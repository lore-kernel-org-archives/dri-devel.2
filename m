Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFE1606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lDLKu4Wp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BBB510E3B4;
	Sat, 21 Nov 2026 08:03:29 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 211CD10E3B4
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 08:03:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2F6AF60D54;
 Sat, 21 Nov 2026 08:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE601F000C0;
 Sat, 21 Nov 2026 08:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795248201;
 bh=+uOtZPsqOXKYcPYuGAOs5O9EZjEyzf3mVE2+5dr005A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lDLKu4WpmdS6Y9gr57RcC5JfqA0KUc0974f4NIJuYcodQP39QcJhFDSpkWx2ko5p9
 BxEYxnMl0j3twE9UVynMaF/x4l85c/ZM87L3+V+2eeBqR7nYZ5ipebt98NOkvFsSfU
 yt8c46bFiZ8JUjpJYCcVfgNFd31/F6NEF57rZF8qdGelx72S3YHBCfeuNzxHWpEfhW
 PMkSmnNk6ktlhnqmV+UnugEbtMSaP9k2rULGvajT7+E2wHAPuV8quUHU+D+uQEEj2v
 n5cuiZPhjX8ZllZ0ZW7LmaBgpW6fByc+5ODr0H+kbpwreV7Ygl+qjH2eftl2ab4qRB
 XD9LB1GH7n3pg==
Message-ID: <sashiko-outbox-226818@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/phy: rockchip: fix RK3506 DSI low-power command
 handling
To: ZhuXiangyu <1194781887@qq.com>
Cc: linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <tencent_6F7C9E04169BCBAE4E162DAA3DCD5395B209@qq.com>
References: <tencent_6F7C9E04169BCBAE4E162DAA3DCD5395B209@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 08:03:21 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/phy: rockchip: missing Fixes: trailers for RK3506 DSI and
  DPHY fixes
--

commit d9fc037cd18d975d189c46c8a1d083b08c417a92
Author: ZhuXiangyu <1194781887@qq.com>

> drm/phy: rockchip: fix RK3506 DSI low-power command handling
>
> Two bugs keep the RK3506 MIPI-DSI link from initialising a panel: the
> DPHY programs the wrong high-speed timing entry, and the PHY data lanes
> are never enabled in the GRF.
>
> 1. phy-rockchip-inno-dsidphy picks the wrong HS timing entry
>
>    The 1.5 GHz inno DSI PHY timing table stores its rates in Mbps while
>    the other tables and the lookup use Hz. The mode enable code compares
>    inno->pll.rate in Hz (e.g. 372000000) against timings[].rate in Mbps
>    (e.g. 400), so the comparison never matches. The loop runs to the end
>    and the last, fastest entry is used, which programs a TLPX/LPX
>    counter that is far too large. The panel then cannot decode the
>    low-power DCS commands and stays in sleep mode, so the display stays
>    black even though the LP packets are visible on the data lane.
>
>    Convert the 1.5 GHz timing table rates to Hz so that the lookup
>    selects the correct entry.
>
> 2. The RK3506 DSI GRF lane enable bits are never written
>
>    rk3506_chip_data only clears the turnaround / force-stop fields, so
>    the PHY data lanes stay disabled unless the boot loader happens to
>    enable them. Program RK3506_DSI_PHY_ENABLE_LANE0/1 as well.
>
> Tested on the RK3506B JerryTech board: the panel now receives the init
> sequence over LP and the framebuffer console is visible.
>
> Signed-off-by: ZhuXiangyu <1194781887@qq.com>

[Severity: Low]
This fixes bugs in the RK3506 DPHY and DSI support.  Should the commit
message include:

  Fixes: 785a9d5bb145 ("phy: rockchip: inno-dsidphy: Add support for rk3506=
")
  Fixes: cabeacc7eadc ("drm/rockchip: dsi: Add support for rk3506")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_6F7C9E04169=
BCBAE4E162DAA3DCD5395B209@qq.com?part=3D1
