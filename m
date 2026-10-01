Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C26CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 125A110E2C1;
	Thu,  1 Oct 2026 13:05:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H6HaFnHW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DF3110E2C1
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 13:05:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0FCD140530;
 Thu,  1 Oct 2026 13:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40D11F00898;
 Thu,  1 Oct 2026 13:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790859942;
 bh=0idX3RpCU1ES9v7UHQmzqGhckQxrUQDJUUBWr8W3mvI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H6HaFnHWl5SGzS5IwZOT6TiTdlep5erJQGoqQu1o6HoHWYnBhFsHYD5jBgCqjXESm
 mE33Gk+nZUlcsyEMwRRBDTzTdl9T4J9ZjqQu9lilzxveYvKh1afxOy9UYDb9UJOhIz
 vXzKBP1CnyajT75ghZCJYwIbDxNHHZ6apIWJ8m6oogMOJInSUkrYPfzpy2CJn30AVx
 hhb9Ur6mRWa1NEqxJfQwEgtPcnGUkRuhl9zb4toOYah+lHZP/Agxm37m0CnJko/vKj
 3E8oTdwP0NLJlMIuJilpdCtSo8WXYG3xO53C3VBJpYVMqi4YqjqxbSFkaMj9dlnBUT
 oV4SxuMkmAdpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 10/24] drm/encoder: add drm_encoder_cleanup_from()
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20261001-drm-bridge-hotplug-v2-10-8e34986dcb68@bootlin.com>
References: <20261001-drm-bridge-hotplug-v2-0-8e34986dcb68@bootlin.com>
 <20261001-drm-bridge-hotplug-v2-10-8e34986dcb68@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 13:05:42 +0000
Message-Id: <20261001130542.A40D11F00898@smtp.kernel.org>
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
- [High] drm: list corruption in privobj_list during dynamic bridge detachm=
ent
--

commit 77c9ca5601fd825a1740e548bb2319aadc1fb84a
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/encoder: add drm_encoder_cleanup_from()

Supporting hardware whose final part of the DRM pipeline can be physically
removed requires the ability to detach all bridges from a given point to
the end of the pipeline. Introduce a variant of drm_encoder_cleanup()
for this.

> diff --git a/drivers/gpu/drm/drm_encoder.c b/drivers/gpu/drm/drm_encoder.c
> index 0d5dbed06db44..40ece477b3025 100644
> --- a/drivers/gpu/drm/drm_encoder.c
> +++ b/drivers/gpu/drm/drm_encoder.c
[ ... ]
> @@ -179,6 +179,44 @@ int drm_encoder_init(struct drm_device *dev,
>  }
>  EXPORT_SYMBOL(drm_encoder_init);
> =20
> +/**
> + * drm_encoder_cleanup_from - remove a given bridge and all the following
> + * @encoder: encoder whole list of bridges shall be pruned
> + * @bridge: first bridge to remove
> + *
> + * Removes from an encoder all the bridges starting with a given bridge
> + * and until the end of the chain.
> + *
> + * Does nothing if the bridge is not attached to an encoder chain.
> + *
> + * This should not be used in "normal" DRM pipelines. It is only useful =
for
> + * devices whose final part of the DRM chain can be physically removed a=
nd
> + * later reconnected (possibly with different hardware).
> + */
> +void drm_encoder_cleanup_from(struct drm_encoder *encoder, struct drm_br=
idge *bridge)
> +{
> +	struct drm_bridge *next;
> +	LIST_HEAD(tmplist);
> +
> +	/*
> +	 * We need the bridge_chain_mutex to modify the chain, but
> +	 * drm_bridge_detach() will call DRM_MODESET_LOCK_ALL_BEGIN() (in
> +	 * drm_modeset_lock_fini()), resulting in a possible ABBA circular
> +	 * deadlock. Avoid it by first moving all the bridges to a
> +	 * temporary list holding the lock, and then calling
> +	 * drm_bridge_detach() without the lock.
> +	 */
> +	mutex_lock(&encoder->bridge_chain_mutex);
> +	if (!list_empty(&bridge->chain_node))
> +		list_for_each_entry_safe_from(bridge, next, &encoder->bridge_chain, ch=
ain_node)
> +			list_move_tail(&bridge->chain_node, &tmplist);
> +	mutex_unlock(&encoder->bridge_chain_mutex);
> +
> +	while (!list_empty(&tmplist))
> +		drm_bridge_detach(list_first_entry(&tmplist, struct drm_bridge, chain_=
node));

[Severity: High]
Does this dynamically detach the bridge without acquiring the
connection_mutex?

If a hardware bridge unplug triggers drm_bridge_remove(), this calls:
drm_encoder_cleanup_from() -> drm_bridge_detach() ->
drm_atomic_private_obj_fini()

In drm_atomic_private_obj_fini(), it executes:
    list_del(&obj->head);
on dev->mode_config.privobj_list without holding connection_mutex or any
other list-protecting lock.

Can this create a fatal race condition with concurrent lockless readers?

Concurrent userspace DRM IOCTLs (like modeset or atomic commits) can invoke
drm_modeset_lock_all_ctx(), which iterates over privobj_list locklessly
using list_for_each_entry(). The lockless iteration would race with the
un-synchronized list_del() triggered here, potentially corrupting the list
traversal for the reader and causing a crash.

> +}
> +EXPORT_SYMBOL(drm_encoder_cleanup_from);
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-drm-bridge=
-hotplug-v2-0-8e34986dcb68@bootlin.com?part=3D10
