Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB202C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:17:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CA9010E37F;
	Thu, 16 Jul 2026 15:17:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="HS++1uoM";
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89A4E10E199
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 15:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=GTHIrhHvcUG8/tD5uBJopZ/Rj0rXLsmqhUefdkxikN0=; b=HS++1uoM7E5qtarYIMUkV/1EuE
 tl9Rn8Dh3nZj8UiZoEQYvnIxAW4vlOyP5bN9Xaq4l9l6B5TZKpk+f6U/tJS0XvyNNwrQ7BimdbFZd
 GpwE2LNTMVCABQTuw9hE0UVDRTUR8zhyIEgmAf762qUsBKPAKeMtn3egkZKfoXN2GX8HnnJ4azGov
 e2UIsT2XO7WhtFbLFfYtuWrFYdkD2j9/YA1mf4oy79KP14B9+B7H1LEurDTpvRaWcQkwQIBcS0rEl
 I9jUBFM1VKjH9V27/PwBGFb/LBx+mHVBxBLsF4g6uUxL+OD831WL6ju4RMtQmYFaztp8G7xwrVqdW
 yfYM7LqQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wkNpj-00000002l0F-1dP3; Thu, 16 Jul 2026 15:17:07 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red
 Hat Linux)) id 1wkNpj-000000012sq-04E5;
 Thu, 16 Jul 2026 16:17:07 +0100
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
Subject: [RFC PATCH 01/11] KVM: selftests: sev_smoke_test: Only run VM types
 the host offers
Date: Thu, 16 Jul 2026 10:31:21 +0100
Message-ID: <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716151706.244987-1-dwmw2@infradead.org>
References: <20260716151706.244987-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

sev_smoke_test ran the plain SEV subtest unconditionally, gated only on
the X86_FEATURE_SEV CPUID bit, while gating SEV-ES and SNP on the
KVM_CAP_VM_TYPES bits.  CPUID reporting SEV does not mean KVM offers the
SEV VM type: when all SEV ASIDs are assigned to SEV-SNP, KVM_X86_SEV_VM
is unavailable even though X86_FEATURE_SEV is set.  On such a host the
test aborts in KVM_CREATE_VM instead of exercising the available modes.

Gate the SEV subtest on KVM_CAP_VM_TYPES like the others, so the test
runs the VM types the host actually offers.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/x86/sev_smoke_test.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index 6b2cbe2a90b7..bf27b6187afa 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -247,7 +247,14 @@ int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));
 
-	test_sev_smoke(guest_sev_code, KVM_X86_SEV_VM, 0);
+	/*
+	 * Only exercise VM types the host actually offers.  CPUID reporting
+	 * SEV does not guarantee KVM offers the SEV VM type: when all SEV
+	 * ASIDs are assigned to SEV-SNP, KVM_X86_SEV_VM is unavailable even
+	 * though X86_FEATURE_SEV is set.  Gate every type on KVM_CAP_VM_TYPES.
+	 */
+	if (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SEV_VM))
+		test_sev_smoke(guest_sev_code, KVM_X86_SEV_VM, 0);
 
 	if (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SEV_ES_VM))
 		test_sev_smoke(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES);

base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
-- 
2.54.0

