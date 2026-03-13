Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B45105F7B3
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 15:03:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3178D10EB84;
	Fri, 13 Mar 2026 15:03:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kc8FDDqn";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8294B10E469;
 Fri, 13 Mar 2026 15:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773414211; x=1804950211;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=+zZrlrlLBTGlrMt43VfZN8jaxUEcD5rTLYR5cOzEnUU=;
 b=kc8FDDqnu78g3nOyEcN7NRuCRIG8jbxsmTbWqtZ8wNhn+8gkkOkPUnbb
 A5vSp5+AckwxYiwtEvcaxu5l0Twq6OPGoXDwVdVidiT9EZJpA8uhNps+i
 kKpeVyF2sNFGCasySHO2vQvZ51/UmuPQUkos0hoWop/qJ8CuRYytyvz47
 QZ+yrE7gJDBoHFb+KJUkdhYx13mlVO+CgU2vRAx5Kx8akDz6UPDp3c5jV
 Pqs0jXMuND7Pz5iSsqTx1rESAF+hMi6EgejtGJQ+6hvBrfQ9D2FCbdUpp
 UnsBbFRWEkeZPKV4TgpBSKdXS2li6mUWfkXvJzZ2TiJU6qm2kUMkF1Ww1 w==;
X-CSE-ConnectionGUID: IgqAKwkoTAmEnvmOU23abw==
X-CSE-MsgGUID: A6hvr5qaTfWz5OZdphq7/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="85223008"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="85223008"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 08:03:31 -0700
X-CSE-ConnectionGUID: H8QnJzp7TJqGR2uP7m3I5Q==
X-CSE-MsgGUID: gZp0HqzWQf6QUwBSHfIraA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="225876196"
Received: from cjhill-mobl.amr.corp.intel.com (HELO [10.125.110.231])
 ([10.125.110.231])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 08:03:25 -0700
Message-ID: <082ec14b39aa804f774003af75df407274e50d2f.camel@linux.intel.com>
Subject: Re: [PATCH 00/22] platform/x86/intel: Add ACPI PMT discovery
 support and enable NVL PMC telemetry
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "David E. Box" <david.e.box@linux.intel.com>, 
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
 irenic.rajneesh@gmail.com, ilpo.jarvinen@linux.intel.com, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 xi.pardee@linux.intel.com
Cc: hansg@kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org
Date: Fri, 13 Mar 2026 08:03:25 -0700
In-Reply-To: <20260313015202.3660072-1-david.e.box@linux.intel.com>
References: <20260313015202.3660072-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
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

On Thu, 2026-03-12 at 18:51 -0700, David E. Box wrote:
> This series adds ACPI-based PMT discovery support and wires it into
> the
> Intel PMC telemetry stack for Nova Lake S.

I think this series is v7, missing patch prefix for versions.

Thanks,
Srinivas

