Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D7D606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=L3njFh0u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8366F112481;
	Thu, 22 Oct 2026 10:01:07 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 401AF11247B;
 Thu, 22 Oct 2026 10:01:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0eo1/XmQ1qEkLiYuaHXP8zv46I6AumWnehLaU34rJ5TaluV4d2IKWVV2icEOkMnJLG+VDi+g6oiqevA6vm3OmFhocEYaJkhqOW1U4iEROG7wZVMlns/sL5/ye3vWtAXnYdyb+oIFTY+x48VBcFN4/ZXbgH43rTwIVyOZD59tfWC2JQ7zdSWkY8ufIe4yPzDPnAEBneKPkd23UPVhw9VEU9JHVKd7dfOCfGrVH/ZJHeImQ+iZcThrqJtEoxN5lkKDFC0bVC1ZF/GgdY3do2jGEsbMbmtwXziN+i6juJhWrTiB6O/krhHFEnOZhFlGFhhcNrxNUyEZWUttNjRI7gGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cq0UrPFtLjyTppEEM2816wces9yU28DXmtzGWBki+0=;
 b=ZQD1+TLmLGFO6otJEsm98Y9dbaHIkFrN0pPydx6gsIvnTWY/Y68JgvEFYRS20P8ChGCbHDEGmnQ7t/570LoWlIDOS0OdH6jZHdAJe/QrtfMw1Wzd1E1vdrFpT3FRmL4qN5lOuyPyzxJihEavg+IvNBT4W2/N8NFbexOx8eETheE3hfuZPuANaR7BTSXMz2sOdzB+J/Q8RSx28/3WBkrYg2Mh6qx8sZ6UrjLWQMLkQpvTO0RYpmQq7MqrNF6JK42bdRuTvtm3l51DegQL++ql8YVKpCYYqu1EIZcDujlUZDqhFdhW9SQNcNK4JMQoDglfgWsuGaQyIKpXvPnrZwYc+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cq0UrPFtLjyTppEEM2816wces9yU28DXmtzGWBki+0=;
 b=L3njFh0ukS0TFneTqMoJaDPkwDOAnuQBBBNOepjV6EA4SgraiOL5FqJGO6xW5MK8TZTe3AJ7MiEk6mjCGgeZ7Ya2vQwWSENXVRTq97lesnmaRVQyetBkE34/IsaTZ1v5/nraReXU6TiwWlmUMosvYwy8EIoEsKQY+NSIgh4hNc4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 10:00:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 10:00:57 +0000
Message-ID: <3c11368b-06a3-4f25-8dc3-f57596b4f627@amd.com>
Date: Thu, 22 Oct 2026 12:00:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm/radeon: fix VCE1 encoding on SI by handling the
 VCE interrupt
To: Matheus Tagliari <mptagliari@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <8c60afb2-cb0b-4aec-9237-2ea3404d2793@amd.com>
 <20261021153346.124285-1-mptagliari@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261021153346.124285-1-mptagliari@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0290.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4154:EE_
