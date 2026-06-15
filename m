Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBE6CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 08:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8E4210E267;
	Mon, 15 Jun 2026 08:07:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LfRP2VIa";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A798210E260;
 Mon, 15 Jun 2026 08:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781510832; x=1813046832;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DR9ErfcbMzvbgLij9Kt/G1xO9wPatTUJGNxzqQXKSeE=;
 b=LfRP2VIaGOayAAKMPzmLr7AnBKPqCbwaZVk1e5VAqIYc0E6vrFKIWW3+
 PJcCs3xVNfj19JrUkex9P2NEJ4ZYPL/TFvJiJcFS2tpd9vwCSNSMy2lbl
 ZA/eGeyYYWB2TRLPuvdZogGYDRr5KpXm46X336Q0R7eH5SB+wv0W+5r2Q
 McpOlTGoGK5TICiNzo1niKmxAniuVJzYjIj4wt3a0XI7OBmKFrimqLBEN
 CnjQ2mnmfa8MxRAT35euMSZJ/Z5fa/JKRZKE/3jm+WkUiNSQMEWexIE2C
 XCLIwEI6IhlZJRwhIoRcOCh0scT11kIaiYp1Sol3/fGjNIFBGJpsIc8XG g==;
X-CSE-ConnectionGUID: +ZctTbwiTZacwdeYpCvthA==
X-CSE-MsgGUID: UDSgOWftRWOSQLB+UXfvGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="99820665"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="99820665"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 01:07:12 -0700
X-CSE-ConnectionGUID: XuiDiVJFQfWLiTAAxLk30g==
X-CSE-MsgGUID: E/sGsGEERvqgvFOBvDY4rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="252360656"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 01:07:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 01:07:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 15 Jun 2026 01:07:11 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.13) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 01:07:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3Hdoj5Je2Y/UjUwKHqoqkqX3hxf+qL4uc/u5SRjGEa4jB7JDl0PxTxd2iH+l47Z128sqzEF+7jwb6/XhEAedYMZEo8ioCHTxvvzYXdMaVTcNrHo1F9OLp0cafuunPJlvhUjAlyUNEpaZoOloxM6l8YT+gAeOx+iInu13f5mrdjCYT4l3XF8z38c02jYj0OfnEzVpRUOcv7o4oS8mXuAwf0blZTOtyOvnluZ8cYq56fSqkuZLDd86UGbPzHa1wgBjlJyqHPFZ1V5Fd0Vsu939GotK1bHBBqi2S6Q3z/zl8325r79h8kOSbnLDdzTjWCBrHn0entmAtENy9GlHSyEdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjYuZUsgv9iJWst9vQXhUg+9kasPzNnTD72gIX9BQBs=;
 b=UAi38Zm+LSaRAzNoVxdLR1ykAJp4UP2sgdGyBGra1JP66lwIgP+Ndq478qoe/pPaOpOMTu8YML+Bneppiixqfo7Vb+kP/0PBRNB01GHpcqL3WJ/4oWYNZoYnu8PRqFYH2yQETXnylQYm4JJ4tccS1VmApls4f2QLXPcC/LvkngjEsyqDHyNvPALSEm89Z5Cbmu9wLygkJ7mtvA5UU7VB+jEiFc2m+H+T5exycB7GvsFJXuS2d0xeVQRxWCW93cXdTr3J0bpcFlp2fLuvvNNvbMyyCgQmmpWtiLSVYR+M+AtD5olJOJvCnRToQEtIxHuxhs11Dcd7nHkIZAmYqr9gow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 DS0PR11MB7263.namprd11.prod.outlook.com (2603:10b6:8:13f::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Mon, 15 Jun 2026 08:07:07 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 08:07:07 +0000
Message-ID: <e1cdf40a-d121-44ba-bca6-48fbeba825a3@intel.com>
Date: Mon, 15 Jun 2026 13:36:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/6] drm/xe: Suppress Surprise Link Down on device
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rodrigo.vivi@intel.com>
CC: <andrealmeid@igalia.com>, <christian.koenig@amd.com>, <airlied@gmail.com>, 
 <simona.vetter@ffwll.ch>, <mripard@kernel.org>,
 <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
 <anshuman.gupta@intel.com>, <badal.nilawar@intel.com>,
 <karthik.poosa@intel.com>, <sk.anirban@intel.com>, <raag.jadav@intel.com>
