Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8283D105F7B3
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 15:11:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F05B910E02E;
	Fri, 13 Mar 2026 15:11:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Bk3IWUMz";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E728810E02E
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 15:11:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773414658; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=S+4slY15TeJiumMclXVJVYXm+YQ5FxkzEJTqC/AYYxoXGxegJZA/YGiQDKj8iR5qtonryY5Pt9ime6mDIbbPf+EYaJsTVTPtTZunvJjHSg+tRwFEDhBHT1wlmFXPaCfeCUH5JDxhFMLK+GmoMdbkoWboHrj2i5pd2ePKnC2ll4Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773414658;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ZKtUQFvAxLD2hZTa5LPl00p/Z3EKh1SexwtdHAhYr+c=; 
 b=loGAJEZGn5iABzLNieOvtZd9bBo6PD1trpJ95urjBjQx2WTCbTXOhZ4+dYcZY5CZ1Gs69NRQIt81GKg+P/9AmaQnSiCq3l+0t8bQ5Yjd3Uyzg5/XjjpfpohxjHX1YZLIb56VxRsyTWrz3lSPrL2NkCNbmCHNzaRx6qKRa/R6RdE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773414658; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=ZKtUQFvAxLD2hZTa5LPl00p/Z3EKh1SexwtdHAhYr+c=;
 b=Bk3IWUMzULsgmGyTMKAkb/cxyPtuJbon3nU3TSkxwips5wzTUeGiEWCQxyrQsjyP
 rx68ht/oeFyeaYdYUg7QSpauoUGxinvkieBHqUYlsjSSgOQTcXI2aSP8ltbb1yrjfhe
 P1JYYdz7M+HvrJB0Dll6cgoDwtvA6Mvz9jckOqRU=
Received: by mx.zohomail.com with SMTPS id 1773414656949399.2089361119673;
 Fri, 13 Mar 2026 08:10:56 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Janne Grunau <j@jannau.net>, kernel@collabora.com,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v5 03/11] drm/gpuvm: Fix comment to reflect remap operation
 operand status
Date: Fri, 13 Mar 2026 15:09:40 +0000
Message-ID: <20260313150956.1618635-4-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313150956.1618635-1-adrian.larumbe@collabora.com>
References: <20260313150956.1618635-1-adrian.larumbe@collabora.com>
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

When a new mapping intersects with an existing GPU VA, but either
end lies before or beyond the existing VA's edges, then the prev
and next mapping operations part of a remap will reflect this
condition by being set to NULL.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 include/drm/drm_gpuvm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index 625958fce7fd..6a6e64cd2cce 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -929,6 +929,8 @@ struct drm_gpuva_op_unmap {
  * If either a new mapping's start address is aligned with the start address
  * of the old mapping or the new mapping's end address is aligned with the
  * end address of the old mapping, either @prev or @next is NULL.
+ * This might also be the case when the requested mapping extends over the
+ * lower and upper boundaries of the intersecting GPU VA.
  *
  * Note, the reason for a dedicated remap operation, rather than arbitrary
  * unmap and map operations, is to give drivers the chance of extracting driver
-- 
2.53.0

