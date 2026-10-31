Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A353D606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=WEiJlXj9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D0C10E9E8;
	Sun,  1 Nov 2026 11:58:13 +0000 (UTC)
Received: from send149.i.mail.ru (send149.i.mail.ru [89.221.237.244])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41A5810E10C;
 Sat, 31 Oct 2026 18:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
 X-Cloud-Ids:Disposition-Notification-To;
 bh=tRYJsTpQDYPC87i9NiIr7RjWCeATwHmIj7GWmFsFNX8=; t=1793471405; x=1793561405; 
 b=WEiJlXj9977J39sCbV3qYGxZXwsGMnQk7JbZ+fjfuAvVGzzK4TnUcM56mWp9G3QYRMLHhmN9moC
 y//xYgVYqBnHbvXCnuTen1s2pZCfE4fSGi9sl3xZPcDMMBGEEkPUv2FSMPS0vQvx33j8zW03zJuAj
 sgCeBZYjupzbe5y1VWHNH64zIZcFctGCw8D/y63/jclUqvLCMXxGQWL1S3Y1AOaLBFeFbDEdQ6jOE
 AiyHdndu6rL2V2MzE/WMyPMOI26fQOiYC61JS+MFmtT7ebd+L5hPlwAAF8vqFQ/rqhrx0EZ8FZp6w
 85KbSpzld4dE3W9W8kS78JwAxzevi5pH1u0A==;
Received: by exim-smtp-675c6798c6-6jjcs with esmtpa (envelope-from
 <s.mavlenkov@mail.ru>)
 id 1xNDq6-00000000U6s-1zk5; Sat, 31 Oct 2026 21:30:02 +0300
From: bitey <s.mavlenkov@mail.ru>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Patrik Jakobsson <pjakobsson@suse.de>,
 bitey <s.mavlenkov@mail.ru>
Subject: [PATCH v5] drm/i915/display: Add quirk for unreliable link status on
 CH7511
Date: Sat, 31 Oct 2026 21:29:48 +0300
Message-ID: <20261031182948.5605-1-s.mavlenkov@mail.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031174518.10004-1-s.mavlenkov@mail.ru>
References: <20261031174518.10004-1-s.mavlenkov@mail.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: exim-smtp-675c6798c6-6jjcs;
 auth=pass smtp.auth=s.mavlenkov@mail.ru
 smtp.mailfrom=s.mavlenkov@mail.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD995934D660C27459BF03C6474325BE6D49CD13B09FAEDAEA5182A05F538085040B6796426194682C43DE06ABAFEAF670554BF22F7465966B264ADF4C6ABA503B96476942D68AFA0BE
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE73870E1FF9A049D91EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB553375667B1596EEF16A891DE1CDDE01F394605E9B3D7B5E91723404BAA540427F2F1F588EEF46B7454FC60B9742502CCDD46D0DFE4D9CDE3FF759CFF6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C0C26CFBAC0749D213D2E47CDBA5A96583BA9C0B312567BB231DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6598BD4784909AC60089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-B7AD71C0: 6FEFE4C63DFE2D851629A3278334FCEC2AD323669803AD9FE6E38E9349F0B966A6C0FD54AE381AFD9D81D631C2696BA1
X-C1DE0DAB: 0D63561A33F958A5F7C512801896934D5002B1117B3ED6964F23875B10A83898FB820E9FE7BD014C823CB91A9FED034534781492E4B8EEAD9CFA8CFAC159CE19C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34CB8C0E004AB9358F525B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659A0635C2FDB058C88428C6D6E9410FAAA582FA56E4E1864FB661CF392B8C8E2108C02483F04D99A76B8341EE9D5BE9A0A26B2CC2F7A054DCD0380210D91784E464B7F5044B0F1079852EE4E5D9E54FDA4F44A2BDFCEC9DBD838705C4085B645248947CB5EE6AA4F0FCFECA0A3B40025F483DB18EBE73F7D69
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWLGX+qvDiReNDLEd9SnCO68=
X-Mailru-Sender: 689FA8AB762F73937C9FA53A4753B313ADA7C4357EFEA443A7E90C9F648061A331B299CC804D2984F3CDC8BC78C4DE7BDA68109F586B92E9CCFD498835386E8A2DDEA15287B001569AA14EBBF425EE34BC7555A253F5B2000D4ABDE8C577C2ED
X-Mras: Ok
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
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When disabling pattern training after successful link training the
CH7511 bridge incorrectly clears the DPCD link status bits: not only
INTERLANE_ALIGN_DONE, but also the per-lane CR_DONE, CHANNEL_EQ_DONE
and SYMBOL_LOCKED bits. This is interpreted as a link failure when
rechecking the link status and triggers an endless loop of retraining
sequences.

Add a quirk to skip the link status check for sinks with unreliable
link status reporting. The quirk is matched on the Chrontel IEEE OUI
(F0:02:2B) and the device ID "CH7511" on any platform.

While at it, clear the DPCD quirks mask before scanning the quirk
table, so that quirks of a previously connected sink do not stick to
a new sink plugged into the same connector on re-detection.

Tested on Ivy Bridge (HD Graphics 2500, device 0152) with a CH7511
DP-to-HDMI adapter on kernels 7.1-rc1, drm-tip and 7.3.

