Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70415C79F8B
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2660610E61D;
	Sat,  5 Sep 2026 15:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aJt4d+Oa";
	dkim-atps=neutral
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F07010FAF1
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 12:05:13 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id
 5614622812f47-4b21f09ec76so693222b6e.0
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 05:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788523512; x=1789128312; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4+3ynWqyKFzddHoGhyE7PRu6fU0EoMOeTQlZ8MJkjTA=;
 b=aJt4d+OaT3aAhZcjTgqMnSoXtwJAO3nxes0nzXbN9t2hYx6VIE3nlLclVEPUUN+Msp
 VWWcex42jza8oQnaxeJ6ivWe57AtHI+j3ABQo7A++qlQ0fpaQ2jHLmMVbVMM5tcramB/
 X3eW35LklRrOyZTR4xNwUshbsGKdrrKdCwMwr7tPSm7SZx3KtAnXcUBbdLIQzGQnpUwP
 cPiOx0WV8ZQ+CuqZM0IiHfJapWNobDxYS37t9nx1PGOy2hyYEtpx1gahOa/4JSkqq2vK
 ISkDMQ7VvCoGgDP6qopZKHFFIUbUgA/i6ac/DFpS9CXvWy5DXg+jja56+OlK16rRDaXJ
 100Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788523512; x=1789128312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4+3ynWqyKFzddHoGhyE7PRu6fU0EoMOeTQlZ8MJkjTA=;
 b=sJ9k1S9GZZTDLptWSBI253W7MdJ7wYIddlLc7hCUahh+yic8eEn8R60xqSh2d+Z0HD
 ZsRus1q9OVHyQIKPPnwhNB6wMqSK2I9kp5BDZaMOoGQ/MyG3IWkIV/OUqEaluleI5TbM
 tcjIOSSNyAWAt/HS/bc5QvzVRYtPzb5YBzLJxP6okqZo79bXJc8yxlh4mhC1jfic4eIZ
 7Opgfngp999ekOHzrQNPOXBg9M+Cqa81QgdDsFrwV3xfcp4NZfOF5LxqKVzIoC2/NsWL
 ZDMcZjyQ11SLUxYaZ58lLXOeSZX6v5Eiz6R89y6r9ZEEc39SlSPMvpzGb1swOQXKuOIQ
 jNOg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2VOojEbX7b3VhblgCRWjz2CT9iXzfKZls9oWNvzg/K1zieIBk72y/+wBpeWt8TbhRrsyMjZAYOAk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++meVsbw1R/XL73OdtE56zYIrFdU4KW93u+zUiaJD4UtBDWrW92d
 FZhUgu+wQjyzwphVqxQcJjqlXXyafwwYOWdGUt0zQaXJuY2brWspGZB/
X-Gm-Gg: AYBFou0oo/9DBCE/1PIVowPT62nb7Q8zBgiXvO09gXpizMvYVWn0udDWGnPOh+TGozq
 bMBa24o/M7xmYhBvDzIzgNdi81XAYN1iQxM3S5hmxKy1IJdy04llSapziV0HDvv7AxNtJjOHePa
 AjWb2NqHDkv2Viw89hqJqMaC8LOxrppAlizqppgQ9FPMXyN85qa1jeoHLYN/+cIRBws8NSCvMrr
 7uWJX5dhLidMiZvhJAd7g1h4ar+KKxW3Jyg1xCx55LCr6poTxkei2BWRsBQovf7Nt0kzMC/iuF2
 gzRjhmdxzWsF5QmJG0A6HV7NLeRJtXqcfKkIcWGwz+k6PzIyOmQBRaguXJmhdbHokrmJDHqWz4d
 8ZiqSuKBiHIzQojzGmpgb7h0zd1ojsMgLeQD/8EHHUwf3AjzJdyV54VmNgL2mrfRBWiN5JbafET
 rG2vKyRrm4SOKVNvJiJKh89vPqmIQalB5rKkqRYeC/ctqNvMAmkqLYFsDhJLHXZpBMPiYCh84d5
 kzJZ+JKptI0sYcL7zryhrylHw==
X-Received: by 2002:a05:6820:4b0a:b0:6b3:5642:76aa with SMTP id
 006d021491bc7-6b6fd9c41dfmr4112854eaf.28.1788523512355; 
 Fri, 04 Sep 2026 05:05:12 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339b8f787esm5770422eec.23.2026.09.04.05.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:05:11 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Zack Rusin <zack.rusin@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 3/3] drm/vmwgfx: fix repeated word in log message
Date: Fri,  4 Sep 2026 17:34:18 +0530
Message-ID: <20260904120430.17224-4-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904120430.17224-1-hemanth.selam@gmail.com>
References: <20260904120430.17224-1-hemanth.selam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:14 +0000
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

Drop the word written twice, reported by checkpatch.pl as a possible
repeated word.

Only the message text changes, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
index e3a187a2c7a1..3c82801a8150 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
@@ -702,7 +702,7 @@ int vmw_resource_validate(struct vmw_resource *res, bool intr,
 
 		spin_lock(&dev_priv->resource_lock);
 		if (list_empty(lru_list) || !res->func->may_evict) {
-			DRM_ERROR("Out of device device resources "
+			DRM_ERROR("Out of device resources "
 				  "for %s.\n", res->func->type_name);
 			ret = -EBUSY;
 			spin_unlock(&dev_priv->resource_lock);
-- 
2.48.1

