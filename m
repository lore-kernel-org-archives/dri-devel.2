Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5428C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03D2B10E8A8;
	Mon, 20 Jul 2026 11:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="cbkgXDcl";
	dkim-atps=neutral
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1682410E893
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 11:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=zGzjQyHuVcqPZBvP+3cG6Vz0Ke3LkZDrFTo2xuU4/JA=; b=cbkgXDcltWLhobeGshdyHgBXgz
 MLmIk478H08vV7I7AMZcXXBh489GA2DHVHQqPTcyzjlJDiP7J7zbixxQuHzHZVnT/yzLUmG5Smv+f
 nvrF7y57wWCnQXXXlCKicL1cGQRl7Mzl6uThPTRVJlax+VrWKX1rM2C+BT+08POe+jS2LhDm32qnh
 qTl3ozOo2+uYw1FhKImJrNs6XwnuyMTdSWeYKq1dS3wtwI5U9nqOMJltX+DoDMP9m6ZvgTb7vq0/l
 IerT3EilVqLV8ZiBvPaqjXG0TIhK5VVj8QXqZ0HfxOepLO5vlLzn+UWk+qPEaqQcv1P/0zCrA74HK
 v2WGivcw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
 id 1wllvj-0000000GWe7-0vqI; Mon, 20 Jul 2026 11:13:03 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red
 Hat Linux)) id 1wllvg-00000000W0S-2RFO;
 Mon, 20 Jul 2026 12:13:00 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Tycho Andersen <tycho@kernel.org>,
 Kees Cook <kees@kernel.org>, Ashish Kalra <ashish.kalra@amd.com>,
 Connor Williamson <connordw@amazon.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Zhou Yuhang <zhouyuhang@kylinos.cn>, Zi Li <zi.li@linux.dev>,
 Dan Williams <djbw@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Colin Ian King <colin.i.king@gmail.com>, connordw@amazon.co.uk,
 graf@amazon.de, fgriffo@amazon.co.uk, David Woodhouse <dwmw@amazon.co.uk>
Subject: [RFC PATCH v2 02/11] KVM: selftests: sev_init2_tests: Derive SEV
 availability from KVM
Date: Mon, 20 Jul 2026 12:03:03 +0100
Message-ID: <5d3c345113748f39b7982e365d241abaf3e11086.1784545391.git.dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2b5e7a83d277134294199a455469bb436196b902.1784545391.git.dwmw@amazon.co.uk>
References: <2b5e7a83d277134294199a455469bb436196b902.1784545391.git.dwmw@amazon.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
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

From: David Woodhouse <dwmw@amazon.co.uk>

The test asserted that the X86_FEATURE_SEV CPUID bit exactly matches
whether KVM offers KVM_X86_SEV_VM.  That is not an invariant: when all
SEV ASIDs are assigned to SEV-SNP, KVM does not offer the SEV VM type
even though CPUID reports SEV, so the test aborts on an SNP-only host.

Derive SEV availability from KVM_CAP_VM_TYPES (as already done for SEV-ES
and SNP), assert only the one-way implication that a type offered by KVM
is also reported in CPUID, and TEST_REQUIRE() the SEV VM type so the test
skips cleanly when it is unavailable.

Reviewed-by: Tycho Andersen (AMD) <tycho@kernel.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 .../testing/selftests/kvm/x86/sev_init2_tests.c  | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/sev_init2_tests.c b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
index 8db88c355f16..689390c10f7c 100644
--- a/tools/testing/selftests/kvm/x86/sev_init2_tests.c
+++ b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
@@ -130,12 +130,18 @@ int main(int argc, char *argv[])
 			    KVM_X86_SEV_VMSA_FEATURES,
 			    &supported_vmsa_features);
 
-	have_sev = kvm_cpu_has(X86_FEATURE_SEV);
-	TEST_ASSERT(have_sev == !!(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SEV_VM)),
-		    "sev: KVM_CAP_VM_TYPES (%x) does not match cpuid (checking %x)",
-		    kvm_check_cap(KVM_CAP_VM_TYPES), 1 << KVM_X86_SEV_VM);
+	/*
+	 * Whether a VM type is available depends on KVM, not just CPUID: e.g.
+	 * when all SEV ASIDs are assigned to SEV-SNP, KVM does not offer the
+	 * SEV VM type even though X86_FEATURE_SEV is set.  Derive availability
+	 * from KVM_CAP_VM_TYPES and only assert the one-way implication that a
+	 * type offered by KVM must also be reported in CPUID.
+	 */
+	have_sev = kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SEV_VM);
+	TEST_ASSERT(!have_sev || kvm_cpu_has(X86_FEATURE_SEV),
+		    "sev: SEV_VM supported without SEV in CPUID");
 
-	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SEV_VM));
+	TEST_REQUIRE(have_sev);
 	have_sev_es = kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SEV_ES_VM);
 
 	TEST_ASSERT(!have_sev_es || kvm_cpu_has(X86_FEATURE_SEV_ES),
-- 
2.55.0

