Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D470CFF5134
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1463210E499;
	Tue,  7 Apr 2026 19:06:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YMnXt+8Z";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8C4C89D7C;
 Tue,  7 Apr 2026 19:06:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4D63F4377D;
 Tue,  7 Apr 2026 19:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9033C116C6;
 Tue,  7 Apr 2026 19:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775588772;
 bh=lPIilq/uq9DXQOmuPLnwo3pM67Y4HykvoJOE43Gkroo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YMnXt+8Z8J/C08cmelJ1UYxDoryXXEvUAmkrIyJD4GXvtpVgxOZ2pq/j4u5HKcRl6
 ocdGJVDzsqtDSP1P5aw9LXfAJ+Lv1L056I//mTRvVvjD8oHzxpK3PE9pHEp/mXIoRo
 2pQI8gwCRh7/3feCmWITTVuZJ9hr3i62ynmWZIEfqJKIBZlHfsDWmTDBVN/AnLPaRB
 UUvFeI2vLTRTzz4Bp4FLvBlxoUSbLwgtlSmNMo5gmUIru95lyioKgmHZZEhsYf38xH
 unWtMKU3TghOrMpIigf/IY4uS/JEzzhygQim9PWQGAkizdvpnckq9fO4miM52Gj2Sy
 yZxiXc6Mj6XFQ==
Date: Tue, 7 Apr 2026 14:06:10 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: freedreno@lists.freedesktop.org, Alexander Koskovich <akoskovich@pm.me>,
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, Sean Paul <sean@poorly.run>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, David Airlie <airlied@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 phone-devel@vger.kernel.org, Dmitry Baryshkov <lumag@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org,
 ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
 Jonathan Marek <jonathan@marek.ca>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 linux-arm-msm@vger.kernel.org, Simona Vetter <simona@ffwll.ch>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v2 1/9] dt-bindings: display: msm-dsi-phy-7nm: document
 the Milos DSI PHY
Message-ID: <177558876975.3405237.15393961747581849793.robh@kernel.org>
References: <20260327-milos-mdss-v2-0-bc586683f5ca@fairphone.com>
 <20260327-milos-mdss-v2-1-bc586683f5ca@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327-milos-mdss-v2-1-bc586683f5ca@fairphone.com>
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


On Fri, 27 Mar 2026 17:12:20 +0100, Luca Weiss wrote:
> Document the DSI PHY on the Milos Platform.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

