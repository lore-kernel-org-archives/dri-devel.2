Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AFFC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:37:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 741C910ED22;
	Wed, 19 Aug 2026 06:37:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d/snSKPs";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52D4010E9D4
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 04:15:13 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so4325307a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 21:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787026513; x=1787631313; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fupa+fHZK0GWdNE5zNzfh7AYYl8icRGNF60UcTuU8jw=;
 b=d/snSKPsP7jvs+8BgjwX2QnV2MqnOyzzT1806iXlonohTPRbPiiQrXkFaq3ZX/by5E
 PKUf0nsuP6Xjba/XJ5tP6cz4yCzIsSCfv5FkkbRDsnemnSNiSkt30HLMnAVDLppH59Op
 AnfR8tGuhmKhKrTSXzrqjBLti20FVqmSAw+/NHFgERB10CMGHJG+ZAtYMFuq/rmSOywg
 9Ml7BTCr2lUOV0qWbYC/XgFc6Xb7sCLnj5RYZ4myn/nK/ItM+3JmCAZxeClGd7U5alAZ
 3tfYVShMORlnN1PG2bwWzFJeooiBYHYgkYLvBUWtY4MaFJwiCWJLB95HkjTvjed9J6RE
 maCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787026513; x=1787631313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Fupa+fHZK0GWdNE5zNzfh7AYYl8icRGNF60UcTuU8jw=;
 b=UVKEXc8KIJ07J0RcGecs15Pr0yPEyGPme+byiDIpnTDP6oNIJO0dyGOr71IMbLMI1X
 tNiPBLvkSz9qNABaZx0cH3geoDJO2UsJ5JeRHDoKIL/QCvbC2+DmffBZqLrGwAITOgat
 UNHpD9cYIMKpKE/ZtCy3Mnya3qJRHM33ELCdI4OxM0BGHQS2WwAxS+DkoNSa+4JFPBVR
 wvNH3qCvFcnPsKUSXSRBtPS9BVGQOUQrkkL4Ac8B0ayNb+9V3gD5eh0QNvcKgKJBEKAA
 uQqWn4NC5SlMIBJAIgOK8tmS2eUay+j03HcG3oEmRL8aHpgXBN5SU1sW6Z/8Jvtd4mf0
 6oxw==
X-Gm-Message-State: AOJu0Yw6BBhXDDxATdOQIBXOlL9vensQ3/qkf9OQr0TmGP8YfFqK705z
 Cf0Z6KQl6o0d3mNh9A2gPARvxYjr1Pd6ZJf2o+ZbDn7EwilXnCNMVn4=
X-Gm-Gg: AR+sD10LNMCYCDzr0+6kBNWKXNMV95MXSsA8aaJnsiMpkesEdimMRfA4mvmEyd3DEgl
 QVRuikT4KOveaSjX2xAq3ExJrCreJEErOT7/5RkrFyQwdwZHrPZhJJe4EOl+ijYSDTM3NtgixBX
 7SoPTBVHmMJRGSINm0yhClQ9X+bexVyCMv6PRK5hLC0FxWh/IyeZ/c3M2kIMEIf7IetFDFi+378
 LgZDjUyf00MnFKIMjXsG2kXrZhZjCCmunJ8qW/HNm6ZYku+1z7InO++9ehLuWDj/XwRbzAZ9bI3
 SaGR4+3qk9L2O6wGgwPLBHSM8W0C0sHVnqnXYwJ6nRYqUPh0mu8xB7h+VRhSGO5ylZCxU6Ld9uu
 beCr+eOuOe8Vw3U6cvLXdFFZcfqG04fUNo5A/q/CEUdWDT4hgu1JAIw2l9OJ7xk2LcV8MMtPcFC
 Jz953/0FtpBl/uWRigZogRtRYDKAKRNYFNUAUb8kCXm3nH9T3rgdL+/q0LS97c
X-Received: by 2002:a17:90b:39b0:b0:385:393e:7124 with SMTP id
 98e67ed59e1d1-3933e60f9d4mr29110763a91.14.1787026512604; 
 Mon, 17 Aug 2026 21:15:12 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39531e84244sm7206458a91.6.2026.08.17.21.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 21:15:12 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: royalnet026@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ogabbay@kernel.org, tomeu@tomeuvizoso.net, triet.hoang.dev@gmail.com,
 markus.elfring@web.de
Subject: [PATCH v5 1/2] drm/rocket: Check allocations before use
Date: Tue, 18 Aug 2026 11:15:04 +0700
Message-ID: <20260818041505.1579320-1-triet.hoang.dev@gmail.com>
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

Changes in v5:
- Add check overflow before kvmalloc_array() in rocket_job_push().
---
 drivers/accel/rocket/rocket_job.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index ac51bff39833..15e93c355c38 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -189,9 +189,15 @@ static int rocket_job_push(struct rocket_job *job)
 	struct drm_gem_object **bos;
 	struct ww_acquire_ctx acquire_ctx;
 	int ret = 0;
+	size_t bos_count;
+
+	if (check_add_overflow(job->in_bo_count, job->out_bo_count, &bos_count))
+		return -EOVERFLOW;
+
+	bos = kvmalloc_array(bos_count, sizeof(void *), GFP_KERNEL);
+	if (!bos)
+		return -ENOMEM;
 
-	bos = kvmalloc_array(job->in_bo_count + job->out_bo_count, sizeof(void *),
-			     GFP_KERNEL);
 	memcpy(bos, job->in_bos, job->in_bo_count * sizeof(void *));
 	memcpy(&bos[job->in_bo_count], job->out_bos, job->out_bo_count * sizeof(void *));
 
@@ -501,6 +507,9 @@ int rocket_job_open(struct rocket_file_priv *rocket_priv)
 	unsigned int core;
 	int ret;
 
+	if (!scheds)
+		return -ENOMEM;
+
 	for (core = 0; core < rdev->num_cores; core++)
 		scheds[core] = &rdev->cores[core].sched;
 
@@ -509,9 +518,9 @@ int rocket_job_open(struct rocket_file_priv *rocket_priv)
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

