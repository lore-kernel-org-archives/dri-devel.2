Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9892CC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F30E010E5A0;
	Thu, 15 Oct 2026 15:34:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F01910E5A0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:34:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F19734349E
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EA91F000C4;
 Thu, 15 Oct 2026 15:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792078465;
 bh=mnkAdyElXCuJ9bIcx6QldQtZNsm8U6339XuGjm7fm2Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iO8sGEBbDA73QMWQngHEpqlu+VTGzWnpNz2ByIotsT6A6fyLJte5J+UiRQCksuGVQ
 ey073ArDKoejM/DdZ/fMPs2E/YY+aSfY2MLtQx0nPQoPcj6qPdzJu5WPO6VLaRxlBV
 PXhcTjOsRzs5rf8/4P6Hq3VQYr0IDL9ZLhFtacPTKJAdwxHfi9hAM2rneeNMJQJ4xa
 G2DFxW6pPN7en3c19USBHz0PJcqFC1fVISe6mfm7Nvk9a6qfE8tCXjayLdoYSiO7bL
 TGhPBRtsTLgAw37JqBKyJytqsD+UZMH/ZktbRdSM7Q+bz1UbDPlJYSNKVZVgAA3L77
 Xza47wldLFh/Q==
Message-ID: <sashiko-outbox-173079@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/28] drm/bridge: Switch print_state to use bridge name
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-drm-state-readout-v6-3-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
 <20261015-drm-state-readout-v6-3-6cc02cd10998@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:34:25 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm_bridge: ignored return from drm_atomic_private_obj_init causes=
 crash
- [Low] drm_bridge: degraded debug output for statically allocated bridges
--

commit e5b998c537e0f9eb83be0fe1e66e8f70427ccfcc
Author: Maxime Ripard <mripard@kernel.org>
Subject: drm/bridge: Switch print_state to use bridge name

This commit updates drm_bridge_atomic_print_priv_state() to print the
human-readable bridge->name instead of the function pointer bridge->funcs.
This is intended to make the state readout output more consistent and
easier to interpret.

> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index d474d60204110..447fe6d333b3b 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -563,9 +563,9 @@ drm_bridge_atomic_print_priv_state(struct drm_printer=
 *p,
>  	struct drm_bridge *bridge =3D drm_priv_to_bridge(s->obj);
> =20
>  	if (bridge->of_node)
> -		drm_printf(p, "bridge: %ps (%pOFfc)\n", bridge->funcs, bridge->of_node=
);
> +		drm_printf(p, "bridge: %s (%pOFfc)\n", bridge->name, bridge->of_node);
>  	else
> -		drm_printf(p, "bridge: %ps\n", bridge->funcs);
> +		drm_printf(p, "bridge: %s\n", bridge->name);

[Severity: Low]
In drivers/gpu/drm/drm_bridge.c:drm_bridge_atomic_print_priv_state(),
for bridges that do not use devm_drm_bridge_alloc() (e.g., legacy or
statically allocated bridges), bridge->name is never initialized and
remains NULL.

When bridge->name is NULL, vsprintf safely intercepts the NULL pointer
and prints '(null)'.

Does this degrade the debug output compared to the previous behavior
(which printed the function pointer symbol for identification), defeating
the goal for these bridges?

[Severity: High]
While looking into the bridge->name changes, I noticed a related issue in
drivers/gpu/drm/drm_bridge.c:drm_bridge_attach(), where the return value
of drm_atomic_private_obj_init() is ignored.

A preceding patch in this series added a dynamically allocated name
parameter to drm_atomic_private_obj_init() which fails with -ENOMEM if
the allocation fails:

drivers/gpu/drm/drm_atomic.c:drm_atomic_private_obj_init() {
    ...
	obj->name =3D kstrdup(name, GFP_KERNEL);
	if (!obj->name) {
		ret =3D -ENOMEM;
		goto err_lock_fini;
	}
    ...
}

Because bridge->name is NULL for statically allocated bridges,
kstrdup(NULL) returns NULL, causing drm_atomic_private_obj_init() to
unconditionally fail. Since drm_bridge_attach() ignores the return value:

drivers/gpu/drm/drm_bridge.c:drm_bridge_attach() {
    ...
	drm_atomic_private_obj_init(bridge->dev, &bridge->base, bridge->name,
				    &drm_bridge_priv_state_funcs);

	return 0;
}

The private object is left zeroed and uninitialized.

Will this cause a deterministic NULL pointer dereference during teardown
when drm_bridge_detach() calls drm_atomic_private_obj_fini(), which
executes list_del(&obj->head) on a zeroed list_head? Does it also cause a
crash during atomic commits when drm_atomic_helper_swap_state() attempts
to dereference old_obj_state->state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-drm-state-=
readout-v6-0-6cc02cd10998@kernel.org?part=3D3
