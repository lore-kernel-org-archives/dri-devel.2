Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDD3C61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:17:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C3ED10EA18;
	Tue, 25 Aug 2026 12:17:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WfwzuDuO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57C6010EA18;
 Tue, 25 Aug 2026 12:17:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CFF8960A5B;
 Tue, 25 Aug 2026 12:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431DB1F000E9;
 Tue, 25 Aug 2026 12:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787660268;
 bh=FaTTTGZ4IVUgyqer7a+OU7NGQiD1FIrE/QXnJiP0MO0=;
 h=From:Subject:Date:To:Cc;
 b=WfwzuDuOer4hLyL3DFq50k1zFiwwpM2klg8XVktpIxf4obqiSJ/8mCRDThburSgzv
 AK8igZEcWnMd96ikUSNnSiK9CjABMqhcIzZb0sOmcgjiymnaWnr6Oa5ct1+8ZVzCeK
 locXI1hykU6gCg4f6h9YpntBqwuDxFLwpliVu3N2VLgy+xb8fhYdEFeSv13v5tpu2r
 3K5SN7GSOMbduV7kvBVy+9kP5csFYvzCDwGyD+clQom7mnTe+WEBgchLuirHGF7OqZ
 qqf1nkYqTfD6LfHdeH3HZ8sfMQkMiHPC+UVY1D1LUbdNiQ4XE94+bA9L9tq7QPWyRa
 0vCnThJGUSfpw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH 0/6] hrtimer: add an expiry injecting callback variant
Date: Tue, 25 Aug 2026 14:16:31 +0200
Message-Id: <20260825-expires-v2-v1-0-90411c6217c7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ+HjWoC/yXMQQ5AMBBA0as0s9akmipxFbGgBmNB00GaiLsrl
 m/x/wWMgZChFhcEPIlpWxPyTICbu3VCSUMyaKWtqnQhMXoKyPLUUpXWdMNonLEWUuADjhS/WdP
 +5qNf0O3vAe77AYsO2jVuAAAA
X-Change-ID: 20260825-expires-v2-0764adf4c466
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Lyude Paul <lyude@redhat.com>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4973; i=a.hindborg@kernel.org; 
 h=from:subject:message-id;
 bh=uxuF9oDXoslzpNcurK5OPdAxWGIKsbJVkvyei3ZDksU=; 
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqjYelIQSGXA4guzoFlt3Ud75kEFzssOSKUAkqx
 KUY7gdiZNuJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCao2HpQAKCRD6UCkIqsW9
 0BOLD/40BEbL6chx737A0yvpDLQPoNVNHsi4cDMNbnqCEcXKOj7xH9clSjGEepaIgTOXL6Nk/IT
 Lp+zYR/4b07o8mhS3SKcNcL9gQTzHbcKq1DXalBVYJveemaFdIy7UoqirbYyEQdOKnyVmln3Qc1
 unk+hIyCKtd1YhNAERM8F63FbXUHSb8VvqNiXa2Npz03nvvccbzG7cf2pnqpmpihJ1G7xjad1h5
 N9I6GN+bABwtg5mjwLC0+zaYh5u4EZiqmbqlVCF5c547xX3oZ+sQx57xICTFPJp/TTqQkhBfook
 oPwp84Emq9hk/0nl7zBTMixpWRujXG7rF5ACVdxisakfZ61pzREibL3jALD32UTbLfQkkP+4Lmh
 FDBflBngzr6jpfhSuZr1Hqgff6ZZAl5VIW/8J3KmxiIzeC7lYs564/72WIdJrozBXPOn2cEIEf6
 NxhocfgNvMfHyRKZ2eY86W7cAncau90z+pGt/JDzK797Rhe+urBwUfn7TnAwj05iiBgTMOqoNqI
 PIEkAt+5OAaL4dWBq/A15jdty6G3f86mi1hmQbXX/w76xN02ar5MCof46FFAoHJyibVWKMOkdiI
 lR31oXS4zXIvZoL8HElfFexNuF1MG0QXsRGRiOduc7UyWzxu1BA21IChipfAEVuH5JMBD/j+4pX
 9pXmz6jY6o8769Q==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7
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

An hrtimer callback runs after __run_hrtimer() has dropped the
cpu_base->lock, and a timer can be armed from any CPU at any time,
including while its callback is running. A callback that adjusts its
own expiry with hrtimer_forward() therefore races with a concurrent
hrtimer_start_range_ns():

