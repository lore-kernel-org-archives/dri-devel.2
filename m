Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87F6FB44C4
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EAEE10F3B1;
	Fri, 24 Apr 2026 07:44:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ED9vuKP5";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC5F410F328
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 05:49:03 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-c7961d7bc09so2869416a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 22:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777009743; x=1777614543; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=begHw2Fh55YIAbwVuxIcFKYuQNkyXTaAo0Peazo3t08=;
 b=ED9vuKP5Aul0XWUvNRG6Hi9QeCXDeF+j+v1yOCFJ/ZnrXWiFwLRLhbBHTZYXstp8BC
 Mrn/WM/rvCH4eQnvCV1M6SAHwEv/vrA2AyY5eQDZPrwRnbrcIgZzze6c07hPwIgyhBlI
 MRi606XjDaWXvIB4C8Rm+OFmvUL9XpDyqTjcSgF9y0A4FgNP6YylRPozDMyVelgauJV/
 WZVsOUCsytA5o+/kk5phMJeZzmLgDEebhW1k4hhf/jo0CWM47I/EqUq3Qrv64j9B4oAt
 kqrvA09N6gTGJ7O9CxySi42A/XaLNk2FQ46Qukjx3suVsRwwBQGohWJZZDM4e2sGdnqm
 n0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777009743; x=1777614543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=begHw2Fh55YIAbwVuxIcFKYuQNkyXTaAo0Peazo3t08=;
 b=PdTOq42FhdKaCmTmwHdfLVo6Z9g72KcocdqRMhBDFtsWlpLt2/BftWwTMu5+xLUNeP
 YYlC3D2M5X5XK0EVihY2haObs/HPSvViBFaLikRanFQ+JbH8o0DakXkDqfu/UMquLHnm
 MiGkgZ3A4BfQQiPgT9G7fc1tbPFETUjO9x/QsRehXseax/Ab0VFQ5P+F+2H/kS9BiCMJ
 jRIvAQemyAohBFT3/miMAM6c++HaMWxoYQi8vLYKJBCoF/AHPEt4EcPc7T36Cew/tG8K
 RECeVBqkTo9bPkpr9GCa1XqoqFrbLyJJseYOIqBxhqEDYU/RjBC0g1/8eOsoLcpuM0F4
 fbVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8daRd3QDoeOh8/l5wIBBX2Hv0FRnHew5gIL2EfPCPkGbN2W9Hqf5cLqbzxNLY3rgIcVRZPOsv8n7c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOxgQ7HFkm+sJYarbKrtvyRKORGMbUupVj86XcSvsBaH8JaYnA
 N/vEnarqklW8EsjPf/rZ78XCxSrOiYMkeBK8Yp4jcSWpLir2TQnhgjfEKB63e1Qp
X-Gm-Gg: AeBDietpZGPQGOjb/dr/Sy8Ozvhjal1lUG01FY8UDqkanfTKqbvMb+zG8igWo4HoqV/
 680ejMrH22KfCNJD1vmkYT1KQkmzEEhZq3I0iwR0QbQlhuMT2hEjhn/nfUuU8ypLhgD7fgwy0Ql
 QACTISDkrQbo3m3fLp4q82N6usxS9zVow0JmWsO6t3JLP/SXJ8WaayJYBOr7OSs+Wdyabv6bXnw
 rckTGeckrSMvTHV5b2qVD9eUufSAMeqH5huEAjE6AqsXtcmfgtRh358c5Pl64k8VIxZFJPRDsni
 0bRtImMXPZWo9T+rc+lWnyi8k0vKH1zYLSGwGAoYaG5AlP15ZsXM+O3zGprNHWn3yM1V/7BaWAu
 Q7jcnYMO2/SW12ureqerJ0NTV4kfLlCYpsnlK07x0+qLkkcfCZeLq7sYMl1/n4/4dE+yMnOh5bP
 sOw9hXE9MG4SwA4XpsCgkw2CvgSvXXbQ4dbx0niPVDOUWrQuBvrCNJpJtwk6TXjpXXPt0w8UU7f
 UGO47HB8aTgAvA=
