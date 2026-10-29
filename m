Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A442606A332
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F288112193;
	Thu, 29 Oct 2026 10:14:15 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 640AC112193
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 10:14:10 +0000 (UTC)
X-QQ-mid: zesmtpip4t1793268835t02a8b639
X-QQ-Originating-IP: oHmhU6HSKHVoVhkiqrVTCiRUAubECZuQVTC+gyjTpIE=
Received: from [192.168.30.244] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 29 Oct 2026 18:13:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12470455325039139127
EX-QQ-RecipientCnt: 32
From: Xilin Wu <sophon@radxa.com>
Date: Thu, 29 Oct 2026 18:13:36 +0800
Subject: [PATCH v4 2/4] dt-bindings: arm: qcom: document Radxa Dragon Q8B
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-q8b-dts-v4-2-e8e7438f5545@radxa.com>
References: <20261029-q8b-dts-v4-0-e8e7438f5545@radxa.com>
In-Reply-To: <20261029-q8b-dts-v4-0-e8e7438f5545@radxa.com>
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
 Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>, 
 dragon@radxa.com, Xilin Wu <sophon@radxa.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=859; i=sophon@radxa.com;
 h=from:subject:message-id; bh=KHvssF0xBmxgfBrsMVKXU7Qx0Wh+vcWm5edVG9ChHrI=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFmPZcJ2+2oob+0IMT9esGkB+5ra2yIyQTuSJV5kaC7tK
 WT9uulrRykLgxgXg6yYIotCPMNc9srca0/FSvVg5rAygQxh4OIUgIlocTH8dzjSVnOs41+wpuH3
 I1o1n/Ja1muHegU//Dfp7t+uqrhKV4b/8ZLO5sFaf64xue7/5LjmU/9njpJ4iaYFH1Z7O/C1uy9
 jBAA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MsTlFT5/XJkMXFgs+IB/vFWsq5QfLWP3ObDZ3SjMsg7+j+ZKWYsYb/MU
 gSjW7YiT+1mmlGRfY6X4hgm2kORHbsjiEXrne6OTbkYR/MOa6vPD15RnovVkZdMvS3PKmf4
 rvw+l7C4d4taeo7Os3KBcSiMSRRHrHa7DURibLrVdV3aWmS3XovA3qcc/3lbyaSBeanwoD/
 8np7VlOuDsJsyzPy4WuiTtfKflV6PLYyLLr4p7UCiKiLp5g+KG/zW8yHgqDkXXIVXJhviAF
 g/9Jh8oEGjN8g0oX9plQPjdmHHNA3Vx0H3aX6gIYlYt/lBYV3Nll+WbZSD/KysGW2EHzYN/
 JD3T8xFm31j526Vp6ZmxSlLhfOJzYp20ppp8oe4yvVFER8XQT/XyVCM0VEQXrS9OJjnrR1T
 ldTeyQuMnuI4x4KjN7pLh/3YML/PSqCAoXL/ObCBr+GBfufz+lrDXCxhj2HzOd1/CFelx9G
 2eIQ6kgl0FJXC1s8UT6CRSoW/2Y0v9pF5Gr7DMyrqJ8kK2S8k9CPq44oqag0lfa2VnzXFtP
 tXxsQk6k5q2A20kgeh7H7APvlRfLz0wP1PFW2IQhyuUUHNocyV2IcS3Sys0SZpPWEyhuKno
 mR0UWZUHmLkeG7E8taFR/+6ug2PjMTm3/q4XG43LatN+q2Bs0TZsCt7RDnYWs84Jb+eSjgR
 RHsQt6+cJHxyLxEBdUNTgePYNnyTXZhnx3QfID4tmhzejmwYP/uqfTexmCCdZYvLdbsXh/+
 tO1dsW1nhpSqqY8oDsAg2BsCJgEd6/Mbv/7NFm76tzilz68BHj+eLUVWx8K3+96aVPIq3oR
 uGjYf5MnsKIsgdo813c81UlMJ1TlIT//WoFAXtgk68F3XL/dDorviLbCK299IiV42unyAuB
 HnTyiKhGOObPAgk6/wfl01hQzV/Ia8GwFPajWPz36CzGOlbxrjGpiBvL+xL4uWweydwrxDM
 NzM3DqABc8vCG6b55/L1dtMDEdN17DSpMe0jjoIF1OBWSWJYumXTct7L8swXMq60ifq9Jkx
 RLD5MgRX7/I7rMy9ThCHQR/YxVUUTWTiGi5T2Sr3ycr7r+L4Q+GcxKSq8KWAdLb+AScm/NS
 oIOg5UeMkPI0pRpgejLpoTX0VrlRad6yUdhXOGyAyqV4Wih3lWZa7Nl7/H2QQHdpXaGYgqx
 y+ndJupuGmZJwpzWsHb/0fcjz/4R1aAdQnZW
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Radxa Dragon Q8B is a single-board computer based on the Qualcomm
SC8280XP platform.

Document its radxa,dragon-q8b compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 121ca557ce1e..f28645b0088e 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -937,6 +937,7 @@ properties:
               - microsoft,blackrock
               - qcom,sc8280xp-crd
               - qcom,sc8280xp-qrd
+              - radxa,dragon-q8b
           - const: qcom,sc8280xp
 
       - items:

-- 
2.56.0