>=20
> Today, PMT discovery flow is primarily PCI-oriented. Some platforms
> expose
> PMT discovery via ACPI _DSD, and PMC telemetry needs to consume that
> path
> for both standalone and companion-device cases. This series addresses
> that
> in three logical steps:
>=20
> =C2=A0=C2=A0=C2=A0 1. Prepare intel_vsec for ACPI-backed discovery
> =C2=A0=C2=A0=C2=A0 2. Refactor PMT class handling so discovery source is
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abstracted (PCI or ACPI)
> =C2=A0=C2=A0=C2=A0 3. Add/enable PMC consumers using ACPI discovery, incl=
uding NVL
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SSRAM support
>=20
> Patches 1=E2=80=936 were previously posted here:
> https://lore.kernel.org/all/20260303051953.1453372-1-david.e.box@linux.in=
tel.com/
>=20
> Series layout
>=20
> =C2=A0=C2=A0=C2=A0 01-06: intel_vsec cleanup/generalization for ACPI-capa=
ble
> discovery
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 plumbing. Pr=
evious changelog up to V7 included.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Major patche=
s:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Patch 6 - ad=
ds ACPI support in VSEC driver
>=20
> =C2=A0=C2=A0=C2=A0 07-12: PMT class refactor and ACPI discovery-source su=
pport
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Major patche=
s:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Patch 12 - a=
dds ACPI support in PMT driver
>=20
> =C2=A0=C2=A0=C2=A0 13-22: PMC driver integration
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Major patche=
s:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Patch 14 - a=
dds new ACPI platform driver
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Patch 20 - a=
dds ACPI discovery support in ssram driver
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Patch 22 - a=
dds NVL IDs for SSRAM discovery
>=20
> David E. Box (20):
> =C2=A0 platform/x86/intel/vsec: Refactor base_addr handling
> =C2=A0 platform/x86/intel/vsec: Make driver_data info const
> =C2=A0 platform/x86/intel/vsec: Decouple add/link helpers from PCI
> =C2=A0 platform/x86/intel/vsec: Switch exported helpers from pci_dev to
> =C2=A0=C2=A0=C2=A0 device
> =C2=A0 platform/x86/intel/vsec: Return real error codes from registration
> =C2=A0=C2=A0=C2=A0 path
> =C2=A0 platform/x86/intel/vsec: Plumb ACPI PMT discovery tables through
> vsec
> =C2=A0 platform/x86/intel/pmt: Add pre/post decode hooks around header
> =C2=A0=C2=A0=C2=A0 parsing
> =C2=A0 platform/x86/intel/pmt/crashlog: Split init into pre-decode
> =C2=A0 platform/x86/intel/pmt/telemetry: Move overlap check to post-decod=
e
> =C2=A0=C2=A0=C2=A0 hook
> =C2=A0 platform/x86/intel/pmt: Move header decode into common helper
> =C2=A0 platform/x86/intel/pmt: Pass discovery index instead of resource
> =C2=A0 platform/x86/intel/pmt: Unify header fetch and add ACPI source
> =C2=A0 platform/x86/intel/pmc: Add PMC SSRAM Kconfig description
> =C2=A0 platform/x86/intel/pmc: Add ACPI PWRM telemetry driver for Nova
> Lake S
> =C2=A0 platform/x86/intel/pmc/ssram: Rename probe and PCI ID table for
> =C2=A0=C2=A0=C2=A0 consistency
> =C2=A0 platform/x86/intel/pmc/ssram: Refactor DEVID/PWRMBASE extraction
> into
> =C2=A0=C2=A0=C2=A0 helper
> =C2=A0 platform/x86/intel/pmc/ssram: Add PCI platform data
> =C2=A0 platform/x86/intel/pmc/ssram: Add ACPI discovery scaffolding
> =C2=A0 platform/x86/intel/pmc/ssram: Make PMT registration optional
> =C2=A0 platform/x86/intel/pmc: Add NVL PCI IDs for SSRAM telemetry
> discovery
>=20
> Xi Pardee (2):
> =C2=A0 platform/x86/intel/pmc/ssram: Use fixed-size static pmc array
> =C2=A0 platform/x86/intel/pmc/ssram: Refactor memory barrier for reentran=
t
> =C2=A0=C2=A0=C2=A0 probe
>=20
> =C2=A0drivers/gpu/drm/xe/xe_debugfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0drivers/gpu/drm/xe/xe_hwmon.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
2 +-
> =C2=A0drivers/gpu/drm/xe/xe_vsec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 7 +-
> =C2=A0drivers/gpu/drm/xe/xe_vsec.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 4 +-
> =C2=A0drivers/platform/x86/intel/pmc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 25 ++
> =C2=A0drivers/platform/x86/intel/pmc/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0drivers/platform/x86/intel/pmc/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
> =C2=A0drivers/platform/x86/intel/pmc/core.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 17 ++
> =C2=A0.../platform/x86/intel/pmc/pwrm_telemetry.c=C2=A0=C2=A0 | 227 +++++=
+++++++++++
> =C2=A0.../platform/x86/intel/pmc/ssram_telemetry.c=C2=A0 | 254 ++++++++++=
++++--
> --
> =C2=A0drivers/platform/x86/intel/pmt/class.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 170 ++++++++++--
> =C2=A0drivers/platform/x86/intel/pmt/class.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 25 +-
> =C2=A0drivers/platform/x86/intel/pmt/crashlog.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 16 +-
> =C2=A0drivers/platform/x86/intel/pmt/discovery.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 4 +-
> =C2=A0drivers/platform/x86/intel/pmt/telemetry.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 45 +---
> =C2=A0drivers/platform/x86/intel/pmt/telemetry.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0 12 +-
> =C2=A0drivers/platform/x86/intel/sdsi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +-
> =C2=A0drivers/platform/x86/intel/vsec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 121 +++++----
> =C2=A0drivers/platform/x86/intel/vsec_tpmi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +-
> =C2=A0include/linux/intel_vsec.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 39 ++-
> =C2=A020 files changed, 784 insertions(+), 205 deletions(-)
> =C2=A0create mode 100644 drivers/platform/x86/intel/pmc/pwrm_telemetry.c
>=20
>=20
> base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
