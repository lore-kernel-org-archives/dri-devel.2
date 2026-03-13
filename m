Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B7D106FD60
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 01:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B706E10EAE0;
	Fri, 13 Mar 2026 01:52:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ES21B1RQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A80710E042;
 Fri, 13 Mar 2026 01:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773366739; x=1804902739;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=O6eG7WRWywaqNptPXMPB/TF5fGTS9YsXb2B5mhnJT5w=;
 b=ES21B1RQKQV/l3Tvd4S4GKcwPk0GtT24W0ID08rylwPH6KalljN51Prk
 2cZpf/eNDccn1hMwTkhNX4aURHhf59bfDB5LHpGyyqGR6qxpFxB4LleAP
 MaiCHzVo9BXA6fTGI3IwlXs1HUOX47fmksUkj55g37s7FG81ATjPeF3oP
 MfGk4m4mZdDcx+ZJzQdz1HrmdzbK7KSlJ4VbuvrW0vg65hY7fgPtSH/zi
 VAkIFbyTCbpCq6IDMck9hqpsHiL0f1q9uFprBiP0eX7cdrv/+nIndWfJU
 wQNHLzmMh0DG/XXOQ6K9Q3KQMxA4RmoQk0lrKh4q3/RNN6955pgO4NcMO A==;
X-CSE-ConnectionGUID: 2UCHMUlOQaWiEXzCRJ1uQg==
X-CSE-MsgGUID: c5F+wmuMRwmh4jTUrCKJ9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74354567"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; d="scan'208";a="74354567"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 18:52:12 -0700
X-CSE-ConnectionGUID: TMsKAeUpRUGaCXxJQ1roKQ==
X-CSE-MsgGUID: fK7N8ixzQC6dsd5yXu8hYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; d="scan'208";a="220108490"
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
Subject: [PATCH 08/22] platform/x86/intel/pmt/crashlog: Split init into
 pre-decode
Date: Thu, 12 Mar 2026 18:51:47 -0700
Message-ID: <20260313015202.3660072-9-david.e.box@linux.intel.com>
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

Refactor crashlog initialization to use the PMT namespace pre-decode hook:

  - Add pmt_crashlog_pre_decode() to parse type/version, select the
    crashlog_info, initialize the control mutex, and set entry->attr_grp.
  - Simplify pmt_crashlog_header_decode() to only read header fields from
    the discovery table.
  - Wire the namespace with .pmt_pre_decode =3D pmt_crashlog_pre_decode.

This separates structural initialization from header parsing, aligning
crashlog with the PMT class pre/post decode flow.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmt/crashlog.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel/pmt/crashlog.c b/drivers/platform/x=
86/intel/pmt/crashlog.c
index b0393c9c5b4b..f936daf99e4d 100644
--- a/drivers/platform/x86/intel/pmt/crashlog.c
+++ b/drivers/platform/x86/intel/pmt/crashlog.c
@@ -496,11 +496,9 @@ static const struct crashlog_info *select_crashlog_inf=
o(u32 type, u32 version)
 	return &crashlog_type1_ver2;
 }
=20
-static int pmt_crashlog_header_decode(struct intel_pmt_entry *entry,
-				      struct device *dev)
+static int pmt_crashlog_pre_decode(struct intel_vsec_device *ivdev,
+				   struct intel_pmt_entry *entry)
 {
-	void __iomem *disc_table =3D entry->disc_table;
-	struct intel_pmt_header *header =3D &entry->header;
 	struct crashlog_entry *crashlog;
 	u32 version;
 	u32 type;
@@ -513,6 +511,16 @@ static int pmt_crashlog_header_decode(struct intel_pmt=
_entry *entry,
 	mutex_init(&crashlog->control_mutex);
=20
 	crashlog->info =3D select_crashlog_info(type, version);
+	entry->attr_grp =3D crashlog->info->attr_grp;
+
+	return 0;
+}
+
+static int pmt_crashlog_header_decode(struct intel_pmt_entry *entry,
+				      struct device *dev)
+{
+	void __iomem *disc_table =3D entry->disc_table;
+	struct intel_pmt_header *header =3D &entry->header;
=20
 	header->access_type =3D GET_ACCESS(readl(disc_table));
 	header->guid =3D readl(disc_table + GUID_OFFSET);
@@ -521,8 +529,6 @@ static int pmt_crashlog_header_decode(struct intel_pmt_=
entry *entry,
 	/* Size is measured in DWORDS, but accessor returns bytes */
 	header->size =3D GET_SIZE(readl(disc_table + SIZE_OFFSET));
=20
-	entry->attr_grp =3D crashlog->info->attr_grp;
-
 	return 0;
 }
=20
@@ -530,6 +536,7 @@ static DEFINE_XARRAY_ALLOC(crashlog_array);
 static struct intel_pmt_namespace pmt_crashlog_ns =3D {
 	.name =3D "crashlog",
 	.xa =3D &crashlog_array,
+	.pmt_pre_decode =3D pmt_crashlog_pre_decode,
 	.pmt_header_decode =3D pmt_crashlog_header_decode,
 };
=20
--=20
2.43.0

