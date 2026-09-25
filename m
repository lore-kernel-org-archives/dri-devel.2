Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9261CA5FA4
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 648A710E89D;
	Mon, 28 Sep 2026 08:42:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FEU85VGS";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B514C10FA91
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 13:26:10 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b91369d18so6241145e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 06:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790342769; x=1790947569; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=06duDdNGXEXO3D6IjmbJBB78lIY9/9EMnDOm9nOMKis=;
 b=FEU85VGSWZawhyIEDwFcsAt56AfpgsIPVYgTgYCKFuvi3Z15A0B00pCplAKIbLSnQw
 dQAazeyKDL3I/T/G7mtsR/2t4htzqYsQRVNMewwTqPhm9yrKr3lGfN/mTZ1ggCFAb9Fr
 AQYv5XcGu+X/rDXCL0yjP/LqDFVf8pjiQlQThWcGgkaOFEw706imCCucqT/Z+zkDv1E0
 Fa1byu/fs+I3z1yJ5nQSlyqoGThFAaCmoCAaFq4zXLJn5n6jH5PrLrPREGFaPKnMUZzm
 D8ZTRCOILXxD6wOd61PVCYxQjJZogXSOtzZI5b8Aunr1V2uuq96Jkx+vzA+2jWkbmnMm
 7gXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790342769; x=1790947569;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=06duDdNGXEXO3D6IjmbJBB78lIY9/9EMnDOm9nOMKis=;
 b=x7uBsSfMgeGNFdwiZ6pOs4C8Oe14bYG8qIoi5qPe1ZWV2P78Wg+WiByvwidaMccIZ+
 fquEKmREaONbfrT0c/k/J3MCfdl6WC5QCu0O4kirQD0guoD744n5280rFyO5MOxbWldM
 7f5yQZlVfm2Zn3Br9eBPqgd6AvoMXa6vxtNCRfRRpGzZVOURytaLjOR5+Cdx7TrEtpmX
 5j3GkGJdrj1zkRTMCJJAeOxgeR16fpV9+R6jfYA0juHfC+q1m/mslZ5Eq24RWHqZjhgE
 Yq+SsQPlM5783H+m7Su8aSEYmAnrc7vmZPh2gCQcCRESM+7OsT0mOJEwKfyq397Ue+YF
 CFjg==
X-Gm-Message-State: AFuF++mfz5HqE7yMkSHywgvH5nawIucnrgV9S6zpTl55+AvZh1hi2I7/
 bAQOTLpRCoRRdcMR/vr0Mhqyfh+S0GdggbLzHzuHrwvOd2pWeSrkwg5g
X-Gm-Gg: AYBFou3vfMwL+mbHzmMnrxhKrPBoHQYBS67TbSaW00RJfjhtqEMqpLucCRPqBO72+Je
 20dKFW22SANFBteK9M66MDdxodiDDFBrDmEC7+Ec1EnbbUpKX1VkVC7jjisDWn01jar3Tad1wcf
 skZ/RQCu6/qQ040e3zHBAEX1H1F0229fnQ27pI0UCNooaUXydxei2Uspf/Dk2NhamIsYmIPgtxa
 IbkkhzMBpZI+SA5/OvSBn6IZa06XQ2DvmcQPZYMTt98nME7swkgWoiAPuACWSFdoXDPRieB7cSY
 FuYI6cIFOKPIS8lYMJAv0ZSNqc++l7wRzu+QlWOKTieQcevYcStGAaqtovUsVbqxwRgluuq5yHs
 2hq09NZBgejYO8iujPIC1N7eOG2AnAZz+kcB0pBzEWr02X960RJ8cJvNKrPDcKOR7m6YeSE0RRe
 mouynUpKGJ3OESQmkPoKEY8mWCo09SzMsbcjmoGOjkc6YvQvQTRzrbyOWnp1q7XxWDGQ8zWXe0/
 dCG5PcAsg==
X-Received: by 2002:a05:600c:6087:b0:49f:df99:ff13 with SMTP id
 5b1f17b1804b1-49fe66e652cmr93012705e9.21.1790342768794; 
 Fri, 25 Sep 2026 06:26:08 -0700 (PDT)
Received: from localhost.localdomain ([194.154.195.114])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4887a354c47sm7488028f8f.15.2026.09.25.06.26.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:26:08 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Douglas Anderson <dianders@chromium.org>,
 Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/dp: don't mark the AUX backlight enabled when enabling
 failed
Date: Fri, 25 Sep 2026 15:25:58 +0200
Message-ID: <20260925132558.27518-1-okerixx@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:42 +0000
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

If drm_edp_backlight_enable() fails, dp_aux_backlight_update_status()
still marks the backlight as enabled. From then on every brightness
change only updates the level and the enable is never retried, so the
panel stays dark until something blanks and unblanks the backlight.

I hit this after resume on a Samsung ATNA OLED panel, where the first
AUX write can fail while the panel is still waking up.

Return the error instead, so the next update tries to enable again.

Fixes: 10f7b40e4f30 ("drm/panel: add basic DP AUX backlight support")
Signed-off-by: Oleg Keri <okerixx@gmail.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -4634,7 +4634,9 @@ static int dp_aux_backlight_update_status(struct backlight_device *bd)
 
 	if (!backlight_is_blank(bd)) {
 		if (!bl->enabled) {
-			drm_edp_backlight_enable(bl->aux, &bl->info, brightness);
+			ret = drm_edp_backlight_enable(bl->aux, &bl->info, brightness);
+			if (ret)
+				return ret;
 			bl->enabled = true;
 			return 0;
 		}

base-commit: 4c253ac4b29b8c6cc6fdef8f92d4facde62e63b9
-- 
2.55.0
