Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04338C55175
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46A3610E57D;
	Mon,  3 Aug 2026 09:49:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QapjPoes";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B2BA10E57D;
 Mon,  3 Aug 2026 09:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785750577; x=1817286577;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5FUtmXN8sKSsmaAam3Tx1fKL6sTRgCdds1d29nmkkJw=;
 b=QapjPoesa6dxDhixCH9UBYNz3xBhYdvMHjOlhNthCRChmaIGS4A9cX1m
 X7T3sa5LQ/tmySzxZjCUTCSx9mrgZuHCihh1qJrM4Pk4xnZJPV0flKfxQ
 s4nh9J7Q2cpQ9RYcSeDqBl1waXrkZPnE7lyUcmhsrucdPsHhln5BpvkIk
 fiJBLrpkS/wAqUBm5zb/EQj4xcjhsFgYtL9n01r/N3tLlEMIYx/fNXIPs
 B6Aq+aCG6MNVCFaBNrk3+lcinJSIXAazGyD6fu7brN3KsjW/loGgibNAP
 eNtVSMIBWHAIFTVAUrUD+kMpHQOU4og05j/wGwiLJrgP+SHqG7dqiRyCo w==;
X-CSE-ConnectionGUID: nlDrKPnISIinc9nnEg83Jg==
X-CSE-MsgGUID: s6BCLxb5RQKUvkImc6I3pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="88811586"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; d="scan'208";a="88811586"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 02:49:37 -0700
X-CSE-ConnectionGUID: MiV+FexKS7qvbsMw6+Lb3w==
X-CSE-MsgGUID: 06H+wb6qRneJb2I8C24x3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; d="scan'208";a="285819634"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 02:42:40 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 02:42:39 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 02:42:39 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.19) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 02:42:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgyvvEk3Ty/4PTZIl6zhliWychC3xYo6F0fJQwt06mxgoOK56/MK7plLbt5a4xO0qoqX7UN7oWhYv2LRdxloNU/axEXi2teo2tohT7x2uBFbknxIpRZHJWVwKfwvxtRPHCwv4Sbm3bxgiKTXLszY25aQppB5Nnx1Ll7oWr5Od5RXQJqPRFM2u9E+6Y92FmDhL4G0IE96kpkYQrer4ZPZHt45ZR7GoasecnG48AIuJU4eVlHGo4Rr/YzQlmcjBXRgLYm6mj7Fn4fEpgYSR1TxOxYY+t1veCWjqfake3h0VYXdwet2b9LU/bL1yIu7df1eOhNyH87qC6UI3CS+VrKxRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CspRc4HoJBVS7M+8w4rHzLiGCkzPWbdbPhXe0XijFQU=;
 b=DL2utXuSW8LRR9HmPIvvV+WG2h3Q3lYYjrOFB9FvUZPEYdOEIEybdLy46spSzV0W6g3R1Kut4xWNLj4zbzH7SZ2UTYAsyo0CAogfoiQjq4TMFmP6NV1hALqnUlM9elAIjkotDKayDeAfyeB7W0CNGjQ20+HEJll0Oqp/nwHyE72nrCBzDN5Tm5SRUnNhvo4HiQ/p+JDX6rZySIDIvKgzNM9HaJBGZHd4QDiuxiZChMl/uu80UkBL0auauB3FiPq3hkWpr+4xETynmekWJMxYUyGQsQP6Q8dKD9EEcOcmdGovoe7SGeEFbb5yCMODc4OOI1JkKFHtQTD+UP5PVEtOiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7636.namprd11.prod.outlook.com (2603:10b6:510:26f::13)
 by PH0PR11MB4871.namprd11.prod.outlook.com (2603:10b6:510:30::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 09:42:36 +0000
Received: from PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b]) by PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b%5]) with mapi id 15.21.0270.012; Mon, 3 Aug 2026
 09:42:36 +0000
Message-ID: <634dae97-a7d0-4955-9c7b-a4ef3d94584c@intel.com>
Date: Mon, 3 Aug 2026 15:12:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/11] drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
To: Robert Mader <robert.mader@collabora.com>, Pekka Paalanen
 <pekka.paalanen@collabora.com>
