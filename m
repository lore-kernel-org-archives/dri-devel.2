Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7927C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 19:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 491D310E5F3;
	Thu, 23 Jul 2026 19:43:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="jt1hjRD3";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A6C210E5EB;
 Thu, 23 Jul 2026 19:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=vxPPDPx23L2aSrkxRbLvlcg96Db0ka/k1js9TlhAo4I=; b=jt1hjRD3Fg1oiNZKN8ObM92PVU
 lMqFoYC5xpsp4OVRi16BK1K+P0wjUQB7faazUVgMes1XPwuBjkktptOvPB8sWsPbOtlsBrGM/IUc6
 xHBligOTXmB/ZpcxrN6zPH5lyhz0EP70iZtvll4Wn955QcsZ86cSJOWtYgrPjN2l3AMY34y67QuIG
 Lpyzzqn4ysXWWrjSVvej/gv2qwKGd3e+qyVdPNQJE47KTY/c1jo9dIk0TqWRsAmtXpB0Vm1oWzgZC
 U8r89REW3pOVTe7MpQt/z3ch0Tp4WxvJgffDZEmylSXw5vdfHT5m2ytIn2nUa5IYWD06Nnq3tvVP3
 cGALxGJA==;
Received: from 179-125-91-91-dinamico.pombonet.net.br ([179.125.91.91]
 helo=quatroqueijos.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wmzKH-003a1P-1z; Thu, 23 Jul 2026 21:43:25 +0200
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
Subject: [PATCH i-g-t v5 0/7] add cgroup_dmem test
Date: Thu, 23 Jul 2026 16:43:06 -0300
Message-ID: <20260723194313.2748143-1-cascardo@igalia.com>
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

v5 TLDR:
Removing creation of VM on Xe and removing USAGE_SLACK.

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

Latest tests for amdgpu used patchset at [9] on top of v7.2-rc3.

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

Compared to v3 of this one [7]:

- Merge dmem_cgroups tests into cgroup_dmem and making cgroup_dmem original
  test a subtest.
- Remove assertion when trying to verify allocations have failed as amdgpu
  will fallback to GTT.

Compared to v4 of this one [8]:
- Removed the creation of vm in Xe, that was leading to extra bytes being
  used and was no longer necessary.
- Removed the USAGE_SLACK that was necessary due to the extra bytes
  allocated due to the use of vm in Xe.

[1] https://patchwork.freedesktop.org/series/163935/#rev3
[2] https://patchwork.freedesktop.org/series/166496/
[3] https://lore.kernel.org/dri-devel/20260611173301.17473-1-thomas.hellstrom@linux.intel.com/
[4] https://gitlab.freedesktop.org/cascardo/igt-gpu-tools/-/commits/dmem_max?ref_type=heads
[5] 502d801f0ab0 ("Merge tag 'erofs-for-7.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs")
[6] https://lore.kernel.org/dri-devel/20260623174319.4138648-1-cascardo@igalia.com/
[7] https://lore.kernel.org/dri-devel/20260702130108.1397444-1-cascardo@igalia.com/
[8] https://lore.kernel.org/dri-devel/20260717120447.1837818-1-cascardo@igalia.com/
[9] https://lore.kernel.org/dri-devel/20260703130541.2686-1-thomas.hellstrom@linux.intel.com/


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
 lib/xe/xe_dmem.c        | 139 +++++++++
 lib/xe/xe_query.c       |  32 ++
 lib/xe/xe_query.h       |   2 +
 tests/cgroup_dmem.c     | 332 +++++++++++++++++++++
 tests/meson.build       |   1 +
 13 files changed, 1355 insertions(+)
 create mode 100644 lib/amdgpu/amd_dmem.c
 create mode 100644 lib/igt_cgroup.c
 create mode 100644 lib/igt_cgroup.h
 create mode 100644 lib/igt_dmem_driver.h
 create mode 100644 lib/xe/xe_dmem.c
 create mode 100644 tests/cgroup_dmem.c

-- 
2.47.3

