Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F37606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rtHm4f2w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF2EA112A13;
	Fri, 30 Oct 2026 21:30:30 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013058.outbound.protection.outlook.com
 [40.93.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2F6B1129F1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:30:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkLaQ+qSIDw4FDxYpO117L9vjU3Ij720Hlk2RJ0Jw6S5pJoz6Wz3AwNuzfpg6P+aLLV6l5Vm4/QClOliiZ5AfXk8zWU0u5m7MncHrBhAfBRa7Bhha/k6aa7D41+klRhq0dNPvXR5ASDt/oCotdaTDVIs2sdzXdPNhi2pTZf4kvz9MaLWluPmx89/1PGNOk5GRVFU4PHC/Z6+1bGOtPi6I5uFHzIZgrRX4yWF2bNGqcO0ja8IF0R/autw8NgDv1O6TVc6G24zSoiZOlBuNDBxAXckkKnG86e0zmK/rSKkBoalzCT7O8gKxUFmVS0w69TLfqmg1K6WLsFN3zelxuOsWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8+aUOVxlh9GXagbeLLgePS+5LPMSHtSH+lQlpBM9Pw=;
 b=r8QsgEXp3b9SfYI3Frn7HX3BK+OxXgAOtR2BgxY8qhDX0bXGXtHu8FLpWxM+/McJw+hpt71CEkCe1DPrQcGiNBvsQ60+ekhVgbpE7N4UGNzYa07UbJPWoWyd/DC37mnE0e8W7j+l6qAalkW4CBJ92r4nylGmwQEPr/c/9QldStX0U1b8bB6ZuWbgtYI4zU1U+SAL1uBzlneTkhBQ8j5Xgg0T6ZbOK2pOB1EkunwB1JPBfVayO618LOxGoresL90EdVNFNRMHX5OHfYKnF/+p6lvrgS4+HlSiaBHb0m8tH/MhM4kdAJA8lE/cKWvwDxS+Mze7KYTwoI/7fvGymHs8aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8+aUOVxlh9GXagbeLLgePS+5LPMSHtSH+lQlpBM9Pw=;
 b=rtHm4f2wXfgsff4Pvet85DoDNF+Gk2Czlt6749y2aNHLXJmrzccyHzmhp1ToYeKuShP/Z38cNeWMl210TgZbBoNjMyHHvsPXdO9JUzD6t2CoRnNCCCyKkG4ZMifPlFnPJy/vahz0PhUeQFuN63+9PBXFGTek9wFdNnUsAhr8UGUMztaXnSZvD33pt/CPozTabMxudKz7maKDUjZjIwXPey09Cppr5AMr+C1LHw3P8uHzhFCuTUlcyQBKxxp7Nr7A/o0jl+labITBT7rbp9mvesevKiXE1Dv1qBjPc/onfeGmxsWX8y52MUSyF1UD2JGLjUH5DXijHS+V2YBqqfEANA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 21:30:14 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 21:30:14 +0000
Message-ID: <26dee420-ed28-47e1-808a-531bdfbb03ef@nvidia.com>
Date: Fri, 30 Oct 2026 14:30:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: nova-core: make pramin/buddy optional
To: Alexandre Courbot <acourbot@nvidia.com>,
 Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Cc: airlied@redhat.com, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org
References: <20261026-nova-pramin-option-v1-1-d073b3f047fc@redhat.com>
 <DMHV8ZWTAEVB.YC2XG5BHNBN4@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DMHV8ZWTAEVB.YC2XG5BHNBN4@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:a03:255::26) To SA1PR12MB5614.namprd12.prod.outlook.com
 (2603:10b6:806:228::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e7edce-ef5d-43b6-666e-08df36ccfc11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|11063799006|4143699003|56012099006|261026140227099003|261022105027099003|261028144727099003|261021121427099003|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: sB39gi4OsBjAuPuAr98HDyCvaY3HjQbzCmx6bnmDv/8KgCPWhE4Oc7d998d/vQrMRczLO0yGKj7Ur1fTvM9oZ4MRvoVfzO5ikDQHMHj+PL+x4b0nFIVmM2Wjbc+de1+fsODFz0XpkB3/4HTFSe0nHx2bBgkd1BOsVIckday4rDgEr1T6YbEPv3CuFMD88SAnG9CqzvlfK9rvu5vo8iq1pPxIVhl2sRA3iG8dFruNVKcl3kmfV3RBWW8g0PlaDYE+ATLXGF+W4BELHKC6yxlLSmHRrfja1N6P4GPwoGZnhW8mLUc6vGhutBT+lNOWN0zHo8I1bTZCdzX8N4T13pojdEr9/gyhA5Hyf/mcRf+fQzEIdO05oRY2gWRemCbhupBjjuoIFTihHeYWUwvciAV/TTwrpYTQq5dta1o0sDGeUeeGznLxY2Y/aO/Itzmwz9YpHrQfRXsINbn8r5Vcven1ztJt0GP+NaZvfOfUQEaxTsaqumLbQcfYHHvp36MniI1X2xG5ALP2W9XNjcnDHlmi2dkcHi+Ft3NS8nYwq/aRXoh5xNh+T8EEBb2s/RLqGFTChwij9mqaQlhn9ABjBSRikS9nsFk9tujWNZ70K/NVWwLgICSsbrjHilDZVTljNWRPRU6CR94qO5Ki/0gBQ4VCnIP8eHOGMhH76Cnc2Nawfvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB5614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(261026140227099003)(261022105027099003)(261028144727099003)(261021121427099003)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG9lR3RQeTFIcndlc2lpVWE4emxmdWJOVjMyZERyWVdlSkQxYUcwaXlwVHVF?=
 =?utf-8?B?R1NDQmNKbjZGMjBBcERtdWxNc2dDNWdtdm1ZNE1LNlJ4anhyL2JDWldYeExp?=
 =?utf-8?B?cVVpOEVsdTNrSFhvakNGOGNCeGh3WHRsek9jVnVJWUhUcEdIdmVJWmlhZXY3?=
 =?utf-8?B?QkdlejNNeXlQNE0xWmZGSW45WCt4RHJKckg2b1FlREhZclRvc0RBWndqU01W?=
 =?utf-8?B?eDk1b2VlaU5WVjBYK29CRkw2ZE1LQ0pEbE9Ca25rRnduOGoyT0VYS3lvS3Rl?=
 =?utf-8?B?blhsaXBHVWZQMXlkelBTcXZMSUI1N1hERlpkN21kUUQ2dFY1SVNhLzZiK2hm?=
 =?utf-8?B?RGZRZDMwbWlvVit1UW9lOGhIVE1CYTlQd0NsNGhVd1hSWEJFWml4UzJDOFNu?=
 =?utf-8?B?TFU5cDltOUJDMldhVjdYS0E2TWJmVi9TYnZ2ZDYvZTl5bmVnU0FDWnQ2V01s?=
 =?utf-8?B?TzV3ZlJsc1hBdHFDZzNwTHVPY1RYOFdMdEExbU1XTHhKekR2L2lUV2xmSU9h?=
 =?utf-8?B?QUE5dmhOTFB3UWorMjNjUFM5a0ZOSEpOT21FaUcyRXJSZlJUOVlrT1BXQzZD?=
 =?utf-8?B?ZFpmNlV5QnhzMWkrWkJhbVgrcWFUY1pFUnVPRmNuUnZxOGQ4STJzak1zQ0cv?=
 =?utf-8?B?K242NTFwQ3NIR0VwZG5Ya0hRNE5vNlJhLzgzSmFlM25EZzNMbDVzSnVjTXFw?=
 =?utf-8?B?U29KekM0NmE2RTZiQmg3TDhJZnR3YUVlZUFNV1pXbk1YdUExa1lBaUppaEJX?=
 =?utf-8?B?NTd0VzBiTklxZGZRVDl0S3I2R01TWCtZc1RGM2lvcGNGNjZ2MjROUDE5Q3Zs?=
 =?utf-8?B?cGZSUUpnL1JMb2NUM2VkSkFMZjk0M3ExelBDSkkreC9tNm1WclFCU3o3enNl?=
 =?utf-8?B?NmhmUkVpUXB6SklEOHBOcUpVTkdudWQ5ZGlSaURibU05TjhsekU1TU5MZGtS?=
 =?utf-8?B?bjJTelNqSmo2aWRtMXpvZnBoS1AyeVFTVm5UektCODhwUVBPREh0S3R0Nmt0?=
 =?utf-8?B?SXRMSEJoRHFvUkUwTkVJUnhoNXV2ZTNoWWw2bXE4c0tTaG5ybGhlSWxkSFVY?=
 =?utf-8?B?MmVFYXFmeXp2V0xLejZCUTdHcnQ0dlFRL0FzRUdDU3VQUlJLbGtpR0F6d1h5?=
 =?utf-8?B?Witvd2tPbTQ2KzlDR1VKc2lsN25nOXBLWG9LVEdadW94M2JlbkxkQ0VhWStp?=
 =?utf-8?B?QXZVbTkybndJaXBORTlEaWxBaGtFNUJNZkFkYzd5TjhkaFpZRWx6c0FGRmtn?=
 =?utf-8?B?dmtheGVWeTlpTWo5aWdOOHdzMGpqWkxid2VMeWtyZFVBTTJtVmxyb1k5Z052?=
 =?utf-8?B?cVNYVzJYTEplQ3J4UDZGRWsxMkJXMTZwVzJPbys3VEU2OU1qWDdBTzVneE5s?=
 =?utf-8?B?QTF5bDl1NXRTMTJyaGttWWxBVGdEWHJyQmpYWlU0eVE4QmhEdERhY0NTbXFV?=
 =?utf-8?B?bVdQemEwUnBjMlcxZTcyMDJIaDBSaXV3RWlFcVVRc1ZTMWZmVlRpa3B4TXF4?=
 =?utf-8?B?c0htTkx1N0ZyYXJ5L3lzaFZhc1BLYTduN0MrRHphVlJQM3FjbTVLOSsydjJJ?=
 =?utf-8?B?RXhobC9BYTRSMjFhOFJzeWsrRysrRHNmOXdsb3dScnNERVFkamRFMHZ6SXFD?=
 =?utf-8?B?RGZHaTZDSDZFaHUvZm5HdUJCYUZrM3RlQUJzUDBSZ1VvVnNNTXRKTUJ3amFa?=
 =?utf-8?B?bDM4cTMvRHJ6Zmw0ZmJNNnY3dzUrN1pOQmd5aUlhQzgvQnI4anQvWWVmSXVj?=
 =?utf-8?B?MzhQZjVGUDBuYml1Yi9icGM3bTBOaE5Fd0VRaldoYisveVFEeXBwMlNYQ2dG?=
 =?utf-8?B?VTkwOEhvR0dyb1hJeHZ6U1AxeGRHSFM4VUUydlhRNkJZN04wL1dESVR4ZElL?=
 =?utf-8?B?WERDUHlRZHpncVloanIvWk9ya2syY2RtcWtRUEIwZG9jdnhMT2JTRzVLS1lE?=
 =?utf-8?B?empydGFXeTFSZjR4bXR4b0tQdTZrRDNEVlNwNmEvbWlrZEJURlVTRldzOVBB?=
 =?utf-8?B?ZWhvTFNUd3pGWi9kamYwMVN3YndNaDB0QzIxdkt1YkQzZmpaRWJTYllpNEIz?=
 =?utf-8?B?RjUyR09tOXBYS1ZvdHFLQzVYeTVuSjc4WHdBOU9xZGJBMnlYR1ZBSXNzNTdm?=
 =?utf-8?B?L2FKWUtnQWI0YVRFWnQ1RWFReXpBRzFucnU3VzRoQlN2b1JrK3dtK2xmZTZX?=
 =?utf-8?B?RnFHUTNOS1kwaVFlNWdEV0dUTVVweHJuc2p2S0J1dlB5YisrYTJId2N2RzRM?=
 =?utf-8?B?clVDVm9mK1MrR21yTCt4QUJQNnhRRFFIcEdtdVd0TFJQUUJwQVhYWWRLTG5C?=
 =?utf-8?B?VXJ0K3JZci9YZmF0dTlMOG9ZN0hzMUp3emNDS0dsa1J2UnU4anJ5dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e7edce-ef5d-43b6-666e-08df36ccfc11
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 21:30:14.1750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oM9YcDuJ0u7m6tTH73Huxi0sD777EvIkemRcSCfQmydeX/3eWu4PD5y0D45SLzpJLyMqIER3fW9cFRQ1tUjX6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 8:51 PM, Alexandre Courbot wrote:
> On Mon Oct 26, 2026 at 1:24 PM JST, Dave Airlie via B4 Relay wrote:
>> From: Dave Airlie <airlied@redhat.com>
...
>>  pub(crate) struct GpuMm<'gpu> {
>> -    buddy: GpuBuddy,
>> -    pramin: pramin::Pramin<'gpu>,
>> +    buddy: Option<GpuBuddy>,
>> +    pramin: Option<pramin::Pramin<'gpu>>,
>>      tlb: Pin<KBox<Tlb<'gpu>>>,
>>  }
>>  
>> @@ -85,28 +85,28 @@ impl<'gpu> GpuMm<'gpu> {
>>      pub(crate) fn new(
>>          bar: Bar0<'gpu>,
>>          chipset: Chipset,
>> -        buddy_params: GpuBuddyParams,
>> -        total_fb_end: VramAddress,
>> +        buddy_params: Option<GpuBuddyParams>,
>> +        total_fb_end: Option<VramAddress>,
> 
> This is related to the comment made by Sashiko, but in which cases are
> we expecting `total_fb_end` to be `None` here? Is this the same set of
> systems for which `buddy_params` will be `None`? If so both arguments
> should be merged into a new type to remove the ability to represent
> invalid state where one is `Some` and the other is `None`.

Neither, because the decision has to happen before GSP boot: on a
zero-FB chip the kernel-side RM sends GSP-RM a system-memory heap in the
boot arguments. The static info comes back after that.

Open RM makes it a per-chip HAL constant. See "bGpuArchIsZeroFb".


thanks,
-- 
John Hubbard

