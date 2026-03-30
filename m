Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD738FF493A
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 05:00:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3469F10E395;
	Mon, 30 Mar 2026 05:00:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="E2DHEtWN";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B34210E395;
 Mon, 30 Mar 2026 05:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774846843; x=1806382843;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3se9zvvUm2Z8Hc0GubTocyP8qDzyoE0HvDWB+4fAzLs=;
 b=E2DHEtWNHTkGxg3dtA5RKELO7wmA5z1HL57Y2BckQmj8OfEK/yCqQKrL
 HidmVAMb28MdjbaWWuU+e1+KD/FTkmsttDoXi9xgATwcPwRP/NhUkcuUz
 TC/PGd1RjsulgkUQ0J7+4/tSOUttA2UJFGtYCEzEru37u8c2QjDEHZD6G
 PjadPjUoxqgPwCfn+1Ew0X7Gw32jyWemAAyYLq5Ex3yAMOD55qXRU/WW3
 hxYV2DC+Oq2UrcfyusJQAfCGS+9yr4+0FeRicQP1+nA4g22Nk2jgK6bME
 DOtnR7qwZLkGamW5eug7PbtbDzFoMFTPL4DPpLYe8/KdhYHPc0DeHljKo A==;
X-CSE-ConnectionGUID: ANpAKbmITSKG3nQT0RTB9Q==
X-CSE-MsgGUID: XZUXb1v7SRikQ3MDapCIZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="98441711"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="98441711"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 22:00:34 -0700
X-CSE-ConnectionGUID: SEPgdD20T6yg/cUjDF9dKg==
X-CSE-MsgGUID: 1nrG0l4bTHyII2eK1pB+lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="225839572"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 22:00:35 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 22:00:34 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 22:00:34 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 22:00:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCEdYaVRkNBlf+JAcEHbtiNQAxMu9yxKvG/qZRprCcrNQLNwEPV0w8yM8Wa0783y3GX/Guda7tFjEXmM7F4xSIM5aED02jVsT3dAzit5wetsps92MxdAFGwZVWvOcrijIKslBChHGW+iP2m40grM24E1Di2LagM5YMttYAEXa/Dpn1PZL0HX4rtW/EjoxYSa+z5ZnGiOAPmH4lSJxYFdTwUWvKZ4PbdoMvechBtKMQkRug79WGxMzg97aGeLRu+jj3mjn9Q+drMlRMXvrD/yvSfAwkwR8bJIA2wXzC0q/WzcJgcdiRBgAp39FQk0rfdd0AWCYednsCH1o89LyRkn9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNktOxvwCMFLv7prmZ3p2QUl+S5MrgKmlKwg9m5qb3U=;
 b=gmjYkrxGrx5SzWGt991cH5df9Nr4ssK13Qag/vskseXbM69lZPJ0H3g6pTP8YA5GdbTW7MhpxvX+Q93IhmV2OcGvoSnEGtAaOkBhY7K9KFi0PnUDKdMkYfooX8Y3EQoffwdIcF2kTmpsw11dgS/i0zOAQoHarXNWDlV3+PQOCLQDoD5UjO7u9bvyfy3qpQ11T/cKkGLVnf9ngK46Y/V5gnwaVTRty6PF0LJV6CgAQWWy7FCOIvKx5uoUyiFQlQ58rDZG8V1MfYhuYBma+7nQg1odjHhh5J8M5/h+Mf4OYCHDp6Y1Ah3+aI+pZZnvPTyRDgQ2QBaiV6heqZKGi82MXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 DS7PR11MB5991.namprd11.prod.outlook.com (2603:10b6:8:72::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.14; Mon, 30 Mar 2026 05:00:32 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 05:00:32 +0000
Message-ID: <88aae008-ddd0-4f23-914f-f4c8e8d6f54e@intel.com>
Date: Mon, 30 Mar 2026 10:30:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET
 recovery method
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rodrigo.vivi@intel.com>
CC: <andrealmeid@igalia.com>, <christian.koenig@amd.com>, <airlied@gmail.com>, 
 <simona.vetter@ffwll.ch>, <mripard@kernel.org>, <anshuman.gupta@intel.com>,
 <badal.nilawar@intel.com>, <karthik.poosa@intel.com>, <sk.anirban@intel.com>, 
 <raag.jadav@intel.com>
References: <20260318064016.374656-7-mallesh.koujalagi@intel.com>
 <20260318064016.374656-10-mallesh.koujalagi@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260318064016.374656-10-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::11) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|DS7PR11MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b190983-6284-454a-b63f-08de8e19454b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 9/yj8SFn7vDGOJ+p1blfV2xjOdRTyweKj9zY5Sr5zw6Qov/26U2dpKvguGyoJCLtAamE+fIpvnp3SF8/C9GO/MRKZaiPIuP0lnPcjS+SEjkI0xHll3YoixuKeth/UJZNSck5pqKkShhZP3saFflrBmJt8q4HBw1Vc1x/xoH4/YMCYjKSl44fFyiKNNY/pb8sXaXcMhJ1oAw2KN6BJkhspbI8wqxfR33e6+G/H6sUI4nFF2fCmYvNKzyNuArTSw0NdQhF2ofi7qeX7RBLeGDusNnlifNrC339kkXak3/Tc/D5OkpqF+KekyKTHGp8rW9u4c9v4gUyVB48Ipz6zyeLOdUindTqbJIrUjspHmS78c4axYAr0sBvJGVsUE9lBeb2k4pgbiTFc9hkrDEVBWxyQTO4DHR0NNAylFrdhRjek27Opf0j0u9b9gZWyhoBtjua9R1mKUS7w/+NZcnKgMfOX39NGmOEGNEWwrcqqxzyfR8mUdqDLYGLACFh9v6rgIckRtYRLjhqSJr9W8MpO2s9kmP0lAb2bGpEDq5i3zSeWl0HuiYgfBruHxhI7BO3S3r3EVKWWFEQbXS1bjBAl6959U6s/e1MN2hoBwZ3bTUSoRGq/xZJKokAdwOOnaBnswWTX7a99fPR+b+gYwwxI6fgXzT3btozGEUCAcHjqy0Aod1UKJhqC6Cpg8uF4FjOCJeI43Zw/PGxegopa77AG/DGNh/OPWgH5ikFrbzlyMLtDvc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekM0eEpOQkRjRTMrOXljYWIvRW0zK3I0RTNvZUVOMWgwNk9xRjdGejVtR3Q1?=
 =?utf-8?B?WXpIb0dkK210OGxrb0oyRjhtakZGZEYvNmNIOHBsWnRxNzlscWtSb0RvTjN6?=
 =?utf-8?B?ZkdMYzZqaG1PRC9YZnhmK3AzREpsR1hKKzhDaWtSblRHZkRla2NFaHRubkRF?=
 =?utf-8?B?cFFMS3FjTzRiY0FRSUF4dDUyLy9SeWtIR3Vqa3A2S3RJYkpqV1RmUGNOdmgx?=
 =?utf-8?B?c2tyYmsxTDhZZ0NSWXA2ejFZdkJNYUk1eDNJOVRKSzR6bkROY2w1V2Vud0dm?=
 =?utf-8?B?dWFCVmJyNnRob3FhNXFqNEVpYTBGaXNqeFdhUFJEMWtMUndhUnI5TzZ0ektu?=
 =?utf-8?B?RHE1M3g4alRrSm84UVNnZmtLS1k2Y0lCWnduN2gyT0VQQ1BVOWVJeG9lYU5m?=
 =?utf-8?B?bjNDakU1Z2w4Q1dMMjV2MFRmdTIyMFJIYi9DcTlReTFpQmYzMk9GeGtpdFkw?=
 =?utf-8?B?ZDVraXR2azY1RTdSWGc0bHJBM05sTlEvbW9Xd00yZVVlaU5hcGVJeExwQ1Qr?=
 =?utf-8?B?MmxyMkd3WHhVcWphdlVtWHBtM0l1SHRtOGw0RXo2SjV5VGhKeERpdkxzd1NF?=
 =?utf-8?B?M1R0Z1owemd6RDR0TUM5dXFPOEJreFR4elp0K2dtN0IxMGhseDlvRUVJMVhX?=
 =?utf-8?B?MG9Uc1ZIeWxkMWlEV2c1bUhUenFJSVlxL0l5cDd5VHpvSEpkZFVrMEFLdm5O?=
 =?utf-8?B?aHZUdlo5dER2Z1l4OXFQRjgxOTQ3eVROZDRvWnFtNWN6dnZPcGlVN0xZczBX?=
 =?utf-8?B?U0FGVEd4aGhTY0RIMlloWW9zNjJHc3gwdHc5dllIUXgzR0ptSHRkS1pJelBv?=
 =?utf-8?B?cGFnRnp1NDk4Mm8xMnRHNGVvY1pyMWlhSWlnNDdYTVVxTHQ5VGVCRWszZnZ0?=
 =?utf-8?B?bjBUY1JSQmlzaElyRTdMUzNHSE80QlNsSlA5eHd0ZGlIbTBVbnlZMDhxVUZr?=
 =?utf-8?B?LzJ6dWNCL3pZSzBsVm5Ea3lKZVpEaThBdGtnb2FmNWZYSmp1Z0NuTW52ck9Y?=
 =?utf-8?B?UlFMOFo3cnNnaERZMFFHY2xlYkZmTWxhV1B5VVdHTXZjR3dyQVVHM0J6SGZx?=
 =?utf-8?B?dkxjdXFITTFnNVFLM24zRFdTcVZhYjE3ei9aQXpCN1JQVjQrTndqcU9vSlRZ?=
 =?utf-8?B?OEM2cWhXd0JKZkJLSHNmbG1JYm9iU0VuNkpQSGduenJnZlBCRHZXaTVBK2VD?=
 =?utf-8?B?TzRSTXVBQzZJdmhFM0pnTFdOOUlsOW9LcTNlamFxZ2VqRFFuM2ZTK2luMzVR?=
 =?utf-8?B?TERxLzgyRUZJQ1p2ZUhkQWpOK1NkYmU3VjNIbGdPSVk4a1JXRGR4c3VlTlRa?=
 =?utf-8?B?SkRkWDlMaTRabS9wa1Ywd0YwQTgxbVZGZDVyeDQzeHJWRUVEeWhLcVlTZmR5?=
 =?utf-8?B?UU5GRVQxcWlNTFlUMzJUSE1PRXhMU01BWEk0eFhuR2pPT1BId0pzZTI3aTRq?=
 =?utf-8?B?VFVkNjdiS2VQRzIwVUZmWDBGSTRVQXMrSktFekpBV05rbndsL2ZnRm1RcWxC?=
 =?utf-8?B?QjlBbUFtcVJiVGMxNTB0Rm01WVdwU0lwV09ScXhPUVdocEtOVHFYanhFSVFs?=
 =?utf-8?B?OWxtY2k1SU1XU2VyYkUyV3laN0xQZG9idDB6UnI5dE5wa0RwRlVCaHBqNmlq?=
 =?utf-8?B?amZDOTA0ZUI4STB6Y1FPQklNdHAyNVVlTk1NOEd2TTBGUWhyOU95NWhwckcz?=
 =?utf-8?B?UWR5YnFQV3E1ZC9sWHJ2WmpSSjdyNHlhQWdzTXQwemdZT3ZHakNnQXExU0k4?=
 =?utf-8?B?SFR0Nlg3Vlh2WCs1anA4bm14bkhjR0ZOcldwZU5oeW9sMkRPV1E0WVA4TnYx?=
 =?utf-8?B?dHVVVCtGNlBlZjdwZ01WNEs3T3RJa3NTUkw5bktyMGlBM1F3UWRjK1NHeUE4?=
 =?utf-8?B?WFNOdkNnUmxPaERraWhYNGRERW9HblB0ekhYOElmK1JlYjRwRGFRbUxCZTky?=
 =?utf-8?B?dEpIbDdKQTBSanViN0pSd2JKZzNHRzFrSnpXalphRS9IblFENzJsS1BOMFJh?=
 =?utf-8?B?UmYyUlBhVElyVkRnaERGZ0hacEUxeGp2bVRrcklJcnRsQnhLSnNVMlBvTjJR?=
 =?utf-8?B?dDIzcEdDTTVSU1VnRHZQZ0xVL2puZTVaeVU1b29uaXprMFRjNnFQOEdpMGxp?=
 =?utf-8?B?KzNxMlNkbE94T2Nwc0Z3RVlFSTlKeWJsQ2lQamVmMERrajVLTUlTb1BObUxq?=
 =?utf-8?B?MlF0eDk3eUt5ZUQ1VGJVSTl0VVBpV2JJUWdNTWtjdFVYbmtPdi9EeEN0cnpy?=
 =?utf-8?B?UEc3U2lTU0txdklDOHR1Mk4xcEdUYUpNWktoQ1NBRS9HbVh0SmoybWhEd21y?=
 =?utf-8?B?d2NxeVRzUWdubFVBM0dCQjk4RTBBUllDZ0FOMmQ4VHNicjJuTE43Zz09?=
