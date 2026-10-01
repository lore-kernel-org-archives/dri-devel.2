Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54041CA5FD4
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C90B10F671;
	Thu,  1 Oct 2026 12:57:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bDQHYABC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1A5710F652;
 Thu,  1 Oct 2026 12:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790859477; x=1822395477;
 h=date:from:to:cc:subject:message-id:
 content-transfer-encoding:mime-version;
 bh=knjNlTsortd0AH6OpvccyHEbqRN8TJ3g0hSrxSE+w9I=;
 b=bDQHYABCVjHIrrpYTdDyBon9rCUMPIuyRYrToGZ//t7RqnWWkz3NvQzX
 m/PR4DNjk5zOe2th9T9Aynq47P0z9LElD6EOWq76IBELk1vXGqTj7urtL
 UElfwLKyKvuzTEIprYabs2Laa+snrxy8hZPrZwf95vZNy9XhdznUGa/QP
 EHUtML84b+StyQjPKhGxEqHSjlwkCuZTfTAb6BEXAPWlUMh1MXco5aBY5
 oEvfrnEM9yfZAhsc0xoSKqyxJVFMWL5atkoRWkZ/c7MUslCCelQB9hQTk
 9SkQSs0rPguBnCvxFWE9XHpTNBS9/tThOYATeNyltpbYTZ7MseTzpYUZV Q==;
