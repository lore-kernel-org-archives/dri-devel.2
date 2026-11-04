Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588D4606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=frZuJEvB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06041112C49;
	Fri,  6 Nov 2026 09:18:49 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E9BC10FCC0
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 15:06:41 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-3514b90bb89so1506786eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 07:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793804801; x=1794409601; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XWmzhsNQRB07nNAqARUA25IM06jzZZBNn2XShTl+N+4=;
 b=frZuJEvB4yHXlSUGJYJ8jAXv++OL7ikleMIGMLGcKqs1fam6whI2n/Xir+YTXFcnuR
 hjV5Rpe6avRriEf1F90kL1x4Bub/jBmhLPSduDpSvbV1Tf3Gm/VITPSIZi3+H7V3t0N8
 T1oJWnpsfocaaHBcKQSa+wUs5wGtOZ//8z14p685BxMDA/sXV5WbvahNMQa7JiM5CeZW
 7Wi5uF/sEgnTiygerXOYk+Ng6d4NFxabRpG9K7RNX4jHV8bmf+MV/vCAq/AUj+cc1eXy
 3gtYeN21q5gCKsJVEqZ8edZgWDkq3rQbSbzle1BV+VzMf04LXZAWbZjf/oaxs3FgBvY5
 VDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793804801; x=1794409601;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XWmzhsNQRB07nNAqARUA25IM06jzZZBNn2XShTl+N+4=;
 b=XhuBmFFUL0UWY/I7rG9KosZp8XzGDX3R09kMRB656EQpa8xhHyMTc3L4rOeB1IKqFs
 cR6J2J97Uyi3D743Fx4fgtMj71CbZOtIOl/QBno1/eXvQK9OfKYQ/QVRFv9vRoBGkEC2
 NRxCddlSiBl7arkoovrq7CTGcFwePeD4mPP/EXZsD7aNCcQuGKYNDJ8UtcYy82AEI02F
 DWm5CwtM92SVk/v5v3seJrDwHzEAlHHXZ6gI/RmaEhRY4luyBIoqBKLpuAdcC5HvL3KL
 5cM/AUfPAfs+uh/CPfVgRTbZ9yCtj7dR7pENukm4s9JG2wuP33a3n5maUgEHdOfR6Ilq
 DQPQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByGwfCpkck4J3ShlWjXGMQAF5QfT5zV6QtC8qGyAO1k9h79hz6oQ1sw7gbwHe3Sm4YHdsWCotWIzRo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+uMuMU9jEsJD4/yubu4Z6RPYdEXaIFUynHA40nGVYqlOJS6qZG
 7F4sZgkg7hJ06eDVTUFzkCU1DRw5vnPqQd9CTKoHT4t2K68nkEM5gvgh
X-Gm-Gg: AYBFou3H6HRkH0LfD4lRH+0YUEHL7iCLVIeRWXMLmiw1tz10imBi0Yh0ObM8rru9DEb
 qaN9k6KNrqJ65jNRRkCYLOKUlj56sYIXv2/hdnbuj7V5U1tS7WxTRg9DiiByxk6rdA/ayd39C4+
 M3QGoH/gtYNfQcpFQNZG1M2YuoE9gPZDxiphhEEwWsei2BKRX2i6UocLJCd45+fhkBH/pb5qZE0
 JYprrwoACh5+A2aNoWD9+JtwqcJHMnCbV7nuUWBciByrlNnOF5WLTyItz7qcFTbggU5s0u3wDhF
 SMYNWDXSzOA+ga8N+7+sWkpR7x8/Pb+O7L5XAnlm7ck69rhtx3gFbanNHHdxLgY67XzYjG7CY8j
 jNkJiItqtVq7rGQm5oQl6NnXBqtGNiBx+1zSr6mp9ZUSJu7jhIV5xwVGBbF/Pj52xj2237v6xqv
 +SDKUJQjiM7NNtyLUeqJcBw80O4s+ODn5U3tZKekIhKkyrGeUGTAJOVE/H3TZz2Yrp2yQ/I9PHr
 iwH2DuR4fo0GthxEjArjtF3WHieuTzwbo1svDXA1Jf5/symNiSxTwik+KR4QAQkEExqPI3/fhaC
 75dRznqOl7WSMkHSK5lAaRxL7nErTeY+r7uCJA9zFxdzcO3QVMVcgUrZWwNJ7nSHJ5YLCyw5G0W
 5s1k7H4shlddaJ7BMoniKro6iiWL0
