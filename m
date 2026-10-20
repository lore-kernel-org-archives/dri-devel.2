Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D95606A323
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qsajWdSw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0493D10F282;
	Tue, 20 Oct 2026 06:38:41 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80EF510F278
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 06:38:33 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so2393025f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 23:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792478312; x=1793083112; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZfCKuhuFLFgY7+lDwr5/B266OUdv6BfsTvR8mFssGTA=;
 b=qsajWdSwkmGvTdDPO1lhoF0efuhDE7UGTrVV6+uRnhlKfeguerY0IIJNHo8DvpWEIr
 9EmbodGgm8dnos5i5evPPI+Fd+Z1e+9BZ8JKBCIMlFOo8AZJkE6CoSkNAHmOSLPeqjjx
 K5cknaixTxUfJo4nfH9kZUhD6Bc/WGz8IMCgcGToVj9sKtfvSsXCxRpo66U3MmIIgOFy
 z8FeaeWfVb44/aIaQzv5Hl9EGZfMzdq3VjX87bmTyxyf7HWwlIk7Hz537q0SIwqc1lLh
 fTJsNxj8l0HkPvgi+ecIrOpPVhPr9wWh+rCB2VTCasY4aicHOBwWgNrziDjVT1dWLppe
 /Avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792478312; x=1793083112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZfCKuhuFLFgY7+lDwr5/B266OUdv6BfsTvR8mFssGTA=;
 b=Pxu/rB38l6baf1IPWi+MIjhD/dks4UFwzQjIPIGh2CcivX8uvTniziEIHgnWxSJ+9I
 C4qx+b2UWisjV+WUka9OQSYLKNOR7MKs/N/FdQ7/5OGLytHM7kPHi2G2JjcLMb/PYbcO
 pYY+4vdrFoImuur3pR5U6f3q5F7XFMrUiTlWQixHyiWmV7YhBmXNgw7YpxE1CPW7NvGM
 XW0vV5p/DWaCedsqQqsB0HubPEgSgcImvPjcKLuYvOuDA8r5H2DS7R26bTjgZ9linHUH
 cs203AtijnReyeFo06IBSyC00/T+S6f+F7uU1smfgrLt9q92JgGQLtVaQ2YgQDieauYe
 /+qg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxigJUObMrGsDDsk1DXVpemABbxMOZ8OnqTT2xs4NqZgjnF5Fbh3gQijsX/z4Dul3S0vQC0eGgBmLU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ9hJG8WWZCoEhIuV/jG9S7PGSktasy61CIVrGMRqx9UaTrQOud
 y/lXbRcXNbyEePgRAaMTH6jeqTX4n71H+5HWAFqBwf2aPUZWPjqtr3kI
X-Gm-Gg: AYBFou236Pp5WoV/hTFdUixhRV/wsTyvwn3/OB7cO0y9OVJuoXgy7O5IAitz9WC6mLz
 AlZtwSqSYQUdxpE/GH7GJIevW5nnW3CWdyYGKY1lGXwKFn+/nkV4zNv2r8IkjVyDp+NBl3ANN1o
 d8hHQCTanQUh7xnx11ycpj9nV6low1lEx2ZaNmT2tCVeQtwSj0mBnjVsQ4hTfnDMWcYBjaBFVVI
 mFb+kNZeeU2Q5jUNQg6BCP325U8UaDLg1gSuDP0OmpDaFk1X2E4RUiwgpAYR8tMVPtxwaTds5o+
 RLuSZkn+8uNujBe+Dx61d//2g+Ire8aBMPgEPgFA2CP9I9LlIdVf1d5l5+PnOBhJVNOidl4esBl
 Rx02uxYwrpSLYtt9vDLGeq26VReRmDtXlavRhnIi0OVjNqKs2lhB5l0Q/LHTQzzqolhEEoT8RKI
 mM4s9QPPIiJ8wZzRX+klIHh/5DRhlZ61PXKlBdNilB2/DYYFJKkC6mUYz/iel76B4g3IaxPktvB
 V2RIQY2frXSNOsx2n+VYL1TAKd7Mb8ikf06u80VmVJUjNA28FQBqjn/cRhsMH590zkoKPRoPYAB
 8BD1JP/i41BHK/Y33U5QEmJicA6bNmHOLShkoLsWqbF0VKssYwnsK3S0VfIb77F3JIVihY7jKA9
 0UA==
X-Received: by 2002:a05:6000:490f:b0:48d:f99d:a0d2 with SMTP id
 ffacd0b85a97d-48e07bbe6a1mr21638509f8f.15.1792478311632; 
 Mon, 19 Oct 2026 23:38:31 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-9c92-6501-2169-eb9c-7ad3-f5db.310.pool.telefonica.de.
 [2a02:3100:9c92:6501:2169:eb9c:7ad3:f5db])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d820714sm3916393f8f.35.2026.10.19.23.38.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Oct 2026 23:38:30 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [RFC PATCH 4/6] iommufd: Keep the pages mutex alive until DMA-buf
 detach
Date: Tue, 20 Oct 2026 08:37:43 +0200
Message-Id: <fdb5d9715d7f278ac24f05246f09703edb283525.1792477872.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1792477872.git.kmehltretter@gmail.com>
References: <cover.1792477872.git.kmehltretter@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

iopt_release_pages() destroys pages->mutex before removing the DMA-buf
attachment. The linked attachment still exposes pages through
importer_priv. An invalidation can enter iopt_revoke_notify() and lock
the destroyed mutex, including when exp_phys is already NULL.

Destroy pages->mutex after dma_buf_detach() has removed the attachment
and excluded further invalidation callbacks.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/iommu/iommufd/pages.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 76d8803d6..59ee68a1a 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1667,7 +1667,6 @@ void iopt_release_pages(struct kref *kref)
 	WARN_ON(pages->npinned);
 	WARN_ON(!xa_empty(&pages->pinned_pfns));
 	mmdrop(pages->source_mm);
-	mutex_destroy(&pages->mutex);
 	put_task_struct(pages->source_task);
 	free_uid(pages->source_user);
 	if (iopt_is_dmabuf(pages) && pages->dmabuf.attach) {
@@ -1689,6 +1688,7 @@ void iopt_release_pages(struct kref *kref)
 	} else if (pages->type == IOPT_ADDRESS_FILE) {
 		fput(pages->file);
 	}
+	mutex_destroy(&pages->mutex);
 	kfree(pages);
 }
 
-- 
2.39.5 (Apple Git-154)

