Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74951C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABAA810E872;
	Mon, 31 Aug 2026 13:39:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HU29c2xl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CD1410E875;
 Mon, 31 Aug 2026 13:39:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 31408439DD;
 Mon, 31 Aug 2026 13:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15B81F00A3E;
 Mon, 31 Aug 2026 13:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788183590;
 bh=YygtfXTan2nafBKTj0tGgsUYKB05+ycgPkoAs9yo+rY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HU29c2xlP36UIbxDd2+x9HNYeaYHseBG3P+QszYJC5oSIQqIUCycQ+R6YlXld/ycZ
 669RzG37pxQmm+Y90sa/BGJGSDqX31v32v4loD+c/AIx+FEyuYJPYOHeU4X62cwMmq
 kPNRm7eLYyrECMKBlCCYk6k18SxyiqiDDf/Zb4ALsgB7kqfft9SlZn+A0ze3jaRvZO
 EmbAPr0q43qJ+henJWmUfKpCZVRs6buEvFCq9IJp0DsuMiWIRHX/Q4IRLD3Rf/vnLY
 YUkEUIX3aP+sZJ2Q54HUPfOznJAohuncgKHTE1ZKFrSgXnCskA+hZfTZHFaZqScgFM
 78DYdcGCwoFAg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Perry Yuan <perry.yuan@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.6] drm/amdgpu: flush pending RCU callbacks on
 module unload
Date: Mon, 31 Aug 2026 09:23:33 -0400
Message-ID: <20260831133314.4125787-185-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831133314.4125787-1-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.48
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

From: Perry Yuan <perry.yuan@amd.com>

[ Upstream commit 67a654b41cfa73c3b83402c4a01b2689cad5b9bc ]

Call rcu_barrier() in module exit to wait for outstanding call_rcu() callbacks
before freeing module text, preventing late callback execution in freed memory.

BUG: unable to handle page fault for address: ffffffffc1d59c40
PGD 6a12067 P4D 6a12067 PUD 6a14067 PMD 13698b067 PTE 0
Oops: 0010 [#1] SMP NOPTI
RIP: 0010:0xffffffffc1d59c40
Code: Unable to access opcode bytes at RIP 0xffffffffc1d59c16.
RSP: 0018:ffffc900198c0f28 EFLAGS: 00010286
RAX: ffffffffc1d59c40 RBX: ffff897c7d6b61c0 RCX: ffff88826aff4590
RDX: ffff8884d8b35490 RSI: ffffc900198c0f30 RDI: ffff88812af67290
RBP: 000000000000000a (DONE segment entries) R08: 0000000000000000 R09: 0000000000000100
R10: 0000000000000000 R11: ffffffff82a06100 R12: ffff88811a4e3700
R13: 0000000000000000 R14: ffff897c7d6b6270 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff897c7d680000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffc1d59c16 CR3: 00000104a980a001 CR4: 0000000002770ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <IRQ>
 ? rcu_do_batch+0x163/0x450
 ? rcu_core+0x177/0x1c0
 ? __do_softirq+0xc1/0x280
 ? asm_call_irq_on_stack+0xf/0x20
 </IRQ>
 ? do_softirq_own_stack+0x37/0x50
 ? irq_exit_rcu+0xc4/0x100
 ? sysvec_apic_timer_interrupt+0x36/0x80
 ? asm_sysvec_apic_timer_interrupt+0x12/0x20
 ? cpuidle_enter_state+0xd4/0x360
 ? cpuidle_enter+0x29/0x40
 ? cpuidle_idle_call+0x108/0x1a0
 ? do_idle+0x77/0xf0
 ? cpu_startup_entry+0x19/0x20
 ? secondary_startup_64_no_verify+0xbf/0xcb

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit feaa5039f6c12acc9aa934c2d45dcd251a12c69f)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

The background check finished: `feaa5039f6c12` is on mainline but not in
`stable/linux-6.18.y` (about 1.37M commits ahead of the stable branch
tip). A grep for "flush pending RCU" on the stable branch returned
nothing, so this fix still needs to be backported.

That matches the earlier analysis: the bug is present in v6.18.44, the
patch should apply cleanly at the end of `amdgpu_exit()`, and the
backport recommendation remains **YES**.

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 99f22633abf53..20e614db485cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3217,6 +3217,14 @@ static void __exit amdgpu_exit(void)
 	amdgpu_userq_fence_slab_fini();
 	mmu_notifier_synchronize();
 	amdgpu_xcp_drv_release();
+
+	/*
+	 * Flush outstanding call_rcu() callbacks before the
+	 * module text is freed.  Otherwise a grace period elapsing after
+	 * unload invokes a callback in already-freed module memory and
+	 * faults in rcu_do_batch().
+	 */
+	rcu_barrier();
 }
 
 module_init(amdgpu_init);
-- 
2.53.0

