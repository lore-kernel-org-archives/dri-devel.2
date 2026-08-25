Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81268C61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C590110EA03;
	Tue, 25 Aug 2026 12:17:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GTYn11Zx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BB0210EA03;
 Tue, 25 Aug 2026 12:17:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 55855601E9;
 Tue, 25 Aug 2026 12:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDF01F000E9;
 Tue, 25 Aug 2026 12:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787660242;
 bh=RhUaj2iTct8ZMQqOXLddUC8RzMt7r68jTHovoycnwZM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=GTYn11Zxoqx4nFPnn3iQV/oLsd5wrPztDmvKbpA57GIdK6xQ2ojPYKQ5JRHQ+MMn3
 ujc3uEV10y5bcgLxvTY2o9I3HsYTcgncZkUn7xHjht7HNcyaln5AlZKbYIRL1uOZAn
 Y4l1WipNdMUk5nam65Vx0ETJnJN8dnIk01eu8xQSRAdqwxfW39kPBDX6/KG/OH1s8Z
 BxrR+CIQcKQdz/El0qtQ/BjJ7loSIsXkCc5SMHgErHKGyOOrAXcoVMFJ94k1damQPS
 07P5mGVRqXxrZ6zAbWPbyUIz3V4RQKCf+I4qkO+9pGmcFEKNR2aQdhJTCdTGUdyTqs
 ocNTWZilwp3+g==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 25 Aug 2026 14:16:33 +0200
Subject: [PATCH 2/6] drm/i915/pmu: use the expiry injecting hrtimer
 callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-expires-v2-v1-2-90411c6217c7@kernel.org>
References: <20260825-expires-v2-v1-0-90411c6217c7@kernel.org>
In-Reply-To: <20260825-expires-v2-v1-0-90411c6217c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2817; i=a.hindborg@kernel.org; 
 h=from:subject:message-id;
 bh=90mGZPWIU/fyS6ZTqqJ088ULnnbMquDKr7jAWdHJqMw=; 
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqjYe6GJ7BAPiTGhlmUhLYcVzfzIAUNIlcz40no
 gBs5R8JTAuJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCao2HugAKCRD6UCkIqsW9
 0P5GD/kBdKSV16YNHwNaRdasWQNQlrPlu/CrDYWDhMd3jpzFnBuNvWToct5CAY0/Zdz7YpbrUid
 y2IGQbIKK+kvJtexLCu3g8fPb24aHwK+81rJQi/Pexp1r8NdVOWJ1o/0UT0aQeN4TVC9uZr1pxY
 WOD5LiYN88jjoq9xQUSuia6jiZP47rLBHhBFSOgEXtbp4r1YPZxz2FSyjHH7rubvooD7QQrG7f3
 D7d4QZeZp7cyEQ4qefhjPvFi/v0yi1YjtRBC13evv5Tx2nrkgd+VRr9SK2XohI7niUjBQeppKv6
 BAxbWSt/VKjsS/FBiQiFi7j43DSJQPR2g0NlWb7EsOPh/C+7FPALNYqUH/5Tu1Rr/XvRloMuBdu
 /yI44zbTAVVOtsywjLTrnUC6PniCuoK12VOEb9xvDETBwDE79PI5kY7nuqa+FBhYflpV+HxCTMH
 CB0anVLjZvCC56ka2E1q+SoE4RpINxdRiRNVyouICREDU+jtMERPomjQ6UPv6tD4EA8JUVUzQp+
 kuzqv127M1hQqtf8qBPReNltryfv0faSx336V25H84++t7WVT0wcjj3JrwgaabcKaIEIi9UdKH9
 JXJrHb2YW4P5OEmTojn7Y+02V5ofwPWJvnBnoiWey868o9pLqWikqY/kcorvkyPcUfAcC47ebhg
 E5C0Rk9kClp7A8w==
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

The sampling timer forwards itself from its callback:

  i915_sample()
    hrtimer_forward(hrtimer, now, ns_to_ktime(PERIOD));

hrtimer callbacks run with the timer base lock dropped, so this
read-modify-write of the expiry races with a concurrent restart of
the timer. Such a restart is possible here: i915_pmu_gt_parked()
clears pmu->timer_enabled, and a subsequent
__i915_pmu_maybe_start_timer() from i915_pmu_gt_unparked() or event
enable on another CPU sees the timer disabled and calls
hrtimer_start_range_ns() - also while the callback is running, since
i915_sample() checks timer_enabled only once at entry and takes no
lock. hrtimer_forward() then operates on an already requeued timer:
it warns and, in the worst case, rewrites the expiry of an enqueued
timer without the base lock.

Convert the timer to the expiry injecting callback variant. The
callback returns the forward request instead of applying it, and the
hrtimer core applies it under the timer base lock. If a concurrent
start requeued the timer while the callback ran, the core discards
the callback's restart request and the start wins, which closes the
park/unpark race without adding any locking to the sampling path.

No functional change in the common case: the timer still forwards by
PERIOD past the sampling timestamp.

Assisted-by: claude-code:claude-fable-5
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/gpu/drm/i915/i915_pmu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index 1c3bafda9c708..c18587e200c9f 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -502,7 +502,8 @@ frequency_sample(struct intel_gt *gt, unsigned int period_ns)
 	intel_gt_pm_put_async(gt, wakeref);
 }
 
-static enum hrtimer_restart i915_sample(struct hrtimer *hrtimer)
+static enum hrtimer_restart i915_sample(struct hrtimer *hrtimer, ktime_t expires,
+					struct hrtimer_forward_args *fwd)
 {
 	struct i915_pmu *pmu = container_of(hrtimer, struct i915_pmu, timer);
 	struct drm_i915_private *i915 = pmu_to_i915(pmu);
@@ -533,7 +534,8 @@ static enum hrtimer_restart i915_sample(struct hrtimer *hrtimer)
 		frequency_sample(gt, period_ns);
 	}
 
-	hrtimer_forward(hrtimer, now, ns_to_ktime(PERIOD));
+	fwd->now = now;
+	fwd->interval = ns_to_ktime(PERIOD);
 
 	return HRTIMER_RESTART;
 }
@@ -1157,7 +1159,7 @@ void i915_pmu_register(struct drm_i915_private *i915)
 	int ret = -ENOMEM;
 
 	spin_lock_init(&pmu->lock);
-	hrtimer_setup(&pmu->timer, i915_sample, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_setup_ext(&pmu->timer, i915_sample, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	init_rc6(pmu);
 
 	if (IS_DGFX(i915)) {

-- 
2.51.2


