Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F31C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:02:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E23D910F608;
	Fri,  3 Jul 2026 03:02:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="aPvZ3AJi";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60FE110F608
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:02:24 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-493bf73ec2aso272375e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047743; x=1783652543;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HsUqz/Qkq/LceV8TelFggUzjDk1o9pU0ZJGrnJynFBo=;
 b=aPvZ3AJiJDJXRsF/GzNA0MHbu+3yWmatTLC3EkjpzYw6QmDjkoS5o8IyOKE3fuHX7P
 OXMKELcdfPOxC+OpZmHgoPIhTg5fx3r1Z4t7eNcIvQNCSIoKVkyo7ViL0YmQlrFLha3y
 5bsJ5MyCa7nWHMbUv+j2yXqmmgQuLqRuR80Jae56yRvIs8Z7+uZtG8R+ElfHV3ejQP4u
 XrhyzItcZNCWUOra5zshsONjw+YvYHChC2drjLM01xD2Dm0FAllo5rqzpfq1pwtG9JhU
 9Hd8eWs6Qk8l8PVWJyHut+1M/wknjDYWM7f4yExBApFhVFYvSnGuFript5HcgxJkwils
 Ewow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047743; x=1783652543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HsUqz/Qkq/LceV8TelFggUzjDk1o9pU0ZJGrnJynFBo=;
 b=XXQhMHhifFm0ma2vkOib1sdJ8G5LI134hFRQfDGLKhMPxdYFLDuTHnH+902y/5FPIA
 Qdi62XKzXxKdnXpRVMGjw3MQf9n7eOB0SY1d+aPB5vOhD5/YeO+NoyxjHygWAwTMYCSf
 J4JjIrCIOQnWBfw0j+YpZJ5otVZfsBGObFFWAhc5ykT+EzcFNAIAiJPSsPth1yoYPZzu
 RhWbdyI61GJElwJ3146bz/r/u1SnoD08ki4IiVKhsYB6QWLezjjvkRvdF9SrKMFuh12i
 nUKoYEUWC0MP4Qni5E0seXzIx7Nz568EhTV2EbuRwVYwX9w+QosXCgBbux9ORd7pq7Vl
 76HA==
X-Gm-Message-State: AOJu0YyZ197UvNmndL9lV4oeNBUWTSEf+tpJnwWn0eLhGRHsHNspmxSz
 JAI9GcxPWbby52iaDQo96votT/u89xfr71YzWl6oD0FgCW+M6am5rlolThDXs/6WDw==
X-Gm-Gg: AfdE7cnFParo3x5zD3nOmtPFu6Jk3PhR6HX71BMqUW/v4+Awc4EKa2Z68u/X0pNy89R
 DyNJ3PCNuAlO8nmyIJhOMMkwrRtJEnUt9zvz8FqrQW27eUicL6+XgxTGWKQ52rUOX4SzbmVSHZa
 ZJa29WxYXzHcyfFIinKgx8Rg7ZZGe/fChgPQ4VyHNaDeuqAYc/GRJAypduIR82ymqNpuXTnhZuG
 HewTWovUwm3JudVrx5JrVS9xYW4m+goC8WxiXaqyBn9l9Kt2VAZCJ+STFH7aubdPgpHOgmBLJPt
 A9buI7YyOSNPOo87ddt42JR+GHTLO42izo5KhfUjFelFFJDnEq3qDSuUGxS+9K8qkdBccMsGEsJ
 G+IAwuth5vf1KI7wC2akbkYEM2ScZra53/2vsD4F4aWW8tMtUVBbf8eJsPFGkU40f2qFyiXU9hW
 Sejj9nG40mFGmH4uV8vIrgZtVZftS7X47RvdCHMnBYILr5AKw7XVCeRdGz9EhfL0Pw/Wk=
X-Received: by 2002:a05:600c:8b61:b0:493:c47f:3c55 with SMTP id
 5b1f17b1804b1-493c47f3c63mr88463955e9.5.1783047742662; 
 Thu, 02 Jul 2026 20:02:22 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4a343csm141233875e9.0.2026.07.02.20.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:02:22 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: rust-for-linux@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, Mike Lothian <mike@fireburn.co.uk>
Subject: [RFC PATCH v2 00/10] drm/vino: DisplayLink DL3 dock driver
Date: Fri,  3 Jul 2026 04:02:05 +0100
Message-ID: <20260703030217.2886-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260617151249.2937-1-mike@fireburn.co.uk>
References: <20260617151249.2937-1-mike@fireburn.co.uk>
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

