Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CB4FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:12:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32B2110E966;
	Tue,  5 May 2026 07:12:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="D/lqd835";
	dkim-atps=neutral
X-Greylist: delayed 499 seconds by postgrey-1.36 at gabe;
 Tue, 05 May 2026 03:44:24 UTC
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C995610E02D
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 03:44:24 +0000 (UTC)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 350A53F618
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 03:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1777952164;
 bh=5nXNXtq4bXqnzVo7coZe7ghW1MNIY/5OFZVdGYJv4uc=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=D/lqd8354x5ssb5iU2+OyzxQMR2fgZwqVX1Y/lTd0K8uWE0JZ0sTXP2o8nqWBqjDw
 KJhN5oumt5uVUDiTkO97hFchfYq/MNUE3E0jdCHcrKpZtMYSD2eQ4sdw6FJzJEmdvw
 bsfNvDGescMCUhH4lhlkCGnKU5/vMIRwHHjKTrrnYuO0wlK+qRC7+KvS+skj+RZUIz
 G24ptRaD8+lSGXxmM3PNG6Gfi/7PRcDeVK0JGIBZZJno/A0lda28lWZHb6d/utVavv
 ntpOPhFOwt/knAwIkgK8S27tr4jf79Wpic8LEH8LvB1CkfzyIoD1TnrPs0sKTjQdgf
 /e6nUImnZRTq+NWrwLbujkyxpfPfGLCe8X3P7dw/WtvorPLYZq4u1hl6PAS9Z+b521
 bl3Jxe30hib1I0ukUqfWNzn5GW2gJ6/NGUXKzS4aiJRzY545bNno3JhNvnA8vJfDNb
 c5TFi8nMaHJxpNRKQ5IBuzEKAoo1yPzAV2onei2mN3GdNIgqYexZptSe5Hqfcfv53M
 mzma4B48Q8bqFy40BQjcEuS+pD9A/6ujcT2yI8Iom2m8kgzcXYUEoeLMALTZTbY0be
 nudaH3ndITgwXlyWFjNA4n0i9dOEqXKGY0EUYFKkkgriymA/Gi3hfh+ElivwaEwnvF
 WB88lRu1+CJfHUNu3lZy7oDA=
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2aae3e185a3so4694755ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 20:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777952162; x=1778556962;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5nXNXtq4bXqnzVo7coZe7ghW1MNIY/5OFZVdGYJv4uc=;
 b=NUlfTMu3rdlJ3r9LJV9gS/fyMGD7+8nBHsRTRIkrZ5FuCtI63k8D7pqBuC4SHhJ3mr
 fGUeFn0quQValbKG39Z1+CqcSiizPvEAMXaLEYvNOBMQK+KfEjH5y3GLJjZ4L9jYMvgd
 igNZ4bDH6/q6iEI/wsz0ezd9ZoWyru/eS/SpG9+dVFuwxzeG9//8uvj+JOaUWV6pU/NQ
 AMkTiC/QKL5CrKKPxOxmfCe9tN83pdwhw23O+hDqPFUD+A5sve2vH5awXebk0+rxEOu/
 tnyYlsHoDAc3KER+njLExaH0DZ2eozWibt1AIiig5bVTE5/WIHCd/ZgKyUnurwBOI1H+
 qbAA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ngVffIdSIV7QkoJlTJrEY7rga76kN1WUYsngt3uqdPug7Htns3xv/U6xfZhEpUeghnLvjTGrC678=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyks3yZPCQEDdV+ECk/CfijxHCR1pDwT7DDfxUGeMSetOuLsI6k
 wl9cxY6k6KwTl6gZauos6fzraFEvQVZorZJy6Y4cUmFiDInL6sbffmKbQMZ9zFFAsyTUct8q2p8
 lrZlRd5XyA6uyxdUlLvCQ5aadsLhh0ynkZxC4pH+B/lAsRiGQyYOyeSJjrR77IuCbHnSW9dIKaA
 470mM0sZtQjccAyrnB+w==
