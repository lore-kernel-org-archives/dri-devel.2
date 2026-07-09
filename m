Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A49C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:46:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 742F910F3A1;
	Thu,  9 Jul 2026 06:46:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="muROlo0s";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB31D10F3A1
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:46:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E684D601D9;
 Thu,  9 Jul 2026 06:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0FB1F000E9;
 Thu,  9 Jul 2026 06:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783579559;
 bh=6Uaawh6W4DFhoAsKRfgfHGRtGoY2Gl3ExGc1z30dL2I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=muROlo0sojBd2AmyaQjxab+4f2CKU9yYFbxcdrCYISYbUSjKTPOXIg+DCq3ezvuP/
 mWVjQGiOJ675fIFKaMHnpFJWolZFLj+1m7SKuMAAkR3foMXfaBnk/EIEi8r9YmCR77
 Ymbp5pWunEl8DSGqu0nc++eCCwP0vqoruQbvTlnlIa72RXDl62JdWWh2E8ivKXcfmo
 8hB6KwS/2PM9xR5EiWcokI3EdLCiylnjlrPr+043zlhOmU/kKAQPWXCH06DdH7ze3k
 boVK7fKDe5lESG7s0sjOvwPWqgc8A+lxeTZIcct2kA+yS8R0Mz20RSyXP2Qb6hqfKf
 XY2lO9Ezr12NA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/amdxdna: Clear mailbox channel after create failure
To: "Ruoyu Wang" <ruoyuw560@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709062256.4166833-1-ruoyuw560@gmail.com>
References: <20260709062256.4166833-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 06:45:59 +0000
Message-Id: <20260709064559.7D0FB1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Stale fw_ctx_id is left intact on aie2_create_context error paths,=
 leaking context state.
- [High] Missing mmput() on retry and success paths in aie2_populate_range(=
) causes mm_struct reference leak.
- [High] Concurrent access to mailbox ringbuffer from ioctl and DRM schedul=
er thread.
--

--- Patch [1]: [PATCH] accel/amdxdna: Clear mailbox channel after create fa=
ilure ---
commit c7aab37bf2d56874aaf94d232e6a55a7ab8e19c2
Author: Ruoyu Wang <ruoyuw560@gmail.com>

accel/amdxdna: Clear mailbox channel after create failure

This commit clears the mailbox channel pointer in the error path of
aie2_create_context() after freeing it. This prevents later context
cleanup routines from operating on stale memory if the creation fails.

> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna=
/aie2_message.c
> index c4b364801cc04..a22d025794598 100644
> --- a/drivers/accel/amdxdna/aie2_message.c
> +++ b/drivers/accel/amdxdna/aie2_message.c
> @@ -277,6 +277,7 @@ int aie2_create_context(struct amdxdna_dev_hdl *ndev,=
 struct amdxdna_hwctx *hwct
> =20
>  free_channel:
>  	xdna_mailbox_free_channel(hwctx->priv->mbox_chann);
> +	hwctx->priv->mbox_chann =3D NULL;
>  del_ctx_req:
>  	aie2_destroy_context_req(ndev, hwctx->fw_ctx_id);

[Severity: High]
This isn't a bug introduced by this patch, but should we also invalidate=20
hwctx->fw_ctx_id here?

If a job timeout triggers a context restart via aie2_hwctx_restart() and
aie2_create_context() fails during mailbox start, the allocated context ID
is freed in firmware but left in hwctx->fw_ctx_id. Could a user then query
DRM_AMDXDNA_HW_CONTEXT_ALL and leak the health report (PC, exception info)
of another process if the firmware reassigned this ID?

>  	return ret;
>  }

[Severity: High]
This is a pre-existing issue outside the immediate diff, but I noticed a
potential resource leak in drivers/accel/amdxdna/aie2_ctx.c.

When populating a range, mmget_not_zero(mm) takes a reference. If the=20
retry path is taken:

drivers/accel/amdxdna/aie2_ctx.c:aie2_populate_range() {
        ...
        if (ret =3D=3D -EBUSY) {
                amdxdna_umap_put(mapp);
                goto again;
        }
        ...
}

Or if the success path is taken:

drivers/accel/amdxdna/aie2_ctx.c:aie2_populate_range() {
        ...
        mapp->invalid =3D false;
        up_write(&xdna->notifier_lock);
        amdxdna_umap_put(mapp);
        goto again;
        ...
}

Does jumping to again bypass mmput(mm) and leak the mm_struct reference?

[Severity: High]
This is another pre-existing issue, but I have a question about concurrent
mailbox access.

If a user submits a job starting the DRM scheduler thread (aie2_sched_job_r=
un
calling aie2_execbuf), and concurrently calls the DRM_AMDXDNA_CONFIG_HWCTX
ioctl:

drivers/accel/amdxdna/aie2_ctx.c:aie2_hwctx_cu_config() {
        ...
        ret =3D aie2_config_cu(hwctx, aie2_config_cu_resp_handler);
        ...
}

Could both threads invoke xdna_mailbox_send_msg() on the same mbox_chann
simultaneously?

drivers/accel/amdxdna/amdxdna_mailbox.c:mailbox_send_msg() {
        ...
        head =3D mailbox_get_headptr(mb_chann, CHAN_RES_X2I);
        tail =3D mb_chann->x2i_tail;
        ...
}

Since mailbox_send_msg() performs an unlocked read-modify-write on the=20
ringbuffer tail pointer and memory, can this race corrupt the hardware=20
mailbox ring buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709062256.4166=
833-1-ruoyuw560@gmail.com?part=3D1