References: <20260612080722.26726-8-mallesh.koujalagi@intel.com>
 <20260612080722.26726-13-mallesh.koujalagi@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260612080722.26726-13-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0105.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::7) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|DS0PR11MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f8c15c6-ee10-48d5-0d41-08decab517df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|4143699003|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 7tonEl62GkBwiaSUaSK1nL8N/XPxQ5NTxTWLpfJtFDtVW7y9Rr89xCKRtpOvnjS5QG8KVXuS4pQkq4VXIL7obJi+YRdNNCPIlzuy2ryfhd9OC5t6yM+j71IbJmLVYOxdXxr4AC5HdlUMFpEj2fO/zHLWYK44DR9t7Wwe/LZ4fGA6gBloTEF6GY4GVYT6YsW3hrgv9H8lL5Tlxr53qeK8N4MouM0XPLhuM8ZYkDbyZvft7Fr9AvjPcyHfS/sn24gut/7hSuVXeFlpW6tPU5TmI+K3uPg4c0RuPoueav/gNo4eCQWUncZeoMik13D5pCRD9yt/BVS3MWvM3xTCe+VgwF0INuaSw2qDJ+C1VdVteqW3NJkj/EtVAnuQH1Sx6chbd5rUNIsFP64ksVsy73jzPmZfLMwcQRjmsoCRg4h3ZkG8NI22pQiYPU1pHRz4GCi/BFjTJlR+LTACvZ17v/rgCE2lCLiCZAOGocL2kXg7gDNjxkO/qxPG6uztgY4AnULRQaN0aTA7IVdRcZjrLvDcBQVW6f47yYFTrB8unWSh7je71/Y4LEmemsCzAhfD8PWkh4FBeDSNnKorW0svmUp0qut188CAWXgtDx/4cfoAGb1DLVgvb1OsNRVPGS8br/puyPI5yI5GJUJq45XWSy5j+rOk+HY0Fnk9ZG6cO2SJBpfzjTy1D9Y9/dgjrAc+kPSM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0lVcEt2UTJ5SERDRDF5WVlqSVAzd2FxdG9mQ0Y3bnoySDB5eE8wYVQwVDZH?=
 =?utf-8?B?WUZNSSsxckRTQnp2MGQrUVJGVjQ1TjZvYUd2UWVIem4rSjQyNjNIRWxVL1RQ?=
 =?utf-8?B?MDB5TmdhTzBoY3dOZ2VIR0d6MWZTTXZXZDVnYzQyNWl1TzVjSjcwUXJ0bi83?=
 =?utf-8?B?Uy9jSmtlN2xERVJWR3l5WDhFQkdRQW1TYmhGRXQ3RjNjY2JpQldrTlN1L2p3?=
 =?utf-8?B?S1d4VHlVVm9uWE9ERndQNEpkcXRGY3pVT1ZyWllyRFpucjFSeDNRODVtd2h2?=
 =?utf-8?B?K1p4TFcwQnhmbVczVWNHdFVMdUVRQ2l6em1tMHFhMWZ6Q29lTDRTQzFoRUhW?=
 =?utf-8?B?UjhKRjBaaVNEbE5La3FKSlhjTU5RVGhjbDR3V1p1RmptN3o0ajhQRG1vb254?=
 =?utf-8?B?emNIWitNZjdKREl0a1hQdUY1WTZKNWR5QXdOaFhRV3hIUjZuS1c5TW1KU2ZW?=
 =?utf-8?B?UkNmVUFvRjRnUFNES29DTjdkQldCT05MTlc0K0VpbnM3LzhFSDJMZ3lxeXBG?=
 =?utf-8?B?a3VIZ1Z3cXgxNXBRM3RFelVTQmlCTnRqVTJEdC9FV0MySWtrOHlxQ2F3djhx?=
 =?utf-8?B?RkRxSnNBVW5ZQU5CbHZOZGx0N3VPK2Y2Q0VQbHI4QjNYdmxOc1hOYlRGVmov?=
 =?utf-8?B?R2lWb2N6MkEzdFlnMHZXTkxlNjBZa0pSN2x3UTRrSDhqNTVrM0lRaGRGNjd5?=
 =?utf-8?B?aDA3YkFCMUFnekc1MTFhRFpFQmZoV1VSaE5GckJPNU4xUkJmWEIya0QxWVBN?=
 =?utf-8?B?OGhkS2JwQXJvM1c4NWlMWlRTN0pjSGErY0dJajcwckZPenB1VU5IME5MQjZY?=
 =?utf-8?B?anpyNEsxVkRSd0NIZjVzWmxqUDRhc1RqVVlSYWZ3UkpaRnArazFxbHNSNW5q?=
 =?utf-8?B?QzJWbjM2S3JQMjRDdko4cit1QUZIaHBmT3pwOER5OWYrRjBza3REbVF2QUpN?=
 =?utf-8?B?SGtaRzE0YVNFc3d1a3cvYTBWZnZCTXkrWWhJZjNXOVRPT1RrRG5KaWVQOVB4?=
 =?utf-8?B?SVc5aEFvZUFiMWlzblBGS3hjQVJhUWFkTlhBNzBSbzBoRTY5b1diNnFqSlRH?=
 =?utf-8?B?b0lpWk9ZZUdtbk5ieTZ2MkdpK1hhUE0yMzBFL0lpYmZ0M1YzSHpnZE14VTF0?=
 =?utf-8?B?UnJIOWkxWUNMS0ZWSWxPK2RaMmFtYUVxbnMybjJHYTAvSFJoQmRPcko5STBk?=
 =?utf-8?B?aHBOdXlKTExESGVsZUNxNDE2ZTc5d3VVZllSbkU5SXhWS0dncDhuY2l0RjlZ?=
 =?utf-8?B?RmloNWt0TWdNMjBaQ3NFclNQeHZJRWxqRXl0Mlkzb2Q3WHBZWWJVa3hoQnJL?=
 =?utf-8?B?MlRDL2dVdEZyV0NPYVg4eFhrUFBHVkEyTERDb2QyZU5IeGIvNzV3UlVuNGNs?=
 =?utf-8?B?ZnlxeDNFRExVREI5dUc5NVpQMmd4Rm15M0NLV3BRbWZTcHdvQnExTmtTblhQ?=
 =?utf-8?B?VmY5TUhlRndmaVVGdlVjcmVWejNIWVY0YU9JZ1l3TnBJTDR4VEIwbm4xbzNq?=
 =?utf-8?B?QUJ2SHcvVFlzakRVYWpmU0t5OVpieVJSbkJQeDc2ZzRmS0UzcjhMQlYrWWJM?=
 =?utf-8?B?Z2VzZlU2c0hpNTNnVGVuMVRBK05mdVNySDhIMmcyYU5IVWlJR3dQanFSQ0g0?=
 =?utf-8?B?a09ZOGxtcm1LOTg0WDhSNktjaVFnbElVSlBuL3ozbm53MjJDRnY5ZXZIV3FN?=
 =?utf-8?B?WnBLaFhYWW54RUp2dUI3SmN2dDJyQ2V4NjZEYlgyaDR6UUZuMXlXS0VWVjZT?=
 =?utf-8?B?N3Yzc0h1bGRocXJmaURlWjg0eVlaQVZ5ckV6TTdaTGFianNmUUQxVWhzZEc3?=
 =?utf-8?B?ZDdlbElYcWZ0Uk53MXErVy84YUplMmpYZUlTYWFPNFo5Tk5lczIwK3ZveWxS?=
 =?utf-8?B?M0o4d1Z6TEQ2aFZMYW9WblRhbHdPQUF6UjJLV0pnejdhYW9ITmlsODh3enV5?=
 =?utf-8?B?R2p2ZmZlY05lM0I0bUNEQ3RodDB0bC9SYVpEbW10eCsySXF3cEFvVzhUWjBI?=
 =?utf-8?B?dSszYjl6Yng3bFBxSVV6dXZPNHp3cUpEbnVYVG9uQUZ1Tmc3S1JmR3QvQjhO?=
 =?utf-8?B?S0RMQ3ovTTlNTS8zVXZkL055eFNTWXgyL3ZPdGpTSWV6SEUyZlh2cExyRVA3?=
 =?utf-8?B?VWRZSGZ4SThvY0NBcXJnVlBiU0NZSXhhcWZpRmJhWXJ2cHRqZzBIaHgyNWUr?=
 =?utf-8?B?ZjMvTitld0pRUE5OSmFSR2Z1MWtncTBGaU9UYnBqaDNoNW1aOTVLeEtzemll?=
 =?utf-8?B?Q3NNcFZJcTR6a0JFbFdsSUNYZjRUVXRnaDR2MEZVK1B5VS9manZkSUNWbEJy?=
 =?utf-8?B?R3NUOFd3YnA2b0pHaHRBZXVjNitsVGN6WGMyTkZyaDMvRCtyMGNXZz09?=
