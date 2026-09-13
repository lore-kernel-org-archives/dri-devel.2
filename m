Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE9FC88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 21:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C20E410E51B;
	Sun, 13 Sep 2026 21:52:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Mi3yTCo2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9981810E51B
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:52:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3DA434015E;
 Sun, 13 Sep 2026 21:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005ED1F000FF;
 Sun, 13 Sep 2026 21:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789336346;
 bh=0MY2iXd/w+p5epQgwoKi+mYbZ+xF2LDaR7QnfZQ2Hdw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Mi3yTCo2OyaWzGijMTY5XDdU9lxL0m7zp4i2H5r8eYhE+fXko47JuNA+JBmCVkCsn
 OhCmN/NS8oXJPBpAZbyb7uOZpsRJjscFJUjo30VRYi4Ztio5lcSMoMn62GsScMy/1+
 IWvtrWYVuac59/zsCeaTtYRBYcfkQOwmv9A6tWFAzCwN0HP1szv41jw635eSosynjs
 KX5QzxVnnHN591DRo940yvQ6YY5EyTGvLk4W/6stygFCyWiOlxmJZ72694/HSyLBwQ
 sVr0nKQkdtm6/IrYvdmk1dfky1gvhLZHEVxhWuJQGQ6ciww17QJpwdL6kQhQqAr2mn
 95xJRCoxRAbIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] accel/amdxdna: clear the mailbox channel pointer
 when starting it fails
To: "Eva Crystal" <0xiviel@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <2fcf0eca215090dbbd95cb86e1bf5076056d3818.1789334558.git.0xiviel@gmail.com>
References: <cover.1789334558.git.0xiviel@gmail.com>
 <2fcf0eca215090dbbd95cb86e1bf5076056d3818.1789334558.git.0xiviel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 21:52:25 +0000
Message-Id: <20260913215226.005ED1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Medium] aie2_create_context() fails to reset hwctx->fw_ctx_id to an inva=
lid state on error paths, causing telemetry corruption.

Pre-existing issues:
- [High] Premature DRM scheduler restart in aie2_hwctx_stop() leads to data=
 races, uninitialized memory access, and Use-After-Free of mbox_chann.
- [High] Jobs are silently marked as successfully completed when the hardwa=
re context is dead, rather than returning an error.
- [High] Mailbox channel memory and firmware context are permanently leaked=
 when set_dpm_level() fails during hardware context allocation.
- [Medium] aie2_fill_hwctx_map() breaks telemetry queries for all clients i=
f any hardware context is stopped or unconfigured.
- [Low] The mapped IRQ number is overwritten by the return value of xdna_ma=
ilbox_start_channel() before it is logged.
--

commit a549f036c2506b6146292b236477aa4ed260a99e
Author: Eva Crystal <0xiviel@gmail.com>

accel/amdxdna: clear the mailbox channel pointer when starting it fails

aie2_create_context() allocates a mailbox channel, starts it, and on a
failed start frees it again, leaving a stale pointer in hwctx->priv->mbox_c=
hann.
This patch sets hwctx->priv->mbox_chann to NULL after freeing it to avoid
use-after-free and double-free issues during context teardown.

>       - a second command timeout reaches aie2_hwctx_stop() ->
>         aie2_destroy_context(),

[Severity: Medium]
This is a pre-existing issue, but when a context is stopped via
aie2_destroy_context(), hwctx->fw_ctx_id is set to -1
(AMDXDNA_INVALID_CTX_HANDLE).

If aie2_get_telemetry() is subsequently called, aie2_fill_hwctx_map() check=
s:

