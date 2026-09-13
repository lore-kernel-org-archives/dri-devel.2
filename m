Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CF2C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCFB410E173;
	Sun, 13 Sep 2026 20:05:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jHHK9Aiv";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBB8810E173
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 20:05:20 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cbee846deecso3663168a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 13:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789329920; x=1789934720; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vsxyHcXIO8kCg+BbasfKONF82xj3AL3NR/R2G4eOqwY=;
 b=jHHK9Aivazb2aiSiRKSoZLMKfeLcMIotWZhi8rzBU9UJ+JwtgPo3oSE2dnELd+3pSv
 yVCbncg9ZT6yEFCZdJJ57DKAsHw5y706xd8z3h4zkAwiAjnI+mKwpARMCZZ3IwhFw1oi
 KAgP3HiYLd+1NIR++LPkAnZxs7zF9z5u2ySX4foO9IAZYTgybCTxKGUe4UU+/Gppcn3x
 OXf4x4PEZhOyG5xO35tpYuY2jvGoBAprawA88EXcMn9JZGCakhJ8APgRqUnO5gdj10Jg
 NlKxxecUrha6Qkme3Y6kWlIT+ZyMtntJL16PD2gg6qS1ohxizpUBEGUC1iBrdUjNmIj/
 NFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789329920; x=1789934720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vsxyHcXIO8kCg+BbasfKONF82xj3AL3NR/R2G4eOqwY=;
 b=k7uOjxg8Q+37KH18n/VPhF56DibNyDYAIhb9iXlnxVeK21uLiBi6xtjQnUb7GrHJCl
 dGQKtD6hjt76LtjN1bpan8Dwj6zGYjeONwUI/t3nq3tnh3XzqHYat3O7uQnUer7JSJS+
 Dj2/PZdOESklOIvt86l5lmzHrHxChMlDr5P0Q+g+LzjFgMQrJs1lqjvyA4WXG+Sb2GEJ
 fhIxn2C2UnQC+Aof3ngQYoHHl8INUM1s3aZFHI02KC0Ng+1u1RxE/B4lI+J9ISwS65hy
 lM+ChRtNTWe+ZJzNSgb+oJWjqzOsqW/iPDb2KdxHFYFFJySnra8k9V6hpTi1lEjBhzFf
 fXig==
X-Gm-Message-State: AFuF++lMbFou1/ceJPpUFGavr52gRxzk9Wp/HpOaGtjQpA8oRbyOsW9R
 hwAPkUGJYly51k95lmu1yOO1M+XFxRrbeL+RLHeW2eGrFIB2I0Jy803pRvfV+ADyT1U=
X-Gm-Gg: AYBFou1FZD+3lzjhgyiLaWoAmqLiirDg/WetVGMnS4ZR1bWcsLyExXK/2IctRyEajXF
 qtfDe+/dxn216Yq2sd1fxtQmOOYrdrQv4KliMr5LKV7bte5++5h0IOciQK8Dz7+M0Eu33Anc/GG
 z7h3nrQfdqm3eYNS9hjtJeeDTQ5mO6X9Ca32mhOvllcpS8S0pXMqrJMIpNYo+osyMuMuBZljH7j
 2M5u8giEzeC3IFfR5ex4/SdO2Er57CiNjFnqodu2VhYAew0nsHRhva2MYSQHcDAVMSxpsqvdxlh
 JZB9OYWypp4r9EtpaHMo9AIbsueTcAXeWEPpTS3WmdzNYMJqvJfqzE7iaLHcDM+tn+CjCTdBj7T
 juElafB3s/vD8Va2Sj7X9GQAOqRgc/GH5udAknLZqprdXB4w/fn51v3xIeepUNjK6vYSlRP5g6c
 0OCA6LJRV6D6KGGsDwcjwshLJYtaPTmcOOg/vx8Zo7CGGwuNdQPj2hJWIt9x2gpKRQdKkCOdew7
 KQfb8WsLSGqmTVik8fdCv++UeApHjRg3tMoUe8HunSyl9+AEjl9my6Yg+jB9ZD5+SJ85Di9HRJI
 qMiFvAXApWsVNGiZldL0obzLZq9YTqAFOvs8ZC55sKqi
X-Received: by 2002:a17:90b:5823:b0:398:bdb0:adb7 with SMTP id
 98e67ed59e1d1-39d9c0aad8dmr27136272a91.16.1789329920331; 
 Sun, 13 Sep 2026 13:05:20 -0700 (PDT)
Received: from 0xiviel.ip (122-63-135-80.mobile.spark.co.nz. [122.63.135.80])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39da64d4bdfsm3676635a91.0.2026.09.13.13.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 13:05:19 -0700 (PDT)
From: Eva Crystal <0xiviel@gmail.com>
To: Min Ma <mamin506@gmail.com>,
	Lizhi Hou <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Eva Crystal <0xiviel@gmail.com>
Subject: [PATCH 1/1] accel/amdxdna: bound the firmware-supplied mailbox
 register offsets
