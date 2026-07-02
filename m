Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E436BC43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42A3510F35C;
	Thu,  2 Jul 2026 13:01:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="rS6IE0DH";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7990D10E4E7;
 Thu,  2 Jul 2026 13:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HAXYzsPcNYY9Q8dQYe8XBPgchSJ1FXkCry5jFDXeHic=; b=rS6IE0DHe0x4Z8dxgn7Wt2oQ+q
 5azPsgzojcn0FuIdaZSVXizcUfiHF+dYZ0jQZJnEi5WqV+2T8UHKCgTNNQJjda3Fnqdbk12yzD8qV
 v0ozrEKN2MUdzfyEE5igDs4oS+EaVXTFbeq4vtzLYITPVi6uxGo8Nk4r2bf+KXdqwgq4/JRi9PJbj
 fc1Hc0KkjGAs8jGXhA0ygtYVnIdU9ysB7eJBN0Dv5AhsIXePcEFQumKIE4i3m63BnilrW7dbprHfd
 oFPO+2kTE9aiFTp9dA7UXWGR12D1HAouErhUViWcFjPtl00Ddoq0EgScbkMYqhteGaM0/VCSVzgtg
 RgBW8a7w==;
Received: from [179.125.94.247] (helo=quatroqueijos.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wfH32-0082Ji-4u; Thu, 02 Jul 2026 15:01:44 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: igt-dev@lists.freedesktop.org
Cc: siqueira@igalia.com, Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>,
 maarten.lankhorst@linux.intel.com,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, kernel-dev@igalia.com
Subject: [PATCH i-g-t v3 0/7] add dmem_cgroups test
Date: Thu,  2 Jul 2026 10:00:51 -0300
Message-ID: <20260702130108.1397444-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

v3 TLDR:
Sending again for fixes when running on top of Xe.

This patchset is based on the work of Thomas Hellström at [1] and a
followup I have submitted at [2]. This is now a v3, since I submitted [6].

With this version, I reverted the order in which to apply the patchsets, as
this one adds the infrastructure and the drivers mechanisms, and a test for
dmem.current and its behavior around dmem.max that is currently supported
in the kernel.

As for the new dmem.max eviction behavior, introduced by [3], it has been
pushed to a branch at [4]. If preferred, I can submit the two patches
independently.

I have run the tests, including the ones that test dmem.max eviction
behavior on a system with a 1GiB VRAM amdgpu card. Rodrigo Siqueira helped
me run it on a Xe system. We have applied the patchset at [3] on top of
current linux origin/master [5], with a fixup for the amdgpu driver.

Now, for the changes since v1 [2]:
- Changed the test name from drv_dmem_cgroups to dmem_cgroups.
- Have system includes before igt ones.
- Documented the current SUBTEST.
- Changed free_vram driver hook to only release a given BO. This allows for
  the eviction trigger by a new allocation added by write_eviction_nonblock
  subtest.
- Changed allocate_vram to keep more state necessary for releasing a single BO.
- Added a global free_vram helper to free all allocated VRAM.

Compared to v3 of [1]:
- I have kept wait_for_usage_drop as release can be lazy and we test for it
  on test_current SUBTEST, but had USAGE_DROP_TIMEOUT_MS be a little
  longer.
- Changed BO_SIZE and EVICT_STEP to allow for more than two eviction steps
  on a 1GiB VRAM system.
- Reduced USAGE_SLACK to avoid false positives, but still allow for some
  page table accounting.

Compared to v2 of this one [6]:

- Ignore -ENOMEM and -ENOSPC when trying to fill VRAM.
- When limiting max memory, allow for some slack, as there might be some
  overhead.
- On Xe, allocate GEM object with no deferred backing, and skip binding.

[1] https://patchwork.freedesktop.org/series/163935/#rev3
[2] https://patchwork.freedesktop.org/series/166496/
[3] https://lore.kernel.org/dri-devel/20260611173301.17473-1-thomas.hellstrom@linux.intel.com/
[4] https://gitlab.freedesktop.org/cascardo/igt-gpu-tools/-/commits/dmem_max?ref_type=heads
[5] 502d801f0ab0 ("Merge tag 'erofs-for-7.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs")
[6] https://lore.kernel.org/dri-devel/20260623174319.4138648-1-cascardo@igalia.com/


Thadeu Lima de Souza Cascardo (4):
  lib/xe: Introduce dmem driver and implement Xe support
  lib/amdgpu: add amdgpu_cgroup_region_name
  lib/amdgpu: add amdgpu support to igt_dmem_driver
  tests/dmem_cgroups: add test for dmem.current

Thomas Hellström (3):
  lib/igt_cgroup: add cgroup v2 and dmem controller helpers
  tests/cgroup_dmem: add dmem cgroup controller test
  lib/xe: add xe_cgroup_region_name() helper

 lib/amdgpu/amd_dmem.c   |  99 +++++++
 lib/amdgpu/amd_memory.c |  25 ++
 lib/amdgpu/amd_memory.h |   2 +
 lib/igt.h               |   1 +
 lib/igt_cgroup.c        | 638 ++++++++++++++++++++++++++++++++++++++++
 lib/igt_cgroup.h        |  56 ++++
 lib/igt_dmem_driver.h   |  25 ++
 lib/meson.build         |   3 +
 lib/xe/xe_dmem.c        | 143 +++++++++
 lib/xe/xe_query.c       |  32 ++
 lib/xe/xe_query.h       |   2 +
 tests/cgroup_dmem.c     |  92 ++++++
 tests/dmem_cgroups.c    | 245 +++++++++++++++
 tests/meson.build       |   2 +
 14 files changed, 1365 insertions(+)
 create mode 100644 lib/amdgpu/amd_dmem.c
 create mode 100644 lib/igt_cgroup.c
 create mode 100644 lib/igt_cgroup.h
 create mode 100644 lib/igt_dmem_driver.h
 create mode 100644 lib/xe/xe_dmem.c
 create mode 100644 tests/cgroup_dmem.c
 create mode 100644 tests/dmem_cgroups.c

-- 
2.47.3

