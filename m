Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB441606A33D
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 01:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ihiBjnmR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0223110EACD;
	Tue, 17 Nov 2026 01:05:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CE1910EACB
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 01:05:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E839C44F7B;
 Tue, 17 Nov 2026 01:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4421F000CD;
 Tue, 17 Nov 2026 01:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794877505;
 bh=YxNXRFV2tfHnN9zjEBdLST7EXKRWTkncONoWrmBal2M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ihiBjnmRjKcU2lWBTMOD6ZsOSL23L8g7JtHfDU/jie6aoauMKrFgyB3jCWTlCEb0H
 av/sznex8DjoOG06+ViORXzDpSAxzWglbsD3r1dNrm7ijV6DdQTBnmPpQ3WF1gaepv
 8arGYdTFmp270YLkd3C1vhm++82NEBm06pGWjWnqv5sLIlZSqzc2Q8Td+1yjAWdDFL
 cv9LQB4L4UJmSdPKvdXiFR2wRAvFtYzd4p4g/gpHNrAEDwz1+xtDCiA508cttz459C
 5xYUy/wHOw4WLFNwflwdRGnVIxG60Ja++5yKAzSn1xFnyCzYdgUhjY2orbf8rVKNpJ
 LTTf9qgzJ2Lpg==
From: Bjorn Andersson <andersson@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Abel Vesa <abelvesa@kernel.org>,
 Ulf Hansson <ulfh@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v5 0/5] arm64: dts: qcom: support SDM845 HDK
Date: Mon, 16 Nov 2026 19:04:42 -0600
Message-ID: <179487749311.432567.13731277200090621528.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019-sdm845-hdk-v5-0-4aa7e22cd0ed@oss.qualcomm.com>
References: <20261019-sdm845-hdk-v5-0-4aa7e22cd0ed@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Mon, 19 Oct 2026 12:18:02 +0300, Dmitry Baryshkov wrote:
> Lantronix HDK845 aka Qualcomm SDM845-HDK is a hardware development kit
> for the Qualcomm SDM845 / SDA845 platform. It uses the modem-less
> version of the chip (SDA845) and provides a rich set of the peripherals
> and connectors. The DSI panel is an optional addon, so it is being split
> to a separate overlay. To (hopefully) ease merging, the overlay is split
> to a separate patch as it depends on the panel. The base DT doesn't have
> external dependencies.
> 
> [...]

Applied, thanks!

[4/5] arm64: dts: qcom: add device tree for SDM845-HDK
      commit: 30eb04d28111e83d2ada48f46be2d314e1a47860
[5/5] arm64: dts: qcom: sdm845-hdk: add display card overlay
      commit: e0bcadc233e6f0876eb66130389db9909c831dc3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
