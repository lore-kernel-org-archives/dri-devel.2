Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727FEC982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 16:01:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81F4A10E2C3;
	Mon, 21 Sep 2026 16:01:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gbskjNYu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD72210E2C3
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 16:01:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F04A4082B;
 Mon, 21 Sep 2026 16:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611E61F000FF;
 Mon, 21 Sep 2026 16:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790006493;
 bh=5oywQCwkoyAWxKTkjl4BozavY9bZmFB/Ba3IzhVy34Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gbskjNYuncKSHhyoh/gYSa+8OKArHJdyqAqqqlEXAfbOC5l6q1P/PGOmZNAPg6Vgi
 A/AbTP1XQ8G+aNYOqfFwuw/fcPuMbOpvHn7zVZTyFrHyhj6usml1IdMCFVeWx5f85y
 /mnWWysSsnFtPh4MaNmFyHjZoVqSnuwyXmegrXCEYh6zyv6+sWq0ln5gHZ0+FwBBIv
 NzFfbFZ9hAE2nD1oXECS1RboS45P+pER3EtK/IFod0+Obl610UQ5pui/XPcRN1GpfI
 eRP0LUYMH26MVEaQKm2lrkGMsiJmyUN+JjanMJXpdiOe1ac0Fswfi/a4IS2UZHKYAw
 /ekAip7jj1RPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 05/25] drm/bridge: Add VTEM EMP support
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260921-vrr-limiter-uapi-v1-5-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-5-2fcd7d011646@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:01:32 +0000
Message-Id: <20260921160133.611E61F000FF@smtp.kernel.org>
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
- [Low] drm/bridge: kernel-doc mismatch for hdmi_write_vtem_emp
--

commit 4f42f5d433397d0bf7581a8604062c841adc15e1
Author: Derek Foreman <derek.foreman@collabora.com>

drm/bridge: Add VTEM EMP support

This commit adds setters and a support bit for VTEM EMP to the DRM bridge
infrastructure.

> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 77b3ffe692304..9dbd1bfa39afc 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h

[ ... ]

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

[Severity: Low]
This isn't a bug, but should this kernel-doc name be @hdmi_write_vtem_emp=20
to match the function pointer below? Running the kernel-doc validator on=20
this header will likely emit warnings about an unused documentation block=20
and an undocumented function pointer due to the mismatch.

> +	 *
> +	 * Program the emp into the hardware.
> +	 *
> +	 * This callback is optional but it must be implemented by bridges that
> +	 * set the DRM_BRIDGE_OP_HDMI_VTEM_EMP flag in their
> +	 * &drm_bridge->ops.
> +	 */
> +	int (*hdmi_write_vtem_emp)(struct drm_bridge *bridge,
> +				   const u8 *buffer, size_t len);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-vrr-limite=
r-uapi-v1-0-2fcd7d011646@collabora.com?part=3D5
