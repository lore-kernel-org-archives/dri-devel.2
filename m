Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE1E606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FGXHRN9j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D58210E00A;
	Thu, 22 Oct 2026 21:58:21 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A56010E00A
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 21:58:15 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so160000f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 14:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792706294; x=1793311094; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6eqn12NWtCMzBotu+Ik94sYsNYAT7Cdm0Ga9zAnTZZI=;
 b=FGXHRN9jb5fzL7IBj2cCy9kgNh4RAy+ZCPOWiUTA5s6YYpEAc1nqZKSTwAb5o2nqln
 +suPx6Jt60/8AEOUN37WgYfZaJ3v/XBMBzXuned1T+42n8B8Ta+VFRq1rmq3O6G24QR0
 WchK7L1o4yR7QZ9dERKbigMyViwaoGkxujzJmVzB1nqNt52ElEjJjsTuokJhXQ6bF59l
 Ie3K3vKtztxR2DNjZeZ+y0lppN8kPbiiGes0fhBdQr7jWxGCecencO4tPu5nVaqF0z7R
 gxtcnzORQ6ax8HC8RLCLrbgUXJfaXvFcNgyUHBySck+lbNXBRhrOn9/dphOhEoFNeKTr
 sqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706294; x=1793311094;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6eqn12NWtCMzBotu+Ik94sYsNYAT7Cdm0Ga9zAnTZZI=;
 b=UneJZu3hmCluoZkkuxB5sklFUw1/thzJrqgTpg5Ipu6rqwhIRFjZOUkCQPCnTwhe8y
 /+ZNGxC8dw1qeSCCZtcpqkmmi1M9C7v7QdBItdacAIqun59lcUh3mFA9wKlFnkps9snD
 SyJ9kx5hhTcnU5IV5CfHgLI654jbuZ5s8lewYT43qAjggp0BvLRmLSojWSIShtAVjwcg
 BbJFRxoXgKZQQDHsDrLiw+Ofg9PQ7pVKeaklYjLS9pGcgpDD9ED3tDxDDqOMAisfKEd3
 KYqnaCR3icg6KK97WBgLvrfHQb92UQufQW55hUIiKv7igD9Jl4aOazugpzt8KPr5Z538
 C4Dw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwV5c3g9TOp7Gnk5RWDVNbHQ4k5XqypmTKHJ8wjIsRolCAb5Bvd+2gGDAmOT5+ObV8KOzfD0yn0DCw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYISI8ge0jdn9SuHeVdXlhu7den38j46wlfi8WVtXJbdiPV0mnbG
 T+Nr4vOIRrFgEd/m4nBk3/xxrIebzxsQrV/oaETVf+aF4SJXAUwrFSrt
X-Gm-Gg: AYBFou2wheqOIZ7R6vS+9L4lhpFCTpyqKGhEDQNBmIcGJ79Fk+onSixfnKnP5OVjlza
 lo2yAAqfFpaz1SK2NJKY88ShDiZ26DZu2I6pdyDlX6Jos1PwTCDSEAHg+S7xs4oGMjelT/Dzw4n
 Fsdgp28m0fSEOTrwff2USjFASGNj3zlD/hSm+J7xeLpvDAiDHpZfuzxHmvb3VTokw8jf1gDaJfZ
 yn2yWLF1SNBag3jGXaVXelopLX9iq6/STpQiBuaa44tqAVGVK2DIaO9SW8fMq1G2XhiM5bkYyIE
 DKRAbqH7pNqT7UZv8mkTBUleZ+0meWVYkHsVN8zgKX0jK6K4sAG0h3HVbbzOygje9tLHbnjccYx
 DzA3fFpA2CcQM1fXqrKBuIDFB6m8jwaKwA7wd5avHKWWGQDm/cMkOwBQYTQKtBSlX7wvnishIBY
 0c1Oi/1laRjML3iSn9OO1MdZ5KowkeLoY6u1q24o/Y0l1d46MN6p7dQCu/mIEqwZmcZgwTwhfgx
 P9n2SCfIc3bDsApWgIWw1TqUO3TYO1iezYCCMgbkPhorXjGhMl95y7cTQIG
X-Received: by 2002:a5d:5d0e:0:b0:48d:ffce:6cef with SMTP id
 ffacd0b85a97d-48e384e63f6mr300522f8f.0.1792706293644; 
 Thu, 22 Oct 2026 14:58:13 -0700 (PDT)
Received: from ArchOarora ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e37e5dfb6sm701704f8f.0.2026.10.22.14.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:58:12 -0700 (PDT)
From: Oarora Etimis <oaroraetimis@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Oarora Etimis <oaroraetimis@gmail.com>
Subject: [PATCH] drm/vkms: use the gamma LUT of the state being composed
Date: Fri, 23 Oct 2026 05:58:03 +0800
Message-ID: <20261022215803.621996-1-oaroraetimis@gmail.com>
X-Mailer: git-send-email 2.55.0
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
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Compose a frame from crtc_state, but take the gamma LUT from crtc->state,
which may already be newer: the worker runs from the vblank timer and can
fall behind a commit. Such a frame combines the planes of one state with
the LUT of another; the CRC and the writeback output can then be wrong.

Read crtc_state->base.gamma_lut instead, and clear the derived fields when
there is no LUT.

Fixes: db1f254f2cfa ("drm/vkms: Add support to 1D gamma LUT")
Signed-off-by: Oarora Etimis <oaroraetimis@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 0fc915a954ba..ed3c8f1a8db6 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -609,6 +609,7 @@ void vkms_composer_worker(struct work_struct *work)
 							  struct vkms_crtc_state,
 							  composer_work);
 	struct drm_crtc *crtc = crtc_state->base.crtc;
+	struct drm_property_blob *gamma_lut = crtc_state->base.gamma_lut;
 	struct vkms_writeback_job *active_wb = crtc_state->active_writeback;
 	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
 	bool crc_pending, wb_pending;
@@ -625,19 +626,22 @@ void vkms_composer_worker(struct work_struct *work)
 	crtc_state->frame_end = 0;
 	crtc_state->crc_pending = false;
 
-	if (crtc->state->gamma_lut) {
+	/* crtc->state may be newer than the state this frame is built from. */
+	if (gamma_lut && gamma_lut->length) {
 		s64 max_lut_index_fp;
 		s64 u16_max_fp = drm_int2fixp(0xffff);
 
-		crtc_state->gamma_lut.base = (struct drm_color_lut *)crtc->state->gamma_lut->data;
+		crtc_state->gamma_lut.base = (struct drm_color_lut *)gamma_lut->data;
 		crtc_state->gamma_lut.lut_length =
-			crtc->state->gamma_lut->length / sizeof(struct drm_color_lut);
+			gamma_lut->length / sizeof(struct drm_color_lut);
 		max_lut_index_fp = drm_int2fixp(crtc_state->gamma_lut.lut_length - 1);
-		crtc_state->gamma_lut.channel_value2index_ratio = drm_fixp_div(max_lut_index_fp,
-									       u16_max_fp);
+		crtc_state->gamma_lut.channel_value2index_ratio =
+			drm_fixp_div(max_lut_index_fp, u16_max_fp);
 
 	} else {
 		crtc_state->gamma_lut.base = NULL;
+		crtc_state->gamma_lut.lut_length = 0;
+		crtc_state->gamma_lut.channel_value2index_ratio = 0;
 	}
 
 	spin_unlock_irq(&out->composer_lock);
-- 
2.55.0

