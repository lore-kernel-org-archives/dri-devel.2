Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25779CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 19:16:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E19A10E2FE;
	Mon, 12 Oct 2026 19:16:53 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C579510E4F6
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 19:16:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F2F11601E4;
 Mon, 12 Oct 2026 19:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893641F0089B;
 Mon, 12 Oct 2026 19:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791832606;
 bh=ITrDbB7toxW4zi2+IGPM37pkdW6PjiQtkXk4Aim++PY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l4WMhPrVwgQZ9f8Z1hKtFNKJ4z4Hpo/EoA6QZJ213l+yHrKPNvT3W6u/1tG/sfB5P
 Z/761H0KQaoQfCTV8qTBRyWxgd8/0XzBN+6nuFejPLQC/V1fDCGXy59Cwi+NCfkADw
 cBUFnruuMq8r7dV7WdwC9wKB/Bd6WvyveIfDUmc9D4C9JRw1AhTHCYXhsUZzwGBucG
 LhY+ig6LIvU41BZW1+9dCfTVf2DRXUzpB2f1z9wdJ7fPIXiqY/4qUuTZkXA/D7OcE0
 5xUnMh8U2frgQ35Rbfcepl/QCShQay5T9kw1ER5NElaviK/GiFBgotFy4efR8GyXUI
 f8mX47M5Algaw==
Message-ID: <sashiko-outbox-168575@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/vc4: dsi: Recover from a timed-out transfer
To: "Henry Zhang" <henryzhang62@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261012190249.3167-3-henryzhang62@gmail.com>
References: <20261012190249.3167-1-henryzhang62@gmail.com>
 <20261012190249.3167-3-henryzhang62@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 19:16:46 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/vc4: dsi: premature controller enable during timeout reset cau=
ses hardware instability
- [High] drm/vc4: dsi: spurious completion due to IRQ handler TOCTOU race
- [Medium] drm/vc4: missing mutex serialization in DSI host transfer
--

commit b73bc40cfc01c81e251315be152ff0c2c6aa9361
Author: Henry Zhang <henryzhang62@gmail.com>

drm/vc4: dsi: Recover from a timed-out transfer

When a transfer times out, vc4_dsi_host_transfer() disables the command,
resets the FIFOs and returns -ETIMEDOUT. This commit adds a recovery
mechanism that resets the DSI block and its analog front end after a
timeout and restores the configuration so DSI keeps working without a
modeset.

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index c092a1aaf700a..3783ff3eeac97 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
[ ... ]
@@ -1359,6 +1358,93 @@ static ssize_t vc4_dsi_host_transfer(struct mipi_dsi=
_host *host,
 	return ret;
 }
=20
+/*
+ * Reset the DSI block and its analog front end, then restore the
+ * configuration done in pre_enable. Resetting the FIFOs alone does not
+ * clear the state the block can be left in after a transfer timed out
+ * (e.g. on an LP receive timeout): every following transfer then times
+ * out as well, until the next modeset.
+ */
+static void vc4_dsi_reset_and_restore(struct vc4_dsi *dsi)
+{
+	u32 ctrl =3D DSI_PORT_READ(CTRL);
+	u32 afec0 =3D DSI_PORT_READ(PHY_AFEC0);
[ ... ]
+	DSI_PORT_WRITE(DISP0_CTRL, disp0);
+	DSI_PORT_WRITE(TXPKT1C, 0);
+	DSI_PORT_WRITE(CTRL, DSI_CTRL_SOFT_RESET_CFG |
+		       DSI_PORT_BIT(CTRL_RESET_FIFOS));
+	DSI_PORT_WRITE(PHY_AFEC0, afec0 | DSI_PORT_BIT(PHY_AFEC0_RESET));
+	/* AFEC reset hold time */
+	mdelay(1);
+
+	DSI_PORT_WRITE(CTRL, ctrl & ~DSI_CTRL_CAL_BYTE);
+	DSI_PORT_WRITE(HSTX_TO_CNT, hstx_to);
+	DSI_PORT_WRITE(LPRX_TO_CNT, lprx_to);

[Severity: High]
Can writing ctrl & ~DSI_CTRL_CAL_BYTE back to CTRL prematurely un-gate and
enable the controller before the subsequent writes to timing and PHY
configuration registers?

Since ctrl was read while a transfer was in progress, it contains the enable
bit (DSI0_CTRL_CTRL0 or DSI1_CTRL_EN).

Writing it back here enables the hardware block before its timings
(HSTX_TO_CNT, HS_CLT0, PHYC, etc.) are restored, which could cause erratic =
bus
behavior and unrecoverable hardware states.

> +	DSI_PORT_WRITE(TA_TO_CNT, ta_to);
[ ... ]
+static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,
+				     const struct mipi_dsi_msg *msg)
+{
+	struct vc4_dsi *dsi =3D host_to_dsi(host);
+	u32 disp0_ctrl;
+	ssize_t ret;
+
+	ret =3D vc4_dsi_transfer(dsi, msg);

[Severity: Medium]
Does this entry point need a mutex to serialize concurrent transfers?

If user-space concurrently triggers DCS commands (e.g., via sysfs backlight
updates and DRM KMS modesets), they can race because vc4_dsi_transfer()
modifies shared variables like dsi->xfer_completion without a lock.

With this patch, a timeout caused by such a race now triggers a full block
reset in vc4_dsi_reset_and_restore(), disrupting any interleaved concurrent
transfer.

+	if (ret !=3D -ETIMEDOUT)
+		return ret;
+
+	/*
+	 * Leave the block usable for the next transfer. The message is not
+	 * resent: it may already have reached the peripheral, and only the
+	 * caller knows whether it is safe to repeat.
+	 */
+	disp0_ctrl =3D DSI_PORT_READ(DISP0_CTRL);
+	dev_warn(&dsi->pdev->dev,
+		 "transfer timed out (stat 0x%08x), resetting DSI\n",
+		 DSI_PORT_READ(STAT));
+	vc4_dsi_reset_and_restore(dsi);
+	DSI_PORT_WRITE(DISP0_CTRL, disp0_ctrl);
+
+	return ret;
+}

[Severity: High]
Can a timed-out transfer cause a spurious completion of a subsequent transf=
er?

If vc4_dsi_transfer() times out, wait_for_completion_timeout() returns.
However, if the hardware interrupt had fired and the threaded IRQ handler
(vc4_dsi_irq_handler) was preempted before calling
complete(&dsi->xfer_completion), it could still be pending.

Since there is no synchronization (like synchronize_irq()) in this timeout
recovery path to wait for the IRQ handler to finish, it returns immediately.

The caller might retry the transfer, reinitializing dsi->xfer_completion. T=
he
preempted IRQ thread could then resume, calling complete() and falsely waki=
ng up
the new transfer prematurely while the hardware is still busy.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012190249.3167=
-1-henryzhang62@gmail.com?part=3D2
