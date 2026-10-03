Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CDBCA5FE4
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 02:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A95DA10FA4D;
	Sat,  3 Oct 2026 02:51:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gw54r9L+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB75F10E741
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 02:51:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F3ABC60AAF;
 Sat,  3 Oct 2026 02:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979041F000FF;
 Sat,  3 Oct 2026 02:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790995895;
 bh=j/zIawsb2OChGAf7YJfpUPurOpunvg3DtxEojutrHQs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gw54r9L+K08CCFvCuyfcqvbcdOKrjNk1MI/gCJXOCp5WWSgmc8n3u3Ed1xzEzL0fA
 9TNhSEpJbP/+EQuAhtjVNQFZS8bd8DhJUliNYf74xjUG3AEYt4+ZmwCRBDwbkn/FkK
 gcnk9sQjiOUFsu2wUqdDi6gIUxmIlqlNBgRcDFzRLV8kSg88gSPGSEp1v7scG13agE
 FhCyEJ4NIpJQCPMUUcuTXNOzvhXRp08UzTsCKqyjv3/KyNet9riPwaCwyfcncGYxPs
 Z6w42UriyAJxrCG5ZewRyyLMZ8QMFZQ4FnnyiOOWLtVwFUgdP51NEGXEHHUtRi93G0
 vq3w1VLB5R77Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] accel/qaic: Split oversized BO requests into
 multiple jobs
To: "Carl Vanderlip" <carl.vanderlip@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261003023818.1161666-6-carl.vanderlip@oss.qualcomm.com>
References: <20261003023818.1161666-1-carl.vanderlip@oss.qualcomm.com>
 <20261003023818.1161666-6-carl.vanderlip@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 02:51:35 +0000
Message-Id: <20261003025135.979041F000FF@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/qaic: UAF and double free in create_slice_jobs error path
- [Medium] drm/qaic: sequence number collision breaks DRM scheduler depende=
ncies
- [Medium] drm/qaic: silent failure propagation due to clobbered error code
--

commit 0016fc8438fc80359a88bc33d3c9d6dd42769622
Author: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>

accel/qaic: Split oversized BO requests into multiple jobs

This commit updates the job submission logic to handle oversized buffer
objects by dividing them into multiple jobs that fit within the hardware
FIFO. It modifies job creation and scheduling to accommodate multiple
chained requests for a single slice.

> diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_dat=
a.c
> index 63ca4a489a9a3..7287370e4fab7 100644
> --- a/drivers/accel/qaic/qaic_data.c
> +++ b/drivers/accel/qaic/qaic_data.c
[ ... ]
> @@ -1169,11 +1166,11 @@ static inline void qaic_dbc_put_job(struct dma_br=
idge_chan *dbc, struct qaic_job
>  static int create_slice_jobs(struct drm_file *file_priv, struct bo_slice=
 *slice, bool partial,
>  			     u64 resize, struct list_head *tmp_list)
>  {
> +	unsigned int nents_offset, nents_xfer;
>  	struct dbc_req *reqs =3D slice->reqs;
> -	struct qaic_job *job =3D NULL;
> +	struct qaic_job *job, *job_i;
>  	unsigned int job_count =3D 0;
> -	unsigned int nents_xfer;
> -	u64 last_bytes;
> +	u64 last_bytes, seq_no;
>  	u32 first_n;
> =20
>  	/*
> @@ -1194,16 +1191,32 @@ static int create_slice_jobs(struct drm_file *fil=
e_priv, struct bo_slice *slice,
>  	else
>  		nents_xfer =3D slice->nents;
> =20
> -	job =3D qaic_create_job(file_priv, slice, nents_xfer, 0, tmp_list);
> -	if (IS_ERR(job))
> -		return PTR_ERR(job);
> -	job_count++;
> +	nents_offset =3D 0;
> +	seq_no =3D 0;
> +	job =3D NULL;
> +	while (nents_xfer > nents_offset) {
> +		job =3D qaic_create_job(file_priv, slice, nents_offset, nents_xfer,
> +				      seq_no++, tmp_list);

[Severity: Medium]
When a BO has multiple slices, does this reset the sequence number for every
slice? This appears to create duplicate sequence numbers on the same shared=
 BO
fence context.

Because drm_sched_job_add_dependency() deduplicates fences using
dma_fence_is_later(), the explicit intra-BO job dependencies might be silen=
tly
dropped if the new seq_no is not greater than older sequence numbers on the
same context.

> +		if (IS_ERR(job))
> +			goto free_jobs;
> +
> +		job_count++;
> +		nents_offset +=3D job->num_req;
> +	}
> =20
>  	/* job points to the last job for this slice, only valid for partial ex=
ecute ioctl */
>  	job->partial_size =3D last_bytes;
>  	job->partial =3D partial;
> =20
>  	return job_count;
> +
> +free_jobs:
> +	list_for_each_entry_safe_reverse(job, job_i, tmp_list, queue)
> +		if (job_count--)
> +			qaic_cleanup_job(job);

[Severity: High]
Does this error path leave dangling pointers in tmp_list? By calling
qaic_cleanup_job() without removing the job from tmp_list (e.g., via
list_del()), the freed jobs remain in the list.

If send_bo_list_to_sched() is the caller and this returns an error (or 0),
the error path there iterates over tmp_list again:

drivers/accel/qaic/qaic_data.c:send_bo_list_to_sched() {
    ...
    list_for_each_entry_safe_reverse(job_i, tmp, &tmp_list, queue)
        qaic_cleanup_job(job_i);
    ...
}

Would this result in a double free of the jobs?

[Severity: Medium]
Will this error path clobber the original error code from qaic_create_job()?
The job iterator here shadows the job variable containing the ERR_PTR, and =
the
function returns the post-decremented job_count (which is 0 or -1).

When this propagates up to send_bo_list_to_sched(), it sees a return of 0:

drivers/accel/qaic/qaic_data.c:send_bo_list_to_sched() {
    ...
    ret =3D create_slice_jobs(file_priv, slice, false, 0, &tmp_list);
    if (ret <=3D 0)
        goto unlock_bo;
    ...
    return ret;
}

Could this mask the failure and return 0 (success) to userspace, causing a =
hang
when userspace waits for BO fences that will never be signaled?

> +		else
> +			break;
> +	return job_count;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003023818.1161=
666-1-carl.vanderlip@oss.qualcomm.com?part=3D5
