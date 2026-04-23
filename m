Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35B0FDEE46
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AB9B10E390;
	Thu, 23 Apr 2026 19:42:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bN8FaFOQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4276410E390
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 19:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776973363; x=1808509363;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hvsufMmcEpKdyY0myog0tpMGOytNnHRWJfi/1spFw0g=;
 b=bN8FaFOQzMtEjKNnJEZ0LVQSDhUfE4c/xtCbh7dzSa2TWZAS2N1ZOfbj
 YLE2QsewbIl9Z26MfOht86RbyeXhhyaiOiG+KxviICvLd6T+De3ege8Iw
 8Swbah5qFt646e7xtQDMSGhHOnHd5eXnzyWYsO9pOennTghLGjqO40t8A
 xu/qNVZwBXzU8oSqZfp6Sd8keEpCsWC2WnXDN2CEBxIZxRu0qN6cXo/No
 axO667sgNGLDQLhOwRX3brQka93tAcGc7Xts7B3jChoI8kOASSsqFgTys
 c0VwDhUe0WVSfzc4ODoJqg9wBIlDQBKqFGCOkbFIZ6SArq6KBQkbQlePB Q==;
X-CSE-ConnectionGUID: SzOR7JIqSJCU4H1mgojp5g==
X-CSE-MsgGUID: HYVkCMkqQU6c25KFxLND2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="77971687"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; d="scan'208";a="77971687"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 12:42:42 -0700
X-CSE-ConnectionGUID: Ov/Y0podRVGtsNAOEUWeNg==
X-CSE-MsgGUID: 5ucqJPg6SgGKbveLzyKhsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; d="scan'208";a="230080457"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 12:42:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 12:42:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 12:42:42 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.6) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 12:42:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmpeCbt3/29SExjGakAAq1np8hl2/lHcWQOyePts9vR4DQyXFW+XHZXk66KbTj6OqAl7qTzRrt7JmmxMUpmbi2MKfvRvfV+MZZZ8WLW4RfwRo4TYRQeDG/djn0eU3ugIx/sLWa2P88cpw6xurW/TnUoJNeHk/elxtECjdEBqb3z0JpCFQUYPfWGHZwIxK4MXCoa3J82qz0RtKlQXA3BUP49QxZs1Nqd7kjY9k41hyPCrUe1oxW/OcgHzyPf7eL9Vr1EAw/rw0w0CeLMf9J2w9m8ae9ixbKK+4KitM7GX3gFffqRkJ1FR96/Kv8w73uiWZyP7K7PFOCxCeg9SOYNKjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uywfleq+KjAciDUJ0OX3Ypsg+NKOLtXJ2FJKUPMIvbY=;
 b=N8k6hGn+zO2YP0T6a/pwn6xj1NOEJtDFeTkRi5atOdA14S6GZLXW/pFiMgWWpUfX6L2ux3I0iUHJWfO+0aNxFO/0OE+cNVN4YAC4tKzMwV3KOHTQ4jcELi/z/oDrHj6WxdF7B2kTe8XOp1aP6gS/vqcFX77P2uz7KjKnEu6QO21Yr3bAjSPEnYRSMmiBID07CTgAh00yxTeT8IEZ7MBVXuFpjV+Qc1XnxhbMsPvuwxZm5phGs9u9s1a1eD9lSD+mgGHfc/KKHjR6pMyeCViSqgTD+oqvaFT5qtVQz+UIK4k2lpAb3rq5SP3WHJSB7qN3PrrO2976Ylow9cQMN+OXog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 PH3PPF248AC5624.namprd11.prod.outlook.com (2603:10b6:518:1::d0f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Thu, 23 Apr
 2026 19:42:38 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 19:42:38 +0000
Message-ID: <e9cca01c-960d-495c-aaba-327eac43cad6@intel.com>
Date: Thu, 23 Apr 2026 12:42:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: further issues with MGA G200 graphics chipset
To: Jocelyn Falempe <jfalempe@redhat.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, "airlied@redhat.com" <airlied@redhat.com>
CC: <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Pasi Vaananen <pvaanane@redhat.com>
References: <76aba88d-ec23-4b3c-ad91-83face0c3e94@intel.com>
 <a9d176ec-d19b-4f41-af16-cdc4e475a8cc@suse.de>
 <6ec01703-31e0-4998-9508-a5a115ae7bc9@intel.com>
 <14aa4840-29c4-46df-b60d-8e1b92494ad2@redhat.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <14aa4840-29c4-46df-b60d-8e1b92494ad2@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0336.namprd04.prod.outlook.com
 (2603:10b6:303:8a::11) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|PH3PPF248AC5624:EE_
X-MS-Office365-Filtering-Correlation-Id: 70604bc0-1d54-4155-14e0-08dea1707953
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: I8bNBYbPNKrZlMBcGkrfWJe8Umg+uRXZy5WCDWM1/U3WvAlagW2pnzwX6LA5hFbsw96v/4D+dbIrY/bjqCdLd2VRAfRhS+Z4J/Kp87BM5WsaBt6la/mRKWkHYKkDQV16G0iJ0XlJ7D9HnRB11S/CuoMCxfjgLyXvvLQ4BTorizgFmk35z7G9Mm9ex6bDXefWnz4OyRH614RB9HlXNsdTmcq9cPx7MjIdYBeWyAq9bxhHJyexX3JWi/DonDjRjrEmlu840OUhUzRw1TST7zOTB4+n7WCsSph53gWghxy6vMNYX3tVMZoqCJNV0yituNEzcxZR5kDdoammrVu0wtvh40AWYKcoIaM16aUV4Ccwyk1erwH7+uPvejI4kGvnKlP92myGAejkdjllQokzSGrnKFhtDIkyfI+NAwwFF1pntNu6bgLmNI5L1waZroTC5bvgqQCMNXe0HOkn14sxhKq7dDjWrxIXbCDP0rqKKwRaVUwxwDqOaaTR5Ap9Pa7D/vZ66rgKetCqizfSzxHxkq+yzaGxZLVnr5rHwSqsOygturW5irY2te6Nm6enwAmQmDl/PBY103na6wuG13HjXPDsH98os5ZBBntZct60MaoX0AlVacBYgFO1oDgt2sxdCNhruAOZ0UGvrMcbfsl7EsKgm8kIpR6vAxVM1NURUhO2V+WJ7MlJxBV3hRH7p2onB0Cr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7579.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aThLVDNqQ1BBdFFWeTJiNEwyOTRLeU5rK056Si83T0RZUHpURnZGcXZNaWRn?=
 =?utf-8?B?OEpydDZDdVZMeWpJODNlWTBZNkJVemNTczlZZjFPVFVkTFVBa2ViL3JTbVlY?=
 =?utf-8?B?bjE2ZWdneGJGdlhDSFJpOHc5ekFDdmVqMEVLdjhleThzL1BzdlRMMjJnMldl?=
 =?utf-8?B?bENmeVZTSWVIZmtYV2o5Uk9SRTF5WGh6eXNGT1dSTWx6SWJzdUIrb3IwdWhn?=
 =?utf-8?B?T2wyYnh2R0lCOEF0YUxjWkZGaTZrOTcrQkNicllVT1crUXN2Q2x5Q0JDdlpR?=
 =?utf-8?B?NjJ6SzVjQjFnSldpMzJLZUZLWVhLZHNiWERYQ1pJRWNuL2VDeFludjVvSkpO?=
 =?utf-8?B?T0hTb3VsYUF1ODV4cm5BQnRrZlFhRDN6Zy84cHhUWk0rUk1pdFpmblRyMTNZ?=
 =?utf-8?B?eFRRbm5RdFNJYVZUYVpLRnBsUUFHd2orMGVsUWVYNGRCQnJEaTFMS3JLUmhO?=
 =?utf-8?B?Q1d3NlV6T21MQWVWeC9heExQQUMyQ3lGV2NtdXVYREJQYjZ2REcxWDFSNDNh?=
 =?utf-8?B?MGFkNk9KeEZGRzRiOFQ1Q25nRjE5ZS9aYzFIZCtaTkNpTVlWc1VRQkpYYXJT?=
 =?utf-8?B?WDRqWDdMN2NEKzJhUWRnYXBMVHBBT3JvV25SdFpwa3lvL2dwV1NDRkVKdkhG?=
 =?utf-8?B?VVFjSWFiRTdadmdJR2J2Ky83a09vT3FhcGNLVlA4K0FCblNrOXZnT3RlM3hm?=
 =?utf-8?B?QXoxY1FtREZpQ1JoRGJuRk00QU5rbkZxRjNvc1hGMkdBdE5ITHlTb0RnaTg0?=
 =?utf-8?B?OTVyM1JCZ3ZZUzhBQmY4YkdMUDNpb0FsYmxqUU1TNm96dzdSVEl1QzdXRkN4?=
 =?utf-8?B?Y3dhMTZ1dWNOVURhUWs3TTNGQjJ5R0tPdmcrS1M4MjA5ZjY5SnIwNnQyTEF6?=
 =?utf-8?B?enB5RG5aejJVU1Y2NDlBRU1lMDh0ZEd0K2VQQkFKQWdINDl0R1pPNmdYRXpo?=
 =?utf-8?B?VllJUWdYcFd4T3VYVThZa2Y5UnBHWmd5MWVVVzc4bzgrb0NwaC8xODFJZ0xN?=
 =?utf-8?B?UGl3czVpWGNIZXF5RWdXYWNEbW55K2RybS9RczgvUWV6UWFpZjZ0aEN4TU9l?=
 =?utf-8?B?Q3ZMcmRGNnFtOVh6RGRxME9MZUgvbnI3WE5MUjNNQ0czdzY3b3NUNGIrQ2FQ?=
 =?utf-8?B?SU8vemRRV2JjNFgyVEZRRlhxZjlBL3d1RmM3TE1tYnVwVUpTaFNMUldBNFlU?=
 =?utf-8?B?eHl3VllyQ3QycEU1eEhscWcrdlVCdlZUeGRHNGh6Z2pSWElsMnFnN3lDbUlR?=
 =?utf-8?B?YTBOOHljSWpZNjZtdWlGVnpHUldCemloTjJXdGtZY1AyYU1RaW1tZEVkSitv?=
 =?utf-8?B?YXNmQ255RFVvdElKeTZnbk16eU53S0U3ZDJnTnptQmxqc3QxaFBkWisvaUY0?=
 =?utf-8?B?NktBUlhFWVMyZm9HL2F6WG9ZYVZ4UDZiV283dmNncHBiem1UcWNTZUxlRFY1?=
 =?utf-8?B?YnkwRFRhYlZ5RTFMR1VlWnpwU2xMYktvalJTa3h2OEx1RkdrUmQwZFJiZWhW?=
 =?utf-8?B?aGxHRFFvRWNRMnIzdlc2TVUyd2hVK3JpTXY5R2dpZGlSYUxzZmhWZTdrOWUw?=
 =?utf-8?B?aGduVVdqWkp2QXRtUVlJQ1VFRyt0Ym5WajNOaXVMc3NNbGJTN2ZMeFVQNWVU?=
 =?utf-8?B?aVRkeWVKelNHdkRaS1VKY1ArU2J3b3RsUDVmNEp2S2hTKzU3dkx3aSs0TU5q?=
 =?utf-8?B?VHp5aUdaZHR3SE0xbXAzeG9mWFQzelZaTzBqN2JjWEdBaitudlB3bTVHMUcz?=
 =?utf-8?B?UFc0eVFYem9tbWxrQmFKVEFpU1p0aWtZUEtBNElLYnU3RGJpSCtuK3dPRG4r?=
 =?utf-8?B?MTc3VTZDL1BtK25kMThFZTBjUWJSUThBQVZ0WllnZEdGWEQ2Q0dkYjBHQ0Fa?=
 =?utf-8?B?UUp1anVTZ2xOTitTUDJmMVZMVkZiODdNQzhDTFpUSGsxWHlqZ3gvL3JJdi9H?=
 =?utf-8?B?MGRnWmRKaW9MQVV6aDVqc2Y2VW9pNDR2NlBNRklmWnVVMzcwamY1Zk4vZFdK?=
 =?utf-8?B?TitrUEovN2FDSlh1MnVvcHJkYmgxT2Z2MHU3aVVPci9oYmdTTENGL1FWTmZT?=
 =?utf-8?B?Q253Y0JYSHVpTnRWNVVBczljdTV2UDIwYWxlT3BXYmhYaUFzemhXTnpKOG9N?=
 =?utf-8?B?dEt4WDdCdkZaQ3p6Tm9RRjl5L0JSSURwc3ZESzEwckFnRXJLQU96VE0zaldk?=
 =?utf-8?B?WkhxUEk2ZDQ2amRIdXRzOGlkOENpT2luN1lzY2pyM1VYaFkvdU9RTitaVm5Y?=
 =?utf-8?B?TmpMZktway9CUndUdGFoREd6RUY0a2Yvb2trek1FOUtmdXVseWlScGdUZWll?=
 =?utf-8?B?WWZwRVpOU1dvVnp4WHlDTUJmWjROc1NKZ082UE9YR2RoWnRkYytySncrTFJm?=
 =?utf-8?Q?hqBQVLLvJ21PEJTk=3D?=
X-Exchange-RoutingPolicyChecked: u2ZHnsRxjx1eOljezgLdpz8KRGXKIG+V3sHtBJxdks0WhQYfOmcV5jedbg6YD3lKqpjcpUuAtoRahhXzsrivlhkcLAd/hS9ej8SHVPtt/nGqMvnjkneoKYNTAG9WrFttGDhSOZlAMdlxIrgRIDoZHyKm1LFMsthOI5C49Q8647yVBZWwj7vmseBuBHdQlAh+EIZiPeN0xQUfiAMf94ZmFj2w2/ZNL3/zPMdektH1d0HjkKXVD/XchfwBiohAxeSJKi8sRXgOK/gcHc9S3YAiwc4UwaSJRyXR8IX0t7L2TxEtXdxSo88FISxKKBhCGXLR33tNMhNs3JKbENUFf5nJ1A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 70604bc0-1d54-4155-14e0-08dea1707953
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 19:42:37.9443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nfKfz6GZ2k2IKBW0dDXPWxAf716LXGkByMrxMiuCcs5NeF1Ggq1/6NI+rmBJC/WzjUcTo5mvXB5Bak20RTfsUbnaO6kqdI7tPngpGFTzXSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF248AC5624
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

On 4/23/2026 12:22 PM, Jocelyn Falempe wrote:
> On 23/04/2026 18:35, Jacob Keller wrote:
>> On 4/23/2026 12:44 AM, Thomas Zimmermann wrote:
>>> Hi
>>>
>>> Am 23.04.26 um 01:55 schrieb Jacob Keller:
>>>> Hello,
>>>><snip>>>> I'm also curious if its possible to stop polling for so
> long with udelay
>>>> in the i2c logic somehow? I am not very familiar with i2c, but it is
>>>> frustrating that this driver is causing yet another stall that is
>>>> impacting timing sensitive data. Even if in this case its due to a
>>>> faulty cable.. it is frustrating that such result causes the PTP
>>>> failures. Would switching to WQ_UNBOUND be helpful here at all?
>>>
>>> Try Dave's suggestion to avoid polling.  The driver won't be able to
>>> detect changes to the connector status, though.
>>>
>>
>> That's fine. I don't think we're even using the device. It looks like it
>> might only be in use for BMC, and the VGA connection isn't actually
>> physically available, so there are no changes to detect.
>>
>> Is this polling really only to detect when VGA is enabled? Would it make
>> sense to only poll on platforms which actually *have* that VGA
> connection?
>>
> Polling was introduced with https://patchwork.freedesktop.org/
> series/131977/
> 
> The driver needs to know if a VGA monitor is connected or not, to
> provide the right available resolutions to the userspace.
> Otherwise you can set a high resolution that works from the BMC, but
> then connecting a VGA monitor will not work, as the driver won't notice
> that something has been connected.
> 
> The mgag200 doesn't have an IRQ or a register to check if something is
> connected on the VGA port, so the driver uses the i2c and tries to read
> the EDID.
> 
> Unfortunately, there is no way to know reliably if a VGA connector is
> present. It's possible to disable polling on some machines using DMI
> quirks, but I don't think this approach will scale.
> 

Timing sensitive setups like mine must have system admins who know to
manually disable mgag200 or disable polling. Many users won't be aware
of this. If the polling were not intrusive, this would not be an issue.
But....

Faulty hardware (perhaps just a cheap pull down resistor on the VGA
connection as Dave Airlie suggests) means that any such affected
platform has a polling routine that causes significant issues on any
timing sensitive applications.

Right now, I am stuck in a situation which means that I have to fight to
reach every customer who uses one of these platforms and confirm they
either disable polling or ban the module so it won't even load.

This is frustrating, as it is unlikely I'll reach everyone.

I doubt that I'm the only one with users who are affected by mysterious
performance or timing problems related to this. While its true that not
*every* instance of the device is problematic (at least not now that we
fixed the other issue with the udelay...), but many systems using the
controller *are* negatively impacted even with the timing fix, as I have
now seen...

Unfortunately, I also have no better idea than a DMI quirk table to
record known platforms that include the controller but don't have a
physical VGA connection exposed.

Thus, I'm wondering what else we can do? Using WQ_UNBOUND might help
somewhat? I have no idea if its safe to sleep instead of spin while
reading the i2c connections... As far as I can tell the non-atomic
version has nothing that *strictly* prevents sleep.. but maybe i2c
access has tighter timing requirements than what usleep_range can
fulfill? I am not sure...

I'd just really like to not have to worry about going to every single
user and asking them to unload and ban a driver for these big server
platforms...
