Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D685FCA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 13:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FF1611211E;
	Fri,  9 Oct 2026 13:21:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bNiyFYcM";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010034.outbound.protection.outlook.com
 [40.93.198.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6D0211211E
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 13:21:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jfm09UPxAJ6pslwVD3y+PYi4iHSPlmCiXJNcCRXm0M0CTMDSsjokA2I45bZtjfrzdUI1z58crK2slVPRdkStEEMTvaCyZfV001QHYZIlfZSaCyYNVNSr/6XeBCktSP4+ZoNiWMsayN0SAJq1TqZq4Dz/QHeO0wFKaE8SUGQ7JwQyZNrsfs+MDmwHlwd47Af1Sc4FdjkwrMp4W9fkz1ek8hHTjLrCMiuLfEMosO3Z1QyaMUJ5+/BfCKavaGE+k85ZqW5TyhA2Gu58WAFx8iZR1sC9LoIJUTj9+LVr0wtrkdiBq8bf+YM6Hhhh8cUX0QgOtDTPE7Q7UG3M9Vrmy+OC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4q7UnqIbLLmSxS7ijIs8EfTYrsQIcBarV/FoyISYwqg=;
 b=sVj3AaZTYe1hHkDGo1Q6OprKHMqyOkvqXq5HwjA/lAmYlp5zXFDINg3bQRIuzEE8V+RGpcJfA9GxqKwwd/a9tXS5PedBqcyBhzMM6m13Khj7No9aMjkXr3nri3a1mJx8tyQfBuyVHydhPcDtWQk9Btnea1ggB4zD/tqao+7b+w1b6qzBsZOW/P7HGmUqPK7OrmXboQ9gUHSQvrlGnXgatCrKUkB9yDMLNWE64NIzHtyH7WhLNHQqCwIfienAGHy6TzzdWhBDUjjj9bs2eYBxwlRxWNqOZOV1e8o81DTTO6/C7gchb2KR8IJF1wy406MV/fUEOho4H+f5UmcRxi3o9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4q7UnqIbLLmSxS7ijIs8EfTYrsQIcBarV/FoyISYwqg=;
 b=bNiyFYcMBidrkAPgI+qlBB998f6tGXEeUdbVNbIntBCQmU8PrTkMJvU5eaUmRRi8a1FwFWGPPYE8jTSIyFfZOfwHRWgeSDLZT2oN4EZCH6R23N5ckbkA5Mh14/bNaclpM0Oq/IRQFsBdxKNLblWNtfSxceLxRQG1S5LPk8knpq0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7915.namprd12.prod.outlook.com (2603:10b6:510:27c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Fri, 9 Oct
 2026 13:21:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 13:21:52 +0000
Message-ID: <50f74418-a1b9-4d93-a9a9-02bb7cbf4544@amd.com>
Date: Fri, 9 Oct 2026 15:21:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] dma-buf: add a warn-only mode to DMABUF_DEBUG
To: Jason Gunthorpe <jgg@nvidia.com>,
 Diederik de Haas <diederik@cknow-tech.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Rob Clark <rob.clark@oss.qualcomm.com>,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Alistair Popple <apopple@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
References: <20261005064133.7305-1-kmehltretter@gmail.com>
 <20261005064133.7305-3-kmehltretter@gmail.com>
 <DLYLA3WQNN3X.3FB9MO8ZWBQ5@cknow-tech.com>
 <20261009125338.GB13920@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261009125338.GB13920@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR11CA0025.namprd11.prod.outlook.com
 (2603:10b6:208:23b::30) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: b4d7389c-7621-4513-fae3-08df26084851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|7416014|6133799003|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: nlZin02ty1dPzKq8wnd9kmjd3ySmpnr+sIXt1ueIbYEJx8Km3C0bcitk6Krh8nmpKdBuFYuAdXyOfuZhgUlhT/MsNM1zf82pYE1HO1ZkuH/VQ8LXFhVN3z+kBS2L85ZcmJmhgEAXFHOKNOpNkZh3cPRRbyMbfyR6EghbfCyX67XwGIpsGKYphPTAdG9pir/pT0FV1dlMzbyVFiSM9oIPxIGUSWO6dabfsP+T3L3a6x+GEbDCcCOHIA7Ks7Ry4a7oloUTB41Chcvcyml9HsE88l06qPVDmbqJXQok113AXBihr7/k3zU6qkq7E1bo8MVi5mncER1YRHdShaAtm60L5xVh+92BTjZabsVSEWReCrPwB33LbmQN3tL5No9b3Ae1WjvzkQEJ62BYExzEe5G8K3f4j3ETeq4MmSWfVvj8hb09p9O7uGq1AQUeTCXJY+33dDrOoL7bLjPjRrRz47rnWy2WjqmRnDaqXGD0uuHW2jF3rxqYcN/Uh3nlbR4EhAM7f5aFXXgynzJdanQasmBOCcLUJLiN5/X8Q2FbuDSExAA3DTX9aS4UA2x9FjYOX0wbuxh2JHgRpTInjnW7sWCTV0Ya32hmaLAUjBIgTTWPrnzqqQ5Gmw8hzzClOIcBvBXQwYYCZpU4n0HFdszdu139HMNdD//93TW3/ZrpGZLCxdA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(6133799003)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGxXQ3ZFUENVZDE1bkZjOWdibDNPdzRzWXZKN2FHZDdURjJnRnFSVk1rTjUw?=
 =?utf-8?B?SnV5QVF3ZmozVWpSRWVvbE1NUFFJZlNpMW5KM1ZlMjFqQjFhaWtNdFBjbUpY?=
 =?utf-8?B?Q0xxYm1TMytVZmNnaE5hMm9BUHozVC95NFRRcEYzT3BxMFpDNm04NGRtbm5O?=
 =?utf-8?B?bHd1alM1NHhGalZxVTVvRm43aXBBTnFpcHQxbUZkZ29zQit3aWJjUG5RWGJw?=
 =?utf-8?B?cXFaNmFVa1UxaGhpL1VwMnYvVWo2MEhpK3JlNGhGY3BOT0R4blVsZUU2Q1VY?=
 =?utf-8?B?Z3o1dGhkakxHcnJhYWhxV2c1WHMrNmw0MUVBeDhuT3ZveVM4MFE5WDRxUmx0?=
 =?utf-8?B?OWxGZ2pYcXE5VjdyS3V3Q0VmSDE5NDF3eFVpRVk5SjFGMnI4NlR2eTRReGtq?=
 =?utf-8?B?RnBDcjFTZzlod1JEaTRJQmtOSDBDSHhvRk1RR3k1SGwxbUkzY0QwTTJTbWUy?=
 =?utf-8?B?ZVpPdkpyK0dVaElYa0NJZHhoQkM0QkM4Vm9JSm1KV09qTUk0UEJ0MkVzTms1?=
 =?utf-8?B?Qzd4cnNtVDBKR1J0MitmZXoyVjg5VVh6Skk2K1hERTliWnBIQnhNREZyam9E?=
 =?utf-8?B?dVVPcHcrZzh5a0d1dmxnK3hSVmFqblIwN1JuZjdBUXVhY1VYcmt5ZHhMUWRt?=
 =?utf-8?B?M0dqOFQyaC92LzRtWi9YYXRySUU0QWQrbFA3ajBRb2FvU2ZkZ2RPNFRJeW82?=
 =?utf-8?B?aVpCV0VCQUZNcFkxZytPN1U0TGRqenNsREJ2UFUvRmo2UjhsZE90Z2hpSXRq?=
 =?utf-8?B?YU4reDF6cGhtQXFUU0ROdUtrQVR0NGtib05taStiNlFnWXJ5MUJTcHdmMmZV?=
 =?utf-8?B?dHplckRDRG5va3A2ZFVsSFMzVE4wR1hWVG5uTmZTZ3RTL0puSVJMMHhtT0U0?=
 =?utf-8?B?WjVORmhpQmRmcHozNFNsL2t5TlJDRE1LeXZVN0IvWlcveVNmVjR6M3lXNVVO?=
 =?utf-8?B?NUdZSEc3dytLZjRQRUhldnJ2eVdLaUdzSG5mVXpYK0ZvZU1sSmNtMHV2OXV6?=
 =?utf-8?B?S0hYaEthSTBWY1E0SjBsRTd0a1IvZkJScm9kRUJCZTVTSzJTVGJvTW8zRmZN?=
 =?utf-8?B?Y1NjMnkxSFhWcU1MOWRGS1IwQmNwdHhYTmhhQkhrRG1jYStleUJXSXRNNnNZ?=
 =?utf-8?B?b3pTVE5LZXlXUnRDS1FMd2NvZE5wL0svcHE3emVSN2ZxNWZqS1IzRldIK3J1?=
 =?utf-8?B?WFR5TmN6NjNyWUhIcDNBWlgvOElTUHFKUWVBek01WEdPQ1VjZ2xHUjZBZ1R1?=
 =?utf-8?B?bGM5K1lvM3pVVEtab2EvMWQrd254dkw3UkdLajZ0OWYvbkRFSUl6SVFaclpJ?=
 =?utf-8?B?YXdjeVZ2T01YQ3UzMU11QmFiRDRpdnBDWnNzYXgvc2JwamdaQmpMTEx3TStl?=
 =?utf-8?B?aGxQZXM3MzVPUE5vZVhWUUFSRERleDdOK1JvUkdEeUlEVWF2ZjRSS2Q5RTBG?=
 =?utf-8?B?eDhJNUdlOEFLUHcycExjZWJRZVdzbWRhNTFVODA3VS9zelF5U2xSTWtlNkJw?=
 =?utf-8?B?bVpJelFpMlpHY0xBV2g1YUVYS0VSRlNmekgwT1hIZnM5MlBCOTlQaXZ5N3Y5?=
 =?utf-8?B?ZDZvTzFBWUI1NHJFMkFHdnhmbFRQamNpcEs5NFhQNmhHa2tFV3dNRDF4alI1?=
 =?utf-8?B?aWJiampxWmVkT3hVTlowbUR1MW5oZE05MTE2ZEVsV091OUthSXVBSHpzV0dv?=
 =?utf-8?B?Y0xwcEUxQkJaVndNWGVSdFNMWTBNcm5VcWg0VU1xbld1TjFqRG1WbU1ZZ1Zy?=
 =?utf-8?B?cTNEc2Q3c2J1eEpHb1ZlVnpud1Y5RkRQR01HWGlkZC82TjdIbjQvOXNzMUZm?=
 =?utf-8?B?a01pVXF1djlzOVIyOVhpRTF1cWMzRFZPZ3NIK2NtNmYyTzI5THVLcVJxU3ha?=
 =?utf-8?B?L002MTRESGp1bXp1Q3NOV01ZYnVXMGxvSkE2R3lMN0ZUZ1pHVnNGeTlSeVI4?=
 =?utf-8?B?Z3lkUVJZQmdsb1VPbERqVGFwdTRSR3V0NWRlMDYxcmhxMVRxSHAxZjJhZlRN?=
 =?utf-8?B?Y0orTS9oQW1CbUVTYVoydlJHZFBrL3BNYlVyakFhZk10aGxOYm5BT2t6WGFP?=
 =?utf-8?B?ZlU2R1V1dllnZGFxUmNicUV2ak1mZ1pEYzhaK3pIb0F4c2xhZyt3eVQvZ2li?=
 =?utf-8?B?MFdqNk9qVTNTNXlXYWdZWTBLaUowNUZFTEZrdGxSUU1RRFkydWZwRlpYNTBv?=
 =?utf-8?B?cW5ITTJrMW4wcUhLd1RPbUx1Znp1THhwTFpyOHYxdks3WmxDM2FvcENJVXpY?=
 =?utf-8?B?Vkg5dzhEVFh6Vjc1QlBFdUpGajlxcnFIbWh0b0cyZjFwVEpQWFlTZWdWUUtk?=
 =?utf-8?Q?E6K6CbtmsnBvt2FaDC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d7389c-7621-4513-fae3-08df26084851
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 13:21:52.6270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zMOoUNelzFIUHZjSdRlqf1FZqIUx4qVthBN4g9Rx+wYL13Bq6cCaM8DmjAs7BgG2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7915
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

On 10/9/26 14:53, Jason Gunthorpe wrote:
> On Wed, Oct 07, 2026 at 02:02:31PM +0200, Diederik de Haas wrote:
>> [ 1091.981354] rc rc3: two consecutive events of type space
>> [ 1104.670513] input: EDIFIER e235 (AVRCP) as /devices/virtual/input/input12
>> [ 1172.090231] devfreq fb000000.gpu: Couldn't update frequency transition information.
>> [ 1189.403278] devfreq fb000000.gpu: Couldn't update frequency transition information.
>> [ 1206.309295] input: EDIFIER e235 (AVRCP) as /devices/virtual/input/input13
>> [ 1268.968696] DMA-BUF: importer used the CPU side of an exporter's sg_table
> 
> This is a nice stack trace, is that the point of this series?
> 
>> [ 1268.968710] CPU: 6 UID: 1000 PID: 29025 Comm: sway Not tainted 7.3-rc6+unreleased-arm64-cknow #1 PREEMPTLAZY  Debian 7.3~rc6-3
>> [ 1268.968715] Hardware name: FriendlyElec NanoPC-T6 Plus (DT)
>> [ 1268.968717] Call trace:
>> [ 1268.968719]  show_stack+0x20/0x38 (C)
>> [ 1268.968726]  dump_stack_lvl+0x60/0x80
>> [ 1268.968730]  sg_dmabuf_cpu_access_warn.part.0+0x24/0x30
>> [ 1268.968734]  sg_dmabuf_cpu_access_warn+0x34/0x38
>> [ 1268.968739]  iommu_map_sg+0xc8/0x1e0
>> [ 1268.968745]  rockchip_gem_iommu_map+0x8c/0x128 [rockchipdrm]
>> [ 1268.968757]  rockchip_gem_prime_import_sg_table+0x58/0x160 [rockchipdrm]
>> [ 1268.968761]  drm_gem_prime_import_dev+0xa8/0x1d0 [drm]
>> [ 1268.968776]  drm_gem_prime_fd_to_handle+0x1a4/0x280 [drm]
> 
> So.. This is the exact same thing I need for iommufd.
> 
> rockchip is managing its own iommu domain and you cannot map to an
> iommu domain without using a physical address.
> 
> Of course it is *completely* illegal to call iommu_map_sgtable() in the
> importer side of a dmabuf.

Yeah we are deprecating this for the last ~5 years now. This bubbled up because I change to DMA-buf debug code to be enabled by default on DEBUG_KERNEL.

Rob is now working on a solution right now for MSM which should be used for rockchip as well.

Regards,
Christian.

> 
> static int rockchip_gem_iommu_map(struct rockchip_gem_object *rk_obj)
> {
> [..]
> 	ret = iommu_map_sgtable(private->domain, rk_obj->dma_addr, rk_obj->sgt,
> 				prot);
> 
> Jason

