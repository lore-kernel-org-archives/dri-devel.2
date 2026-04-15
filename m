Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D29F433CD
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 22:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5026410E1EB;
	Wed, 15 Apr 2026 22:05:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dyq3bdwE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 966B310E1CC;
 Wed, 15 Apr 2026 22:05:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 434A244079;
 Wed, 15 Apr 2026 22:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E9AC19424;
 Wed, 15 Apr 2026 22:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776290754;
 bh=mLhAH1+qugv1Sjri+ehdqjCtiHWhDQZg0i8/wQtcuss=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dyq3bdwEVhqrapGRkeC1slHrlvaOFocWB2Y400KUIDJJwiEI/99IYsNEpDjSTHxw7
 fu05FN2hFQrfOTD6rP06XhyB3p+rxtSbzqA1LHDunb9iLtS5l0Z1Sg1sAe2kKn9RuH
 DN2f4no+jojDj/td8r/T78bGhTH4nUfdBT39iFQwLuHcqgtwbcQhTznhI0+eZtN2f1
 5dRuWJkyzqeB9dwjVoqUe0QTBp+NLOZ73AIn95v8qJ/nsX+8dZeEB0NocrDY7j1H9W
 A3tBXrFFdXumPRlemFQOFDQSZ4DSzxUbo/wj8KNuZezMt9J5ww3m8F6rEYNqPgddIL
 4PcL3dgVnranw==
Date: Wed, 15 Apr 2026 17:05:51 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Dmitry Baryshkov <lumag@kernel.org>, freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Konrad Dybcio <konradybcio@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, devicetree@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-arm-msm@vger.kernel.org, David Airlie <airlied@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>, Sean Paul <sean@poorly.run>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 dri-devel@lists.freedesktop.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: display/msm: dp-controller: Correct
 SM8650 IO range
Message-ID: <177629075131.744309.15655011124361064388.robh@kernel.org>
References: <20260405-dts-qcom-display-regs-v2-0-34f4024c65dc@oss.qualcomm.com>
 <20260405-dts-qcom-display-regs-v2-1-34f4024c65dc@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405-dts-qcom-display-regs-v2-1-34f4024c65dc@oss.qualcomm.com>
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


On Sun, 05 Apr 2026 16:33:57 +0200, Krzysztof Kozlowski wrote:
> DP on Qualcomm SM8650 come with nine address ranges, so describe the
> remaining ones as optional to keep ABI backwards compatible.  Driver
> also does not need them to operate correctly.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../bindings/display/msm/dp-controller.yaml           | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

