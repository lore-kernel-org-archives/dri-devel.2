Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA67C9830E
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 00:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6193810E223;
	Sat, 26 Sep 2026 00:26:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="bevBJB7x";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DC1410E223
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 00:26:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790382372; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=O8LVy66XgkSSFMoP0QVFIy2/voxkfMS/j8bmyyeOFL2FSFq47dQFaPuaLL8zrL0kzrcX6IxxB2PGQ7o6RJSnfeaWB0ZAE4lbpM+2cIxhQyDLPir+WpmMrbwQ4mc2M8XabP6ErTsuGfEsUgXGdLKKFO0oMuTyXTByk/bZY8nAILQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790382372;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=rwYYr3dzkkUgcOzLC5zgNrkaVjsF9YoWpxyb4GV7h14=; 
 b=bP4FXyfQcs6+IOAU1pEpJMGFkVnShDG9nnFqHpHUyFkxgXaSMS5qhiWC1hLtKpv8XvZVBdcNgy2qUwVBNv12i8ARniE7nS3d8loFgIfxuzK4uUmmItqUL8UpUy6awWyqta65q4UNYqzwFVo8VtsIdXTBkwGoLsnpyRMUe6WDcgg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790382372; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=rwYYr3dzkkUgcOzLC5zgNrkaVjsF9YoWpxyb4GV7h14=;
 b=bevBJB7xQ7zmgyWERBazYF4tlCO0TlN0nmK5k3Dtkzeohub2uQN3pcwZinYAQwl+
 OycGyGtctZcJvEetykgiioAGjOyElBEUTdkdWPY8QqBAdIZwSrTx5BptjtN10VWSXau
 RpmAizxyGqP6NgVYVnCxIZSP07uZ6KxcYAltMFrI=
Received: by smtp.zohomail.com with SMTPS id 1790382371486273.5271645872215;
 Fri, 25 Sep 2026 17:26:11 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Subject: [PATCH v3 0/2] drm/tyr: safely write GpuInfo to userspace
Date: Fri, 25 Sep 2026 17:26:08 -0700
Message-Id: <20260925-b4-gpu_info_intobytes-v3-0-e19bcb71980d@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNUQuCMBDA8a8Se27h3WZpT32PiHDzpgNzstlIx
 O/e9CmC6OXgf3C/m1kgbymw825mnqIN1vUpxH7HdFv1DXFbp2aY4TErUXAleTM877Y3Lo3RqWm
 kwDXWMjdYilwXLN0Onox9be71lrq1YXR+2t5EWLf/xAgcuFIIJ2FKIICLdl1XKeerg3YPtqoRP
 yX5S8IkgcpyEqI2RSW/pWVZ3vuzyYIIAQAA
X-Change-ID: 20260923-b4-gpu_info_intobytes-c2d45f2935c8
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1260;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=hfK5OVz+2QcBJEGQp5s7j+sgirY7kP6SRjDdPIZcJd0=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFnbBZWUpBZ5CT44nXzjkuDzHE0hCW3/iqd1sVffKev0z
 q/5WFjbUcrCIMbFICumyHLW3qhHvOq9ke78/80wc1iZQIYwcHEKwETyHRgZTm6/eub3JtfvbzWC
 Wl2iq5fkL1w0Q4bzSCPTSu7/ep251YwMW9aLRGe52IYka2Rdj5waIlWRk/NEgu/O26nFvq9lTOS
 ZAA==
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
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

This series makes zerocopy and zerocopy_derive available to the UAPI crate
so that zerocopy derive attributes can be added to generated UAPI
bindings. It derives the zerocopy traits specifically for struct
drm_panthor_gpu_info, allowing Tyr to safely copy this struct byte-for-
byte into userspace memory.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
Changes in v3:
- split the commit into two to keep Tyr changes separate
- Link to v2: https://lore.kernel.org/r/20260924-b4-gpu_info_intobytes-v2-1-1b05e33df8a4@collabora.com

Changes in v2:
- use zerocopy_derive::most_traits
- Link to v1: https://lore.kernel.org/r/20260923-b4-gpu_info_intobytes-v1-1-bb2173f91e11@collabora.com

---
Deborah Brouwer (2):
      rust: uapi: add zerocopy/zerocopy_derive
      drm/tyr: safely write GpuInfo to userspace

 drivers/gpu/drm/tyr/file.rs |  2 +-
 drivers/gpu/drm/tyr/gpu.rs  | 12 ------------
 rust/Makefile               | 12 +++++++++---
 rust/bindgen_parameters     |  3 +++
 4 files changed, 13 insertions(+), 16 deletions(-)
---
base-commit: 896ed083362758b33c49a1b5e5a3423c5814d87e
change-id: 20260923-b4-gpu_info_intobytes-c2d45f2935c8

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

