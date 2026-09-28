Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FA6C9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 02:40:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D34DA10E6F5;
	Mon, 28 Sep 2026 02:40:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QGr2WhW2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24E7C10E6F5;
 Mon, 28 Sep 2026 02:40:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2C7FF60052;
 Mon, 28 Sep 2026 02:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5D81F000FF;
 Mon, 28 Sep 2026 02:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790563206;
 bh=LDjkTaw420ertubegWm220eZKiu4uuw5cWFVc9oA6uY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QGr2WhW2WEUAwM3aHRJliMiYDcrXq4joIi7Nca5Rasl3buOs9w77iMKaHXBPmcmzq
 +OYWvRRuwCfpVo3FvpHFxXDqOKUjvmjFw/DL3Lq5kEajbhB0hFYe4EC/8VfXEhjCaB
 QsqGdq6M8ceow4CoUFoZxXCnAW8vfE42RncxVFPrn7zWhYLsLUJo8TcXR31r45M6SY
 Bt9aJlCgUzFLGlZPIsG+FCfFgcS1k788P+6PPQtANHCMa4EMYsJ06I/q7zD3I0MdhB
 SWVADjBmtoe+ZctJQg0+0zy1VkvOXxP2uW3sHQ47woMWzhynOEyun26plVyvp/Xeaf
 /l46pwikFdUqA==
Date: Sun, 27 Sep 2026 21:40:02 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
Subject: Re: [PATCH 1/5] dt-bindings: display/msm/gmu: Fix Glymur's compatible
Message-ID: <arnTH0_tjrspIymm@zenbook>
References: <20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com>
 <20260925-mahua-gpu-v1-1-0fa0bfd8d315@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-mahua-gpu-v1-1-0fa0bfd8d315@oss.qualcomm.com>
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

On Fri, Sep 25, 2026 at 02:44:32AM +0530, Akhil P Oommen wrote:
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> The Glymur GMU compatible string was incorrectly documented as
> qcom,adreno-gmu-x285.1. Fix it to use the correct string
> qcom,adreno-gmu-x290.1.
> 
> Fixes: 7bc29d5fb6fa ("dt-bindings: display/msm/gmu: Add Adreno X2-85 GMU")
> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/display/msm/gmu.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
> index 9e459f12ce3f..f22661447e7c 100644
> --- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
> @@ -363,7 +363,7 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: qcom,adreno-gmu-x285.1
> +            const: qcom,adreno-gmu-x290.1

It would be preferrable if you add the new compatible and then once the
dts has moved you remove the old one (i.e. after next -rc1) - that way
my dtbs_check doesn't light up while we're trying to dance these patches
into the different branches.

Regards,
Bjorn

>      then:
>        properties:
>          reg:
> 
> -- 
> 2.55.0
> 
