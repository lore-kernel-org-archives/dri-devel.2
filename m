Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FB8606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 06:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=A7tI0nq7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AEE510E12C;
	Wed, 18 Nov 2026 06:48:48 +0000 (UTC)
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com
 [209.85.215.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7CDA10E12C
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 06:48:41 +0000 (UTC)
Received: by mail-pg1-f225.google.com with SMTP id
 41be03b00d2f7-cd61cef87f1so476770a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 22:48:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794984521; x=1795589321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1wn8B8AtBDch11Kn2VubYj0NKMdWprvKTv7qKouH7kM=;
 b=SWHoqP6QJFKDnxyBTZXi90a5kFaKTtNhpv9Q1znLIzgqOaf8GzuSLuk885AS12SO9D
 +fXtWnZcvFdhBxRAX1gmi1U8wxgrR8b4ddk8GV15Kn44dAOWUsKu5vtONEDksRKSYX2B
 XluPZrlUkyUuSZExXU7KTLSumAczilrO10GkVnsEXrJ4bgMAzcHXFjm7WprKWh16i9kE
 6M5DTAAUM/K+X0GxWNb2AHWDTa7bCk97LjrbomgfplMMTH7CbQ93F9Y3+W7i85GJa3DW
 7PtIg6kWQIfWK1Qm3gcknCSwjKY3yjo+UaByEsKYb0BLJWurtPbh96iwg+RBvVw1f4WN
 BW+A==
X-Forwarded-Encrypted: i=1;
 AL+hErEWtAdOenTCW7elXfRe22ZWJxYL5Vzvs9d9Qi/Vlu03uHRRRhYezBZHA/UJpfFrsjaU5ve+V19iCa4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9b/wc+zntVv9QXapAGVlXmQBLoiBnUXxg/Wj/agufAEiobkbQ9
 vh3Rn+O50EFyc8MJB2SR3BwWmnIxDkAC7l1zGZZ/46nMWYLO3rzJ1tA+tLx8NewVxSp/8/ReIVm
 ZRlYywM8UqKiSTsV2keCJXRNO23Q3G3bu6Yg7uWOm2xs1wkxPc5mfwAPRVBDMb0dqngf5aiF25f
 FCa7SvZqc/RN608LqpjI1oEqjuwKxu9gDlBO+iMbBAkCY3g7tEJO9D+rnAS7uuMNiwIZXnS1yD3
 fEtQ5qGiqzaINVa75vB
X-Gm-Gg: AZFdTZdsGNrnxtkmtqo9iZRMTHiSOSRm4JAtCNg8IJ534I4JULmxi8YCIkh85M84d/O
 Df3XaaECofplarTKOfDq0X2OUt6lm784XmT3Eh9oCEL6wzVBz8YGDmZnbwMfJtZ1FajIHFB6UeG
 ZNuHhfxsqhZN4eER4Oy5tyl5h4MMiwVSZQxchCnRncarf2Dmh7siZKg5AeqmXP1i3izAM2egYQL
 4mRAAXMfI7rz/LW7Pkgct9T+CKIzulK0ZSYsDLt7aCIkau62A6C9MM8HuadCteFph4Fp9o52lES
 VgV6gttCfBlHshvcAlTdgvUSk9JGmXqnUbZp83PW0LQcy3jkdtcCmdCvTcxOvtWsTRNhEBB5Z+e
 QxqcenoOgXK91p8EKDkQt7wvwxuK444zxRBWV3IV85xH5BdXf+LBE3WUfJUomRYWlxXOJF3Rd4S
 hwpu28TXN+z64WGgTv2B1/YjfIVprRn+Sn
X-Received: by 2002:a17:90b:53cf:b0:3ac:ea3b:f28b with SMTP id
 98e67ed59e1d1-3b3d07b80bcmr1696314a91.24.1794984521157; 
 Tue, 17 Nov 2026 22:48:41 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b3d4c21b91sm516271a91.5.2026.11.17.22.48.40
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Nov 2026 22:48:41 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-99c47fe8cacso514381241.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 22:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794984520; x=1795589320;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1wn8B8AtBDch11Kn2VubYj0NKMdWprvKTv7qKouH7kM=;
 b=A7tI0nq7T4cDbSFoZxbj020dCBO2ecJZ9p7awydJz37mCAA7J90iDS+XPWRQBBFFSB
 Yq1IdF1BseLFKhZrNKKmyX3Q/ZB3KFIRdHffAz4qTzTcla4houb7ZxWbbXBDRgApWeSf
 lbekJnLbS5luH7rRaRoPSfl5B+cqyxgBGoz0U=
X-Forwarded-Encrypted: i=1;
 AL+hErFD6B44fA0HVXkwaquVI0Ua5C1fC8hEDL//2HSmTizW+K4+sNTX8Wd1qEC+mG6VqP4CiNcpmeN0CQo=@lists.freedesktop.org
X-Received: by 2002:a05:622a:528c:b0:533:8b99:fcd2 with SMTP id
 d75a77b69052e-55d5a668644mr25275531cf.40.1794984019864; 
 Tue, 17 Nov 2026 22:40:19 -0800 (PST)
X-Received: by 2002:a05:622a:528c:b0:533:8b99:fcd2 with SMTP id
 d75a77b69052e-55d5a668644mr25275241cf.40.1794984019244; 
 Tue, 17 Nov 2026 22:40:19 -0800 (PST)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d61cf3b56sm2078141cf.13.2026.11.17.22.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 22:40:18 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Borislav Petkov <bp@alien8.de>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v4 1/3] x86/vmware: Move high-bandwidth hypercalls out of line
