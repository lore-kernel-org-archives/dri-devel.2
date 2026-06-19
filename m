Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051BDCD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3099710E079;
	Fri, 19 Jun 2026 12:18:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TtUji9cJ";
	dkim-atps=neutral
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A84E310E079
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:18:28 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-3997a448ecbso17002431fa.0
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 05:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781871507; x=1782476307; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dLZ+pCnD0P0yEjXHP7s+d0OIOgshDvs2k5lhyVXVghQ=;
 b=TtUji9cJqns1GVmodR3q+XjhI/mpybhPXKxTQBaT5s3lX9Vz+aMhA4LRylJph1w6cz
 yoJpF3UjL8SZlUWiazRvDvENqNDXBXjJwR/uarKYqw5Mo5Nt1KgRl/THBv86BFIA0glE
 Tmsc4WR8c562yQuyy5LFhClZ7rwV3mBX6UiGlofZGTqyko91iuif9ldzV1xz/DStB0yC
 MSToQV6ZXUDEuMd37lqiZbemaPf69mHcMPZPJ7q0DG/WhipqkB3CSKqFBhs6M/ck9orv
 gc8ZY/1tSatOfLOQguyfAvV4O6qa7zULp62bb4yh7vT6dnKy3k3A9U9ajQtkBffMu5dT
 2rJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781871507; x=1782476307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dLZ+pCnD0P0yEjXHP7s+d0OIOgshDvs2k5lhyVXVghQ=;
 b=hpJRSvLCZ2qQ93eNL1eKL94r46GVfJFJv+AJWJYoxiwPL4A34EDa5C6qpRxN15heHx
 r8MkXrq43RtxG/+7Iou17W34CXTVpt9/ptHpVrnpK+01L+YTzLU+iafYp4RuFRvW7yHD
 ZSaNDqvxksasOTellqFZrpmwYIAUJj9wPLsibEWUpvJKIPzbXkN/Vo47w0NskALFrdf/
 zlTONDIlkbw/WDKa1q3X1MB1m87D7+r0+YFBiCA1DmWrtEhw0kEkqyDZLmWnIlrrv36s
 v9+m17TMaA3UGYHEz0JYCwxNbAq9dv70Q0V6IiuZTYyknIj0rbJsD79uEJNQnxM2D354
 HlFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+9Pq4iyrdk/6WkEMhBL8uBdYczgKVX5aRdAPWiu+RIJJXmB+13uSAvgygpVJvYRmLCHHdc56rZG4Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1XU8Zt7y1llk57rfA/Hgu+zoAKLooSD8AM57TUeaiv7xezAUq
 B59dvYlqKjhBpU9rWmQBXxcQpa/whqSZwqD8DbGmKRcFPBK7skimnta+
X-Gm-Gg: AfdE7cm6NMZ6709heGSS5aYac/ugP87dU/loH5d4XfPOYPMFrdy3gdDXiYB5cNXuYIz
 F0FbPUWvhJIle6J+gH/sjnIH6S+OBte36tQD5nIqTa+S1zczGxvBSZ5v1VRQJ0aJKE/4WbfOh1H
 EcydlzOYGxwG4BD7K8xClXZ/2Wq7lger2IT5GS0KGO+4zWL7PkYLt9ijGaPSrxDs1j6GUVxNW1p
 ++Vkb1hfbBRjTS83AR9rlJAJBmVPIGQDc8BShv2x8HGkYCB8gcUwsWhNR82lEUM/WaRZt2UJEp+
 PO4YVZY/BVzdONBXKQQqPTvhB9FXQm+Mr6XKO1gn1SDX7ZC1BZhkji6wFGWhZZX2TVsiuckcBFX
 I3AcD1xDOKTU1tHtgu+np9G7jzoj2YF52S3Fz9so/bCEGlyUwJEq9fWZXEtI40R/YiiCLE1d722
 f6/AE/xALtSKrvaF567LsZdQ==
