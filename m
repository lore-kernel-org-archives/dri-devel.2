Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AEAC88E4C
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18A9510F519;
	Fri, 11 Sep 2026 07:50:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="euuZE2GZ";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC1A610E0A7
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 12:08:23 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843c2790ccso1389753f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 05:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789042102; x=1789646902; darn=lists.freedesktop.org;
 h=references:in-reply-to:subject:cc:to:from:message-id:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kr90axAl39Wct6vUhubTPo3djvuufRCk0pWZynFpKbM=;
 b=euuZE2GZZuSPIanajoF5rK004WxDHCU82+h4DdXE8cmdzOLxd1PBgzGHeoMyYQYAOF
 d1L0lTMax+U/7vi0cvFF6jw3AZILdcxMwLDrGmzMwkY4nf8Pe/gaXM47ipLY74oC+NEL
 cijaMrhP7cisvhEp2+FOFGUbQTevcvWUfjMTsCYv1AWGve1XPHh3DgrcxHeHkIvu0is+
 QtpO5r15Op9ssRqDngMCYzm5pPaKvtHECGe+cnBfcfPIbJx0ojYpgBmSRKBbAK8cBGqL
 Z4uJJ+pthMIFxoO822MxV6Y91HeILS9XAkNrtTaTJOadBRxqRzjil0y+5vSEGCnNo6o8
 yvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789042102; x=1789646902;
 h=references:in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kr90axAl39Wct6vUhubTPo3djvuufRCk0pWZynFpKbM=;
 b=cLw3Pby/yX96xVJTuwix+GxF8ox6MuP2NjltW2ZMttHtQ0XueE64a9A/p03sJJNMS3
 0fSAV7O4JWx4f9+HMVcUGUf9WtjiWmbGIvx8sVtao0PvWEJ6JXPgfzYlBFs4CNn8KCMn
 pTQ3kRD2q1noDkD71nTEnOQkK04gC0dJMFyu7vAwbvN7NdWJQkRfSITLW8Ok2aGI9DIi
 NlPTpQ8ZL6JpXMX5gdpA6ZrIxOmM7Vd3M6MT1aHXSMSH+3lv0+PQvhnLIRCPwoAsmX5Y
 3PqK3bkxCFtsMOi6g4nQboOpYmH6kcDrQpxxl/+XMF1rrLoHzkZg0JleGvZR+RmRvZMX
 Jn0Q==
X-Gm-Message-State: AFuF++lyhPJoeN7ZTrQjmQaXJ59wpq9x5PrvD2KHJfC+FR6S7k0CE4X9
 Ps8Nyd5ujZP2zMHGzILHIbyzEKt4a/oetqwjeIiBji0JvsiTlpQej+vW
X-Gm-Gg: AYBFou0NzH8rcLiydo2u/H4nCXB18rb4f+5k8wMK9uytLLNzmiYHRZbz7TDarEBp81W
 Tn2JGbW2p2AR8vrOGVY5vcULh9mftEk5u2zBuf4aeY364WYOUW84reYs5KhaAkX5xxrdkg8fZ0u
 CYqvrpfn5I/l+wjT98oDG14g3aefdQptkov8HCbrq+73F5zQ66DStAMu8EqzeLyWstmhUWpS6vW
 kF7UUSic6BapOz4DFIFa6EHIWYzoq+dSnRM92Uh7teKnJWr38JJoBBqTuBqPR+1NrM+BAviH5FD
 ECXGsQGRKbsz7+ha+nBmuw2jkqvRxQfBFoM/3kp0m2bUgMKq8OtlFZr5K7MqYemNWwHXFcoO6zi
 BeGnxEuS7TdkU43H63Q6YMAbUeu6HpBNNY/qWAkcM6nUZVevjFR6wArbFzPq2+tMa2GpNTq5EnV
 knZewvUbmZTI77+LUA/7TRIZGrw9C0nYe//RW7bDmE+lIM56Z4SmCh+pXjwsGjQ4sY/p4HiL4tv
 uKEHHXPpDFnZXWkN8pqnWulBnZX05m8m1Qdu9McGtKvVAfbxYyFT27pLig9ePCGplG+eDOvUVxR
 KbMrqfhX66ceig==
