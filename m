Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834D8CA5FEF
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 15:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 766A310E0F1;
	Sun,  4 Oct 2026 15:42:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="PuwKzbBE";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E26910E037
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 15:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:From:Reply-To;
 bh=L60KS9Ryu+GB36HOKga7+1ueNpBsI+HF/UyX6K3kFl8=; b=PuwKzbBEwBj9zyZta4OrGlYUCc
 DqJE7jYlAMJvMTWxNloekg9S0giRzRKtoHdr2GzGqzR5nodlNR4r3zZFfWUD7/m++iJniPqgIP5T3
 YOFy7p8N+G+o2pqsWc6QVFMJSfmDMTlvgAwX8aQi/lw4JnFlnzi1n8sgrtGsTqyf/vfIADi++NId5
 nqBPlWl2kGrtMalo4DPahZ3rUYpRtO3Xc8P4GhIzsAIPqw1guml19SpHnHTm3PIlwov3HnKAoZH3Z
 m8J/oJW+8WoJpNU6DnHnjqqgoGle5STqkMayz3yZ/EKEo69CGKKYPcZKmN+m6cYDkf5fYQ2oyntsN
 SpWnU45w==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xDOLy-00BNsh-Ul; Sun, 04 Oct 2026 17:42:19 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH 00/11] drm/vc4: Split and shrink job_lock
Date: Sun, 04 Oct 2026 12:42:00 -0300
Message-Id: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3LSQqAMAxA0atI1gba1AG8irjQGjULBxooQundL
 S4fn59AOQgrDFWCwFFU7qvA1hX4Y752RlmLgQx11hjC6Bs8RT1u8rIiLc66jmhrewNlegL/oTz
 jlPMHhy3PPmAAAAA=
X-Change-ID: 20261002-vc4-misc-fixes-2b313622f570
To: Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3322; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=aUADTcKS+xQ06Hol6yU6grYroQAHjK9vM9/jrlC4Q64=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqwnPQYSaB+7vhI+yFd9qBAlNhi3sx7j8xPR9Jf
 /xMyTxc0aSJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCasJz0AAKCRA/8w6Kdoj6
 qn5SCADGk2skLJufTw0nE/WLUC9o4F3xd36qUJMRgwpV+NQ182zNupm/IQn8qShfRI8rTVlxB2E
 TOjp/j+sz2joF46amwyDHPlUOAOMIQhTwHqFnycoBnaX7UJ1smEbV/4kViopHb+dn+e4quQbZj7
 SWsm7hnNqNGFDzc666fDucx9OBMnwM6CAdO2h06pl/W3FyfB+3MrNUtX/8tIaG+qBrMKbzX8XYq
 WTEYx/+8JtTt+HHSPWgq2GwORbR7LQuJb8DxkD3bgD35nD3iSSXaXwv4awy8XOLj0w8CCYm3fgu
 4o2d2nmgHDAajwOcRIn0J7yg+kECEwzJcpXlbv8Ts2IromIW
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

vc4->job_lock is a device-wide spinlock taken by the V3D interrupt handler,
so everything under it runs with interrupts disabled. It currently
protects several unrelated things: job queues, the binner slot pool, the
saved hang state, the active perfmon, the attachment of the job fence to
every BO, and more.

This series aims to (1) split vc4->job_lock into multiple independent locks
and (2) shrinks its critical sections when possible.

In particular, the series address four current issues:

  1. drm_syncobj_replace_fence() runs under job_lock, which lockdep reports
     as an IRQ lock inversion.

  2. drm_exec_fini() runs under it as well and reaches kvfree(), which asks
     for preemptible task context.

  3. VC4_SUBMIT_CL re-reads vc4->emit_seqno after dropping the lock, so a
     concurrent submission makes the ioctl return another job's seqno.

  4. The perfmon counters are copied to userspace with no lock held.

The rest of series does a series of changes to move work out of job_lock
and reduce contention.

On a Raspberry Pi 3B+ running `glmark2-wayland --off-screen`, lock_stat
shows job_lock contentions reduced by 90% (2093 -> 207 per run) and total
wait time by 96% (14.7 ms -> 0.6 ms). The longest job_lock hold, during
which interrupts are disabled, drops from 747 us to 27 us, as the render
done handler no longer signals fences under the lock. The workload is
GPU-bound, so the glmark2 score is unchanged (239.6 vs 240.2) [1].

About 99k acquisitions per run move off job_lock onto the per-fence locks,
and 185k more onto bin_alloc_lock, with little contention on either.

Considering that glmark2 is a GPU-bound client, it's important to notice
that contention improvements might be higher with several clients or a
CPU-bound workload, which I did not measure.

This series applies on top of "drm/vc4: Fix binner slot allocation failing
on an idle GPU" [2].

[1] `glmark2-wayland --off-screen` scores are the mean of 5 runs per kernel
without CONFIG_LOCK_STAT enabled. The lock data is the mean of 3 runs from
CONFIG_LOCK_STAT builds.

[2] https://lore.kernel.org/dri-devel/20260930182204.1877361-1-mcanal@igalia.com/T/

Best regards,
- Maíra

---
Maíra Canal (11):
      drm/vc4: Publish the output fence outside of job_lock
      drm/vc4: Drop the BO reservations outside of job_lock
      drm/vc4: Refcount vc4_exec_info
      drm/vc4: Return the seqno of the submitted job
      drm/vc4: Attach the job fences outside of job_lock
      drm/vc4: Use the inline fence lock
      drm/vc4: Signal the render fence outside of job_lock
      drm/vc4: Take job_lock only once to drain job_done_list
      drm/vc4: Protect perfmon state with a dedicated lock
      drm/vc4: Protect the hang state with a dedicated lock
      drm/vc4: Split out bin_alloc_lock

 drivers/gpu/drm/vc4/vc4_drv.h     |  20 +++++--
 drivers/gpu/drm/vc4/vc4_gem.c     | 106 +++++++++++++++++++-------------------
 drivers/gpu/drm/vc4/vc4_irq.c     |  80 ++++++++++++++++------------
 drivers/gpu/drm/vc4/vc4_perfmon.c |  40 +++++++++-----
 drivers/gpu/drm/vc4/vc4_v3d.c     |   2 +-
 5 files changed, 146 insertions(+), 102 deletions(-)
---
base-commit: 64eded63d88ea70466c57cf433761bb1efea37a4
change-id: 20261002-vc4-misc-fixes-2b313622f570