X-Received: by 2002:a05:651c:211f:b0:399:1fbd:8f2f with SMTP id
 38308e7fff4ca-3998bd06f64mr8439831fa.9.1781871506548; 
 Fri, 19 Jun 2026 05:18:26 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3998beca743sm4598331fa.5.2026.06.19.05.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 05:18:24 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: do not enter fs_reclaim under notifier_lock
 in lockdep training
Date: Fri, 19 Jun 2026 17:18:18 +0500
Message-ID: <20260619121819.189293-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cbc54f68-b0bd-40ad-b5e7-ed8157128417@amd.com>
References: <cbc54f68-b0bd-40ad-b5e7-ed8157128417@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Makes sense, thanks. I won't respin this one then.

Vitaly, for the reorder, here is a deterministic reproducer so you can confirm
the splat on your side without a round-trip. It arms an mmu_interval_notifier
via GEM_USERPTR over anonymous memory, then forces reclaim of that exact range
with madvise(MADV_PAGEOUT), so amdgpu_hmm_invalidate_gfx() takes notifier_lock
under fs_reclaim in the calling thread. Needs CONFIG_PROVE_LOCKING and a fresh
boot; build/run notes are in the header. Happy to give Tested-by once you post.

// SPDX-License-Identifier: MIT
/*
 * amdgpu-notifier-reclaim-repro.c
 *
 * Deterministic reproducer for the false circular-locking-dependency splat
 * produced by drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c.
 *
 * amdgpu_lockdep_init() (run at module load) calls fs_reclaim_acquire()
 * while holding the dummy notifier_lock, teaching lockdep that it is legal
 * to enter reclaim with the MMU-notifier lock held. The real notifier lock
 * is taken in amdgpu_hmm_invalidate_gfx(), which mm/ calls from inside
 * reclaim, so the reverse edge fs_reclaim -> mmu_notifier -> notifier_lock
 * is mandatory. The cycle is closed the first time reclaim unmaps a page
 * covered by an amdgpu userptr interval notifier.
 *
 * This program installs such a notifier (GEM_USERPTR) over anonymous memory
 * and then forces synchronous reclaim of that exact range with
 * MADV_PAGEOUT, which runs try_to_unmap()->invalidate_range_start() with
 * fs_reclaim held in the calling thread, closing the loop on demand.
 *
 * Requirements:
 *   - kernel built with CONFIG_PROVE_LOCKING (lockdep)
 *   - amdgpu loaded; run from a FRESH boot (the first lockdep splat of any
 *     kind calls debug_locks_off() and silences all later reports)
 *
 * Build:  cc -O2 -o repro amdgpu-notifier-reclaim-repro.c
 * Run:    ./repro                 # picks the first amdgpu render node
 *         ./repro /dev/dri/renderD129
 * Watch:  sudo dmesg -w
 */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <dirent.h>
#include <sys/ioctl.h>
#include <sys/mman.h>

/* --- minimal amdgpu uapi (self-contained, no libdrm needed) ----------- */
#ifndef DRM_IOCTL_BASE
#define DRM_IOCTL_BASE 'd'
#endif
#define DRM_COMMAND_BASE 0x40
#define DRM_AMDGPU_GEM_USERPTR 0x11

struct drm_amdgpu_gem_userptr {
	uint64_t addr;
	uint64_t size;
	uint32_t flags;
	uint32_t handle;
};

#define DRM_IOCTL_AMDGPU_GEM_USERPTR \
	_IOWR(DRM_IOCTL_BASE, DRM_COMMAND_BASE + DRM_AMDGPU_GEM_USERPTR, \
	      struct drm_amdgpu_gem_userptr)

#define AMDGPU_GEM_USERPTR_READONLY (1 << 0)
#define AMDGPU_GEM_USERPTR_ANONONLY (1 << 1)
#define AMDGPU_GEM_USERPTR_VALIDATE (1 << 2)
#define AMDGPU_GEM_USERPTR_REGISTER (1 << 3)

#ifndef MADV_PAGEOUT
#define MADV_PAGEOUT 21
#endif

/* ------------------------------------------------------------ */

#define BUF_SIZE (64ull * 1024 * 1024) /* 64 MiB, page aligned by mmap */