CC: Harry Wentland <harry.wentland@amd.com>,
 <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>, "Melissa
 Wen" <mwen@igalia.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-2-harry.wentland@amd.com>
 <64bdc6c8-41e7-4c7f-aa8e-ceb05128d987@collabora.com>
 <8aaeb5b2-2706-415a-8662-40f863270dac@intel.com>
 <20260730172758.0c65485f@fluorite>
 <70f4aff6-3f2d-43a4-b80a-26d7d2aed669@collabora.com>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <70f4aff6-3f2d-43a4-b80a-26d7d2aed669@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0092.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d4::8) To PH0PR11MB7636.namprd11.prod.outlook.com
 (2603:10b6:510:26f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7636:EE_|PH0PR11MB4871:EE_
X-MS-Office365-Filtering-Correlation-Id: 44313820-5902-41dd-38aa-08def1438cf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|10067099003|4143699003|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sTHcYw5SbO0U+W/E23Ko4w4APp8IKHbpJ6j6p8aRMWe/5058zTOtHg9FSyJ20urE9NznWlpy0pkgA4IDCOdos+aVl5BDHXdaRZ2GTTxqJlPPRt6a5EcfZfFq6N22J1cJccUZPqM/God3clKYe6ZYStoTdKuev2Jtmmm2TCteWgjy40Nvl4SidCSIzjifsh6XVyT1nlvcv5RJF9gg28QfDSNVrbuKgeO2cbFO3tsPaNceZdiDwESdfwPbMcN5ZE+TWTrztthcFp1/B5QVsatzOLwr3jWygFa2LmEUcCflT4BFrVsPbBn1VU6cVHoKmy6XSavSaHQzzBPEkJ8lFEFwL8Nm8parKTxBtmSMhksdLRahRCHV26sZwUc8aW/RXWSDyAQUJ60Ffim9TSoXe28jPBJIQpi8f0QsCjeyDQp3uIl9GHYIBPAvdAoRGJmrg1UUbsneJcv5FRyiN/BN3HReLfhiOHpIUHcJD1CH5VPkgcRiT6BDz3cwwlcqDAgg+i8e21ArI97dOJnlllkk+rKk9aU5FBxBk6L/aF4SsVs1mKGQGJWQhn/eGmx4IX8i4WatXgSsEUtBbmLUlz8tMHzflZba9DVH97thRvIgMUNDXkghmsZe953g7EohtXySy1GE3pKeG068hF9p5lcBYmWiK9QZEb8tSaLsGWFNV4KLSvI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7636.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjVQekJkaEpURkpWS2NrZ09pTWFFUVNQbDBOdit2Zno1ZWpUWjV2WFVTNHpq?=
 =?utf-8?B?WnB2UUpPZWFVUlVvVkY2R1MzMEgwSHpFYzNqUnZLNnVmUmorcldETGkwTExv?=
 =?utf-8?B?VHRwWkdxOWpwRjRpM3FqQlNiakdLZEpNSzBPZ0VHZStmakErUitqMDlIN2li?=
 =?utf-8?B?bXhmOUtWaWxiSU4vaGR1RUNlVlZSakFUclFwSyswYnlkdTBiUDZTU2YwNmVW?=
 =?utf-8?B?N0lOcnR4MlRxSkJUU0U2ajlmTG9aMU5hMENiTDd0Zm12WU5VRHdRcmFFbnE2?=
 =?utf-8?B?UFB2TUpkOEo3RGNZZ0M4UERtaTB6azVzUEhhdGxMdXVSZENwc2l5eVcxd25x?=
 =?utf-8?B?RCt5aWwvZ0pINEtUejMvZFdMQndiT3dVUy94aXNGMDdnSWxTdlI4L2lyUTdu?=
 =?utf-8?B?RmpMK05QcWJHei9lUXlrbUttRVllN1VDZEFYdTRpOURKRFZxcDI4bUN6Mzgy?=
 =?utf-8?B?Vm1pYXkraDBWTW01cmI3Z2FrYUJGNnZIbkdKSkNCSThUSjgzREdkeERyTDBJ?=
 =?utf-8?B?ZGpCVzAxNDRFT3l6K0Mxb3V3UnJYUUhab1I5cHBVaXFrdUErMlN0aWp6RS8x?=
 =?utf-8?B?VEw3WkpoNmNiTEM3Zi8xd25kMzRZak5JdHRJdEthU294MDZ2aU5jNHVFc2dl?=
 =?utf-8?B?QVBaK1dSY1RoYXpVNEpPemF5Z1cyTWF0OGVCclFEcUV4Q3d4UkRlTERSdzBi?=
 =?utf-8?B?OU1Ba1V2WjYwZll0Mkd2cmN1ZGRsK3BiSWdicUFYaHBZWnE0VzFrcjBlZml3?=
 =?utf-8?B?WStnblQ1SGZlNVNNQnIvenBjUWZYWk8zVjliSnI1N2lOQ2QrcnFGSG55MWxW?=
 =?utf-8?B?NjFRQ0kyTGVoL1RQOUtPME9yUUVBdVZFaGxISXJ6QVpVakxuUjdLSU9uNXF3?=
 =?utf-8?B?dHROZ0lsWnpmZ3N0L3NzSGs5eHBUK09oZFNFLzBDMHJialdDQjF0VDlyQmdZ?=
 =?utf-8?B?andXeGMraWNVVXUycjU3anRJMTd4WlhuSjhWMXJTaDRla1VtYk83TXhGM0Rl?=
 =?utf-8?B?R3lBb2ErdVhFc2IxdTdlKzNNZGNkYVRkQjdyK2pLcFp1YXVKNW8wNGZ4SVBk?=
 =?utf-8?B?SW04ajl4NmloL2RhcFVEeFJJdWVKRXJWRGhyNm1aSzBZbU5zY3ZCTXY5Q01k?=
 =?utf-8?B?ZG9oNXZ3UXNHMmlqQ29JQTJIKy90OVlVRUZZdlV1dFVtQ1lKVkduZE16aDR4?=
 =?utf-8?B?UFdNZm9rYUVzK2NmTHNHOEZYcDJXQnhjTzlrQUNGYm1kYzMvMndhdjRiVXIv?=
 =?utf-8?B?THFNUG5BNFRCS3VSRVBWMkNGRjB5Y0xXcWtuaWZIekxsZEJsZ1ZlN0JFS3Aw?=
 =?utf-8?B?RytRS0dsQzd0VWVOYkg5UW9pZjZYNTRENU5oL0t2VG5INGVzYk4zR1RwdUpn?=
 =?utf-8?B?UnBhdXB0Wi9GZVcwNVZXWS94MnpUY3JlWmYxUEdvaEtBdE9VbkJpTk9DTndY?=
 =?utf-8?B?NFJnSlNVWlpCZ25uRDRLV0VWaHdzTTJEU21ETTh6MjFyT0Q2T3pzcGR0TWZo?=
 =?utf-8?B?L1h4ZWlCSmJZZFNBbDFrQytrQitCbnlkQmdseTA3amxIZFdxTHdYSVN1dVBF?=
 =?utf-8?B?ZnlkWUFnS1A1SkwzNzhsbDZ2ZStPQVYvNzYyUHdVRzZmU1lvNHNxTkc1dVhU?=
 =?utf-8?B?UDZxNFN2YXBPL3VyQlplWkdsalNsZGZ6M0VhUmUwSG14UElSQXNtN0NOckFX?=
 =?utf-8?B?M0Y3VmdTMDNhamlNa0h0Vy9XQW8xZ1owN3dLQ3o2ZGppc1NIc05xRWJCQ1R4?=
 =?utf-8?B?RUsrYWZSRjFPMXBmYWRPNXE0bnYyb3JqblZuc2pITXYrclY5UUxJTGdFcVZa?=
 =?utf-8?B?Tm5CVlNmdUZuenZnSmpOVG53cjlwWTJMNndvckRhTzJsM3NEMS9ia2RVV1lr?=
 =?utf-8?B?M3pBc0hiYkxMbUpQUGVYc3FYK0UvUm5oWUtVekxVQlhzOTArZWdRODZiY0kv?=
 =?utf-8?B?Snp6bUQwVy9teUZHM1YybVJZczVzNEg3N0VSbVowL2JyTU9sR21NNWVhUXhP?=
 =?utf-8?B?TjhoKzZWa2IzSS9ldnk0U2krclpFbkNkN2I5cmN0amFBN0JRZjJubUZ1TGMw?=
 =?utf-8?B?R3ZSSE52QmN6c2NFa1k5bFdkMHk4bmIyVWl4R1AraU1tUWtWdytLbVpBY0I3?=
 =?utf-8?B?SHAwaUJDUC9QTmhadmhrNGZjQnZMalNiZkNBalp0bHU5K1NyWC9CZGg0UGlT?=
 =?utf-8?B?ZUgvSjJwSlpxWm9DWnpEUVhIZGZtT1NNQzVNaTFlVE01OFdXQ0ZLUVk5Wmpv?=
 =?utf-8?B?eWpTWU5RTlh0RDBDU29xbjZIZVg4MXFMVGJpZSttOWo0WnF6SnVGUm9LNW82?=
 =?utf-8?B?dDc5dXNkZGY4dnh3Z21NVGNKQ0NBajJheDBtTUtUb1ozYll0SFBKUEpUVm1O?=
 =?utf-8?Q?rk+DSjczBo+at/rY=3D?=
X-Exchange-RoutingPolicyChecked: ekMjOrd5HpFcUoNR2zsIxlzuLhBGpGEFqUC85cEliCp4r5g296t3JLyeXjTFGEmASfWcCyUvxZ8aG9HzExZeqy3JNCDj1kAbtTunO5H/f385Z9EnvJwy2jc3Sb4+VgNDNELvr3NJClb/Jy7N+oA805ahrjGs/qD5C/70hs8BS92YdMIzb0vr0gJmm81Q8xAOW1boDM24vC2B4u0cSIviCH6bVbqk9Gk90Xlt+U8pW2BF+Hkdt5thV1pqIPIRbddLDB6gRwxO2OrYLgwSKXIfS6XmxJtkavkt7oVWaYj7CmxZ+mMrU3gNGhfjvYutUObJF68PZTUEJPkrakqxbLHX7g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 44313820-5902-41dd-38aa-08def1438cf6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 09:42:36.6519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehVBjuJ2hk5ZTwhMp7veWf8tkRfb8g1HVnQeCFRBbZCFcs2Tm4AleyzIBkpSCHtOF6mOwguuPpYjfWE66GRj+siyAY3kXYtx6hZxeaIcpK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4871
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



On 7/31/2026 3:31 PM, Robert Mader wrote:
> Hi Chaitanya, thanks for the explanation and sorry for the delayed 
> answer! I needed to think about it for a bit and would like to propose 
> an idea now, see below.
> 

No problem!

> On 30.07.26 16:27, Pekka Paalanen wrote:
>>>>> ...
>>>>> Limited to RGB",
>>>>> +    [DRM_COLOROP_FM_YCBCR_LIMITED_FULL] = "YCbCr limited to full",
>>>>> +    [DRM_COLOROP_FM_RGB709_RGB2020] = "RGB709 to RGB2020",
>>>> I'm still a bit unsure how useful the later two values are,
>>> You can see them being used in [1] and tested by [2]. We split out the
>>> "YCbCr limited to full" block because some Intel planes have a 1DLUT
>>> between it and the "YCbCr XXX Full to RGB" block. This keeps the color
>>> pipeline consistent with the actual HW.
>> Hi Chaitanya,
>>
>> it would be nice for VKMS to be able to have such a color
>> pipeline only. Then userspace authors can test it.
>>
>> That gives me the idea, that perhaps there should be a library of color
>> pipelines for VKMS that replicates actual hardware pipelines. Maybe it
>> would be in the kernel, or maybe it would be in some userspace project
>> if VKMS pipelines can be crafted through configfs or something else.
>>
>>> Based on your experience implementing the colorop in weston, do you
>>> foresee any challenges in supporting limited-range framebuffers using
>>> the "YCbCr Limited-to-Full" fixed matrix block?
>> I cannot imagine a big problem, but it is yet another configuration
>> that userspace must be explicitly prepared for.
> 
> I agree with Pekka - it shouldn't be hard to implement, especially if it 
> can be tested on VKMS, but I'm worried that:
> 
> 1. It could end up resulting in some "Intel-only" code that most Wayland 
> compositors would need to carry around.
> 
> 2. While having an additional 1D curve is great, IIUC it wouldn't be 
> needed/used by Weston and similar compositors for now.
> 
> 3. It would complicate the use of a cross-vendor helper for the legacy 
> properties (for clients not setting 
> DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE) as discussed in https:// 
> lore.kernel.org/dri-devel/d42d5750-f3c5-4e2b- 
> baa3-514b87e59e86@linux.intel.com/
> 
> 
> IIUC there should be a simple solution for that, though, and I'd like to 
> ask if you think it would work for you: the Intel driver could just 
> expose two pipelines: a "complex" one with "YCbCr Limited-to-Full" in 
> the first fixed-matrix color-op and the additional 1D lut - and a 
> "simple" one with a single fixed-matrix also support the "Limited to 
> RGB" values. The later would waste the 1D lut in favor of compatibility 
> with clients not supporting "YCbCr Limited-to-Full".
> 
> To be fully clear what I mean: IIUC right now the drm_info output of you 
> pipeline looks *roughly* like this:
> 
>             └───"COLOR_PIPELINE" (atomic): enum {Bypass, Color Pipeline 1} = Bypass
>                  ├───Bypass
>                  └───Color Pipeline 1
>                      ├───Color Operation 1
>                      │   └───Properties
>                      │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = Fixed Matrix
>                      │       ├───"BYPASS" (atomic): range [0, 1] = 1
>                      │       ├───"NEXT" (atomic, immutable): object colorop = 2
>                      │       └───"FIXED_MATRIX_TYPE" (atomic): enum {YCbCr 601 Full to RGB, YCbCr 709 Full to RGB, YCbCr 2020 NC Full to RGB, YCbCr limited to full, RGB709 to RGB2020} = YCbCr 601 Full to RGB
>                      ├───Color Operation 2
>                      │   └───Properties
>                      │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
>                      │       ├───"BYPASS" (atomic): range [0, 1] = 1
>                      │       ├───"NEXT" (atomic, immutable): object colorop = 3
>                      │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB EOTF, sRGB Inverse EOTF, Gamma 2.2, Gamma 2.2 Inverse, Gamma 2.4, Gamma 2.4 Inverse} = sRGB EOTF]
>                      ├───Color Operation 3
>                      │   └───Properties
>                      │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = Fixed Matrix
>                      │       ├───"BYPASS" (atomic): range [0, 1] = 1
>                      │       ├───"NEXT" (atomic, immutable): object colorop = 4
>                      │       └───"FIXED_MATRIX_TYPE" (atomic): enum {YCbCr 601 Full to RGB, YCbCr 709 Full to RGB, YCbCr 2020 NC Full to RGB, YCbCr limited to full, RGB709 to RGB2020} = YCbCr 601 Full to RGB
>                      ├───Color Operation 4
>                      │   └───Properties
>                      │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
>                      │       ├───"BYPASS" (atomic): range [0, 1] = 1
>                      │       ├───"NEXT" (atomic, immutable): object colorop = 5
>                      │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB EOTF, sRGB Inverse EOTF, Gamma 2.2, Gamma 2.2 Inverse, Gamma 2.4, Gamma 2.4 Inverse} = sRGB EOTF]
>                     ...
> 
> While I think it should look like this:
> 
>             └───"COLOR_PIPELINE" (atomic): enum {Bypass, Color Pipeline 1, Color Pipeline 2} = Bypass
>                  ├───Bypass
>                  ├───Color Pipeline 1
>                  │   ├───Color Operation 11
>                  │   │   └───Properties
>                  │   │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = Fixed Matrix
>                  │   │       ├───"BYPASS" (atomic): range [0, 1] = 1
>                  │   │       ├───"NEXT" (atomic, immutable): object colorop = 12
>                  │   │       └───"FIXED_MATRIX_TYPE" (atomic): enum {YCbCr 601 Full to RGB, YCbCr 709 Full to RGB, YCbCr 2020 NC Full to RGB, YCbCr limited to full, RGB709 to RGB2020} = YCbCr 601 Full to RGB

