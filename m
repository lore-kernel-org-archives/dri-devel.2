Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDE6C9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:44:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6763210E8C3;
	Mon, 28 Sep 2026 08:43:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="pBTpT6bH";
	dkim=pass (2048-bit key; secure) header.d=erebion.eu header.i=@erebion.eu header.b="oiJfyf5m";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16A1B10E063
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 10:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Date:Subject:From; t=1790418021; bh=s+3AQyFd+4zTqYgAjaoftBv
 B6wqvJfWSyCWo8CZwX9I=; b=pBTpT6bHi9K4+c36TEuh5wJpemWpfA0FNO1wCPc2q4P6aw0EwR
 2+lcXhUtjlwYgPIgcwAoinxMwqn8/1vTKxBg==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Date:Subject:From; t=1790418021; bh=s+3AQyFd+4zTqYgAjaoftBv
 B6wqvJfWSyCWo8CZwX9I=; b=oiJfyf5mz9Ymx+JnivyQtI/iSIFxt8lOIGsTYUcL8I6fWyZqYB
 Lz6bl8lm6K07CTS8OYInmphreQ5mdAfPOAe0GydV2k4/NHfApZFZe9WHDdfdGMx/++1aT8juK+I
 df4++gS20/mrXInx5orlxF4WkoSM2rAh/n0F4IPSpFyoX2DUXyT4pBfZd3+PWviz8pjx/eZLGfa
 QkHq38u+kruuEvnrPbmXegIGlN6jQi5Q1Y6Z1VHYAOP3aHwCYoNBu/kvh9B1+64B77DgaaMXjVK
 7Qn6cObbfNUNxekoe70SB6FUd63ccRrF3wEW0w6Q1YQKqjn5J6QBpNwoH0fzX2ummjw==;
From: erebion <erebion@erebion.eu>
Subject: [PATCH 0/8] Enable more nodes for the Xperia 10 III
Date: Sat, 26 Sep 2026 12:20:17 +0200
Message-Id: <20260926-pdx213-upstream-3-v1-0-1609c18b5c1d@erebion.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NWw6CMBBFt0Lm2zFtUXlsxfDRx6A1KdQ+CAlh7
 1bx8yTnnrtBpGApQl9tEGix0c5TAX6qQD/l9CC0pjAIJm6sFR16swpeY/YxBZIOazRMtWxsLp2
 6Kig7H2i06695Hw6OWb1Ip2/obwR653KWDg2UjIR6ds6mvlqac41Bcxj2/QOBqRgLoQAAAA==
X-Change-ID: 20260829-pdx213-upstream-3-d0b80f749b5b
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 erebion <erebion@erebion.eu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790418021; l=834;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=sTxpDCM+G0Yq8WpiNk3ug+EjerLzcaGqlhbo/oAYrvI=;
 b=arG2sJxbNpZtpTLVc1Ew+eNITgNYPE40NjLYeJCJP0ULhIjZmB1hBqnvjZHtWtJvhDcL2INaM
 NnMgNqCWYsOCNTyF+yuYaozGqDI4WCdJ93+uhDbnV+5Mf7uTkwI4AOu
X-Developer-Key: i=erebion@erebion.eu; a=ed25519;
 pk=rOCVlR8khmBtCFe4ZlDcbCbIcORxdaNzPDkoIiHM7xc=
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:42 +0000
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

Enable some more nodes for the Xperia 10 III.

Signed-off-by: erebion <erebion@erebion.eu>
---
erebion (8):
      arm64: dts: qcom: sm6350-lena: Add flash LED
      arm64: dts: qcom: sm6350-lena: Add qcom,rmtfs-mem node
      arm64: dts: qcom: sm6350-lena: Enable ADSP, CDSP & MPSS
      arm64: dts: qcom: sm6350-lena: Enable IPA
      arm64: dts: qcom: sm6350-lena: Enable Bluetooth
      arm64: dts: qcom: sm6350-lena: Enable wifi
      arm64: dts: qcom: sm6350-lena: Enable PM7250B
      arm64: dts: qcom: sm6350-lena: Enable PMK8350

 .../dts/qcom/sm6350-sony-xperia-lena-pdx213.dts    | 260 +++++++++++++++++++++
 1 file changed, 260 insertions(+)
---
base-commit: e5e04726cdd043e309677071ab1b65a4b18f422b
change-id: 20260829-pdx213-upstream-3-d0b80f749b5b

Best regards,
--  
erebion <erebion@erebion.eu>