static int open_amdgpu_render(const char *forced)
{
	if (forced) {
		int fd = open(forced, O_RDWR | O_CLOEXEC);
		if (fd < 0)
			perror(forced);
		return fd;
	}

	/* try renderD128..renderD143 and keep the first that accepts GEM_USERPTR */
	for (int i = 128; i < 144; i++) {
		char path[64];
		snprintf(path, sizeof(path), "/dev/dri/renderD%d", i);
		int fd = open(path, O_RDWR | O_CLOEXEC);
		if (fd < 0)
			continue;

		/* probe: a zero-size userptr returns -EINVAL on amdgpu but
		 * -ENOTTY/-ENODEV on a non-amdgpu driver, which lets us tell
		 * the nodes apart without pulling in libdrm version ioctls. */
		struct drm_amdgpu_gem_userptr probe = { 0 };
		errno = 0;
		ioctl(fd, DRM_IOCTL_AMDGPU_GEM_USERPTR, &probe);
		if (errno == ENOTTY || errno == ENODEV || errno == EOPNOTSUPP) {
			close(fd);
			continue;
		}
		fprintf(stderr, "using %s\n", path);
		return fd;
	}
	fprintf(stderr, "no amdgpu render node found under /dev/dri\n");
	return -1;
}

int main(int argc, char **argv)
{
	int fd = open_amdgpu_render(argc > 1 ? argv[1] : NULL);
	if (fd < 0)
		return 1;

	/* anonymous, private, page-aligned region for the userptr */
	void *buf = mmap(NULL, BUF_SIZE, PROT_READ | PROT_WRITE,
			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	if (buf == MAP_FAILED) {
		perror("mmap");
		return 1;
	}
	memset(buf, 0xa5, BUF_SIZE); /* fault every page in */

	/* REGISTER installs the mmu_interval_notifier (amdgpu_hmm_register());
	 * VALIDATE additionally faults the pages via hmm_range_fault() and
	 * binds them into GTT. ANONONLY matches our MAP_ANONYMOUS region. */
	struct drm_amdgpu_gem_userptr up = {
		.addr  = (uint64_t)(uintptr_t)buf,
		.size  = BUF_SIZE,
		.flags = AMDGPU_GEM_USERPTR_ANONONLY |
			 AMDGPU_GEM_USERPTR_REGISTER |
			 AMDGPU_GEM_USERPTR_VALIDATE,
	};
	if (ioctl(fd, DRM_IOCTL_AMDGPU_GEM_USERPTR, &up)) {
		perror("GEM_USERPTR (VALIDATE)");
		/* retry without VALIDATE: the notifier is still registered, the
		 * pages are present from the memset, MADV_PAGEOUT still works */
		up.flags = AMDGPU_GEM_USERPTR_ANONONLY |
			   AMDGPU_GEM_USERPTR_REGISTER;
		if (ioctl(fd, DRM_IOCTL_AMDGPU_GEM_USERPTR, &up)) {
			perror("GEM_USERPTR (REGISTER)");
			return 1;
		}
	}
	fprintf(stderr, "userptr handle=%u, interval notifier armed over %p..%p\n",
		up.handle, buf, (char *)buf + BUF_SIZE);

	/* Force synchronous reclaim of the notifier-covered range. MADV_PAGEOUT
	 * runs shrink_folio_list()->try_to_unmap()->invalidate_range_start()
	 * with fs_reclaim held in THIS thread, so amdgpu_hmm_invalidate_gfx()
	 * takes notifier_lock under fs_reclaim and lockdep closes the cycle.
	 *
	 * A few iterations (re-touching in between) cover the race where pages
	 * are already paged out on the first pass. */
	for (int it = 0; it < 8; it++) {
		if (madvise(buf, BUF_SIZE, MADV_PAGEOUT))
			perror("madvise(MADV_PAGEOUT)");
		usleep(50 * 1000);
		memset(buf, 0xa5, BUF_SIZE); /* fault back in for the next pass */
	}

	fprintf(stderr,
		"done: check dmesg for "
		"\"possible circular locking dependency\" / amdgpu_hmm_invalidate_gfx\n");

	munmap(buf, BUF_SIZE);
	close(fd);
	return 0;
}
