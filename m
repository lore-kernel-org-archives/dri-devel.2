Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F1D606A6B1
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=hv33eNY7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 802FB10EEC1;
	Mon, 23 Nov 2026 14:59:06 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67DE910EEC1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 14:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795445939;
 bh=C/LrQy/b3pP6rvBM/K9DTtkaboUzCcE+bKa+Er8ZWrk=;
 h=From:Subject:Date:To:Cc:From;
 b=hv33eNY7iFLjH4F+l2Z4rC4uTlN3bAbSXSC937MTgf3/QcjCYH2CYvtJDxz8U6o4V
 AYJYk/TrMTkI1ixud9NW5KkIDleCm7uD3T+pwgLjGcuvykl3JsufCXJh7P+WNKBJrR
 TvmNzI0tFZOlV9tACCg7rbhV5IUbOFP1RP2ygolq861flpGlRPsoyqUCc5A1/tV7KS
 zKD3W9M7AOW/8P4o8GQBZC61jjCAkVwK9klbodoIGDmD5Qgfb/li1e9tQcBZu8hfh3
 AM2bO0fuJFUwMbA86oQ2TTZClfrX9ldsuB/puOAwX+ub+2U8Izaj960GjHCkYvCFiU
 5lLfWcKHFvr/g==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5BE6817E031C;
 Mon, 23 Nov 2026 15:58:58 +0100 (CET)
From: Laura Nao <laura.nao@collabora.com>
Subject: [PATCH v7 0/3] drm/tyr: add Job IRQ handling
Date: Mon, 23 Nov 2026 15:58:44 +0100
Message-Id: <20260728-tyr-irq-v2-v7-0-4e172e58e28c@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKRUBGsC/3XPwWrDMAwG4FcpPs9DlqMk2mnvMXawZWc1dHXnF
 LNS8u5zC2MtS8GX3/D9ks5qjiXFWb1szqrEmuaU9y0MTxslW7f/iDqFlhUC9jDgqI+nolP50hU
 1eCsEiD5aqxo4lDil72vZ23vL2zQfczlduytefn9r+LamPaMFB4JJjAnEr5J3O+dzcc+SP9Wlq
 tpbfrdFtY2zsBcSQBZa490fH4HueNf4aFw3gOmNEVjj9Hg6NU48BQ7RMaFb4/1j3mvQhoTBuxi
 4+3f7siw/HFslZ6QBAAA=
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
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Changes in v7:
- Rebased on top of drm-rust-next
- Added spinlock to serialize mask register writes with state 
  transitions, matching panthor's behavior.
- Added IrqState to track an interrupt state and coordinate
  primary/threaded handlers and teardown.
- Replaced JobIrqMaskGuard with new TyrIrqRegistration struct, which 
  wraps a ThreadedRegistration. Its drop implementation ensures 
  interrupts are masked and status is updated before free_irq() is 
  called, preventing racing with threaded handlers running concurrently 
  on another CPU and a possible IRQ storm.
- Updated job_irq_init to resolve the IRQ registration into a 
  Pin<KBox<TyrIrqRegistration<...>>>, so it's fully initialized before 
  returning.
- Rebased on top of "drm/tyr: GPU reset infrastructure"[3]. Updated
  code to leverage HwGate for IO operations.
- Added "drm/tyr: add HwGate::try_access_atomic()"
- Link to v6: https://lore.kernel.org/r/20260728-tyr-irq-v2-v6-0-15c90baed949@collabora.com

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
- [PATCH v9 0/2] drm/tyr: GPU reset infrastructure[3] and its
  dependencies

Note: A branch with all the changes is available here: 
https://gitlab.freedesktop.org/laura.nao/linux/-/commits/b4/tyr-irq-v7

[1] https://lore.kernel.org/all/20260728-fw-boot-b4-v10-0-9187aefa3f2f@collabora.com/ 
[2] https://lore.kernel.org/rust-for-linux/20260424-b4-fw-boot-v4-v4-15-a5d91050789d@collabora.com/
[3] https://lore.kernel.org/all/20261122-tyr-reset-impl-v9-0-ed42d8f513ec@onurozkan.dev/ 

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
Daniel Almeida (1):
      drm/tyr: add HwGate::try_access_atomic()

Laura Nao (2):
      drm/tyr: add TyrIrq threaded IRQ wrapper
      drm/tyr: add Job IRQ handling

 drivers/gpu/drm/tyr/fw.rs            |   1 +
 drivers/gpu/drm/tyr/fw/irq.rs        | 148 +++++++++++++++++++
 drivers/gpu/drm/tyr/irq.rs           | 269 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/reset/hw_gate.rs |  54 ++++++-
 drivers/gpu/drm/tyr/tyr.rs           |   1 +
 5 files changed, 471 insertions(+), 2 deletions(-)
---
base-commit: 746918a0c6c0c1738e74d5e198ee06c848e2ddd2
change-id: 20260728-tyr-irq-v2-0b3c5022be33

Best regards,
-- 
Laura Nao <laura.nao@collabora.com>

