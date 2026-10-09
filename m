Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4F5CA6012
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:56:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FEEB10FF53;
	Fri,  9 Oct 2026 07:56:08 +0000 (UTC)
X-Greylist: delayed 16674 seconds by postgrey-1.36 at gabe;
 Fri, 09 Oct 2026 07:56:05 UTC
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4597210E759
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 07:56:04 +0000 (UTC)
X-QQ-mid: zesmtpip2t1791532526tc2f97ed7
X-QQ-Originating-IP: VBjnUdPH8eC5s6bbmCJPoWdYx3vLC3pyuYwl0fR409I=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 Oct 2026 15:55:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10937849882715644539
EX-QQ-RecipientCnt: 32
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 09 Oct 2026 15:55:06 +0800
Subject: [PATCH v2 1/4] dt-bindings: display: bridge: simple: document
 Chrontel CH7218A
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-q8b-dts-v2-1-eda11e5dea8b@radxa.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1233; i=sophon@radxa.com;
 h=from:subject:message-id; bh=G4sBlfB4NGRMNHWX1zneeBBLLlnhh7y7L1BErGKdRik=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFkn5j6dLvxD9rDtZd8tLCU/7edO92tbXbWPRY6Rk33Rn
 4KfbRr7O0pZGMS4GGTFFFkU4hnmslfmXnsqVqoHM4eVCWQIAxenAExEIIrhf3Uyl5x+xe4V9m9n
 cvFybXfI4WFw2CJ+5NuE89LSx+S/P2Zk6A05+Nlu+u4MXVkN/n9eb9QCWmXX3nFPuyS1O0T5yv7
 PHAA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MWgnKUIRcMzUjOVK4clzKPivdwNFZOmqHpyW99kJockB/liF7JezN3Pp
 sseHFtFM5DIw+yzRh0yEyJqjnSA8RbztqzpCFYoZI1qhqYJO8DEBMvvaI5CNAPJhGB9r9cj
 zaVTN5FsxushsDrZ8tuCJBvNl3C9iq9ZHhkouvJcaJmFuwf3qoelfmx7fbZzQN6Q822wtZm
 F06BlZ0lyiwEvJZO+icCgnvVLlP66RCd4KYRulyy6P1ZEZ1Q44BMhslIR9OnEwomJbeBj9H
 smDIB2TSN0DNZzQvD7hHQD0lPPlUo5T2H4x+la+xHiHfrses1V9RCRL+85wys8MdplStM0w
 9T6PgWisv+gwacatF0Lzd4Bd1zrmIw5o+iNqGdWCnob7YHF+pYfJ44SlLhgjY5uoy9sLivR
 ZRB07s4ibDgBVMdFzMmSSA3ptFgJAB/JU+H1RsFpChoBod/7UWmI4+PSFr5LQHS9KxVR12/
 3MrFtSU+ujda0Kho0HHETvdA7o/owN795xrrYzoq2Y5M4pJBkcP7VQfGz4UHzfh/Y/PiFQe
 BkkIPVlwx/A7LimHmAKTsogkGUp7U8LnfcdnQMHZjjaBc73gEuy/qcMw52QS0FXJ2HbGBRq
 Vv9fL0sfPMv6WAXmAMUEF6BowIea1n82EoMIRorrnu8wUtU04F7eFt0jUhS1+xUilY92VG7
 NGYsLJPwSplhuH7UGFNe379C0kAWvqeGqxcKOlVSG/b4TkuLO4DyOwG5wL39HVVU6BHFu8W
 77Ws4gKkI6w4nHFwxh327upvXGycAxg/pEnp+nTf87SxfJ6V3CtNeEJQoykV8kfBHxqX1E4
 y6S2A1rG84MtYd2meYpdLbtfn7R+2CDvbTioTIf0knrY8Zfhl3Dzv76oyaH8cdfO8vi5pB/
 X448rAitmpT/FXEBWakZa0aDcnU5+xU2GmJWCe55q0hnI3RJAQLkFtGt0+MzWAl2uhk1xAH
 zfH7/XOAko0ZIBWZgUBZolzHd0P0T6OLO1tUSE/BTT72J77jB43vA6XXcYPSPVyJEzRSD6j
 Nzo9cORTMr6k/Hf7y3D4uEAnc3e14VUETk3nsRZfj9FVpn7Ob/Ly7ElDi1XhyMzLu4EmbJG
 jonoiS1SbqC1ZSqavz/MldbT1o4Yz3tAO0YfM639Y97
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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

The Chrontel CH7218A is a DisplayPort 1.4 to HDMI 2.1 protocol converter.

The device contains an embedded microcontroller and on-chip flash. It
automatically boots its firmware and requires no host-side configuration
for the on-board use case, so it can be represented by the simple bridge
binding.

Document the chrontel,ch7218a compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Tested-by: Daniele Briguglio <hello@superkali.me>
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
index 7636c24906ba..9e0e7e09774e 100644
--- a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
@@ -29,6 +29,7 @@ properties:
           - adi,adv7123
           - algoltek,ag6311
           - asl-tek,cs5263
+          - chrontel,ch7218a
           - dumb-vga-dac
           - mstar,tsumu88adt3-lf-1
           - parade,ps185hdm

-- 
2.56.0

