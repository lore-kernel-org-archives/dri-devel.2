Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8DA606A31A
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 05:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qV0mMbut
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A855F10E256;
	Sun,  8 Nov 2026 05:23:55 +0000 (UTC)
Received: from mail-pi2-f10.google.com (mail-pi2-f10.google.com
 [74.125.227.202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20D3910EACA
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 05:23:49 +0000 (UTC)
Received: by mail-pi2-f10.google.com with SMTP id
 41be03b00d2f7-cd65a511e43so115217a12.1
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 21:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794115428; x=1794720228; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nPcc1C6VpjmCET3tBtMp/wreo0ZSVB6OHb06Azdk0dk=;
 b=qV0mMbutnaItxUe5JxptVO5bLEfKpy6Vg3UERY7pMc85uKwt0wwQ6D0vhBihBzPs0T
 VEyOpesuDtuOg+QYK03E49SylxwOEcWzuvg2gMW4QJi7XWYTQNu0w2bYrAP5UpraiimJ
 tUnFNMsE3YTmEJkliwauXaebFUNMPkaxYp0Y1U77DXIeqrVAFfAKbLiEQwQc8UalLNZL
 12bfQlNHE8XQrvBTGLAe763d8AJWAOFC+c9EETZXZOlfWDNFyfdC2ax2EDyOPR1KP0Ex
 YRQL0CaT88LgnAlOCaqsKp+seckab0geM6NcPAWDGMWBzF9E9oI9aFDgx0Mg43pdTfXt
 qyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794115428; x=1794720228;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nPcc1C6VpjmCET3tBtMp/wreo0ZSVB6OHb06Azdk0dk=;
 b=n4oq7Gcm7azsJUNgpY95v59Xa0FERS74ZlNGL4hZb0H4TaYk7v/L8blqWUQLsjlw3x
 c2M7CyRJXj9d/mynoYtzcjPmxlUgci2HsFpqdrRyfFrXDKae3FKRfwrk0kV9dx1K1nFx
 JFwPGooA9+1pwt2yn08ohcTRaGe8cZmSmSpopFzjDaTuTGKkEiJXESxoTPAm553lTPfy
 aRaaYrVPYQI07VdWQiDbnuvC5qWFGOS3MR1smZiLl/24FSc9nIIC9yfD4madZy32iaj7
 BOz/TlME9izsz6SwmBYEuUnPmqj25+adw3jLZbXvPW9p/5IgIngH0AlEFpTaPK5WZ0BB
 mS7Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEwntk0HXajgraw8HaHf+k6o30TZCQyqejB7cbAkiP1G7a/LPIx1FGlVUZXOP2rUJ4lRPJ9IxBz+yI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8fTBR/9pKuiAtNx2iFEi9qTVq2MOWWsckla2l6PGlstFPWNEeQ
 rCo3Luf6b6IkjUCctFRMUDQ/fMGJ1fcwzJwHSyIcUKW6+XSMUDHMRT5W
X-Gm-Gg: AYBFou2XOVCy0+WTsTRCyt21s3GN5WrXogyWIsnrcjR4IDSJ1Dcq8plft+dt4/cXCIe
 v+N7grqXz9iAu8XQ9FrMy+dz6g2hkmlY4sbevreSsLKia0ok3RqSiTcI3BiCng8/h/V52egvNIr
 ctkZqqgHmAmPFrnWx4UGFwrWCkLO1Hv3Juc4/KWLqQsjeCQz/hwZ8Z7Hgr5A+n+Wn/FZ3PaUFyJ
 duaK3p3U5ZdROlX/hJcMsRb8NGr2AVM9g6ILgBsGSmHKGgJwFAwFookju42UciE6bo9qJ83X8fl
 7bRtJj/NqiW7RJMdZVq9PtBwoUfNqE1VQgr9Tzir1t1rHBi/jiu7R9LRo0bmwP6MCSmZQRGdXmh
 NYkCNpHBBtYv438txkwpKo/nR1Xdhnw24QugU5vOwFrCex2dinAV3yOckSfJ3hNEgRqd1DR9cK1
 AtrG1eDqx1wGgKhcmhcqXPhmKa7rjl7USxdgRdprUs2fa95Dp77L1XpaJlIGTt6du5MRMMbRziv
 2UuGJyMBONup4FAyrdqYnR354EszDSmbI24dhoHdjOr9XpqFN84RUP4LbIZt2jVZnjWX4RhmcE2
 pn8s36+xk4NEGbt7ZoS1dUjJM6GUPygv4euwhpjeel3ugMUqZkwWWEkblfa95gQb55NapuN7bNc
 OHOzqtLCKKkl4M1IaUlwe6k0m7sV5/n/NYCQP2NcJKBSii/w=
X-Received: by 2002:a05:6a00:3313:b0:890:a995:1f61 with SMTP id
 d2e1a72fcca58-8b66ef0603fmr596011b3a.15.1794115428353; 
 Sat, 07 Nov 2026 21:23:48 -0800 (PST)
Received: from [192.168.50.20] (42-98-155-143.static.netvigator.com.
 [42.98.155.143]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b646bd4af6sm281341b3a.2.2026.11.07.21.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 21:23:48 -0800 (PST)
From: Aveline Noir <jm5905938@gmail.com>
Date: Sun, 08 Nov 2026 16:13:33 +1100
Subject: [PATCH 1/2] drm/amdkfd: handle SVM interval notifier registration
 failures
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-kfd-svm-baseline-errors-20261107-v1-1-9ef4008019ab@gmail.com>
References: <20261108-kfd-svm-baseline-errors-20261107-v1-0-9ef4008019ab@gmail.com>
In-Reply-To: <20261108-kfd-svm-baseline-errors-20261107-v1-0-9ef4008019ab@gmail.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Philip Yang <Philip.Yang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, 
 honghuan@amd.com, honglei1.huang@amd.com, psirt@amd.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,SUBJECT_DRUG_GAP_L,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The first interval notifier registration for an mm can fail while
initializing the interval tree. svm_range_add_notifier_locked() ignores
that error, so SET_ATTR and retry-fault handling can publish an SVM range
without a registered notifier. Subsequent HMM access can then dereference
an uninitialized notifier.

Propagate the registration error and register staged ranges before
publishing the SET_ATTR transaction. Remove successful registrations on
failure before freeing the staged ranges, preserving the original ranges
and the existing memory-accounting rollback. Also free an unpublished
retry-fault range and return its registration error.

Fixes: b1c46c7d622b ("drm/amdkfd: validate svm range system memory")
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 56 +++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index ed5e3318877b..8184cbbb829e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -106,16 +106,21 @@ static void svm_range_unlink(struct svm_range *prange)
 		interval_tree_remove(&prange->it_node, &prange->svms->objects);
 }
 
-static void
+static int
 svm_range_add_notifier_locked(struct mm_struct *mm, struct svm_range *prange)
 {
+	int r;
+
 	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx]\n", prange->svms,
 		 prange, prange->start, prange->last);
 
-	mmu_interval_notifier_insert_locked(&prange->notifier, mm,
+	r = mmu_interval_notifier_insert_locked(&prange->notifier, mm,
 				     prange->start << PAGE_SHIFT,
 				     prange->npages << PAGE_SHIFT,
 				     &svm_range_mn_ops);
+	if (r)
+		prange->notifier.mm = NULL;
+	return r;
 }
 
 /**
@@ -2257,6 +2262,7 @@ svm_range_split_new(struct svm_range_list *svms, uint64_t start, uint64_t last,
 /**
  * svm_range_add - add svm range and handle overlap
  * @p: the range add to this process svms
+ * @mm: the process address space, write locked by the caller
  * @start: page size aligned
  * @size: page size aligned
  * @nattr: number of attributes
@@ -2285,7 +2291,8 @@ svm_range_split_new(struct svm_range_list *svms, uint64_t start, uint64_t last,
  * 0 - OK, otherwise error code
  */
 static int
-svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
+svm_range_add(struct kfd_process *p, struct mm_struct *mm,
+	      uint64_t start, uint64_t size,
 	      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
 	      struct list_head *update_list, struct list_head *insert_list,
 	      struct list_head *remove_list, struct list_head *remap_list)
@@ -2373,17 +2380,38 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	}
 
 	/* add a final range at the end if needed */