This would be

{YCbCr limited to full} = YCbCr limited to full

>                  │   ├───Color Operation 12
>                  │   │   └───Properties
>                  │   │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
>                  │   │       ├───"BYPASS" (atomic): range [0, 1] = 1
>                  │   │       ├───"NEXT" (atomic, immutable): object colorop = 13
>                  │   │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB EOTF, sRGB Inverse EOTF, Gamma 2.2, Gamma 2.2 Inverse, Gamma 2.4, Gamma 2.4 Inverse} = sRGB EOTF]
>                  │   ├───Color Operation 13
>                  │   │   └───Properties
>                  │   │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = Fixed Matrix
>                  │   │       ├───"BYPASS" (atomic): range [0, 1] = 1
>                  │   │       ├───"NEXT" (atomic, immutable): object colorop = 14
>                  │   │       └───"FIXED_MATRIX_TYPE" (atomic): enum {YCbCr 601 Full to RGB, YCbCr 709 Full to RGB, YCbCr 2020 NC Full to RGB, YCbCr limited to full, RGB709 to RGB2020} = YCbCr 601 Full to RGB
>                  │   ├───Color Operation 14
>                  │   │   └───Properties
>                  │   │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
>                  │   │       ├───"BYPASS" (atomic): range [0, 1] = 1
>                  │   │       ├───"NEXT" (atomic, immutable): object colorop = 15
>                  │   │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB EOTF, sRGB Inverse EOTF, Gamma 2.2, Gamma 2.2 Inverse, Gamma 2.4, Gamma 2.4 Inverse} = sRGB EOTF]
>                     ...
>                  └───Color Pipeline 2
>                      ├───Color Operation 21
>                      │   └───Properties
>                      │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = Fixed Matrix
>                      │       ├───"BYPASS" (atomic): range [0, 1] = 1
>                      │       ├───"NEXT" (atomic, immutable): object colorop = 22
>                      │       └───"FIXED_MATRIX_TYPE" (atomic): enum {YCbCr 601 Full to RGB, YCbCr 601 Limited to RGB, YCbCr 709 Full to RGB, YCbCr 709 Limited to RGB, YCbCr 2020 NC Full to RGB, YCbCr 2020 NC Limited to RGB} = YCbCr 601 Full to RGB
>                      ├───Color Operation 22
>                      │   └───Properties
>                      │       ├───"TYPE" (immutable): enum {1D Curve, 1D LUT, 3x4 Matrix, Multiplier, 3D LUT, Fixed Matrix} = 1D Curve
>                      │       ├───"BYPASS" (atomic): range [0, 1] = 1
>                      │       ├───"NEXT" (atomic, immutable): object colorop = 23
>                      │       └───"CURVE_1D_TYPE" (atomic): enum {sRGB EOTF, sRGB Inverse EOTF, Gamma 2.2, Gamma 2.2 Inverse, Gamma 2.4, Gamma 2.4 Inverse} = sRGB EOTF]
>                     ...
> 

