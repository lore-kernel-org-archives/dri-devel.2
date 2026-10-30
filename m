Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A03606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zx+BsWHt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CAD610E5CC;
	Fri, 30 Oct 2026 17:48:47 +0000 (UTC)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C8F810E251
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:48:41 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-18cdcfc05ffso1338341c88.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793382520; x=1793987320; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HVu2JcCG2HprgJzsSbrc+jJQTNcc1yWhLqbH9s7EdTs=;
 b=zx+BsWHtarEe7PHhAAJWU2cHwuKREqLsG7ftmulUU+s6ComGUnylYhsx6GGFU1G86Y
 qNK/KwdK/BTohz51+cePupovvsR9ofYOElbSub1KzLRNMSMaoF9KUI8fnWKWwDIwD9Dc
 EKTB2jh25bnwkyFPHEOvWHZsYHxg2feyvusszSy5mFzvTCeMDTDnGLn6PuW2B3/9Mkzx
 p7YYHgFR7VbE1xn1jhWz+hs1sjAQ9VtMeO/yN1YSYoE6A3wk86RUqPngrR1DEZso3vQq
 kYaGCAsTjE+XUDSitbfLAPOz0iOfUO9PlJ+O5lSVvshCbZJPR3ijhUo4TqLzfszBHn69
 xURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382520; x=1793987320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HVu2JcCG2HprgJzsSbrc+jJQTNcc1yWhLqbH9s7EdTs=;
 b=gujXkt+OPsOSd51Y4GrUZIkN1uz31ofeinl+LvumOVEiELrT9FD9Nj5rFINPq/3uS7
 vBs6a0FNuHiuO46oIFynpKpN2NKiKkE55KFdk47hBuRyRFfwqpTgdsu5DBQKAM/XzpXC
 iTSRKWsox7JeN4VF1H88ddXapmlhGWK37zpMw1OD52gReSM394+zmU6hWD5oeviqQ9An
 w8yqrqs7maYQ1aKzSc3GQqbFJYpB9QzUj51vOwVkdxys+vFI5F4hzMk87WhBvZq7LJWE
 psws4HhbPtuwOib+l2oITrXtde604K893x+EEtneYZQQAnYxDJw/12wKGCDSVxj33IXY
 vwUQ==
X-Gm-Message-State: AFq9FYLpqA69ugXEO+3b+8o11eRI3yTESO6wdeHyF/8YcSFK+Iu4G0EM
 j8rXtJyFiblVKWYyQ84XBym+L7BV6aW9mZhDIPwDGO29P3qQoy7CA0lU
X-Gm-Gg: AYBFou2QsStMKfKEfhBc2x7126hXBBVBQNwlXTfbKk7yDYCrQSfGc6Di0vvsT7ud9PL
 9tNoHPjyvyWjzvys1jJnweROCTLGy2vKT2X+UXCQRP2KgtFtuEMfUY3TJwPGsLwzR242uqKhD8C
 cevwogcLwuOhhHtdelz32sET8Djkpo6rqaMP85R00IRvXIA/87KtY7Sk/QpCQAVIbBu9x4X5v8U
 vtspH5cfKzNJZnpSkZXaf1zS4YRV50DE+fykcR9hn0OsMUBxy6nb/ficlHl3fGhjL8aRZFwJeO2
 eyE51dxicyBMn2hp0SFnxC2S31Ec0CpYA2eYzeEPVcK/xvNxt5ITTmMYVgnGX6xJ2VqGSEjiqyT
 OAIF6PaFLT7Uj6Lin1z+umpPVRkT84auKeenug2kQ1MvWIeIkYB7Y1/4jkptE01i6x5+9BWk+iF
 YICWrAwzf5hB495Hgg5+YRW9CXH1s//xyErgdXLXvyCwC2KK2p/RZ6ClkbRTAxPa/I94lEsuVLi
 CvwATZbiOfDEs2YvHBQra3KUjsXMfZVHTQeYQJpCXY90uomgVSKjqb6Y0ADQMRzBZMMzblMsQ5R
 ArL5oGSc+rF2tcrNJeZ7dQ+QwqQ6
