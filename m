Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCF1606A326
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=okonski-org.20260707.gappssmtp.com header.i=@okonski-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KdVAqtaG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1549310F34B;
	Tue, 24 Nov 2026 08:39:52 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27B6010ECA3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 22:11:35 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6b88bc47e23so4772748a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 14:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=okonski-org.20260707.gappssmtp.com; s=20260707; t=1795471893; x=1796076693;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wrbZvtX9auyLdMA7XsHgJrd1m9Tl2lVAyzPMGYT9XzM=;
 b=KdVAqtaGHU38hYen/WRWC+pU9/wWeCOP063HxXlVccClruksQTLzR9mxifDMIV8e8f
 eNeiS3NRrTmsqWMbqg98gAMwYXkKFQJNy3aqdenYkEILVWom59YcW2b67Yi2uAUCeYu1
 E6/IbUl2M9Tj9eHIkg7DEn8P9C3vPJxfZO+QvUhB/sVYLp+0vaggh6PUfWPT9rWZGkif
 3S29MK3Z/NfzSjTZ7LPnJjQ/OKt4fLLZPaNCDWGddAcfZrs5nCZHMXmR30Pk4+SVryVr
 iRBIukFEWclft84eSjXbrCNunxXoCh6XPK+Twu8Pj56iwtYLzAyrWn/+o4nIn9MRMk5i
 CInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795471893; x=1796076693;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wrbZvtX9auyLdMA7XsHgJrd1m9Tl2lVAyzPMGYT9XzM=;
 b=elB7+FzY+hUpkVuHnVaLg71On8m34Ah28ntBUY11x4CUrWj4vOxMEd1Qc8VoFwyFDH
 mikbojMIFs5YGK4mom2d8cJPKJ9shLH6rLmKc0vuLG+yiajcrEmk2eZAkMOND15T75sC
 HgzI3XIYt7n07JN9MtNMl6uGtbLvJwwaAFAP+UWXZRs+m+t1VzYuFi5oC4iyzenQEmyE
 6rsGsFtLOJ4be0BUuY+uqTevqd7UIyWhudi2CGY6VmY823/jrSr7MVrEQ2WADjBgQUge
 qo9YcAdfC0zmxpx7h95fLCvDw7ItYZHSU/PDNRFvUsGUm3Bc6P+xwm4ES4VT2buHHYqx
 1bvA==
X-Gm-Message-State: APuU4Z+kzFxj3cU5avyz2uRGBb+hgZnQKiLAxLbmaPsZwFUbpnXd9a1b
 ejiRhnKgU1kFbfmsKOXcAZdD/c1fWCkU7Qm5DxWdVQNSFbDZvToDBaa8MpDaO2ZBFF0=
X-Gm-Gg: AZFdTZfvbJE35TvhAEirdFQyONQXND0SgZ4D1G6XPA193D+XvKXhBiJP0Ep4gHVkcN8
 GdxPoJP06za2GYHi5iR7/sPKpbluzamFw4t0jJUpN2mW+buc7FoSHANG3czHN78oKJLs1u806me
 SPqBmhDtnletci3MWHth/TXsb0O+uuUT7qTVILwEI32QNl2lMWO9o9nxUObiyGa4xVc5ct2YAXb
 wJNIlOKU2AR4ZzqAqBc1SZ9vFH+DjX4iGEpobiPVFKW5vGtrCZ12uwCOUWg6qa7LPMQg7J2KQ4I
 4+BrRnqNRtFHRh9H3sltBXDatcBLvB54k9rEV+TQVol79wgCfntLTGDZqUHCcGHi19J8IJ7IX3M
 VdTnGqLFfTjgPpkh+EBVxCi6CIyENyk6wKbnZPJoJiNzbG2U3+SGg1ACPNYZ3Orwb5TYzhURxIi
 sHuo5fXPWlmNYxB1nI9EFer5Ult2sM8XSUBp50Fso4A8BDvSfVCmP2Du1dpCBUkgF0u3FhAY3hR
 BhQrn6yhFXEwdjU1rJrazZXRoedEQY+SH0al/rLLRNVHAKOn1Tnqgynw+vqlQfdwvHjU/WNH4gD
 +fvFD+ckPGPVzk9TJXn/o/arLeHVxtRNPuKX5DIVIexXabWcTQN0Kenus9CDZEbFvcn8rvaCG8R
 sDbxafRGTCdK3BKZk3h8WdjfNh7z0+/0VkDZ68L9Bsdrgyg==
