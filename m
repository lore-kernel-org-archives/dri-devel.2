Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31EF60A2613
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:05:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E2CC1124B6;
	Fri, 13 Nov 2026 13:05:47 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA8AF1124A9
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 13:05:45 +0000 (UTC)
Received: from [127.0.1.1] (unknown [223.166.93.97])
 by APP-03 (Coremail) with SMTP id rQCowAAnLY4WC_dq1RfzAA--.14404S2;
 Fri, 13 Nov 2026 21:05:31 +0800 (CST)
From: Han Gao <gaohan@iscas.ac.cn>
Date: Fri, 13 Nov 2026 21:05:08 +0800
Subject: [PATCH] drm/ast: Clear VGASR1 screen disable on CRTC enable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-ast-vgasr1-sd-v1-1-0f9e7d727c06@iscas.ac.cn>
X-B4-Tracking: v=1; b=H4sIAAML92oC/x3MMQqAMAxA0atIZgOmYi1eRRyqjZpFpZEiFO9uc
 XzD/xmUo7DCUGWInETlPAqormDZ/bExSigG0xhLRC16vTFtXiOhBpyNC9x31jF5KM0VeZXn/43
 T+34XnSRlXwAAAA==
X-Change-ID: 20261113-ast-vgasr1-sd-b28de7568e1a
To: Dave Airlie <airlied@redhat.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Jocelyn Falempe <jfalempe@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Han Gao <rabenda.cn@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Han Gao <gaohan@iscas.ac.cn>
X-Mailer: b4 0.14.2
X-CM-TRANSID: rQCowAAnLY4WC_dq1RfzAA--.14404S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw13CF4xKr18Kr1ktr4ruFg_yoW8AFW5pF
 47AayI9r45J3ZFkayUAa1ruay3Gay3KrWfWF1kCa4SvrnxtryxZr45uasrWFyUXFZ7Aa4f
 tFnrtr13XFy29aUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
 n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
 AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
 17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
 IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
 IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
 C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: xjdrxt3q6l2u1dvotugofq/1tbiBgMKDGr22px3DQAAsj
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

Commit 6f719373b943 ("drm/ast: Blank with VGACR17 sync enable, always
clear VGACRB6 sync off") stopped clearing the SD bit in VGASR1 when
enabling the CRTC, as SD was thought to only disable access to video
memory. On AST2600, SD also blanks the display output, including the
picture captured by the BMC for remote KVM.

Nothing else clears SD, as ast_set_std_reg() preserves the bit. If
firmware or a previous kernel, such as one that started this kernel with
kexec, left SD set, the display stays blank. Clear SD on CRTC enable.

Fixes: 6f719373b943 ("drm/ast: Blank with VGACR17 sync enable, always clear VGACRB6 sync off")
Cc: stable@vger.kernel.org # v6.7+
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 drivers/gpu/drm/ast/ast_mode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 08db132acae85d19003b4361ade227454b6a0e3a..a42d0434cd7999ec2ef66a67cd9d81ff1dc9509a 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -857,6 +857,9 @@ static void ast_crtc_helper_atomic_enable(struct drm_crtc *crtc, struct drm_atom
 
 	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0x17, 0x7f, vgacr17);
 	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xb6, 0xfc, vgacrb6);
+
+	/* Firmware or a previous kernel may have left the screen disabled. */
+	ast_set_index_reg_mask(ast, AST_IO_VGASRI, 0x01, (u8)~AST_IO_VGASR1_SD, 0x00);
 }
 
 static void ast_crtc_helper_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261113-ast-vgasr1-sd-b28de7568e1a

Best regards,
-- 
Han Gao <gaohan@iscas.ac.cn>

