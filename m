Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9767C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 04:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1945810E4CB;
	Mon, 14 Sep 2026 04:07:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="BZf66e8z";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 445FA10E4CB
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 04:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789358867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rCoc2R/ijUeWuWPNV3TxEtpKBXnNgpWvgPneT9lSNbM=;
 b=BZf66e8zoMb1s00LKEKUOyl1DOXPlTaAMssOeLMenzp507OwBKaZfxV8xn5W6QbgKFILkT
 N+bo0JpPDtnV7AUvLbWQPVkERROfywOBVw2UWgqZxZ2OII7J0p9mQHEj0cDVw7xq0o0HC6
 5pV9plDzhbhOnFs1dabD1v0JMK9yM4o=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-2oTWmfODOoW5_2QJc9qLpA-1; Mon, 14 Sep 2026 00:07:45 -0400
X-MC-Unique: 2oTWmfODOoW5_2QJc9qLpA-1
X-Mimecast-MFC-AGG-ID: 2oTWmfODOoW5_2QJc9qLpA_1789358864
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5b75a9f9199so2235841e87.2
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789358863; x=1789963663;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rCoc2R/ijUeWuWPNV3TxEtpKBXnNgpWvgPneT9lSNbM=;
 b=U1KkDudKf4SmB17Zn2J3QN58kxQNc8u/PXzw1QLKtSPFG1wWipLaykCdaCy0MHO/PP
 Om7agKlLpvusYaEV2xrkBj5AC+rQEwMkAEaDaj6cwCXVRybqQs/ObTfYMtOkSrsYBMBY
 OvvJHdCUjxIfq6y0Ud8+WkfXss1hW72Sdqs6K5vqrBvgL5BeENE7oijLLt1oSbe3DkK6
 AcAexiB+z0ai9ouvSbvcuQ8zPY5fkh5SFffTuHlJuW5AxL+qr4GsgHb99yyUSDQ1V6iy
 i8xgwwJ7T8/ahvz6F5WYdIp+tBGwLYOntQFQipm47yPD1jhRq7UZE5putbEUyxcafMJF
 71Jg==
X-Gm-Message-State: AFuF++kmVtcc9QH3idIhik9SvBbH42Ma2MyOqDpB8yQnxSRIG19qXlvC
 js1fID2bglfUQpmfo0h70X4NjP9o6IPl5hP2Xd5uNVZPAFu1lih5uy1mKXPYmxVixXFqUi0EvXb
 bu8tS0I+la/jbo8/TliKNfGikhNzAOvzfJbtBFww1brDA8jxA+5IgEdXDR6WLu4PYpwCDiEYE3M
 htaH39PfFD1FUFMeutJmYENFB8jKCqvHb19xyGlB9xO11fEBrc1dxZ
X-Gm-Gg: AYBFou3WeB+n3aGM6nTTlKzZz4ZEt0NaBYBV8PHEc3AyGDGcnHCF/ZdPjHRube3VX1V
 95JZ8uFwXH8633tq2MJ7ArdSOJdpQ+12cgGjbiKn2q/negqve2c3BezgsRJjBNMT8CABoHU/AwC
 DGbwPL02Fv0DicVBoqN4RadGNk5bP3wycUTwyo/27kf0oHdDHJj5R1Q9xkM+2H03uPUsIRS53/H
 V94XkCy92Yj731AYioduviwMzVNASo94xSCD77PmvlbhTjiVyTnIjujg2a7yqfriZq3/wZE/ifX
 PtOEVacNVxhMIaSXlHbty9SErwvZpW366Avb+JxRgHF0mJkwsIBgGMZLtxvfDEaKdIEDJtKI+q2
 nR+HuiPNIYXZ1jA6lqDqf
X-Received: by 2002:a05:6512:3347:b0:5b1:5ccf:5268 with SMTP id
 2adb3069b0e04-5b8ae67d301mr224140e87.1.1789358863596; 
 Sun, 13 Sep 2026 21:07:43 -0700 (PDT)
X-Received: by 2002:a05:6512:3347:b0:5b1:5ccf:5268 with SMTP id
 2adb3069b0e04-5b8ae67d301mr224127e87.1.1789358863047; 
 Sun, 13 Sep 2026 21:07:43 -0700 (PDT)
