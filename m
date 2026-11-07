Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D65606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tWmLWarb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3727A10EB76;
	Sat,  7 Nov 2026 14:28:27 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DEB010E35C
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 09:02:57 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cdab8873d9dso577306a12.1
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 01:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794042177; x=1794646977; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Msgr/ei5SuDAvl2P+N05cPht0vpFHzkCnX6RCf+TJHk=;
 b=tWmLWarbUNx4bdzTm1tVW4Q8jX9kMrT7u+ypVZXSiMuJMSlk+0+qXpZZSD3VB8k9v2
 8m7OX6HLXcPg2E+NdKY9F8Rc1TgsHTddPk8PA3Wj2N33M2uH7/+MzENP4qOnN2oW/h5l
 CYNMT/DWDhtlRf8QZoRTgG9JXzHgJ3YpWtOgbkNMPVHvB9VGqQbQLsR7P4izu86E/RxW
 hOpDRgnCpB66obpgBfaLB5hPpmXKDTJw9snmouEQkeKbwGBWaoZTbRAf5iiTYGECLwyt
 YHKFUGQJWFP6ReEpgI9a5yFjiWcwtSNXQCmDkkKOoIRVUcNMOwAIys3hBkq0KipPFUDk
 WFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794042177; x=1794646977;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Msgr/ei5SuDAvl2P+N05cPht0vpFHzkCnX6RCf+TJHk=;
 b=s4vQAu1qMJ6XCcbbeIzIZ1aENiOcstSbovzDn2Omp8kbQTnSeo8pMzy+h/zA8czQiJ
 PAKu2nUiDY2RTSNiFPDta+dhsZVoW++tOCzqkI/Cd8IyXSr/4LG+EzAYguYlyzmQ30E1
 c38v7CiQrIFBfuVkiI2rD83b71FsiY0eL1EuDNXk99lZHF/ka0XgPERYj0R2k4lv1eMj
 H1JkYyTk2wLeUbdRqGneXBqqlO2nbi23DQfzo1ijiaw1FF8Ae+6nJyB7YoVv0YARnJHq
 FLLrsn9u/vvu6QUH01uQtZqLmj6oTviKnHOzdKuSUN8EmQSmCwWYxosAMpUhIIWttVAR
 l7sg==
X-Gm-Message-State: APuU4Z9eo1g3jkjfbE6DaX0ialwCGga1A6b9zLbrYS8/p7LeAW13jyXk
 90imm573CDdc07EuKnDejQGoV8qW18IgcscmVVSXP8ZBPJ1ZOjw6fMhwEXKEEoH7
X-Gm-Gg: AYBFou1kuNbyjQZkW84objHo+eoBUhUFvmzr9MAOqENxMdZhsh+3hZYy6x9nbgEXH6Q
 2dwiMS8U0CXjLpc8gqJxW+8i0S9jBxJ2VZLDPMq5v4PzS+wRHoRAXUCCRwC08rCis9BIvqjVWZ/
 mRX4rrc10vwsdoaqZcHjH6MbWkq7Agnglg3ClZy+VEmvfN+5WJpKJsSl3dAWKFqDifTqFRyiPF4
 lihMyBve9fwy1lZxF1Qyek7SY5UmHsNwRI/iVQSTmXADz9vtKCYuecl99aeIl0Umf3I0PaoLr4K
 ZlqvDy+qC6WbPg6P2m6mj30oi/9RN79cVmWuI3aYGnwQ8jOFmVTySCP+q+cm6NefpiHXESn9PGk
 v1umiJC0sT7oWfn9xTKW1h5NGjjuW4/prNMqLCFIPt4mOCRQ9De3FMDfDYYmplNYTWbc45necDu
 NOi65MCa1BSsdj+zluU4rscGCuSXipUDi36IJIJ4JXdMKZtS9unthRQkBX4Ud4ZyvRA9kZOt6F+
 uy7ei1mpqq4CHKGA4ECFBQgNRviheIyTjLDU7EKmm4bD2u1pdTAFLrv+A371o/dGnsN7oUnR8wh
 thmSK6hYlz82kOpk/SmEzPlzodl+iLpRe+mFvbxeBwsGzqjrT2EW3CbsXFhDpgEdYzFxYZSJalL
 2gWG3m56Pmtn3un88XQo/8b134b0aBA6DPeMY0on/woqZRC/v6g==
X-Received: by 2002:a17:90b:3889:b0:3ac:a521:960 with SMTP id
 98e67ed59e1d1-3b0db5f1305mr5282291a91.1.1794042176597; 
 Sat, 07 Nov 2026 01:02:56 -0800 (PST)
Received: from Karthik ([2405:201:c01e:69e8:376b:daa2:909a:eabb])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed47528e35sm11773085ad.5.2026.11.07.01.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 01:02:55 -0800 (PST)
From: Karthik Sarvan <karthiks1mail@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de, louis.chauvet@bootlin.com, melissa.srw@gmail.com,
 simona@ffwll.ch, oaroraetimis@gmail.com,
 Karthik Sarvan <karthiks1mail@gmail.com>
Subject: [PATCH v2] drm/vkms: Set preferred_depth to 24 for XRGB8888 default
Date: Sat,  7 Nov 2026 14:32:38 +0530
Message-ID: <20261107090238.18181-1-karthiks1mail@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 14:28:21 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VKMS defaults to XRGB8888, which has a color depth of 24 bits stored
in a 32 bpp container. Setting preferred_depth to 24 reports the actual
depth to userspace (such as Xorg) via DRM_CAP_DUMB_PREFERRED_DEPTH
rather than returning 0, while keeping the fbdev default intact.

Signed-off-by: Karthik Sarvan <karthiks1mail@gmail.com>
Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>
---
v2:
- Add commit description (Thomas Zimmermann).
- Collect Reviewed-by from Oarora Etimis.
- Resend as standalone thread per reviewer request.

 drivers/gpu/drm/vkms/vkms_drv.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 5a640b531d88..10337889b1b0 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -146,12 +146,8 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
 	dev->mode_config.max_height = YRES_MAX;
 	dev->mode_config.cursor_width = 512;
 	dev->mode_config.cursor_height = 512;
-	/*
-	 * FIXME: There's a confusion between bpp and depth between this and
-	 * fbdev helpers. We have to go with 0, meaning "pick the default",
-	 * which is XRGB8888 in all cases.
-	 */
-	dev->mode_config.preferred_depth = 0;
+	/* XRGB8888 has 24 bits of color data stored in 32 bits per pixel. */
+	dev->mode_config.preferred_depth = 24;
 	dev->mode_config.helper_private = &vkms_mode_config_helpers;
 
 	return vkms_output_init(vkmsdev);
-- 
2.56.0

