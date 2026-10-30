Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB64606A329
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 05:44:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9068F10E73F;
	Fri, 30 Oct 2026 05:44:49 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 642DD10E74A
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 05:44:34 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.150])
 by APP-01 (Coremail) with SMTP id qwCowABnO++1LuRqL2kEDA--.17661S5;
 Fri, 30 Oct 2026 13:44:26 +0800 (CST)
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Date: Fri, 30 Oct 2026 13:44:14 +0800
Subject: [PATCH 3/4] drm/panel: ilitek-ili9881c: add Mingjun MJ070BI30IA2
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-mj070bi30ia2-v1-3-a0f65b65c290@iscas.ac.cn>
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
X-CM-TRANSID: qwCowABnO++1LuRqL2kEDA--.17661S5
X-Coremail-Antispam: 1UD129KBjvJXoW3tw47Zr1kWFWUXF47XrW3GFg_yoWDtFWxpr
 98Cws2k34rursxt34rWFZrJay2kayxtr4kCryDuws0qayYkr4ftay5Ja18W3Z8Za17uFs3
 AF42g3s8WF45GaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
 x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
 A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
 0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
 IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
 Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
 xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
 JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
 kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
 6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
 IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
 Ja73UjIFyTuYvjfUO_MaUUUUU
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mingjun MJ070BI30IA2 is a 7" MIPI DSI LCD panel used by Lichee Console
4A, with a initialization sequence matching the pattern of Ilitek
ILI9881C driver chip.

Add it to the driver for ILI9881C-based panels.

Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 222 ++++++++++++++++++++++++++
 1 file changed, 222 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index c3d5ab67121d9..83148c40e25ca 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -2198,6 +2198,201 @@ static const struct ili9881c_instr waveshare_7inch_a_init[] = {
 	ILI9881C_COMMAND_INSTR(0x36, 0x00),
 };
 
