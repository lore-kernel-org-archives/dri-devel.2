Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECD8F30283
	for <dri-devel@archiver.kernel.org>; Sun, 15 Mar 2026 22:34:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5DB010E19B;
	Sun, 15 Mar 2026 22:34:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i/aSwf5L";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A7D910E1AA
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 22:34:57 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4852ff06541so44344725e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 15:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773614096; x=1774218896; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jQzZONnM4aIeZD+RlnEew9gmqoqVacuTTfndGoL0Obc=;
 b=i/aSwf5L+nM3ryc9HyMBa7714BeOkDF3Ykiv0guAmFwLjMp7yQ+jpwBAhEM5jFs1vn
 Ts4QvuCNZLf7uZr7Q2YM38Lp1sJZ4zQctAJ/ZwkGjqsTTckYcPr5MC17KlF87C6r+XPU
 uYxgK92TwTVbwWxC2/v6oSWYcEIC4MMT0oOWJy8yvy/6kbgO4I3BUDVUJhOhwWZLd9Mh
 2p9AZaxPpG5UUqJBssZJ19kOvkUHBqAUdTlC9nM4vIPOSvzubxd9SqrpTrwYIjOx5LTt
 4sDqsJdOiaqeZcHGdqkSVyDmZpWW7Hj4R3dpBak84jEuAXO5/okAMTx4aAJfAcDZA9z+
 5ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773614096; x=1774218896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jQzZONnM4aIeZD+RlnEew9gmqoqVacuTTfndGoL0Obc=;
 b=GKYhUGlKqSK//xnPZ4Y0kuxPfLeFikoAOlgohU4G8+2LHC8JCHvKV3sDZx4AqK6GoQ
 mXtssFZTFKISh6JTA1ZFxRhKWPO/HdnGjdaghMFwxN/+tC701KWRD2TRAkXLJwbz1Sx/
 RgodRRKGZGn05crZ431pC2AWiLdH4jCOUzdaStGU9wczPdrVLeS0P1nkO3ezEL7v5GTA
 6KEXKjDk1m5AWVqAyScQOUVmZkTQDXw2mfRowiMwU4YmY98lOLoGE2XwU4LFkpGZkuI5
 v+8IbhfnejCACHQPlXWXXa7Z8iA6dTMUMaLlQo3C86eEpkczLOhEonxYdyt4L8RFzYdg
 9CXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/m+d9ZA2j4H4M8z1WkAVhs8Kgh9YcTPs8JSod+76f9w+V83awtF/t/e6DD8ZqXiAzq84n6cr87qM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzV4BvI4nj5u9dwAfJwi7ek/nqpg1bkRPaV3+ObEbfk8VYhcxUh
 akh7p8AChTAG1fj0ab1uBXSPcYluYW4wze6oT/xmE/zrAwoIq7/8NS+g
X-Gm-Gg: ATEYQzwiuv0phpCCLRIGMqb2YUsxaD3GHa9DFv6wgl1qRT/gzi8jaRBrHQ0uYQ1StQK
 QER48IJrZ0BbDfRHA/KapUu4ExjSFufH8rYa4CR0wVRY9ZB6Z0230PPDftOOcC15W4vx+ljicGD
 V8T0M42gSr8EdsIGJVmS5wRdjm7buzIrAOQ67lauFquJGBv+90tMH2M1+ttT7DIqnQdpf8F4jsE
 8QEZRslZxzIctlOk39HmdnVWkJAod0yxPhc1G8IGdtl7UOAJQYm/Z+IeJSBrcXUVqpXg9PFt0qt
 Kmv3pc/2yMioPXLK+BYxZmVKmb6ubdfpE3W/HAI0RWPQE0OPFkT5HG9Ge0S8LMwKaafKVyFjqj6
 WCSn9eFsjLUlprV8Iq2xkl7KXspftG3qd+4IecFAVBtvhD0zguZPEcbvwU8e/VbXCy4KQPfFgY7
 r6mWBvMZZxtSYN4Al7Lp9M5YbihdOt5Eloodav9dTSuOBSeZAYuvcU8n43Rdfgk8TWtAB+i9/TE
 EmdzoA+IDQKdRjkDGUZ
X-Received: by 2002:a05:600c:468e:b0:485:3f58:d9d with SMTP id
 5b1f17b1804b1-48556714b67mr178951105e9.32.1773614095582; 
 Sun, 15 Mar 2026 15:34:55 -0700 (PDT)
Received: from localhost
 (p200300eba70b6e00ca7f54fffe019321.dip0.t-ipconnect.de.
 [2003:eb:a70b:6e00:ca7f:54ff:fe01:9321])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541aa73dasm1128568445e9.2.2026.03.15.15.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 15:34:55 -0700 (PDT)
From: =?UTF-8?q?Johannes=20W=C3=BCller?= <johanneswueller@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Johannes=20W=C3=BCller?= <johanneswueller@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] drm/amd: fix HDMI signal type for EDID overrides
Date: Sun, 15 Mar 2026 23:33:04 +0100
Message-ID: <20260315223307.45807-3-johanneswueller@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260315223307.45807-1-johanneswueller@gmail.com>
References: <20260315223307.45807-1-johanneswueller@gmail.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

If an EDID override is in effect (e.g. via debugfs edid_override or
drm.edid_firmware kernel parameter), the overriding EDID may not
advertise capabilities matching the physical connector being used.
In that case, trust the physical connector type over the EDID in
create_eml_sink() and dm_helpers_parse_edid_caps().

Signed-off-by: Johannes Wüller <johanneswueller@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c        | 9 ++++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c    | 9 ++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ff09a5371cb2..bc853f7555a9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7911,7 +7911,14 @@ static void create_eml_sink(struct amdgpu_dm_connector *aconnector)
 		return;
 	}
 
-	if (connector->display_info.is_hdmi)
+	/*
+	 * If an EDID override is active, it may not advertise HDMI capability
+	 * even though the physical connector is HDMI. Trust the connector type.
+	 */
+	if (connector->display_info.is_hdmi ||
+	    (connector->edid_overridden &&
+	     (connector->connector_type == DRM_MODE_CONNECTOR_HDMIA ||
+	      connector->connector_type == DRM_MODE_CONNECTOR_HDMIB)))
 		init_params.sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
 
 	aconnector->drm_edid = drm_edid;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index d7b0b84b3865..36b6e37f1517 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -137,7 +137,14 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 				  edid_caps->display_name,
 				  AUDIO_INFO_DISPLAY_NAME_SIZE_IN_CHARS);
 
-	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
+	/*
+	 * If an EDID override is active, it may not advertise HDMI capability
+	 * even though the physical connector is HDMI. Trust the connector type.
+	 */
+	edid_caps->edid_hdmi = connector->display_info.is_hdmi ||
+		(connector->edid_overridden &&
+		 (connector->connector_type == DRM_MODE_CONNECTOR_HDMIA ||
+		  connector->connector_type == DRM_MODE_CONNECTOR_HDMIB));
 
 	if (edid_caps->edid_hdmi)
 		populate_hdmi_info_from_connector(&connector->display_info.hdmi, edid_caps);
-- 
2.53.0

