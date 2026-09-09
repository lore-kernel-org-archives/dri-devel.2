Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB69DC88E45
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21DBF10F40A;
	Thu, 10 Sep 2026 10:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="sXawcu+9";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="b9Q4YJ6B";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74D7410F1A3
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:53:12 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hg2MB5r8GzMlJr;
 Wed, 09 Sep 2026 15:53:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788961990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iuJQiHvs9iP3PQ03RHys/Ar1s5GNOF4lhn09HnTAQd0=;
 b=sXawcu+9waCVaP7TSgWjwW3DjhbtBP7mpZzo0sV2ex6EmOrgco4n9ZyPmQ9lHmz4hX1Grk
 fcunJ7aP3ef+NsMDl+r/HSVnSsSaRVcyq5u2EOLTzLEO4aGXk2w2oG16BWK146WEjzSTVQ
 H4swSmhlqwQrNURfcNnQbOo6alrCw2uJLQFBj5Kq34gnmICk3cHZVnNwNU+RTvK/RUwI2P
 m/Fxl3IVB8hJDkgeqqlyvlr/mVKokszggNpFnxQOAQkgJVN644h/k2q5rNURgVtGGshDG3
 G85ESssSnzmvsiI/F7dlUvusoh4W+JkjJnX3hw4OltTfoc6VMd7/k2EOFuACtA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=b9Q4YJ6B;
 spf=pass (outgoing_mbo_mout: domain of manuelebnerli@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=manuelebnerli@mailbox.org
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788961989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iuJQiHvs9iP3PQ03RHys/Ar1s5GNOF4lhn09HnTAQd0=;
 b=b9Q4YJ6BDbbrtZBPJ74ddbSs3qEZOz2jk2O5p0FXFpij3T2tUFq0LazqWNMVLDNy1/VZAY
 Vn1FhIP3Xr2jMv3k6qMv5csuADVvseL+sdb+IkKOlh/23uLnp9yWHQ8D6UPpMrrvVE7FRJ
 LM+EZKXMACwfwG5mNWqCb+bpEOTiYfttW8zShtcwOAs2V/lztonrOpS4nxFQVriYwT/6hX
 fKa3qHnYap88y4KwoUOaLdgMkgXcq1pSL0su1zDbIzTppy0uoUIJ0xjqxqdPiPXbpb+Ybg
 PhJbXrdanVjN2DHpLtEyZ6V9y7mhsTHu5w3RosPbi5T6Srro1f7bqwcQ02NyNw==
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH] Documentation/gpu: Fix bracket
Date: Wed,  9 Sep 2026 15:52:33 +0200
Message-ID: <20260909135233.1364650-2-manuelebnerli@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: mhwupi7m53zinn4efqm6apnsbpajmcsm
X-MBO-RS-ID: 454f5675d07381df421
X-Rspamd-Queue-Id: 4hg2MB5r8GzMlJr
X-Mailman-Approved-At: Thu, 10 Sep 2026 10:06:32 +0000
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

Remove needless '('.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/gpu/drm-vm-bind-locking.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-vm-bind-locking.rst b/Documentation/gpu/drm-vm-bind-locking.rst
index a345aa513..df6cf0132 100644
--- a/Documentation/gpu/drm-vm-bind-locking.rst
+++ b/Documentation/gpu/drm-vm-bind-locking.rst
@@ -170,7 +170,7 @@ submission is therefore preceded with a re-validation section:
            validate_gem_bo(&gpu_vm_bo->gem_bo);
 
            // The following list iteration needs the Gem object's
-           // dma_resv to be held (it protects the gpu_vm_bo's list of
+           // dma_resv to be held. It protects the gpu_vm_bo's list of
            // gpu_vmas, but since local gem objects share the gpu_vm's
            // dma_resv, it is already held at this point.
            for_each_gpu_vma_of_gpu_vm_bo(&gpu_vm_bo, &gpu_vma)
-- 
2.54.0

