Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DF5606B9EB
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Vr+khez4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D42A510E02F;
	Tue, 10 Nov 2026 08:30:40 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013052.outbound.protection.outlook.com
 [40.93.196.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C25B910E02F;
 Tue, 10 Nov 2026 08:30:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPPM3S/vo9bouT7hGfKOyqAVKTuSsl8A+CMaeFtHEw8N3hY7Bks0M+RgaRLQ2RumtIRd07rSUbGTsZmlls1+0slaRBM1/1DnQi0414nOf4LbEKa8k2jGRKbI5Sf7Z2P3yaadioUtY7JyIm4t5TAQl0sxRZYbsNOpUcs70JXcBTD5BT9cBix/MDT5IW5ZloZWsAgMlKZPjsLv5ZIOzUuNv5YBDJQaPAyOm015f5XzlxnsB35jFrZmjIOPsf04I0Q9ZhrGX4l7krUxTDRMmuJ/4JHLEQN0GqhnzyLG2VqTnMeaZLZ1puCs/ztRimAu6RRZRdZ3UcYRloXRNkLbIkUIKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URsGaNR7k/tGm8h2t+x2hUEi9qnvLhJGje1xfZmLZM8=;
 b=k2I2916X5P9q+WRVlxe+RG7USMaXth1HxMcwLeuSCgKJH5TBIbInTtofnF+cBNH6srVvL9BPHB9wkzWjrZS4sCuhgTuVXvJfjMQU/vFnviab0Qlqc+1WP9Hv8TPlCCZRvzfDaJ7Sa/KJRtfH3wMKRuIi1MaOFxkF7I8/qn6PLKiRDWvAq4A8k/3CmqDn2SeET6dLvuEA1KsmeNXlf7z4heKPR98EkUKJPee33uNUYFOTrEYt9ZcTpDaD8rFUdRwQy0YQi4U/460FxIHy1akfPo3dweS4C9r/fNAX9PStzvPDMEkQLWmCexqlMLFuNIS6b26pgHfSvx79lbJOdoyXQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URsGaNR7k/tGm8h2t+x2hUEi9qnvLhJGje1xfZmLZM8=;
 b=Vr+khez4axN4/rUINnv6r0Eti77c8Ov1BcEj6olBWNR3UVsQQFvhRPLe9V2NPfZceyYtya3UmNimkmbXiN25f8g6aPxFaK3TZRj2LxtWGXrd7PTfKPRImuMv422AtkBaunHRYJGEa9pR2RD65+nMOmnYSHqL79oU+PMNScG3yJs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 08:30:30 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 08:30:29 +0000
Message-ID: <aa233f10-eb96-4bde-a44c-0855110bb151@amd.com>
Date: Tue, 10 Nov 2026 16:30:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 08/22] drm/amdgpu: implement SVM range notifier and GC
 helpers
