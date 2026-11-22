Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBD7606A339
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 05:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddfi9yX1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01F7C10E351;
	Sun, 22 Nov 2026 05:12:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DE6810E327;
 Sun, 22 Nov 2026 05:12:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9A4404013A;
 Sun, 22 Nov 2026 05:12:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795324366;
 b=M4yRKcgK1Rxw0NsGjPCnMpeCM8ivuAv0Ik9Qvh7rNroIxj4FEkmjHKcSybuPNkPa3Jk/
 77GNrQvHIIa4zPTQjlvJ35zXx9+kxHOjdKC1wvAxlMZdWw8YLt6hRw1Uu9HdPa38TTY/B
 IFAwkI0l/dA1O6ZlO3da8lOYkS6U0n8w5OkSjrnwccpkrODJqTxLqBDqSloEmlMtagfu/
 8JTKT0qBvG75epSnVLSN/d1PLJ4XT8L6rkNTMldbT/64WeBwaNIFaB4Ros8frnlKDchyP
 PikJMieoA2Lai/UJz3miJpJ3zfXr3S2F0IVwz5CTol5Q64ixyh74V2mNU1ulEonJlGw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795324366;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=dv2pTH9QBO+8U81BAE+yrCyKWYsV7NNXzqFMfxnEC+c=;
 b=fkPfIgy92pnxKeF0IobSMgfKxNinj6e7axS0rA5k+gSxEAX8A1KmeUlNEnCvU8ddwOM8
 ObA2Eq6j4qTj8UJkDHENR9p/rawCbXElppgjQlztmeH6bNabxjFvJ1sD6KSC289Dg8SNR
 1V47mqtrjU9y1YEDfXpjafLuI3T0Sp6gA7iNBUdoVTME+NNvEi3b6YGLB7GawhjdKqI4+
 CQ3kwbu4ChRz6ukIlg5+b6u1fwMLQfgJ5uQfgh9S+f3kuNltrSM65xsGNsEsDgeB3Lml6
 Y2AvxujMrQFy4Ptgs+TQWjNLf1aJH7vM2rJW0am5jhWpx1X/Y8lnJJzUaTltPXHGtww==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 0D5FD1F000C0;
 Sun, 22 Nov 2026 05:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795324366;
 bh=dv2pTH9QBO+8U81BAE+yrCyKWYsV7NNXzqFMfxnEC+c=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=ddfi9yX1t/y8pkikSUPEJpMrjL/VRWuh1jgAbRUOrTgGnfMR34w/XKKr/7M+D5YSa
 NPgBVGdETY6Fun17WTTD0/PDLmGKD9iwke/mTr6uAgi6Kd6imjp/EUPU3gRtasC9xD
 vubcYXL3EQEkEfPxjNRgr21HjKat4nIo/4xIOY0NDbLbVZ0EkJGV76ZChsPPqaWdei
 MrxobCAndCOfvw3KnDJeDR0qF4oYSQ/Di4edtwFXM794moAanNqxe/O5ok+lt6Dsqy
 iM+VLdVcbItC0xJw3M8wvzk9q6zSHvdX/XoWBZs4PbkuORWkfzfgX9lk52l3dPEyvG
 is0gaFUNXZa1A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 917A94BF13;
 Sun, 22 Nov 2026 05:12:45 +0000 (UTC)
From: EMCP333 via B4 Relay <devnull+emcp.enser.io@kernel.org>
Date: Sun, 22 Nov 2026 05:12:43 +0000
Subject: [PATCH] drm/msm: Use div64_u64() for the retired-submit GPU clock
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-b4-drm-msm-retire-div64-v1-1-94d6981799d0@enser.io>
X-B4-Tracking: v=1; b=H4sIAMp5AmsC/yXMwQ7CIBAE0F9p9uxqoUjVXzEeCqx2TUrNUolJ0
 38X9PgmM7NCImFKcGlWEMqceI4FateAH4f4IORQDLrVVimt0RkMMuGUJhRaWAgDZ2tQqePp3Pa
 d6qyHsn4J3fnze77e/k5v9yS/1LvacEMidDJEP9ao8pD7vUHxGrbtC28RdYObAAAA
