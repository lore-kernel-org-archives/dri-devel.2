Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8E7606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w4MYEZIV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6418410F02C;
	Sat, 14 Nov 2026 16:25:07 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 706741126B6
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:29:44 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-376a4059061so130328eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794587384; x=1795192184; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Me8wiQ0HJEeNW8ibwQsvd7QQqaIgXxWtjrcDHkoHDvM=;
 b=w4MYEZIVvsmzm7akuv+rMeeOx8nCvBbh8JnE8N/uGuMRotCKJK0nlgNXFDQGUvvT/G
 Rbl6ROIJTDKEQRvergG6iap506B45SGCjrTdj/M04lrlNp7+QjbJ8HcedoATDZjzWxxP
 yPL19p2PgMdzBtUiEWOCl4vVTawRgCwodrKlTXsM1d9V96syXTOdF5Kgtk8TjycRwJpF
 Ji1Sf23a3MnnEdwdKNi7wiB7W1Swj4AR04qRYjOUlElrxuR0yINM4eUYUEIgzclPOl3p
 sWH18++g2/g7baXDpcDmkTnYgP/WOJUV1WcwZDRj01G2laJ0vTnjeiMpd7AgleNZOa03
 /b+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794587384; x=1795192184;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Me8wiQ0HJEeNW8ibwQsvd7QQqaIgXxWtjrcDHkoHDvM=;
 b=jWSfmjevkqcBBCLp1/bHR7QqaURgGtgLkQJjIXBChWVUZ4iGvvSqcEvGC7Md/e8qP3
 XPE5/e3Ixip5L5Q2KcgoUyN4w3GRiBhmZ90jM6cuEPlkn5y8z9opUblYyM4dhO0q9krg
 IgIrnvVfGh24N6s8xuvRH/jEyI6h0uyQ7ErZmPOuzW/3bWUgsHpbgTNzLZNshfk8+PJ1
 bFFdy6RQe/ZF24n3VlJCFZHe/3B+a/NELPsJeej3Tnm48/Fqn6gaBd/ON9MXv/lAZZa9
 qIgyZOrS3mX8df/ZRSaz4FLMrQILWGZeQ0Aey215BvB5hP3Y7V0UlDUBaZ07Tlp968mN
 ZFqg==
X-Forwarded-Encrypted: i=1;
 AL+hErHtFJeRpKs5sn56W46YL22Ecs5Z/Xb0IO63/IVd/VY5MV38RfL6cxwdv7wsRsr00+ILwAQFE2D2ytU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8tNmGyx7Bf7vDV0o4nbLwm80pFaKooVLtmk/RRkcqtWHPmnFnp
 F755P7jcNG7X1tF5GEEwdDI8hj5WnwRkSTmKIxUTNSTIYf/VAF8QnKne
X-Gm-Gg: AYBFou2ExVFnROxB6eRb6P0+L2/x3vlD6W3XqPcOYo5h//4KV/XDJltJPI+hDEyMu94
 3dgaRpS1DyzPQnEhybZiM6ZxtSO6L8l4vMFl4sF1DrLMmduYgiAqZcRtFIVDBqVQA+1xCst7kYw
 VQmoGNee6WsJXmvcxratmgIveGh64bqvo/A/mxSD79XKdJDraQo+Sqe6qe0BgYiTJ1diY2eGr9h
 /S7DEercf3uL9WPI6N1vBmE67qTKDUa/OD98dhJyGI8kY2livJubDVOYfGT3dgl9sb/++sw2Wgo
 zLkc5DkZGYHK2oCZXY9qR54qQwfAK4XcauAyVW5nG2YAPniqB3TSeshZUtIVFaoK6naJkEy2NUD
 +UZ5USBG/WamNgCGfXOwUXf95EdP0tN1sDSXmYbmEwy9Rqa7WftHjfb7JGQUJBpxfqGbYx602MW
 IICbm9lQ0UMBOVeXTD7wQ3FsWr1Di1u25ubTDYwTyVYkQucdgNco8FUusMioVGBtODMw7oHUc4M
 NS5PZvz6fFWHQimUWZqWjrnBfZFQyGQNP0Xthf/fO/j0CDX/AzEEIylDT4stCcN1KT6C6KBJEpW
 RlRIkFDIyScMaL6ytNu28LxI9wWfx5LkB1ddFPwg2inKFHZzp4VaIGSLdqJNo/SJvZozpStpF4a
 3erk=
X-Received: by 2002:a05:701b:290a:b0:127:def:dd72 with SMTP id
 a92af1059eb24-1b5030f8a7dmr3833998c88.2.1794587383353; 
 Fri, 13 Nov 2026 08:29:43 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031918c7sm11835849c88.9.2026.11.13.08.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 08:29:42 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>, Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jiwoo Kim <arpe1618@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] accel: ethosu: Fix use-after-free of the active perfmon
Date: Sat, 14 Nov 2026 01:29:31 +0900
Message-ID: <20261113162930.15751631-1-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
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

ethosu_perfmon_start() stores the perfmon in perfmon_state.active
without taking a reference, and nothing stops the counters when the job
that started them completes: the perfmon stays active until a later job
runs with a different perfmon or none, GET_VALUES or CLEAR_GLOBAL stops
it, or it is destroyed. Meanwhile it is only kept alive by the
references held by the file's perfmon xarray, the global perfmon and
the jobs using it.

