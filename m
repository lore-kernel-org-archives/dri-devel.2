Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4A9C61DB9
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 782B010EAA2;
	Tue, 25 Aug 2026 14:35:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oESYlRgD";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29D9F10E90B
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 06:37:43 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6a422090b14so5825142a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 23:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787639861; x=1788244661; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ci3WaRxL1LKBNX+6XcT/a5YijLEiic6s2oitvILr4v4=;
 b=oESYlRgDx9DgTsUfVFE49VFtguxmQTcipDmLkaDjSh80EsSm3A876e05e0OsZE04D+
 +FTgVZ4b/eLFG3kAgqNtbRJ6Npa6Tgjc3z74RUKyDU/LWijTlZFFWFOcH6gr0fFFbvwO
 Cc0GsT0xmdwQTsV6QxMBeBST+AlvdxNiOBqxPv+zX2zqO+fusstQa2FMxKgYKYbptH0E
 stzM1JoibMjoUpgAsLdRJHl6qSscf9GuSiy8wFCGUtmljQfLbNjbCr/am3MuNjdfj7Qf
 k3G0jKKQGg0Sbb/PyCwM9VNmQrZeBBh3dlgGaS4THF5lcr2qWTMSeWWyzaRthY7J2wie
 duKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787639861; x=1788244661;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ci3WaRxL1LKBNX+6XcT/a5YijLEiic6s2oitvILr4v4=;
 b=fZ2nJ2dyxLiaXOPOmPPl6DjfCUPiVAVUnmycKt8m0NNFGFMCE/1WwsPRCXBx+ikENa
 65tMkzZpL/2f9cJyU9DN0yucGwH2P5h5SU75p0e/lxA+31OZUgkTfn3WhKB17j46q0ip
 3j0/81QqrY99cFIz+YXoYQN14zLVFvlw0964/8yh1Y/Wnoqg6r0SlRYIjSqm7fvgV2h9
 cFX3KGiMMoio+lXcDn6q+dmdr8ySGg1oG1HSZJV7SFYMVBOOFd/V628RIvd6gJScXAPT
 PyoATakAxuytcbqGvYWWNJ19pklb3ggmzChafjEOPGrNVdQBAwi40AwGd5WyJa1yW1gA
 yhUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr1Y1JzVzh+UbFhxH1E9db61/KX4PXwAKvBQNr4gmnXC/dhnbDJDWStxRVX3skIeW54LN/8IUorT3Y=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kZKB1b2TXRvwIenCn2B4TERtTow0txe5USfDHf8PFnpgEMu3yq
 2oG8dJcHvDTmkrvzuWj8AUboD4LHjgCfDy23gFEbqoQbKG2sDxNTX7Kv
X-Gm-Gg: AR+sD12T8iBOj3+hzxeuGhCnSjkJWW7yVeozE7sSfsxtIa1MYBBFzJQUNxZeItujE/3
 ifvEYLUuj7VPmzfiOemCi1s1o/+E++U5BHT3ZL9HE/zt+RR5+dtcBXDHzp+wkrEdE1bv99neJoc
 ngAIPR+3vzQo47yqobwZa5dtMAPDDDRV6znv40DWbrBV4603pR3fq1ZuKPEDCZX+YRkObGOWJE0
 NrSIHlttZLK7Ls9W/TltuZ/R6wqMEFtLFZOKhzAHNlOeoaA1nEciwUeyaT9czOQiUALx+k6Wkcm
 8xWcBej2aaAu5vxxNIU2gTP2JPTacpl2nORQKpOXA5u1Cen/jf8oResHvL0ptoke6qQmBBa8RL+
 m+rgoXs4XfFUryNTyh/Z8iDwuXmydcC8PkJITnUZ3BOx2KjUMT+c8MmRwcADYtk+FKEEmqyhJ68
 IdDaeiPbgIYVYtlSmozHIdTwpMidPzjKGxOsEiudeE6ZwdIRq6kRhflV3fxw1OFlH4W8vDPZGk+
 Z1E+LyGz7RHNzuDPy1Qy/fTFexYu686T42u7i2Ch8AREuA1SwbMUiL+QOhofP8XkRH96I3IjWt6
 vybPMiN2kqi5QdgXo3vAOW7ffsDMosa6Vrh8+s6c0AfYE65HsBVx4wNYbsr6nZm25YS4
X-Received: by 2002:a17:907:9626:b0:c24:87e3:b8b8 with SMTP id
 a640c23a62f3a-c249209907amr2334856866b.17.1787639861208; 
 Mon, 24 Aug 2026 23:37:41 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-af54-b201-7419-a557-62e9-4d13.310.pool.telefonica.de.
 [2a02:3100:af54:b201:7419:a557:62e9:4d13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249689fa97sm1442110066b.57.2026.08.24.23.37.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Aug 2026 23:37:40 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-sound@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v3] drm/vc4: hdmi: Unregister the ASoC card on unbind
