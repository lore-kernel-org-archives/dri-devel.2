Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983AAC43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 03:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC97A10EB40;
	Tue,  7 Jul 2026 03:21:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PlW6VQ0M";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F01610E418;
 Tue,  7 Jul 2026 03:21:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 968EE600FF;
 Tue,  7 Jul 2026 03:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41F11F00AC4;
 Tue,  7 Jul 2026 03:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783394514;
 bh=Zo1j0X41TZWp7MtLyzXFSkH33VUbHq8e3f9IeM67dbk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PlW6VQ0M7FupS+br9H0ybJVae1YSHbmCRGg4BEyZWHYtESvldaSiEgAbvlemt7PeX
 5908NFLrwB3VJouDd8u4cNunOL2ViQDmEtHq7GsNjoic3b+ScSNzR60M7ph2BmEdwc
 tARa4R5dU8P2R2ZlPSeKPBVRo9+fAzS0i/YyZzoVgdVOcnGcXEBBqU5eW/Ne20rZ/H
 n6Ar8V7LNH6FjkS2MGw5YW657mtp/4jOe3kD9qOnl3UZwsYS2lRyGCJX/xiFIk8F6L
 Arz4DcZQyy1AiCNvjKzwwTd8SQAEuSa5EA/Wm694mKzKcOBBh7aG+ILpVI8vkHhqst
 cCPKEM/DWhkgg==
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
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/8] qcom: display / dts: Few corrections of
 address spaces.
Date: Mon,  6 Jul 2026 22:21:28 -0500
Message-ID: <178339449937.1938770.7041355905157380217.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260405-dts-qcom-display-regs-v2-0-34f4024c65dc@oss.qualcomm.com>
References: <20260405-dts-qcom-display-regs-v2-0-34f4024c65dc@oss.qualcomm.com>
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


On Sun, 05 Apr 2026 16:33:56 +0200, Krzysztof Kozlowski wrote:
> Changes in v2:
> - Patch #2: Add dai-common.yaml reference (Dmitry)
> - Correct subject
> - Rb tags
> - Re-order Eliza bindings patch
> - Link to v1: https://patch.msgid.link/20260402-dts-qcom-display-regs-v1-0-daa54ab448a3@oss.qualcomm.com
> 
> [...]

Applied, thanks!

[8/8] arm64: dts: qcom: sm8750: Correct DPU VBIF address space size
      commit: 4fd832d6aed496c7111746d2c1e36b006659f89d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
