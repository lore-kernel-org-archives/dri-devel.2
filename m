Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE7C606A331
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 20:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vDXQf+mX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E74E10ECA7;
	Fri, 13 Nov 2026 20:26:49 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A407D1127C0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:26:41 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-8b4bc5b8de5so539587b3.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794601600; x=1795206400; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N/fUclXpqfBbRTXstkD/0tb3Qwq7pJB/lf0GrepOYDw=;
 b=vDXQf+mXGErGpym6tfwDhKbM6KSMCZ4rmDnCB0He961PbWh8SXrAdHpS1FmZ9J1Ddf
 cmhF985R28rtQZrtZVapER1I+fdFDumpwMz/6mRm0WS+OzBLTJxe3YzdxozLOFmuA+am
 cMshNHQSynd/ngzqdzmBPwzS/itTmoJmlj6K1wpmR9O9hCc6hPlgfbXWzpVUox1YvqlW
 SNMguzDb2lRUKQmiseVPV06EUP5sSdgFT2sl9r/y2s9zO1dCfO0DxOcQDW4Yi1eKdMCB
 nsaTapZOSdqj4DD9CkzWjP8GdTKeLM3GeSvbxu8qJ/rW7SYjpElrC7mOD7CTpR3pW4/W
 Iedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794601600; x=1795206400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=N/fUclXpqfBbRTXstkD/0tb3Qwq7pJB/lf0GrepOYDw=;
 b=tI+WnTlngwHFvhKVFx4SLLbSCbcvic+NGW4947ILPTOMmVrW6+laBMQ+YcVUrftl5H
 o9mbDErderJ3EksObrvo2kPePRg9LloeFi91YLYwIouHQigEUUVN/O0V+u6uyZ3rfsVL
 rBJQmst4PAw3FSjFuWLALiCDNtPUMR6PAPleaFSJ707CbqWDka5zvOZCGG11aQ9ucCie
 htBxm3Ws/HR4RGM6bib9x16vTqKPKFnLYv5yYqefN+Ibnq1rH5Bl1gaksiV85TwSVwAI
 Ipr3HXfuMacJy69b0+mHiiXh7uUNo+KJbHHEgyMd1r1/wTcKrIplKfxXo3u1wxDqUQbc
 LSsA==
X-Gm-Message-State: APuU4Z/ZvEZbCqCUhgdYhaZ3Ag96HFiClfZKqsM1epaL3MV15P0P5CDn
 7t/i7DGvDgf5RCxf/wWmyge1YLB38niTAa5wPcQO3IXZz5mZZLlQvKCXXAo92eymb88=
X-Gm-Gg: AYBFou3fcEfHhbhkBHABt6SZsaosi7ed/z1+QIidFey5rUpynR/0F5h9Pa95nq/9Ta0
 bjeHMDr7edwe3DNlGQlu8zXO/7TGrptwFillLK0Rbrvx/RBm3GBHVtJvJPa+XA4OKXLdhoTAhg4
 68NBwlm88UKJAns8uFh4NoA/gDjIrz3IO53Rlo90GQRh7QsBUZ4ZUeaN8owMdmVit40XgrfrHAx
 rw5oliW8xJI4MAbkNOejBWmFbo6LbHvNskTjpdnHDOALDb1VPxZwJ/MjzD0m2rRUATAsdDVLEMS
 XGPEEe07MQyCUGIhSDJrBwdlevYn+qizVs5estbKS6UsKcvR988N1AhWTPO+2hel53PePlKf048
 M2ZSZH8q1z8a5hzlHEUP2PuHukQ6oIq0YuqXGqQq1XLKwolr7L3IISS5qXfsggyPtUHb+Io3rcF
 gEnJ2hhv9Y+0VwBoEVZFCsU130Xj/YLccX23Sm8QnoCLsHtq0n9JJff0lGefOR44yxqTZRJASZc
 utz3blOylWkrdmfC/z5t1CJ0yK8Leki5ynhMTFqTDMtvkC1Ye730AwQgnECMA5IQqq/hC4BmU4T
 fjCd/y+uxzjy0bji1a6Hgy2d9qgAszAeRKijVbBNf/o7CZ4+gXa2T7az78NXGRpZyo8=
X-Received: by 2002:a05:690c:3489:b0:8b3:361f:5d93 with SMTP id
 00721157ae682-8b4aa232adcmr20808837b3.14.1794601600621; 
 Fri, 13 Nov 2026 12:26:40 -0800 (PST)
