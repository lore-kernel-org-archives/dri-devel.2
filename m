Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE21C79FAE
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03E8B10ED4B;
	Tue,  8 Sep 2026 20:22:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IwI5lKJn";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 365B510E177;
 Tue,  8 Sep 2026 20:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788898957; x=1820434957;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=fnz8DKFcdf8L5RpYzsp+oChwzZ7qkrorOkv4U8OEz64=;
 b=IwI5lKJnPSW9BC/FfCiY6WqaeYNE6O1eH8HwmcoZDIIPRepHZnWPU3HA
 Su4gaL3vTDHYwEKDqIwkahamlIk2kZbTnvFhg5bLt34OWAfgcApJ44sil
 ZcwGCJe/R6ESJjiBxMLqc7s+QlebT0DlNV/X5cnEPhv0vf5FaVJqJpj4N
 znhmNulSLfRpnDVgSPYiPv0sbEaNZ3iLe00E4higmAW6/SCf/T7Ain+9K
 jUQ5CdDpDZfG3QuWzmUPcAEW17mUcXhmz9QryUjCUScc1Ie5r5k5N76Q2
 01ZQK4vYYRreRhCRHdJ8t1sh+N6N+oeqTfCnSI/x8oPy8ZrkdfFkuKEXT Q==;
X-CSE-ConnectionGUID: bP1xc++vQw6ZnWwNBW8iDQ==
X-CSE-MsgGUID: kOPcZnxwRQe3QG2PHXfd0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106683377"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="106683377"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 13:22:37 -0700
X-CSE-ConnectionGUID: CfhJggI9S4ipNWqq4NBHPw==
X-CSE-MsgGUID: c/mtonwtQdKA7CXR0Y804Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="269352595"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 13:22:36 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 13:22:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 13:22:35 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.50) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 13:22:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMpHlHbF75o75R9v2mHzgzGZ/1KJ74sORnzGoLSFC686ZYDpuDa4rcGHWHDpRFhuCGe4M1R0dYNL/QMPA10qGLhlrHtfSU/zLbMG7iAlKJ/tAB3BhJjxjdGtZ1O0ZcYeJS+s/JOpnP8NrgrtmfEcOPu+LBWXAxPz2rEMyQ7TMvxjX7jH0f+jDRr5/q2Ps53RDa0uhTol+ETqhCi/z0jjUgyKGaBKQolF/9GNyGGm+DW/XeDW0UnnRA2MFXxvZVlR4YPOjX8feoA2i2alPLiV0jk6SLeoGUWPH1YGS8Pc86TTh4hqNU2vMDFvzJ6HQ30GTuyw68cuYDE1TzQmhJg4fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkRnY6pl/upFFRVxJ51U5QHVYCCwgI2Dc3DhiMU+yBw=;
 b=Dya2YWHqRt6hEcaGuc9g9lP0I5npmfHmHBQ8sY3U98BYC5MVbRuZrCkVioqvN6KpLUsRRMlfDfJndBMnPYLztGarcxTIzXKS6fX36br8/Mc1tfwktRtcUuJiUmhFrpMhC2jS9kQ8CGPg2WOacDaSP8PLdyyB7m8+ABE9RJyzkw0OKZ1wR7HH3IStNjPwY1SPg//TO5diVpKhiRrOAHRNWmbaV3nG63kzRigPDDTxZyMAfwj/BZme98SN0glT9TEchPYYfKhv+d3PJJNvRm8uFsF5K4j7PZSjMyNP8kHSyo15ykjZPTOHntRsDcbG5WadD6R2MTiDT+zX0nJVtYLcrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 20:22:25 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%3]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 20:22:25 +0000
Date: Tue, 8 Sep 2026 13:22:23 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>, Mika Kuoppala
 <mika.kuoppala@linux.intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>
