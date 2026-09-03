Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074EAC61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 20:15:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ABC610F76F;
	Thu,  3 Sep 2026 20:15:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MFVigoPy";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B888010E464;
 Thu,  3 Sep 2026 20:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788466500; x=1820002500;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=iZGUdHfhiotChU8TV/+miiS844owm0TLegjV9y7ZZWw=;
 b=MFVigoPyMh2jv8PHGEvNfHWugv2vjUhz7O1RYqlKE+4vy15C60aK6y2I
 /oaZXAhRoIIeeLVJW2KE7CNvFFSIcG8TDxEJWPwokoaNdxoiINNZVu2c6
 yDKXtpivmArVBPjrqjqRD4oxCzAx/i33ocjXBocpjxT1w5Ir+Zq3XzT+F
 uCcksMUwHnu8uZ2gSSV26LrzS99JGLYbGAW8y+Wax5KcuLMGVxZzCzEAj
 9WuFZP0EEpOTH1scEGegt9z1vIhgn6YQlJwPkp7rOYNloR9GH3QXAeohI
 n5WKuXL61mKny7PifJy2ITf3+aToMGLEBpQLAoGeTGDDegzwwOLyuLsyd A==;
X-CSE-ConnectionGUID: CbK46aaXReK1ewxZ9XSSJQ==
X-CSE-MsgGUID: HldPQe+xRt+JZYdci42Diw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88885623"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="88885623"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 13:14:59 -0700
X-CSE-ConnectionGUID: co8YX2xRTbKYQnTIBildRA==
X-CSE-MsgGUID: Gh/rkezpRrSCa6cPHzO5og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="273981376"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 13:15:00 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 13:14:59 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 13:14:59 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 13:14:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRFpbrkujfUsogRnBM3j/zg2JuV5Zbt4FNgHFikBDSPV93ditQhalzxt+UmDDs50X98Y1PgAUgnwKBSK474l1xhXTxDq9MO9ZhQ6nYNVpIFTmFW9GjTRe9Mdx2YHvuMz98NAnodqwpKZWfQLFTuX/bt3urKmYnc4a/Tgu8nDB+Q7M5W8RPPpPDj+ZZmfoTSHXO9kA/w8LzO7v5hzlZ2smZ5zyoiqkRHq8vOoEAXQG/zkAio2NObcX//H8KYAIRrY68JC2alCriHhU/409Wi8Yk0eia1BL6i/LeFt2+OhGRy3m6ZqbOhkC+im8FtzryF9pGd+orUSYF7zq18t0YSa0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9cLTn5X/X6BVl+d2tRD8CI12MGc/6q/NkX7UGfcro8=;
 b=di0t3KGKNfSzgz+8kR0IrIJ5Ds4vjlw9wCtOZx10EcEDpe+ysWjp04PFlh1XaDh6xNRV8VRFGKtChS5mghleZpr4PpATlPP/CfCscBPcfdbJSTebgqmdPmZjithDSDFGUTDTweFL/JOG2LZNtOjzMD8rr7bIjebdPRX1lGRkZMPSXPHFg3++ANeCQo3+ZrCHrPu3ioxh81WR2ZVRY9wzt2CuQ3XTDY4ZDbcqhErqfVrrjBbZ3TwJFgct9xqkM6gbhEUCApI0syF524gdbYdYrcYy1XSoToleJRKmpD2AnVJrplZHnhgUudhVhqkr4Q7Lm55B7WPMBiIs7tSD6ERa7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by IA3PR11MB9226.namprd11.prod.outlook.com (2603:10b6:208:574::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 20:14:57 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 20:14:57 +0000
Date: Thu, 3 Sep 2026 16:14:50 -0400
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
Message-ID: <apnVOtDv4WAIoj_X@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: BY3PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::20) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|IA3PR11MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: f95bf588-b284-40cd-dd46-08df09f8062f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|6133799003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: WYJgLV5S48V03vsysAaHY2kydXHRNPs08/kyuBGI6EttRwVGhVN2mmX3+uVR0k29/eWz3tl4JqQsNQnb9YG7Kr2d8gnotw2v2zRUSND4dtnPh4NnWTTKNVn+hBeiqayWZlu3E/IqhahqPjP7g1URPRV7hUmtPO1umgE0FMzFigN1RPHmWZs1B/pVKsNK/HYgPgWzIo1oOAnnt11tUgI592gUvqmBIxDz3WFJfc04hAKUO6NFasFuyT+JwZNOcXIGdcK1GMt4GINy8t8ngpv8YEJitroQUPe7ftTxTWn3hpf0hcKcOFIGAjiuXJyZ5yYSC21QXQujUD+YObvbUhypnkKWTS/7uZ/urZtCsGS9YcPExspspW6PHQJK87lOhM0zbnpquiaG0EllwjK8/xTYCTpqwY6yfdf/LhcdL9G+fLNN5/+SzH2wKASkqrBFuEUu1DlIDQth8eh/tWMomEEtD+rGZLDIyi86s2+3/peIadNLr74GHUO5p2a4jlQIZ1/SoNhZC71Mt3qlGqJW9egAEpWEOay3WqdjdNb59wRG2v57ko2EDP1BC9JzpmgOCdx1Covf6SxYRMYuXv6Bl5jtG5nR5h/hWcVUEXxDomqcGFXH+tyn9YhWozpf79q6m8aU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(6133799003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MomBWoPtYze0B2lmM53EGi89xxKcu/N4+MmtC9Ve8HaLvzfN1kxz5smwkCrz?=
 =?us-ascii?Q?7QO9L6MchixRuFcU1aHTKLAMZsmLy34cQRr3rWo8nX0olq8asWKLeYQeQbOT?=
 =?us-ascii?Q?cAU0iQcC5hbROE0FObxhWSN80vzgH7gSwo41R51snvff5r4fgP8uj5HV0q0I?=
 =?us-ascii?Q?F4XVQgkN+4874cZ/XxtKOWLcLb1fivCzB7L26xvqxGmSO9/UiqHQJGenBFbt?=
 =?us-ascii?Q?CstwtJy5N8uVSuCVnyhJJD8VKy7eH0EBRrV+S4vwnWZZ8pcYF/xd3US0vpKq?=
 =?us-ascii?Q?3ctCKythQlaWxle4EvpfB9AbP+fHcmmXeYTod8qzV+m72BResImXRfjtx7vo?=
 =?us-ascii?Q?/lAWftqaJ+bmHBd3nCLq3DlAZonjnjWZEvTUNZzZviW8uxySZpIKTRVwvCiD?=
 =?us-ascii?Q?e4P6+W3q3I1x0W7ZXmjy1ArUuV4yMYtG95qPUqKW9UJSnGSaNDC3DC+a4L/g?=
 =?us-ascii?Q?J21nDiOWguQF5GFzeVMHfHw8RpQPW0SFtyx4xs6S/vo/K+oODeZumZZ7GTjQ?=
 =?us-ascii?Q?q2y7VlilFkSVHj+fa5yA3aDA2ph9EGsohCexQrA9XlGvWE33jZoqUVXS0Tt3?=
 =?us-ascii?Q?gj+Pziz0wV1+0GMeOdzW0X1WjcVriumdJ5dBQR7FAawkSxkjwz4MHixKD3nC?=
 =?us-ascii?Q?hnvDpg7l/+UO/Ypv9VLPjKx9cUWIaajvfUaBN0iLs4mdH9FUjgYikVqE6aTC?=
 =?us-ascii?Q?Cqgw5tSJjYBd4wP1enibrBRGK34EtQ8JuiDddKq8+v309M4oEgDSQ5T4JXlx?=
 =?us-ascii?Q?9ftg/tpPaYtGXPxXO2uade0NATZVV4DN6d58il5eOJBBS+liK35lbJRjGDP2?=
 =?us-ascii?Q?LbdR5K2fhCECFHvi9CJfQNEpSooPnkTx8Y8jwtOQv5tGVf1wP8LpgQwNNHSW?=
 =?us-ascii?Q?PjkB/PMoetHYP+KpdblxYgmf7RvY5JrpBSv8jEd6N81ZWDJncjmnoZzAJpge?=
 =?us-ascii?Q?Mi2fH31dfc81xSs0rRXMy0FimohHLGZGTMjEyZL4fW5vJi1dqyzuE26PoilJ?=
 =?us-ascii?Q?F+D+go79X6jANpFY92s6r8v8pwOJuN9RvPrXICQd74zRhT40FfO7DrPO70z7?=
 =?us-ascii?Q?rwYnuni3zGhiQRhspg2sH937phA6zfWNJHqU9//oTtHatNoDNl5+h158fIYc?=
 =?us-ascii?Q?JnQbsjOOpP7udMSFZ/HtwyYuwxerd0RynBzlHZVhUpq5OvaDCku9mQ9buS/m?=
 =?us-ascii?Q?db3o6m0Txbs35H2tIOmNk29r30WPa/ufWci9yksv+7XFMxlincxUsVDjSavj?=
 =?us-ascii?Q?Ccf/B0Zze5+r10wa+39AjjALWk40lCW/9GCX5+8NkS6BkgXagDdb+Y1MHD3O?=
 =?us-ascii?Q?vLyzXVPNqSe+pDmVENAxotHH4YrCGhINm8DogGZcNNDI5v/pQqrz2suYkVoV?=
 =?us-ascii?Q?aUPtc17HIAkJ6W84/PiBrKd51c7an802IHa1/Zs1nW9ph0TAOPb4C99IKo1K?=
 =?us-ascii?Q?5aeLKTQaQWrGSLK3vmZO4KzvIHgUAO+3ryESIfzAdDAUfJfKjB8pbDmYaqmI?=
 =?us-ascii?Q?SCjy60/mftvMHizLxbr3vSQtB5IhYHnMzmww4Qrlr6J4foVf/QaR7YBPp0YC?=
 =?us-ascii?Q?dIkl9LCNypsaApDJB3fiXqfgS1Sqc3tur0B3SK74nBQPJwUN0Bkn+2FS0oyD?=
 =?us-ascii?Q?ZpQqcqjFt0yzy8oNYyq+ILe+2meyOrBNWB18twvNOZ8dc2kLXgp9NMDNurdk?=
 =?us-ascii?Q?6pSmMELiKTAZHpOJ8yxnuzmK0/D0SdNAIdhGuo4clKvBUw3ScWqCEqfFdyq/?=
 =?us-ascii?Q?nn9xyjwc9A=3D=3D?=
X-Exchange-RoutingPolicyChecked: qFkMczciGaXYSfCkkU/WgZ61/LMFhcIGamjDIZlIMbx/KMklxgLDAEcQMv2jJqqEf2qYWnr6kTrf1DhNVugx21XKGHAELwmEY/GaJxJocESdnf0ExXwE4qobyoTuOyqw7WUXTR50n6U5cpIbmzTzjM+olxHyXhzpn0H3FsbQMXODZIGnpL7G2l0o5IszV9g1Qx7h26V5k3fNP2R8FKDBiCY2qt39d/IZL76w5RFLnnwpl9zI4FqwEpJZwU/GrTpL4oxh1zH79wLfMMD+J4lzWtWgwppSA/OVrwIU7WRGc/2ev+u1p/p9UI4O7qFhybOgBCC0ojWFPU7MYAYFWPRXxw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f95bf588-b284-40cd-dd46-08df09f8062f
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 20:14:57.2030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3yBZPp2GWCDAy7+4VvfVcotY1G71zW3lHc9ttBh82QNNSHrfp4dBeNJgSmoHWtKtvUsq4NVaO2UCHasrJ2n9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9226
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

Here goes our first drm-xe-fixes of this 7.3-rc round.

Thanks,
Rodrigo.

drm-xe-fixes-2026-09-03:
A small fix on the error handling of an OA uapi and the
addition of a drm_info message to report FLAT_CSS base misalignment.
The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-fixes-2026-09-03

for you to fetch changes up to 0e68c74e44da81a4599c52437ee1f63a2c234470:

  drm/xe/vram: report FLAT_CCS base misalignment (2026-09-03 15:50:27 -0400)

----------------------------------------------------------------
A small fix on the error handling of an OA uapi and the
addition of a drm_info message to report FLAT_CSS base misalignment.

----------------------------------------------------------------
Lu Yao (1):
      drm/xe/oa: Remove sysfs entry on idr_alloc failure in xe_oa_add_config_ioctl()

Matthew Auld (1):
      drm/xe/vram: report FLAT_CCS base misalignment

 drivers/gpu/drm/xe/xe_oa.c   | 6 ++++--
 drivers/gpu/drm/xe/xe_vram.c | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)
