Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AA4C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B67710F57A;
	Thu,  3 Sep 2026 12:35:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HZAZ1zm1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 218DC10F57A
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 12:35:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E47CB42DB0;
 Thu,  3 Sep 2026 12:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB951F000E9;
 Thu,  3 Sep 2026 12:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788438950;
 bh=y3V+7uMRfnRdyanOSMgHTTGvCzLHmifBko8jlgoRIVs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=HZAZ1zm1RdkGbnsqhCrWKABPQcL0ZZDPvNL/ji0y0N2ZFtkJpTewen3Ls9/gna8qz
 tx27ZDTFscva9bILlikP8dxPVw+6+ysYDillpUnMZWOFbo7vRal9+WsMkc58dTNDQB
 e5moD0F6ecVHVtzp1I0sARJhHBn6ZUh633hR/9rxayCrHsbM3RqsoDb5A4zkepfupI
 E/jfrce2qAnNbZqoUM8Vysi+aYe0bUKMxHV1vcvuhBnahXHTf3nPWwHMv2yBXkWW7j
 LdUJ+S8aQKP9pB6+DFmeCHGugSsNcv2n7b/E9u50GEYlteA0Eqzs1xrVgLjhLyZfoU
 CGqdXOPFiB1Dg==
Date: Thu, 3 Sep 2026 14:35:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Xilin Wu <sophon@radxa.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Stephen Chen <stephen@radxa.com>,
 Junhao Xie <bigfoot@radxa.com>
Subject: Re: [PATCH 5/6] dt-bindings: pinctrl: qcom,sc8280xp-tlmm: allow
 gpio-line-names
Message-ID: <20260903-elated-ethereal-ladybug-eaf509@quoll>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-5-7de0b6a73d08@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260901-q8b-dts-v1-5-7de0b6a73d08@radxa.com>
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

On Tue, Sep 01, 2026 at 04:47:58PM +0800, Xilin Wu wrote:
> The SC8280XP TLMM GPIO controller exposes 230 GPIO lines. Allow boards to
> provide descriptive names for these lines and constrain the list to the
> number of GPIOs exposed by the controller.
> 
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

