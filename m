Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7361CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E05510F01C;
	Wed, 17 Jun 2026 15:12:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="BDqUWi8J";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18E7C10F01C
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 15:12:58 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso74922945e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1781709176; x=1782313976;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1mULv+koftw5O8PCqfx+7jD7KAbxdOhkeCix7/plmIA=;
 b=BDqUWi8Jg/t0U1fbi39mIPTTRr+/WgsG6C8irMA0DL41ReCTcw5LsAjREIrDc9gze1
 FS3fKab9S6jQopm3nR15KBOtqKOJEycw4810+wpBrmX8w/qaQz57kWW4+dYzr5Um3p3r
 1Ip90JLYKhQEuEKmmixedVJPiWM8oZhiQQpBgcx5Dgg3zvyK1ZzYru9N+biOO5V10Jv3
 9u50OiWjMf0H3yvGDt1b/SQLhYdGB2THXD21BEHSMkXuUbsnGBzpIYHagPQW/XmpbhpS
 roKtTCE9oVKistERS6R7XDBl6y4aALwZFeLIfC/gy6C5HvF2H1u6W6hkRzkSrfznvODi
 k5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781709177; x=1782313977;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1mULv+koftw5O8PCqfx+7jD7KAbxdOhkeCix7/plmIA=;
 b=hYmY8S4EEc9rkuRDK/Np0gYMmcC4d+W1IIUdd9wm1F5dXM8rdsIe9poP4N7ykJGzw3
 Z2768G1GhMmBKRrSlaQzT+m2OA19WBE/aCz9J8fiPMXRWHFF60sByIDxoFWPGrJxDgUk
 MFYKP1GlUPBsuMB+Ws6Yvi2h61nGHR+0Yw21KLTBdadfFQpVY4XeYdtoVjdVn2qnXc59
 8xq591RI+2WF0Qs6mBUdfhuT1iSoXlMGilrBPrhhk0g8wxXNiBIJTF0YAQv3ZAR00MXD
 cxGAdsg35yQYzDPkZ9Ufe+LALY8ORZwz2e0+Wm2Ixkotyg1sEeof8lnXN5zdV4HX+frY
 C3kQ==
X-Gm-Message-State: AOJu0YyeGfbQHdAawlwU3quRMNl6PdpnP44NfXhbNRNKL8h/EQU1Jc17
 se00Ltu+0qw14jt2qvNI3qhBxdOTlO+cEQ9bc/YExYH7XAEk3M+s1LMyHxrAF7SKGwO6oFSQepn
 BUy7QeyJe
X-Gm-Gg: Acq92OHffEEsHD7Cs10dKEsfCk02o9RQQT6mmLeDvRN71h9KaVPXuQ1RkgoRQbRXvG3
 nZntZZeNq850Uzwqhyg7URVYoDIg0Gv33VINqd3F+JP2N9Rv21DM2bDymqF2t6eD/FVmYGFJVo1
 ULzKBY0YMOPNi4sufHcNIMcok5Av4RcY9WHkmfbW/JzvsorA4cnjEEzKGZVhhZoFCq+0pCSxdjF
 E/O8sNISpETF1GiQlSkJK28bY/qn//7oNeaL/qOwYPtiaCxHRLDT05aXafV938hGBTQd+O55GmN
 kxSutV2RD5cQZK+x3s+ChoLTV+99U6nNaubD4v+uZ5scn4NCuoZd+5VdtyNeaSo/z/mB/zpV9SF
 5V0/vT9BDGyFOxbLZ3Rp1EECLeWWnzmDEs46uxlyMIcOa+8cOg7jbkvNUxjDMp9ssif8Zfa3BtN
 yD5UFdxL3UIakxsTc0UfYFcNv49t9OIKXbGs5x3duVodxN8Z1HepkOWA8e
X-Received: by 2002:a05:600c:828a:b0:490:3fdd:d353 with SMTP id
 5b1f17b1804b1-492333a14c5mr76057075e9.8.1781709176515; 
 Wed, 17 Jun 2026 08:12:56 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a9a399sm151019305e9.14.2026.06.17.08.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 08:12:55 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: Mike Lothian <mike@fireburn.co.uk>, rust-for-linux@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/7] drm/vino: DisplayLink DL3 dock driver (RFC,
 help wanted)
Date: Wed, 17 Jun 2026 16:12:37 +0100
Message-ID: <20260617151249.2937-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.54.0
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

Vino is a clean-room, in-kernel Rust DRM driver for DisplayLink DL3 USB
docks (Dell Universal Dock D6000, 17e9:6006), a native replacement for
the out-of-tree EVDI module plus the proprietary DisplayLinkManager
userspace daemon. It is built on the in-tree Rust USB, crypto and DRM/KMS
bindings, which are posted as their own prerequisite series; this series
is the driver that consumes them and touches only drivers/gpu/drm/vino/
plus the two drivers/gpu/drm/{Kconfig,Makefile} wiring lines.