X-Exchange-RoutingPolicyChecked: ld+HtN8RFaac3yN21UP03gXuRObCVFYckRlVVtvkcIDqiKtk9lSrQuO8uy/5vyzMoUQMrzqzUQ4sKmCGEJEwrhHEYjlUpfaZkYIC8AhVX7gu3mtAVaCzThlexz3cf0cW76ElOq2GrxEl8XWBITS/IQGepPhkk+Y+Gf/ijzV6fjhySt1Rd5eNU7rLELmZB1NTylyWAO7Vr0sdFp3tWFIVj9fWli7XzJKXnoPVHowoWoTTeu9heoALf6c+7jt2X2t1p/XkHeZT2FSpIALKdxPv9KZMokwW5BFwJOKrwr+1W3QK1b0LJ2KCz9LS4sLXGwB4AMsAxTigYVJP3toDM2hR8Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b190983-6284-454a-b63f-08de8e19454b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 05:00:32.4502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jy3+RdLKnSNLn2twSpPNPljA1IgoGWqC7VOCR2pMTGT2OW+Gxfm2JvISJs1wTRJbQWFlDBr2mheYPOQ4QRgc7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5991
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


On 3/18/2026 12:10 PM, Mallesh Koujalagi wrote:
> Add documentation for the DRM_WEDGE_RECOVERY_COLD_RESET recovery
> method introduced for handling power management unit errors. This method is
> designated for severe errors that compromise core device functionality
> and are unrecoverable via recovery mechanisms such as driver reload or PCIe
> bus reset. The documentation clarifies when this recovery method should be
> used and its implications for userspace applications.
>
> v2:
> - Add several instead of number to avoid update. (Jani)
>
> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> ---
>   Documentation/gpu/drm-uapi.rst | 73 +++++++++++++++++++++++++++++++++-
>   1 file changed, 72 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
> index d98428a592f1..5b63f1c17b9b 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
> @@ -418,7 +418,7 @@ needed.
>   Recovery
>   --------
>   
> -Current implementation defines four recovery methods, out of which, drivers
> +Current implementation defines several recovery methods, out of which, drivers
>   can use any one, multiple or none. Method(s) of choice will be sent in the
>   uevent environment as ``WEDGED=<method1>[,..,<methodN>]`` in order of less to
>   more side-effects. See the section `Vendor Specific Recovery`_
> @@ -435,6 +435,7 @@ following expectations.
>       rebind          unbind + bind driver
>       bus-reset       unbind + bus reset/re-enumeration + bind
>       vendor-specific vendor specific recovery method
> +    cold-reset      full device cold reset required
>       unknown         consumer policy
>       =============== ========================================
>   
> @@ -446,6 +447,27 @@ telemetry information (devcoredump, syslog). This is useful because the first
>   hang is usually the most critical one which can result in consequential hangs or
>   complete wedging.
>   
> +Cold Reset Recovery
> +-------------------
> +
> +The ``WEDGED=cold-reset`` event indicates that the device has encountered
> +power management unit errors that affect core functionality that cannot be

