Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C595FC88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:48:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04C6D10E097;
	Tue, 15 Sep 2026 15:48:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dje2cfxs";
	dkim-atps=neutral
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com
 [74.125.230.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E09FA10E097
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:48:10 +0000 (UTC)
Received: by mail-qk2-f12.google.com with SMTP id
 d75a77b69052e-52fb766bfd8so39460691cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 08:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789487290; x=1790092090; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Kylk6jQtKAQ+o3Y2HdR0DJ4+oM1lekmhtx/9tJwi1dg=;
 b=dje2cfxsjmsZKuqxfPjfklE+6oBvEKnZiDiNRzfXxjrUspRjIn/A3pAVYcgghpqPp6
 IQBsLudXmZgAhPoSyJRNsDhwEfJHJ2SUQUq0Px88jgX8mp9VpiXjhQtifIfUXvMyERk8
 qY5+ufv0O9N6BChH3k4nqLL7/pXhYUs+tVeU/XHpP0Ue+4+EYfBI2bKTKBZ2FZoxtRSt
 +O4oC7r3O6rsi3BVQUVxR4Vtff4GfUX5tMth06gBP/IBrpN2JiT0jFub3Lcsb8NBwifV
 qBb42vOSN8RxaTNVPLrYuTUC0VFwSnhVLLiFr/uLkz/t9WvqsCmGVMVxADCUCj92dIBR
 giDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789487290; x=1790092090;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Kylk6jQtKAQ+o3Y2HdR0DJ4+oM1lekmhtx/9tJwi1dg=;
 b=fs14oxuDq7CFjwBaVaoLZdHzLtgRMBoQtV1jnSc5BpDcnspK8k5EfZKjaAkn97NPeX
 SOuRcOFynunErJJ6xgwBVTS8hJmduuimziqbKKZGPR+eiwHdq8OgVwQLWSJA9BipGaaN
 9mqQkBlbcr4qrnhQzNdOjuIuOUR4PWw9/xB7W+fgIaiPmZfeb2O93t3e4z7cUbuJ7bBi
 VCWPUlPKxXBy53d86At+c5/bMQuU9TmtaM5ArAMKUk00yzRn9CwC8eoEQOq6f+lzgKEP
 0Va3zxDLQWorzS0cZfQV2FWOT23is+TnbOMoPFqlCr077Nhx4wvpwIBZEhbPqN5vZ+Oa
 W3xA==
X-Gm-Message-State: AFuF++lnsy8lA1Wz03PJSfEtV/tOR95auINOmM0qdWvINkmkW8lQzn7W
 e3eyMl8Pk/5BmY3lpdacL+DmDslP8jhobT2krxnYQCDFQK0kgj0nZWuy
X-Gm-Gg: AYBFou2lpjv1SLyqaJ6oWY2UTIaYU73JCuQgrd/rwxYQu+yQmJiDPQyjHwSFAbSsCLf
 7nwwNJx1dGE9+fPXkM0zrKg6ZMlmAe2Rg0yp+usLFPWjhaPnMJJC9Dpx892HuDO7NjySt0FZikg
 ZP/kSDOu2wZua14H6zZBqHMi65FcjJ0m9pQl5RwnvjxWXi0nAGeRk8pDT85M2YgFyGq1IKRtTx3
 FhRJXVaGdf2Jxt7jwMo5nPQF/KP4agqGLLKl02p4vsk+9MBG5LTKiqXq6xq9I/0rWXUgcpTWACp
 osbbreXdpulJsH2wMZ5tkKvQw2Cjv1k6UQAQ+LVK5yB3tlYCBuNEXrvuG0nQYSpF3u9iUbd5erL
 v/7zXzvOh8sIrbpWsC3BUzmS4pkvuA0lJmmBaxXgsvWYWPZwt8t67D4r0aOo3zsgPe6+xCi4zTc
 svglF7YhIA4kmIs62kiEiZaLRHeLdQWGd8wdqfhLBg1zuWz8GKX68yFoj2eR5MWTUl7rTa4dnjH
 EK+/+u4iMU6F3+V
X-Received: by 2002:a05:622a:190f:b0:530:e4fb:60fc with SMTP id
 d75a77b69052e-5310cf3a3c1mr119647581cf.15.1789487289736; 
 Tue, 15 Sep 2026 08:48:09 -0700 (PDT)
Received: from laptop.amd.com (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-530f6823ba5sm82610361cf.28.2026.09.15.08.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 08:48:09 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: christian.koenig@amd.com, ray.huang@amd.com, nat@pixelcluster.dev,
 arunpravin.paneerselvam@amd.com, matthew.auld@intel.com,
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: change TTM maintainers to Natalie and Arun
Date: Tue, 15 Sep 2026 17:48:04 +0200
Message-ID: <20260915154804.605772-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
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

The blunt reality is that I don't have time to look into patches or bugs
any more as it would be necessary. The same counts for Ray.

Natalie has been working on the dmem cgroup patches for TTM and agreed
to take over looking more into TTM.

Arun is working in my team and already maintaining AMDs VRAM backend for
TTM and the underlying buddy allocator.

Add Thomas as reviewer as well, better to have more eyes on that
component.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b5a4e4b35cf..b6e58a138501 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9140,10 +9140,11 @@ F:	drivers/gpu/drm/drm_privacy_screen*
 F:	include/drm/drm_privacy_screen*
 
 DRM TTM SUBSYSTEM
-M:	Christian Koenig <christian.koenig@amd.com>
-M:	Huang Rui <ray.huang@amd.com>
+M:	Natalie Vock <nat@pixelcluster.dev>
+M:	Arun Pravin <arunpravin.paneerselvam@amd.com>
 R:	Matthew Auld <matthew.auld@intel.com>
 R:	Matthew Brost <matthew.brost@intel.com>
+R:	Thomas Hellström <thomas.hellstrom@linux.intel.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
-- 
2.43.0