Date: Mon, 14 Sep 2026 08:02:12 +1200
Message-ID: <20260913200212.133126-2-0xiviel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913200212.133126-1-0xiviel@gmail.com>
References: <20260913200212.133126-1-0xiviel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Firmware chooses where a mailbox channel's head and tail registers live
and reports them to the driver as device addresses: in the management
mailbox block it writes into the SRAM BAR, read by
aie2_get_mgmt_chann_info(), and in the CREATE_CONTEXT response, read by
aie2_create_context() for every hardware context. AIE2_MBOX_OFF() turns
each one into a raw byte offset into the mailbox mapping, and both
aie2_hw_start() and aie2_create_context() derive the mailbox interrupt
register from one of them by adding 4. On AIE4, aie4_mailbox_start()
takes the same four offsets straight out of the mailbox_info block.

None of them is checked. mailbox_reg_read() and mailbox_reg_write() add
the offset to xdna_mailbox_res::mbox_base and hand the result to
readl()/writel(), so an offset past the end of that mapping is an MMIO
access outside it, at a kernel virtual address the driver has no claim
to. AIE2_MBOX_OFF() is an unsigned 32-bit subtraction: a reported
address below the aperture base does not yield an obviously invalid
small offset but wraps to a very large one, and the + 4 for the
interrupt register can wrap independently of the value it derives from.

The bound is already there. xdna_mailbox_res::mbox_size is the exact
length of the mapping pcim_iomap() produced - the device's mailbox
window size, or the BAR length when the device does not override it -
and it sits in the same struct as mbox_base. The driver stores it and
never reads it.

Check the four register offsets and the interrupt register against
mbox_size in xdna_mailbox_start_channel(). Every mailbox register
access reads mb_chann->res[] or mb_chann->iohub_int_addr, and that
function is the only writer of either, so it is the one point every
firmware-supplied offset passes through, for the management channel,
for a hardware context and for AIE4 alike. It is also where the derived
interrupt register arrives, as a parameter, which a check at the
producing sites would not cover. A zero interrupt register keeps its
existing meaning of "this platform has no such register".

Failing there rejects the channel before any offset reaches readl() or
writel(). aie2_hw_start() and aie4_mailbox_start() unwind and fail the
probe or resume; aie2_create_context() frees the channel and destroys
the firmware context, so AMDXDNA_CREATE_HWCTX returns an error to
userspace instead of leaving a channel that accesses outside its
mapping.

This is the firmware-to-driver trust boundary. Whether the part can
report a register outside the mailbox aperture is not established and
there is no reproducer. The offsets are simply the one firmware-supplied
value this driver leaves unbounded, against a limit it already computes
and stores.

Signed-off-by: Eva Crystal <0xiviel@gmail.com>
---
 drivers/accel/amdxdna/amdxdna_mailbox.c | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
index cc8865f4e79c..0c4cb8beb26e 100644
--- a/drivers/accel/amdxdna/amdxdna_mailbox.c
+++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
@@ -112,6 +112,28 @@ static u32 mailbox_reg_read(struct mailbox_channel *mb_chann, u32 mbox_reg)
 	return readl(ringbuf_addr);
 }
 
+/*
+ * Firmware describes where a channel's head and tail registers live, as raw
+ * offsets into the mailbox mapping: in the management mailbox block it writes
+ * into SRAM for the management channel, and in the CREATE_CONTEXT response for
+ * a hardware context. Both helpers above add such an offset straight to
+ * mbox_base, so bound it against the size of that mapping first.
+ */
+static bool mailbox_reg_in_range(struct mailbox_channel *mb_chann, u32 mbox_reg)
+{
+	struct xdna_mailbox_res *mb_res = &mb_chann->mb->res;
+
+	/* Every access through the two helpers above is 32 bits wide. */
+	return (u64)mbox_reg + sizeof(u32) <= mb_res->mbox_size;
+}
+
+static bool mailbox_chann_res_in_range(struct mailbox_channel *mb_chann,
+				       const struct xdna_mailbox_chann_res *res)
+{
+	return mailbox_reg_in_range(mb_chann, res->mb_head_ptr_reg) &&
+	       mailbox_reg_in_range(mb_chann, res->mb_tail_ptr_reg);
+}
+
 static inline void mailbox_irq_acknowledge(struct mailbox_channel *mb_chann)
 {
 	if (mb_chann->iohub_int_addr)
@@ -518,6 +540,16 @@ xdna_mailbox_start_channel(struct mailbox_channel *mb_chann,
 		return -EINVAL;
 	}
 
+	/* A zero iohub_int_addr means the platform has no such register. */
+	if (!mailbox_chann_res_in_range(mb_chann, x2i) ||
+	    !mailbox_chann_res_in_range(mb_chann, i2x) ||
+	    (iohub_int_addr && !mailbox_reg_in_range(mb_chann, iohub_int_addr))) {
+		dev_err(mb_chann->mb->dev,
+			"Mailbox register offset outside the %zu byte mailbox mapping\n",
+			mb_chann->mb->res.mbox_size);
+		return -EINVAL;
+	}
+
 	mb_chann->msix_irq = mb_irq;
 	mb_chann->iohub_int_addr = iohub_int_addr;
 	memcpy(&mb_chann->res[CHAN_RES_X2I], x2i, sizeof(*x2i));
-- 
2.53.0

