Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE953CA5FFE
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 07:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3686B10F208;
	Tue,  6 Oct 2026 07:24:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JyHgkiQQ";
	dkim-atps=neutral
Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com
 [74.125.228.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B1D010E245
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 09:55:57 +0000 (UTC)
Received: by mail-ej2-f41.google.com with SMTP id
 a640c23a62f3a-c2e1195040aso250429366b.2
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 02:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791194155; x=1791798955; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hBckql0s/2nEbii/g+PLtX2a0BnDe1iX6ffCpfRgr1I=;
 b=JyHgkiQQLWBo9Oyh7DxaOvIH3mq8qP8IE2Dy6l6u8lJnHdRkzPjSG7wY4HufnwoucL
 bSQOhg1xdNdPGS0Ye1ymBUncSb8FS+Td6UzRECTwNuHdN2K7TGDGj7dHFMfBBqq+Si14
 HkllqTOLKy++Qzzo8txyWd2uPLHCG3O0BpZswNHuE0mSGxyElvyBXplqt9G5G4fdVA/j
 JdARen2ydHCoQM2Ptp09XF1FLeWd7vm46gwY1qFawjdi2hMhM4cJ2RJD4ZppAi94V0tW
 wBdC/BMmTZrh7awCyaodN0runtKDwWetVnbtSD+OVKBL1GIrWbzEYysVhqMMjW1XA4G4
 tcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791194155; x=1791798955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hBckql0s/2nEbii/g+PLtX2a0BnDe1iX6ffCpfRgr1I=;
 b=coo2OMXMeDE1xGUzFu4CrFC65NMVcfxG2Piksek9LiHY9Ywt2LaMbrvXLI+r0XhRYG
 1MvD+MINbGIEycRZxLGbwnbqmcg0g5o2WcmpURnyZFhSBGkQ8AmIzxEMXtOOkrSN5Lw5
 //2qMHYRVnMKNjP17/RTj2ptB5kes/5kYizvEk1rq6oqM/4b1qG8oM0ocJK6SNUzUNZY
 1YJGvAqF+40zs+xNZVMlXQIYkDwv0WRH3Vj6DqYODMAu1FlY6y8377nUaQ5cTaLU+ugz
 59d4xnRtQVNTUJFXnuLivqZk7J3iljWdLSV0+/uTPNvzPQYGlAiGZfP1Uuk20+rb1ADU
 wMTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx776HbxDStcOfjqppIUhNPWkDTbDCuxuqJZnfuQPK+k1Q6UIj60Snjwl2Koar6su/yzzl06qLzqro=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mrz/uBLJH+LyFx+v+JrcaM4U4ozGuckbpuJHe4263lkPrZRDU0
 XJMgNlVhvzyZihBfG9u07CykcLaG0F7eEJPPuhJPBX4RQFEabccipipu
X-Gm-Gg: AYBFou1lhf0PGnJY5f0HqL5nSBoGpy2gbvitgBMwGxfbuHK/VC9Xpddskfk8yBCXZs2
 3pMcHO9nz7CtYISVkEeAMDANcPdY3GCj+nu94V5/wUjy4JCVonneVKzLZD7JDCQ2gAuN74B9RsO
 kpsVEMJlFkKaVydDj7YKqUA3Ko6UGDrhlv/Fhdxs/06v8Bn2N2LveAU+ZIDr8EpnVGlNys3ahGr
 07DAG2GEGrShR74wjDNszkd6kXHzyrs4y51wiBb4nHKmfL0uAPjdkOtnAAVWyTudkJkMsML7KsT
 BFeGaYkaLMh2V1s9RfxrJnNmur+N6C1hG8ZpkbSU06pO4jtwOkkjWX8YtsfzD598NMiGB91MB7w
 vHW/zFv0dQGkQY3GixGttwsZ0WlItK0xKBITCNIDMXr3IgnhZZL+H/ntLXwqR6v6vVHAy6yT9sU
 nRIuYtCmkFW0QszhR7iBB6okjxhjW/vfDx8p0sDxiKIt+1Pj4r9hxvEPcDkhQtDFSKxFj8/poxk
 h71vxxMjAhIVoh863XVE1RMuPt1JJUc0np7KWnpD6OT4xrnia0MJA7caOzF+UwMii3b3GJ7yadU
 GpqzsxYH6ttv+Jy4zw12ss6xxgLHyzN5lmflXxW5MLUFbvs=
X-Received: by 2002:a05:6938:a090:20b0:c2e:52d6:1fb7 with SMTP id
 a640c23a62f3a-c2e52d6226amr528492566b.22.1791194155086; 
 Mon, 05 Oct 2026 02:55:55 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com
 (54-240-197-234.amazon.com. [54.240.197.234])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31562aba16sm50753266b.23.2026.10.05.02.55.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 02:55:54 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oupton@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
 Ackerley Tng <ackerleytng@google.com>, Joey Gouly <joey.gouly@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Steffen Eiden <seiden@linux.ibm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>, Alex Williamson <alex@shazbot.org>,
 Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org
Subject: [RFC PATCH 1/6] KVM: guest_memfd: Add a writable result to get_pfn()
Date: Mon,  5 Oct 2026 09:55:47 +0000
Message-ID: <20261005095552.52748-2-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005095552.52748-1-griffoul@gmail.com>
References: <20260720111259.122911-1-dwmw2@infradead.org>
 <20261005095552.52748-1-griffoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 06 Oct 2026 07:24:11 +0000
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

From: Fred Griffoul <fgriffo@amazon.co.uk>

A guest_memfd backing has no way to tell KVM that a page must stay
mapped but must not be written by the guest. get_pfn() returns only a
frame, and KVM takes write access from the memslot flags.
KVM_MEM_READONLY is not an option: KVM refuses it on guest_memfd slots,
because it emulates a write to a read-only slot as MMIO, which private
memory cannot support.

Add a writable output to get_pfn(). KVM sets it to true before the
call, and the backing may clear it. When it is false, the x86 and arm64
stage-2 fault paths map the page without write permission. A guest
write to that page then exits to userspace as a memory fault; KVM first
releases any page that the backing returned. Callers that do not map
the page pass NULL.

The result applies to stage-2 mappings only. When KVM writes guest
memory through the memslot's host address, the permissions of the host
mapping apply.

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 arch/arm64/kvm/mmu.c        | 13 ++++++++-----
 arch/arm64/kvm/nested.c     | 10 +++++++---
 arch/x86/kvm/mmu/mmu.c      | 18 ++++++++++++++++--
 arch/x86/kvm/svm/sev.c      |  4 ++--
 include/linux/kvm_host.h    | 11 ++++++++---
 samples/kvm/gmem_provider.c |  3 ++-
 virt/kvm/guest_memfd.c      | 13 ++++++++-----
 7 files changed, 51 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 6c941aaa10c6..32e591edc69d 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1607,7 +1607,7 @@ struct kvm_s2_fault_desc {
 
 static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
 {
-	bool write_fault, exec_fault;
+	bool write_fault, exec_fault, writable;
 	bool perm_fault = kvm_vcpu_trap_is_permission_fault(s2fd->vcpu);
 	enum kvm_pgtable_walk_flags flags = KVM_PGTABLE_WALK_SHARED;
 	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
@@ -1641,14 +1641,17 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
 	/* Pairs with the smp_wmb() in kvm_mmu_invalidate_end(). */
 	smp_rmb();
 
-	ret = kvm_gmem_get_pfn(kvm, s2fd->memslot, gfn, &pfn, &page, NULL);
-	if (ret) {
+	ret = kvm_gmem_get_pfn(kvm, s2fd->memslot, gfn, &pfn, &page, NULL,
+			       &writable);
+	if (ret || (write_fault && !writable)) {
 		kvm_prepare_memory_fault_exit(s2fd->vcpu, s2fd->fault_ipa, PAGE_SIZE,
 					      write_fault, exec_fault, false);
-		return ret;
+		if (!ret)
+			kvm_release_faultin_page(kvm, page, true, false);
+		return ret ?: -EFAULT;
 	}
 
-	if (!(s2fd->memslot->flags & KVM_MEM_READONLY))
+	if (!(s2fd->memslot->flags & KVM_MEM_READONLY) && writable)
 		prot |= KVM_PGTABLE_PROT_W;
 
 	if (s2fd->nested)
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index fb54f6dad995..9ad1fa029835 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1411,12 +1411,16 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 		if (is_error_noslot_pfn(pfn) || (write_fault && !writable))
 			return -EFAULT;
 	} else {
-		ret = kvm_gmem_get_pfn(vcpu->kvm, memslot, gfn, &pfn, &page, NULL);
-		if (ret) {
+		ret = kvm_gmem_get_pfn(vcpu->kvm, memslot, gfn, &pfn, &page, NULL,
+				       &writable);
+		if (ret || (write_fault && !writable)) {
 			kvm_prepare_memory_fault_exit(vcpu, vt->wr.pa, PAGE_SIZE,
 					      write_fault, false, false);
-			return ret;
+			if (!ret)
+				kvm_release_faultin_page(vcpu->kvm, page, true, false);
+			return ret ?: -EFAULT;
 		}
+		vt->wr.pw &= writable;
 	}
 
 	scoped_guard(write_lock, &vcpu->kvm->mmu_lock) {
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 234d0a95abf5..17ac2bfdc164 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4612,6 +4612,7 @@ static void kvm_mmu_finish_page_fault(struct kvm_vcpu *vcpu,
 static int kvm_mmu_faultin_pfn_gmem(struct kvm_vcpu *vcpu,
 				    struct kvm_page_fault *fault)
 {
+	bool writable;
 	int max_order, r;
 
 	if (!kvm_slot_has_gmem(fault->slot)) {
@@ -4620,13 +4621,26 @@ static int kvm_mmu_faultin_pfn_gmem(struct kvm_vcpu *vcpu,
 	}
 
 	r = kvm_gmem_get_pfn(vcpu->kvm, fault->slot, fault->gfn, &fault->pfn,
-			     &fault->refcounted_page, &max_order);
+			     &fault->refcounted_page, &max_order, &writable);
 	if (r) {
 		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
 		return r;
 	}
 
-	fault->map_writable = !(fault->slot->flags & KVM_MEM_READONLY);
+	/*
+	 * The memory's owner has the final say on writability, on top of the
+	 * memslot flag: a page it reports read-only is mapped read-only, and a
+	 * guest write to it exits to userspace rather than being installed.
+	 */
+	fault->map_writable = !(fault->slot->flags & KVM_MEM_READONLY) &&
+			      writable;
+	if (fault->write && !fault->map_writable) {
+		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
+		kvm_release_faultin_page(vcpu->kvm, fault->refcounted_page,
+				 true, false);
+		fault->refcounted_page = NULL;
+		return -EFAULT;
+	}
 	fault->max_level = kvm_max_level_for_order(max_order);
 
 	return RET_PF_CONTINUE;
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 125779c82bc4..983e19f7dbd2 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4063,7 +4063,7 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 	 * The new VMSA will be private memory guest memory, so retrieve the
 	 * PFN from the gmem backend.
 	 */
-	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
+	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL, NULL))
 		return;
 
 	/*
@@ -4996,7 +4996,7 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
 		return;
 	}
 
-	ret = kvm_gmem_get_pfn(kvm, slot, gfn, &pfn, &page, &order);
+	ret = kvm_gmem_get_pfn(kvm, slot, gfn, &pfn, &page, &order, NULL);
 	if (ret) {
 		pr_warn_ratelimited("SEV: Unexpected RMP fault, no backing page for private GPA 0x%llx\n",
 				    gpa);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 04fa0cb126f6..f84f3ab44acf 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -660,9 +660,14 @@ struct kvm_gmem_ops {
 		    struct kvm_memory_slot *slot, loff_t offset);
 	void (*unbind)(struct file *file, struct kvm *kvm,
 		       struct kvm_memory_slot *slot);
+	/*
+	 * @writable: [out] clear to have KVM map the page read-only; a guest
+	 * write then exits as a memory fault.  NULL if the caller does not care.
+	 */
 	int (*get_pfn)(struct file *file, struct kvm *kvm,
 		       struct kvm_memory_slot *slot, gfn_t gfn,
-		       kvm_pfn_t *pfn, struct page **page, int *max_order);
+		       kvm_pfn_t *pfn, struct page **page, int *max_order,
+		       bool *writable);
 	int (*populate)(struct file *file, struct kvm *kvm,
 			struct kvm_memory_slot *slot, gfn_t gfn,
 			kvm_pfn_t *pfn, struct page *src_page, int order);
@@ -2651,12 +2656,12 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 #ifdef CONFIG_KVM_GUEST_MEMFD
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		     gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
-		     int *max_order);
+		     int *max_order, bool *writable);
 #else
 static inline int kvm_gmem_get_pfn(struct kvm *kvm,
 				   struct kvm_memory_slot *slot, gfn_t gfn,
 				   kvm_pfn_t *pfn, struct page **page,
-				   int *max_order)
+				   int *max_order, bool *writable)
 {
 	KVM_BUG_ON(1, kvm);
 	return -EIO;
diff --git a/samples/kvm/gmem_provider.c b/samples/kvm/gmem_provider.c
index 9728f5a8029b..75197c088762 100644
--- a/samples/kvm/gmem_provider.c
+++ b/samples/kvm/gmem_provider.c
@@ -157,7 +157,8 @@ static int gmem_max_order(struct gmem_info *info, gfn_t gfn, unsigned long index
 
 static int gmem_get_pfn(struct file *file, struct kvm *kvm,
 			struct kvm_memory_slot *slot, gfn_t gfn,
-			kvm_pfn_t *pfn, struct page **page, int *max_order)
+			kvm_pfn_t *pfn, struct page **page, int *max_order,
+			bool *writable)
 {
 	struct gmem_info *info = to_gmem_info(file);
 	pgoff_t index = gfn - slot->base_gfn + slot->gmem.pgoff;
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index d284bb70fe05..0f4bf2cc5e8e 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -624,7 +624,7 @@ static void kvm_gmem_native_unbind(struct file *slot_file, struct kvm *kvm,
 static int  kvm_gmem_native_get_pfn(struct file *file, struct kvm *kvm,
 				    struct kvm_memory_slot *slot, gfn_t gfn,
 				    kvm_pfn_t *pfn, struct page **page,
-				    int *max_order);
+				    int *max_order, bool *writable);
 static void kvm_gmem_native_release(struct file *file);
 static int  kvm_gmem_native_mmap(struct file *file,
 				 struct vm_area_struct *vma);
@@ -988,7 +988,7 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
 static int kvm_gmem_native_get_pfn(struct file *file, struct kvm *kvm,
 				   struct kvm_memory_slot *slot, gfn_t gfn,
 				   kvm_pfn_t *pfn, struct page **page,
-				   int *max_order)
+				   int *max_order, bool *writable)
 {
 	pgoff_t index = kvm_gmem_get_index(slot, gfn);
 	struct folio *folio;
@@ -1016,7 +1016,7 @@ static int kvm_gmem_native_get_pfn(struct file *file, struct kvm *kvm,
 
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		     gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
-		     int *max_order)
+		     int *max_order, bool *writable)
 {
 	const struct kvm_gmem_ops *ops;
 
@@ -1029,7 +1029,10 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		return -EFAULT;
 
 	*page = NULL;
-	return ops->get_pfn(file, kvm, slot, gfn, pfn, page, max_order);
+	if (writable)
+		*writable = true;
+	return ops->get_pfn(file, kvm, slot, gfn, pfn, page, max_order,
+			    writable);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
 
@@ -1093,7 +1096,7 @@ static int kvm_gmem_populate_one(const struct kvm_gmem_ops *ops,
 				    src_page, 0);
 	else
 		ret = ops->get_pfn(file, kvm, slot, gfn, &pfn,
-				   &ignored_page, NULL);
+				   &ignored_page, NULL, NULL);
 	if (ret)
 		return ret;
 
-- 
2.47.3

