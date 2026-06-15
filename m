Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D919CD98DE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 08:08:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8ECC10E260;
	Mon, 15 Jun 2026 08:08:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="et3Pl0n7";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35FA210E260;
 Mon, 15 Jun 2026 08:08:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtBcIQfvttkn6K/xQMD11oF4ZBDuyItWesAISYedZYb0RSgaBsiLcks2QtoapqvlyBx/f6wv9uVFiH62ekDYjy5QZ8nqfxGHL1rRIMrYxeYQeKbHl9hD5D22lCllFHrhbZIA5tUxn92MVbWYNKDS6NbmtVxxdBe49kf6K++T/qTmXfU8cFY7Elx04rCd+C5czzRA2pM+XKcYZb3PNIBqIXetM69JQYCCUS1cTdPcO/fGx0J+OhjtnMYWjsCOrNmv32nDqz8NxGjXCVHVUCRni40S5ivWFR+JQ++vlye5/K6GHGcPMztsY+xlDoFQwrYQyCIh1t0g1l69bf7qTV3D7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoRKDwgsU48rvfX9inpC54kC0nqbLsPgOfvBb7MXoa8=;
 b=Lc94NFlyrdOO68yoRaR0EOH6MfXWnTW41s9o9po0cgQ7YGCv/koDVMQyD53iRfA9r8p8FqiLsvPFwy5dK1p5vvaueDU18jTCnYXT4RFC6BVu2Q6ymfSzWMjxY2kg2CtOALhXR4/8wfdfnF4Irynvp04iyne3N2M1sSV3kds4gC7caDqBB9wjp7yT2uc3nBNSFcoD+cUcyxCjtIiRia+2l2kpnVC+/ZhKGvYeCikyYPaaMjYQCWCnPPDrRGjgXGssYT6pJPnMKcZ0GI3MmDVlObZtFmdqjzhr1T3jYin9XxE8wN8jIf4WimaDoTGH5xNslVrEqKFQlcwQrb7RmeWyfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoRKDwgsU48rvfX9inpC54kC0nqbLsPgOfvBb7MXoa8=;
 b=et3Pl0n79WgvwmVR024d8fDoiB9bKsfCkZGKgZyhBhR1dBy2XXGlLfnmb39ObX60D6rYMphn3MidVhu7g3Cr25mi0n0MiXzo1hkRCTxbYVyeBwGewogPKFOSbejxAkxuZ1gy3PlhIYcFXaz+fHXkK5tIOXJXjjWL1YA2E1WrKeA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 08:08:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Mon, 15 Jun 2026
 08:08:13 +0000
Message-ID: <e8ecc15d-63f2-4bd2-9fb0-1d800498c1f5@amd.com>
Date: Mon, 15 Jun 2026 10:08:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/18] drm/amdgpu: add SVM core header and VM
 integration
