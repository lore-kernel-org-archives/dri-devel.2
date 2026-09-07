Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1353C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4491F10E7D3;
	Mon,  7 Sep 2026 13:00:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V7gbZVei";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78C9A10E7D3
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:00:23 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49d0726cdbcso708215e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 06:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788786022; x=1789390822; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eMVNQCd6i4RG6aVc2yBHhkRh+QAlwsGwWBLxiEeQYU0=;
 b=V7gbZVeidbfGe4252g1+MoNN4c282KDMbdmm0CmWRXsaadCOp+7c4oVzwMLGnnvbuO
 aFkwjEgGZDa4BE1IK2Z3f6G3QgPfkiqfu/wt7kRARz+/1mxwBG2LMJV5btxnfXQg5JsF
 EtLjFuvcU7XJ4mYfAaomAGsu6Mh5z2aesSf7AtxFXBKyLp+/vDFCTkRf1xSh38vq0GQ6
 OG/y39ugJ7wT66IdW3griNarRH1MarB1D7M5wneSvD1C3NEsRqnP2XWnIQvqHnbQciD6
 93pw9auRmjB9FXOqjmajs9eqAMIciDQGafI2/18DlqgiTNXemfmWMnY2ZN5fDTycrCCV
 j97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788786022; x=1789390822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eMVNQCd6i4RG6aVc2yBHhkRh+QAlwsGwWBLxiEeQYU0=;
 b=KMPzJXyqKddhqd+aRuAfZ6ZdN5CIbjpwmkVPvkIxI45+dOR0r6sl5+olDgxXiE39eM
 i2V7mR4m2QCrXigtitx+cjjkVGa+E+ortJ8gXjjjITb0gNGKdg9pYyaQH1/n9YYBTm9y
 qWVDzTpH7HvBL1dvDTxV/B7PiLlReoycjTtX2m40XyLEEIuY+rUAaQ3DgVrf+QidM8Jm
 9sfxojM9tjEW1lquYxQ75hjzTfw9U9sn2RwuXeUE4ue5I8HyDeJYs8ZqLy5ZFtnyKHC3
 iHTugUl7wj9Drbpqs+F8uRF6Z0AKajPmtvQJezreihxljRT3s4fTxco5YLDbofRMUsYK
 arWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx00mf3pnvA24vz9YcTZaojYYkEwoo9fBliZ2qpfkxPE8zYOj7L1vv4B9cw11BpBaZZ8m7W1dlihnQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lTdsG3cny/dzAn/yxX9e/Ux0IWNL7SOREuFIM5/SnfEjE8ymqP
 Aon8idBLO6kJx6cTnvwOGtklRYEBnW/YWEPz9XdXJ6Jw3c4LrLFPGzeC
X-Gm-Gg: AYBFou0yB9e1FRPml8x1gWQs7XhDhtoU9xpDeY7xbbhP1iPr+ikxjDZx5Oya8u7aIzQ
 HPaqrTeJY+mQgcGNsn4f4PJwAKvweXFSVbbLU7OFCaYh0qgNUK6YvaT5Osxi2mGhiCDnCqi+GLW
 AZvnXR/kdzQjUKDhkHfbL0WRHa2ha05HWLnkE7DCUUQ9USYN6h3ni6FIZzfEK+/YZDMeiP4rw4L
 yWE2b68hZ09jj/9utjKdRqZHEPD4Ebr8OBlJ5hTaE9NsxOTrQGFXeN7tWgR1VukqeyI6XEO9VdE
 OCnmgZLBMgcDE4dAWikQAzDwmJe0EvogSiyYcLiRbsoUVLLylixB+I2Kvb3/88nq+VmHUjGv2mj
 CUqqfJ1QJzzFgziUfz5zhVHRSxb9OpGK0deGzN1rNRSCfc3u91dm7TH9MCZG2grsUzFS/I+sRiO
 KhhA9OWoe53FLq1S+tuV4/NGUc7f/mX0VHmMFyaSP7S6o66Atv+Kg1hEXlUvnGUFfvAN3uk01gE
 I14xwsslFifpxgcSvQDaISUxSud7nVFpr7zbykGDSK17i5EycmRA/LGXyoanysWIJvsTkMjUivN
 TnW7
