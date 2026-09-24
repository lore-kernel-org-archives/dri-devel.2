Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022D2C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A10110F67E;
	Thu, 24 Sep 2026 15:36:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K/o7ijRH";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C1BB10F67F
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:36:09 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843c3ea1f6so1325827f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 08:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790264167; x=1790868967; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=b3avaLkGbJI7b3eQY9BMM4QIlSMsNqoKGq3lOV/zF1s=;
 b=K/o7ijRH8RwouVJ4GHcb+mIqIaHk/YRDCrWWl1P/oHTYP1ATcyhV/87cFJm/wnQgx3
 htkvavEsMWjnL/RpHfddvqsRQ6ptmQ95XovDIvzW35l5rl+x7wPDSCL3FWzlPjCLfvk8
 DqWYiRANvCmJ+y3X9xKHEVQ9gJgFZITJ0r7s5Sr60HMQDPGdkn8SS1P4R4AMroYrIxob
 lx/btCXsvdU4avGHaM1gn4ZWgpEQgcUPU6kcS27gMBbP458pBzdhpArT2+A8Uz3iF1z3
 I2HfmFQeZW57OxfFSjmf3ASSD92A/IowLhCPd8S2M3cHiRijdmDhMfpsaQUDcE9Dtgfx
 1nQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790264167; x=1790868967;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b3avaLkGbJI7b3eQY9BMM4QIlSMsNqoKGq3lOV/zF1s=;
 b=amMJ6ewgy95pi+i1uxGhgHjmlDpecSHIFnckyrx5XsDvyfts3sx77f3WBkCIO/kP67
 nmzVqs2UD2O/huMbBC7rR9T+Ih1bF+A5gGrSSOzyrJKzx2jI7IHiDIDB/lxhyjTJkkeJ
 eIvYCMCgKCjA4FGmhW+g8VeIxqOJRT848GfSjHNm9HhfzK0wSAQc+WL7Uwwt7wAU8gGE
 RklppepwZvME2onFY9S3Z9ahb4lKs7xlcIkvqu3p95mUs4/XglESu1scb9QtOFQJVoGC
 5561pVc83ivjOFt6OuI0eudLRhYD7v8biAmi7tx94cbKkwusxucD/grbD/Vm/e4rL70e
 BGtg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1CWTVzwT55TPoHJNBkJJVbOfvPgnP8vlXtU1fnvNWsd+w5X5zfCQGINTNunvh9evHlPnavqmEt0U=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mMgFwXwH02ryzVvrqHLrkImh3SP+i+dmItAxbloRgfd9gAbKP6
 z6yrQhPDCRELkJGYM2Lx9tS6nFjIg4T+tCR5Hy3e21tbzro9M+kfivjb
X-Gm-Gg: AYBFou0t1Hj21rFczDUru1H/guJAa89NpZXmRICD4EgpmH6KNoJw7OzoMb6DP3+kn4w
 abhttF7LPORJiZvY8z0/fSgeiWiuVDqnNZcJ/WK5Bm2sT0H3Ow+2q4xvI66EQRA/MPT70z+qyFB
 koshp+4w0+vH7hO9W3M8GyEgwFpR9S2U/GDd6l9BQtgRzHjwwK5jp6oo3U/5kGqzIv2sD/jZwk/
 J9ibxmiJhWGX1BNopoveXna+m9AW7AILuF8xlS7YERnSIBvWRGTAbvXUTuIbbS4ee+nMP7UxdzK
 mBN38uCuBqWM/HaFjc3TZXjpuUu/glBJn22wToWG+hTJVCmqcTIkwzLey09onau41RztSwlWClK
 eI99ZHzjK3IBYOpyVPuW2rin1k4w4l8sGZbH2lLjsfzMI9Z3YxC8duC+qa6g/cuVYRrcizrDolJ
 FSyEDMBHG7c0DIMU073f4yyn44VMfHBMaNBE01/Q2gQPawgKkNNdLQ38b79DGgaQwLuTjEzt8ns
 LURbdrDDMCW83RlcZ9cnwnoFlcgJKETJn8=
X-Received: by 2002:a05:6000:402a:b0:45e:e1a4:c4c3 with SMTP id
 ffacd0b85a97d-48871670ccdmr5463936f8f.15.1790264167282; 
 Thu, 24 Sep 2026 08:36:07 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886848646dsm14308007f8f.10.2026.09.24.08.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 08:36:06 -0700 (PDT)
Date: Thu, 24 Sep 2026 18:36:05 +0300
From: Michail Tatas <michail.tatas@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/amdgpu: unmap GART dma pages before free
Message-ID: <arVDZbkfZbzfvKO4@michalis-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

amdgpu_gart_table_ram_alloc() maps the GART dma pages
and neither the error path nor amdgpu_gart_table_ram_free()
unmaps those pages before freeing them, which could leave
the device writing to freed memory.

Fix by unmapping the GART dma pages before freeing them.

Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
---

Changes in v2:
- Fixed a null dereference possibility based on review 
  from sashiko

Revisions:
- v1: https://lore.kernel.org/all/arKhDFCSoPDNYaxX@michalis-linux/

 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index c4c21dbbbdbf..116c646b86a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -209,6 +209,8 @@ int amdgpu_gart_table_ram_alloc(struct amdgpu_device *adev)
 error_resv:
 	amdgpu_bo_unreserve(bo);
 error:
+	dma_unmap_page(&adev->pdev->dev, dma_addr, adev->gart.table_size,
+		       DMA_BIDIRECTIONAL);
 	amdgpu_bo_unref(&bo);
 	if (sg) {
 		sg_free_table(sg);
@@ -240,6 +242,8 @@ void amdgpu_gart_table_ram_free(struct amdgpu_device *adev)
 		amdgpu_bo_unreserve(adev->gart.bo);
 	}
 	amdgpu_bo_unref(&adev->gart.bo);
+	dma_unmap_page(&adev->pdev->dev, sg_dma_address(sg->sgl), adev->gart.table_size,
+		       DMA_BIDIRECTIONAL);
 	sg_free_table(sg);
 	kfree(sg);
 	p = virt_to_page(adev->gart.ptr);
-- 
2.43.0

