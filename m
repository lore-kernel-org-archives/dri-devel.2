Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7D5CC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:37:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 923A910F53B;
	Tue, 13 Oct 2026 07:37:14 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D448010F52D;
 Tue, 13 Oct 2026 07:37:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B8485600D1;
 Tue, 13 Oct 2026 07:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25D61F000FF;
 Tue, 13 Oct 2026 07:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791877027;
 bh=i+pC2obaIGGB4V4M0zaUFjWaDrcyP3lwZCtySrn98To=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ldKtogeUzd/aBwyOxdYNBr9Qa2OiQSHlKRmb3TMb97JKdmzFa2x/O4ieFa2MCayxr
 /KvURpTVGnMGWYr86fLjT5xOOuHdA7/pJPPjH9TWmKqr3jNM7qxrVCKVwk22Ctzzcv
 Kl4EtgiURLO68qYkqtl9f4z81chc/V50/vsFOW4CwyJ+JN4zzGIPq6KuUZLrH0IoPz
 kEm8pY4Ugv0f6VoD0p5zX7FlzQXYJCDmBCg/ZDRhYdRcpqS5TcUSdcMdijrl/ixhNv
 pQ3yQvdc7CiXvDoarOdnvAcV28s+zjijopI6fMGCxgEl2zqSrAO2tCZFYoADt0cEvs
 n5mMBmCNFnf3w==
Date: Tue, 13 Oct 2026 09:37:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Shawn Guo <shengchao.guo@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>, 
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Subject: Re: [PATCH v2 01/13] dt-bindings: phy: qcom,edp-phy: Add DP PHY
 compatible for Nord
Message-ID: <20261013-vanilla-chimera-of-rain-efb58c@quoll>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
 <20261012-nord-drv-dt-v2-1-a2ab9af954d2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261012-nord-drv-dt-v2-1-a2ab9af954d2@oss.qualcomm.com>
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

On Mon, Oct 12, 2026 at 07:02:11PM +0530, Nabige Aala wrote:
> From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> 
> Nord relocates several PHY/QSERDES registers relative to existing
> SoCs, so it cannot reuse an existing compatible. Add qcom,nord-dp-phy
> to the compatible list. Nord also needs a dedicated ref clock besides
> aux and cfg_ahb, so add it to the allOf condition that requires
> three clocks (aux, cfg_ahb, ref).
> 
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

