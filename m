Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF33606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=izYsAptq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ADB31129FF;
	Fri, 27 Nov 2026 10:27:45 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 436F510E4FD
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:19:39 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4a32576da88so4541983f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 01:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795771178; x=1796375978; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=metfIbrsOxAWRmHkJSDy8voQcz9dpLZ1W5XEiDguPng=;
 b=izYsAptqb2mJDcVejUrGvh3CZEFOpPMM/k9/3j7VUQoMllQ8640nZUtDCGDH8eN8gg
 xqYkh2kerScCTx6NyUZrIxCNyrOc4y9LRCvimeetxInVPRRh3zzy2kiwFnpb/djOy6Oa
 iN492dpfIqFc8ZnK6RQSGpHjgzlhxmMCnA0EEfAdDHGCSF2RGOjHuPsZwXDXJ+7HRtIp
 Fop8cAEN//DavLiTgVcApKZB1G/V2SDxoQuuP86a0p7HzkfvI8VoSpvw1iti43whQXIn
 FGcvQ692ZhAtX9AGri4hPa3OL7Isv668NLhqZtc9nPYK/4Ak+Ne4v478fjOmuwubsvVT
 qiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795771178; x=1796375978;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=metfIbrsOxAWRmHkJSDy8voQcz9dpLZ1W5XEiDguPng=;
 b=N34TtTMcmfp4B7UjruZ1TLECoxi/Vyyfk6hk44AVNwEBavGhOXcNsu1/OtJ7R20Cfa
 aCRsyJv+rmFAQssr+7penkr5GItHDAZiweST7isaqLCede6RfA7KI89MClsD4B8msNRw
 ECBCvDQsA44dCpAcbDDpr1N6ywbJSIpP4NsZdT8bI3Xj61bvKjb4c0O16aqy9HGi+YGk
 UlripT3YcbtMJQdIxeXK0cWgJMNxWKSoy0+Jis1CMCLk4+m39nASDRkyDdAfuAm+tdDM
 BuPk434VvgSL5yk0lTXZKPf12aJSmuDlv5iamd/7lQKKzBgcCUDqDfBJX4R/+wsI0Zei
 EBHQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGoYv30RB0py/6iZIpDXCAQmzvzFnd5C35VLhMEZwm2wxR3QmHVQmqzZ8XmtHst+8fyQ5R3XDnvuhs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/UUFSvJdoiI6+mNJd0/E3SH8LV0txWe2ekWAHdKsbaNLv0ofsh
 hsRUHhWTz3+04EcVp7gBQFbwmCsdgLzI5+WW7+d7qrVeue/RTQ5iMFGW
X-Gm-Gg: AZFdTZe0yKnSdqqU26b4YiteXmftfcwAePcc38FQ6dMTaOSUk+uVut75LHzYZGoUsoM
 2nHdJ4r5RwgEHBjrAsHmG1nrXbwx5UXjYn1RjDz8IP7xGH5k11hQSBOGEn2BoneeN1G1RWM9kEp
 HC71+zdHAkFTFKWDlbDOIWqC5lWNXE1V/Fl3itzW2rAVvS7cObDMLUODCS8tNomIoRkR9zTuK3m
 29c1SacKvQIA8975AVWCDHBMx1vwCjNQhMEHF6HOXq3UM7bFr1ofYxgYK9a3kHhg3xa7OKagOmL
 MGFOMsspp0CMqLsg4f1plwVJHjURGsF7wHYn735zaNRpcStMBpBB7e9p5zlXvwKNkIMMSsj/pGb
 Y4tAspTHmRzkFgIMPsXwEvTnrGfIJTSZf8nx+I8vhe2DJbX+3K4GKHmXeBNU8LybWqrRCUX4H/3
 nMTMWbAXSu3+fx8wy4rH3lghP0NvGSzmTYaUdCiZSstAlwa9i4j6D0MoTyDaWAGHIa5CavdrlmM
 MBrWgiGOgCt4r3qMHslN5ia+aYfUgZgli15bswSvy4QrQz1UoZqrJ9th5mGM/qjnOZLVHUDFGsc
 7zDo9gVwOkOCI1QG6yBj+bIhC+8bDmDI+OhetB2tMqIrcgI=
X-Received: by 2002:a5d:5d08:0:b0:4a6:4f91:284c with SMTP id
 ffacd0b85a97d-4abb83116bdmr53271779f8f.51.1795771177338; 
 Fri, 27 Nov 2026 01:19:37 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c340df4sm52415228f8f.55.2026.11.27.01.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 01:19:36 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH] drm/msm/snapshot: Do not keep an error pointer as the atomic
 state
Date: Fri, 27 Nov 2026 09:30:50 +0000
Message-ID: <20261127093052.1338722-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 10:27:44 +0000
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The drm_atomic_helper_duplicate_state() function returns ERR_PTR(-ENOMEM)
when it fails to allocate.  msm_disp_capture_atomic_state() stores the
result in the disp_state->atomic_state variable without a check.
Later msm_disp_state_print() passes it to drm_atomic_print_new_state()
and msm_disp_state_free() to drm_atomic_commit_put(). Both dereference
the error pointer.

Store the state only if the call succeeds. The snapshot then has no
atomic state, which both users already handle.

Fixes: 98659487b845 ("drm/msm: add support to take dpu snapshot")
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---

(Just accidentally bumped into this, while working on BPF stuff...)

 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
index 850246fc89e1..c9bc58b833d3 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
@@ -111,6 +111,7 @@ static void msm_disp_capture_atomic_state(struct msm_disp_state *disp_state)
 {
 	struct drm_device *ddev;
 	struct drm_modeset_acquire_ctx ctx;
+	struct drm_atomic_commit *state;
 
 	ktime_get_real_ts64(&disp_state->time);
 
@@ -121,8 +122,9 @@ static void msm_disp_capture_atomic_state(struct msm_disp_state *disp_state)
 	while (drm_modeset_lock_all_ctx(ddev, &ctx) != 0)
 		drm_modeset_backoff(&ctx);
 
-	disp_state->atomic_state = drm_atomic_helper_duplicate_state(ddev,
-			&ctx);
+	state = drm_atomic_helper_duplicate_state(ddev, &ctx);
+	if (!IS_ERR(state))
+		disp_state->atomic_state = state;
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
 }
-- 
2.54.0 (Apple Git-157)

