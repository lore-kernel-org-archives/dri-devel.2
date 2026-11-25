Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E515606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 20:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=E0t/jPCt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D70310E252;
	Wed, 25 Nov 2026 20:28:42 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 509CB10E252
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 20:28:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795638511; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bVjUtopT3JmDHTvh9Azp17CvVtPb5q4EQix/Rasg38yoXcuyv9rdM54fYEHXY3PYSKk7sOHFAW5gVqcVvn9NtxxbrLgWfbIDMTOK4Em1pRUM7HGRmASU6BRSmXYn37jgAHiweoknbCQvWASlFZsRBJcbomvNE6kt2Qz/eEgbwso=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795638511;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=JOYAa7fLf3e5taKaH7vZHli1+lb0DGOTCK/mKOpNivA=; 
 b=OSzJDmTZCeop6vjVmMmsaRIQquaAuX2pzXfNkHR1a/x+OW5bejuc8uhYPc2fOS4f5d9UdBhilU3skOl/j5TbGztmksIvQia7Kcf8vc5VzI9p40sApkzWhDeWCCUdjIbboXZJoUWrao7QAGRpKuRkiSq6NZeSCdl3Y2790L3224o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=E0t/jPCtXGtbb6JaguDNhXG1M4TpVUu9A8qf+uw6GCu6dZl9p34wDOVn1IM6B2q078APwQ/1/XEZ5i1KoWOhylrI1V5c3DdNHBmC1A4Un59GTkgJSvynnXd+mOZG8se8VZ/vZ9U+wh7aLnRVaOK9QeRejLbrL7Arjv8pVji8OvM=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=JOYAa7fLf3e5taKaH7vZHli1+lb0DGOTCK/mKOpNivA=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795638509259683.9981897561948;
 Wed, 25 Nov 2026 12:28:29 -0800 (PST)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Wed, 25 Nov 2026 13:28:20 -0700
Subject: [PATCH] drm/tyr: clamp va_bits to available bits
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-b4-va_bits_clamp-v1-1-07e2bb33eb50@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyNT3SQT3bLE+KTMkuL45JzE3AJdk8Q000RLo2TDVDMLJaC2gqLUtMw
 KsJHRsbW1AAZORVliAAAA
X-Change-ID: 20261125-b4-va_bits_clamp-4af5a92c1e68
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, sunke@kylinos.cn, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2484;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=xNf252I664eRJisbxhiMQd/tqwpzVUUADtcDYFaeWQ4=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDNnsLm++z2sQDzij+oWvtEG2t/fxQ70ky9c6VmpcTx9Ob
 U1YyRTVUcrCIMbFICumyHLW3qhHvOq9ke78/80wc1iZQIYwcHEKwERe/WJkeO3eO2E745TdDj3L
 NtX9XvnbrPaad8DqzI1nNwu+ut70XZqR4TzLPcv1ERHP7xmbXz2RsfhS9p4AJbOPWmrff72KYjR
 cwgQA
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Tyr creates a virtual memory space using the number of bits supported in
virtual addresses as reported by the gpu. But the page table mapping
operations limit the width of the input virtual addresses to unsigned
long. This can result in tyr creating a virtual memory space that is
larger than a 32-bit system can support.

Check if the virtual address space bits supported by the gpu are larger
than the width of unsigned long, and if so, clamp the virtual address
space bits to this smaller size.

This reproduces the clamping that already occurs in panthor_mmu_init().

Link: https://sashiko.dev/#/patchset/20261122-tyr-ioctls-v7-0-3a2af624b992%40linux.dev
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/gpu.rs | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tyr/gpu.rs b/drivers/gpu/drm/tyr/gpu.rs
index 820de9d60c19..058863a6b70b 100644
--- a/drivers/gpu/drm/tyr/gpu.rs
+++ b/drivers/gpu/drm/tyr/gpu.rs
@@ -36,6 +36,15 @@
 
 impl GpuInfo {
     pub(crate) fn new(io: &IoMem<'_>) -> Self {
+        let mut mmu_features = io.read(MMU_FEATURES);
+
+        // In io_pgtable_ops, input virtual addresses can't exceed unsigned long.
+        // Check that the virtual address bits reported by the gpu are
+        // architecturally supported and, if not, clamp them to the available bits.
+        if mmu_features.va_bits().get() > usize::BITS {
+            mmu_features = mmu_features.with_const_va_bits::<{ usize::BITS }>();
+        }
+
         Self(uapi::drm_panthor_gpu_info {
             gpu_id: io.read(GPU_ID).into_raw(),
             gpu_rev: io.read(REVIDR).into_raw(),
@@ -43,7 +52,7 @@ pub(crate) fn new(io: &IoMem<'_>) -> Self {
             l2_features: io.read(L2_FEATURES).into_raw(),
             tiler_features: io.read(TILER_FEATURES).into_raw(),
             mem_features: io.read(MEM_FEATURES).into_raw(),
-            mmu_features: io.read(MMU_FEATURES).into_raw(),
+            mmu_features: mmu_features.into_raw(),
             thread_features: io.read(THREAD_FEATURES).into_raw(),
             max_threads: io.read(THREAD_MAX_THREADS).into_raw(),
             thread_max_workgroup_size: io.read(THREAD_MAX_WORKGROUP_SIZE).into_raw(),

---
base-commit: 7402dd230f4497954b465145a22cff7a5a488629
change-id: 20261125-b4-va_bits_clamp-4af5a92c1e68

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

