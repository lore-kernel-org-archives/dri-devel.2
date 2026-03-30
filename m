Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA1910D14B6
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 13:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F7A410E14C;
	Mon, 30 Mar 2026 13:40:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QZYiU7dZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DD3C10E129;
 Mon, 30 Mar 2026 13:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774878048; x=1806414048;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=85De2iFbDpP3Cw+AYM79bvTbRP4omlgb9EaXJFr0Ofg=;
 b=QZYiU7dZFbFv8wo26U6kVxe6eNpIrC6RwSGvo1OFc4bxPCMVWPAJ4LqI
 CcaWQ3qJxrj3tpVCXS5z4shXuIdqyFgCoWU4Dh4bQSqWTf0W6IjfPllgi
 Yd2a3xf7GtGXyjCl/XSfKtkysNdT7tYjcTbsjR7Amk6jPT5zw3i1wW6Er
 8iLqD0QiXz91UCRhQPKXqMc/Bknxya42GpMfNaobC7jjcVDLO/soRH7ji
 JtlCfS9fwDM6PjUJNloHwTkIbAIgixh7A6vbFqqQUBQMJxO3skNJnLTtr
 bght0cd5trfBogRiQa86cfaKRmRYJttTQbHRN77PeW+xwl0gFXjhBNQ5K A==;
X-CSE-ConnectionGUID: VgMin+CqTG+hVhKgXSywjw==
X-CSE-MsgGUID: 9cEPFLMaSJ6x0C1OqlGUjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75048249"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="75048249"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 06:40:48 -0700
X-CSE-ConnectionGUID: x+i0eLOwRLS4oCXN5oRPjg==
X-CSE-MsgGUID: tJoM6R3nQD2HMRdoogKilw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="223182782"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 06:40:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 06:40:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 06:40:47 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.9) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 06:40:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ge/2KZw0eS3+JA5dpV/oYE7Re5QM7uzGGQOOvyv/AzWrFT0qeJmZQLq+wXYn0WisVmlO6qUpoAcdpcRPzuWapJxx0sC2fGaZARJ9SpFYSa2RLhtWX0r3KDV6TCb3yw1VwKeV+BUevOcibnsof7dNMNfIaYs79pyaxYJ3dz7MXTOZeCSrLTvYmx+iyhYixQRGx6pDxTttDzbL7AH7r2xe9tjvO/AAuv5xq9i2KX3JJcwtaWfcTlrxWNneEAF7YZ93lSXYMM9hCOKn00Yh/aFOX14p8KSqR2vSdx2aoqIZZOwv5ByghvGuedwJK3pG+qjKFfmRbwpE3t+RyS6V6DlNBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/L9vPYs1O8gxO0iQ0geFm5OA7L8THuAmG15WwA9+Qg=;
 b=NabIW5G/dMqQ9CfLerDHvwXt11pNdgdeM4AAk7vOqyC4mjUb8dS2Urf0y4uRGm/Whhb7p19F0ADeslAhnMeNL3X6fCIH/7Bl/3WaYn/YL9SLF6rM7qk8nnfXltVXjNyevWESOyFyOKtD8EXNTNi8g5TLWDlVdRtW2LhO+l5ej6UhK2fTj03Ow/MVvVxVqtONINlTlffpiki807VoF1pWow5AyHcq1CfD12oYHD6r54sHL/ESsHaOm6kC0uNezLsMDkuvr0oWhaEN8P4r6yVw49BGgcjuImV8rbFWZWUmyXlIxhOVc2/N0Ku16FAqiP/Fbv8YhSwC4FGc/+SL6PbXWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6207.namprd11.prod.outlook.com (2603:10b6:208:3c5::21)
 by DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Mon, 30 Mar
 2026 13:40:44 +0000
Received: from MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d]) by MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 13:40:43 +0000
Message-ID: <227a4bce-b3dd-4633-a2ae-8dceb82a6653@intel.com>
Date: Mon, 30 Mar 2026 19:10:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] drm/xe/debugfs: Add interface to trigger power
 management unit error handler
To: "Tauro, Riana" <riana.tauro@intel.com>
CC: <andrealmeid@igalia.com>, <christian.koenig@amd.com>, <airlied@gmail.com>, 
 <simona.vetter@ffwll.ch>, <mripard@kernel.org>, <anshuman.gupta@intel.com>,
 <badal.nilawar@intel.com>, <karthik.poosa@intel.com>, <sk.anirban@intel.com>, 
 <raag.jadav@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rodrigo.vivi@intel.com>
References: <20260318064016.374656-7-mallesh.koujalagi@intel.com>
 <20260318064016.374656-12-mallesh.koujalagi@intel.com>
 <ab3e5dcf-d259-4a29-a70b-071bcdd24ec2@intel.com>