and all the "1D Curve"s will be programmable "1D LUT"s

> This should allow us to have the best from both worlds - maximum 
> flexibility for users wanting the additional 1D lut, as well as simple 
> clients just needed a drop-in replacement for the legacy properties.
> 
> Please let me know if that make sense and you think that would be 
> possible (especially if I made wrong assumptions here).
> 

That is a good idea. (I am a bit disappointed I did not think of it :/).

We can initially have a pipeline with:

[YUV -> RGB Fixed Matrix] -> [1D LUT]

For now the fixed matrix only exposes -

{YCbCr 601 Full to RGB, YCbCr 601 Limited to RGB, YCbCr 709 Full to RGB, 
YCbCr 709 Limited to RGB, YCbCr 2020 NC Full to RGB, YCbCr 2020 NC 
Limited to RGB}

>> Thanks,
>> pq
>>
>>
>>> As for the "RGB709 to RGB2020" block, I can see it being useful for
>>> converting SDR Rec.709 content into the Rec.2020 color space before
>>> blending it with an HDR plane.
> 
> I see, thanks. At least for Weston I think it's unlikely that we will 
> use that for now - the current plan is to blend in linear space and then 
> use the post-blending / CRTC pipeline convert to the output color space. 
> But AFAIK that's not in any way implied by Wayland, so other compositors 
> may well take different approaches and use this matrix.
> 

Even with linear blending a compositor might need to convert a Rec.709 
plane to Rec.2020 if it intends to blend in Rec.2020. Though, I am not 
sure which blending space Weston operates in.

> My request to drop it from the series was purely about landing it 
> together with the corresponding implementation - like Harry just 
> announced for v5 in https://lore.kernel.org/dri-devel/ 
> fea5b938-24ec-4e62-9c7b-e0afbca83c0e@amd.com/ - i.e. I don't have any 
> reservations against the matrix/enum.
> 

I understand. I was merely wondering if there will be some 
implementation complexity that you would like to flag.

Thanks a lot for the suggestion! :)

==
Chaitanya

> Best regards,
> 
> Robert
> 
> -- 
> Robert Mader
> Consultant Software Developer
> 
> Collabora Ltd.
> Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
> Registered in England & Wales, no. 5513718
> 

