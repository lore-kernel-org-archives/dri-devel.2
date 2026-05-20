Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB7ACD5BAB
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 07:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BBC910EDAE;
	Wed, 20 May 2026 07:24:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fRlpKvy+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 570D710EDAE;
 Wed, 20 May 2026 07:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779261845; x=1810797845;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=otV6uakBihx8RdPA28oAk9SRN5nur9mUWUqndJ8ZP4g=;
 b=fRlpKvy+ZOe9cXV3JzPJU6MInDX3/WxCL0gXDq4zhDtVbXTmGiqa+/Bf
 gMuvNowD5nuQl1+U5ApZ/Rnju+Z0sQbCRLrpCsi+9rmf6mpOmcLY/1eV/
 p2XxlEX7Jz3Fw7zFBdoTubR9yTb66NZpg4aF6sgyRCJtkjjX0Sw/dT343
 I216swBEaCJnhHLdlJW4OBJqkKkyM5v1VaHLwJ/syOOkQbMK3CSEZEG4w
 iLlu0PwOAcxasoTckNjmbSF1wGHHVJvsEXEbi+lCLewCPXrN29ccBxSvn
 bHIFLpybU5YRpR/YitspoXu/7OB342q7XBA7Xush+Q1M89+z4pHJFI1JO A==;
