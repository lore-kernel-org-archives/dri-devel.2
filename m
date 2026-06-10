Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E34CD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:44:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E27210E778;
	Wed, 10 Jun 2026 07:44:02 +0000 (UTC)
X-Greylist: delayed 515 seconds by postgrey-1.36 at gabe;
 Wed, 10 Jun 2026 07:44:01 UTC
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53AB510E778
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 07:44:01 +0000 (UTC)
Received: from localhost.localdomain (unknown
 [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by psionic.psi5.com (Postfix) with ESMTPSA id 2B91B3F1A3;
 Wed, 10 Jun 2026 09:35:23 +0200 (CEST)
From: Simon Richter <Simon.Richter@hogyros.de>
To: dri-devel@lists.freedesktop.org
Cc: Simon Richter <Simon.Richter@hogyros.de>
Subject: [PATCH] drm/amdgpu: remove unused label
Date: Wed, 10 Jun 2026 16:34:52 +0900
Message-ID: <20260610073509.474959-1-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The merge commit 6795a14b9d0b0 (drm-next -> drm-tip) leaves the label from
commit 342981fff3280 ("drop retry loop in amdgpu_hmm_range_get_pages") in,
causing a build failure with CONFIG_WERROR.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index a876210c94c5..99bc9ad67d5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -200,7 +200,6 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 		pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
 			hmm_range->start, hmm_range->end);
 
-retry:
 		r = hmm_range_fault(hmm_range);
 		if (unlikely(r))
 			goto out_free_pfns;
-- 
2.47.3

