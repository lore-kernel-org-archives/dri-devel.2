Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA79DC5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 06:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91C1C10E665;
	Mon, 17 Aug 2026 06:55:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UgFwW+gQ";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 759DA10E640
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 05:39:54 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-84874b52eabso3992370b3a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 22:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786945194; x=1787549994; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zy/ytYehsZsoTcb2/AmoaL5OkR/LozuHPUZF+r1PLNA=;
 b=UgFwW+gQDBBLd0botwRfqbNDEu3///u7OXic9zKpie5zJEfyY5c6X94JH1FlyuF0Wj
 Q3sw6Q3EfLtbctr3zCS1vaijqMSXoLtT+RO245r4ML33aZb3YOP9562X+3dACbFO1IdF
 DZl5TEUjpJWKmr9z/UjAHmL4+xR21m0S9tO9+GfpapQMjcgmLFJx66sgFuuRQD57P+r5
 PEbtac1UBBF1Sb62cPv0SvvvFyfMY/ASINSajsc1z95rJX8rIoq1VelwQ5+oj57U1Xwi
 7SNNqXz3oo2+1cNZdSJcUdE2AuFi6tI+wioZY0LpvoclaBo61/eYEOaDT+zA6YDSqS8k
 5gNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786945194; x=1787549994;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zy/ytYehsZsoTcb2/AmoaL5OkR/LozuHPUZF+r1PLNA=;
 b=aa1j1RT/NbfkVhR0V0KR120b07eZCfPJrlILQtfjXJ/LOHJv1OsxcEgJqg2PeoOYXd
 eRDqNEFziOTFytxLXCHvqRL1whJ9lfOE2cNTjZf9gzhNcQ+BIcqVOmVYywiT/BAFQ99L
 pgkS1je9yBYZxwIje+oSflVtFSV6IcDx35JLQkiGGUBjvq9oMaqNKAS7Sd/eTtknlg0a
 usHIcePXBHRONGtVeeJMl5Dr2dg3pa8BjYOLj4mUbqoxdUbsNI1YPUFitq6D3tMGrdRQ
 698XLbJIB9YSc2OMgYVuAbUCho4cBVGpESTKzXvGOQa4cPOsq+QY+kyephOYu4T00R23
 jk9g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqvhjYlkGXqueaec5waw3ekYmB6kN+6PeCgkyB8O02Vr17/Ricz30ZPZA72pN84gS4JoTUToae+ECY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxpEfA4Wt1GkDdvJqDCKT2f7aMiwo7ygHLxatuRwCdp8WoKLvKl
 P9NRolOtwTQD1zTd8ddZH8UKrVgKBRbUxRv8cFbtqffVIcnNFtNbQ7+HcO6nQwDquaa1
X-Gm-Gg: AR+sD12m3vPfPeUUKGPqAZQKlB7MFr+Ov/EPFJ2NPJRbbpvcH+m81ZOgMuEZjZppFux
 fpmrLJ29AiSJCW5eLpNUZGgY6qvQ2UvSo99dSf0pC8uttGGY/uOWrDChYPzs9a43XqpeMiZiSCl
 zPgMvenq1m9S2vX4lDiNCo1iAdSaSsvbGZBEWOA9WGtBMQK7QXf5wyBTNXj3PASZUY/B20UhWn5
 iY8ELccGwtg9y8zQyBo0E00JhICCuJnZUoPLaluW/Ds6Rc1AI0176EZlIx1DAgy5PbPdtbbIPVF
 TbFtEidw7pfbsJtrigsY72SBRVkzxiNYKhcQNqM6XZGTKWQzwkN+srpfL7nkqqUHfudctJGZsTP
 3CqNRye2GQMoDHIvG+4dA3NjWJ6rFmlowPCBLnquE+zW2/mzu2kgnME/N1gdyl9xzOZm8KYbT8g
 EKE3CRfE5pQBG8Mg4h5lwlEex975cz5Nsaz7jMpz/r4uVbXDKwHC1JbzSi/GA=
X-Received: by 2002:a05:6a00:1490:b0:846:1698:638b with SMTP id
 d2e1a72fcca58-84fde2644d3mr18420435b3a.27.1786945193977; 
 Sun, 16 Aug 2026 22:39:53 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8517d223f1bsm2273786b3a.38.2026.08.16.22.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 22:39:53 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: tomeu@tomeuvizoso.net
Cc: ogabbay@kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] drm/rocket: Check allocations before use
Date: Mon, 17 Aug 2026 12:39:49 +0700
Message-ID: <20260817053949.819142-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Aug 2026 06:55:17 +0000
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
 drivers/accel/rocket/rocket_job.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index ac51bff39833..2fee21988d27 100644
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
 
-- 
2.53.0

