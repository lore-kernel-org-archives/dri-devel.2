Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DF2CDB47C
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 02:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B49410E141;
	Thu, 25 Jun 2026 02:44:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NVRGLeMm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4630310E141
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 02:44:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2F80760018;
 Thu, 25 Jun 2026 02:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970D41F000E9;
 Thu, 25 Jun 2026 02:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782355447;
 bh=3Ed2BxiIMhPYhguUas11kdQuuX+949t4PYJnWbso7fE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NVRGLeMmLalGytwhg5adDBNe+7jCzIwUs9rKVghYKGYPCDlpfU6vAGFJiZCvnXwvl
 /GKBo62am4QeQ+9VAmTPkJ80Ej3m/3LWw1dekF2pZaQ3vztPD1PNBNwpxMkZmoEmSq
 cEudMBhJGgi2twp+npUmvdc9RX3AFAPmuxq9CMM7LExn/QsJVXOM4Zm301tMYZcimi
 uUpINIyWSSbOROuU0Q+hY+NUOl/ikp4Vi3BW4S+hdMlQS1X7xp4KfMNS2QI4UD5jr0
 RKjdxa3mL1Z8HIQpUhRoDxoL68+OM4G8XI2pLatYLvgnD4zIgPR6p3kkvYmbwQtrsZ
 zK4WjqVXxKKQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/logicvc: Fix layer_node reference leak in
 logicvc_layers_init()
To: "Jason Xiang" <jx@jasonxiang.net>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625023359.26011-1-jx@jasonxiang.net>
References: <20260625023359.26011-1-jx@jasonxiang.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 02:44:07 +0000
Message-Id: <20260625024407.970D41F000E9@smtp.kernel.org>
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
- [High] Use-after-free on DRM mode objects (plane, CRTC) due to `devm_kzal=
loc` memory allocation combined with `drmm_mode_config_init` lifecycle mana=
gement, and incorrect explicit freeing via `devm_kfree()`.
--

commit 0b8e61159a658d64dd9da573a68be2d6791f659b
Author: Jason Xiang <jx@jasonxiang.net>

drm/logicvc: Fix layer_node reference leak in logicvc_layers_init()

This commit fixes a reference leak on layer_node in the error path of
logicvc_layers_init() by adding an of_node_put() call.

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
This isn't a bug introduced by this patch, but does jumping to this error
label cause a use-after-free on DRM mode objects?

Looking at logicvc_layer_init(), layers are allocated with devm_kzalloc():

drivers/gpu/drm/logicvc/logicvc_layer.c:logicvc_layer_init() {
	...
	layer =3D devm_kzalloc(dev, sizeof(*layer), GFP_KERNEL);
	...
	ret =3D drm_universal_plane_init(drm_dev, &layer->drm_plane, ...);
	...
}

If an error occurs in logicvc_layers_init() after some layers are
successfully initialized, it jumps to the error label:

drivers/gpu/drm/logicvc/logicvc_layer.c:logicvc_layers_init() {
	...
error:
	list_for_each_entry_safe(layer, next, &logicvc->layers_list, list)
		logicvc_layer_fini(logicvc, layer);
	...
}

Then logicvc_layer_fini() explicitly frees the layer memory using devm_kfre=
e():

drivers/gpu/drm/logicvc/logicvc_layer.c:logicvc_layer_fini() {
	...
	list_del(&layer->list);
	devm_kfree(dev, layer);
}

Since the layer was registered with drm_universal_plane_init(), manually
freeing the layer without calling drm_plane_cleanup() leaves a dangling
pointer in drm_dev->mode_config.plane_list.

Additionally, on driver unbind or probe unwind, devres cleans up memory
before drmm_mode_config_init() runs its cleanup, which could iterate over
freed objects. A similar pattern appears to exist for the CRTC allocation
in logicvc_crtc_init().

Does this driver need to be updated to use drmm_universal_plane_alloc() and
similar drmm_* helpers to safely tie the object lifecycles to the DRM device
instead of devres?

>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625023359.2601=
1-1-jx@jasonxiang.net?part=3D1