X-CSE-ConnectionGUID: 4S2CkEK6QK24Wnz1lVFVuw==
X-CSE-MsgGUID: gB+b5q/XSZCzK3SfTwhEQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80209820"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="80209820"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 00:24:05 -0700
X-CSE-ConnectionGUID: ht9jUfZ1TbWrETdfBoA2Xg==
X-CSE-MsgGUID: O6bpHj/HS3C5ecsRfZoGDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="239062435"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 00:24:05 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 00:24:04 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 00:24:04 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 00:24:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZqirCcwJASWq3ZSESj07Y6zdpwYpAFUNu4AK+X1YSALVSotDYjf2LZ+z3ofgPWMyGdqm2mIqO0v+JtY3HPL5Pi0eos8qPN5GVOYuV5G/IcniRcHlwoqMMUG9W5gFD/15IS4s6zKAxviaBfLqtEVQYXIsuuFENDfDxbHXVkD15+T61MnK7YID7gLDOOyFwIP6tSTt/OeJn2RvFN4opmItahOowDk391AWjs5Y6B0cNAGio3ALTXibLJUceYyfJx47Wi3h3xvbyOap80M/NX9xFsNPIivSk4/yfzJq2lY9ycSTY8gOM24Ag8l28RRRdf2T9Nyl4j53bmuld6eoWWa7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fn2dvn7SOMdaLFBNpHI0Z+SBcWWlHkUs5EHrujXpEzQ=;
 b=NNgCUgDJjRayqYRJifkrEvU4RgmOWTL6pqirjQu1pAfvgS9EH/4GIPISsRpfDDLku28IqZJ8Sg0xlC0hgeUVpEySApMpUgTll0WcPa2SndgAJWdxEytKsQx8uNhAAkvHVbbxxxMPm8R4H8uRj4VWmNn76PLEosg6bzSLZMUKL3ZJzjDqfwp+XvKhDIzsCWqedDylUKOjSkBCGcfGIfygVBESPCWYdQTc37LCOAMVppKzj94vZhwfIPG29fuJaLGn92moZlsWGDDGY5XbTBHrl4/XHbpK9ULZHUPJbHoeXjI/kjEuTfjBSilY1fDJ+cH7Y8mstAR03irH18vw/rMMRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 PH0PR11MB7521.namprd11.prod.outlook.com (2603:10b6:510:283::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 07:24:01 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 07:24:01 +0000
Message-ID: <5d52d3dd-2154-48e2-b849-0ca2aa74fb13@intel.com>
Date: Wed, 20 May 2026 12:53:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] drm/xe/drm_ras: Add per node cleanup action
To: Raag Jadav <raag.jadav@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>
CC: <rodrigo.vivi@intel.com>, <maarten@lankhorst.se>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <kuba@kernel.org>
References: <20260514202839.1888688-1-raag.jadav@intel.com>
 <20260514202839.1888688-4-raag.jadav@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260514202839.1888688-4-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::19) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|PH0PR11MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa39c9c-9368-4035-4254-08deb640c3b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: Rfzeg2wVaDAas+h7ItO/fqqOXN66T1AQGV3VeSzGRRigbt1tzgSL/n4A5JxGcCK8TsvB7W5ksLsaaa5wFqE/DiLlYzGAdgQj1YDTuL68Lv0GmW298uMvObEdwhngKnRitEIjZXE4k8Dl5Xt+CvSHjCk4u4YYQIS6fslByD/BbkPL0aRG/2NyFe2qiDM66LqDW8BFEzdk8gxKts81mny80wCKEofUy/rrzxKp5YjkdqG5yM4AIFvif3Nj7yEfIqDFQGoobGlEjdZVwLKdVZpRVePOK6gyuS+RnTGpJoYnAmumdJIUpRAnNZTOmp134fjxlS7J22Zt4rl02cVjImiMgDz3cLFtS2aN3KqfC8hKxXuStxmW5/t9NB9iEvn3S3zNSR43sEqsCrauZe6tZE5tdIBMh29sLauuMbUGsePtwZD9SSaFy/c+oDm5XBDNc++XPp5tGKEEBZYe/ogQXNnI2zXOWDxZ+PxyHIr69tdL+mp3KQOhiRVje1tKYEDnUP1AUhC6/VA6vj9NLKetcVdVR768JQFFHXFvSCEFZrqGI2+XZPrpmzzWrkdgO/ax0Od10yu0iwh7BKQRFkGUjt49XeFXYMYPsOZEyBMssbt1lXof6XHUhSNoW1C2bKsksqa5QyjWxlKHRaA3Btzwx++Y+AGr04TCICGv2lj1Ta0s9k8AY0tatMyT8qouw8tZfzzt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUlMUVd5RTVnSktFWEtFcVk5TmQ4SlljaURwTFVQYXp0dUcwcVROVkp2Q0c2?=
 =?utf-8?B?MHlvVHR3dHBlR05xMVg4VlhDc1QvZkt5bCt6dFc1RCs3WWJOaWx6OWcyUDJJ?=
 =?utf-8?B?b20yVFY3ejNlTHBtT3QwVmU2UlhkNFFHYkJMc3ZvVEJFMHk0LzVDVVBMRWtq?=
 =?utf-8?B?cVhDVXZoM0h6bEhoTGVzYnN4SU5pODE4YUlvcld6TUkvTWpGSDdQRHhzYktn?=
 =?utf-8?B?Y3NhelpkVG5LWkFWME96ZDB1ZWhrUjV2NnBCOGV5THlPQ3BiWXdIRVJGMGd6?=
 =?utf-8?B?UzJXY1p0OUJNVkQ5OWxiTWNERFZhbCtlRzFadnhPTUtKeHFaM0xQVkViRW5Q?=
 =?utf-8?B?SU5KOFZyVTFPRy9aSkZoZXUxWTdpZ0NKV1liaGt1N2lVMWt4b1VFMUdYNlIr?=
 =?utf-8?B?TnRsWEZLLzFJWjV6WHR1SWZuSi9lSDB0QTNnSGVDU2t4dmZxOGI4ajVTelZ4?=
 =?utf-8?B?ODVQaGF1cS9EdjZkM3VjNTRoNzdLd3JNeWI5Q2NjWEJNMmw0bWZyekN4WEVP?=
 =?utf-8?B?UFR0bkEzNmNQWHF5RWdjU0pVa2t4Mk9oZXlLQXh2MFhwZHAyMjE4ZWtxTzY3?=
 =?utf-8?B?VTFZM2dpaDFDQkVHVUI4TGFlLzg3aHhKMCtxa0U1dFFXQlErSlgya09Vb2gv?=
 =?utf-8?B?MVVLdTVSdmlaRHhZRkxsbVMxVHpscEJLRFhubW5QUVZOaGtaZDM2L2k0a09y?=
 =?utf-8?B?Sm1TVHVub1ZhUnIrNmp5RDJsb010ZHRuckZxRDFDVk92dGdTNVVOYUxGNXRn?=
 =?utf-8?B?Vm4rZ2VWSzhaQlRCVE52UFovQXhpV2ZsT3NzTUJyZE9JYkFHcmgvVHFkSG02?=
 =?utf-8?B?cHNnU2tjK1hLWTZleGt3MTk2V3BnWmJHVk5ha3UrTXRSRUQrMWxRZ2dKTkd4?=
 =?utf-8?B?dXV1U2h1QWtjemFSQ3hMWkNYUFlMWkQyQnN3R1V3ODBKZ2c2MHczMkxINkpK?=
 =?utf-8?B?RHF0UGVTZ2p2L1VVamlOaGx0STR0Z0pSd0t4dFZ4ditsM1RhWE5ITXBiT3BJ?=
 =?utf-8?B?TEdjWm8xcENSbjl4L0FQMkgzcldkeDUzc3h1eDdod0FYMEg0V3hmK01CSzVs?=
 =?utf-8?B?elhaMGlWOXJSMG9MVVNIVXRPdFVvbkNaditYb0RZeVcvUzV2WktrV0pjaU1W?=
 =?utf-8?B?VllRNE4vZFl5U2NuK0ZoT3JCTExJdHdISURTYVpFRWlYcXZWQjBmNWp6czNa?=
 =?utf-8?B?UStaZ01zNDhTVWZYbGRqY09JamlOL21Vaklxd1RXYlNUZGtyeDBYR3FFblpu?=
 =?utf-8?B?b2czQnpQZ3E5ZllRSlFlM21nSXEzYVpva3RLRXBhKy9ScG84Vlg0eDdwYUVk?=
 =?utf-8?B?MjdTOThvSGkxSGNZY0xoVDR4QW9CU3Arc2U2ai8ySW53WnJxYU8wZVRVZDc5?=
 =?utf-8?B?YWQ0M1RzRFZ3RldTU3ZjMUZ5S2FUU0VtNEtPeW91RGZ1UzFNMXhBM20zNjN3?=
 =?utf-8?B?M2s0RGJNN2tndTZyZmsweUZHVTJwVmNoYzBEWTduR01tblNxUnNpdFN0dkJo?=
 =?utf-8?B?ZlEzYWo1MGlDWDB2RXNyNTllQ2N0eXlhZDNiK1p5Um1NWjFoYVJJV1pxcDdR?=
 =?utf-8?B?dEFrUkpEckxncllTZTV1V1VHUGJOMHBNTWpoYXdDZzFBc3VHVWVMQ3ZBVk5W?=
 =?utf-8?B?bzQ2UldRQllJQU4xT2FGOVFLOGhBdmhMMzU5UEpISWdpT25rbmtaYWFPRFFB?=
 =?utf-8?B?SnhXeTAxL1p1MSt5MkVzYjlPUGthWjAwdHRnMFdjcExGYWpZZWRWaGF5SVJm?=
 =?utf-8?B?eTZvdFZVMDcrL2lnenl4a0V3QW0vUVV5d0Nwd1Q2ZlF6bmtiU0daeGxDaXNa?=
 =?utf-8?B?YkxNUXpqaGZRV01rTTZBQWtyelZkSG9mTGFuam1ESmprWDFuZTBTSzZaempN?=
 =?utf-8?B?eTN2MDZxeUpxQVNxbllNVjBHSEUrNFFCMjlYc2dBSTczdTlhb3E3amE1OC9M?=
 =?utf-8?B?dnRFNXVqVDlEZE8vWm40Y2greHpjYnI4ZTBGNkVBZnNBQnFKOEs3aFZNd09v?=
 =?utf-8?B?bHp0SUp0amZKcmN6TVlsQmUxL1lEQ0dTQlExczVBOC9hclZOWmdtQ2RiUlFN?=
 =?utf-8?B?b0FIVHBJQjFac2dhenZoTWoxd3c4ZzAyQ24vdmExcVg4bDhoaFQ1N1JrL3BM?=
 =?utf-8?B?cUZZMGpxWjlPVi9MckFYUTdaSjMycjdXVXRQQWVFeWdmdStiVHJtTGYyUWlw?=
 =?utf-8?B?bHppQlBYQkNlTFBhNmpCZkZ2MUdjR2d3ZzF6RXlXSEFsQmNrWlN2U01yblRN?=
 =?utf-8?B?czUzaWdDM2ZuSVhKQmhUNzBnTVVOazNINytqMjdlMFVaTW5WV2YzYWN6WW01?=
 =?utf-8?B?NnpzMjRxS01ZdGFqbWpkV1VoSk56Rjg4S0RpS3dpVG5aWUZNSUxNdz09?=
