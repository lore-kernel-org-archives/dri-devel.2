Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C32606A325
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=ZMbgvPeD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DB9D10E86D;
	Mon,  9 Nov 2026 10:57:22 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80F1910E86D
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 10:57:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1794221830; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=I8w82vpRerYe/fqatMiuXnz7i72924YIYuCjPhjFvwr1SXxv8PrtjQsMJfTpRb6foJUE91t7I7l4PckutbQs89OFh/Bigp/53ehch2Id1x1nLT/cvbwCqM92Z8+Gxyv7IGfNXv2gbRCG1bPfDMAYpVtlS/+qwdk8P0b8RLF/ky0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1794221830;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=f8D+c+xXz77yaRBvZTCvLZtC1I7mMyw60XZTeuJrOlE=; 
 b=KXSe6rWfjZMDMftcnFdvZx/wjNsCJ+AVy1gEd2bfZ3aF/5QvGY4uir7cniJ8WCSbf25U5HchOqXiLJyUPr5PT1BhpVHeS3f4xeYTFfcvmL4HGq1KMp3VbRrer8bU0FU6kJiJCgOicPQ6QOklBGtgGBM6DSXNC/tGD/WRo9XaJQA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=igor.torrente@collabora.com;
 dmarc=pass header.from=<igor.torrente@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=ZMbgvPeD82uGsLTZ6tuqgdpUaYVXbhY+LcprJOgBMBHFs3vjkJiTHrPKrzx13IC6ifuyDQw0wM2QEcJj/ZWo9ufSP6thw0Pnye0Xdi+fjC7UPu1YuoOL+jZgNVW2AmhPKq1WZYgYDT4jbQso/HhXgQPuTajWU2wCHIFoeOKa5Wk=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=f8D+c+xXz77yaRBvZTCvLZtC1I7mMyw60XZTeuJrOlE=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794221828347562.1677845416142;
 Mon, 9 Nov 2026 02:57:08 -0800 (PST)
From: Igor Torrente <igor.torrente@collabora.com>
To: boris.brezillon@collabora.com, steven.price@arm.com, liviu.dudau@arm.com
Cc: Igor Torrente <igor.torrente@collabora.com>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/panthor: Allow exporting BOs with an exclusive VM
Date: Mon,  9 Nov 2026 07:56:51 -0300
Message-ID: <20261109105652.7114-1-igor.torrente@collabora.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

Panthor currently does not allow exporting BOs with an exclusive VM.
However, VDRM (native context) drivers export BOs for import by the guest
VM, which does not attempt to bind them to any GPU VM.

Allow these BOs to be exported and rely on
panthor_vm_prepare_map_op_ctx() to reject attempts to bind them to a
different GPU VM.

Signed-off-by: Igor Torrente <igor.torrente@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_gem.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 22b57ab6f929..7d028c773bee 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -573,10 +573,6 @@ panthor_gem_prime_export(struct drm_gem_object *obj, int flags)
 		.resv = obj->resv,
 	};
 
-	/* We can't export GEMs that have an exclusive VM. */
-	if (to_panthor_bo(obj)->exclusive_vm_root_gem)
-		return ERR_PTR(-EINVAL);
-
 	return drm_gem_dmabuf_export(dev, &exp_info);
 }
 
-- 
2.55.0

