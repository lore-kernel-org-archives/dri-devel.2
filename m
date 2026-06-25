Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8154ECDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B157610E1EA;
	Thu, 25 Jun 2026 13:40:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W1Psm/sF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D1B210E1EA
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:40:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9AF1260018;
 Thu, 25 Jun 2026 13:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278061F000E9;
 Thu, 25 Jun 2026 13:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782394813;
 bh=wQHcfa/X5NsZDXcZGSVp4y7Kgx10jzQH3t41uG3WyHE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W1Psm/sFUaVcsCN3ywSGsY5hLUqdafupneiaPfQqRJhUpC4Hew0gDFsY8qYoZSoKq
 s4A+Jt21nsgQBgvUDhA5wJPrsZbCtL4AP6spy6JUv5HdX8LXhf7hv8cCPt+6TsZFhs
 YHuSgBjK6ZBCxwRS11rTTLH4lk86CTGko/0Tmz+q7SDtihnPzTwynR4vnq/21/2Y6A
 2eE6r1MbNhjaCkdz3jupnigFWtbw1u3dD7fKTWSgo02oY7IwAr2tcTlCPCR8dHcEYo
 dp4EiVs4nYAmzX640v2sbdy3p/69+tMNedRRIAI5/yHiLHIKFLt89yWd+W9Isr8Eu4
 FO3C1mQGL2/Gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/logicvc: Fix port node reference leak in
 logicvc_crtc_init()
To: "Jason Xiang" <jx@jasonxiang.net>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625132438.191290-1-jx@jasonxiang.net>
References: <20260625132438.191290-1-jx@jasonxiang.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 13:40:12 +0000
Message-Id: <20260625134013.278061F000E9@smtp.kernel.org>
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
- [High] Use-After-Free due to devres and drmm lifetime mismatch.
- [High] Use-After-Free caused by explicit devm_kfree() without drm_plane_c=
leanup().
- [Medium] OF node reference leak when breaking out of for_each_child_of_no=
de().
--

commit a08081e9643ffc88f8c23d8338f577d6209738f8
Author: Jason Xiang <jx@jasonxiang.net>

drm/logicvc: Fix port node reference leak in logicvc_crtc_init()

This commit uses devm_add_action_or_reset() to drop the port node reference
obtained from of_graph_get_port_by_id(), fixing a node reference leak on
unbind and probe error paths.

> diff --git a/drivers/gpu/drm/logicvc/logicvc_crtc.c b/drivers/gpu/drm/log=
icvc/logicvc_crtc.c
> index 81e5b80736fa7..4de48822ca21b 100644
> --- a/drivers/gpu/drm/logicvc/logicvc_crtc.c
> +++ b/drivers/gpu/drm/logicvc/logicvc_crtc.c

[ ... ]

> @@ -274,6 +279,10 @@ int logicvc_crtc_init(struct logicvc_drm *logicvc)
> =20
>  	crtc->drm_crtc.port =3D of_graph_get_port_by_id(of_node, 1);
> =20
> +	ret =3D devm_add_action_or_reset(dev, logicvc_crtc_of_node_put, crtc->d=
rm_crtc.port);
> +	if (ret)
> +		return ret;

[Severity: High]
This isn't a bug introduced by this patch, but this new error return
introduces another path that triggers a use-after-free due to a lifetime
mismatch between devres and drmm.

The CRTC is allocated using devres:

drivers/gpu/drm/logicvc/logicvc_crtc.c:logicvc_crtc_init() {
	...
	crtc =3D devm_kzalloc(dev, sizeof(*crtc), GFP_KERNEL);
	...
}

However, the DRM device is also managed by devres:

drivers/gpu/drm/logicvc/logicvc_drm.c:logicvc_drm_probe() {
	...
	logicvc =3D devm_drm_dev_alloc(dev, &logicvc_drm_driver,
				     struct logicvc_drm, drm_dev);
	...
}

Since devres executes in reverse order of allocation, the CRTC and planes
are freed by devm_kzalloc unwinding before devm_drm_dev_alloc unwinding
calls drm_dev_put().

When drm_dev_put() runs, it calls drm_mode_config_cleanup(), which iterates
over the mode_config lists and calls .destroy() hooks on the already-freed
CRTC and plane structures.

Can we convert the CRTC allocation to use drmm_kzalloc() or similar
DRM-managed APIs to prevent this memory corruption on teardown?


While reviewing this, I noticed a couple of other pre-existing issues in
the driver's layer initialization.

[Severity: Medium]
This is a pre-existing issue, but does logicvc_layers_init() leak the device
node reference if layer initialization fails?

Looking at logicvc_layers_init() in drivers/gpu/drm/logicvc/logicvc_layer.c:

drivers/gpu/drm/logicvc/logicvc_layer.c:logicvc_layers_init() {
	...
	for_each_child_of_node(layers_node, layer_node) {
		...
		ret =3D logicvc_layer_init(logicvc, layer_node, index);
		if (ret) {
			of_node_put(layers_node);
			goto error;
		}
	...
}

The for_each_child_of_node() macro automatically drops the reference on the
previous child node and acquires it for the next one.

If the loop is terminated early via the goto error path, wouldn't the caller
need to manually drop the reference to the current layer_node using
of_node_put()?


[Severity: High]
This is a pre-existing issue, but does the error unwinding path in
logicvc_layers_init() cause a use-after-free in the DRM core?

If logicvc_layer_init() succeeds for at least one layer but fails for a
subsequent layer, the error path iterates over the successfully initialized
layers:

drivers/gpu/drm/logicvc/logicvc_layer.c:logicvc_layers_init() {
	...
error:
	list_for_each_entry_safe(layer, next, &logicvc->layers_list, list)
		logicvc_layer_fini(logicvc, layer);
	...
}

This calls logicvc_layer_fini(), which explicitly frees the layer memory:

drivers/gpu/drm/logicvc/logicvc_layer.c:logicvc_layer_fini() {
	...
	devm_kfree(dev, layer);
}

The layer's drm_plane was already added to the DRM device's
mode_config.plane_list during initialization.

Because drm_plane_cleanup() is never called to unlink the plane from the
core list, the explicitly freed memory remains accessible to the DRM core.

When probe ultimately unwinds and drm_mode_config_cleanup() is called, will
it dereference the freed plane?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625132438.1912=
90-1-jx@jasonxiang.net?part=3D1
