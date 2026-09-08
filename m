Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9052C79FA1
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:05:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43E3C10EDC2;
	Tue,  8 Sep 2026 22:05:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WSwgjDQo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57DB010EDBD
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:05:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D03BA6022F;
 Tue,  8 Sep 2026 22:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F3A1F00A3D;
 Tue,  8 Sep 2026 22:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788905113;
 bh=23Vj12u5uLbYesugUdSCoTd9GIaMsirFDh+buPYQwfY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=WSwgjDQoUcNDnpymdNQ8lHmy/aDUEZqJvuJg6XgjfJW0VLmi5L+ecJqoYllmxrCYE
 HBDIKPcKV6ga/Cr+cYKO/x/bFPI6thhg92SCFE1GaATiBVwBj9PNd97p5vnMgA2p3A
 taexFKrekUANqXEmw2sMvEpxfQ1ioqo/nETX4e1li0SKeBgARpMosHOJhyNMO1bXRy
 Ws+4yflhSZm1DXYMh1j+I3vEnWc+IOveFfPPzfxNlGNKS//hNWgXe3smIG9n72/lGb
 FvWwO++9RH6+LJ4s6cFN426iu1WXHXrJRt4BNDDgK+FLVNKQVq/p3GaPnTeIB5d4s9
 AvfkGwx6xE8EA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 08 Sep 2026 17:04:54 -0500
Subject: [PATCH v3 17/22] accel: ethosu: Reject reserved command encodings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-ethosu-fixes-v3-17-490fe215286f@kernel.org>
References: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
In-Reply-To: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
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

The command stream contains a 10-bit opcode and a two-bit command
control field. Reject reserved opcode and control encodings in the
switch default case so they cannot be interpreted differently by the
validator and hardware.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - new patch
---
 drivers/accel/ethosu/ethosu_device.h |  3 +++
 drivers/accel/ethosu/ethosu_gem.c    | 12 +++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_device.h b/drivers/accel/ethosu/ethosu_device.h
index 8e23fdbf7f8a..68e2969b6f79 100644
--- a/drivers/accel/ethosu/ethosu_device.h
+++ b/drivers/accel/ethosu/ethosu_device.h
@@ -91,6 +91,9 @@ struct gen_pool;
 #define NPU_KERNEL_DILATION_X		BIT(3)
 #define NPU_KERNEL_DILATION_Y		BIT(4)
 
+#define NPU_CMD_CTRL_CMD1		BIT(14)
+#define NPU_CMD_RESERVED_MASK		(BIT(15) | GENMASK(13, 10))
+
 enum ethosu_cmds {
 	NPU_OP_STOP = 0x0,
 	NPU_OP_IRQ = 0x1,
diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 578d1b5b955c..f4bd31018e56 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -170,9 +170,9 @@ static void cmd_state_init(struct cmd_state *st)
 
 static void cmd_state_set_reg(struct cmd_state *st, u16 cmd)
 {
-	u16 reg = cmd & ~BIT(14);
+	u16 reg = cmd & ~NPU_CMD_CTRL_CMD1;
 
-	if (cmd & BIT(14)) {
+	if (cmd & NPU_CMD_CTRL_CMD1) {
 		if (reg < NPU_CMD1_REGS)
 			__set_bit(reg, st->cmd1);
 	} else if (reg < NPU_CMD0_REGS) {
@@ -182,9 +182,9 @@ static void cmd_state_set_reg(struct cmd_state *st, u16 cmd)
 
 static bool cmd_state_reg_is_set(struct cmd_state *st, u16 cmd)
 {
-	u16 reg = cmd & ~BIT(14);
+	u16 reg = cmd & ~NPU_CMD_CTRL_CMD1;
 
-	if (cmd & BIT(14))
+	if (cmd & NPU_CMD_CTRL_CMD1)
 		return reg < NPU_CMD1_REGS && test_bit(reg, st->cmd1);
 
 	return reg < NPU_CMD0_REGS && test_bit(reg, st->cmd0);
@@ -733,7 +733,7 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 		cmd = cmds[0];
 		param = cmds[0] >> 16;
 
-		if (cmd & 0x4000) {
+		if (cmd & NPU_CMD_CTRL_CMD1) {
 			if (get_user(cmds[1], ucmds++))
 				return -EFAULT;
 
@@ -1054,6 +1054,8 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 			st.dma.src.len = st.dma.dst.len = addr;
 			break;
 		default:
+			if (cmd & NPU_CMD_RESERVED_MASK)
+				return -EINVAL;
 			break;
 		}
 	}

-- 
2.53.0