X-Gm-Gg: AeBDiesy5+ZewP3jzx15yQW1cigfmFNLjkiloW7tKqJ6NECLqca4exgYeSpgXp1I+ZL
 RRbCnwDxETE6L51DoB4D+gyq0sBuZVe987CFxTlxIWR40bdnTuMgcADXYI2NAtjalt5l30sjUf9
 qkT6WN3ptcUPLjZrTC48+LTKqcLmpVffiK6WA7KrZGE11XzZ2h3VU0TR2rZkA5DkU5fk7hnKCcG
 /5teeu/bLOkLu22ZWfecDNovvJdvSG+MVc6LXWwzHuge2W4HAUc+Q9MDMIZYnWVI1VXtO9p65ko
 tkGUu9FOg2hCL2HjuWQW3QO3OP2pn0XNW6DXFJ1ATyc5wbLSQzCp7boQKlY+y2OUqwMu/eQOhDF
 cUwhflWJm+f73Xk8eWxatXI9p4VPC7Alxv1TqWepRUytZGsmVoaYOKprrka5ScfXs2UKnLP8frJ
 E0EQEGJCUCSfCXUpv4h18etxZaIHufQafdR7bhhCZsk1/hNlo/oXy0VYVdpdxHRy/plcCOVoO04
 2QUDJEJ9kgA
X-Received: by 2002:a17:903:1b64:b0:2ba:1e94:d03b with SMTP id
 d9443c01a7336-2ba53e967b8mr6021915ad.6.1777952162423; 
 Mon, 04 May 2026 20:36:02 -0700 (PDT)
X-Received: by 2002:a17:903:1b64:b0:2ba:1e94:d03b with SMTP id
 d9443c01a7336-2ba53e967b8mr6021765ad.6.1777952162048; 
 Mon, 04 May 2026 20:36:02 -0700 (PDT)
Received: from an-XPS-15-9520..
 (2001-b011-2008-6553-c5e9-d4dc-67fd-a915.dynamic-ip6.hinet.net.
 [2001:b011:2008:6553:c5e9:d4dc:67fd:a915])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9cae16a9esm114405985ad.50.2026.05.04.20.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 20:36:01 -0700 (PDT)
From: ChunAn Wu <an.wu@canonical.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/i915/tc: Recover AUX channel after external TC port
 mode change
Date: Tue,  5 May 2026 11:35:57 +0800
Message-Id: <20260505033558.157604-1-an.wu@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 05 May 2026 07:12:26 +0000
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

When Fn+F4 triggers mirror mode, the BIOS/EC reconfigures a TC port
mode (e.g. DP-Alt to TBT-Alt via UCSI) without generating HPD. The
driver's cached TC mode becomes stale, so intel_dp_aux_xfer() uses
the wrong power domain and IO routing, and AUX transactions fail.

This occurs when the USB-C-to-HDMI dongle does not support TBT, so
the mode switch creates a mismatch. It also occurs with slow monitors
whose delayed HPD/DDC/EDID recovery causes the Type-C layer to settle
on a stale tbt-alt state before the dongle finishes re-negotiation.

Add intel_tc_port_aux_recover() to detect hardware/cached TC mode
divergence and reset the PHY. Wrap it with
intel_dp_aux_xfer_with_recovery() to retry with corrected settings.

Tested on Panther Lake and Lunar Lake with a BenQ HDMI monitor via
USB-C-to-HDMI dongle.

Signed-off-by: ChunAn Wu <an.wu@canonical.com>
---
 drivers/gpu/drm/i915/display/intel_dp_aux.c | 41 +++++++++--
 drivers/gpu/drm/i915/display/intel_tc.c     | 75 +++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_tc.h     |  1 +
 3 files changed, 113 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux.c b/drivers/gpu/drm/i915/display/intel_dp_aux.c