X-MS-Office365-Filtering-Correlation-Id: b1228f5f-3437-4d5b-ebea-08df30235dd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|261021121427099003|56012099006|4143699003|11063799006|5023799004|261021123027099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: ZD1gCC4Ro4szE2yZj28FgL9lq9rqUAMFX2lz8wHtNzQPi8tdRtnYr1HXmeqJnhawdZHTZo6Uw9TSuCCxuzDKVfQ068aICvqc4YkAlU/djgRCEDOVRW1PJRopjUcyc+mLNpM0PVMpa9VcDyonKK6jKqh30OOpjOThI1n8zi+Vsd63K7Upur2q9kRRgdtPSwavhAwsD9BqzjZheu1RBjcA4ej3aUmMdgAQzovwgBe/7uhMmmoDS+gPJz9Gv7lEXzkv2FcqRJWUSjri+Ys+C5OXMdqlLCHBZHZlN+t/zjlxBX0XD/LUuAwGHdO3pugNeH86/JQN9VEE3oWDT3n7BIb2ScTTWYd5hTmrIlqYl7YrC9lShC8dBB/NZHSC5KnJKEh/0KS/voycGkAQ5sJlqrShZo/74GqS3OGs00AbmEHCURqQ2NM7EiBN7fpFBg9JuLpjqV1Oj6v7VNV/XNmoT2qTbFJ4g7JW83Adc+6hm/uf0ze80n98O6Mt2minRflCQWe6PZ9HSomGxN2on+6WK7QFXS0afQ34eBfH4AXaQVJm08+A91iVYOG7mZIgz3mMOYUxdDmgRfoqIUew49L441Hh5WGFGPEQ2ZZFzJB/0UlwPxydTP9nTcfMMUOYmqU2PI4omR4Bhkcr/ghgT5LUjyUxvuSbp/+79eclu//wmNI1ql0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(261021121427099003)(56012099006)(4143699003)(11063799006)(5023799004)(261021123027099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHNJMHhFSHRpUjl0b1lkSjhjOGphRVdkTjNmaXFLR1J1Y09pQ0E5enpndmdI?=
 =?utf-8?B?YjJIUC8zZlg2M0tYWnp3dDFkQS8rNGV1Yk9OUFhGeVNTL1NKek9VWEhOT0pT?=
 =?utf-8?B?aG4vN1BrVndTbkM4Tnk5U0dUOXo4VmZiVjVnVnQ2ZEpZTlFlYkFFcmlBMjNI?=
 =?utf-8?B?dlRKa0V0dFQ3MTJvRkhoR01qNnNuS3RoemFLbTJzSVBPcGpqK01YWXpMVHR5?=
 =?utf-8?B?NnNoYnByNUYwQkJ0NldIMm94b0pIUWdDUkY2K3RXTDJhRnJ2SUtWSnZtZDcr?=
 =?utf-8?B?MkN6RWpad2dIT1hBaHFkN1JxcDhxemhwcmZKRlJHcjdqcGRBcVNCTFN3L1Bz?=
 =?utf-8?B?eGpXc2Jud0NYR2JSMm1hN2k3bENQMW55WWIzODNrMkZiNWkzaGdFb1BIbnl6?=
 =?utf-8?B?Tk5wejdKY0lGNUEvNTFDT29idHlZSGtBUkdPWEJ4c3c4QlNteVpudytsQ2JZ?=
 =?utf-8?B?YU9tTlpKenBsdEJMbSs5eDVBcHV3ZTM4Y0dBNzBNdkJtb0tHWWJOdjRnM3hu?=
 =?utf-8?B?N1NudE50YXl3VzVSYlNzaUtyMkZNOFZBbVI2SmoxL3JFN2ZJRGp0WHpSdGhR?=
 =?utf-8?B?enFTVEZBY0VpMkZGbXVzMmNEd0xhOGdQbU52UXFua1ZNVldUU0VEeSs2VjNl?=
 =?utf-8?B?ME93WlU2U3U3bVlUdUo4RUNKT3ZnbFl5OENNcGErcXIvZUMrOEJEdnFmNEFq?=
 =?utf-8?B?ajNRUUNNTGlNNjhTOHc2dTNxdzlQOWNWc0dwSlgxYXU3eGQ0NElsUnozdVJZ?=
 =?utf-8?B?M0krMDlyMGJHTG40MitxL3hlMGtMTVI1bVFoN1FkdlZ3Tk50UERtWmxxM201?=
 =?utf-8?B?VjE2YVNmRXRwL0J4WVZOcmRLalFURzBvM3RWWmNRVVoxUkV2R2kxT2o0TCtI?=
 =?utf-8?B?K3lKSHMxQnZBeE43ZVZMcC81SkFhSGIzcE53UVJDOTIrQUFyNysvMjlLRitI?=
 =?utf-8?B?VVZqcEhqRTNwS3lSbVkyYzBtNDZuM3ptQmFidlBoQ0lDcnRubkpqQ0xFU1do?=
 =?utf-8?B?REZBWk56MHZqYWxuQi92Y3ZkUTIyWDhwc0NuczRTMTRPVWk0NzZsY0V6YmdO?=
 =?utf-8?B?UHlORjh4RTdrQXZJMG5lNmd3MnNGT2hDZDRKZ3ZBSnplUnRmWExiVVc3U00x?=
 =?utf-8?B?VHI1VVVrcllIK0cxbUdCOUlKMWlGQWZ1OTdNMlZ1OS9DOWJIdXZUb2VEU3Rh?=
 =?utf-8?B?a3VmQ1RqNmZ2TFUrc2x4cE5nTTlkb3B5Wk56NnVpSHd5MGRYTFIvb1A2QlhP?=
 =?utf-8?B?c3JmOGZSa2Y1QU43RjNkd1Z4RHo1aS9vRHNHK1ovSks2ekU0OUFueXd2M0Rp?=
 =?utf-8?B?dlZKd2JHUVdDdjBmOHNUbG05aE5yaFRMU2VjdFJvc2lBSTlCREg3bFhHWDZL?=
 =?utf-8?B?Mnh6ckt5ODZDcGRxK1dnV0NIKzVVQ0Y1aExGTnpmazdibXI4V0FicjNLdFNp?=
 =?utf-8?B?VGlFRU5Dd1FQZzFzZk45RUhIRDlyaEs5bWNsOU5OM3RtbDZHR21TcE45aEEy?=
 =?utf-8?B?Q2ZpNDdCR1lBK2NzZTE5Q0crQWZGSVlOc1RGdmxabm5Gb2NScW5iV200Qy9u?=
 =?utf-8?B?YTRDdnp6UE5zNzRmNllBY2FWYXlETklUQVZFbWJXMVFtV25FeVluQU1PdDdx?=
 =?utf-8?B?NU03UExaQXAxS21FdVh6R2pHd1dscUMrTzlmWnFxaGdsZEVONVZMSXY3a2JM?=
 =?utf-8?B?Z0dCdlNDU21sSjlBanpFcHdXaGpVUFlIZ1lIdldzU2s4TTh2bVVhRlgwWEdN?=
 =?utf-8?B?Nnc4bGxnN3cvR3FNa0NZODVzdWo2b2hFM1BvU29KOFhQOXBBT1ptUy9BWkRq?=
 =?utf-8?B?RGI4RkttU0RZeER3TFFZenJvb0VxTldhK0s3bTVvQWdOZ2xVb0g2VndycVYx?=
 =?utf-8?B?TytMWlNqQzY0UWRWOUdvOUFRbnlrNUJ3VE1DOUN3bVNnSTM1R1lITjh3ZEE0?=
 =?utf-8?B?YUdDd1JJeS9rTlB1QXZ0NnpwQTZNb0dDQ1ZLRWpaN0VjY0dHcWF6Q1dVbFRK?=
 =?utf-8?B?azMwYzBSTDYva1VTVkZGTjFKdEVMdTJvbjd3MTRKcVhZbEwxRlhGWEY1U3BP?=
 =?utf-8?B?TFY1REtTeldKZCt4U3pEYW43WldFdXZkeWllOUhlK2pFOXZTbFBZbFlzTUZn?=
 =?utf-8?B?L3Y3TXBLN2tZNEhTcXpUQkR2bnZZQWU5Tjk5R0JEb1dnWFV3UlR1U1hSRjIz?=
 =?utf-8?B?VlI1OG9QUmg0SW1OU09MNXVNbDRRb2daaTF5TFNuZnduNWVUaXBXZ0RFM0Ro?=
 =?utf-8?B?MXRlOExWaFpkcXlhcEtsUHJwbnZzU2Rlek1CT1c1T2I1SFhDZmxhaDYrc3pk?=
 =?utf-8?Q?8LU/jiORZ72lAwXwvG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1228f5f-3437-4d5b-ebea-08df30235dd2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 10:00:56.7317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVxLCgCIDHVo3PhpzWLxASkTEk9k99Gqd6rsTahts6997Wg3YbltYepfupbDaYO8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 17:33, Matheus Tagliari wrote:
