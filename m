Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399B3CA5FEF
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 16:16:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60B1010E5C5;
	Sat,  3 Oct 2026 16:15:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dm0BSHuJ";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 183FA10E2B9
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 16:15:55 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso6027295e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 09:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791044153; x=1791648953; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ya85XkpyrpMe6Lfgalo1nGODKz5TM2XHUGeehhaYQEs=;
 b=dm0BSHuJe2NDpCZ7h3uZ90YR/YwAnxmUosWLlfcbSriJn3xMF5ZX1nDpjhEXxURk0L
 XrMIPzEEwXrsin/FD+yMt1VkLhy0YaiDUQC+pueyOAwcG6HuKfvY8Wpr4GZDv6VJ1dhg
 vTgNqQlGreD3jfdSJdrFOrK7LZt43roqGJukDu5iSaroC2hV+tkRjDmVTFnvTtba5jf9
 uIxEqO/6hMIahDB49LRa6qvo/UAO22BY9X7AayyUNtKXhOw462fBBYA6mrYOTureQeTu
 E+gpBbU6bkETRbf91HhE7FJ6W0+z8yEeq0kyEajak18GepXUiYtQ9wga+O3SgYDXNXEu
 X4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791044153; x=1791648953;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ya85XkpyrpMe6Lfgalo1nGODKz5TM2XHUGeehhaYQEs=;
 b=iX3VB0LIeBVnzzMsrTBWiUYZN1vvUjgaVCkByo5GdMSGvuGyTURFx8HRtmsBTFcELE
 8Jo4UUcv/iT0tbtwe0+0T72td61OyLjgncFV9BCkH7evc9lF3Cj8OfUMSay5ed2ifdYu
 XQzCVPqjccXwmazXnn0+siRf9uWdkrncSXCCHmtr7coWuKJuUJkQ081jBMKjPPxX4mv/
 FaGNBP7UMF4AIkDalJHL+Jr4TGVfibAS9rq/kLUYfw3F+qDJRGpkeiGXhB3X4zBtWvAk
 4VCe/o9fSXEgTW2QQ+SfV+61cCi/crL+0J4zce5S6oQ6sxWShNHGzV851MQVM4DnAriz
 xjnQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCHgkAaJslbr4Urvduvib9RlDbln4IqyeQ6l6LqjmNaeQXDqMUAUYwBOYAXehRAF77hCJoZWx3elE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l56Hv9I23Yjkce51NGk3qDRDOkYvKT3Jq2n1CbYPHxlVl9AF3S
 GqlM5jj6mCOUkAhVvgzKIIc57jrbvYYlqwQSmHpBTMb3n5PFNlzxGjVg
X-Gm-Gg: AYBFou1Z2nMGALbov9TqUbzbZukES/nyxN3cKoYkbRGbfShS5ILdpPEQzNnncld/0XG
 Zq7dD7KNT9SjMqzyMg2aeM675dHnWsgw9AOyeRs8qF2RxXii0G4u3cl9oXmblePOrQqu5JSPjdt
 qQCOkEHy8OvvuUd2X0taIITd0aYnUAUVxUuaBxpe5LFM4hFX45D5TUiLFioLmDh88vD7u2NyqXj
 h8fcOlXZ49T92uP64XvzyI1e6OIPnNDXXoQxyV8mYXpgIBTc2RzEHO00B9mqkdrf884h30sTX6x
 jnvsU3V8BwPF+BepD/W6xaZJMwS7ameTVomb0xLZHlQLX6nUQUALJdCQBFIMeWbd2plOcx7nQp3
 864QgCY2qrePj7tuxOIpYq419+pYcyjWelsF1Bhi2d1la5HIWmkB54tT2iaZHUqurlbLijjRtMs
 3B6O3XN5cvmf6pON89dJCOq1xOSfOnAfJ6VOXyXfooVQhU4e4RdKo+eyeq7oqJCFe0a2VYMXalR
 /VmzkapiHr1nBh4OjmnaMs6Ap9ZZDbGwzvSj6CQlTdvhcrTLSCzy/DoBgX79sQ2GLsx
X-Received: by 2002:a05:600c:4e13:b0:49c:cee0:e7c1 with SMTP id
 5b1f17b1804b1-4a02757999cmr98416455e9.16.1791044153155; 
 Sat, 03 Oct 2026 09:15:53 -0700 (PDT)
Received: from localhost
 (p200300eba703ae00ca7f54fffe019321.dip0.t-ipconnect.de.
 [2003:eb:a703:ae00:ca7f:54ff:fe01:9321])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a02854073csm167309945e9.3.2026.10.03.09.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 09:15:52 -0700 (PDT)
From: =?UTF-8?q?Johannes=20W=C3=BCller?= <johanneswueller@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: =?UTF-8?q?Johannes=20W=C3=BCller?= <johanneswueller@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@intel.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 2/2] drm/amd: fix HDMI signal type for EDID overrides
Date: Sat,  3 Oct 2026 18:15:08 +0200
Message-ID: <20261003161525.23600-3-johanneswueller@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261003161525.23600-1-johanneswueller@gmail.com>
References: <20261003161525.23600-1-johanneswueller@gmail.com>
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
v2: rebased; create_eml_sink() now lives in amdgpu_dm_connector.c.

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c  | 9 ++++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c    | 9 ++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index ad3383169d83..2bce57b06037 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -2134,7 +2134,14 @@ VISIBLE_IF_KUNIT void create_eml_sink(struct amdgpu_dm_connector *aconnector)
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
index 5c74f19fc33a..9f4465682088 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -223,7 +223,14 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
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
 
 	if (edid_caps->edid_hdmi) {
 		edid_caps->qs_bit = connector->display_info.rgb_quant_range_selectable;
-- 
2.56.0