index b20ec3e589fa..d496b2231656 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux.c
@@ -481,6 +481,39 @@ static u32 intel_dp_aux_xfer_flags(const struct drm_dp_aux_msg *msg)
 	return 0;
 }
 
+/**
+ * intel_dp_aux_xfer_with_recovery - AUX transfer with TC port recovery
+ * @intel_dp: the DP port
+ * @send: buffer of bytes to send
+ * @send_bytes: number of bytes to send
+ * @recv: buffer to store received reply
+ * @recv_size: maximum number of bytes to receive
+ * @aux_send_ctl_flags: extra flags for the AUX send control register
+ *
+ * Wrapper around intel_dp_aux_xfer() that attempts to recover from an
+ * external TC port mode change (e.g., dp-alt -> tbt-alt via hotkey BIOS
+ * action) when the initial AUX transfer fails. On failure, recovery is
+ * attempted once via intel_tc_port_aux_recover() before retrying.
+ *
+ * Returns: number of received bytes on success, negative error code on failure.
+ */
+static int
+intel_dp_aux_xfer_with_recovery(struct intel_dp *intel_dp,
+				const u8 *send, int send_bytes,
+				u8 *recv, int recv_size,
+				u32 aux_send_ctl_flags)
+{
+	struct intel_digital_port *dig_port = dp_to_dig_port(intel_dp);
+	int ret;
+
+	ret = intel_dp_aux_xfer(intel_dp, send, send_bytes, recv, recv_size,
+				aux_send_ctl_flags);
+	if (ret < 0 && intel_tc_port_aux_recover(dig_port))
+		ret = intel_dp_aux_xfer(intel_dp, send, send_bytes, recv,
+					recv_size, aux_send_ctl_flags);
+	return ret;
+}
+
 static ssize_t
 intel_dp_aux_transfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg)
 {
@@ -508,8 +541,8 @@ intel_dp_aux_transfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg)
 		if (msg->buffer)
 			memcpy(txbuf + HEADER_SIZE, msg->buffer, msg->size);
 
-		ret = intel_dp_aux_xfer(intel_dp, txbuf, txsize,
-					rxbuf, rxsize, flags);
+		ret = intel_dp_aux_xfer_with_recovery(intel_dp, txbuf, txsize,
+						      rxbuf, rxsize, flags);
 		if (ret > 0) {
 			msg->reply = rxbuf[0] >> 4;
 
@@ -531,8 +564,8 @@ intel_dp_aux_transfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg)
 		if (drm_WARN_ON(display->drm, rxsize > 20))
 			return -E2BIG;
 
