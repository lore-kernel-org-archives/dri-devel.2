Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3716F606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=QuftJV5R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98CA510EA0C;
	Sun,  1 Nov 2026 12:00:45 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84B3A10E04D;
 Sat, 31 Oct 2026 13:45:56 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jGzkp37xMzMlJj;
 Sat, 31 Oct 2026 14:45:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793454354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RzSVGEDnt2v1e9IyCd8MHB2A0CzuAV9Q0LfSGRDAFgI=;
 b=QuftJV5RoQJ/tif+CucklESWieMZDr1Odfv4IGM4qi4XF2jE/29KtAzPM9Q8uMp9XjgY46
 hkSyKeqkZcyOTCD/70ifIftg31slmxnlMoin4I6cRWtZCNhZlUXTYUl2bmWmbxmwz+vkJs
 QPeAKSlmRMSqFr5kRLUp2l9+ore60YwqkJHILoSP6psKtyByrICC601gV/4Wykp8xIsgbm
 x8MjIAGl6FOufLFO7i26bv4D+ukgzNpzWyr7HZS61H36WccwgDLUM0MHMSJyFAwDHIYspl
 qo3dvdo+1C83uu/bcfUvK5opty1baNeR45jfykDDCcqjxCVCR3QAKPbywkFCzQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, simona@ffwll.ch, superm1@kernel.org,
 alexander.deucher@amd.com, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: panel-backlight-quirks: Add ASUS ROG Flow X13 3840x2400
 panel
Date: Sat, 31 Oct 2026 13:45:51 +0000
Message-ID: <20261031134551.2735792-1-hugo@hsal.es>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jGzkp37xMzMlJj
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

On an ASUS ROG Flow X13 GV301QH (BIOS 418) ATIF
QUERY_BACKLIGHT_TRANSFER_CHARACTERISTICS answers with a minimum input
signal of 12 and 49 curve points for the Sharp LQ134R1JW51 panel, and
amdgpu logs "Using custom brightness curve". With that minimum,
brightness 0 gives 4.7% duty

With the quirk, brightness 0 sends PWM 0 (read back from
amdgpu_current_backlight_pwm in debugfs). The panel stays lit, but much
dimmer than the old 4.7% floor. Its LED driver has a minimum of its own,
so 0 does not turn the backlight off

linux-hardware.org also lists this panel in a GV301QE. Match the ASUS
vendor and the panel, as the Framework 13 entries do, and let the
brightness reach the bottom of the PWM range

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
I could only test this on a GV301QH. The entry matches any ASUS laptop
with this panel, and linux-hardware.org only lists it in ROG Flow X13s,
one of them a GV301QE. If you'd rather limit it to the GV301QH, I can
add a DMI_BOARD_NAME match in v2

 drivers/gpu/drm/drm_panel_backlight_quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
index 2d0238382ebd5..b60333e748741 100644
--- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
+++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
@@ -69,6 +69,14 @@ static const struct drm_get_panel_backlight_quirk drm_panel_min_backlight_quirks
 		.dmi_match_other.value = "Galileo",
 		.quirk = { .min_brightness = 1, },
 	},
+	/* ASUS ROG Flow X13 3840x2400 panel */
+	{
+		.dmi_match.field = DMI_SYS_VENDOR,
+		.dmi_match.value = "ASUSTeK COMPUTER INC.",
+		.ident.panel_id = drm_edid_encode_panel_id('S', 'H', 'P', 0x151b),
+		.ident.name = "LQ134R1JW51",
+		.quirk = { .min_brightness = 1, },
+	},
 	/* Have OLED Panels with brightness issue when last byte is 0/1 */
 	{
 		.dmi_match.field = DMI_SYS_VENDOR,
-- 
2.56.0

