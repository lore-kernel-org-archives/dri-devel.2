Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B52AC624D6
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC08E10F56B;
	Thu,  3 Sep 2026 12:21:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZZsCYv/o";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2895210F56B
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 12:21:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 58F2060235;
 Thu,  3 Sep 2026 12:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60691F00A3A;
 Thu,  3 Sep 2026 12:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788438106;
 bh=pEFcQwUWKI0+glCWBdCizaYXqt/sRHZ3qa/JpkWlcdo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZZsCYv/oIufvrbwozPstakgJ3BAdRn1ofneWuuvuVaNvHRI3j/SstJl1/RV85wiUk
 OdpStGOaiYz/rm1s3nyCR44regZs1qr81fu9rMtTb3fOPY2cvwLWDG6xc3hoNv91di
 eUOmhFaWSvAh5F+Pl8+SZvBmaL+pWr2+0fZO8n29Gn962LDLQazqDA1ZINye+LlTgj
 WiPfTiq1B8do6hMG3jfia7z01B3Low2W4jwIHdtO6UIoTAWU3u0Is/wUxNKAED3oYM
 VS4/4288FVNqscDTCA47VQ2IL8yJHl0rir/PwsCOFd2QjnWzrS0GmjA9hr/q/rVI9t
 vPNQbb4c0srDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/10] drm/tidss: oldi: Fix OLDI signal polarities
To: "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260903-tidss-pre-beagley-v1-8-93928baa8b12@ideasonboard.com>
References: <20260903-tidss-pre-beagley-v1-0-93928baa8b12@ideasonboard.com>
 <20260903-tidss-pre-beagley-v1-8-93928baa8b12@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 12:21:45 +0000
Message-Id: <20260903122145.B60691F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] Modifying driver-private state in atomic check callback violates a=
tomic modesetting semantics.
--

commit 3406ad4360f9e6a4eda4b2203c1f6400e5e7ab77
Author: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

drm/tidss: oldi: Fix OLDI signal polarities

This commit fixes OLDI signal polarities by removing drm_bridge_timings
and properly setting input_bus_cfg.flags in tidss_oldi_atomic_check(),
as well as setting OLDI_DEPOL based on the DE bus flag.

> diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/t=
idss_oldi.c
> index 5eb749f495d59..624f1646fb07a 100644
> --- a/drivers/gpu/drm/tidss/tidss_oldi.c
> +++ b/drivers/gpu/drm/tidss/tidss_oldi.c

[ ... ]

> @@ -329,7 +352,8 @@ tidss_oldi_mode_valid(struct drm_bridge *bridge,
>  }
> =20
>  static const struct drm_bridge_funcs tidss_oldi_bridge_funcs =3D {
> -	.attach	=3D tidss_oldi_bridge_attach,
> +	.attach =3D tidss_oldi_bridge_attach,
> +	.atomic_check =3D tidss_oldi_atomic_check,
>  	.atomic_pre_enable =3D tidss_oldi_atomic_pre_enable,
>  	.atomic_post_disable =3D tidss_oldi_atomic_post_disable,
>  	.atomic_get_input_bus_fmts =3D tidss_oldi_atomic_get_input_bus_fmts,

[Severity: High]
This isn't a bug introduced by this patch, but does the implementation of
tidss_oldi_atomic_get_input_bus_fmts() violate atomic modesetting
semantics by modifying driver-private state during the check phase?

In drivers/gpu/drm/tidss/tidss_oldi.c:tidss_oldi_atomic_get_input_bus_fmts(=
):

        input_fmts[0] =3D oldi_bus_formats[i].input_bus_fmt;
        oldi->bus_format =3D &oldi_bus_formats[i];

A TEST_ONLY atomic commit or concurrent commits can alter the global
driver-private state (oldi->bus_format). This could cause a subsequent
real commit to program the hardware with an incorrect bus format, leading
to display corruption.

Should this configuration decision be stored in the drm_bridge_state object
instead of the driver-private tidss_oldi structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-tidss-pre-=
beagley-v1-0-93928baa8b12@ideasonboard.com?part=3D8
