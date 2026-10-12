Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81B5CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 11:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F44E10F011;
	Mon, 12 Oct 2026 11:34:36 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBADB10F038
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 11:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=Cc1Uea7diDM+0S37dFP6rR7kt2Lopk4LERQKkL/X0OU=; b=smdh0966KQhEA17VFMjFRS0ll1
 qvQYI78uBQAglNpsHEZ56Nzv22CQxKdOx38mqWkNJhL5FgZzpiiMWAgQf2f4m7Um50P6cWV1jykB9
 KCqAI4rdCwrlg5PlJboe+pPTrEFf348D9Eg5qTrWH9/P4tqih8qf6tBk+x8XK3wDg3rS2eH+XoWzk
 pAYUghxU9F4IxfsunU/VGZPpMB9Y2aljjaIp6ue2RndxvrSfTix1A1+Hu1pZq0TD/2AcU300tXLOT
 qBx16mC7sIpUr9ftGUwDv4m8+ijjEmC7zW94CviX8hphPXuMcWxw5cN06hzbYmPS65ujh7yawcWx3
 Kx4mwD4g==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xGEIQ-00GQnV-8m; Mon, 12 Oct 2026 13:34:22 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: kernel-dev@igalia.com,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/2] drm/vc4: VC4 HDMI Runtime PM fixes for Packet RAM
Date: Mon, 12 Oct 2026 08:33:33 -0300
Message-ID: <179180481049.3672683.8597368731332679923.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002-vc4-hdmi-packet-ram-fix-v1-0-3d73148096c9@igalia.com>
References: <20261002-vc4-hdmi-packet-ram-fix-v1-0-3d73148096c9@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Fri, 02 Oct 2026 10:36:42 -0300, Maíra Canal wrote:
> While testing Raspberry Pi 4 HDMI hotplug with drm-misc-fixes, I hit the
> following warning:
> 
> [  201.570266] ------------[ cut here ]------------
> [  201.570293] Packet RAM has to be on to store the packet.
> [  201.570367] WARNING: drivers/gpu/drm/vc4/vc4_hdmi.c:683 at vc4_hdmi_write_infoframe+0x404/0x494 [vc4], CPU#0: wireplumber/1606
> [...]
> [  201.658650] Hardware name: Raspberry Pi 4 Model B Rev 1.5 (DT)
> [...]
> [  201.758499] Call trace:
> [  201.760967]  vc4_hdmi_write_infoframe+0x404/0x494 [vc4] (P)
> [  201.766607]  vc4_hdmi_write_audio_infoframe+0x1c/0x28 [vc4]
> [  201.772247]  write_infoframe+0xbc/0x140 [drm_display_helper]
> [  201.777975]  drm_atomic_helper_connector_hdmi_update_audio_infoframe+0x80/0xdc [drm_display_helper]
> [  201.787140]  vc4_hdmi_audio_prepare+0x4ac/0x570 [vc4]
> [  201.792252]  drm_connector_hdmi_audio_prepare+0x24/0x30 [drm_display_helper]
> [  201.799390]  hdmi_codec_prepare+0x100/0x160 [snd_soc_hdmi_codec]
> [  201.805471]  snd_soc_pcm_dai_prepare+0xd4/0x100 [snd_soc_core]
> [  201.811375]  __soc_pcm_prepare+0x60/0x12c [snd_soc_core]
> [  201.816752]  soc_pcm_prepare+0x34/0x58 [snd_soc_core]
> [  201.821863]  snd_pcm_do_prepare+0x70/0x8c [snd_pcm]
> [  201.826798]  snd_pcm_action_nonatomic+0xe4/0x174 [snd_pcm]
> [  201.832350]  snd_pcm_prepare+0xc8/0xd8 [snd_pcm]
> [  201.837021]  snd_pcm_common_ioctl+0x458/0x614 [snd_pcm]
> [  201.842308]  snd_pcm_ioctl+0x30/0x48 [snd_pcm]
> [  201.846802]  __arm64_sys_ioctl+0x88/0xd8
> [  201.850769]  invoke_syscall+0x48/0xf4
> [  201.854470]  el0_svc_common+0x80/0xd8
> [  201.858171]  do_el0_svc+0x1c/0x28
> [  201.861520]  el0_svc+0x3c/0xb0
> [  201.864605]  el0t_64_sync_handler+0x68/0xdc
> [  201.868834]  el0t_64_sync+0x198/0x19c
> [  201.872536] ---[ end trace 0000000000000000 ]---
> 
> [...]

Applied to drm-misc-fixes, thanks!

[1/2] drm/vc4: hdmi: Move packet RAM enable to PM runtime
      commit: 3f57b34485dc01e5a2db60a89a6ae5439a897e53

I'll apply the second patch to drm-misc-next after the backport.

Best regards,
- Maíra
