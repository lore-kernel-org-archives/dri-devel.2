Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314A9606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 22:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nozomi.space header.i=@nozomi.space header.a=rsa-sha256 header.s=mail header.b=WMkQLEdh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA13910E662;
	Sat, 24 Oct 2026 22:59:13 +0000 (UTC)
Received: from mail.nozomi.space (mail.nozomi.space [139.162.184.125])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4051910E09B
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 22:49:43 +0000 (UTC)
From: =?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nozomi.space;
 s=mail; t=1792882181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tw3b76rDa30BUAUXIT9wy2RRpvrslrRXO3zIbnXtAbE=;
 b=WMkQLEdhhQFxqiqzCDg3pInpoIHK00pmPhMyL1XDEKdqij7pKoKcHpELgmHHYjyujD10sS
 A91BQ6HeeFaT0Rjg+jPLVnV+k4vfSw4WUY570Mmfog19Yap/8qtpiOr7i2yLF/7nXFJPFq
 FEz6yS8sYEUFmKOdZLW4R5QkvJRdOS7Xap48tVNkmZ7p0HN8jOaUNcbBldtNLCRNIYYhQK
 5OPcwB08FJW+rG+zjpupm+fD54TCSUYQM8U3qdZNkNZfUDtlEj+YWk+ustqpwRrD1Lg58O
 k08zLu74ExYjkUCvlkMF3X9eKa6/maI/1ETUuN0Jq/QDKvzHizU82SXIfl3cJA==
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
Subject: [PATCH] drm/amd/display: keep LTTPR AUX timeout when repeater caps
 are invalid
Date: Sun, 25 Oct 2026 00:49:40 +0200
Message-ID: <20261024224940.17258-1-michal@nozomi.space>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 Oct 2026 22:59:01 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some retimers report a nonzero PHY repeater count together with an
invalid max lane count. One example is the MegaChips (Kinetic) MCDP6000
USB-C DP Alt Mode retimer in the Sony PlayStation VR2 PC adapter.
dp_is_lttpr_present() then treats the link as having no LTTPR, and both
retrieve_link_cap() and the resume path in amdgpu_dm drop the AUX reply
timeout from the LTTPR value (3.2 ms) to the default one (552 us).

The retimer is still in the AUX path and relays every transaction. The
MCDP6000 datasheet gives 100 us of round-trip AUX latency in its normal
latency mode, and recommends that a source using it raise its AUX reply
timeout. Reading the LTTPR caps has also told the repeater that the
source uses the extended timeout, as required by the DP spec.

With a sink that replies quickly this goes unnoticed, but with a slower
downstream device behind the retimer (a USB-C dock driving a monitor),
replies miss the 552 us window. Reading the extended receiver caps
fails, EDID reads fail, link training fails, and the connector falls
back to 640x480:

  LTTPR count is nonzero but invalid lane count reported. Assuming no LTTPR present.
  retrieve_link_cap: Read extend caps data failed, use cap from dpcd 0.
  EDID err: 2, on connector: DP-1
  enabling link 0 failed: 15

Add dp_lttpr_needs_extended_aux_timeout(), which is true whenever a
repeater count is reported, and only drop to the default timeout when
no repeater is reported at all. Links without a repeater and links with
a valid LTTPR behave as before.

Tested on an RX 9070 XT with PSVR2 adapter -> USB-C switch -> USB-C dock
-> Dell AW3425DW: EDID is read and the link trains at 3440x1440@240Hz
with DSC. The same adapter connected directly to the monitor keeps
working.

Signed-off-by: Michał Kopeć <michal@nozomi.space>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  2 +-
 .../display/dc/link/protocols/link_dp_capability.c  | 13 ++++++++++++-
 .../display/dc/link/protocols/link_dp_capability.h  |  2 ++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bdabb4bf14dab..35885b6d6f787 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1333,7 +1333,7 @@ STATIC_IFN_KUNIT void s3_handle_mst(struct drm_device *dev, bool suspend)
 			 * CTS 4.2.1.1 regression introduced by CTS specs requirement update.
 			 */
 			try_to_configure_aux_timeout(aconnector->dc_link->ddc, LINK_AUX_DEFAULT_LTTPR_TIMEOUT_PERIOD);
-			if (!dp_is_lttpr_present(aconnector->dc_link))
+			if (!dp_lttpr_needs_extended_aux_timeout(aconnector->dc_link))
 				try_to_configure_aux_timeout(aconnector->dc_link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
 
 			/* TODO: move resume_mst_branch_status() into drm mst resume again
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index ad1a499b0d9d2..25e901f23d2db 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -404,6 +404,17 @@ bool dp_is_lttpr_present(struct dc_link *link)
 	return is_lttpr_present;
 }
 
+/*
+ * A repeater that reports a nonzero count with invalid caps is not used as an
+ * LTTPR, but it is still in the AUX path and adds relay latency. Reading its
+ * caps has also told it that the source uses the extended AUX timeout, so keep
+ * that timeout unless no repeater is reported at all.
+ */
+bool dp_lttpr_needs_extended_aux_timeout(struct dc_link *link)
+{
+	return dp_parse_lttpr_repeater_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) > 0;
+}
+
 /* in DP compliance test, DPR-120 may have
  * a random value in its MAX_LINK_BW dpcd field.
  * We map it to the maximum supported link rate that
@@ -1825,7 +1836,7 @@ static bool retrieve_link_cap(struct dc_link *link)
 		return false;
 	}
 
-	if (!dp_is_lttpr_present(link))
+	if (!dp_lttpr_needs_extended_aux_timeout(link))
 		try_to_configure_aux_timeout(link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h
index 6e17f72a752f3..e5c2382390a11 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h
@@ -55,6 +55,8 @@ bool dp_is_sink_present(struct dc_link *link);
 
 bool dp_is_lttpr_present(struct dc_link *link);
 
+bool dp_lttpr_needs_extended_aux_timeout(struct dc_link *link);
+
 bool dp_is_fec_supported(const struct dc_link *link);
 
 bool is_dp_active_dongle(const struct dc_link *link);
-- 
2.56.0

