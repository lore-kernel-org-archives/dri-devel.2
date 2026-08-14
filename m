Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D00C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AE1210F33A;
	Fri, 14 Aug 2026 07:19:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JRczrUNK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5386F10F33A
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 07:19:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 24CBA40286;
 Fri, 14 Aug 2026 07:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1E41F000E9;
 Fri, 14 Aug 2026 07:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786691978;
 bh=Q+fyVvhjJP20EDzEa4k4KNhrLp2VjSVDUoDjTyr41yw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JRczrUNKPmw63fxR65RjZJYOBbOnj9pvKNCLVhPND8Me/QESZ+AT0kn4JojLMLpdb
 uBa1pxGfzTYFR88sJ9FLwxkIWjHbFYRucJ7gcBXQvdZ1Vd6kGy/ppy1WRiOdxl0ArP
 qsWQCCzeSznE1GjId1FIKQGtfd/O+7aHTGVZTAe7b0XG40CeorjiGateu30yJSVs9r
 uO4Qo6C5lTVw2ZJA5fKLrl0yXu6Qta43Iop6ShpCcjC6uHttj2ffo6wiQeqOKkQATZ
 fvN6kvprpn/mpbRjfUfQeTdrgh1WzxUoDbqlTfTV7Gwi2zB7JDx6Kd0tCm5va1wfNO
 uNhg5aS+VfBzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm: logicvc: fix device_node refcount leak in
 logicvc_layers_init()
To: "Manush Prajwal" <manushprajwal555@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813111037.724-1-manushprajwal555@gmail.com>
References: <20260813111037.724-1-manushprajwal555@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 07:19:37 +0000
Message-Id: <20260814071937.DF1E41F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] DRM mode objects allocated with devm_kzalloc are freed before drmm=
_mode_config_cleanup() executes, causing a use-after-free during teardown.
--

--- Patch [1]: [PATCH] drm: logicvc: fix device_node refcount leak in logic=
vc_layers_init() ---
commit 287cb4b6b0c0c79eff11b1f6730b1461931e959d
Author: Manush Prajwal <manushprajwal555@gmail.com>

drm: logicvc: fix device_node refcount leak in logicvc_layers_init()

On logicvc_layer_init() failure, logicvc_layers_init() releases the
parent layers_node reference before jumping to the error path, but
never releases layer_node, the child node held by the current
for_each_child_of_node() iteration. Add the missing of_node_put()
for layer_node alongside the existing one for layers_node.

> diff --git a/drivers/gpu/drm/logicvc/logicvc_layer.c b/drivers/gpu/drm/lo=
gicvc/logicvc_layer.c
> index 7f5ba000188ab..e83a2aafed779 100644
> --- a/drivers/gpu/drm/logicvc/logicvc_layer.c
> +++ b/drivers/gpu/drm/logicvc/logicvc_layer.c
> @@ -613,6 +613,7 @@ int logicvc_layers_init(struct logicvc_drm *logicvc)
> =20
>  		ret =3D logicvc_layer_init(logicvc, layer_node, index);
>  		if (ret) {
> +			of_node_put(layer_node);
>  			of_node_put(layers_node);
>  			goto error;

[Severity: High]
This isn't a bug introduced by this patch, but does taking this error path
lead to a use-after-free during driver teardown?

When we jump out of the loop to the error label in logicvc_layers_init(),
logicvc_layer_fini() is called, which frees the layer memory using
devm_kfree().

However, in drivers/gpu/drm/logicvc/logicvc_layer.c, logicvc_layer_init()
allocates the layer with devm_kzalloc() and then registers an unmanaged
drm_plane using drm_universal_plane_init():

	layer =3D devm_kzalloc(dev, sizeof(*layer), GFP_KERNEL);
	...
	ret =3D drm_universal_plane_init(drm_dev, &layer->drm_plane, 0,
				       &logicvc_plane_funcs, formats->formats,
				       formats_count, NULL, type, NULL);

Because the plane is not unregistered before devm_kfree() is called, does t=
his
leave a dangling plane pointer in the DRM core list?

Additionally, when devres unwinds during a probe failure or driver unbind,
won't it release the devm_kzalloc() memory before the drmm teardown action
calls drm_mode_config_cleanup() (since drmm_mode_config_init() was used in
logicvc_drm.c:logicvc_drm_probe())?

If so, drm_mode_config_cleanup() would iterate over the freed plane and call
its ->funcs->destroy callback, triggering a use-after-free.

A similar devm_kzalloc() and unmanaged DRM object lifecycle mismatch appears
to exist for logicvc_crtc_init() in drivers/gpu/drm/logicvc/logicvc_crtc.c
and logicvc_interface_init() in drivers/gpu/drm/logicvc/logicvc_interface.c.

>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813111037.724-=
1-manushprajwal555@gmail.com?part=3D1