This is v2 of the vino RFC: an in-kernel Rust driver for DisplayLink
DL3 docks (Dell D6000, 17e9:6006), replacing the out-of-tree EVDI
module plus the DisplayLinkManager userspace daemon.

Still an RFC in the same place v1 was: the dock never engages its
content-protection channel for vino, so no pixels flow yet. What's
different is everything underneath it. v1's review said, in short,
"work on safe KMS abstractions instead of raw C KMS + as_raw()" --
that's the bulk of this round (see the drm series cover for the
detail), plus the driver picked up several months of hardware-testing
fixes since v1 that had nowhere to land until now.

   1/10  skeleton + USB bind + plaintext bring-up          (proto, rng)
   2/10  clean-room HDCP 2.2 AKE/LC/SKE                     (crypto, hdcp, ake, golden)
   3/10  AES-CTR/AES-CMAC control-plane seal + arm          (cp)
   4/10  Vino framebuffer codec                             (video)
   5/10  DRM/KMS sink, on the safe KMS mode-object layer    (drm_sink)
   6/10  the driver itself: USB bind, bring-up, KUnit tests (vino)
   7/10  the hardware cursor plane (cursor_atomic_update -> CP)      (drm_sink)
   8/10  CRTC gamma, plane rotation and DDC/CI monitor controls      (drm_sink, cp)
   9/10  two heads, 90/270 rotation, damage clips, connector probe   (drm_sink)
  10/10  hrtimer-driven software vblank for refresh-rate pacing      (drm_sink)

