Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE130C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 01:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2B3610EB0C;
	Tue,  7 Jul 2026 01:27:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Nd+wdKUb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83C6E10EB0C
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 01:27:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 45CF242D71;
 Tue,  7 Jul 2026 01:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2071F000E9;
 Tue,  7 Jul 2026 01:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783387655;
 bh=qrbkX+9fvGFaLJTswN/I4VkgkW7XZkbl1Qznf9Y2JYA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Nd+wdKUbAdvVUElbXw0FTEDbiLRbuIfXNwnRMhwsQDAGqdMzlG4X+fQI82kUI+0PG
 8++DIAE9jfMGhVjCjpG+ZYK7Xc9FTVfNwdNEDNeksfpbK9rnO4CKBYGBKfhpPXMPLg
 H39mYSteYhg9kdkyy1ZUoSuNdn6wAyxaIbXh2KXWuFI0rXqG+o9FPZhSydjFSzhl9X
 GEPGm1gWTLSS5T/KnLJnm7E3eB/hQMvfryfjVpJFofJCMNoHza3BqB0LL4I7VatNkE
 nV54wV3GNq4wpk7/s5jws7biDk6RxmCQzCU3Oprm4/x0BAVYvSEMVsk7t065/Zu0WR
 0SOqsPU8lEVSg==
From: Bjorn Andersson <andersson@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Cristian Cozzolino <cristian_ci@protonmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v5 0/6] Enable new features for flipkart-rimob
Date: Mon,  6 Jul 2026 20:27:17 -0500
Message-ID: <178338764566.1558388.6463068099121810198.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331-rimob-new-features-v5-0-5fcf42a29c12@protonmail.com>
References: <20260331-rimob-new-features-v5-0-5fcf42a29c12@protonmail.com>
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


On Tue, 31 Mar 2026 11:47:08 +0200, Cristian Cozzolino wrote:
> This series enables a set of miscellaneous features for Billion Capture+
> (a handset using the MSM8953 SoC released in 2017):
> - Panel and GPU
> - Touchscreen
> - WiFi + Bluetooth
> - Hall sensor
> 
> [...]

Applied, thanks!

[3/6] arm64: dts: qcom: msm8953-flipkart-rimob: Enable display and GPU
      commit: a8c0bd4233a9612f200a27f535b66e71eec289a6
[4/6] arm64: dts: qcom: msm8953-flipkart-rimob: Enable WiFi/Bluetooth
      commit: 15c3536da9227b5850b566f48b2135a7ecc8faf2
[5/6] arm64: dts: qcom: msm8953-flipkart-rimob: Enable touchscreen
      commit: 74a12ff179901fcec9217ead7d2be368ddff0dd1
[6/6] arm64: dts: qcom: msm8953-flipkart-rimob: Enable Hall sensor
      commit: 349ba5a82f0c9f4cfd817dd961e57a545977a66d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