Date: Wed, 18 Nov 2026 01:40:11 -0500
Message-ID: <59bf54707b78e2a4d2072c1aff6bcf72cb35e6b2.1794206170.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794206170.git.zack.rusin@broadcom.com>
References: <cover.1794206170.git.zack.rusin@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The high-bandwidth helpers contain inline assembly which temporarily uses
%bp as a VMware ABI register. Keeping that assembly in vmware.h duplicates
it in callers.

Move both helpers to vmware.c and export them for the vmwgfx module.
Preserve their unwind hints and remove the redundant caller-wide objtool
annotations from vmwgfx.

Preserve the argument sequence from commit e0e022004bbe ("x86/vmware:
Fix i386 high-bandwidth hypercall arguments").

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 arch/x86/include/asm/vmware.h       | 62 +-------------------------
 arch/x86/kernel/cpu/vmware.c        | 68 +++++++++++++++++++++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c |  3 --
 3 files changed, 70 insertions(+), 63 deletions(-)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index fb011cef01e7..f3ffe358d2a3 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -253,12 +253,6 @@ unsigned long vmware_hypercall7(unsigned long cmd, unsigned long in1,
 	return out0;
 }
 
-#ifdef CONFIG_X86_64
-#define VMW_BP_CONSTRAINT "r"
-#else
-#define VMW_BP_CONSTRAINT "m"
-#endif
-
 /*
  * High bandwidth calls are not supported on encrypted memory guests.
  * The caller should check cc_platform_has(CC_ATTR_MEM_ENCRYPT) and use
@@ -266,66 +260,14 @@ unsigned long vmware_hypercall7(unsigned long cmd, unsigned long in1,
  * This assumption simplifies HB hypercall implementation to just I/O port
  * based approach without alternative patching.
  */
-static inline
 unsigned long vmware_hypercall_hb_out(unsigned long cmd, unsigned long in2,
 				      unsigned long in3, unsigned long in4,
 				      unsigned long in5, unsigned long in6,
-				      u32 *out1)
-{
-	unsigned long out0;
-
-	asm_inline volatile (
-		UNWIND_HINT_SAVE
-		"mov %[in6], %%" _ASM_AX "\n\t"
-		"push %%" _ASM_BP "\n\t"
-		UNWIND_HINT_UNDEFINED
-		"mov %%" _ASM_AX ", %%" _ASM_BP "\n\t"
-		"mov %[magic], %%eax\n\t"
-		"rep outsb\n\t"
-		"pop %%" _ASM_BP "\n\t"
-		UNWIND_HINT_RESTORE
-		: "=&a" (out0), "=b" (*out1)
-		: "b" (cmd),
-		  "c" (in2),
-		  "d" (in3 | VMWARE_HYPERVISOR_PORT_HB),
-		  "S" (in4),
-		  "D" (in5),
-		  [in6] VMW_BP_CONSTRAINT(in6),
-		  [magic] "i" (VMWARE_HYPERVISOR_MAGIC)
-		: "cc", "memory");
-	return out0;
-}
-
-static inline
+				      u32 *out1);
 unsigned long vmware_hypercall_hb_in(unsigned long cmd, unsigned long in2,
 				     unsigned long in3, unsigned long in4,
 				     unsigned long in5, unsigned long in6,
-				     u32 *out1)
-{
-	unsigned long out0;
-
-	asm_inline volatile (
-		UNWIND_HINT_SAVE
-		"mov %[in6], %%" _ASM_AX "\n\t"
-		"push %%" _ASM_BP "\n\t"
-		UNWIND_HINT_UNDEFINED
-		"mov %%" _ASM_AX ", %%" _ASM_BP "\n\t"
-		"mov %[magic], %%eax\n\t"
-		"rep insb\n\t"
-		"pop %%" _ASM_BP "\n\t"
-		UNWIND_HINT_RESTORE
-		: "=&a" (out0), "=b" (*out1)
-		: "b" (cmd),
-		  "c" (in2),
-		  "d" (in3 | VMWARE_HYPERVISOR_PORT_HB),
-		  "S" (in4),
-		  "D" (in5),
-		  [in6] VMW_BP_CONSTRAINT(in6),
-		  [magic] "i" (VMWARE_HYPERVISOR_MAGIC)
-		: "cc", "memory");
-	return out0;
-}
-#undef VMW_BP_CONSTRAINT
+				     u32 *out1);
 #undef VMWARE_HYPERCALL
 
 #endif
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index f7ab9e7902cf..7cfc894f0663 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -30,12 +30,14 @@
 #include <linux/reboot.h>
 #include <linux/static_call.h>
 #include <linux/sched/cputime.h>