X-Received: by 2002:a05:6402:1ed6:b0:6ba:8541:e530 with SMTP id
 4fb4d7f45d1cf-6ba8541e8ccmr5020204a12.45.1795471893197; 
 Mon, 23 Nov 2026 14:11:33 -0800 (PST)
Received: from vautera ([2a02:21a0:10:748:2::2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba37109b55sm5678828a12.32.2026.11.23.14.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 14:11:31 -0800 (PST)
From: =?UTF-8?q?Jakub=20Oko=C5=84ski?= <jakub@okonski.org>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de
Subject: [RFC PATCH 0/2] drm/amd/display: avoid flip_done waits on TEST_ONLY
 commits
Date: Mon, 23 Nov 2026 23:09:11 +0100
Message-ID: <20261123220913.937402-1-jakub@okonski.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:39:44 +0000
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

(bear with me because it's the first patch I've ever sent over email)

I tested overlays on KWin 6.8 and noticed a big latency tail for
DRM_MODE_ATOMIC_TEST_ONLY | NONBLOCK checks that KWin does to plan the
frame and decide whether it needs composition or direct scanout.
The testing happened on an RX 6900 XT RDNA2 GPU. The stalls happen
whenever planes move on or off an overlay or change geometry with the
previous commit still pending.

The stall happens in amdgpu_dm_atomic_check(): dm_update_plane_state()
sets needs_dc_state_realloc, which calls do_aquire_global_lock() and
waits for both hw_done and flip_done on the CRTC's newest commit, even
though TEST_ONLY publishes no state and mode-only DC validation takes
<= ~0.1 ms.

This RFC adds a test_only bit to struct drm_atomic_commit (1/2) and
skips the flip_done wait in do_aquire_global_lock() for non-modeset
TEST_ONLY checks (2/2), keeping all locks, the hw_done wait, and the
full drain for modeset tests and real commits.

I tested my 7.3.4 kernel at stock and with this series. A recorded
desktop session lasting ~26 seconds and replayed with libinput replay.
A browser window navigating to a page and interacting with it causing
redraws in response to input. farnoy.dev/tools/mouse-latency.

Captured stalls from this scenario break down like this:

+--------------------------+-----------+----------+
|                   Metric | Unpatched |  Patched |
+--------------------------+-----------+----------+
|              Replay runs |        10 |        5 |
|         Presented frames |      5943 |     3019 |
|         TEST_ONLY ioctls |     51305 |    25627 |
| TEST_ONLY stalls >= 2 ms |        13 |        2 |
|          flip_done waits |         9 |        0 |
|            hw_done waits |         4 |        2 |
+--------------------------+-----------+----------+

No flip timeouts or atomic commit failures were observed.

The remaining two long waits were on hw_done: tracing the previous
commit worker showed 99.3% of each ~7 ms wait inside
dc_update_planes_and_stream(), returning 9-19 us after a late flip.

Patches written by an LLM, reviewed and tested by me.
Compile-tested on amd-staging-drm-next 8dd68a79583a.

I was told Harry is working on this specific area but I'd already tested
this change by then, so I'm pushing in case this is useful. I have no
idea whether this works on <=gfx9 or >gfx10, and I have not attempted to
improve the hw_done waits.

Jakub Okoński (2):
  drm/atomic: record TEST_ONLY ioctl intent in drm_atomic_commit
  drm/amd/display: Skip flip_done wait for non-modeset TEST_ONLY checks

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++++++++-------
 drivers/gpu/drm/drm_atomic_uapi.c                 |  1 +
 include/drm/drm_atomic.h                          |  7 +++++++
 3 files changed, 16 insertions(+), 7 deletions(-)


base-commit: 8dd68a79583aaf6df6fe4feea3ee9e9f26b02993
-- 
2.56.0

