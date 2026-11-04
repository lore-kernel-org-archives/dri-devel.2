Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4BE606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=aK5E77qf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3165910E87E;
	Wed,  4 Nov 2026 10:31:27 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AC1310E87E;
 Wed,  4 Nov 2026 10:31:19 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jKMDP1NQ6zKpD1;
 Wed, 04 Nov 2026 11:31:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793788277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mpWDUgWNllYmwWDvt+1cOKqE19b+6BZOvtWPf9+ZuFk=;
 b=aK5E77qf73KmN+YPG22apwu/2bqTkeyzt0slNGeQ/r6uuWmGtCN8wPhkc4He1cgO0GrqoS
 /bx/rwKubp62WdH4+mmLF46fCJLRqTmBYvmjt8G79ZkfiKJvWgbdXlpgOMNXTVwaigm2mo
 o3PGYwciV2fX/iXXKD8UgHDhRfd/XXkIrvtXF4YDH411PYWeJMFVhdZ88t2TS/Pyu+IaQ1
 EBLr7DflM+KRzlTk0c9Yo9MIMMS1aJIl9Kh3ABOGUFsEvugr662v5iGujRVlR6BIYU90Ng
 YI6Z+Q2yMSlArBucyXVZrZvvuHVjDADpC58hq/aFG2Q4IzIMWMHNwVCHE+hTLA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: harry.wentland@amd.com, siqueira@igalia.com, amd-gfx@lists.freedesktop.org,
 sunpeng.li@amd.com, alexander.deucher@amd.com
Cc: Hugo Sales <hugo@hsal.es>, mario.limonciello@amd.com,
 christian.koenig@amd.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, simona@ffwll.ch, alex.hung@amd.com,
 airlied@gmail.com
Subject: [PATCH RFC 1/3] drm/amd/display: Repair or drop a bad ATIF backlight
 curve
Date: Wed,  4 Nov 2026 10:31:10 +0000
Message-ID: <20261104-backlight-curve-validate-v1-1-10c688880e85@hsal.es>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104-backlight-curve-validate-v1-0-10c688880e85@hsal.es>
References: <20261104-backlight-curve-validate-v1-0-10c688880e85@hsal.es>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3990; i=hugo@hsal.es;
 h=from:subject:message-id; bh=eGsJybhymdSdbkuQZPExKFHX3+TH4+OvLoaQiagrmMo=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsl5zFtRHpwuUbNVaGlNWendFPMufzJ+uj20tzyyX3
 pjPpT8ruL6jlIVBjItBVkyRRfeGJwPLxMkzc4qeL4GZw8oEMoSBi1MAJmLuxPBX0L44Rudjvt/L
 3RKTU5gkr72fOMlsYei0OmHWFvnHfy0WMjJcL77CxNEimmT+cJupgs+ekM0886dzbVhxl5Orv67
 Y/icHADBzRZo=
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jKMDP1NQ6zKpD1
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The custom brightness curve code expects the input signals and
luminances of the ATIF curve to increase monotonically. They come from
firmware as u8 values, and nothing checks them

Check the curve once, in amdgpu_dm_validate_backlight_caps(), next to
the signal range check. If a signal falls, drop the curve and map
linearly. Cap a luminance over 100% at 100%, and raise a luminance that
falls back to the one before it. When the check changes the curve, warn
about a firmware bug

The curve code only caps its result at 100%. A point over 100% then
makes the curve reach full brightness before that point and stay flat up
to it. With the point capped, the curve reaches full brightness at the
point itself

Dropping the curve also changes ABM. The power module rejected a curve
whose signals fall and built its default quadratic LUT. With no points
it builds a linear LUT over the firmware's signal range and uses the
firmware's AC and DC levels, as it does when firmware reports no curve.
The power module still rejects a capped or raised luminance, as before

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
The data_points clamp duplicates "drm/amdgpu: Clamp the ATIF backlight
curve to its 99 points", which fixes the overflow where the ATIF reply
is read:
https://lore.kernel.org/r/20261031153948.127016-1-hugo@hsal.es
This check stays correct whichever of the two lands first

The check keeps a repeated signal, which the mapping steps over as
before. It sits in amdgpu_dm rather than in
amdgpu_atif_query_backlight_caps() so KUnit on UML, which has no ACPI,
can reach it
---
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 358ba0c73d795..3a27fb956627a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -52,6 +52,48 @@
 #include "dm_helpers.h"
 
 #if defined(CONFIG_ACPI) || IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+/*
+ * The brightness mapping needs signals that never fall from point to point
+ * and luminance that never falls or passes 100%. Drop a curve whose
+ * signals fall, and flatten the luminance of the others
+ */
+static void backlight_validate_custom_curve(struct amdgpu_display_manager *dm,
+					    struct amdgpu_dm_backlight_caps *caps)
+{
+	struct amdgpu_dm_luminance_data *p = caps->luminance_data;
+	int over = 0, falling = 0;
+	int i;
+
+	if (caps->data_points > ARRAY_SIZE(caps->luminance_data))
+		caps->data_points = ARRAY_SIZE(caps->luminance_data);
+
+	for (i = 1; i < caps->data_points; i++) {
+		if (p[i].input_signal < p[i - 1].input_signal) {
+			drm_warn(adev_to_drm(dm->adev), FW_BUG
+				 "ATIF: backlight curve signal %u at point %d is below %u, using a linear curve\n",
+				 p[i].input_signal, i, p[i - 1].input_signal);
+			caps->data_points = 0;
+			return;
+		}
+	}
+
+	for (i = 0; i < caps->data_points; i++) {
+		if (p[i].luminance > 100) {
+			p[i].luminance = 100;
+			over++;
+		}
+		if (i && p[i].luminance < p[i - 1].luminance) {
+			p[i].luminance = p[i - 1].luminance;
+			falling++;
+		}
+	}
+
+	if (over || falling)
+		drm_warn(adev_to_drm(dm->adev), FW_BUG
+			 "ATIF: backlight curve has %d points over 100%%, set to 100%%, and %d falling points, raised to the point before\n",
+			 over, falling);
+}
+
 STATIC_IFN_KUNIT
 void amdgpu_dm_validate_backlight_caps(struct amdgpu_display_manager *dm, int bl_idx)
 {
@@ -66,6 +108,8 @@ void amdgpu_dm_validate_backlight_caps(struct amdgpu_display_manager *dm, int bl
 			    caps->min_input_signal, caps->max_input_signal);
 		caps->caps_valid = false;
 	}
+
+	backlight_validate_custom_curve(dm, caps);
 }
 EXPORT_IF_KUNIT(amdgpu_dm_validate_backlight_caps);
 #endif

-- 
2.56.0