What's here and works, HW-verified: USB bind + plaintext session init;
HDCP 2.2 AKE (H'/L'/V'); AES-CTR + Dl3Cmac control-plane seal, byte-exact
against the reference daemon's wire traffic; the stream-open arm marker
that gets the dock processing our encrypted CP for the first time; a
registered DRM/KMS card (CRTC + primary plane + virtual connector/
encoder, GEM-shmem dumb buffers); the Vino codec's DC plane and 8x8
transform, byte-exact against captured hardware output.

What's missing / why it's still RFC:
 - No live pixels. Every host-observable byte we put on the wire now
   matches the daemon -- verified down to paired full-bus USB captures
   and xHCI TRB completion codes -- but the dock still won't ack the
   first encrypted control-plane frame. Current read is a dock-firmware
   gate unreachable from the host; a hardware USB analyser is the one
   untried next step. See docs/BLOCKER.md in the source tree for the
   full trail of what's been ruled out.
 - The codec's AC coefficient entropy grammar is reverse-engineered but
   not finished (EOB/scan/context still open), so the WHT colour path
   only covers 64x16-aligned geometry; other modes use the RLE
   fallback. Not fabricating the rest until it's verified against
   hardware.
 - Per-head EDID and per-head mode-set/DDC. Two heads are wired (patch
   9), each scanned out to its own video endpoint with its own cursor,
   but the bring-up only reads head 0's EDID, and the CP mode-set has no
   decoded head/stream field -- so a head is conveyed on the wire only by
   which endpoint its frames go to. Real dual-monitor use past the CP
   wall needs those captured.
 - Two known-open items from v1's automated review, unresolved because
   fixing them properly needs more of the safe-KMS work above: some CP
   message builders (cursor/mode-set) still GFP_KERNEL-allocate from a
   path DRM considers atomic-commit context, and CP_ENGAGED/scanout
   state are still module-global statics rather than per-device (the
   driver is single-instance throughout, so this only matters for a
   theoretical multi-dock case).

Depends on the safe KMS mode-object layer landing (posted alongside,
"[RFC PATCH v2 00/18] rust: drm: safe KMS mode-object layer + evdi
bindings") and, transitively, on the locking/DRM-registration
prerequisite postings that series depends on -- see that cover letter
for exactly what and why. This series won't build without them.

Source, HDCP/HDMI specs referenced, and the full RE trail:
  https://github.com/FireBurn/vino-scripts
  https://github.com/FireBurn/linux/tree/vino
  https://gitlab.freedesktop.org/FireBurn/linux/-/tree/vino

Changes since v1:
 - Rebuilt on the safe KMS mode-object layer instead of raw C KMS +
   as_raw() (Danilo, Miguel) -- see the drm series cover.
 - Folded in the v1 review fixes that survive independently of the KMS
   rework: in-tree AES-CMAC + key-prepared-once AES (Eric Biggers);
   Interface<Bound> threading + cancel_work_sync() of the bring-up work
   in disconnect() (fixes a dropped-work-handle UAF); EP08 16-bit
   length overflow rejected; codec SECTION_CODE mode indexing fixed;
   encoder shadow committed only on full-frame success; cursor_image
   checked arithmetic; EP84_BUF-sized cap reads; pace_cap_ack/
   lockstep_reply no longer abort on short frames; Kconfig depends on
   USB (was USB=y); #[cfg(CONFIG_KUNIT)] (was the always-false
   CONFIG_KUNIT = "y"); a redundant Kconfig select dropped (Julian
   Braha). All from the Sashiko bot + human review on v1.
 - Added the byte-exact Vino colour codec (DC plane + 8x8 transform)
   and the real EP08 wire-record framing, from continued hardware
   testing since v1.
 - Re-added the hardware cursor plane (patch 7) and, now that the safe
   KMS layer exposes them, the CRTC gamma LUT, plane rotation property
   and DDC/CI brightness/contrast/DPMS controls (patch 8) that v1's
   raw-KMS driver had.
 - Added a second display head, 90/270 rotation, damage-clipped repaint
   and connector detect()/mode_valid() (patch 9), consuming the new
   drm-series bindings. The KMS feature set now exceeds v1's.
 - Added hrtimer-driven software vblank (patch 10): the CRTC now paces
   page-flips to the display's refresh rate instead of completing them
   immediately, using the safe KMS layer's VblankSupport.

Mike Lothian (10):
  drm/vino: add DisplayLink DL3 dock skeleton and protocol framing
  drm/vino: add the clean-room HDCP 2.2 AKE/LC/SKE handshake
  drm/vino: add the AES-CTR/AES-CMAC control-plane seal and arm sequence
  drm/vino: add the Vino framebuffer codec
  drm/vino: add the DRM/KMS sink, built on the safe KMS mode-object
    layer
  drm/vino: add the DisplayLink DL3 dock driver
  drm/vino: wire the hardware cursor plane
  drm/vino: wire CRTC gamma, plane rotation and DDC/CI monitor controls
  drm/vino: two heads, 90/270 rotation, damage clips and connector probe
  drm/vino: hrtimer-driven software vblank

 drivers/gpu/drm/Kconfig          |    1 +
 drivers/gpu/drm/Makefile         |    1 +
 drivers/gpu/drm/vino/Kconfig     |   20 +
 drivers/gpu/drm/vino/Makefile    |    2 +
 drivers/gpu/drm/vino/ake.rs      |  173 ++
 drivers/gpu/drm/vino/cp.rs       |  733 +++++++++
 drivers/gpu/drm/vino/crypto.rs   |   48 +
 drivers/gpu/drm/vino/drm_sink.rs | 1173 +++++++++++++
 drivers/gpu/drm/vino/golden.rs   |   69 +
 drivers/gpu/drm/vino/hdcp.rs     |  167 ++
 drivers/gpu/drm/vino/proto.rs    |   73 +
 drivers/gpu/drm/vino/rng.rs      |   12 +
 drivers/gpu/drm/vino/video.rs    | 1229 ++++++++++++++
 drivers/gpu/drm/vino/vino.rs     | 2640 ++++++++++++++++++++++++++++++
 14 files changed, 6341 insertions(+)
 create mode 100644 drivers/gpu/drm/vino/Kconfig
 create mode 100644 drivers/gpu/drm/vino/Makefile
 create mode 100644 drivers/gpu/drm/vino/ake.rs
 create mode 100644 drivers/gpu/drm/vino/cp.rs
 create mode 100644 drivers/gpu/drm/vino/crypto.rs
 create mode 100644 drivers/gpu/drm/vino/drm_sink.rs
 create mode 100644 drivers/gpu/drm/vino/golden.rs
 create mode 100644 drivers/gpu/drm/vino/hdcp.rs
 create mode 100644 drivers/gpu/drm/vino/proto.rs
 create mode 100644 drivers/gpu/drm/vino/rng.rs
 create mode 100644 drivers/gpu/drm/vino/video.rs
 create mode 100644 drivers/gpu/drm/vino/vino.rs

-- 
2.55.0