+#include <asm/asm.h>
 #include <asm/div64.h>
 #include <asm/x86_init.h>
 #include <asm/hypervisor.h>
 #include <asm/cpuid/api.h>
 #include <asm/timer.h>
 #include <asm/apic.h>
+#include <asm/unwind_hints.h>
 #include <asm/vmware.h>
 #include <asm/svm.h>
 
@@ -67,6 +69,72 @@ struct vmware_steal_time {
 static unsigned long vmware_tsc_khz __ro_after_init;
 static u8 vmware_hypercall_mode     __ro_after_init;
 
+#ifdef CONFIG_X86_64
+#define VMW_BP_CONSTRAINT "r"
+#else
+#define VMW_BP_CONSTRAINT "m"
+#endif
+
+unsigned long vmware_hypercall_hb_out(unsigned long cmd, unsigned long in2,
+				      unsigned long in3, unsigned long in4,
+				      unsigned long in5, unsigned long in6,
+				      u32 *out1)
+{
+	unsigned long out0;
+
+	asm volatile(UNWIND_HINT_SAVE
+		"mov %[in6], %%" _ASM_AX "\n\t"
+		"push %%" _ASM_BP "\n\t"
+		UNWIND_HINT_UNDEFINED
+		"mov %%" _ASM_AX ", %%" _ASM_BP "\n\t"
+		"mov %[magic], %%eax\n\t"
+		"rep outsb\n\t"
+		"pop %%" _ASM_BP "\n\t"
+		UNWIND_HINT_RESTORE
+		: "=&a" (out0), "=b" (*out1)
+		: "b" (cmd),
+		  "c" (in2),
+		  "d" (in3 | VMWARE_HYPERVISOR_PORT_HB),
+		  "S" (in4),
+		  "D" (in5),
+		  [in6] VMW_BP_CONSTRAINT(in6),
+		  [magic] "i" (VMWARE_HYPERVISOR_MAGIC)
+		: "cc", "memory");
+	return out0;
+}
+EXPORT_SYMBOL_GPL(vmware_hypercall_hb_out);
+
+unsigned long vmware_hypercall_hb_in(unsigned long cmd, unsigned long in2,
+				     unsigned long in3, unsigned long in4,
+				     unsigned long in5, unsigned long in6,
+				     u32 *out1)
+{
+	unsigned long out0;
+
+	asm volatile(UNWIND_HINT_SAVE
+		"mov %[in6], %%" _ASM_AX "\n\t"
+		"push %%" _ASM_BP "\n\t"
+		UNWIND_HINT_UNDEFINED
+		"mov %%" _ASM_AX ", %%" _ASM_BP "\n\t"
+		"mov %[magic], %%eax\n\t"
+		"rep insb\n\t"
+		"pop %%" _ASM_BP "\n\t"
+		UNWIND_HINT_RESTORE
+		: "=&a" (out0), "=b" (*out1)
+		: "b" (cmd),
+		  "c" (in2),
+		  "d" (in3 | VMWARE_HYPERVISOR_PORT_HB),
+		  "S" (in4),
+		  "D" (in5),
+		  [in6] VMW_BP_CONSTRAINT(in6),
+		  [magic] "i" (VMWARE_HYPERVISOR_MAGIC)
+		: "cc", "memory");
+	return out0;
+}
+EXPORT_SYMBOL_GPL(vmware_hypercall_hb_in);
+
+#undef VMW_BP_CONSTRAINT
+
 unsigned long vmware_hypercall_slow(unsigned long cmd,
 				    unsigned long in1, unsigned long in3,
 				    unsigned long in4, unsigned long in5,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index fd77ab6568cb..20ab4019680c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -24,7 +24,6 @@
  *
  */
 
-#include <linux/objtool.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -289,7 +288,6 @@ static int vmw_send_msg(struct rpc_channel *channel, const char *msg)
 
 	return -EINVAL;
 }
-STACK_FRAME_NON_STANDARD_FP(vmw_send_msg);
 
 
 /**
@@ -384,7 +382,6 @@ static int vmw_recv_msg(struct rpc_channel *channel, void **msg,
 
 	return 0;
 }
-STACK_FRAME_NON_STANDARD(vmw_recv_msg);
 
 
 /**
