Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35C9CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:55:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B86410E5AD;
	Thu, 15 Oct 2026 12:55:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BFDE10E5AD;
 Thu, 15 Oct 2026 12:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792068929; x=1823604929;
 h=date:from:to:cc:subject:message-id:
 content-transfer-encoding:mime-version;
 bh=t/bVQjIR6DTLcz+moZQF5aI6RLCCttofRqtQYhEY7O8=;
 b=VwzO9CB+JobJ+JUH/XT6LOFfnKH3qXx+HfnwuIMKGMqvz2TZzgu6vhTc
 e0BUvoc+nMuWqZPmPdgV+9wImcKRCgyyFYY/cmvai4RuhYzAX6b+UpUn3
 ItXXBLywLo/vXF9xv0GmUEngiLCxZRlwh+fmJlt835PH3cviXjsZMlIze
 pDFCq+tBHzWTbZDO6nzD/rzIxSltKIOmwVSOQZvPWmA9ZTANr13X2RVhZ
 olaooyU8e2kbaHfFYqJ5r6ogFr67GrvwYksAj/ylpjQxuirKgxc7PxyVR
 1GXW7tQFIaHQ3AjCXxOmdNfUy8MWfR7/4HIM16FC+inzI0rTEUDpaWYFe g==;
X-CSE-ConnectionGUID: /jf9rN3RR5Owk9ol5IxBJg==
X-CSE-MsgGUID: 6B0psnm+RV+VaqTqS0De5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="732457"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="732457"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 05:55:28 -0700
X-CSE-ConnectionGUID: K+7GnwHoS7W/sfgdR1BcGQ==
X-CSE-MsgGUID: W7piPm0HQVe8LknXR9xxXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1646178"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 05:55:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 05:55:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 05:55:26 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.19) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 05:55:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JC5pXJbVkN2Nx5xBm9UxiHp/XxbIttW099DxIZO89+/dvKgHUERVrT0ZQfvxgueXPclohVOl8QJen6xlN6t6Ar+LTt5wh82LRYURFWY2E/XS1V5Ar4TS9GGzdbQyfCacwnoNVPsTy5+dsmYON2uNn1ftdyDxfbJP9Jvn9now4nj0x9HXt2LAc3FKjDl+gvB5oPI0kDBneAoqMCSdf26TVTb1GkYd6/rB4X06xcBvEMPRHBeVQ9htebRfcV0QIBkYOBdkB4olfSyRNb+A4YKDqbPvkmVCLDD063m49ir/7Sw9Gyi+gFY8ewNfB8ymrhDt15cJQL9dKN9hzvmaPa7ehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KB7s0dVXFf31HenPImekwqSJ7XS5hlsjp9XyIdulH6Q=;
 b=MVvOgb6UvGumCW+9hTCjZoyM6eetopfvizJw2PzjqIxopYun6IshkL25hadnS3wBsIXk8sd9kY/yZIFSZUGFYzjysrCT9hNcIJryGKWmDjBhMIoUQ1TGml0ckEwoOzPP9DNg2ceSRsP3dDWMNLmSZQWTkpo8n7I8oYap5mcg7fFGmKKAvnkWdozo0OxfK0qEV62kQ5BgsJq3kBpGEDMG/NUltcyiGrYTHuLArDyCtEweeiDRmpjUrhGqRj1VVIEI14tHZaXm0JkKrkdTDKmcWr4Dv3D8qKoonRSC/mx+Qd5ikpX7RPIhzz/17C5TBPlORg22FBaw55wqYN0nizmUeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB7181.namprd11.prod.outlook.com (2603:10b6:8:113::13)
 by PH0PR11MB5046.namprd11.prod.outlook.com (2603:10b6:510:3b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 12:55:18 +0000
Received: from DM4PR11MB7181.namprd11.prod.outlook.com
 ([fe80::89ec:90c8:3170:5f0a]) by DM4PR11MB7181.namprd11.prod.outlook.com
 ([fe80::89ec:90c8:3170:5f0a%4]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 12:55:18 +0000
Date: Thu, 15 Oct 2026 08:55:13 -0400
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
Subject: [PULL] drm-xe-fixes
Message-ID: <atDNMV-Aohu6s0gE@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0018.namprd21.prod.outlook.com
 (2603:10b6:a03:114::28) To DM4PR11MB7181.namprd11.prod.outlook.com
 (2603:10b6:8:113::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB7181:EE_|PH0PR11MB5046:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f98b405-bf74-407e-6707-08df2abb905b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|23010399003|376014|11063799006|56012099006|18002099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: +b56zQ7t0mORZlH/ouw7+if/5EPTUge3SsSoAahztRMhitZJs2ITj9s66n3Ah1SZNwc5ggwVAtFFofCqy+gl1LKWfDqWjP7kbOQwqDvr+Y9lHnW25EIP/hBLhj+EXH1LYzhgw+BuD7KW+nHt5gf9H8X3AYDzHyFRqZSRfkqsG3QCDPQmMDb5et7fCIquthvV2SHhyoG2lkIOc0q3YanWuCdafKI+F6yBcpJ+rtuYPVTrQykVlfejT/6ZljY8oqwt8QpEF8KCfUnj5rveIIM+xJ0JGpAuI7aQBvmYZAnZxAZWSkowXj1HMZNz+E73L8v3S5t5bT6Fk+RUxC9L3dS2yXTbjrn6J8wn2pcbdPCcjxbxNs02OzhwlqxFZYWp5VzVSjxMsM7hlsU5yX+Fe7hgzNzyHjtb3Fcq9BtTBgYoxwSHCrsLBwOJD2/ssnvtO8a4T9U55LI5fmQ3lkBsXEId9YUCIXiU1Ue8Hu71sU8Ms83qcwrKYmHENLtuZ/CJZL8LyTMssDipy0IyKV5EuxZCNhxsypFSOT5kmh8HfHIdvupQnSO2Fx7T7lsjPlqex9gylw71a1Jzlf9vVStQV2a14R33lslmhICwX4SoBj4Ri3NUrd5uwRQt8W31hVauxSKo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB7181.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(18002099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?dePvNuHE4MfcCqGzyhVo4rQllXAQqLCFwdDMxGGr/mjLVXUuA/8O+hr/w1?=
 =?iso-8859-1?Q?oIwjr+h3izzkjxDC0TgAvYXOiQ7vybS45YsvG3cgL1aG3QTp5HX/l+Zbqx?=
 =?iso-8859-1?Q?JTVab2+DL748AAWrlfh6KZ6fTCkB/z6LSN+eDhl9sj3ODp5uBK83gtWdHt?=
 =?iso-8859-1?Q?JGalM349b3wLwiLX2/R4YKqz4XeJ+wPRW3xFUzciYkrkP23k1dkql+68Hy?=
 =?iso-8859-1?Q?1drF08ip0WK2pdbQh5FQ5FBpwGX4VttYXfpA5V2nVX7QDLRMv+IkqTZ6zm?=
 =?iso-8859-1?Q?uBya3IjCpbCcUqGEMWkFvyR7U37rzIZpgd3GXPHE10YgK+oBJ3c9bIJdOc?=
 =?iso-8859-1?Q?lm4Qrego7uFFjoWIZ2jmXBhXRBvEvU4rk7sJTPwY+weeUjfg3YN29P+2NX?=
 =?iso-8859-1?Q?pnQOgvULB69W9+cXO99ud6lhK9yz/QTxeeBRWeGkiYa99Gq6/lYboO/RIs?=
 =?iso-8859-1?Q?YyVWWUzHx5pE2ATzSPTdkdrbTNNqRIDeWqH/Qj6Wr41K6ALeLMjIcr9viQ?=
 =?iso-8859-1?Q?V7JSzV70wRSLcYiU0LlSmYzNnVdzakvdLT3fzwGGqYHEomYmorEwR6lvan?=
 =?iso-8859-1?Q?S/FiZdW0HpY1PKcKIo4U+7rsd4junzqKULetAxZitqm7e1iy/HQTtkr4Wd?=
 =?iso-8859-1?Q?XL4Ag6aQ12p8iNedLgJUySW9gae6c7RdsIwbgWebTSNIHbNsR8uQBvnZa5?=
 =?iso-8859-1?Q?AXl79BItoJGACT3oWdKVgJBjt9Xdlv4+fh1XbvEU4blUGPr1xGJlUMfdSH?=
 =?iso-8859-1?Q?TLyTz0H9yksUrbMCESm6E3eWAzpmoy9TWr2cybxzNXX5ifeLAagyo/G0mF?=
 =?iso-8859-1?Q?4z7OJn2v4xQnWfCgWq7uEm5IwRYKCJySzffJ4x4sVVAcEheSK5zichn6mn?=
 =?iso-8859-1?Q?iqivtDVm4W4w/R9l3vwpt47inO3V216pbQjysOmc+KQekx7nKJoIPtcrny?=
 =?iso-8859-1?Q?pvropMXUrtWVpu3jX/eC2i2kQhf6wmhbuzthcO5zXu8G1WuSdbrdXK4tIz?=
 =?iso-8859-1?Q?pi/TeFJs4pKIzgejbqi+MVoRuo4NhxjlMCKE8f0EDMJdQj8oPDmiwy/5qn?=
 =?iso-8859-1?Q?VaTBhD1VkZ5XWEXk5lXMpJ6O3jMMhCwJB1Tri1Dl4j+XLqwPYqfl6ryMBU?=
 =?iso-8859-1?Q?1uZ9AoWghJkK1CK4Buvs3HwftgzfYBcqf2g27uhrmVqd99a1E8WQG125Eo?=
 =?iso-8859-1?Q?4IMQmCHKHOn+7kFr4yLoTkbd0gJxTMbTYiTkIW4lW1BYJuzIoCEXdG3pmr?=
 =?iso-8859-1?Q?+twQzIiZkSJMIvh2uh/pwbIHBxFGAabPGxyquddPcMtI/4tblj7kZZ1C/S?=
 =?iso-8859-1?Q?UwVatZjUenVpHakBjZ1u5sTYCf+FYIEcrYMuTNkWSu57KoCiZtYbGPJgx0?=
 =?iso-8859-1?Q?d3yZwkW5wpc7ES/i77ahl0vNPqYou0KbNerpgnTnN09QKYF2v8uruK8iNo?=
 =?iso-8859-1?Q?rhwbpHhgsiMjBYbdDdO1TSTSusvbkpjeSOuw90lHCfwjhuBrp9g0UW8xtC?=
 =?iso-8859-1?Q?Th4AC9Ldd63DNJnzbYJOp3MslYuL21cvVHI3w8m+etH960G/QPgmhZXYFX?=
 =?iso-8859-1?Q?0jfjBvXhqzvZA6XOE82j6y7AkH5p4FSA+/fahHf/1QHnd6cfRcbMvaO9nS?=
 =?iso-8859-1?Q?OJ2H4DNQI8FsGgh715OQ2RVitTWpNAzKqpRO3y4RtJg2pz9LiK40eMmr7L?=
 =?iso-8859-1?Q?zrh/VJhxe62N3HWfInrqJWhuY/fv0iJv2HN6u2G6ihKsCsejXX58gLI9At?=
 =?iso-8859-1?Q?nGpoUuqSjTz9Rw9b9OPXeKsGECxglfdib+YROl/7uYYAKPLakkyjM6lgCy?=
 =?iso-8859-1?Q?kY6JTfVOWw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 1lMrk+N27TL9IwhFNHky0zlcGSzMNiBdjuV+TvwZk+ShXAliQ2Qe3B0MdeKRcKod7lV3rwePnKp5TOynM1dV0sU7oo0Io7zFIq4aBvLJbNzAnqcLty7C1tufaeGRtJ5/eA46fxEHEaj3zDaM9dwXY4JWUkS4hleTUlox+LAPgDu7HPsbauWYSeckRAZVCwEabnihyx5bCqLl2hXKOD/7IwoyBLyfyDODgJnrjhDmBfuunwUUoJsVvb2Yvc9/MRPVMifAmQ5qsiiVBc/a9zKMumHkMjC5or17BNlQ4bAeg4M3aNStRIge2LpLp6TwHP6hvvCPAG4oYpE8syKzGCSBKQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f98b405-bf74-407e-6707-08df2abb905b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB7181.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 12:55:18.1621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNqSu4Ul1Xp0jAONhr5Kbw1iyuD1numY6K54rPRX5pzRaGUZ//FjIhAhM3dNWkqtNpxwK6bR9uSmeb3vRj4MUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5046
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

Here goes our xe fixes for this round.

Thanks,
Rodrigo.

drm-xe-fixes-2026-10-15:
An OA uAPI fix by zeroing OA buffer at allocation,
and other 3 small fixes around eviction and shrinker.
The following changes since commit 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907:

  Linux 7.3-rc7 (2026-10-11 20:04:55 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-fixes-2026-10-15

for you to fetch changes up to d2ce8fcd778ee6d92748c92d23a56d4416c29d86:

  drm/xe: Bump LRU for external objects on exec and rebind (2026-10-13 09:57:13 -0400)

----------------------------------------------------------------
An OA uAPI fix by zeroing OA buffer at allocation,
and other 3 small fixes around eviction and shrinker.

----------------------------------------------------------------
Bommu Krishnaiah (1):
      drm/xe/oa: Zero OA buffer at allocation

Niranjana Vishwanathapura (1):
      drm/xe: skip eviction of a BO with no resource

Thomas Hellström (2):
      drm/xe: Don't transfer shrinker pages for pinned bos on purgeable state change
      drm/xe: Bump LRU for external objects on exec and rebind

 drivers/gpu/drm/xe/xe_bo.c   | 11 ++++++++++-
 drivers/gpu/drm/xe/xe_exec.c |  7 ++-----
 drivers/gpu/drm/xe/xe_oa.c   |  7 +++++++
 drivers/gpu/drm/xe/xe_vm.c   | 31 ++++++++++++++++++++++++++++---
 drivers/gpu/drm/xe/xe_vm.h   |  2 ++
 5 files changed, 49 insertions(+), 9 deletions(-)