X-Exchange-RoutingPolicyChecked: D6W2Qa7GgV5gd5KRLvyK30UdLLs6Qtx06sPlW0byg0rfG/1h+JxXvXrr+bRj1kA+0oZsFXWA6N/FtQPtGoplH3mm5DqErObTA9uRs2gdJShSSCrIhe3zhBk2Av5L3QQrE53EttPN1NMaAZHDgdEaJ4F0KmB6EHj0alk6cdx5pOPwjCe/0Iuhm0CW6o/ForoAP3acbIUQsn+J2zGJ7LMG2FyTDAukcdgk58oqfnqgso1sKyWEPrpsPyEEgMrVZOQf8nDc/SN8iuLNUyWTfg2YoWC4FgEUXkFAO9cirThIXzmRwZXoUVjsUcCTFzZm404TFT4ZZmxO3zpPEW+36mCn7Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8c15c6-ee10-48d5-0d41-08decab517df
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 08:07:07.5330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjeifjenTR6HmaRksvddcOMdC5e+/J5mpFI6wS2EpHrTnw7mP/6KQ1Iie5Mp+w6fU73HT1AHinuu3NECvYAAbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7263
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


On 12-06-2026 13:37, Mallesh Koujalagi wrote:
> PUNIT errors can only be recovered using a power-cycle. Xe KMD
> sends a uevent to notify userspace to trigger a power cycle.
> On platforms where link drop caused by powering the device off and
> back on is reported by hardware as a Surprise Link Down (SLD), which
> AER then escalates as an Uncorrectable Fatal Error. That error fires
> before the device finishes coming back up and defeats the
> very recovery we are attempting.
>
> To keep the expected, recovery-induced link drop from being raised as
> a fatal AER event, mask the Surprise Link Down bit
> (PCI_ERR_UNC_SURPDN) in the upstream port's AER Uncorrectable Error
> Mask register before punit_error_handler() requests the cold reset.
>
> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> ---
> v6:
> - Expand commit message to explain why SUR_DN is masked. (Raag/Riana)
> - Check Slot Implemented bit before reading Slot Capabilities, per
>    PCIe spec. (Riana)
> - Add debug log.
>
> v7:
> - Handle surprise link down event properly. (Aravind/Riana)
> - Update commit message. (Riana)
> - Correct log message.
>
> v8:
> - Use find_usp_dev() in punit_error_handler() function.
> ---
>   drivers/gpu/drm/xe/xe_ras.c | 65 ++++++++++++++++++++++++++++---------
>   1 file changed, 49 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 93a56a0269f1..15c2fa0d323a 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
> @@ -209,8 +209,57 @@ static enum xe_ras_recovery_action handle_core_compute_errors(struct xe_ras_erro
>   	return XE_RAS_RECOVERY_ACTION_RECOVERED;
>   }
>   
> +static struct pci_dev *find_usp_dev(struct pci_dev *pdev)
> +{
> +	struct pci_dev *vsp;
> +
> +	/*
> +	 * Device Hierarchy:
> +	 *
> +	 * Upstream Switch Port (USP) --> Virtual Switch Port (VSP) --> SGunit (GPU endpoint)
> +	 */
> +	vsp = pci_upstream_bridge(pdev);
> +	if (!vsp)
> +		return NULL;
> +
> +	return pci_upstream_bridge(vsp);
> +}
> +
> +#ifdef CONFIG_PCIEAER
> +static void pcie_suppress_surprise_link_down(struct pci_dev *usp)
> +{
> +	u32 aer_uncorr_mask;
> +	u16 aer_cap;
> +
> +	aer_cap = usp->aer_cap;
> +	if (!aer_cap) {
> +		dev_dbg(&usp->dev,
> +			"AER capability not present\n");
>
> +		return;
> +	}
> +
> +	pci_read_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, &aer_uncorr_mask);
> +	aer_uncorr_mask |= PCI_ERR_UNC_SURPDN;
> +	pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, aer_uncorr_mask);
> +	dev_dbg(&usp->dev, "Surprise Link Down masked for cold reset\n");
> +}
> +#endif /* CONFIG_PCIEAER */
> +
>   static void punit_error_handler(struct xe_device *xe)
>   {
> +#ifdef CONFIG_PCIEAER

We can remove the ifdefs and use this
  aer_cap = pci_find_ext_capability(usp, PCI_EXT_CAP_ID_ERR);

> +	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
> +	struct pci_dev *usp;
> +
> +	/*
> +	 * Cold reset power-cycles the slot, dropping the PCIe link. The
> +	 * slot triggers a spurious Surprise Link Down AER event on the USP.
> +	 */

Also mention the reason for masking it. Move this comment to the 
function that masks it.

Thanks
Riana

> +	usp = find_usp_dev(pdev);
> +
> +	if (usp)
> +		pcie_suppress_surprise_link_down(usp);
> +#endif
>   	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
>   	xe_device_declare_wedged(xe);
>   }
> @@ -503,22 +552,6 @@ enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe)
>   	return XE_RAS_RECOVERY_ACTION_RESET;
>   }
>   
> -static struct pci_dev *find_usp_dev(struct pci_dev *pdev)
> -{
> -	struct pci_dev *vsp;
> -
> -	/*
> -	 * Device Hierarchy:
> -	 *
> -	 * Upstream Switch Port (USP) --> Virtual Switch Port (VSP) --> SGunit (GPU endpoint)
> -	 */
> -	vsp = pci_upstream_bridge(pdev);
> -	if (!vsp)
> -		return NULL;
> -
> -	return pci_upstream_bridge(vsp);
> -}
> -
>   static void aer_unmask_and_downgrade_internal_error(struct xe_device *xe)
>   {
>   	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
