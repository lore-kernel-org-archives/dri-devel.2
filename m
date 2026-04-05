Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF35E9D80D
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 19:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCEEE10E1CC;
	Sun,  5 Apr 2026 19:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rF0dD1rS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3E3310E1C3;
 Sun,  5 Apr 2026 19:40:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 88077444DB;
 Sun,  5 Apr 2026 19:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C77C2BCB2;
 Sun,  5 Apr 2026 19:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775418035;
 bh=bcdQYL7EhIubI8NIAgWhB6Nh2elJGgYkYt6pP5PNL98=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rF0dD1rSP88l0Jz43uWE8BQE5UP+D+g6ojP+WNEN7jnSIffvpCLEuKZQ+7SBQx6tE
 NlZqAE94CvD2NwcVwOWaAByzywhz+hcgUmUpFX8yBCaTDipPePNXtj/acjxnorlhse
 j5S/Nx1Hx7qnvI7dsmAw2sCyIQ/IzFbcri6wcrwF1Ht38PhnauyqyRLJEJ9AjKOKKV
 jp3Ji2lnxWofCTM0pSR6CJsnLHcOCFnnhiWzom8wilua79cA5Rm1tMwma4+vmtjaEu
 GQthC34LAMA+Q9TDX5Bs6nvd0rzSlJfVTHyjkgVJN5xM+lZ/S/UOXhYD7OseIeDK1J
 zTT8eIF3pXZag==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Qingqing Zhou <quic_qqzhou@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Jie Zhang <quic_jiezh@quicinc.com>
Subject: Re: [PATCH v8 0/4] Support for Adreno 612 GPU - Respin
Date: Sun,  5 Apr 2026 14:40:15 -0500
Message-ID: <177541802143.2061229.3144892197628318346.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312-qcs615-spin-2-v8-0-fca38edcd6e6@oss.qualcomm.com>
References: <20260312-qcs615-spin-2-v8-0-fca38edcd6e6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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


On Thu, 12 Mar 2026 04:39:52 +0530, Akhil P Oommen wrote:
> This is a respin of an old series [1] that aimed to add support for
> Adreno 612 GPU found in SM6150/QCS615 chipsets. In this version, we
> have consolidated the previously separate series for DT and driver
> support, along with some significant rework.
> 
> Regarding A612 GPU, it falls under ADRENO_6XX_GEN1 family and is a cut
> down version of A615 GPU. A612 has a new IP called Reduced Graphics
> Management Unit or RGMU, a small state machine which helps to toggle
> GX GDSC (connected to CX rail) to implement the IFPC feature. Unlike a
> full-fledged GMU, the RGMU does not support features such as clock
> control, resource voting via RPMh, HFI etc. Therefore, we require linux
> clock driver support similar to gmu-wrapper implementations to control
> gpu core clock and GX GDSC.
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: talos: add the GPU SMMU node
      commit: 1d5c82f19b8a079767622191fa7478028a6ce79f
[2/4] arm64: dts: qcom: talos: Add gpu and rgmu nodes
      commit: 8de397a5618aaea810e447946a1f1d19c610fdc2
[3/4] arm64: dts: qcom: talos: Add GPU cooling
      commit: a74c7b347d7e1094bf16e5053889c9ba4d9a3ac5
[4/4] arm64: dts: qcom: qcs615-ride: Enable Adreno 612 GPU
      commit: ed5ee207bc075d774ecc837acc90d02548cd5061

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
