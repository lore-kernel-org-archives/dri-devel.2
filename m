Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70047C88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 21:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A48710EA38;
	Sun, 13 Sep 2026 21:34:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nr3lyjTo";
	dkim-atps=neutral
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E983410EA38
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:34:24 +0000 (UTC)
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-85469e25400so1008853b3a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 14:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789335264; x=1789940064; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0B8hNNWkyqRTAPtToZa4Ta80Tqs8xdDUvBUMhZpcU9I=;
 b=nr3lyjToZmsgeZWltabEAo533wtYQUynl88qU6Bzqowlqbi6HWGd2Wwd/zu5ftlhEp
 k8HFfu7vES4MJzsx5UHSbm3sSKcY16i+pX72tmerplpuG4ISXr3zqqffnUdkl3qaN8RN
 /4jqirQVnVpuFcT6VkyiatujMP3d1ZwBlXMAPQYbwVYu6Lz6X5hbPOmBifDhI20kZeqO
 gGLeO7R1NThbGakV71Sfi2HM8Bvfmi2MoW1iQiN6MJQwaa1fDQ3nqfsYLXET94gw4UtF
 xKprFIXVsj+IxL0QprtaJ7ftxcLXaDfjvxht8mYvT01RNQWCBIdMIetiKpwyin2jCeF6
 p9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789335264; x=1789940064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0B8hNNWkyqRTAPtToZa4Ta80Tqs8xdDUvBUMhZpcU9I=;
 b=kd9INzWudlKw7h3d+TWmR3lYpSL4/+NUScuFIzj+QK+/XX9okB194WcLd1wrllQuBZ
 bHwXeXKPZ5vx2LDES2ZGZvD6XNZrXTO7u6j9MThVjPjWt8ghrwpMe2TtbvoCh1c+BA7E
 kxAFEf/z4jvZmtXN/nw+jQqazjbT3lH5NS39ZJxzEmq2lkI5XifzgNVanJfcJUlrjAve
 0o2QECVTGdktQgeMcToVYFt5a973TwQdGHU8RmCWeJYmmK24UCRM2h2Ygw6P/5OwFkpT
 8qLJzgzHCUr4NR7UYI3xPu4EnAYOfstySTnfMjziD2aLKy69P/eHYGIHoNj1tn6gEw2h
 T4wA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4HnRHWOoyP2KRVPLWzeCevPmiunmuaFMob3kBdM7rX+1oK0toKEflctMKYkt4hRBS+COE6bzPtmQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kgbuh0kQfT3zrOoPRuTEFAkZniCmrG1C4CGItaR1EQFvwBiLPb
 IbWNSeVCELRaJUdMb1MNJtHISJLqj8l/lVwvuxPXQGJAwG2l57t0vLjK
X-Gm-Gg: AYBFou3+dhb2ECsSAlrebRjhk6IUerBwk07stcaYVTEF5aagVWu3e+DHU1/1NzLZ2A/
 0vcb3TUWnw647hr2UeJt8idFpHlhnxUZf0nUAz80tXf6VklQaOs801fT8Clo4aZYaqy4g0tbVfd
 FAv3/5AYUtt+sTKRZW88eKFIaDGbBc25sMr1J1lB+jUtpx8dYLdrOssh/2HGMO3mQTWl+VP19A3
 isNoNF11aSW62GfBiqWkx1U99Qo2FqFl59xNCZsOd+LRmkmOw8YavH7IEZVJqD6JV+BMs/j3xFo
 LdGK9LMWEmtyC3wH94RZyLESFQrzI6mnhJUJWcsCyf0csGUTjWZ3yYHUM2VrTgM+FnDD3siDCe9
 yR2+F9WqtDAIQqjBln/nYgxPjoS+NeIla4HnnmrZBnCuW1FdprVaw9dglEYbnYn6C+4CGMQX4t2
 gvt0WTxzkQWc3SksiKH+pEqB649ieTLDwSN/BOmy3ENUrRS80P/YKV7iyNMsNpanaVH3XSrPTEb
 K4g6dvAW/QJIzpnXvJUVmxOUeD8SWTODvk06hjqwMCJG0ywg6MihmJCxhTOLLckS32mjJ7xZt1D
 WuGFEnezhkJlWPUtPsmm6WdX288TmvGTccVLPQZwBJxO
