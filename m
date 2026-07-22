Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7069C531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FE8A10EFFA;
	Thu, 23 Jul 2026 07:09:36 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6298510E29E;
 Wed, 22 Jul 2026 04:21:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [111.196.245.140])
 by APP-05 (Coremail) with SMTP id zQCowAAHdT9DRWBqREu7AA--.23709S2;
 Wed, 22 Jul 2026 12:21:23 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] drm/nouveau/gsp: validate sequencer command span
Date: Wed, 22 Jul 2026 12:21:23 +0800
Message-ID: <20260722042123.39900-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAHdT9DRWBqREu7AA--.23709S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJryfXFW5KrW3Xw4rWF4UArb_yoW5JF1Upr
 s5G3WFyFWDWa1xJFyxAF15Xa4Yy34vya43Cr9rZryDAFs7JrW0yr1Utr4Yv34Sgr4fC34F
 yF95GayxuryUG3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9S14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F
 4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
 628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
 IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
 MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JV
 W5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_
 Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr
 1UYxBIdaVFxhVjvjDU0xZFpf9x0JUDOz3UUUUU=
X-Originating-IP: [111.196.245.140]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Mailman-Approved-At: Thu, 23 Jul 2026 07:07:31 +0000
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

The GSP sequencer RPC contains a variable command stream. The handler
currently walks commands using the stream header length without first
proving that the stream, each command payload, or a register-save slot
fits in the received RPC and its fixed save area.

Validate the stream and each command against the RPC payload before
walking it, and reject register-save indexes beyond the fixed save
array.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 .../drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
index f544afa12b6b..00417bbccc12 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
@@ -1010,15 +1010,30 @@ r535_gsp_msg_run_cpu_sequencer(void *priv, u32 fn, void *repv, u32 repc)
 	struct nvkm_subdev *subdev = &gsp->subdev;
 	struct nvkm_device *device = subdev->device;
 	rpc_run_cpu_sequencer_v17_00 *seq = repv;
-	int ptr = 0, ret;
+	u32 ptr = 0, payload;
+	int ret;
+
+	if (repc < offsetof(rpc_run_cpu_sequencer_v17_00, commandBuffer) ||
+	    seq->cmdIndex >
+	    (repc - offsetof(rpc_run_cpu_sequencer_v17_00, commandBuffer)) /
+	    sizeof(seq->commandBuffer[0])) {
+		nvkm_error(subdev, "invalid sequencer command buffer size\n");
+		return -EINVAL;
+	}
 
 	nvkm_debug(subdev, "seq: %08x %08x\n", seq->bufferSizeDWord, seq->cmdIndex);
 
 	while (ptr < seq->cmdIndex) {
 		GSP_SEQUENCER_BUFFER_CMD *cmd = (void *)&seq->commandBuffer[ptr];
 
+		payload = GSP_SEQUENCER_PAYLOAD_SIZE_DWORDS(cmd->opCode);
+		if (seq->cmdIndex - ptr < payload + 1) {
+			nvkm_error(subdev, "truncated sequencer command\n");
+			return -EINVAL;
+		}
+
 		ptr += 1;
-		ptr += GSP_SEQUENCER_PAYLOAD_SIZE_DWORDS(cmd->opCode);
+		ptr += payload;
 
 		switch (cmd->opCode) {
 		case GSP_SEQ_BUF_OPCODE_REG_WRITE: {
@@ -1064,6 +1079,9 @@ r535_gsp_msg_run_cpu_sequencer(void *priv, u32 fn, void *repv, u32 repc)
 			u32 addr = cmd->payload.regStore.addr;
 			u32 slot = cmd->payload.regStore.index;
 
+			if (slot >= ARRAY_SIZE(seq->regSaveArea))
+				return -EINVAL;
+
 			seq->regSaveArea[slot] = nvkm_rd32(device, addr);
 			nvkm_trace(subdev, "seq save %08x -> %d: %08x\n", addr, slot,
 				   seq->regSaveArea[slot]);
-- 
2.43.0

