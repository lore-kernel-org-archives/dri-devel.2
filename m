Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DC3106FD6C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 01:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D072F10EAEA;
	Fri, 13 Mar 2026 01:52:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dAW4Af3C";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5270610EAC9;
 Fri, 13 Mar 2026 01:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773366739; x=1804902739;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FwrIZvhC393jVxgoQvl41shUwjFWL+jsAsS7ui/cgso=;
 b=dAW4Af3CpofcADHyiD0EgNE4nXzo1QGRpOmvtsmz8veEE4zZTjdLq2bS
 XMuAJKMYDHP0ueca+cIjwUe27xEunjUtVC9r6K9YXI80HbXu3aG7tif1O
 sPNJoMSN//SX6W7TkMjgcJkd3s3sO8Co7FHQnzXfigK3ApraNN10xGsG+
 cyjSfLE0n7a6Uq5dadbmrDCxs+9lIax2628Y2Y4HEqTzNHn//AY7nDjIY
 zGYK91qiQt8RCwL/p0HHZvQbpx2yIGv0WExAQmmNpCmxCxY0AqQ/XaqCB
 d4EaxG0/hA6Xjlw2wHWDUaNeFHVEATZKGiGDsyR3MLWZYoRt2w1iB9upz g==;
X-CSE-ConnectionGUID: 21y/VfB4TaqOd34Eun0hqg==
X-CSE-MsgGUID: mw4oa+SGRnau/HqvLufiMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74354582"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; d="scan'208";a="74354582"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 18:52:12 -0700
X-CSE-ConnectionGUID: TDvBLrxtRHq0FW+O4xYBQw==
X-CSE-MsgGUID: FbedKJiZSZas7FzHAHNLQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; d="scan'208";a="220108500"
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
Subject: [PATCH 11/22] platform/x86/intel/pmt: Pass discovery index instead of
 resource
Date: Thu, 12 Mar 2026 18:51:50 -0700
Message-ID: <20260313015202.3660072-12-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313015202.3660072-1-david.e.box@linux.intel.com>
References: <20260313015202.3660072-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
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

Change PMT class code to pass a discovery index rather than a direct struct
resource when creating entries. This allows the class to identify the
discovery source generically without assuming PCI BAR resources. For PCI
devices, the index still resolves to a resource in the intel_vsec_device.
Other discovery sources, such as ACPI, can use the same index without
needing a struct resource.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmt/class.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/=
intel/pmt/class.c
index a4d6ffed2fed..f94f51178043 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -207,11 +207,12 @@ EXPORT_SYMBOL_GPL(intel_pmt_class);
=20
 static int intel_pmt_populate_entry(struct intel_pmt_entry *entry,
 				    struct intel_vsec_device *ivdev,
-				    struct resource *disc_res)
+				    int idx)
 {
 	struct pci_dev *pci_dev =3D to_pci_dev(ivdev->dev);
 	struct device *dev =3D &ivdev->auxdev.dev;
 	struct intel_pmt_header *header =3D &entry->header;
+	struct resource *disc_res;
 	u8 bir;
=20
 	/*
@@ -236,6 +237,7 @@ static int intel_pmt_populate_entry(struct intel_pmt_en=
try *entry,
 		 * For access_type LOCAL, the base address is as follows:
 		 * base address =3D end of discovery region + base offset
 		 */
+		disc_res =3D &ivdev->resource[idx];
 		entry->base_addr =3D disc_res->end + 1 + header->base_offset;
=20
 		/*
@@ -413,7 +415,7 @@ int intel_pmt_dev_create(struct intel_pmt_entry *entry,=
 struct intel_pmt_namespa
 			return ret;
 	}
=20
-	ret =3D intel_pmt_populate_entry(entry, intel_vsec_dev, &intel_vsec_dev->=
resource[idx]);
+	ret =3D intel_pmt_populate_entry(entry, intel_vsec_dev, idx);
 	if (ret)
 		return ret;
=20
--=20
2.43.0

