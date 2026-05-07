Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90D7CD37AC
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 20:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 508BD10F274;
	Thu,  7 May 2026 20:35:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JzUU5UXX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA6A610F274
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 20:35:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C1E8F40304;
 Thu,  7 May 2026 20:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3906C2BCC9;
 Thu,  7 May 2026 20:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778186121;
 bh=pFaClC15A5h5LUxiUTMKOYJdhEY+xd8nzrtmaKHEWUo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JzUU5UXX5wSYlnNfXgszAc7TvILW8ETeeN811kNIK3vF65q1U793fpkIVRO34Pd6I
 uC57JzslFIOWalDcCds0tLSp0ubSVOnQyEMz5nHrTQvU7lhKm8lThuySUmRykCq7L0
 /OE4SsxzRBAHdUyV5Qy8OO2m5yigCCCWdj9p3zmErFwf5DnRgmD0nG7oaWgGXVoCOR
 4arC3RntCzbV2VFTi0ksRhPpfkpKbdlDjsd21+WqvN/MFSOKx24dF2gteqoNeOhUUL
 C/S7zzdiYijWbuk9n+2+2nNww6N+xYnfW+T8NQN16lmSaDxQn95sGmG9Ls4138q6OM
 W9rON2FdbJjLw==
From: Bjorn Andersson <andersson@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?q?Kamil=20Go=C5=82da?= <kamil.golda@protonmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Yedaya Katsman <yedaya.ka@gmail.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v4 0/3] Add support for the Samsung S6E8FCO DSI
 and M1906F9 display panel
Date: Thu,  7 May 2026 15:34:32 -0500
Message-ID: <177818605997.73000.9692910497119100760.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260314-panel-patches-v4-0-1ecbb2c0c3c8@gmail.com>
References: <20260314-panel-patches-v4-0-1ecbb2c0c3c8@gmail.com>
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


On Sat, 14 Mar 2026 23:46:20 +0200, Yedaya Katsman wrote:
> This adds a driver to support the Samsung S6E8FCO DSI controller with the
> M1906F9 display panel found in Xiaomi Mi A3 (xiaomi-laurel). The driver is
> generated using linux-mdss-dsi-panel-driver-generator[0].
> 
> The mdss reset dependency makes the screen work more reliably.
> 
> [0]: https://github.com/msm8916-mainline/linux-mdss-dsi-panel-driver-generator
> Original tree with patches: https://gitlab.postmarketos.org/SzczurekYT/linux/-/tree/laurel
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: sm6125-xiaomi-laurel-sprout: Enable MDSS and add panel
      commit: 493cb869874cd301c370adf9a3f9577942c4f0f1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
