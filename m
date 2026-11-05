Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FD0606A328
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=N0pruNAc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD22A10E02E;
	Thu,  5 Nov 2026 23:21:37 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8849310E02E
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 23:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=lfq+EvUzvErEzYkKbkDsw+fJPd6MIG6qU24yGrPjmH8=; t=1793920891; x=2109280891; 
 b=N0pruNAcuZaqU4cHt+GRs9YNZiFuWJCuHBmCzhys5jkIQYVCnoOu9Bb6kInpAqMG7iD823YK6Fi
 rgAwoky3KxT/nCLJ6gqnVaVbKUbjncqmPMU7b4IsArstztehWno/d8SuGR1zzGgOrC2TgDRpInyC4
 qtSArXXRvRxmcohpfNA/Awsa9hqZqmRDkY4VFaOKSg/TVzgW/pSsOsPGAtCzBpvDI4Iyj5UAKNTUT
 27pkGFT31iGRIzS/HONEsIfMPbSjVK0YjWaNVoEG0awLPa5XDpHYIkQ2iFRbEPuj8pQhA/C1EOqLb
 aEr114/xqv2jtLyuFUDBVU6KJCLfkc0fRmqA==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xP6lp-003qVr-Es; Fri, 06 Nov 2026 00:21:25 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: kernel-dev@igalia.com,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/2] drm/vc4: VC4 HDMI Runtime PM fixes for Packet RAM
Date: Thu,  5 Nov 2026 20:20:10 -0300
Message-ID: <179392080013.2087368.16708197866468778679.b4-ty@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261002-vc4-hdmi-packet-ram-fix-v1-0-3d73148096c9@igalia.com>
References: <20261002-vc4-hdmi-packet-ram-fix-v1-0-3d73148096c9@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


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

Applied to drm-misc-next, thanks!

[2/2] drm/vc4: hdmi: Remove unused packet_ram_enabled flag
      commit: a2adf145df03811bad4deb1b9a72cee44c939dbd

Best regards,
- Maíra
