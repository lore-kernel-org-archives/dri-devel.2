Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B482C4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 18:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49EB710E455;
	Fri, 17 Jul 2026 18:42:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="exrK6qDc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A92B510E2F4;
 Fri, 17 Jul 2026 18:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784313758; x=1815849758;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=3iQD+hlDjBl9unHeyWKfJhOfAkBowaj+Z7G3SGGdSpg=;
 b=exrK6qDcim9KOuODb9r7ArCKcy20eo29bxLyYyIlYYNlPRb1/7I5+Jsk
 H++ozrcRAN5iXIO759Apg9X/JdztndsVmlPTQ2zn1XY5X82BcBdCqE3dM
 cbvvzsAE8WLnvyI/mOJ7YIOM2vFuoD7+z2DES+55lfJ9ptG9iNJ8dDGCg
 L7hg0tjtE+vkoiPAfHJbn5IJqIUKfzZwoXwu8e5qg77JGwelHBa2JL5Py
 dllVr8dqmK9iSmSDt+LUBTTYniebSSvHfhcEVUWPxHVm4adWsiApix0K4
 l74ne9kqMzOPjjc43895qmAmKq3AUULi2NFmmI2iBkysZxI8xmv1WX575 w==;
X-CSE-ConnectionGUID: /uSpZNQsTN6r84dZ8mEtlA==
X-CSE-MsgGUID: 0EKw0LvBSLifI/ukNtP7qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="84871060"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="84871060"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 11:42:37 -0700
X-CSE-ConnectionGUID: X8faj9vKS/OVygX+Rym/fQ==
X-CSE-MsgGUID: 3dQDfEjYRL6FuCy7KflmPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="255686630"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 11:42:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 11:42:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 11:42:36 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.11) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 11:42:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzIHx2uXhPG+YjDWMZPRrxmuvLNFoNRmVil5QnyqGjSjLPkrEEA9ac6yujR5Gf4oy8h+C1g3DCvh9QFh9K+b+JLVrRVc7OPsf2rqm7Tml22A9hkZDN8khHf4BwDtQh2F0sI+9yxMYzIRy+OmEq7Gd3Kyy12CdzBsZZyebD7aJfG7ZEFG1X6p3cB6XLWuQZQbUw+1JLxqb3GS8bfKzrkEjY7SuRawLdjfKPHWFA/lA1dmQ7kVNguOEQtfkE5CvaEJpyjUXv9rUinFwA4vxZxO+loNYicfA2BLk4AQXcVCN0PruIYJwPZGn8JgnGBHZUwNSi9uPJwsD2j+A2TkRET93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCVQ3H7a3O2+JLI7EfLGB82jKEqKpd/BFV1z1N3y1Mk=;
 b=w5qTNnKQv7TslGIOuapnxOfZ/EVf3qyyKFpXJ0vrqnaMRJN7pH9JyIAYkprhKTxXdUy4puIXubaLT1XnWM0GcOMfJQpUXA4VEIlHEun45GfesDqdtt5JAkqbBJGPL2dtmzybL29RAcHGLiqJP3YvwsHAQHZ9e/xUvnTBWV8Fsuz6WnqO+F69K3+kjk3V80Fd80fW3L3+Q9ZlWiXgLKU8cg/4kXL/vo8fYmjuaZFWFkgiXiqs3as6Qwfll569vxSZajPQK/cjw6h/u3AyS3vm4XYhH+SbeIi9VWpmrTCHZRWKZ3pCZrc/ypsZT0Fp+5MBDY21XU0Zuqr66rHFrESCWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by CH3PR11MB7914.namprd11.prod.outlook.com (2603:10b6:610:12c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 18:42:33 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 18:42:31 +0000
Date: Fri, 17 Jul 2026 14:42:26 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
CC: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, "Oded
 Gabbay" <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <dim-tools@lists.freedesktop.org>
Subject: [PULL] drm-intel-fixes
Message-ID: <alp3ks0K1ZsxUC05@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: BY3PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:217::19) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|CH3PR11MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: bef016b6-7c8e-4d6e-d8b0-08dee4332909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: /zcwhNghFlwa62FQZ2WgDwYFk4+bfvV7Yu3f2ul7kg3dPcHz9304TB1tglSGEPlCEvkLmVNTlMqz4UED0a7TlpRuKA4H84aJUVnKP6RHglNIg5dtRtt9RrJ5h3TM2UTP12oI0cudVmEPkyHWYE/TtzbN2lF1cFHt0LABkPSGuT5Ytu+A51G6g/4FumoVf3zVom1PUiSY8sTGJkXsNptVoGBP3zV45tHpUM0lhibMzzMmtfaHuw7ieDyUlOAABwlZZxstireXkW+XjIo9Y1USrXWl1oyfIdNl9W5BM3W28SvtjSJNTMfKfJBEHZctnUIJobyLKoUlZVnfVNPJqVGQa8A6MJnQu21v7GXaGSJPUXKWiga45ypm0nFpWd66mEdOX/vZUqBgiNwlwslGjUCTPwXQYzbzur7eIRof+L6Aim+R215MSf3bUEvcoUoGTe74OyiCsRxZt2v9r4tSZjmbYLTED2Emp6fYfgZTCmASx2DHw6bz6okEPAwiULa76jEGDoKDdAfWd4v0FjKTr1GS80ugAIXFwN10dqu7zhSZR02qPCtDoa+g7usS0FCfizCY5mqwWpGBhNC++WQxK4UM6GAVvYbl5WCqX1ljnknjWcd8aioDkuFK0IlSopjhdo9D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/HSjVOdmjXUzic2gheSpjyaAOq9sTMlwEIZF60mDjKtTbFatnRKm22TCGsrJ?=
 =?us-ascii?Q?zWXQzHZYZprIfI3PLVSOLztnDL9bOClIRKuS0mUf5h12NOuI6vQwpI5G0zlc?=
 =?us-ascii?Q?JLDDloa8Ouje1pW9RBMtkMt9L2EhoYdpoxkZWM/vYuImR6HSMEFE43+Xsw0S?=
 =?us-ascii?Q?UWRR1ymGg5+EX0WUQughGL2X/wbeGpyIdQct4sKwb4DjiTerxlhDbmKCqjYj?=
 =?us-ascii?Q?Y72haJ23cGIlTaJhlkTkxPfegZZgDFKypThb7mDrTajAFOt07Uqk3DysHMmG?=
 =?us-ascii?Q?4iHXjq9q5b6gdL65KD3IjMJiKpMPMQbpSszjvSdx+4/4wJvohWYLVjAI6GFh?=
 =?us-ascii?Q?VihhkK52iPCWYpA1s4Yyr5rbcWdwGqmZTAR7hsX0sdfVOnZh3YSbycRT1LdX?=
 =?us-ascii?Q?SQGGqRDugxPAQgO/WfwclWuNlWjxm0Qgi9PW9aG/ZwFdPSrOJAqCNSzy3+NH?=
 =?us-ascii?Q?0baUq9JvQ5VqA9MHKe1TACBs9ZcFdKWW0J6MRZw8LAGxTUWSwH8GDSNDyIv2?=
 =?us-ascii?Q?mUs3oVKqqCOjZO/4yrV2kRIfmrx3EgNQRfr8U6VrE+eQj2BAynt6O9XU/KcE?=
 =?us-ascii?Q?hdKvCLtFjLWvyfkegbB0ThsAsVDDT/tAZlZ3MgsBmD45YNM3iQc3WkUH60hp?=
 =?us-ascii?Q?cgLQAJFYvUuIErruYX54eEklHgpTs8lghx2BEnuF7a0iL98WgFCxd187BXHW?=
 =?us-ascii?Q?zU1s8RYNak1m6IHweYYdL5T82gJVnlHQ+65zXOmI9O/5Lb2h8rs6SE2o7D1+?=
 =?us-ascii?Q?1Y5qXrhhFf5XwwEL79O3ySV78dkkakgXMoDdhTqmqlynlb+MJ95r3/Ngg5nP?=
 =?us-ascii?Q?w4ARG1XQ2F3AQ7mf/H02qrG8clw0hrUMkOtBuuDscs+JL/zS5xrfDb790Zwv?=
 =?us-ascii?Q?2J6qF+LK3uItS140c1PFD2jxrQ63Ub87WuYkSFQ4snznYJnSjTPf9NzPs7VM?=
 =?us-ascii?Q?kE5gQ5t3DvLTnxrb9KpGT0/ILbP+Y16qgtxBYWxklCy9xbl2Cgi1Fo0+6MYc?=
 =?us-ascii?Q?corDouVT9Tecf7etPxMMkJeLd8n00tXeHYoRk3xqpwhzfHeoKdoKvhi3/4KC?=
 =?us-ascii?Q?CojU5fMrQ1wriw9WI4S3B3JiQOAdsklloeJhKqu5+DlHDtv2rer8RiGYfx74?=
 =?us-ascii?Q?GDsG+9SiD8fVn9r61sgmV6AudPWqvYBDWd/m5sCjDoViTNxX5QU28ZeYOCyk?=
 =?us-ascii?Q?GR1HBc/ZuvmZlWmkMQdMjt2VojqdESCxBO1EZ1ecUT7OqLsOMKzfwrLYeHyA?=
 =?us-ascii?Q?bOVNBptjxknNkpmA91tKOCM1QS6D5yZcJ6QgctXEc9tyzabIIMX80O/HnFGI?=
 =?us-ascii?Q?evyxBYqvkNHmB1+avdVLUg9ik3Ljdo1tvbYUEOEou1UFGMRESHoAPII1dlMU?=
 =?us-ascii?Q?T+uDmqC+22L0pfHg/BxdDaOT24xHk4BAIxHG5gneHKbiSxukc8Wwo1vRit5Q?=
 =?us-ascii?Q?/GwSt76GIGLMPyCGuvjKQiTz557VIb8Y+j5C0Pryw5QtF2KdOhhqZD2kdd42?=
 =?us-ascii?Q?z7/ncDt5l2vLANBgGKLP5fmc9x58Sw+bNMazL0IcZpHsA9iRs1Tjt/QryS82?=
 =?us-ascii?Q?HjZOtYkw7FNZJkataHCpDQPxNq7fuWCodD5nEyAjTxzU+gVgSYAWAaenjqgR?=
 =?us-ascii?Q?KZs8KSpBtmXlMOufo8o6wsFvEG2QJG4zcapsheuiE/j21wyQYKoKjegE3l+L?=
 =?us-ascii?Q?nL8d7YG0Bc2JzpV5nH7re9YOVnoawYCYVMFP0hjxBqIbugJ52E4ku3y5gn1N?=
 =?us-ascii?Q?zkx0MOdigw=3D=3D?=