Fixes: 3b3be899fc81 ("drm/i915/dp: Recheck link state after modeset")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/15744
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/15994
Co-developed-by: Patrik Jakobsson <pjakobsson@suse.de>
Signed-off-by: Patrik Jakobsson <pjakobsson@suse.de>
Signed-off-by: bitey <s.mavlenkov@mail.ru>
---
Changes in v5:
- Rename the quirk to QUIRK_DP_LINK_STATUS_UNRELIABLE and drop the
  commit subject mention of the interlane align bit, since the quirk
  now covers the whole link status (Sashiko)
- Skip the link status check entirely for quirked sinks instead of
  synthesizing link status bits (Sashiko)
- Clear intel_dp->quirks.mask before scanning the quirk table to
  prevent stale quirks from a previously connected sink and repeated
  quirk messages on connector re-detection (Sashiko)
- Use drm_info_once() for the quirk message (Sashiko)

Changes in v4:
- Also force the per-lane status bits (CR_DONE / CHANNEL_EQ_DONE /
  SYMBOL_LOCKED). On Ivy Bridge the CH7511 zeroes the entire lane
  status registers after training (ln0_1 = ln2_3 = 0x00), so forcing
  only the INTERLANE_ALIGN_DONE bit is not enough to stop the retrain
  loop.
- Rebased on top of v7.3

Changes in v3:
- Match on all devices with a CH7511, instead of only VLV
- Rebased on top of drm-tip
- Additional "Closes" tag
---
 .../drm/i915/display/intel_dp_link_training.c | 12 ++++++++++
 drivers/gpu/drm/i915/display/intel_quirks.c   | 23 +++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_quirks.h   |  1 +
 3 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
index 9a692f4..0fdc5a4 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
@@ -43,6 +43,7 @@
 #include "intel_hotplug.h"
 #include "intel_modeset_lock.h"
 #include "intel_panel.h"
+#include "intel_quirks.h"
 #include "intel_psr.h"
 
 /**
@@ -2515,6 +2516,17 @@ intel_dp_needs_link_retrain(struct intel_dp *intel_dp)
 	if (link_recovery_autoretrain_pending(link_training))
 		return true;
 
+	/*
+	 * The Chrontel CH7511 DP-to-LVDS bridge does not maintain the DPCD
+	 * link status fields after the training pattern is disabled: the
+	 * interlane alignment and per-lane status bits all read back as zero
+	 * even though the link is up. Skip the link status check for such
+	 * sinks, otherwise the bogus status triggers an endless retrain
+	 * loop.
+	 */
+	if (intel_has_dpcd_quirk(intel_dp, QUIRK_DP_LINK_STATUS_UNRELIABLE))
+		return false;
+
 	/* Retrain if link not ok */
 	return !intel_dp_link_ok(intel_dp, link_status) &&
 		!intel_psr_link_ok(intel_dp);
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index 7d7db77..27141ad 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -94,6 +94,14 @@ static void quirk_disable_edp_panel_replay(struct intel_dp *intel_dp)
 	drm_info(display->drm, "Applying disable Panel Replay quirk\n");
 }
 
+static void quirk_dp_link_status_unreliable(struct intel_dp *intel_dp)
+{
+	struct intel_display *display = to_intel_display(intel_dp);
+
+	intel_set_dpcd_quirk(intel_dp, QUIRK_DP_LINK_STATUS_UNRELIABLE);
+	drm_info_once(display->drm, "Applying DP link status unreliable quirk (Chrontel CH7511)\n");
+}
+
 static void quirk_disable_psr2(struct intel_display *display)
 {
 	intel_set_quirk(display, QUIRK_DISABLE_PSR2);
@@ -289,6 +297,15 @@ static const struct intel_dpcd_quirk intel_dpcd_quirks[] = {
 		.sink_oui = SINK_OUI(0x00, 0x22, 0xb9),
 		.hook = quirk_disable_edp_panel_replay,
 	},
+	/* Chrontel CH7511 DP-to-LVDS bridge */
+	{
+		.device = DEVICE_ID_ANY,
+		.subsystem_vendor = PCI_ANY_ID,
+		.subsystem_device = PCI_ANY_ID,
+		.sink_oui = SINK_OUI(0x2b, 0x02, 0xf0),
+		.sink_device_id = SINK_DEVICE_ID('C', 'H', '7', '5', '1', '1'),
+		.hook = quirk_dp_link_status_unreliable,
+	},
 };
 
 void intel_init_quirks(struct intel_display *display)
@@ -320,6 +337,12 @@ void intel_init_dpcd_quirks(struct intel_dp *intel_dp,
 	struct pci_dev *d = to_pci_dev(display->drm->dev);
 	int i;
 
+	/*
+	 * Reset the mask so that quirks from a previously connected sink
+	 * do not stick to a new sink plugged into the same connector.
+	 */
+	intel_dp->quirks.mask = 0;
+
 	for (i = 0; i < ARRAY_SIZE(intel_dpcd_quirks); i++) {
 		const struct intel_dpcd_quirk *q = &intel_dpcd_quirks[i];
 
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.h b/drivers/gpu/drm/i915/display/intel_quirks.h
index 970a4fe..483aa1f 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.h
+++ b/drivers/gpu/drm/i915/display/intel_quirks.h
@@ -23,6 +23,7 @@ enum intel_quirk_id {
 	QUIRK_EDP_LIMIT_RATE_HBR2,
 	QUIRK_DISABLE_EDP_PANEL_REPLAY,
 	QUIRK_DISABLE_PSR2,
+	QUIRK_DP_LINK_STATUS_UNRELIABLE,
 };
 
 void intel_init_quirks(struct intel_display *display);
-- 
2.56.0

