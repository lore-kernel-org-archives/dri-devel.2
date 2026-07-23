Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6811EC44536
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 02:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C98B310EF6A;
	Thu, 23 Jul 2026 02:01:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jo421Dv4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 053BE10EF6A
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 02:01:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E2ED241E7C;
 Thu, 23 Jul 2026 02:01:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9201F000E9;
 Thu, 23 Jul 2026 02:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784772062;
 bh=Jsj025+j5ajWSUEXfF8QGxVeM6i7mgTc2Fko/KuJWz4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Jo421Dv44BQ8JVDMO4QSVSsMGtVcLeVMo4yqWY4LCEtY2FaJirX4j1cuU9tkBlSQA
 XW2PJvIxJAEcHJtbggLR/xT1B25QuYP974FWxbZLxda3p8vpccyjZSQGmuszRLbrlh
 Fb6LVdT/Ua8w+FhPzM2+M+4f2Q+zyEJDQ7QHjqtiSACm5gQ8TLcL65PPGWapeHnBDl
 R8M3SBDh14cre1d7pVYKH4ms9caNY9dih6SxemcZ37RBg1doWIvMwLV1cvXCyMWbA7
 IBJUT6p+vuQVXYPyAAAc+z5vcgM3CMbPQCgKlIhiepPtChEp0Kbkfo07SJTRos++X6
 kOZOxVLfLk2qA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 43/61] drm/bridge: ite-it6263: Advertise HDMI 1.3
 capabilities
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260723-dw-hdmi-qp-scramb-v9-43-4fb12ea22ac9@collabora.com>
References: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
 <20260723-dw-hdmi-qp-scramb-v9-43-4fb12ea22ac9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 02:01:02 +0000
Message-Id: <20260723020102.9A9201F000E9@smtp.kernel.org>
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
- [Low] The macro `MAX_HDMI_TMDS_CHAR_RATE_HZ` and its descriptive comment =
are now unused and should be removed.
--

--- Patch [43]: [PATCH v9 43/61] drm/bridge: ite-it6263: Advertise HDMI 1.3=
 capabilities ---
commit 30b48bebf03b99c913be112fadde6e8cf5c4b197
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/bridge: ite-it6263: Advertise HDMI 1.3 capabilities

This commit advertises HDMI 1.3 support for the IT6263 bridge and drops the
redundant it6263_hdmi_tmds_char_rate_valid hook. The TMDS character rate
limit is now enforced via max_tmds_char_rate during connector atomic check.

> diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/bridge=
/ite-it6263.c
> index f166bb38998c0..73caf28c6ac77 100644
> --- a/drivers/gpu/drm/bridge/ite-it6263.c
> +++ b/drivers/gpu/drm/bridge/ite-it6263.c
> @@ -738,20 +738,6 @@ it6263_bridge_atomic_get_input_bus_fmts(struct drm_b=
ridge *bridge,
>  	return input_fmts;
>  }
> =20
> -static enum drm_mode_status
> -it6263_hdmi_tmds_char_rate_valid(const struct drm_bridge *bridge,
> -				 const struct drm_display_mode *mode,
> -				 unsigned long long tmds_rate)
> -{
> -	if (mode->clock > MAX_PIXEL_CLOCK_KHZ)
> -		return MODE_CLOCK_HIGH;
> -
> -	if (tmds_rate > MAX_HDMI_TMDS_CHAR_RATE_HZ)

[Severity: Low]
Since this function is being removed, should the definition of
MAX_HDMI_TMDS_CHAR_RATE_HZ in drivers/gpu/drm/bridge/ite-it6263.c also be
removed? It appears this patch removes the only user, leaving the macro and
its associated comment as dead code.

> -		return MODE_CLOCK_HIGH;
> -
> -	return MODE_OK;
> -}
> -

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-dw-hdmi-qp=
-scramb-v9-0-4fb12ea22ac9@collabora.com?part=3D43
