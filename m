Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E81CA5FD9
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 07:34:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54AEF10F44F;
	Fri,  2 Oct 2026 07:34:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mba+1cut";
	dkim-atps=neutral
Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com
 [74.125.227.166])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A39210F43E
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 07:34:31 +0000 (UTC)
Received: by mail-pj2-f38.google.com with SMTP id
 98e67ed59e1d1-3a4b4770191so1753362a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 00:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790926471; x=1791531271; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gS7zKOv1EqOmDyg8WJGW/LMneMC1tlnOuM3sUdO8PR8=;
 b=mba+1cutXtbqfCGnuSEwpSI6YPrVTKO28UARTe29gh8JJvZj3wAJL6Gh3DZmwzFHuZ
 67LPmLwIpbIBPWcvEPiVdsgjD9Zw9CUndTYMGnTYypBHxaWvPvzdXWvjLJkCiFjyB11R
 daLV0cHzJcZJYc2pbdP6XKY2ugLBlZoJl6PdhPcMsQSpSQd6mHzMqCCPcpvTEGcZrovz
 O4c1gqXOLzrvLTDv7vq7IPqIVpnIbs5fVc/KxTh513Owut73JwuJeVShL4Les0sB+Ead
 diLx/bibnpFp3ZR4YdJr8ANKCdenn8XdnIj+0+VhBRR1pcdhmOTp4a4LUF0xD8VwAw0e
 QOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790926471; x=1791531271;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gS7zKOv1EqOmDyg8WJGW/LMneMC1tlnOuM3sUdO8PR8=;
 b=n4SuQkkAFobiITYr+95iowTAewPx3zQpdFyXhWuRSjReKjt3UvqCmL235sKHnfrmDV
 hvf6UFhdds3dqMl7JJ4Apm4/pI7nEcZ8MEr4FmTfOzfJq0PRTQ5YAgY3esSm1nutqBij
 sM3ecQc2tKnnqGEfUSzXtDKCJEPsr4sL02bUsfgI9E2et+I7fkFAyrQ/naB+P/O6wmMR
 Qi439m/cKDHDzSdHiF20UGkYfQ21J/GmE5sUzZu/m8NiAiokMBIt99kp4QLLcl11yWTN
 wQTCEF2bisnH444/3cwUb/swfgnqWkEg2bzjDfxZ4n+Oq8CN94c5WNFUD/PtLQ+6BGhe
 djBQ==
X-Gm-Message-State: AFq9FYKuTfbTxPtbmpfNg057zlaTEc/IT+UMtZUj9Ccit3kRHijM+9I/
 qh43eScOYpQylgTXQSfivKljMzsU0Y6dqkzVNcA/lPYQ4+B364Ca1gZN
X-Gm-Gg: AYBFou3JB42fuTedrhjLiLT/i/0NWltC4HoQPO15YkYn8l1zqagMYlmg3GcQcfsE8rX
 q0HzEAMp9joze0ab5eRH3LpNQsrTCndxlVbA1RVvRi19yk4/3UbXcf9CNOcAVPDtRxe06MMlvsf
 47CrcORmZYQLBy3uq8n4cKKpTkN2vdOCvq61+jJZ1MIUeTAzlIHB3sa4zPvvwIv1Q7XXJ25D+bm
 iwjwoZOqxSKOlQxHWEI28z6rc/v4hhrj5K/CsosTMVsSDashENLprZCvfFkJHRqR/upIlq7zZkk
 OUF2dFCABZWceAzvRFHhvI56kyAWokgh3HKatgoh4/vbbefDuF9vwT2LyXCrGljZd4ZHfCUkG70
 EXqGHyHk8INdXPlfVVDOJczV5tsHo42Vt44mNng+WeFjmPWLOxRUlujew+z+Za+uLq9+wf1zSwc
 iVPH9sFfHN86o27y4o0+ih2yylA7dwllftShPyWLuoJU9X1Hiy5TmWyRN+AgP9Iro+DM6dY+Tzu
 snl3lhww0gGMAX1rw1hBd3aVBvbPs+khYefA5Mqif92AVxJga06DAYfaeIOetne3l5oUZy2Co37
 +v/4/4Uyt8Utjo3keYJLwc31lbTIwZalQ2YUshAun5T5kwP7ZErGiXPnwA==
