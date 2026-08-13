Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35221C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:09:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56CE210F1A0;
	Thu, 13 Aug 2026 07:09:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="efkkXlRL";
	dkim-atps=neutral
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1280E10F1CA
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:09:54 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-5218927884fso3221731cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 00:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786604993; x=1787209793; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=f3MaYnYHOPM8bGKboWFu46JR1KiOLz9Hc+Ei/xGBa9w=;
 b=efkkXlRLQKE7fNhRw80r6Csjy05BYhc98KDmJ6rlQ8Zypp8HNtSd4Ygumj2c/iGz2W
 HLbNTyQlJjSmb56opkQsQnR/vaMbHHgfiEcCcVpUMTZ4O0oWSRE9WQ1FXwWb6Aj3hpyV
 YeChgjL1kBrGrtRgXYLS/coctAoxVJJqTl+0y8baXjhxu3C462IcYy8xgKyehfjVp11t
 bpVR32lEq6EBNgu7FxdXhZN9vT8Cqy9ktk9mIS5NcjFQGx4c4Z7nRd01i1WMmFv99TH/
 Hc1/Xi1epTmmjJXnZCKZh/RXiodxLpef2wmAl7llqn17OIlTJhDaIZc+RD9ONo4+R6pt
 IhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786604993; x=1787209793;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f3MaYnYHOPM8bGKboWFu46JR1KiOLz9Hc+Ei/xGBa9w=;
 b=X6+XbRbPZCOVM6Cpu3MraHy4HuelNCuuOs1+bP6XEb6p5tCWT12s5cYgCXxwFvVffU
 2tALCp9y38qrvCFmeY0AAiJYn+kBk8CA3pkO0Gb5HW/iw7+qAvrducQYVGUryMbFImot
 mw5H3PPIfq29cSzF946k7SghLFdKsopYo0TBhzmyP6ZlsLlhn3TVysyfUtz3JHXOlUsm
 chL64fUSnGOVJNc1HgpbBDJYYNy1j8IZuqyulri62k/R64OeLThKp/Z4Qh/8sb9GiO7m
 8r0ijsU9RtiQF7XAsP9rC6o9qOQJaVxnH+QBsUxsuJ/kHQr4ABZ4VDero1gGwZaqacfw
 KmsA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUSINiES9mcxbahg6JsM/e8m2tLeqLgbgXM4p+ro+FEfAWsRlmthzRk18sDAdg+3p2PcahSONWQm4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0QwSuqjRsp5ehAhVIbhQf4O32/ZYniYFtN6qKR5MHonJlV9Im
 KIV6+vzjag+WgiZ6d6rMWT4cbF9O73pdOQVdwGXBOllyxB5wUgFSCwqV
X-Gm-Gg: AR+sD12tTT853wd/KMFMBiOVVkxGjrn9/vvTJDp3xFF5hNJX3+6omNhkeF5KV0/JHoH
 M7lu4u4zsTT7kLmTpWqHdz0KeZaH05YOLWUwUw4SnzI1T1IMVVAUpImwNeBjqE30VWDfuu74WZ1
 s/v1//NDn8+ZyIordv9jeQ6ldldLvw9ycngbuzJPGp+42iHN7MTGOlGH2NZSnjRGQWMXpDNezjk
 grAh7wRdEZw6n3SPFC5BaE3eIrRM0dTJR2YJZRh95viOdwPqtoypDdUAQqx1lOZE/nEzX1D8AKV
 WEm6zTTAkH0SRlgymLVmSNTxZ3nT4EmpVDH9atlPuZ/ly/PKsI4iYixrYS1naJt5Gj/ClZvGAtl
 vUcxEudFOLkSVPht8HXs38NKydmrp+jUei93HtH1FEsyN2HP9f7jW71Tgd9KpnREfalUCJNHYKV
 oGCPr11a+y4k7mTIexp7dFL8ctsxlX1xcwdo3BnFWG8YCylBSpLcvGUA==
X-Received: by 2002:ac8:5a05:0:b0:517:2c1e:8b6 with SMTP id
 d75a77b69052e-52d73e3bda5mr35334591cf.38.1786604992962; 
 Thu, 13 Aug 2026 00:09:52 -0700 (PDT)
Received: from localhost ([37.19.206.57]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d73dfaec3sm11467541cf.1.2026.08.13.00.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 00:09:52 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:09:47 +0300
From: Dan Carpenter <error27@gmail.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matt Roper <matthew.d.roper@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, Xin Wang <x.wang@intel.com>,
 Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/xe: tests: fix error message in xe_migrate_sanity_test()
Message-ID: <an1tu0z3T-qX1ogn@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
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

This is supposed to print the error code but there is a copy and
paste bug so it prints "bo" instead of "err".

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/gpu/drm/xe/tests/xe_migrate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_migrate.c b/drivers/gpu/drm/xe/tests/xe_migrate.c
index 3c1be809be82..f10d9513747b 100644
--- a/drivers/gpu/drm/xe/tests/xe_migrate.c
+++ b/drivers/gpu/drm/xe/tests/xe_migrate.c
@@ -198,8 +198,7 @@ static void xe_migrate_sanity_test(struct xe_migrate *m, struct kunit *test,
 
 	err = xe_bo_vmap(bo);
 	if (err) {
-		KUNIT_FAIL(test, "Failed to vmap our pagetables: %li\n",
-			   PTR_ERR(bo));
+		KUNIT_FAIL(test, "Failed to vmap our pagetables: %d\n", err);
 		return;
 	}
 
-- 
2.53.0

