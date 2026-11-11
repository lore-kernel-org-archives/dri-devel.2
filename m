Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F90C606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cYFsVGf4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D89DD10E35C;
	Wed, 11 Nov 2026 17:27:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BED9310E35C;
 Wed, 11 Nov 2026 17:27:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5F57343462;
 Wed, 11 Nov 2026 17:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2C31F00A05;
 Wed, 11 Nov 2026 17:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794418042;
 bh=drt6bFkBv178cJO+P7WExaPrMxk8Yq5UNXKDoei1MCQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cYFsVGf4NBVdTKN4CbCW5yQsVh8gDenbOHLx1KBypUSEqU7bmrPhJz3nlaa60mAL8
 CWnvYbm4MLk72SqpzKATlBXMmGJBKRhVkC5JMhQDDZcq/zuxxdRRpsn088tk4jQ51X
 +mOmOvtn3um/6WTGbCnj7HlAQhdSqlfG95beSIbW5SLG7GvBPMA7+39X0ikcq4ScTP
 NS0o0NpQ/jhHrrFoFO8VQmi0O+rb6DHPF7/mvNeTb5KIFEVhBlQwMJjKFtP45jOloi
 ktXFnPbcKZLWR+Dne2e6Aoawl4S5R93oNt9BtWVvadJO9k5FSBcQfnAQ6wavJdJlvd
 /x5etHOT3ZqlQ==
Date: Wed, 11 Nov 2026 11:27:20 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Mahadevan <quic_mahap@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@mainlining.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Del Regno <angelogioacchino.delregno@somainline.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Robert Foss <rfoss@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
 Richard Acayan <mailingradian@gmail.com>,
 devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, linux-kernel@vger.kernel.org,
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 freedreno@lists.freedesktop.org, Jessica Zhang <jesszhan0024@gmail.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH 3/3] dt-bindings: display/msm: Require DSI graph endpoint
Message-ID: <179441783226.4120015.12174944636473780529.robh@kernel.org>
References: <20261110-display-msm-of-graph-v1-0-0f3106f817b4@oss.qualcomm.com>
 <20261110-display-msm-of-graph-v1-3-0f3106f817b4@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-display-msm-of-graph-v1-3-0f3106f817b4@oss.qualcomm.com>
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Tue, 10 Nov 2026 13:57:44 +0100, Krzysztof Kozlowski wrote:
> Technically, DSI controllers do not need OF graphs with endpoint to the
> panel and could rely directly on their child node (when panel is the
> child of DSI).
> 
> However Linux Qualcomm MSM DRM DSI driver never implemented such
> approach and it requires a valid graph endpoint pointing to the panel.
> If it is missing, the drivers will silently accept such DTS in
> dsi_host_parse_dt(), but later fail on dsi_host_attach() because number
> of lanes is not initialized.  The number of lanes is initialized to safe
> default only when there is a valid endpoint which is missing data-lanes.
> 
> Extend the bindings to validate existing DTS to match expected ABI.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/display/msm/dsi-controller-main.yaml      | 6 ++++++
>  .../devicetree/bindings/display/msm/qcom,milos-mdss.yaml          | 1 +
>  .../devicetree/bindings/display/msm/qcom,msm8998-mdss.yaml        | 2 ++
>  .../devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml        | 1 +
>  .../devicetree/bindings/display/msm/qcom,qcs8300-mdss.yaml        | 4 +++-
>  .../devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml        | 8 ++++++--
>  .../devicetree/bindings/display/msm/qcom,sar2130p-mdss.yaml       | 2 ++
>  .../devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml         | 1 +
>  .../devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml         | 1 +
>  .../devicetree/bindings/display/msm/qcom,sc8180x-mdss.yaml        | 2 ++
>  .../devicetree/bindings/display/msm/qcom,sdm670-mdss.yaml         | 2 ++
>  .../devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml         | 2 ++
>  .../devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml         | 1 +
>  .../devicetree/bindings/display/msm/qcom,sm6125-mdss.yaml         | 1 +
>  .../devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml         | 1 +
>  .../devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml         | 1 +
>  .../devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml         | 1 +
>  .../devicetree/bindings/display/msm/qcom,sm7150-mdss.yaml         | 2 ++
>  .../devicetree/bindings/display/msm/qcom,sm8150-mdss.yaml         | 2 ++
>  .../devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml         | 2 ++
>  .../devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml         | 1 +
>  .../devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml         | 2 ++
>  .../devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml         | 2 ++
>  .../devicetree/bindings/display/msm/qcom,sm8650-mdss.yaml         | 2 ++
>  .../devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml         | 1 +
>  25 files changed, 48 insertions(+), 3 deletions(-)
> 

Please don't apply this before the .dts changes. I'm tired of chasing 
down transcient warnings when only half the ABI break is applied.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
