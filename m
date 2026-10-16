Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4872CCA48B
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 10:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4167D10E0BE;
	Fri, 16 Oct 2026 10:10:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77779112732;
 Fri, 16 Oct 2026 10:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792145400; x=1823681400;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CocWOINojaexqxzKS8w1xJBhW/9vkl39vn3QppISWLU=;
 b=ZSJX9Hr2/rZcXVqcHBcg5zvdXYDPhBqtkrxKlhN+8Ws4yB1RdLPTeF53
 YmB36SIZR5xMB7+qF1i9SstbVSBd3xL7A5QkyGs5lQCLPNbB5pOPAtMqv
 tzGuPWH+4qCPVS9qKS3gijwVCBHBEvK/B7qHRpJLDu4kWeFCdmhAySKpy
 dFL2YTACaL1awgheImdDwqCexLv0oAUDAJFnjC31REQTrmD7NfDRZgIDt
 b3qye0PkVEED9HTLv0swySjAhOUPw4NjboCYULJd5DNbBEOYdoquUCCuq
 3yyyJno/DydmDnzglUnlYEvJIbsJa71iBEF7wIlCy8RVoMgNA0tHZl8CS g==;
X-CSE-ConnectionGUID: tEgq2AQuSEWbS1rAUU5Lyg==
X-CSE-MsgGUID: ZWBEzBR8Tcmlmn5WtMt74A==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="812778"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="812778"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 03:09:59 -0700
X-CSE-ConnectionGUID: 4O7HjPRFTiS41UF/vIXSOA==
X-CSE-MsgGUID: hE186P24TV+6wyiP7rClNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1888330"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 03:09:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 03:09:58 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 03:09:58 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.51)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 03:09:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNBZBkSgnvnqJ0Xa2xzBPYCJ1GIvtgAz2lbxRLzarb23o6kvGbsw0KnkkOBs2VSn+lQUoKFqcs9hhCyCpkziqehAGb23bCrGr4K2VFfehFNb0AdZyJLRXlwdycLqEG+2garalO9LUxXxY3HIx8btcuK9+Bh6Fw6wbQ2LlPKuilrSkkGeWUAFKqaxV8yLrnpvFeQlSCpN4NrHr47ju8DSI7dY4E8gNI6VaP+o4hWNUM1g7D+Ft/M8TYwdOi99pc/ADe5wns0hnoKDJCsqLSYWTHhPoibhjZs0gV+PNv6XTAMAUnMa2djdxay9O2ywPERh1ceQLltHdr66dVlaOli5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7Iei5JB18MLCPQn5CzJtXok1z4RaH5p9eCYtZzNDxM=;
 b=YSIrHom0e6Mi8blwIqTEQ66KxAivNhLGLdyKhQPYyizSFmsdBu75IzxdYujleag8AReb5Lxh6J6b+QZUENLQekk+90rUGjqnUqLq8lSijSGL0qgkOopAeGHbQA1kH8V7L8MSNiEwcTOHqNfZ+udVWL/xnE+/I13Wf3BHLLNkRFIhb4Y+ZqWvOSJgJ4O9NDpO+AA/2G017dHriPh7UG+0lKfF5jClGKNHcziY33b1ZYNoAwxM9WXQ29Amwx+VZCejwsmlpokvO8nqhmlaO8PkRVf86S5MyJr1idjdjYgl5au8EDsvew84nezKU4ZS0VzJgJs/tIp1sS9WLI0vJzsN+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8208.namprd11.prod.outlook.com (2603:10b6:8:165::18)
 by SJ2PR11MB8469.namprd11.prod.outlook.com (2603:10b6:a03:57b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 10:09:55 +0000
Received: from DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c]) by DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 10:09:55 +0000
Message-ID: <1d3f9198-722d-4d1b-88ef-94ba778ed05b@intel.com>
Date: Fri, 16 Oct 2026 15:39:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gpu/buddy: Prune exhausted subtrees in range-biased
 allocation
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Matthew Auld <matthew.auld@intel.com>,
 Joel Fernandes <joelagnelf@nvidia.com>
References: <cover.1791802549.git.sanjay.kumar.yadav@intel.com>
 <ef9c4d0b6368b736ce639cfe6258f43b0ab6ca10.1791802549.git.sanjay.kumar.yadav@intel.com>
 <808d1a18-9bcb-43a9-bc15-723d84395d05@amd.com>
