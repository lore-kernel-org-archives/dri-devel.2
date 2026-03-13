Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627B9107BCEA
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 22:19:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A37B810EB9C;
	Fri, 13 Mar 2026 22:19:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KnyeCv1g";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C815D10EB97;
 Fri, 13 Mar 2026 22:19:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 00E9060132;
 Fri, 13 Mar 2026 22:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6D6C19421;
 Fri, 13 Mar 2026 22:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773440389;
 bh=0MkZk4pZGxHmnsDZni06Nwrm9u06R9hz2Qn+nuX7Cvg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KnyeCv1gSsIriEpaxrHzP+lygHlT20gcMrzLgx4mwTE9NC003vla9SwA6mjLFJo3V
 N9PUfcT0xJjk5ahSc++qRBynsjJ+/IgpBthKjD/l+QTbShW47g3X9/rFXEebQB1Cl5
 pE2R67JWynOy/FtJqcF60LBRmjxO/NuhLuyO5OxdahYFbDfGKzaRgMCQwLtNxwy887
 AdFaDjrmiLIleuGmc6HDd5sxF70qT6MVLSDUGy1hoDeOO7UPsL+JuLgDUlePxBYTD2
 9soSwKPHAGVr262Kto0nhn2O9XrpA8aKGkfcCRYuYj3W6JdLLlTUys/BxzzFYCtOpq
 Z182JWHydSmWg==
Date: Fri, 13 Mar 2026 17:19:48 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, Maxime Ripard <mripard@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Marek <jonathan@marek.ca>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, David Airlie <airlied@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 linux-arm-msm@vger.kernel.org, Sean Paul <sean@poorly.run>,
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: display/msm: dp-controller: Add
 Eliza SoC
Message-ID: <177344038742.3527195.4769688326442777545.robh@kernel.org>
References: <20260304-drm-display-eliza-v2-0-ea0579f62358@oss.qualcomm.com>
 <20260304-drm-display-eliza-v2-1-ea0579f62358@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304-drm-display-eliza-v2-1-ea0579f62358@oss.qualcomm.com>
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


On Wed, 04 Mar 2026 13:58:43 +0100, Krzysztof Kozlowski wrote:
> Add DisplayPort controller for Qualcomm Eliza SoC fully compatible with
> SM8650.  The device looks very similar to SM8750 (same DP TX block
> v1.5.1) but with a differences in DP PHY: Eliza and SM8650 use DP PHY
> 4nm v7.0, SM8750 uses 3nm v8.0.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---
> 
> Changes in v2:
> 1. Commit msg
> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

