Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C669CC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:00:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1779D10E3CE;
	Mon, 21 Sep 2026 07:00:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="anPahbY4";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C398D10E589
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 22:35:12 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1cebcb8d7so574303a12.0
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 15:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789857312; x=1790462112; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nKBMCnqQxAVAZA5OoEBqOOWoLHoxQT5GMnJh9vvIW74=;
 b=anPahbY4usLQOEh3HjciZOsCUommUmrj18P0zqwID4i3IC45czPnl3O8RJ5lnCpy3N
 vl5wy2MJsvsiu6MtMFYhK7o1eqD6XpL59S0drJQk2QzNylUgnHj+5WMWjRDDOIWupI1K
 E1sVbCw8N8m++bHu4+2hLLqsR6bNiIl0LWQlF7X/vhFdvcuWn6x6dvC1xIYlRc8vwOz1
 veSiWLk+nEdCEVL3DFDEDUB77PbLsJ0UJNvbsdYd8KJenlCh3QwfGN97x1S7SMYVTF1M
 BkRlj1GjbI4l3uqMTPAmiiyx7LScu3leVdXd3ld8t7gIV+DwTqEWq415n5VdCvFzGekj
 oxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789857312; x=1790462112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nKBMCnqQxAVAZA5OoEBqOOWoLHoxQT5GMnJh9vvIW74=;
 b=QdLNMCByf1IwU9stwC6chhEGmNG8NUR5dNaQO1dnhsMbPWqbGCe0zxvCuksf3KgrsE
 jtKria3lyt/CMhpSsiMgRW2CY/U/UgNPSgPexx9fD1XhKHlhiwq0Z0mQfunWsToMXYws
 omNpqhjp+Hnhizj3+jlGWGNnCIYPr7j66MWdeOqMTyI3PvgmIEmzKZ2CGLc8o9U/0aX3
 QEJ+dibpAQhKvCoj+Wo3sbxQXyXrlhgojpZEsRIZ85tcWUrJYkNbs1ZXytO9PuHjbT2m
 OGrThuBTReTvntDY2dwn7BFUu3nNyZMQY4bVHqUYogc+oqSAcWQ9z1DpZFNFavcBvPzk
 AM3w==
X-Gm-Message-State: AFuF++kY/JlekRlOGtQvUJehC+ym3mEYNUn/3o/fjUrFx/DLGJhKJqm7
 RNUT+l4eKF26rV4gtpuATy0Z34iBctpDynyNtcjwTSGqZOqQfURwiEgV
X-Gm-Gg: AYBFou3pbqaIIbYtVpico9oPw5fG6S7aIf/bMnKQbRio86+SmKnr9Nx69RQAvz64DYB
 aOe2x8/NO/YR011C+uoCeUWdZ48QnVZpqvZLl4Mhi8p2/dURYU3j/dYWg69P3CrGL6eK7R4r+sL
 Au9thOqVnioA3+u9SI+9wuPXCKpIspMvQKSmOnyKfqKM0AYvHwiqEqjMzyEb5MNnwkmQKGAAK4l
 s13dUEg3TPX38OYN7S2Yom5j6GGE29lUS4A9VZY7Vv8PqtaWgObeYQtI3+zdJ1umUIxLTqjINXd
 wTc/SmFHY98gtQwTUNcAAQNRghnyqiuGmzjU19NyVJQ6u4K7y/Aa5JSrCDQDhl+mvKqQqgZ/Grl
 cbwDdLKUNGpBnKXr3tqReOm2eeN40aOMLwVi1ZTIoSV0uyqFnav5wx6UvJNJsrxGaJBzMLRtond
 4/fbmmTWgy7be+qu1u5Pmq5gixTqVkrdr84aVWIReADUdJN7wLTKxa9aL2bah0J6cKPlLpZGZd1
 +3WisDzA+vbqW38pNzu9uc6SnEf9AzHO+zID1WdNvqI2NyJ874IbPr/iK30BptC+WJJAKHtM3uW
 Ent9JeiSwI8=
X-Received: by 2002:a17:902:d2d2:b0:2dd:ad73:5b5a with SMTP id
 d9443c01a7336-2ddb224f33bmr75712475ad.21.1789857312166; 
 Sat, 19 Sep 2026 15:35:12 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ddc179dbd5sm13215505ad.39.2026.09.19.15.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 15:35:11 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: airlied@redhat.com, sean@poorly.run, tzimmermann@suse.de, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/udl: reject short USB EDID control transfers and fix URB
 init cleanup
Date: Sat, 19 Sep 2026 22:35:11 +0000
Message-ID: <20260919223511.3889061-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

In drivers/gpu/drm/udl/ (udl_drv.c, udl_edid.c), check that
usb_control_msg() returns the full 2-byte response in
udl_read_edid_block() before copying read_buff[1], and clean up
allocated URBs if udl_Driver initialization fails.

Fixes: 5320918b9a87 ("drm/udl: initial UDL driver (v4)")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/gpu/drm/udl/udl_drv.c b/drivers/gpu/drm/udl/udl_drv.c
index 1922988625eb..239a6983f49f 100644
--- a/drivers/gpu/drm/udl/udl_drv.c
+++ b/drivers/gpu/drm/udl/udl_drv.c
@@ -97,8 +97,10 @@ static int udl_usb_probe(struct usb_interface *interface,
 		return PTR_ERR(udl);
 
 	r = drm_dev_register(&udl->drm, 0);
-	if (r)
+	if (r) {
+		udl_drop_usb(udl);
 		return r;
+	}
 
 	DRM_INFO("Initialized udl on minor %d\n", udl->drm.primary->index);
 
diff --git a/drivers/gpu/drm/udl/udl_edid.c b/drivers/gpu/drm/udl/udl_edid.c
index af4cff2a7c51..b7c462436573 100644
--- a/drivers/gpu/drm/udl/udl_edid.c
+++ b/drivers/gpu/drm/udl/udl_edid.c
@@ -36,7 +36,7 @@ static int udl_read_edid_block(void *data, u8 *buf, unsigned int block, size_t l
 		if (ret < 0) {
 			drm_err(dev, "Read EDID byte %zu failed err %x\n", i, ret);
 			goto err_drm_dev_exit;
-		} else if (ret < 1) {
+		} else if (ret != 2) {
 			ret = -EIO;
 			drm_err(dev, "Read EDID byte %zu failed\n", i);
 			goto err_drm_dev_exit;
