Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E01DC55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 04:35:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B4DB10E151;
	Fri, 31 Jul 2026 04:35:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kA1Xkyzh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1F6710E151;
 Fri, 31 Jul 2026 04:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785472523; x=1817008523;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=J80yGjBx3qxXeiLSccoL0bFEw+3lSWphHLROInZ+yt0=;
 b=kA1Xkyzh7+drXPBgSb7aXSoWE8POP8wJeDM7sK/WxtGP6+aJ3iSDuCjV
 d3MhTlhhxUSXk9JWbTQD83Xiji1yb52Vx7XgU2ASnL8j4GlOzFpWSqIqc
 wiPh+2ktmxB2lVz/t116csN++1tRjfOODMzHqwyUqUJuUSKXOqTFg4Uy1
 RYLGQXWTt6LZ/0iuypN6yWZaEdX+nh244sGwvseOALs2AnICct9FCVih4
 3geHm9oS7np7hW/I15lN1JBSMMUkeoeKqa/M0HdnjioybZ2o2QwFUfxgv
 PQKpD16eqW068wPeDH19MzPpy6JfOsABcQeodxcnUqD1n/u1M3F1gsAR7 Q==;
X-CSE-ConnectionGUID: baylJ9CaTa2Ig0y+sHz4RA==
X-CSE-MsgGUID: DIxq16vlRmu0EExIY3xq+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="108889824"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; d="scan'208";a="108889824"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 21:35:23 -0700
X-CSE-ConnectionGUID: Vzx0QehBT+aOt3icvyPxfg==
X-CSE-MsgGUID: OWtxYzPRRkSkYTCaJuKrdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; d="scan'208";a="298685560"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 21:35:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 21:35:21 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 21:35:21 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.4) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 21:35:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g99Q831sCbZlhTZYE1x4In3RTQ+z+fsjvADIK4RrW1xppECJ0qhA/kjaLEPplf6v8yPp05r7iJlURcL/zv6xCHh2zTLtGAo6I+WDlmpqVCcVx8KofqiQBV4YpGUk8BWC1EV2/ZKEtmJ3VzbDUwGjI7qEDe+lAhdsnyOzYWSkvxo1VGtXvzsQjK1BDXls1MeQRAeILSwGtGbX31UYrnOxqGIMQY2+VJDIy4ld5go+8DFeNRZI7Px8wqWqEAYmFYiTl9gNliK2hlwjigEt3D1vWhWa/BGIKUIL/wzXiqWLDzZQ30pFKO4HM6iieEZ38SbiEv5HIQ0y/NPDQ0VB/MzROw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZcXUU1XZEH4rec+Bs9lh2w1HKvrhDgNRkw4oKXTnMQ=;
 b=L8K6kV35ipgRkBNCeIxv2hltf1t0UYiTsDDfU60MBST44PBEMj/8kmKoeGKVKUA84HyOqfiDdfaqfbiVxnkkaAsGqFbLhmY0kmL+8tvAywFHybv7BzzOwVAhnU3pVu6vwQqQOI3l9FXEgRbim9JAsnitetjD58N1zmPJi2wOnZJ57XyjjMFiGaXPIvKPo8AQJHUuCyoFx80nmx30b9sxitlr8aNDYxgZiiU6QZFjPiPVMKXG3BSSncO8+KxHcl8n0kDjxpU9pBDluQcPIT1/s4XzBZNAFM58ihTvOif9FF9xp1Qex1xylgTrl013lev5nPhaxbMct3KqYTQtr/7L/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7636.namprd11.prod.outlook.com (2603:10b6:510:26f::13)
 by PH7PR11MB5981.namprd11.prod.outlook.com (2603:10b6:510:1e0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 04:35:02 +0000
Received: from PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b]) by PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 04:35:01 +0000
Message-ID: <67685f36-e5a0-4672-80fa-a887557765d2@intel.com>
Date: Fri, 31 Jul 2026 10:04:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/11] drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
To: Harry Wentland <harry.wentland@amd.com>, Pekka Paalanen
 <pekka.paalanen@collabora.com>