To: Aveline Noir <jm5905938@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Alice Ryhl <aliceryhl@google.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 Felix Kuehling <felix.kuehling@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Jenny Liu <Jenny-Jing.Liu@amd.com>,
 Junhua Shen <Junhua.Shen@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>, Yiru Ma <yiru.ma@amd.com>,
 Huang Rui <ray.huang@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
 <20261021025915.2433837-9-ray.huang@amd.com>
 <179424436564.222336.1790875367286789154.b4-reply@b4>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <179424436564.222336.1790875367286789154.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR03CA0008.apcprd03.prod.outlook.com
 (2603:1096:990:6::13) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|CY8PR12MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 96aafa0d-b51c-4672-6b0b-08df3f04e0de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|6133799003|10067099003|4143699003|11063799006|56012099006|261102123227099003|261022075727099003|261021121427099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: M3moMAM9xDx0FhJvIX6KJ3cETHcppqQYSuS6PhtUtJ7fLTDyUm0JfSqsyqmnNvZsa5uYubUtj8YeClhgPqTG2SvKa8s4rMWr9kw3q34DCiLT0TM0atdFiECeI2GDqxOFGLUj17kKP/QLPQ9kxyyE0pzcrkbYA4hjLDLhAlwmpwgE44tcUgfqghMphN4JLwY8Mxgt4VCDxg1Sf0FHlo5H6M4ZZp7ZMmgSD9Wrd4PZOaFvJAKu9qib7YG2Nq7MRv4v7lIW7KwB5YeVW8u6M+3FDlARKRpzgAomsn63pUMLbTQIbZNfI3aavNAO2lNgLuPFsWbDODGx80fOCdfz/iCiOH1Qf5pmMMt9MoMjS0Vr1ayrMwehKpmfchb0n14mrivn4mRF7OiFQI60COVc7GyarwtGy3O7AgC0o7mRMuD+rncGp1X1OCTvR6GkFdkYv9EOmiF/ZH2kkiNZrLkiFMjYaN+y7angV6irdcZPsleQ939SD2KI34ZLOYORhX+4ACD4rZfZM/hHnCmt0U3hsl40EDUJktSMFVg5Nva/mUim84ldQIn/2LFfnjC2pY0wOqtjDoeH+2QMT3BlniKrfG3QK9rYRMDDsKkUf3HEEEMzDLlBpgNsTnxR30sVXEN3PqaUJNkO2I4QjoczOXJgSX9XAUgirZ/6zcgvsJkW6Ov9T/k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(261102123227099003)(261022075727099003)(261021121427099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmEzSHdhRXFUdjFFdGVqN2g4VGRvRjgweTcyQnVYL2l0bXlnYS9rbWtUUEFH?=
 =?utf-8?B?Uy90TEliaVBnaEZCNnZ2YjVSWE1qblYybFQzOXdrcXJ3TFJVZ1ZKRXFPV1Ja?=
 =?utf-8?B?bjFjdi9PNnhhSXdEbnFmbmJmcmdjTzVMQXVUNkRZdnBJdHZCeDVneklRZFc1?=
 =?utf-8?B?VEFVZ0R5UVdtREJLTmVYTUE5RXFIR2R1ZmM1YTE0UWkvcUhvc3J4c3NwenFL?=
 =?utf-8?B?QmU2NFZlNGJLUjBSTTdIWVBvNU1tbTFoTXRKd3Y0QnZNK0JoT3NHMlh0U1Rj?=
 =?utf-8?B?cDZ5TjVZekVuaCtOOWdZci9EYyt2dkdEcVJzcUs1cjNGQVRCZngxZEp1cVdH?=
 =?utf-8?B?aEZQTmZGNTZJL2FvQ21MTVVXdlRPNDUza0Nzeks4OE5yZ2pXN0ZQVWpiNFJv?=
 =?utf-8?B?cDlaZ0VWOW5iemZMTWZ6Y2RzME5XSE51cFByMzFBZmx4S3ZYUDg2akpETFR3?=
 =?utf-8?B?K3l3Wld1ZmJ0MUEzQVUySlVON1g5bG83UUt0WWtsR3R4bzZkdmxSNlpyc2d1?=
 =?utf-8?B?eC9zOHc1VVVkTEZ1RXhGZmdmclNYSitiV0pVUDY5WndpdnVxYkdra2NJNE5G?=
 =?utf-8?B?S0F3NVpCYlVPcGFWMW1SaTlhUnpkUHJlVUY3amp2YkJld0hWcEZ5dERpVDhk?=
 =?utf-8?B?Z2UvMGlZOFF6bEJ6enBkcGZhZXg5aEI3bGs5bGJDZlR6K0o4Y3VUU251SWVD?=
 =?utf-8?B?U0ljQkRWN3BpSnFMTzdYc3MyMzRvc2FqWjY5WGNqM3M4Rjk2aWl5TFRDQzVN?=
 =?utf-8?B?YXJuK25VQ1IvWi8wNGcxMXNseVYvaEdmemtCRzZrdVhIOEFEV1UzZVYzemh3?=
 =?utf-8?B?OTNmNVo0c0xWdzZXZHN6VmIrcGc4blAzWWwvaWF1QVV6K0lGS21jREFmajhx?=
 =?utf-8?B?WThtSTMyT2hCdVJxTUl5ZHFocVA3NXFZRHdDdTZvaDE5YWZqMjhNZ0NIUXpE?=
 =?utf-8?B?bVJvOGFsMFgrS21qNDBSR0J5eThSSDEwcU5OY1h0MEhOTDRzbWFLdTN6ZkNH?=
 =?utf-8?B?LzFLb2h3VkhjSlFsK2JEK0FWeFJ2dHk0bzdIM2ptWnRvYS9HNTB3TEgvWGlv?=
 =?utf-8?B?bEk2bHJmNzNuV2k4RzduZWFoRVVTWXg5UWs2c09jcG45RHU5bGRLYXAwYndO?=
 =?utf-8?B?ZEJ0N1krbGF6aitoS3BNS05oSDBaOE82akR3aEovLzU3RmJzcm5mUE1ZRUxq?=
 =?utf-8?B?ZHlCbGtWRXdqWHI0Mm5iZE1HdTZ0OGg4UTROUG9BZEZrcFY4WW1vU2prQW1H?=
 =?utf-8?B?RHJYWUVZRFFhaWJpUjhKSGE2K2xOenRqUlpUUkxhYkF2SmVrMERpZnBXb2J1?=
 =?utf-8?B?VE5EdHJCYVBjMG1laGZGVmhoK3Q1Y29LenJHbjU2VENpWEtrZjE2M2lmY3JD?=
 =?utf-8?B?NE9ENDVrdFNMdXl4eStOd1l2ei91VlQrZVMxVWRnSkN0eFd4QXEvb25xcVdQ?=
 =?utf-8?B?Mk8wVEV4YW5LKzZoNEhxT2xRcytzQi9kYXZ6b0w4Z3RGZCtxSnViVVFqdWpK?=
 =?utf-8?B?NEYvZzlrSVRkd2NaR3UveUhrdUZXanB1OGNGNXAyVGZCV2VjWS9SMHJmTjc4?=
 =?utf-8?B?Wi9VclRocHc4UVh4VUpVSkRLUDR5WUVLdTJ1OU1ldnB1QVZsckp6NEt0dXY2?=
 =?utf-8?B?TGtJb1Q5SWNyZkFvdW9kNjBoT3h6WXN1ZUdmUi9KV0IvUk9QeVRWRkNuSTBq?=
 =?utf-8?B?Q3hhUlIySUs5Rm5jbHM1allkTHJnWlc0Y29KTzlnYUIrTnRTUGM5QVFsYk83?=
 =?utf-8?B?R0YvYzhKOGttMlJuaTd6SHl3NHlpaVR0WHBjSXJ6VW9OMy9wK3RnQ0ZES3or?=
 =?utf-8?B?WDhlMEVsZjZCMTYvaGl5UUhDT3dINTFVY0lRVlBpWDJIUlBmSWR4WFhSOTNS?=
 =?utf-8?B?cms3WEVKeFBQdFYyZ2U5YXpyWGlQZWVsZlJmVTIyaXlKQTIyeFpId1kxcDUr?=
 =?utf-8?B?cTlsa3R3VTNyRU5mNHBqMkUwS1hxV2QybDZ0WmFKODNNUWErckJUbXJ0cEli?=
 =?utf-8?B?UW9CR2tVN3dnbU1RdEJFQWlTemZRV2JqdTZ2VXZtNWpWMkUzUFp0ZVZna1dk?=
 =?utf-8?B?NEZHdHpzUmpjclpBc3dqKzhnRXVUN2ptTk1WSFIreVZYZGc0NEEzWDk1bzEy?=
 =?utf-8?B?bjZyWE9NajVGckY5cnhZTVZJNk9uSHZxKzJ3M25ZZGhPT3BxSVdmU042dDZz?=
 =?utf-8?B?MS9xc21YcFl5QjNHM1NxT0xTSlpGdlBzOXpVWmJnM3BEWDJXRkRFR0ZqdkRx?=
 =?utf-8?B?RmRjb04rUTVyR0htN0VyRDlXTHVGRit0SHB0eENhQW5pUDA0RDBtT25sVmZK?=
 =?utf-8?Q?kYefLgZmfdm7kAKodx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96aafa0d-b51c-4672-6b0b-08df3f04e0de
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:30:29.8271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSfqCyBOvFMgaiNzGOgevW44SlxS3YPpIFIEucQ5Mw6bKUWW9c5+uc4bclF01Ar8iuud6onvRkmf7oiN7eARQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337
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



On 11/10/2026 1:12 AM, Aveline Noir wrote:
> Hi Ray,
> 
> On Wed, 21 Oct 2026 10:58:47 +0800 Huang Rui wrote:
> 
>> + * Invalidate the GPU view of @range over the notifier window: zap the
>> + * affected PTEs and clear the gpu_mapped flag. The range is not removed
>> + * here; structural removal if needed happens in the event-end phase.
> 
> I think this can leave stale PTEs behind when only part of a range is
> invalidated. Take a one-page notifier event on a larger system-memory
> range mapped with 4K PTEs. This zaps that one PTE but clears gpu_mapped
> for the whole range, and then the event-end callback unmaps DMA for the
> whole range. The other PTEs are still valid at that point, but their DMA
> mappings are gone. A later notifier won't zap them either, because
> gpu_mapped is already false.
> 
> Maybe the zap should cover the full range when its DMA mapping is
> going away?

Yes, the zep should cover the entire range, will fix it in next version.

> 
>> +			if (crosses_boundary) {
> 
> Another case is GPU_RO going from 1 to 0 over a whole mapped
> GPUSVM range. This branch isn't taken, so the PTEs are zapped but the
> old DMA_TO_DEVICE mapping stays around. The next get_pages() sees valid
> pages and reuses it, so the writable GPU PTE goes in without an
> HMM_PFN_REQ_WRITE fault or a DMA_BIDIRECTIONAL remap. If it's a VM_WRITE
> MAP_PRIVATE mapping whose CPU PTE still needs COW, I think it can miss
> the write fault. So could the old DMA mapping be dropped before the
> writable PTE goes in?

Will apply the drm_gpusvm_unmap_pages when attr is change, regardless of 
whether crosses_boundary.

> 
> I couldn't tell from the cover which drm_gpusvm base this is on, so I
> used 671b7825dbfe for both of these. I haven't reproduced either one on
> a GPU, though.

Regards,
Honglei

> 
> Thanks,
> Aveline Noir