Content-Language: en-US
From: "Yadav, Sanjay Kumar" <sanjay.kumar.yadav@intel.com>
In-Reply-To: <808d1a18-9bcb-43a9-bc15-723d84395d05@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b8::6) To DS0PR11MB8208.namprd11.prod.outlook.com
 (2603:10b6:8:165::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8208:EE_|SJ2PR11MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: 089a23fe-a9db-467d-f542-08df2b6da066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261009223027099003|56012099006|11063799006|5023799004|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: bmIroVLsRhMDgG4xMRBSbTMXILXDf5/c6bLRmJagluBc9jZ/A6F5yxIZbNiB5V8F7jMPIgsfAcks0YkohT8HZ2zDdIb5dvm+M7OEwwcEDVdU3DnTHlDFZuqxy8bljZZAcukHBA/JvNYvshZzNTIRkyynvLbdn/84XhS0VZbsZVh37u71X0BOEJ0vSHUXiJYCgHMdFAOBQI3r/NP43Lhf7BcuNCgriH/UuD9R2BJIjjbVsew+x76FHX9LiZ1zJPnwFiHnQ4gGro5bLqUGrzHG5thpOophmzx1xkNt+cuZWmdoWUwf5yEEK1SaSllYwAPjDlAC/wbaYkgtKb2AzKHatf1T1yThw3urID21O3sLy5BRSnE3Wsox63jv92d8iduHlwDNjVktrXT4WfbKy223AM2AESpPzqVhIO+/XuGfM+e8h7R48x9hvjV/wT2ipMHedPTckrkOpyOYzYLE1nj65ShBoH7Qsogy4pQTkDqoaLkrEer57OviWKkAnST+0wAfp8Tegs6i5Q+pPCM5YjxoDnurEQJ8EWUL2mGiOCegD7snpA04gSzQMjIqMiItfM3O/DuP4zfKaS0TWTZzGihxekbUs2hhwCavPA28Mwhlsl8fd5GVun34gngUAAjZ9rym/jUWRdcrKm4uVQbTR3lOcH4Hh0xj7VDQxBn+OVipi/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8208.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261009223027099003)(56012099006)(11063799006)(5023799004)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG52bG83Z09DOFRCc2RXS0FtQVliVXpPZEo3N3g1Z1BZSjZUQURONFJKcW90?=
 =?utf-8?B?SEpUQ203TWI5bEs1OWtBY1pGUllncGtuYVJBQUNDTjN1RXRpY0toQUF0ZFhz?=
 =?utf-8?B?MWxaZWNCVHFRNjM3VmZlUWgxc29samxMUHpvSlF4Z3VrUDBpS0F3TWphZzZN?=
 =?utf-8?B?VTN2a0R5d2tKbnJwdFRpNGtDRnJGN0p2djF2OE5Ia1NMYkJIb2txbEdiWUJU?=
 =?utf-8?B?S1dXQkdqclpiR0xWdThiRWpTazkzRHNCR0RKU2FLVzhCT3FnT3hPc3FZOVhE?=
 =?utf-8?B?ZlQwZ3JxZEw3eFRCbS96QnFBTGdXVHRldFZPVmpYTjlpN2E4cVNSOVhHcm1J?=
 =?utf-8?B?bm0zOEdHUmU1M0d1NzQrT2VDbzBGRkdLT0pPUElFUXNnSzY1ZGpWSGFHczFu?=
 =?utf-8?B?dmx4aEhnRCtlTEM3Mld2a2psM0FlaEpwTFJNZHZ1SHlmOGNsOHVkU2UzMkx3?=
 =?utf-8?B?SFpQdFdQY094TU92ZWFuMVhSUUx0NEM0eHJpa1dRaVpQdERYZitGVUZ1NDlt?=
 =?utf-8?B?R1RDTlZNSHpqY0FSRVB2WTNwYnh5NFdyQUlNRGlqSUpIUDhsQVhXWGpOeGdM?=
 =?utf-8?B?Q2drQ2JPSWlQSWdzZlZWejVxQ1JyTEN5a2FTN05GMms4Z2M3dlpVZnIrcHRE?=
 =?utf-8?B?KzFsM1I0UThlVUJ5V0dYQkpRbFNwNy9NT203cGdNQUdTcUZkR3NKOXhOalUw?=
 =?utf-8?B?Q1gyYmI1Qm5PSDE5T2tsVWNxNHYvY2RPNVI4S044dTBuQVh6RHVtYm5CYlJZ?=
 =?utf-8?B?NWlhdVlWTTVFU1c3TlBxdUptUEFDVEw3Z1ozb2pGVVJNaVZrVWRkeTZjYkk0?=
 =?utf-8?B?ZVEzRmtHZFJLQUxXSkdEQWUyRkhGVDVpSE83UEFhd2RYZXNUaTlwd2lKMWsz?=
 =?utf-8?B?QnVLV3JmN1p5eXVBQ2EzcnE5YTZnTnA1WHFwY0oydTErcnpKN29TTm0zemt5?=
 =?utf-8?B?VEZxMndjSFlMSWw1UTBnbzFLd0w0c0IxRGk4bnBBcjhyOGxack5GQUtJUmNt?=
 =?utf-8?B?MXI2c0s4OTZGbzk2VmE0TS9jcStyUkdQZEJrQ3FXVUNzZUx2VGQwNGNwcklq?=
 =?utf-8?B?c29TZGU5UCt3MjNPQUQ2VE1sU3dOVlJsdnIrcFo1ZTMvV01mSE9Wcm5TUUIx?=
 =?utf-8?B?N2NGb1l4TXQ2UnZ5c2RBVXdwbjJoWDlsM0VWcGVIMytKdjlORVJuV2xhOUZQ?=
 =?utf-8?B?bDZxOW1Kb1Y4aHcwQ1c4QzhncmFlU0tZSkNaS0QvN3hKaXBzaW1qWTJtaElw?=
 =?utf-8?B?VHZKLzJRcWVyOUNkNGtBUjMzNXcrd0JCVjUwZFdKTEdYY1hSckFTYU8ydDVl?=
 =?utf-8?B?U2FRYTlFdEhMZWZReU9xL2xuNFpwNU9VSFIzamJjY0ZyNFZRa2JYNHZOb3hT?=
 =?utf-8?B?SEtNUjUvcndZc2x1Y0U2QXdmRitpTUF2Ym1tZndKSHI4V0tDQ3Z2aE1MMlNw?=
 =?utf-8?B?clB3aUJwMlJ1bTlwRDBBM3BGV003VWVJOFpjSDViY0FyOFNQNElhRHNVRFBK?=
 =?utf-8?B?Qk94dTJaWXp1R3AvUzBkMkZsL0tmNXJuRzYvZ083WDJ2bVpnckQrK0lwZS9M?=
 =?utf-8?B?Nm9ISnZIelR4QVdyQXNmUTZNREFtb1J0UWtLSmlhL28zaGx0M3NoeU5YYmdR?=
 =?utf-8?B?N0tUSDM4V1RNbkh6SnVuUDFFcTArN2lhMktXd1lmZkVIOC9RZTI1VnFFRjZT?=
 =?utf-8?B?UUNYWkx1Z3BqdUgvKzdHUi8xendnSWxCcTJuWTdCU2VXb2VRWEJtMUdJZFVV?=
 =?utf-8?B?UiswSFh5TDVhZEFmMWNtYkhCSG0yYzV3eU5vcm11WHRtQmwwNm05ZCtXWkhr?=
 =?utf-8?B?cWRFM3dZQU9vclVQUGFZejV6aEliWlR2NVN5RUpKbVkydWNRcStRSWNERjFy?=
 =?utf-8?B?TE1DT0xKQXRXQjd1VXFPZmFUallqY3pwdkg1K2Y2TUtEc2l0S1RVUHgyMjk5?=
 =?utf-8?B?Q2dZdDFFWlh0MWRsUDF4QlNjdXlTa1I2dGFmR0FnbjZWRS9rYTFhN0gyVHJM?=
 =?utf-8?B?Si9RZ05VdzluS1BXQ29DaVNTbkNqTC83Ykl1dWZVNmJpclB6YVdwUFdFSVhz?=
 =?utf-8?B?YUdMdnVmanNvNWJtSDBjT0dTNnhYYkQ1Z1JEUGpNSmJiYVpPb0lPaXJ1VmUr?=
 =?utf-8?B?Q3lNcW9QTEc3Z05Ia3g2WHEzRVhMbVhSdFFDNkhVckJaT3pXVDZFdmhMSlBH?=
 =?utf-8?B?cmpkN3F3S3A5TEQ4SEI4Uzh5MUFPVlpUOStEaTErYUsvSG90VjhqMmpYREtP?=
 =?utf-8?B?L3FvYzJMU1lJTVNUNkZhY1VxT2JlRmhDTklQUnN5VkJkZThJNWhTUTVWK2ZR?=
 =?utf-8?B?TGhidEJvMXg1L010WlUzVFpLcytrem5MMCtyc01QZGF6WXY1bjB6bHpJOEQ3?=
 =?utf-8?Q?2n13xCCHbYFAlCZ0=3D?=
