Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E79CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97B0110F83F;
	Fri,  2 Oct 2026 13:36:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="c8tbnpND";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEB4D10F83F
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 13:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:From:Reply-To;
 bh=SXvW2JnVlVNsJw4UOTay/IGqZ48AZkTDF6CIX7TovnA=; b=c8tbnpNDI6r/cEPmwiTWS56qAA
 jigrlRXE5K7cnwdr+D59mapKG75Q3WtGuARaxZKnlRqda9DmZVlQNrP0p7Y1HQidicPIz+P9qdc7j
 oD+RFGvqyl5INeyDjP4Pr19WGJkawENBjbJMUp7jU71wu43J+P5EEAmD0jj0OEd8g+7x+Ih+2d7ET
 /vpxof4QKOjEa0bQFc7dKq6NrpC1g2cli0DYg2HdJ6G4FkZ372F0f7Wlit2Rm97xWpYTyjjuibCdC
 IoyeH1Y6ZtLHIu40b9Q/fvSrMDXDUZCxqhs4FLFf+rDqj3jiJi3J3VJXGcbtfx8AtnzqvbFGzXmIW
 kufptJQQ==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xCdRT-00AceG-J8; Fri, 02 Oct 2026 15:36:51 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/2] drm/vc4: VC4 HDMI Runtime PM fixes for Packet RAM
Date: Fri, 02 Oct 2026 10:36:42 -0300
Message-Id: <20261002-vc4-hdmi-packet-ram-fix-v1-0-3d73148096c9@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bkFNCvpKdBBdawktNCSQ/p50n
 IGZCpkSU4a5q5CocOYzNpB9B3Y3cSNk1xiUUKMUQmKxGncXGC9jD7oxmYCeHyQ9TNoO0is/Qau
 vRE3/52V93w9SFY/naQAAAA==
X-Change-ID: 20261001-vc4-hdmi-packet-ram-fix-e4374c31f2f7
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2491; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=2YnHjkrtDM95uEYLsFpFvLsu3Zl1bzMAhsJ/UDr5b5Y=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqv7Nw+NRnvAlMYc0HdJXDo0el85uuZMKkHIBD3
 ZmdochvCt2JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCar+zcAAKCRA/8w6Kdoj6
 qgmoB/9nVvRW4noPDUTflCmZfxHoDEERv1NpYTEf1FLvnUm8VBACHrufnIt4aUz1mZ8wB2096tJ
 +41FhnIOn82tTdP3a/7hZ3OmpT091Ta3YjWt0zWaERTqJ9bydEyt6OvkUqQ+pMCGAeTQYVGXyTL
 ouGkU33zbixmY4HIqw9TnN0M4tRkNpYMj7YduXwr/a8bwAAzOFt/8pcVZWHx1YiTI2wQn10l5gQ
 JrqefKQ8DyAtSOb+u1LJ3YdrVxYLKozm5U5PxDRrMfqVEIKse9en89bcpoZJtHlB0DxRrVG8b+i
 RGU8tKLART51XafmktwFdTbO58Xa5MLtrpaTqSUt444cpIIp
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

While testing Raspberry Pi 4 HDMI hotplug with drm-misc-fixes, I hit the
following warning:

[  201.570266] ------------[ cut here ]------------
[  201.570293] Packet RAM has to be on to store the packet.
[  201.570367] WARNING: drivers/gpu/drm/vc4/vc4_hdmi.c:683 at vc4_hdmi_write_infoframe+0x404/0x494 [vc4], CPU#0: wireplumber/1606
[...]
[  201.658650] Hardware name: Raspberry Pi 4 Model B Rev 1.5 (DT)
[...]
[  201.758499] Call trace:
[  201.760967]  vc4_hdmi_write_infoframe+0x404/0x494 [vc4] (P)
[  201.766607]  vc4_hdmi_write_audio_infoframe+0x1c/0x28 [vc4]
[  201.772247]  write_infoframe+0xbc/0x140 [drm_display_helper]
[  201.777975]  drm_atomic_helper_connector_hdmi_update_audio_infoframe+0x80/0xdc [drm_display_helper]
[  201.787140]  vc4_hdmi_audio_prepare+0x4ac/0x570 [vc4]
[  201.792252]  drm_connector_hdmi_audio_prepare+0x24/0x30 [drm_display_helper]
[  201.799390]  hdmi_codec_prepare+0x100/0x160 [snd_soc_hdmi_codec]
[  201.805471]  snd_soc_pcm_dai_prepare+0xd4/0x100 [snd_soc_core]
[  201.811375]  __soc_pcm_prepare+0x60/0x12c [snd_soc_core]
[  201.816752]  soc_pcm_prepare+0x34/0x58 [snd_soc_core]
[  201.821863]  snd_pcm_do_prepare+0x70/0x8c [snd_pcm]
[  201.826798]  snd_pcm_action_nonatomic+0xe4/0x174 [snd_pcm]
[  201.832350]  snd_pcm_prepare+0xc8/0xd8 [snd_pcm]
[  201.837021]  snd_pcm_common_ioctl+0x458/0x614 [snd_pcm]
[  201.842308]  snd_pcm_ioctl+0x30/0x48 [snd_pcm]
[  201.846802]  __arm64_sys_ioctl+0x88/0xd8
[  201.850769]  invoke_syscall+0x48/0xf4
[  201.854470]  el0_svc_common+0x80/0xd8
[  201.858171]  do_el0_svc+0x1c/0x28
[  201.861520]  el0_svc+0x3c/0xb0
[  201.864605]  el0t_64_sync_handler+0x68/0xdc
[  201.868834]  el0t_64_sync+0x198/0x19c
[  201.872536] ---[ end trace 0000000000000000 ]---

Dave had already fixed this in the Raspberry Pi downstream tree [1].
This series upstreams his commits with no code changes and reworded
commit messages.

Maxime, could you ack/review these patches, please?

[1] https://github.com/raspberrypi/linux/pull/7431

Best regards,
- Maíra

---
Dave Stevenson (2):
      drm/vc4: hdmi: Move packet RAM enable to PM runtime
      drm/vc4: hdmi: Remove unused packet_ram_enabled flag

 drivers/gpu/drm/vc4/vc4_hdmi.c | 23 +++++++++++------------
 drivers/gpu/drm/vc4/vc4_hdmi.h |  6 ------
 2 files changed, 11 insertions(+), 18 deletions(-)
---
base-commit: bca45af5998a05f34b13a2ef11e639bac9c62643
change-id: 20261001-vc4-hdmi-packet-ram-fix-e4374c31f2f7

