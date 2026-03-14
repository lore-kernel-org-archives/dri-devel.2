Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979D110706E2
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 16:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEE7910E163;
	Sat, 14 Mar 2026 16:54:45 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85E0010E519
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 16:54:42 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.43])
 by APP-03 (Coremail) with SMTP id rQCowABXdt2_krVp5hKqCg--.41046S2;
 Sun, 15 Mar 2026 00:54:24 +0800 (CST)
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Sui Jingfeng <suijingfeng@loongson.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>
Subject: [PATCH] drm/loongson: stop to set get_vblank_timestamp for 7A1000 CRTC
Date: Sun, 15 Mar 2026 00:54:21 +0800
Message-ID: <20260314165421.1201790-1-zhengxingda@iscas.ac.cn>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXdt2_krVp5hKqCg--.41046S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Xw1UJw1rWr48Kr43Aw15CFg_yoW8Jr4kpF
 srCF1IyrWDXFySywnrJF10kayruay5Jr929a9Fkw13uw45Ar18CF18AFW7uw17XF9rZ3ya
 qrn7tF1YkFs29aUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
 0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
 6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
 AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
 c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
 AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
 Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B
 _UUUUU=
X-Originating-IP: [112.94.100.43]
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
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

As there's no known hardware capability about querying vblank on the
7A1000 display controller, setting get_vblank_timestamp will mislead the
kernel about the support of DC-backed high precision vblank query.

Drop this function pointer in the CRTC function table for 7A1000.

This solves a kernel warning when booting Linux 7.0-rc3 on a
3A4000+7A1000 Haier Boyue G51 laptop (with injected EDID for replicating
the display timing set by the firmware).

Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
 drivers/gpu/drm/loongson/lsdc_crtc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_crtc.c b/drivers/gpu/drm/loongson/lsdc_crtc.c
index 587fbe285e9ef..b3af8e0cdb15f 100644
--- a/drivers/gpu/drm/loongson/lsdc_crtc.c
+++ b/drivers/gpu/drm/loongson/lsdc_crtc.c
@@ -721,7 +721,6 @@ static const struct drm_crtc_funcs ls7a1000_crtc_funcs = {
 	.late_register = lsdc_crtc_late_register,
 	.enable_vblank = lsdc_crtc_enable_vblank,
 	.disable_vblank = lsdc_crtc_disable_vblank,
-	.get_vblank_timestamp = drm_crtc_vblank_helper_get_vblank_timestamp,
 	.atomic_print_state = lsdc_crtc_atomic_print_state,
 };
 
-- 
2.52.0

