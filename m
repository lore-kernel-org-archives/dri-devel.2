Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51801606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 05:44:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87D1410E686;
	Fri, 30 Oct 2026 05:44:43 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62B7D10E4C5
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 05:44:34 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.150])
 by APP-01 (Coremail) with SMTP id qwCowABnO++1LuRqL2kEDA--.17661S4;
 Fri, 30 Oct 2026 13:44:25 +0800 (CST)
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Date: Fri, 30 Oct 2026 13:44:13 +0800
Subject: [PATCH 2/4] dt-bindings: ili9881c: add compatible string for
 Mingjun MJ070BI30IA2
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-mj070bi30ia2-v1-2-a0f65b65c290@iscas.ac.cn>
References: <20261030-mj070bi30ia2-v1-0-a0f65b65c290@iscas.ac.cn>
In-Reply-To: <20261030-mj070bi30ia2-v1-0-a0f65b65c290@iscas.ac.cn>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Icenowy Zheng <uwu@icenowy.me>, 
 Han Gao <gaohan@iscas.ac.cn>, Icenowy Zheng <zhengxingda@iscas.ac.cn>
X-Mailer: b4 0.15.0
X-CM-TRANSID: qwCowABnO++1LuRqL2kEDA--.17661S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr15tr43Aw4DXF4DGF15urg_yoWDWrg_Wa
 93AF1qvrn5A3WSgwn0yF4kGr4rZ3yxCr4Duwn8tFnY934IkrWDKFyvyw1rAryUurW3uF1f
 ur4fG34DGwsrujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbk8FF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
 0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
 wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
 ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I2
 62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
 AFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
 0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI
 1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
 Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
 CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
 I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
 8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
 UjIFyTuYvjfUOdgAUUUUU
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
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

Mingjun MJ070BI30IA2 is the LCD panel used by Sipeed Lichee Console 4A,
and its initialization sequence seems to match ILI9881C controller.

Add its compatible string to the ILI9881C binding.

Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
 Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
index 42e35986fbf60..0139e35d85c4b 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
@@ -20,6 +20,7 @@ properties:
           - bananapi,lhr050h41
           - bestar,bsd1218-a101kl68
           - feixin,k101-im2byl02
+          - mingjun,mj070bi30ia2
           - raspberrypi,dsi-5inch
           - raspberrypi,dsi-7inch
           - startek,kd050hdfia020

-- 
2.56.0

