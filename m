Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48D6CA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:09:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 266A210E01F;
	Tue,  6 Oct 2026 08:09:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CcBKp/HM";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4673210E01F
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 08:09:44 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2dd1dcdcf95so3079445ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 01:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791274184; x=1791878984; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JlNumo0XDQS2lJkteQBjfN8Fb96oMehV3mMd0MRgQKQ=;
 b=CcBKp/HM/y31uZhY6ZVvHxhMYMdCJmCOQAz6Yb55d/Wwq8wCP5yvULu+uxaODxp2kO
 qOWS7/8ry7sGyI1c7p6U7eHFzvIyMm/veyLXsRFah7P5z17HIvhu3LwC751Uk9J46k8c
 KbMGry4q70zebYF/Jn/Yef37DInzsQLEd5i03oAvpmGSkKUVVgcXT5jWp0c9fqib8/VC
 PCl0v6b1fLN8ICG6GJK2uW20e4I7VzJKthWlHJPvjEkMeDAAfiC5k+O4yznhR88TzgNo
 TZvC5mFz6DAY2U/Z6UWO5pssKsnPxgSZLSJJ/JIfto33eUrG0SLxo9GwvclFoaKi8FjA
 b2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791274184; x=1791878984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JlNumo0XDQS2lJkteQBjfN8Fb96oMehV3mMd0MRgQKQ=;
 b=f8VOZ1Ngx5iBmGkKS5gtY0ZV8CekLSIK7z23bcwvzO2dMtKZcC5SVioVaYt5E7bfI3
 Op00jNAqawK9ZUCgoQCuzpUlWHrEDCA+CQnk8SGINJjIlsTY6zwvN1LeZdlStFIl1bRH
 6YEoR4H42op6Mi2gZhE5f1QuiU4K/ljKl9P3lpPGa1zNzChPUUtbyrrVdKjV5gihDN4i
 GI3Pd9gLQZBFsnBkP141lzlqmB2XgDuImyu1fWrOXcbQpKviHlCZiAF6F3+hl2yv+OVD
 FXgpxtLQPXR2d6RYKrT00plj6sW9D/pA7UowO+dHAMM+e69l3JUaaxUqAuNUVKYGb2hf
 isyA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFf9HYRmC75ihG6h2oDjpCLYgAOcPJ4ey2GpfhyIg7xDJ3J67KZjt8R9C7I/wKdw+jjVqW4Zv0FpU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIJ4heq8bvTELWT/2xmfOptIeEjTGV3MawdcsbvfRGTws+FY7hA
 a1npVqg5oPm3HN6Q2KGAZNSyoqvIEXkTVC6mMlgld/dTGRjfn1fYnLFK
X-Gm-Gg: AYBFou3tDKIvi1GCnPuAFeFxdRi+2wXNrYI0/L4m/08f00r8u0GxkZHqu6daFLToCMz
 FEXeq8TModIL74e/y/mwRa5hCgoralaaDb4uaVmECp8jZ2AoA6l97NhIlVPMR8k92Cv9bxdHqgn
 ZAV3hUx/741hAZFOQfKpYIlukwq07rlOpvEbG0yUU6uyl714EYtf3lYobvcuV5viEd99cuOmUce
 FxHuvixMn+34+vGAfeki/L54JO9tWeZYrevtV/UqiN33N3vo8wK3m/jiAzHvWXd3Lt49Pb2hwf/
 R3IfWnMePXNaZl32JMbltBzVmgNbHu9wPCYoTyGeImW0o4SFCrRRaLzUTcIdy0xDCeugRjRmkqL
 MayFc1jrKWZKGxUOmp1LpSWl7nx2uYAJOtbq2daoite1hqc/Di5BNlqPZAFZ0S01HDV9sB09YF8
 aHO+x+JWkkG4/4Vx4V9064bzIB1kKKYs+tx79CnPULMI20sdClhfHrqGQIwu3XcuzbMIk7/yD3R
 9bDENy3QWgabwEXyRw7/xcYO6qPm7WcTT4gfH0x7VMEx475qIhesIFpC9scej0j/14W9sKRTSxf
 CHloMoa9MRuvDd2nHucOBovZERs3dyK2g/u5HjJlcxmAH6FmElIu+az4Hg==
X-Received: by 2002:a17:903:19e6:b0:2e5:dc5a:c795 with SMTP id
 d9443c01a7336-2e5dc5aca22mr5127565ad.36.1791274183691; 
 Tue, 06 Oct 2026 01:09:43 -0700 (PDT)
