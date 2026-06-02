Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D0ACD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 12:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C52E810F01C;
	Tue,  2 Jun 2026 12:11:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=berkoc.com header.i=@berkoc.com header.b="QxOZ/v80";
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=berkoc.com header.i=@berkoc.com header.b="UmxQNmXB";
	dkim-atps=neutral
Received: from mail-01.1984.is (mail-01.1984.is [185.112.145.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6497910F01C
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 12:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com; 
 s=1984;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date
 :Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MkohThdmCBghVJ6kKfUL75hAjcPs15At7pwTQ+W5scU=; b=QxOZ/v80h2FY3gjZYxe4/leLgq
 /GOQxTfc74VDpo8uzy593GCn1jzZKXViBRg6dkOTOFhk9+XBb7WZCCMdwYe/YgWa4FyDTg2yzbMYk
 X9Y+JGnfzaFLFamghF3AjKnBrdyhSeFcCXeZDwCX4cCj1r3wSy8JCsx4g0SlJ89nPcIPJgLmfPZtQ
 aXtCrn3regzWFAxF7XkjWHEImH2IYMSb+6OC4DmybJ869pT5r/g1LuO51h3fxeqNCVBd39EniD6AC
 aEGYSIUmTuEuyFTBN87gnHxvZfURMwqrApWAgB/4BMp6xd5MTcK1Z1goo2IhGtfNUVY8gGzDQQIb0
 +Nm2zsHg==;
Received: from localhost by mail-01.1984.is with utf8esmtp (Exim 4.96)
 (envelope-from <me@berkoc.com>) id 1wUNxR-000OaN-0T;
 Tue, 02 Jun 2026 12:11:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=berkoc.com;
 i=@berkoc.com; q=dns/txt; s=me; t=1780402238; h=message-id : date :
 subject : cc : to : from : sender : reply-to;
 bh=MkohThdmCBghVJ6kKfUL75hAjcPs15At7pwTQ+W5scU=;
 b=UmxQNmXBXDWXcQ/lmer7OU43IVz9ispEClvSVvsDyBL3f3mYbcb23iFBZWmA7VYX6bnH1
 5CPuPMigJ20uktlwqprAm3mke74YF1ORXeyAW+Yw9PaKryLx/NDlmazsHbZDOxFhsoQ/uy+
 oVWwzrj/IZilKUM96bHBBClX2oUlX7oxsa3mYciOn0O7YivehbetAr0ysTBeUbpj12THmov
 2xRhniOqriyVqf4wMuCHIRa0k3Y26gBxT9XwS4G+5GY7kLRHQMYKyJlhHduw91NLxoIq3Ok
 3ROnt2eT+MpCMv9iS4D6r3xLKJVvox5TQ/hZ6wQnV9uKNYn3WUwjCqemckhw==
From: Berkant Koc <me@berkoc.com>
To: airlied@redhat.com
Cc: tzimmermann@suse.de, jfalempe@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, sam@ravnborg.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/mgag200: validate pixel clock against PLL range in
 mode_valid
Date: Tue, 02 Jun 2026 14:10:38 +0200
Message-ID: <1780402238.22b24b6f590c@berkoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: git-format-patch via Skynet
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com
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

The per-model pixpllc_atomic_check helpers for G200WB, G200EH, G200ER,
G200EV, G200EH3 and G200EW3 initialise m, n, p and s to zero and only
update them when the inner search loop finds a candidate whose delta
to the requested clock improves on the previous best. They return 0
unconditionally afterwards. If the requested pixel clock falls outside
the model's VCO window so that the outer guard skips every iteration,
no candidate is recorded and atomic_update later programs pixpllc->m - 1
(unsigned underflow) into PIXPLLCM/N/P. The result is a corrupted
output clock on those models.

Following Thomas Zimmermann's suggestion, reject such modes earlier in
the pipeline rather than inside atomic_check. Add an optional
pixpllc_mode_valid callback to struct mgag200_device_funcs and dispatch
it from the shared mgag200_crtc_helper_mode_valid. Each affected helper
provides an implementation that walks the same divider space as its
atomic_check counterpart and returns MODE_CLOCK_RANGE when no candidate
falls within the same 0.5% (5/1000) tolerance that g200se has always
enforced. Models without the callback (G200, G200SE, G200EH5) keep
their current behaviour.

Filtering at mode_valid time means the userspace mode list never
contains modes the PLL cannot synthesise, so atomic_check no longer has
to defend against an empty search loop and atomic_update is never
reached with zeroed pixpllc values.

Tested with static analysis against the linux-7.1-rc4 tree; runtime
confirmation on physical Matrox hardware welcome. checkpatch.pl --strict
clean.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Berkant Koc <me@berkoc.com>
Assisted-by: Claude:claude-opus-4-7 berkoc-pipeline
---
 drivers/gpu/drm/mgag200/mgag200_drv.h     |  8 ++++
 drivers/gpu/drm/mgag200/mgag200_g200eh.c  | 41 +++++++++++++++++++
 drivers/gpu/drm/mgag200/mgag200_g200eh3.c | 38 +++++++++++++++++
 drivers/gpu/drm/mgag200/mgag200_g200er.c  | 50 +++++++++++++++++++++++
 drivers/gpu/drm/mgag200/mgag200_g200ev.c  | 42 +++++++++++++++++++
 drivers/gpu/drm/mgag200/mgag200_g200ew3.c | 45 ++++++++++++++++++++
 drivers/gpu/drm/mgag200/mgag200_g200wb.c  | 41 +++++++++++++++++++
 drivers/gpu/drm/mgag200/mgag200_mode.c    | 13 ++++++
 8 files changed, 278 insertions(+)

diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.h b/drivers/gpu/drm/mgag200/mgag200_drv.h
index a875c4bf8c..3eae8756cc 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.h
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.h
@@ -248,6 +248,14 @@ struct mgag200_device_info {
 	}
 
 struct mgag200_device_funcs {
+	/*
+	 * Optional. Validate that @mode's pixel clock falls within the
+	 * model's PIXPLLC window. Called from mgag200_crtc_helper_mode_valid
+	 * so that out-of-range modes are filtered before atomic_check.
+	 */
+	enum drm_mode_status (*pixpllc_mode_valid)(struct drm_crtc *crtc,
+						   const struct drm_display_mode *mode);
+
 	/*
 	 * Validate that the given state can be programmed into PIXPLLC. On
 	 * success, the calculated parameters should be stored in the CRTC's
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200eh.c b/drivers/gpu/drm/mgag200/mgag200_g200eh.c
index d2aa931f57..189bb1671e 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200eh.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200eh.c
@@ -40,6 +40,46 @@ void mgag200_g200eh_init_registers(struct mga_device *mdev)
  * PIXPLLC
  */
 
+static enum drm_mode_status mgag200_g200eh_pixpllc_mode_valid(struct drm_crtc *crtc,
+							      const struct drm_display_mode *mode)
+{
+	static const unsigned int vcomax = 800000;
+	static const unsigned int vcomin = 400000;
+	static const unsigned int pllreffreq = 33333;
+
+	long clock = mode->clock;
+	unsigned int delta, tmpdelta, permitteddelta;
+	unsigned int testp, testm, testn;
+	unsigned int computed;
+
+	if (clock <= 0)
+		return MODE_CLOCK_LOW;
+
+	delta = 0xffffffff;
+	permitteddelta = clock * 5 / 1000;
+
+	for (testp = 16; testp > 0; testp >>= 1) {
+		if (clock * testp > vcomax)
+			continue;
+		if (clock * testp < vcomin)
+			continue;
+
+		for (testm = 1; testm < 33; testm++) {
+			for (testn = 17; testn < 257; testn++) {
+				computed = (pllreffreq * testn) / (testm * testp);
+				if (computed > clock)
+					tmpdelta = computed - clock;
+				else
+					tmpdelta = clock - computed;
+				if (tmpdelta < delta)
+					delta = tmpdelta;
+			}
+		}
+	}
+
+	return (delta > permitteddelta) ? MODE_CLOCK_RANGE : MODE_OK;
+}
+
 static int mgag200_g200eh_pixpllc_atomic_check(struct drm_crtc *crtc,
 					       struct drm_atomic_state *new_state)
 {
@@ -230,6 +270,7 @@ static const struct mgag200_device_info mgag200_g200eh_device_info =
 	MGAG200_DEVICE_INFO_INIT(2048, 2048, 37500, false, 1, 0, false);
 
 static const struct mgag200_device_funcs mgag200_g200eh_device_funcs = {
+	.pixpllc_mode_valid = mgag200_g200eh_pixpllc_mode_valid,
 	.pixpllc_atomic_check = mgag200_g200eh_pixpllc_atomic_check,
 	.pixpllc_atomic_update = mgag200_g200eh_pixpllc_atomic_update,
 };
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200eh3.c b/drivers/gpu/drm/mgag200/mgag200_g200eh3.c
index 7bea7a728f..621e4efb47 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200eh3.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200eh3.c
@@ -15,6 +15,43 @@
  * PIXPLLC
  */
 
+static enum drm_mode_status mgag200_g200eh3_pixpllc_mode_valid(struct drm_crtc *crtc,
+							       const struct drm_display_mode *mode)
+{
+	static const unsigned int vcomax = 3000000;
+	static const unsigned int vcomin = 1500000;
+	static const unsigned int pllreffreq = 25000;
+
+	long clock = mode->clock;
+	unsigned int delta, tmpdelta, permitteddelta;
+	unsigned int testm, testn;
+	unsigned int computed;
+
+	if (clock <= 0)
+		return MODE_CLOCK_LOW;
+
+	delta = 0xffffffff;
+	permitteddelta = clock * 5 / 1000;
+
+	for (testm = 150; testm >= 6; testm--) {
+		if (clock * testm > vcomax)
+			continue;
+		if (clock * testm < vcomin)
+			continue;
+		for (testn = 120; testn >= 60; testn--) {
+			computed = (pllreffreq * testn) / testm;
+			if (computed > clock)
+				tmpdelta = computed - clock;
+			else
+				tmpdelta = clock - computed;
+			if (tmpdelta < delta)
+				delta = tmpdelta;
+		}
+	}
+
+	return (delta > permitteddelta) ? MODE_CLOCK_RANGE : MODE_OK;
+}
+
 static int mgag200_g200eh3_pixpllc_atomic_check(struct drm_crtc *crtc,
 						struct drm_atomic_state *new_state)
 {
@@ -134,6 +171,7 @@ static const struct mgag200_device_info mgag200_g200eh3_device_info =
 	MGAG200_DEVICE_INFO_INIT(2048, 2048, 0, false, 1, 0, false);
 
 static const struct mgag200_device_funcs mgag200_g200eh3_device_funcs = {
+	.pixpllc_mode_valid = mgag200_g200eh3_pixpllc_mode_valid,
 	.pixpllc_atomic_check = mgag200_g200eh3_pixpllc_atomic_check,
 	.pixpllc_atomic_update = mgag200_g200eh_pixpllc_atomic_update, // same as G200EH
 };
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200er.c b/drivers/gpu/drm/mgag200/mgag200_g200er.c
index 8fa8fe943a..d030094ae4 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200er.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200er.c
@@ -57,6 +57,55 @@ static void mgag200_g200er_reset_tagfifo(struct mga_device *mdev)
  * PIXPLLC
  */
 
+static enum drm_mode_status mgag200_g200er_pixpllc_mode_valid(struct drm_crtc *crtc,
+							      const struct drm_display_mode *mode)
+{
+	static const unsigned int vcomax = 1488000;
+	static const unsigned int vcomin = 1056000;
+	static const unsigned int pllreffreq = 48000;
+	static const unsigned int m_div_val[] = { 1, 2, 4, 8 };
+
+	long clock = mode->clock;
+	unsigned int delta, tmpdelta, permitteddelta;
+	int testr, testn, testm, testo;
+	unsigned int computed, vco;
+
+	if (clock <= 0)
+		return MODE_CLOCK_LOW;
+
+	delta = 0xffffffff;
+	permitteddelta = clock * 5 / 1000;
+
+	for (testr = 0; testr < 4; testr++) {
+		if (delta == 0)
+			break;
+		for (testn = 5; testn < 129; testn++) {
+			if (delta == 0)
+				break;
+			for (testm = 3; testm >= 0; testm--) {
+				if (delta == 0)
+					break;
+				for (testo = 5; testo < 33; testo++) {
+					vco = pllreffreq * (testn + 1) / (testr + 1);
+					if (vco < vcomin)
+						continue;
+					if (vco > vcomax)
+						continue;
+					computed = vco / (m_div_val[testm] * (testo + 1));
+					if (computed > clock)
+						tmpdelta = computed - clock;
+					else
+						tmpdelta = clock - computed;
+					if (tmpdelta < delta)
+						delta = tmpdelta;
+				}
+			}
+		}
+	}
+
+	return (delta > permitteddelta) ? MODE_CLOCK_RANGE : MODE_OK;
+}
+
 static int mgag200_g200er_pixpllc_atomic_check(struct drm_crtc *crtc,
 					       struct drm_atomic_state *new_state)
 {
@@ -267,6 +316,7 @@ static const struct mgag200_device_info mgag200_g200er_device_info =
 	MGAG200_DEVICE_INFO_INIT(2048, 2048, 55000, false, 1, 0, false);
 
 static const struct mgag200_device_funcs mgag200_g200er_device_funcs = {
+	.pixpllc_mode_valid = mgag200_g200er_pixpllc_mode_valid,
 	.pixpllc_atomic_check = mgag200_g200er_pixpllc_atomic_check,
 	.pixpllc_atomic_update = mgag200_g200er_pixpllc_atomic_update,
 };
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200ev.c b/drivers/gpu/drm/mgag200/mgag200_g200ev.c
index 3fadbeb10a..8286e4d6ad 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200ev.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200ev.c
@@ -46,6 +46,47 @@ static void mgag200_g200ev_set_hiprilvl(struct mga_device *mdev)
  * PIXPLLC
  */
 
+static enum drm_mode_status mgag200_g200ev_pixpllc_mode_valid(struct drm_crtc *crtc,
+							      const struct drm_display_mode *mode)
+{
+	static const unsigned int vcomax = 550000;
+	static const unsigned int vcomin = 150000;
+	static const unsigned int pllreffreq = 50000;
+
+	long clock = mode->clock;
+	unsigned int delta, tmpdelta, permitteddelta;
+	unsigned int testp, testm, testn;
+	unsigned int computed;
+
+	if (clock <= 0)
+		return MODE_CLOCK_LOW;
+
+	delta = 0xffffffff;
+	permitteddelta = clock * 5 / 1000;
+
+	for (testp = 16; testp > 0; testp--) {
+		if (clock * testp > vcomax)
+			continue;
+		if (clock * testp < vcomin)
+			continue;
+
+		for (testn = 1; testn < 257; testn++) {
+			for (testm = 1; testm < 17; testm++) {
+				computed = (pllreffreq * testn) /
+					(testm * testp);
+				if (computed > clock)
+					tmpdelta = computed - clock;
+				else
+					tmpdelta = clock - computed;
+				if (tmpdelta < delta)
+					delta = tmpdelta;
+			}
+		}
+	}
+
+	return (delta > permitteddelta) ? MODE_CLOCK_RANGE : MODE_OK;
+}
+
 static int mgag200_g200ev_pixpllc_atomic_check(struct drm_crtc *crtc,
 					       struct drm_atomic_state *new_state)
 {
@@ -268,6 +309,7 @@ static const struct mgag200_device_info mgag200_g200ev_device_info =
 	MGAG200_DEVICE_INFO_INIT(2048, 2048, 32700, false, 0, 1, false);
 
 static const struct mgag200_device_funcs mgag200_g200ev_device_funcs = {
+	.pixpllc_mode_valid = mgag200_g200ev_pixpllc_mode_valid,
 	.pixpllc_atomic_check = mgag200_g200ev_pixpllc_atomic_check,
 	.pixpllc_atomic_update = mgag200_g200ev_pixpllc_atomic_update,
 };
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200ew3.c b/drivers/gpu/drm/mgag200/mgag200_g200ew3.c
index e387a455ea..8db95f4d13 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200ew3.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200ew3.c
@@ -22,6 +22,50 @@ static void mgag200_g200ew3_init_registers(struct mga_device *mdev)
  * PIXPLLC
  */
 
+static enum drm_mode_status mgag200_g200ew3_pixpllc_mode_valid(struct drm_crtc *crtc,
+							       const struct drm_display_mode *mode)
+{
+	static const unsigned int vcomax = 800000;
+	static const unsigned int vcomin = 400000;
+	static const unsigned int pllreffreq = 25000;
+
+	long clock = mode->clock;
+	unsigned int delta, tmpdelta, permitteddelta;
+	unsigned int testp, testm, testn, testp2;
+	unsigned int computed;
+
+	if (clock <= 0)
+		return MODE_CLOCK_LOW;
+
+	delta = 0xffffffff;
+	permitteddelta = clock * 5 / 1000;
+
+	for (testp = 1; testp < 8; testp++) {
+		for (testp2 = 1; testp2 < 8; testp2++) {
+			if (testp < testp2)
+				continue;
+			if ((clock * testp * testp2) > vcomax)
+				continue;
+			if ((clock * testp * testp2) < vcomin)
+				continue;
+			for (testm = 1; testm < 26; testm++) {
+				for (testn = 32; testn < 2048; testn++) {
+					computed = (pllreffreq * testn) /
+						(testm * testp * testp2);
+					if (computed > clock)
+						tmpdelta = computed - clock;
+					else
+						tmpdelta = clock - computed;
+					if (tmpdelta < delta)
+						delta = tmpdelta;
+				}
+			}
+		}
+	}
+
+	return (delta > permitteddelta) ? MODE_CLOCK_RANGE : MODE_OK;
+}
+
 static int mgag200_g200ew3_pixpllc_atomic_check(struct drm_crtc *crtc,
 						struct drm_atomic_state *new_state)
 {
@@ -143,6 +187,7 @@ static const struct mgag200_device_info mgag200_g200ew3_device_info =
 	MGAG200_DEVICE_INFO_INIT(2048, 2048, 0, true, 0, 1, false);
 
 static const struct mgag200_device_funcs mgag200_g200ew3_device_funcs = {
+	.pixpllc_mode_valid = mgag200_g200ew3_pixpllc_mode_valid,
 	.pixpllc_atomic_check = mgag200_g200ew3_pixpllc_atomic_check,
 	.pixpllc_atomic_update = mgag200_g200wb_pixpllc_atomic_update, // same as G200WB
 };
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200wb.c b/drivers/gpu/drm/mgag200/mgag200_g200wb.c
index d847fa8ded..63f9909a99 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200wb.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200wb.c
@@ -38,6 +38,46 @@ void mgag200_g200wb_init_registers(struct mga_device *mdev)
  * PIXPLLC
  */
 
+static enum drm_mode_status mgag200_g200wb_pixpllc_mode_valid(struct drm_crtc *crtc,
+							      const struct drm_display_mode *mode)
+{
+	static const unsigned int vcomax = 550000;
+	static const unsigned int vcomin = 150000;
+	static const unsigned int pllreffreq = 48000;
+
+	long clock = mode->clock;
+	unsigned int delta, tmpdelta, permitteddelta;
+	unsigned int testp, testm, testn;
+	unsigned int computed;
+
+	if (clock <= 0)
+		return MODE_CLOCK_LOW;
+
+	delta = 0xffffffff;
+	permitteddelta = clock * 5 / 1000;
+
+	for (testp = 1; testp < 9; testp++) {
+		if (clock * testp > vcomax)
+			continue;
+		if (clock * testp < vcomin)
+			continue;
+
+		for (testm = 1; testm < 17; testm++) {
+			for (testn = 1; testn < 151; testn++) {
+				computed = (pllreffreq * testn) / (testm * testp);
+				if (computed > clock)
+					tmpdelta = computed - clock;
+				else
+					tmpdelta = clock - computed;
+				if (tmpdelta < delta)
+					delta = tmpdelta;
+			}
+		}
+	}
+
+	return (delta > permitteddelta) ? MODE_CLOCK_RANGE : MODE_OK;
+}
+
 static int mgag200_g200wb_pixpllc_atomic_check(struct drm_crtc *crtc,
 					       struct drm_atomic_state *new_state)
 {
@@ -277,6 +317,7 @@ static const struct mgag200_device_info mgag200_g200wb_device_info =
 	MGAG200_DEVICE_INFO_INIT(1280, 1024, 31877, true, 0, 1, false);
 
 static const struct mgag200_device_funcs mgag200_g200wb_device_funcs = {
+	.pixpllc_mode_valid = mgag200_g200wb_pixpllc_mode_valid,
 	.pixpllc_atomic_check = mgag200_g200wb_pixpllc_atomic_check,
 	.pixpllc_atomic_update = mgag200_g200wb_pixpllc_atomic_update,
 };
diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index 8894a063b1..ed82171a84 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -583,6 +583,8 @@ enum drm_mode_status mgag200_crtc_helper_mode_valid(struct drm_crtc *crtc,
 {
 	struct mga_device *mdev = to_mga_device(crtc->dev);
 	const struct mgag200_device_info *info = mdev->info;
+	const struct mgag200_device_funcs *funcs = mdev->funcs;
+	enum drm_mode_status status;
 
 	/*
 	 * Some devices have additional limits on the size of the
@@ -605,6 +607,17 @@ enum drm_mode_status mgag200_crtc_helper_mode_valid(struct drm_crtc *crtc,
 		return MODE_BAD;
 	}
 
+	/*
+	 * Reject modes whose pixel clock falls outside the per-model PIXPLLC
+	 * window. Without this filter, pixpllc_atomic_check can return success
+	 * with zeroed PLL parameters and atomic_update would underflow.
+	 */
+	if (funcs->pixpllc_mode_valid) {
+		status = funcs->pixpllc_mode_valid(crtc, mode);
+		if (status != MODE_OK)
+			return status;
+	}
+
 	return MODE_OK;
 }
 
-- 
2.47.3