Prerequisite binding series (apply in this order before this one):
  - [RFC PATCH 0/9] rust: usb: synchronous bulk/control transfers + helpers
    https://lore.kernel.org/r/20260617145946.1894-1-mike@fireburn.co.uk
  - [RFC PATCH 0/2] rust: crypto: library AES-128 / SHA-256 / HMAC + RSA
    https://lore.kernel.org/r/20260617150143.2152-1-mike@fireburn.co.uk
  - [RFC PATCH 0/5] rust: drm: minimal KMS bindings, EDID read, rotation, HDCP defs
    https://lore.kernel.org/r/20260617150232.2210-1-mike@fireburn.co.uk

It is posted as an [RFC] in a deliberately INCOMPLETE state to ask for
help with one remaining blocker -- the control-plane engagement "wall"
(see below and patch 3). It was previously a single ~5000-line patch; it
has been split into one self-contained subsystem per patch so it is
reviewable and so others can pick up and fix a single layer in isolation:

  1. skeleton + USB bind + the plaintext connect handshake (proto);
  2. the clean-room HDCP 2.2 AKE/LC/SKE (crypto, rng, hdcp, ake, golden);
  3. the AES-CTR/AES-CMAC ("Dl3Cmac") control-plane seal + arm (cp);
  4. the Vino RawRl mode-2 framebuffer codec (video);
  5. the DRM/KMS device + EP08 framebuffer scanout (drm_sink);
  6. DDC/CI brightness/contrast, DPMS power and DFU device-info;
  7. KUnit self-tests for the protocol and crypto paths.

Each commit builds and the module loads on its own, so the series is
bisectable. With the prerequisite binding series applied it is
git-am-clean and checkpatch.pl --strict reports no errors (the only notes
are the expected "does MAINTAINERS need updating?" on the new files and a
few >100-column verbatim log strings).

Note on tooling: the implementation was AI-assisted (see the Assisted-by:
trailers); the reverse-engineering, the hardware testing on a real D6000,
and responsibility for the code under the DCO are the author's.

What works, all on real hardware (Dell Universal Dock D6000):
 - the plaintext connect handshake over the Rust USB bulk + control API;
 - the clean-room HDCP 2.2 AKE/LC/SKE -- H', L' and V' all verify against
   the dock, establishing the shared session key;
 - the AES-CTR + AES-CMAC control-plane seal, byte-exact against the
   reference daemon's captured wire, plus the plaintext stream-open arm;
 - registration of a real struct drm_device via an atomic KMS pipeline, so
   the dock appears as a mode-settable GEM/dumb DRM card, with a live EP08
   framebuffer-scanout hook on every page-flip.

What does NOT work -- the wall (help wanted):
 After the arm marker the driver sends the first encrypted control-plane
 frame and the dock never acknowledges it (the wsub=0x45 ack count stays
 0), so the CP cipher never engages and no pixels flow. Every
 host-observable channel has been matched to the reference daemon -- the
 bulk wire is byte-identical through the arm and the first encrypted frame,
 the AKE verifies, the seal/MAC/IV are byte-exact, the full EP0 control and
 endpoint sets match, and the arm timing is tighter than the daemon's --
 yet the dock silently drops our encrypted CP while engaging the daemon's.
 The gate appears not to be visible on the host wire. If you have knowledge
 of the DisplayLink DL3 control-plane engagement sequence, or ideas for
 isolating a whole-bus timing/ordering property a per-channel diff cannot
 see, help would be very welcome.

Not-for-merge as-is: the driver carries RE diagnostics behind pr_debug and
a small captured plaintext cap-announce skeleton (golden) that a fully
field-derived builder should eventually replace.

Mike Lothian (7):
  drm/vino: add DisplayLink DL3 dock skeleton and plaintext bring-up
  drm/vino: add the clean-room HDCP 2.2 AKE/LC/SKE
  drm/vino: add the AES-CTR/AES-CMAC control-plane seal and arm
  drm/vino: add the Vino (RawRl mode-2) framebuffer codec
  drm/vino: register a DRM/KMS device and scan out to EP08
  drm/vino: add DDC/CI brightness/contrast, DPMS power and DFU info
  drm/vino: add KUnit self-tests for the protocol and crypto paths

 drivers/gpu/drm/Kconfig          |    2 +
 drivers/gpu/drm/Makefile         |    2 +
 drivers/gpu/drm/vino/Kconfig     |   21 +
 drivers/gpu/drm/vino/Makefile    |    2 +
 drivers/gpu/drm/vino/ake.rs      |  167 +++
 drivers/gpu/drm/vino/cp.rs       |  686 ++++++++++
 drivers/gpu/drm/vino/crypto.rs   |   81 ++
 drivers/gpu/drm/vino/drm_sink.rs | 1466 +++++++++++++++++++++
 drivers/gpu/drm/vino/golden.rs   |   69 +
 drivers/gpu/drm/vino/hdcp.rs     |  167 +++
 drivers/gpu/drm/vino/proto.rs    |   73 ++
 drivers/gpu/drm/vino/rng.rs      |   12 +
 drivers/gpu/drm/vino/video.rs    |  348 +++++
 drivers/gpu/drm/vino/vino.rs     | 2053 ++++++++++++++++++++++++++++++
 14 files changed, 5149 insertions(+)
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
2.54.0

