Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0B2106ACF3
	for <dri-devel@archiver.kernel.org>; Thu, 12 Mar 2026 22:42:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFDEF10E2FB;
	Thu, 12 Mar 2026 22:42:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="r9Ob3yk+";
	dkim-atps=neutral
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com
 [209.85.208.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D4010E171
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 22:42:22 +0000 (UTC)
Received: by mail-ed1-f74.google.com with SMTP id
 4fb4d7f45d1cf-6612daf5e65so1088519a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 15:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1773355340; x=1773960140;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZQePyGCcJSLkSetdN+bKrj1kfFypqaLV10vxUIU7GyU=;
 b=r9Ob3yk+UvU6rpJ2Vi/U60D9DM5AyhrQcbbks3fzDE7EptYHz9SMSsSjc7ZIow99/T
 qMQPB+Eka2RS1SQN+tlGsTEOtRuDf2cqfr7T3GQ8QFETCyS8bU1SHGyQWVGF96HkfRn1
 Di0bf7LFQKeCyXdWek0xvpFqzjrAYXWOrzKq9NQB0P+kk0gJmwPuyDbvzPSrpGGmSXMv
 mM0Uttvr6osud6vNX1eIYC/jisl/lYqu4TEtYPR8T7pLCldcNy1M3sS2nxePc3E4Q05G
 N9mwny5q9sLAvbioyqNmSpGNLv131nTISiW6g6OAKxceJjtOwsIxo///gkUKoCXxLeXg
 KX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773355340; x=1773960140;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZQePyGCcJSLkSetdN+bKrj1kfFypqaLV10vxUIU7GyU=;
 b=YZiK5q+9iqF7TuawxvAQn/BoBN9mTHod7tL3XLEIABpqtEg/GeU2RIvXoSEPS6c1nI
 ND0KGwQ4HxLAwhFc1kZDTxJTht6KI+zYTKl6XGhCDzdg2G/Sc/Jb6Jp4s8RlGkTCjXHM
 nuOMp/ohocT6bk07xpIEvTK1qAoKh5TOjjR6AXyo3gIMMvNIN3iVSmzveyzcxEK2Znul
 297UG3mmm5/nZ425aibrKXPeL0kWA7Bhh2h2gUGosFY944aCa44DcQQHdjGly8Tr+8K1
 N8MF46PXQogozO1b15T5EYoqAeP91SgPzUPXzWpuiWDrdIyqEo1CxbxzrYNM09e50d07
 hbrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgzZTIu5nnM3YajUxfhdsD7HRk3N3mar7u487lOqhrRwlJS+EZeeZbHlWwdw4i+Ew6AG6VUhZifWs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwtoyQAor8zvxIsSwe/1bgeEFsQC2JEQKNgA6BrGqH91TyvaLj7
 l/jP4kwnIHFsaYy+c6D8fLte1AD2L3uYwYcgzKDwmf08wye9s/9FYaSQtIh+EONUGBxlvDFmEfo
 KH2MBBJ8wQ9Dbpxl5KA==
X-Received: from edxw2.prod.google.com ([2002:a05:6402:702:b0:660:bf79:1ded])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1ecf:b0:662:fad8:4ab1 with SMTP id
 4fb4d7f45d1cf-663ba9c2be5mr581809a12.7.1773355339768; 
 Thu, 12 Mar 2026 15:42:19 -0700 (PDT)
Date: Thu, 12 Mar 2026 22:42:18 +0000
Mime-Version: 1.0
Message-ID: <abNBSol3CLRCqlkZ@google.com>
Subject: [PULL] drm-rust-fixes 2026-03-12
From: Alice Ryhl <aliceryhl@google.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 "Thomas =?utf-8?Q?Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, dim-tools@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
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

Hi Dave and Sima,

Please pull these DRM Rust fixes.

The last patch has not been linux-next yet, but no issues are expected.
No conflicts expected.

The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/rust/kernel.git tags/drm-rust-fixes-2026-03-12

for you to fetch changes up to 0073a17b466684413ac87cf8ff6c19560db44e7a:

  gpu: nova-core: gsp: fix UB in DmaGspMem pointer accessors (2026-03-11 16:24:15 +0100)

----------------------------------------------------------------
Core Changes:

- Fix safety issue in dma_read! and dma_write!.

Driver Changes (Nova Core):

- Fix UB in DmaGspMem pointer accessors.
- Fix stack overflow in GSP memory allocation.

----------------------------------------------------------------
Danilo Krummrich (1):
      gpu: nova-core: gsp: fix UB in DmaGspMem pointer accessors

Gary Guo (3):
      rust: ptr: add `KnownSize` trait to support DST size info extraction
      rust: ptr: add projection infrastructure
      rust: dma: use pointer projection infra for `dma_{read,write}` macro

Tim Kovalenko (1):
      gpu: nova-core: fix stack overflow in GSP memory allocation

 drivers/gpu/nova-core/gsp.rs      |  46 +++---
 drivers/gpu/nova-core/gsp/boot.rs |   2 +-
 drivers/gpu/nova-core/gsp/cmdq.rs |  93 +++++-------
 drivers/gpu/nova-core/gsp/fw.rs   | 101 +++++++++----
 rust/kernel/dma.rs                | 114 +++++++-------
 rust/kernel/lib.rs                |   4 +
 rust/kernel/ptr.rs                |  30 +++-
 rust/kernel/ptr/projection.rs     | 305 ++++++++++++++++++++++++++++++++++++++
 samples/rust/rust_dma.rs          |  30 ++--
 scripts/Makefile.build            |   4 +-
 10 files changed, 534 insertions(+), 195 deletions(-)
 create mode 100644 rust/kernel/ptr/projection.rs