-	if (start <= last)
+	if (start <= last) {
 		r = svm_range_split_new(svms, start, last,
 					READ_ONCE(max_svm_range_pages),
 					&new_list, update_list);
+		if (r)
+			goto out;
+	}
+
+	/* Register all notifiers before publishing any of the new ranges. */
+	list_for_each_entry(prange, &new_list, list) {
+		r = svm_range_add_notifier_locked(mm, prange);
+		if (r)
+			goto out;
+	}
+	list_for_each_entry(prange, insert_list, list) {
+		r = svm_range_add_notifier_locked(mm, prange);
+		if (r)
+			goto out;
+	}
 
 out:
 	if (r) {
-		list_for_each_entry_safe(prange, tmp, insert_list, list)
+		list_for_each_entry_safe(prange, tmp, insert_list, list) {
+			if (prange->notifier.mm)
+				mmu_interval_notifier_remove(&prange->notifier);
 			svm_range_free(prange, false);
-		list_for_each_entry_safe(prange, tmp, &new_list, list)
+		}
+		list_for_each_entry_safe(prange, tmp, &new_list, list) {
+			if (prange->notifier.mm)
+				mmu_interval_notifier_remove(&prange->notifier);
 			svm_range_free(prange, true);
+		}
 	} else {
 		list_splice(&new_list, insert_list);
 	}