To: "Huang, Honglei" <honghuan@amd.com>, Huang Rui <ray.huang@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260612090928.29682-1-ray.huang@amd.com>
 <20260612090928.29682-3-ray.huang@amd.com>
 <889e580d-5ecc-4bed-b1b1-a5693692cf79@amd.com>
 <03e6e547-3c03-446e-91e7-da5b043344ea@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <03e6e547-3c03-446e-91e7-da5b043344ea@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:208:329::26) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e2c2b3-7893-458e-3892-08decab53f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Myxj0A/nE7/LPmHDpfy6uWn47s8af9QQUyH3TUrjYorxhF9bwWSGaSmXktYl0hoECEP7jkrK/CagZm++VaoWpMzBXYh2lvTxgSdx0ZJkgg+PQvHkPWJtL8pai26ncTwfOBgXJs2SHRuCxhaYSBGDn1bOiwn5oZx4LA8rto2HPYuuk+08BRG7sQD14sidT/GzKar7Wp1O3aGAk3/hofUjd9oHIJ+h1+7pGphf/UVEyiZQYFwuR2/VqBdrj7Ds9GKEwxxyoDulfmLZTMRcejS4Dtpc67j19GHRZ1YXZgqULyw7HjpBSeMLlJwDRJ8T0T8cjxkaDTCVL6xORMLeDYWxZGpjOkieLTqjWLlOggCnFuDyIgy5JF9WB9p24ZU6ff9SKf+wusO1QR/JIBGXvPVB+kVfArtEE/zMXh2kFk1ilvoq4PDT9ONM4QhgREQOEvh5TvGWUA34rhH0qqjxGrRhO4EFTbzjJmQpckL/U9p51szyTdGRgfYHcrThTX+7J7qa7cv0hQVFFdJ0fJxlO2S+6tdNvwjhK4XF7pMUqbTHzsu00zAu/Q6vvbqB/jiIW+9Rnn8X2gM1biSN5hBu/+HqrWfWAVWjshfaI7lulmStuutsW1FayKo8FDmN6tRD+9uyfHyuWwI0Fo4/wu9FzjWLq47cPubodD7SHVGzbuOGN7c8oxS5l348HbH86BwND5Mx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEUvdFNDaExzSE5kV3NJNko4ZE05VVl4TTVuWUNYOHVxcTVwNU9sUk1MTWZC?=
 =?utf-8?B?ZUZxUFp0VXIrNm1hZ3RhSWlHc2k1eFRJTUhjZVlMRVd6RVNLaGZiWFpxQVN1?=
 =?utf-8?B?SWRwa3FwUFlnUGlJL2FPT0dIRkhvR2dQdTYxc25oN1l5SFhWN3dqTXl6ZlU1?=
 =?utf-8?B?elZuRFA4QmtCM0xLcUF6Um9tdkZTNmIyRW1RamJKY3YxZ1JSdmNzbnBIaUFP?=
 =?utf-8?B?WFFQVmFHVGc1L2F1d0tYZEFrMkhJVWxNZ1RiWFEwMG85NVJLanArcmc0VFRI?=
 =?utf-8?B?c0Y3NEI5R3FRWWNqUjRidThHbjNmLzlIRmZXNDdvOW9tZXo5eDdaRXlNWFVx?=
 =?utf-8?B?VVBsRmpRQ25ReUlzd245ZlNJM3h1TTI5WmVJWGFmcG9oNjFFcGg4SVNRWS9E?=
 =?utf-8?B?M0t6cFA4ZWpKY1Z2OFlKWlgzMWM0YlJZNnlRZkxmMUpFaFROa05WRkp4VVpU?=
 =?utf-8?B?TGJHUXdLSHNTeEwyOVpvM1ZnWHgwOTIvT2F3SWlHYkNERGlRTDVrZWNQQ1Vv?=
 =?utf-8?B?U2QrV01hOWwvd2NuUVlsNDk5c2Y0a1dVOS9GWTZWa3VnYy96QUhZMmdDcTJH?=
 =?utf-8?B?SUdsRXRsdTFLaEZUblFyWnVxdGx5d1h1Vm4rZm9WclVPWnZQYmUwRG1jV3NP?=
 =?utf-8?B?ZFArd2pQQkhMQjR4dkNDN3hZclJGVTh6bTlaMG13cFE0ZmVYOWZEYmxxSU9s?=
 =?utf-8?B?bElqTi83bm90dkNybDZBRkI3N280YlpFMXg5MzAwR2F5QU5seWFYUlordkNX?=
 =?utf-8?B?Y3dMQW9SUjQzZzhCemtYcWlkTFZsL0gwS2MxWDZWdFk0aEUwSjV2WTMwYjRQ?=
 =?utf-8?B?RmN1U1RsQXcyazhobEQ3OGFOcWIxSGVNQWlCNVdZQnJPVnREVGZ2bko0NjFm?=
 =?utf-8?B?NDJHYURwV3lVRC9LRVliKytqLzdhWllwQ05tbWJhenB3RE4ra0w5L0lDdDVq?=
 =?utf-8?B?WE40bWpob2dlZm92dWRXY1c0Z3g1eVoxNDhpY0Fndk11TzRjUG91ckdHWlNo?=
 =?utf-8?B?YWNnRHc5R2lkNGpwQWxRQndWOWtUcjFSTWY3UEhRK1ZFcHp4dGRCb0hza2lz?=
 =?utf-8?B?aUJqdjdDY0lEQ1ZURkpTZytsZTJCcEs4UDZydUNHbmJiV3NzUXlUOUYvbTVa?=
 =?utf-8?B?Q1FCSWhXa0hQb2IrdndsK1Y2d09CcFVaNUpvZHpKVUIzZnVKbldnbmtXRDFF?=
 =?utf-8?B?bHRqcjg3eWMyLy9nL2dQNEdVdFlTME1aY0o3V2c3bUhZZk5RTElhRTdxTlVD?=
 =?utf-8?B?RjdLN0xyUUh6R2hOeXdRVm0rL3o5KzdQKzArMmlIaWpaV1UxQ1ZaTUlaZGRt?=
 =?utf-8?B?SkpFUWttRkpRZWEvSzAwbjlVYmVJVElWSlRubVBtTWFUNlQxaU5Ea21Uakpq?=
 =?utf-8?B?MWZHNTd6SGdyODBZTllrQWpSR1F0UG9yeXkvaGlQUll6elkvN3NsR3A5bGZ1?=
 =?utf-8?B?NXd3aXhPM1htTGZ2enZYeU5wQ3RlQjZ3ZWtsVHJKNnhjSzVTNGhBUkFaUnVP?=
 =?utf-8?B?Z3k3L0dHMkNPOUFvQmFVT0pLdnNPWHowaW01WG51VXhLRHRVR1BrdVpiWWUv?=
 =?utf-8?B?SnJMZHZST3F3YW5mNHlGc1doT0MyWnFzcGtRTHlxZW1vb01teDkwRTVpMS9Q?=
 =?utf-8?B?U3Zqc2dQQVg4UnFjdlhac214VnB3N21ndWl4VGRia3AvakpNdWpoMk1MeC90?=
 =?utf-8?B?WnhiY09kUnYwNTlUNHZQM3FCOTNYZHlEaFNjN3dRb2hhSko5b3VRZmNyK3BE?=
 =?utf-8?B?RWpFTGVRNDF0dkIrUDArdktKdmg3VVVldjdBQ0hQajkzbFJla3MwazdreTRN?=
 =?utf-8?B?VTgyYnRDWm9OZE5NMUtwc0xWQS9WTWplbWdKWkU3alVVcEFjODJiSUNBSFRC?=
 =?utf-8?B?QTk2c1RHTlo5UXRwQWxJdkg2MFFsT1ZLbEVKRmloUTBSZ0M3Z0pQaHhjTC93?=
 =?utf-8?B?cHpuNkxHak5RUFg0K2w0YnZSeVh5Q0svd2pmK0J2QWpFSFQ3MlB0R2Nma0hq?=
 =?utf-8?B?VjNCK3NaT20wOWdkakRkcW9pUnNOZW9CckhHU3JFL3BSVlRidDNpdzlZNkVW?=
 =?utf-8?B?V3ZFWW0xbytDa2w1RVZlMTZPUDgrT3NxZ3B2WGxxN3BuL3B1K2pFeHZTdzg2?=
 =?utf-8?B?N1dadXFvVW52elB2eCtEOHM2NittWlZ4WUQzSkZ2NHp6VjFKL1p4SDRINmxh?=
 =?utf-8?B?Umw1Z1RYcWVxdnRHVVFUL3pjcmVrcERuNk5qdnZ6M0dWbHpZWFVZOXNiMGYw?=
 =?utf-8?B?WFJRQ1NYaWpHV3J4Q1IvTGM0QUVId3JFcENDZGozUWVRbi9HcFMxUjJYQ0F4?=
 =?utf-8?Q?1U4nPeOUYwrN9jCzdX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e2c2b3-7893-458e-3892-08decab53f74
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 08:08:13.8603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLujpHEBpzfNb1yPLb6AFF3OraZnnv1O5vgCOeKpHtocGl0wIflL8IcqNOdLJ0RX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883
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

