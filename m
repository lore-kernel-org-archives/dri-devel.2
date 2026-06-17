Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA0BCD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D37410EA4C;
	Wed, 17 Jun 2026 15:02:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="SgOZlc+j";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C76E010F005
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 15:02:39 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-bec49f7e35eso788717966b.2
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1781708558; x=1782313358;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lCa0uenWWZ89F0YVTYC+LQ6UyP30FoInUSkltfqEQkI=;
 b=SgOZlc+jpIaUlhe8SzlPa7w0tTaEHoE91dIkiUOZebxyECzUAGBev2beIQ6pB2Z7T+
 YPTAqbU4VFbvjVJaxuLB7So2RbQs5bT4pnHYcKJfLxCOxf5/7wMoZR2XwZ+u5wwKKwmY
 5TqwEMq6rM5cUNLQ0zfLKvnXAskoLJUxtKGozCQluSsZaiTwwmYP0e36poMrLNnGrDcP
 ORn1JyB9/8vyN/nL3imlIhJ37jI09e3onsWiEurWIM2HqK39S53qegCHOCfFYsm4NG+D
 VYw4+dgerNvPju48jCBDWZHEjsFlysz8mno818RptkS3jhEQyT0qfePUWWz5YIu7JE21
 afgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781708558; x=1782313358;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lCa0uenWWZ89F0YVTYC+LQ6UyP30FoInUSkltfqEQkI=;
 b=osoDOGGBUtwSWAjwI8eWel3SVAUpdYrQYkmJTL8IY37KKbfORLpRgqUoQ5vyOPcv/v
 DZbaIqACQHCsJuVcBuMcnA+filM8zCdsv5SDIAQjhTMjpGY/zkvioOfjL87rYGiGkIjL
 qhNJmp92RWFDIL7qjsXTxrfkLr7biDQPnLromZnFY8xwGs8qrvLJDJDBsJ5oUpqlJLAn
 28aCV9Vgci+bpUXKbWko1ZQgLk/6gAk3oqJGLRDgw1+PY2FDiF2sdCXr1me1llNXaGtP
 23+qYs9iuRyD/O2ieXyI/sJETAoWT4Q66YKyQ20rbtTY6xQCNe2cOrnI/7SB1RzzW5Sx
 E5vg==
X-Gm-Message-State: AOJu0Yz6q7GIBoq9KEb031oadYE3AvKGmxoJcTBhzJuTkH2zsMCHEstU
 ibDXQIsg2GWrLnXpU0J/ldpHsK9UfJweuTA0bIQOKT8gGEri8y0aCwsRIH/lJ7yQQzecXMm7MsL
 W3nJtoKGV
X-Gm-Gg: Acq92OFjGIm1v/SR2pWwJg+22I0UzboxvWxC0W/ZXL4NrZ//6gRq0+NlO5C8P9HI17H
 IrXMHHfdi/fzpxyeY3F0i2kDNwZIXujCl4CK8eSoGz+31x5SY4RO3tSRyeRfDSlmeOBJailvcEI
 1Ta7ekLpNKVdMTTpYFuTWG7W3H9teAyCxHBC5tZgPEQfDADlzwoZGr8aaHjeEqVlniIE0p7/Yma
 WO28t/cGCfy5JIkBXSXFdv30aRCDcSzOd/b2uM+cvIdapSiAq5q3CwTkbujOyiLSdS7IHEzKFNH
 pEpbXIdreCvNM/sXLttt1T+BJ7Q9Rm0HB4slHeq3YM/ejNEnbq/uVTMG0Ewh15Px1vnawMIXWeU
 HGV14NddMTg2/S7JeEcN16suIbUxuKlJT57Rx3fIZoQBi9kj955dHtXbY2H/TomknDMQVbdek8V
 n/rgwVcV5YU2KFbUfe2Jzd/P8jFE4asO1MbFmIY4ETmp2WUTIQMoB1xjJk
