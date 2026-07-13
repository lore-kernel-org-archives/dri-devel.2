Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB5FC44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E46010EB51;
	Mon, 13 Jul 2026 22:36:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JvC0l00d";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E3D210E655
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 18:39:04 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-493c52cde9eso31058665e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 11:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783967942; x=1784572742; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zd5o6Ej/s5YZL/Mnfze+Lcvp2kVDTJWSbodyoJwd+Bc=;
 b=JvC0l00dC7cj4COn6E2bhVpxBjIQ1fVJh1tIUk6Eq2PRiASOn45Kf2C88ov+1LeyaC
 9XGA5IG89x6gk6n/fagxMstyEC5d6eZkUD/xYfPSwH3oGSnPuhrXlkzNQ7RSrBvfVuoq
 6+4Wjthg2VljV7Sp2C/horq+kyppR1snWOvEAfhexCHddAFD2Kob1g+eHgVeNbkeo8n+
 8OWLkILfpujTI/5vRtpyqPma3Zd5Aeqi/6Z9GxefG38VE8iIQ/9Cjb4zHthnAYNi7ESO
 sbkj5uOIMnLk0+/WgWZxxt+U5kpyXS+B8QDjy5YYB7Su6UkDZzxIxgvH+ZwSU472r7dD
 NErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783967942; x=1784572742;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zd5o6Ej/s5YZL/Mnfze+Lcvp2kVDTJWSbodyoJwd+Bc=;
 b=YKOEJHQLUiNw7INwfG4SGzx0WyDlIZni02BkmgKBx24O+HkiPrVV5wbnWNmRXJM4np
 ZF30HGHU6QKn7Y/EsawmsYHBKwYuHHM5YskQsv0A8Bvw4ZKGf00aai8ep/0H6xjJxJxq
 32HSJyoq8pDxpqLFBv5v7Ajq7IliQEJyh2aIk1D6m/8wdcQkctrhcRRb2S7SxbfxpN7O
 a4YUwOsyXNam6JBOQYRZ8ywEG+orMPh39m9VSUQxGKRuehZAzcmZL3rdzkY+y3Qtcleb
 JwHwrhriuYCnbS7StfnJCw0ILgzi77azEwUyRTbzQ1V+W38ygDvOyfrRHIOqjpEKre8l
 lQOA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrF1l1gbNa3TICCUGXQ6ndDQFJw1NoKXLe6PHtqsGTvxJBdxWHljDe9/g1bZA3Bms5DwfIhNRq7ZV0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsUT1TWGIXohIF2b/R7pGhyJU9eSS6U8ckodLXHG5bOkbgdo4Z
 8H5blyBCjIFoxXCQxbaUDj1aCYhHGF+NppfpVflEZXIrLK/kN4rSWkCB
X-Gm-Gg: AfdE7clrbpZLphR5yzikKtxv86LhTc4rZOfR2+Ct79C02fnxkKJSpcZK4H8GofXhl1x
 Pyli9fZC+oZfxkXCnWtJlakKFu4Hptc21mthph4I36zG19DgkglgirPpB3e0qP9BaJ9Qct5pIRu
 3IF4UR0iMkD6QJ1MQg/VG2DZRK0rWH8lSopGdcYKunUBae+Myh0hRtEQsdzW6v+sr2gP5Yzjiro
 tQyh0Jogo47FVUZi7OvsqxAUaNoYtNXOw4+29uEZoiW9bJN5+loNFR0l1eVTwc4x8B/REYC6NgC
 QUzD3OK7hbH6ZPb/pIUW8otmyW6RB1De0KCGgwQnDkVxSDonn5uVPpPcLC9mXOV9a8bLpY1vbt7
 Htb4lETsEN16bl9N9RNxO3oVG3xa+a2knLnOyr6Rw3XzD49Q+CETqswGp9d6TbWmM+ChkxGc3pT
 igKrh+7Bh8BSOp61KmvGmPkJ95lh+A
X-Received: by 2002:a05:600d:109:b0:493:e8bc:a75b with SMTP id
 5b1f17b1804b1-493f882b13cmr69903995e9.30.1783967942492; 
 Mon, 13 Jul 2026 11:39:02 -0700 (PDT)
Received: from timo-z13.fritz.box ([193.30.163.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm14702455e9.4.2026.07.13.11.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 11:39:02 -0700 (PDT)
From: =?UTF-8?q?Timo=20Pr=C3=B6mer?= <timo.proemer04@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Timo=20Pr=C3=B6mer?= <timo.proemer04@gmail.com>
Subject: [PATCH 2/2] drm/amd/display: Use drm_edid_block_count() instead of
 raw extensions
Date: Mon, 13 Jul 2026 20:38:41 +0200
Message-ID: <20260713183841.5921-3-timo.proemer04@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713183841.5921-1-timo.proemer04@gmail.com>
References: <20260713183841.5921-1-timo.proemer04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Jul 2026 22:35:59 +0000
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

Instead of manually calculating the EDID block count by reading the
extensions field from the raw edid structure (`edid->extensions + 1`),
utilize the core DRM helper `drm_edid_block_count()`.

This now includes possible HF-EEODB extension blocks, which are not
included in `edid->extensions` and were previously truncated with the
`memmove`.

Signed-off-by: Timo Prömer <timo.proemer04@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index c6f94eb71..ac5a3b337 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1160,6 +1160,7 @@ enum dc_edid_status dm_helpers_read_local_edid(
 	struct drm_connector *connector = &aconnector->base;
 	struct i2c_adapter *ddc;
 	int retry = 25;
+	int block_count;
 	enum dc_edid_status edid_status = EDID_NO_RESPONSE;
 	const struct drm_edid *drm_edid;
 	const struct edid *edid;
@@ -1205,7 +1206,9 @@ enum dc_edid_status dm_helpers_read_local_edid(
 		    edid->extensions >= sizeof(sink->dc_edid.raw_edid) / EDID_LENGTH)
 			return EDID_BAD_INPUT;
 
-		sink->dc_edid.length = EDID_LENGTH * (edid->extensions + 1);
+		block_count = drm_edid_block_count(drm_edid);
+
+		sink->dc_edid.length = EDID_LENGTH * block_count;
 		memmove(sink->dc_edid.raw_edid, (uint8_t *)edid, sink->dc_edid.length);
 
 		/* We don't need the original edid anymore */
-- 
2.55.0

