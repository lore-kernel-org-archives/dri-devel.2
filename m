Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38192CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 09:51:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9107E10E0CF;
	Wed, 20 May 2026 09:51:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BGIIdLiG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 430DA10E05A;
 Wed, 20 May 2026 09:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779270667; x=1810806667;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OXtFtP/m57XLsukI84s7Tx4PHJKD8ZV9H6mr+y0hi2g=;
 b=BGIIdLiGRCR1C5jCqVn7YrfutZketKQR/wgsnhuAkvLmFPUP8ohUR18x
 CcftXk6ovuTC2eXQJ3JOYttmTNLaoaJUQhDUnxyzESxZVNe0/TLvx/cV/
 aoF+onL74O/VtBMAFtNko/AJ6SK3pGhvFjxszDTRtwQceLTl6qxRzlfE6
 r2N+sh8MyuoxkUlqb7gfDFcLZEnUd3bigmvsACoEL9NRMl+j+OLVAl2ph
 e/ldm0C5+OPYDufHmAmWw/HPJJnD4bt0ZeioBr2kqfiTsIAJg0JRbakWD
 d/eqCgTkUeuoeYzIIBU9r6Izb00uBILeXf1cSRf37KKUfkkFdyJ0u8yMf w==;
X-CSE-ConnectionGUID: Ohb7n3KOQo6EmaKmnsFpaA==
X-CSE-MsgGUID: sCozc5x3Qd6beAm9lL7vgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="79891825"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="79891825"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 02:51:06 -0700
X-CSE-ConnectionGUID: ssNPU1/USAyBGQob7RNSbA==
X-CSE-MsgGUID: c4xApjljTLyAMG94MqNcpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="237117031"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 02:51:06 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 02:51:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 02:51:05 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 02:51:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKLECBbKLZQLUvLtMyhhAf3bS3AfgwTif4OKus4536vn8tti0+LVNmKG/hWr7cl/2OZ++8d2BVPwrGFYSfvCtwAChWTYrsX/HdRtNSkG+mH73BZUDFreOS5xm9IgiBTkEH8NGYCLlJFCb/V1rb7g1wFRfiAMm6jtIVqWLbSaF5qSSv4XcAz5dslzxKIeKoioiZ1LEPzYXX03YMvtvV8I0IjG9aE6VTMAt9SkY3PEr5LzzukZeA8JEfTI3XQ2+WUEY4rnE4PqAT9HBMxqqqaLnD52O4EKEN7ww+mpIWslRfsgfpJM21Hn0NZ8KWAQytLMBuxZJUonEURrCcY9//SEGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDoAJXFK9OVfKnjjQY/Z4xQtAE+fQV9GcjkPQxN5XK8=;
 b=GfV51yecuVhIER6VODm93eLHLxKYwWZuzYd0skYRcA3UEp//yY0IdXwQkNMKwrK1v72S1JUMYe2bw/+E88Td1kSKo35FXEgK8AQS8mOwrUppkMy6cfDk2HV1cEFbNohW0/zIDXA/D3luG1IW94ZXIU0q3SHA9hCZfu776f00R9JhfGeLdjL07M3sX99O50saL7y8Xw7tMkXKtuP85vr9ODJ9uBPdlUE4dNVq7b/NlFDoa2px74G5eC2BIymKYRo8RXd0LEV+bUDhon06a7XZWRHyDjCBqWcgjFERPutFfGwgZYPpmV3qFQ4FxCVgpBSaukhj6LxRwaAvSNJbFph/sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6207.namprd11.prod.outlook.com (2603:10b6:208:3c5::21)
 by SJ2PR11MB8372.namprd11.prod.outlook.com (2603:10b6:a03:539::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 09:51:02 +0000
Received: from MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d]) by MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 09:51:02 +0000
Message-ID: <d3ef7dd8-afa8-4e2a-a691-b2c2ab9a88fd@intel.com>
Date: Wed, 20 May 2026 15:20:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET
 recovery method
