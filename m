Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C9BC5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:39:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8498810EE9E;
	Wed, 12 Aug 2026 07:39:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HL80GheG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D1BE10EE9E
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 07:39:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 913AF60A7E;
 Wed, 12 Aug 2026 07:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5771F000E9;
 Wed, 12 Aug 2026 07:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786520393;
 bh=5RsGI1VR34r6morus9taD5f+nwBUBZDNdGT5/wPRL+8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HL80GheGuUaJKN7hpV62ZNDB2McyF0bic1+WWnTiwAW0L0wB1sABjqCtaq+exvADu
 hF5X2LXMaJuXvJwNBardUIP4ShVyyUFCIJUlgmA3j2beG31D43uUA5wO65ees+IThn
 B/oGUfDFrivnbGMcyRRhGjjuNuqyF9xwReepeemHHS5pRKBWERctplHODAIP+KmEnp
 oKr2v4Xug7d66YGjhlfJHMfiGEduWhD8TDA3iBpXXhTuzt19+Q8Z9KFcwf3v9pRIJX
 /yX2Bili2/fICm7K3U5LciqpCA8EyeCBwweD0N7C0Tr+ecI+af8Uar1SphjqIJixF7
 0XWL/4UiqeABg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] drm/rockchip: dsi: Add maximum per lane bit rate
 calculation
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812073002.328-2-kernel@airkyi.com>
References: <20260812073002.328-1-kernel@airkyi.com>
 <20260812073002.328-2-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 07:39:52 +0000
Message-Id: <20260812073953.1E5771F000E9@smtp.kernel.org>
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
- [Medium] Strict inequality check for maximum lane bit rate incorrectly re=
jects exact boundary values, causing valid display modes to fail.
--

--- Patch [1]: [PATCH v4 1/3] drm/rockchip: dsi: Add maximum per lane bit r=
ate calculation ---
commit c849fa328462e27e823555ae008f52416cbc0bb9
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/rockchip: dsi: Add maximum per lane bit rate calculation

This commit introduces chip-specific maximum lane bit rate boundaries for t=
he
Rockchip DW MIPI DSI driver. This allows varying maximums per platform rath=
er
than using a hardcoded 1500 Mbps default.

> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gp=
u/drm/rockchip/dw-mipi-dsi-rockchip.c
> index 268d4993a04fd..fd91343d0f6d5 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c

[ ... ]

> @@ -572,6 +573,7 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const stru=
ct drm_display_mode *mode,
>  	unsigned long _fbdiv, best_fbdiv;
>  	unsigned long min_delta =3D ULONG_MAX;
> =20
> +	max_mbps =3D dsi->cdata->max_bit_rate_per_lane / USEC_PER_SEC;

[Severity: Medium]
Will this cause display modes that exactly match the new lower max_mbps
to fail?

In dw_mipi_dsi_get_lane_mbps(), there is a strict inequality check shortly
after this assignment:

        /* take 1 / 0.9, since mbps must big than bandwidth of RGB */
        tmp =3D DIV_ROUND_UP(mpclk * bpp * 10, lanes * 9);
        if (tmp < max_mbps)
                target_mbps =3D tmp;
        else
                DRM_DEV_ERROR(dsi->dev, "DPHY clock frequency is out of ran=
ge\n");

Because this patch lowers the boundary to 1000 Mbps or 1200 Mbps for several
chips, display modes that yield a bandwidth exactly matching the chip's
maximum will now be rejected.

For example, a mode needing exactly 1000 Mbps would have previously passed
because 1000 < 1500, but will now fail since 1000 is not < 1000. Should the
check be updated to allow exact boundary values by using <=3D max_mbps?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812073002.328-=
1-kernel@airkyi.com?part=3D1