On 6/12/26 15:20, Huang, Honglei wrote:
> On 6/12/2026 8:02 PM, Christian König wrote:
>> On 6/12/26 11:09, Huang Rui wrote:
>>> From: Honglei Huang <honghuan@amd.com>
...
>>> +static inline void amdgpu_svm_assert_locked(struct amdgpu_svm *svm)
>>> +{
>>> +    lockdep_assert_held_write(&svm->svm_lock);
>>> +}
>>
>> What exactly is that lock protecting?
>>
> 
> this lock is the driver_svm_lock required by the drm_gpusvm framework
> It is registered by drm_gpusvm_driver_set_lock(), and drm_gpusvm lockdep asserts it on every structural entry point, e.g.
> drm_gpusvm_range_find_or_insert() / drm_gpusvm_range_remove().
> 
> Per amdgpu_svm it serializes the write/commit side against the fault
> handler: range/notifier tree insert+remove, attribute changes, and the
> garbage collector.
> 
> This is the same thing xe does, in drivers/gpu/drm/xe/xe_svm.c:
> 
> drm_gpusvm_driver_set_lock(&vm->svm.gpusvm, &vm->lock);

This is clearly incorrect in that case. Our equivalent in amdgpu is vm->eviction_lock.

That was already completely incorrect in the old KFD implementation, please don't use that one as blueprint.

Regards,
Christian.

