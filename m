Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62BFC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD3DF10E0D5;
	Tue,  1 Sep 2026 08:49:17 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B10C10E0D5
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 08:49:16 +0000 (UTC)
X-QQ-mid: zesmtpip4t1788252509t94851027
X-QQ-Originating-IP: lIvP1GpVQQqw+C7jJ6FIpBcVY6xKxry0TN9Yl3JnFvM=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 01 Sep 2026 16:48:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16756156345845701689
EX-QQ-RecipientCnt: 29
From: Xilin Wu <sophon@radxa.com>
Date: Tue, 01 Sep 2026 16:47:58 +0800
Subject: [PATCH 5/6] dt-bindings: pinctrl: qcom,sc8280xp-tlmm: allow
 gpio-line-names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-q8b-dts-v1-5-7de0b6a73d08@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
In-Reply-To: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
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
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=866; i=sophon@radxa.com;
 h=from:subject:message-id; bh=XiivO9ePSRP/6Irz+PM55rhD9kC4gh2QxLZOX5pCwp0=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFnTJrrkHHs+38bv27U78yvk/YXve736EWrMOM3PuUz7y
 yMr9YSIjlIWBjEuBlkxRRaFeIa57JW5156KlerBzGFlAhnCwMUpABPhVGRk+DvJIVHi+Hrt9TeZ
 dDZ7qz53V3614516ve/ZfXMeMIrs9mdk+O55aOXMVfGzH2zu7l9hc1ZzcaCWzhS2xv83cuMeuUd
 84AYA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N7GUC1BMtJ2bXmb0PH9h2wgyYeFAVyuEOqioZnCVRB9QpBPBQXLPrCX1
 aaUXvC7Q7HzsjCw3lzdENUuwQl+D+/JNL0A+Gk09glQ5lZ/y7ikkBcbPezqbR9GkTh+Z/Cp
 dYz83U95A0ykSulDrQB3XnrTwUUOIlzYh0yXNHX/885/Lp3Kg6KZBBDChlt9xkHJMtv2Bhm
 GTmH9n9qnveP5+Nypmua4ztlj2bVuBvdmT+HglWD2M/PQFwdHtdZ7fAiWB2U4jdDnq41ShV
 Ug8aGrd6FVzJAWDZ+M0T6nLGwuPquvDKv78kIvOddM5Ew+Z84JP+d3X15c99OpsZiwhUTva
 oj+WiZmtua5TIRuRkK07CfXP6PAJb4Ic9mY6JG4b2hHlIGY9ITet2J4ZhgSZTrpXAUbLd8b
 q3ues6nnDPDdXHQ45pKWBG0t6OAHKkvTLwZGw9ZosHL/9bC8IwwBWYmuDyhlLSlePdYG/aJ
 XhqvFegS8PPXClXkLuY551GM2JQbusQsnIgeyatOCspjziZ12SBre618WvKaMcNCzA/s374
 7oLgPIUbq7PvpiIyXHPjP8XKOFG8MBQJl/tlJt4sJPDb5arwaoIV4npMpWowSDbbk/F6//E
 rO8e6QerekrhKJf1UTvGstMwO0hFdt8lK68ZKHDydAMELXRuY99sxXwMpchSNbBDjX6k2rX
 O7kdgvGYDgklQbimP0ZwRViEwxofSq3VPG/6EDUmnQt0LuADuL3JhMhc4TvWKK9T/280XrE
 ga7OGkLHq3IbMRTU7Uc34XxzaBszirfskgVcdjMhaEgPLRNHHvJcr/VS8iic7hOK25l58qJ
 hF9FH7W0ffJ4ynw5iCbfxwScZk0nCjJYalR72y6Cmks+WB5wfMLUpTJISgr4sxTO0EKQdIP
 Jk0WGnEEdQCPVYqcobAlazf03j4P9RIj17GYfOVwOeDxQy3SmTCbrl9SUf0lOAtedkyvENM
 ALn6+fQtgSbXT8QVZhgyaS2Ded/EpkZTEGPNXfC1wDSq6ZrsnfIqmT4WLrg4kBDwVFWLtbl
 RnzULhPRg2HKWdAn4bIoiVweUx8VTwWbUsdryvz/qDrLz0Xr2mtYV55GJbDbOjxVowBAWSi
 00+o5pTENat4r/7aIVOqCAEybsFXJ4Z4g==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

The SC8280XP TLMM GPIO controller exposes 230 GPIO lines. Allow boards to
provide descriptive names for these lines and constrain the list to the
number of GPIOs exposed by the controller.

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml
index ed344deaf8b9..ebc3a8b34a4c 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml
@@ -27,6 +27,9 @@ properties:
 
   gpio-reserved-ranges: true
 
+  gpio-line-names:
+    maxItems: 230
+
 patternProperties:
   "-state$":
     oneOf:

-- 
2.55.0

