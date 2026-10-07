Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662ECCA6002
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C90C10F44F;
	Wed,  7 Oct 2026 08:07:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Fydh8RXe";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E971210E53E;
 Wed,  7 Oct 2026 08:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791360429; x=1822896429;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=romjlo+9XGi6AHS6ZJhdS/i4Eu/Sc0BFFjJspgHaBRQ=;
 b=Fydh8RXe/cVk2ESxvkcHrTIBLhX8I+YFPJQZ2ceLcRhPNCvg+XGDyXIb
 abO/mJoRjXmj7ePjXKumkKPKeg7OqXAuQGb9owOtbjvLd0qa3ZGmQIlZM
 M7poJ5kpn38haUOFPzkaEngt7fdcM312xuv0ztH1RySebnTlpdyfUVNr/
 2et3QAByGDkpx9AO+BIhDUDcWjFk3pssbFYIBK9zatCeZ7qb4Bb2zGiw0
 0qgZg09suwbFfWsX0+JXBpcLl2lROZ7fLDNhXk+SfiUYBymSpGPpaW1ci
 g0rwfucjdK8hYNqFfNcSqWnm6z4R9vcibpymONdGVlchaPrVwk/4AZJZU w==;
X-CSE-ConnectionGUID: IgkobZtNRpWeOGtBEpCBEA==
X-CSE-MsgGUID: tBv+nc/BRva8rmtfsj2qsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="108529"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="108529"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 01:07:07 -0700
X-CSE-ConnectionGUID: 0Mk0mLUSRr2GF0Bs/rpY/w==
X-CSE-MsgGUID: CouYNn0jRoy1mAI6wVYmuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="315405490"
Received: from aravind-dev.iind.intel.com ([10.190.239.36])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 01:07:02 -0700
From: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, amd-gfx@lists.freedesktop.org
Cc: simona.vetter@ffwll.ch, airlied@gmail.com, tejas.upadhyay@intel.com,
 himal.prasad.ghimiray@intel.com, rodrigo.vivi@intel.com,
 riana.tauro@intel.com, raag.jadav@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 pratik.bari@intel.com, Hawking.Zhang@amd.com, tao.zhou1@amd.com,
 YiPeng.Chai@amd.com, jinzhou.su@amd.com, cesun102@amd.com,
 lijo.lazar@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com
Subject: [PATCH v2 0/2] drm/xe: Expose retired VRAM pages via drm-ras
Date: Wed,  7 Oct 2026 13:33:52 +0530
Message-Id: <20261007080354.3072751-1-aravind.iddamsetty@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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

The memory page offlining support tracks bad VRAM pages and currently
only exposes them through debugfs (vram_bad_pages), which is not a
stable ABI. Add a proper userspace interface using the drm-ras
generic netlink family.

Introduce a new node type DRM_RAS_NODE_TYPE_RETIRED_RESOURCES which
enumerates hardware resources that have been permanently taken out of
service. Each node reports a single resource type, identified by its
node-name, so the resource type is implied by the node rather than
carried per entry. The per-entry payload stays extensible: each entry
carries a single type-specific nested attribute, so future resource
types can be added without touching existing consumers. VRAM pages are
the first supported type, reported via the vram-page nest as
{address, size, status} where status is one of retired/pending/failed.

A single operation is added on the node:
 - GET_RETIRED_RESOURCES: dump the resources retired on the node. The
   dump opens with a leading capacity summary entry (max-pages
   inside the vram-page nest, i.e. the maximum number of pages that
   can be offlined, with no address/size/status), followed by one
   entry per retired resource. Userspace derives the retired/queued
   counts by counting entries.

The netlink interface is described by the YAML spec
Documentation/netlink/specs/drm_ras.yaml. The following files are
generated from that spec with tools/net/ynl/ynl-regen.sh and must not
be edited by hand:
 - include/uapi/drm/drm_ras.h        (uapi attribute/command enums)
 - drivers/gpu/drm/drm_ras_nl.c      (generated policy and op table)
 - drivers/gpu/drm/drm_ras_nl.h      (generated declarations)

Eg:
$ sudo ./tools/net/ynl/pyynl/cli.py \
     --spec Documentation/netlink/specs/drm_ras.yaml \
     --dump list-nodes

[{'device-name': '0000:03:00.0', 'node-id': 0, 'node-name':'correctable-errors',
 'node-type': 'error-counter'},
 {'device-name': '0000:03:00.0', 'node-id': 1, 'node-name':'uncorrectable-errors
', 'node-type': 'error-counter'},
 {'device-name': '0000:03:00.0', 'node-id': 2, 'node-name':'vram-retired-pages',
 'node-type': 'retired-resources'}]

$ sudo ./tools/net/ynl/pyynl/cli.py --spec \
Documentation/netlink/specs/drm_ras.yaml  --dump  get-retired-resources \
--json '{"node-id": 2}'

[{'node-id': 2, 'vram-page': {'max-pages': 100}},
 {'node-id': 2, 'vram-page': {'address': 12807041024, 'size': 4096,
 'status': 'retired'}},
 {'node-id': 2, 'vram-page': {'address': 12809400320, 'size': 4096,
 'status': 'retired'}}]

The first entry is the capacity summary (max-pages); subsequent entries
are the retired pages.

v2:
 - Rebase on drm-tip
 - Drop the per-entry resource-type discriminator attribute; the type is
   now implied by the node (node-name), which reports a single type.
 - Fold all VRAM-page fields, including the retirement status, into the
   vram-page nested attribute; the top-level entry is just
   {node-id, vram-page}. (Rodrigo)
 - Drop the separate GET_RETIRED_RESOURCES_INFO operation. The capacity
   (max-pages) is now emitted as a leading summary entry inside
   GET_RETIRED_RESOURCES (max-pages in the vram-page nest, no status);
   offlined/queued counts are derived by counting entries.

Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Riana Tauro <riana.tauro@intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>
Cc: Joshua Santhosh Ranjan <joshua.santosh.ranjan@intel.com>
Cc: Ashwin Kumar Kulkarni <ashwin.kumar.kulkarni@intel.com>
Cc: Pratik Bari <pratik.bari@intel.com>

Aravind Iddamsetty (2):
  drm/xe: Expose retired VRAM pages via drm-ras
  drm/xe: Remove bad VRAM pages debugfs interface

 Documentation/netlink/specs/drm_ras.yaml |  91 ++++++++++-
 drivers/gpu/drm/drm_ras.c                | 174 ++++++++++++++++++++-
 drivers/gpu/drm/drm_ras_nl.c             |  12 ++
 drivers/gpu/drm/drm_ras_nl.h             |   2 +
 drivers/gpu/drm/xe/xe_debugfs.c          |   2 -
 drivers/gpu/drm/xe/xe_drm_ras.c          |  77 +++++++++
 drivers/gpu/drm/xe/xe_drm_ras_types.h    |   3 +
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c     | 190 ++++++++++++++---------
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.h     |   4 +-
 include/drm/drm_ras.h                    |  74 +++++++++
 include/uapi/drm/drm_ras.h               |  48 +++++-
 11 files changed, 592 insertions(+), 85 deletions(-)

-- 
2.25.1

