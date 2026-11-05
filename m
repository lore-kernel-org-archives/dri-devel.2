Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF0D606D822
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eFyHEeDX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4741710E94E;
	Thu,  5 Nov 2026 16:33:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 799BA10E34C
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 16:33:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 20E47412B3;
 Thu,  5 Nov 2026 16:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27891F000C1;
 Thu,  5 Nov 2026 16:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793896405;
 bh=ar+fuOsJ+En2tIkEzCw97yzoYxBV9Da6T+rtVtCPUA8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eFyHEeDXimv9XsoDHO7ZT4mF+sVU0J2VfOprpNt2iFAHFM5OAL17WXlo9OzqSbrfH
 8QqvMEAjE2m6eDRQ+q2KKboTQ+BBwZ8k9zw9ZrdmpvCg+hE+FbQBCNqrk5GzO5bxOA
 XCkwsVzA7srBmcXWWv8VeGfP2yN1UiNwupV4KhmR8jHBPA50aJ/K/65Pz9PNLhAgyS
 vQpgkj/oTntMUyhtHYu/T6JjZy+WT06aZpm9TBDkzfUD4xF8Dcoc8fy+Cc4Wp3pCQa
 CRrY7i6dY+c2COkMf+AeiaZOuFv/GWzHNPoY5LHea4Uc0kMlyeoBdtXN5e4Wxkb+80
 dOTqgNix/5E2Q==
Message-ID: <sashiko-outbox-199504@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/27] drm/bridge: Add VTEM EMP support
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-vrr-limiter-uapi-v2-4-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
 <20261105-vrr-limiter-uapi-v2-4-55f4215be2c2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:33:24 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] drm/bridge: wrong kernel-doc tag for hdmi_write_vtem_emp in drm_bri=
dge_funcs
--

commit db5205bd90d10ddf734b146e8cd3c0d61b65f621
Author: Derek Foreman <derek.foreman@collabora.com>

drm/bridge: Add VTEM EMP support

This commit adds VTEM EMP callbacks, the DRM_BRIDGE_OP_HDMI_VTEM_EMP
operation flag, and corresponding drm_bridge_connector wiring to support
VTEM extended metadata packets on HDMI bridges.

> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 1981d24a700d2..6913662023cae 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm_bridge.h
> @@ -684,6 +684,29 @@ struct drm_bridge_funcs {
>  	int (*hdmi_write_spd_infoframe)(struct drm_bridge *bridge,
>  					const u8 *buffer, size_t len);
> =20
> +	/**
> +	 * @hdmi_clear_vtem_emp:
> +	 *
> +	 * This callback clears the emp in the hardware during commit.
> +	 *
> +	 * This callback is optional but it must be implemented by bridges that
> +	 * set the DRM_BRIDGE_OP_HDMI_VTEM_EMP flag in their
> +	 * &drm_bridge->ops.
> +	 */
> +	int (*hdmi_clear_vtem_emp)(struct drm_bridge *bridge);
> +
> +	/**
> +	 * @hdmi_write_spd_infoframe:
> +	 *
> +	 * Program the emp into the hardware.
> +	 *
> +	 * This callback is optional but it must be implemented by bridges that
> +	 * set the DRM_BRIDGE_OP_HDMI_VTEM_EMP flag in their
> +	 * &drm_bridge->ops.
> +	 */
> +	int (*hdmi_write_vtem_emp)(struct drm_bridge *bridge,
> +				   const u8 *buffer, size_t len);

[Severity: Low]
As reported by Sashiko on RFC [1], should the kernel-doc comment for
hdmi_write_vtem_emp in struct drm_bridge_funcs in include/drm/drm_bridge.h
use @hdmi_write_vtem_emp: instead of @hdmi_write_spd_infoframe:, so that
running scripts/kernel-doc does not warn about a duplicate
@hdmi_write_spd_infoframe section and an undescribed hdmi_write_vtem_emp
member?

[1] https://lore.kernel.org/r/20260921-vrr-limiter-uapi-v1-5-2fcd7d011646@c=
ollabora.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-vrr-limite=
r-uapi-v2-0-55f4215be2c2@collabora.com?part=3D4
