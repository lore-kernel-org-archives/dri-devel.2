Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F964C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC27910E02E;
	Fri, 24 Jul 2026 09:36:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UG5SoNhI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5D5410E010;
 Fri, 24 Jul 2026 09:36:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1AADA43872;
 Fri, 24 Jul 2026 09:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63BF1F000E9;
 Fri, 24 Jul 2026 09:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784885807;
 bh=iDc15U1kStf17/3+/VOLnuomPMxAGfj6hbdZDDiDRWI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UG5SoNhIcY02zB/cbJO3mbU8GDIHDmzZYMHQjV+m4ticc1ATRv5+6/qwiLgxUFUzF
 EeaBcmKIRwRvNn2R7DF62jkB0Ex44gTJzfVEBSNFv9Lq5mDBrUdx7SIcYC/P2b6wVM
 wyG+jr7YXQ6p2XVUPZZ0+XsuwwReewconY95shJrMldqy//hnAzn2ycYf1EBHxGLwC
 n8u1M8B3pat9HDB59DyKKCasi7klTw7ra9E7KbxAxfT6/vNx4Pd/Ig9QsUrJ0J+xo2
 amvxqTHgc6rfomtDxrD+DXsCowopoke5h3xlYuKixRRByCHWI85f8Szz3v/wMkzyJq
 pgVcu98D4s/PQ==
Date: Fri, 24 Jul 2026 11:36:42 +0200
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
Subject: Re: [PATCH 1/3] dt-bindings: display: msm: Allow two MDSS power
 domains
Message-ID: <20260724-cocky-uppish-pelican-3796ee@quoll>
References: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
 <20260720-msm_gdsc2-v1-1-4687866d6cb0@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260720-msm_gdsc2-v1-1-4687866d6cb0@oss.qualcomm.com>
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

On Mon, Jul 20, 2026 at 04:43:53PM +0800, Yongxing Mou wrote:
> Kaanapali (SM8750) and Glymur use two display power domains.
> CORE_GDSC powers the main display hardware while INT2_GDSC
> powers a subset of SSPP blocks.
> 
> Allow the MDSS bindings to describe both power domains and
> their corresponding power-domain-names values.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/display/msm/mdss-common.yaml        |  3 ++-
>  .../devicetree/bindings/display/msm/qcom,glymur-mdss.yaml   | 13 ++++++++++++-
>  .../bindings/display/msm/qcom,kaanapali-mdss.yaml           | 13 ++++++++++++-
>  3 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
> index c6305a6e0334..c0b650ffd9ef 100644
> --- a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
> @@ -31,7 +31,8 @@ properties:
>      const: mdss
>  
>    power-domains:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2

So all deviecs now get 2 domains and this is completely ignored in the
commit msg.

Best regards,
Krzysztof

