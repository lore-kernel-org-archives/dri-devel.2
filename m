Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA83C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8793C10E248;
	Wed, 26 Aug 2026 16:34:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="OvCSHntq";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D181710E30D
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:34:09 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-495437bb891so315635e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762048; x=1788366848;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BNp6aViZcz4to/Cdqsuhox+93lABRwOcAkdzqvBJ+0U=;
 b=OvCSHntqbD53RZxU1MRUWPluaa4JAXxtv/C11tFFWC5GtS4Xz/ydpOZX+mA1FLG8zl
 6BjWAmlV2CWEaLvJ/SI8eurkeQ/6ZF79YWo0YmpHJjaBZwfZgi3tNgywuuOKtcP1FqJY
 jx5CHw9LaJR7zRS6EjVLWYP4vrtOMk/IFjHhNx38Zk8hzKmjlqgP276mjrI0X2Z9El8A
 22H/Y0z3wym1tnoVp4sBH8oPmSUGp3OrRzxWnhzP2CuVzNVrzLQCQNl9JVKf7tgju60M
 Gyk2EsHSPKXMjcdkyhCko8p16K2BIa92LvYiRJ9sEg5fIKI43SRcr0j6+jnKpu5jNq9V
 A9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762048; x=1788366848;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BNp6aViZcz4to/Cdqsuhox+93lABRwOcAkdzqvBJ+0U=;
 b=M0JqQifW19OTBEqkxOliOAlcmH7qothVLaSB4UOiRx1teLYSEgBdy0+49/P9OUHSde
 Yl/8gUXmb+0obutHp3ivE18Xv2QDwbIGP33QtPljP9iSvZ+8KuiO1oBdXIo6DEikP81I
 GESUn9sxSYbHW0SIQ0hAVQCMu2byLYviq3pl0FQ3g/FROdJja8NeaCD25eeEHIn54JGL
 JqH6qjSddgcvNWyI4NUJOLA3+bGMnDxGkkqOU4/aTb1my6d4GM5q0CC1bxC39cH+t6yS
 t37Lu19ofcd8njMEaOCx3LhYcCJFKWQZ3VWN+6tNwzxvLQo/6VqN8qnbeKIN/m8BJamH
 zoBw==
X-Gm-Message-State: AFuF++kCgAbGUbYpFpRjnbl2lsya9zwlPo6VgeRlTp7ld1Qx0+W4FwuK
 F7yUvmJ7BfGXO5IjT6/Co/b3hZ8oJpK7V9+X923EjAs8/Z2I91GuCaIhqKsICtviCEmHfR1TWOs
 HeLBxexzu
X-Gm-Gg: AR+sD10VrOzzE4OqX6WE0rRtfqGvViIzU0Ib3uzeBG9LfRGATDHMoVtQP40WGki2sxy
 xbBFnQiVz7XuctP9uzlxHEuBzuTSmKT0Y4+6vXmSCQ9CR7+/q6Bj78UuOBdj26jSzYDA/vVu7sS
 M7Zt2DfKxN7jmIQrYyBHgOLwtqC6tBXCpmtxV5LxSryuKrT/GdxeFZTPFL6UIP/T9sCEYG2xvCO
 hy/GUvmOY4iA6DZ3/XhllkwRfgUXY4bV3oHS5QeBEm5KWGyg1d54oClTDY1Nggg5Z0+DMH5heG4
 SrTirdwzbErN/nxajUqjWDitoFqVxWaaVrn80t3u1iOckO9XQt/wZ0gvBY1i9qOorhP+2G7I+vG
 DsFc13ATSGT4+HUXiv5FofTeyDTZEoyculxRlHaTV0MdDz2DXetU3OSuxxckbn3Qnp7L2riv+tg
 9OrV/fjXK+wZrZkZ9H/wiG/ju2F8SpM8+WvXq5CzlPDDBYYKm6ByPCVkEvUf32IQkNNvMQTSj3Z
 9l+cbaHzessnS2xgFcxBd9YOFr8g54gMy2z
X-Received: by 2002:a05:600c:46d0:b0:495:5d6d:9cc1 with SMTP id
 5b1f17b1804b1-49b0dd5821cmr5708995e9.0.1787762048114; 
 Wed, 26 Aug 2026 09:34:08 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca8c75csm31227535e9.2.2026.08.26.09.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:34:07 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: Mike Lothian <mike@fireburn.co.uk>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH v3 0/23] rust: drm: KMS abstractions for a Rust display driver
Date: Wed, 26 Aug 2026 17:31:31 +0100
Message-ID: <20260826163359.4998-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
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

KMS abstractions for a Rust display driver, continuing Lyude Paul's KMS series
rather than replacing it. The first patch adapts that work to the DRM APIs as
they stand today, and the rest add what a real driver turned out to need

Broadly they fall into four groups:

  Lifetime and ownership: mode-object references tied to their owners, owned
    CRTC and vblank references, a safe constructor for owned registration data,
    pinning the owner while DRM files remain open, and rejecting cross-device
    GEM handle creation
  Properties a driver must read or publish: typed colour and rotation, plane
    blend mode, FB_DAMAGE_CLIPS, connector colorimetry and HDR metadata, and a
    connector's requested link depth
  Callbacks and state: connector detect() and mode_valid(), common state and
    connector helpers, checked plane geometry, walking the CRTCs an atomic
    commit carries, and CRTC mode changes
  Modes and framebuffers: an owned display mode constructor, mode flags and CTA
    VIC matching, synthesized CVT connector modes, and validated shmem scanout
    views