X-Received: by 2002:a05:701b:4349:b0:1a9:d04f:1b55 with SMTP id
 a92af1059eb24-1ac5d0da4acmr3932044c88.26.1793382520030; 
 Fri, 30 Oct 2026 10:48:40 -0700 (PDT)
Received: from DPBox.lan ([45.207.158.52]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac192c27cdsm14041310c88.10.2026.10.30.10.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 10:48:39 -0700 (PDT)
From: MuXian Chen <a18165943161@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, simona@ffwll.ch,
 MuXian Chen <a18165943161@gmail.com>
Subject: [PATCH v2] drm/amd/display: drop RGBA8888 from plane format lists
Date: Sat, 31 Oct 2026 01:48:25 +0800
Message-ID: <20261030174825.14233-1-a18165943161@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030171816.11610-1-a18165943161@gmail.com>
References: <20261030171816.11610-1-a18165943161@gmail.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DC's enum surface_pixel_format has no RGBA8888 (memory order A,B,G,R):
fill_dc_plane_info_and_addr() has no case for it and returns -EINVAL.
Yet rgb_formats[] and overlay_formats[] advertise DRM_FORMAT_RGBA8888, so
compositors (KWin on Wayland) pick it for layers with alpha and every
atomic commit fails once per frame, flooding dmesg with

  amdgpu 0000:06:00.0: [drm] *ERROR* Unsupported screen format RA24
  little-endian (0x34324152)

and forcing a fallback to composition on every frame.

Remove the two entries.  No working configuration is lost: a plane that
advertises RGBA8888 can never convert it in fill_dc_plane_info_and_addr(),
on any display generation.

Update the KUnit expectations in dm_test_get_plane_formats() accordingly:
14/20/9/14 -> 13/19/8/13.

Tested on Raphael 610M (DCN 3.1.5): before, ~240 atomic commits per second
failed with -EINVAL; after, the plane format list no longer contains RA24
and dmesg is clean.

Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5339
Signed-off-by: MuXian Chen <a18165943161@gmail.com>
---
v2:
 - update dm_test_get_plane_formats() expectations after dropping RGBA8888
   (reported by Sashiko AI review).
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 5 +++--
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 8 ++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 9139823..6d5454f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -49,11 +49,13 @@
  * For future use cases we should either initialize them dynamically based on
  * plane capabilities, or initialize this array to all formats, so internal drm
  * check will succeed, and let DC implement proper check
+ *
+ * DC has no surface format for DRM_FORMAT_RGBA8888, so it must not be
+ * advertised here or in overlay_formats.
  */
 static const uint32_t rgb_formats[] = {
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_RGBA8888,
 	DRM_FORMAT_XRGB2101010,
 	DRM_FORMAT_XBGR2101010,
 	DRM_FORMAT_ARGB2101010,
@@ -70,7 +72,6 @@ static const uint32_t rgb_formats[] = {
 static const uint32_t overlay_formats[] = {
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_RGBA8888,
 	DRM_FORMAT_XBGR8888,
 	DRM_FORMAT_ABGR8888,
 	DRM_FORMAT_RGB565,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 7422e8b..3e7ef6d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -277,20 +277,20 @@ static void dm_test_get_plane_formats(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, universal_cap);
 
 	plane->type = DRM_PLANE_TYPE_PRIMARY;
-	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_plane_formats(plane, NULL, formats, 32), 14);
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_plane_formats(plane, NULL, formats, 32), 13);
 
 	cap->pixel_format_support.nv12 = true;
 	cap->pixel_format_support.p010 = true;
 	cap->pixel_format_support.fp16 = true;
-	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_plane_formats(plane, cap, formats, 32), 20);
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_plane_formats(plane, cap, formats, 32), 19);
 
 	plane->type = DRM_PLANE_TYPE_OVERLAY;
-	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_plane_formats(plane, NULL, formats, 32), 9);
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_plane_formats(plane, NULL, formats, 32), 8);
 
 	universal_cap->type = DC_PLANE_TYPE_DCN_UNIVERSAL;
 	KUNIT_EXPECT_EQ(test,
 			amdgpu_dm_plane_get_plane_formats(plane, universal_cap, formats, 32),
-			14);
+			13);
 
 	plane->type = DRM_PLANE_TYPE_CURSOR;
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_plane_formats(plane, NULL, formats, 32), 1);
-- 
2.56.0

