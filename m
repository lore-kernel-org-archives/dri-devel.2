Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D77C44500
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73DC210E467;
	Tue,  7 Jul 2026 07:33:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S3cJlJ3i";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCA3E10E467
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:33:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 613CB618AE;
 Tue,  7 Jul 2026 07:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA881F00A3D;
 Tue,  7 Jul 2026 07:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783409600;
 bh=LQcRDmNWbRAXD/TCfpuEmVOi3+A7MRg8kYEdwNmXc1E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S3cJlJ3iouB7Z6ojGsVKgLqcqwGPkp3Jy1uXU1U1IKX5tE7sNZ0O7RxFTlyFh7SwO
 6nPinlpFUbzE1P6i+gkaLAfLN4CNUkX5xjjaOcuGKv+sfI0J5wumQ+v9wWXuscUcgU
 ko0IIIneizm7Ib48e6ZKYBDYWMXa8LJ1fQuYBDnq/cNqLv5EzED9GAXpoCeIJispSI
 scyNRCIEcmu7LIqkf5UmLD+Z4hxtLns2Zshh50EoT0MXGAc2sC4z8wRmi2OA2oKvG/
 OkLDUvWRIPv4/8aR7PdRQjqJJ3hOx+0/AdrXGZvc2HGIY6p9hWYmPT8WJ+mXcWSW8e
 XBUiQFBrHT0Uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 08/40] dept: add a mechanism to refill the internal
 memory pools on running out
To: "Byungchul Park" <byungchul@sk.com>
Cc: "Chuck Lever" <cel@kernel.org>, tytso@mit.edu,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-rt-devel@lists.linux.dev, "Jeff
 Layton" <jlayton@kernel.org>, cassel@kernel.org,
 "Anna Schumaker" <anna@kernel.org>, dlemoal@kernel.org, ojeda@kernel.org,
 linux-ide@vger.kernel.org
In-Reply-To: <20260706061928.66713-9-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-9-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:19 +0000
Message-Id: <20260707073320.3EA881F00A3D@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Per-CPU object pools (`lpool`) grow unboundedly because objects ar=
e never returned to the global pool, leading to endless `vmalloc()` allocat=
ions and potential OOM.
- [High] Un-ratelimited printk in the pool exhaustion path causes console f=
looding and soft lockups.
--

(Note: The format of this report is altered to use a free-form summary rath=
er=20
than inline diff quotes due to recitation restrictions.)

commit 0f35ff40c325e46d2d4adab446907928b805d0e5
Author: Byungchul Park <byungchul@sk.com>

dept: add a mechanism to refill the internal memory pools on running out

This commit introduces a mechanism to dynamically refill internal memory
pools for the DEPT engine using an IRQ work and workqueue. It adds per-CPU
local pools and a vmalloc-based refill path when the static pools are
exhausted.

[Severity: High]
Could the per-CPU local pools (lpool) grow without bounds under certain
workloads?

Looking at to_pool() and from_pool() in kernel/dependency/dept.c, objects
are unconditionally added to the per-CPU lpool without any upper bound
check or reclaim logic. If a task allocates an object (like ecxt or wait)
on CPU A, migrates to CPU B, and frees it, the object goes into CPU B's
lpool.

Because objects are never returned to the global spool when the lpool grows
large, the global pool will eventually drain. When from_pool() sees an
empty global pool, it triggers request_rpool_refill(), which allocates new
memory via vmalloc() in dept_wq_work_fn().

Will continuous cross-CPU allocation and freeing indefinitely leak memory
into local pools and repeatedly trigger vmalloc allocations, potentially
leading to an out-of-memory condition?

[Severity: High]
Is it safe to use an un-ratelimited printk in the pool exhaustion path?

In kernel/dependency/dept.c:from_pool(), when a pool is exhausted, the
code calls DEPT_INFO() (which maps to pr_warn()) to notify the user. This
happens with hardware interrupts disabled via dept_enter().

Because the pool refill in dept_wq_work_fn() happens asynchronously in a
workqueue, the pool will remain empty until the workqueue runs. Every
subsequent lock acquisition during this window will synchronously print a
multi-line message to the console.

Could this flood the console and cause soft lockups or RCU stalls since
thousands of locks might be acquired by a single thread while waiting for
the async workqueue to execute?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D8
