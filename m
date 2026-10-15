Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89397CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:28:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95DDD10E300;
	Thu, 15 Oct 2026 15:28:49 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0D9D10E300
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:28:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D7C1760120
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BF91F000C4;
 Thu, 15 Oct 2026 15:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792078121;
 bh=6+PH+ssdXv6GXyAC/kPBehHg10xpvD+4E8eZ2GfM1t8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kJRSGdUQdRdSqgJzrJF2PGDXiZD+aQ3FjuetByNX+z1wrkLY9+1QwBThp3AidCzpm
 i0myMfllSdEmD5/2T5Ag7lshGc2p1dAYidoYLclhySssNDsmSDTcXTItsMpLshww0n
 VzGVLJZhdhj79vJIQzA/MlSBdNzUKa/DUHuBeL9LF3MnLa4sNLRBJ4drWiscEECfCl
 QVnSbR+HhzvvH09GgolaiXmtB3+I6Chuyu8OPFeXN8R0k7PA+d7h0O6jrR1MDQ8FUl
 x4VvtB/qMnr3cfZ+zTLt7p6Ekjch7yby4mwK6LUHnfWvgC2/cBqAOy0ETkCLqg8++X
 G6qvA2/AAhEFA==
Message-ID: <sashiko-outbox-173072@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/28] drm/bridge: Add drm_private_obj_is_bridge()
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-drm-state-readout-v6-4-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
 <20261015-drm-state-readout-v6-4-6cc02cd10998@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:28:41 +0000
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
- [Low] drm/bridge: typo in drm_private_obj_is_bridge NULL guard
--

commit 4aa8371c67584717cdc9bfc67e2f423ff8e526fe
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: Add drm_private_obj_is_bridge()

This commit introduces drm_private_obj_is_bridge() to identify if a private
object is backed by a bridge. This is necessary because bridges require
special readout ordering during encoder chain handling.

> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 447fe6d333b3b..9d5529765f5fb 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -582,6 +582,21 @@ static const struct drm_private_state_funcs drm_brid=
ge_priv_state_funcs =3D {
[ ... ]
> +/**
> + * drm_private_obj_is_bridge - check if a private object backs a bridge
> + * @obj: private object to check
> + *
> + * RETURNS:
> + *
> + * True if @obj is the &drm_private_obj embedded in a &struct drm_bridge,
> + * false otherwise.
> + */
> +bool drm_private_obj_is_bridge(struct drm_private_obj *obj)
> +{
> +	return obj->funcs && obj->funcs =3D=3D &drm_bridge_priv_state_funcs;

[Severity: Low]
Is there a typo in the null guard here?

If the intent is to protect against a null obj pointer, checking obj->funcs
first will cause a null pointer dereference.

If obj is instead guaranteed to be non-null, the left side of the && is
redundant dead code, because comparing a potentially null obj->funcs pointer
to a valid static address safely evaluates to false.

Should this instead be return obj && obj->funcs =3D=3D ... or just the right
side if obj is guaranteed to be non-null?

> +}
> +EXPORT_SYMBOL(drm_private_obj_is_bridge);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-drm-state-=
readout-v6-0-6cc02cd10998@kernel.org?part=3D4