X-Exchange-RoutingPolicyChecked: Qa189QX2BtARDhYE/EYpxgaq1w8l88kqWQhP5gzMl4fFZlsZ0iE9MFsQXuPKoR2f844RW8m8SoBo5hQlsnUzCqGIdiq8dg0+1pErZMWDxyAW2equsDcT+Jz7sQYMJu5TkxZfS2tjNGBr3fe7VJmrIuUwXTjye61Fv3db+gzYQhrMpqc5RJWLZEzRXarn4cS1auA83tS2I42JpPA58fpuOu8UTNnTY7bKihpu1UKDjb8U6WbPOP5XCiPF2YMhi/ZAJ9LXxG7R1uPllVpX+cNzquCRoC8L4S3yMAGiqIBv+XNm5fyJnSRNcd/U5VK9GERMRVETr6FaftHg87aXg0L1CQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: bef016b6-7c8e-4d6e-d8b0-08dee4332909
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 18:42:31.8538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6pDDnFj7a0AQ0vt9hy8XxaDr9PGVWRcC+MdMu7dcKol2h89rouYhmhZv8QeNa9DXXt08XXkyvSAEz995TRMJNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7914
X-OriginatorOrg: intel.com
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

Hi Dave and Sima,

Sorry for the delay on this PR.
I had noticed some strange warnings in our CI runs of
drm-intel-fixes so, I hold on until I was sure it was not
getting caused by any of the patches in this PR.
But everything should be good with these 4 small fixes.

