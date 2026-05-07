Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18064CD3445
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 23:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 449F810F2B7;
	Thu,  7 May 2026 23:32:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="iVYEAzSY";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD78B10E040
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 23:32:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1778196765; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=iodR+X/sfygQTZFO7MO+8dJKs+PSVKYNwaZcBryNUV0U6DqjGSN+r9IK5htAANVryOd7ThQu9KiqdQDmdYHuH5nkujSKRHKIykmcy9OJ8S+8/rkmKl+2AYRn2h1ULv3P4fNbz3/amBZ80xNaMgQOqAL5xapuVqlLCga4bo20uOE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778196765;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=0yXurVd+vBtVsJ59FkRCImq2A0GRBwr2KgHlyQcm6R8=; 
 b=iVolRgS9IUseYB1TZIT30l1YI9IVnXPPF+Jem6gvazKAJ8wUQBjl63qoMHRF5XU5UBGOTG5AkfIouemwjiKPkuMZfaxfzqmoE5QMc7d7icp50jRTqfd+wA6+pa8Ul9EOcPwDohHHiEvDLoEn/VHbrjapKhHURlqlcLePdn8TuQE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778196765; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=0yXurVd+vBtVsJ59FkRCImq2A0GRBwr2KgHlyQcm6R8=;
 b=iVYEAzSYWg8zuqA/0fzNP54Rcvy+I5m6/m1GN2ptYnzcxD8orITKLm+e+UWJ0WBQ
 JMisswL9xB5p6AjNxestVh58t91+cAQqiyBAMTDlxrSSNl1+FxZdWYC/5Z7vPNglo8H
 vTppCf0WkaWowBB6Yo6G8n/SjplL1urtJG14xbwo=
Received: by mx.zohomail.com with SMTPS id 1778196762618896.5906424507173;
 Thu, 7 May 2026 16:32:42 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Subject: [PATCH 0/7] drm/tyr: add userspace MMIO mmap support
Date: Thu, 07 May 2026 16:32:38 -0700
Message-Id: <20260507-tyr-mmap-v1-0-eec048a23c25@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUwNz3ZLKIt3c3MQCXeNESxNDEwMTs7SkJCWg8oKi1LTMCrBR0bG1tQC
 Dm0F4WgAAAA==
X-Change-ID: 20260507-tyr-mmap-3a9414046fbb
To: Alice Ryhl <aliceryhl@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 boris.brezillon@collabora.com, beata.michalska@arm.com, lyude@redhat.com, 
 acourbot@nvidia.com, work@onurozkan.dev, alvin.sun@linux.dev, 
 Laura Nao <laura.nao@collabora.com>, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2137;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=+hdChgrxdEzktXzCgBh0WuTgbVK+102ALnzsogUqgo4=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJl/FSUl922OWt1eskJE4PJyC8fzt7+fT4lYIbq4wk/jY
 MWabvnIjlIWBjEuBlkxRZaz9kY94lXvjXTn/2+GmcPKBDKEgYtTACbyYyojwwqXJh+NLexTj4rt
 aix3n22//fKDqv74A0nPM55rLZhU2szI8EQn+v2zigeK500l9uT/nLF850+uLQlfVGU3HdRN9Ir
 JZgYA
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

This series adds support for Panthor-style userspace MMIO mappings to
the Tyr driver.

Panthor reserves a special DRM mmap offset range for exposing selected GPU
MMIO pages directly to userspace. This series implements the initial
userspace-MMIO mmap path for Tyr and wires up support for mapping the
LATEST_FLUSH USER register page.

The mapped page is read-only, non-cached, shared, and faulted in lazily
through a custom VMA fault handler using vmf_insert_pfn_prot(). This
allows userspace to observe GPU cache flush completion directly through
the mapped register instead of polling through an ioctl.

To support this, the series adds a small set of Rust MM and DRM helper
APIs:

* pgprot_noncached() wrapper for Rust MMIO mappings
* VmaRef::pgoff()
* drm::File::device()
* driver-overridable DRM file operations

The series also adds USER register page definitions and stores the MMIO
physical base address in TyrDrmDeviceData so PFNs can be derived during
fault handling.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

---
Daniel Almeida (2):
      mm: rust: add pgprot_noncached helper
      mm: rust: add VMA page offset helper

Deborah Brouwer (5):
      drm/rust: add File::device() helper
      drm/rust: allow drivers to override file operations
      drm/tyr: add USER register page definitions
      drm/tyr: store MMIO physical base address
      drm/tyr: add userspace MMIO mmap support

 drivers/gpu/drm/tyr/driver.rs |  12 +-
 drivers/gpu/drm/tyr/mmap.rs   | 247 ++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/regs.rs   |  18 +++
 drivers/gpu/drm/tyr/tyr.rs    |   1 +
 rust/helpers/mm.c             |   5 +
 rust/kernel/drm/device.rs     |   4 +-
 rust/kernel/drm/driver.rs     |   6 +
 rust/kernel/drm/file.rs       |  12 ++
 rust/kernel/drm/gem/mod.rs    |   3 +-
 rust/kernel/mm/virt.rs        |  10 ++
 10 files changed, 314 insertions(+), 4 deletions(-)
---
base-commit: 37f748ed0c19e007e7c5677f5d605d6b93841792
change-id: 20260507-tyr-mmap-3a9414046fbb

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