X-CSE-ConnectionGUID: fvSxR1jrSYWEEWqkzAs2Fg==
X-CSE-MsgGUID: lSUMPp/1QQOmjioRIY34bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="102188512"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="102188512"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 05:57:56 -0700
X-CSE-ConnectionGUID: QVuEE20oSVOiaV3UZWO0vQ==
X-CSE-MsgGUID: +L0mJSaHTRmtDmrhrzocQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="9896"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 05:57:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 05:57:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 05:57:55 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 05:57:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7X14owPqzBlpe8Sqq96GiinKETH9IrJP+a1/x9CX4olWzOkh5H69IjjRdEdH9q0I5HUoIb/2Xo3EhCxQWHY/7z12s/SqJo6vU4S9HtFizuyh0Yl70ehvEEJOE1zVWkSYFQqCseeSbUvqMtVoTs/RQH/FwYMDTGhuXulc30HoGRowCjNbltbrYiTkCbrPwjr0nMOgehv6VzSxjr3BpkR9Q1g4QnRImoM2xcuS9b5Ow5+sfagxrEHYhGllZddFjykks9VMv0H1qjvkqsPXP4OoKjdg+RDoKt2bmY5VlvbSVoLuhzLDSj0ujP2mKpslariMUlnt/fsI1AoXpXBVFRIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fjvftiW24k3/rPYF3/CIsLTXBbt3pItjdgB4WUcGMw=;
 b=UoLwwPSJlZTgjKtddyw1LiWU2YCT/vznsoIxlEOFesj20gYXKt4fL5MbNQCX/AHn/GylGasn8VyS5qR+VIoyaY7lDwhhctAcUOswkn0KYaYUC/ctknPLowKPHHNigp6V0/WQEJd/NmvRaQdoUgJWrxxAdf2oDkt1tSCKqU23XHjMM+oQEdi5v0Q212xDS/nzITdJ3Lb+zobzUyz9dqzEdsF6X2pxSmWIRWtx2iQXPtLRB/soWDwG/uQAQk9a9kAR9/t2wAYJgDYS8Luc2U3aYaighZ01/IZjgy8jOjc8V+25UOU3/nE6Lqzx1CIgXkGZeCfxxlw+DaaUqdIIP+RuRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by SJ2PR11MB8403.namprd11.prod.outlook.com (2603:10b6:a03:53c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 12:57:47 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 12:57:47 +0000
Date: Thu, 1 Oct 2026 08:57:22 -0400
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
Subject: [PULL] drm-xe-next
Message-ID: <ar5YsqAK3bS4Ta6Z@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|SJ2PR11MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: f349d56a-18e4-473e-2427-08df1fbb9714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|7416014|10067099003|260925021311599003|11063799006|260925021911599003|56012099006|260925022911599003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: f+2ru85NVeIm4mvEXMLi4w+D46ql12F39EhdcTFO/+alaQObL87oX1SNo3V128NoJjCb5w9u1jfk9bufNXTn6BtvKjbZbgefxYOejztfKAacAH3zzLE6TSjVgmOXrpcSexrNz+eVz9psAiY3M/WQF4mftnkKOURfsSvrERRq2hzMMYlXIitJq7ltYH+7TDBhD95rjSllQYtDwh3wnozNbThQ6wmkymzmSjK/zAnHPdjKM9Upg5987wBSmMks9Y5t21xCLgVe73xmhsdCCsFmEizJx+4C65RHx3q5f3VoXdEk/yYLbtlJZlZuD0B+MZOa4MT4L23QRi4a8Y618kXKQjc6dXJR757FENhQETaHSv+P9O0Iqblx5MuI9K7BhCvs4XvKsnTdTUzsp4nwUjWxVKpsTbwr+LlHXn269J4M4sNSEmEe9uxKdI6eLdtafp+x+P+kcajqQgdL0aY8sRzVjoQiey92sWejYZcsCgOngX7OVyDQ0fW04uPb2Qp4WXzx9OsoUD70e+LXsW/shLn75n+IKJkB/9K1GfAUEuvRwK1KiKo3BcIkdw3uZ2deLd5S/LopOMVvmafUFT+DcqqgkVjfnxT2WoO5j3KaBywClFM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(7416014)(10067099003)(260925021311599003)(11063799006)(260925021911599003)(56012099006)(260925022911599003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0NRTGxuOGFiTnNSL0ZzY0RDSTV4SEdPMy9WOEJjS1lScVJuNmRtVHEzdklX?=
 =?utf-8?B?NVVHYWFEelRQN3JSN3hNdzlyUjI1OEh5K3BXdDVIREFjSjlQdk1JNkt5MFY2?=
 =?utf-8?B?VHFwdjZHL1V4Q1ZFVnhocXlFZlQ0ZjQ4aVZKNWdIaHlpRjk2bDlVVjc5OXdM?=
 =?utf-8?B?YmZPbFdTOG1UV3Zodi9ybEZlaHRWekhqd1NoRWZGOGp5UjJCeGlPY1VzeUhX?=
 =?utf-8?B?UldReXBWU1hmdmhZazg5WnhvN3o1dkJEbGtjNVFzTmdJN1UzdGFCbTc0ckZr?=
 =?utf-8?B?T2FRd0JudVd6UmEzQVBQSkxEWnZwMUhycWxzZVduK3R1Z2dEODZ6UElnNWZq?=
 =?utf-8?B?djBjZlR6c2FybVExR2gzbFl6b1NTUU1OYVNEeXY4WUIxMU0wR2NtZUk4VDNM?=
 =?utf-8?B?U0hjQXFzcWNYWE1SNFoyNlp1aTZPZ08zZ0RHMTd2cjBTMUF0UjMvUERPS0Jo?=
 =?utf-8?B?SFFMMS9FN0tUQVcwb3A3OE12dHZRcWsrdkpDakgyZU56ZHhUeDFiL05IS3BD?=
 =?utf-8?B?VTc2eGQyUGRTVkZ6WHlEaTB6VE8zYm16SlJVcXgzQ2QvcDJOc3hpUk9NYWNo?=
 =?utf-8?B?cjc5V3g2aXpOcWxjNnZ1QlN1cStqb2NZUkowMHNuclhPNklZTE9wOERpMUEv?=
 =?utf-8?B?azdnNWpCVkNDRFJCdEd0eHRuUVErYTR5YmNNb1ZhN1dvS3RWYkpYbFdZMytR?=
 =?utf-8?B?QlBCRmIreE5GL2sxQXRBQVk1MEdlLzZWbmZpMXJubkVmeGhiUHM3a0djUito?=
 =?utf-8?B?dE5oSXh2Nm0yUjYzNnpVMUdRUzRBbmhnelgzaFpaNTVha2JKNkU0a2UzUXBq?=
 =?utf-8?B?dUIyTDR0enFRZEp6Zm1sSWRVYTYzQUhMYzN1MFRyN2h4Mk5FOENXOS9qNUlQ?=
 =?utf-8?B?aU9NNnI0WXNCSW1TYTF5RjhoOWZUWFZodTd0ZDVqd1lVTVBkNFpDOFA5QnB3?=
 =?utf-8?B?UlRlbDY5dzFoWmpzV1ZDaSt5NWd0WURvSHZLMEJ0bXRzN2RGK2lGRityZXp1?=
 =?utf-8?B?RHpmMGY5UmFNZXRvblhDWnZSVTZYdXgwR3BCVXl6blVYZ0NZM3BnMDN6TUZq?=
 =?utf-8?B?a2Z0dHhjazk5VXBYc3A0YUpKOXRPckVRYUJUVjd1aTZYd2ZybGZRelVsSkFu?=
 =?utf-8?B?aEh2a2dYNnBHTVFrSlZKTnFiMUNXMTNaK3FlWjJDOEl2Q1N4QXBoMjd0eVVr?=
 =?utf-8?B?RFVibTNFK3NObS9idkQweTJVaFdsSWYySWIwMTBFMTdpVmI1dzZWT214Vk5W?=
 =?utf-8?B?M3BqSjNCeEJRQjI1RnZZVmtwbTZESE5QR2Q5UlR0eEtDdjF3ZjhPSmlCSUxa?=
 =?utf-8?B?eDlKbVJrZlRRaFVHRVRvM0hUWW9qTEVlWkZtN25oRHdXaHlGR3RqNEFlbkU1?=
 =?utf-8?B?UjhFMTc0ajJRZ05IUDdrNmxPUVV3Ny81aWNFcjhTWmZlWHd5MjVqV1lrYkZh?=
 =?utf-8?B?NGQ1TERxa0krSnFnVkowL2ZBSDE4VnNOR3dzWDgzcWt1RndscXJ3cCtUdXhQ?=
 =?utf-8?B?REVXeXZRV3Q2K3kxYW1tbjJTYm9LZWlBYmhONktyK0xzSGZHNzhScHRwK1lr?=
 =?utf-8?B?dW5RTks0dEZBQmttTlhsbVdNa0FGZk5oRGVJWlczQi8yMDl1SnJHUnIvYjJN?=
 =?utf-8?B?OW9odzVkYnVDTldROFFJeUNJMnRPNFAwZWIrbUE3amVUd2s3dTc3K0Y5V0RB?=
 =?utf-8?B?NUdFaGZxQW0xNG82elpDZ2VkdmtWQTdETlhTb29NdkFKckNrc1BOcGJaSXdj?=
 =?utf-8?B?L2pQZGhiZDNVcXdJRTdnVCtMZUUxcXRPV2dNYmV6RFp5RWp0clRUWkdaWjRn?=
 =?utf-8?B?RWJKVUNhQ2dZR0pWTlFzZTVOQVl4b0ZlSDhzdTJBYVNoaGhZSXUycjd3QU1U?=
 =?utf-8?B?NzZjWmk4cDFENlRaWHZpekd3cHk1RWxPTWpZWllqTGhVcnN1Kzc0cDQyajZy?=
 =?utf-8?B?a3g5RmV6QldrT3phMUJxS1JJQWhmY2dzdkxCeDBwUjNjZGRQYjVVZHhtN29n?=
 =?utf-8?B?eFpEanFhZG1sMVpEajQ3RE9vMjNqTWt0NVFWTFRDU3VHTlRWY3IxbW1CVDFo?=
 =?utf-8?B?Y0VpbGtFVXh0QXF0Tm9kM3QwM0dJZmQ4c1ZEZkM4Nm9JUU5DTjlJQVF4UFN2?=
 =?utf-8?B?OTZyM2QrajRoc0VNLy9oRFRoaFJKSWd5SjMvTmhXL0xTQm41ODhQY080cHBB?=
 =?utf-8?B?N2ZKVS9tMFlPMFhhNjdTTGQ5MkIyM1FPMWsxRmtTSjlVQ25wVFM5UkkydU9L?=
 =?utf-8?B?V2dUa0FoblQ5dmdFRHJuRTdiRDlBREdTT01yNkI4M3VSWG01WHNLb3J0R1d1?=
 =?utf-8?B?aC9wbGJYUVcwa0JncndzVndGVCs5V0VxTU5xcWUxcjZhV3FqcUtjM3hTZlhI?=
 =?utf-8?Q?yF8GbSeBC3onwpJk=3D?=
X-Exchange-RoutingPolicyChecked: ZtnUwXm42oNeV+uCQb1abCuFw1ZVUtmQD8VJDbXba5r4RBs9HdSKwgL3BQyzvGQx/td34avw2H6gIChhdML38CeMnij+/OoVWPtWirKhuj1kLaoEnqI3gvFp8MEAZmknObjZAHff7DLNPWWgF5fUGqwRZUfPdH1CT6zdAnnYQA5XOV3SzkTyTN6tvZTuZtmMmNIxPe3k2rNbWosEwvJk3WVBNh10v1j0Nx0A8bTas3iD/8CJRciM0XyyKVrLdM0VO+Sk5PSneMj+yzegUufJlDiV2rnyfJQPFyKGtHo/m0RuaHqOinnMSflvWSWtZPyrUxeDxkEhXdKAJAGZfjHHiA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f349d56a-18e4-473e-2427-08df1fbb9714
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 12:57:46.9997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWAJ6aCH/6CamYxdTkoHB1qReB0HoPOWY+8icJht+UyjZ/wR9kIi6b5FBsNYV2ExqDmPVQnUzKydfthocEZ07g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8403
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

Here goes our likely last PR towards 7.4 of xe changes.

Thanks,
Rodrigo.

drm-xe-next-2026-10-01:
UAPI Changes:
 - New sysfs to expose device UID (Badal)

Driver Changes:
 - Nuke PTs only after unlinking contested VMAs (Auld)
 - Limit sg segment size to PAGE_SIZE on Xen PV (Szymon)
 - Move locking to xe_sriov_pf_reprovision_default (Michal)
 - New workarounds (Tilak, Tales, Daniel)
 - Keep VF LMEM BAR size low if no VFs enabled (Marcin)
 - Drop ratelimiting from dev_unhold_work debug trace (Varun)
 - System Controller's Maibox response improvement (Anoop)
 - General clean-ups (Roper, Lin)
 - Revert "drm/xe: Set mask bits for CCS_MODE register" (Roper)
 - CPU binds and ULLS on migration queue (Brost)
 - Re-apply an i2c patch silently removed by a merge (Bartosz)
 - New PTL PCI ID (Atwood)
 - Enable PXP for NVL-S (Alan)
 - Let xe_guc_ct_send_locked() callers reserve G2H credit (Sujaritha)
 - Implement print vfunc for page fault info logging (Brian)
 - Do not dma_fence_put zero fences in err_out path (Jonathan)
 - Add focused VM teardown and page fault tracing (Daniel)
 - Fix ULLS chained job loss and GT reset replay (Varun)
 - Refresh TTM LRU on SVM prefetch (Himal)
 - Fix xe_mmio_wait32() to honor delay/sleep maximums (Alan)
The following changes since commit 320662381ca243a3364663e917a7447afaf618fa:

  drm/xe: Poll GT for C6 before D3 (2026-09-18 11:52:56 -0400)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-next-2026-10-01

for you to fetch changes up to 70dab9ee7d620e6018a64798aed065d14e9baed1:

  drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep maximums (2026-10-01 08:46:23 -0400)

----------------------------------------------------------------
UAPI Changes:
 - New sysfs to expose device UID (Badal)

Driver Changes:
 - Nuke PTs only after unlinking contested VMAs (Auld)
 - Limit sg segment size to PAGE_SIZE on Xen PV (Szymon)
 - Move locking to xe_sriov_pf_reprovision_default (Michal)
 - New workarounds (Tilak, Tales, Daniel)
 - Keep VF LMEM BAR size low if no VFs enabled (Marcin)
 - Drop ratelimiting from dev_unhold_work debug trace (Varun)
 - System Controller's Maibox response improvement (Anoop)
 - General clean-ups (Roper, Lin)
 - Revert "drm/xe: Set mask bits for CCS_MODE register" (Roper)
 - CPU binds and ULLS on migration queue (Brost)
 - Re-apply an i2c patch silently removed by a merge (Bartosz)
 - New PTL PCI ID (Atwood)
 - Enable PXP for NVL-S (Alan)
 - Let xe_guc_ct_send_locked() callers reserve G2H credit (Sujaritha)
 - Implement print vfunc for page fault info logging (Brian)
 - Do not dma_fence_put zero fences in err_out path (Jonathan)
 - Add focused VM teardown and page fault tracing (Daniel)
 - Fix ULLS chained job loss and GT reset replay (Varun)
 - Refresh TTM LRU on SVM prefetch (Himal)
 - Fix xe_mmio_wait32() to honor delay/sleep maximums (Alan)

----------------------------------------------------------------
Alan Previn (3):
      drm/xe/gsc: Define GSC for NVL-S
      drm/xe/nvl-s: Enable PXP for NVL-S
      drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep maximums

Anoop Vijay (1):
      drm/xe/sysctrl: Allow per-command mailbox response timeout

Badal Nilawar (1):
      drm/xe/cri: Expose device UID through sysfs

Bartosz Golaszewski (1):
      drm/xe/i2c: Re-apply use device_create_managed_software_node()

Brian Nguyen (1):
      drm/xe: Implement print vfunc for page fault info logging

Daniel Charles (2):
      drm/xe/xe3p: Force non-compressible memory reads to 256B overfetches
      drm/xe: Add focused VM teardown and page fault tracing

Himal Prasad Ghimiray (4):
      drm/pagemap: Add helper to access backing devmem allocation
      drm/gpusvm: Add devmem callback to get_pages
      drm/xe: Bump prefetch BO LRU via GPUSVM devmem callback
      drm/xe: Bump prefetch BO LRU for already-valid ranges

Jonathan Cavitt (1):
      drm/xe/vm: Do not dma_fence_put zero fences in err_out path

Marcin Bernatowicz (1):
      drm/xe/pf: Keep VF LMEM BAR size low if no VFs enabled

Matt Atwood (1):
      drm/xe/ptl: Add a new PTL PCI ID

Matt Roper (2):
      drm/xe: Drop old Xe GT ID macros
      Revert "drm/xe: Set mask bits for CCS_MODE register"

Matthew Auld (1):
      drm/xe/vm: nuke PTs only after unlinking contested VMAs

Matthew Brost (24):
      drm/xe: reference VM from PT BOs
      drm/xe: Drop struct xe_migrate_pt_update argument from populate/clear vfuns
      drm/xe: Add xe_migrate_update_pgtables_cpu_execute helper
      drm/xe: Decouple exec queue idle check from LRC
      drm/xe: Add job count to GuC exec queue snapshot
      drm/xe: Update xe_bo_put_deferred arguments to include writeback flag
      drm/xe: Update scheduler job layer to support PT jobs
      drm/xe: Add helpers to access PT ops
      drm/xe: Add struct xe_pt_job_ops
      drm/xe: Update GuC submission backend to run PT jobs
      drm/xe: Store level in struct xe_vm_pgtable_update
      drm/xe: Don't use migrate exec queue for page fault binds
      drm/xe: Enable CPU binds for jobs
      drm/xe: Remove unused arguments from xe_migrate_pt_update_ops
      drm/xe: Make bind queues operate cross-tile
      drm/xe: Add CPU bind layer
      drm/xe: Add device flag to enable PT mirroring across tiles
      drm/xe: Add ULLS support to LRC
      drm/xe: Add ULLS migration job support to migration layer
      drm/xe: Add ULLS migration job support to ring ops
      drm/xe: Add ULLS migration job support to GuC submission
      drm/xe: Enter ULLS for migration jobs upon page fault or SVM prefetch
      drm/xe: add migrate ULLS period configfs attribute
      drm/xe: Document ULLS for migration jobs

Michal Wajdeczko (1):
      drm/xe/pf: Move locking to xe_sriov_pf_reprovision_default

Shuicheng Lin (2):
      drm/xe/madvise: Remove unreachable madvise_funcs NULL check
      drm/xe: Remove no-op ternary in emit_flush_invalidate()

Sujaritha Sundaresan (1):
      drm/xe/guc: Let xe_guc_ct_send_locked() callers reserve G2H credit

Szymon Acedański (1):
      drm/xe: Limit sg segment size to PAGE_SIZE on Xen PV

Tales A. Mendonça (3):
      drm/xe: Capture devcoredump on TLB invalidation timeout
      drm/xe: Log when a timed out TLB invalidation ack finally arrives
      drm/xe: Implement Wa_22016122933

Tangudu Tilak Tirumalesh (3):
      drm/xe: harden adjust_idledly() against divide-by-zero and overflow
      drm/xe: Add wa_14025941587 to xe2, xe3 and xe3p platforms
      drm/xe/xe3p_lpg: Add support for Wa_16030224309

Varun Gupta (4):
      drm/pagemap: Drop ratelimiting from dev_unhold_work debug trace
      drm/xe: Park on the ULLS semaphore before publishing the next job's tail
      drm/xe/guc: Publish the ring tail when replaying a chained ULLS job
      drm/xe/guc: Rewind the LRC ring head when replaying a ULLS job

 .../ABI/testing/sysfs-driver-intel-xe-gpu          |  10 +
 Documentation/gpu/xe/xe_migrate.rst                |   3 +
 drivers/gpu/drm/drm_gpusvm.c                       | 105 ++-
 drivers/gpu/drm/drm_pagemap.c                      |  17 +-
 drivers/gpu/drm/xe/Makefile                        |   1 +
 drivers/gpu/drm/xe/abi/guc_klvs_abi.h              |   1 +
 drivers/gpu/drm/xe/regs/xe_gt_regs.h               |   3 +-
 drivers/gpu/drm/xe/regs/xe_regs.h                  |   2 +
 drivers/gpu/drm/xe/xe_bo.c                         |   4 +-
 drivers/gpu/drm/xe/xe_bo.h                         |  29 +-
 drivers/gpu/drm/xe/xe_bo_types.h                   |   2 -
 drivers/gpu/drm/xe/xe_configfs.c                   |  67 ++
 drivers/gpu/drm/xe/xe_configfs.h                   |   2 +
 drivers/gpu/drm/xe/xe_cpu_bind.c                   | 296 ++++++++
 drivers/gpu/drm/xe/xe_cpu_bind.h                   | 111 +++
 drivers/gpu/drm/xe/xe_devcoredump.c                |  46 +-
 drivers/gpu/drm/xe/xe_devcoredump.h                |  15 +-
 drivers/gpu/drm/xe/xe_device.c                     |  14 +
 drivers/gpu/drm/xe/xe_device_sysfs.c               |  36 +
 drivers/gpu/drm/xe/xe_device_types.h               |  15 +-
 drivers/gpu/drm/xe/xe_drm_client.c                 |   2 +-
 drivers/gpu/drm/xe/xe_exec_queue.c                 | 161 ++---
 drivers/gpu/drm/xe/xe_exec_queue.h                 |  16 +-
 drivers/gpu/drm/xe/xe_exec_queue_types.h           |  20 +-
 drivers/gpu/drm/xe/xe_gt_ccs_mode.c                |   6 -
 drivers/gpu/drm/xe/xe_guc.c                        |  16 +
 drivers/gpu/drm/xe/xe_guc.h                        |   2 +
 drivers/gpu/drm/xe/xe_guc_ads.c                    |  11 +-
 drivers/gpu/drm/xe/xe_guc_ct.c                     |  23 +-
 drivers/gpu/drm/xe/xe_guc_ct.h                     |   2 +-
 drivers/gpu/drm/xe/xe_guc_engine_activity.c        |   6 +-
 drivers/gpu/drm/xe/xe_guc_hwconfig.c               |   2 +-
 drivers/gpu/drm/xe/xe_guc_log.c                    |   7 +-
 drivers/gpu/drm/xe/xe_guc_pagefault.c              |  35 +-
 drivers/gpu/drm/xe/xe_guc_pc.c                     |   3 +-
 drivers/gpu/drm/xe/xe_guc_submit.c                 |  90 ++-
 drivers/gpu/drm/xe/xe_guc_submit_types.h           |   2 +
 drivers/gpu/drm/xe/xe_hw_engine.c                  |  96 ++-
 drivers/gpu/drm/xe/xe_i2c.c                        |  22 +-
 drivers/gpu/drm/xe/xe_i2c.h                        |   1 -
 drivers/gpu/drm/xe/xe_lrc.c                        |  73 ++
 drivers/gpu/drm/xe/xe_lrc.h                        |   4 +
 drivers/gpu/drm/xe/xe_lrc_types.h                  |   4 +
 drivers/gpu/drm/xe/xe_migrate.c                    | 771 +++++++++-----------
 drivers/gpu/drm/xe/xe_migrate.h                    |  95 +--
 drivers/gpu/drm/xe/xe_mmio.c                       |   5 +-
 drivers/gpu/drm/xe/xe_pagefault.c                  |  53 +-
 drivers/gpu/drm/xe/xe_pagefault_types.h            |  10 +
 drivers/gpu/drm/xe/xe_pci.c                        |   5 +
 drivers/gpu/drm/xe/xe_pci_sriov.c                  |   3 +
 drivers/gpu/drm/xe/xe_pci_types.h                  |   4 +-
 drivers/gpu/drm/xe/xe_pt.c                         | 779 ++++++++++++---------
 drivers/gpu/drm/xe/xe_pt.h                         |  12 +-
 drivers/gpu/drm/xe/xe_pt_types.h                   |  49 +-
 drivers/gpu/drm/xe/xe_ring_ops.c                   |  86 ++-
 drivers/gpu/drm/xe/xe_ring_ops_types.h             |  24 +
 drivers/gpu/drm/xe/xe_sched_job.c                  | 101 ++-
 drivers/gpu/drm/xe/xe_sched_job.h                  |  56 ++
 drivers/gpu/drm/xe/xe_sched_job_types.h            |  49 +-
 drivers/gpu/drm/xe/xe_sriov_pf_provision.c         |   4 +-
 drivers/gpu/drm/xe/xe_svm.c                        |  68 ++
 drivers/gpu/drm/xe/xe_svm.h                        |  18 +
 drivers/gpu/drm/xe/xe_sync.c                       |  20 +-
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.c            |   7 +-
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h      |   3 +
 drivers/gpu/drm/xe/xe_tlb_inval.c                  |  54 ++
 drivers/gpu/drm/xe/xe_tlb_inval_job.c              |  28 +-
 drivers/gpu/drm/xe/xe_tlb_inval_job.h              |   4 +-
 drivers/gpu/drm/xe/xe_tlb_inval_types.h            |  17 +
 drivers/gpu/drm/xe/xe_trace.h                      |   2 +-
 drivers/gpu/drm/xe/xe_trace_bo.h                   |  58 +-
 drivers/gpu/drm/xe/xe_tuning.c                     |   4 +
 drivers/gpu/drm/xe/xe_uc_fw.c                      |   1 +
 drivers/gpu/drm/xe/xe_vm.c                         | 275 ++++----
 drivers/gpu/drm/xe/xe_vm.h                         |   3 +
 drivers/gpu/drm/xe/xe_vm_madvise.c                 |   6 -
 drivers/gpu/drm/xe/xe_vm_types.h                   |  12 +-
 drivers/gpu/drm/xe/xe_wa_oob.rules                 |   4 +
 include/drm/drm_gpusvm.h                           |   6 +
 include/drm/drm_pagemap.h                          |   7 +
 include/drm/intel/pciids.h                         |   1 +
 81 files changed, 2717 insertions(+), 1370 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-xe-gpu
 create mode 100644 drivers/gpu/drm/xe/xe_cpu_bind.c
 create mode 100644 drivers/gpu/drm/xe/xe_cpu_bind.h
