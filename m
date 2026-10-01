Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFD9CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E416E10E3F0;
	Thu,  1 Oct 2026 13:14:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="foELpJf1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DD1D10E3F0
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 13:14:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0A70440A44;
 Thu,  1 Oct 2026 13:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A001E1F000FF;
 Thu,  1 Oct 2026 13:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790860465;
 bh=8Dw3nZwM4dTesktDhxCNNRX7f0NMh7R30VeCOXlPa9A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=foELpJf1denkZyL6birvZNNTxgcZ2p8zOJEafEgv4WgAL2dlhTy+w2RdRXCi2M/pI
 ohe5td8zdslT/FX/EMq5udy59R8IvBOasLQY2me2fMRUYjgT91/J99IdBGdmaZ/4KX
 3M7ouuJy8s+7JhRFjjutPqWjRMppSQ5ClTPOYKezY99WiCYkd0yvsjXsJ4+xpMh0aN
 SUIhBb1Hu22WdVTHfyDd4g7rXJ/cjEDasZeEE5+HodkeJniklQ5Erxi28ArJ5lhJvq
 0CkGuuWgyORk5v6jqy8oKnlUGqVvtt2Wjb71hXVPy02jzwTJsE4qXLKXlZQdl9il40
 8BXV0ynDFsH+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 12/24] drm/bridge: shutdown and cleanup on bridge
 unplug
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: imx@lists.linux.dev, dri-devel@lists.freedesktop.org, Frank.Li@kernel.org
In-Reply-To: <20261001-drm-bridge-hotplug-v2-12-8e34986dcb68@bootlin.com>
References: <20261001-drm-bridge-hotplug-v2-0-8e34986dcb68@bootlin.com>
 <20261001-drm-bridge-hotplug-v2-12-8e34986dcb68@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 13:14:25 +0000
Message-Id: <20261001131425.A001E1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] drm/bridge: UAF from dangling encoder pointer in drm_bridge_re=
move()
- [Critical] drm/bridge: list corruption in drm_encoder_cleanup_from() on c=
oncurrent unplug
- [Critical] drm/bridge: data race on privobj_list during hot-unplug detach=
ment
- [High] drm/bridge: overbroad shutdown via drm_atomic_shutdown() on unplug
- [High] drm/bridge: lockless TOCTOU race on encoder pointer in drm_bridge_=
remove()
--

commit d7e62834c6a405667b2b0039bc07bf8c9f4cd74d
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/bridge: shutdown and cleanup on bridge unplug

This commit adds logic to shut down the pipeline and detach the removed
bridge (and subsequent ones) from the encoder chain when a bridge is
hot-unplugged. It modifies drm_bridge_remove() to invoke
drm_atomic_shutdown() and drm_encoder_cleanup_from() if the bridge is
attached to an encoder.

> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 3cf84f2da33ba..468ceed36eb9c 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -507,9 +507,17 @@ EXPORT_SYMBOL(devm_drm_bridge_add);
>   * it won't be found by users via of_drm_find_and_get_bridge(), and add =
it
>   * to the lingering bridge list, to keep track of it until its allocated
>   * memory is eventually freed.
> + *
> + * If the bridge was attached, also shutdown CRTCs and detach this bridge
> + * and the following ones.
>   */
>  void drm_bridge_remove(struct drm_bridge *bridge)
>  {
> +	if (bridge->encoder) {

[Severity: Critical]
Is it possible for bridge->encoder to be a dangling pointer here?

When a display driver unbinds, drm_encoder_cleanup() calls drm_bridge_detac=
h().
The detachment logic clears bridge->dev but fails to clear bridge->encoder:

drivers/gpu/drm/drm_bridge.c:drm_bridge_detach() {
	...
	bridge->dev =3D NULL;
	drm_bridge_put(bridge);
}

If the encoder memory is then freed, and the bridge driver later unbinds,
drm_bridge_remove() will observe the dangling bridge->encoder pointer and p=
ass
it to drm_encoder_cleanup_from(), which immediately attempts to acquire the
freed encoder's bridge_chain_mutex.


[Severity: High]
Is this lockless read of bridge->encoder susceptible to a TOCTOU race?

If this races with drm_bridge_attach(), it can observe the newly assigned
bridge->encoder before drm_bridge_attach() links the bridge into the encoder
chain under bridge_chain_mutex.

drm_bridge_remove() would then call drm_encoder_cleanup_from(), which acqui=
res
the mutex, sees the bridge is not yet in the list, and skips detachment. The
bridge is then linked into the chain by drm_bridge_attach(), while
drm_bridge_remove() proceeds to destroy bridge->hpd_mutex and drops its
refcount.

> +		drm_atomic_shutdown(bridge->dev);

[Severity: High]
Does this unconditionally disable all display pipelines on the DRM device d=
uring
a single bridge unplug?

Looking at drm_atomic_shutdown(), it invokes drm_atomic_disable_all() on the
entire device. For systems with multiple independent displays (e.g., an int=
ernal
eDP panel and an external hot-pluggable HDMI bridge), couldn't this blank t=
he
internal display when the external one is unplugged?

> +		drm_encoder_cleanup_from(bridge->encoder, bridge);

[Severity: Critical]
Can this lead to list corruption on concurrent unplugs?

In drm_encoder_cleanup_from(), the code evaluates !list_empty(&bridge->chai=
n_node)
to check if a bridge is attached:

drivers/gpu/drm/drm_encoder.c:drm_encoder_cleanup_from() {
	...
	if (!list_empty(&bridge->chain_node))
		list_for_each_entry_safe_from(bridge, next,
					      &encoder->bridge_chain, chain_node)
			list_move_tail(&bridge->chain_node, &tmplist);
	...
}

If Thread A removes an upstream bridge, it moves downstream bridges to its =
local
stack tmplist. If Thread B concurrently removes one of these downstream bri=
dges,
it acquires the mutex and evaluates !list_empty(). Since the node is in Thr=
ead
A's tmplist, it evaluates to true.

Thread B then executes list_for_each_entry_safe_from(), which expects to te=
rminate
at &encoder->bridge_chain. Because the node is actually on Thread A's stack
list, the loop never reaches the encoder's list head, wrapping around the s=
tack
LIST_HEAD and interpreting arbitrary memory as struct drm_bridge.


[Severity: Critical]
Does detaching a bridge here introduce a data race on privobj_list?

drm_encoder_cleanup_from() calls drm_bridge_detach(), which calls
drm_atomic_private_obj_fini(). This executes list_del(&obj->head) to remove=
 the
bridge from dev->mode_config.privobj_list.

However, privobj_list is documented as invariant over the lifetime of the d=
evice
and doesn't need locks:

include/drm/drm_mode_config.h:struct drm_mode_config {
	...
	/**
	 * @privobj_list:
	 *
	 * List of private objects linked with &drm_private_obj.head. This is
	 * invariant over the lifetime of a device and hence doesn't need any
	 * locks.
	 */
	...
}

Modifying it dynamically on hot-unplug without protective locks (like RCU)
introduces a data race with concurrent atomic operations or mode settings t=
hat
iterate the list locklessly.

> +	}
> +
>  	mutex_lock(&bridge_lock);
>  	list_move_tail(&bridge->list, &bridge_lingering_list);
>  	mutex_unlock(&bridge_lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-drm-bridge=
-hotplug-v2-0-8e34986dcb68@bootlin.com?part=3D12
