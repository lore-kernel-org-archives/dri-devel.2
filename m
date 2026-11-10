Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE068606EF36
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 10:22:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2D2110E09D;
	Tue, 10 Nov 2026 10:22:02 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB8AA10E4D4
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 09:26:30 +0000 (UTC)
Received: from loongson.cn (unknown [10.20.42.172])
 by gateway (Coremail) with SMTP id _____8Axj9E_4_JqSiMeAA--.21632S3;
 Tue, 10 Nov 2026 17:26:23 +0800 (CST)
Received: from ubuntu.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJDxSs494_Jql3UzAA--.21244S2;
 Tue, 10 Nov 2026 17:26:21 +0800 (CST)
From: wuqianhai@loongson.cn
To: chenhuacai@kernel.org, kernel@xen0n.name, tzimmermann@suse.de,
 deller@gmx.de, bhelgaas@google.com
Cc: ardb@kernel.org, ilias.apalodimas@linaro.org, javierm@redhat.com,
 loongarch@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-efi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 wuqianhai <wuqianhai@loongson.cn>
Subject: [PATCH v3 5/6] efi/libstub: Enable direct sysfb_primary_display
 access on LoongArch
Date: Tue, 10 Nov 2026 17:24:24 +0800
Message-Id: <20261110092424.2647921-1-wuqianhai@loongson.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110090203.2631481-1-wuqianhai@loongson.cn>
References: <20261110090203.2631481-1-wuqianhai@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxSs494_Jql3UzAA--.21244S2
X-CM-SenderInfo: 5zxtxtpqkdxqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7GF1fCFW5GrWxCFykWFWxuFX_yoWkCFgEya
 s8urZrWr4j9ryYgr4UKrWfuas0qay0qw1kZF92yrW3tw4jgwn5Ww4kXwn7CF13AryvkrZ8
 A3WDCF9xAr48tosvyTuYvTs0mTUanT9S1TB71UUUU1JqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbBxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1ln4kS14v26r1q6r43M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
 xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
 6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
 0EwIxGrwACjcxG6xCI17CEII8vrVW3JVW8Jr1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v2
 6r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14
 v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
 17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMI
 IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
 IxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
 sGvfC2KfnxnUUI43ZEXa7IUYsJ55UUUUU==
X-Mailman-Approved-At: Tue, 10 Nov 2026 10:21:36 +0000
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

From: wuqianhai <wuqianhai@loongson.cn>

alloc_primary_display() returns NULL on LoongArch when neither
CONFIG_EFI_EARLYCON nor CONFIG_SYSFB is enabled, so the EFI stub does not
populate the core kernel's sysfb_primary_display.  Allow LoongArch to link
directly to sysfb_primary_display, like x86, so the firmware framebuffer
information is always available.

Signed-off-by: wuqianhai <wuqianhai@loongson.cn>
---
 drivers/firmware/efi/libstub/efi-stub-entry.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/libstub/efi-stub-entry.c b/drivers/firmware/efi/libstub/efi-stub-entry.c
index efa3ab8ad1c6..2ac22720675c 100644
--- a/drivers/firmware/efi/libstub/efi-stub-entry.c
+++ b/drivers/firmware/efi/libstub/efi-stub-entry.c
@@ -20,6 +20,7 @@ struct sysfb_display_info *alloc_primary_display(void)
 		return __alloc_primary_display();
 
 	if (IS_ENABLED(CONFIG_X86) ||
+	    IS_ENABLED(CONFIG_LOONGARCH) ||
 	    IS_ENABLED(CONFIG_EFI_EARLYCON) ||
 	    IS_ENABLED(CONFIG_SYSFB))
 		return kernel_image_addr(&sysfb_primary_display);
-- 
2.34.1