X-Exchange-RoutingPolicyChecked: ygMBTNBHmatOs928MrVDrHxeZcBsy1yZSIUiGrMDtOsISBln+LvMy05ZT93/uBOUECio2FnFaQs/AvdSz4WAouBgiNA91qdC5ZN7yqGKmUt8NINh2dUZrntR6jIhFR8yrgMUyC4LLBlXSNGvoys3GHtAczN+T6gZVs60aJA9prBMQH4/h+io4YHtVJsSNDqJtkkiyztTXsw3jSjjkHPza6YYdHlYY9ydiGU4ALruJHMMZnstah+3KWkLAqRuZBZNP2bHaWohXavVMJ0IzQoedlFBNEY7IHjEoLauuyxQh1fRnXNU00i28jJjF5w4yOVXUrSmfxYqqCpgztemHf6LhA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 089a23fe-a9db-467d-f542-08df2b6da066
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8208.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 10:09:55.4330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0XK8aWWIkeV4ApN0Cl8qwGjJcbkdhYS5SD2g2PAXckJgvRySvHcLwDbx160jGqTEyIN0pX8ZPfeljKIfJphtuh+5Xs4PixEnEgxkYL+neo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8469
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


On 13-10-2026 10:18, Arunpravin Paneer Selvam wrote:
>
>
> On 10/12/2026 4:40 PM, Sanjay Yadav wrote:
>> __alloc_range_bias() walks the buddy tree depth-first, higher address
>> first, and descends every SPLIT block even when nothing below it is
>> free. Range allocations are placed top-down, so they pack below the
>> range end and each new one walks every block already allocated there:
>> O(N) per allocation and O(N^2) for N allocations, under the allocator
>> lock.
>>
>> Track in each block the largest order of any FREE block in its subtree
>> (GPU_BUDDY_NO_FREE_ORDER if none), update it whenever a block changes
>> state, and skip subtrees that cannot satisfy the requested order.
>> gpu_buddy_block_trim() detaches the block while re-allocating inside
>> it, so recompute from the parent once it is reattached.
>>
>> Skipped subtrees contain no FREE block of the requested order or
>> larger, so the old walk could neither split nor return anything there.
>> The remaining blocks are visited in the same order, so the selected
>> block and placement are unchanged.
>>
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
>> Cc: Joel Fernandes <joelagnelf@nvidia.com>
>> Assisted-by: LLM
>> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
>> ---
>>   drivers/gpu/buddy.c       | 31 +++++++++++++++++++++++++++++++
>>   include/linux/gpu_buddy.h |  7 +++++++
>>   2 files changed, 38 insertions(+)
>>
>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>> index 2f2aaadafe35..7a975873238f 100644
>> --- a/drivers/gpu/buddy.c
>> +++ b/drivers/gpu/buddy.c
>> @@ -602,6 +602,7 @@ static struct gpu_buddy_block 
>> *gpu_block_alloc(struct gpu_buddy *mm,
>>       block->header = offset;
>>       block->header |= order;
>>       block->parent = parent;
>> +    block->subtree_max_free_order = GPU_BUDDY_NO_FREE_ORDER;
>>         RB_CLEAR_NODE(&block->rb);
>>   @@ -717,6 +718,27 @@ static void rbtree_remove(struct gpu_buddy *mm,
>>       RB_CLEAR_NODE(&block->rb);
>>   }
>>   +static void update_subtree_max_free_order(struct gpu_buddy_block 
>> *block)
>> +{
>> +    while (block) {
>> +        s8 max_free;
>> +
>> +        if (gpu_buddy_block_is_free(block))
>> +            max_free = gpu_buddy_block_order(block);
>> +        else if (gpu_buddy_block_is_split(block))
>> +            max_free = max(block->left->subtree_max_free_order,
>> + block->right->subtree_max_free_order);
>> +        else
>> +            max_free = GPU_BUDDY_NO_FREE_ORDER;
>> +
>> +        if (block->subtree_max_free_order == max_free)
>> +            break;
>> +
>> +        block->subtree_max_free_order = max_free;
>> +        block = block->parent;
>> +    }
>> +}
>> +
>>   static void mark_allocated(struct gpu_buddy *mm,
>>                  struct gpu_buddy_block *block)
>>   {
>> @@ -729,6 +751,7 @@ static void mark_allocated(struct gpu_buddy *mm,
>>       mm->used_scoreboard[gpu_buddy_block_order(block)]++;
>>         rbtree_remove(mm, block);
>> +    update_subtree_max_free_order(block);
>>   }
>>     static void __mark_free(struct gpu_buddy *mm,
>> @@ -750,6 +773,7 @@ static void __mark_free(struct gpu_buddy *mm,
>>       mm->free_scoreboard[gpu_buddy_block_order(block)]++;
>>         rbtree_insert(mm, block);
>> +    update_subtree_max_free_order(block);
>>   }
>>     static void mark_free(struct gpu_buddy *mm,
>> @@ -772,6 +796,7 @@ static void mark_split(struct gpu_buddy *mm,
>>       mm->free_scoreboard[gpu_buddy_block_order(block)]--;
>>         rbtree_remove(mm, block);
>> +    update_subtree_max_free_order(block);
>>   }
> Just wondering if touching mark_free(), mark_allocated(), mark_split() 
> which are hot-path functions, could have any performance implications.?
>
> Regards,
> Arun.
Hi Arun,

Yes, I measured the impact because these are hot-path functions.

update_subtree_max_free_order() stops at the first ancestor whose value 
remains unchanged. Across the tested workloads,
it walked approximately three levels on average, and around 88% of calls 
stopped within four levels. Reaching the root was rare.

Cost on the normal (non-range) path. Existing gpu_buddy KUnit 
performance tests, drm-tip vs drm-tip + patch:

Test                                            drm-tip        + patch
Fragmented allocation                            139ms       154ms
Reverse-ordered free                            91ms        96ms
Contiguous alloc after fragmentation            8ms            8ms
Repeated 256 KiB allocs from fragmented pool    14ms        14ms

For platform approximately 12 GiB VRAM and a 4 GiB BAR: xe_pat 
pt-caching-random-offsets, per window of 16k allocations.

Metric                                        Without Patch With Patch
Average range-allocation time                78-793µs         340-494ns
Blocks visited per allocation                16K-147K        38-39
xe_pat pt-caching-random-offsets runtime    ~48s            ~0.7s

Yes normal-path cost is increased very small and bounded, while the 
patch removes the quadratic slowdown from range-restricted allocations.

>>     static inline bool overlaps(u64 s1, u64 e1, u64 s2, u64 e2)
>> @@ -869,6 +894,8 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 
>> size, u64 chunk_size)
>>         size = round_down(size, chunk_size);
>>   +    BUILD_BUG_ON(GPU_BUDDY_MAX_ORDER > S8_MAX);
>> +
>>       mm->size = size;
>>       mm->avail = size;
>>       mm->chunk_size = chunk_size;
>> @@ -1280,6 +1307,9 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>           if (gpu_buddy_block_order(block) < order)
>>               continue;
>>   +        if (block->subtree_max_free_order < (int)order)
>> +            continue;
>> +
>>           block_start = gpu_buddy_block_offset(block);
>>           block_end = block_start + gpu_buddy_block_size(mm, block) - 1;
>>   @@ -1881,6 +1911,7 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>>       }
>>         block->parent = parent;
>> +    update_subtree_max_free_order(parent);
>>       return err;
>>   }
>>   EXPORT_SYMBOL(gpu_buddy_block_trim);
>> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
>> index ddc4eca84175..8037f5a0feb1 100644
>> --- a/include/linux/gpu_buddy.h
>> +++ b/include/linux/gpu_buddy.h
>> @@ -141,8 +141,15 @@ struct gpu_buddy_block {
>>       unsigned int subtree_max_alignment;
>>       struct list_head tmp_link;
>>       bool has_clear;
>> +    /*
>> +     * Largest order of any FREE block in this block's buddy 
>> subtree, or
>> +     * GPU_BUDDY_NO_FREE_ORDER if none. Protected by the driver lock.
>> +     */
>> +    s8 subtree_max_free_order;
>>   };
>>   +#define GPU_BUDDY_NO_FREE_ORDER (-1)
>> +
>>   /* Order-zero must be at least SZ_4K */
>>   #define GPU_BUDDY_MAX_ORDER (63 - 12)
>
