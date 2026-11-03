Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2471E606A329
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=M/Lfrkxx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AADD10E798;
	Tue,  3 Nov 2026 07:16:07 +0000 (UTC)
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com
 [209.85.215.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B3BE10E798
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 07:16:01 +0000 (UTC)
Received: by mail-pg1-f227.google.com with SMTP id
 41be03b00d2f7-cc502d509c0so1513843a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 23:16:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793690161; x=1794294961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q4y6B1icyNzjJObRP5v2+iWtsvF0W+PG7Ux6Z6hjgbY=;
 b=BtjAPPIhc5aGI/V/qSkdOaPaLnM9/1jOo8k9iQuRjj97lR/tiME5Oct1nrAicbTCRK
 5Y1djHWpTMtQEWLdmqGqVPCQMrS9zdzttwVTeNMH3RQcHutUATwRm3YlQeKbYYxgvgtQ
 iPuixOwQvJ6ABhmYW2ukyOuJN7soJXOrBrsirQiymk/xZ0pKnELg/Lo6+Dl/EKnDe3vu
 J9hMJXgftu+FdwH7k0sgU/oeJR3Mh/p5b4Mv4PWj9t9NiQKMZBZjyPTnC7sxVV8bHC3V
 /fj05REVPKD4PMdevUW7GTPlO659Owth1RGML1cqTteDgc34Gwyfdrpxxal8yQD6hOW/
 0Qcw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKUZrsSZNfWpV8FowZeL6lzHZsVvG44STXeBg0/eHHEdKXVNYsGLlLIG1SzGBHtdghfXa0h/XfZYA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9YDnCmttF2MgkXKuvJFVDfr3OfEM1u8X2v6NNFlgh2DwPIhBTk
 OVTTHus9MfssM4uREvJLqUjwkKzrLsvMqa8qsOjtrOH2yue+q18GT9B3m9faZKpA8/xmiStmbhc
 Y/Y2Z9W0EnsgrCGZNksW1zgb5YJq6KCcp84K3x9ow226ROP9Azl5RcXm94i+I77XG6WJGzEcafb
 C+2/s4CyM4BEhqzlOTDAQ/bCsvhdcEWmDed2ujYVuUo6zZn2KJoKEbof+hWIKk7xvqLxKm1XPMo
 Hb8qPwApL6P7Tjoz/3J
X-Gm-Gg: AYBFou2AXo9USBrYe+72/t4Mcji5dwas9JrWpt04jG8A8FomJsSWVEQB4rcAoRYXHp/
 hEI9eN3h8R3XdNPXtDRhBjbQIPen5sQ3CysfBNAkaYj9K1IpttXYD8MQw8s6JUjiwQs8ptYtsrN
 Aufa0xlMgV2Tzel7Tan0FW6ZcmkMv7qCCrQClqS04cT3EFwXWriHR+uk9aTN12qSo7CGOIBZ7Zv
 VQt2ToKXc7Lz2g+MnmKZHDZpMB4waPH0s5oxXPwRTNkjnTAbxI8O3cUCg4243fwsPerrMdPH7/c
 EPoZO4lcMB1E+gVmWB9G+ZcQAEm+e8biUwTYnLYRsbrLVfvEvM3JjZRirC9VdXZQNGBq94vZn3k
 CY+kG9ZFS7Gl7KxUUEtIPlAWZVCWGMcPqQOVPxQAO95nbMGwmcADi6ZDNW6xektYt1f8MvdY30H
 SPbPMlz6dfPvPvftz8wZE4VdsxV0zdT9v/
X-Received: by 2002:a17:90b:3d83:b0:3ac:9176:e82b with SMTP id
 98e67ed59e1d1-3ae89838772mr9391053a91.54.1793690160551; 
 Mon, 02 Nov 2026 23:16:00 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b07c9263d2sm1307465a91.7.2026.11.02.23.16.00
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 02 Nov 2026 23:16:00 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f1e62510cso846446385a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 23:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793690159; x=1794294959;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q4y6B1icyNzjJObRP5v2+iWtsvF0W+PG7Ux6Z6hjgbY=;
 b=M/LfrkxxM3VMi4pd9KMOG65BC0abkhnsQ4ukfgwnQ55aj/UkNGFIDo3n4M6MdNsPLQ
 rZ1qT0aQsRaj+rjJyC5cFlX9uLdKSAMloPR68DJVDFanBtQoV6WVU+Zouaad7HFyzvZy
 Vvby5ipwLb8rqx5sEWp3TKS7Ul55pFrq6Fut4=
X-Forwarded-Encrypted: i=1;
 AKwUvBxZmN1R2mzwgqL64LJhewpdjQCy2RnqkPpi2a8JMJI8EMsD9UwPFxq/tuRFjPaLzgoLVUkTgS68HSs=@lists.freedesktop.org
X-Received: by 2002:a05:620a:2687:b0:943:b019:f011 with SMTP id
 af79cd13be357-94421719dd1mr1970190285a.28.1793690159388; 
 Mon, 02 Nov 2026 23:15:59 -0800 (PST)
X-Received: by 2002:a05:620a:2687:b0:943:b019:f011 with SMTP id
 af79cd13be357-94421719dd1mr1970188385a.28.1793690158920; 
 Mon, 02 Nov 2026 23:15:58 -0800 (PST)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9442581b2d2sm1018334585a.15.2026.11.02.23.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 23:15:52 -0800 (PST)
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
Subject: [PATCH v3 3/3] x86/cpufeatures: Remove unused VMware hypercall
 feature bits
Date: Tue,  3 Nov 2026 02:14:58 -0500
Message-ID: <c8e57b19d95fd8ffbfd13e7ab1c1ade551b1bd7b.1793685318.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793685318.git.zack.rusin@broadcom.com>
References: <cover.1793685318.git.zack.rusin@broadcom.com>
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
index 6719c009f237..b5c1610ff408 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -492,10 +492,6 @@ static void __init vmware_set_capabilities(void)
 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 	if (vmware_tsc_khz)
 		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
-	if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMCALL)
-		setup_force_cpu_cap(X86_FEATURE_VMCALL);
-	else if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMMCALL)
-		setup_force_cpu_cap(X86_FEATURE_VMW_VMMCALL);
 }
 
 static unsigned long
