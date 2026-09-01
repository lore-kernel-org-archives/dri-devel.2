Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A363FC61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA5AA10EBF4;
	Tue,  1 Sep 2026 08:49:16 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54FCC10E0D5
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 08:49:15 +0000 (UTC)
X-QQ-mid: zesmtpip4t1788252505te49710af
X-QQ-Originating-IP: j0zn8JV8YG2Na5F1kBXtTpcNGNwxlSCLn2r/eXAtkZE=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 01 Sep 2026 16:48:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8002565544933552914
EX-QQ-RecipientCnt: 29
From: Xilin Wu <sophon@radxa.com>
Date: Tue, 01 Sep 2026 16:47:57 +0800
Subject: [PATCH 4/6] dt-bindings: arm: qcom: document Radxa Dragon Q8B
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-q8b-dts-v1-4-7de0b6a73d08@radxa.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=789; i=sophon@radxa.com;
 h=from:subject:message-id; bh=oDplWRoiwO5NuQtrHxA7ZfWcC6OR+6v2pC5fKH/TROk=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFnTJjqzbZkX+ofzc+sR0R4nue1x+naVL37ekzz5Y5PLk
 T2n3dOsOkpZGMS4GGTFFFkU4hnmslfmXnsqVqoHM4eVCWQIAxenAEzEPZuR4dqe5vPLFuZ15f1Y
 8jKr6qR3rbzwn2N1fsm6ffL+IuzHpzL8r51lzRt5QdNJYD7v2i+cCjd0lZsqF878U/JHPLt5nmA
 KLwA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MhHYuF7Otq+o/2QhaoGILUxGokugDRzjQJ35gVkRfSQ51k6oaSg7y5el
 L4bt3O6XFqbjiWO6SMojSVwo2rsnwNLeQd1l/H6z5rkBs+r/fbFC63zb+ERmtGjXcTri6Fa
 B00DsB9pZhVv2kZMqTdENWZ49ef0XePRC0pD72WQTjvCrqBwpbqANeaSpFnp5GG9KvseHzL
 GA9bJEHYJn4h5YjQ9B27dF+8Gap+iwIfebGAGEbAupsT3G6awV9nuUN1qzzu8ijffpXneQZ
 Wajv2DCrYDCCxThfb3pBzcIX+CpepF2LmnSPqOCZDJx9wKXNZ6CT/BNOByxIoeejcLB/oHG
 Mba0jj90rOLsqGcx+JyD8GRhbvFX6x3qCMcZ4SGebi6bkpVkMWmEGcH56YwP5+9AsHrtAiG
 2iWIeB9nq4yNWPLMipBLJzK6B+7BkA2Imujzh3v2gLeD3VaTWbExzisbOwnzuvFEDEYVl4v
 tXi0MiFKd8iv6Eh8yin4gezMhtMSof5TIQcxtzOzlc7efFjxp1wn1g9oRqeHCjHV4ZYqmoP
 8e38AsZQk35cIWz13YvzYSO2Uhd7xdZ+dGAgGivHoRckX4EgZpT9IfFSiGVbxe9+ZVrdQH7
 a9Yy72un1ZurXkZTiGKvW0zEw/L4ubt+DUJHnQjBi3Z14kLqHuaAmpB9yEHEKXsKtMCZDbj
 tY6Vq6mf9qPDbwiEp69yGGFXan3ot9clRdqgPBlvtA3iF18Ev8cbbc3Yq+WNnUl7r1NLF3A
 CS58pYEG5bT67HStUrgSQetD/vTro6ZHRFnkG+lmLDc72SnCtIcE1yGp6MN6jU9QuL4rQ+X
 g0dapfbKr9hdOnNRbPEYHl8QB+Agw7UHDrTssrWfw52gbfdAvi02sY97JTlJPxr/L/M6w9Y
 231Cssak8EuuBZQcBg0Vqd1jcgHv5WZ6n251Ejd48l7AHGn6QaSkr/UQ3kRtMvpS8ihXlJS
 92EBHjddf10hhxHDzlHeglaUpRytgRUHXvC7cUaUR+zAThUc2QvcGJOr0KuIiHANio68Osp
 iBVj884BFEv0zME7hyHX96dKZNfRMMvIm2hjexzx0USGo7/fWF6vgbifrDPE4=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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
2.55.0

