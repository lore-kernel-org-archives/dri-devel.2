Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB64CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 09:35:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 055D710E47D;
	Tue, 26 May 2026 09:35:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="egD0gI8m";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDA9B10E05E;
 Tue, 26 May 2026 09:35:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8D1CB42DBD;
 Tue, 26 May 2026 09:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888DF1F000E9;
 Tue, 26 May 2026 09:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779788121;
 bh=VjdWwVx11B2owiNtlnnBG9aofooAg//Wrod2Av6nBG8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=egD0gI8mZv2jT9ujrJ9anIMvv+1CV1hP6ANO/zRmq6fQ2wKAI9X0QMGV5P6egYKg9
 1W8b7nzX6SDVAf/5iqO1i17Jfo4BB0CpzbSmXwsnIsi5p58610OYLKm5jI4CFUQbF3
 +55rvCNp4969GbA7dLZpnoTW0ID77SlOpgqlOYKtnQxE0rUh3FeisVAxMJUc1u2ux1
 7rZp0+RJdBzrsnjqzidM4GNrUnLVLIYztZ9Cz8GL3BPPr8RHNIjxJ0EIk+c1Jg64Uo
 dWgX7ns6kcgWk9KJxXSQQl0iD6scdU5SxrH5MDWt8m2f9vMbI114PBNqHUrIDHV59d
 BDXURAugAf/Yw==
Date: Tue, 26 May 2026 11:35:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH v5 2/5] dt-bindings: display/msm: gpu: Document Adreno
 X2-185
Message-ID: <20260526-cheerful-classic-grouse-bc3d60@quoll>
References: <20260522-glymur-gpu-dt-v5-0-562c406b210c@oss.qualcomm.com>
 <20260522-glymur-gpu-dt-v5-2-562c406b210c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260522-glymur-gpu-dt-v5-2-562c406b210c@oss.qualcomm.com>
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

On Fri, May 22, 2026 at 03:41:58PM +0530, Akhil P Oommen wrote:
> Adreno X2-185 GPU found in Glymur chipsets belongs to the A8x family.
> It features a new slice architecture with 4 slices, significantly higher
> bandwidth throughput compared to mobile counterparts, raytracing support,
> and the highest GPU Fmax seen so far on an Adreno GPU (1850 Mhz), among
> other improvements. Update the dt bindings documentation to describe this
> GPU.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/display/msm/gpu.yaml | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