To: Raag Jadav <raag.jadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rodrigo.vivi@intel.com>, <andrealmeid@igalia.com>,
 <christian.koenig@amd.com>, <airlied@gmail.com>, <simona.vetter@ffwll.ch>,
 <mripard@kernel.org>, <maarten.lankhorst@linux.intel.com>,
 <tzimmermann@suse.de>, <anshuman.gupta@intel.com>, <badal.nilawar@intel.com>, 
 <riana.tauro@intel.com>, <karthik.poosa@intel.com>, <sk.anirban@intel.com>
References: <20260512132614.1793083-7-mallesh.koujalagi@intel.com>
 <20260512132614.1793083-10-mallesh.koujalagi@intel.com>
 <agWM41MpCMqDt4mb@black.igk.intel.com>
Content-Language: en-US
From: "Mallesh, Koujalagi" <mallesh.koujalagi@intel.com>
In-Reply-To: <agWM41MpCMqDt4mb@black.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0337.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21f::13) To MN0PR11MB6207.namprd11.prod.outlook.com
 (2603:10b6:208:3c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6207:EE_|SJ2PR11MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: f94d6e9c-3899-495a-9ab5-08deb6554d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|4143699003|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: hLffHa2VaeBH2s2/ia3ag++hjmbcbnAbMhhqmzouvS+nOZEVd/ZiBqvsav7eknj8wiNFEDrec/4CWFfSVS3F5q+BObP2RtFordx2C+XR+3GZENKT+5i5SpE5JfLhHxA0FryCZGezcCTar9D4jRdxD9QFUAia1PVQWq/IanvmLkysePxwj+LN4oBR/o78mEx/VE/jC3gRMrrAIDuO/3hDq2WRid05a8HVkWy7/OHKU5zr/ErCcXwt5eBsfBk0hVaGIIZynsRmIhFha0bHBMwBqUeJigCyVMh4AXT2MSA6QP9kFfvGfu/8qrSYlgazkPEi9DMNqpe1JeZi6tB9h/+06Wb2B3wTm+71mBs917Tb0GyxlE75QnqgX2YyHQygfJ/RtlseGxsD8m9O5Ks/ZndpRAzo0IZLDZbB5k0Q9tWhlxsgJbT1A6qSe9oL8U0yvp7AiXqo5yr0KRUMqtaaeJNFxPFK7B+qdWpGWKmJrFH40NzRcDtqWgaFB1HYV5JyEwuxqugnYsuwqTfWQQG2LTDu5qT2tz0qCU5AN64ZPULJ9UoRZP+Qz78nuDPv7UpbL6VUimRPN0c6AuMs5kytXRf6fysrC+TMjnLbz31brALSYCc+ZTLBUb+FmEAkqZPuarwAVk6ZKSKK6PjDVlPMWMqStvrf5AFNh8PIMYFhw+oaK/9Om+bHBjm+qb5E8SmTaDeR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6207.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(4143699003)(56012099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEMzdFVzNXk2a0Q1bnlKRzZxbE9MbmRzbUsySFBhS0loRDdtRG01b1MxTml1?=
 =?utf-8?B?MXAvTXdKSUVjcVc1Z3BGczJOZFNpMHVpejRXeXZwbENMK082Ykdwa3BLQU5D?=
 =?utf-8?B?TUpFaGY4dFpTN1lEN1B3dFpmMXFyTnE5RDdrNFpFS3NpZWFZTUF4bVorZ3lo?=
 =?utf-8?B?WUdkeHRxS3pkTXBuVlBHQXhIeFBHYkx6Y3lwMHVNZzVWdVk3UlVORmtYRVNV?=
 =?utf-8?B?M1BPZEhyOC96L2ZjakpTY25RK2c3YjZmWFdYS1FsUWk3RVJKVC82SVljUml4?=
 =?utf-8?B?clNpSk1HNzNWeE9Vbi9IUWJudlVqWHBwdWlKSm14V1d6V3lUOWxLNWo2TnNH?=
 =?utf-8?B?MmV3SnRmUlkzSWV4a3drMW1UYXorZlBsTzR5SE0ra25oeGRhQjdua0JzZ3VY?=
 =?utf-8?B?MHR6T0ZZaFdNS2tKTmlhWk82MEpjR2NmSmZsQWFZdlc3em53Tk1Gc25IL0hq?=
 =?utf-8?B?Vy9SQmxHV1Q3emFIbGd3WjNVL1oxRDVLM3ZmZ0Z3U2xzSDRQYTUwbEwzRGxU?=
 =?utf-8?B?elNFY0ZRYmd4RktmSFlCQkxXTHIrL0ZMVUdUS28xZlk4bk40aEk5R2k1MDcy?=
 =?utf-8?B?VVYxS0haMVd4S3UxOGxRTGNnLy9hR1g3Q3U2ZkdvK2ZhMkJyU2EyZW1YbFdM?=
 =?utf-8?B?UHlNVUtNSFBFbDI2UUhMSFIvd3o2QnBlVmZySk0xREwxM2lVcndVdFhSZTc0?=
 =?utf-8?B?TDNnSEFjcGg3ZTdVZ3JWZFVxNkJvUGc5c1ZsekVRUTNpbFVHWE5uYkZ0UGhF?=
 =?utf-8?B?QitoR3lXYVRNK0JpQXFyTE5QMUpSMTBFVzNWblA3YUtMcFFiNWVVY3RqZ1hC?=
 =?utf-8?B?cnBNOW1XRTcwUW5xbGplTmNPMjJhQ2x3SzIzUjhudGtaT3plcVhZVTRSVHpa?=
 =?utf-8?B?bmpKK0VDdmgwRklSZm5SSWtPcWkrcTAyQkdZTDZvV1haQmZTbnFYT1NrazRa?=
 =?utf-8?B?THZOOGNpOGN2QktsVkU2UkJ3ckh2b2ZpN2Exd3BRWFlaYnJYaVRXdVUvaTJr?=
 =?utf-8?B?cFNFWG5BaXQ2Z0xqa3ZrZHFXRkVzQkNFSDU4ZVl5Yy84Y3FwZVRlUnVzampp?=
 =?utf-8?B?aWFXcGV2dmpmR0J5MEkxMUt1YlVkd1Zha0VENk10WjkvV09yOGJvb3N4Skpo?=
 =?utf-8?B?QjF1N3NVdmNxTE0yTEZqUG9xSDZJS0pkODZ5cnprVHhIRzhlbjFjMGczZWlW?=
 =?utf-8?B?UEFDdFhTb1duQm16cDVDb3U3cFVselFwTjFNNDFNRW5GUGcwWjNQYmNIS0pU?=
 =?utf-8?B?bDRyM3Y5bHNhVTduVGRpWTYxWnpOWVFiSXFNVkVsaU5NZ0Q1SUcxbXNyUzk3?=
 =?utf-8?B?MFhwa2JLUklOY3JLc21kak9rVjJ3dkIxci9CT2dEV29ib1FFNVNoU3VxN3FJ?=
 =?utf-8?B?REpEdldmVTQ3b2k1MEdidkFQZTlDdkhoY1JFWjF3UmErMi83QzUreUZ1TUtE?=
 =?utf-8?B?VDVoVUNrQzFxVGpReFVxSXlmNmFGdDAxYXFKVUxkc0NXUWVqb290OUh6Ymow?=
 =?utf-8?B?NXRUbzVUeFVkblV4ZVR2djUwNmZHSWV6Z3hMd1FwSGErNmhIU0dhdUIzR1Vr?=
 =?utf-8?B?akczNTFJV0puU3BDOTNvNnZMSXF2QUkxUmlQSkNTMkFzOHY1ZHZoNG5nU1h4?=
 =?utf-8?B?bTJEQnZQRWV5c3FTcnlTMDZoV0JaVnJkcHNwUDNod2pYNTRLOEN4VDcwdmk5?=
 =?utf-8?B?R29FQVpTeEJjVXlSSWphQ3Vqei9xVGQzYndiOVdadkxzZDlXWU5mQlJJWWZJ?=
 =?utf-8?B?OWlyNnVLY1Bvci9lZVFweEI3NGluUEN6TlNEUkZKa01aR21WRzFYcjRzeTRO?=
 =?utf-8?B?T0pzUCtPcGM0UWM4WXZ0ajB6d3QvMnJHZjRrRDBhR01QVVhLUTF2YWNNOHht?=
 =?utf-8?B?a0ZpenpOUjhsU2VjbXkwR1Y3ZVl0bTcrSjV2R1NwbDNPOTZGVVhLRXdQeko3?=
 =?utf-8?B?NitKcFRCL0lpN0s1TjNOcHdLQ1lXck5DeGtVSlByRnExZXc5NHNwU0dQTndl?=
 =?utf-8?B?UURYWnJzRDg4b0gxeGc4dlJpRjVBd3NqcVp6d0Ira3FCV0dVKzZJcUw4aGRS?=
 =?utf-8?B?bHlNZCtpQ3JTeUgxZXZzSWg0Z3BQOWNzS2Nsd1N3Uis5d09rb3U3dC9keGNC?=
 =?utf-8?B?NjFKeEFMRHVSb0N4c0VmRFNIMkZWM01TNzI1YU5XV3NtSjRidG1Rbkx6aE9p?=
 =?utf-8?B?cVJRK2Z3ZVVGbE9abmtnWkR2UjY3c2pVS0gxYTZaTjNTSWdoU05uNVhYQnN5?=
 =?utf-8?B?UUg3YzlGbno1SWJmenBjNm1WY01zUXQzZVpBaFptMUlsMHRXc0EwRVAwT1Fn?=
 =?utf-8?B?OTM5SmRWKzB0b05KOUt6Qk14SGN4SDJZRW1FMkF1TGFxcWtBcCt4d0xTdDVT?=
 =?utf-8?Q?qPCDJ6+If8yM8+C8=3D?=
X-Exchange-RoutingPolicyChecked: I/ytOOvmWFsZdzvnKgNOLCrKEv8DL+xcu0UwVjA6csjWgARbS8Wcbym+jtSWGpuhftIh3tSjzcrxotRPz3c3sYEdkTwSjpGxxYSFyh6ZPDii2fVisS/wUsllkYkt6XN7i5Fx2tSR8+Ji+e7CxAZmuCoW+EzBVtO0GhuPGuDpCbl9nns2NoGN+wwOAVGExCsmvvOBsJjR3gPiQvDva2Oxbz7M6MiT/8G65RJlM4rhK7px1EWUFUbxuIGhi9DH/dm0S4CPfyHcTRlioWx7bdYpiRx1Vy06JO6IzHOb+Mri9BZZuD+cmUXWtECI4H1LdTOiRJyoCCoGj+4hUCmaV49HMA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f94d6e9c-3899-495a-9ab5-08deb6554d44
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 09:51:01.9837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dzg3W4iOzdWkuKtWevdgWoz0B47dp1riHN7slUxQkds/EaurTEsqpuPPojQFlT8v9frpl3TRsRBpjWn9FVxWQi+NrQCJKx/LC8RxVqukxDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8372
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

Hi Raag,

On 14-05-2026 02:20 pm, Raag Jadav wrote:
> On Tue, May 12, 2026 at 06:56:18PM +0530, Mallesh Koujalagi wrote:
>> When ``WEDGED=cold-reset`` is sent, it indicates that the device has
>> encountered an error condition that cannot be resolved through other
>> recovery methods such as driver rebind or bus reset, and requires a
>> complete device power cycle to restore functionality.
>>
>> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
>> ---
>> v2:
>> - Add several instead of number to avoid update. (Jani)
>>
>> v3:
>> - Update document with generic scenario. (Riana)
>> - Consistent with terminology. (Raag)
>> - Remove already covered information.
>>
>> v4:
>> - Update doc. (Raag/Riana)
>> - Change commit message.
>>
>> v5:
>> - Update commit message. (Raag)
>> - Remove unbind.
>> - Simplify cold-reset script.
>> ---
>>   Documentation/gpu/drm-uapi.rst | 64 +++++++++++++++++++++++++++++++++-
>>   1 file changed, 63 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
>> index 32206ce62931..809386f16521 100644
>> --- a/Documentation/gpu/drm-uapi.rst
>> +++ b/Documentation/gpu/drm-uapi.rst
>> @@ -422,7 +422,7 @@ needed.
>>   Recovery
>>   --------
>>   
>> -Current implementation defines four recovery methods, out of which, drivers
>> +Current implementation defines several recovery methods, out of which, drivers
>>   can use any one, multiple or none. Method(s) of choice will be sent in the
>>   uevent environment as ``WEDGED=<method1>[,..,<methodN>]`` in order of less to
>>   more side-effects. See the section `Vendor Specific Recovery`_
>> @@ -439,6 +439,7 @@ following expectations.
>>       rebind          unbind + bind driver
>>       bus-reset       unbind + bus reset/re-enumeration + bind
>>       vendor-specific vendor specific recovery method
>> +    cold-reset      remove device + slot power cycle + rescan
>>       unknown         consumer policy
>>       =============== ========================================
>>   
>> @@ -451,6 +452,17 @@ debug purpose in order to root cause the hang. This is useful because the first
>>   hang is usually the most critical one which can result in consequential hangs
>>   or complete wedging.
>>   
>> +Cold Reset Recovery
>> +-------------------
>> +
>> +When ``WEDGED=cold-reset`` is sent, it indicates that the device has
>> +encountered an error condition that cannot be resolved through other
>> +recovery methods such as driver rebind or bus reset, and requires a complete
>> +device power cycle to restore functionality.
>> +
>> +This method is used by devices that are plugged directly into the PCIe slot
>> +which supports removing the power.
> This looks good to me.
>
>>   Vendor Specific Recovery
>>   ------------------------
>>   
>> @@ -528,6 +540,56 @@ Recovery script::
>>       echo -n $DEVICE > $DRIVER/unbind
>>       echo -n $DEVICE > $DRIVER/bind
>>   
>> +Example - cold-reset
>> +--------------------
>> +
>> +Udev rule::
>> +
>> +    SUBSYSTEM=="drm", ENV{WEDGED}=="cold-reset", DEVPATH=="*/drm/card[0-9]",
>> +    RUN+="/path/to/cold-reset.sh $env{DEVPATH}"
>> +
>> +Recovery script::
>> +
>> +    #!/bin/sh
>> +
>> +    [ -z "$1" ] && echo "Usage: $0 <device-path>" && exit 1
>> +
>> +    # Get device
>> +    DEVPATH=$(readlink -f /sys/$1/device 2>/dev/null || readlink -f /sys/$1)
>> +    DEVICE=$(basename $DEVPATH)
>> +
>> +    echo "Cold reset: $DEVICE"
>> +
>> +    # Try slot power reset first
>> +    SLOT=""
>> +    for addr_file in /sys/bus/pci/slots/*/address; do
> This looks like we're peeking into every slot present on the machine which
> is not very optimal. Can't we just follow device hierarchy in DEVPATH to
> look for the slot that is relevant for us?
Agree!  I will update example script by looking slot in DEVPATH instead 
of scanning
every PCI slot on the system.
>> +	    [ -f "$addr_file" ] || break
>> +	    addr=$(cat "$addr_file" 2>/dev/null)
>> +	    [ -n "$addr" ] || continue
>> +	    case "$DEVICE" in
>> +		    "$addr"*) SLOT=$(basename "$(dirname "$addr_file")"); break ;;
>> +	    esac
>> +    done
>> +
>> +    if [ -n "$SLOT" ]; then
>> +	echo "Using slot $SLOT"
>> +
>> +	# Remove device
>> +	echo 1 > /sys/bus/pci/devices/$DEVICE/remove
>> +
>> +	# Power cycle slot
>> +	echo 0 > /sys/bus/pci/slots/$SLOT/power
>> +	sleep 2
> Is this tested on actual machine? Is there an explanation for the amount
> of sleep needed that serves all cases generically?

Honestly acknowledges! point, the original sleeps  were guesses and 
there is not a

single value that's correct across all the platforms (it's depends on 
the slot controller,

downstream link etc.). I'll remove both sleeps in next version.

Thanks,

-/Mallesh

>> +	echo 1 > /sys/bus/pci/slots/$SLOT/power
>> +	sleep 1
> Ditto.
>
> Raag
>
>> +	# Rescan
>> +	echo 1 > /sys/bus/pci/rescan
>> +	echo "Done!"
>> +    else
>> +	echo "No slot found"
>> +    fi
>> +
>>   Customization
>>   -------------
>>   
>> -- 
>> 2.34.1
>>
