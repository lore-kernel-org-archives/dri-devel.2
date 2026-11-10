Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8D8606A330
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=timsurber.de header.i=@timsurber.de header.a=rsa-sha256 header.s=MBO0001 header.b=lrBVtFU+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0996010F946;
	Wed, 11 Nov 2026 08:22:54 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DE5F10E3A3
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 21:56:18 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jPL805YvnzKnVv;
 Tue, 10 Nov 2026 22:56:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=timsurber.de;
 s=MBO0001; t=1794347776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5+84XRQja2nnqq3sHPcHJ7yp3gSL2eT4Yzx/gZRX0+E=;
 b=lrBVtFU+Cj9Pv/IB6Ef6Poz7ib9MJfNEyjNdjRVyb3o+AMTYpgGVHLTp/nszPW6cN9xvRp
 gMRXUmlLCY7FBbfHdxauKraBRprhgy7PnK+riLfe0OaI90HhbRpeHSSOlw1hk33HMpnaQt
 xC2XzOsAsTIrboUBTJrVofG8M8cdBa/UcIYCzjINlZGefUzdMpFt1AdLU4eB8Ft98sTnDU
 yZv21taC8qNONhJLu8FQwxfkMJsxAePzSwTMwC5xcT3n1GYkiNW7qHQNszxEb36s+BM3CE
 NMczRqKwxRyta5Sna5pA+clBTKm7JnuSanZzPJ+YGVHO8q6kzJO7dRa8kWbOdQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of me@timsurber.de designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=me@timsurber.de
From: Tim Surber <me@timsurber.de>
To: Frank Zhang <rmxpzlb@gmail.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andyshrk@163.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] drm/bridge: dw-hdmi-qp: serialize HDMI audio callbacks
 with PHY enable/disable
Date: Tue, 10 Nov 2026 22:55:35 +0100
Message-ID: <20261110215535.2658927-1-me@timsurber.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915103433.13163-1-rmxpzlb@gmail.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jPL805YvnzKnVv
X-Mailman-Approved-At: Wed, 11 Nov 2026 08:22:47 +0000
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Frank,

On Tue, Sep 15, 2026 at 06:34:33PM +0800, Frank Zhang wrote:
> The crash occurs when HDMI audio callbacks access registers after DRM
> atomic framework disabled the PHY.

I reproduced this on a FriendlyElec CM3588 NAS (RK3588) and tested v6.
The bug can be hit in more situations than the reboot case in the
commit message. The details are below in case they help with the
commit message or with the stable backport.

Setup:
- rockchip for-next at c3baae5f1 (7.4.0-rc1), arm64 defconfig
- HDMI TX/RX audio DT enablement for CM3588 on top (HDMI-IN series)
- Debian forky, GNOME 50 / Mutter 50.5
- HDMI0 TX looped back into the RK3588 HDMI RX, so playback on HDMI0
  can be captured on the HDMI-IN card for a functional check
- netconsole to capture oopses

Without the patch:

