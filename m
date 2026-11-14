Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC742606A330
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uDsqkpaJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66E7210F003;
	Sat, 14 Nov 2026 16:24:54 +0000 (UTC)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 554F610E22C
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 08:20:29 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-1397a4855beso51832c88.2
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 00:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794644428; x=1795249228; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SqXDyJrLwFkhi21RssicBQAdX6l60Qls8EPKvWmfnzg=;
 b=uDsqkpaJLd4J7zXwPPSi+bRLbXGpPZcylDt4/XoKaMtD9hG4Ty310eCNTLo5RHgqMZ
 EJQpSyikLwWyGiA9Z2wtfLgpIT7eZh87ut9hDs8mvdGIciCERHP6FcLWQUkRa5UDvMuL
 R77RZtTfE+kDBf84oSiV7eVYraeyiG6TBv39Nd/iTi9kTDTA8leQkQ4i+pxMw5K6Q015
 L1lQKACbi+FEHK0n6yewwvXRtaLJwhHolr0H2Lzbqn4MebayAyxUQVtDhXHEEPIXx6ip
 bnWdKmeFHCqRNhJJS0607QmwB/pxaX4vC+nUGLMImo+bjo0MiAj2aeCKSNsBbKgEB7MM
 87lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794644428; x=1795249228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SqXDyJrLwFkhi21RssicBQAdX6l60Qls8EPKvWmfnzg=;
 b=Onp7dzup/Y3Sg9b2FWEsWQDWCA9IzrUBORv+5gTv5jcT3fNVO4mpjqx/5O3iWU98Rl
 xnvhl1E4dIZyXMQRc/QLRTnIUyaYnpN7utqNC7QmkbEXpNeXRiTwcWdJ+cJeI73TSXUl
 OB72/0uV9EF406t5gYXmmGzpIuJITcal9R5WkU0t6SFUsKcf4Wi+zFtzcJTgaIyXAAVc
 Of8gR4yNPI6sdAfyaowT4d3xhXgBVLxV4yLmhccOJVE0rtFwA058FscERQUcV/qUcvlh
 CzkvzcOlXlqdalAdr5ec62e/i2rZD2GYjZDyN/8s0uz+MhMbgi/eAND6V/ZGHiWMOhTZ
 cNRg==
X-Forwarded-Encrypted: i=1;
 AL+hErEE4I/PmYaykOVJcA/JL5ZilxV8zIjVlGZaasfzONhTMjD1mPnYRYVmCu+FMX5O3s8qzt6deGFrs0A=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+dFZRl7IGyHBSKIh/eiVGycB6UFt6WNcS3cZxyTzB5h+km+QuV
 gXlOwY/zbFwyA5KEluxaJXebruaODzKcHGb4F8bGU5yk3kH5qmi07TDD
X-Gm-Gg: AYBFou0gBzol5I98XhGugAG7Pvgs2uFbK6/hyCGaLpXvwEEhCYe7ndn1tjMJxky0VWq
 BW/8994kdu40yHrvtizoZIpBvbpRAjnXr0vuP/Lv5tCTZqAPRrSSphRHgB1dHrmC/nX/S96WW2I
 eM1fvkDSE/d8pgAswOG9l5ntZeQPi5FIYwnH/HmZTs+Udgc0squ49nw7gBtS5FEzklvdYYacb4u
 ltIbA3Es2Y0Q8+y62VpT8EKrPRX8633cQ9PF/KOWg75xMjNWJneRgxL+qrZ27YVhpHLyB8g3Maa
 wuF1LkaDcwxEP4Ogkbdh7NDtu9FmYmh7XdfqoKvlEsG322MiF5HJo/Mw2vmAPuPf4EN3O8ec67k
 LTsC4ppzkJCdmxsTqRIUi/3Dq06vNKTmb+2ivxCRIMt1umH0RKWDbhdTDAhjO8JKDyIoHQgIxWa
 4IDuz6+lkQqe5Ih/7o//1sK6oWqnkLD1uVwWiN3V6OBvN9lXuM5EeeCt1ySyiEtlidwv4ppkLhM
 LFoaBdp5Z+0IgZ2dH7R2P+Z/y+fe+mQerJHZynBUPS9JZVMa5//h4Try+RW9T51GfEssVX4Bksb
 jpWNPypZBRUTJGTtfhkzd4QLnrD6KSi9jHLacgKSGXIXHiXP4eXtaFyvBcl066M4HCQbN/VSCk3
 fboU=
X-Received: by 2002:a05:701b:290a:b0:127:def:dd72 with SMTP id
 a92af1059eb24-1b5030f8a7dmr6472366c88.2.1794644428430; 
 Sat, 14 Nov 2026 00:20:28 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031918c7sm19524043c88.9.2026.11.14.00.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 00:20:27 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 1/4] drm/panfrost: Hold a reference to the MMU context of a
 job
Date: Sat, 14 Nov 2026 17:20:13 +0900
Message-ID: <20261114082016.2454-2-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114082016.2454-1-arpe1618@gmail.com>
References: <20261114082016.2454-1-arpe1618@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A job stores the MMU context of its file in job->mmu without taking a
reference to it. Once the file is closed, the context is only kept
alive by the BO mappings that still reference it, and a job may be
submitted with no BOs at all.

When the file is closed while such a job is still running,
panfrost_jm_close() does not wait for the job, and panfrost_postclose()
then drops the file's reference to the context, which frees it unless
BO mappings of other jobs still hold it. The job interrupt handling
that follows calls panfrost_mmu_as_put() on the freed job->mmu, and
panfrost_core_dump() also reads job->mmu if the job times out.

Take a reference to the MMU context when the job is created and drop
it when the job is cleaned up.

This was found with an AI coding assistant, which also drafted this
patch and its changelog. It has not been reproduced, and the change
has only been compile-tested.

Fixes: 6e516faf0431 ("drm/panfrost: Job should reference MMU not file_priv")
Cc: stable@vger.kernel.org
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 2 +-
 drivers/gpu/drm/panfrost/panfrost_job.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 7c348a0bf1ee..afda794e2aeb 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -331,7 +331,7 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
 	job->jc = args->jc;
 	job->requirements = args->requirements;
 	job->flush_id = panfrost_gpu_get_latest_flush_id(pfdev);
-	job->mmu = file_priv->mmu;
+	job->mmu = panfrost_mmu_ctx_get(file_priv->mmu);
 	job->ctx = panfrost_jm_ctx_get(jm_ctx);
 	job->engine_usage = &file_priv->engine_usage;
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 4ddf4b722ddf..7022b1b2e020 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -377,6 +377,7 @@ static void panfrost_job_cleanup(struct kref *ref)
 		kvfree(job->bos);
 	}
 
+	panfrost_mmu_ctx_put(job->mmu);
 	panfrost_jm_ctx_put(job->ctx);
 	kfree(job);
 }
-- 
2.43.0