Received: from localhost.localdomain
 ([2804:1254:81a4:f900:fd83:f7ad:7c00:7806])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa98b9a8sm29156547b3.26.2026.11.13.12.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 12:26:40 -0800 (PST)
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Gabriel Gama <operatingsystemsdepression@gmail.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Joseph Telaak <joseph@telaak.dev>
Subject: [PATCH 8/10] drm/gma500: validate MMU ranges before changing page
 tables
Date: Fri, 13 Nov 2026 17:26:35 -0300
Message-ID: <20261113202635.15636-1-operatingsystemsdepression@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAFGNeaiEVnm_b8OBEELseBg9JDgm_PuDzZG2pQu8KxFPnzANyQ@mail.gmail.com>
References: <CAFGNeaiEVnm_b8OBEELseBg9JDgm_PuDzZG2pQu8KxFPnzANyQ@mail.gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Validate alignment, 32-bit GPU extents, representable PFNs and tiled
geometry before changing PTEs. Use u64 exclusive endpoints so the final
GPU page does not wrap on i386. Reject overlapping tiled rows and invalid
strides before division or allocation.

Signed-off-by: Gabriel Gama <operatingsystemsdepression@gmail.com>
---
diff --git a/drivers/gpu/drm/gma500/mmu.c b/drivers/gpu/drm/gma500/mmu.c
index 76c05f5a260c9ca305e7ef9a12ffdc1f61c56482..b5854ed29c28cc33205e02018dc2e1ec505b0137 100644
--- a/drivers/gpu/drm/gma500/mmu.c
+++ b/drivers/gpu/drm/gma500/mmu.c
@@ -136,10 +136,9 @@
 
 }
 