+static const struct ili9881c_instr mj070bi30ia2_init[] = {
+	ILI9881C_SWITCH_PAGE_INSTR(3),
+	ILI9881C_COMMAND_INSTR(0x01, 0x00),
+	ILI9881C_COMMAND_INSTR(0x02, 0x00),
+	ILI9881C_COMMAND_INSTR(0x03, 0x73),
+	ILI9881C_COMMAND_INSTR(0x04, 0x13),
+	ILI9881C_COMMAND_INSTR(0x05, 0x00),
+	ILI9881C_COMMAND_INSTR(0x06, 0x0A),
+	ILI9881C_COMMAND_INSTR(0x07, 0x05),
+	ILI9881C_COMMAND_INSTR(0x11, 0x00),
+	ILI9881C_COMMAND_INSTR(0x09, 0x28),
+	ILI9881C_COMMAND_INSTR(0x0A, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0B, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0C, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0D, 0x28),
+	ILI9881C_COMMAND_INSTR(0x0E, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0F, 0x28),
+	ILI9881C_COMMAND_INSTR(0x10, 0x28),
+	ILI9881C_COMMAND_INSTR(0x11, 0x00),
+	ILI9881C_COMMAND_INSTR(0x12, 0x00),
+	ILI9881C_COMMAND_INSTR(0x13, 0x00),
+	ILI9881C_COMMAND_INSTR(0x14, 0x00),
+	ILI9881C_COMMAND_INSTR(0x15, 0x00),
+	ILI9881C_COMMAND_INSTR(0x16, 0x00),
+	ILI9881C_COMMAND_INSTR(0x17, 0x00),
+	ILI9881C_COMMAND_INSTR(0x18, 0x00),
+	ILI9881C_COMMAND_INSTR(0x19, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1A, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1B, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1C, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1D, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1E, 0x40),
+	ILI9881C_COMMAND_INSTR(0x1F, 0x80),
+	ILI9881C_COMMAND_INSTR(0x20, 0x06),
+	ILI9881C_COMMAND_INSTR(0x21, 0x01),
+	ILI9881C_COMMAND_INSTR(0x22, 0x00),
+	ILI9881C_COMMAND_INSTR(0x23, 0x00),
+	ILI9881C_COMMAND_INSTR(0x24, 0x00),
+	ILI9881C_COMMAND_INSTR(0x25, 0x00),
+	ILI9881C_COMMAND_INSTR(0x26, 0x00),
+	ILI9881C_COMMAND_INSTR(0x27, 0x00),
+	ILI9881C_COMMAND_INSTR(0x28, 0x33),
+	ILI9881C_COMMAND_INSTR(0x29, 0x33),
+	ILI9881C_COMMAND_INSTR(0x2A, 0x00),
+	ILI9881C_COMMAND_INSTR(0x2B, 0x00),
+	ILI9881C_COMMAND_INSTR(0x2C, 0x04),
+	ILI9881C_COMMAND_INSTR(0x2D, 0x0C),
+	ILI9881C_COMMAND_INSTR(0x2E, 0x05),
+	ILI9881C_COMMAND_INSTR(0x2F, 0x05),
+	ILI9881C_COMMAND_INSTR(0x30, 0x00),
+	ILI9881C_COMMAND_INSTR(0x31, 0x00),
+	ILI9881C_COMMAND_INSTR(0x32, 0x31),
+	ILI9881C_COMMAND_INSTR(0x33, 0x00),
+	ILI9881C_COMMAND_INSTR(0x34, 0x00),
+	ILI9881C_COMMAND_INSTR(0x35, 0x0A),
+	ILI9881C_COMMAND_INSTR(0x36, 0x00),
+	ILI9881C_COMMAND_INSTR(0x37, 0x08),
+	ILI9881C_COMMAND_INSTR(0x70, 0x00),
+	ILI9881C_COMMAND_INSTR(0x39, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3A, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3B, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3C, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3D, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3E, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3F, 0x00),
+	ILI9881C_COMMAND_INSTR(0x40, 0x00),
+	ILI9881C_COMMAND_INSTR(0x41, 0x00),
+	ILI9881C_COMMAND_INSTR(0x42, 0x00),
+	ILI9881C_COMMAND_INSTR(0x43, 0x08),
+	ILI9881C_COMMAND_INSTR(0x44, 0x00),
+	ILI9881C_COMMAND_INSTR(0xA0, 0x02),
+	ILI9881C_COMMAND_INSTR(0x51, 0x23),
+	ILI9881C_COMMAND_INSTR(0x52, 0x44),
+	ILI9881C_COMMAND_INSTR(0x53, 0x67),
+	ILI9881C_COMMAND_INSTR(0x54, 0x89),
+	ILI9881C_COMMAND_INSTR(0x55, 0xAB),
+	ILI9881C_COMMAND_INSTR(0x56, 0x01),
+	ILI9881C_COMMAND_INSTR(0x57, 0x23),
+	ILI9881C_COMMAND_INSTR(0x58, 0x45),
+	ILI9881C_COMMAND_INSTR(0x59, 0x67),
+	ILI9881C_COMMAND_INSTR(0x5A, 0x89),
+	ILI9881C_COMMAND_INSTR(0x5B, 0xAB),
+	ILI9881C_COMMAND_INSTR(0x5C, 0xCD),
+	ILI9881C_COMMAND_INSTR(0x5D, 0xEF),
+	ILI9881C_COMMAND_INSTR(0x5E, 0x11),
+	ILI9881C_COMMAND_INSTR(0x5F, 0x02),
+	ILI9881C_COMMAND_INSTR(0x60, 0x08),
+	ILI9881C_COMMAND_INSTR(0x61, 0x0E),
+	ILI9881C_COMMAND_INSTR(0x62, 0x0F),
+	ILI9881C_COMMAND_INSTR(0x63, 0x0C),
+	ILI9881C_COMMAND_INSTR(0x64, 0x0D),
+	ILI9881C_COMMAND_INSTR(0x65, 0x17),
+	ILI9881C_COMMAND_INSTR(0x66, 0x01),
+	ILI9881C_COMMAND_INSTR(0x67, 0x01),
+	ILI9881C_COMMAND_INSTR(0x68, 0x02),
+	ILI9881C_COMMAND_INSTR(0x69, 0x02),
+	ILI9881C_COMMAND_INSTR(0x6A, 0x00),
+	ILI9881C_COMMAND_INSTR(0x6B, 0x00),
+	ILI9881C_COMMAND_INSTR(0x6C, 0x02),
+	ILI9881C_COMMAND_INSTR(0x6D, 0x02),
+	ILI9881C_COMMAND_INSTR(0x6E, 0x16),
+	ILI9881C_COMMAND_INSTR(0x6F, 0x16),
+	ILI9881C_COMMAND_INSTR(0x70, 0x06),
+	ILI9881C_COMMAND_INSTR(0x71, 0x06),
+	ILI9881C_COMMAND_INSTR(0x72, 0x07),
+	ILI9881C_COMMAND_INSTR(0x73, 0x07),
+	ILI9881C_COMMAND_INSTR(0x74, 0x02),
+	ILI9881C_COMMAND_INSTR(0x75, 0x02),
+	ILI9881C_COMMAND_INSTR(0x76, 0x08),
+	ILI9881C_COMMAND_INSTR(0x77, 0x0E),
+	ILI9881C_COMMAND_INSTR(0x78, 0x0F),
+	ILI9881C_COMMAND_INSTR(0x79, 0x0C),
+	ILI9881C_COMMAND_INSTR(0x7A, 0x0D),
+	ILI9881C_COMMAND_INSTR(0x7B, 0x17),
+	ILI9881C_COMMAND_INSTR(0x7C, 0x01),
+	ILI9881C_COMMAND_INSTR(0x7D, 0x01),
+	ILI9881C_COMMAND_INSTR(0x7E, 0x02),
+	ILI9881C_COMMAND_INSTR(0x7F, 0x02),
+	ILI9881C_COMMAND_INSTR(0x80, 0x00),
+	ILI9881C_COMMAND_INSTR(0x81, 0x00),
+	ILI9881C_COMMAND_INSTR(0x82, 0x02),
+	ILI9881C_COMMAND_INSTR(0x83, 0x02),
+	ILI9881C_COMMAND_INSTR(0x84, 0x16),
+	ILI9881C_COMMAND_INSTR(0x85, 0x16),
+	ILI9881C_COMMAND_INSTR(0x86, 0x06),
+	ILI9881C_COMMAND_INSTR(0x87, 0x06),
+	ILI9881C_COMMAND_INSTR(0x88, 0x07),
+	ILI9881C_COMMAND_INSTR(0x89, 0x07),
+	ILI9881C_COMMAND_INSTR(0x8A, 0x02),
+
+	ILI9881C_SWITCH_PAGE_INSTR(4),
+	ILI9881C_COMMAND_INSTR(0x6E, 0x1A),
+	ILI9881C_COMMAND_INSTR(0x6F, 0x37),
+	ILI9881C_COMMAND_INSTR(0x3A, 0xA4),
+	ILI9881C_COMMAND_INSTR(0x8D, 0x1F),
+	ILI9881C_COMMAND_INSTR(0x87, 0xBA),
+	ILI9881C_COMMAND_INSTR(0xB2, 0xD1),
+	ILI9881C_COMMAND_INSTR(0x88, 0x0B),
+	ILI9881C_COMMAND_INSTR(0x38, 0x01),
+	ILI9881C_COMMAND_INSTR(0x39, 0x00),
+	ILI9881C_COMMAND_INSTR(0xB5, 0x02),
+	ILI9881C_COMMAND_INSTR(0x31, 0x25),
+	ILI9881C_COMMAND_INSTR(0x3B, 0x98),
+
+	ILI9881C_SWITCH_PAGE_INSTR(1),
+	ILI9881C_COMMAND_INSTR(0x22, 0x0A),
+	ILI9881C_COMMAND_INSTR(0x31, 0x00),
+	ILI9881C_COMMAND_INSTR(0xA6, 0xA6),
+	ILI9881C_COMMAND_INSTR(0x55, 0x3D),
+	ILI9881C_COMMAND_INSTR(0x50, 0x9E),
+	ILI9881C_COMMAND_INSTR(0x51, 0x99),
+	ILI9881C_COMMAND_INSTR(0x60, 0x06),
+	ILI9881C_COMMAND_INSTR(0x62, 0x20),
+	ILI9881C_COMMAND_INSTR(0xA0, 0x00),
+	ILI9881C_COMMAND_INSTR(0xA1, 0x17),
+	ILI9881C_COMMAND_INSTR(0xA2, 0x26),
+	ILI9881C_COMMAND_INSTR(0xA3, 0x13),
+	ILI9881C_COMMAND_INSTR(0xA4, 0x16),
+	ILI9881C_COMMAND_INSTR(0xA5, 0x29),
+	ILI9881C_COMMAND_INSTR(0xA6, 0x1E),
+	ILI9881C_COMMAND_INSTR(0xA7, 0x1F),
+	ILI9881C_COMMAND_INSTR(0xA8, 0x8B),
+	ILI9881C_COMMAND_INSTR(0xA9, 0x1D),
+	ILI9881C_COMMAND_INSTR(0xAA, 0x2A),
+	ILI9881C_COMMAND_INSTR(0xAB, 0x7B),
+	ILI9881C_COMMAND_INSTR(0xAC, 0x1A),
+	ILI9881C_COMMAND_INSTR(0xAD, 0x19),
+	ILI9881C_COMMAND_INSTR(0xAE, 0x4E),
+	ILI9881C_COMMAND_INSTR(0xAF, 0x24),
+	ILI9881C_COMMAND_INSTR(0xB0, 0x29),
+	ILI9881C_COMMAND_INSTR(0xB1, 0x4F),
+	ILI9881C_COMMAND_INSTR(0xB2, 0x5C),
+	ILI9881C_COMMAND_INSTR(0xB3, 0x3E),
+	ILI9881C_COMMAND_INSTR(0xC0, 0x00),
+	ILI9881C_COMMAND_INSTR(0xC1, 0x17),
+	ILI9881C_COMMAND_INSTR(0xC2, 0x26),
+	ILI9881C_COMMAND_INSTR(0xC3, 0x13),
+	ILI9881C_COMMAND_INSTR(0xC4, 0x16),
+	ILI9881C_COMMAND_INSTR(0xC5, 0x29),
+	ILI9881C_COMMAND_INSTR(0xC6, 0x1E),
+	ILI9881C_COMMAND_INSTR(0xC7, 0x1F),
+	ILI9881C_COMMAND_INSTR(0xC8, 0x8B),
+	ILI9881C_COMMAND_INSTR(0xC9, 0x1D),
+	ILI9881C_COMMAND_INSTR(0xCA, 0x2A),
+	ILI9881C_COMMAND_INSTR(0xCB, 0x7B),
+	ILI9881C_COMMAND_INSTR(0xCC, 0x1A),
+	ILI9881C_COMMAND_INSTR(0xCD, 0x19),
+	ILI9881C_COMMAND_INSTR(0xCE, 0x4E),
+	ILI9881C_COMMAND_INSTR(0xCF, 0x24),
+	ILI9881C_COMMAND_INSTR(0xD0, 0x29),
+	ILI9881C_COMMAND_INSTR(0xD1, 0x4D),
+	ILI9881C_COMMAND_INSTR(0xD2, 0x5C),
+	ILI9881C_COMMAND_INSTR(0xD3, 0x3E),
+};
+
 static inline struct ili9881c *panel_to_ili9881c(struct drm_panel *panel)
 {
 	return container_of(panel, struct ili9881c, panel);
@@ -2493,6 +2688,23 @@ static const struct drm_display_mode waveshare_7inch_a_mode = {
 	.height_mm	= 154,
 };
 
+static const struct drm_display_mode mj070bi30ia2_mode = {
+	.clock		= 75750,
+
+	.hdisplay	= 800,
+	.hsync_start	= 800 + 48,
+	.hsync_end	= 800 + 48 + 32,
+	.htotal		= 800 + 48 + 32 + 80,
+
+	.vdisplay	= 1280,
+	.vsync_start	= 1280 + 3,
+	.vsync_end	= 1280 + 3 + 10,
+	.vtotal		= 1280 + 3 + 10 + 24,
+
+	.width_mm	= 94,
+	.height_mm	= 150,
+};
+
 static int ili9881c_get_modes(struct drm_panel *panel,
 			      struct drm_connector *connector)
 {
@@ -2704,6 +2916,15 @@ static const struct ili9881c_desc waveshare_7inch_a_desc = {
 	.lanes = 2,
 };
 
+static const struct ili9881c_desc mj070bi30ia2_desc = {
+	.init = mj070bi30ia2_init,
+	.init_length = ARRAY_SIZE(mj070bi30ia2_init),
+	.mode = &mj070bi30ia2_mode,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+		      MIPI_DSI_MODE_LPM,
+	.lanes = 4,
+};
+
 static const struct of_device_id ili9881c_of_match[] = {
 	{ .compatible = "bananapi,lhr050h41", .data = &lhr050h41_desc },
 	{ .compatible = "bestar,bsd1218-a101kl68", .data = &bsd1218_a101kl68_desc },
@@ -2714,6 +2935,7 @@ static const struct of_device_id ili9881c_of_match[] = {
 	{ .compatible = "wanchanglong,w552946aba", .data = &w552946aba_desc },
 	{ .compatible = "waveshare,7.0-dsi-touch-a", .data = &waveshare_7inch_a_desc },
 	{ .compatible = "ampire,am8001280g", .data = &am8001280g_desc },
+	{ .compatible = "mingjun,mj070bi30ia2", .data = &mj070bi30ia2_desc },
 	{ .compatible = "raspberrypi,dsi-5inch", &rpi_5inch_desc },
 	{ .compatible = "raspberrypi,dsi-7inch", &rpi_7inch_desc },
 	{ }

-- 
2.56.0

