Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D09606A326
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hxM+cKln
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06CA010F30B;
	Tue, 24 Nov 2026 08:39:46 +0000 (UTC)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 062C410EFBF
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 17:55:31 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1a2761c69fbso2644930c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 09:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795456530; x=1796061330; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5zbntsnJYF+MluAOcW87nvuR13e90ScUCD9/dIZ65Hg=;
 b=hxM+cKlnIJXfyto1bW91Iw2f8DPvHroG0h7WfHGcz1DCxjNVNXlcFozOKwU02Fze3c
 n2Uj4ee65qjjNV+yLKf8+DLSs75dBdK70kuEE0fWbhmkyCJcR/KcAfPzBjPakcQe9kib
 WkTwh1fLnaqZSvD8UU5LHdK10zdHpif7bD4ot3zNX/f0sSmAL4HnHySDFJHxCM0zehUF
 tbOnoBJ3frVzmd5D2YXgci1PQ8DOSWgRg4isjpTdwIcrtw/4GNYrCRftKkoh7uNJlTZx
 /RgxQcSEVquFH0fauJJVw/q5K1S71HIdwjLKdOY1ZImq1CUpZC6rY6A7l7EuuHeDEmcY
 bCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795456530; x=1796061330;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5zbntsnJYF+MluAOcW87nvuR13e90ScUCD9/dIZ65Hg=;
 b=1fw/ePvbxUhwpbBJJYXeNepSIqFe7kzHznNTAeZt5GJkivQHFpWAyw2faEpw6S47/N
 kTqzFSDU+KfUyAdv3zkHFJIYknHyC9S9cBjUZdNdsIJhneUIVXBmflxrZrFxRrNBO6XF
 y99yfaSe+Yx9YZnbkoorDGBemQiRcR1VHTwPdlTTAQFhkPK4picY8cCneAqObyl3o/1B
 yCvs89DLk3Dd6kGhHU9JfqkPLpCcHSr+nw71w1pEKOkV8U/E0DLM0gYPURZ5sru5pBxu
 JgIf+IgNKQ8LHIT8B447pXQa80t0COCR1XDmMqzsqDnz3Vh10d9Z5TrcpqNqaRUFQ+e8
 0FrA==
X-Forwarded-Encrypted: i=1;
 AL+hErHkBPzsI+oh3J3mNN2mrN95OTMu+cvsd4s7ogLpYvznUr0go4oMYrziBuGSML7lW3Uk/c5JAtTEcd0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9U3yLAEaE81bo9pW4wHdtJ854B17xKH9y0zVDliCd77+B4VXpW
 DkS9zJ5diB9aDPlAZcXLhvtTmwk958HX7ToAh1U/KH/7uWhe76nY+5eH
X-Gm-Gg: AZFdTZfAC2NYdg8bEJUOFkcWGT2JnznnxbxfsK7YWysfp209FpiH6MhdNZA1sV9jpPJ
 BUxRwZqYGWxEoDW0q07JsL9n0zTy/MeT+OyMFzog4O+A46EFURIDRTGvLKtNz/AGzgMA0snlwsT
 YAUwDqzhghTyywRwgcDBf9u8/zPixdKtuDG8B1macuU8LUZ27MwGQIIaXX313kTgeCnwOiS6jkL
 y10HPbLK8h3F5Z/Yi3Bi81NNUkcUuAQMsH1q0UT1sucl62DZuOu2l0we6lU8u3uTQImCeZwvGAv
 1XTHJqYhxu8NxmUrKcx5Y7/4jXKgkyxniNOTDkY9+uCtP4T4egFURtycilS5Jjoh5o8BobAhhau
 QwNUW9asEDrV0cl9nQ2zdmbims6JRgexrJcEB/R7DLdoV7n9VWKogGRKfDq61O9MkmO3oGQq1gm
 Lw1Hv4Q4D0lPUxVSfAfwpU1aMD+uRS0LXaSxtkhc9OJZnhosF849PJh+tc/RWFoTYMjaAC1yC3M
 8Ga9sMJyM6ijAmDlpWdRWG2ubgp0lWAl49OoshV6dwv/zSuKPDbJ0APSFsh/GO1jJekwDq69aP1
 s9EsddGdJXXo/AZldeIQg0GJ6HAUhjm2OH4Iaa2KuT1HaiewxFEOnw==
X-Received: by 2002:a05:701b:4584:b0:1ac:9da7:e86e with SMTP id
 a92af1059eb24-1b556908c17mr12515895c88.30.1795456528961; 
 Mon, 23 Nov 2026 09:55:28 -0800 (PST)
Received: from ubuntu ([110.9.142.4]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b562a82b3fsm30885828c88.5.2026.11.23.09.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 09:55:28 -0800 (PST)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, Bokun Zhang <Bokun.Zhang@amd.com>,
 dri-devel@lists.freedesktop.org, Monk Liu <monk.liu@amd.com>
Subject: [PATCH] drm/amdgpu: fix wrong unit of vf2pf_work delay
Date: Tue, 24 Nov 2026 02:55:12 +0900
Message-ID: <20261123175513.2144018-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:39:44 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The delay of schedule_delayed_work() is in jiffies. But
amdgpu_virt_update_vf2pf_work_item() reschedules vf2pf_work with
vf2pf_update_interval_ms without converting it, so the interval is in
milliseconds only if HZ is 1000.

So use msecs_to_jiffies() when rescheduling.

Fixes: 519b8b76f0b6 ("drm/amdgpu: Implement new guest side VF2PF message transaction (v2)")
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
I don't have a test environment, so this patch is compile tested only.

 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 915e2a069baf..f93d5df51528 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -797,7 +797,8 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
 	amdgpu_virt_write_vf2pf_data(adev);
 
 out:
-	schedule_delayed_work(&(adev->virt.vf2pf_work), adev->virt.vf2pf_update_interval_ms);
+	schedule_delayed_work(&(adev->virt.vf2pf_work),
+			      msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
 }
 
 static int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev, uint32_t *pfvf_data)

base-commit: 8dd68a79583aaf6df6fe4feea3ee9e9f26b02993
-- 
2.53.0

