Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03543C98311
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18E6610F1A3;
	Wed, 23 Sep 2026 20:44:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Lk4YdGJ0";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0DC410F1A2;
 Wed, 23 Sep 2026 20:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:From:Reply-To;
 bh=HdUz0zne8odeFw2HiyHUB4/tMjq35wYkxHxy0r1qMXk=; b=Lk4YdGJ0KOgSPLSJoBHzLWxw4F
 tpaW8ImF0gYg/yjuYmLIfJAHk7+4HEnKYzAgNShcR55V6BwoYkj07OdmKVed3eErUhN5vXc/KKe24
 NX/xUMX6DlurM1x3AOW8CAmnzFcnp5nAAoDdxuN0uxkanmZ1oRfTOsORurBSx6dvMtlkmJmruLrXI
 urTCevHaTOo7BzqwTDinmws35ysRvSG2xv6eBN7V+oekf2Gwbi+Xa9mENcVhscEqgLA3F6gRP+iIN
 kFmU6MpSQ/5/DF+0ucA9JWevboI+MeqHdQWxXYhwNHy3/BMJqzRKbQkaKRuXqTmN0/UAZ2qvn/Z9Y
 yaH3kMqg==;
Received: from 179-125-72-1-dinamico.pombonet.net.br ([179.125.72.1]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x9Tpg-006KVk-UI; Wed, 23 Sep 2026 22:44:48 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH i-g-t v7 0/9] add cgroup_dmem test
Date: Wed, 23 Sep 2026 17:44:35 -0300
Message-Id: <20260923-dmem_max-v7-0-194ea47bbb4d@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADM6tGoC/02Oyw6CMBREf4V0bUkf2IIr/8MQcy0XqLHUtEgwh
 H8XMAaXJ5k5MxOJGCxGckomEnCw0fpuAX1IiGmha5DaamEimFCsYIJWDt3VwUg5HDGXWmYacrL
 EnwFrO26qS/nl+Lrd0fRrf03UwTvatwFhV2oheZFJLlOhs5xnknJqIBoIlT/bBh4WUuPdWm9t7
 H14b1cHtc78Xsn91aAoo4pXRolCsxrwX1LO8/wBYW96VvIAAAA=
X-Change-ID: 20260902-dmem_max-1a5e837347a8
To: igt-dev@lists.freedesktop.org
Cc: siqueira@igalia.com, Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, 
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, Christian Koenig <christian.koenig@amd.com>, 
 maarten.lankhorst@linux.intel.com, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Kamil Konieczny <kamil.konieczny@linux.intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, 
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Natalie Vock <natalie.vock@gmx.de>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, kernel-dev@igalia.com
X-Mailer: b4 0.16-dev-62088
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

v6 TLDR:
Change igt_dmem_driver API by moving handle array allocation out of it and
into the test itself and including dmem.max new behavior test.

This patchset is based on the work of Thomas Hellström at [1] and a
followup I have submitted at [2].

With this version, I reverted the order in which to apply the patchsets, as
this one adds the infrastructure and the drivers mechanisms, and a test for
dmem.current and its behavior around dmem.max that is currently supported
in the kernel.

As for the new dmem.max eviction behavior, introduced by [3], it has been
now included since it has been merged to Linux v7.3-rc1.

I have run the tests, including the ones that test dmem.max eviction
behavior on a system with a 1GiB VRAM amdgpu card. Rodrigo Siqueira helped
me run it on a Xe system. We have had applied the patchset at [3] on top of
then current linux origin/master [5], with a fixup for the amdgpu driver.

This latest version has not been tested on Xe, except for the dmem.current
behavior, which was tested with a 7.0 kernel.

Latest tests for amdgpu used v7.3-rc1.

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

Compared to v5 of this one [10]:
- Documented igt_dmem_driver structure.
- Simplified igt_dmem_driver API, such that handle array allocation is not
  done, and handles are returned as part of allocation.