X-Received: by 2002:a17:90b:4c08:b0:3a2:ad6e:4435 with SMTP id
 98e67ed59e1d1-3a6ce5a1c77mr1889027a91.5.1790926470615; 
 Fri, 02 Oct 2026 00:34:30 -0700 (PDT)
Received: from 0xiviel.ip (122-63-128-121.mobile.spark.co.nz. [122.63.128.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f478e750sm7931692a91.13.2026.10.02.00.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 00:34:30 -0700 (PDT)
From: Eva Crystal <0xiviel@gmail.com>
To: Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sashiko-reviews@lists.linux.dev, Eva Crystal <0xiviel@gmail.com>,
 Sashiko AI review <sashiko-bot@kernel.org>
Subject: [PATCH] accel/amdxdna: bound the firmware-supplied mailbox ring
 against the mapped region
Date: Fri,  2 Oct 2026 19:37:39 +1300
Message-ID: <20261002063739.184503-1-0xiviel@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The mailbox ring start address and size both come from firmware, and
rb_start_addr is used directly as an offset into the ioremapped SRAM BAR:

	read_addr = mb_chann->mb->res.ringbuf_base + start_addr + head;
	header.total_size = readl(read_addr);

Nothing compares it against the length of that mapping. The only gate
between the firmware words and that readl() is is_power_of_2(rb_size) in
xdna_mailbox_start_channel(); the bounds tests in mailbox_get_msg() are
all relative to the firmware-supplied rb_size, not to the mapping. The
driver does record the true length, in struct
xdna_mailbox_res::ringbuf_size from pci_resource_len(), but that field is
never read anywhere.

So firmware can describe a ring that starts past the end of the BAR, and
the receive path reads there. Measured on an npu4 device (0000:06:00.1,
1022:17f0 rev 0x10, fw 1.1.2.64) by moving i2x_buf one page beyond the
window: the channel starts, the first firmware response drives
mailbox_get_msg(), and the peek readl() in mailbox_rx_worker faults on a
not-present page at exactly ringbuf_base + ringbuf_size. pcim_iomap()
maps the whole BAR, so one byte past the window is already past the
mapping. This happens during probe, before any device node exists, so no
userspace is involved. The oops kills the mailbox worker mid work item
and probe then wedges in drain_workqueue(). Only the read direction was
measured; nothing is claimed here about the write path.

Reject a channel whose ring does not lie entirely inside the mapping.
The check sits in xdna_mailbox_start_channel(), which is where all three
producers of this geometry converge: the management information block in
aie2_get_mgmt_chann_info(), the CREATE_CONTEXT response in
aie2_create_context(), and the mailbox information block in
aie4_mailbox_start().

Reaching this needs firmware that reports geometry it should not.
npu*.sbin is signed and loaded from root-owned /lib/firmware, so this is
not something an unprivileged user can drive. The file already validates
other firmware input on this path, the MGMT_MBOX_MAGIC check,
aie2_check_protocol() and the tail pointer in mailbox_get_msg(), so the
standard applied here is the one it already sets for itself.

Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/20260913214451.639251F000FF@smtp.kernel.org/
Signed-off-by: Eva Crystal <0xiviel@gmail.com>
---

This was first raised publicly by the Sashiko AI review bot on dri-devel on
13 September 2026, in its automated review of my own mailbox register-offset
series, where I then listed it as deferred in the v2 cover letter; this patch
is the measured follow-up to that report.

To be precise about scope, because that report raises two items and this patch
addresses only the first: it bounds the ring's placement and span against the
mapping. It does not bound rb_size from below, so it does NOT fix the second
item in the same report, where a tiny but still power-of-two rb_size (e.g. 2)
makes mailbox_get_ringbuf_size() - sizeof(u32) underflow and widens the
send-path wrap bound. I checked that case against this patch and the patch
accepts it: is_power_of_2(2) passes, and all four of the added clauses read
false on an honest rb_start_addr. That item is not mine to claim, it was
published in the same message, and if it is addressed it should be a separate
patch crediting the same report. I have not measured it; the underflow is on
the x2i/send side and the harness described below has no x2i override.

The mailbox ring start address and size are both supplied by firmware, and
rb_start_addr is used directly as an offset into the ioremapped SRAM BAR
without being compared against the length of that mapping. The only gate
between the firmware words and the first readl() on the receive path is
is_power_of_2(rb_size) in xdna_mailbox_start_channel(); the three bounds
tests inside mailbox_get_msg() are all relative to the firmware-supplied
rb_size rather than to the mapped region, and struct
xdna_mailbox_res::ringbuf_size, which the driver fills from
pci_resource_len() and which holds the true window length, is never read
anywhere in the driver. A firmware-supplied i2x_buf that places the receive
ring base past the end of the window therefore produces an out-of-window
read. This patch adds the missing comparison in
xdna_mailbox_start_channel(), which is the single point all three producers
of this geometry pass through (the aie2 management block, the aie2
CREATE_CONTEXT response, and the aie4 mailbox info block), and fails channel
start when the ring does not lie entirely inside the mapping.

How this was measured. On an npu4 device (0000:06:00.1, 1022:17f0 rev 0x10,
firmware amdnpu/17f0_10/npu_7.sbin, fw_version 1.1.2.64, HP OMEN 16-ap0xxx,
kernel 7.1.5) I built the driver out of tree with instrumentation that logs
the ring geometry and recomputes, for every ring access, whether the target
lies inside res.ringbuf_base + res.ringbuf_size. A module parameter
overrides exactly one firmware field, info_regs.i2x_buf, at the point it
lands in aie2_get_mgmt_chann_info(), i.e. upstream of every gate, so the
whole downstream path is the driver's real one. The override moved the
receive ring base to BAR2 offset 0x80000, one byte past a 0x80000 window.
The channel started with no complaint, the only check applied being
is_power_of_2(rb_size)=1, and the first response from firmware then drove
mailbox_get_msg(). The peek readl() faulted:

  BUG: unable to handle page fault for address: ffffd0db86b80000
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  Workqueue: xdna_mailbox mailbox_rx_worker [amdxdna]
  RIP: 0010:mailbox_rx_worker.cold+0xb6/0x43b [amdxdna]

The faulting address is exactly res.ringbuf_base + res.ringbuf_size in both
runs; pcim_iomap(pdev, 2, 0) maps the whole BAR, so one byte past the window
is already past the mapping and the PTE is zero. This happens during probe,
before /dev/accel/accel0 is created, so no userspace component is involved.
As a secondary effect the oops kills the mailbox worker mid work item, and
the RX timeout path then calls drain_workqueue() on a work item whose worker
is dead, so probe wedges in uninterruptible sleep and the module cannot be
unloaded.

The same override was run twice, from two independent boots, the second with
preconditions recorded beforehand (tainted 0, in-tree module, device bound).
Everything that identifies the defect was identical across the two runs: the
access type, the not-present PTE, the workqueue, the RIP symbol and offset,
the faulting instruction bytes, every frame and offset of the call trace, and
fault minus base equal to res.ringbuf_size. The only differences are the
ioremap base and the module load base, which a reboot is expected to move.
A benign control, the unmodified firmware geometry, was run through the same
instrumented build across two runs, with both the straight-line and the wrap
branch of the send path exercised, and all 513 bounded ring accesses landed
inside the window.

What I am not claiming. Both injection arms overrode the i2x (device to
host) direction only and left x2i untouched, so the send path ran on honest
geometry throughout. There is no measurement here of what an out-of-window
x2i->rb_start_addr would do at the memcpy_toio() in mailbox_send_msg(); no
write-path injection was attempted, and nothing in this report should be read
as a write-side or code-execution claim. What was measured is a 4-byte
out-of-window read that faults on a not-present page, and the probe wedge
that follows. The per-hwctx path is also uncovered: the second producer of
these same values is the CREATE_CONTEXT response in aie2_message.c, and
exercising it needs a userspace stack to create a hardware context, which
was not available on this box, so only the management channel was driven.
The instrumentation for the cq_pair path exists and never fired. The same
absence of a window check applies there on paper, and the fix sits in the
common function, but that path was not measured. Separately, a second arm
that overrode rb_size instead of rb_start_addr was accepted by the driver
and recorded as exceeding the window, yet produced no out-of-bounds access
in 137 accesses, so rb_size alone is not sufficient to leave the mapping;
rb_start_addr is.

The patched driver was then run on the same device, six arms across six clean
boots, each arm a single override of the same instrumented build (one module,
one sha256, no rebuild between arms). Honest geometry is accepted and the
device works normally: probe completes, /dev/accel/accel0 appears, 10 workload
passes return 100/100 queries, and 32 real ring accesses all land in window.
Four out-of-bounds geometries are rejected at channel start, before any ring
access, with no page fault, no oops, and a clean module unload in about two
seconds: rb_start_addr equal to the window length, rb_start_addr strictly
greater than it, an oversized span, and a non-power-of-two rb_size handled by
the gate already shipped. The rejection cascade is byte-identical across those
arms except for which gate names itself.

What that does and does not establish, clause by clause. The two receive-side
clauses are each exercised in isolation: the span clause by an oversized
rb_size on an honest rb_start_addr, and the placement clause by
rb_start_addr=0x100000 against a measured ringbuf_size=0x80000, where the span
clause cannot fire at all because ringbuf_size - rb_start_addr underflows in
size_t to 0xFFFFFFFFFFF80000. That is the arm which shows the two clauses are
not redundant. Two limits on it, stated rather than left to be inferred: the
kernel short-circuits at the placement clause and so never evaluates the span
clause on that input, which means the span clause's falsity there is
arithmetic over hardware-measured operands rather than an observed branch, and
I did not build a variant with the clause removed to show acceptance directly;
and that arm has had one hardware run, not two, so I am not describing it as
reproduced. The two x2i clauses were never injected at all and remain
unexercised, for the reason given above.

Finally, the injected values stand in for firmware rather than coming from
it. The module parameter writes the word where the firmware word lands, so
the path below that point is real, but the firmware itself was never made to
publish these values. npu*.sbin is signed and loaded from root-owned
/lib/firmware, so this is not reachable by an unprivileged user on a healthy
system; I am proposing it as the same kind of defensive check the file
already applies to other firmware input on this path (the MGMT_MBOX_MAGIC
check, aie2_check_protocol(), and the tail pointer in mailbox_get_msg()).

The full oops from both runs, the instrumented build, the runners, the
control run and the complete measurement record are available on request
rather than pasted here.

Eva Crystal (0xiviel)
XSource Security
https://xsourcesec.com

 drivers/accel/amdxdna/amdxdna_mailbox.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
index 05c3786de135..896b7503cf8d 100644
--- a/drivers/accel/amdxdna/amdxdna_mailbox.c
+++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
@@ -518,6 +518,19 @@ xdna_mailbox_start_channel(struct mailbox_channel *mb_chann,
 		return -EINVAL;
 	}
 
+	/*
+	 * The ring start address and size are supplied by firmware and are
+	 * used as an offset into the mapped ring buffer region. Check that
+	 * the ring described lies entirely inside it.
+	 */
+	if (x2i->rb_start_addr >= mb_chann->mb->res.ringbuf_size ||
+	    x2i->rb_size > mb_chann->mb->res.ringbuf_size - x2i->rb_start_addr ||
+	    i2x->rb_start_addr >= mb_chann->mb->res.ringbuf_size ||
+	    i2x->rb_size > mb_chann->mb->res.ringbuf_size - i2x->rb_start_addr) {
+		pr_err("Ring buf does not fit in the mapped region\n");
+		return -EINVAL;
+	}
+
 	mb_chann->msix_irq = mb_irq;
 	mb_chann->iohub_int_addr = iohub_int_addr;
 	memcpy(&mb_chann->res[CHAN_RES_X2I], x2i, sizeof(*x2i));
-- 
2.53.0

