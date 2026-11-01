Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916D4606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LiODybk0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D04B10EBB6;
	Mon,  2 Nov 2026 08:03:59 +0000 (UTC)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 885D610EA84
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 15:30:36 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso1117860eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 07:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793547036; x=1794151836; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SVBYUGKBfy5VgyJYxRQsxXI/PNaZpWYW53mlcMJpkq8=;
 b=LiODybk0TSQuV8fuOT56QSLDF/lp+qr/AI/QTo8l009FbUbBFvc/2EBIDMOKCdFXlY
 rDobhQrgD1Z2CXSohjEqQ6QIB319/Dp6kPNs6LaSqUATZkTZUKjX56ScQsOp34VvslN/
 tMn34yh9k4NtqC53isVCaUTIye6Bntnvbr/8gRT3QnriTX4VX4Rwlvxh6u4uI3lNbp+U
 TWPUKiAYo7UkJDtTsouBrrQMvvq0M9dushAsDRm4t1FH8BCJO9BygQbC2cuRvHwFBIOs
 NFydm6nrbsy8oW6vaXmI1Z6KpNNZmnysBsUW9DGW/MkWnxizZUCHnOrk0iPHdcsXxWfB
 rDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793547036; x=1794151836;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SVBYUGKBfy5VgyJYxRQsxXI/PNaZpWYW53mlcMJpkq8=;
 b=0eGDbHgBp8seoqXm2ny6BLA1BCval9xrfoyC+L53vtAVmlH26J73/GWw7A0VBcuMTk
 LzOFmF3Mvj+bjGGJpbcvugNKpygoymn5eCye7smlfI6cR34KRROWURuYVRR3vDFFrdf+
 sNPvTZ26bosNSFIVjKNmu8ZdQKK87YgKwoB/MleCIRJrzH0cpzYQMe97B2XmtJXeXAUZ
 3HoFESIsvWyEbLPle1heLQOiHApzWj7XCjluDcGnx7DV69lQjI5GtEuo6bHwHB/TNs/w
 hMTHaJiVSysH0/JuOzI41PUMhi/LZwu62tnndl21jRhOObyzA8C1aksG+VzFq4c8Xsl5
 IzDg==
X-Gm-Message-State: APuU4Z+n5AIlhlS3Ql/YSq0cBPduPGJBsMfA/adA39dwP3GOCkIp7cZ2
 lBSElt246iAQ2N2cwM9yMxWlY8pzf14lrn4mHsn4cgmt3qB+vmWOLLrTX/iuMpaL
X-Gm-Gg: AYBFou2y9zukvXroKbuUCwp0QFPZntu86ODpnzy+PKdxhc9i7DXu+SxefeEk2XO+2pD
 8RVfFyRdzBuhZl4M0SkHVfNKzOpAU5jr+rpaoPNSmyXxNKjcxFhGSbu5WwMEo+0h+BkCPItaCr7
 uNFdYRnO703d2/aQr6zjRjbXkMER1Z4zdOra8iC6rsT2gg/jq77wxthZaetdqbaFP4hKHCrGwyN
 9sD8V7BxcRK29iyCSaPO0DCIlNXg2thyYwPNsBCEzPvTQGviH4/3zuyi8abja07P6c7dZDs6AE7
 vMn8W0cw2qunAu3rhxKTG4Jdta3Nq2wIJoOUm0t9DYAn0Sc6QnB56Z61EKulShOvZUMLEHqn5rr
 /rZOcIii3HFqnvUZDVki6Gn1k1Dftq8lqtgCwlvho8lpm5xOh6eeQ6PCDWtZuwvFoV43vV3OV4y
 RKjVhYISH8AbK9dD00FJoF5OeCoGj9j0vDuWU7VCLWAvPyV5fpb4/TFB4gqzV6MDPsG7a+2UzV9
 Njs/g7RjFAOuN9L61M+lmEYfOuo+OFi6/IhwcAoUVZ1F970DPkUqV9NHmfIRK2cxoht8xGUgPSg
 s/fWytBX7YYrB/rIVaDhTcxoY7Gv5yM=
X-Received: by 2002:a05:693c:2514:b0:368:fdf9:6e64 with SMTP id
 5a478bee46e88-36a423b4363mr11283926eec.23.1793547035458; 
 Sun, 01 Nov 2026 07:30:35 -0800 (PST)
Received: from fedora ([2401:4900:8fef:d435:87b8:cb2f:c85c:2d3d])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42669128sm30374017eec.3.2026.11.01.07.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 07:30:34 -0800 (PST)
From: Ravin Chokshi <ravin.chokshi@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, acourbot@nvidia.com, lyude@redhat.com,
 linux-kernel@vger.kernel.org, Ravin Chokshi <ravin.chokshi@gmail.com>
Subject: [PATCH] drm/shmem_helper: Fix kernel-doc name of
 __drm_gem_shmem_free_sgt_locked
Date: Sun,  1 Nov 2026 21:00:00 +0530
Message-ID: <20261101153000.20839-1-ravin.chokshi@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:03:58 +0000
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

The kernel-doc comment names __drm_gem_shmem_release_sgt_locked(),
but the function it describes is __drm_gem_shmem_free_sgt_locked().
Update the comment to use the real name, which also fixes the
kernel-doc warning about the prototype not matching.

Fixes: b78dab829760 ("drm/gem/shmem: Introduce __drm_gem_shmem_free_sgt_locked()")
Signed-off-by: Ravin Chokshi <ravin.chokshi@gmail.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index d654a22a30de..6ec273f0849e 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -159,7 +159,7 @@ struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t
 EXPORT_SYMBOL_GPL(drm_gem_shmem_create);
 
 /**
- * __drm_gem_shmem_release_sgt_locked - Unpin and DMA unmap pages, and release the
+ * __drm_gem_shmem_free_sgt_locked - Unpin and DMA unmap pages, and release the
  * cached scatter/gather table for an shmem GEM object.
  * @shmem: shmem GEM object
  *
-- 
2.55.0

