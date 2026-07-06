Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E2BC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 06:36:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFAEB10E75D;
	Mon,  6 Jul 2026 06:36:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ljqRKau9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 208AA10E2F3;
 Mon,  6 Jul 2026 06:36:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AD46C4081D;
 Mon,  6 Jul 2026 06:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7465C1F000E9;
 Mon,  6 Jul 2026 06:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783319816;
 bh=DgG06+fPhBUefxG+g15sZ2YExh0h/ruMjb8SnPH6H+g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ljqRKau9DCFpA3AklvnxUyEXQF+DlQ4bo0jmiHb9FTBi0BiNyfJlYGIAoZKmmV1Rd
 78hccCK9z0lFtUb2/08OsSZNR/Pi5+h/5rLi1hpnrxlMtDgVjOjbPjDIdKLjtaahIU
 GpIZyvi3nllQMc/bgvupFzCbkdpIl9wlgqyHvtWeh4fqfkOquRJ8EGp/Qvwgl4xxzu
 3O5NWIkBJzsu+bWpTPQjhXAa8IUEwO5O2xHAy4S52J3Ys0V/u29PSPLAcMu2RPUsyE
 EwyFBcFZXGkNSl6z7c/nlw8dmQ40+1esWLB8jmB4ETd0kbE9QCw+0B30vYu34Ozvdf
 2NdYKatgV9IWQ==
Date: Mon, 6 Jul 2026 08:36:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sean Paul <sean@poorly.run>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/8] dt-bindings: display/msm: gpu: Document Adreno 840
Message-ID: <20260706-radiant-shark-of-calibration-ac2d13@quoll>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
 <20260705-kaana-gpu-dt-v2-2-6ac53de56314@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260705-kaana-gpu-dt-v2-2-6ac53de56314@oss.qualcomm.com>
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

On Sun, Jul 05, 2026 at 01:30:06PM +0530, Akhil P Oommen wrote:
> Adreno 840 GPU found in Kaanapali chipsets belongs to the A8x family.
> It is a new IP which features the new slice architecture with 3 slices,
> raytracing support, and the highest GMEM size seen so far on a Snapdragon
> mobile chipsets. Update the dt bindings documentation to describe this GPU.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/display/msm/gpu.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