> On Wed, Oct 21, 2026 at 04:10:04PM +0200, Christian König wrote:
>> The fence handling on radeon should work completely without interrupts
>> since those have been rather flaky on really old HW.
>>
>> So no idea why that actually crashes for you if the interrupt is not
>> enabled, my educated guess is that enabling interrupts actually doesn't
>> fix the crash but makes it less likely because of timing change.
>>
>> Would it be possible to just switch over to amdgpu instead? Or is there
>> any support still missing there?
> 
> Thanks for taking a look.
> 
> On the interrupt: I agree I have not shown why the hang happens, and a
> timing change is entirely possible.  What I can say is limited to this:
> 
>  - stock radeon: every encode hung within about 100 frames (many runs);
>  - with the VCE ring semaphores disabled: no hang, but fences are only
>    noticed by the wait timeout, about 4 fps (~256 ms per frame);
>  - with the interrupt enabled and handled, semaphores left on: no hang
>    in roughly ten minutes of total encode time (up to 1080p, plus
>    several minutes of KDE's RDP server).
> 
> That is correlation, not a root cause.  If it helps I can test enabling
> VCE_SYS_INT_EN without processing the fences from the handler, and run a
> long soak test with two concurrent encodes.
> 
> One difference that may be relevant: on CIK radeon does enable and
> process the VCE interrupt (vce_v2_0_resume() sets VCE_SYS_INT_EN and
> cik_irq_process() handles src_id 167).  Only VCE1 (SI and Trinity)
> never did.
> 
> On amdgpu: it works for me, I found nothing missing for this use.  I
> tested it on 7.2.9 and on Debian's 6.12.113 with the amdgpu VCE1 series
> backported: h264_vaapi encodes up to 1080p with DPM and runtime PM
> enabled, no hangs.
> 
> The reason I looked at radeon at all is the distribution situation.
> Debian 13 stable ships 6.12, where SI is driven by radeon by default
> and amdgpu has no VCE1 support (that needs a newer kernel, which Debian
> only offers through backports).  So anyone on the stable kernel who
> uses VAAPI encoding on an SI card, here through KDE's RDP server, ends
> up with a wedged GPU.
> 
> Since you are considering dropping SI/CIK from radeon, I do not want to
> push a change you don't want.  If radeon keeps SI for the 6.x kernels,
> what would you prefer?
> 
>  a) this series;
>  b) disable the VCE semaphores like uvd_v1_0 did in 013ead48a843 (works
>     here, but slow);
>  c) leave radeon alone and just document VCE encoding on SI with radeon
>     as a known issue that amdgpu's VCE1 support in newer kernels
>     supersedes (even a one-line warning pointing to amdgpu.si_support=1
>     would help people on 6.x).
> 
> I am fine with any of them, and if it is (c) please feel free to ignore
> the series.  A v2 of patch 2 that fixes the CIK register issue found by
> the automated review is ready in case you want (a).

Yeah as Alex pointed out trinity is not supported by amdgpu and never will.

On the other hand that APU was the first one with VCE and I widely remember how buggy that HW was. So it is probably a wonder that this works in the first place.

I would say we take the patch and see. If anybody starts screaming we will probably just revert it immediately.

Problem is more than I have no time at all to wrap my head around that code again. @Timur can you do me a favor and take a look?

The radeon VCE code is basically the ancestor of the amdgpu VCE code. 

Regards,
Christian.

> 
> Regards,
> Matheus

