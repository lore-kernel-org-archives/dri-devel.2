Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C094AC98338
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 17:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2499A10E667;
	Sun, 27 Sep 2026 17:50:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cgL5SSxl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23E8310E65E;
 Sun, 27 Sep 2026 17:50:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5B2BA60052;
 Sun, 27 Sep 2026 17:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117E31F000FF;
 Sun, 27 Sep 2026 17:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790531436;
 bh=/vbm5QoeycSWTloWQxB0kK3Em/as6Fxxdtxh7/akDAU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cgL5SSxl4EIHtpk2EftozLFVQvL19d3Yksi4Qybvo/uVVVu2mM4yhNRU4nTTcVCZA
 oMz3NGKIDQvdnO5IpJjWjRCZZcJHoU1yStMmrU2lrzkqw9gts0nAYGc48SLADiEiLG
 uiVizhCyPO57ui43xZCoo8KlCPtwHU35UVu1kEI2NWmjAaBkSDYarmohJ/RzlYhPT0
 ah2wimxJhD+Bl6+zfoOJNsipF+aDTezlLBJ5au+LhOdLmvayiO2aoolMacvuG1hS6l
 xBKe9wjveFD8MoOSOk85CTi4IQKfjPP+Luav/rKHouK8mqsm9fqG4Y9S3evyuI6M6e
 9JADdWrSLLIUA==
Date: Sun, 27 Sep 2026 19:50:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Muzaffer Kadir <muzafferkadir@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Robert Marko <robimarko@gmail.com>, 
 Guru Das Srinagesh <linux@gurudas.dev>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Kees Cook <kees@kernel.org>,
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, iommu@lists.linux.dev, mfd@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-pm@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v3 12/19] dt-bindings: clock: qcom,rpmcc: Add MSM8952
 compatible
Message-ID: <20260927-statuesque-energetic-cheetah-dad592@quoll>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-12-b96fd3fe298b@mainlining.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921-msm8952-initial-support-v3-12-b96fd3fe298b@mainlining.org>
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

On Mon, Sep 21, 2026 at 09:19:03PM +0300, Muzaffer Kadir wrote:
> Document the rpmcc found on MSM8952.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> index 17332aa55886..aa532f208f5a 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> @@ -56,6 +56,11 @@ properties:
>                - qcom,rpmcc-shikra
>            - const: qcom,rpmcc-qcm2290
>            - const: qcom,rpmcc
> +      - items:
> +          - enum:
> +              - qcom,rpmcc-msm8952
> +          - const: qcom,rpmcc-msm8976
> +          - const: qcom,rpmcc

This block should be placed rather before one using qcm2290 as fallback,
to keep alphabetical sorting.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

