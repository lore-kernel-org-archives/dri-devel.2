Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A722FCD0DC
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A4B010E751;
	Wed, 18 Mar 2026 08:29:08 +0000 (UTC)
X-Greylist: delayed 489 seconds by postgrey-1.36 at gabe;
 Wed, 18 Mar 2026 07:28:47 UTC
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTP id AD46810E0B5
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:28:47 +0000 (UTC)
Received: from loongson.cn (unknown [10.20.42.129])
 by gateway (Coremail) with SMTP id _____8AxQcBEUrppjDwcAA--.22546S3;
 Wed, 18 Mar 2026 15:20:36 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.129])
 by front1 (Coremail) with SMTP id qMiowJDxD8M_Urpp8phXAA--.36851S2;
 Wed, 18 Mar 2026 15:20:31 +0800 (CST)
From: Jianmin Lv <lvjianmin@loongson.cn>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>, Huacai Chen <chenhuacai@kernel.org>
Cc: Xuefeng Li <lixuefeng@loongson.cn>, dri-devel@lists.freedesktop.org,
 Jianmin Lv <lvjianmin@loongson.cn>
Subject: [PATCH] MAINTAINERS: Update GPU driver maintainer information
Date: Wed, 18 Mar 2026 15:13:07 +0800
Message-Id: <20260318071307.3682-1-lvjianmin@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxD8M_Urpp8phXAA--.36851S2
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7KrW3Wry8KFyrJrW5WFy5Jrc_yoW8Xry7pF
 s3G34FkrnrJF4fArs0ya47ZFWYq34rAFZ8Cr4qy3sI9r90yw1rtF4Uta15Ga17XFy5Ka10
 qwn7AFWvka1UGFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
 xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
 6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
 vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
 Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
 xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
 cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
 AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
 14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOiSdUUUUU=
X-Mailman-Approved-At: Wed, 18 Mar 2026 08:28:25 +0000
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

From: lvjianmin <lvjianmin@loongson.cn>

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

Signed-off-by: lvjianmin <lvjianmin@loongson.cn>

diff --git a/MAINTAINERS b/MAINTAINERS
index 837db4f7bcca..b4d7c4089e95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8626,9 +8626,13 @@ F:	drivers/gpu/drm/lima/
 F:	include/uapi/drm/lima_drm.h
 
 DRM DRIVERS FOR LOONGSON
-M:	Sui Jingfeng <suijingfeng@loongson.cn>
+M:	Jianmin Lv <lvjianmin@loongson.cn>
+M:	Qianhai Wu <wuqianhai@loongson.cn>
+R:	Huacai Chen <chenhuacai@kernel.org>
+R:	Mingcong Bai <jeffbai@aosc.io>
+R:	Xi Ruoyao <xry111@xry111.site>
 L:	dri-devel@lists.freedesktop.org
-S:	Supported
+S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	drivers/gpu/drm/loongson/
 
-- 
2.31.1

