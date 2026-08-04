Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A329DC55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FEB810E8C1;
	Tue,  4 Aug 2026 08:11:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="efHoyFr7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF99A10E8C1
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 08:10:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8613B4127C;
 Tue,  4 Aug 2026 08:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6461F000E9;
 Tue,  4 Aug 2026 08:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785831059;
 bh=Vxt3Gsgbxn5cm/fuapSJug3XwT+L+wuPC4HoZnkEuEY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=efHoyFr7Jy2Z8OYNZfVZMKIPis4v2qQ/W5hXsO93K6ld4pIpj0+CsZaIs2Sa9dE6t
 W0aguUimwYqwv8N9Wsoc0+i+9NqAn+RvMMhcuR7xJZL5fuEQom5F7+LIcI3Uxgq3FT
 42r2LYvr/UcqXNYrwq4b5+gQlYOYFAzdL11p9FdKMYNNfBBjT2S+b67UzRdauq5fHG
 1JXDmzQHGI3ng+4PQuGWoOMyDi9TTr5vz0Lt4yMibt5OSu4x/8c5jSGHFsk/iV3rqV
 dQziUwG1T+rMtlvGUsGAi2iAMG+JKDeJlZ2TGDhn4EYPK05/y8THhU2iRpOw4yEEMw
 8p/UI2FTUiLeg==
Date: Tue, 4 Aug 2026 10:10:55 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dawid =?utf-8?Q?Wr=C3=B3bel?= <me@dawidwrobel.com>
Cc: Jianhua Lu <lujianhua000@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sm8250-xiaomi-elish: label the
 WiFi node
Message-ID: <20260804-glossy-mastodon-from-sirius-db9aac@quoll>
References: <20260730-sm8250-xiaomi-enuma-v1-0-ed6d8fb99668@dawidwrobel.com>
 <20260730-sm8250-xiaomi-enuma-v1-3-ed6d8fb99668@dawidwrobel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260730-sm8250-xiaomi-enuma-v1-3-ed6d8fb99668@dawidwrobel.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, Jul 30, 2026 at 11:52:02PM +0200, Dawid Wr=C3=B3bel wrote:
> The Mi Pad 5 Pro 5G shares this device tree but needs its own board data
> variant, so give the node a label to allow overriding the property.
>=20
> Signed-off-by: Dawid Wr=C3=B3bel <me@dawidwrobel.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/a=
rch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
> index 19aff83ecf7b..12a2ba48340f 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
> @@ -817,7 +817,7 @@ &pcie0_phy {
>  };
> =20
>  &pcieport0 {
> -	wifi@0 {
> +	wifi_0: wifi@0 {

This is pointless on its own. Label does not end up in DTB, so your
patch has zero effect.

You miss the user of the label here.

Best regards,
Krzysztof

