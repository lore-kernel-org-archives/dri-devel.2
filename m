Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F026C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 777B110E2EF;
	Fri, 11 Sep 2026 15:49:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JCptqKzZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 891C310E2EF
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:49:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A9BB060202;
 Fri, 11 Sep 2026 15:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0B81F000FF;
 Fri, 11 Sep 2026 15:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789141748;
 bh=hd+UvuJiwOUDiM2w6IpVWyqO25djS1xmTmBKKaDCSdQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JCptqKzZ75f32yJlRgCuNxgHtGsNfod82lXksNFXwLA9+FtJtt9MsmuYvPM8/dGs/
 QOvomvRyoUxVkNxGNULfpJ+d3ywbAK01KTQMsxfzGwt4urlJZoFXll7H9AB6K6bt2l
 aZUekB8Zv78fWUwChnPW/f0Fuo4zlSjSPEkGA0ueaQ7zW3jg8+iwKDSehi+53h3IF+
 H5jl0IZ509R1ITFFOgHiBPLuTy8sGH1yrhHaTDNL0sDlnUdBC07afOusPlUBWiR+xz
 1oGFCVWwhiU24LN7Z0Snrpc84pji2E67S5t8kqGbHyXV1M10LYWu1UVu6pKPMH3ZPn
 TeI6ApyF3+qmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/17] phy: qcom: edp: Add Nord-specific register offsets
To: "Nabige Aala" <nabige.aala@oss.qualcomm.com>
Cc: vkoul@kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 neil.armstrong@linaro.org, robh@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, olteanv@gmail.com
In-Reply-To: <20260911-nord-drv-dt-v1-7-e25c073cf1b6@oss.qualcomm.com>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-7-e25c073cf1b6@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 15:49:07 +0000
Message-Id: <20260911154907.BB0B81F000FF@smtp.kernel.org>
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
- [Low] The newly added register `DP_PHY_LDO_CFG` is missing the `_NORD` su=
ffix.
--

commit d9b8ac1d640ce0c0f48897f46216bd9e72eb391e
Author: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>

phy: qcom: edp: Add Nord-specific register offsets

This commit adds Nord-specific register offsets for the DP PHY and QSERDES
v8 COM to allow Nord sequences to reference them directly by name.

> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/p=
hy-qcom-edp.c
> index a3c893f72908f..bf8a17336c7ec 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
[ ... ]
> @@ -41,9 +41,19 @@
> =20
>  #define DP_PHY_VCO_DIV                          0x0074
>  #define DP_PHY_TX0_TX1_LANE_CTL                 0x007c
> +/* Nord uses a different register layout; non-Nord value is 0x00a0 */
>  #define DP_PHY_TX2_TX3_LANE_CTL                 0x00a0
> +#define DP_PHY_TX2_TX3_LANE_CTL_NORD            0x00c0
> =20
> +/* Nord uses a different register layout; non-Nord value is 0x00e0 */
>  #define DP_PHY_STATUS                           0x00e0
> +#define DP_PHY_STATUS_NORD                      0x0110
> +#define DP_PHY_LDO_CFG                          0x00f0

[Severity: Low]
The commit message notes this patch adds Nord-specific defines, and other
newly introduced registers appropriately use a _NORD suffix (like
DP_PHY_STATUS_NORD and DP_PHY_TX_LN0_DRV_LVL_NORD).

Does DP_PHY_LDO_CFG also need the _NORD suffix here? Leaving it off makes it
appear as a generic register rather than a Nord-specific one.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-nord-drv-d=
t-v1-0-e25c073cf1b6@oss.qualcomm.com?part=3D7
