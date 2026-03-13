Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8D0106FD71
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 01:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C928710EAE3;
	Fri, 13 Mar 2026 01:52:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Mj/ev/MD";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EA4610EAC6;
 Fri, 13 Mar 2026 01:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773366739; x=1804902739;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=HyZPT4xj/h9rsSXpt3bJWZONcExlgM7rs4CWBgwAqIs=;
 b=Mj/ev/MDg6SRE6wnLD9MbEpo43c3xh2GAIHpp+HKkIrOQZ1l0Sjs2Ob/
 sMN4h3SgFBW3kIxEr4jZH8eimLYSFhrF7K383NyMmabuR7MDTI+liGlOc
 nSsTLs8r3h9W8NLhrIc9NyqEQ4lCEKSsICfdjcd4dPsvEDV215SMWMT2I
 fJ3IgeoV4gEkl90YjWvHxrZNl73xb+ifw5PFZF/AKKjsnLnHfUJ+uFquL
 fEFa2iL2WxzJIN3Ecpt7loVAiXJgLVlJ1tchQ5Q4IqyzoWab3NfmJELpN
 ORD/JsDkjfPGI6OA7M+w7zr2lcFA/ZGFkfdzaVV1JkNymzTVod7bgUdZq g==;
X-CSE-ConnectionGUID: ctht/xVXSTqeOT/FtCuz8Q==
X-CSE-MsgGUID: iJADxvxAQdCAYu6FvhOfSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74354531"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; d="scan'208";a="74354531"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 18:52:12 -0700
X-CSE-ConnectionGUID: o/J1PXZCRxinXe9US6mS9w==
X-CSE-MsgGUID: DskQomeYR92n3K21XYfdEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; d="scan'208";a="220108465"
Received: from debox1-desk4.jf.intel.com ([10.88.27.138])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 18:52:12 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 irenic.rajneesh@gmail.com, ilpo.jarvinen@linux.intel.com,
 srinivas.pandruvada@linux.intel.com, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, xi.pardee@linux.intel.com
Cc: david.e.box@linux.intel.com, hansg@kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 00/22] platform/x86/intel: Add ACPI PMT discovery support and
 enable NVL PMC telemetry
Date: Thu, 12 Mar 2026 18:51:39 -0700
Message-ID: <20260313015202.3660072-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

This series adds ACPI-based PMT discovery support and wires it into the
Intel PMC telemetry stack for Nova Lake S.

Today, PMT discovery flow is primarily PCI-oriented. Some platforms expose
PMT discovery via ACPI _DSD, and PMC telemetry needs to consume that path
for both standalone and companion-device cases. This series addresses that
in three logical steps:

    1. Prepare intel_vsec for ACPI-backed discovery
    2. Refactor PMT class handling so discovery source is
       abstracted (PCI or ACPI)
    3. Add/enable PMC consumers using ACPI discovery, including NVL
       SSRAM support

Patches 1=E2=80=936 were previously posted here:
https://lore.kernel.org/all/20260303051953.1453372-1-david.e.box@linux.inte=
l.com/

Series layout

    01-06: intel_vsec cleanup/generalization for ACPI-capable discovery
           plumbing. Previous changelog up to V7 included.
           Major patches:
           Patch 6 - adds ACPI support in VSEC driver

    07-12: PMT class refactor and ACPI discovery-source support
           Major patches:
           Patch 12 - adds ACPI support in PMT driver

    13-22: PMC driver integration
           Major patches:
           Patch 14 - adds new ACPI platform driver
           Patch 20 - adds ACPI discovery support in ssram driver
           Patch 22 - adds NVL IDs for SSRAM discovery

David E. Box (20):
  platform/x86/intel/vsec: Refactor base_addr handling
  platform/x86/intel/vsec: Make driver_data info const
  platform/x86/intel/vsec: Decouple add/link helpers from PCI
  platform/x86/intel/vsec: Switch exported helpers from pci_dev to
    device
  platform/x86/intel/vsec: Return real error codes from registration
    path
  platform/x86/intel/vsec: Plumb ACPI PMT discovery tables through vsec
  platform/x86/intel/pmt: Add pre/post decode hooks around header
    parsing
  platform/x86/intel/pmt/crashlog: Split init into pre-decode
  platform/x86/intel/pmt/telemetry: Move overlap check to post-decode
    hook
  platform/x86/intel/pmt: Move header decode into common helper
  platform/x86/intel/pmt: Pass discovery index instead of resource
  platform/x86/intel/pmt: Unify header fetch and add ACPI source
  platform/x86/intel/pmc: Add PMC SSRAM Kconfig description
  platform/x86/intel/pmc: Add ACPI PWRM telemetry driver for Nova Lake S
  platform/x86/intel/pmc/ssram: Rename probe and PCI ID table for
    consistency
  platform/x86/intel/pmc/ssram: Refactor DEVID/PWRMBASE extraction into
    helper
  platform/x86/intel/pmc/ssram: Add PCI platform data
  platform/x86/intel/pmc/ssram: Add ACPI discovery scaffolding
  platform/x86/intel/pmc/ssram: Make PMT registration optional
  platform/x86/intel/pmc: Add NVL PCI IDs for SSRAM telemetry discovery

Xi Pardee (2):
  platform/x86/intel/pmc/ssram: Use fixed-size static pmc array
  platform/x86/intel/pmc/ssram: Refactor memory barrier for reentrant
    probe

 drivers/gpu/drm/xe/xe_debugfs.c               |   2 +-
 drivers/gpu/drm/xe/xe_hwmon.c                 |   2 +-
 drivers/gpu/drm/xe/xe_vsec.c                  |   7 +-
 drivers/gpu/drm/xe/xe_vsec.h                  |   4 +-
 drivers/platform/x86/intel/pmc/Kconfig        |  25 ++
 drivers/platform/x86/intel/pmc/Makefile       |   2 +
 drivers/platform/x86/intel/pmc/core.c         |   4 +-
 drivers/platform/x86/intel/pmc/core.h         |  17 ++
 .../platform/x86/intel/pmc/pwrm_telemetry.c   | 227 ++++++++++++++++
 .../platform/x86/intel/pmc/ssram_telemetry.c  | 254 ++++++++++++++----
 drivers/platform/x86/intel/pmt/class.c        | 170 ++++++++++--
 drivers/platform/x86/intel/pmt/class.h        |  25 +-
 drivers/platform/x86/intel/pmt/crashlog.c     |  16 +-
 drivers/platform/x86/intel/pmt/discovery.c    |   4 +-
 drivers/platform/x86/intel/pmt/telemetry.c    |  45 +---
 drivers/platform/x86/intel/pmt/telemetry.h    |  12 +-
 drivers/platform/x86/intel/sdsi.c             |   5 +-
 drivers/platform/x86/intel/vsec.c             | 121 +++++----
 drivers/platform/x86/intel/vsec_tpmi.c        |   8 +-
 include/linux/intel_vsec.h                    |  39 ++-
 20 files changed, 784 insertions(+), 205 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmc/pwrm_telemetry.c


base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
--=20
2.43.0

