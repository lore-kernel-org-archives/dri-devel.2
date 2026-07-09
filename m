Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CB6C44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:00:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE7BE10F37C;
	Thu,  9 Jul 2026 06:00:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="fJee2e0b";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EACA10F37C;
 Thu,  9 Jul 2026 06:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=shOH7v7tPxVk69OD7clf+CDo5fSlmEBJdPyqsNSj7YU=; b=fJee2e0bEpFV+MeSw3m1kMIhF7
 2p/EvrdeQqYW8h0YJGPzPDjxBXfYEaa/4HWpy7NXiCEjkRwHqaRsKX7miJDcQnoHC1d6wTl7fU/q0
 4g5pWmHi8iILwVgJ3yaHVczqpWOIm4PCXPvIRkF2jYVBNyjq14SLdewJt9ajJc6NI+i94pbW5LlzF
 eP/C13Qyhoc7FRHxhw0eUHZDwdfTcLir0dpCex5mh13uujLQvKeXB5rcSa+gcWU2yylR5crwPCd3V
 jUh9amyxDcVaNEs7yg1eA1GmyRP/jF5ns43+tASm3WJ06arcX9lV3qmskUJDVKpln0sFP7vpFw7wu
 zmWYVPIA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1whhns-000000016X9-3jZc; Thu, 09 Jul 2026 06:00:08 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: dri-devel@lists.freedesktop.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: drop kernel-doc for deleted struct fields
Date: Wed,  8 Jul 2026 23:00:07 -0700
Message-ID: <20260709060008.529870-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

3 fields in struct amd_ip_funcs have been deleted, so also delete the
kernel-doc comments for them to avoid warnings:

WARNING: ../drivers/gpu/drm/amd/include/amd_shared.h:481 Excess struct member 'check_soft_reset' description in 'amd_ip_funcs'
WARNING: ../drivers/gpu/drm/amd/include/amd_shared.h:481 Excess struct member 'pre_soft_reset' description in 'amd_ip_funcs'
WARNING: ../drivers/gpu/drm/amd/include/amd_shared.h:481 Excess struct member 'post_soft_reset' description in 'amd_ip_funcs'

Fixes: 947e46eb2fb9 ("drm/amdgpu: Delete check_soft_reset() from amd_ip_funcs")
Fixes: b7500532e12b ("drm/amdgpu: Delete pre/post_soft_reset() from amd_ip_funcs")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org

 drivers/gpu/drm/amd/include/amd_shared.h |    3 ---
 1 file changed, 3 deletions(-)

--- linext-2026-0708.orig/drivers/gpu/drm/amd/include/amd_shared.h
+++ linext-2026-0708/drivers/gpu/drm/amd/include/amd_shared.h
@@ -439,10 +439,7 @@ enum amd_dpm_forced_level;
  * @complete: handles IP specific changes after resume
  * @is_idle: returns current IP block idle status
  * @wait_for_idle: poll for idle
- * @check_soft_reset: check soft reset the IP block
- * @pre_soft_reset: pre soft reset the IP block
  * @soft_reset: soft reset the IP block
- * @post_soft_reset: post soft reset the IP block
  * @set_clockgating_state: enable/disable cg for the IP block
  * @set_powergating_state: enable/disable pg for the IP block
  * @get_clockgating_state: get current clockgating status
