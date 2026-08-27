Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68C9C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:01:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1D1510EEDF;
	Thu, 27 Aug 2026 08:01:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="RS0nKWei";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6057A10EEDF
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 08:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1787817697;
 bh=Wmdr0hoqNBZwZfY4RPaKUuFoMfMYXlwXpLbrI6oTzqI=;
 h=From:Subject:Date:To:Cc:From;
 b=RS0nKWeiWBR8rQquaaVLxnS6KWk0r3UNq0fGrQEJ+IXhhVqlbILCNKzyGYwVTgkPk
 mkhhgHKUBYwcjmnzhODeCYILa5UXgghSkClU5yn3WA2/aZ7GTnGOWlCljcdT5XpCzt
 Rsl4mNV8JrTkNu4+/gA6rXhy8rwquNBMs3UgqGrqDu7K6UO8rs/G2/v2S39SCjKxUy
 7jFf56ZIphkUsXfECvuwjzgcNxDo0noD4ScgRry6NFAbnRD8IMnnxSzmxNZNWTyNCv
 dLV1x26GQ453tOLdV8HPY3JP7bGIn3xkOyURUnKm70pS5iJSh5+RD9qkFJ3P4IJOIW
 n1yxGrtA3rilw==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0BC9117E0467;
 Thu, 27 Aug 2026 10:01:37 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
Subject: [PATCH v6 0/2] drm/tyr: add Job IRQ handling
Date: Thu, 27 Aug 2026 10:01:09 +0200
Message-Id: <20260728-tyr-irq-v2-v6-0-15c90baed949@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMXuj2oC/3XO3wrCIBTH8VcJrzOOx51tdtV7RBfuzJVQWS6kG
 Hv3XBD9ocCbn/D56iB6F73rxXI2iOiS73045lHOZ4J39rh10rd5CwQsocJaXm5R+niWCSU0mgk
 QG6e1yOAUXeevj9h6k/fO95cQb492wun2mTHvmXyUZKwIOlaqJbPisN/bJkS74HAQUyrpd/7xi
 6QzN2waJgY0TL948eI10AcvMq+VLSpQpVIMvzj9f50yJ9O1pnXWENpvPo7jHe1rc4BlAQAA
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, kernel@collabora.com, 
 Laura Nao <laura.nao@collabora.com>, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.12.0
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

Changes in v6:
- Split changes into two separate commits: the first one creates a new 
  file with TyrIrq/TyrIrqTrait and their related impls, the second 
  commit imports and uses TyrIrq/TyrIrqTrait from crate::irq instead of
  crate::driver
- Removed irq() accessor, unmasking the interrupts in TyrIrq::request() 
  by accessing the private irq field directly instead
- Add JobIrqMaskGuard to mask the Job IRQ before free_irq() runs, fixing 
  incorrect drop order in the IRQ teardown path 
- Combined fw_ready/job_irq_wait into a separate JobIrqEvents type
- Store firmware-ready state only once and always wake waiters 
  unconditionally
- Clear the status once the handler has been successfully registered
- Use mask() in reenable_mask() to reduce code duplication
- Reworded commit messages to reflect the changes
- Link to v5: https://lore.kernel.org/r/20260728-tyr-irq-v2-v5-1-59fd9dea952a@collabora.com

Changes in v5:
- Implement PinnedDrop on TyrIrq to clear the interrupt mask on teardown 
- Link to v4: https://lore.kernel.org/r/20260805-tyr-irq-v2-v4-1-81a4701611c0@collabora.com

Changes in v4:
- Replaced c_str! with C-String in irq.rs
- Moved clear_status() before handle() in handle_threaded(), to avoid 
  losing events if hw re-asserts the bit while handle() is running.
- Only unmask interrupt sources in job_irq_init() when the handler is 
  correctly registered.
- Link to v3: https://lore.kernel.org/r/20260728-tyr-irq-v2-v3-1-9c9bc5c029c5@collabora.com

Changes in v3:
- Propagated request_threaded_irq_by_name safety requirement up the
  call chain, made TyrIrq::request() and job_irq_init() unsafe
- Dropped CSG bits masking, added TODO comment to note this will be
  handled at a later stage. Reworded commit message to reflect the
  change.
- Added documentation for TyrIrqTrait, TyrIrq, JobIrq and job_irq_init()
- Link to v2: https://lore.kernel.org/r/20260729-tyr-irq-v2-v2-1-c2750fc11d59@collabora.com

Changes in v2:
- Dropped Wait custom type in favor of WaitQueue
- Renamed JobIrq lifetime to generic 'a

This series follows up to [1], which adds support for firmware loading
and MCU booting to the Tyr driver. The changes included here were
originally introduced in its v4[2], then dropped to reduce the scope of
the series, and have been adjusted to work with the HRT (Higher-Ranked
Lifetime Types) driver architecture recently introduced.

The series adds a threaded IRQ wrapper for the firmware Job interrupts,
used to signal events from the global CSF (GLB) and Command Stream Group
(CSG) interfaces.

These changes will be later used to wait for global CSF interface
readiness after firmware boot, as part of the CSF firmware interfaces
support that will be submitted as a separate series.

This series is based on drm-rust-next and depends on:
- [PATCH v2] rust: irq: make Registration compatible with lifetime-bound drivers[3]
- [PATCH 0/5] rust: sync: add WaitQueue infrastructure[4]

Note: [4] doesn't apply cleanly on drm-rust-next at the moment, due to
missing changes in rust/kernel/sync/lock/spinlock.rs[5]. I've applied
all dependencies and fixed conflicts for the purpose of testing this
patch on top of drm-rust-next, a branch with these changes is available
here: https://gitlab.freedesktop.org/laura.nao/linux/-/commits/b4/tyr-irq-v6

[1] https://lore.kernel.org/all/20260728-fw-boot-b4-v10-0-9187aefa3f2f@collabora.com/ 
[2] https://lore.kernel.org/rust-for-linux/20260424-b4-fw-boot-v4-v4-15-a5d91050789d@collabora.com/
[3] https://lore.kernel.org/rust-for-linux/20260719153631.559341-1-dakr@kernel.org/
[4] https://lore.kernel.org/rust-for-linux/20260726223613.1242940-1-dakr@kernel.org/
[5] https://lore.kernel.org/all/20260302232154.861916-1-lyude@redhat.com/

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
Laura Nao (2):
      drm/tyr: add TyrIrq threaded IRQ wrapper
      drm/tyr: add Job IRQ handling

 drivers/gpu/drm/tyr/fw.rs     |   1 +
 drivers/gpu/drm/tyr/fw/irq.rs | 174 ++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/irq.rs    | 114 +++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/tyr.rs    |   1 +
 4 files changed, 290 insertions(+)
---
base-commit: d7962d990307dc28dfded8cf6ba96d7498af7631
change-id: 20260728-tyr-irq-v2-0b3c5022be33

Best regards,
-- 
Laura Nao <laura.nao@collabora.com>

