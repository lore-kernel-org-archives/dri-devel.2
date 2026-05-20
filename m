Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562A3CD5BA4
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 16:40:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7797F10E1F6;
	Wed, 20 May 2026 16:40:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XbVkFlg+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 713BC10E377
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:40:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 37980445CC;
 Wed, 20 May 2026 16:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 153E2C2BCFF;
 Wed, 20 May 2026 16:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779295242;
 bh=MyekTXthbD77XbAAilufOkHi42iN9IphYUU9ktVwJcM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=XbVkFlg+Ax/Scz2iA8PTbPWoC1HZnoXuGyZLdJHZjtqdI70vkq8jppocBN85035aB
 tEf+Bl3EaTfRxihMxxa79GuYJ3E87ExgDb3Da3N/D2ko4gg0PElJ9fteMjykI4ZMtj
 HETVYgS+o1rROPNdk79lHuDFQUv5sHnvADYIYrTJJ40YqzcHhSpm6PdlgbEOvVNEw5
 OAdDVdfj9NkrLvUm46gpaKksqbbBKLYC1JLObaQymBejEe0zE5BCb1RdP1I0VXeX2e
 aKqaBH+aHAyJWvhvX+44oqoFyh7ijDCnceQd/T4ebmOMPQEt9ABnfKBrlt5ULt2GdE
 BP3oQjquAZaUw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 05A6CCD4F3C;
 Wed, 20 May 2026 16:40:42 +0000 (UTC)
From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne_via_B4_Relay?=
 <devnull+jerome.debretagne.gmail.com@kernel.org>
Date: Wed, 20 May 2026 18:40:08 +0200
Subject: [PATCH 04/11] arm64: dts: qcom: sc8280xp-arcata: add USB-C
 orientation GPIOs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260520-surface-sp9-5g-for-next-v1-4-9df52552bf87@gmail.com>
References: <20260520-surface-sp9-5g-for-next-v1-0-9df52552bf87@gmail.com>
In-Reply-To: <20260520-surface-sp9-5g-for-next-v1-0-9df52552bf87@gmail.com>
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779295238; l=901;
 i=jerome.debretagne@gmail.com; s=20260520; h=from:subject:message-id;
 bh=OCnS+HjzBDa6iYYkNDmwKoF2GY8YnhPkJ574zoElZT8=;
 b=dYr8V+M6VjVVKDNeSUyd5gbt1Y0kPZPTcYrZhl4EbeFe+Xej59AGvGTYxnmSdW829SB6NT2DV
 THeXK6yf8prAazQS2BexcN1jEEvy9tQ5sdSUYLBqeGxk+qJZqzrpdj9
X-Developer-Key: i=jerome.debretagne@gmail.com; a=ed25519;
 pk=3/JYhgYjGg5V9mlFxc0A0+pFiyjsuDB/TtDlNMId9fk=
X-Endpoint-Received: by B4 Relay for jerome.debretagne@gmail.com/20260520
 with auth_id=785
X-Original-From: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?=
 <jerome.debretagne@gmail.com>
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
Reply-To: jerome.debretagne@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Jérôme de Bretagne <jerome.debretagne@gmail.com>

Define the USB-C orientation GPIOs so that the USB-C ports orientation
is known without having to resort to the alt mode notifications.

Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
index 7f1cc1899002529b7ac7340974c99f6ed493d410..49c0ecfc6c055ef2cd85db022d9340ecb88b7fc4 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
@@ -61,6 +61,8 @@ pmic-glink {
 
 		#address-cells = <1>;
 		#size-cells = <0>;
+		orientation-gpios = <&tlmm 166 GPIO_ACTIVE_HIGH>,
+				    <&tlmm 49 GPIO_ACTIVE_HIGH>;
 
 		/* Left-side top port */
 		connector@0 {

-- 
2.47.3


