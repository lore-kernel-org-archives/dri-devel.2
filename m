Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BDCC55171
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 23:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17D9410E1D3;
	Fri, 31 Jul 2026 23:24:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R4Diy8O+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA94A10E1D3
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 23:24:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 069C6600DA;
 Fri, 31 Jul 2026 23:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F7E1F00AC4;
 Fri, 31 Jul 2026 23:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785540277;
 bh=XnovqiqSPO9qXkYFQ9a3Bzdd9DblbyJK4dwwFmE7ZvA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R4Diy8O+nrqgkHECBciR/M9523P0WurIeqrt4nFt2YAPVubljXKjHgTPBpkl0QmcD
 0SJFKq2k2Hoqd/PDZ6YafUoeIfDdLv814bbeng6rYtTSLY0rYDgoG9blq/PgGdCJ9i
 mKQsAXt2B/Hxq52tNcJECMR0mWOfrjaMXEzBOLCZQb/fIGUh3BmAAAEIvi2eUgp17b
 x0fRECBi0rX/4te4y82zW9YxneQRWssdP4Yy3hcH7QpW+VLMMA2OTRoOuM8s1xNnZU
 bQNrKj7HdDfBV7wXhrcMtiwXRNaBnQ5WpxMLWX+92rLw2Bvj+9L/V8qE974WqNQ6U6
 VUo3WdrWemykA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 51/69] drm/bridge: ite-it6263: Advertise HDMI 1.3
 capabilities
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-51-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-51-294364b2cf15@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 23:24:37 +0000
Message-Id: <20260731232437.87F7E1F00AC4@smtp.kernel.org>
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
- [Low] The macro MAX_HDMI_TMDS_CHAR_RATE_HZ is left unused after its only =
caller was removed.
--

--- Patch [51]: [PATCH v10 51/69] drm/bridge: ite-it6263: Advertise HDMI 1.=
3 capabilities ---
commit bc899868425793b3c769c7eaa96a7d6bb7256b3c
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/bridge: ite-it6263: Advertise HDMI 1.3 capabilities

This commit advertises HDMI 1.3 support for the IT6263 bridge and sets the
max_tmds_char_rate limit. It also drops the hdmi_tmds_char_rate_valid() hoo=
k=20
since its checks are now handled earlier by the DRM core.

> diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/bridge=
/ite-it6263.c
> index 550999491086e..e8e0197171e10 100644
> --- a/drivers/gpu/drm/bridge/ite-it6263.c
> +++ b/drivers/gpu/drm/bridge/ite-it6263.c
[ ... ]
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
> -		return MODE_CLOCK_HIGH;

[Severity: Low]
Since this function is being removed, does this leave
MAX_HDMI_TMDS_CHAR_RATE_HZ as dead code?

Looking at drivers/gpu/drm/bridge/ite-it6263.c, the macro is defined near
the top of the file:

#define MAX_HDMI_TMDS_CHAR_RATE_HZ      225000000

but it doesn't appear to be used anywhere else in the driver now. Could it
be removed in this patch as well?

> -
> -	return MODE_OK;
> -}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-dw-hdmi-qp=
-scramb-v10-0-294364b2cf15@collabora.com?part=3D51
