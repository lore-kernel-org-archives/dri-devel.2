Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DE7C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 14:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3A1F10F15D;
	Wed,  8 Jul 2026 14:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b3BIonws";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EBC310F159;
 Wed,  8 Jul 2026 14:57:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 519554028B;
 Wed,  8 Jul 2026 14:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9E41F00A3E;
 Wed,  8 Jul 2026 14:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783522670;
 bh=0nyjPP7mSe9HiaUk/UAjsc7FDqovQ36jWq3u/Ghh3NU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=b3BIonws6GBU1JlnYzyiZS/8iEvoaxqney15cIDK3RkmmOj4j5bZdMGC5paED25nz
 /2Ri3AWkQsGJecEMUFNXlXujo1tV7DxJ6Lf055izNHe0fPZpLBtfEdpSq3HJjk083p
 dLkrSU+Qs97qjXu5qZNTw0h7FALgy9HRdiVUxVajCLB4rbCZJaGvhJhdyxIIWnIFGm
 App7+l94x6euzXqdRhoZWPaeW6oMqG/g7lGZBrTKbYtXXr8TctkFQ6JB6awqWIltuR
 qd6SGRDYqnxZFD34DyZPLez2qqn0EruDnyEZv5D48zYudajBfv4Gr5jbr1/PtS9UMl
 sohNRmBnfPm8g==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v4 0/2] Add Shikra (QCM2390) display support
Date: Wed,  8 Jul 2026 09:56:50 -0500
Message-ID: <178352261601.2235436.270088747516489288.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608-shikra-display-v4-0-88a846afdd5d@oss.qualcomm.com>
References: <20260608-shikra-display-v4-0-88a846afdd5d@oss.qualcomm.com>
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


On Mon, 08 Jun 2026 12:31:41 +0530, Nabige Aala wrote:
> Shikra (QCM2390) is a Qualcomm SoC based on the QCM2290 family that
> reuses the same MDSS/DPU 6.5 hardware as QCM2290. This series enables
> the display subsystem for Shikra by adding DT binding updates for MDSS,
> DSI controller and DPU and UBWC configuration mapping Shikra to
> qcm2290_data.
> 
> Driver and SMMU support are covered by the existing qcom,qcm2290-mdss
> fallback compatible string — no separate drm/msm or IOMMU patches are
> required.
> 
> [...]

Applied, thanks!

[2/2] soc: qcom: ubwc: Add Shikra UBWC config
      commit: a45af9d6e6175473c8744c0f1cf2348f641e3029

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
