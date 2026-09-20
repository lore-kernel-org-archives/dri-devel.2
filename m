Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2D7C982E1
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 15:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5701310E412;
	Sun, 20 Sep 2026 15:10:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KJJW3bWg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8F5F10E0F8;
 Sun, 20 Sep 2026 15:10:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 51A8141143;
 Sun, 20 Sep 2026 15:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BBC1F000FF;
 Sun, 20 Sep 2026 15:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789917046;
 bh=QtVbNLcDa/iTthid63Qll4pVWqWerOdn9F8dCJT8zFQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KJJW3bWgPDuZAwPSJ7XyIWvS0BkVW/i8vaxBzw4+cgFgzL/44Zh80gZ6ZvsobC6Am
 B0dw8zAuVNHfwyo7J+XoSS3DIn9oCwQjsx2D2+sP3i7YrwvjT5jdezdeSxeuhRjhRF
 +o4b2GoKmpz8lyQO7F4D4buNRRHoKNWdTnxnRIx5jeL3yYqJLQknAsbWZPx8FNCKWD
 uGXQHK5wbPviq4gw3v+8/n2IvfAHBg6jSueibA2COtUYc+mbPGLOg6A0y/ZnRM53Ry
 qXtKu6QGyPXMYetdNkDaOxgyt4knpin69l4/ab1qGO7381XrkcSZMVFFCrkcfRVJ6Q
 Nq4jA5Un1MZHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/8] drm/bridge: pass down IRQ_HPD to the drivers
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 neil.armstrong@linaro.org
In-Reply-To: <20260920-hpd-irq-events-v5-5-ff1de0090c72@oss.qualcomm.com>
References: <20260920-hpd-irq-events-v5-0-ff1de0090c72@oss.qualcomm.com>
 <20260920-hpd-irq-events-v5-5-ff1de0090c72@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 15:10:45 +0000
Message-Id: <20260920151045.D3BBC1F000FF@smtp.kernel.org>
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
- [Low] drm/omapdrm: hdmi5_bridge_hpd_notify signature mismatch causes buil=
d failure
--

commit c12a9be57208a1450c89b7b186ca8f9ff6848995
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/bridge: pass down IRQ_HPD to the drivers

The DisplayPort standard defines a special kind of HPD events called
IRQ_HPD. These events are used to notify DP Source about the events on
the Sink side. Pass down the extra status to the bridge drivers via the
hpd_notify() callback, letting DP bridges to act accordingly.

> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index ed9f77a2597a1..2b3cad4bedde9 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -509,7 +509,8 @@ struct drm_bridge_funcs {
>  	 */
>  	void (*hpd_notify)(struct drm_bridge *bridge,
>  			   struct drm_connector *connector,
> -			   enum drm_connector_status status);
> +			   enum drm_connector_status status,
> +			   enum drm_connector_dp_event event);
> =20
>  	/**
>  	 * @hpd_enable:

[Severity: Low]
Could this cause a build regression by missing an update in
drivers/gpu/drm/omapdrm/dss/hdmi5.c?

While hdmi4_bridge_hpd_notify() was updated in this patch,
hdmi5_bridge_hpd_notify() in hdmi5.c still retains the old 3-argument
signature. Assigning this incorrectly-typed function pointer to
hdmi5_bridge_funcs.hpd_notify will result in an incompatible pointer type
compiler error when building with CONFIG_DRM_OMAP enabled:

drivers/gpu/drm/omapdrm/dss/hdmi5.c:
static void hdmi5_bridge_hpd_notify(struct drm_bridge *bridge,
                                    struct drm_connector *connector,
                                    enum drm_connector_status status)
{
...
static const struct drm_bridge_funcs hdmi5_bridge_funcs =3D {
...
        .hpd_notify =3D hdmi5_bridge_hpd_notify,
...
};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920-hpd-irq-ev=
ents-v5-0-ff1de0090c72@oss.qualcomm.com?part=3D5
