Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A895606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 06:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=h1nDGJox
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A7C310E556;
	Wed, 18 Nov 2026 06:40:34 +0000 (UTC)
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com
 [209.85.215.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3716610E52C
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 06:40:28 +0000 (UTC)
Received: by mail-pg1-f228.google.com with SMTP id
 41be03b00d2f7-cdb9f760337so1049016a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 22:40:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794984028; x=1795588828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WGXSzPoaoRZhYGRZwzYW9Xi8SgZA3sFH/3kCEUuvBxU=;
 b=ANqo9pmDKCl1hwRsi/V2TIWqf4peNG2DIt0e0Njw3rEadDqDEe3pauch6Xlc8yclf6
 7wceDC+sVXgu8LN62rCMzGJIzB7937BbnsXe+lWso/+PoC6loeEdAfuUYbuzdMr1poM9
 /hDtPE9wIDvYHM21bGDG++PDjs30/EeGWOGNSuN9AFoOd5MNyC8947gxO8jkDCLgY2iz
 QFj4bZFPB7fDfBCW9WYSINvBL0lkb7KXZ/M956ovekGLw4OjBqbMcIfr9nuAlQ9zVbBR
 VuPCzOD/wmZJsZNPHb0ZVaG6aiBJq1TbA0h1eall/6s8z7jDNdl8FV6X/QFAlkK4+CKE
 QtMA==
X-Forwarded-Encrypted: i=1;
 AL+hErHBTmv+7AFn4AXkuvSsuGAkRLJtE0rYg1c9wrc0E7F6ESEgHadXW9jP7BYUIC0mL26Eq7/XBoB/eUA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/QOdlP76hEXnprdEqX35trJ6cy/G4wVlEFi+8xtXYMkXpjzvew
 PNe34eXSoGzD9l4SwegRRDqNYYktACrTOfkGf06jRhrhavb8v0h6VKTN+sli/Im5b/vy+ws0TAB
 +vKKThtZIAu/OnfRASNhpuPPOxSi/n3TXYa58kMKllRgQ19KZs62RcKooMVMk7TbWn1DAHBAiSQ
 85Tf3anuzCzdpIxsWhDgwzOkfwUgLXIsj8XVTIgH4We3ZFtwlIwZnmOkapiZa7Yi4Sc7k8+0bMq
 QaZgnl0d8W4wo7x2lIl
X-Gm-Gg: AZFdTZdHY+dfUm/L/8Z9/KMy5tC0np4qsdYRBdwHSSbvqqOzQ7SKEnMUnVVM6DCeTkJ
 j9cDt4C9t7Q+FUk9rbF2I9/x35XChZRJkouF+Wm+wTmXbfdgLoSC7KN5MJHTli2FXMv0K84ndYi
 E4JpXcIz3AMBo96FI3emciu8j2FJFQZbyG3rzEKyhJtirw+Swo6haKPMftOdlUfRX3eh/imExsN
 9OYEhBHziepS5yvQsrflo49T34rR7kf8xU61bGhlD21wbVrPAj2gk3H7TORs8Fx1iTDiRK7T9x0
 9Pwa3I795gozOZG+5zAZH+GTHobK+bIysvWYgm9C9GkMi8YfXCl05SIFKPgf4lIzCasjptimqHw
 XfInAOrEGHgkuJsfreLBn8Ppul5xM+/0LRuJzwt8MNP8AF1uK2lH/7qk0XfyrNErxG9NCGgpnCU
 f3BGzTj9edo0x/aekPgrTmTDhEJ+o5YvUf
X-Received: by 2002:a17:90a:e7cf:b0:3b0:9409:6969 with SMTP id
 98e67ed59e1d1-3b3d07d4596mr1185869a91.19.1794984027545; 
 Tue, 17 Nov 2026 22:40:27 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b3d0eaa8eesm1247021a91.2.2026.11.17.22.40.27
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Nov 2026 22:40:27 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-55bb7f70b06so30351581cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 22:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794984026; x=1795588826;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WGXSzPoaoRZhYGRZwzYW9Xi8SgZA3sFH/3kCEUuvBxU=;
 b=h1nDGJoxbtXeItAp1vwf6hO7EAB+UO4QHat5ej6hxX64tS0ckBBII4nId61eG+gqi6
 MxMovEaFOHTV/37UzzBNEei9JCfR3H+yADY8yxHotW065DoW25jP7OCGAktPSNsbNuBX
 UnW3mwxMy94bteBUlBJPe7H1mYukzt/9TOfVc=
X-Forwarded-Encrypted: i=1;
 AL+hErFcIJ5OkSy+0pzGv+4nnJMIygu3+tJ8YPu+ZRm43jZuWsCB3/ASSmmgLpHxPXd+kyDYgqBkf3NR03k=@lists.freedesktop.org
X-Received: by 2002:a05:622a:4185:b0:545:de78:a6ef with SMTP id
 d75a77b69052e-55d5a747c5amr22156151cf.38.1794984025901; 
 Tue, 17 Nov 2026 22:40:25 -0800 (PST)
X-Received: by 2002:a05:622a:4185:b0:545:de78:a6ef with SMTP id
 d75a77b69052e-55d5a747c5amr22155911cf.38.1794984025512; 
 Tue, 17 Nov 2026 22:40:25 -0800 (PST)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d61cf3b56sm2078141cf.13.2026.11.17.22.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 22:40:24 -0800 (PST)
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
Subject: [PATCH v4 3/3] x86/cpufeatures: Remove unused VMware hypercall
 feature bits
Date: Wed, 18 Nov 2026 01:40:13 -0500
Message-ID: <bcc9b471c176d5b162e6935b2c0c7f96c65ac8a6.1794206170.git.zack.rusin@broadcom.com>
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

The static-call conversion removed the alternative instruction templates
that used X86_FEATURE_VMCALL and X86_FEATURE_VMW_VMMCALL. Their remaining
users only force the bits during VMware setup; no code tests either bit.

Remove the forced capabilities and mark both positions free in the kernel
header. Neither feature has a cpuinfo name, so this changes no
userspace-visible flag.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 arch/x86/include/asm/cpufeatures.h | 4 ++--
 arch/x86/kernel/cpu/vmware.c       | 4 ----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 61930f0d4578..b7633930020f 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -233,8 +233,8 @@
 #define X86_FEATURE_VMMCALL		( 8*32+15) /* "vmmcall" Prefer VMMCALL to VMCALL */
 #define X86_FEATURE_XENPV		( 8*32+16) /* Xen paravirtual guest */
 #define X86_FEATURE_EPT_AD		( 8*32+17) /* "ept_ad" Intel Extended Page Table access-dirty bit */
-#define X86_FEATURE_VMCALL		( 8*32+18) /* Hypervisor supports the VMCALL instruction */
-#define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* VMware prefers VMMCALL hypercall instruction */
+// free: was #define X86_FEATURE_VMCALL ( 8*32+18) /* Hypervisor supports VMCALL */
+// free: was #define X86_FEATURE_VMW_VMMCALL ( 8*32+19) /* VMware prefers VMMCALL */
 // free: was #define X86_FEATURE_PVUNLOCK               ( 8*32+20) /* PV unlock function */
 #define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* PV vcpu_is_preempted function */
 #define X86_FEATURE_TDX_GUEST		( 8*32+22) /* "tdx_guest" Intel Trust Domain Extensions Guest */
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index c104681d0945..39f0bdbd1eab 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -505,10 +505,6 @@ static void __init vmware_set_capabilities(void)
 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 	if (vmware_tsc_khz)
 		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
-	if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMCALL)
-		setup_force_cpu_cap(X86_FEATURE_VMCALL);
-	else if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMMCALL)
-		setup_force_cpu_cap(X86_FEATURE_VMW_VMMCALL);
 }
 
 static void __init vmware_init_hypercall(void)
