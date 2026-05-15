Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331DECD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 08:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 727EA10F493;
	Fri, 15 May 2026 08:41:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oRN7HuI8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A40CB10F48F;
 Fri, 15 May 2026 08:41:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 64CB04098E;
 Fri, 15 May 2026 08:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA76C2BCB0;
 Fri, 15 May 2026 08:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778834501;
 bh=aY+I/LTAujFm+hDwZi1iHm/T2SvWphqZsDt1Qu4o7K8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oRN7HuI8F/a/wkF5ZQMN+bjdRzVs5CGPHU28vmycUxBHRi/o+yl6mzyI7K0EaOrbX
 xcqkcorF1nR5zCVz2nEy4IEle+hQKtJEtG22BbgZBL+T+HiK8rjGkkpr0fQppTStLD
 HXLweRFTks+nwQw6i4PpMGjjn5IbfUGRQptc+wYTKY45G7/0usy2ppltNfIZ2566bG
 GZtBckNeBuHCwwuAq9BwIuYf6sdiEOPtXlxTBH2VjvavoQQP4GY20nVkB0ygmGZYME
 u4PLo9k2xrvRdiWYOnbc6XEN+gS2scQT9gffMtGvhmuy+qgPpYCe+dyg6/tpj3aEDe
 kfQUR0qQAL2Lg==
Date: Fri, 15 May 2026 10:41:39 +0200
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
Subject: Re: [PATCH 1/8] dt-bindings: arm-smmu: Update the description for
 Kaanapali GPU SMMU
Message-ID: <20260515-reindeer-of-original-skill-cb55a1@quoll>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-1-13e1c07c2050@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260512-kaana-gpu-dt-v1-1-13e1c07c2050@oss.qualcomm.com>
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

On Tue, May 12, 2026 at 03:53:15AM +0530, Akhil P Oommen wrote:
> Extend the sm8750's clock description section to also cover Kaanapali GPU

There is nothing about sm8750 in the diff. Probably you wanted to
document the constraint of clock for Kaapanali Adreno SMMU?

> SMMU since it uses the same single "hlos" vote clock.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Best regards,
Krzysztof

