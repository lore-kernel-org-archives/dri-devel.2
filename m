Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF367C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 20:58:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F235210E252;
	Sun,  5 Jul 2026 20:58:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eaUmDhZB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE50810E251;
 Sun,  5 Jul 2026 20:58:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6003A61383;
 Sun,  5 Jul 2026 20:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECE61F00A3D;
 Sun,  5 Jul 2026 20:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783285111;
 bh=kvF20U9p4jLz7Do8a9oYX/KULoHc0Sp1lSPWWya2vuE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eaUmDhZBaFxjd09zhY3+FDSq+Px7XMxuZNvbEsF+vxHT/5hhHbqX2NAMXqtwZ9TEq
 dOa/9LYLOPHKBtkow15dehRwO5Eih/iEc+qnH8Eghsd69dpc3GFReQ0wiq5LNSLP0r
 kMSWIXfpzcE6I8Yr8wfNtXE3uLLSU9TveuPnCfDP0I4W4+xwD1yuZFBT5NQnquWd/F
 7/HaZknHK4/rn5EaBCBNkbOoKXhCcKR4bRiY0UWTz9KRF5j6cM6+tdD47bCKo02S8m
 +2omtd7EOZGi0FhEm324lZLKYt0hu8e7uvH9v8aodtNuBVEx/tpXIOZ5P+gyO6Wz/x
 5f/dPx4zm6iig==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jonathan Marek <jonathan@marek.ca>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexander Koskovich <akoskovich@pm.me>,
 Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v3 0/9] MDSS / DPU bringup for Milos
Date: Sun,  5 Jul 2026 15:58:04 -0500
Message-ID: <178328508279.1157743.6279460557736699887.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501-milos-mdss-v3-0-58bfc58c0e13@fairphone.com>
References: <20260501-milos-mdss-v3-0-58bfc58c0e13@fairphone.com>
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


On Fri, 01 May 2026 09:14:42 +0200, Luca Weiss wrote:
> This series adds display support for the Milos SoC.
> 
> This is tested on the Fairphone (Gen. 6) using the SM7635 SoC (8bit DSC
> cmd mode), and the Nothing Phone (3a) has also been reported to work by
> Alexander Koskovich.
> 
> The panel driver for Fairphone (Gen. 6) and devicetree enablement will
> be sent later.
> 
> [...]

Applied, thanks!

[5/9] soc: qcom: ubwc: Add config for Milos
      commit: 889ee1f4f6633f8300500b529518d30bec282762

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
