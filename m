Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2804FC55167
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 21:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8723A10F0B5;
	Thu, 30 Jul 2026 21:52:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Du/ecM7N";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B32910F0B5
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 21:52:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9D27D60254;
 Thu, 30 Jul 2026 21:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2ADD7C2BCFA;
 Thu, 30 Jul 2026 21:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1785448337;
 bh=eal9G28T5whWn85NtRXkvtfPeAVFqFjdK1pHXLc1jvo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Du/ecM7NFfx9SdawEhe+Q9BiOXQ4M9+PWCG5NaVkjmiAbCvYgu2pk2lLajG5ria1h
 Ri1qfLyI7a2QHqfjPL4H17G5hN8qm/1LIyKLbReRBog185OKvO8GtnxcWlUXR4PwiB
 T102EWxLRRL2weZwGflp7k+4r5AmyCD4VYQC/I63aCqqWmPESb/k3SM1/PHvVCOItA
 cnzSnPulWPItvhCVWisqTftVEtSuVJlLgnrN3GznbTSb5b4bt1ulqbuZJLMqaxRKD3
 /UvAxgv4YM9LjcYMoIn4xmgsAkK6ZfoIcLnhkfuu+CuBxrRsWDt8P8X81wQv0ESigV
 m6gC9v3yxSXPQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 1556AC55171;
 Thu, 30 Jul 2026 21:52:17 +0000 (UTC)
From: =?utf-8?q?Dawid_Wr=C3=B3bel_via_B4_Relay?=
 <devnull+me.dawidwrobel.com@kernel.org>
Date: Thu, 30 Jul 2026 23:52:02 +0200
Subject: [PATCH 3/4] arm64: dts: qcom: sm8250-xiaomi-elish: label the WiFi node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260730-sm8250-xiaomi-enuma-v1-3-ed6d8fb99668@dawidwrobel.com>
References: <20260730-sm8250-xiaomi-enuma-v1-0-ed6d8fb99668@dawidwrobel.com>
In-Reply-To: <20260730-sm8250-xiaomi-enuma-v1-0-ed6d8fb99668@dawidwrobel.com>
To: Jianhua Lu <lujianhua000@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 =?utf-8?q?Dawid_Wr=C3=B3bel?= <me@dawidwrobel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=793; i=me@dawidwrobel.com;
 h=from:subject:message-id;
 bh=9PgRYneIZ007uPWyIFA5A8vuFZUckwmPT37f8xhISQU=;
 b=owGbwMvMwCV2qrTGfeXVd28ZT6slMWRlH++/dsorLKNw2Qa7Z4y/HeQ5bl3/+Jv71r1Ta5cXH
 3Nb0OPZ2VHKwiDGxSArpsiilxa0xyr45fd3L36Hw8xhZQIZwsDFKQAT+f+ckWF9ewOLn/J69/6Q
 dGvGj/XXUpek5elkuHc8m7CR8e6XyZkM//12//8+w1bI9taWj1fEo6pz/D/8S+tacsdnYe4chdI
 nBjwA
X-Developer-Key: i=me@dawidwrobel.com; a=openpgp;
 fpr=B64A778E0E64049A70C831C8B7B81FA12B282A92
X-Endpoint-Received: by B4 Relay for me@dawidwrobel.com/default with
 auth_id=901
X-Original-From: =?utf-8?q?Dawid_Wr=C3=B3bel?= <me@dawidwrobel.com>
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
Reply-To: me@dawidwrobel.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Dawid Wróbel <me@dawidwrobel.com>

The Mi Pad 5 Pro 5G shares this device tree but needs its own board data
variant, so give the node a label to allow overriding the property.

Signed-off-by: Dawid Wróbel <me@dawidwrobel.com>
---
 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
index 19aff83ecf7b..12a2ba48340f 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
@@ -817,7 +817,7 @@ &pcie0_phy {
 };
 
 &pcieport0 {
-	wifi@0 {
+	wifi_0: wifi@0 {
 		compatible = "pci17cb,1101";
 		reg = <0x10000 0x0 0x0 0x0 0x0>;
 

-- 
2.55.0


