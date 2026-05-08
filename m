Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D716CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 13:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9698210E32F;
	Fri,  8 May 2026 13:58:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="f1aAhyx7";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFE4210E32F
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 13:58:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1778248710; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WN01I0arlGspujodryolaOf9eEx/8s5vv0H6oxmDrclrqzrm3c7uCBZ3vvyKN0wGAJBKBzDuuhIcq7BiLXsgHDudrP42vhJZH6/3q631RijJ00fcS7X0xYIoi6qjUrZ5PLsHN3/bXNu9LYYmJYN9d7osdyzzZZ5i+kknV4Eyers=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778248710;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=2XxAyhD+cPP5bbx4QSdWivMJIWCt/E759TvxLI/dglc=; 
 b=OZbqhbv8gXL3CxcVHJhJ/uyhNtJYrjctJyATD3UH8EVwZJUtBXw6FMJm9FfPtnWdPJmw1upI8uXJZzfO3qOeNxbUVrxoxI1YllBTF+Zl3UKIjSfBj+CySfpW6Ye5x5Qz8g9LJR6D2P7oXABST3lXXWKV0WTswWTIerpYb3zAdvs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778248710; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=2XxAyhD+cPP5bbx4QSdWivMJIWCt/E759TvxLI/dglc=;
 b=f1aAhyx79F6PgTxHXOhpRqCkJuOBk0QdHBOQLxlFVPnaIS5Q6+KlAuRgZ/SAqAdN
 l9/RUCQNbMqqLzBOhyO/spKVK5PVBRIz0O/zSCVpOSoFfzzTGm2w6q2g+zQuoUYgc2V
 UxLVhe234/5zHGe0Ea0gE0vgeuvziQUkHSig2m/E=
Received: by mx.zohomail.com with SMTPS id 1778248709941414.46861839131236;
 Fri, 8 May 2026 06:58:29 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/gpuvm: Fix comment to reflect remap operation operand
 status
Date: Fri,  8 May 2026 14:58:08 +0100
Message-ID: <20260508135814.3296874-2-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508135814.3296874-1-adrian.larumbe@collabora.com>
References: <20260508135814.3296874-1-adrian.larumbe@collabora.com>
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
index 625958fce7fd..4836ef9cc25f 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -929,6 +929,8 @@ struct drm_gpuva_op_unmap {
  * If either a new mapping's start address is aligned with the start address
  * of the old mapping or the new mapping's end address is aligned with the
  * end address of the old mapping, either @prev or @next is NULL.
+ * This will also be the case when the requested mapping begins before the
+ * old mapping's start address or stretches beyond its end address.
  *
  * Note, the reason for a dedicated remap operation, rather than arbitrary
  * unmap and map operations, is to give drivers the chance of extracting driver
-- 
2.53.0

