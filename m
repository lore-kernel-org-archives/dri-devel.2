Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78325107BCE8
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 22:20:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C67C510EB9E;
	Fri, 13 Mar 2026 22:20:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WyilRsVw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E65B10EB9E;
 Fri, 13 Mar 2026 22:20:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1812860132;
 Fri, 13 Mar 2026 22:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80456C19421;
 Fri, 13 Mar 2026 22:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773440401;
 bh=cxsE61Udr6fKEoCues0p7VRlQg8F2SPg+fKrpN64xZg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WyilRsVw/NQRiLwyRR9gBY+zG+kNOXTOi+NdksNXHQ4FLLW6mlxQz0Soh881IR2Ea
 ZFwy4zPEurK0j7OXBJk3CmRrf7ly95QYbN9O50YCg+eiKtJVBUdHwxckbB7mcrd7le
 dzF1vDZhIU7eHtqbP2gTdYeR9Tai7ZsUO1f39vgIdtdV5t6FwBs6Qh5kYlN4qVX1jD
 OaaCCW9rQDBOHsIt1A5VUNWlYZczLV7F6fFBaw4x0NcsXm2NuPqItl3+gKgUZZ7oit
 kXyqJcctWJnDam6t3sTgDplL6cpQv52Wa6yzM+/rsFgcrdufkb15tNtijS8vrN1AHy
 Na+ahywOfLY+g==
Date: Fri, 13 Mar 2026 17:20:00 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jonathan Marek <jonathan@marek.ca>, freedreno@lists.freedesktop.org,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Marijn Suijten <marijn.suijten@somainline.org>, devicetree@vger.kernel.org,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 2/8] dt-bindings: display/msm: dsi-phy-7nm: Add Eliza
 SoC
Message-ID: <177344040017.3529549.10944169278090896454.robh@kernel.org>
References: <20260304-drm-display-eliza-v2-0-ea0579f62358@oss.qualcomm.com>
 <20260304-drm-display-eliza-v2-2-ea0579f62358@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304-drm-display-eliza-v2-2-ea0579f62358@oss.qualcomm.com>
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


On Wed, 04 Mar 2026 13:58:44 +0100, Krzysztof Kozlowski wrote:
> Add DSI PHY 4nm v5.2.4 for the Qualcomm Eliza SoC, fully compatible with
> SM8650.  Note that this DSI PHY, unlike the Eliza MDSS DSI, is not
> compatible with SM8750.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

