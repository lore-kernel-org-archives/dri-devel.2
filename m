Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B046DFF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 11:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21DA810E34C;
	Tue, 28 Apr 2026 11:45:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dj6Zrweg";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1E7D10E34C
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:45:37 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-35dac556bb2so6685607a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 04:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777376737; x=1777981537; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1pkP0/dDsbN7BRJkxdoTN59hq9O2Teltgpo/B86M5m4=;
 b=Dj6ZrwegSiiEUwFFUD82QQ5j7GLoCtiPArU6C+VlAhzcK78/Pt39QhICQX7esGvXE7
 jTv1dl9eGgcaFLdQZSs0VJBjbZz1xOSCr1tFJnAw8jo7yaAFdBpKy6aTud/vZ1ZZ1rno
 71sg41xm5MS+t+uCnupxzOlx2afq36/adc1k/dMSeIz5ECkPI4Ol4Zesdp9wUPKLByoL
 mXgn5XPGZYlpfhgoFPe01REdAEOzphUMX1wtPOvhoXXMtElTTaVfvZn1IHm+eW7rrxhR
 Sbu7r/D09tYVuXha2w1psyseqZ73jbMDnGjgC6YWfC3+idveMuRPec1asC9dHW0uldIj
 D0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777376737; x=1777981537;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1pkP0/dDsbN7BRJkxdoTN59hq9O2Teltgpo/B86M5m4=;
 b=Iq2jFx+FhnHgui9qbkxjNWXZjxy3FyZlM+G/uiKT0MmOZWwLzVc/GcQtClGo1vz0Q1
 qtOhVDM3inf/7MOLO1uP0bqSioYTd6jM76lJj1JYcSDI9LzcrvxlgpSX3aKjBVVhPqKM
 02v+wG3QvL5hXZuWtLBcoe7gc4EWhXTR488aUrBzZr1/yoR/RD8+qa0f/3o0Kx3wHZiZ
 KQ86Qrb3BB5hqY55kQ93dMIFqrMEgXdCV5mJME4oyw7mIs+YeXfI3P8jRWJYfm5V7rPD
 Geewie9Qvv0GZ5Bbwy89g2zNBbMbHsuxqMwNa4hIozdoCawMSMeUNhVm9x4VVCX0JzYK
 FXSQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8hbDVmK/XqZn1g1laxizBfPQQfu6teiLFUlvDo3vCV9MjlxMFz8lovBXTxQz0FIygYwu+VYKEnn1w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzntlGd4YQp9TFCG+q1lwFXn+OOXCUwyO0Z1682s8XPres/t0Ri
 AY5RavupBxNN9nZes3exKZ7ca8W9Sm9SXooBn8OOnjmO2V2ks9DT0irY
X-Gm-Gg: AeBDievtdCXsgGCa3EEUsyFUJa2i+G9pyvf+nvLQ5aAvv3ltv11HdCwDf9J3dM3dsdG
 ttmPrbYwJtZ7Df2q6iwpg75iqU/kADmccRajIoaIE/HaeLg81aM6jiy9MDWvuoZEeUsOlaIFKNI
 YLvtPr8sV0kJN6f09Wtm6IAaPiYtgUrrA/AQdeu+VJmXSTZ+bjChfwDTPCvT8PKUdrYGGBzhUlr
 PXAR+oyCIQzd4VbsFeSluz/YqktxU0D7JnypFLVC78gkMtMQD+PNV4uIsz1GzEt+DHSVhEXLK5D
 KUB4PS0ip1UYmfFLeRHwap3oWQNQ/rOzdQLfZbs3Xjsf4cpq2596nxd9WfZcozqUQd1ZI1d0ALk
 2Ut/USJ4qNJlsg3bi2jkVTYNFBXbp+UH6dQ530PFR0g44L6H6/whhR30sSQgLlKCx+esdOsmW6b
 aLymLKwxu3EXjsUNYkv8qqLm8=
X-Received: by 2002:a17:90a:d64e:b0:35d:8fdb:4f26 with SMTP id
 98e67ed59e1d1-36491f89e50mr2890066a91.1.1777376737142; 
 Tue, 28 Apr 2026 04:45:37 -0700 (PDT)
Received: from lgs.. ([101.36.111.22]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36490fbfccesm2690890a91.14.2026.04.28.04.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 04:45:36 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Likun Gao <Likun.Gao@amd.com>, Asad Kamal <asad.kamal@amd.com>,
 Ce Sun <cesun102@amd.com>, Kees Cook <kees@kernel.org>,
 Meng Li <li.meng@amd.com>, Guangshuo Li <lgs201920130244@gmail.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Fix error handling in amdgpu_xcp_cfg_sysfs_init()
Date: Tue, 28 Apr 2026 19:45:21 +0800
Message-ID: <20260428114521.364863-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

Once kobject_init_and_add() fails for an XCP resource kobject, we
should call kobject_put() to decrement the reference count for cleanup.
Otherwise, it could cause a memory leak.

The error handling loop also uses xcp_res[i] instead of xcp_res[j],
so it fails to put the previously added resource kobjects and may put
the failed kobject more than once.

Fix this by putting the failed resource kobject before jumping to the
error path, and by using the correct loop index when putting the
previously added resource kobjects.

Found by code review.

Fixes: 4ae86dc87850 ("drm/amdgpu: Add sysfs nodes to get xcp details")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index cc5f4e01e38f..315e33a9d7c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -948,15 +948,17 @@ static void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev)
 					 &xcp_cfg_res_sysfs_ktype,
 					 &xcp_cfg->kobj, "%s",
 					 xcp_res_names[rid]);
-		if (r)
+		if (r) {
+			kobject_put(&xcp_res->kobj);
 			goto err;
+		}
 	}
 
 	adev->xcp_mgr->xcp_cfg = xcp_cfg;
 	return;
 err:
 	for (j = 0; j < i; j++) {
-		xcp_res = &xcp_cfg->xcp_res[i];
+		xcp_res = &xcp_cfg->xcp_res[j];
 		kobject_put(&xcp_res->kobj);
 	}
 
-- 
2.43.0