@@ -3011,8 +3039,12 @@ svm_range *svm_range_create_unregistered_range(struct kfd_node *node,
 	if (is_heap_stack)
 		prange->preferred_loc = KFD_IOCTL_SVM_LOCATION_SYSMEM;
 
+	r = svm_range_add_notifier_locked(mm, prange);
+	if (r) {
+		svm_range_free(prange, true);
+		return ERR_PTR(r);
+	}
 	svm_range_add_to_svms(prange);
-	svm_range_add_notifier_locked(mm, prange);
 
 	return prange;
 }
@@ -3203,11 +3235,11 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			goto retry_write_locked;
 		}
 		prange = svm_range_create_unregistered_range(node, p, mm, addr);
-		if (!prange) {
+		if (IS_ERR_OR_NULL(prange)) {
 			pr_debug("failed to create unregistered range svms 0x%p address [0x%llx]\n",
 				 svms, addr);
 			mmap_write_downgrade(mm);
-			r = -EFAULT;
+			r = prange ? PTR_ERR(prange) : -EFAULT;
 			goto out_unlock_svms;
 		}
 	}
@@ -3839,7 +3871,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	mutex_lock(&svms->lock);
 
 	/* Add new range and split existing ranges as needed */
-	r = svm_range_add(p, start, size, nattr, attrs, &update_list,
+	r = svm_range_add(p, mm, start, size, nattr, attrs, &update_list,
 			  &insert_list, &remove_list, &remap_list);
 	if (r) {
 		mutex_unlock(&svms->lock);
@@ -3847,10 +3879,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		goto out;
 	}
 	/* Apply changes as a transaction */
-	list_for_each_entry_safe(prange, next, &insert_list, list) {
+	list_for_each_entry_safe(prange, next, &insert_list, list)
 		svm_range_add_to_svms(prange);
-		svm_range_add_notifier_locked(mm, prange);
-	}
 
 	list_for_each_entry(prange, &update_list, update_list)
 		svm_range_apply_attrs(p, prange, nattr, attrs, &update_mapping);

-- 
2.56.0

