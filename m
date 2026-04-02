Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF1FCC6B2D
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 08:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DF3A10F134;
	Thu,  2 Apr 2026 08:19:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JpbYY4Gs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E36710F13B;
 Thu,  2 Apr 2026 08:19:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 377C2444C6;
 Thu,  2 Apr 2026 08:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBFBC2BC9E;
 Thu,  2 Apr 2026 08:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775117997;
 bh=kCHRqLos+Q7aRM5Obmyyx2+3neVvE8bbS+yXZO5QXaI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JpbYY4GsdWnQNH+hxsL0E06CXFI0GS5Jlnl0vfOST9wjRCJhbxis8W2jEZC9IJURC
 tTzyjrTrQCmT9GbM/ly5SKpLFztZXZzqtYoxCvDVvDos8ulCQPyOL/G7FAfQKkSVNz
 lW+aWJ8YHvhxYGvMcmxkF5DkIvcNdxvc6khakROr8p0RqKVD1gdQ8eWveRjDLPo7Lu
 38CQDjwnxLhFuN1IYXIpaOqIL1SPp8fj7Rk8WfGLjP3RIwNgFRgt4z/IJDJnP9uT2E
 jUgHdBLDHEani32GAjVqiphSTFASm/w/AlMWhgJH6/BjIOKRQ368fWJBTRJx0NYV6J
 yw9zOE8vGJ9GA==
Date: Thu, 2 Apr 2026 10:19:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] arm64: dts: qcom: milos: Add Adreno 810 GPU and GMU
 nodes
Message-ID: <20260402-military-arrogant-woodpecker-4ab9b5@quoll>
References: <20260331-adreno-810-v1-0-725801dbb12b@pm.me>
 <20260331-adreno-810-v1-6-725801dbb12b@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260331-adreno-810-v1-6-725801dbb12b@pm.me>
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

On Wed, Apr 01, 2026 at 02:17:44AM +0000, Alexander Koskovich wrote:
> Add GPU and GMU devicetree nodes for the Adreno 810 GPU found on
> Qualcomm SM7635 (Milos) based devices.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  arch/arm64/boot/dts/qcom/milos.dtsi | 148 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 148 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/milos.dtsi b/arch/arm64/boot/dts/qcom/milos.dtsi
> index 621f05820826..a8feb0339804 100644
> --- a/arch/arm64/boot/dts/qcom/milos.dtsi
> +++ b/arch/arm64/boot/dts/qcom/milos.dtsi
> @@ -7,6 +7,7 @@
>  #include <dt-bindings/clock/qcom,milos-dispcc.h>
>  #include <dt-bindings/clock/qcom,milos-gcc.h>
>  #include <dt-bindings/clock/qcom,milos-gpucc.h>
> +#include <dt-bindings/clock/qcom,kaanapali-gxclkctl.h>

Why? My next from 27th Match does not have Milos in that binding. Was it
added? It's worth mentioning in commit msg.

Also, please keep alphabetical sort of the includes, k < m.

Best regards,
Krzysztof

