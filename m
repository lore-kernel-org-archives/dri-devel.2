Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5588C88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE19410E11F;
	Sun, 13 Sep 2026 20:05:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FaE9NQNR";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BF8C10E11F
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 20:05:07 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc4ab4fe290so325821a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 13:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789329907; x=1789934707; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Sf2mM+0FSeHh2dziQvsLoHJODGB0iyYj41aqVIfwGU0=;
 b=FaE9NQNR1Xowxmjav4o4nncx8Mmrv3oKLArIMlKYnPw8j14LykPG3mZmRFKVDwINWl
 Iiz7aTagWCoPwtuICVNDUUmteZ0D+j+H61vMs2TRvH/54gIg449b/EFihpsuqaBwbIai
 ZbSWUnPuqZqM0z5PBcOL7wGisuOX1tAlJIm+THE8ReOpBhLnsiZMT8YWz7WTG+JKNzV/
 VlGwg6mLWuWYu+vXG7Izlbd3NMUQyx/NUlL1WjXMW478GufOP0e7kDsFc5BwIMA0pULC
 6Zo0ZcQFAc0w0DUEO0XS9HXun97vJgOVZfAkMOdfuIFxBkCSvth5AODqEEtr2aCLS+cH
 j3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789329907; x=1789934707;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sf2mM+0FSeHh2dziQvsLoHJODGB0iyYj41aqVIfwGU0=;
 b=KWfOo0+8OvKHwlJ5HWiQBzif6pT+UuXn+FRO5R59WC1iyskSffK6Nd6rEPPinqwNTf
 amyp6cqjMp9cXQtb1cIEDYeLpFBxPsWJvzKJ92BDuhJR1iI2dln6tcoRXKY738/3gt1v
 tDJG48FCu4YB7rPH8kSAUHnlNqDGKPVOvS/83ACYcYhvHoaLJfKIBKh6mCTMYridKCzO
 Fzw6zlOZeNHTJJ6qSkwkeOrMng4dHGIBG0P7lKu11ped9H36uef6Tk6tuREXJmGeYv+h
 6HTNVH9CVjcY58WXNn9dm4V5JTbO5a2olLBt2B3S1jq8cOODwDkryLKJ7pQH5u1WHhc5
 85jw==
X-Gm-Message-State: AFuF++kr7+IPliuhSiCnKR4nqGDvFnpSiDfkjL3LtZeFBNA73y1JoR43
 UAIfRZm65vAzhXZz4R2nD5aFZ5hPArqv457A8RXJJbS2Ijmz5T0MqgvG
X-Gm-Gg: AYBFou1WXLxqgZCB0A/1l2bRwteVrhbhX8rqv1XZzyZsBa2RQRV6Fh3YWQJ6KtfCYP/
 Jzcv2BiitkW15+nKsnsyhdrEM19cwECgXyNXHvb6BOLbPTaXNAsh6sXteI4fAMuZCjXAgQw0b87
 16abjXoJUQrK3P5Y71vsu/iHBcv2PEINkRdabQMeSNs+o7oNLE1bS8uCYuv8/Gb5YpoMYR2koFw
 kPGdjTGKAfOiOsrfVH/ZiM26BoJCJDAzKIiuZB74krI4y+KpN35off9B6QN4/GSd1ZFvXztWZ4a
 oiA1TqA02TDfygmE0FAF4IXxmhsllR5r6fBlSKFXKL2q8RKptrHxrndzEoAgFFUzvJTE4cCGfYs
 KpFdRPR95zqclBsZj9/E1TlRt2jAZ+r4HKinbAYSViuIk6rc16WAT0eZahVdWg3zx07iZm5UsmV
 j7JRTIQrAQz/o6Yc0SMhKTE+1W/aE5EGItu5wCRbNKdkU+M2ZfyIIxlUyTDQqiyTba9sulNHytB
 mbuB0/MqRXuA2t66qml+OY5FkMRlh44NNWccXWzlX1cPKIFbx8Z/UlakbfZstVNqgcwqLDHD+5B
 JpQPoSGrC8sXCfkNwJiddc2ZssL1kZUVdWZdsl9icnVa2lgNZ8EGJgY=
X-Received: by 2002:a17:90a:28f:b0:39d:b57e:b47d with SMTP id
 98e67ed59e1d1-39dd55d31e4mr2699554a91.8.1789329906574; 
 Sun, 13 Sep 2026 13:05:06 -0700 (PDT)
Received: from 0xiviel.ip (122-63-135-80.mobile.spark.co.nz. [122.63.135.80])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39da64d4bdfsm3676635a91.0.2026.09.13.13.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 13:05:06 -0700 (PDT)
From: Eva Crystal <0xiviel@gmail.com>
To: Min Ma <mamin506@gmail.com>,
	Lizhi Hou <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Eva Crystal <0xiviel@gmail.com>
Subject: [PATCH 0/1] accel/amdxdna: bound the firmware-supplied mailbox
 register offsets
Date: Mon, 14 Sep 2026 08:02:11 +1200
Message-ID: <20260913200212.133126-1-0xiviel@gmail.com>
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

This is a change at the firmware-to-driver trust boundary, and I would
rather be plain about that before anything else. The values in question
come from NPU firmware, not from userspace. There is no proof of
concept, I have reproduced nothing, and it is not established that the
part can report a mailbox register outside the mailbox aperture at all
-- I could not locate the producing code in the firmware image at
instruction level, so I make no claim about the emittable range, in
either direction. What I can show is static: the driver takes four
register offsets from firmware, computes and stores the exact bound
they should be checked against, and never checks them.

