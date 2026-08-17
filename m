Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C76FC5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:37:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F9F10ED2F;
	Wed, 19 Aug 2026 06:37:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PVpAeSDU";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66AA110E3E5
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 09:31:47 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-38dcbade417so3125093a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 02:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786959107; x=1787563907; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mr+TqHpD4NfH87dyjxCAi72h/kE3hW+J/KRhRismO0I=;
 b=PVpAeSDULbrXF5UlKwuH3AZP+h2YFpA4qbOIUldZLGDOXNLyK8jR3Vcg4oEM8OUjM1
 by3nvBxc11ta+QMz87fN+kPcmYoIcYqtz72cVXkz3sxsBfv1klvs9uCYm/EedXktPXz8
 I7h6q9LlcgW98DuiX6RZZYk2pdEkonQWaivkK4eeRyT5t0PBIncA6wLLqTqUHnqdjxuF
 DLHB8UJZLVR/iXhXsG2tVDOXNVg1j80dF7+9MiVusQ3uPKbffYvAJJq2EPcGzqNqJbIu
 XwWJ5kXbVGFPdXaA4EIBly8/2U2Tml6XltGDUlipoDdF4kn7GN9iwbiRCPhpe7i8FUVi
 ZCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786959107; x=1787563907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mr+TqHpD4NfH87dyjxCAi72h/kE3hW+J/KRhRismO0I=;
 b=dy65eJTEyH8TS+4gpOUT6IN0trtjG/MUPOuo7bbajEWx4pDgUp1AWKnIUOrkja1w0H
 rcaSr94l34sBB81NJ9iYyMYFYDDY1l+RIH8e7ltQARPs5o13raQ80GVGi5r0w1UxpGUK
 ZmVDHN0lSwlXlx9QDN6womQdmK8APUb5WEGK8sA5NQQQvwptQvgmy4GDyWSM4gKMh6tz
 vq89Uf0Znuv176WuZZhyPzXzJWiTOKiiJ7/n9vii4xwHM7u3p68Mff2EwTemqz+U4Pzf
 lpZpVGvMhGo2oozcw5ZaX9CJq1Rh3ffopg2I68HYRvIwWfb36eREcnrzkl/ckSOyuQhY
 KYxw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFfpjNY+e1JcpTWqu89E2DsjRsS5LUVa0puZiXAgdm0RqfJW6oppZTaK5QPOSj/jzvLEKPpOPVn4g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwstF736PLzmiYI9dbl+e4eTVcBbuQV9reuLrVaQM8oY+s5wzoH
 tHmGZb+J9hQpDCz2+n3Td0dQ+4qqKg8bhIIHY776tJVF4CXKaoxN6yo=
X-Gm-Gg: AR+sD12gJ0zYTorhZpGHW722Pp94DgEw7dEYeQ1P0w1KOx5b5VT+yjl/Jcr19tA9c3N
 azF2CLAvtjZPfZHoO5z3rdDz+3TGFk7f7hIZzbM9LG2PjAzZpaqY4CkT9NCd5P3AJy5Nj1p+ubJ
 BE/pvJ0IaQzCUWtGwRdCg3SNrrMb9osKeHtCDve8oVe1LLN7WzSlNilfRZnQ9FRR97qQQBuJdLl
 YwLPjJ7slEeb2ha+VUHtFoLpAJBjogJyUfPkEBlpAgLRkfM2DS7dOMPgjrnb3Hvg8IZphis7B6y
 +AUnhN+5CFNQXoTnnSppMDRbKchapdQ7GGrFWN6yGHFuJtKavjCLuQeeQNgGioaupRN4PEgYacT
 x56lx6UtCHLXtEKi7eF14wfNlJdAiw9TMDqfZm0RNaR/gD2Cd/KmHO550YSAPgLydECe1H8tSol
 qpfX+qLMdEUyuVFz1KDuqT1Fr7QKw5H8Sx9W4eh7oN5rsw1+qxWOlPgY6JU7w=
X-Received: by 2002:a17:90b:38d2:b0:381:6c5:3f63 with SMTP id
 98e67ed59e1d1-3933b807a97mr22444654a91.6.1786959106729; 
 Mon, 17 Aug 2026 02:31:46 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3954d2e1a09sm1616832a91.7.2026.08.17.02.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 02:31:46 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: tomeu@tomeuvizoso.net
Cc: ogabbay@kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH v3] drm/rocket: Check allocations before use
Date: Mon, 17 Aug 2026 16:31:42 +0700
Message-ID: <20260817093142.975407-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <fbc4211c-d98b-458e-9dd6-3c3ec867df3a@web.de>
References: <fbc4211c-d98b-458e-9dd6-3c3ec867df3a@web.de>
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

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
Changes in v2:
- Free scheds when drm_sched_entity_init() fails.
- Initialize ret to 0.

Changes in v3:
- Move patch version descriptions below the '---' marker.

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

