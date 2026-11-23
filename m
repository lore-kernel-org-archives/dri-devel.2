Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFAD606A33F
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=okonski-org.20260707.gappssmtp.com header.i=@okonski-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KATw54mm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D2AB10F352;
	Tue, 24 Nov 2026 08:39:58 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 092B610EEBC
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 22:11:40 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6b88d143160so4669950a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 14:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=okonski-org.20260707.gappssmtp.com; s=20260707; t=1795471898; x=1796076698;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8D+ctn0pse02ZuULxqlLv/iDLr/WH6tZ2LvtGmPFTZY=;
 b=KATw54mm3Gah2vA6cu9pZoE0azOWrYs6ZM8AhZjnkroDTiJRnp89TsHR2ICMYX7epl
 7keU5q8HKD1kVPBPifob5CiQ7cTuWWJB0bKsGKciHZ0zsbGdhCz4adqUUfaJx7e2rJ7H
 G8lO54Aj6pWC1bFOXPHHgRczFyON5uMOXLwIUwE+lv76V05DMrUdULUMqf/SsJQQ44zd
 1AG9GCcgSjY52joG6jZVVT/2DsQf2CU0nFzgsRBVvhKHN8IfdOcmSNaqXmqXbs7+D/FN
 GE+BNWHRX21jxu7vywuoQzBohqBOpLJsP37MnaQf2zsKcHFavG4NQKrTjb6h72QcWqgu
 SYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795471898; x=1796076698;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8D+ctn0pse02ZuULxqlLv/iDLr/WH6tZ2LvtGmPFTZY=;
 b=JOiWlXqIFhi/5RqXxRsCzMxl5LXXOzJEnSoTavmbM/XCnHESrULipKz02eL42hsDDJ
 39he0hKiYGck+uwtNr3tlWp2l3hCaUfznBJNRWOGPZA1CxNh7wImA7uFsMkTze+6Ii6K
 /xq2aN6kekOFUFKqyakXnGXp5C7SobfxCdeDt5NMQ2sya8vWIAg7ufpu1pSXg13F0J22
 6ZFbwO3aSzOis7O32OGLedTPRfzCcIs6QnuZMDXJYtqond56sXHo5ZjWnW7XnqGNJAQk
 QAhtfy1nN3iOeciAdXRS9Xvid+IqTXuWirb6GqNUdgv6rZVtEA/K6cr+XYEcksJlvLXA
 7hcg==
X-Gm-Message-State: APuU4Z+N5F/FxO1nD12B8IcLOi39MUn02oxEBKJeeAEb3Ig5muKNMlPf
 ONWe3wfe+MwIyA7nOAgASbw+jEgEtpXIk01N6AZxHd1D/KdPTV3DZndbUpFi3GymB1U=
X-Gm-Gg: AZFdTZeUFNXzrrYznPao5woxQuj4BxYJWOHuYQ8o7I3Lu0h8HLbS0jcn2gFekN0GrvO
 lDg+HIfyWHieMU7zkFKyd4dlelLzYx6c9ctHfcpGEjQPZNGj7PbP5UO9+LS6cQkDmv0bsoopulF
 vl81eHibFxDlk1n7TZrTcLMEqQTJKm12xot4v13aMVzL0jzKdQzmVxM6I8RrSFr/0vt0SI7xXK0
 r9coMArfpZNKD4tKTgYLXHb6U4ZhyzUxuGyy/hgDSJq09IA5zIoFha0wXeKQ5PQkXCk0+xySgDZ
 pxypmv6j4uFV1/Ky+NFSFnu0FRa1hfwtIaG00XoJWPRrafL4Q3A5yvDt0ueYN795xrxFsj1Jfg1
 CcsiHOf0uQQ4/eYfJH56QvwVNAEFDf53pNkbY3Bl67rLDz47hGgS52IxkugD+b9txSE58xBv4hI
 j9i+vz6yYaGqqgFjicvjmyARtWnHK6Oz7MuxBmQI67r18akE+vg4h5B/sxrz5SGcGVVxZCaE/q6
 4VhVzAJS7h/2OJ9rZRUkzxbAW13l1SSonZv7rMUHFRNJY+m/jmrzrcUOEwtmUSCNsX73/OvsKA2
 evwirTYRk+a2Pob2ZWXtihobGOvmZTZZnEW7xx8GD96uwldUd24Oq9cy732jlZywpokKc3iEPZ+
 +vRl6NThCSY52nFI44eRHB1m9URiw4ueUJRrrUDWSSVlxPA==
X-Received: by 2002:a05:6402:400d:b0:6b5:9849:e328 with SMTP id
 4fb4d7f45d1cf-6ba37ebdda1mr8924995a12.39.1795471898391; 
 Mon, 23 Nov 2026 14:11:38 -0800 (PST)
Received: from vautera ([2a02:21a0:10:748:2::2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba37109b55sm5678828a12.32.2026.11.23.14.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 14:11:37 -0800 (PST)
From: =?UTF-8?q?Jakub=20Oko=C5=84ski?= <jakub@okonski.org>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de
Subject: [RFC PATCH 2/2] drm/amd/display: Skip flip_done wait for non-modeset
 TEST_ONLY checks
Date: Mon, 23 Nov 2026 23:09:13 +0100
Message-ID: <20261123220913.937402-3-jakub@okonski.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123220913.937402-1-jakub@okonski.org>
References: <20261123220913.937402-1-jakub@okonski.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:39:44 +0000
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

needs_dc_state_realloc makes amdgpu_dm_atomic_check() call
do_aquire_global_lock(), which waits for hw_done and flip_done of each
CRTC's newest commit. A TEST_ONLY check issued while a nonblocking
commit is pending therefore blocks for up to one refresh (6.9 ms seen
on DCN 3.0 at 120 Hz) for about 0.1 ms of validation.

A TEST_ONLY transaction publishes no state and does not reconfigure
IRQs through the commit path, so a non-modeset test has nothing to
order against the pending flip. Skip only its flip_done wait.

Kept: the modeset and private object locks, the hw_done wait (DC
validation reads the programmed topology in dc->current_state), the
same validation, and the full drain for modeset tests and real
commits.

Signed-off-by: Jakub Okoński <jakub@okonski.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3d2201285888..25dcbee0c7df 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5594,8 +5594,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 }
 
 /*
- * Grabs all modesetting locks to serialize against any blocking commits,
- * Waits for completion of all non blocking commits.
+ * Grabs all modesetting locks to serialize against blocking commits, and
+ * waits for pending programming and, where needed, flip completion.
  */
 STATIC_IFN_KUNIT int do_aquire_global_lock(struct drm_device *dev,
 					   struct drm_atomic_commit *state)
@@ -5624,13 +5624,14 @@ STATIC_IFN_KUNIT int do_aquire_global_lock(struct drm_device *dev,
 		if (!commit)
 			continue;
 
-		/*
-		 * Make sure all pending HW programming completed and
-		 * page flips done
-		 */
+		/* DC validation can inspect the programmed pipe topology. */
 		ret = wait_for_completion_interruptible_timeout(&commit->hw_done, 10*HZ);
 
-		if (ret > 0)
+		/*
+		 * Tests don't publish state or reconfigure interrupts. Limit
+		 * overlap with pending flips to tests that disallow modesets.
+		 */
+		if (ret > 0 && (!state->test_only || state->allow_modeset))
 			ret = wait_for_completion_interruptible_timeout(
 					&commit->flip_done, 10*HZ);
 
-- 
2.56.0

