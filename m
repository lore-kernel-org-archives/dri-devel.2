Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D7DC79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:18:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DAB310E54E;
	Wed,  9 Sep 2026 13:18:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L4is6ELt";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BDF110E54E
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:18:19 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49b96837ca3so46049195e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 06:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788959897; x=1789564697; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+AiVzdutjGcRUDNFx0/iYhbxY4PM+Gwrdgc6/3SbWR4=;
 b=L4is6ELtr1L60UJslRIEJ+4qdqlKsNT1voUPHLz4MzwR/jRNynhn8MVhZ/9iNsvbP4
 friGhgjKwnpTqDdQzrRMgqnNtp8OgpL6N1lwfUPbhGM2ULvUskTZ2jCP2VKBr9anyGJa
 tSlg1tiMJEAjacEwxt3oiGN3oAPaOb0JUroUeD5EhwY02uGieMq5MFKD1nvt8J+QBnkJ
 XoAK5ZvfSVoOg9hmTX7oI7jZLA6QYmRj20dvpOajJXvRGF5wOkcvKQnandrXk/gBu7Tp
 A7bgRpkYK2+ZpH2WWG+R5YxmfnBcJuJl5cI0n4OSBnSA1tegdnEkjZxhC0DHXZ+Zzz1v
 nNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788959897; x=1789564697;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+AiVzdutjGcRUDNFx0/iYhbxY4PM+Gwrdgc6/3SbWR4=;
 b=hwDAlsogCrE8HYC7OyVaNpy4MOcVvJ1wCRrSwWH5jqSIWvIN02aT8t2S79FXrOThy2
 a3sHe3FsmBKSbz+iPbaMaQnkRH8NUb7Ta4yiFJWF5bb+5uy9hoe+xn/xkKa2Ob2ZZvng
 lXOAqI5P2XlwO7J9J3Zh46Lu2aRied7L+QbwsWf31il11EOdl6KJ8WH7wx9d/XX8DM2E
 XocfgynUX6QrAZ14RkWF8vN9d8LE8HwY7eOQHe6oCNFOy34aWX6nj3DEQIxcPDtNn6gF
 nruwkEItQCgOqLwEuTZa8GuYDbtDBJGn6mM6R0Lwxgism711BloawmKR2n7ylrKnjd1W
 xRvQ==
X-Gm-Message-State: AFuF++nWpLD4/jK3cy1WW/xDur3mbnbo4zqw1omSbSYIGoBeWTfpGd3h
 LaS1xiPD2/lPTQLpSj/Ilt1wEpJCa6+T0Svksk8xPD5dJ5C99qvS2og7
X-Gm-Gg: AYBFou1+8/0S2njqxocAv7N4kHrVIIqgS0PkHIUhy+HW8KxOgUW1Hzuc/1D0ImukxM8
 ow3Fs2GrIJwsbg6fxg48xMP8NrHG0IbDAinuAwapQJWQgWmsyjmxpHqaN9P9tWVV+KZECnNHznK
 I+gqnJPn+49v3PB99/WaQpEPiQwuqiZ2vdaEQNmtERtPh9naUT/gKY5+qIuakqvkj7q7ALVdEkj
 tqBIY98fpDWQhH6AN/Vxnw2BoaRW2bRuA3NYUqeGlkEPk72HO+gsvqQahvUi/EuWvjdpr+5qntD
 CAVgmGsCKs+axnYL2axPKAsXaB5JB6stj9Cgqls7I7jyccMx03Nb301ifSj/dGVarJmGm+9cU0i
 jtm5v/H7Zwvh6LsS/mPuj6iUrPoOEKtRenM4Pu0IXwUW0InjiY83OqiBmuzcm04vplOxeduJd1G
 5/Fz3Kt5jNe37CUSGWaeg/3fwn1yu8t8NkV3tktY2cNbfJOoGSVU+JEBKn4T0MPO5OV39qWtcaO
 k0Lrj16mgCw
X-Received: by 2002:a05:600c:a087:b0:49c:d26a:cf70 with SMTP id
 5b1f17b1804b1-49cf825a75dmr368157315e9.15.1788959892792; 
 Wed, 09 Sep 2026 06:18:12 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1568:cb00:7389:2b93:7e4e:44c7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee80eda4sm555457755e9.15.2026.09.09.06.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 06:18:12 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, malhyuk97@gmail.com, tursulin@ursulin.net,
 matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com
Subject: [PATCH 2/2] drm/sched: document the RCU dependency
Date: Wed,  9 Sep 2026 15:14:24 +0200
Message-ID: <20260909131808.2201-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909131808.2201-1-christian.koenig@amd.com>
References: <20260909131808.2201-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reply-To: christian.koenig@amd.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Tvrkos patches added RCU protection to the returned strings from
get_timeline_name()/get_driver_name() callbacks of the dma_fence
backends.

This fixed use after free problems for a couple of drivers, but we never
documented the consequences for the drm_sched_fence.

Add a few words on the function documentation to note that we need an
RCU grace period between signaling the last scheduler fence and
scheduler teardown.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 6cb6f9546493..22103cb07782 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1203,6 +1203,10 @@ static void drm_sched_cancel_remaining_jobs(struct drm_gpu_scheduler *sched)
  * is implemented, all jobs will be canceled through it and afterwards cleaned
  * up through &struct drm_sched_backend_ops.free_job. If cancel_job is not
  * implemented, memory could leak.
+ *
+ * The scheduler fences timeline name is returned protected by the signaled
+ * status and RCU, so an RCU grace period is necessary between signaling the
+ * last scheduler fence and tearing down the scheduler who originated it.
  */
 void drm_sched_fini(struct drm_gpu_scheduler *sched)
 {
-- 
2.43.0