-static inline unsigned long psb_pd_addr_end(unsigned long addr,
-					    unsigned long end)
-{
-	addr = (addr + PSB_PDE_MASK + 1) & ~PSB_PDE_MASK;
+static inline u64 psb_pd_addr_end(u64 addr, u64 end)
+{
+	addr = (addr + PSB_PDE_MASK + 1) & ~(u64)PSB_PDE_MASK;
 	return (addr < end) ? addr : end;
 }
 
@@ -484,13 +483,13 @@
 	struct psb_mmu_pt *pt;
 	uint32_t rows = 1;
 	uint32_t i;
-	unsigned long addr;
-	unsigned long end;
-	unsigned long next;
-	unsigned long add;
-	unsigned long row_add;
+	u64 addr;
+	u64 end;
+	u64 next;
+	u64 add;
+	u64 row_add;
 	unsigned long clflush_add = pd->driver->clflush_add;
-	unsigned long clflush_mask = pd->driver->clflush_mask;
+	u64 clflush_mask = ~((u64)clflush_add - 1);
 
 	if (!pd->driver->has_clflush)
 		return;
@@ -500,8 +499,8 @@
 	else
 		desired_tile_stride = num_pages;
 
-	add = desired_tile_stride << PAGE_SHIFT;
-	row_add = hw_tile_stride << PAGE_SHIFT;
+	add = (u64)desired_tile_stride << PAGE_SHIFT;
+	row_add = (u64)hw_tile_stride << PAGE_SHIFT;
 	mb();
 	for (i = 0; i < rows; ++i) {
 
@@ -525,22 +524,53 @@
 	mb();
 }
 
+/* Validate the complete mapping before touching page tables. */
+static int psb_mmu_check_range(unsigned long address, u32 num_pages,
+			       u32 desired_tile_stride, u32 hw_tile_stride)
+{
+	u64 span;
+	u32 rows;
+
+	if (!IS_ALIGNED(address, PAGE_SIZE))
+		return -EINVAL;
+	if (((u64)address >> 32) || num_pages > BIT(20))
+		return -ERANGE;
+	if (!num_pages)
+		return 0;
+
+	if (hw_tile_stride) {
+		if (!desired_tile_stride ||
+		    num_pages % desired_tile_stride ||
+		    hw_tile_stride < desired_tile_stride)
+			return -EINVAL;
+		rows = num_pages / desired_tile_stride;
+		span = (u64)(rows - 1) * hw_tile_stride + desired_tile_stride;
+	} else {
+		span = num_pages;
+	}
+
+	if (span > (BIT_ULL(32) - address) >> PAGE_SHIFT)
+		return -ERANGE;
+
+	return 0;
+}
+
 void psb_mmu_remove_pfn_sequence(struct psb_mmu_pd *pd,
 				 unsigned long address, uint32_t num_pages)
 {
 	struct psb_mmu_pt *pt;
-	unsigned long addr;
-	unsigned long end;
-	unsigned long next;
+	u64 addr;
+	u64 end;
+	u64 next;
 	unsigned long f_address = address;
 
-	if (!num_pages)
+	if (!num_pages || psb_mmu_check_range(address, num_pages, 0, 0))
 		return;
 
 	down_read(&pd->driver->sem);
 
 	addr = address;
-	end = addr + (num_pages << PAGE_SHIFT);
+	end = addr + ((u64)num_pages << PAGE_SHIFT);
 
 	do {
 		next = psb_pd_addr_end(addr, end);
@@ -575,14 +605,15 @@
 	struct psb_mmu_pt *pt;
 	uint32_t rows = 1;
 	uint32_t i;
-	unsigned long addr;
-	unsigned long end;
-	unsigned long next;
-	unsigned long add;
-	unsigned long row_add;
+	u64 addr;
+	u64 end;
+	u64 next;
+	u64 add;
+	u64 row_add;
 	unsigned long f_address = address;
 
-	if (!num_pages)
+	if (!num_pages || psb_mmu_check_range(address, num_pages,
+					      desired_tile_stride, hw_tile_stride))
 		return;
 
 	if (hw_tile_stride)
@@ -590,8 +621,8 @@
 	else
 		desired_tile_stride = num_pages;
 
-	add = desired_tile_stride << PAGE_SHIFT;
-	row_add = hw_tile_stride << PAGE_SHIFT;
+	add = (u64)desired_tile_stride << PAGE_SHIFT;
+	row_add = (u64)hw_tile_stride << PAGE_SHIFT;
 
 	down_read(&pd->driver->sem);
 
@@ -635,19 +666,22 @@
 {
 	struct psb_mmu_pt *pt;
 	uint32_t pte;
-	unsigned long addr;
-	unsigned long end;
-	unsigned long next;
+	u64 addr;
+	u64 end;
+	u64 next;
 	unsigned long f_address = address;
-	int ret = -ENOMEM;
-
-	if (!num_pages)
-		return 0;
+	int ret;
+
+	ret = psb_mmu_check_range(address, num_pages, 0, 0);
+	if (ret || !num_pages)
+		return ret;
+	if ((u64)start_pfn + num_pages > BIT_ULL(20))
+		return -ERANGE;
 
 	down_read(&pd->driver->sem);
 
 	addr = address;
-	end = addr + (num_pages << PAGE_SHIFT);
+	end = addr + ((u64)num_pages << PAGE_SHIFT);
 
 	do {
 		next = psb_pd_addr_end(addr, end);
@@ -687,27 +721,32 @@
 	uint32_t rows = 1;
 	uint32_t i;
 	uint32_t pte;
-	unsigned long addr;
-	unsigned long end;
-	unsigned long next;
-	unsigned long add;
-	unsigned long row_add;
+	u64 addr;
+	u64 end;
+	u64 next;
+	u64 add;
+	u64 row_add;
 	unsigned long f_address = address;
-	int ret = -ENOMEM;
-
-	if (!num_pages)
-		return 0;
-
-	if (hw_tile_stride) {
-		if (num_pages % desired_tile_stride != 0)
-			return -EINVAL;
+	int ret;
+
+	ret = psb_mmu_check_range(address, num_pages,
+				  desired_tile_stride, hw_tile_stride);
+	if (ret || !num_pages)
+		return ret;
+	if (!pages)
+		return -EINVAL;
+	for (i = 0; i < num_pages; i++) {
+		if (!pages[i] || page_to_pfn(pages[i]) >= BIT_ULL(20))
+			return -ERANGE;
+	}
+
+	if (hw_tile_stride)
 		rows = num_pages / desired_tile_stride;
-	} else {
+	else
 		desired_tile_stride = num_pages;
-	}
-
-	add = desired_tile_stride << PAGE_SHIFT;
-	row_add = hw_tile_stride << PAGE_SHIFT;
+
+	add = (u64)desired_tile_stride << PAGE_SHIFT;
+	row_add = (u64)hw_tile_stride << PAGE_SHIFT;
 
 	down_read(&pd->driver->sem);
 
@@ -719,8 +758,10 @@
 		do {
 			next = psb_pd_addr_end(addr, end);
 			pt = psb_mmu_pt_alloc_map_lock(pd, addr);
-			if (!pt)
+			if (!pt) {
+				ret = -ENOMEM;
 				goto out;
+			}
 			do {
 				pte = psb_mmu_mask_pte(page_to_pfn(*pages++),
 						       type);