X-Received: by 2002:a05:6a00:21d1:b0:84e:e741:174f with SMTP id
 d2e1a72fcca58-86b2f70a205mr22719967b3a.7.1789335264423; 
 Sun, 13 Sep 2026 14:34:24 -0700 (PDT)
Received: from 0xiviel.ip (122-63-135-80.mobile.spark.co.nz. [122.63.135.80])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b291c5e8dsm3477094b3a.32.2026.09.13.14.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 14:34:24 -0700 (PDT)
From: Eva Crystal <0xiviel@gmail.com>
To: min.ma@amd.com,
	lizhi.hou@amd.com,
	Min Ma <mamin506@gmail.com>
Cc: Eva Crystal <0xiviel@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] accel/amdxdna: bound the firmware-supplied mailbox
 register offsets
Date: Mon, 14 Sep 2026 09:31:56 +1200
Message-ID: <cddcbf5989cdbf6da94855152a34451ffa07860b.1789334558.git.0xiviel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789334558.git.0xiviel@gmail.com>
References: <cover.1789334558.git.0xiviel@gmail.com>
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

Require 32 bit alignment in the same place. All six users of these
offsets go through mailbox_reg_read() or mailbox_reg_write(), whose
bodies are a bare readl() and writel(); the driver has no narrower or
wider mailbox accessor, so an offset that is not a multiple of four
cannot name a register in this block whatever else is true of it.
mailbox_get_msg() already pairs a range check with IS_ALIGNED(tail, 4)
for the ring tail firmware writes, for the same reason.

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
 drivers/accel/amdxdna/amdxdna_mailbox.c | 37 +++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
index cc8865f4e79c..a390836fe797 100644
--- a/drivers/accel/amdxdna/amdxdna_mailbox.c
+++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
@@ -112,6 +112,33 @@ static u32 mailbox_reg_read(struct mailbox_channel *mb_chann, u32 mbox_reg)
 	return readl(ringbuf_addr);
 }
 
+/*
+ * Firmware describes where a channel's head and tail registers live, as raw
+ * offsets into the mailbox mapping: in the management mailbox block it writes
+ * into SRAM for the management channel, and in the CREATE_CONTEXT response for
+ * a hardware context. Both helpers above add such an offset straight to
+ * mbox_base, so check it against the shape of that mapping first.
+ */
+static bool mailbox_reg_in_range(struct mailbox_channel *mb_chann, u32 mbox_reg)
+{
+	struct xdna_mailbox_res *mb_res = &mb_chann->mb->res;
+
+	/*
+	 * Every access through the two helpers above is a readl() or a
+	 * writel(), so an offset has to be 32 bit aligned, and leave room for
+	 * 32 bits, to name a register in this mapping at all.
+	 */
+	return IS_ALIGNED(mbox_reg, 4) &&
+	       (u64)mbox_reg + sizeof(u32) <= mb_res->mbox_size;
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
@@ -518,6 +545,16 @@ xdna_mailbox_start_channel(struct mailbox_channel *mb_chann,
 		return -EINVAL;
 	}
 
+	/* A zero iohub_int_addr means the platform has no such register. */
+	if (!mailbox_chann_res_in_range(mb_chann, x2i) ||
+	    !mailbox_chann_res_in_range(mb_chann, i2x) ||
+	    (iohub_int_addr && !mailbox_reg_in_range(mb_chann, iohub_int_addr))) {
+		dev_err(mb_chann->mb->dev,
+			"Mailbox register offset unaligned or outside the %zu byte mapping\n",
+			mb_chann->mb->res.mbox_size);
+		return -EINVAL;
+	}
+
 	mb_chann->msix_irq = mb_irq;
 	mb_chann->iohub_int_addr = iohub_int_addr;
 	memcpy(&mb_chann->res[CHAN_RES_X2I], x2i, sizeof(*x2i));
-- 
2.53.0