-		ret = intel_dp_aux_xfer(intel_dp, txbuf, txsize,
-					rxbuf, rxsize, flags);
+		ret = intel_dp_aux_xfer_with_recovery(intel_dp, txbuf, txsize,
+						      rxbuf, rxsize, flags);
 		if (ret > 0) {
 			msg->reply = rxbuf[0] >> 4;
 			/*
diff --git a/drivers/gpu/drm/i915/display/intel_tc.c b/drivers/gpu/drm/i915/display/intel_tc.c
index a21dd4e3fe4c..1b23161e4eea 100644
--- a/drivers/gpu/drm/i915/display/intel_tc.c
+++ b/drivers/gpu/drm/i915/display/intel_tc.c
@@ -1861,6 +1861,81 @@ void intel_tc_port_link_cancel_reset_work(struct intel_digital_port *dig_port)
 	cancel_delayed_work(&tc->link_reset_work);
 }
 
+/**
+ * intel_tc_port_aux_recover - Recover AUX channel after external TC mode change
+ * @dig_port: digital port
+ *
+ * When firmware causes a TC port mode change (e.g., dp-alt -> disconnect ->
+ * tbt-alt) during a hotkey-triggered display mode switch, AUX transactions
+ * using the stale power domain and IO flags will fail with timeouts or errors.
+ * This happens because:
+ *
+ *   1. The display driver holds the TC link in dp-alt mode (link_refcount > 0)
+ *   2. Firmware (e.g., via HP WMI hotkey BIOS action) reconfigures the TC port
+ *      mode externally without notifying the display driver
+ *   3. tc->mode stays as TC_PORT_DP_ALT while HW transitions to a different
+ *      mode, invalidating the AUX power domain and IO flags used by
+ *      intel_dp_aux_xfer()
+ *
+ * This function detects the discrepancy between tc->mode and actual HW state,
+ * and re-synchronizes them via a TC PHY reset. After recovery, AUX retries
+ * will use the correct power domain and control flags.
+ *
+ * The link_refcount is temporarily cleared to allow intel_tc_port_reset_mode()
+ * to proceed without the PHY-ownership assertion that fires when link_refcount
+ * is non-zero and firmware has already released PHY ownership.
+ *
+ * Must be called outside the TC port lock (tc->lock).
+ *
+ * Returns: %true if recovery was performed and AUX can be retried,
+ *          %false if recovery was not needed or not possible.
+ */
+bool intel_tc_port_aux_recover(struct intel_digital_port *dig_port)
+{
+	struct intel_tc_port *tc;
+	struct intel_display *display;
+	bool recovered = false;
+
+	if (!intel_encoder_is_tc(&dig_port->base))
+		return false;
+
+	tc = to_tc_port(dig_port);
+	display = to_intel_display(dig_port);
+
+	mutex_lock(&tc->lock);
+
+	/*
+	 * Recovery is only needed when the link is actively held AND the HW
+	 * TC mode has diverged from the driver's cached state.
+	 */
+	if (!tc->link_refcount || !intel_tc_port_needs_reset(tc))
+		goto out;
+
+	drm_dbg_kms(display->drm,
+		    "Port %s: AUX recover: external TC mode change detected (%s -> HW), reconnecting TC PHY\n",
+		    tc->port_name, tc_port_mode_name(tc->mode));
+
+	/*
+	 * Temporarily clear link_refcount so intel_tc_port_reset_mode() can
+	 * run the PHY disconnect/connect cycle without the ownership assertion
+	 * that fires when link_refcount > 0 and firmware has already released
+	 * PHY ownership externally.
+	 */
+	tc->link_refcount = 0;
+	intel_tc_port_reset_mode(tc, 1, false);
+	tc->link_refcount = 1;
+
+	recovered = tc->mode != TC_PORT_DISCONNECTED;
+	if (!recovered)
+		drm_warn(display->drm,
+			 "Port %s: AUX recover: failed to restore TC port mode\n",
+			 tc->port_name);
+
+out:
+	mutex_unlock(&tc->lock);
+	return recovered;
+}
+
 static void __intel_tc_port_lock(struct intel_tc_port *tc,
 				 int required_lanes)
 {
diff --git a/drivers/gpu/drm/i915/display/intel_tc.h b/drivers/gpu/drm/i915/display/intel_tc.h
index 6719aea5bd58..d44998a3081a 100644
--- a/drivers/gpu/drm/i915/display/intel_tc.h
+++ b/drivers/gpu/drm/i915/display/intel_tc.h
@@ -108,6 +108,7 @@ bool intel_tc_port_ref_held(struct intel_digital_port *dig_port);
 bool intel_tc_port_link_needs_reset(struct intel_digital_port *dig_port);
 bool intel_tc_port_link_reset(struct intel_digital_port *dig_port);
 void intel_tc_port_link_cancel_reset_work(struct intel_digital_port *dig_port);
+bool intel_tc_port_aux_recover(struct intel_digital_port *dig_port);
 
 int intel_tc_port_init(struct intel_digital_port *dig_port, bool is_legacy);
 void intel_tc_port_cleanup(struct intel_digital_port *dig_port);
-- 
2.34.1

