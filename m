Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD545F4198B
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:29:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FBC5890CE;
	Wed, 15 Apr 2026 11:29:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="BFeoH3Kh";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83EED10E6C1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 11:29:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776252552; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=etAjdlYxXyoMfDGGKWZBdPeAFUJldn2DDKQL5OXasbbWX75f9obuelX3nuiaf4wjU/eA3uA4aSEYpS0yD+vBro3QKIRhK8TFhoYkV17vb0QOgNCd0eUGXqVme13PLRtBhBEf4RjrsxHnnyyXWogPbVEs1ZLamyL8ScR6wRk6bBg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776252552;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=gr13Nmbg8/Li/THg9/wBxJnkp5KIApliQsqqzogOCzg=; 
 b=ASxEpRye7Ep6g0beBONTd7edjZf1RbrxqRNgHQe7mM4vJ14SiLR6N9w8wnWUW8G5QaY/LKCMtaUpYuh8Fk8AK3ejdPixF5jAVCqPeh4CUQ7ujYd43vGdL+vppd1rijJeX8v/9BSRgbIX2mQAmuLctKf3mzt3MgIzuVG6U0Wa8CA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776252552; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=gr13Nmbg8/Li/THg9/wBxJnkp5KIApliQsqqzogOCzg=;
 b=BFeoH3KhZcrPB5L1gdxx9NsslGKpzHoFy1+boDP6nN+iafX/OLtn9qTfbsxGmx6j
 OJ4SXNmfWvgsw1fXUCHdnv+iV6otI29DmZBScqtZcypM1f4LSUafvpgkPzVb2YA2CF4
 Nd2dG/6rrzLnsC86WO+8zwpzUSS/YR4by/UOENxg=
Received: by mx.zohomail.com with SMTPS id 1776252551384243.10310370497484;
 Wed, 15 Apr 2026 04:29:11 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH v7 0/6] Support sparse mappings in Panthor
Date: Wed, 15 Apr 2026 12:28:44 +0100
Message-ID: <20260415112900.681834-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
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

This patch series implements sparse mappings in Panthor. Owing to the lack of HW MMU
features for sparse page table entries, this had to be implemented using a dummy object
over which sparse mappings requested over VM_BIND are mapped cyclically.

To that end, a new VM_BIND flag was added in the driver's uAPI.

The end goal of this patch series is to improve support of Vulkan sparse
resources. At the moment, to implement this feature on Mali hardware, Vulkan
sparse map is implemented by mapping the specified region to a "dummy bo" so
that the accesses do not fault. A newly created sparse resource starts off
unmapped, and therefore also has to be mapped to the "dummy bo".  This "dummy
bo" is small (a page size) in comparison to the sizes of va ranges that we might
want to map to it, and a large number of vm_bind ops can be necessary. For
example, if the user were to create a 100e6-byte sparse resident resource, we'd
have to poke VM_BIND with ceil(100e6/0x1000)=24415 map operations.

The new VM_BIND sparse mapping feature addresses this particular inefficiency by
letting us implement a single Vulkan sparse map operation and sparse resident
resource initialization with just one map operation.

Link to the conversation for the previous patch series revision at:
https://lore.kernel.org/dri-devel/20260403192743.3572062-1-adrian.larumbe@collabora.com/

Changes in v7:
 - Switched back to Panthor BO-backed dummy object instead of raw pages so as to profit from
 the existing shrinker reclaim paths.
 - Created Dummy BO's per file context to avoid information leaking between them.
 - Reorganised some of the low-level page mapping code.
 - Added commits deleting spurious white space and unused op contex field.

Changes in v6:
 - Moved all the GPUVM core code into the driver backend.
 - Discarded commits that touch on the gpuvm core too.
 - Redesigned the uAPI so that no repeat range or user BO is supplied for sparse mappings.
 - Replaced user-supplied BO with a kernel-allocated array of raw pages.

Changes in v5:
 - Minor fixes to drm_gpuvm.c.
 - Add panthor MMU page sizes device queriable param.
 - Add helper to make sure unmaps of repeated regions are correct.
 - Some fixes to Panthor's repeat mappings implementation.
 - Lump arguments to panthor_vm_prepare_map_op_ctx into a single struct.

Changes in v4:
 - Fixed the warnings reported by the kernel test robot.
  https://lore.kernel.org/oe-kbuild-all/202507041635.WyDu3TQ1-lkp@intel.com/
 - Fixed the warnings reported by the CI.
  https://patchwork.freedesktop.org/series/151264/

No changes in v3.

Changes in v2:
 - Make panthor use this stuff.
 - Make it possible to express a repeated mappina of any suitably sized
  and aligned range of a BO, rather than strictly the page size -sized
  prefix, generalizing the API. Rename DRM_GPUVA_SINGLE_PAGE to
  DRM_GPUVA_REPEAT.
 - Clean up parts of drm/gpuvm affected by these changes.

Adrián Larumbe (6):
  drm/panthor: Expose GPU page sizes to UM
  drm/panthor: Pass vm_bind_op to vm_prepare_map_op_ctx
  drm/panthor: Delete spurious whitespace from uAPI header
  drm/panthor: Remove unused operation context field
  drm/panthor: Support sparse mappings
  drm/panthor: Bump the driver version to 1.9

 drivers/gpu/drm/panthor/panthor_device.h |   3 +
 drivers/gpu/drm/panthor/panthor_drv.c    |  10 +
 drivers/gpu/drm/panthor/panthor_gem.c    |  35 ++++
 drivers/gpu/drm/panthor/panthor_gem.h    |   2 +
 drivers/gpu/drm/panthor/panthor_mmu.c    | 230 ++++++++++++++++++-----
 include/uapi/drm/panthor_drm.h           |  26 ++-
 6 files changed, 260 insertions(+), 46 deletions(-)

--
2.53.0