X-Received: by 2002:a05:6000:1883:b0:482:ea08:8c97 with SMTP id
 ffacd0b85a97d-485aad9458dmr21686931f8f.2.1789042101895; 
 Thu, 10 Sep 2026 05:08:21 -0700 (PDT)
Received: from localhost (adsl-178-39-48-248.adslplus.ch. [178.39.48.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c81c3sm51597465f8f.26.2026.09.10.05.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 05:08:20 -0700 (PDT)
Date: Thu, 10 Sep 2026 14:08:20 +0200
Message-ID: <4d885f9e201df6f48a06f4ab3b27a7f1@gmail.com>
From: Robin Räber <robin.raebi@gmail.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 00/74] Add HDMI 2.0 support to DW HDMI QP TX
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
X-Mailman-Approved-At: Fri, 11 Sep 2026 07:50:02 +0000
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

Hi Cristian,

I tested this series on a Xunlong Orange Pi 5 (RK3588S) driving an
AOC Q32G1WG4 monitor (2560x1440@144, TMDS char rate 592 MHz) and can
report that scrambling works, with one interop issue described below.

A note on the test base: drm-misc-next at the series' base commit does
not boot on this board for reasons unrelated to the series (the
unpatched base commit hangs early as well; I can dig into that
separately). I therefore backported the series onto v7.2.3, dropping
the vc4/sun4i/tests patches and adjusting for minor context drift in
drm_connector.c and the scdc/hdmi helpers. The dw-hdmi-qp, rockchip,
bridge_connector and helper patches applied without functional
changes.

With the backport applied, all four 2560x1440 modes (60/100/120/144)
are exposed and 144 Hz works, but scrambling initially failed:

  rockchip-drm display-subsystem: [drm] Sink doesn't support scrambling.
  dwhdmiqp-rockchip fde80000.hdmi: Failed to enable scrambling: -22

The cause is the monitor's EDID: its HF-VSDB declares a Maximum TMDS
Character Rate of 600 MHz but leaves the SCDC Present flag unset, so
drm_scdc_sink_supports_scrambling() rejects it. The SCDC interface of
this display is nevertheless fully functional: reading SCDC via DDC
returns sink version 1, writes are accepted, and after the change
below TMDS_CONFIG reads back 0x03 (scrambling + 40-bit clock ratio)
with a stable picture at 592 MHz.

Since HDMI 2.0 mandates SCDC support for character rates above
340 MHz, I worked around it by trusting the declared rate:

--- a/drivers/gpu/drm/display/drm_hdmi_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_helper.c
@@ static bool drm_scdc_sink_supports_scrambling(struct drm_connector *connector)
 {
 	const struct drm_display_info *info = &connector->display_info;
 
-	return info->is_hdmi &&
-	       info->hdmi.scdc.supported &&
-	       info->hdmi.scdc.scrambling.supported;
+	if (!info->is_hdmi)
+		return false;
+
+	/*
+	 * Some displays (e.g. AOC Q32G1WG4) declare a Max TMDS Character
+	 * Rate above 340 MHz in their HF-VSDB but leave the SCDC Present
+	 * flag unset, even though SCDC is functional. The spec mandates
+	 * SCDC support for rates above 340 MHz, so trust the declared rate.
+	 */
+	if (info->max_tmds_clock > 340000)
+		return true;
+
+	return info->hdmi.scdc.supported &&
+	       info->hdmi.scdc.scrambling.supported;
 }

I'm happy to test further revisions on this hardware, and to submit
the above as a proper patch if you think this is the right place to
handle such non-conformant EDIDs.

For the dw-hdmi-qp/rockchip/helper parts, on the backport described
above:

Tested-by: Robin Räber <robin.raebi@gmail.com>

Best regards,
Robin