Date: Tue, 25 Aug 2026 08:37:35 +0200
Message-Id: <20260825063735.14676-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Aug 2026 14:35:48 +0000
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

vc4_hdmi, including the embedded ASoC card, is DRM-managed and remains
alive until the final reference to the DRM device is dropped. The card is
registered with devm_snd_soc_register_card() on the HDMI platform device
from the component bind callback, so its devres node starts out in the
component's devres group and would ordinarily be released at component
unbind, while vc4_hdmi is still alive.

Whenever an ASoC component is registered, the core retries every card
waiting for components. For a devm-managed card, each retry destroys and
re-adds its devres node. Because snd_soc_bind_card() requeues the card and
converts -EPROBE_DEFER to success, even a retry that still defers can move
the node outside the now-closed component devres group. It is then released
only at HDMI platform driver detach rather than component unbind.

With no DRM file open, as in the reproducer below, aggregate teardown
drops the final DRM reference. This frees vc4_hdmi before the HDMI
platform device's devres release, so snd_soc_unregister_card() accesses
freed memory:

  # modprobe vc4; rmmod vc4
  BUG: KASAN: slab-use-after-free in snd_soc_unregister_card
  Read of size 1 at addr ffff0000456a8450 by task rmmod/262
   devm_card_bind_release / devres_release_all / driver_detach
  Allocated by task 171: drmm_kmalloc / vc4_hdmi_bind
  Freed by task 262 (rmmod): drm_dev_put / component_del

If a DRM file remains open through platform detach, the final DRM release
is deferred until the last close and the ordering is reversed.

Register the card without devm and unregister it from the component unbind
callback, where both the HDMI device resources and vc4_hdmi are alive. This
makes the card lifetime independent of when the final DRM reference is
dropped.

Fixes: 42d99857d6f0 ("ASoC: core: Move all users to deferrable card binding")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
v3:
- Clarify that DRM-managed memory is released when the final DRM
  reference is dropped, not necessarily at driver unbind. With no open
  DRM file this precedes the HDMI platform devres release; with a file
  held open through detach the ordering is reversed. No code changes.

v2: https://lore.kernel.org/r/20260823173740.2983-1-kmehltretter@gmail.com/
- Preserve the existing ASoC component-lifetime comment and document at
  the card registration site how deferrable binding can move the card's
  devres node outside the component devres group.
- Point Fixes at the deferrable card binding change.
- Add the ASoC maintainers and linux-sound recipients, add the stable
  trailer, and update Assisted-by to the current format.

v1: https://lore.kernel.org/r/20260822143218.68764-1-kmehltretter@gmail.com/

Tested on a Raspberry Pi 400 (BCM2711), v7.2-11658-g26260251022f, with
KASAN: report gone, rmmod/insmod loop clean.

 drivers/gpu/drm/vc4/vc4_hdmi.c | 24 +++++++++++++++++++++---
 drivers/gpu/drm/vc4/vc4_hdmi.h |  1 +
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 17c8635c5afa..7e312932488a 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -2422,12 +2422,18 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 	 * snd_soc_card_get_drvdata() if needed.
 	 */
 	snd_soc_card_set_drvdata(card, vc4_hdmi);
-	ret = devm_snd_soc_register_card(dev, card);
+
+	/*
+	 * Deferred card binding can move a devm registration outside the
+	 * component devres group, so unregister the card explicitly at unbind.
+	 */
+	ret = snd_soc_register_card(card);
 	if (ret)
-		dev_err_probe(dev, ret, "Could not register sound card\n");
+		return dev_err_probe(dev, ret, "Could not register sound card\n");
 
-	return ret;
+	vc4_hdmi->audio.card_registered = true;
 
+	return 0;
 }
 
 static irqreturn_t vc4_hdmi_hpd_irq_thread(int irq, void *priv)
@@ -3345,8 +3351,20 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 	return ret;
 }
 
+static void vc4_hdmi_unbind(struct device *dev, struct device *master,
+			    void *data)
+{
+	struct vc4_hdmi *vc4_hdmi = dev_get_drvdata(dev);
+
+	if (vc4_hdmi->audio.card_registered) {
+		snd_soc_unregister_card(&vc4_hdmi->audio.card);
+		vc4_hdmi->audio.card_registered = false;
+	}
+}
+
 static const struct component_ops vc4_hdmi_ops = {
 	.bind   = vc4_hdmi_bind,
+	.unbind = vc4_hdmi_unbind,
 };
 
 static int vc4_hdmi_dev_probe(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 29d461d4ee49..444c73513d86 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -106,6 +106,7 @@ struct vc4_hdmi_audio {
 	struct snd_soc_dai_link_component platform;
 	struct snd_dmaengine_dai_dma_data dma_data;
 	bool streaming;
+	bool card_registered;
 };
 
 /* General HDMI hardware state. */
-- 
2.39.5 (Apple Git-154)