Content-Language: en-US
From: "Mallesh, Koujalagi" <mallesh.koujalagi@intel.com>
In-Reply-To: <ab3e5dcf-d259-4a29-a70b-071bcdd24ec2@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::19) To MN0PR11MB6207.namprd11.prod.outlook.com
 (2603:10b6:208:3c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6207:EE_|DS0PR11MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f69235-0dea-4e96-d3b6-08de8e61f0aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: fFdn9shVEY09d/DYz+fSyd8GcAiZatETWu4bRY2ZBQdr3/JNa1xKLyenZIENKO9xdkGFdwtOBFANnIZN51F9ahUy+oHhuRthT/s+HhCJLhhfvw9n/sXon1ygxIHVK1mylRIuMno/4HB4bodVFmY4ULNNdX/kV5kb5sm5NQnJbHfxVlB8q/nBBuALDuiqekQbZHqNIk7dKkQIz0z0ad1eh5mQpJf1Wip3H6Uu3QodKwV5p+O03ZIlSgbq2J8m73tbe66xt1bPk+JhvL1F0lGhhKuoFGzcjVCiBYMv1RpcbBVfxqabJyq65FiKqOl1fJFnSfyisXkY5KuN87fBwRsp/Qqpj20q0+ZLN4qxZBs8EOYbNr608NJfL+/Dyhqp/g+/a8Ow3Rlg80a+p9xQ4TNojsC1Q6m1v/qcxGhC8fkvxFSqA9tO6Nfx5MXadH4V9hk/LkYiSGnjU4OCQPl7D5nqBMs1ldyoGvXQwUSVNOu/4/UbThNPHULRyZR0BEWmmIBYN10O2pVAj+9LF67ExTvXiLtmzgFT+GmB3lsv0kW4C+LpnaN8wMZ5KFNAsOCZYTdZJewRWzy5TCi2wFOstv1YrJiM/6dwvcDpnC8uv4e3/xskutkslBsQQhJ8A0CG6zp9Tfv8sc9w6uYiFlLvJghuHij5F6yohs2fwd6eCJOg0jZm0B2UHOHthOUSgQoTWl8e9cUYJLIE9CZOGlhjoQhJthFJOtFLaRNQw5W1R9jKSsI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6207.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enNGcGNaRmtwQzRnQW1YR0hMSXhJUzd5endNZXlweFhWY0pleGc2eFVKZENl?=
 =?utf-8?B?UVRrYkFCNGFkR0lHWjhQcjBSTzdyWEZrUm42QUg1Zy9MK3MvS2Q0bHJMbEh1?=
 =?utf-8?B?LzlKSGlaTTFaY2R0RHdFTExxcURDTEZJalY3bEYzMVRVZmhrUlJNbDhkenlQ?=
 =?utf-8?B?OHNKTmM3Z045V085eVJPdzJwSTEwMmJ6bDI1TlQzT2VwZGJlSFAyNFQyNEtl?=
 =?utf-8?B?SndQd3B3S29DdzhnTlk5R0pPejV4RG5sbjN4M25obmFQUVJ5ekFESk8yT05I?=
 =?utf-8?B?SUhuYjcrOGtoQmx2RjRPZG94c3AxRmlyayt0am9OVlh5TnVKZ3hPSFdwT0hM?=
 =?utf-8?B?UHJxZFRya05tbUdxVWcvdGU4WVJZOUhZRDA4NC9Gc2xmMVcxZGRjcThlMUpl?=
 =?utf-8?B?T2JPRWNLalVCR0oxSEVUWDMwYTNjVnRudlc2Y3VocnJPQThOblpCNjJYQ0RQ?=
 =?utf-8?B?eHpMcjF3V2R6RTBSdXNaRC8zeFVUY1k1aFg4S1hKS0w4b2gzanpndFF0VHI2?=
 =?utf-8?B?RUxtVExJVDg4VFFXK2RBWVZ5OFNTSjgxK2xKZW5EWFV3YWVHOGtnWGd0TEFE?=
 =?utf-8?B?dFBwSVN5aDJMbWplRmJydG00Zkp1MUhSdE04Vk9pcFpBV2RPNGUyRzhLbGRl?=
 =?utf-8?B?SjRobWJHVmxuTVdkRml3YVQ0ZDc4M3dIaTVYWmN6bXdFbkh1d2FtM2lqWWJk?=
 =?utf-8?B?aENsWmRoVG1xdDF3aWxBQkxZWkhhUENVR2Jta3hjdmtCTDQ4dlFIbzA5QURl?=
 =?utf-8?B?Q3NtVktiNEhxZXFhbmFQRlgwUUJ3SUhKdUJKdWMramNJMDNadmxEamVkUEk2?=
 =?utf-8?B?NjByZVIwME5CbFNOelowY1dId1JiMlhnTmJGNHJRa2UxczFZTllocWlYbzVl?=
 =?utf-8?B?aExPVnNZeXYzTTY3Z1FmN3phQ3IzeldlR0lYdUFpaWFrQS85NTJGckp6dTlQ?=
 =?utf-8?B?ZnVSSmNKTU9kVVZHVzBCeXdQSTlYYXdIUVRCM0dlVm9zZFk2bklhRURPYWUz?=
 =?utf-8?B?YzBZVnBIQlRldDBCVVh5Y0srMWMvUnlkeGF6STArTzFRRmZKZVlSS1JxdzFi?=
 =?utf-8?B?OEdlTU9Kck1xTHBuTVJSKzVyV2xVQmt1dmJyejljV21nQ0V3cE96RjVyOFlz?=
 =?utf-8?B?c0E2bmhBRTBCNm5iNGtXRWFKME9oRzdDbWtVL2wvME1WdGJReHo3WUhGSXRZ?=
 =?utf-8?B?dDlXdG52V2ZXK2w5NG9oa1pYaXJ3aEp3K2dlc05RaUpBdG5IMER2ekh2WHdw?=
 =?utf-8?B?MThUaFpuaGw5bEZLRXV6WG9CVTN2UmVLR1hhcEtBa29ucUZGcDV2cWRPUjhE?=
 =?utf-8?B?dnNHWDljRHhlZ2lNNFFzMmtUYW5oOUg0MXRZZGx5Q2FueWJCNG9jb3lCQXBX?=
 =?utf-8?B?T2xOSFB0OFFMWlMyNk1OSnVkQS8yeGNleVRTVVQ3UVgvNHpEYjZXV3lJV29W?=
 =?utf-8?B?dFV4MEVPRVZMeWJpUm80dncrckpyVzlRdXpRdDFNdWFkTUVhRFZ2VjZsUllt?=
 =?utf-8?B?ekY0Q2l0WGljak5KdGxYS0kyaEJIbWdBNXBZdHNNSVFCWU9wK2pTVzFTOWor?=
 =?utf-8?B?aG1GZnhqMWlQVlhsVnBTaFZYRDFvNlA2Mkx3eU5SRE1JMWJPZjMraGJ4SEho?=
 =?utf-8?B?a24zUzJmdWJVWkxodXlDTVhZblRzNlI0M1J0cnlxU1M5bFRQRjJqNWg2T2ZI?=
 =?utf-8?B?VzlwL3RRWnZINkJkeEJNR2R0dUxYNzlnSHdZOFBqdG5EUDlkTjE1TmdKZ29B?=
 =?utf-8?B?OEJoTGU2aEMybUNKWnJhWkUrZWxBZjNNUXpabXRlbllmM1BvTWNJWlF6R3dR?=
 =?utf-8?B?cEJtY0xyNGhnUlJSalFzSzNocVVTYytWS2VZS1dHYmY4VUYwaEJMY1dvL0Vx?=
 =?utf-8?B?MDJzQkZHanN0K3VMZ2hvcmIrNDlGYng0ajBWbmtBU0VIckdPM2xrK09mQTlZ?=
 =?utf-8?B?ZXpycGRLdUpmVXZjbVFsazQwNWxHTmF4YlpSNXlWdnBGOWlTMWIxMlY0bk1H?=
 =?utf-8?B?N2FyaVpGaEFpTitlYTkrTXZha2JqeHRzTEo0d2pWNmJiZi9aVjNlYmpZQ21r?=
 =?utf-8?B?Qjk5ZEpZME9DMFFNa3dnV2NYMENyYXBKeFBzY05TZDRXVHg2cEN6TVpIYTdB?=
 =?utf-8?B?UGJ6WVRMNFhiTVA5eUJEN1A4akVCcTlDQ3BWR1M2WFVUS05palFuMTY4NzJm?=
 =?utf-8?B?b0ozUEZIZVI5NmF2ZDlJUjUyMUs2L3VsTUpzOUpmNlpqcHpIYUlodUpWM2Jo?=
 =?utf-8?B?UFE1eTNsak50SDNBYWg4Q1ZKcXNUcERObGF0KzVJSENzTWM2WTdSS01Cc1Nv?=
 =?utf-8?B?ckwvdmdTQ1pUNUZROE51NURDSkxxVjhudjZFWFlJYVJXQWlERlA1bFhhVGxW?=
 =?utf-8?Q?Dq/oOEGSeUqXAIDE=3D?=
X-Exchange-RoutingPolicyChecked: kTiU3r3KCj9LtS8NC/5KS/ZNaU12MKwWF2yZM0xabM5t4a21kgcQmss/V26YM4MZFbT5PfM70PGY3ozFGAMwZrtwU0jB70jTX3OjS6J6D3fhdYOeoe5CdZuNK3If3bGdoOPPcXCnzI7RbTpNDhFKAS/HoUH/d2Gu81VBHDfuIlarH0QbeTEx3+yw6HPIO+rnd9cgSzbuBz3c0hoUnDB7bWK6+0PZQc+ad6ALSV8s6D8NmveI2YfoEGQojku3aKEldy3NfK0GL7LCPVeRqfY+gmEUewE1NJyI91PyYdGUSHOXJDwX+MCFPts0oDcQGXof1ktqoMNGFgCnopXCDMkCLg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f69235-0dea-4e96-d3b6-08de8e61f0aa
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 13:40:43.7985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLD83qdiKYsRtwjJ6imHC6XrjZWLY4BvDS6Lwq+kgqyMPXWirrYusFRLBvPwN/yrCZSVQVWew4W6kFCujWsAKlgtB2nJBJNbCFtQTenTHsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7481
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


On 30-03-2026 10:25 am, Tauro, Riana wrote:
>
> On 3/18/2026 12:10 PM, Mallesh Koujalagi wrote:
>> Add a debugfs interface to manually trigger power management unit error
>> handler for testing cold reset recovery paths. This is useful for
>> validating the error recovery mechanism.
>>
>> The new debugfs entry 'trigger_punit_error' is located at:
>>    /sys/kernel/debug/dri/N/trigger_punit_error
>>
>> Reading the file displays usage instructions. Writing '1' invokes
>> xe_punit_error_handler(), which marks the device as wedged with
>> DRM_WEDGE_RECOVERY_COLD_RESET method and sends a uevent to userspace
>> indicating that a complete device power cycle is required for recovery.
>>
>> Writing '0' or any other false value has no effect.
>>
>> This interface is intended for development, testing, and validation
>> of power management unit error recovery code.
>
> Would fault injection be more appropriate here?

Here we need a deterministic way to invoke the punit error handler to 
test the cold-reset

recovery flow end-to-end. Using debugfs interface, we directly triggers 
wedge/reset status via a debugfs write

rather than using fault injection.


Thanks,

-/Mallesh

>
> Thanks
> Riana
>
>> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_debugfs.c | 38 +++++++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_debugfs.c 
>> b/drivers/gpu/drm/xe/xe_debugfs.c
>> index 844cfafe1ec7..390bbed9c1af 100644
>> --- a/drivers/gpu/drm/xe/xe_debugfs.c
>> +++ b/drivers/gpu/drm/xe/xe_debugfs.c
>> @@ -18,6 +18,7 @@
>>   #include "xe_gt_debugfs.h"
>>   #include "xe_gt_printk.h"
>>   #include "xe_guc_ads.h"
>> +#include "xe_hw_error.h"
>>   #include "xe_mmio.h"
>>   #include "xe_pm.h"
>>   #include "xe_psmi.h"
>> @@ -509,6 +510,40 @@ static const struct file_operations 
>> disable_late_binding_fops = {
>>       .write = disable_late_binding_set,
>>   };
>>   +static ssize_t trigger_punit_error_show(struct file *f, char 
>> __user *ubuf,
>> +                    size_t size, loff_t *pos)
>> +{
>> +    const char *msg = "Write 1 to trigger power management unit 
>> error handler\n";
>> +
>> +    return simple_read_from_buffer(ubuf, size, pos, msg, strlen(msg));
>> +}
>> +
>> +static ssize_t trigger_punit_error_set(struct file *f,
>> +                       const char __user *ubuf,
>> +                       size_t size, loff_t *pos)
>> +{
>> +    struct xe_device *xe = file_inode(f)->i_private;
>> +    bool trigger;
>> +    ssize_t ret;
>> +
>> +    ret = kstrtobool_from_user(ubuf, size, &trigger);
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (trigger) {
>> +        xe_punit_error_handler(xe);
>> +        drm_info(&xe->drm, "PMU error handler triggered via 
>> debugfs\n");
>> +    }
>> +
>> +    return size;
>> +}
>> +
>> +static const struct file_operations trigger_punit_error_fops = {
>> +    .owner = THIS_MODULE,
>> +    .read = trigger_punit_error_show,
>> +    .write = trigger_punit_error_set,
>> +};
>> +
>>   void xe_debugfs_register(struct xe_device *xe)
>>   {
>>       struct ttm_device *bdev = &xe->ttm;
>> @@ -550,6 +585,9 @@ void xe_debugfs_register(struct xe_device *xe)
>>       debugfs_create_file("disable_late_binding", 0600, root, xe,
>>                   &disable_late_binding_fops);
>>   +    debugfs_create_file("trigger_punit_error", 0600, root, xe,
>> +                &trigger_punit_error_fops);
>> +
>>       /*
>>        * Don't expose page reclaim configuration file if not 
>> supported by the
>>        * hardware initially.