X-Received: by 2002:a17:906:9fca:b0:c03:b8c6:cc27 with SMTP id
 a640c23a62f3a-c05a6bded8bmr287227266b.24.1781708557936; 
 Wed, 17 Jun 2026 08:02:37 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f1cdsm57264311f8f.11.2026.06.17.08.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 08:02:36 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: Mike Lothian <mike@fireburn.co.uk>, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Lyude Paul <lyude@redhat.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/5] rust: drm: minimal KMS bindings, EDID read, rotation,
 HDCP defs
Date: Wed, 17 Jun 2026 16:02:22 +0100
Message-ID: <20260617150232.2210-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This RFC series exposes enough of the C KMS API to Rust for a driver to
bring up an atomic mode-setting pipeline with the drm_simple_display_pipe
helper (one CRTC + primary plane + encoder) and install a real EDID read
off its own transport:

  1/4  KMS headers + Driver::FEAT_MODESET/FEAT_ATOMIC
  2/4  <drm/drm_edid.h>: drm_edid_alloc/_connector_update/_add_modes
  3/4  pub drm::Device::as_raw() escape hatch (separate, contentious bit)
  4/4  <drm/drm_blend.h> (atomic plane rotation property) + a rust_helper
       for drm_atomic_get_new_crtc_state() (inspect proposed CRTC state
       from a mode_config atomic_check)

It is deliberately an RFC and interim: it does NOT add safe Rust KMS
abstractions (CRTC/plane/connector wrappers - an active upstream effort),
only the raw binding surface plus the trait/visibility tweaks a driver
needs to call the C helpers itself.

FEAT_MODESET / FEAT_ATOMIC follow the existing FEAT_RENDER idiom exactly
(per-feature bool associated consts folded into compute_features()), so
GEM-only drivers are unaffected.

drm::Device::as_raw() is made pub as a documented temporary escape hatch
for calling the C KMS helpers until safe wrappers exist. That is the part
most likely to draw objections, so it is split into its own patch (3/3):
the feature flags and header bindings in 1/3 and 2/3 are useful on their
own and can land even if the escape hatch is reworked or dropped (e.g.
replaced by narrow per-helper safe wrappers).

drm_blend.h (4/4) exposes drm_plane_create_rotation_property() so a
driver can offer the standard atomic rotation property, and adds a
rust_helper for the static-inline drm_atomic_get_new_crtc_state() so a
driver can read a CRTC's proposed state during atomic_check() (the vino
driver uses it to reject a multi-head modeset that would exceed the USB
bandwidth). Like the rest of the series it is interim raw-binding surface.

drm_hdcp.h (5/5) exposes <drm/display/drm_hdcp.h> so a Rust HDCP driver
can use the canonical HDCP 2.2 message IDs, length constants and hdcp2_*
message structs instead of redefining them (the vino driver runs HDCP 2.2
over a vendor USB transport and reuses only the message definitions, not
the drm_hdcp_helper state machine). It only pulls in <linux/types.h>.

Note: a related but independent fix - using drm_dev_unplug() instead of
drm_dev_unregister() in Registration::drop, which closes a real
use-after-free for Rust DRM drivers on a hot-removable bus - is sent as a
standalone, non-RFC patch ("rust: drm: unplug the device on Registration
drop") rather than buried in this RFC, since it stands alone and should
not be gated on the KMS-surface discussion.

Factored out of an out-of-tree in-kernel Rust DisplayLink DL3 dock driver
that drives a virtual connector and reads the dock's downstream EDID; but
the bindings are generic (the same path simpledrm/gud/udl use).
Compile-tested in-tree against drm-next.

Mike Lothian (3):
  rust: drm: add minimal KMS bindings for simple-display-pipe drivers
  rust: drm: expose drm_edid.h for reading connector EDID
  rust: drm: expose drm::Device::as_raw()
  rust: drm: expose drm_blend.h and the atomic new-CRTC-state helper
  rust: drm: expose <drm/display/drm_hdcp.h> HDCP 2.2 message definitions

 rust/bindings/bindings_helper.h | 10 ++++++++++
 rust/kernel/drm/device.rs       | 18 +++++++++++++++++-
 rust/kernel/drm/driver.rs       | 17 +++++++++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)

--
2.54.0
