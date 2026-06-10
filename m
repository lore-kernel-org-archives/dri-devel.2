Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3962CD98D6
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0523A10EE4C;
	Thu, 11 Jun 2026 10:49:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sms-medipool.de header.i=@sms-medipool.de header.b="p5/sMMMS";
	dkim-atps=neutral
X-Greylist: delayed 595 seconds by postgrey-1.36 at gabe;
 Wed, 10 Jun 2026 17:58:06 UTC
Received: from mail.sms-medipool.de (mail.sms-medipool.de [178.63.14.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 177AB10EB42
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 17:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sms-medipool.de;
 s=mail; t=1781113715;
 bh=nE96KNk6MqeKHtTvcFrsvJeaaru9noiZamxjCmdDHI0=;
 h=From:To:Cc:Subject:Date:From;
 b=p5/sMMMS8C1YnggKI8IIPW2zNVR9ItAI/7nWIrXa8cjyv368k2zP4T47J8tMKc0NP
 4MUj/gOIHmmuEjUIO6092492KckWM2wg7oGVxPnN6Vv4XohfZBVagrJQjGT6DZfRf3
 0npjAIu3wlvqMKTuw8U1V/3WWTlckVV8aPlH74LYmbYw6cV/pXWTXH5At7MSjHebJY
 GFGhcY937Kx6rhwZAy0WW0Mb4qM0bvO7l964x/SDVa5i3hIa4rpEHcqLVQrYT/uPPT
 1ypLFjHpRdrUAppOOjwwau+Ovoed3hkT+VATcoG1jxRdm2FnSo0LSj6FF2zo8PY2QW
 yFvjNZznUFsEA==
Received: from mail.stoss-medica.de (mail.stoss-medica.de [213.147.17.40])
 by mail.sms-medipool.de (Postfix) with ESMTPS id C675011B61;
 Wed, 10 Jun 2026 19:48:35 +0200 (CEST)
Received: from NUC16-Linux.sb.golima.de ([95.88.98.111])
 by mail.stoss-medica.de (Kerio Connect 10.0.8 patch 2) with ESMTP;
 Wed, 10 Jun 2026 19:48:34 +0200
From: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: Hans Verkuil <hverkuil@kernel.org>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, alexander.kaplan@sms-medipool.de
Subject: [PATCH] drm/dp: Service the CEC tunneling IRQ flags without CEC_IRQ
 in ESI1
Date: Wed, 10 Jun 2026 19:48:33 +0200
Message-ID: <20260610174833.6284-1-alexander.kaplan@sms-medipool.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jun 2026 10:49:05 +0000
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

The DP standard requires a DP-to-HDMI protocol converter to assert
an IRQ_HPD pulse with the CEC_IRQ bit in the
DEVICE_SERVICE_IRQ_VECTOR_ESI1 register set whenever it sets a bit in
the CEC_TUNNELING_IRQ_FLAGS register (DP v2.0, Table 2-194, DPCD
address 3004h).

The Synaptics VMM7100 based DP-to-HDMI protocol converters get this
half right.
They assert an IRQ_HPD pulse for each CEC event, but never set the
CEC_IRQ bit.
ESI1 reads as 0 at the very moment CEC_TUNNELING_IRQ_FLAGS has the
corresponding TX/RX flags set.
drm_dp_cec_irq() trusts the bit and returns without servicing the
flags, so no transmit is ever completed and the CEC adapter is
unusable with these devices.
Every transmit times out, claiming a logical address fails and the
/dev/cecX device ends up unconfigured.
The converter's CEC engine itself works fine.
Driving the CEC tunneling DPCD registers manually shows the TV
ACKing the tunneled messages and sending requests of its own.

Demote the CEC_IRQ bit from a gate to an acknowledge hint: service
the CEC tunneling IRQ flags on every IRQ_HPD pulse, whether or not
the branch device set CEC_IRQ, and acknowledge CEC_IRQ in ESI1 only
when it was actually set.
Servicing is idempotent since every action is keyed to a
write-1-to-clear flag bit, so for branch devices with no pending CEC
event this amounts to one additional AUX read of the flags register,
and only on connectors that advertise the CEC tunneling capability
(without it no CEC adapter is registered and drm_dp_cec_irq()
returns early as before).
Devices that conformantly set CEC_IRQ are serviced exactly as before.

With this the CEC adapter of a VMM7100 based USB-C to HDMI adapter
configures and transmits successfully (verified against an LG OLED
TV with an Intel Panther Lake xe device, including TV power on/off
over CEC).

Fixes: 2c6d1fffa1d9 ("drm: add support for DisplayPort CEC-Tunneling-over-AUX")
Signed-off-by: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
---
This patch is part of a set of independent fixes for the USB-C to DP
to HDMI 2.1 protocol converter (PCON) path, found and verified on an
ASUS NUC 16 Pro (Panther Lake, xe) with Synaptics VMM7100 based
adapters.
Each part stands on its own and can be merged independently.
The other parts:
[1] https://lore.kernel.org/r/20260610174413.5881-1-alexander.kaplan@sms-medipool.de
[2] https://lore.kernel.org/r/20260610174807.6231-1-alexander.kaplan@sms-medipool.de
[3] https://lore.kernel.org/r/20260610174819.6258-1-alexander.kaplan@sms-medipool.de
 drivers/gpu/drm/display/drm_dp_cec.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_cec.c b/drivers/gpu/drm/display/drm_dp_cec.c
index 436bfe9f9081..824a99f86a3d 100644
--- a/drivers/gpu/drm/display/drm_dp_cec.c
+++ b/drivers/gpu/drm/display/drm_dp_cec.c
@@ -218,6 +218,9 @@ static void drm_dp_cec_handle_irq(struct drm_dp_aux *aux)
 	if (drm_dp_dpcd_read_byte(aux, DP_CEC_TUNNELING_IRQ_FLAGS, &flags) < 0)
 		return;
 
+	if (!flags)
+		return;
+
 	if (flags & DP_CEC_RX_MESSAGE_INFO_VALID)
 		drm_dp_cec_received(aux);
 
@@ -255,11 +258,22 @@ void drm_dp_cec_irq(struct drm_dp_aux *aux)
 
 	ret = drm_dp_dpcd_read_byte(aux, DP_DEVICE_SERVICE_IRQ_VECTOR_ESI1,
 				    &cec_irq);
-	if (ret < 0 || !(cec_irq & DP_CEC_IRQ))
+	if (ret < 0)
 		goto unlock;
 
+	/*
+	 * Some branch devices, for instance the Synaptics VMM7100 based
+	 * DP-to-HDMI protocol converters, assert an IRQ_HPD pulse for each
+	 * CEC event, but never set the CEC_IRQ bit in the
+	 * DEVICE_SERVICE_IRQ_VECTOR_ESI1 register. Check the CEC tunneling
+	 * IRQ flags even without CEC_IRQ being set: servicing the flags is
+	 * idempotent and only costs one additional AUX read.
+	 */
 	drm_dp_cec_handle_irq(aux);
-	drm_dp_dpcd_write_byte(aux, DP_DEVICE_SERVICE_IRQ_VECTOR_ESI1, DP_CEC_IRQ);
+
+	if (cec_irq & DP_CEC_IRQ)
+		drm_dp_dpcd_write_byte(aux, DP_DEVICE_SERVICE_IRQ_VECTOR_ESI1,
+				       DP_CEC_IRQ);
 unlock:
 	mutex_unlock(&aux->cec.lock);
 }
-- 
2.54.0