Subject: Re: [PATCH v8 3/3] drm/xe: Convert xe_user_fence to drm_user_fence
Message-ID: <aqBufwAli0Krw+s3@gsse-cloud1.jf.intel.com>
References: <20260908084627.352535-1-srinivasan.shanmugam@amd.com>
 <20260908084627.352535-4-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908084627.352535-4-srinivasan.shanmugam@amd.com>
X-ClientProxiedBy: MW4P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::35) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DS0PR11MB8718:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fd3c182-672d-4465-7f72-08df0de6e535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|4143699003|10067099003|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DJaYtaazneNsLS01bBpKU5hugRsLzUg6glaDPxEfq1EVM7csZZ+pZLt8wOZ8m/Z7pHsWHgnrdga12MO4c7Ic0vgT7gLRmE6jy7jhuxLZ6lWg62Kw3Us72+QQbQnZUqp6RR4PpMZeswLEY86AS3jG9k3x+M3W7COYEQeSeUs0iOR+keE/R3QikfrpMYZWmcIwpzvo/9nO2h4FyXjyAVkaMIn11JUZThpDxyyrOHAsmzqlygvW0hiq89T3dOEZ8XVh8lDSK0NRG/06b/1i7ZK9XGrpdExr/zXxutEkhdTrCquRrjvqyCAEBwsVoRSFthTNILBBPYKa6Oj3oPNzkstTnhRkk49wXKBMO1NQ5Z4H5tTtRxzhsiETxx6zi90uzzcFbX/S0STpNqtAnMJbbROe82CglUI36oq8ABrsrE0KHo80VCRa6uFbWF1ph+oFjiOpnBfCvfW/XRS1ACCcBlDgvahgKwvZ8DjY93RLGPwVUKcFXVVrLJR6dH4phzVfr4sDCo+FP4Sf00bkXPIpxKYl+3rp84pIglMtAE7dudCM80tOx6RZ6IcwMaV/7qoYBYSqvKaMSwOZ7h0By9cywWYYGqRngFUrtRWI91aBDlti/sgHi5aZfWZ0sNlcOiOGbbBJWF53Tt7vpTE47YrMcjEq4hC5HN8cyyMo/DDvZU9HxCQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(4143699003)(10067099003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzNranV0RmI4UndjVHo0R0pUUXRNd3RnOHVsNnFSL3o1UmV0SlpJcGRkVk44?=
 =?utf-8?B?UllwUjcxd3RxbVRGS0loQ0pjbEd4YUNYZXRsK3o1SzVoUy9FQVRMblR1TllY?=
 =?utf-8?B?THFaTkdYZ0NLdHNJcm0xSWVoNW5Ka1ZWRUJDZ1FKTVdhNEk5REFyOWdic0xm?=
 =?utf-8?B?YlFsbVVjdmRQc2VMeUFnTm5laVpmNDZQR21zZ2ViSnBMdmM0TkdhaWI4VG14?=
 =?utf-8?B?MVlHbmpqNWdCVGltTTFjRVJZMHd3Zk1ESTNCRjlmdDE5bU5HaXhmcDFodktm?=
 =?utf-8?B?SWNYM09ENytvVEN6TUVMVEpOeHpUc2EwM2pjVUFMLzFvV0xwSlVTNkVYZENE?=
 =?utf-8?B?dE1lQmNpNnBRdU14S2E4OGdCcFpUeXI4Z3ZnOG5yNEVHVkRYTUR4Nll1ZUxC?=
 =?utf-8?B?Wm90ZnVzSjA4UTFiU0VETUdOU1JHbHpiVjNCQys1SDFEaGxzVWhPRnJRNERy?=
 =?utf-8?B?ZTBJck5GenNXMU1BMFo3RDQwTE1uMHFnQzZJUVphZUR0ODdnNlhpWDQzUXh4?=
 =?utf-8?B?ZnFoYk8vc1BrT1NMWFcvMWM1QUUvdWp4d2hUMytjb04xOTN6eHExVm1GMHcw?=
 =?utf-8?B?NFJzeGdJRmE2RzREVDJhdmpRZlNyQzlUcTVnczVLcFFwUlRVVC9hVGJaODRH?=
 =?utf-8?B?MU15UHJaUmRsYmhRNUtYR0pvZkJGWkZ4UGFWektYUEJYVCtFdXM5cU9zeFVL?=
 =?utf-8?B?VzhMbUErL3lZbklvZkNCbkNjcTVrOHdxQTJoV3dodmFrVGkxTVRRNVZoRi9p?=
 =?utf-8?B?VmtmNlNPWVY0SDJSd2tLZFNDaFBlM0FDQWRXUXdlanpoZkNWTnVLV05xeDdI?=
 =?utf-8?B?Q2g5dG94WlhGdmNISFpRcE44bkp2cGdPUmp6NkVKMWdKN3RrMk9RbDNxT0xI?=
 =?utf-8?B?MzZkYW1SL21UM2VWR0I1Q3FUaWt1SUxMcUxMT3NKaDEvZFRBODFEMVFJbjh6?=
 =?utf-8?B?Vmk2V08xMHpzWGFZVi96MG4xMTJWNk11SkdiYitrZ3kzaS9rWk9DaG1qcFZS?=
 =?utf-8?B?WExiNFJwMzdrWFJFUGVjRHY0eTF6azhVK3RCdW1sTEQ2dHVFTHh4TFNhQmdG?=
 =?utf-8?B?akZUaUllay9BS1pMYytVSjZkb3ZEeFpVd2p1ZWZzU1BmcnFMRUV1YlhOTzZp?=
 =?utf-8?B?Z21yTVlCOVdHVEdvRGU3czU0SXQrTWIyZVFwd0RGN3lEVFlUb2FLNVhkYnE2?=
 =?utf-8?B?cGpTOENmbjhlTGZteW5PZCt2dWdCUDJWOFZSbXJaZUNNQm0yNCtvZkF2RzlD?=
 =?utf-8?B?M09NL1d1Q2dFZ1RhMUdGZWxMS2ZsQTdGUWIrNFhmbEVaOVMxSGwrYlVUalJ4?=
 =?utf-8?B?bVA1NERLd2c2dUUzRGQ4RVBkbVB4aU0xMWtRelBwbllVZ0lRRVVhZTRCeEYw?=
 =?utf-8?B?aG9wTTFqK1p4dlhnRjdJTUV4ci9Qb3E1bzlTL1dwdnM3S1FDTlh1WUhzMzdH?=
 =?utf-8?B?K0pFdUVjQkRxNnFRcWprTnRoOW5aMU95TDJmQm93WlhLNWNybzlCby8wL2Q4?=
 =?utf-8?B?SU1rc0lMRGxyOW96N2MwWGswQnhtbTJiQllieG5uVFRsajVQK1ZsRm5KeW9V?=
 =?utf-8?B?QzV6ZXVHSzk2OGt1enc1ZjZicjVxWk5GYlowODBTVFBwYlQ2UlJ6ZFk4VE9s?=
 =?utf-8?B?bExxdURlSW93QXF4ek1KaW5YNE8vRi9GUEYwQmJxMkM2eG14ci8rUWNmZWVa?=
 =?utf-8?B?bXdxcFEycnl1WkR1dldqYVZjUnl6Vm5BZHh3Tm83di9SOE5YbXYrV3lZT25Z?=
 =?utf-8?B?Y3p4Y25OS3B2UlRrQjFpRldzUHcvSFZENjlHMENjZ1FENjJaMmVFRWRvd1lP?=
 =?utf-8?B?UEVOVEV6aUdHWDV0UnZnSkp4SnVuR0ZKdXUzUGNNWE4wS2dEVFVIOGFvT1RE?=
 =?utf-8?B?alpkVnAvL1VaL0wvdmJsN3c5Z1Jzbk83L3M4Yjd3WVhxSnhBK1BYbGlWeU1U?=
 =?utf-8?B?SkczVG5MNGpPeFJFL0tLQXlYMWVTL2hLVjFidzhLVE1IOGsrU1JhMjJEaDdG?=
 =?utf-8?B?Vm1HeEsySk5wQmROckRpK0lQTTF4SFNpL0s1YUljWklwbllDcGlGd0p4OUww?=
 =?utf-8?B?OFhKSDVYak9abTg2Q0gxVE9sOUlhVDB3ZE95NDFqYjM0a2luVHlmeHBwRWxM?=
 =?utf-8?B?Ti9UWjJ4b2t3Vit6ZGNSSmpqa05jcWJzWkI3anlWZCthNWNOeDFXbmRidjFy?=
 =?utf-8?B?cjhpNXVUdEdFMlZRT1dzamtnSU9ZQ3J0dmxmd1oveHpHQW9MNWhEUGxaOWpU?=
 =?utf-8?B?VnZVcUc4SDE4cDc5aGtjQXhvaFRZaGZZVDV3Q0FaTUVQTEk1L0J3eUUzWTdC?=
 =?utf-8?B?S1orMTNjTC96ajkzRGYwSCtQdGdJYlpreGFIOFZQcjJNYmhKVGsrdVVBUUdW?=
 =?utf-8?Q?KA1p72ctMM0qJuxs=3D?=
X-Exchange-RoutingPolicyChecked: g4FvfZbaCzj6+Wvb57OTyhKqsTVscPgfAe2V8TmiVxEcotCizJjd4giLGbTuQUB8y0iZAZUAAOylmxDgci5io+8W6hUj26djWXCneaPgrMO3pvG475/n4YMJ2xX9PE12ufNqScmFW1tbQXQLKS8zmOXcSBbxFmy8a7RJbVRqeoPzhY21l5D7/zBrzd4nFqWZ4rOB9W7zJjW6/2WX39inJ4Vvke2+U3pQijbDcOtZcrcrADpzaDGEj5pmB4yJAlU330t6priDGTdRibaS9oO35aaNqloOa+kL+wlufjo3gtxVcCGl6WLzcZIs59YnWY3JtkvaZI3mIWcEuZ0b8eLmMg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd3c182-672d-4465-7f72-08df0de6e535
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:22:25.1219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NBXNSf0wTAXBi1CUvj9sPx2X4j9bGYsCPrp2B35f397Z4ZZmzcDsDASVIC5jDbDrAN4lBv2VA2YdGkcpavxAow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8718
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

On Tue, Sep 08, 2026 at 02:16:27PM +0530, Srinivasan Shanmugam wrote:
> Replace the open-coded user fence implementation in xe_sync.c with the
> new common drm_user_fence helper.
> 
> struct xe_user_fence now embeds struct drm_user_fence as its base.
> XE-specific fields (xe_device pointer for the ufence_wq wake-up,
> userspace VA, expected value, signalled flag) remain in the wrapper.
> 
> The local user_fence_destroy/get/put/worker/kick_ufence/user_fence_cb
> functions are removed. Their logic moves to xe_ufence_ops.writeback and
> xe_ufence_ops.destroy, which are called by the drm_user_fence helper.
> 
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: intel-xe@lists.freedesktop.org
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v8:
> - Fix xe_ufence_worker ordering: WRITE_ONCE(signalled, 1) before
>   copy_to_user(), add smp_wmb() before wake_up_all() (Matt,
>   mirrors upstream fix 8ae04fe9ffc93)
> - Rename .worker → .writeback in xe_ufence_ops (Matt)
> - Update commit message: xe_ufence_ops.writeback (not .worker)
> 
>  drivers/gpu/drm/xe/xe_sync.c       | 154 ++++++++++++++++-------------
>  drivers/gpu/drm/xe/xe_sync.h       |   2 +
>  drivers/gpu/drm/xe/xe_sync_types.h |   1 -
>  drivers/gpu/drm/xe/xe_vm.c         |   1 +
>  4 files changed, 89 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
> index 37866768d64c..c0e720cf579a 100644
> --- a/drivers/gpu/drm/xe/xe_sync.c
> +++ b/drivers/gpu/drm/xe/xe_sync.c
> @@ -6,12 +6,11 @@
>  #include "xe_sync.h"
>  
>  #include <linux/dma-fence-array.h>
> -#include <linux/kthread.h>
> -#include <linux/sched/mm.h>
>  #include <linux/uaccess.h>
>  
>  #include <drm/drm_print.h>
>  #include <drm/drm_syncobj.h>
> +#include <drm/drm_user_fence.h>
>  #include <uapi/drm/xe_drm.h>
>  
>  #include "xe_device.h"
> @@ -19,36 +18,65 @@
>  #include "xe_macros.h"
>  #include "xe_sched_job_types.h"
>  
> +/*
> + * xe_user_fence wraps drm_user_fence with XE-specific fields.
> + * The drm_user_fence base handles MM borrowing and work-item lifetime.
> + */
>  struct xe_user_fence {
> -	struct xe_device *xe;
> -	struct kref refcount;
> -	struct dma_fence_cb cb;
> -	struct work_struct worker;
> -	struct mm_struct *mm;
> -	u64 __user *addr;
> -	u64 value;
> -	int signalled;
> +	struct drm_user_fence base;
> +	struct xe_device     *xe;
> +	u64 __user           *addr;
> +	u64                   value;
> +	int                   signalled;
>  };
>  
> -static void user_fence_destroy(struct kref *kref)
> +static void xe_ufence_worker(struct drm_user_fence *base, bool mm_ok)
>  {
> -	struct xe_user_fence *ufence = container_of(kref, struct xe_user_fence,
> -						 refcount);
> +	struct xe_user_fence *ufence = container_of(base, struct xe_user_fence, base);
>  
> -	mmdrop(ufence->mm);
> -	kfree(ufence);
> -}
> +	/*
> +	 * Mark signalled before the userspace write so that if userspace
> +	 * observes the written value and immediately issues a VM unmap,
> +	 * check_ufence() will see signalled=1 and not return -EBUSY.
> +	 *
> +	 * NOTE: copy_to_user() may block if userspace backs the address with
> +	 * userfaultfd or FUSE. Drivers requiring non-blocking semantics should
> +	 * use a dedicated workqueue instead of xe->ordered_wq.
> +	 */
> +	WRITE_ONCE(ufence->signalled, 1);
>  
> -static void user_fence_get(struct xe_user_fence *ufence)
> -{
> -	kref_get(&ufence->refcount);
> +	if (mm_ok) {
> +		if (copy_to_user(ufence->addr, &ufence->value,
> +				 sizeof(ufence->value)))
> +			drm_dbg(&ufence->xe->drm,
> +				"copy_to_user failed, user fence wasn't signaled\n");
> +	} else {
> +		drm_dbg(&ufence->xe->drm,
> +			"mmget_not_zero() failed, ufence wasn't signaled\n");
> +	}
> +
> +	/*
> +	 * Ensure both signalled=1 and the fence value written by copy_to_user()
> +	 * are visible to all CPUs before wake_up_all() wakes waiters. Without
> +	 * this barrier, weakly ordered architectures (e.g. ARM64) may allow
> +	 * waiters to observe the wakeup before seeing the updated values.
> +	 */
> +	smp_wmb();
> +	wake_up_all(&ufence->xe->ufence_wq);
>  }
>  
> -static void user_fence_put(struct xe_user_fence *ufence)
> +static void xe_ufence_destroy(struct drm_user_fence *base)
>  {
> -	kref_put(&ufence->refcount, user_fence_destroy);
> +	struct xe_user_fence *ufence = container_of(base, struct xe_user_fence, base);
> +
> +	kfree(ufence);
>  }
>  
> +static const struct drm_user_fence_ops xe_ufence_ops = {
> +	.writeback = xe_ufence_worker,
> +	.destroy   = xe_ufence_destroy,
> +};
> +
>  static struct xe_user_fence *user_fence_create(struct xe_device *xe, u64 addr,
>  					       u64 value)
>  {
> @@ -63,51 +91,22 @@ static struct xe_user_fence *user_fence_create(struct xe_device *xe, u64 addr,
>  	if (!ufence)
>  		return ERR_PTR(-ENOMEM);
>  
> -	ufence->xe = xe;
> -	kref_init(&ufence->refcount);
> -	ufence->addr = ptr;
> +	ufence->xe    = xe;
> +	ufence->addr  = ptr;
>  	ufence->value = value;
> -	ufence->mm = current->mm;
> -	mmgrab(ufence->mm);
> +	drm_user_fence_init(&ufence->base, xe->ordered_wq, &xe_ufence_ops);
>  
>  	return ufence;
>  }
>  
> -static void user_fence_worker(struct work_struct *w)
> -{
> -	struct xe_user_fence *ufence = container_of(w, struct xe_user_fence, worker);
> -
> -	WRITE_ONCE(ufence->signalled, 1);
> -	if (mmget_not_zero(ufence->mm)) {
> -		kthread_use_mm(ufence->mm);
> -		if (copy_to_user(ufence->addr, &ufence->value, sizeof(ufence->value)))
> -			XE_WARN_ON("Copy to user failed");
> -		kthread_unuse_mm(ufence->mm);
> -		mmput(ufence->mm);
> -	} else {
> -		drm_dbg(&ufence->xe->drm, "mmget_not_zero() failed, ufence wasn't signaled\n");
> -	}
> -
> -	/*
> -	 * Wake up waiters only after updating the ufence state, allowing the UMD
> -	 * to safely reuse the same ufence without encountering -EBUSY errors.
> -	 */
> -	wake_up_all(&ufence->xe->ufence_wq);
> -	user_fence_put(ufence);
> -}
> -
> -static void kick_ufence(struct xe_user_fence *ufence, struct dma_fence *fence)
> +static void user_fence_get(struct xe_user_fence *ufence)
>  {
> -	INIT_WORK(&ufence->worker, user_fence_worker);
> -	queue_work(ufence->xe->ordered_wq, &ufence->worker);
> -	dma_fence_put(fence);
> +	drm_user_fence_get(&ufence->base);
>  }
>  
> -static void user_fence_cb(struct dma_fence *fence, struct dma_fence_cb *cb)
> +static void user_fence_put(struct xe_user_fence *ufence)
>  {
> -	struct xe_user_fence *ufence = container_of(cb, struct xe_user_fence, cb);
> -
> -	kick_ufence(ufence, fence);
> +	drm_user_fence_put(&ufence->base);
>  }
>  
>  int xe_sync_entry_parse(struct xe_device *xe, struct xe_file *xef,
> @@ -282,24 +281,15 @@ void xe_sync_entry_signal(struct xe_sync_entry *sync, struct dma_fence *fence)
>  	} else if (sync->syncobj) {
>  		drm_syncobj_replace_fence(sync->syncobj, fence);
>  	} else if (sync->ufence) {
> -		int err;
> -
>  		drm_syncobj_add_point(sync->ufence_syncobj,
>  				      sync->ufence_chain_fence,
>  				      fence, sync->ufence_timeline_value);
>  		sync->ufence_chain_fence = NULL;
>  
>  		fence = drm_syncobj_fence_get(sync->ufence_syncobj);
> -		user_fence_get(sync->ufence);
> -		err = dma_fence_add_callback(fence, &sync->ufence->cb,
> -					     user_fence_cb);
> -		if (err == -ENOENT) {
> -			kick_ufence(sync->ufence, fence);
> -		} else if (err) {
> +		if (drm_user_fence_add_callback(&sync->ufence->base, fence))
>  			XE_WARN_ON("failed to add user fence");
> -			user_fence_put(sync->ufence);
> -			dma_fence_put(fence);
> -		}
> +		/* fence ref consumed by drm_user_fence_add_callback */
>  	}
>  }
>  
> @@ -434,6 +424,34 @@ void xe_sync_ufence_put(struct xe_user_fence *ufence)
>  	user_fence_put(ufence);
>  }
>  
> +/**
> + * xe_sync_ufence_cancel() - Non-blocking cancel of user fence callback
> + * @ufence: user fence reference
> + *
> + * Attempts to cancel the pending callback without waiting for the worker.
> + * Safe to call while holding dma_resv_lock or vm->lock. If the callback
> + * has already fired, the worker runs independently — xe_ufence_worker
> + * only accesses device-level and userspace resources, both safe after
> + * VMA teardown.
> + */
> +void xe_sync_ufence_cancel(struct xe_user_fence *ufence)
> +{
> +	drm_user_fence_cancel(&ufence->base);
> +}
> +
> +/**
> + * xe_sync_ufence_cancel_sync() - Cancel user fence callback and wait for worker
> + * @ufence: user fence reference
> + *
> + * Cancels any pending dma-fence callback and waits for the worker to fully
> + * complete before returning. Must be called during teardown before freeing
> + * any resources accessed by the worker.
> + */
> +void xe_sync_ufence_cancel_sync(struct xe_user_fence *ufence)
> +{
> +	drm_user_fence_cancel_sync(&ufence->base);
> +}

