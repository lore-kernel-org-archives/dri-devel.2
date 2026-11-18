Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5543E606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 10:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20260707.gappssmtp.com header.i=@tomeuvizoso-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gS2e7zG8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFF4410EB9D;
	Wed, 18 Nov 2026 10:19:42 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E73A10EB9D
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 10:19:36 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so5877645e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 02:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tomeuvizoso-net.20260707.gappssmtp.com; s=20260707; t=1794997174;
 x=1795601974; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NLaIVuRrItq/K8XGKB3939YkOngM/rpDK9AY6I9hNIg=;
 b=gS2e7zG81n384T/RF2psKTIqTAl3Gd7dCGC9hVj9wu+nUZJF+hKpkzaZA8wrKdMMh/
 GHEClLxj+qsvjc5zamE1AUdwiFKq/oNgR94Epw8r3nMRdJCIqjPGAQPICThDvOk7wGOg
 mw6BjJ5T56F85lR3JqW9Knhbba0QT4/qnUiNplNhr6s4f4+boLoDG/QS6NjdZuzASQdb
 4W2F3xt4cSksEMLLs9tuHnJOWeUFETbNQFcvKW3G2KttuatooL8cY0U9gRqfnLut+B5D
 c5fwF/Z+OGBscIHa128Dfk2N0BAyCAWpauuvrfwuk3BgfqCIYPne1AYL20PSBT/hJAdB
 KLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794997174; x=1795601974;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NLaIVuRrItq/K8XGKB3939YkOngM/rpDK9AY6I9hNIg=;
 b=acqOE+rgS0DNBYRc+ZUruakiS3Ox0JFAUV/itrFwMBWSkKN3ycRFzsrE6OxvUfnIxB
 12PTuMA5Wfbku81sPYjL7X5SOdRaNGxNSZOtnrVKIwWEMwDziDCTOcLdMc4dyI456idZ
 bnS0K1k2L21zQCrU/vXq3arhHY4DjveNPuNh2EEKMgc3LSNaWbfjO/2a1i1+DerDJCsN
 Biyfzw702+NfqaFOOdbpwmzjl+ui+IWxgKS/GGY6Rk02Ozjfi7qZ6cj0UZrHHhA8f7KX
 i89zGf5PHahwXrACvdkdsd0piqXjSg1YdECnRMzg/tV09mXk7+ECyvWKrv1m1GwUPgSt
 JC0g==
X-Forwarded-Encrypted: i=1;
 AL+hErFX5MkrSpjXKaMdNGn/JQhlKT4b6CvHlC6UauE80JYRHooQAr1m+U+1pgJRKRsxGgZKG4iILHJyeBw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9GSl9CfKxF5Gld1PL+9lLQKK3LCvCNO++OCjvBn9+8t0FMFfXH
 okq5nJ5y/iNc5/Nw1tzQvSRVA0QokRFkRjzAbRMhYlfjYuiimQIjS3SZAe7UZuhYAZs=
X-Gm-Gg: AYBFou3cWbxUH4PZgfUx2BoZhMMj5fFthxkVTGi40onivaJfVMyw8ymivVWGLObdSLt
 iWPCUcfwYZQ/bAxtrb6Nhg0bhigREtJsGRKN6NLaa9/TBAMLTuZFIV9fWYdrQkI6YdwYtCX5Egq
 vtz6h4FRGgU8HYkA7Rw/zLfE8H58ftB1JoM+FpHA1GzLO3yd+Lb4T4qGgtzX591s38buf/+VQku
 sflBMcIsnv1LCz6F8HtdMlpBhc5omF/1kBy/xlz/49cTiuqEnpP1LGDg00Xh0gWBLC6IWx2fi5G
 tK4p977LqidYmnjyx5DkYSQqk6cWysOzaIqeT/9BKt2qFqimhEooLqcO32oDfYSwMZbNmjd4XNe
 I7s14emlEAx69GuSyJ1WilBDpNQUnJMQsISC5kKLIiutltdbzdapwmnGHmlStog4WDDE7ihbT+m
 bu+E24cJaSjTQdNDBnO05lTMfS22x0w1DwG686G+FzEnyJ5xEfTtgb4Lo0jh3fSw7bmwpgVONQp
 PEXUCIdwPkixEbASh07cqaDbgDj0J4ffnvGe1gSBVi7p43JSOrNCR88ToA4Ot/EWSAOHQr/fNwu
 Q8Pc51RDN71IdBk2IglCsxacN6etp3GHIo93mD01OYcjs79x3/uH/0Y4gI/5ieeWx8LXgbQy7+b
 z4fG7OgDq46DbcDBtFP2BqvkaWh7bW1dI0lWGqyYefBQ+2nO5xw==