X-Received: by 2002:a05:693c:42cd:b0:34d:755b:d60b with SMTP id
 5a478bee46e88-36a42435386mr23523976eec.34.1793804800593; 
 Wed, 04 Nov 2026 07:06:40 -0800 (PST)
Received: from localhost.localdomain ([2405:201:301c:f8cd:5040:8550:f5e4:709a])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36db94376b1sm527287eec.10.2026.11.04.07.06.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Nov 2026 07:06:39 -0800 (PST)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Aryan Sinha <sinha.aryan03@gmail.com>,
 kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] drm/amdgpu: fix kernel-doc in amdgpu_ualink.c
Date: Wed,  4 Nov 2026 20:36:22 +0530
Message-ID: <20261104150632.33843-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The two comments do not describe what follows them. The one above
amdgpu_ualink_npa_vm_unmap_range() is missing the ualink prefix, and the other one for amdgpu_ualink_gart_npa_addr() sits above two defines instead of the function, so kernel-doc attaches it to the first defined one.

hence, Move the defines up and fix the name.
The description also had a stray blank line splitting it in two and said dst_accid_id where it meant dst_accel_id, so join & fix it back up.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202609241952.zFr1FYRB-lkp@intel.com/
Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 6cd3927a7..f875209e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -4631,7 +4631,7 @@ static int amdgpu_ualink_npa_vm_map_range(struct amdgpu_device *adev, struct amd
 }
 
 /**
- * amdgpu_npa_vm_unmap_range - Unmap a range from the NPA VM
+ * amdgpu_ualink_npa_vm_unmap_range - Unmap a range from the NPA VM
  * @adev: amdgpu device pointer
  * @bo: buffer object backing the mapping
  * @pte_flags: page table entry flags
@@ -4727,6 +4727,9 @@ static u64 amdgpu_ualink_npa_addr(struct amdgpu_device *adev, u32 type,
 	return npa;
 }
 
+#define AMDGPU_UALINK_GART_NPA_ADDR_GPUID_SHIFT		41
+#define AMDGPU_UALINK_GART_NPA_ADDR_GPUID_MASK		GENMASK_ULL(50, 41)
+
 /**
  * amdgpu_ualink_gart_npa_addr - Get GART-mapped NPA address for ring buffer
  * @adev: amdgpu device pointer
@@ -4734,18 +4737,12 @@ static u64 amdgpu_ualink_npa_addr(struct amdgpu_device *adev, u32 type,
  * @src_accel_id: Source accelerator ID
  * @dst_accel_id: Destination accelerator ID
  *
- * Computes the NPA address suitable for GART mapping by adding dst_accid_id to
- * NPA address to access remote by SDMA.
-
- * clears the source GPU ID bits from the NPA address which is set for
- * address-identification mode.
+ * Computes the NPA address suitable for GART mapping by adding dst_accel_id to
+ * NPA address to access remote by SDMA. It also clears the source GPU ID bits
+ * from the NPA address which is set for address-identification mode.
  *
  * Return: NPA address adjusted for GART mapping
  */
-
-#define AMDGPU_UALINK_GART_NPA_ADDR_GPUID_SHIFT		41
-#define AMDGPU_UALINK_GART_NPA_ADDR_GPUID_MASK		GENMASK_ULL(50, 41)
-
 static u64 amdgpu_ualink_gart_npa_addr(struct amdgpu_device *adev, u32 type,
 					u32 src_accel_id, u32 dst_accel_id)
 {
-- 
2.46.0