If userspace destroys a perfmon while a job using it is still queued,
ethosu_perfmon_delete() can only stop it if it happens to be active at
that point, and the queued job makes it active when it runs. When the
last such job is released, the perfmon is freed, but
perfmon_state.active still points to it. The next job's
ethosu_switch_perfmon() then passes it to ethosu_perfmon_stop_locked(),
which reads ncounters and updates values[] of the freed perfmon.

Make perfmon_state.active hold its own reference: take it in
ethosu_perfmon_start() and drop it in ethosu_perfmon_stop_locked() when
the perfmon stops being active. As a perfmon can now be kept alive by
perfmon_state.active alone, also drop that reference when the DRM
device is released. The counters are still left running after a job
completes, as before.

The problem was found through AI-assisted source code review. The fix
is compile-tested only and there is no reproducer, as I don't have
Ethos-U hardware.

Fixes: 17cdb54644e7 ("accel: ethosu: Add performance counter support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---

Notes:
    This keeps the counters running after the job that started them
    completes, as the driver does today, and only fixes the lifetime of the
    active perfmon. v3d instead stops the job's perfmon when the job
    completes; I can do that instead if you prefer, but it would also stop
    the idle and cycle counters at that point.
    
    It applies to drm-misc-fixes, and on top of v4 of "accel: ethosu:
    Another batch of fixes".

 drivers/accel/ethosu/ethosu_drv.c     | 20 ++++++++++++++++++++
 drivers/accel/ethosu/ethosu_perfmon.c | 15 +++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
index 4a24bbd2bb..b6778196c9 100644
--- a/drivers/accel/ethosu/ethosu_drv.c
+++ b/drivers/accel/ethosu/ethosu_drv.c
@@ -341,6 +341,21 @@ static int ethosu_init(struct ethosu_device *ethosudev)
 	return 0;
 }
 
+static void ethosu_put_active_perfmon(struct drm_device *ddev, void *res)
+{
+	struct ethosu_device *ethosudev = to_ethosu_device(ddev);
+	struct ethosu_perfmon *perfmon = ethosudev->perfmon_state.active;
+
+	/*
+	 * A perfmon left active holds a reference, see ethosu_perfmon_start().
+	 * This runs at the final drm_dev_put(), possibly long after unbind,
+	 * when no job or file can use the perfmon any more: just drop the
+	 * reference, without touching the hardware.
+	 */
+	ethosudev->perfmon_state.active = NULL;
+	ethosu_perfmon_put(perfmon);
+}
+
 static int ethosu_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -367,6 +382,11 @@ static int ethosu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = drmm_add_action_or_reset(&ethosudev->base,
+				       ethosu_put_active_perfmon, NULL);
+	if (ret)
+		return ret;
+
 	ret = ethosu_job_init(ethosudev);
 	if (ret)
 		return ret;
diff --git a/drivers/accel/ethosu/ethosu_perfmon.c b/drivers/accel/ethosu/ethosu_perfmon.c
index 26f625374f..69c0967f87 100644
--- a/drivers/accel/ethosu/ethosu_perfmon.c
+++ b/drivers/accel/ethosu/ethosu_perfmon.c
@@ -54,9 +54,20 @@ void ethosu_perfmon_start(struct ethosu_device *ethosu, struct ethosu_perfmon *p
 	writel_relaxed(mask, ethosu->pmu_regs + NPU_REG_PMCNTENSET);
 	writel_relaxed(PMCR_CNT_EN | PMCR_EVENT_CNT_RST | PMCR_CYCLE_CNT_RST,
 		ethosu->pmu_regs + NPU_REG_PMCR);
+
+	/*
+	 * The counters keep running after the job that started them
+	 * completes, so the perfmon can stay active after that job and its
+	 * handle are gone. Hold a reference for as long as it is active.
+	 */
+	ethosu_perfmon_get(perfmon);
 	ethosu->perfmon_state.active = perfmon;
 }
 
+/*
+ * Stops @perfmon if it is the active perfmon. This drops the reference
+ * held by perfmon_state.active, which can free @perfmon.
+ */
 void ethosu_perfmon_stop_locked(struct ethosu_device *ethosu, struct ethosu_perfmon *perfmon,
 				bool capture)
 {
@@ -73,6 +84,7 @@ void ethosu_perfmon_stop_locked(struct ethosu_device *ethosu, struct ethosu_perf
 
 	if (!pm_runtime_get_if_active(ethosu->base.dev)) {
 		ethosu->perfmon_state.active = NULL;
+		ethosu_perfmon_put(perfmon);
 		return;
 	}
 
@@ -94,6 +106,9 @@ void ethosu_perfmon_stop_locked(struct ethosu_device *ethosu, struct ethosu_perf
 	ethosu->perfmon_state.active = NULL;
 
 	pm_runtime_put(ethosu->base.dev);
+
+	/* Drop the reference taken by ethosu_perfmon_start(). */
+	ethosu_perfmon_put(perfmon);
 }
 
 void ethosu_perfmon_stop(struct ethosu_device *ethosu, struct ethosu_perfmon *perfmon,

base-commit: bafda823590ddf7031ecb765d673572fae7ab44a
-- 
2.43.0

