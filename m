Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B40CCC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:32:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 705CC10E5E4;
	Wed, 14 Oct 2026 11:31:54 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 556F610E5E4;
 Wed, 14 Oct 2026 11:31:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7889760219;
 Wed, 14 Oct 2026 11:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805D71F0089E;
 Wed, 14 Oct 2026 11:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791977507;
 bh=vw+7jQrUaW6gQiLHDSoehx2M6m/ImpU4GodAzQiW9Vw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WMiLNbeKnSwA/rEcgg2XRD74LUjkwxfflgDR+/8QGukGsQ0P3Pvk125N0cGv/cSVo
 85UPNcZIg5iMZIh5g9EQOW8tEFcUW2UPJft46xiHDjAWc8+CFwO1BHbTPZtCanZSDq
 bQVAQW4Zamz7zuiaLvUQGcb18jlqHXZHyP6RmhJgn5O3cBKfJV1xuf8Jg7P3iHyPpR
 oSuA7Q/1RT5pyoSFIKXzjI2Iq4co+6pf3JWSjx+lQBHjIOL0MfBd+o5Xp6WOUWnCcp
 uPc40qj2MGPeeJrKF42lESnwOqPuyc6S9CvFr+2AvV34wDANvGi08ZHxJIUJJ/L7xK
 q70avl+tBMRGA==
Date: Wed, 14 Oct 2026 13:31:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Abel Vesa <abelvesa@kernel.org>, Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: display: msm: Add INT2 GDSC to
 Kaanapali DPU
Message-ID: <20261014-elated-hasty-coot-ae3485@quoll>
References: <20261014-msm_gdsc2-v3-0-f1ed69014416@oss.qualcomm.com>
 <20261014-msm_gdsc2-v3-1-f1ed69014416@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014-msm_gdsc2-v3-1-f1ed69014416@oss.qualcomm.com>
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

On Wed, Oct 14, 2026 at 12:38:16PM +0800, Yongxing Mou wrote:
> Kaanapali (SM8850) has two display GDSCs. CORE_GDSC supplies shared
> MDSS hardware and most of the DPU, while INT2 GDSC supplies the
> VIG2/VIG3/DMA5 source pipes. Without INT2 GDSC, these source pipes
> remain inaccessible.
> 
> Describe CORE and INT2 as power domains of the DPU device, matching
> the hardware partitioning. INT2 only supplies DPU-local source pipes,
> while CORE also remains attached to the parent MDSS device because it
> supplies shared MDSS hardware. DPU performance-state votes on CORE are
> propagated through the genpd hierarchy to its parent MMCX domain.
> 
> Restrict the two-domain schema to the Kaanapali DPU compatible, so other
> platforms sharing qcom,sm8650-dpu.yaml retain the existing single
> power-domain constraint.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/display/msm/dpu-common.yaml | 19 +++++++++++++++++--
>  .../bindings/display/msm/qcom,kaanapali-mdss.yaml   |  4 +++-
>  .../bindings/display/msm/qcom,sm8650-dpu.yaml       | 21 +++++++++++++++++++++
>  3 files changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dpu-common.yaml b/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
> index 3f953aa5e694..19b791a857b5 100644
> --- a/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
> @@ -25,8 +25,7 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  power-domains:
> -    maxItems: 1
> +  power-domains: true

No, widest constraints always stay here. Look at other bindings.

>  
>    operating-points-v2: true
>    opp-table:
> @@ -53,4 +52,20 @@ required:
>    - operating-points-v2
>    - ports
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,kaanapali-dpu

There is no such compatible. Open this file and point me to it. Why are
you adding this compatible to common schema? Is there any prior art
doing something like this?

Best regards,
Krzysztof

