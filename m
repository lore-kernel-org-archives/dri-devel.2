Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C82ACC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E5751122C7;
	Thu, 15 Oct 2026 10:52:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB48E1122C7;
 Thu, 15 Oct 2026 10:52:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E898260120;
 Thu, 15 Oct 2026 10:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156521F000C4;
 Thu, 15 Oct 2026 10:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792061549;
 bh=xC/wmtw3i4A2qkYE5TyAigTML94khyrDMBlobSOJqgU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lpu1v2r0eRW+NRHnHYNntpREb8FMeCzXvUSXWLPRx2DICFS4FVUw0CR1u/6+PzGt+
 Yzl8fxEqDbo8MXZhXaDNuIBJ6JeqVUHk+X9/tHvhPtpVsOOEoTfdpKE4ZeGl0/3D7c
 W52ZmS9sh+GQ3PmXB+jkFg9vC6beXSxsuyoAdrn2azxT22T0+C3B/6RLnG2xLU/qCO
 Xwyu91CPNXWyge0u1YAOun349hIpNU9DILBK/DuEyCDVZinqo/u+YX4ik+1JVKcn4k
 L0/lnaxv+n/8+XgltW01lXWDw/NepkPyzJrVbiS2Du+anuU9FCrp/UOkam0rFCILkY
 9RzfHijUP9llg==
Date: Thu, 15 Oct 2026 12:52:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Philipp Stanner <phasta@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev
Subject: Re: [PATCH 13/13] arm64: dts: qcom: hawi: Add DCP support
Message-ID: <20261015-unstoppable-masterful-wrasse-87dcd4@quoll>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-13-48aad0fe4f72@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015-jshekhar-drm-msm-dcp-v1-v1-13-48aad0fe4f72@oss.qualcomm.com>
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

On Thu, Oct 15, 2026 at 01:08:33PM +0530, Jayant Shekhar wrote:
> diff --git a/arch/arm64/boot/dts/qcom/hawi.dtsi b/arch/arm64/boot/dts/qcom/hawi.dtsi
> index 0926d880cb0c..58fcf42cbaba 100644
> --- a/arch/arm64/boot/dts/qcom/hawi.dtsi
> +++ b/arch/arm64/boot/dts/qcom/hawi.dtsi
> @@ -8235,4 +8235,63 @@ timer {
>  			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
>  			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
>  	};
> +
> +	dcp: virtio@9be8000 {
> +		compatible = "qcom,dcp-virtio", "virtio,mmio";

More slop.

At least you could ask your agent to TEST it. See internal guidelines
how to do it.

Best regards,
Krzysztof