- Make get_region_name callback use the context, instead of fd, which
  avoids repeating the vram region lookup for Xe.
- Moved handle array allocation into the test.
- init/deinit the igt_dmem_driver per driver, not per subtest.

[1] https://patchwork.freedesktop.org/series/163935/#rev3
[2] https://patchwork.freedesktop.org/series/166496/
[3] https://lore.kernel.org/dri-devel/20260611173301.17473-1-thomas.hellstrom@linux.intel.com/
[4] https://gitlab.freedesktop.org/cascardo/igt-gpu-tools/-/commits/dmem_max?ref_type=heads
[5] 502d801f0ab0 ("Merge tag 'erofs-for-7.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs")
[6] https://lore.kernel.org/dri-devel/20260623174319.4138648-1-cascardo@igalia.com/
[7] https://lore.kernel.org/dri-devel/20260702130108.1397444-1-cascardo@igalia.com/
[8] https://lore.kernel.org/dri-devel/20260717120447.1837818-1-cascardo@igalia.com/
[9] https://lore.kernel.org/dri-devel/20260703130541.2686-1-thomas.hellstrom@linux.intel.com/
[10] https://lore.kernel.org/dri-devel/20260723194313.2748143-1-cascardo@igalia.com/

To: igt-dev@lists.freedesktop.org
Cc: siqueira@igalia.com
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: maarten.lankhorst@linux.intel.com
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Kamil Konieczny <kamil.konieczny@linux.intel.com>
Cc: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: Natalie Vock <natalie.vock@gmx.de>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: kernel-dev@igalia.com

--
2.47.3

---
Changes in v7:
- igt_cgroup_free is now called by an exit handler and cannot be called
  directly.
- cgroup names are namespaced by subtest name so they do not conflict,
  both changes allow cgroups to be removed in case of test failures.
- igt_cgroup_exit_current is introduced to allow process to exit cgroup
  and go back to root cgroup.
- Driver is closed and reopened between tests, dropping any leftover
  usage in case of failures.
- Call igt_stop_signal_helper at test fixture to prevet child leak in
  case of failures.
- Update/fix copyright, comments and documentation as requested in
  reviews.
- Link to v6: https://patch.msgid.link/20260903-dmem_max-v6-0-61dc62970fae@igalia.com

---
Thadeu Lima de Souza Cascardo (4):
      lib/xe: Introduce dmem driver and implement Xe support
      lib/amdgpu: add amdgpu_cgroup_region_name
      lib/amdgpu: add amdgpu support to igt_dmem_driver
      tests/cgroup_dmem: add test for dmem.current

Thomas Hellström (5):
      lib/igt_cgroup: add cgroup v2 and dmem controller helpers
      tests/cgroup_dmem: add dmem cgroup controller test
      lib/xe: add xe_cgroup_region_name() helper
      tests/cgroup_dmem: add dmem cgroup eviction test
      tests/cgroup_dmem: add write_eviction_nonblock subtest

 lib/amdgpu/amd_dmem.c   |  90 +++++++
 lib/amdgpu/amd_memory.c |  25 ++
 lib/amdgpu/amd_memory.h |   2 +
 lib/igt.h               |   1 +
 lib/igt_cgroup.c        | 685 ++++++++++++++++++++++++++++++++++++++++++++++++
 lib/igt_cgroup.h        |  56 ++++
 lib/igt_dmem_driver.h   |  36 +++
 lib/meson.build         |   3 +
 lib/xe/xe_dmem.c        |  98 +++++++
 lib/xe/xe_query.c       |  32 +++
 lib/xe/xe_query.h       |   2 +
 tests/cgroup_dmem.c     | 542 ++++++++++++++++++++++++++++++++++++++
 tests/meson.build       |   1 +
 13 files changed, 1573 insertions(+)
---
base-commit: 4aeabf104b136437d0ccc57caf32a752587d595c
change-id: 20260902-dmem_max-1a5e837347a8

Best regards,
--  
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