X-Received: by 2002:a05:600c:3b25:b0:49b:910c:76fb with SMTP id
 5b1f17b1804b1-49d01dd415bmr124724415e9.2.1788786021284; 
 Mon, 07 Sep 2026 06:00:21 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8822007B3AD9A87B9E27CB.dsl.pool.telekom.hu.
 [2001:4c4e:1b88:2200:7b3a:d9a8:7b9e:27cb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5533ffbsm318152775e9.3.2026.09.07.06.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:00:20 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Frank Zhang <rmxpzlb@gmail.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Detlev Casanova <detlev.casanova@collabora.com>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, daniels@collabora.com,
 dmitry.baryshkov@oss.qualcomm.com, heiko@sntech.de,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe
 when PHY is down
Date: Mon,  7 Sep 2026 14:59:54 +0200
Message-ID: <20260907153000.hdmiqp-audio-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512103153.8861-1-rmxpzlb@gmail.com>
References: <20260512103153.8861-1-rmxpzlb@gmail.com>
 <b89a3039-05b7-4e4f-8306-07a37d2bd3c9@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Frank, Cristian,

Independent hit of the same crash, in case it helps get this one moving
again.

Board: Rockchip RK3588, Orange Pi 5 Plus. Kernel: 7.2.0-rc7 with the
Collabora dw-hdmi-qp HDMI 2.1/FRL work on top (so not plain mainline, but
the audio shutdown path is the same code). Userspace: PipeWire/WirePlumber.

At that boot the HDMI link never came up (the sink did not answer SCDC),
so every snd_soc_dai_prepare() failed with -ENODEV, and about five seconds
later WirePlumber closing the PCM took the same path your patch guards:

  snd_pcm_release -> hdmi_codec_shutdown
    -> drm_connector_hdmi_audio_shutdown
    -> dw_hdmi_qp_audio_disable
    -> drm_atomic_helper_connector_hdmi_clear_audio_infoframe
    -> dw_hdmi_qp_bridge_clear_audio_infoframe
    -> regmap_update_bits (read) -> SError, panic

Serial console excerpt (7.2.0-rc7, tmds_char_rate was 0 at that point):

[   16.597316] hdmi-audio-codec hdmi-audio-codec.7.auto: ASoC error (-19): at snd_soc_dai_prepare() on i2s-hifi   (x4)
[   16.601847] SError Interrupt on CPU5, code 0x00000000be000011 -- SError
[   16.601852] CPU: 5 UID: 112 PID: 2821 Comm: wireplumber Tainted: G   M       OE       7.2.0-rc7-rk3588-igor-claude-hdr2+ #10 PREEMPT(lazy)
[   16.601862] pc : regmap_mmio_read32le+0x38/0xf0
[   16.601867] lr : regmap_mmio_read+0x50/0x98
[...]
[   16.601903] Call trace:
[   16.601904]  show_stack+0x24/0x50 (C)
[   16.601908]  dump_stack_lvl+0xe0/0x140
[   16.601912]  dump_stack+0x1c/0x38
[   16.601915]  vpanic+0x4e8/0x5b0
[   16.601919]  panic+0x6c/0x78
[   16.601921]  nmi_panic+0x8c/0x98
[   16.601924]  arm64_serror_panic+0x7c/0x98
[   16.601927]  arm64_is_fatal_ras_serror+0xa8/0xb0
[   16.601930]  do_serror+0x3c/0x78
[   16.601932]  el1h_64_error_handler+0x40/0x80
[   16.601937]  el1h_64_error+0x84/0x88
[   16.601938]  regmap_mmio_read32le+0x38/0xf0 (P)
[   16.601941]  regmap_mmio_read+0x50/0x98
[   16.601943]  _regmap_bus_reg_read+0x68/0xd0
[   16.601947]  _regmap_read+0x80/0x2a8
[   16.601950]  _regmap_update_bits+0x13c/0x1e0
[   16.601953]  regmap_update_bits_base+0x70/0xd0
[   16.601956]  dw_hdmi_qp_bridge_clear_audio_infoframe+0x3c/0x78 [dw_hdmi_qp]
[   16.601964]  drm_bridge_connector_clear_audio_infoframe+0x2c/0x68 [drm_display_helper]
[   16.601993]  clear_infoframe+0x5c/0x128 [drm_display_helper]
[   16.602016]  drm_atomic_helper_connector_hdmi_clear_audio_infoframe+0x70/0x110 [drm_display_helper]
[   16.602039]  dw_hdmi_qp_audio_disable+0x28/0x108 [dw_hdmi_qp]
[   16.602042]  drm_bridge_connector_audio_shutdown+0x38/0x80 [drm_display_helper]
[   16.602065]  drm_connector_hdmi_audio_shutdown+0x28/0x50 [drm_display_helper]
[   16.602086]  hdmi_codec_shutdown+0x68/0xb0 [snd_soc_hdmi_codec]
[   16.602091]  snd_soc_dai_shutdown+0x60/0xe0 [snd_soc_core]
[   16.602123]  soc_pcm_clean.isra.0+0x5c/0x1f8 [snd_soc_core]
[   16.602151]  soc_pcm_close+0x40/0x80 [snd_soc_core]
[   16.602177]  snd_pcm_release_substream.part.0+0x48/0xf0 [snd_pcm]
[   16.602193]  snd_pcm_release+0x68/0x110 [snd_pcm]
[   16.602205]  __fput+0xe4/0x340
[   16.602209]  fput_close_sync+0x4c/0x138
[   16.602211]  __arm64_sys_close+0x44/0xa0
[   16.602215]  invoke_syscall+0xa8/0x138
[   16.602217]  el0_svc_common.constprop.0+0x114/0x140
[   16.602219]  do_el0_svc+0x28/0x58
[   16.602222]  el0_svc+0x48/0x310
[   16.602225]  el0t_64_sync_handler+0xc0/0x108

So the asymmetry is exactly what you describe: audio_enable/prepare check
hdmi->tmds_char_rate, audio_disable does not, and the read-modify-write in
clear_audio_infoframe hits the block with the PHY down.

Today I could reproduce it on demand, with the in-tree module of the same
kernel: disable one HDMI output in the compositor (KWin, so
atomic_disable() runs: tmds_char_rate = 0, PHY off), then

  aplay -D plughw:hdmi1,0 /usr/share/sounds/alsa/Front_Center.wav

open succeeds, prepare logs the usual "ASoC error (-19)", and the close
that follows dies in the same place, this time as a synchronous abort:

  Internal error: synchronous external abort: 0000000096000010 [#1] SMP
  pc : regmap_mmio_read32le+0x30/0xf0
  ...
  dw_hdmi_qp_bridge_clear_audio_infoframe+0x3c/0x78 [dw_hdmi_qp]
  drm_bridge_connector_clear_audio_infoframe+0x2c/0x68 [drm_display_helper]
  drm_atomic_helper_connector_hdmi_clear_audio_infoframe+0x70/0x110 [drm_display_helper]
  dw_hdmi_qp_audio_disable+0x28/0x108 [dw_hdmi_qp]
  hdmi_codec_shutdown+0x68/0xb0 [snd_soc_hdmi_codec]
  snd_soc_dai_shutdown+0x60/0xe0 [snd_soc_core]
  soc_pcm_close+0x40/0x80 [snd_soc_core]
  snd_pcm_release+0x68/0x110 [snd_pcm]
  __arm64_sys_close+0x44/0xa0
  note: aplay[52181] exited with irqs disabled
  note: aplay[52181] exited with preempt_count 1

(x19 = 0xffff800081ca0aa8, i.e. PKTSCHED_PKT_EN.) One more consequence of
the non-fatal variant that may be worth a line in the changelog: the task
dies while snd_pcm_release() is still holding the PCM's open_mutex, so
every later open() of that PCM blocks in D state until reboot - the card
is gone for the session. The reboot after that hung too (soft lockup in
rcu_exp_gp_kthread, a CPU never answering the NMI - I don't have a clean
causal chain for that second hang) and ended in a hard reset.

I read Cristian's comment on v4 - if you post a v5 that reuses
dw_hdmi_qp_bridge_clear_audio_infoframe() from the write path instead of
open-coding it, I am happy to run it on this board and reply with a
Tested-by. I have a serial console attached, so the negative case (PCM close
after the link failed to train) is something I can exercise here.

Thanks,
Igor
