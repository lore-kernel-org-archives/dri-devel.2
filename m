Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78144606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=XMODGxoP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E5BE10E9FF;
	Sun,  1 Nov 2026 12:01:39 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE10A10E0B7;
 Sat, 31 Oct 2026 15:39:51 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jH2GG28hFzMlcN;
 Sat, 31 Oct 2026 16:39:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793461190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=adnGSaSpP4BAdVI9adsOus4fU610Llwk+z/mzctLwuc=;
 b=XMODGxoP8K0i2JmT5G3NAunZ8O8RDukJhXUb82dntJS/qmHlCV8SLhBZC5T8z65tiGMK+a
 OhOH5Qj+QupkaZUB0lHW3E1LgArMVAkdHMmGVZH+leT267/1YqfsKk+eu+PsLa1bk/jarO
 IF08S1OAzP5/2pGXqPYMG6OaS6xgyqepCq3Fyolr25HU/BFPcgME6dgxOiypeBjPS2KK/b
 aNtVMUSc9tKkOFJgEqXEqn4Wc1dlBE96STrxcGqKPACc4mvc6MjGJXhToRXH308e+0Fofx
 +8ZvvGThFB8xHg/EWiyDqoRLcI128HvvZI/HtCs0sjYbXzuagTRf1fx9BNi6Og==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: alexander.deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: superm1@kernel.org, lijo.lazar@amd.com, harry.wentland@amd.com,
 alex.hung@amd.com, kees@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Clamp the ATIF backlight curve to its 99 points
Date: Sat, 31 Oct 2026 15:39:48 +0000
Message-ID: <20261031153948.127016-1-hugo@hsal.es>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jH2GG28hFzMlcN
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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

amdgpu_atif_query_backlight_caps() stores the firmware's number_of_points
as data_points but copies only the 99 points that luminance_data[] holds.
number_of_points is a u8, so a firmware table that claims more makes the
custom curve code in amdgpu_dm index past the array, and
dm_query_extended_brightness_caps() copy past the end of the
data_points[] buffer it fills

Clamp the count to ATIF_QBTC_MAX_DATA_POINTS and warn, since a table
that claims more is a firmware bug

Fixes: f729e63743f0 ("drm/amd: Pass luminance data to amdgpu_dm_backlight_caps")
Signed-off-by: Hugo Sales <hugo@hsal.es>
---
The other ATIF checks log at debug level because they make the call fail
and the driver falls back to its defaults. Here the driver keeps going
with a truncated curve, so this one warns

 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 63088c072087a..4874ee864b807 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -406,7 +406,11 @@ int amdgpu_atif_query_backlight_caps(struct amdgpu_atif *atif)
 			characteristics.max_input_signal;
 	atif->backlight_caps.ac_level = characteristics.ac_level;
 	atif->backlight_caps.dc_level = characteristics.dc_level;
-	atif->backlight_caps.data_points = characteristics.number_of_points;
+	if (characteristics.number_of_points > ATIF_QBTC_MAX_DATA_POINTS)
+		pr_warn(FW_BUG "ATIF: backlight curve has %u points, using the first %u\n",
+			characteristics.number_of_points, ATIF_QBTC_MAX_DATA_POINTS);
+	atif->backlight_caps.data_points = min_t(u8, characteristics.number_of_points,
+						 ATIF_QBTC_MAX_DATA_POINTS);
 	memcpy(atif->backlight_caps.luminance_data,
 	       characteristics.data_points,
 	       sizeof(atif->backlight_caps.luminance_data));
-- 
2.56.0

