Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D6CCC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:52:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C022110E4E3;
	Thu, 15 Oct 2026 08:52:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCB1F10EB99
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:51:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A84724399D;
 Thu, 15 Oct 2026 08:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6061F000C5;
 Thu, 15 Oct 2026 08:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792054318;
 bh=dWcQvOvf0MJoEk6VNqyDCjj1jOptNR1+bSUzeS9rWHg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=a0JYqDdeV4dUJEEKDTGctJWkP6A+yCD9pB/X1h5SItjMlV9fhcQ1qjownfE8lC7IA
 ECFWUWKkexj8iIhe4/bSqAozOiu2gBIWNBuyZjKmPR9ZpM1KAEq2zmSa1H9ndZYHWx
 SRFiZU6vcnhqcuorUnszUiSl8heO86/oqmLjHiHXgQqRiA+vX3vLhbi4/6gRECAkkQ
 SCFB1f+iNyM3SN/94BX5D56urZuXgcE7JDgZfs3YIS4s3+/KCPQbh56vyd62XJLVyb
 PnUQWLfEOHGpqm15uTU6TbGdmJXizL0kEPishoIwm2qWdn+n1YlPpHfK0ZcBg+2VeZ
 C+q+5BnebxFzQ==
Message-ID: <sashiko-outbox-172521@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] arm64: dts: qcom: add device tree for SDM845-HDK
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261015-sdm845-hdk-v4-4-b532b9f4029c@oss.qualcomm.com>
References: <20261015-sdm845-hdk-v4-0-b532b9f4029c@oss.qualcomm.com>
 <20261015-sdm845-hdk-v4-4-b532b9f4029c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 08:51:57 +0000
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
- [Low] arm64: dts: qcom: inconsistent SDHC_2 drive strength vs comment
--

commit ad3a4fdbe0a1af267d2159b955cbbffe917a1e14
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

arm64: dts: qcom: add device tree for SDM845-HDK

Add device tree for the Qualcomm / Lantronix SDM845 HDK. This adds support
for the development platform using the modem-less (SDA845) SoC, including
peripherals like HDMI, DSPs, and USB.

> diff --git a/arch/arm64/boot/dts/qcom/sdm845-hdk.dts b/arch/arm64/boot/dt=
s/qcom/sdm845-hdk.dts
> new file mode 100644
> index 0000000000000..a2f139751ab6a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845-hdk.dts

[ ... ]

> +	sdc2_default_state: sdc2-default-state {
> +		clk-pins {
> +			pins =3D "sdc2_clk";
> +			bias-disable;
> +
> +			/*
> +			 * It seems that mmc_test reports errors if drive
> +			 * strength is not 16 on clk, cmd, and data pins.
> +			 */
> +			drive-strength =3D <16>;
> +		};
> +
> +		cmd-pins {
> +			pins =3D "sdc2_cmd";
> +			bias-pull-up;
> +			drive-strength =3D <10>;
> +		};
> +
> +		data-pins {
> +			pins =3D "sdc2_data";
> +			bias-pull-up;
> +			drive-strength =3D <10>;
> +		};

[Severity: Low]
Is this configuration intentional? The comment in the clk-pins block just
above explicitly warns that mmc_test reports errors if drive strength is not
16 on clk, cmd, and data pins.=20

However, cmd-pins and data-pins are configured with a drive strength of 10.
Does the comment need updating, or should these pins be set to 16 to avoid
potential mmc_test errors?

> +	};

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-sdm845-hdk=
-v4-0-b532b9f4029c@oss.qualcomm.com?part=3D4
