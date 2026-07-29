Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27750C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 02:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F17410E61D;
	Wed, 29 Jul 2026 02:09:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="faN170J1";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D57D210E61D
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 02:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:From:Reply-To;
 bh=jQ3MEIzPVK1aM8W85E2IKoZrQwrN2eJRt2nDMRqmdfM=; b=faN170J1eEVrtZ75h0JxlZ5sD5
 cg4vNGLG6UOqSAyw/QKzhF2HdOwPsPdfGm6iggFq67/voP0sarhgXqhPiNYvHmjGoiNjVXxOUZl5t
 PKk8p19jgCdPmLWYWDLU9L8/v2dZAq8RiIVbQdw1WTjWC/+sx65l6l6ZXxxaMe987qMBmB4k9h8tz
 n57V2oGFnj9TuXMk3XsReeCjqt4MOu7Ei43ICd5KCQzzxiLcVZZfz6Jku88xc6yes0ln8O5bat1D9
 Fu1GcU1jngIgXTVwHw+z3xwqfKYyEmTb5w+fK4gaMGt9Mw3rLnCv7FQlMzyk53fLrt34IZXa4hThR
 COagbF9Q==;
Received: from [187.36.208.132] (helo=[192.168.1.221])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wotjd-007FxT-Sl; Wed, 29 Jul 2026 04:09:30 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/2] drm/v3d: Fix system freezes by serializing the GPU reset
Date: Tue, 28 Jul 2026 23:09:21 -0300
Message-Id: <20260728-v3d-order-global-reset-v1-0-e47be838158d@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqEMBBF0a1IjS2I8RNxK9ID03lqgRipNCKIe
 zf08AzuvSlBBYmG4ibFKUninlGVBX3XaV/AErLJGtsZZ3s+68BRA5SXLfppY0XCj52rO980LYz
 vKceHYpbrPx4/z/MCI7FdaWgAAAA=
X-Change-ID: 20260728-v3d-order-global-reset-7736b445e0b8
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1919; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=aoWCB7e23RflCVloo+41eZtueA7DFsV81XtQ7IdnGkk=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqaWDWwS8yF++ZdqPclBhFNySaMkOkfl94xX3No
 O7ur+3e3Y+JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCamlg1gAKCRA/8w6Kdoj6
 qhOcCACgGcIDqzKdSfhnJPmYf/uxigm5M+rk+kHwpCRjQn2AlF7GkxrVLoqMXctCL6OFLrmEjy9
 xBqVDhykQXMMiR2ICKek2eSpYmEz7XhOpMzmORoOQleLmtp5g0ufdKEO5B8UtFYD3ZxZnyaWAnZ
 vm8KtY7Sy3Rrt7PiJtIrV3aOGJfOQcx3jZGI3aEvvIjFSb05DIm8ZE5EHmWDOY0uTcVPbO23qV3
 SI+DMYwlCvYwa0gm9XL2H9PoDUMELd0iHIkq/2hlldqqLNkE42VcGP4yTH+lmfpU+zDWRZz3/id
 2nFd6NwYW5GWCHwxkj6xTbGaqd3CzHMey1K+IFDHIgdiL99j
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

V3D exposes several independent hardware queues, but it only has a single,
global reset. Therefore, when a job times out in one queue, the timeout
handler has to stop, reset and restart the schedulers of every other queue
as well. As each scheduler queues its timeout work on the system workqueue,
those handlers run concurrently and can interfere with each other.

This can be reproduced on a Raspberry Pi 4 or 5 by running glmark2-wayland,
which keeps the CL queues busy, while a second application triggers a GPU
reset in the CSD queue every 0.5 seconds. The failure is non-deterministic,
but it usually shows up after a dozen resets: the DRM scheduler warns about
a credit imbalance in one of the CL queues,

    WARNING: CPU: 2 PID: 43 at drivers/gpu/drm/scheduler/sched_main.c:102 drm_sched_run_job_work+0x238/0x4d0 [gpu_sched]

and, from that point on, the UI freezes and the machine is unusable.

The DRM scheduler already provides the synchronization that this kind of
hardware needs: an ordered workqueue passed as drm_sched_init()'s
@timeout_wq parameter, which guarantees that the timeout handlers of the
different schedulers are executed sequentially. Patch 1 gives all of the
V3D queues such a workqueue. Patch 2 removes `reset_lock`, which only
ever covered the driver's callback and is made redundant by the ordered
workqueue.

Only patch 1 is Cc'ed to stable, in order to keep the backport minimal.

Best regards,
- Maíra

---
Maíra Canal (2):
      drm/v3d: Serialize the scheduler timeout handlers
      drm/v3d: Remove the now-redundant reset lock

 drivers/gpu/drm/v3d/v3d_drv.h   |  8 ++++----
 drivers/gpu/drm/v3d/v3d_gem.c   |  3 ---
 drivers/gpu/drm/v3d/v3d_sched.c | 13 ++++++++-----
 3 files changed, 12 insertions(+), 12 deletions(-)
---
base-commit: 48a570c964d8e37d353381e4195106277e17f5cb
change-id: 20260728-v3d-order-global-reset-7736b445e0b8