Power management errors may be only xe usecase.  Keep the documentation 
vendor-agnostic.
Some vendors may want to use it for a different usecase

> +resolved through recovery mechanisms.
> +
> +This recovery method is reserved for power management unit error conditions where the
Same as above

Thanks
Riana


> +device state cannot be restored via:
> +
> +- Driver unbind/rebind operations
> +- PCIe bus reset and re-enumeration
> +- Device Function Level Reset (FLR)
> +- Warm device resets
> +
> +Such power management unit error state typically persists across all software-based
> +recovery attempts. Only a complete device power cycle can restore
> +normal operation.
> +
> +Upon receiving a ``WEDGED=cold-reset`` event, userspace should initiate
> +a full cold reset of the affected device to restore functionality.
>   
>   Vendor Specific Recovery
>   ------------------------
> @@ -524,6 +546,55 @@ Recovery script::
>       echo -n $DEVICE > $DRIVER/unbind
>       echo -n $DEVICE > $DRIVER/bind
>   
> +Example - cold-reset
> +--------------------
> +
> +Udev rule::
> +
> +    SUBSYSTEM=="drm", ENV{WEDGED}=="cold-reset", DEVPATH=="*/drm/card[0-9]",
> +    RUN+="/path/to/cold-reset.sh $env{DEVPATH}"
> +
> +Recovery script::
> +
> +    #!/bin/sh
> +
> +    [ -z "$1" ] && echo "Usage: $0 <device-path>" && exit 1
> +
> +    # Get device
> +    DEVPATH=$(readlink -f /sys/$1/device 2>/dev/null || readlink -f /sys/$1)
> +    DEVICE=$(basename $DEVPATH)
> +
> +    echo "Cold reset: $DEVICE"
> +
> +    # Try slot power reset first
> +    SLOT=$(find /sys/bus/pci/slots/ -type l 2>/dev/null | while read slot; do
> +	    ADDR=$(cat "$slot" 2>/dev/null)
> +	    [ -n "$ADDR" ] && echo "$DEVICE" | grep -q "^$ADDR" && basename $(dirname "$slot") && break
> +    done)
> +
> +    if [ -n "$SLOT" ]; then
> +	echo "Using slot $SLOT"
> +
> +	# Unbind driver
> +	[ -e "/sys/bus/pci/devices/$DEVICE/driver" ] && \
> +	echo "$DEVICE" > /sys/bus/pci/devices/$DEVICE/driver/unbind 2>/dev/null
> +
> +	# Remove device
> +	echo 1 > /sys/bus/pci/devices/$DEVICE/remove
> +
> +	# Power cycle slot
> +	echo 0 > /sys/bus/pci/slots/$SLOT/power
> +	sleep 2
> +	echo 1 > /sys/bus/pci/slots/$SLOT/power
> +	sleep 1
> +
> +	# Rescan
> +	echo 1 > /sys/bus/pci/rescan
> +	echo "Done!"
> +    else
> +	echo "No slot found"
> +    fi
> +
>   Customization
>   -------------
>   
