Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327EFCA5FAB
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 03:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BAB010EC6B;
	Tue, 29 Sep 2026 03:15:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HpQ0GK/8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3DBE10E8EC;
 Tue, 29 Sep 2026 03:15:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C193160008;
 Tue, 29 Sep 2026 03:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C651F0089A;
 Tue, 29 Sep 2026 03:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790651736;
 bh=GEzguwRwS5syEr0Yxmm+GQnv6aaJs8GgD9MsaAoQHBg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HpQ0GK/8d/QvKuFU/nBtDeA9xjw23kf/uDawHrGn/uGDLHBqKWS/NS7yjwyiZ64GL
 jp00DotUa7CoBk5sx72TLJy2ENnLJbUqBSbnHlQmGI+uv2kSjl/GAeKz/Vr8I+9Jtj
 M9p9FJ4x5nFxi1QtwvfxcC62xidICkvvpc2OGpucUeKIP0oSM6WUuJXQEKz+KCNa1g
 gcMspOIM9UIaEi73imVs8KsammtA+lZxXsZO8M4fwlrlVGJUUtjgI6Axb0DT9QAWPZ
 aGumbfW5qgWNJSuzieaFyl9e45K0k3FKRx2DtqTStThA3zuTHg9oSjWmy3GAFPhzAV
 /uY6Zs4faPCSw==
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
 Conor Dooley <conor+dt@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Subject: Re: (subset) [PATCH 0/6] drm/msm: Support for Adreno 830 GPU
Date: Mon, 28 Sep 2026 22:14:37 -0500
Message-ID: <179065170939.2673486.13753100445228009486.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260809-pakala-gpu-v1-0-207ad1fac1c7@oss.qualcomm.com>
References: <20260809-pakala-gpu-v1-0-207ad1fac1c7@oss.qualcomm.com>
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


On Sun, 09 Aug 2026 01:53:07 +0530, Akhil P Oommen wrote:
> This series add support for Adreno 830 GPU present in Snapdragon SM8750
> chipset, which is almost 2 yr old now. Adreno 830 is the first GPU in
> AdrenoeA8xx family [1]. So, architecturally A830 is very close to A840 GPU,
> so we just need to add a catalog entry to describe the GPU along with the
> necessary register lists. Both Mesa support and firmwares at
> linux-firmware repo are already available. Mesa needs a correction to
> the chipid value which will be fixed soon.
> 
> [...]

Applied, thanks!

[3/6] arm64: dts: qcom: sm8750: Add GPU and GMU nodes
      commit: 9e39531ce39a98a77ddcf58f838a50dbf164092c
[4/6] arm64: dts: qcom: sm8750: Add GPU cooling
      commit: c4dc1775c7723e9ed1ff74b649fe72d8aa741eb1
[5/6] arm64: dts: qcom: sm8750-mtp: Enable Adreno 830 GPU
      commit: d5eee07a7818e9e65b21d61ef622cd517ab49ddf
[6/6] arm64: dts: qcom: sm8750-qrd: Enable Adreno 830 GPU
      commit: c9cf34cb19f87cd0637a9f1aecd46640c19d76ca

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