1) Display off, then open/close the PCM

   Mutter switches the outputs off (CRTC fully disabled):

     busctl --user set-property org.gnome.Mutter.DisplayConfig \
         /org/gnome/Mutter/DisplayConfig \
         org.gnome.Mutter.DisplayConfig PowerSaveMode i 3
     cat /sys/class/drm/card0-HDMI-A-1/enabled   # -> disabled
     speaker-test -D hw:HDMI0 -c2 -r 48000 -t sine -F S16_LE -l 1

   hw_params fails with -ENODEV (prepare sees tmds_char_rate == 0).
   The close that follows still reaches clear_audio_infoframe:

     Internal error: synchronous external abort: 0000000096000010 [#1] SMP
     pc : regmap_mmio_read32le+0xc/0x24
     Call trace:
      regmap_mmio_read32le+0xc/0x24 (P)
      _regmap_bus_reg_read+0x68/0xac
      _regmap_read+0x60/0xd8
      _regmap_update_bits+0xfc/0x14c
      regmap_update_bits_base+0x54/0x80
      dw_hdmi_qp_bridge_clear_audio_infoframe+0x30/0x40 [dw_hdmi_qp]
      drm_bridge_connector_clear_audio_infoframe+0x20/0x40 [drm_display_helper]
      clear_infoframe+0x50/0xf4 [drm_display_helper]
      drm_atomic_helper_connector_hdmi_clear_audio_infoframe+0x64/0xcc [drm_display_helper]
      dw_hdmi_qp_audio_disable+0x1c/0xa4 [dw_hdmi_qp]
      drm_bridge_connector_audio_shutdown+0x28/0x4c [drm_display_helper]
      drm_connector_hdmi_audio_shutdown+0x1c/0x30 [drm_display_helper]
      hdmi_codec_shutdown+0x58/0x7c [snd_soc_hdmi_codec]
      snd_soc_dai_shutdown+0x54/0x80 [snd_soc_core]
      soc_pcm_clean.isra.0+0x5c/0x1e0 [snd_soc_core]
      soc_pcm_close+0x34/0x60 [snd_soc_core]
      snd_pcm_release_substream.part.0+0x88/0xe0 [snd_pcm]
      snd_pcm_release+0x58/0xc8 [snd_pcm]
      __fput+0xd0/0x300
      ...
     note: speaker-test[1576] exited with irqs disabled
     note: speaker-test[1576] exited with preempt_count 1

   The task dies holding the ASoC PCM mutex. Afterwards the
   close_delayed_work kworker stays in D state in
   snd_soc_close_delayed_work(), so audio stays broken until reboot.
   One of my runs ended in an SError panic instead of the
   synchronous abort.

2) Display turned off while a stream is running (the wider case)

   Start playback on hw:HDMI0 with the display on, switch the display
   off through Mutter as above, keep playing, then stop the stream.
   Playback keeps running normally (state RUNNING, hw_ptr advancing)
   and nothing is reported to user space. When the stream is closed,
   the board dies: SSH drops, nothing reaches netconsole, and it
   reboots only through kernel.panic. I reproduced this twice.

   No application error is needed for this. Playing audio over HDMI
   while the desktop blanks the screen, or while the sink is
   unplugged, and then stopping playback is enough. I suspect this is
   also what most users hit in practice, more than the reboot path.

3) HDMI output never enabled (HDMI1, nothing connected)

   Opening and closing hw:HDMI1 repeatedly fails with -ENODEV and does
   not crash. The same holds for WirePlumber probing HDMI0 at boot,
   before the compositor enables it. The register accesses only fault
   after the PHY has been initialised once and then disabled, which
   matches your analysis.

With v6 applied:

- Case 1: the open now fails cleanly ("Playback open error: -95,
  Operation not supported" from the new startup check). No abort,
  and the system stays healthy.
- Case 2: playback continues after the display goes off, and the
  close completes cleanly. No hang.
- Case 3: unchanged, -ENODEV, no crash.
- Functional check: after re-enabling the display, a 440 Hz sine played
  on HDMI0 is captured correctly on the HDMI-IN card through the
  loopback, so the prepare/infoframe path still works.
- Stress test: for 2 minutes, HDMI0 was toggled on and off 114 times
  (atomic commits disabling/enabling the CRTC at random 0.1-0.9 s
  intervals), racing about 2950 open/play/close cycles on hw:HDMI0
  with random lifetimes. No oops, no hung tasks, nothing new in
  dmesg (lockdep was not enabled).

It may be worth adding the "stream open while the output is disabled"
case to the commit message. It is much easier to trigger than the
reboot race and makes a stronger case for the stable backport.

Tested-by: Tim Surber <me@timsurber.de> # FriendlyElec CM3588 NAS (RK3588)

Thanks,
Tim
