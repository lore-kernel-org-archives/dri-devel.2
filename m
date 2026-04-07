Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F98FF5136
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3C1110E4A4;
	Tue,  7 Apr 2026 19:07:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Lux9qAf4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFD5110E00B;
 Tue,  7 Apr 2026 19:07:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 28F4E600CB;
 Tue,  7 Apr 2026 19:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3199C116C6;
 Tue,  7 Apr 2026 19:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775588830;
 bh=G6An/J/iBgbRqFjJ9i8aQHvrnf5qvpyoY+B082y2Iu0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Lux9qAf4H+3WFaQZ01EoN5GG+mbRCLw3mih5kqISHaUXRzBE2hV69y6P3A1J3Ro22
 SWvxjMLkC/1xKKCjPHQwW6biHgys0curqZ2zcZX4SghRp/RWrLxQrCdJ9Yj6aG8PQb
 i9dBz1AQVDvtIucQ6vs31mq9io4k0V+D2ySkJKBHj381tFVdOMuNnspw9AIjrQm41H
 3VOcRtDDIcJB1NkTdHhMFZjjpg4f/E/XKbBro9CMzt16Vkh4ZhBq+eBNogsT6qIcjJ
 o5hjaEJGksnGG22kFsyaNZ7111K7X4CvcJ04DjvV9WZYDn+XJ/V53H1g0mbPNNEFw7
 NECFKlqvd9ZAw==
Date: Tue, 7 Apr 2026 14:07:07 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Alexander Koskovich <akoskovich@pm.me>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 ~postmarketos/upstreaming@lists.sr.ht,
 Rob Clark <robin.clark@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Dmitry Baryshkov <lumag@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Marek <jonathan@marek.ca>, phone-devel@vger.kernel.org,
 Jessica Zhang <jesszhan0024@gmail.com>,
 freedreno@lists.freedesktop.org, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 3/9] dt-bindings: display: msm: document the Milos DPU
Message-ID: <177558882669.3409524.8504183460631288519.robh@kernel.org>
References: <20260327-milos-mdss-v2-0-bc586683f5ca@fairphone.com>
 <20260327-milos-mdss-v2-3-bc586683f5ca@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327-milos-mdss-v2-3-bc586683f5ca@fairphone.com>
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


On Fri, 27 Mar 2026 17:12:22 +0100, Luca Weiss wrote:
> Document the DPU Display Controller on the Milos Platform.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

