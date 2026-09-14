Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62ECEC88E67
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 04:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C12F510E14F;
	Mon, 14 Sep 2026 04:57:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mT3vByJo";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FBBA10E14F
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 04:57:12 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-398e9698a70so2968213a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789361832; x=1789966632; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uCp8m2ue1HIu47SujiP2rZsKqNx/UJ3BDFl1VHtBYXI=;
 b=mT3vByJow/x/bw1uC/pOrbW4vk9twTLY+lmIODJOSH6YCiJnhVYCUOWGO1jYxuWIgb
 gw8KCbP4TkzXZNIOQEtzZjkRYWonBWgCXnhMT/5clgDn7yBAgZ9dSHBUFiOJ3WR6k/tr
 +oUBgCOAVdbMN/mn2wJH90XvpX1xDZeVZXRUO8QAWSN/kSUp6UkUCyF8hVOEpMB/oQQb
 NQRevhin7aZdZW7RJwDxYBliWb3JuvYK/0i0Shfh2+bMcpHjHq/005IhIooQQ2FH5YR1
 hXRtT3Si6g3OTwppWYhXGMZjhchhUsBSAmSg/GML9VnJOpmCe3p9f3KQZPo4bGV6Ebui
 qyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789361832; x=1789966632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uCp8m2ue1HIu47SujiP2rZsKqNx/UJ3BDFl1VHtBYXI=;
 b=L6/NzYD2EYE8uxEZyqndCFzVYBsW4XpB/9II1QN7bor+uRCGzGzyKR9CiHP1mAAm/7
 X4vWsnTsK+vpx/XAN5SKMdG1BbjK/lxZysd+s25IqseQyYdiINFjHpD/jIsLxVWUlma9
 N+xuz4kDWnq0jm/aFAv5y3dL4y0WWyIv2rG+ZsfjE62vS4lanDbwCIWepK7iCj1SHklL
 BRJ9L4uCe6OmJAWxU6+ya+g+Acn0f2Nax56qfdL9Q/ZFCjM2mogECVxtFDPEZnhdjzS/
 yvs+5abdCdu4Uup0tyZQIHF1HDLxUZNMbaDn6k6Y10QTxdSbtGwPbI8xO0dlYDkU4Zm1
 eb8w==
X-Gm-Message-State: AFuF++nYBjJSEOmh1IlbPm/yLU9ExH05UMhwu33mBz3yunu+mZxjLv2u
 EdC/YWMBl3SzjgcS7j7L+n52dunHQbzqNvCUXXWcDVQYb6szvwRYUok=
X-Gm-Gg: AYBFou1ahzH+Z0r8LG7Ufmnzvj2f2WARe/iQn1wAC4hDckOS2X9z30FIRnt4YjP8k7h
 16JVF7AHKUQkXu65NdTjWhfvDAYNWwiNs191yUfK/cUR8Ff7FDZ3Ph5zL6EixynAlZJb8Lzrl+d
 QUaNdp/OqBguso6RdLmwtJwKHZQR9xmRUx4xIDAFLs8sCPSUfnWTbX08++UoWK2w8uEV3WQ+7T0
 cJPMwxDJ6L9E770qHWU06lwOHfhFDe83898VZVQEJz09OoVl7zFe1yNcjBaWx7btY4QnHgd63ut
 4na3Iak1NuwurXoUXciOyYScTfpVs20k6t0lYTwFp45sXrsQfJeiwzHJmQL+KAPwqHFIeKssDzM
 s7bhvdcgu+LmDJ5SOccCNiP1+ZghMnQKlH8R28nwK+BJhjyb+8cq8g12W2WCjBxkriZIsDqCwzr
 dlTMDHxWTwH/oYoQnAHpEs1GJLFYwlTHIMnsCpM7m8UNxvcLcBBUzA7/oeSCua92TipNoGfK4Qg
 wuj545VNzsVkw==
X-Received: by 2002:a17:90b:1d05:b0:398:9bd1:3210 with SMTP id
 98e67ed59e1d1-39dec0bdc55mr2456899a91.17.1789361831544; 
 Sun, 13 Sep 2026 21:57:11 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d994872e0sm18824792a91.8.2026.09.13.21.57.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 21:57:11 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: sidong.yang@furiosa.ai,
	royalnet026@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ogabbay@kernel.org, tomeu@tomeuvizoso.net, triet.hoang.dev@gmail.com
Subject: [PATCH v6 2/2] drm/rocket: Keep scheduler allocation in
 rocket_file_priv
Date: Mon, 14 Sep 2026 11:56:05 +0700
Message-ID: <20260914045605.381933-3-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914045605.381933-1-triet.hoang.dev@gmail.com>
References: <20260914045605.381933-1-triet.hoang.dev@gmail.com>
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

The scheduler array passed to drm_sched_entity_init() is retained by the
entity when the device has multiple cores. drm_sched_entity_init() stores 
the list conditionally:

	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;

With one scheduler, it keeps only entity->rq and drops the array pointer
while rocket_job_open() allows its local copy to go out of scope. So
for num_cores == 1 the kfree() in rocket_job_close() is a kfree(NULL)
and the array leaks unreachably. For num_cores > 1 there is no leak,
which is why this is invisible in normal use on RK3588.

Keep the allocation in rocket_file_priv so rocket_job_close() can destroy
the entity before freeing the array. Free the array directly if entity
initialization fails, since rocket_job_open() does not call
rocket_job_close() on that error path.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")

Suggested-by: Igor Paunovic <royalnet026@gmail.com>
Link: https://lore.kernel.org/all/20260817093009.22359-1-royalnet026@gmail.com/
Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com>
Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
---
Changes in v5:
- Free rocket_priv->scheds instead of entity->sched_list in rocket_job_close().

Changes in v6:
- Add Tested-by and Fixes tags.
- Move kfree() below the drm_sched_entity_destroy() call in rocket_job_close().
- Update commit message to explain why the scheduler array must outlive the scheduler entity.
---
 drivers/accel/rocket/rocket_drv.h | 1 +
 drivers/accel/rocket/rocket_job.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/rocket/rocket_drv.h b/drivers/accel/rocket/rocket_drv.h
index 2c673bb99ccc..9421e48ec5d8 100644
--- a/drivers/accel/rocket/rocket_drv.h
+++ b/drivers/accel/rocket/rocket_drv.h
@@ -23,6 +23,7 @@ struct rocket_file_priv {
 	struct drm_mm mm;
 	struct mutex mm_lock;
 
+	struct drm_gpu_scheduler **scheds;
 	struct drm_sched_entity sched_entity;
 };
 
diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 704a15513179..f27e6264f91d 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -528,6 +528,8 @@ int rocket_job_open(struct rocket_file_priv *rocket_priv)
 				    rdev->num_cores, NULL);
 	if (ret)
 		kfree(scheds);
+	else
+		rocket_priv->scheds = scheds;
 
 	return ret;
 }
@@ -536,8 +538,8 @@ void rocket_job_close(struct rocket_file_priv *rocket_priv)
 {
 	struct drm_sched_entity *entity = &rocket_priv->sched_entity;
 
-	kfree(entity->sched_list);
 	drm_sched_entity_destroy(entity);
+	kfree(rocket_priv->scheds);
 }
 
 int rocket_job_is_idle(struct rocket_core *core)
-- 
2.53.0