Thanks,
Rodrigo.

drm-intel-fixes-2026-07-17:
Couple of display fixes (NV12 for bigjoiner and Watermark clear
on plane disable) along with couple of GT selftests fixes.
The following changes since commit a13c140cc289c0b7b3770bce5b3ad42ab35074aa:

  Linux 7.2-rc3 (2026-07-12 14:16:39 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-fixes-2026-07-17

for you to fetch changes up to 612978b83f45bf7018815209db5395d759db6f26:

  drm/i915/selftests: Fix GT PM sort comparators (2026-07-16 11:27:19 -0400)

----------------------------------------------------------------
Couple of display fixes (NV12 for bigjoiner and Watermark clear
on plane disable) along with couple of GT selftests fixes.

----------------------------------------------------------------
Emre Cecanpunar (1):
      drm/i915/selftests: Fix GT PM sort comparators

Pengpeng Hou (1):
      drm/i915/gt: use correct selftest config symbol

Vidya Srinivas (1):
      drm/i915/display: Fix NV12 ceiling division for bigjoiner case

Vinod Govindapillai (1):
      drm/i915/wm: clear the plane ddb_y entries on plane disable

 drivers/gpu/drm/i915/display/skl_universal_plane.c | 33 +++++++++-------------
 drivers/gpu/drm/i915/display/skl_watermark.c       |  2 +-
 drivers/gpu/drm/i915/gt/intel_engine_user.c        |  2 +-
 drivers/gpu/drm/i915/gt/selftest_gt_pm.c           |  8 +++---
 4 files changed, 19 insertions(+), 26 deletions(-)
