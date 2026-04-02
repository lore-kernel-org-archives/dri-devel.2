Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00983D6AB18
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 23:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7D5C10F786;
	Thu,  2 Apr 2026 23:35:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="BODeN5nK";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF40D10F76C
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 23:35:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1775172951; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LMJtOACO99DVYa3Zy0ZtWgDgYKygwTzTDYrv+WGwJTHqrP28QnTIzPD+7uClxLQ/oiWTvgHmxN6PwLtBaxu7BP6ZkZU1YPwMOMcjR8H15Diajfl2++dhrhLCw9PaprptZAU5AtDwuawSc5diplN5F2bzRKsfMyPGWrLsiFu3JSw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1775172951;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=xLQ7jPWMosmzvuLTBcsWWp0XdEuXwKiP64qZpiJezZs=; 
 b=E81A0ySWahGV9ZGUsX/M0HsIfQjuW8gOzteoz5iAQd45SvAp1ACck3ze3DmL/bUFOb13zg7lpI2pbgpoHZiiS5L1zm/J5WQUAmX8uAp62HZkXo1hWzlbs3+TIJyVXJ7dMVw/aS7Og++gGx0Q2JTACC1mNdB3e0pJcf3nuNImYDg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775172951; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=xLQ7jPWMosmzvuLTBcsWWp0XdEuXwKiP64qZpiJezZs=;
 b=BODeN5nK61LFWzM1v85Xu4V6Yro4O0cB0v4+yuPoJjFjpdkqYFv749yIURRtVB7K
 dZNOSaT74Z5VHHXJlg2T7AQDVb59FF4BF2dz+rn2hO01U4YwlAziV7pWcX9BayBQJGo
 R5mKdY2S3Rnn3x3n0dEcf0TsvfKh/hPRB5w9ZY04=
Received: by mx.zohomail.com with SMTPS id 1775172950255126.6962243263522;
 Thu, 2 Apr 2026 16:35:50 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Subject: [PATCH v4 0/6] drm/tyr: Use register! macro
Date: Thu, 02 Apr 2026 16:35:30 -0700
Message-Id: <20260402-tyr-use-register-macro-v4-v4-0-96a8d42f8bd1@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MPQqAMAxA4atIZgNtqQpeRRyqjZrBHxIVRby7x
 fEb3ntASZgU6uwBoZOV1yXB5xn0U1hGQo7J4IwrjTcO91vwUEKhkXUnwTn0suLpsbMx2mLwlQ0
 BUr8JDXz976Z93w9IUFh0awAAAA==
X-Change-ID: 20260402-tyr-use-register-macro-v4-b1dd15f471aa
To: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 Boqun Feng <boqun@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Steven Price <steven.price@arm.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Dirk Behme <dirk.behme@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Deborah Brouwer <deborah.brouwer@collabora.com>, 
 Boqun Feng <boqun@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2871;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=6DwD6IinKIIx0Gt0bJ1Ll0TLA4MGUxDv2mPPQh3wHbA=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJnn/oaWhaznaDE6vNJq+/Fy6WnHvafYPFk4zWKupMjUp
 rRnqd5/O0pZGMS4GGTFFFnO2hv1iFe9N9Kd/78ZZg4rE8gQBi5OAZhI5SGG/zW/uH6xb1z9yeZg
 8stfN1bYHdh2rTNBP9F627sI88d+XpmMDG82iJzNdpk1VfpaqITnqis2B/9+/V58nvvLNM2+PS1
 tGXwA
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

This series changes the Tyr driver to use the kernel's register! macro
for hardware register access, replacing manual bit manipulation and custom
register structures with a more type-safe and maintainable approach.

---
This series applies on drm-rust-next
tag: drm-rust-next-2026-03-30
base commit: 7c50d748b4a6

Changes in v4:
 - Add PartialEq to all enums so they can be used in comparisons.
 - Replace u64 registers with u32 LO/HI pairs and helper functions to read them.
 - Combine all MMU register definitions into one patch.
 - Drop [PATCH v3 03/12] drm/tyr: Set interconnect coherency during probe
   to avoid possible leaks/data corruption.
 - Pick up Ab, Rb tags

 - Link to v3: https://lore.kernel.org/r/20260323-b4-tyr-use-register-macro-v3-v3-0-a87daf9e4701@collabora.com
    
Changes in v3:
 - Update write_val() with write_reg() from API change.
 - Replace const values with enums and use => ?=> syntax.
 - Convert 1-bit fields to bool.
 - Change module visibility from pub(super) to pub(crate).
 - Add new commits to define mmu address registers.
 - Add new commit exposing hardware DOORBELLS.
 - Pick up Reviewed-by tags.
    
 There are also change logs per patch.
    
 - Link to v2: https://lore.kernel.org/r/20260311-b4-tyr-use-register-macro-v2-v2-0-b936d9eb8f51@collabora.com
        
Changes in v2:
 - Rebase on v8 of register! macro series;
 - Add documentation;
 - Remove manual functions to get address bits;
 - Revise gpu_info() to use macro;
 - Remove manual functions to get address bits;
 - Revise gpu_info() to use macro;
 - Revise l2_power_on() to use macro;
 - Set interconnect coherency protocol with macro;
 - Separate commits for each register page;
 - Replace HI/LO pairs with 64bit registers
 - Order registers by address;
 - Remove doorbell clear field from GPU_IRQ_CLEAR;
 - GPU command is redesigned to accommodate multiple layouts;
 - MMU register bits corrected;
 - Use UPPERCASE for register names;
 - Move the consts to impl block for registers;

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

---
Daniel Almeida (1):
      drm/tyr: Use register! macro for GPU_CONTROL

Deborah Brouwer (5):
      drm/tyr: Print GPU_ID without filtering
      drm/tyr: Use register! macro for JOB_CONTROL
      drm/tyr: Use register! macro for MMU_CONTROL
      drm/tyr: Remove custom register struct
      drm/tyr: Add DOORBELL_BLOCK registers

 drivers/gpu/drm/tyr/driver.rs |   24 +-
 drivers/gpu/drm/tyr/gpu.rs    |  232 +++---
 drivers/gpu/drm/tyr/regs.rs   | 1744 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 1761 insertions(+), 239 deletions(-)
---
base-commit: 7c50d748b4a635bc39802ea3f6b120e66b1b9067
change-id: 20260402-tyr-use-register-macro-v4-b1dd15f471aa

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

