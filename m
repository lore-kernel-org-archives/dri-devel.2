Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700D1606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=db5aOBvY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C867A112CB3;
	Fri, 27 Nov 2026 17:59:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0513112CAF;
 Fri, 27 Nov 2026 17:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795802373; x=1827338373;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=525Mz2x3++RQhSkz3V8GbEgn0v0jVcbWudCmLnP9FZ0=;
 b=db5aOBvYmAUMdPdjFPbgWUuXg0YTBUjQi3A6qcYoPifz+VlqFQz1baLI
 Y66dBeNoCn6hQPxqVsu9aRJlBb6G5SQNW2SmYde9zM02BFz18DD5HRARY
 jXeruEDVAddtfqCVw9NmWtz9jZTMwb/0peFrGYlBKgJIvTGl+4lFKZP8D
 l1TwpaTopaOAE8KFdMSh48Eay/X5onWQKLod53ifRNs7DGkAN723lcr+s
 vn2uSmymzHrgB+aMzBCuYhib2pXw/EUdMqnzEzIXcipZJedY6dftPX2pt
 8xR6hOv18yW1uNumXEjRrPOKxI8RPBVXen3cZkQGcGb2ripH0NaGSnsWh A==;
X-CSE-ConnectionGUID: Z2+TgzMHRDqMiyrs72OHTA==
X-CSE-MsgGUID: NpScm1bQQCmyjlLabbjz6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4717107"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4717107"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 09:59:33 -0800
X-CSE-ConnectionGUID: XFmhQ6HbQ7aU0NQ93C2SUA==
X-CSE-MsgGUID: sNFmNcEHQOm3MGCp8xUFeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="12228741"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 09:59:33 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 09:59:33 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 09:59:33 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.6) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 09:59:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drOyJC0ax2goUNJFNO4IXnFS/jK0JEH/uttz/0LLp9pCtv+KXiGd2ldrGkEKU6MUF4ehsAPxi+NzcX/GTVUMhuGGQUE7c2TPjMU0LIkFVik3iCMYWhX+NyJzqEV4Ubp5s7G7xDSzeeNc+aqaYRRRUMspuNQOna8/LO8HpcXgfHtDe4q0/gY3i7k731nxgkZZNtJUc9nFrPgq9YqJUXgB1Y+p5dD4nHmGSJ1ZQXom3YM1pNBrPjBzospfvg+pURQb4fpQ5XE3j3ruAscc7ABl2LssX1BjFJqD7un3LMq3kz1tAyC2k5sHGhzQHCKFN/vJmnTENyIqMmQIJT0m+0m8+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiSI84YDoosyeSQy6GoB9iVNUzJDAe9IJ9Lysdy99lQ=;
 b=Knvx5CGtUwBWRGBzvXrCQJgkRO1oOwkqzhgn/+hqT5RvfRMIBilD+heOGvWl6viBwOSibtb8SXn8qXvIEwMQ36JWUe4S/nqL0xpjXKzs4gzpl+ybqy8dLnTX6L7todTisVe0Y2Ujo28dxvUihlOoWh+rcr48FPSs9cktWJsxVG0XiUIt2Yd4dzGaOCeP56iDgtE3qT0HpkWqkYd/GmejQnZMAFQdgeitwNm5t2wbyc9k77hc3jSD2rMvBl/GkuXt5hSmEkYTBSBNVIVavop8lAZJYAcIYZjVb6LgJY6xCB1bKTQAESpTMdbEDMACxQqTAQz7BMLfIW9pRR7XKU8+AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 CY8PR11MB6865.namprd11.prod.outlook.com (2603:10b6:930:5f::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.9; Fri, 27 Nov 2026 17:59:30 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Fri, 27 Nov 2026
 17:59:30 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <intel-xe@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>, Jeff Hugo
 <jeff.hugo@oss.qualcomm.com>
Subject: [PATCH i-g-t 5/9] tools/drm_ras: Show and set telemetry fields
Date: Fri, 27 Nov 2026 12:59:16 -0500
Message-ID: <20261127175914.784751-14-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127175914.784751-10-rodrigo.vivi@intel.com>
References: <20261127175914.784751-10-rodrigo.vivi@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:a03:180::49) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|CY8PR11MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: dd2de198-bd13-454f-d81e-08df4cb02f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|56012099006|261022105027099003|261028144727099003|261026140227099003|261102123227099003|261021123027099003|261022075727099003|261021121427099003|10067099003|261009223027099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: dFM+NF/gmpk1UCI8C/9wZ8M5z59RU6wURIZc1qFokhZEPaCQPyNV+ouZifUvBLmT7zGwAGpu2A7LJMNKw/u5eNbXuMou7iBiRrHs0FOFXAgycm/Csp2lau0aLZ5nTngR629xQDkpsIlO8b4GIBvZWyP0QRirR0H6WnNRc6/4i7g5C5pF0qcvdpwHjHOZPtyCfjgLJqlNURffs5uIasRmjiE9N0u4FEjOIcWh6EGs3f8uABTrivV82KSNyfU3rZ03TTIZ/1wXdOIaxiQHn7z8aBNViblznjBxFzP6WAPzrKIKPBp/h0kpuc2vDHKGiQTho2G/2NJLWWRzmzTU99gp6DAH5IYJCeRwwux+c8bB6SSeep5HhMdUfzEJv4g+SuodVtbrjCR2Kd3MUI/MWkcTsXQWuLvhOKeYybPJegvZAjKSspJEU+GFjf61A9YoO4SUe4UoG3e1MzIZpuEqSFXTR+zCBXFbKiJOta0xL7rip1XOgGkcrB9jW5294Qswwu+ZIqWLHe0eLUMbNBsrEStP5yl+KdwxRnoHoYqjjP7rl/BNyJWrJw9kQ0iqZbF48EV/eVegxPt+kX185ScA37DB0bVpkFV2+9F8tZ+9+8xQqMNA6MM2RC3PeTcdikVmdV9DoGo1TZENhfO5tzkLt1Z0k4/g0sBjbNy1BzYW523lpdY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(261022105027099003)(261028144727099003)(261026140227099003)(261102123227099003)(261021123027099003)(261022075727099003)(261021121427099003)(10067099003)(261009223027099003)(18002099003)(22082099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Axs1aYbI9bRKiA6DzB9pXhWvVWo8MLVGne6tV0QRAflPXiybn0WWVZ047jiJ?=
 =?us-ascii?Q?aHNiq6jfAajQOnWYEdSbhshaD47U+4GAI9zsWo2C/uIXdwvL/Z9L/K7yi+jb?=
 =?us-ascii?Q?670QrkDIUP8zca5vD260RxguBIYa7d8SLt3glR01XKhKrER1OvkGTZ7lRoV7?=
 =?us-ascii?Q?sXw5KNBtVdswe4eUopwpNgFlyL/R0o86Q99ZWnwVFEdwEAcHqsMAAVyy2W2s?=
 =?us-ascii?Q?UQoavwGKBxQdKlX0Qr7hicFP9ZPhOqsTKH3Ij7bgyXdz1bxVVZqYtu7VxlXM?=
 =?us-ascii?Q?YHpEzydgy3jfW+pBEfE73FjqlwCq4loe+toElf1fQ9x7+jo/cGvviKiRgpLr?=
 =?us-ascii?Q?mUSfB7has0SpJvMzAxzrmCzSD2ukhoe7cxO+4o5R72bqkn5/LFPZWDpVbsyR?=
 =?us-ascii?Q?qIdpWcjJp50OgWj+DGcMTUzgEbBmglql6uxtfYZOH4uHLToO5DtMWJFhkEfB?=
 =?us-ascii?Q?Obpgndd3BFcgf29VoIaDGYTps8rkn282vAnF078o265unMyN5goK/gZq141e?=
 =?us-ascii?Q?bQZWgVKekBgdzlXxJRzku9raLeo5bzbuXZQxRZnt0kfOCTqYFSlO0oNKUsdk?=
 =?us-ascii?Q?QHOBK5DtlX9MOtvZchsuvqgfmR1O/6/J9W+JwiqMQzY8J76HHU7AJvitJMiX?=
 =?us-ascii?Q?GxdneogeVE7tUK8CRf+L/aNuCxJEot4IV6wg5Vki/hAIXBOhko3c3qCGAW2E?=
 =?us-ascii?Q?81qr1ZikpTxmpIzkqTA+KoNjOXwokP5hFIoPMoAvyE62NrMxQbidlLgWG5Z6?=
 =?us-ascii?Q?DKOaEdrcABxapsSHRwhyqRFoeikj0gjZi+K+QAukp2iEgG9Ijvxmdz/J/80i?=
 =?us-ascii?Q?x8RTGY2U1/XIXVvvrhY8S5ia98ar0b7kzBtHZNQUxFNI2J2s1Py1Dy/9XH7y?=
 =?us-ascii?Q?GzpQdKVbL+rvSZJOXqOfM5C49u2t1dRF8PS0bdPV4W8B+HkiJum4OXaXpHsp?=
 =?us-ascii?Q?ODkSICncDVpRelHd5JXNGgkW1tZsR1iMyrbRUwhXnCgRDQAjUXtYzGAf/dJ7?=
 =?us-ascii?Q?m9+6CoJHalN6xeaIjlSkPH0kB8AaNdX4bjBMvlWw+ul1E1jqfOkFyef0/HNm?=
 =?us-ascii?Q?Q6y+vIcpNPgbzQLWAW8nZmVbvdluMdT6gDhIiJrh2ygZURiYNQ9GiYrVZLhC?=
 =?us-ascii?Q?CJKALJrXVGoQKERmZOZxFt5HQe4/GBesYZM4a9Ry3+qsOQ9UzzPv7kmvbk//?=
 =?us-ascii?Q?WzDbHoFuNikca8vlxY8VSN5E9LunA2I1je1kx2ElJP9UhHEaZezgs4Za61Ft?=
 =?us-ascii?Q?F6F0y1UyFTeLOkq7YCJqCG2Q474reLvU3bYldK/63phwNmNje6JvFb26kH6O?=
 =?us-ascii?Q?bZadlW6U2iRk21RRX/GyO6jUyDAx5bcwt31wfhS+TD43nfQcnSANbR3hNpQF?=
 =?us-ascii?Q?0os91d7JIjD4wZXP8LT4ftz0VlPekY5z9mqi08dW7gSzlVOZF7sZd2yhYd5M?=
 =?us-ascii?Q?mmms4mjLYvXF1yuvQu3C+XeDvzLOTN3PYqgie1+rhqaxMouMoMOHvPF8Qa1c?=
 =?us-ascii?Q?YBEwF4a7S+2Jn2CJ6QWk41fTNjl/l8DQUboyCn0a8U1xYmggVd7KUeHasRZK?=
 =?us-ascii?Q?nMFykV1hl8JveVxX1zPCTgLeRIsu1Si2vDBXrYbqr13ifio3qn+iSDnwaKse?=
 =?us-ascii?Q?Ikfko8gFQ62N8VW9QDaXEGIK2Hzo2l/yqCyH8bz7CQWDTU3NfudTtqTzeTg/?=
 =?us-ascii?Q?opREPL1OyhH2nEVh8/5yAZdoXEMElQp+HKEEannpymvibmOOiCWbotWWW43c?=
 =?us-ascii?Q?Lh8/FAnjjA=3D=3D?=
X-Exchange-RoutingPolicyChecked: M/YPUrxUbbQqPzUs4Et0Gzvl8CSa/cY3exvPyezL86r94PqPPid3JxhsvpiaO5+eImEC9h/Q8TviYlxP5n2ynxNYBds7oyNFm7SsQ9BLn+GvdmXi3bORbugq6YwjftV8AO6eVhj5sq3Cf649EsGKLkU/tFJS+FKZaPG+UNIW88rCVxqtMp1bUupFXOi53tDFFl9NHKBosmYrisg//WVSiXmb5Kze7P8iwiZRe30DRO+IIYnAMQ1GnkA9KPpEmpwupQd4lgc96UPxSzsZtxlgycCk45grh4VDyNLs+jm6j+r6SBOT+INcDiaRB7T+VnI7eAWDCoXlIa6lAfFsKQeB4g==
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2de198-bd13-454f-d81e-08df4cb02f77
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 17:59:30.6823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6iEBm0QcXWHRK8LII4I/y+j8pf/p//+SRUaioTSXRrcjcn2k3V04ByQ8mT6oELMlN5HV98rzPzTctMWZwHSrIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6865
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For telemetry nodes, show one line per field with its ID, name, access
mode and, for readable fields, its current value or the status reported
by the device. Add -s <field>=<value> to write a field:

  # drm_ras -n <node-id>
  # drm_ras -n <node-id> -s <field>=<value>

Build-tested only, no telemetry device was available.

v3:
 - Align the field columns (Zack).
 - Return the error of a failed read, after listing all the fields (Zack).

Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Tested-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Reviewed-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 tools/drm_ras.c | 127 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 121 insertions(+), 6 deletions(-)

diff --git a/tools/drm_ras.c b/tools/drm_ras.c
index 0af1ca919..aae92f99a 100644
--- a/tools/drm_ras.c
+++ b/tools/drm_ras.c
@@ -5,6 +5,7 @@
 
 #include <errno.h>
 #include <getopt.h>
+#include <inttypes.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -14,6 +15,7 @@
 
 static const char * const node_types[] = {
 	[DRM_RAS_NODE_TYPE_ERROR_COUNTER] = "error-counter",
+	[DRM_RAS_NODE_TYPE_TELEMETRY] = "telemetry",
 };
 
 #define name_of(names, i) \
@@ -38,6 +40,101 @@ static void print_error_counter(const struct igt_drm_ras_error_counter *counter,
 	printf("%u\t%s\t%u\n", counter->id, counter->name, counter->value);
 }
 
+struct telemetry_fields {
+	struct igt_drm_ras_telemetry_field *field;
+	int count;
+};
+
+static void add_telemetry_field(const struct igt_drm_ras_telemetry_field *field, void *data)
+{
+	struct telemetry_fields *fields = data;
+	struct igt_drm_ras_telemetry_field *f;
+
+	f = realloc(fields->field, (fields->count + 1) * sizeof(*f));
+	if (!f) {
+		perror("realloc");
+		exit(EXIT_FAILURE);
+	}
+
+	fields->field = f;
+	fields->field[fields->count++] = *field;
+}
+
+static const char *field_mode(uint64_t mode)
+{
+	bool read = mode & DRM_RAS_TELEMETRY_FIELD_MODE_READ;
+	bool write = mode & DRM_RAS_TELEMETRY_FIELD_MODE_WRITE;
+
+	return read && write ? "rw" : read ? "r" : write ? "w" : "-";
+}
+
+static int show_telemetry(struct igt_drm_ras_nl_context *ctx, uint32_t id)
+{
+	struct telemetry_fields fields = {};
+	int64_t value, status;
+	int i, len, width = 0;
+	int ret;
+
+	ret = igt_drm_ras_nl_list_telemetry_fields(ctx, id, add_telemetry_field, &fields);
+	if (ret)
+		goto out;
+
+	for (i = 0; i < fields.count; i++) {
+		len = strlen(fields.field[i].name);
+		if (len > width)
+			width = len;
+	}
+
+	for (i = 0; i < fields.count; i++) {
+		const struct igt_drm_ras_telemetry_field *f = &fields.field[i];
+		int err;
+
+		printf("%" PRIu64 "\t%-*s  %-2s", f->field, width, f->name, field_mode(f->mode));
+
+		if (f->mode & DRM_RAS_TELEMETRY_FIELD_MODE_READ) {
+			err = igt_drm_ras_nl_telemetry_get(ctx, id, f->field, &value, &status);
+			if (err) {
+				printf("  %s", strerror(-err));
+				ret = err;
+			} else if (status) {
+				printf("  status %" PRId64, status);
+			} else {
+				printf("  %" PRId64, value);
+			}
+		}
+
+		printf("\n");
+	}
+
+out:
+	free(fields.field);
+
+	return ret;
+}
+
+static int set_telemetry(struct igt_drm_ras_nl_context *ctx, uint32_t id, const char *arg)
+{
+	int64_t value, status;
+	uint64_t field;
+	char *end;
+	int ret;
+
+	field = strtoull(arg, &end, 0);
+	if (end == arg || *end != '=')
+		return -EINVAL;
+
+	arg = end + 1;
+	value = strtoll(arg, &end, 0);
+	if (end == arg || *end)
+		return -EINVAL;
+
+	ret = igt_drm_ras_nl_telemetry_set(ctx, id, field, value, &status);
+	if (!ret && status)
+		printf("status %" PRId64 "\n", status);
+
+	return ret;
+}
+
 static int show_node(struct igt_drm_ras_nl_context *ctx, uint32_t id)
 {
 	struct igt_drm_ras_node node = { .id = id };
@@ -52,6 +149,8 @@ static int show_node(struct igt_drm_ras_nl_context *ctx, uint32_t id)
 		return -ENOENT;
 	case DRM_RAS_NODE_TYPE_ERROR_COUNTER:
 		return igt_drm_ras_nl_list_error_counters(ctx, id, print_error_counter, NULL);
+	case DRM_RAS_NODE_TYPE_TELEMETRY:
+		return show_telemetry(ctx, id);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -59,28 +158,35 @@ static int show_node(struct igt_drm_ras_nl_context *ctx, uint32_t id)
 
 static void usage(const char *name)
 {
-	printf("Usage: %s [-n <node-id>]\n"
+	printf("Usage: %s [-n <node-id> [-s <field>=<value>]]\n"
 	       "List the DRM RAS nodes, or show the content of one node.\n"
-	       "  -n, --node <node-id>  show the error counters of a node\n"
-	       "  -h, --help            show this help\n", name);
+	       "  -n, --node <node-id>         show the error counters or telemetry fields\n"
+	       "                               of a node\n"
+	       "  -s, --set <field>=<value>    write a telemetry field of the node\n"
+	       "  -h, --help                   show this help\n", name);
 }
 
 int main(int argc, char **argv)
 {
 	static const struct option opts[] = {
 		{ "node", required_argument, NULL, 'n' },
+		{ "set", required_argument, NULL, 's' },
 		{ "help", no_argument, NULL, 'h' },
 		{ }
 	};
 	struct igt_drm_ras_nl_context ctx;
+	const char *set = NULL;
 	long node = -1;
 	int c, ret;
 
-	while ((c = getopt_long(argc, argv, "n:h", opts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "n:s:h", opts, NULL)) != -1) {
 		switch (c) {
 		case 'n':
 			node = strtol(optarg, NULL, 0);
 			break;
+		case 's':
+			set = optarg;
+			break;
 		case 'h':
 			usage(argv[0]);
 			return EXIT_SUCCESS;
@@ -90,11 +196,20 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (set && node < 0) {
+		usage(argv[0]);
+		return EXIT_FAILURE;
+	}
+
 	if (igt_drm_ras_nl_init(&ctx))
 		return EXIT_FAILURE;
 
-	ret = node < 0 ? igt_drm_ras_nl_list_nodes(&ctx, print_node, NULL) :
-			 show_node(&ctx, node);
+	if (set)
+		ret = set_telemetry(&ctx, node, set);
+	else if (node < 0)
+		ret = igt_drm_ras_nl_list_nodes(&ctx, print_node, NULL);
+	else
+		ret = show_node(&ctx, node);
 	if (ret)
 		fprintf(stderr, "%s\n", strerror(-ret));
 	else if (ctx.dump_interrupted)
-- 
2.56.0

