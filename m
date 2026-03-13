Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1976D107BCE2
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 21:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35CDD10EBA4;
	Fri, 13 Mar 2026 21:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L0CbYZTt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D906210EBA4;
 Fri, 13 Mar 2026 21:54:30 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F6624447D;
 Fri, 13 Mar 2026 21:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493F9C19421;
 Fri, 13 Mar 2026 21:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773438870;
 bh=c9fnUiG/AbnP2qanxxG12d19at+kYpDMVVkqjlSyvuM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L0CbYZTtkkHmx308AVBrbymS0KdJc5zvVcaZgXr5bwBJ3oHFpDp4F9ek786W+L2WN
 Hj5I3qiPZ2CNW47o9W7Hr539VMKPDqu+ThpIfJaOCq5ofebgBL5G0hp0mqDZg/3hIP
 ekcqVuvMsQpyZo6goqREuYM51nU0SVPnF/H0lQl0NCXIeMzKcpSCyn0gMUAQjtpJJL
 jRq8B/tXraNs91dY2bV7rg0MmqddqNgKpj+9s5pNxvn0BNHALD/9Wf8HCJ3dV1G061
 gAC+NcwbJ/ZlAzB97rVZltk9ScbKkl/AMmAWmXu+yUeOcyE3hHfMNNrJgYdoF0oS9G
 y7BYYe3TXc7Gg==
Date: Fri, 13 Mar 2026 16:54:29 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Simona Vetter <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, freedreno@lists.freedesktop.org,
 Sean Paul <sean@poorly.run>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] dt-bindings: display/msm/gpu: Drop redundant
 reg-names in one if:then:
Message-ID: <177343886847.3412788.12364118148298803763.robh@kernel.org>
References: <20260301142033.88851-2-krzysztof.kozlowski@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301142033.88851-2-krzysztof.kozlowski@oss.qualcomm.com>
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


On Sun, 01 Mar 2026 15:20:34 +0100, Krzysztof Kozlowski wrote:
> Top-level reg-names defines already proper order for "reg-names" with
> minItems: 1, so no need to repeat it again in one of "if:then:" cases.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---
> 
> Changes in v2:
> 1. Rebase
> ---
>  Documentation/devicetree/bindings/display/msm/gpu.yaml | 7 -------
>  1 file changed, 7 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

