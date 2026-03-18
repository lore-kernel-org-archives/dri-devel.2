Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CDF107760C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 19:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC46310E7B1;
	Wed, 18 Mar 2026 19:50:40 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTP id 5854C10E768
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:31:19 +0000 (UTC)
Received: from loongson.cn (unknown [10.20.42.129])
 by gateway (Coremail) with SMTP id _____8CxosDlcLppV0YcAA--.22985S3;
 Wed, 18 Mar 2026 17:31:17 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.129])
 by front1 (Coremail) with SMTP id qMiowJAx38LhcLppR6xXAA--.36345S2;
 Wed, 18 Mar 2026 17:31:13 +0800 (CST)
From: Jianmin Lv <lvjianmin@loongson.cn>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Qianhai Wu <wuqianhai@loongson.cn>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>, Huacai Chen <chenhuacai@kernel.org>
Cc: Xuefeng Li <lixuefeng@loongson.cn>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>
Subject: [PATCH v2] MAINTAINERS: Update GPU driver maintainer information
Date: Wed, 18 Mar 2026 17:23:49 +0800
Message-Id: <20260318092349.11651-1-lvjianmin@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAx38LhcLppR6xXAA--.36345S2
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF45XF4rCr4DKF1rGF4rZwc_yoW8GF1xpF
 s3G34SkrnrAF4fArs8C3W7AFW5Z395CFZ8WrZ0y3sIgr90yw1rtw40ya15Ja17JFW5Ka1I
 qwn7AFWvka1UGFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
 AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
 6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
 xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
 jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
 0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
 67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0b6pPUUUUU==
X-Mailman-Approved-At: Wed, 18 Mar 2026 19:50:21 +0000
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

I and Qianhai are GPU R&D engineers at Loongson, specializing
in kernel driver development. We understand that the current
Loongson GPU driver lacks dedicated maintenance resources
because of some reasons.

As Loongson GPU driver developers, we have both the capability
and the responsibility to continuously maintain the Loongson
GPU driver, ensuring minimal impact on its users. After internal
discussions, our team has decided to recommend me and Qianhai
to take over the maintenance responsibilities, and recommend
Huacai, Mingcong and Ruoyao to help to review.

And We'll continue to maintain it for current supported chips
and drive future updates according to chip support plan.

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>

diff --git a/MAINTAINERS b/MAINTAINERS
index 96ea84948d76..4232039b7282 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8626,8 +8626,13 @@ F:	drivers/gpu/drm/lima/
 F:	include/uapi/drm/lima_drm.h
 
 DRM DRIVERS FOR LOONGSON
+M:	Jianmin Lv <lvjianmin@loongson.cn>
+M:	Qianhai Wu <wuqianhai@loongson.cn>
+R:	Huacai Chen <chenhuacai@kernel.org>
+R:	Mingcong Bai <jeffbai@aosc.io>
+R:	Xi Ruoyao <xry111@xry111.site>
 L:	dri-devel@lists.freedesktop.org
-S:	Orphan
+S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	drivers/gpu/drm/loongson/
 
-- 
2.20.1

