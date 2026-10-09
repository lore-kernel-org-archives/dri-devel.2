Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFC1CA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:56:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C53C10E759;
	Fri,  9 Oct 2026 07:56:21 +0000 (UTC)
X-Greylist: delayed 16664 seconds by postgrey-1.36 at gabe;
 Fri, 09 Oct 2026 07:56:17 UTC
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71AB510FF44
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 07:56:17 +0000 (UTC)
X-QQ-mid: zesmtpip2t1791532534t173164c0
X-QQ-Originating-IP: BuEVl1c8H95NpE4oXHOC/UUST0zQ5tlQaJLw7XoHYz8=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 Oct 2026 15:55:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5870349108209219683
EX-QQ-RecipientCnt: 32
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 09 Oct 2026 15:55:08 +0800
Subject: [PATCH v2 3/4] dt-bindings: arm: qcom: document Radxa Dragon Q8B
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-q8b-dts-v2-3-eda11e5dea8b@radxa.com>
References: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
In-Reply-To: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>, 
 dragon@radxa.com, Xilin Wu <sophon@radxa.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Daniele Briguglio <hello@superkali.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=sophon@radxa.com;
 h=from:subject:message-id; bh=+V4J4jb5Aj7TY9xO/xX782sZxUDJGWTEX8LeDQ4fkho=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFkn5j678tLO/c7n2Lsx+oaL5/RW9WpUalzP1nHiVMqpn
 el+V1S9o5SFQYyLQVZMkUUhnmEue2XutadipXowc1iZQIYwcHEKwERsHjH89/m89f5x/yg/3i0x
 hjvMLr5bvOD0G/MXy3iPqL7/s8xi9QGGv3LLfKy/brJkmvvkpT5jsu7fgwc33THc09py2uTqOdV
 Pa/gB
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mj4jBrur4Tx6rnpaEtTCFgsTlo757VXqUSL6OCGigeDfxXo+uv1fVSjk
 lArq0otNhV2p0POdyPU6mJP6WmbwyAO//28HG+PUNvsD0lyjIeQGSNfF4P5AkcYDDn7YuFV
 goGih4jLtjJIOWSxrK3smroIIkUnkFtgwcHvbqIZYliyn9IjirjfW1VANNEga1W0TMPQmLJ
 +wrFCCKEjA/rfZTfj4V1kQCt+YpqXScrzDCXiW5tLC11MD2beMxpMaztI70WgDUN6DZaBd0
 gqdzyGu/nINqPH6U/ONOpnhj/gNhXgzWd+Raa8un/uB2Dnl/iErl9wTJE2r6xIysy85uIJt
 M7Hq4+2Zfuyb0NHYYKxXyPVZp8OWOhjJ23LGNQpZj3NZGVU9KmEcWdH3gPJ6iPrquqDpNEW
 s00x9is/loPtyaSfUqkXKJTW8yxNby54dAfBJD4uielDLmYaEUFCGRr9X+G4bDlnlyCIauH
 iev98ZAVY4e8/llOWwDA8SnPkks+uJN9CGrt9f7VxWgq2iJzUZd7RypgEiof0Yi9DFd6u1B
 tFARIc8cJ2TDJjRk9C22OV7D9HvlNgxBmqXCvEKeDRSHYHlUIErs6/4vagcHcMvWcNcTotA
 oonE027TgUi91iwxg7p0x6VlsokdMZdv4XMTCSEvwKh/Jm10unsNFYKVgJWMNQwVDFWUU7D
 ON/c7uVmgmIPI6LhjaIg1q+nDzhXJNo9/xA23k0RTQr+pKM6P8V0ize15jZ6/LL4+4dseiX
 8AkpuLYMOb/EOHkwf7Yn0oApK+F24p5LBaHokeJwamq03ckYJQZX/miBqCInpedcTVaqHSn
 WZus/slXCxpjo/N3MvrGafF5ZRsSjP9YUFEvjOLWcPL3020ES5ex/Lbfdtn99DgDt2GErnd
 EnnJ+cHfhCp6J6+s8Sqv9qFYNE1dioQIxU8z8tMxDpUWIh3iZSTkeCkCb8TkrOB2sIfa8c/
 JOtA+Ju8ItgP47oLQpVrz8PPUiKVyvwxRVD0EKw9dcolETR+gEZo753YRIIQLAJGxEETwJT
 H8qZJcHH5LgqCDZRUh2dJpPnFEALA3sGqPJfbp/yNHyAJT2J32pRRfESHFMTHIkQTARsRb3
 FR2RG+J2GHfiSIpncm/B3ebjClP3DBdUQ==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
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

The Radxa Dragon Q8B is a single-board computer based on the Qualcomm
SC8280XP platform.

Document its radxa,dragon-q8b compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Tested-by: Daniele Briguglio <hello@superkali.me>
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index ff8a35df7862..4341bb04f912 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -902,6 +902,7 @@ properties:
               - microsoft,blackrock
               - qcom,sc8280xp-crd
               - qcom,sc8280xp-qrd
+              - radxa,dragon-q8b
           - const: qcom,sc8280xp
 
       - items:

-- 
2.56.0

