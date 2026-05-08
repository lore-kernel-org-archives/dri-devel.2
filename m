Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CAFCD3427
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 10:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE73310E624;
	Sun, 10 May 2026 10:07:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ogKWmlef";
	dkim-atps=neutral
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDA6D10F58B
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 18:05:22 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-8d560ede296so256685885a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 11:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778263522; x=1778868322; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9oUEHji2HuAH1Squ/e2hO3APLsVoXtI85k3zSv3ekYQ=;
 b=ogKWmlef4oC+fAL/XVYkuNPiOjJPPC96efzmyOupvdUGgnbXH4GbgtBvX9GlgLU/ku
 +SQLcS4Qw7x8+HbELlKRzGOkg3ZbiO9+H9HF1siiBjdCeumB+TsxlNOBh7b4mWlBtPNb
 O5quw+p+6nLbot/jCGIehTopEN8/wuRhmtiqkpozw+PBd8oYfEIxoJtd3yZDuITJ5Pvn
 VqTuomu5F0FNHMjB2TIYuEfUuTKLpAIhuunQ+GVoY7W5mZ37Bt68Yi+8nlh1yxndkM8o
 I1WAwoy0vzI/96kEhRCmLRY5NyxorUclL2XVT1y31mTB9Q/b1rYdwOMouNjPrGqTsMdK
 9nkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778263522; x=1778868322;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9oUEHji2HuAH1Squ/e2hO3APLsVoXtI85k3zSv3ekYQ=;
 b=KCzPGJfny/Za37R4H4zdrh5jpKr6ehQ64G2FCjHuCPSFmOR+SfBSSsYCEHXbGFhxMW
 O3UGDJ/Xb2/UeqysQxwdiV8uIiQvAS54DVaUOhLYnTYe9EgICulY0L664YrPVgjfKXmq
 Z4KkqeaDT73nKhDJOkptUEvHrbl8N383EIBf/CnF3rcUpAaB8GE1rPiURd/H9h165HJf
 /nyGQ0Ri9YZB5SuvJ12L9qJSmd+bFie5s+N2cbra0F8Ld9CEp4+yvlMNfk3ZJf5W9cxZ
 FKXc9GD7O0OCKWQT1h1cgvnYpIfoOx5tqWLpRCiVN8QjVqfnAKIzY1le7/YA543GdbhH
 17Ug==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3GJwahlFNduVQd3WHTb7rG/DYt7I5iWqQaCl5dgqErK8g3+COxxamcvH592KZuPANq8VCAM5pJcI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxyrlv2/bG4g2AaC8RSD52HrI9vF72gpDALH+zwrNSU3zSyRKMy
 iFlWCYSY1N/HsgffJ6zUwgpPu0ysiLQBr4WtkEqrDLPjq7JGHZJ75Xw2
X-Gm-Gg: AeBDiev4NsNXixFtwualJZwzl5MCuASJ+h3QEAc7meGQ9FsGv6KpBSxDSVFCKtFRUxS
 BOhpjAMjBb+p8s14zuVDhciHN/Pj+elqlGBW23TSEehsy5sjHKGqTre6yGjdE5BB+Rbeyvvs7Ng
 q//b4+ttdFsqVmgRuSPHMGva4szk+wBpvMXHTkC0QGYRkKSww074E83P/kdxxX+hp9EZeMOcuBB
 +4zgc/jErfXbQBqYuPQHmNuJf79n2uIPvoEsqWj+pmkkZHnrjWao6zIssV2xnRU7Q0Hn9J8i4r0
 N26ku+XcoNA4OgaEtPKlVgQmr2O4duCs2Fg7B94UIGJgyBOLNjAdQkQ+odierWLo72Uu+VGBw2M
 CYeIBz0ThzU7pEhR0GM4hHQQIN4w5jSPjI8ea5qF2EXOAwCPqQ9ymMWrdzE/CnbzsrnYsda9UBl
 1BgCNVhWO+vxqnfviXGIOTqJsDj4dhrmrOXAMwmn29OCtfSEHrG7OkEOQ9V66qJJb18VOU32fum
 hIHq87uTIzwjemPYosSBBX7uuU18MMwKv5WEFL8cjs=
X-Received: by 2002:a05:620a:1991:b0:8ef:3953:7ab with SMTP id
 af79cd13be357-907badfb1b2mr550343985a.40.1778263521386; 
 Fri, 08 May 2026 11:05:21 -0700 (PDT)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu.
 [165.124.184.136]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-907b9c542cdsm265592085a.0.2026.05.08.11.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 11:05:21 -0700 (PDT)
From: Ziyi Guo <guoziyi114@gmail.com>
X-Google-Original-From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: l.stach@pengutronix.de
Cc: linux+etnaviv@armlinux.org.uk, christian.gmeiner@gmail.com,
 airlied@gmail.com, simona@ffwll.ch, etnaviv@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH] drm/etnaviv: Honor userptr read-only at the GPU MMU
Date: Fri,  8 May 2026 18:05:18 +0000
Message-Id: <20260508180518.1417371-1-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 10 May 2026 10:07:04 +0000
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

The IOMMU mapping for a userptr BO was installed with a hard-coded
ETNAVIV_PROT_READ | ETNAVIV_PROT_WRITE, ignoring the read-only
attribute set when the BO was created without ETNA_USERPTR_WRITE.
Build the prot mask from etnaviv_obj->userptr.ro so MMUv2 clears
MMUv2_PTE_WRITEABLE for read-only userptr BOs.

MMUv1 PTEs carry no R/W bits and its fast path skips the MMU, so
read-only cannot be enforced there; refuse such a mapping with
-ENODEV.

Fixes: a8c21a5451d8 ("drm/etnaviv: add initial etnaviv DRM driver")
Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
index e3572461b599..28f26d60ac05 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
@@ -269,10 +269,18 @@ int etnaviv_iommu_map_gem(struct etnaviv_iommu_context *context,
 {
 	struct sg_table *sgt = etnaviv_obj->sgt;
 	struct drm_mm_node *node;
+	int prot = ETNAVIV_PROT_READ;
 	int ret;
 
 	lockdep_assert_held(&etnaviv_obj->lock);
 
+	if (!etnaviv_obj->userptr.ptr || !etnaviv_obj->userptr.ro)
+		prot |= ETNAVIV_PROT_WRITE;
+
+	if (etnaviv_obj->userptr.ptr && etnaviv_obj->userptr.ro &&
+	    context->global->version == ETNAVIV_IOMMU_V1)
+		return -ENODEV;
+
 	mutex_lock(&context->lock);
 
 	/* v1 MMU can optimize single entry (contiguous) scatterlists */
@@ -301,7 +309,7 @@ int etnaviv_iommu_map_gem(struct etnaviv_iommu_context *context,
 
 	mapping->iova = node->start;
 	ret = etnaviv_iommu_map(context, node->start, etnaviv_obj->size, sgt,
-				ETNAVIV_PROT_READ | ETNAVIV_PROT_WRITE);
+				prot);
 
 	if (ret < 0) {
 		drm_mm_remove_node(node);
-- 
2.34.1

