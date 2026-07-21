Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3E5C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:30:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 682E510E214;
	Tue, 21 Jul 2026 16:30:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nLYLHaa2";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF43410E214
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 16:29:58 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2cc7e86e7aeso89308775ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 09:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784651398; x=1785256198; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :message-id:date:cc:to:from:subject:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=755BiUbRPPKbOSidVRU/Ra+/ObPva+L4XMSJVI+HSC8=;
 b=nLYLHaa2+psrFSkNAOYXZJi8j+EiSptprY+c473/hc0jaIQb0zfI+PrY1g6XzP9lZb
 cIenpJjOYRS42lXy3jf3BEAs4S6sNRiWLtsIpfX5OHPfi94w6dp95Jn8aZBUmkauaxZX
 etunATrwI776sEQHFYDr0tDCpRbWUoZDG6HF5gqYd2xo6ZoGyyPCkqQmG5TGiMZJlDAn
 ZTmEmjWsEUALMN38CESX7uttj+Oun3moAqSsRCizc8e+9TLWqGQpLMXcRv06VRiyTJqM
 DZTmrByoPspIDNmw85A87XIteFdvz5ppYMX43VFjEW5+ilOgO5ueQzzt09wq+sQ/dXuG
 dQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784651398; x=1785256198;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :message-id:date:cc:to:from:subject:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=755BiUbRPPKbOSidVRU/Ra+/ObPva+L4XMSJVI+HSC8=;
 b=EQOgDI+qC7g4jWmojcIbOYAQbuZmBhZiFMlQi8YtjxCkR/RU+rG5gPNm2/liTgbhNk
 ROGs92W1kxCXIJJgBaDVJHZ0KAeMwNqOA7dX7R7y+q7szJ43NeiHoAXg6S42+lKmcrw+
 bbVHISQ/5TCAdZvrZzem3ysVcjg1Wjylmp2D8HeVmRYa5JV6xsWNMN/Uk4A376hIY8Zc
 FFitZYG0PisOsnykK/e5HDUQv9Wpv4CJXz1hNTU8CnVXwtzuHE731c9Q4MDigpnePFwW
 VgYHyA7qqOEDdP4LuTomu1HweI8ndAxC0Q+/NeADeeXviP1rsTo/IMtgQaJmqWj7gicR
 hTzA==
X-Gm-Message-State: AOJu0Yzh7RAsdbp1ZF0hO+cBN9OyOPm4V9fs/H2NwCkqn5eAhosKf18D
 dslnCUVVyxNv7MPIe3cFoA8zRB+1cc1eLSUQ51ZMO5lKS7DeDLMSp8s0N6D+Gdt7
X-Gm-Gg: AR+sD11er3oMBFT9t6meJKhS8A+c7X7uL59SiBj+iglDYfzfJUIaWsYonWGHskiD4Q5
 Y5TVGVh8/kbA2wkosUUJsWE4n1YJ8yJ7RIr3LS31Wwl0re6vsksCLkfJYHHfhDQlFOB9uCZYV4T
 ltL4E+O+kpmlA5CrVaQeyoObV6KsIETw5hi09K9/3JVYRiNv9pfNJiBGT1ECPsOgjjJIYoiSVuj
 EiX/jWXkOxWVEVdxjH8AsHQrq4AhCpO8F7xUQ6jLCFqYJ0cJpRFFGR6qIde3lCZ3uIue/w4Xm54
 K5Zklh+VRJYJlONDI6AT27ql+zWxEF8B7U9A9b8qSJgeE148ldbR5p7rhKvCJOpy3262Nxamoke
 2OyN7EbnkAbKpqEM7a3YjSqMP7MvAq6uNLdr388y300HOxP0rXGhytQLLV0gqY8hOTE6YVuY2wp
 daNy/dGfzvHR1Jz968hHTtXC7WzbbsIEaCreVs9ivHnMtw2ZO2
X-Received: by 2002:a17:903:1a2e:b0:2c9:c517:d078 with SMTP id
 d9443c01a7336-2cf349d849amr217655105ad.36.1784651398229; 
 Tue, 21 Jul 2026 09:29:58 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf34490361sm80219255ad.17.2026.07.21.09.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 09:29:57 -0700 (PDT)
Subject: [PATCH v2] drm/gpusvm: Zero HMM PFNs before scanning ranges
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 skinsburskii@gmail.com, thomas.hellstrom@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org
Date: Tue, 21 Jul 2026 09:29:56 -0700
Message-ID: <178465137297.1335238.13264315601290244705.stgit@skinsburskii>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

drm_gpusvm_check_pages() and drm_gpusvm_scan_mm() asks HMM to report the
current CPU page-table state without faulting missing entries by leaving
default_flags set to zero. The HMM PFN array is still caller-owned input/output
state, and the framework may preserve input bits while filling entries. It is
not safe for the caller to hand HMM an uninitialized array and then treat
entries without HMM_PFN_VALID as an authoritative unpopulated result.

Use kvcalloc() for the temporary PFN array so entries that are not
reported as valid start from the documented zero state. This prevents
random stack or heap contents from being interpreted as HMM PFN flags or
PFN values during the scan.

Fixes: f1d08a586482 ("drm/gpusvm: Introduce a function to scan the current migration state")
Cc: stable@vger.kernel.org
Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 drivers/gpu/drm/drm_gpusvm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index ca234fd2c491..6ca6e68be5a6 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -708,7 +708,7 @@ static bool drm_gpusvm_check_pages(struct drm_gpusvm *gpusvm,
 
 	mmap_assert_locked(gpusvm->mm);
 
-	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
+	pfns = kvcalloc(npages, sizeof(*pfns), GFP_KERNEL);
 	if (!pfns)
 		return false;
 
@@ -780,7 +780,7 @@ enum drm_gpusvm_scan_result drm_gpusvm_scan_mm(struct drm_gpusvm_range *range,
 	const struct dev_pagemap *other = NULL;
 	int err, i;
 
-	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
+	pfns = kvcalloc(npages, sizeof(*pfns), GFP_KERNEL);
 	if (!pfns)
 		return DRM_GPUSVM_SCAN_UNPOPULATED;
 


