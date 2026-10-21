Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D63606A31B
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sWPaowe6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED08C11244B;
	Thu, 22 Oct 2026 09:41:21 +0000 (UTC)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com
 [209.85.217.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66A9D10FD99
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 11:41:53 +0000 (UTC)
Received: by mail-vs1-f51.google.com with SMTP id
 ada2fe7eead31-7cc013095d4so178566137.2
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 04:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792582912; x=1793187712; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Fx75j4SxhSfx9/iSOVIDoOGsjmIu6P89n8oQ2wrar1Q=;
 b=sWPaowe6ngjS0YD/gPl6Is9y0HUgKrXGM2HpjkokH4ckunEJYdRiYLzIdr6ZhgkgZQ
 mQ5s+/BKyAsT/lB19KlkO0qD/VpKtSX8DsWugTMdyz9Mh/0l+JMOGJmeZr9reGptyDRh
 YRNUMaVQij5sr1zxznXM98nx41am+FAliS4QV2ckemMrFdrsV+rxnjS3crZzaVMMCejY
 ngwtXttlMUjONvf0CZRIqfIX7PUpFvJfCXyfJOqr8/PIaOzgDrAec95CvMv3DV9/01WY
 nsUwmjZz6Nmxw4lOloctgLxST0fafCfP4IFQgcTbyjVqH8x0+TFHPAND4lgd51FylCDY
 xDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792582912; x=1793187712;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fx75j4SxhSfx9/iSOVIDoOGsjmIu6P89n8oQ2wrar1Q=;
 b=Mdl61HcKVZbC5r6jx/d5L3HI17iwrImBf54fgkWgTk/XLiX3aMK73dWEN4ZOVo7eTW
 px5ze+DQNZ5a7eB2jegh4CP5DGKi4GDWvyO39kf3710cskycY+GkJdF3ghUUPaHwdeYt
 NPdDzeYtH8/Js1u8WgX/xyPD83JDz+aO72Ws41SlwFSikt4iiUC/tR/OanJyQlmAMelz
 Ajj0GoLNiTqv2HTTDQeVgMX/P2rqm1A3qPAKcAR7oSRX3kMz86vy2HTO6TZJ99u2RE1s
 rkPt95FOp3sGpkBqV54pY11Wrs2+6IgO8SBa1AvVBWJqKK+662nCEAew8s3PeBFBDBia
 BXOg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw7ggOKjoH0CHzZzXvLGBDjQf5N5rEt6FYKqjTN/zWaqUfPecQjgm6aQorLJmW3T30Y+FCtOWcW84M=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKXe40i7KCFZ847TIhhsu7D1FiT3cQcJrDYwRZ8OoUPraFZk2/3
 1lZJVaItz1PIE8h0Afqn2uU4NPsrp1AGLhyaE0vnobQWGRQKry1WpReQ
X-Gm-Gg: AYBFou2FaX5ef4gfokIpptPjQM6ZMIpTqgapUhSjKkaNVBWx9ucKcyX0gkq3mP3nIXy
 5C6mZrC2dwarR6jgQyZLtFNjoDn8NaFBL41phVPb843kEcxiMOVZeWXF9VvaljJi5LPsjwpOb3y
 OqPkYXaI0a+YxoQFRwl1bJ0+S2Qc5voffXMY5wYZThaxCt5qOy0WuS9++6ESI5WAC4JAL8jF/j5
 cA+SqXbKzJ+0YHu2yfMS7sWJ7X1Hj36faSBakC3bcWM7dIW1yaD236I2QS7/MgatubYS9HtUdJd
 HkZYGIsl9ZzmKA6BX+o5OpB6aeKNP/xrioAtbGIA7buK2BvaUiD5Hm2UsDF4NJS3BAci1e+ZYYs
 GEUqw/+Y6+E27wa5GM8iFvUlB9eLxAKtAvUo6HpFiiI1+6X3cgIRCGmPwj36fdfotzvEL5XpmgE
 WAzi7xLuy7DgaIdrvhEKoWyHzYHE8Mxs8lfWzL87GsMujBrsIi7ck3TQqr6gjNZoDM6sm5LEYRC
 Nobq3vRprYbaXm+CQ8qM0oG9BbCTocOaEvI9zP6bhgooBMkIEA6a7JzXId92iYwvG7W4Vg=
X-Received: by 2002:a05:6102:5346:b0:7c0:9788:b46e with SMTP id
 ada2fe7eead31-7cc926f8856mr513003137.32.1792582912106; 
 Wed, 21 Oct 2026 04:41:52 -0700 (PDT)
Received: from localhost.localdomain ([177.155.254.119])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7cc91f9c7f1sm2365006137.0.2026.10.21.04.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 04:41:51 -0700 (PDT)
From: Matheus Tagliari <mptagliari@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Matheus Tagliari <mptagliari@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/radeon: fix VCE1 encoding on SI by handling the VCE
 interrupt
Date: Wed, 21 Oct 2026 08:41:16 -0300
Message-ID: <20261021114122.94008-1-mptagliari@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 Oct 2026 09:41:15 +0000
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hardware H.264 encoding with the VCE block on SI GPUs (radeon driver)
hangs the GPU after a few dozen frames.  I hit it with the KDE Plasma
RDP server, which encodes through VAAPI, and reproduced it with a
plain "ffmpeg -vaapi_device ... -c:v h264_vaapi" test on a Radeon HD
8870M (Cape Verde).

The VCE1 code never enables the VCE trap interrupt and the SI (and
Trinity) interrupt handlers do not process it, unlike the CIK code and
amdgpu.  Patch 1 adds the handlers, patch 2 enables the interrupt.

Results on Debian 6.12.113 (see patch 2 for numbers): hang before,
none after, and 34 fps instead of ~4 fps for the workaround that avoids
the hang.  The KDE RDP server (KRDP) itself, driven by a local FreeRDP
client, now encodes on the VCE ring for several minutes (about 40
fences per second on ring 6 in the radeon_fence_emit tracepoint) with a
clean kernel log.

Two caveats:

 - I have not worked out why the missing interrupt turns into ring
   lockups instead of only added latency.  What I know is that the
   hang needs the VCE ring to wait on a hardware semaphore (disabling
   only the waiting side, or both sides, of radeon_vce_semaphore_emit()
   avoids it) and that handling the interrupt makes it go away with
   the semaphores left enabled.  If someone knows why, I would be glad
   to improve the commit message.
 - The Trinity/Richland change is compile tested only.

The series was developed and tested on Debian's 6.12.113 with the
radeon module built out of tree.  It applies cleanly on drm-next
(fad06cf), where drivers/gpu/drm/radeon builds without warnings (W=1,
allmodconfig) both after patch 1 and with the whole series.

Matheus Tagliari (2):
  drm/radeon: process the VCE interrupt on SI and Trinity
  drm/radeon/vce1: enable the VCE trap interrupt

 drivers/gpu/drm/radeon/evergreen.c | 14 ++++++++++++++
 drivers/gpu/drm/radeon/si.c        | 14 ++++++++++++++
 drivers/gpu/drm/radeon/sid.h       |  2 ++
 drivers/gpu/drm/radeon/vce_v1_0.c  |  4 ++++
 4 files changed, 34 insertions(+)


base-commit: fad06cfaf385787b9ffa2f73f049d42dbe1de57f
-- 
2.47.3

