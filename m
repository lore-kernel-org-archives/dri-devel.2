Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2E9606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 05:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nNoAY/ln
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73EA310E21F;
	Thu, 19 Nov 2026 05:17:35 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4532B10E775;
 Thu, 19 Nov 2026 05:17:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E0E2443CA0;
 Thu, 19 Nov 2026 05:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09CA1F000C5;
 Thu, 19 Nov 2026 05:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795065448;
 bh=gXpxPMzeoAX9RUKDnfouZnk/t/QyTFIgvcetpcqjXb0=;
 h=From:Date:Subject:To:Cc;
 b=nNoAY/ln4P/m9Z1H1RNktvGZAouxWB14J8peRpSec14XDgvQEs6y1pfIfIxBIT5VB
 rh6shz2oSa8xpF1IhA0usCLQfu+viNi4qzIjd6ooz4bzfS4HSTjRoZsy6fe5afKbiL
 1I1th3coP+r1yS2dloy0ZZDsp/vbw5+SdTb1irLrt9zQzuh3Z6x60E2zUNjbb5DAQa
 bL3iIrIgVHfu5fhtqfOcXQvZdY49sF1pKzvWhHZfTkObVBeBan9jr018fv2L6k1+BP
 9pzIbm64gAvTsI6/OgH5Pjb6JmM5ZTkSwNgxm4v7BUtPMuTBIwynFMS4z4WDxqKvYV
 ZOMMGQN+m6RBA==
From: Mario Limonciello <superm1@kernel.org>
Date: Wed, 18 Nov 2026 23:17:14 -0600
Subject: [PATCH v4] drm/amd/display: Route connector DDC over AUX for
 native DP sinks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261118-superm1-amdgpu-ddc-v4-1-539eaeb4edd7@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OTY7CMAwF4KugrCfIdkJgZsU9RiyaxC0B+qOEV
 iDUu5PABiTE8snPn30TiWPgJP4WNxF5Cin0XQ76ZyHcvuoalsHnLAjIIALJNA4cW5RV65thlN4
 7aVQNbBEcEIm8OESuw+WB/u+eOY32wO5cpNLYh3Tu4/VxdcLS+3pgQony162c1ZWuDfltHi5d3
 4rCT/QKqI8AZWBtPRsPoNWGtkeOHZ+WfWyehnoxED4aqjyhlbGgPbLCN2Oe5zsSdrQSTAEAAA=
 =
X-Change-ID: 20261102-superm1-amdgpu-ddc-63f0eb10c022
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Cc: Richard Hughes <richard@hughsie.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Wayne Lin <Wayne.Lin@amd.com>, 
 simonit.orig@gmail.com, 
 =?utf-8?q?Eren_=C3=96zen?= <erenozen@protonmail.com>, 
 Mario Limonciello <superm1@kernel.org>
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On DisplayPort and eDP connectors DDC is tunneled over the AUX channel,
but the connector's "ddc" adapter ("AMDGPU DM i2c hw bus N") always
drives the physical i2c pins, which don't reach a native DP sink.  The
AUX backed adapter ("AMDGPU DM aux hw bus N") does, so userspace such as
fwupd, which uses the "ddc" sysfs link for DDC/CI, has to work around
this.

Keep a single i2c bus per connector and pick the transport per transfer
based on the link's transaction mode (link->aux_mode), as the EDID read
helpers already do: for native DP/eDP/MST sinks forward the transfer to
the AUX adapter, otherwise (DVI/HDMI, including DP++ with a passive
adapter) use the hw i2c engine as before.

Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
Reported-by: simonit.orig@gmail.com
Closes: https://github.com/fwupd/fwupd/pull/11308
Co-developed-by: "Eren Özen" <erenozen@protonmail.com>
Signed-off-by: "Eren Özen" <erenozen@protonmail.com>
Signed-off-by: Mario Limonciello <superm1@kernel.org>
---
Changes in v4:
- Add Wayne's tag
- Fold in Eren's fix for kunit tests
- Link to v3: https://patch.msgid.link/20261110-superm1-amdgpu-ddc-v3-1-9436b04d1e31@kernel.org

Changes in v3:
- Select the transport with link->aux_mode instead of
  link->local_sink->sink_signal, matching the EDID read helpers in
  amdgpu_dm_helpers.c.  This drops the unlocked local_sink dereference
  that could race with link detection/hotplug (use-after-free), and it
  also covers MST links (local_sink is NULL there) and links with
  force_to_use_aux set.
- Check ddc_service->link for NULL before dereferencing it, so
  amdgpu_dm_i2c_xfer() still returns -EIO when there is no ddc_pin
  (fixes dm_test_i2c_xfer_no_ddc_pin()).
- Reword the commit message to describe the aux_mode selection.
- Link to v2: https://patch.msgid.link/20261103-superm1-amdgpu-ddc-v2-1-7bde6d004382@kernel.org

Changes in v2:
- Check which i2c bus to use on the fly instead of changing static symlink to
  avoid regressing passive adapters.
- Link to v1: https://patch.msgid.link/20261102-superm1-amdgpu-ddc-v1-1-9c5cb4a4f62d@amd.com
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c  | 16 ++++++++++++++++
 .../display/amdgpu_dm/tests/amdgpu_dm_connector_test.c   |  6 +++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index b498fc5fbb140..f80de9e7f850c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3373,6 +3373,22 @@ STATIC_IFN_KUNIT int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
 	int i;
 	int result = -EIO;
 
+	if (!i2c->oem && ddc_service->link) {
+		struct dc_link *link = ddc_service->link;
+		struct amdgpu_dm_connector *aconnector = link->priv;
+
+		/*
+		 * DDC to a native DisplayPort sink (SST, MST or eDP) is
+		 * tunneled over the AUX channel; the physical i2c pins only
+		 * reach DVI/HDMI sinks (e.g. DP++ with a passive adapter).
+		 * Use the same aux_mode selection as the EDID read helpers so
+		 * the connector's single "ddc" bus works for either sink.
+		 */
+		if (aconnector && link->aux_mode &&
+		    aconnector->dm_dp_aux.aux.ddc.algo)
+			return i2c_transfer(&aconnector->dm_dp_aux.aux.ddc, msgs, num);
+	}
+
 	if (!ddc_service->ddc_pin)
 		return result;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index f09e2a72c5346..6564d5d22825c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -6140,7 +6140,9 @@ static void dm_test_i2c_func_returns_flags(struct kunit *test)
  * @test: The KUnit test context
  *
  * When the backing ddc_service has no ddc_pin the transfer bails out early
- * with -EIO before touching the message buffers or the dc handle.
+ * with -EIO before touching the message buffers or the dc handle. Non-OEM
+ * adapters always have a link, so the test gives the ddc_service a zeroed
+ * one.
  */
 static void dm_test_i2c_xfer_no_ddc_pin(struct kunit *test)
 {
@@ -6151,6 +6153,8 @@ static void dm_test_i2c_xfer_no_ddc_pin(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, i2c);
 	ddc = kunit_kzalloc(test, sizeof(*ddc), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, ddc);
+	ddc->link = kunit_kzalloc(test, sizeof(*ddc->link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ddc->link);
 
 	i2c->ddc_service = ddc;
 	i2c_set_adapdata(&i2c->base, i2c);

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261102-superm1-amdgpu-ddc-63f0eb10c022

Best regards,
--  
Mario Limonciello <superm1@kernel.org>