Received: from fedora (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a0456c11sm2098666e87.21.2026.09.13.21.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 21:07:42 -0700 (PDT)
From: mpenttil@redhat.com
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
 =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
 Maxime Ripard <mripard@kernel.org>
Subject: [PATCH] drm/tests: hdmi: fix infoframes tests
Date: Mon, 14 Sep 2026 07:07:23 +0300
Message-ID: <20260914040723.2593700-1-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XWHiZrQbPoxY61-N48NPbiopYetoESJTVndL-LhvpyM_1789358864
X-Mimecast-Originator: redhat.com
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Mika Penttilä <mpenttil@redhat.com>

drm_atomic_commit() calls drm_atomic_check_only() internally. Calling
drm_atomic_check_only() explicitly before the commit leaves the state
marked as checked and triggers drm_WARN_ON(state->checked) when the
commit checks the state again.

Remove the redundant explicit checks.

Fixes: 7436a87db99d ("drm/tests: hdmi: check the infoframes behaviour")
Cc: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
---
 .../drm/tests/drm_hdmi_state_helper_test.c    | 54 -------------------
 1 file changed, 54 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 353a261d42da..f8ae1a0bd5c0 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -2929,15 +2929,6 @@ static void drm_test_check_infoframes(struct kunit *test)
 
 	old_hdmi_update_failures = priv->hdmi_update_failures;
 
-	ret = drm_atomic_check_only(state);
-	if (ret == -EDEADLK) {
-		drm_atomic_commit_clear(state);
-		ret = drm_modeset_backoff(&ctx);
-		if (!ret)
-			goto retry_crtc_state;
-	}
-	KUNIT_ASSERT_EQ(test, ret, 0);
-
 	ret = drm_atomic_commit(state);
 	if (ret == -EDEADLK) {
 		drm_atomic_commit_clear(state);
@@ -3034,15 +3025,6 @@ static void drm_test_check_reject_avi_infoframe(struct kunit *test)
 
 	old_hdmi_update_failures = priv->hdmi_update_failures;
 
-	ret = drm_atomic_check_only(state);
-	if (ret == -EDEADLK) {
-		drm_atomic_commit_clear(state);
-		ret = drm_modeset_backoff(&ctx);
-		if (!ret)
-			goto retry_crtc_state;
-	}
-	KUNIT_ASSERT_EQ(test, ret, 0);
-
 	ret = drm_atomic_commit(state);
 	if (ret == -EDEADLK) {
 		drm_atomic_commit_clear(state);
@@ -3153,15 +3135,6 @@ static void drm_test_check_reject_hdr_infoframe_bpc_8(struct kunit *test)
 
 	old_hdmi_update_failures = priv->hdmi_update_failures;
 
-	ret = drm_atomic_check_only(state);
-	if (ret == -EDEADLK) {
-		drm_atomic_commit_clear(state);
-		ret = drm_modeset_backoff(&ctx);
-		if (!ret)
-			goto retry_conn_state;
-	}
-	KUNIT_ASSERT_EQ(test, ret, 0);
-
 	ret = drm_atomic_commit(state);
 	if (ret == -EDEADLK) {
 		drm_atomic_commit_clear(state);
@@ -3276,15 +3249,6 @@ static void drm_test_check_reject_hdr_infoframe_bpc_10(struct kunit *test)
 
 	old_hdmi_update_failures = priv->hdmi_update_failures;
 
-	ret = drm_atomic_check_only(state);
-	if (ret == -EDEADLK) {
-		drm_atomic_commit_clear(state);
-		ret = drm_modeset_backoff(&ctx);
-		if (!ret)
-			goto retry_conn_state;
-	}
-	KUNIT_ASSERT_EQ(test, ret, 0);
-
 	ret = drm_atomic_commit(state);
 	if (ret == -EDEADLK) {
 		drm_atomic_commit_clear(state);
@@ -3387,15 +3351,6 @@ static void drm_test_check_reject_audio_infoframe(struct kunit *test)
 
 	old_hdmi_update_failures = priv->hdmi_update_failures;
 
-	ret = drm_atomic_check_only(state);
-	if (ret == -EDEADLK) {
-		drm_atomic_commit_clear(state);
-		ret = drm_modeset_backoff(&ctx);
-		if (!ret)
-			goto retry_crtc_state;
-	}
-	KUNIT_ASSERT_EQ(test, ret, 0);
-
 	ret = drm_atomic_commit(state);
 	if (ret == -EDEADLK) {
 		drm_atomic_commit_clear(state);
@@ -3438,15 +3393,6 @@ static void drm_test_check_reject_audio_infoframe(struct kunit *test)
 
 	old_hdmi_update_failures = priv->hdmi_update_failures;
 
-	ret = drm_atomic_check_only(state);
-	if (ret == -EDEADLK) {
-		drm_atomic_commit_clear(state);
-		ret = drm_modeset_backoff(&ctx);
-		if (!ret)
-			goto retry_crtc_state_2;
-	}
-	KUNIT_ASSERT_EQ(test, ret, 0);
-
 	ret = drm_atomic_commit(state);
 	if (ret == -EDEADLK) {
 		drm_atomic_commit_clear(state);
-- 
2.55.0

