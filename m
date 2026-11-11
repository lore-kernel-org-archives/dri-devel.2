Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB12660A5BCB
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=kcRSOaS5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EA6710E409;
	Wed, 11 Nov 2026 15:05:38 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB2DA10E409
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:From:Reply-To;
 bh=r/tQe1r/9Kq6Wve/p13yf9ltV8xT67RnBFbWL9WrR3E=; t=1794409531; x=2109769531; 
 b=kcRSOaS54wQ7oW8v4mIgfCSBu5E8fYppzdAjmJWwWQj39wQZ69XVb20Rn9nOVIu8L+0RNGJyQ6R
 nj8BDjIwS2FbY0dciVz1tVQVey6GAfSU4fCLsSyiroEJkw/sp+xSO+7kxDM2uYZx8sdtAiuYQoxEf
 dyurXyQUOER3bZZwm2HY2ru+Bfw3VekO7zoqoxg1MOV5nWiz4Rg3hqxRwve1fJdNlMz8UsSK8Cerb
 gE8RDscvQnLxT/hS4jXX5hn9Vd2m1lzR2sK8Czs3VIFaerQqVldEcxS0VGlK7NrLiiz/exTa9LDGX
 wEUYAxkB6BoFUHl/s0iBe8kp7QBpuqsYQG/A==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xR9t9-008sMR-UV; Wed, 11 Nov 2026 16:05:28 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH v2 0/4] drm/vc4: Fix the V3D interrupt state across power
 transitions
Date: Wed, 11 Nov 2026 12:05:18 -0300
Message-Id: <20261111-vc4-irq-cleanup-v2-0-aa757bb742f2@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNQQ6CMBBFr0Jm7RjaSq2svIdhUcsAkyDFVhsN4
 e5WElcu30v++wtECkwR6mKBQIkj+ymD3BXgBjv1hNxmBllKXRqhMbkDcrijG8lOzxmNVaYVuqu
 sqiCv5kAdv7bipck8cHz48N4OkvjaX+v410oCSyTSrjrJqzJKn7m3I9u98zdo1nX9ACV442GvA
 AAA
X-Change-ID: 20260816-vc4-irq-cleanup-8a38d16f5a35
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Iago Toral <itoral@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2491; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=NOeC66MW0Wm90Hq2rSrJnEYOG6lxdv7eWfSB7pjN2Fs=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq9IQ1pVe1ZKdYnIGBijFnq/BOQYndh3pGU7/no
 qnE1Lp361WJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCavSENQAKCRA/8w6Kdoj6
 qhc/B/9lyICmtkVBCuR07T/260t1jENvbGQ1xjJPxxPYFjGnJMNlUMfuyt9w3e/1AQ38p0+59Ct
 CxYqCurHJKY0ruLBNW3iRwH89bCti0xuVKoQFuPjnb4NzX8x9ouXTUhYa4G4oMVWnyJFnaWr79l
 Df4FLkka7V0YheudtlLSdBbc0IS/A5VyX8nEg41Ze5EZ5Nt9Pi2vOlJZASqlAgrFk6B6mN43jpx
 fIGDYS7KvO2G0ClKGFqvfH1F/NALChkwoQOGZq93Js19bJDC5wequZhEAD/Q9imGzCz3HYMZwJx
 xm3HwQUXmrBMnIZPsGYeTIIQ4pfkixm20LbQyq8jKUHqB7va
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The V3D block is runtime suspended whenever it goes idle, and the driver
does not fully restore its interrupt state on the way back up. This series
fixes the paths that lose that state, or that touch V3D registers while
the block is powered down.

PATCH 1 takes a runtime PM reference around the binner BO allocation.
vc4_create_bo_ioctl() reaches bin_bo_alloc() without powering the block
up, so its write to V3D_INTENA can land on a suspended device.

PATCH 2 rebuilds the interrupt mask on every resume. The out-of-memory
interrupt was armed once, when the binner BO was allocated, and masked on
every suspend, so an overflow after an autosuspend raised nothing and the
binner stalled until the hangcheck. vc4_irq_enable() now derives that bit
from whether a binner BO exists, and vc4_irq_reset() goes through it.

PATCH 3 re-enables the IRQ line after a GPU reset. vc4_reset() disables
it through vc4_irq_disable() and nothing enables it again, so after the
first hang, jobs only retire through hangcheck resets. This is a v7.4-rc1
regression and relies on PATCH 2.

PATCH 4 is a small clean-up for drm-misc-next.

Let me know your thoughts.

Best regards,
- Maíra

---
v1 -> v2: https://lore.kernel.org/r/20260817-vc4-irq-cleanup-v1-0-ee6c592b3836@igalia.com

- Rebased on drm-misc-fixes, which now carries the reset controller series.
- Dropped "drm/vc4: Bound the wait for a binner slot in the overflow work",
  superseded by commit cca01232d94a ("drm/vc4: Fix binner slot allocation
  failing on an idle GPU").
- Dropped "drm/vc4: Hold a runtime PM reference in the binner overflow
  work", as vc4_v3d_runtime_suspend() already drains the work before
  powering down.
- Dropped "drm/vc4: Let runtime PM tear the V3D down at unbind".
- New patch: "drm/vc4: Re-enable the V3D interrupt after a GPU reset".

---
Maíra Canal (4):
      drm/vc4: Hold a runtime PM reference while allocating the binner BO
      drm/vc4: Rebuild the V3D interrupt mask on every power transition
      drm/vc4: Re-enable the V3D interrupt after a GPU reset
      drm/vc4: Take the IRQ number from vc4_dev in vc4_irq_install()

 drivers/gpu/drm/vc4/vc4_drv.h |  2 +-
 drivers/gpu/drm/vc4/vc4_irq.c | 49 ++++++++++++++++++++++---------------------
 drivers/gpu/drm/vc4/vc4_v3d.c | 10 ++++++---
 3 files changed, 33 insertions(+), 28 deletions(-)
---
base-commit: 8bf8cda54c08ee3693f4dd1e2b7607fe5e466c79
change-id: 20260816-vc4-irq-cleanup-8a38d16f5a35

