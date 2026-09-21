Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9962C982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE02089C28;
	Mon, 21 Sep 2026 10:33:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YOpZLUpA";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 035A910E039
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 10:33:27 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccd4f99cso3037602a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 03:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789986807; x=1790591607; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LOJu4MS3w9MQaaK/54wLQUMKD8EsXJhG30omKcb0Cl4=;
 b=YOpZLUpAnwF8TB/liIFVgsD+Nak8R3pe8agLZebjPRD/RqMYbiuxf/obT2ot48R69r
 vNTxU0RKuNOKNszQ3usDFpGCezYcmwuZJBFmtOjgf2x2oubOL0jHOHd5l4dAhffPgaA/
 /775dzB/ZtnARNXQvJ15OnDJM6Ptisoec7WUys3khOO34fNfqJZuJVkPMFlJkBqf7luj
 VjoXDTj9EAXa+WsK+WqTbUBkUL8QAPPuS99qNvNpTXIWnM7z2k0MYrWbrgzi6v8RnVyR
 Dr9L5ODjSo0YdP9SOilWOBJcQXl11g6i8jkKPz8D8neujpf1GWLmEMd7Pw10iBGw0Lj7
 idcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789986807; x=1790591607;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LOJu4MS3w9MQaaK/54wLQUMKD8EsXJhG30omKcb0Cl4=;
 b=D3mVDNYBcHUMNbl+53jZLDEBaIO/h0+9hStMitcKayXmEHDvPgZ6QkNtJwvHphPSxi
 WRBgQf5fPObt1lwpbfHZT/rUstAJORJ5yhX21UW1mIFCXOTD5Y4YAG+UzcTEFlGn8qGB
 jnx65/oEqtHgaAvm2DTZB8RaS0DDzm7o9XCub86M7qhImw+D/UH9AVQbsCrH6cJgjs3K
 IdkZHefMnZiUIU49+mOHYIcq38dxIBj4Tir8IkxK+KsLixzGNriqTHBI69szKuTRghRx
 8TnXtQEgd9oTNpkCyMZC5mFD+ksjlPK1RgPAdCC8zp2xJmCv50c+TfT2t9NpNbxpD6uf
 HB8A==
X-Forwarded-Encrypted: i=1;
 AKwUvByXyIayf1IQBUxSSBEjkJ91SVwTZ523P83P9IpVmDP0UCIZWatHX+xaRb/2txvbUv8Tq7zZqwWX3e8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mRW1HvAfre/IVnItWMDdi6Lupz5rSwsQ3rZNzCdqzGdheFp8Aw
 UBjz5L8Ir7oh/DncXL/KG71A3GPM2D1uT9hl4zSiHNLUCZs3NlwQ811T
X-Gm-Gg: AYBFou2EZyGtLq1nDl0RVBOCCW9bLERno8sbHPNOpTnP6q2SB5EeijVTA5ZVB6Ygt79
 Ag77zs6cNrDDDWB1RKVtoiv549SJ7CUuv1vAIno2kVKqD/8/h87V0G8rUVS2HiIjkGASgJyxQax
 ppMfrB2dy1ogNPNHv6aQfKqXFGn9itJQ9nIqz3EIK9D7zfy5fNg3UFWBHyzbw6vZY53smo82Ej2
 CSx57VCwG19jGV3pbVUjr9R/MSF7oOlbma3gqCviMcuUzhSeQ0mHtdf0Y/3KFe+VVsNVcMNPWp3
 oJpVDGfHzj6RCEWtYrUvNFbaaLbyB35EqWzb3mVmBi+WKiR7l+2KgtXNxYfrAqC4CNlpr5EszFN
 94C6JqSmpzgRr1k147G390Ng0p3XLZPvoQHI6JDzHM4AnBie52cPVPcx2V7CYyRR6rG9efGQDEc
 tzXAyEa64rJdakcWPQDKvvJaS8ijdXtRUiFHEP1aR8JX9CWCw2e+OPdw==
X-Received: by 2002:a17:90b:1b03:b0:39d:f254:4173 with SMTP id
 98e67ed59e1d1-39e54ea5e89mr16601552a91.21.1789986807374; 
 Mon, 21 Sep 2026 03:33:27 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a023e44854sm4994658a91.4.2026.09.21.03.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 03:33:26 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ce Sun <cesun102@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Guangshuo Li <lgs201920130244@gmail.com>,
 Brady Norander <bradynorander@gmail.com>, Kees Cook <kees@kernel.org>,
 Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: fix ACP MFD device leak on init failure
Date: Mon, 21 Sep 2026 18:33:18 +0800
Message-ID: <20260921103318.353216-1-lgs201920130244@gmail.com>
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

acp_hw_init() registers ACP child devices with mfd_add_devices() before
attaching them to the ACP power domain and initializing the hardware.

If attaching a child to the power domain fails, or if the ACP reset or
clock enable operation times out, the failure path frees only the
source cell, resource, and platform-data allocations. The child
platform devices already registered by mfd_add_devices() remain
registered and are never released.

Remove the children from the power domain and unregister the MFD
devices on failures that occur after mfd_add_devices() succeeds. Keep
mfd_add_devices() failures on the existing cleanup path since the MFD
core already rolls back partially registered children itself.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 25030321ba28 ("drm/amd: add pm domain for ACP IP sub blocks")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index 9014678d75ab..be4d00ac96b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -318,7 +318,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
 		r = device_for_each_child(adev->acp.parent, &adev->acp.acp_genpd->gpd,
 					  acp_genpd_add_device);
 		if (r)
-			goto failure;
+			goto failure_remove_mfd;
 		break;
 	}
 	default:
@@ -443,7 +443,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
 		r = device_for_each_child(adev->acp.parent, &adev->acp.acp_genpd->gpd,
 					  acp_genpd_add_device);
 		if (r)
-			goto failure;
+			goto failure_remove_mfd;
 	}
 
 	/* Assert Soft reset of ACP */
@@ -461,7 +461,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
 		if (--count == 0) {
 			dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
 			r = -ETIMEDOUT;
-			goto failure;
+			goto failure_remove_mfd;
 		}
 		udelay(100);
 	}
@@ -479,7 +479,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
 		if (--count == 0) {
 			dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
 			r = -ETIMEDOUT;
-			goto failure;
+			goto failure_remove_mfd;
 		}
 		udelay(100);
 	}
@@ -489,6 +489,11 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
 	cgs_write_register(adev->acp.cgs_device, mmACP_SOFT_RESET, val);
 	return 0;
 
+failure_remove_mfd:
+	device_for_each_child(adev->acp.parent, NULL,
+			      acp_genpd_remove_device);
+	mfd_remove_devices(adev->acp.parent);
+
 failure:
 	kfree(adev->acp.i2s_pdata);
 	kfree(adev->acp.acp_res);
-- 
2.43.0