X-Received: by 2002:a17:903:1a45:b0:2b2:65db:8c5f with SMTP id
 d9443c01a7336-2b5f9f4f562mr323157805ad.27.1777009743184; 
 Thu, 23 Apr 2026 22:49:03 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.bl1-in.ibm.com
 ([129.41.58.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa176e9sm208778245ad.20.2026.04.23.22.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 22:49:02 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
 jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org,
 ardb@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 tamird@kernel.org, arnd@arndb.de, nsc@kernel.org, mkchauras@gmail.com,
 simona.vetter@ffwll.ch, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Cc: Link Mauve <linkmauve@linkmauve.fr>
Subject: [PATCH V13 6/7] rust: Add PowerPC support
Date: Fri, 24 Apr 2026 11:17:41 +0530
Message-ID: <20260424054742.45832-7-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424054742.45832-1-mkchauras@gmail.com>
References: <20260424054742.45832-1-mkchauras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 07:44:43 +0000
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

From: Link Mauve <linkmauve@linkmauve.fr>

For now only Big Endian 32-bit PowerPC is supported, as that is the only
hardware I have.  This has been tested on the Nintendo Wii so far, but I
plan on also using it on the GameCube, Wii U and Apple G4.

These changes aren’t the only ones required to get the kernel to compile
and link on PowerPC, libcore will also have to be changed to not use
integer division to format u64, u128 and core::time::Duration, otherwise
__udivdi3() and __umoddi3() will have to be added.  I have tested this
change by replacing the three implementations with unimplemented!() and
it linked just fine.

Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
Link: https://github.com/Rust-for-Linux/linux/issues/105
Link: https://github.com/linuxppc/issues/issues/451
Acked-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/Kconfig  | 1 +
 arch/powerpc/Makefile | 2 ++
 rust/Makefile         | 4 +++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e93df95b79e7..4ac897b650d4 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -285,6 +285,7 @@ config PPC
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_RSEQ
+	select HAVE_RUST			if PPC32
 	select HAVE_SAMPLE_FTRACE_DIRECT	if HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_SETUP_PER_CPU_AREA		if PPC64
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index a58b1029592c..589613eaa5dc 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -61,6 +61,8 @@ else
 KBUILD_LDFLAGS_MODULE += $(objtree)/arch/powerpc/lib/crtsavres.o
 endif
 
+KBUILD_RUSTFLAGS 	+= --target=powerpc-unknown-linux-gnu
+
 ifdef CONFIG_CPU_LITTLE_ENDIAN
 KBUILD_CPPFLAGS	+= -mlittle-endian
 KBUILD_LDFLAGS	+= -EL
diff --git a/rust/Makefile b/rust/Makefile
index ee11fba7a03d..fd9c1bf026ca 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -400,13 +400,15 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
 	-fstrict-flex-arrays=% -fmin-function-alignment=% \
 	-fzero-init-padding-bits=% -mno-fdpic \
 	-fdiagnostics-show-context -fdiagnostics-show-context=% \
-	--param=% --param asan-% -fno-isolate-erroneous-paths-dereference
+	--param=% --param asan-% -fno-isolate-erroneous-paths-dereference \
+	-ffixed-r2 -mmultiple -mno-readonly-in-sdata
 
 # Derived from `scripts/Makefile.clang`.
 BINDGEN_TARGET_x86	:= x86_64-linux-gnu
 BINDGEN_TARGET_arm64	:= aarch64-linux-gnu
 BINDGEN_TARGET_arm	:= arm-linux-gnueabi
 BINDGEN_TARGET_loongarch	:= loongarch64-linux-gnusf
+BINDGEN_TARGET_powerpc	:= powerpc-linux-gnu
 BINDGEN_TARGET_um	:= $(BINDGEN_TARGET_$(SUBARCH))
 BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
 
-- 
2.53.0

