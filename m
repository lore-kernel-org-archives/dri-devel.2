Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB02FC5CFC1
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 20:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3686310E485;
	Sat, 15 Aug 2026 20:11:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ibTyF3tB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4020710E485
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 20:11:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B9EAC43D52;
 Sat, 15 Aug 2026 20:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDDF1F000E9;
 Sat, 15 Aug 2026 20:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786824690;
 bh=+SlKUex6kmzAkO9SdmYskwRG7H1dVBHo2PV44ytZwz8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ibTyF3tBikMQEmEzxGT9R2/KphnovaFzrLCK+EyNnKbrhpFvMTQ8kRYmaz2KmPtNS
 KQS3xXonL6Jmq33vuo7k0NpYom5eq4Q4/l40hVCwG2BhFcM2p8ouRnjqz7zuyj/wRl
 kLybwyqZsvdz/SoRU6Jvn3O/cqj8V83BrfjRJQyLN5/ql5AW9Aj7b1liUT/huItA2r
 S7lzOVBmFQi+Bxahg8zZGjBycidNAZzC32mn3QmxyW0fR7JmWOH20l5JWDHT6JG0qt
 QShJkcALeD3WtKqByUC+1effxU7U+Lo+3W725LGTYyzD05VjEWiV0WIxD7+zzSSXR1
 nMhF8Em5be0TA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/nouveau: cancel the DP IRQ work before freeing
 the connector
To: "Marek Czernohous" <mczernohous@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <178682366002.3748010.4096452389040554615@gmail.com>
References: <178682366001.3748010.7798811159846779765@gmail.com>
 <178682366002.3748010.4096452389040554615@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 20:11:30 +0000
Message-Id: <20260815201130.7BDDF1F000E9@smtp.kernel.org>
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
- [High] Use-After-Free / Memory Leak in nouveau_connector_create() on LVDS=
 initialization error path.
- [High] NULL pointer dereference in nouveau_dp_irq() when initializing the=
 drm variable.
- [High] Use-After-Free on the drm object due to late irq_work cancellation.
--

--- Patch [2]: [PATCH 2/3] drm/nouveau: cancel the DP IRQ work before freei=
ng the connector ---
commit f68e09b38970f3b87ae7ed5977b718c0b00485df
Author: Marek Czernohous <marek@czernohous.de>

drm/nouveau: cancel the DP IRQ work before freeing the connector

This patch adds a cancel_work_sync() call to nouveau_connector_destroy()
to ensure the DP IRQ work is cancelled before the connector is freed. This
prevents a use-after-free where the irq_work remains on the system queue
past the kfree().

Link: https://sashiko.dev/#/patchset/20260812231330.705425-1-mczernohous@gm=
ail.com?part=3D1

> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/dr=
m/nouveau/nouveau_connector.c
> index b0b0ad9a0c248..e49dcaa6d210b 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -397,6 +397,7 @@ nouveau_connector_destroy(struct drm_connector *conne=
ctor)
>  	struct nouveau_connector *nv_connector =3D nouveau_connector(connector);
>  	nvif_event_dtor(&nv_connector->irq);
>  	nvif_event_dtor(&nv_connector->hpd);
> +	cancel_work_sync(&nv_connector->irq_work);

[Severity: High]
This isn't a bug introduced by this patch, but does cancelling the work here
leave a race condition that causes a use-after-free on the drm object?

During driver teardown, nouveau_display_fini() cancels drm->hpd_work. Later,
drm_mode_config_cleanup() calls nouveau_connector_destroy(), which now waits
on nv_connector->irq_work here.

If irq_work is actively running on a worker thread when this executes,
cancel_work_sync() will block. While finishing, nouveau_dp_irq() calls
nouveau_connector_hpd(), which unconditionally schedules drm->hpd_work:

nouveau_dp_irq() {
    ...
    nouveau_connector_hpd(nv_connector, NVIF_CONN_EVENT_V0_IRQ | hpd);
}

Since drm->hpd_work was already cancelled and is never cancelled again, it =
is
placed back on the system workqueue. After teardown completes and the drm
object is freed in nouveau_drm_device_remove(), the workqueue could execute
nouveau_display_hpd_work(), dereferencing the freed pointer. Should this
cancellation happen earlier, such as in nouveau_display_fini()?

[Severity: High]
This is a pre-existing issue, but looking at nouveau_connector_create() in
nouveau_connector.c, does the LVDS initialization error path leak the
connector and cause a use-after-free?

nouveau_connector_create() {
    ...
    drm_connector_init(dev, &nv_connector->base, funcs, type);
    ...
    if (type =3D=3D DRM_MODE_CONNECTOR_LVDS) {
        ...
        ret =3D nouveau_bios_parse_lvds_table(dev, 0, &dummy, &dummy);
        if (ret) {
            NV_ERROR(drm, "Error parsing LVDS table, disabling\n");
            kfree(nv_connector);
            return ERR_PTR(ret);
        }
    ...
}

drm_connector_init() adds the connector to dev->mode_config.connector_list =
and
allocates an IDA. If the LVDS table parsing fails, the error path frees
nv_connector with kfree() but doesn't call drm_connector_cleanup(). Does th=
is
leave a dangling pointer in the global connector list that will crash when
traversed, and leak the allocated IDA?

[Severity: High]
This is a pre-existing issue, but looking at nouveau_dp_irq() in
nouveau_dp.c, can we encounter a NULL pointer dereference here?

nouveau_dp_irq() {
    ...
    struct nouveau_encoder *outp =3D find_encoder(connector, DCB_OUTPUT_DP);
    struct nouveau_drm *drm =3D nouveau_drm(outp->base.base.dev);
    ...
    if (!outp)
        return;
    ...
}

find_encoder() can return NULL if a valid DisplayPort encoder isn't found,
which the code anticipates. However, outp is immediately dereferenced during
variable initialization to fetch the dev pointer for nouveau_drm() before t=
he
null check executes. Can this cause a kernel oops if outp is NULL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178682366001.374801=
0.7798811159846779765@gmail.com?part=3D2
