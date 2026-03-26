Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2BB109E543
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 03:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB73710E248;
	Thu, 26 Mar 2026 03:19:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iRkfdznG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B4D310E248;
 Thu, 26 Mar 2026 03:19:46 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8AE9A60121;
 Thu, 26 Mar 2026 03:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DC9C2BCB3;
 Thu, 26 Mar 2026 03:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774495185;
 bh=t2XUoSvh89kqrOozKJYUzWgw4+PCXIyw3r8zSeuwVMU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iRkfdznG7zqPyad0uVzudin6FHRv7An47mVUdEZ/FvQ2qBaSkWeEZ+7aFbC5EDmgy
 B/RuLfd+kOCT6Ovk0Jbqnwb3V3j2fFjMscgqHDeVX4v/DQF8RtUZH7z2Kp45ou/OFw
 9asb0Jjg28yeEVw8k29Ad6JGVM1+rFDCQQgE29aeUoc6E2V0zG7HK8dk/KqU5DBBqH
 8QQMOSuqh3qlfmkX7XGHgZd1hol8zb51ltmFBx+0F7nYJ+OXl3m7GdllpX3xVV+k2A
 7C37dfe4qDHfynu53twSeYAGA2wqyISgTBDSQVwh3BE/YqFwWdUpk1yBLsWeDr7zTy
 NM3+XZ1pVIM9Q==
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
 Jonathan Marek <jonathan@marek.ca>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v3 0/8] drm/msm: Add Qualcomm Eliza SoC support
Date: Wed, 25 Mar 2026 22:19:25 -0500
Message-ID: <177449516604.60308.13612221686206008609.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325-drm-display-eliza-v3-0-dc2b2f0c74a2@oss.qualcomm.com>
References: <20260325-drm-display-eliza-v3-0-dc2b2f0c74a2@oss.qualcomm.com>
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


On Wed, 25 Mar 2026 13:16:41 +0100, Krzysztof Kozlowski wrote:
> Changes in v3:
> - Re-order soc/ubwc patch to be last in the series. Maybe it should be
>   sent separately?
>   Use defines for .ubwc_swizzle value
> - Tags
> - Link to v2: https://patch.msgid.link/20260304-drm-display-eliza-v2-0-ea0579f62358@oss.qualcomm.com
> 
> [...]

Applied, thanks!

[8/8] soc: qcom: ubwc: Add configuration Eliza SoC
      commit: 9a116af73a3c90cbfc78d6b007325539056f83be

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