X-Change-ID: 20261122-b4-drm-msm-retire-div64-11589073136c
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jordan Crouse <jordan@cosmicpenguin.net>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, EMCP333 <emcp@enser.io>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795324363; l=2454;
 i=emcp@enser.io; s=ultron; h=from:subject:message-id;
 bh=Mv5vF8Oc99FZKnLAmD9sYhN9n2NgdGEHtxT8xvPHv9k=;
 b=8RCUs9bzCxX/GEB0D3HUaQ+guM16RHO+kqTUQCCGyfxj59dfKUi6VE0gUKqIhQsdbY1hCvUlo
 B7cYzZs8VnlADWgwc/F13bjCDvVt6sX5AdYfg0AW4KcfNteRjdqqTYU
X-Developer-Key: i=emcp@enser.io; a=ed25519;
 pk=5sG48Lul+Vn7OzXu3VZrCWk5uvEFPYMXYnAV0TZR/tY=
X-Endpoint-Received: by B4 Relay for emcp@enser.io/ultron with auth_id=1598
X-Original-From: EMCP333 <emcp@enser.io>
Content-Transfer-Encoding: 7bit
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
Reply-To: emcp@enser.io
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: EMCP333 <emcp@enser.io>

retire_submit() derives the GPU clock from the CP cycle and always-on
counter deltas:

	if (elapsed) {
		clock = cycles * 1000;
		do_div(clock, elapsed);
	}

elapsed is a u64, but do_div() takes a 32-bit divisor, so it is silently
truncated. The guard tests all 64 bits while the division uses only the
low 32, so any elapsed value that is a non-zero multiple of 2^32 divides
by zero, and any value of 2^32 ns or more gives a wrong clock. On 32-bit
ARM the division by zero lands in __do_div64 and prints "Division by zero
in kernel" with a backtrace on every such retire.

Observed on an Adreno 330 (MSM8974, LG Nexus 5) running a downstream
6.16 kernel: the backtrace repeated every 0.3-0.9 s from the first GPU
submit, 232 times in 34 minutes. The faulting return address,
retire_submits+0x3dc, is the instruction after the only
non-constant-divisor __do_div64 call in the function. Why elapsed has
zero low 32 bits so often on this GPU was not investigated.

Use div64_u64(), which takes a 64-bit divisor.

Tested on the downstream postmarketOS 6.16.12 msm8974 kernel on a Nexus
5: no "Division by zero" over an 1850 s soak with about 30 minutes of
GPU load (before: 232 in 34 minutes). On this tree it is build-tested
only.

The code and this changelog were prepared with the help of an AI coding
assistant. The submitter has reviewed both and takes responsibility for
them.

Fixes: 4241db42e474 ("drm/msm/gpu: Add trace events for tracking GPU submissions")
Signed-off-by: EMCP333 <emcp@enser.io>
---
 drivers/gpu/drm/msm/msm_gpu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 8319119041..8b99998e19 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -705,10 +705,8 @@ static void retire_submit(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
 	cycles = stats->cpcycles_end - stats->cpcycles_start;
 
 	/* Calculate the clock frequency from the number of CP cycles */
-	if (elapsed) {
-		clock = cycles * 1000;
-		do_div(clock, elapsed);
-	}
+	if (elapsed)
+		clock = div64_u64(cycles * 1000, elapsed);
 
 	submit->queue->ctx->elapsed_ns += elapsed;
 	submit->queue->ctx->cycles     += cycles;

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261122-b4-drm-msm-retire-div64-11589073136c

Best regards,
--  
EMCP333 <emcp@enser.io>