Also here are the HDCP 2.2 message identifiers, which are DRM UAPI rather than
driver constants

Changes since v2:

  Lyude's 43 commits are carried in order and patch-identical to the imported
    source, with her messages and tags untouched and no trailer of mine on any
    of them. v2 mixed her work with adaptations of mine and obscured the
    attribution, which was the fair complaint
  Everything of mine on top is a separate commit, and it is either an
    adaptation to a DRM API that has moved or a safety extension a driver
    needed
  The i2c adapter-provider patch is dropped. Igor Korotin's work is active and
    its provider-lifetime question is not one to answer privately in a driver,
    so the kernel driver registers no downstream I2C adapter this round
  The typed event channels and the private ioctl compat translations are
    dropped. Both existed for a second consumer that is not part of this
    posting, so neither has a user in what is sent
  The hardware-cursor support that was a separate v2 patch is folded into the
    plane work it belongs to

Two overlaps worth naming. Alvin Sun's
"Fix missing fops.owner in Rust DRM/misc abstractions" fixes the same bug as
"rust: drm: pin the owner while DRM files remain open", from the other end,
through ModuleMetadata rather than by threading an owning module through
UnregisteredDevice::new(). Theirs is the better shape and mine should be dropped
the moment it lands; it is still load-bearing today because upstream
UnregisteredDevice::new() takes no module. And where an early patch here fixes a
commit of Lyude's that is itself unmerged, that fix would be better folded into
her next revision than carried separately, and I am happy to do it that way

v2: https://lore.kernel.org/r/20260703030123.2814-1-mike@fireburn.co.uk

The rest of the posting, which is one series per subsystem:

  rust-core, 9 patches, rust-for-linux and linux-kernel
  https://lore.kernel.org/r/20260826162851.2497-1-mike@fireburn.co.uk
  rust-crypto, 2 patches, linux-crypto and rust-for-linux
  https://lore.kernel.org/r/20260826163004.3365-1-mike@fireburn.co.uk
  rust-usb, 5 patches, linux-usb and rust-for-linux
  https://lore.kernel.org/r/20260826163101.4168-1-mike@fireburn.co.uk
  rust-drm, 23 patches, this one
  rust-firmware, 1 patch, to linux-kernel and rust-for-linux, not sent yet
  drm-vino, 13 patches, to dri-devel, not sent yet

Vino is the user for all of them. The abstractions themselves are generic and
carry no knowledge of DisplayLink

The whole thing is one branch, base and prerequisites included, which is the
quickest way to read it:

  git clone -b vino-v3 https://github.com/FireBurn/linux
  cd linux
  make LLVM=1 rustavailable
  make LLVM=1 -j$(nproc)
  make LLVM=1 -j$(nproc) modules

CONFIG_RUST=y and CONFIG_DRM_VINO=m are the two to set; DRM_VINO selects the
rest of what it needs

It is the exact tree these patches were generated from, at 4c9ba407018e, the
drm-rust-next tip of 2026-08-06. drm-next has moved on since, and this follows
drm-rust-next deliberately: the KMS layer underneath this work lives only there,
and that tree picks up drm-next on its own schedule

Two commits on the branch are not in any of the series above, because they
enable no part of Vino: a scheduler call site that stops compiling under the
locking-guard series, and the Kms associated type Tyr needs once the KMS
registration trait requires one

It applies to the base above plus this, and nothing else:

  Lyude Paul, Rust bindings for KMS + RVKMS
  https://lore.kernel.org/r/20250305230406.567126-1-lyude@redhat.com

The reference branch also carries Boqun Feng's counted interrupt disabling
series, which SpinLockIrq needs. One patch of it is already in tip locking/core
as e901c1510e24

These patches were written with the assistance of Claude (Anthropic), used
through Claude Code as an interactive coding assistant, across the design, the
implementation and the tests. Every patch it contributed to carries an
Assisted-by trailer. The Signed-off-by is mine: I have reviewed and tested what
is here and I stand behind it

Mike Lothian (23):
  rust: drm: kms: adapt Lyude's KMS series to current DRM APIs
  rust: drm: kms: tie mode-object references to their owners
  rust: drm: kms: constrain connector encoder attachment
  rust: drm: reject cross-device GEM handle creation
  rust: drm: kms: add common state and connector helpers
  rust: drm: expose HDCP 2.2 message identifiers
  rust: drm: kms: add typed color and rotation properties
  rust: drm: kms: add connector detect() and mode_valid() hooks
  rust: drm: kms: add plane damage-clip accessors
  rust: drm: framebuffer: add validated shmem scanout views
  rust: drm: kms: expose checked plane geometry
  rust: drm: kms: add owned CRTC and vblank references
  rust: drm: kms: plane: add FB_DAMAGE_CLIPS property support
  rust: drm: add a safe constructor for owned registration data
  rust: drm: pin the owner while DRM files remain open
  rust: drm: kms: add the plane blend-mode property
  rust: drm: add an owned display mode constructor
  rust: drm: expose mode flags and CTA VIC matching
  rust: drm: expose CRTC mode changes
  rust: drm: kms: add synthesized CVT connector modes
  rust: drm: kms: read a connector's colorimetry and HDR metadata
  rust: drm: kms: walk the CRTCs an atomic commit carries
  rust: drm: kms: expose a connector's requested link depth

 22 files changed, 2062 insertions(+), 99 deletions(-)

base-commit: 4c9ba407018e8deb06dbc643112bac8f40404f95
prerequisite-message-id: <20250305230406.567126-1-lyude@redhat.com>
