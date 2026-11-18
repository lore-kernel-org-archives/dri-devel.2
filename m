Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81576606A32F
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HTqDh8QD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF43910E11A;
	Wed, 18 Nov 2026 21:24:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8803B10EC87;
 Wed, 18 Nov 2026 21:24:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C88D963E31;
 Wed, 18 Nov 2026 21:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4379C1F000C8;
 Wed, 18 Nov 2026 21:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795037052;
 bh=CBZ4MUDN1V6G6hrYGqXNAHH4lS+mS4YrSWVjq50XU4g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=HTqDh8QDi3DGGaQUwXFEviTDlrmX2axB052QtdHd8dMFcNwdO4DSGIt+93JSBpLm5
 xSt0q3Ru4nrkGdckC03eujeEOS9i2UHgl6ezymWi9Og8k4swawOVYhOXt2ZGxjyBDL
 vDLGluqblK/cL60WiCTdwz0v/xo5h9hv01p3WgTK5808ui3xCOp+nIAH//q0WHZPdh
 J4fAngvIE+VoVYFw0H7zRxo6JQwaC+Ts1HN+uGnyhyquxE1P1v8ft/70bny45NfsjC
 pLH5ad8QyPjRbdpy7T5bbK73w+kZ0AmgqIm2amo/qvXpdklHwxmMpkR29+cbJHXMbh
 arwdaAf2N4+iQ==
Date: Wed, 18 Nov 2026 15:24:09 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, Shawn Guo <shengchao.guo@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Simona Vetter <simona@ffwll.ch>, Jessica Zhang <jesszhan0024@gmail.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>, freedreno@lists.freedesktop.org,
 Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 04/11] dt-bindings: display/msm: qcom,sm8650-dpu: Add
 Qualcomm Nord Soc
Message-ID: <179503704934.1079357.8885119101380287004.robh@kernel.org>
References: <20261116-nord-drv-dt-v3-0-e3d3bf0e2c49@oss.qualcomm.com>
 <20261116-nord-drv-dt-v3-4-e3d3bf0e2c49@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116-nord-drv-dt-v3-4-e3d3bf0e2c49@oss.qualcomm.com>
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


On Mon, 16 Nov 2026 18:46:43 +0530, Nabige Aala wrote:
> Add DPU (v12.1) for Qualcomm Nord SoC which has noticeable
> differences against SM8750 (v12.0):
>  - Added DSPP blocks
>  - Added INTF6-INTF10 and removed INTF1,INTF2 and INF5
>  - Added one more DP
> 
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

