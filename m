Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973E6C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:39:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35E7C10ED38;
	Wed, 19 Aug 2026 06:39:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aWGVOFZT";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFE5310E7DC
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:01:21 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2d530328efbso28942055ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786975281; x=1787580081; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4j17PyBNuLGfxl9FFlRnI48Qb6gT7KYiy30T6gTiVKA=;
 b=aWGVOFZTN2H869LkIdI6S7qSiSLhRc3SnNyA3CTEAdCmUyNX2/L61sWGaWPmXu7Yin
 VaYWWrEbwL3MwGE7TVbSty8OdA+l+yclDHMbnas8UTYiC9kuvnvF8rvwRGnxGFtt9LAs
 rmH+JC40jnuFA4dGMWT8kQ6aQnm05bwcqrSB2jGzBVT59H5Nofm+wLbPvcpYqwRYhqki
 VfIi8GQ/hrqZ6thD1CgJUZaia+SxHhwUxUCT0jm69v8VwGHGnz/z8oxoZpLhohVHQnY4
 k8iTwgBds6QvbuqIUZUAs8FvCmLdEJRr1Q4oD6oJqiZs/2cn08AiKf8KmoJONr2Qlglh
 Ib5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786975281; x=1787580081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4j17PyBNuLGfxl9FFlRnI48Qb6gT7KYiy30T6gTiVKA=;
 b=rqp7dgrPt1/XQxtHyZYwBTostBFmT8SI5w37TXYnCcpRm9TfTMv+zP8NsmmUBb7jgM
 6olc0ax/nODs+T/ItoQj2L5eH251Oz+LpuuUnfpSeoGPc0Dx0YYQ7W6WbGjqJ087fqyd
 mAhE7IZYdCHFrdMJ8a6behlHMhkKq2ecVhxuUppYAMMUSU1yyNfRqABCKCklvacQ1nU3
 kgl7rEFkRF4vKLPnHKLc1nTsB8ErHlBb05UzftoYG1Pv4N3RRVMrrvHshCPDm3LceICo
 noKPb2WIAKA1GcX/Nlbjq+VuUm8CZc0R6R4qUMc5SKibL2Cz1iiaV8KnmCgRiJknAT5k
 pTEA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpIDbcij0P/Myz2sJjOEKjTg7oE2KHPSXh5mjJQArWv+UGny8fu5k8+9fYKrUM0lburh1qV7VyIDQE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzC3Dl1VD5BOT0EpoKJIdKz8pE6Eqseeoj4+p0JXnmNtvfr3fb9
 1yFZhYWMJyl7uEzKUUsCHCM/ZKlaWre35/YZpu/Akh1azf/rF0K7r9k=
X-Gm-Gg: AR+sD13S3sCksZvQYo1AmTBAMKaphIOwLCLNbV0Zs3zentlLP2OAM2WZRwbpNYsPERU
 Ox0NT+2FZe7IlToAZGTFiBhbC4L28ucMMxgRjQrAJRf9kslMcdFPGsDuLfd/nA7IvPfVNZLOd0/
 gWACSR+0Mt+0trPKom6ZtInp1IMxaoOIIHsYx8ybhxAa4sgEWFcYNUf+ek+ePMy0hbovnb5oAnc
 8IiqMQCEVK2PXzt4IXEYfGqcJ/QT8Y/mIwqXwApsPFRmbQ2/m3pF7Nwu6Qm+rC1WTA32ho6GGme
 o1jCqXYftD8Xu5mdvpjwWbv/tQGob7Zf6PYAKU3yf2+5HRE6doBegkTJpUZQbdKa7V+TqP6s/YG
 l/iqtP3yQkD475qyad9LuFy6ajgtJwe7pMQeH5k8dYgLps/omB43Rr4/EpLWLcT3T+Y5fkKgCtK
 xB80Byu9P29PDn01RS6NG318QZHg6cNMQ5j688OPeu1ykQdTmfbjc5nIQTsYeDD+V6Ms+SHA+vD
 uZw+133MU4W3+Ib9vKj/6Ma2M38JD768JTRvjkQxWpyQ50D58cLrVaQlg22yPIm7ubwBdZkGA==
X-Received: by 2002:a17:903:3244:b0:2c9:e9db:8167 with SMTP id
 d9443c01a7336-2d5c4f3964amr6340695ad.7.1786975281367; 
 Mon, 17 Aug 2026 07:01:21 -0700 (PDT)
Received: from
 codespaces-2db70c.m2fxbej512jepnsor2itp05j3d.ix.internal.cloudapp.net
 ([207.46.224.82]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d5bb4dfe6dsm6364195ad.18.2026.08.17.07.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:01:21 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
X-Google-Original-From: Triet Hoang <89897892+HMTCT@users.noreply.github.com>
To: tomeu@tomeuvizoso.net
Cc: ogabbay@kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, royalnet026@gmail.com, Markus.Elfring@web.de,
 Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH v4 1/2] drm/rocket: Check allocations before use
Date: Mon, 17 Aug 2026 14:01:09 +0000
Message-ID: <20260817140110.148873-1-89897892+HMTCT@users.noreply.github.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817093009.22359-1-royalnet026@gmail.com>
References: <20260817093009.22359-1-royalnet026@gmail.com>
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

Check the result of kvmalloc_array() in rocket_job_push() and
kmalloc_objs() in rocket_job_open() before using the allocated
buffers.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
Changes in v2:
- Free scheds when drm_sched_entity_init() fails.
- Initialize ret to 0.

Changes in v3:
- Move patch version descriptions below the '---' marker.

Changes in v4:
- Remove unnecessary initialization of ret to 0.
- Adjust commit message word wrapping.
- Add Fixes tag.

 drivers/accel/rocket/rocket_job.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index ac51bff39833..adcc792541ec 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -192,6 +192,9 @@ static int rocket_job_push(struct rocket_job *job)
 
 	bos = kvmalloc_array(job->in_bo_count + job->out_bo_count, sizeof(void *),
 			     GFP_KERNEL);
+	if (!bos)
+		return -ENOMEM;
+
 	memcpy(bos, job->in_bos, job->in_bo_count * sizeof(void *));
 	memcpy(&bos[job->in_bo_count], job->out_bos, job->out_bo_count * sizeof(void *));
 
@@ -501,6 +504,9 @@ int rocket_job_open(struct rocket_file_priv *rocket_priv)
 	unsigned int core;
 	int ret;
 
+	if (!scheds)
+		return -ENOMEM;
+
 	for (core = 0; core < rdev->num_cores; core++)
 		scheds[core] = &rdev->cores[core].sched;
 
@@ -509,9 +515,9 @@ int rocket_job_open(struct rocket_file_priv *rocket_priv)
 				    scheds,
 				    rdev->num_cores, NULL);
 	if (WARN_ON(ret))
-		return ret;
+		kfree(scheds);
 
-	return 0;
+	return ret;
 }
 
 void rocket_job_close(struct rocket_file_priv *rocket_priv)
-- 
2.53.0

