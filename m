Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C00AF364D1
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 22:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D00AB10E04A;
	Thu,  9 Apr 2026 22:57:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="rjC961Kl";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011050.outbound.protection.outlook.com [52.101.57.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC61B10E04A
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 22:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qn6Z3SXX8ZugEmzGE5bl2d/YUcAYK0oP2HWpdVJlL7sE36nALqW5iCiJdoOZwAuT6+4OIaQG2uiyLLewCJQsUG+6n2HkwTD6qdK6P9elz7h3kwCg5fEPDBbhFZMuz2gmbQ+ZhEKvDMUOVBvBYOwbtJ+KmwqjLcFEfPuBAdFR7tQwK/los2a0Noh0Y1xHi+cckc5ND3z9evaNWjZVdoL9WDntvQpdfnBFPrNKpycUd8NWLyhTSN6xkRJ9KeymbLEFd9Pr7y3QZ4ncTCZimEdcS4NlF61CZXGtbY+3ANBLmL44PnN4grnRB2Y/5njOSyDfgdxRAcPSTyJkJJptplOH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMP3RJn9BzMJhwQvyyIF4VPZD11Hs6WRnR3AJlM8JEs=;
 b=T5ih2EUPVplQDoNUPTq2KRnKRyxKS33mI2Ivl8TsKJhHpRsj1oqAdJjiY/qAQQIMb2w6mN3r3nxvUdaGsWZP5wORdFQ3s8wfyB6DQ/DPC5dIK/r8iWBUr4xi1dyqMvwSwfZIWO8U3UHuscxcMHLQyzC70Ct6Q1/Vcnl0bzbtZE2wInw3kJCvbAwLBLb3zaopeOV0FJ4sZjdLilamZlA4Hcx68cs+dj1FROyAN32VjEZqkghTU5n+iDiN5KKLyneDBCZkuqBxos6mebIPXIbA8VA4X4jR/aojt5F7qqhMgws4SZ93REAmKvTVaG/RP7Q2NpqHHbx+7+ExDrDiMtRzvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMP3RJn9BzMJhwQvyyIF4VPZD11Hs6WRnR3AJlM8JEs=;
 b=rjC961KlMGytMQaK8nrmgUPBZXzmwTWwzRaWvhWCAqS84eiyZuQ5McdJR5HkeDD/kHnGSg8Hjwpo0+44QRjY88j3cl07TzS8StSvup4Gkuc67Z0Tu096OwQ2mU9Q6WmlSGdaUimb7VpmRC94mERxHfxcMWqOTBQwtbJvsA7wNKyHMEgQeM7GbjYaJdaHl//dl/TAdDgWHDcqR4GC9cm7H3Jb0oI36Xg+JsALXdTZqRpDAT8ushXhw1eiUL9U2Yg4aocfhHkKlL6UC6N6rTuQ3JLC1pNG4wF2A585f/xTE/gjzedoPNPEhBU5cpvJUuG7200T/N3Vi0iR44X2M8y3nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.34; Thu, 9 Apr 2026 22:56:58 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9769.020; Thu, 9 Apr 2026
 22:56:57 +0000
Message-ID: <91732d1a-da56-4ea8-9012-b86a34b1ad0c@nvidia.com>
Date: Thu, 9 Apr 2026 15:56:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: nova-core: fb: make sure to unregister SysmemFlush
 on boot failure
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260409-fix-systemflush-v1-1-a1d6c968f17c@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260409-fix-systemflush-v1-1-a1d6c968f17c@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0122.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::7) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|DM4PR12MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eba2e25-d706-469c-c860-08de968b4d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: nhRgiuehnI6f643tFHB1jbaicJO1Z9ntX6Mn8Tn6DCAh5I1Yuh0q27euv6imqVynEv1o3G+uVsGKtC5YtCmymurEtQpO+OLhogzTj0Z6fhRmnEJg5fzYr4gVWOXatuzp/ad5h5W3Q7IvxAIyx5H/mVkuzQ0SFWpzuls1y91RST+OaaAl7umqm4MFc7bvrLhTsCmqP2RJeJjUWafe5msUa4MDAPiBUztj/97uJadBIPy6iadq882q+QuRdtbukQB2YDIYA/QpBdjkHlOvdh1otEfD724+6gyjNMjx2Dv3ypQQiAeKqknH26oXYQbh3LJMLMF5+brFIh/ysTPtDfVK6Y226ByQALSLLO2kifdRyzPQKHSa2SMaPUgL3DQojH3JHGPeGXDraJgaChLHapzY3eP8Zj30VD5SLrL+00qyicnnokpHkEbJdvYBhBulu9elKDbPh9JHIp0MpUo1EpBQT3OHkd8dDm0BBKoMZ26vWwVkhxifQaX4i+/xdsGqU+nHd3hHoNCuDdriO6K5Y6Sf3nS3u7S14VWcEIddTy5YJC55Ngc11UEts1achkrf9iqzxcliqPwg351vrq+klzREaS3Lq8EOcX3WcpQvi6/fTjxL5SgfSEg7wq0aZwj8zoFk4xbBdiVsD1yGbc6QRdP+lP8CkDxpWMhhLQdmAX9D388nC8ehro5ILqhl54EhXVpFivclZ8Iwu9EkJjPmAKUrBIfzgUoploPxxUjifv59O10=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3NQL2dxZ1NnUGdFUDVGNHNtOUJqVW9aSnZQWkEzM3pMcy9jNzE5WDQyWFdk?=
 =?utf-8?B?N2wxWUdjMmhmeThVajY3aERLbFZJV1I1MCtEalFjSlpiaC9teTR4ZDVZaXg5?=
 =?utf-8?B?NXIyZFUvSEc3ZmV3NXZXVEk0MjVzVEJlcEgvbnFBUk93OXBkS1FSL3R4cXQ1?=
 =?utf-8?B?UWUweXdUVWdqVmZHMm1PajdmeDRheklhLzRkRjU5bm9neWt6QnFuakdWdTdK?=
 =?utf-8?B?OVVMVnU2TExoa0RWVW9OcldQdUJoRitKekV6QjZXZXNZNTFuYkJxcC9OYTlU?=
 =?utf-8?B?VEF1RkwvckVyVkN0bDl2L0RWd1FEOTg0TDdOZXhLZ2gzTzVOK3FDK2VpMjhB?=
 =?utf-8?B?ekdHcDd0WFBNOUFkeHA0TjNqVHlJQU9EM0lENHNWekQ5bjlTcWk3ZmRDTm5E?=
 =?utf-8?B?aU1XcHRCZlNvb3REK2VRY2ZOZWUyaUgvN0lHMFZHeWx3YmhJOEF4bVRFR293?=
 =?utf-8?B?cFJCblp4VTlqalRhNngvbW1pWWY4K3BSMHJZTFdGbUFrRGpUYWd4M0gzVHp4?=
 =?utf-8?B?MWNCdFE3bm1FcUNadVpyTDRoY1QvNndaeU5QTkRCaGtlMzNrb29KZ2hnYkQ3?=
 =?utf-8?B?MS9xODdqTldYRHpaR0RGQWFuSkdjVnpQMDlZUmlIbGdoNVFrcjB3akZwaTh5?=
 =?utf-8?B?M05zN2djVjhLTFRIVC9ZbGlKc0VURDdHRjlWbTVMOWs0SUdmTWdxd3NESDNj?=
 =?utf-8?B?NmhLU0ZuVFpRWjZiU2s3WWEvOElIdFlFZnpscjMybU1nOXUvVEpFeWtHOUtL?=
 =?utf-8?B?d3Nacnp3OXV4Y09KRWkzNVduN29VU1g5ZGxyT3hPdVlIb1psUlltZ002dnE2?=
 =?utf-8?B?RzRCck9UYndkb1IvVm1Rc1ppL3JRMHBLQVp4ZTArajhHa0xQYzA3cHBGTXBL?=
 =?utf-8?B?ZUJVU29BdGFPY2RSZFJIaVJ3SndIVkYrbkIrTFpjbVRlYkRvK1BMWE8vZ3Ix?=
 =?utf-8?B?ZFd2Z3hEaXVUN090ZUpuUjF4WllONGFxNHVGUXU3eno2RyswRFV2Z0pSYmNB?=
 =?utf-8?B?REFPdXNRZVA3R2tNVnlVK3ZvZ3dTR0tlaVovNERLMjk5Z3pZZitEQWZoa2Nn?=
 =?utf-8?B?cVNuaE1IbkxIMC9Lb2VkL3h3ZTN3RzhTbm03U0tLdzNORFBYY01IWVB4Skd6?=
 =?utf-8?B?ZWxMVGtBODJHNWd3Nm03NUdXdmd6QjRXSE1EbDJzazJ3SVB1UnBtZHoyZWhx?=
 =?utf-8?B?Z3dFbUo3dk1NOFRZb0daaW1icEx6bTNNRllZQk91akswbERqbmt1K09UTlh6?=
 =?utf-8?B?d1NBY3dSYmNGQ3pQK05hbHB5SHBIMkhCQjY3bFkvMGdOR3JZakxyUFRtS3A2?=
 =?utf-8?B?UDloVTV1dG9xckZJTVNEVWVXQURzNzljL0lNUWNzS3c5cHlLaUthSElQYUVy?=
 =?utf-8?B?RSt6NnJUOGIzbkVyOUM4dlR5Qkt3RGVnK2xIQ3hoUERXdGxCQU9DbWtUK2NL?=
 =?utf-8?B?MmdNY0Z4Y0o5ZFFkOUVnM2VzOWIyN016K1Uya2dxMWhDaDRzcnhoTTZpWlpr?=
 =?utf-8?B?TVRqVnFGSHVpUkgvdG9HOHFFMEpZOHpTeGI0c1BRc0N6dWkrdUJzNXFCS3Bl?=
 =?utf-8?B?WHZ3cVg3V3p1Wk1ZaU5IbzZZQTAyOGc4RkMrSEhFSFdxSDJ6djlCU25qbUJN?=
 =?utf-8?B?cHpqaGd5U0F3OFdPb0VWWUkrSkl5TlhXcURTVVJTZFBheUFDMGNrelgxYUJ0?=
 =?utf-8?B?SHFDaTF6OGJDTmF2SmsrMG55SUJONE5rWm1Rc3RRNFFTUjJzbThjckhMNHFi?=
 =?utf-8?B?L2QxVVBDTi9HNFBNR0xJR0QxY0hoWVNjVCszUnZLckdzNkdEc2cyYmZ2S0dz?=
 =?utf-8?B?NnhLcXk4dlZJVjBUZWd4VUlNWCtWSDcyd1pxTCsrSWJBcXpWRHN2RW5pczhX?=
 =?utf-8?B?K3BudzBBUTlxTTNsOURkNHUyYTRXd3VCOG4rTE1EV0p6VDZZanhsdFBTdzhD?=
 =?utf-8?B?RzRXK0pFNmd5MzE1cFVHa2FhYmVuaDFQV3RPRzdvUGlyeHBxRG0vTlNrZUpF?=
 =?utf-8?B?RjRwWWtyTWtWM1A1clNjSmVrVGtLTlNLSXpjQkFLL2JXWnR5NzdGOXo1MlR5?=
 =?utf-8?B?bXpzaGxYUFpEcHBXQ09UUlUyeG0xQkVVM3E4VngybVdZbFhGZDFxZXhyb01i?=
 =?utf-8?B?R1lCQm1mYjNxM29jSS9PeHk4NklSOFNFdDkrUG5HTzZTODlobzNVSHF6SDVS?=
 =?utf-8?B?L25KRHRYNEgzZDFmajZBUEVwU3ArWTEzZzNTVFRtcXVDUWxybEFYK0FwdzRl?=
 =?utf-8?B?SU03Umo1d1hiNElBektDOG1jZ3FvZG5EVnM1c0ZvVzlZSlJwREdvTG4weGhE?=
 =?utf-8?B?bncvK3ByQVRRZVFTandoSWpKWTJ2OUJ0U0Y2L1EvWjZrR0dxUEVsUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eba2e25-d706-469c-c860-08de968b4d23
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 22:56:57.5076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzdprPj4jOvvkppeh0U6kvCVf6JFL6PiP8PmF8krYJwNMwE3jbT3bc96IqnavGZZdiT9uGb1YtcVxVyE5xE1NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6254
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

On 4/9/26 5:15 AM, Eliot Courtney wrote:
> Current `Gpu::new` will not unregister SysmemFlush if something fails
> after it is created, since it needs manual unregistering. Add a `Drop`
> implementation which will clean it up in that case. Maintain the manual
> unregister path because it can stay infallible, unlike the Drop path
> which depends on revocable access. In the case that `Gpu::new` fails the
> access is guaranteed to succeed, however.

Hi Eliot,

The code looks exactly correct to me. I just have some tiny commit
message suggestions:

1. The subject line could be tightened up slightly, to:

    gpu: nova-core: fb: unregister SysmemFlush on boot failure

2. And I'd like to rewrite the commit message body, to approximately this:

If Gpu::new fails after SysmemFlush::register succeeds, the registered
sysmem flush page is never unregistered because SysmemFlush has no Drop
impl and try_pin_init! only drops already-initialized fields on failure.

Add a Drop impl that unregisters through revocable BAR access, which
covers the init-failure path. The manual unregister in Gpu::unbind is
still needed because by the time Drop runs during normal teardown,
devres has already revoked the BAR.

With that,

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard

