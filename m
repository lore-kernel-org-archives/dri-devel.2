Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BF4C5DF76
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3144510E30A;
	Sun, 16 Aug 2026 14:05:17 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3305E10E0E4
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 07:56:30 +0000 (UTC)
Received: from localhost.localdomain (unknown [111.196.241.250])
 by APP-01 (Coremail) with SMTP id qwCowAAX7O8pyn5q5oeeBQ--.63476S2;
 Fri, 14 Aug 2026 15:56:25 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Bartosz Golaszewski <brgl@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: David Lechner <david@lechnology.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v2] ARM: davinci_all_defconfig: enable the current ST7586
 symbol
Date: Fri, 14 Aug 2026 15:56:24 +0800
Message-ID: <20260814075624.16639-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAAX7O8pyn5q5oeeBQ--.63476S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1kJF18Cr4fCr48JFWxtFb_yoW8Jw1xpF
 W5ArsxJa109F1Syay7CrZ5WrZxJanIv3yxCF1jy34Uur1qv34UGrWkKF43WanrWrWkJr4F
 vF9akF9IvFyUCrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
 JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
 AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
 rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
 v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
 Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSLv
 NUUUUU=
X-Originating-IP: [111.196.241.250]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:05:11 +0000
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

The ST7586 DRM provider is now built by CONFIG_DRM_ST7586.
davinci_all_defconfig still enables the removed DRM_TINYDRM and
TINYDRM_ST7586 carrier symbols.

Replace those stale entries with the current provider symbol.

Assisted-by: Codex:gpt-5
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1: https://lore.kernel.org/all/20260624082029.18675-1-pengpeng@iscas.ac.cn/
- no source-code changes
- rebase davinci_all_defconfig
- route the revision to DaVinci and ST7586 maintainers
- add the coding-assistant disclosure

The Kconfig/provider mapping was reviewed statically; no DaVinci kernel
build was performed.

 arch/arm/configs/davinci_all_defconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 72703ef0c51c..ac0029701283 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -144,8 +144,7 @@ CONFIG_VIDEO_ADV7343=m
 CONFIG_DRM=m
 CONFIG_DRM_TILCDC=m
 CONFIG_DRM_SIMPLE_BRIDGE=m
-CONFIG_DRM_TINYDRM=m
-CONFIG_TINYDRM_ST7586=m
+CONFIG_DRM_ST7586=m
 CONFIG_FB=y
 CONFIG_FB_DA8XX=y
 CONFIG_BACKLIGHT_PWM=m
-- 
2.50.1 (Apple Git-155)