drivers/accel/amdxdna/aie2_pci.c:aie2_fill_hwctx_map() {
    if (hwctx->fw_ctx_id >=3D xdna->dev_handle->priv->hwctx_limit) {
        XDNA_ERR(xdna, "Invalid fw ctx id %d/%d ", hwctx->fw_ctx_id,
        ...
        return -EINVAL;
    }
    ...
}

Since fw_ctx_id is a u32, -1 evaluates to 0xFFFFFFFF, which is strictly gre=
ater
than hwctx_limit. Does this error bubble up and completely abort the teleme=
try
query for all clients just because one context is in a valid stopped state?

>       - the next job submitted reaches xdna_mailbox_send_msg() on the fre=
ed
>         channel, via the !mbox_chann guard in aie2_sched_job_run(),

[Severity: High]
This is a pre-existing issue, but does aie2_sched_job_run() silently drop j=
obs?

drivers/accel/amdxdna/aie2_ctx.c:aie2_sched_job_run() {
    ...
    if (!hwctx->priv->mbox_chann)
        return NULL;
    ...
}

Under DRM scheduler semantics, returning a NULL fence indicates the job
completed synchronously and successfully. Does this cause the scheduler to
signal the finished fence without error, leading user-space applications to
process uninitialized output buffers as valid data instead of receiving an
error pointer like ERR_PTR(-ENODEV)?

> The create path itself is not affected: when aie2_xrs_load() fails,
> xrs_allocate_resource() removes the solver node without calling
> ->unload, and aie2_hwctx_init() frees hwctx->priv, so the stale pointer
> never outlives the structure holding it.

[Severity: High]
This is a pre-existing issue, but does xrs_allocate_resource() leak mailbox
channel memory and the firmware context if set_dpm_level() fails?

drivers/accel/amdxdna/aie2_solver.c:xrs_allocate_resource() {
    ...
    ret =3D xrs->cfg.actions->load(cb_arg, &load_act);
    if (ret)
        goto free_node;

    ret =3D set_dpm_level(xrs, req, &dpm_level);
    if (ret)
        goto free_node;
    ...
free_node:
    remove_solver_node(&xrs->rgp, snode);
    return ret;
}

Because the free_node error path skips calling xrs->cfg.actions->unload(),
are resources successfully allocated by load() permanently leaked when
set_dpm_level() fails?

> Starting a channel can fail today without this patch: the ring buffer
> sizes firmware reports are rejected unless both are powers of two, and
> request_irq() can fail.

[Severity: Low]
This is a pre-existing issue, but does aie2_create_context() overwrite the
mapped IRQ number before logging it?

drivers/accel/amdxdna/aie2_message.c:aie2_create_context() {
    ...
    ret =3D pci_irq_vector(to_pci_dev(xdna->ddev.dev), resp.msix_id);
    ...
    ret =3D xdna_mailbox_start_channel(hwctx->priv->mbox_chann, &x2i, &i2x,
                     intr_reg, ret);
    ...
    XDNA_DBG(xdna, "Mailbox channel irq: %d, msix_id: %d", ret, resp.msix_i=
d);
    ...
}

Since xdna_mailbox_start_channel() returns 0 on success into ret, will this
incorrectly always log 0 for the IRQ number instead of the actual assigned =
IRQ?

diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/a=
ie2_message.c
index b4c49259a1a23..f658760c3d480 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -277,6 +277,7 @@ int aie2_create_context(struct amdxdna_dev_hdl *ndev, s=
truct amdxdna_hwctx *hwct
=20
 free_channel:
 	xdna_mailbox_free_channel(hwctx->priv->mbox_chann);

[Severity: High]
This is a pre-existing issue, but does aie2_hwctx_stop() unpark the DRM
scheduler thread before aie2_hwctx_restart() completely recreates the conte=
xt?

drivers/accel/amdxdna/aie2_ctx.c:aie2_hwctx_stop() {
    drm_sched_stop(&hwctx->priv->sched, bad_job);
    aie2_destroy_context(xdna->dev_handle, hwctx);
    drm_sched_start(&hwctx->priv->sched, 0);
}

If the scheduler restarts prematurely, it can execute queued jobs and call
aie2_sched_job_run(), which locklessly accesses hwctx->priv->mbox_chann.

If this runs concurrently with the error path here in aie2_create_context(),
could aie2_sched_job_run() load the pointer just before it is freed and set
to NULL, resulting in a use-after-free?

+	hwctx->priv->mbox_chann =3D NULL;
 del_ctx_req:
 	aie2_destroy_context_req(ndev, hwctx->fw_ctx_id);
 	return ret;

[Severity: Medium]
Does zeroing hwctx->priv->mbox_chann here inadvertently skip resetting
hwctx->fw_ctx_id during subsequent teardown?

Because aie2_destroy_context() checks if the channel pointer is NULL and
early-returns 0, it will completely skip resetting hwctx->fw_ctx_id to an
invalid state (e.g., AMDXDNA_INVALID_CTX_HANDLE).

If the firmware later reuses this ID for a new context, will
aie2_fill_hwctx_map() map multiple host contexts to the same firmware conte=
xt
ID, leading to incorrect telemetry attribution?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789334558.gi=
t.0xiviel@gmail.com?part=3D1
