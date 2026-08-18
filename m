Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38582C5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 558FB10E067;
	Tue, 18 Aug 2026 20:58:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KjbKgeip";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 731DF10E067
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 20:58:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 63525601DE;
 Tue, 18 Aug 2026 20:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B031F000E9;
 Tue, 18 Aug 2026 20:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787086688;
 bh=G1umH/P7M0QM9ZZL2yU9Z4octxqls7SjudBogTFxhrU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KjbKgeippzZB/6zkzwf2+nwHZg1BhyRrrVd8byF48jyRTPn47wwV5PUwp8DC3MvQQ
 Bx+KsTtkDBWLLNTsvVlC+kpXUSRK5HMLM7Ms2QjL+s+gV+dRQPOp16cMxyKWMHb1kZ
 gHP5/sNtHjHa+Bu4IoqftprH+kxXJ2y6vHvLbCBbvttE2JdpPlcgDtzwQmBvbopCFM
 bP4cSITL6tOawjKUdQ6TgiexXTB6TtNpcCRqHTpxIWAYtvr18zg42msvl5ykPM6gzw
 DDMxpsAqnuVGx/TwyHph9lPyvqer92OXNvilfT8dWs7qEl4MYJLJuMUb0HxmuIzRSl
 o/qngCMp1qyjg==
Date: Tue, 18 Aug 2026 15:58:07 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>, Yedaya Katsman <yedaya.ka@gmail.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 dri-devel@lists.freedesktop.org, Conor Dooley <conor+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor.dooley@microchip.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: Re: [PATCH] dt-bindings: display: panel: samsung,s6e8aa5x01: Allow
 common properties
Message-ID: <178708668632.548309.1196715575996049760.robh@kernel.org>
References: <20260818-topic-sprout_panel_warn_fix-v1-1-ded1e8d5f121@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-topic-sprout_panel_warn_fix-v1-1-ded1e8d5f121@oss.qualcomm.com>
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


On Tue, 18 Aug 2026 16:00:56 +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Change additionalProperties to unevaluatedProperties to allow
> inheriting properties from panel-common.yaml, preventing this warning:
> 
> qcom/sm6125-xiaomi-laurel-sprout.dtb: panel@0 (samsung,s6e8fc0-m1906f9): 'port' does not match any of the regexes: '^pinctrl-[0-9]+$'
>         from schema $id: http://devicetree.org/schemas/display/panel/samsung,s6e8aa5x01-ams561ra01.yaml
> 
> Fixes: f3e1caef597e ("dt-bindings: display: panel: document Samsung AMS561RA01 panel with S6E8AA5X01 controller")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  .../bindings/display/panel/samsung,s6e8aa5x01-ams561ra01.yaml           | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

