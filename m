Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698D8C61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E0A310EC10;
	Wed, 26 Aug 2026 07:09:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zyu4bzj/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3320A10EC0F
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:09:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 477BA600C4;
 Wed, 26 Aug 2026 07:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65021F000E9;
 Wed, 26 Aug 2026 07:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787728194;
 bh=QDKTCkcUvt9uXFphhDSs7Uu1v6DBFmx22g8nVamvX3Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Zyu4bzj/YqaItzca7T3yQAehP+VbxXMD+nqiVT4NSEP8WThF71iC49cRqfaO0Zr5V
 bKvYs6u0sJ4T7qV5cDhDOEo/OCNIap/AGvipSPcUfXt4IFvmK9Lmd6bdZqVpFF+5KW
 hILC7rI8DTaVzgNK2fdsCwDE/iXwwKCMPpmjuc4uy1C29xMRoMzdeMBtoSoGniLZ+j
 rQcpRwCSH5Abcw9MhgrVW9WLHL3+tCDbh3vnAgSgEcki0/KpuVn6UYctlzrabdBD/3
 vxznOxJ7V1osQ4EHMU7Bm61oZvtjbXKuJzm5X98uwN5hcAMal0pTGVd405gGJ0TPRL
 0FdEKlp90LtMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/logicvc: fix device_node refcount leak in
 logicvc_layers_init()
To: "Qingshuang Fu" <fffsqian@163.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826065408.617148-1-fffsqian@163.com>
References: <20260826065408.617148-1-fffsqian@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 07:09:53 +0000
Message-Id: <20260826070953.C65021F000E9@smtp.kernel.org>
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
- [High] Mixing devm_kzalloc for DRM objects (like planes and CRTCs) with d=
rmm_mode_config_init causes a guaranteed Use-After-Free during driver unbin=
d or probe failure.
--

commit 6e5820173d0237a07dd104b640171197be436f49
Author: Qingshuang Fu <fuqingshuang@kylinos.cn>

drm/logicvc: fix device_node refcount leak in logicvc_layers_init()

This commit fixes a device node reference leak in logicvc_layers_init(). It
adds a missing of_node_put() on the error path to ensure the reference
acquired by for_each_child_of_node() is properly released when
logicvc_layer_init() fails.

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
This isn't a bug introduced by this patch, but could this error path lead t=
o a
use-after-free during mode config cleanup?

When logicvc_layer_init() fails and the code jumps to the error label,
logicvc_layers_init() cleans up previously initialized layers by calling
logicvc_layer_fini(). This function calls devm_kfree(dev, layer) without
first calling drm_plane_cleanup(), leaving dangling pointers in the drm_dev
plane_list.

Additionally, because logicvc_drm_probe() sets up mode config via
drmm_mode_config_init(), the mode config cleanup is registered as a DRM man=
aged
action. The layer and CRTC structures are allocated with devres (devm_kzall=
oc()
in logicvc_layer_init() and logicvc_crtc_init()).

During a probe failure or driver unbind, devres runs in LIFO order and frees
the layers and CRTC before releasing the drm_dev. When the drm_dev is final=
ly
released, drmm_mode_config_cleanup() iterates over mode_config.plane_list a=
nd
crtc_list to call their destroy hooks, dereferencing the already freed memo=
ry.

>  		}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826065408.6171=
48-1-fffsqian@163.com?part=3D1
