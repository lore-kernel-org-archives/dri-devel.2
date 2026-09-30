Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC3CC9830E
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 04:00:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49E0C10F173;
	Wed, 30 Sep 2026 04:00:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QSp9ZbmQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9F1A10F173
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 04:00:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B4D3A40E26;
 Wed, 30 Sep 2026 04:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844E81F000FF;
 Wed, 30 Sep 2026 04:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790740824;
 bh=CwHb581fngnQ/udLZo3jcfKHMFH7BkCzuNeqIDqGCsU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QSp9ZbmQ38f0Yp2Ee5n66qMmGqskXjdlJEkQVnlFLjTDqULn13DkpG/kysz6yjOHO
 QH3YPqzkMoU3urNe7A+HfXJyeA3AkwBHzedRCHlSCUNSXw13mKZTMuQx1WHoyjTE4k
 NoWarZAOHbx901HN0DKx1x+dNbz30A6WtJoWShOiMkOVEyZPuH+VnqTKPNDmQIWQ20
 EvORnbJTBq+JQKyahzqOPkzZI86nVAzg672sGbRzKWb1Vj4i4VVl4f7TieoyUq7bQM
 Z6y7n/H0FqKN/FsIVqaerso0O0ikwuV7Q5UjUkIPgSXOTEMoveDAafXIJ+1ImCljAc
 CLM1Qf9DedXgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1 13/20] accel/amdxdna: Prepare for AIE4 command
 submission
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260930033233.1727265-14-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
 <20260930033233.1727265-14-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 04:00:24 +0000
Message-Id: <20260930040024.844E81F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Race in get_read_index() allows last_read_index to regress
--

commit b18a81613bb4ba1a66541441dd19a7be5abf5cef
Author: David Zhang <yidong.zhang@amd.com>

accel/amdxdna: Prepare for AIE4 command submission

This commit prepares the data structures and completion wait helpers requir=
ed
for AIE4 command submission. It defines struct amdxdna_cmd_start_dpu, exten=
ds
union amdxdna_job_priv, and updates completion wait helpers to handle read
tearing and asynchronous device disconnects.

> diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie=
4_ctx.c
> index 3927c9fef05f9..59d37bd5c5a08 100644
> --- a/drivers/accel/amdxdna/aie4_ctx.c
> +++ b/drivers/accel/amdxdna/aie4_ctx.c

[ ... ]

> @@ -423,34 +423,92 @@ static inline bool valid_queue_index(u64 read, u64 =
write, u32 capacity)
> =20
>  static u64 get_read_index(struct amdxdna_hwctx *hwctx)
>  {

[ ... ]

>  	if (!valid_queue_index(ri, wi, CTX_MAX_CMDS)) {
> -		XDNA_WARN(xdna, "Invalid index, ri %llu, wi %llu", ri, wi);
> -		usleep_range(100, 200);
> -		ri =3D READ_ONCE(*hwctx->priv->umq_read_index);
> +		ri =3D READ_ONCE(*priv->umq_read_index);
> +		/* Order the read_index sample before the write_index sample. */
> +		smp_rmb();
> +		wi =3D READ_ONCE(priv->write_index);
>  		if (!valid_queue_index(ri, wi, CTX_MAX_CMDS)) {
> -			XDNA_ERR(xdna, "Invalid index after retry, ri %llu, wi %llu", ri, wi);
> -			ri =3D 0;
> +			/*
> +			 * Still invalid (torn 64-bit read, or a transient
> +			 * accounting skew). Return the last valid read_index
> +			 * instead of 0: read_index only advances, so the cached
> +			 * value is a safe lower bound -- it never reports a
> +			 * command complete that isn't, and never regresses the
> +			 * worker into falsely timing out a finished job.
> +			 */
> +			XDNA_DBG(xdna, "Invalid index, ri %llu, wi %llu", ri, wi);
> +			return READ_ONCE(priv->last_read_index);
>  		}
>  	}
> =20
> +	WRITE_ONCE(priv->last_read_index, ri);

[Severity: High]
Can this lockless blind write allow an older read index to overwrite a newer
one when executed concurrently by multiple waiters?

If Thread A reads `ri =3D 10` from hardware and Thread B reads `ri =3D 12`,=
 Thread B
could execute `WRITE_ONCE(priv->last_read_index, 12)` before Thread A execu=
tes
`WRITE_ONCE(priv->last_read_index, 10)`, causing last_read_index to regress.

This breaks the monotonicity required to safely prevent false timeouts.

>  	return ri;
>  }

[ ... ]

> @@ -466,11 +524,14 @@ int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 =
seq, u32 timeout)
>  		wait_jifs =3D msecs_to_jiffies(timeout);
> =20
>  	ret =3D wait_event_interruptible_timeout(cert_comp->waitq,
> -					       (check_cmd_done(hwctx, seq)),
> +					       check_cmd_done(hwctx, seq, cert_comp),
>  					       wait_jifs);
> =20
>  	if (!ret)
>  		ret =3D -ETIME;
> +	else if (ret > 0 && get_read_index(hwctx) <=3D seq)
> +		/* Woke on disconnect/reset, not on real completion. */
> +		ret =3D -EAGAIN;

[Severity: High]
Could this disconnect-detection logic incorrectly trigger when get_read_ind=
ex()
returns the corrupted, backward-jumped last_read_index during a torn read?

If last_read_index regresses due to the race condition above, a subsequent =
call
to get_read_index() experiencing a torn read would fall back to this stale
value.=20

This check would then falsely evaluate to true, causing successfully comple=
ted
jobs to falsely return -EAGAIN to userspace.

> =20
>  	aie4_put_cert_comp(cert_comp);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930033233.1727=
265-1-yidong.zhang@amd.com?part=3D13
