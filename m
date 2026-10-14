Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC51C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:34:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9FB010FE84;
	Wed, 14 Oct 2026 16:34:16 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8376610FE71
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:34:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BDACC60230;
 Wed, 14 Oct 2026 16:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241CF1F000C4;
 Wed, 14 Oct 2026 16:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791995648;
 bh=y1oqGte81QPkuu3Nzh/KYdoOan/7YE75ei9LVzMCaRg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Gl5tFEUGljMWk1XHidANSkZjbppuzB0ONJmoBWzo2w5WQUqAPCj7r9GJsVxEFM54L
 djij+SKw8DMrbll25e9oeSnqo02J6ExbWh3jNCnQJYVPtR1x8lnzzkn6589Hf/RrCS
 pTRqRU4hxpEgbmux98Wa843RkloFSQrUbVjk4s5Y4m1+XlKmkh+02AbVrKoa+KUFTS
 A9ALliIusrm2Z89jsLtmytD7TzyRDkKmO5dwcL1qWBdkMov95BtNb37h+yfpRyfSkY
 9JGy2oaHDzWt4mgBfWFcnx9qQeyq2CUrH1/ZCRJMoDhWvSTgASxBRuxRvkw2mzATT0
 Sy2kP1fCGvJ3A==
Message-ID: <sashiko-outbox-171536@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: sdm845-hdk: add display card
 overlay
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261014-sdm845-hdk-v2-5-6d0b4b42f267@oss.qualcomm.com>
References: <20261014-sdm845-hdk-v2-0-6d0b4b42f267@oss.qualcomm.com>
 <20261014-sdm845-hdk-v2-5-6d0b4b42f267@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 16:34:07 +0000
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
- [Medium] dts: qcom: sdm845-hdk: missing mode select line configuration
--

commit 054d071f82b9427b1a9e8eba69c5018761cb4d20
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

arm64: dts: qcom: sdm845-hdk: add display card overlay

This commit adds a device tree overlay for the SDM845 HDK to support a
Truly NT36850 WQHD dual-DSI panel.

> diff --git a/arch/arm64/boot/dts/qcom/sdm845-hdk-display-card.dtso b/arch=
/arm64/boot/dts/qcom/sdm845-hdk-display-card.dtso
> new file mode 100644
> index 0000000000000..1022ab096170f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845-hdk-display-card.dtso
[ ... ]
> +&tlmm {
> +	disp0_reset_n_active: disp0-reset-n-active-state {
> +		pins =3D "gpio6";
> +		function =3D "gpio";
> +		drive-strength =3D <8>;
> +		bias-disable;
> +	};
> +
> +	disp0_reset_n_suspend: disp0-reset-n-suspend-state {
> +		pins =3D "gpio6";
> +		function =3D "gpio";
> +		drive-strength =3D <2>;
> +		bias-pull-down;
> +	};
> +
> +	mdp_vsync: mdp-vsync-state {
> +		pins =3D "gpio10";
> +		function =3D "mdp_vsync";
> +		drive-strength =3D <2>;
> +		bias-pull-down;
> +	};
> +};

[Severity: Medium]
The commit message states "the mode select line driven low for the dual
port mode", but does the &tlmm node actually configure this?

There doesn't appear to be a gpio-hog definition or other configuration
here to statically drive the mode select line low. Without it, might the
dual-DSI panel fail to initialize correctly if the hardware defaults
to the single port mode?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-sdm845-hdk=
-v2-0-6d0b4b42f267@oss.qualcomm.com?part=3D5
