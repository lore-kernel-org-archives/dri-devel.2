Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D80C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:36:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AA1710E607;
	Wed, 19 Aug 2026 06:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FxkTTply";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0394810E3CB
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:20:54 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-84e0688b859so204193b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 00:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786951253; x=1787556053; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jtd38hsH3dGNiUrGGPtNYK9qHwfFDcPb/sf8PmxKYhs=;
 b=FxkTTply5ggq0xuVdVcHGwhMMlKNdKRv91TWzesC+HMALFfocLRYIUN/IWoV3SFbjB
 juVhJ1mUAf6hReJNcRoYGq7DGO3aVuykgWsiRHMgbXwltqeulSvlqperZm9Bct6boyAs
 E7oyMO1oKPiQcRVtUZjys8I7C3nHfk7dAjwErpsbxoXmr5cm6TVLRB94bVd7tYcC/75F
 +HFIZeVgmZ6weMU2zNaLk6ep/0KcmOBUOxZcYA4UEPVqoBjUlsj0cvhe5K80LVrXXVz2
 ZAo8jKckBDk39f6OjpetmtN3ZQ0iILdVI2zwes/s3qV63eZEbkMrA3HXEmrELokYIUoF
 +iIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786951253; x=1787556053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jtd38hsH3dGNiUrGGPtNYK9qHwfFDcPb/sf8PmxKYhs=;
 b=p9fPfuxf6BSgQKmSWbWDnX+mdHqO/wy6RNufVMhgIczEWl55Rqylo6JxOx21BEqzTA
 qgUBHwCngB/EciuivOngd3WubmcPooxSiQiR0c4wJhMLpvO97sr664HYOb1jRP2JpoBF
 xyNhOjBwLWCW9qlv4hT/fsivSXx3UkxHErK4e7jDkH+xWvJW1DmgnxWPDK7j+w9AjrqG
 9DgEVhDGtBCniKIoDu0NJPYY+dzAkYx36ucHkePcFzC3YBtmrhFr4ks5zrqeJx5UfNAG
 6q2c40CNaEVOmJUAXOryoAr5jS05zcdQZpyRB7JZlFyMop4EHNBN6DJPlYEixZbheI8F
 EV/g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrpLpIFj+0MMCKY9VNcPrG1L5u94Dk2ryLwI6XyQbtME9xmVZHeFTeK3KOuYjbOfTb5RYHy50cBiQY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx2ptTLBUTEQHSYOZ+zO8BfPOaEKdqk8XnST0R2N/8V737hBN29
 CSJyS4ytlrrOqee7rfs6k1fbF8NK+A6GylLokjb7sEJ1OjEn105Hhy75qN5XeQlR7rpq
X-Gm-Gg: AR+sD13Ec5lHyhyIQ60kLxaTxN8xlpJkAsXQPYbidRDCbNlRmk8cig2srgHKrNoAMPA
 agLTEZq5s/cIYqxLE//ZWvbuEAMBtkP23/MVb0NPtakWmHPF2huCzemvxeK8pEjz5CcHoOp6/0b
 Ca79w+V2bXUAGnvaEKuw/uXmVhZO2rpmnUblmGTUjoPRpgJK/OvzJ6dqlJlJo4i6DA/mICK+m17
 PROJP0UKZjal0it3f9ixVnFeszxFIyfWu+Io37GIT7H8hHprtbQLnDlG3W5IDTphNbq0Us9gwN3
 e7XQNvyTpLyDmGtvXKv2B6ug2EZ85MucUdlK6givMLv9L7E6ZbPv9r8uxQadPWItDggwUgwElVU
 /jchSo299qQFKuauS1IxL5q2FbIuCIY/kgL7zhL7wRHDMn9G6TiAIQnG+x0+2dyHZ9cZb24cAv+
 t2yO7f5jQZIHNgTJMxiZ4zLBiytjzM/5MsZiCsJ2yovZ3/dge8zSggfF8+5pY=
X-Received: by 2002:a05:6a00:2383:b0:84e:89a:b8ec with SMTP id
 d2e1a72fcca58-84fde3d4d3emr20738437b3a.11.1786951253271; 
 Mon, 17 Aug 2026 00:20:53 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc13bf02fbcsm284780a12.3.2026.08.17.00.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 00:20:52 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: tomeu@tomeuvizoso.net
Cc: ogabbay@kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH v2] drm/rocket: Check allocations before use
Date: Mon, 17 Aug 2026 14:20:45 +0700
Message-ID: <20260817072045.876042-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817055315.C9AA41F000E9@smtp.kernel.org>
References: <20260817055315.C9AA41F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:31 +0000
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

Check the result of kvmalloc_array() in rocket_job_push() and
kmalloc_objs() in rocket_job_open() before using
the allocated buffer.

Changes in v2:
- Free scheds when drm_sched_entity_init() fails.
- Initialize ret to 0.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/accel/rocket/rocket_job.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index ac51bff39833..24e1a61f71e7 100644
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
 
@@ -499,7 +502,10 @@ int rocket_job_open(struct rocket_file_priv *rocket_priv)
 	struct drm_gpu_scheduler **scheds = kmalloc_objs(*scheds,
 							 rdev->num_cores);
 	unsigned int core;
-	int ret;
+	int ret = 0;
+
+	if (!scheds)
+		return -ENOMEM;
 
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

