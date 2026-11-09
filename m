Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49478606A333
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uf9DlNmb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72D7410E877;
	Mon,  9 Nov 2026 12:25:56 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD4AB10E279;
 Mon,  9 Nov 2026 12:25:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6C34041A7C;
 Mon,  9 Nov 2026 12:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B06D1F0089F;
 Mon,  9 Nov 2026 12:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794227149;
 bh=kJd4B1A71W2bSqOCg/3CIRE8x+hOqrAAX5uwcrZn7QQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Uf9DlNmbCl8RMTTpddNJvNO7YQMROzGH+LVeheLO68qBfeJHcBYhYIMCKqThRPV3I
 rttP5neahB9OHInWTbnHStnMUQns2Mny7pi8RyP/l6JWNP5MlZUUSAEK/80Xgk+Mnh
 j3lSjgFyxJf+wf3jz4xScwJtzzRxizVlhERzAM7xZLGTlRmFpwzdEJ5VJL9437BSNR
 z6bHq9d8hTdqrS9bqvZEH7AxycHFT+4Wrci9zuVT6Ct4RrQInuLVVZIKwpTavbZTtG
 hY6+lvSDF5KvsvZQecajA/OPzqP9TVfgxM5e+MywztijnCAdhtttUo2tyG+F+wodMm
 E0kJ3SM/guAZA==
Date: Mon, 9 Nov 2026 13:25:45 +0100
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Joonhoe Kim <26rote@gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: display: msm: Add INT2 GDSC to
 Kaanapali DPU
Message-ID: <20261109-mammoth-of-delightful-potency-b1ede2@quoll>
References: <20261109-msm_gdsc2-v5-0-4a3159b5e4b8@oss.qualcomm.com>
 <20261109-msm_gdsc2-v5-1-4a3159b5e4b8@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261109-msm_gdsc2-v5-1-4a3159b5e4b8@oss.qualcomm.com>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 04:36:35PM +0800, Yongxing Mou wrote:
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
> Keep the widest valid power-domain constraint in dpu-common.yaml and
> narrow it in each platform-specific binding. Require two domains and
> their names for Kaanapali, while retaining the existing single-domain
> constraint for all other DPU platforms.
> 
> Repeat power-domains in qcom,sm8650-dpu.yaml because dtschema requires
> power-domain-names to have a power-domains sibling in the same file.
> 
> Tested-by: Joonhoe Kim <26rote@gmail.com>

Drop

Anyway, where did it happen? Nothing in v4, nothing in v3.


> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  .../bindings/display/msm/dpu-common.yaml           |  3 +-
>  .../bindings/display/msm/qcom,kaanapali-mdss.yaml  |  4 ++-
>  .../bindings/display/msm/qcom,msm8998-dpu.yaml     |  3 ++
>  .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |  3 ++
>  .../bindings/display/msm/qcom,sc7180-dpu.yaml      |  3 ++
>  .../bindings/display/msm/qcom,sc7280-dpu.yaml      |  3 ++
>  .../bindings/display/msm/qcom,sc8180x-dpu.yaml     |  3 ++
>  .../bindings/display/msm/qcom,sdm845-dpu.yaml      |  3 ++
>  .../bindings/display/msm/qcom,sm6115-dpu.yaml      |  3 ++
>  .../bindings/display/msm/qcom,sm6150-dpu.yaml      |  3 ++
>  .../bindings/display/msm/qcom,sm7150-dpu.yaml      |  3 ++
>  .../bindings/display/msm/qcom,sm8150-dpu.yaml      |  3 ++
>  .../bindings/display/msm/qcom,sm8650-dpu.yaml      | 34 ++++++++++++++++++++++
>  13 files changed, 69 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dpu-common.yaml b/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
> index 3f953aa5e6949..c67199011f263 100644
> --- a/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
> @@ -26,7 +26,8 @@ properties:
>      maxItems: 1
>  
>    power-domains:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>  
>    operating-points-v2: true
>    opp-table:
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
> index 9f935defd6b12..6d6391970d6b6 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
> @@ -125,7 +125,9 @@ examples:
>  
>              operating-points-v2 = <&mdp_opp_table>;
>  
> -            power-domains = <&rpmhpd RPMHPD_MMCX>;
> +            power-domains = <&mdss_gdsc>,
> +                            <&mdss_int2_gdsc>;
> +            power-domain-names = "core", "int2";
>  
>              ports {
>                  #address-cells = <1>;
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml
> index d5a64c8a921f1..bded43a34b87d 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml
> @@ -15,6 +15,9 @@ properties:
>    compatible:
>      const: qcom,msm8998-dpu
>  
> +  power-domains:
> +    maxItems: 1
> +
>    reg:
>      items:
>        - description: Address offset and size for mdp register set
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
> index 034d3df8d2470..6c1476a0faaf5 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
> @@ -19,6 +19,9 @@ properties:
>            - const: qcom,shikra-dpu
>            - const: qcom,qcm2290-dpu
>  
> +  power-domains:
> +    maxItems: 1
> +
>    reg:
>      items:
>        - description: Address offset and size for mdp register set
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
> index 8137618237ce7..3fa0f02f44892 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
> @@ -19,6 +19,9 @@ properties:
>        - qcom,sm6350-dpu
>        - qcom,sm6375-dpu
>  
> +  power-domains:
> +    maxItems: 1
> +
>    reg:
>      items:
>        - description: Address offset and size for mdp register set
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
> index df9ec15ad6c3c..7703d9b017cfc 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
> @@ -24,6 +24,9 @@ properties:
>        - qcom,sm8450-dpu
>        - qcom,sm8550-dpu
>  
> +  power-domains:
> +    maxItems: 1
> +
>    reg:
>      items:
>        - description: Address offset and size for mdp register set
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc8180x-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc8180x-dpu.yaml
> index a411126708b80..8e10f9e0d1769 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,sc8180x-dpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sc8180x-dpu.yaml
> @@ -15,6 +15,9 @@ properties:
>    compatible:
>      const: qcom,sc8180x-dpu
>  
> +  power-domains:
> +    maxItems: 1
> +
>    reg:
>      items:
>        - description: Address offset and size for mdp register set
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml
> index dc11fd421a27f..9dafe1d827e13 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml
> @@ -17,6 +17,9 @@ properties:
>        - qcom,sdm670-dpu
>        - qcom,sdm845-dpu
>  
> +  power-domains:
> +    maxItems: 1
> +
>    reg:
>      items:
>        - description: Address offset and size for mdp register set
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
> index 510eb6c193649..173c2f034241c 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
> @@ -15,6 +15,9 @@ properties:
>    compatible:
>      const: qcom,sm6115-dpu
>  
> +  power-domains:
> +    maxItems: 1
> +
>    reg:
>      items:
>        - description: MDP register set
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-dpu.yaml
> index 8cbf99f9fcba5..b8344ff8895ac 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-dpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-dpu.yaml
> @@ -16,6 +16,9 @@ properties:
>    compatible:
>      const: qcom,sm6150-dpu
>  
> +  power-domains:
> +    maxItems: 1
> +
>    reg:
>      items:
>        - description: Address offset and size for mdp register set
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml
> index c79b2d4428003..8e50942f3e1f2 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml
> @@ -15,6 +15,9 @@ properties:
>    compatible:
>      const: qcom,sm7150-dpu
>  
> +  power-domains:
> +    maxItems: 1
> +
>    reg:
>      items:
>        - description: Address offset and size for mdp register set
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml
> index a88d22f30a602..b407bc3994620 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml
> @@ -17,6 +17,9 @@ properties:
>        - qcom,sm8150-dpu
>        - qcom,sm8250-dpu
>  
> +  power-domains:
> +    maxItems: 1
> +
>    reg:
>      items:
>        - description: Address offset and size for mdp register set
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
> index aa0cf0ec5b93f..c3bf4e7ca1ffe 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
> @@ -54,6 +54,15 @@ properties:
>        - const: core
>        - const: vsync
>  
> +  power-domains:
> +    minItems: 1
> +    maxItems: 2
> +
> +  power-domain-names:
> +    items:
> +      - const: core
> +      - const: int2
> +
>  required:
>    - compatible
>    - reg
> @@ -61,6 +70,31 @@ required:
>    - clocks
>    - clock-names
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,kaanapali-dpu
> +      required:
> +        - compatible

Droo required

> +    then:
> +      properties:
> +        power-domains:
> +          minItems: 2
> +
> +        power-domain-names:
> +          minItems: 2

How did you resolve my previous comment?

> +
> +      required:
> +        - power-domain-names

Why adding this?

Best regards,
Krzysztof

