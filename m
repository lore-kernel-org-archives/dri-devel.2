Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF68606D811
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=H3W4IZre
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C1B110FAB8;
	Wed,  4 Nov 2026 09:55:32 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CECC310FAB1;
 Wed,  4 Nov 2026 09:55:25 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jKLQy3jftzKp5C;
 Wed, 04 Nov 2026 10:55:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793786122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i2FCQmEXZxDKQqcnu9pkHrDLOEfTmGF5gpWGt15wdhI=;
 b=H3W4IZreX+st8oDtTRlUnsvZVZN7KIZ2Kc9R7msnEuNKIJ+sWxJ/OjAFEWrB4YRh+/HSUF
 sIduUMUukfvKj4drqZ55hzIF96IXeIvDXE9920GUmG4Pe53Yo6aK+OcE17u+Tnaq73YFDL
 ZKz5YPBc/0icxTGwNNOCz9XTscz4lDeZExQgkhXo/f0z6Z7Z9zvirxQCghWnshd1pd9icz
 BcQNqyFZ7lSMWAziiX/is1Q6R7Kg+1nA/GJS5Q1gvAtdyFiZOyON4xLcVCMiOCxxyrXLCU
 6ZlkrAb7eN6hLSIMMDf3tfeCpXMEyRr1F7LjC/9N9/iEKLVdEjRfC8Yhj2I44g==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: alexander.deucher@amd.com, sunpeng.li@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, amd-gfx@lists.freedesktop.org
Cc: Hugo Sales <hugo@hsal.es>, ray.wu@amd.com, simona@ffwll.ch,
 alex.hung@amd.com, mario.limonciello@amd.com, linux-kernel@vger.kernel.org,
 lohita.mudimela@amd.com, bhawanpreet.lakha@amd.com,
 dri-devel@lists.freedesktop.org, roman.li@amd.com, airlied@gmail.com,
 christian.koenig@amd.com
Subject: [PATCH RFC RFT 2/8] drm/amd/display: Interpolate between backlight
 LUT entries
Date: Wed,  4 Nov 2026 09:55:10 +0000
Message-ID: <20261103-backlight-curve-rfc-v1-2-6e4813a8f2eb@hsal.es>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103-backlight-curve-rfc-v1-0-6e4813a8f2eb@hsal.es>
References: <20261103-backlight-curve-rfc-v1-0-6e4813a8f2eb@hsal.es>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3956; i=hugo@hsal.es;
 h=from:subject:message-id; bh=ZSz/RMblfQ0zJlVinD3vgNgodrBoJz7mNpa5XoTpSXU=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsl7xRL1dtzwqReOLy8lXF20XvvQvtDuVk+Vbs2JL0
 umWFQf7nu3pKGVhEONikBVTZNG94cnAMnHyzJyi50tg5rAygQxh4OIUgIkEXWT4Z+imfsGnWEuW
 z+C73OQ/vRPMT4nGf5faUd6sKR+1xGpdFiPDtqDC16yRK5TW7WGdc/NFiMX3jKTeTlVHc5E1vJO
 4RbcxAAA5pEjS
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jKLQy3jftzKp5C
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

backlight_millipercent_to_pwm_legacy() takes the floor index into
backlight_lut, which has one entry per percent of luminance. Any request
between two whole percents gets the PWM of the lower one, so a PWM panel
has at most 101 brightness levels however fine the request is

Interpolate linearly between the entries on each side of the request.
Whole percents still give the LUT entry. The result never decreases as
the request grows, since validate_ext_backlight_caps() only accepts a
curve whose signals and luminances strictly increase, so the LUT never
decreases either. The linear curve bypass and the 100% case are
unchanged

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
amdgpu_dm only hands the power module whole percents until patch 4, so
on its own this patch changes no PWM for it. Coming first keeps patch 4
from dropping a level to the whole percent below

With patch 4 too, on the GV301QH curve with minimum 12, the 62452 levels
from user_min to user_max reach the panel as 57821 different PWM values.
Without the series they give 99, and patch 4 without this patch would
give 100. The bottom tenth of the scale goes from 18 PWM values to 5434

BACKLIGHT_MILLIPERCENT_MAX is defined at the top of power_abm.c as
100 * 1000. mod_power_create() sets num_backlight_levels to at least
101 and allocates backlight_lut with that many entries, and nothing
changes it afterwards, so index + 1 stays within the LUT. The function
still returns early with fewer than 2 levels, as
backlight_pwm_to_millipercent_legacy() already does

KUnit: dm_test_pwm_lut_between_percents, dm_test_pwm_lut_monotonic and
dm_test_pwm_lut_min_input_signal from patch 6 fail without this patch
and pass with it
---
 .../gpu/drm/amd/display/modules/power/power_abm.c  | 29 ++++++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_abm.c b/drivers/gpu/drm/amd/display/modules/power/power_abm.c
index 5e86889eaa841..d9c1f1401b604 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_abm.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_abm.c
@@ -524,6 +524,9 @@ static unsigned int backlight_millipercent_to_pwm_legacy(
 {
 	unsigned int pwm = (unsigned int)-1;
 	unsigned int index = 0;
+	unsigned int lower, upper;
+	unsigned long long scaled;
+	unsigned int remainder;
 
 	if (core_power == NULL)
 		return 0;
@@ -541,17 +544,33 @@ static unsigned int backlight_millipercent_to_pwm_legacy(
 		return pwm;
 	}
 
-	if (millipercent >= (100 * 1000))
+	if (millipercent >= BACKLIGHT_MILLIPERCENT_MAX)
 		return core_power->bl_prop[inst].backlight_lut[core_power->bl_prop[inst].num_backlight_levels - 1];
 
-	/* This will give the floor index. */
-	index = ((core_power->bl_prop[inst].num_backlight_levels - 1) *
-						millipercent) / 100000;
 	/* Null check otherwise eDP doesn't lightup when connected to DP1 */
 	if (core_power->bl_prop[inst].backlight_lut == NULL)
 		return pwm;
 
-	pwm = core_power->bl_prop[inst].backlight_lut[index];
+	if (core_power->bl_prop[inst].num_backlight_levels < 2)
+		return pwm;
+
+	/*
+	 * Interpolate between the two LUT entries around millipercent.
+	 * backlight_lut has num_backlight_levels entries, and millipercent is
+	 * below BACKLIGHT_MILLIPERCENT_MAX here, so index + 1 stays within it
+	 */
+	scaled = (unsigned long long)(core_power->bl_prop[inst].num_backlight_levels - 1) *
+		 millipercent;
+	index = (unsigned int)div_u64_rem(scaled, BACKLIGHT_MILLIPERCENT_MAX, &remainder);
+	lower = core_power->bl_prop[inst].backlight_lut[index];
+	upper = core_power->bl_prop[inst].backlight_lut[index + 1];
+
+	if (upper <= lower)
+		return lower;
+
+	pwm = lower + (unsigned int)div_u64((unsigned long long)(upper - lower) * remainder +
+					    BACKLIGHT_MILLIPERCENT_MAX / 2,
+					    BACKLIGHT_MILLIPERCENT_MAX);
 
 	return pwm;
 }

-- 
2.56.0

