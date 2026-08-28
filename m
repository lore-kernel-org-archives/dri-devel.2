Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B74C624C2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F80310E68F;
	Mon, 31 Aug 2026 07:00:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ajdZag+y";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A89E10E4F6
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:58:05 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2d049069377so12152665ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 07:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787929085; x=1788533885; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1VfMpdC9MNUgJGJ712gixEQAXWsGGubkbIBW/Kf06N0=;
 b=ajdZag+ydavOY6qRF3haATDBqlxhiJ9e4jLGzcob7L2A4VPU+7AXeM15rTQ6Jj90La
 0n2r+9b7S7eROhaP0zZlMxx++NO2AGZh55gW+lbvs8Jt++bNokH1gHnYbNNdzyvZQ6Du
 xwgMVzj6xKdZvxZ+03E2P7xk7oYnVa1lpcy3veYW0XnGibloMTh+difrgLH+/ChRmi/j
 8Beb9irKDkxXDq2XnGBjHm5EY8w0MZqUN4zfJz9mQ8HlbeMO2hu431GOYyrEs3LDGKDd
 0/HXMHvIx/BpS7dPP/A4u61sB9XSAvqQ2HfyDpMc8Rvc75BwY7LiTe68wPHdynu4uH9v
 nJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787929085; x=1788533885;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1VfMpdC9MNUgJGJ712gixEQAXWsGGubkbIBW/Kf06N0=;
 b=g5NnVvghCErxl46hLzjZ2ZMV+8zilQ7fHapAYICY+iIyGy+f5KAr7mYQTKsxZOXhrA
 FKIp88GbkzGRgm0xckpcvozjwYCMtCEoDTCnYpKopqPJ4aHDQgq6HG24MF05cjAhlPt0
 +av0IQE+i3XSmxe0yzXV7+ZfMz8J2I2WOM4olQqWDzeoXIjJkXyMzbj5ubGQmly/Ii4Q
 Zx4BqETEsuPx6XZqCTGDKl3JTccfHqdQ0G/hJp6fiODztUMKB0jm3HYAJ1YIFk/Itjhq
 wMgBkbTwA94Wp9jkmdEs2E+39NnJo8neiYRF0Nv/vxWHkTwOq7whGdZMHuS+DD2BlZrf
 2aZA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGgaxDPdHipiRkd5W71pq4WVVNS3fjhqxYn7Gccs2IQFXrVM722KFIg0dTUv3uSariwibecO2rtmA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nNKHj7/RnTqh0yfPobzj7rACXhBvXz+6ql8YwB74ogmqwHK72q
 qyKuk6008snaNikD4x3lsv34leqKVxWCyqBxQp1xKW0NkKf0gOH4TzE=
X-Gm-Gg: AR+sD13yL9olepa7rjtxos2sAdtp6Spvj7fA0O3mlCzqdUhKIWHbVm/wXJ2hJSlqKU1
 PJSfh+tp+tvJJqDQ2eqZTRn3GFrtgIHRL2r2veT+yoSiGcIRch96HXrdgvQzg6i5rKFi8fwtwg5
 nQajP8XG334tZAc51NGux2dc9LiCvN8iBwDQ0MjVjVxyT99XyQkNvw+EMK1RZqClT6/Dm+5pddW
 +KOCUHuiNoYUAnLSP1FGV+Yuegy53noQWgcKSK/XbzoYLqwHTb0I1IIZP57APIbs8EmPKektbXV
 pZ/jtBDqQ5D9dhc6Eg538JfnuJ0I/lz6phptwTLbI6nMIU2CAJNVAcz7iSBO5skPZd70Tyz7Wsq
 pyQI53fmXdhmyq3zLWVTRdI2Ek+ZL/KsRanCyAWyMHqDF2SpXzF7lF0zWRWa5h3NlPML91PWVAy
 bmDPh/jXnNuuKWPcRsZn1VSlrZto0U4g6ZGa63Yo+3q1GgphU/v7kih8V/X3ZGXa1zgtkQROQyd
 WiNtNDALPbVUxM5J4v2XZC4/OESodYUy5COSA==
X-Received: by 2002:a17:903:3d06:b0:2d8:d4ce:9f34 with SMTP id
 d9443c01a7336-2d8d4cea3e9mr8380325ad.18.1787929084834; 
 Fri, 28 Aug 2026 07:58:04 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d75988b6fcsm6159625ad.56.2026.08.28.07.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:58:04 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
Subject: [PATCH v1 0/2] drm/sched: fix a use-after-free in get_timeline_name()
Date: Fri, 28 Aug 2026 23:57:55 +0900
Message-ID: <cover.1787928528.git.malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:00:03 +0000
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

This fixes an unprivileged use-after-free (read) in the DRM GPU scheduler
core, present in current mainline (v7.2-rc5) and reachable through at least
three in-tree drivers: amdxdna, nouveau and msm (VM_BIND).

drm_sched_fence_get_timeline_name() dereferences fence->sched->name, and
the fence is not ops-detached on signalling (the ops carry a .release
callback), so a userspace-held finished fence can outlive a per-context
drm_gpu_scheduler that a driver frees on context/fd teardown.
get_timeline_name() is reachable unprivileged via SYNC_IOC_FILE_INFO on an
exported sync_file, so this is a deterministic UAF read of the freed
scheduler - a bounded arbitrary kernel read once the slab is reclaimed
(there is no write primitive on this path).

It's the same bug class as CVE-2025-38703 (drm/xe) and CVE-2025-71302
(drm/panthor), which were fixed per-driver; the drivers above never got
the equivalent fix. Patch 1 fixes it in the core (cache the persistent
timeline-name pointer at fence init) so any per-context-scheduler driver is
covered. Patch 2 adds a KUnit regression test on the existing drm_sched
mock harness that catches the UAF under KASAN with no hardware.

Since the bug class is already public (the xe/panthor CVEs), I'm sending
this to the list directly rather than through the security process. It
looks like a candidate for stable backport.

The KUnit test was run with:

    ./tools/testing/kunit/kunit.py run --arch=x86_64 \
        --kunitconfig=<KUNIT + KASAN + DRM_SCHED_KUNIT_TEST> \
        'drm_sched_fence_uaf_tests*'

- without patch 1: KASAN slab-use-after-free in
  drm_sched_fence_get_timeline_name
- with patch 1: test passes, no KASAN report

Jonghyuk Kim(MalHyuk) (2):
  drm/sched: cache the timeline name to fix a use-after-free
  drm/sched/tests: add a UAF regression test for get_timeline_name()

 drivers/gpu/drm/scheduler/sched_fence.c       | 16 ++++-
 drivers/gpu/drm/scheduler/tests/tests_basic.c | 65 ++++++++++++++++++-
 include/drm/gpu_scheduler.h                   | 11 ++++
 3 files changed, 90 insertions(+), 2 deletions(-)

-- 
2.43.0

