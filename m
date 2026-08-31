Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAB9C61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 20:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDC0F10EA32;
	Mon, 31 Aug 2026 20:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vz0HbuCD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AA4610EA32;
 Mon, 31 Aug 2026 20:21:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 732AD602CE;
 Mon, 31 Aug 2026 20:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CF81F00A3D;
 Mon, 31 Aug 2026 20:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788207694;
 bh=l2JpYiqPXr/ethYzM1+1gzuYbq5aiDfKpOFymITEWkA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Vz0HbuCDz6jTkAyyRbApRPlGU1s/AldD7YaBTRnpX1KQrE0stbO/DlScr6GSjFJgr
 U6EhF8VT2vWle8IXFm3LDARun45i1svx/fFdObVYQotH32cxe3ymAbbM6PtKjzLW5h
 W+F6y7MM6z+LcproWjYSOOmvNrWVVWO1/uFfW1NLfP1x+roC7dOrM9GWl9KJnyYk1v
 q+opEN3dxMXKfhbiAI+J8FpRXZmHmRnZkKCXAq6ZCmZzzL2MbMatowtcYnBphmjzc8
 ZjHzaldm0txts3epxaHDsDTi0gL6tB7nUwy7Oq6yaB1C7z7MVjLujX5O/VtuwPuxfD
 HNzlWkrRhuxZg==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/9] drm/msm: Support for Eliza GPU
Date: Mon, 31 Aug 2026 15:21:12 -0500
Message-ID: <178820768658.1699313.7616803665464814803.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
References: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
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


On Sat, 18 Jul 2026 02:11:25 +0530, Akhil P Oommen wrote:
> Adreno 722 found in Eliza chipset belongs to the A7x Gen1 family. It is
> derived from A730 and shares the same IP-level configurations: HWCG
> registers, protected registers, GBIF CX registers and gmu_cgc_mode.
> Major differences include smaller cache/core counts, 1MB GMEM, no
> Concurrent Binning & LPAC support. Some of the peripheral blocks like
> RSCC are from A740 that resulted in updates to RSC layout.
> 
> [...]

Applied, thanks!

[6/9] arm64: dts: qcom: eliza: Add GPU SMMU node
      commit: 0cb81794dea5b236122578bd49e3e6bfdc6adf87
[7/9] arm64: dts: qcom: eliza: Add GPU nodes
      commit: 5cc169156d877a4aa947092dd3c9dbd784d62f93
[8/9] arm64: dts: qcom: eliza: Add GPU cooling
      commit: c53d30b2814e0f0215cdafe9ccf691eace2949ff
[9/9] arm64: dts: qcom: eliza-mtp: Enable Adreno A722 GPU
      commit: 864e8d024df64433f9916c72411c92157dd4ca53

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