Received: from 0xiviel.ip (122-63-128-121.mobile.spark.co.nz. [122.63.128.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e5a5ef4dbasm18597775ad.71.2026.10.06.01.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:09:43 -0700 (PDT)
From: Eva Crystal <0xiviel@gmail.com>
To: yidong.zhang@amd.com, quic_jhugo@quicinc.com,
 karol.wachowski@linux.intel.com, max.zhen@amd.com, lizhi.hou@amd.com,
 ogabbay@kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: sonal.santan@amd.com,
	mario.limonciello@amd.com,
	wendy.liang@amd.com
Subject: Re: [PATCH V2 14/20] accel/amdxdna: Implement AIE4 command packet
 building and submission
Date: Tue,  6 Oct 2026 20:12:45 +1300
Message-ID: <20261006071245.197376-1-0xiviel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006042230.547807-15-yidong.zhang@amd.com>
References: <20261006042230.547807-15-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, Oct 05, 2026 at 09:22:24PM -0700, David Zhang wrote:

> +/* Job timeout detection (TDR) will guarantee the fence signalling */
> +static void job_worker(struct work_struct *work)
> +{
> +	struct amdxdna_hwctx_priv *priv =
> +		container_of(work, struct amdxdna_hwctx_priv, job_work);
> +	struct amdxdna_hwctx *hwctx = priv->hwctx;
> +	struct amdxdna_sched_job *job;
> +
> +	while ((job = peek_running_job(hwctx))) {
> +		wait_till_seq_completed(hwctx, job->seq);
> +		if (get_read_index(hwctx) > job->seq) {
> +			dequeue_running_job(hwctx, job);
> +			/* Abort partially submitted jobs; complete fully submitted ones. */
> +			if (job->aie4_job_state != AIE4_JOB_STATE_SUBMITTED)
> +				job_abort(job);
> +			else
> +				job_complete(job);

> +static void job_done(struct amdxdna_sched_job *job)
> +{
> +	job->aie4_job_state = AIE4_JOB_STATE_DONE;
> +	dma_fence_signal(job->fence);
> +	/* Release submitter mm reference taken at submit. */
> +	mmput_async(job->mm);
> +	kref_put(&job->refcnt, aie4_job_release);
> +}

The get_read_index(hwctx) > job->seq test here reads a value userspace can write, and this patch is the first to let it release resources rather than just end a wait.

priv->umq_read_index = &qhdr->read_index is already in drm-misc-next (drivers/accel/amdxdna/aie4_ctx.c:212 at 34e9ab018249), but there its only consumer was check_cmd_done() from aie4_cmd_wait() and aie4_vf_ops had no .cmd_submit, so forging it only ended your own wait early. Here it decides dma_fence_signal(), mmput_async() and the BO reference drops in aie4_job_release().

The queue is userspace's own BO: hwctx->umq_bo_hdl is args->umq_bo from CREATE_HWCTX (drivers/accel/amdxdna/amdxdna_ctx.c:252) and is mmappable read-write (drivers/accel/amdxdna/amdxdna_gem.c:1409), so the submitter shares the pages the driver vmaps. valid_queue_index() bounds it only against the kernel copy priv->write_index, so any value in [write_index - 32, write_index] passes and one store retires every outstanding job. Nothing else is consulted: cert_comp_isr() (drivers/accel/amdxdna/aie4_pci.c:114) only calls wake_up_all(), and aie4 has no per-job mailbox handler.

I may be overstating the impact. I found no kernel memory corruption: no driver allocation's free is gated on a job fence, and the queue BO reference drops in aie4_hwctx_fini(), after hwctx_stop() has done the synchronous aie4_msg_destroy_context(). User pages look covered, since SVA is the default and the core invalidates device TLBs on every mm invalidation (drivers/iommu/iommu-sva.c:341). What is left is cross-process integrity: job->out_fence sits in every argument BO's reservation as DMA_RESV_USAGE_WRITE and those export as dma-buf (drivers/accel/amdxdna/amdxdna_gem.c:680), so an importer is told the NPU is done when it is not. I cannot tell from source whether CERT keeps executing packets it already fetched once the host moves read_index past them; if it stops, this is self inflicted only. You have the hardware.

Would a driver owned completion word work, device mapped but not user mapped? Or could CERT report the count in a register or mailbox message the ISR reads?

Separately: abo->mem.map_invalid is set in the MMU notifier (drivers/accel/amdxdna/amdxdna_gem.c:247) and at mmap time for imported BOs (drivers/accel/amdxdna/amdxdna_gem.c:505), but cleared only in aie2_populate_range() (drivers/accel/amdxdna/aie2_ctx.c:1145), static and called only from aie2_cmd_submit(). On aie4 it is never cleared, so aie4_cmd_submit() returns -EINVAL for that BO's remaining life. An imported dma-buf argument BO that userspace mmapped starts with the flag set and can never be submitted.

Eva Crystal (0xiviel)
XSource Security
https://xsourcesec.com
