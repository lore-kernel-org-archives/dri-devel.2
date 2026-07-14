Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917EAC44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:19:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF40510F1E9;
	Thu, 16 Jul 2026 08:19:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qA7BYMzX";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 683A610E0E3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 22:54:34 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2ceed7018c8so9318065ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 15:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784069674; x=1784674474; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :message-id:date:cc:to:from:subject:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PuczVviH7I6iBF+tE/3yKvEgvc7CTglLYSZ6Ql2SVLo=;
 b=qA7BYMzX3yD7Db1pAVZlYvgINClBNY0EWAo1mDTuOeOtstwNhJwriJF6A2ghsSkbxE
 fX7u4HkfXXGYc49eWhBf9XnyOTRNT/o756H4pF3qlTT1VKLp9rfiQYLbtlBKWL79TGvG
 9xPmlqINJ+PmQnkIZAZ1L0qTPS8+05f8KxL717JNS6BkMq1TGwS8Q4y3c19IkZCjNEtm
 6OTKyxlkvuByqGePPa85T9Ta1W0lU5RolIOGrI0dd81VzlgEcUapeCbmR1kSlqOe79ry
 PsfsQV3b35+TABiPlfSTSKUYvQzNXFV8mgfV+EKG+JRIFsmw8D7gvWvB8ABzqwim6SFO
 YO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784069674; x=1784674474;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :message-id:date:cc:to:from:subject:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PuczVviH7I6iBF+tE/3yKvEgvc7CTglLYSZ6Ql2SVLo=;
 b=SfeQSKys/pGQDtroycbv497Y/8OZ5PdtLWLuUV3pHxl6Q5NsLPTivi3fiH/sLN467b
 i1cPUrXsy5+CwOcC9Ehu33z0kh48JVZBfS/Gg7y0AVB4fa1xgS4XKFjN/YbpVJPHqYJJ
 RR/VH08qSzwTJrgYQA8kRbAMELeKSIZebmuMc4ttIN23mDvlUg0f9wsMJER6JcXiCAvW
 zcvjlEkNbUhc9V2iWboxfROCAxzoMy3STDU3hKf6tOjL34OgNK/N5bWu0+5OevscbOK6
 e47WYC6/G/4BOQBIWNpxvwfmN4A1F9xRHychw2PEgiAOGPCmqQ1qkVIm0+GKAlIBolgK
 Q52Q==
X-Gm-Message-State: AOJu0Yz9VmOVO+Iq+s0xYpwuuY+WZjb1MQac7lpJgaWt3gZhm0CG+XXG
 m4LyXFWHuMgSjcZPBhOZ0JzNNvYl3DgUQre0oo+yyXr0vSSNvtsV/V+d85dEhu0K
X-Gm-Gg: AfdE7cnNtQ/8Eu6TFrdKO1Dcy0s2vxhPRH+9eXGVsvKRyABSecMhdwWatvEd7Bzx3LU
 uP5iqYHrhNtDRfbTA+YSm4MBDpS8UmR3YO6Yv3MxoLptF2cP0Gq8WwXxq2GVAc9HZUYrszVAv6t
 NGQYbGfh78ihpJox4l3iZypPNagTA2gjhjBdsIlfxHBG7MZQnU3kZ3541opYM1zsdFkrYPEE6UK
 dl2yz0B7ixVGWr3+NDUCRD5lJSk+EJH2SfNXUDuPECQcIMd5ES236NmdM8nPFHjyMFSBIqQVKSu
 X5Crk/6g0KHiyQjbnocPCnwtSwri962na5qAPY7iu1L7ovBgP4InWol/FxRuCja86AhnVDoTZLp
 LJFU/jZ7B7witb+IfLTHRqC/q3GuoRfsDmR8xeBLHAN0dhHQXHZYqnjyinYnpuhavXIHyDnzK5W
 KTuclIikWDKxkfAf/R/K+4S5pr2EYPkBYFGseCfdIR79RtWi6hVfh55sf9EQ0=
X-Received: by 2002:a17:902:d985:b0:2ca:bf8e:35fe with SMTP id
 d9443c01a7336-2ce9e9ac9b7mr141747505ad.16.1784069673866; 
 Tue, 14 Jul 2026 15:54:33 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3d57bsm122411715ad.59.2026.07.14.15.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 15:54:33 -0700 (PDT)
Subject: [PATCH] drm/gpusvm: Zero HMM PFNs before scanning ranges
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 skinsburskii@gmail.com, thomas.hellstrom@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org
Date: Tue, 14 Jul 2026 15:54:32 -0700
Message-ID: <178406967042.1113483.2116704310277917086.stgit@skinsburskii>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:18:22 +0000
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

drm_gpusvm_scan_mm() asks HMM to report the current CPU page-table
state without faulting missing entries by leaving default_flags set to
zero. The HMM PFN array is still caller-owned input/output state, and
the framework may preserve input bits while filling entries. It is not
safe for the caller to hand HMM an uninitialized array and then treat
entries without HMM_PFN_VALID as an authoritative unpopulated result.

Use kvcalloc() for the temporary PFN array so entries that are not
reported as valid start from the documented zero state. This prevents
random stack or heap contents from being interpreted as HMM PFN flags or
PFN values during the scan.

Fixes: f1d08a586482 ("drm/gpusvm: Introduce a function to scan the current migration state")
Cc: stable@vger.kernel.org
Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 drivers/gpu/drm/drm_gpusvm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 1a8bb83bd28d..c8f489d7ff7e 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -859,7 +859,7 @@ enum drm_gpusvm_scan_result drm_gpusvm_scan_mm(struct drm_gpusvm_range *range,
 	const struct dev_pagemap *other = NULL;
 	int err, i;
 
-	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
+	pfns = kvcalloc(npages, sizeof(*pfns), GFP_KERNEL);
 	if (!pfns)
 		return DRM_GPUSVM_SCAN_UNPOPULATED;
 