CC: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
 Melissa Wen <mwen@igalia.com>, Robert Mader <robert.mader@collabora.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-2-harry.wentland@amd.com>
 <20260730135911.4e52408e@fluorite>
 <fea5b938-24ec-4e62-9c7b-e0afbca83c0e@amd.com>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <fea5b938-24ec-4e62-9c7b-e0afbca83c0e@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::15) To PH0PR11MB7636.namprd11.prod.outlook.com
 (2603:10b6:510:26f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7636:EE_|PH7PR11MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b61792-4fc9-4a63-2df2-08deeebd15c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|4143699003|10067099003|56012099006|11063799006|5023799004|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SrxsSB3BgHBRc+Dj+jPuotj3xaJR1IzeWfka1hlhVsTO/bkw8oTNefZ+NQp73mQZHSEYUurUnqOyksiMBnAnX4tbgr+oEFFmklHcOD74oHqhHmSm620WUJ3WYysoMVI8JNezjyd/eEK5E/nyapp4aMLyuH9TtnBAQsM3hr196In3xnErnOUZaTZPSGL9jrzjVRforknlXRU7wP7RE4asz00zXPVWljoWlefEus1ZdljPpduYehAKMXjkVa4DJllYXfIri9BFvhlH+f1wTesLBhuD2/D/QZdYRzBB+OQF/dbB6d2GE8Yc48I3eimEsuLoTIPJ68y/VdYExI/M5isvVNstdcXPQNi3gidfUkNipYWiX6f49m+jMj0ZN3GXJVR4BLOSYOEY3EJmIKrU6OMiNKzj9zYBjt8NU5BX52JJLog14MaO9GQ7zPWcetKIJrOuv3xKa93zb47nTYh9ZMj2Ty7WdBV8KG0AR1P1EZ0lhmHLPSzurYgNwth1lBo1PESaIR0KCyGvSnG+Rdnu7SpHLhbCYEWkAPkWLiP4hp3DteNPm8Sav8DWoCInPvgwEA8fzIC3Q2iouMBE/ssd6iM5rNMtUXXB5viWmYxdCdT4YU1X2XcaLPsImJ5HBsogFpVoM284vywYTYEVzPZqWIbROlyB+FOgSie8Tk9KsPbQ3iI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7636.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(10067099003)(56012099006)(11063799006)(5023799004)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWVNUW9NZDM5SUdtdDJkTGhoOGROSnpHaDh0VWg2aXg4QnhZLzV3NElhWDA1?=
 =?utf-8?B?UEpTQVg5cytFdmtSYXA1YW5pRmRLNlVGalh6VXYxS0htOHRHK0szSTViTlNR?=
 =?utf-8?B?dmZvcVJ4VXZHWjJHZTdKTG5wcm5nY3ZQRm5zck9sM1RpeEZna1U1OUhVeFg2?=
 =?utf-8?B?N1ZpT1V6T1VOTkI3Z053MGJ1ZkVQdEF5NVlpU2k5bnVPRnI4N295RU4zWWww?=
 =?utf-8?B?bnkwb0ZwOGtiMlFDSDF3ZlZMbjU0QlJKYWszcndMTzZaM2E1R1MvYndVKzIr?=
 =?utf-8?B?bWN5clpzKzc3UlRIZHFEMGQyQXFudklWdWMrZmVwRWRaWmNTSTFMK3dFUFg0?=
 =?utf-8?B?Wlo2ZWRZNzkwbmo3NWhWZkxvU2diTUNrdDlzdlQ2d2NwSndWbjd3VUkwQWZI?=
 =?utf-8?B?Qm03NTQxRXdPRFJJaWtleFg4UTVkL0NTSlZSNE5SZVczbEE3S3pmR1d6UjhM?=
 =?utf-8?B?eldPN29xSTNoUzdMZE82NWsrWldueU9IZlBSYk8wRTFhSGVFYUh5OW5vN1hw?=
 =?utf-8?B?OVpkQmx4T3FSMFNSRHFvRm9YeU04TDVFZ2MwaDI4RWhpZ0swVk54UGZKWHZY?=
 =?utf-8?B?eU9DU01jMjloRVJQb0NMaFV1Z05PVmlxZ1J0Zk8zeVk0d0pBanYwWEVHZzgz?=
 =?utf-8?B?bWRkLzcwTzNJRjU5b0VoK2t6WEo3b09UQUNBK2Mwd0JSa0VxU2xKRDdRQ2JT?=
 =?utf-8?B?V0FjOUZsN0NNRld0UERmdDJPTnhtSFIzczBCVW1URVdRMWlSQ2F1VGEyKzZM?=
 =?utf-8?B?bWxRL0o4VVgvSjMySXpOWEF2WjlXOXNtaVhydXFadzdHTmFXVW5ydXJpdEFw?=
 =?utf-8?B?T1h2OU9lTDU3elpDOXl4Uis1aGpFNXNSUCt4VEU0SjFSM1BqYm1QSFpoSzh2?=
 =?utf-8?B?Mkc5cGJtT2dKYURIWjhielZrNEJNTy9SUzhLbmNqMWFQTDZtV01PMzF6dDFB?=
 =?utf-8?B?ZnZyalpyM1Z0QUkyQ0FhcTc3MjFVUEQrZWl4d04vMEIrTjNnWHRsbElROVNu?=
 =?utf-8?B?RTVEclAvMnppK1pTaTB0T3lKaXFqNDNTdHdqQm43bXV5L24xSEVzU1RQN3Nr?=
 =?utf-8?B?SXZUSVlndStIdE56TlVhbDJDN3IzYzlPc1pDWUFzVm5hcW5nbzhZQ2daemY1?=
 =?utf-8?B?RTJQNEFyZlZ4djY2cjI0cjJ3WTdDSU1yNzEwMSsvbVZpUjdpMTdUWEp0ajNi?=
 =?utf-8?B?S3JQVFVpUW8yTXNWUXphcXNDdTFYWkxUeElDVmpUT0hLMDNvM09rT0NNNU80?=
 =?utf-8?B?MGRzRmVSK3FySmpUb2o3a0ZhL3IyS2w1QUVCNDVZa3FVZHphY0ZaVDVOSDBm?=
 =?utf-8?B?OGpiQVhoVXR6VXNyZDlxMi8zS2lSeE05S2grQTFQdlJGTjdsOVdsaFhGbzlz?=
 =?utf-8?B?L0dSWVhxM2htUHpzT1pVWXVac3dJSGl1MFZYczRNMXNob1RJZ1RFK2lWM0FG?=
 =?utf-8?B?ZnBJNzNFVU14L3ZrWkpQSHlucWVRc21CRDF4bVpOQW01WW5jM0tvNVpEUUVj?=
 =?utf-8?B?dUVFaTZGbVpCMnlkNjI0a0ZQQzZJa1VXRUZsUGZwdGtzY1BLWC9OYkZmRGJD?=
 =?utf-8?B?cmxZNzRKMk1VV3N4T1Jtd0Jvd2V5MlgrdDNCOWNhaE5aaXgxN0phQ2RtTExR?=
 =?utf-8?B?VkRhV2lNZGdvYmU1L3YrYnA4TFQxcjNJSCtUT1V2VG44bWFTM1ZRdmtrTStX?=
 =?utf-8?B?SWNsYTRienYyUVVEUlNhcnBFU3QzVjZkd3F2ZG5BMk5EdndIR3lyL293Qmd0?=
 =?utf-8?B?UkZxeWt1dVVqWHRRT3hNWVBjand5cEhhUk5la1kyYmtRNU9LVUZ4d0xoeGJD?=
 =?utf-8?B?NXdwaUkzVTA3cUVCa2xteVhhUzZZN3U3MHcwQmFHUTNZZkV5bmlKUmpHOWlQ?=
 =?utf-8?B?bUUrWmhnQVo5UUJQRXo2WTA1cWZWSjJDWGpvWUdKOVpmTFRGeGVvTjZOVGRJ?=
 =?utf-8?B?TGFwQmtQbHVwN2NvR3VLY1RJcnBKNStzN1hnVzFsUXNKcm9USzU2bzJuS3pU?=
 =?utf-8?B?RXVraldHTThhb3psMVluUVNka05YQVFhTzBrQVdNR29OQXBlanpWV1EyQm1u?=
 =?utf-8?B?YWxhdFJkaUFyUW9SOXBzdVFEOTZvWFBwdU1HUFVkSVdRbnh1cm9ZTGllQ2hr?=
 =?utf-8?B?TmYrRzlQS1o4bWdrQUNPcWYrc05ZeUVWbzREOHhveDZIRXpmS0dIQXlyVWw4?=
 =?utf-8?B?RHYyNUh4Q2dwU2p2SGNNcVQ0RGZaNlR0RHhWdEtGenZpMVBlbXl1djBqUWs4?=
 =?utf-8?B?WVJrVlZFSE0xbFR6MlJwTHBndmJ0KzVzV0RLQWZLZlB0TGJpYy9mTlRIOFli?=
 =?utf-8?B?K2hsRzdUcjQzVkNQaDYwQlF5Tkd6ckZIMDdpcldEZkJaTXRtWjhvb29Bc2tD?=
 =?utf-8?Q?GgORMx+Q0tEIEy1U=3D?=
X-Exchange-RoutingPolicyChecked: YXuD32BgYMvTWgSMhyG0C0cwXyffmRWJPLsK90iWZPsLu6LjS9TGXtAicpdN+cJQC0dZc/mqA293Y0DxeaCfK0J4AIL46iDXO1etLWJKF3hxC7LQLPHF8YI6UvF8R2JXiIb3i1qLnjmYWtro3UzqXlxpE07FggB931UkRG3Z/ArzxpabUpD3W0+irGh2bt0i9JAOpCY3CTdeWT94ALXUaUlIBNaoju16ZA4QVNNflKPz7P8ExfPK77vQrtky5GOW3kaSgNn+yAQUN9aC3UBIwZLbmra6wu0Joivpo+J/zWTcbaF2vEuPs/kmH9edqzTMCxkxTZmJpxpsXJKDwE9SDQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b61792-4fc9-4a63-2df2-08deeebd15c0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 04:35:01.7783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPOlFghxRpyLESdNrTX54mt/W2KoigCsD4LmSYmBuw9NC6gQuaUbgdA1smPLJOBjY9I/k4dNt0/OuKVJq2QJl35YZ/6cV9OG7lQQ+S8U2jQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5981
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



On 7/31/2026 1:57 AM, Harry Wentland wrote:
> 
> 
> On 2026-07-30 06:59, Pekka Paalanen wrote:
>> On Wed, 22 Jul 2026 09:45:57 -0400
>> Harry Wentland <harry.wentland@amd.com> wrote:
>>
>>> From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
>>>
>>> Introduce DRM_COLOROP_FIXED_MATRIX, a new colorop type representing a
>>> hardware that performs a fixed matrix operation.
>>>
>>> Unlike CTM-based colorops, this block does not expose programmable
>>> coefficients. Instead, userspace selects one of the predefined
>>> hardware modes via a new FIXED_MATRIX_TYPE enum property. Supported modes
>>> include common YCbCr->RGB and RGB709->RGB2020 conversions.
>>>
>>> v4:
>>>   - Add limited-range YCbCr-RGB conversion matrix enums (Robert)
>>>   - Document matrix values (Pekka)
>>>   - Clarify RGB709 to RGB2020 is a full-range matrix (Pekka)
>>>   - Fix confusing "CSC preset" doc (Pekka)
>>>
>>> v2:
>>>   - Naming changes (Pekka)
>>>
>>> v3:
>>>   - Fix NC matrix enum name and string (Melissa)
>>>   - Rebase
>>>
>>> Co-developed-by: Harry Wentland <harry.wentland@amd.com>
>>> Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
>>> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
>>> Reviewed-by: Melissa Wen <mwen@igalia.com>
>>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>>> Reviewed-by: Robert Mader <robert.mader@collabora.com>
>>> ---
>>>   drivers/gpu/drm/drm_atomic.c      |   4 +
>>>   drivers/gpu/drm/drm_atomic_uapi.c |   7 ++
>>>   drivers/gpu/drm/drm_colorop.c     | 109 ++++++++++++++++++++
>>>   include/drm/drm_colorop.h         | 159 ++++++++++++++++++++++++++++++
>>>   include/uapi/drm/drm_mode.h       |  12 +++
>>>   5 files changed, 291 insertions(+)
>>
>>> diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
>>> index 682fcc651525..e7ccf7d053b8 100644
>>> --- a/drivers/gpu/drm/drm_colorop.c
>>> +++ b/drivers/gpu/drm/drm_colorop.c
>>> @@ -68,6 +68,7 @@ static const struct drm_prop_enum_list drm_colorop_type_enum_list[] = {
>>>   	{ DRM_COLOROP_CTM_3X4, "3x4 Matrix"},
>>>   	{ DRM_COLOROP_MULTIPLIER, "Multiplier"},
>>>   	{ DRM_COLOROP_3D_LUT, "3D LUT"},
>>> +	{ DRM_COLOROP_FIXED_MATRIX, "Fixed Matrix"},
>>>   };
>>>   
>>>   static const char * const colorop_curve_1d_type_names[] = {
>>> @@ -90,6 +91,17 @@ static const struct drm_prop_enum_list drm_colorop_lut3d_interpolation_list[] =
>>>   	{ DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL, "Tetrahedral" },
>>>   };
>>>   
>>> +static const char * const colorop_fixed_matrix_type_names[] = {
>>> +	[DRM_COLOROP_FM_YCBCR601_FULL_RGB] = "YCbCr 601 Full to RGB",
>>> +	[DRM_COLOROP_FM_YCBCR601_LIMITED_RGB] = "YCbCr 601 Limited to RGB",
>>> +	[DRM_COLOROP_FM_YCBCR709_FULL_RGB] = "YCbCr 709 Full to RGB",
>>> +	[DRM_COLOROP_FM_YCBCR709_LIMITED_RGB] = "YCbCr 709 Limited to RGB",
>>> +	[DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB] = "YCbCr 2020 NC Full to RGB",
>>> +	[DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB] = "YCbCr 2020 NC Limited to RGB",
>>> +	[DRM_COLOROP_FM_YCBCR_LIMITED_FULL] = "YCbCr limited to full",
>>> +	[DRM_COLOROP_FM_RGB709_RGB2020] = "RGB709 to RGB2020",
>>> +};
>>
>>
>>> diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
>>> index 224fae40ed2b..92eb6463c39f 100644
>>> --- a/include/drm/drm_colorop.h
>>> +++ b/include/drm/drm_colorop.h
>>> @@ -134,6 +134,146 @@ enum drm_colorop_curve_1d_type {
>>>   	DRM_COLOROP_1D_CURVE_COUNT
>>>   };
>>>   
>>> +/**
>>> + * enum drm_colorop_fixed_matrix_type - type of Fixed Matrix
>>> + *
>>> + * Describes a Fixed Matrix operation to be applied by the DRM_COLOROP_FIXED_MATRIX
>>> + */
>>> +enum drm_colorop_fixed_matrix_type {
>>> +	/**
>>> +	 * @DRM_COLOROP_FM_YCBCR601_FULL_RGB:
>>> +	 *
>>> +	 * enum string "YCbCr 601 Full to RGB"
>>> +	 *
>>> +	 * Converts full-range YCbCr into full-range RGB using the BT.601
>>> +	 * coefficients. Y is normalized to [0, 1] and Cb, Cr are centered
>>> +	 * at 0 (the nominal 0.5 offset removed) before the matrix::
>>> +	 *
>>> +	 *   | R |   | 1.0   0.000000   1.402000 |   | Y  |
>>> +	 *   | G | = | 1.0  -0.344136  -0.714136 | x | Cb |
>>> +	 *   | B |   | 1.0   1.772000   0.000000 |   | Cr |
>>> +	 */
>>> +	DRM_COLOROP_FM_YCBCR601_FULL_RGB,
>>> +
>>> +	/**
>>> +	 * @DRM_COLOROP_FM_YCBCR601_LIMITED_RGB:
>>> +	 *
>>> +	 * enum string "YCbCr 601 Limited to RGB"
>>> +	 *
>>> +	 * Converts limited- (narrow-) range YCbCr into full-range RGB using
>>> +	 * the BT.601 coefficients. Before the matrix Y is offset by 16/255
>>> +	 * and Cb, Cr are centered at 0, following the studio-range
>>> +	 * convention of ITU-R BT.601::
>>> +	 *
>>> +	 *   | R |   | 1.164384   0.000000   1.596027 |   | Y - 16/255 |
>>> +	 *   | G | = | 1.164384  -0.391762  -0.812968 | x | Cb         |
>>> +	 *   | B |   | 1.164384   2.017232   0.000000 |   | Cr         |
>>> +	 */
>>> +	DRM_COLOROP_FM_YCBCR601_LIMITED_RGB,
>>> +
>>> +	/**
>>> +	 * @DRM_COLOROP_FM_YCBCR709_FULL_RGB:
>>> +	 *
>>> +	 * enum string "YCbCr 709 Full to RGB"
>>> +	 *
>>> +	 * Converts full-range YCbCr into full-range RGB using the BT.709
>>> +	 * coefficients. Y is normalized to [0, 1] and Cb, Cr are centered
>>> +	 * at 0 (the nominal 0.5 offset removed) before the matrix::
>>> +	 *
>>> +	 *   | R |   | 1.0   0.000000   1.574800 |   | Y  |
>>> +	 *   | G | = | 1.0  -0.187324  -0.468124 | x | Cb |
>>> +	 *   | B |   | 1.0   1.855600   0.000000 |   | Cr |
>>> +	 */
>>> +	DRM_COLOROP_FM_YCBCR709_FULL_RGB,
>>> +
>>> +	/**
>>> +	 * @DRM_COLOROP_FM_YCBCR709_LIMITED_RGB:
>>> +	 *
>>> +	 * enum string "YCbCr 709 Limited to RGB"
>>> +	 *
>>> +	 * Converts limited- (narrow-) range YCbCr into full-range RGB using
>>> +	 * the BT.709 coefficients. Before the matrix Y is offset by 16/255
>>> +	 * and Cb, Cr are centered at 0, following the studio-range
>>> +	 * convention of ITU-R BT.709::
>>> +	 *
>>> +	 *   | R |   | 1.164384   0.000000   1.792741 |   | Y - 16/255 |
>>> +	 *   | G | = | 1.164384  -0.213249  -0.532909 | x | Cb         |
>>> +	 *   | B |   | 1.164384   2.112402   0.000000 |   | Cr         |
>>> +	 */
>>> +	DRM_COLOROP_FM_YCBCR709_LIMITED_RGB,
>>> +
>>> +	/**
>>> +	 * @DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB:
>>> +	 *
>>> +	 * enum string "YCbCr 2020 NC Full to RGB"
>>> +	 *
>>> +	 * Converts full-range YCbCr into full-range RGB using the BT.2020
>>> +	 * non-constant luminance coefficients. Y is normalized to [0, 1]
>>> +	 * and Cb, Cr are centered at 0 (the nominal 0.5 offset removed)
>>> +	 * before the matrix::
>>> +	 *
>>> +	 *   | R |   | 1.0   0.000000   1.474600 |   | Y  |
>>> +	 *   | G | = | 1.0  -0.164553  -0.571353 | x | Cb |
>>> +	 *   | B |   | 1.0   1.881400   0.000000 |   | Cr |
>>> +	 */
>>> +	DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB,
>>> +
>>> +	/**
>>> +	 * @DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB:
>>> +	 *
>>> +	 * enum string "YCbCr 2020 NC Limited to RGB"
>>> +	 *
>>> +	 * Converts limited- (narrow-) range YCbCr into full-range RGB using
>>> +	 * the BT.2020 non-constant luminance coefficients. Before the matrix
>>> +	 * Y is offset by 16/255 and Cb, Cr are centered at 0, following the
>>> +	 * studio-range convention of ITU-R BT.2020::
>>> +	 *
>>> +	 *   | R |   | 1.164384   0.000000   1.678674 |   | Y - 16/255 |
>>> +	 *   | G | = | 1.164384  -0.187326  -0.650424 | x | Cb         |
>>> +	 *   | B |   | 1.164384   2.141772   0.000000 |   | Cr         |
>>> +	 */
>>> +	DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB,
>>> +
>>> +	/**
>>> +	 * @DRM_COLOROP_FM_YCBCR_LIMITED_FULL:
>>> +	 *
>>> +	 * enum string "YCbCr limited to full"
>>> +	 *
>>> +	 * Converts limited- (narrow-) range YCbCr into full-range YCbCr.
>>> +	 * Though not strictly a matrix operation it can be represented as
>>> +	 * one. Luma is expanded by 255/219 and chroma by 255/224, keeping
>>> +	 * the black level (16/255) and chroma neutral point (0.5) fixed::
>>> +	 *
>>> +	 *   | Y'      |   | 1.164384  0.000000  0.000000 |   | Y - 16/255 |
>>> +	 *   | Cb'-0.5 | = | 0.000000  1.138393  0.000000 | x | Cb - 0.5   |
>>> +	 *   | Cr'-0.5 |   | 0.000000  0.000000  1.138393 |   | Cr - 0.5   |
>>> +	 */
>>
>> Hi Harry,
>>
>> the prime notation (Y') is often used to signify an electrical domain
>> while in the same context stimulus variables without prime signify an
>> optical domain. Using both forms here might cause some confusion.
>> Instead of an equals sign, maybe you could use an arrow to avoid having
>> to rename all YCbCr variables? (e.g. x ← x + 1)
>>
>> About the chroma offset for both ranges on all coefficients; it depends
>> on the number of bits per channel B such that
>>
>> 	N = 1 << B
>> 	offset = (N / 2) / (N - 1)
>>
>> I assume the drivers and hardware get this right, but I feel a little
>> uncomfortable letting this approximation into the documentation since,
>> strictly speaking, it's incorrect.
>>
> 
> I'm dropping DRM_COLOROP_FM_YCBCR_LIMITED_FULL and DRM_COLOROP_FM_RGB709_RGB2020
> from v5 because we don't have any good non-IGT usermode testing these currently,
> to my knowledge.
> 

Sure Harry, makes sense. We will try to get one user mode implementation 
soon.

> Chaitanya, I expect you'll re-add them for your Intel series. Make sure to take
> Pekka's comments into account then. Would like to see how these fit into any
> compositor implementation.
> 

Ack, sorry for missing Pekka's comment the first time. I will take them 
into account when I create a patch for the colorops that Intel needs.

==
Chaitnaya

> Harry
> 
>>
>>> +	DRM_COLOROP_FM_YCBCR_LIMITED_FULL,
>>> +
>>> +	/**
>>> +	 * @DRM_COLOROP_FM_RGB709_RGB2020:
>>> +	 *
>>> +	 * enum string "RGB709 to RGB2020"
>>> +	 *
>>> +	 * Selects the matrix that converts full-range RGB with BT.709
>>> +	 * primaries to full-range RGB with BT.2020 primaries. The
>>> +	 * coefficients match the RGB-to-RGB conversion defined in
>>> +	 * ITU-R BT.2087::
>>> +	 *
>>> +	 *   | R2020 |   | 0.6274  0.3293  0.0433 |   | R709 |
>>> +	 *   | G2020 | = | 0.0691  0.9195  0.0114 | x | G709 |
>>> +	 *   | B2020 |   | 0.0164  0.0880  0.8956 |   | B709 |
>>> +	 */
>>> +	DRM_COLOROP_FM_RGB709_RGB2020,
>>> +
>>> +	/**
>>> +	 * @DRM_COLOROP_FM_COUNT:
>>> +	 *
>>> +	 * enum value denoting the size of the enum
>>> +	 */
>>> +	DRM_COLOROP_FM_COUNT
>>> +};
>>
>> I have verified all the matrices listed above.
>>
>> I would prefer to see the notational issues addressed, but with or
>> without:
>>
>> Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>
>>
>>
>> Thanks,
>> pq
> 