X-Exchange-RoutingPolicyChecked: JAPUdh/qKWr376q9EoJmfY34z3gPVGhrcdfuUG8wB2hozAWsbwLVQmJIXz11s0LrjsPCC0RfHBUlvA1HvhZggeBQlyOooHL/wyYHwVJVwcxs8APMgnCudCIC1EQLAVXymQbnLl7T+ytkSM/653d1YuN2Bf7ugYfF9/iUkLgE4p4Og5OpGUrmyeZJA3z5o7dYMpCQI+0F1iuGweHgF7nZfYg3qP7YQsJFCGWJ9RgCxzHjiSrTnrWG4t7c3RmjEq8gdA9VkCnHqq6wP8LVjJpKcJ6j0H+0gRvRD5UorpJL843maJ0FyaQq+cSId2pOL/GWktNNSPYyGdp3csUM72DJQA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa39c9c-9368-4035-4254-08deb640c3b2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 07:24:01.4296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNMywM1wI86O5tImxpb0fQeQTVRrpu08sJq1oJ12oFOWaBtjgF8FIjuXq6doC5pn7gMsPuTlo+GLPK71l9DLsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7521
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


On 5/15/2026 1:58 AM, Raag Jadav wrote:
> cleanup_node_param() is not registered in case of counter allocation
> failure, which results in stale memory of previous node that isn't
> cleaned up on unwind.