The shape of it. Firmware reports where a mailbox channel's head and
tail registers live: in the management mailbox block it writes into the
SRAM BAR, read by aie2_get_mgmt_chann_info(), and in the CREATE_CONTEXT
response, read by aie2_create_context() for every hardware context.
AIE2_MBOX_OFF() converts each to a raw byte offset into the mailbox
mapping. aie2_hw_start() and aie2_create_context() each derive the
mailbox interrupt register by adding 4 to one of them. On AIE4,
aie4_mailbox_start() takes four such offsets straight out of the
mailbox_info block. mailbox_reg_read() and mailbox_reg_write() then add
the offset to xdna_mailbox_res::mbox_base and hand the result to
readl()/writel(). Nothing in between compares it to anything.
AIE2_MBOX_OFF() is an unsigned 32-bit subtraction, so a reported address
below the aperture base does not fail closed but wraps to a very large
offset, and the + 4 can wrap independently of the value it derives from.

Why this is a patch rather than generic hardening: the driver already
treats firmware as an input to validate, in at least six places. It
rejects a bad management-mailbox magic (aie2_pci.c:93), checks the
reported protocol version (aie_check_protocol(), aie.c:68), range- and
alignment-checks the ring tail firmware writes (amdxdna_mailbox.c:294),
rejects an out-of-range device revision (aie2_message.c:1262), bounds a
reported error count against the buffer that has to hold it
(aie2_error.c:312), and -- the closest parallel -- bounds a
firmware-returned fw_ctx_id against priv->hwctx_limit before using it as
an array index, in aie2_fill_hwctx_map() at aie2_pci.c:917. That last
one is this patch in miniature: same source, same driver, a stored limit
consulted before use. The mailbox register offsets are the one
firmware-supplied value left unbounded, and the limit they should be
bounded against, xdna_mailbox_res::mbox_size, is assigned on the line
after the mbox_base they are added to, in the same struct, and then read
nowhere in the driver.

For precedent on the boundary itself -- not as a claim about this driver
-- accel/ivpu, the other NPU driver in accel/, took four fixes in 2026
whose entire content is a firmware-supplied value used without
validation. Each was assigned a CVE and each was backported across
several stable branches:

  commit d9faef564438 ("accel/ivpu: Fix signed integer truncation in
  IPC receive") -- CVE-2026-53202
  commit dd1311bcf0e6 ("accel/ivpu: Add bounds checks for firmware log
  indices") -- CVE-2026-53205
  commit 1d0b597facdd ("accel/ivpu: Add bounds check for firmware
  runtime memory") -- CVE-2026-53206
  commit ddb44baed257 ("accel/ivpu: Reject firmware log with size
  smaller than header") -- CVE-2026-72089

I cite them only for the principle that in this subsystem "firmware
reported it" has been treated as a reason to check a value rather than a
reason to trust it. They say nothing about whether this driver has a
real problem.

On impact, stated conservatively. This is not a controlled write
primitive and I am not presenting it as one. The offset is chosen by
firmware, not by an attacker: I have not shown any path by which
userspace influences what firmware puts in cq_info.head_addr, and I did
not look for one. The data written is not attacker-chosen either -- the
writes are a ring pointer the driver computed, or the constant 0 for the
interrupt acknowledge. The landing address is mbox_base + offset, where
mbox_base is a vmalloc-space address an attacker neither controls nor
observes. The realistic outcome of an out-of-range offset is an MMIO
access outside the ioremap: either a fault at a kernel virtual address,
from the rx workqueue or from the ioctl path, or a write into whatever
else is mapped there. On parts where the mailbox BAR is also the public
register BAR, an overshoot that stays inside the BAR reaches public
registers instead of mailbox head and tail. That is a landing-zone
detail, not an impact upgrade.

The patch itself is one check, in xdna_mailbox_start_channel(). I
considered putting the bound in mailbox_reg_read()/mailbox_reg_write()
instead, since that is where an offset meets readl()/writel(), but the
six call sites argue against it: two return void and two return a u32 in
which every value is a legal register value, so a guard there could only
silently skip a write or fabricate a read, and it would sit in the
per-message IO path. All six take their offset from mb_chann->res[] or
mb_chann->iohub_int_addr, and xdna_mailbox_start_channel() is the only
writer of either, so it is a genuine choke point: the management
channel, every hardware context and the AIE4 path all pass through it,
and the derived interrupt register arrives there as a parameter, which a
check at the producing sites would not cover. It already validates the
ring sizes, it already returns int, and all three callers handle a
failure -- aie2_hw_start() and aie4_mailbox_start() unwind and fail the
probe or resume, and aie2_create_context() frees the channel and
destroys the firmware context, so AMDXDNA_CREATE_HWCTX returns an error
to userspace rather than leaving a channel that accesses outside its
mapping.

No Fixes: tag, deliberately. The defect dates to the driver's initial
merge in v6.14-rc1, but this patch does not apply to any of the three
commits that introduced it, and I checked rather than assumed: at that
point the accessors used a u64 address with (void *) casts, and the
function this patch changes did not exist -- it was
xdna_mailbox_create_channel(), returning a pointer and NULL on error
rather than an int. A Fixes: tag would point at trees the patch cannot
be applied to without being rewritten. Say the word if you would rather
have the provenance recorded and deal with the backport separately.

Based on commit d681d7ef617e ("Merge misc regression fixes that seem to
have fallen through the cracks"). Builds clean on x86_64 with
CONFIG_DRM_ACCEL_AMDXDNA=m, gcc 15.3, W=1, no new warnings;
checkpatch --strict reports nothing. Not tested on hardware: I have no
way to make firmware report an out-of-range offset, which is the same
gap described at the top.

Eva Crystal (1):
  accel/amdxdna: bound the firmware-supplied mailbox register offsets

 drivers/accel/amdxdna/amdxdna_mailbox.c | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

-- 
2.53.0