- The read-modify-write of node.expires in hrtimer_forward() is
  unsynchronized against the write in the start path, which happens
  under the base lock.

- The is_queued check in hrtimer_forward() is a
  time-of-check-to-time-of-use bug. A concurrent start can enqueue
  the timer right after the check, and forwarding a queued timer
  changes the expiry of a node inside the timerqueue without
  re-sorting it, leaving the tree unordered.

Users that both forward from the callback and arm the timer from
other contexts have to serialize the two themselves, as perf does
with cpc->hrtimer_lock and the hrtimer_active flag, see 4cfafd3082af
("sched,perf: Fix periodic timers"). The requirement is subtle. i915_pmu
and taprio do not honor it today.

For the Rust hrtimer abstraction this is a soundness problem rather than
a documentation problem: safe Rust code can arm a timer whose callback
is running, because Arc<T> is Clone and Pin<&T> is Copy, so a callback
context forward() cannot be offered as safe API at all. Making arming
exclusive in the Rust type system was tried [1] and abandoned. It adds
complexity to the Arc based API, and it leaves the C interface as the
same trap for C users.

Gary suggested [2] removing the race structurally instead: snapshot
the expiry under the base lock, hand it to the callback by value, and
have the callback request the forward and the requeue instead of
performing them itself. This series implements that suggestion.

Patch 1 adds the expiry injecting callback variant to the hrtimer core.
Such a callback is installed with hrtimer_setup_ext() and receives
the expiry snapshotted under the base lock. To restart the timer it
fills a struct hrtimer_forward_args and returns HRTIMER_RESTART, and
__run_hrtimer() then applies the forward and the enqueue with the base
lock held. The callback never touches live timer state. If a concurrent
start enqueued the timer while the callback ran, the restart request
is discarded and the start wins, which matches how we already treat a
restart of a timer that was requeued behind the callback's back. The
new callback pointer shares storage with the classic one in an anonymous
union and is discriminated by a flag placed in existing padding, so
struct hrtimer does not grow and the classic callback path is untouched.

Patch 2 converts i915_pmu, which forwards from its sampling callback
while gt park/unpark can start the timer from another CPU. The
conversion closes that window without adding locking to the sampling
path, and demonstrates that the new variant is not Rust-only
plumbing.

Patches 3 to 6 are the Rust side. Patch 3 moves the abstraction to
the new callback variant: HrTimerCallback::run() receives the expiry
snapshot and returns HrTimerRestart::Forward { now, interval }, and
HrTimerCallbackContext with its forward()/forward_now() methods is
removed. Patch 4 is Tomonori's expires() fix rebased on top, now
justified by exclusive access rather than by callback context. Patch
5 documents the pre-existing hazard that starting a timer from within
its own handler self-deadlocks when the returned handle is dropped
there.

The i915 patch is compile tested only, I have no hardware for it.

[1]: https://lore.kernel.org/rust-for-linux/20260813134834.1562995-1-tomo@flapping.org/
[2]: https://lore.kernel.org/rust-for-linux/DKNVOU9JC15P.3DEBNZ56QK20E@garyguo.net/

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
Andreas Hindborg (4):
      hrtimer: add expiry injecting callback variant
      drm/i915/pmu: use the expiry injecting hrtimer callback
      rust: hrtimer: use the expiry injecting callback variant
      rust: hrtimer: document deadlock when starting a timer in its handler

FUJITA Tomonori (2):
      rust: hrtimer: restrict expires() to exclusive access
      rust: hrtimer: Make HrTimer repr(transparent)

 drivers/gpu/drm/i915/i915_pmu.c     |   8 +-
 include/linux/hrtimer.h             |   7 +
 include/linux/hrtimer_types.h       |  34 ++++-
 kernel/time/hrtimer.c               | 112 +++++++++++++++-
 rust/helpers/time.c                 |   6 +
 rust/kernel/time/hrtimer.rs         | 257 +++++++++++++++++++-----------------
 rust/kernel/time/hrtimer/arc.rs     |  23 ++--
 rust/kernel/time/hrtimer/pin.rs     |  23 ++--
 rust/kernel/time/hrtimer/pin_mut.rs |  26 ++--
 rust/kernel/time/hrtimer/tbox.rs    |  23 ++--
 10 files changed, 352 insertions(+), 167 deletions(-)
---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260825-expires-v2-0764adf4c466

Best regards,
--  
Andreas Hindborg <a.hindborg@kernel.org>