It is registered.

ret = assign_node_params(xe, node, i);
if (ret)
     cleanup_node_param(ras, i);



>   Add per node cleanup action which guarantees
> cleanup on unwind and also simplifies the cleanup logic.
>
> Fixes: b40db12b542f ("drm/xe/xe_drm_ras: Add support for XE DRM RAS")
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_drm_ras.c | 42 +++++++++++++--------------------
>   1 file changed, 17 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
> index 89640ffb1c33..40abde29a26f 100644
> --- a/drivers/gpu/drm/xe/xe_drm_ras.c
> +++ b/drivers/gpu/drm/xe/xe_drm_ras.c
> @@ -131,14 +131,20 @@ static int assign_node_params(struct xe_device *xe, struct drm_ras_node *node,
>   	return 0;
>   }
>   
> -static void cleanup_node_param(struct xe_drm_ras *ras, const enum drm_xe_ras_error_severity severity)
> +static void cleanup_node_param(struct drm_ras_node *node)
>   {
> -	struct drm_ras_node *node = &ras->node[severity];
> -
>   	kfree(node->device_name);
>   	node->device_name = NULL;
>   }
>   
> +static void cleanup_node(struct drm_device *drm, void *arg)
> +{
> +	struct drm_ras_node *node = arg;
> +
> +	drm_ras_node_unregister(node);
> +	cleanup_node_param(node);
> +}
> +
>   static int register_nodes(struct xe_device *xe)
>   {
>   	struct xe_drm_ras *ras = &xe->ras;
> @@ -150,13 +156,19 @@ static int register_nodes(struct xe_device *xe)
>   
>   		ret = assign_node_params(xe, node, i);
>   		if (ret) {
> -			cleanup_node_param(ras, i);
> +			cleanup_node_param(node);

At this point drm_ras node is not registered.

>   			return ret;
>   		}
>   
>   		ret = drm_ras_node_register(node);
>   		if (ret) {
> -			cleanup_node_param(ras, i);
> +			cleanup_node_param(node);

Ditto

Thanks
Riana

> +			return ret;
> +		}
> +
> +		ret = drmm_add_action_or_reset(&xe->drm, cleanup_node, node);
> +		if (ret) {
> +			cleanup_node(&xe->drm, node);
>   			return ret;
>   		}
>   	}
> @@ -164,20 +176,6 @@ static int register_nodes(struct xe_device *xe)
>   	return 0;
>   }
>   
> -static void xe_drm_ras_unregister_nodes(struct drm_device *device, void *arg)
> -{
> -	struct xe_device *xe = arg;
> -	struct xe_drm_ras *ras = &xe->ras;
> -	int i;
> -
> -	for_each_error_severity(i) {
> -		struct drm_ras_node *node = &ras->node[i];
> -
> -		drm_ras_node_unregister(node);
> -		cleanup_node_param(ras, i);
> -	}
> -}
> -
>   /**
>    * xe_drm_ras_init() - Initialize DRM RAS
>    * @xe: xe device instance
> @@ -204,11 +202,5 @@ int xe_drm_ras_init(struct xe_device *xe)
>   		return err;
>   	}
>   
> -	err = drmm_add_action_or_reset(&xe->drm, xe_drm_ras_unregister_nodes, xe);
> -	if (err) {
> -		drm_err(&xe->drm, "Failed to add action for Xe DRM RAS (%pe)\n", ERR_PTR(err));
> -		return err;
> -	}
> -
>   	return 0;
>   }