This is unused in this patch.

> +
>  /**
>   * xe_sync_ufence_get_status() - Get user fence status
>   * @ufence: user fence
> diff --git a/drivers/gpu/drm/xe/xe_sync.h b/drivers/gpu/drm/xe/xe_sync.h
> index 6b949194acff..b5ff3387c592 100644
> --- a/drivers/gpu/drm/xe/xe_sync.h
> +++ b/drivers/gpu/drm/xe/xe_sync.h
> @@ -44,6 +44,8 @@ static inline bool xe_sync_is_ufence(struct xe_sync_entry *sync)
>  struct xe_user_fence *__xe_sync_ufence_get(struct xe_user_fence *ufence);
>  struct xe_user_fence *xe_sync_ufence_get(struct xe_sync_entry *sync);
>  void xe_sync_ufence_put(struct xe_user_fence *ufence);
> +void xe_sync_ufence_cancel(struct xe_user_fence *ufence);
> +void xe_sync_ufence_cancel_sync(struct xe_user_fence *ufence);
>  int xe_sync_ufence_get_status(struct xe_user_fence *ufence);
>  
>  #endif
> diff --git a/drivers/gpu/drm/xe/xe_sync_types.h b/drivers/gpu/drm/xe/xe_sync_types.h
> index b88f1833e28c..67048199b070 100644
> --- a/drivers/gpu/drm/xe/xe_sync_types.h
> +++ b/drivers/gpu/drm/xe/xe_sync_types.h
> @@ -12,7 +12,6 @@ struct drm_syncobj;
>  struct dma_fence;
>  struct dma_fence_chain;
>  struct drm_xe_sync;
> -struct user_fence;
>  
>  struct xe_sync_entry {
>  	struct drm_syncobj *syncobj;
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index b01f31ed4417..fbd2c28de8a6 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -1181,6 +1181,7 @@ static void xe_vma_destroy_late(struct xe_vma *vma)
>  	struct xe_bo *bo = xe_vma_bo(vma);
>  
>  	if (vma->ufence) {
> +		xe_sync_ufence_cancel(vma->ufence);

This is a behavior change in this patch. Why is this change?

Also can't this prevent a user fence signaling on unbind if
xe_vma_destroy_late() executes before the user fence? I'm somewhat
suprised our CI didn't fail because of this change or Sashiko didn't
complain about this, so maybe I'm missing something.

Matt

>  		xe_sync_ufence_put(vma->ufence);
>  		vma->ufence = NULL;
>  	}
> -- 
> 2.34.1
> 
