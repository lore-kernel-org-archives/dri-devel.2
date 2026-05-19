Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8ADCD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 14:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 650B410ED45;
	Tue, 19 May 2026 14:47:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="fAMxXSp+";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AF1C10ED52
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 14:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779202048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=giYYHrHxYHTkG5VVTzSY8R7Lmh6VjOaCPuVGGkOK6iA=;
 b=fAMxXSp+tssmCGHDZDnN5lygkFn131he0VHMTQAVPyZFhX1oSJfdEJ3rRd63AEXhvtHUeT
 mlZ/ehkhhG23qnla02ehdrFya1p5NII6jRaXNX4IYB6CV7QhMSgQY+1lKv/xoARRxJDRZh
 48R+QZoxd7YHN/6C4JJVR8Y8xwnsGPk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-8gznEiG3Nay6BYJLR43zmA-1; Tue, 19 May 2026 10:47:26 -0400
X-MC-Unique: 8gznEiG3Nay6BYJLR43zmA-1
X-Mimecast-MFC-AGG-ID: 8gznEiG3Nay6BYJLR43zmA_1779202046
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-44cc3c9b2feso3726839f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779202045; x=1779806845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=giYYHrHxYHTkG5VVTzSY8R7Lmh6VjOaCPuVGGkOK6iA=;
 b=E30IW/5wvBzSQgXqtMwNM3TKemBgRoUM6ZpR/KN6xzZUS/zvmD+1IW6SmHxH7DoD1P
 n2I1rXxUEcIWV4TW6JxKr+eEC79a6U3gghWEZgqtKpL1Ssfnn9QiPm3fHS/M9i73h831
 Qu3tALJArsrvtEg4plrtR2YfPxcs2QgQYKKMvagVXna6N+2mtigikUKFHALYxFrGREEn
 pfbbTNAf/17YhpkaHSFTS9UlFJR4ud/FBLqpctMBMmPPmDkbVocqOJzooJr9CgMmSXWE
 WgM0ecyMkkFLnft8kF9zz266t730n0k4fH0Ih3VTQsyC4CW4YE8P5G1pXSE+4OvP5oQE
 q4+g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Uxf7S7ctU+yZU5Tfl0x3o1Ac5XiNHCrTskv8OM5r3g+Gmsmrc00CcD/zpHMZeE6O3sT8ZW/cMG4o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+fo0J33QiI8H7PtKyBWlv0tigWsG+jFJgF77gu6XQqrdWdN18
 35A9+M288U1JcEGm392uoRcrpguuORZzD/LRPU3AZcVKm9h7MD1GtJ/ayOa3Zz+EwsGI1ehbiaP
 AyNI7737CDWajmqgV5/AAWE31EmdZPveB7g6ecL3QF3vCdmlqMftQuAQjy9UzGABVNSXxyA==
X-Gm-Gg: Acq92OHsLpvKofnuQCzHYyDEAxDXQJoMEfnhHSRoRVY3W3w7sqb/z/Y4iijCGEcst0K
 6bqe+d7d+1rylcea3M5znSMrjUmaZ0erb8r1LBzYIjSCQJVRPd6x+KEpX9JZ4yT4h5OVvztK33A
 ixfokQljyy7sBqqciIPAYzldhzgZ0dOOSDV3fqd5hUxJQc6jkBiTZ3PsAuJg+tttfw4KMSEx5Sw
 zaPVFLHCYSWc+srPNeY/IQPlYsII/yuArvfk2CvTsQ1VHQcV6X8MIppvDzYxu8Jx5HKrulj8nvy
 DQL4eSKtj0v3kMFZ+q3c5VIa9cniJtdTYsi4kwxdwx5aQoPsOX51spDnTBzF4i6VRlhG6MT8H8w
 RZERmB9u4Z18+2nihyjPXXt8qirfl+rZleAahuGrHId/WA50=
X-Received: by 2002:a05:6000:1ace:b0:43b:3b80:6776 with SMTP id
 ffacd0b85a97d-45e5c594c2cmr30926038f8f.30.1779202045473; 
 Tue, 19 May 2026 07:47:25 -0700 (PDT)
X-Received: by 2002:a05:6000:1ace:b0:43b:3b80:6776 with SMTP id
 ffacd0b85a97d-45e5c594c2cmr30925971f8f.30.1779202044996; 
 Tue, 19 May 2026 07:47:24 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a666fsm45731796f8f.36.2026.05.19.07.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 07:47:24 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jani Nikula <jani.nikula@intel.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: [PATCH 1/8] drm/display: hdmi: Add common TMDS character rate
 constants
Date: Tue, 19 May 2026 16:46:57 +0200
Message-ID: <20260519144712.1418302-2-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519144712.1418302-1-javierm@redhat.com>
References: <20260519144712.1418302-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FuiRZnkS4wwQuvHSt2JJeh2nY9tb5Do_ZdP_bXlVm0I_1779202046
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Several DRM drivers already define their own constants for minimum and
maximum TMDS character rates.

By defining common rate constants in a shared header, drivers can just use
them instead of having driver local define macros or use magic numbers.

The values defined in the <drm/display/drm_hdmi_helper.h> header correspond
to maximum TMDS character rates defined by each HDMI specification version:

  - DRM_HDMI_TMDS_CHAR_RATE_MIN:    25 MHz (minimum for all versions)
  - DRM_HDMI_TMDS_CHAR_RATE_MAX_1_0: 165 MHz (HDMI 1.0 maximum)
  - DRM_HDMI_TMDS_CHAR_RATE_MAX_1_3: 340 MHz (HDMI 1.3 maximum)
  - DRM_HDMI_TMDS_CHAR_RATE_MAX_2_0: 600 MHz (HDMI 2.0 maximum)

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 include/drm/display/drm_hdmi_helper.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/drm/display/drm_hdmi_helper.h b/include/drm/display/drm_hdmi_helper.h
index 9c31ed90516b..0ee246ff82e0 100644
--- a/include/drm/display/drm_hdmi_helper.h
+++ b/include/drm/display/drm_hdmi_helper.h
@@ -5,6 +5,12 @@
 
 #include <linux/hdmi.h>
 
+/* HDMI spec TMDS character rate limits (in Hz) */
+#define DRM_HDMI_TMDS_CHAR_RATE_MIN	25000000
+#define DRM_HDMI_TMDS_CHAR_RATE_MAX_1_0	165000000
+#define DRM_HDMI_TMDS_CHAR_RATE_MAX_1_3	340000000
+#define DRM_HDMI_TMDS_CHAR_RATE_MAX_2_0	600000000
+
 struct drm_connector;
 struct drm_connector_state;
 struct drm_display_mode;
-- 
2.54.0