X-Received: by 2002:a05:600c:3ba3:b0:4bb:6991:2330 with SMTP id
 5b1f17b1804b1-4bb7da349efmr45418205e9.22.1794997174425; 
 Wed, 18 Nov 2026 02:19:34 -0800 (PST)
Received: from alcachofa.home (cst-prg-52-235.cust.vodafone.cz.
 [46.135.52.235]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb78430918sm118711585e9.13.2026.11.18.02.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 02:19:33 -0800 (PST)
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
To: Heiko Stuebner <heiko@sntech.de>, Oded Gabbay <ogabbay@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Triet Hoang <triet.hoang.dev@gmail.com>,
 Sidong Yang <sidong.yang@furiosa.ai>,
 Igor Paunovic <royalnet026@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] accel/rocket: Fix up sched array handling on open and close
Date: Wed, 18 Nov 2026 11:18:58 +0100
Message-ID: <20261118101901.253550-1-tomeu@tomeuvizoso.net>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Don't WARN when drm_sched_entity_init() fails in rocket_job_open().
It can return -ENOMEM, which is an allocation failure and not a
driver bug, so it doesn't deserve a stack trace.

Also free the scheduler array in rocket_job_close() only after the entity
has been destroyed, so that entity->sched_list never points to freed
memory.

Fixes: d341ef030f3c ("accel/rocket: Check allocations before use")
Fixes: 9bca2b5f1a4f ("accel/rocket: Keep scheduler allocation in rocket_file_priv")
Suggested-by: Sidong Yang <sidong.yang@furiosa.ai>
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Link: https://lore.kernel.org/all/20260826113538.42111-1-sidong.yang@furiosa.ai/
Link: https://lore.kernel.org/all/20260826113538.42111-2-sidong.yang@furiosa.ai/
---

This addresses a mistake I made when I missed the v6 of the
"accel/rocket: Fix allocation handling and scheduler array leak" series
and pushed v5 to drm-misc-fixes.

With these changes, both drm-misc-fixes and drm-misc-next contain the
same code in these functions and there should be no conflict when the
two are merged.

This is to apply to drm-misc-fixes only.

---
 drivers/accel/rocket/rocket_job.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 7b798a90bc49..454d465a39e3 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -572,7 +572,7 @@ int rocket_job_open(struct rocket_file_priv *rocket_priv)
 				    DRM_SCHED_PRIORITY_NORMAL,
 				    scheds,
 				    rdev->num_cores, NULL);
-	if (WARN_ON(ret))
+	if (ret)
 		kfree(scheds);
 	else
 		rocket_priv->scheds = scheds;
@@ -584,8 +584,8 @@ void rocket_job_close(struct rocket_file_priv *rocket_priv)
 {
 	struct drm_sched_entity *entity = &rocket_priv->sched_entity;
 
-	kfree(rocket_priv->scheds);
 	drm_sched_entity_destroy(entity);
+	kfree(rocket_priv->scheds);
 }
 
 int rocket_job_is_idle(struct rocket_core *core)

base-commit: f9fc6da01a290609428d308033143f1d96ab658f
-- 
2.54.0

