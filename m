Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC3BC5DF8C
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1242F10E7F0;
	Wed, 19 Aug 2026 06:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V1SpfVxj";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41CCC10E7E6
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:03:13 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2d049069377so35710665ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786975393; x=1787580193; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=izcVO6R3v4+neqjC7EnHrbwsHX05E2W9qHGBbkC6pXk=;
 b=V1SpfVxj0FqE8KuI9bYtuCp+gsO43nnRGO9np10ehl+6ZnN6ANiWHhaBT5HroLQzU3
 arFQXmMnSx6tGbWTDBcmtuJS5IA+ouIvMTYLWqe3P/W17+64GNL8opYgAW1lr4cnNf9o
 wkBecrwE2mCZZgEyiUBMsvJFVbX1FLCSG0cL008Xx9XtwPTsF5U+46WkGkXaxToKm5fL
 n8zSczobsPwhgqDOVcpXnz/ouafb8ZiYha+0nBqwscV0KgVfJh7ulT4uw8HBE5aAaMa7
 FEk5CRJSfDe/n7nW0KBxCjIEZau8lYvg17+9lXZXzVJObm9IbOjHudfwh9h7ciD1sPw8
 EsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786975393; x=1787580193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=izcVO6R3v4+neqjC7EnHrbwsHX05E2W9qHGBbkC6pXk=;
 b=NX0ZZIUs7luWvlX+oRJzR0pEHyeTD+DSNWhS47/uXxvPE66a0XyVw+5eYRD8aVot6P
 uoCUTfnetjcaPlpehOCyoQcrYOisq1QoXo7VuepcZ/moIMUWSshEebPv3wx3SUIPlAuZ
 L7U3DBNe1d++F3c126qtRa61lzMjyDZ0KS3bcMu6i1MlBEQoquiQ4CnKKYxoVhRDp5SU
 XvZakPXAqzUM5/s8i1eU5v3fNHko9uXkBVhn0DP7Ee6N7RWxNMLrzY0RiFOAq8lEr6Kt
 HY5VVBcMNEpyuGonFamj1EiGqOqLzks+1oV5cI2ff+374OQ/eI1n3yrnE0HK1MI/DQvF
 /Hhw==
X-Forwarded-Encrypted: i=1;
 AHgh+RodTypTQtFcjNkuzB2isKm/gLsenxeAZZpXhUj21lxBHuk1LfPjDJmlpZV55cXK7ScgOjegCg4DOrs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjxwXkiYn3QWVmPgafwtUmjLghi1Z2/98zJ1BnHMm1ZbIQrHRm
 t8TybN4oL03SPzZpBSjoeyNoXH6+MdFhqmDenERw4CsMkj3HLnDuMcFgvlRSsbtLcVKAVaQ=
X-Gm-Gg: AR+sD10FuZwHaH+PJI7r+OKyP7i8yNcI2jUMlfSChVprI4mMHjHXwzkjtoMuK8A/1Os
 mSSWPQfjiBJQoLuK/yXouHd8LJWbIV/KnasrEDGZaBG/kPQ/yDE0SVujanMEXTSHsdm1MY4bn9Q
 wuKBcdXNSqFT3yEqdHpPszmLrv0w68MYXbdHg7S3eRIDcQ8uOGzHGq7H65cnhwG8Y4yhlqYiVn5
 aGbIsoeBYhs587F209P7aOgv2ByvjpzM1ElyS4dMUKFuY+p5gtNjo2g+SBjHXk4X46tbSP0Bh1t
 WE2GBHYMQ5Iha2r1J1pGOr+7GGd3B0t6odvZYelPtUW960UVwnD5K0/ALu6Wh7LmY6L+pw5THSP
 34EXSXYrBdPVgq9x2TVhAiYRkIEfBWk63tq/kkSGFPSLVLMeBBfERASRTIZarTzYPlsFgfNAaFM
 FkwyyZvy7oo2wYUXJYc4JfrwDDkY+nigZeIo0o4rD54YLlyMTT8UHO0mEllyAAupJ2lhSoVZBIh
 miBjn5gm9Es6kWeCcXjBYKJmqN8dQMNXQPgfJUE65onzv5iYOD4bm53BxpbikpdABuiH4wLw1tR
 Ij/3bWwY
X-Received: by 2002:a17:902:f68a:b0:2ca:eea:eb5c with SMTP id
 d9443c01a7336-2d3b0da664amr251108225ad.18.1786975392648; 
 Mon, 17 Aug 2026 07:03:12 -0700 (PDT)
Received: from
 codespaces-2db70c.m2fxbej512jepnsor2itp05j3d.ix.internal.cloudapp.net
 ([207.46.224.82]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d5bb4dfe6dsm6364195ad.18.2026.08.17.07.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:03:12 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
X-Google-Original-From: Triet Hoang <89897892+HMTCT@users.noreply.github.com>
To: tomeu@tomeuvizoso.net
Cc: ogabbay@kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, royalnet026@gmail.com, Markus.Elfring@web.de,
 Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH v4 2/2] drm/rocket: Keep scheduler allocation in
 rocket_file_priv
Date: Mon, 17 Aug 2026 14:01:10 +0000
Message-ID: <20260817140110.148873-2-89897892+HMTCT@users.noreply.github.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817140110.148873-1-89897892+HMTCT@users.noreply.github.com>
References: <20260817093009.22359-1-royalnet026@gmail.com>
 <20260817140110.148873-1-89897892+HMTCT@users.noreply.github.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

From: Triet Hoang <triet.hoang.dev@gmail.com>

Keep the scheduler allocation in rocket_file_priv
and free it unconditionally in rocket_job_close().

Suggested-by: Igor Paunovic <royalnet026@gmail.com>
Link: https://lore.kernel.org/all/20260817093009.22359-1-royalnet026@gmail.com/#t
Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/accel/rocket/rocket_drv.h | 1 +
 drivers/accel/rocket/rocket_job.c | 4 ++++
 2 files changed, 5 insertions(+)

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
index adcc792541ec..ff1d9e802024 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -514,8 +514,11 @@ int rocket_job_open(struct rocket_file_priv *rocket_priv)
 				    DRM_SCHED_PRIORITY_NORMAL,
 				    scheds,
 				    rdev->num_cores, NULL);
+
 	if (WARN_ON(ret))
 		kfree(scheds);
+	else
+		rocket_priv->scheds = scheds;
 
 	return ret;
 }
@@ -525,6 +528,7 @@ void rocket_job_close(struct rocket_file_priv *rocket_priv)
 	struct drm_sched_entity *entity = &rocket_priv->sched_entity;
 
 	kfree(entity->sched_list);
+	kfree(rocket_priv->scheds);
 	drm_sched_entity_destroy(entity);
 }
 
-- 
2.53.0

