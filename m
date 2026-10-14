Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA36CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:17:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C7210FCF8;
	Wed, 14 Oct 2026 12:17:54 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011022.outbound.protection.outlook.com [52.101.52.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A267A10FCF8;
 Wed, 14 Oct 2026 12:17:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1z9vN/rS/S4+v2R4qy184BUnwO4VNq4C65pXaQuNxHojdaiPpdYlPQ12k/+Tfv6VA6rLHVjlto5oZhtXJCQEp71+C8CJkZgimaAjx2jUH/oh8YcsV711xv3Ck17Ngh64yTJWvv7m1M+q3qbX5yBU/A59te6HFjJMEk7dWPBJFCj1DdxXgjpdFqcdIrgCKVErs0UO0gNrCo+mnPEI4mF0dNMl+ZCkP9g/1Dyt8M2pPS5f5rm0ddGaASyh0/Fll7TAAMHZTKYzGbjjhBElW/UUBBCwiQbmu6hSeoSIm0bfWBz4pZvbrb7xO0f2zkFRLnV8ShuqXepOzlQAwv7kEOZ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+gNEIKTHvJ/3ICZKuP+POUfb3V7FW5mUNbd8OlUqdQ=;
 b=atfsNyNAj5lcl0iOdjmS6R8zlAc/vUXAzf24XM7868qf5xJ4Sp0o5r/zFaxWv15yoVcQdZyS33+Gqyj9CjNhieCsnrd5DyXrhMpMOGTYPLwklZlZfumslyAAZpgWM4ZdGNaQ/F/6INe1AflSaIN7mimE3gTQofjBjJ9xn0jNr1sFMOgBGfsfiKT97s7NpB+D9r46PFo001IZnoB9XDHpdwDzUrPDXKgAiL5I5rxjIDLn26ysREZucgRXZIp2a/dXhRSfFQBH6nV7g1YQP4ouDird51mJRbHPd9HcaiGPnkX1nCoiT0h9IiReJ1AeiFw3WYdjWsssDuQ0teURRZnNew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+gNEIKTHvJ/3ICZKuP+POUfb3V7FW5mUNbd8OlUqdQ=;
 b=jJgz6G5t529G48LLbNCVlhFkZelJ7Qu4DBazwWKljsHM/o+TPl/YuhR73X2gY6VQSjrYN22hbtCOn2hL0nI8phDpJ2KaF6gnObzqTnijxlzeDHCgYH0e2Nq7NuNzr8hD6NqgQjazDcFvJzbDoX3vGz3y0xcTlaW3fu+JRGsg58c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS3PR12MB153673.namprd12.prod.outlook.com (2603:10b6:8:611::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 12:17:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 12:17:44 +0000
Message-ID: <1ebc177e-2e44-48f1-a462-ff5a64b63d7e@amd.com>
Date: Wed, 14 Oct 2026 14:17:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/exec: don't immediately add prelocked obj to array of
 locked objs
To: vitaly prosyak <vprosyak@amd.com>, vitaly.prosyak@amd.com,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20261007124657.9664-1-christian.koenig@amd.com>
 <0b8f0025-0a76-47fd-b4e4-bcab26f70366@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <0b8f0025-0a76-47fd-b4e4-bcab26f70366@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS3PR12MB153673:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b9cc575-80ab-4101-4a6e-08df29ed2684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|4143699003|11063799006|261009223027099003|260925021311599003|260925022911599003|260925021911599003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xg4GP3QAvnqRgUEaeA2LgnmfTcwhCM5bIO07c8ZWiXz9nlTgFZVGdPIP9PFt3rNeZ1oq3YuNlGzfhaVBdhr2K4+1S3jyYW2loyuJ5Y0OkNeSbsDdX40WlAg+RL+y2wBPA1j3x6BtFbrDiD5EVIoT+7s2WEhH3cqUsq1QFRM/BYQLZLfoz5SNhBZ/m0of5oSPDRkk22Mqc+JN9oExITkc3NS88H7y+u7Of/45EBE9ftCSQPzhy1mCcaQvBuc+NJ7gKODL85TrZLi5z5WA+KsVjokTS+QfGdSfUtiENCy2PIhqboI7SKpYhbG2LcrP4XumeEs8zB/ErHxAKDpYybtHq7HfZ51WwNBS/UX7tp38WB9SvFetKS62LfvHPFFl3XBiRnJ+tGcfS0nTydDCsoAY2zpsGMawXXrht7woSniKt7GWf1trERSxWVts2ecFhH9uVwq8czbM/rpf8FVIqc/y+j7WfuWnyjSh3UYAfmV/1pq7hsUeVQeHZehAmUz1fEesO4AU5Dmm+PTGJDT2fT0iBeAudmVEZliI3IFbEiGiy+wKggnj8PPs9zXDRHVdGCqaU7D4qpXeSGJYDopK1CR5pUrXvT9toQ17Gv5+h9Ho8rZUS4oCOrb72Ua85PxY+PCWKFNV/il/NJbk0BZquyQ3DPUIhtwjZ2E2eAE/kxlYAnM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(261009223027099003)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elRiall2aUNGbUF5S08ybkVic3dLL0xaTUIrVDRXYTFTbXQvdklhVDVsTFZ4?=
 =?utf-8?B?bTNXTDhvejY1K1J5Z242WlppWDBJWXlLeFlqeXNBcGVtN1BTMEs2UG1IckI4?=
 =?utf-8?B?bEt4V2xybEpxZXNLVUtOS25BQ1J2STUyNzlUZi8vR1NXTkFVZ21GcURqN1FH?=
 =?utf-8?B?aHdnUy9oQVkrM0Vub3BqRHBMaFkyQ2NIazQ2dHhUQlkxYVMwUzNhOGk2Q0ZD?=
 =?utf-8?B?YUVwbDNUSDV3U2JNUHpIalZRWWJYcmVvQXVlZTdCM3h1THVUTjkvWmY3UDJQ?=
 =?utf-8?B?YVdYc2ZkaW9BSVJPSVRVZTZqYWFReFhVZHE1OEVSN1o4THE1VFV2RVREM0Nz?=
 =?utf-8?B?UVVpeGQwQ1hybTJ0WTN6S1M5MFY0MkdHOGJXNzhTVjdYQ214WGZQRlRKS0wy?=
 =?utf-8?B?Z2FHNUZnV0pwSnE5Sk93ZEhBUmRSYlBianhGMWRlakEvcUswWmRnanh3eksw?=
 =?utf-8?B?cU5RK2NaQm9RazE4ejZlNjhOekNKdHZERGN0YXhwcHBnTUhPTlg1UXhES1Rp?=
 =?utf-8?B?em93SFQ4ODhNSjNKVnI3SWxVOFN6S2NOa3A1NTk1WWo2TGpEUEVrTXd3SFZ5?=
 =?utf-8?B?UHJCWkVTNitRZVhOYkV0S3l3OE9vNzQ5L29rWEdTYVV2c1YyRG5jTUtocFho?=
 =?utf-8?B?RXFUZVlDQUl5WEo2SVdHSENlalg1aldxVFI5OGFodlYvS09VMGJ2T2NCZXBn?=
 =?utf-8?B?dHIyUmQ2TXAxT25jQkFwYmxSVmlDRE1UTjRuSlNBUVovL0E4VEt1U3FWcnl2?=
 =?utf-8?B?ODhJM2l1b0s1MmJCZTc3alFHc2JwQ0lPYm9kRGlZZWhMRy9FMzlMWmoxZHZ3?=
 =?utf-8?B?RUNEem5HNzNibWpCYXpHalpZUlVKdWxMRGtQTWJ6aWFrWlQvdVhnYXdzSkVH?=
 =?utf-8?B?TUp6ODZXdFVsSHBHaEZFSnVnM21hdVdmUUdsT0t2YjhGeVNGZDFmL2FwVDVV?=
 =?utf-8?B?WXlTVjhwK05reGtOVTRublVtM3A1Qlh4em5kNDdOSlMwdEhHSVRJYTFvNHhl?=
 =?utf-8?B?WnVUM295YXppK2tXUE05Z0xYUkZkb2VBd2hpT2RDYTNiTEU5VHVGY3c2Q1J1?=
 =?utf-8?B?ck1GSTJ3VDRNMkxRZjlxRkxJaDhLdFEwNWVaREMwTmY3aStFUkZZQkJ6R0RP?=
 =?utf-8?B?TmZucTc1bWs3NktKaFg4a0Rxd3pwWXpCdUJaRnRZczRWY2NsSXE0bXdrODRq?=
 =?utf-8?B?YzlaSi9LNVllY3pNalpZUFExVVRaV1BzSVljYkNYRkEyTmpkYXF6a3RVS0dZ?=
 =?utf-8?B?VFVKTHBBcEtkczRVRElEaXRmeFBEZkM1b0ZENGRMTU1aK0lUc2lGTUpZRnVE?=
 =?utf-8?B?LzhuQytScXkxMUdSbUt3bWV5REE5ZXQ0ZWlmV3ZKMnQzN0V0eDNHcTBDVyts?=
 =?utf-8?B?RXEwTFJDTlVWZStEUGtsZUVEcGIrRVJaRVZIWmRiVE5YR3cxL1E4TDl6Njli?=
 =?utf-8?B?b0ZPQ0lSeTZQZmJQaklWb2RKeVVMbEhZMWwyQ1JEaWxlQ2F1N29Zei94T25O?=
 =?utf-8?B?WWxZM29yVU0xNVhjVnlDVUxuL0k5ZlhwRExkN3J2enlud2piWWVEcGpzZ2o4?=
 =?utf-8?B?RGpjdUdTMW9wa3I4VjQ1QThqdnJtK1Q0d1RtQkNHRnQzMkVWQktic3dBRFJO?=
 =?utf-8?B?aXJaSG9ZTTZMd3hjZFhyYUhFSExDL0VrRjExbXVxb2N1OE14bE9xREVLdFI3?=
 =?utf-8?B?Zlcra3lxMHVJVDBjeThqbDRlcGpMVWRpQWtXUlpLcDFIbUQyZVFSdTVhdWZI?=
 =?utf-8?B?eGg3UXJiR0ZzZUxvVU8zdnB1MEN1MkxIUCs4dzAzZDBiN20yWWFTWEYyb1Fj?=
 =?utf-8?B?aTBDRmFyd3V6KytnbHRwTDZxN2hNUlZJZFRwMGxMUjB2Q2wyUFJaVlE3QTI2?=
 =?utf-8?B?Z0w5TlU2TGJsMWRUdG1Mb1R1K240c1Zwa0pyVkRseFc0ZGl0QTRsSEhIT2hp?=
 =?utf-8?B?bm5SZXVHbjV4ampSTUpLaGo0Q2ZBYytlZ3lmY1BacGhDU3VTZXhjMzI3OERO?=
 =?utf-8?B?dG5lZit4bVhoY1k3a2VTVHpTVTdjL1pNUTdwVUcyaUVMV0c1WU9GcmhLREsx?=
 =?utf-8?B?SFI0OExuK1hPOVN3RVZlV3F0MGdJZFhGNS9QekJMTlNDRHZWaG0vdUNaL0Fv?=
 =?utf-8?B?TDNxdkdwM205Zm1Ka2VSeEJWRFVpU0lnWlNxbHpTU3l3NEhlSVJ2SGNxbUhC?=
 =?utf-8?B?NjZUS1IrbzFidmRKb0RNMjJ5VTUwczdDQjJrNFpXSVhJb2JLL3VJUU5XM0pE?=
 =?utf-8?B?T21lRkNRbG91bkZJblR1Z096RzhBb2s2SGtEOWxpM3UwQVBVUk93ZlEwQnR5?=
 =?utf-8?Q?27sx8Cr7Er2jPDh82S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9cc575-80ab-4101-4a6e-08df29ed2684
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 12:17:44.5025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2M9gfBmn4HqQreZcKTnm7xtj/d+Zi/HsPyds615nyAJ88ZuhyeX3cYZYqrmgXWx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB153673
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

I've pushed the patch to drm-misc-fixes and are now going to push it to amd-staging-drm-next as well.

Thanks,
Christian.

On 10/8/26 18:17, vitaly prosyak wrote:
> Hi Christian,
> 
> Thanks for the fix. Tested under the same conditions that previously
> reproduced the crash at dma-resv.c:329; the crash did not reproduce
> with this patch
> 2026-10-03T16:00:58-04:00 Intel-system kernel: kernel BUG at drivers/dma-buf/dma-resv.c:329!
> 2026-10-03T16:00:58-04:00 Intel-system kernel: Oops: invalid opcode: 0000 [#1] SMP NOPTI
> 2026-10-03T16:00:58-04:00 Intel-system kernel: CPU: 11 UID: 0 PID: 477 Comm: kworker/11:2 Not tainted 7.1.0+ #83 PREEMPT(full) 
> 2026-10-03T16:00:58-04:00 Intel-system kernel: Hardware name: ASUS System Product Name/ROG MAXIMUS Z790 HERO, BIOS 2703 10/17/2024
> 2026-10-03T16:00:58-04:00 Intel-system kernel: Workqueue: events amdgpu_userq_restore_worker [amdgpu]
> 2026-10-03T16:00:58-04:00 Intel-system kernel: RIP: 0010:dma_resv_add_fence+0x2d6/0x2f0
> 2026-10-03T16:00:58-04:00 Intel-system kernel: Code: 44 8b 88 30 0a 00 00 48 05 18 0d 00 00 50 4c 8b 45 08 48 8b 75 b8 e8 f9 01 35 ff 58 41 8b 45 14 41 39 45 10 0f 82 d2 fe ff ff <0f> 0b 31 d2 45 31 ff e9 ba fe ff ff e8 c9 a5 5c 00 66 0f 1f 84 00
> 2026-10-03T16:00:58-04:00 Intel-system kernel: RSP: 0018:ffffcb8682e5fb28 EFLAGS: 00010246
> 2026-10-03T16:00:58-04:00 Intel-system kernel: RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> 2026-10-03T16:00:58-04:00 Intel-system kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> 2026-10-03T16:00:58-04:00 Intel-system kernel: RBP: ffffcb8682e5fb78 R08: 0000000000000000 R09: 0000000000000000
> 2026-10-03T16:00:58-04:00 Intel-system kernel: R10: 0000000000000000 R11: 0000000000000000 R12: ffff88edd40ca500
> 2026-10-03T16:00:58-04:00 Intel-system kernel: R13: ffff88ed91d83f00 R14: ffffffffc1c3ee60 R15: 0000000000000000
> 2026-10-03T16:00:58-04:00 Intel-system kernel: FS:  0000000000000000(0000) GS:ffff88f53e2bc000(0000) knlGS:0000000000000000
> 2026-10-03T16:00:58-04:00 Intel-system kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 2026-10-03T16:00:58-04:00 Intel-system kernel: CR2: 0000756822dd7000 CR3: 000000012e1d4006 CR4: 0000000000f72ef0
> 2026-10-03T16:00:58-04:00 Intel-system kernel: PKRU: 55555554
> 2026-10-03T16:00:58-04:00 Intel-system kernel: Call Trace:
> 2026-10-03T16:00:58-04:00 Intel-system kernel:  <TASK>
> 2026-10-03T16:00:58-04:00 Intel-system kernel:  amdgpu_evf_mgr_attach_fence+0x179/0x330 [amdgpu]
> 2026-10-03T16:00:58-04:00 Intel-system kernel:  amdgpu_evf_mgr_rearm+0x1ff/0x2b0 [amdgpu]
> 2026-10-03T16:00:58-04:00 Intel-system kernel:  amdgpu_userq_vm_validate_and_restore_queue+0x8f0/0xc80 [amdgpu]
> 2026-10-03T16:00:58-04:00 Intel-system kernel:  amdgpu_userq_restore_worker+0x64/0xb0 [amdgpu]
> 2026-10-03T16:00:58-04:00 Intel-system kernel:  process_one_work+0x22e/0x780
> 2026-10-03T16:00:58-04:00 Intel-system kernel:  worker_thread+0x1db/0x3d0
> 2026-10-03T16:00:58-04:00 Intel-system kernel:  ? __pfx_worker_thread+0x10/0x10
> 2026-10-03T16:00:58-04:00 Intel-system kernel:  kthread+0xfe/0x140
> 2026-10-03T16:00:58-04:00 Intel-system kernel:  ? __pfx_kthread+0x10/0x10
> 2026-10-03T16:00:58-04:00 Intel-system kernel:  ret_from_fork+0x3bd/0x470
> 2026-10-03T16:00:58-04:00 Intel-system kernel:  ? __pfx_kthread+0x10/0x10
> 2026-10-03T16:00:58-04:00 Intel-system kernel:  ret_from_fork_asm+0x1a/0x30
> 2026-10-03T16:00:58-04:00 Intel-system kernel:  </TASK>
> 
> 
> My patch preserved the fence-slot request across retries. Your approach
> instead excludes the implicit prelocked BO from iteration until explicitly
> requested again, avoiding the extra reservation-count bookkeeping.
> 
> A few minor wording corrections:
> 
> - "keeping the prelocked object of the array" should be
>   "keeping the prelocked object out of the array".
> - "Should the prelocked object never been mentioned again" should be
>   "If the prelocked object is never mentioned again".
> - "might never given to" should be "might never be passed to".
> - "unecessarily" should be "unnecessarily".
> 
> Tested-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> 
> Thanks,
> Vitaly
> 
> On 2026-10-07 08:46, Christian König wrote:
>> When a contention is detected the drm_exec object grabs a reference to
>> the contended object, unlocks all other objects and pre-locks the
>> contended one before anything else.
>>
>> The problem is that it is possible that this pre-locked object was about
>> to be destroyed and drm_exec is now holding the last reference to it.
>>
>> So we never actually see this pre-locked object again to be explicitly
>> locked and so also never reserve a slot for a dma_fence object on it.
>>
>> Should the driver now use drm_exec_for_each_locked_object() to add a new
>> fence to all locked objects we eventually see a warning or even a
>> BUG_ON() to prevent random memory corruption.
>>
>> Fix this by keeping the prelocked object of the array of locked objs
>> until it was explicitly mentioned by the driver again.
>>
>> Should the prelocked object never been mentioned again by the driver
>> just unlock and drop the reference at the end of the locking loop.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Reported-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
>> Fixes: 09593216bff1 ("drm: execution context for GEM buffers v7")
>> CC: stable@vger.kernel.org # v6.6+
>> ---
>>  drivers/gpu/drm/drm_exec.c | 73 ++++++++++++++++++++++----------------
>>  include/drm/drm_exec.h     | 15 ++++----
>>  2 files changed, 52 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
>> index 2453ec41360f4..a910b0ad17ce4 100644
>> --- a/drivers/gpu/drm/drm_exec.c
>> +++ b/drivers/gpu/drm/drm_exec.c
>> @@ -48,6 +48,16 @@
>>   * See struct dma_exec for more details.
>>   */
>>  
>> +/* Unlock and put the prelocked obj */
>> +static void drm_exec_drop_prelocked(struct drm_exec *exec)
>> +{
>> +	if (exec->prelocked) {
>> +		dma_resv_unlock(exec->prelocked->resv);
>> +		drm_gem_object_put(exec->prelocked);
>> +		exec->prelocked = NULL;
>> +	}
>> +}
>> +
>>  /* Unlock all objects and drop references */
>>  static void drm_exec_unlock_all(struct drm_exec *exec)
>>  {
>> @@ -58,8 +68,7 @@ static void drm_exec_unlock_all(struct drm_exec *exec)
>>  		drm_gem_object_put(obj);
>>  	}
>>  
>> -	drm_gem_object_put(exec->prelocked);
>> -	exec->prelocked = NULL;
>> +	drm_exec_drop_prelocked(exec);
>>  }
>>  
>>  /**
>> @@ -118,6 +127,14 @@ EXPORT_SYMBOL(drm_exec_fini);
>>  bool drm_exec_cleanup(struct drm_exec *exec)
>>  {
>>  	if (likely(!exec->contended)) {
>> +
>> +		/*
>> +		 * The contended and prelocked object might never given to
>> +		 * drm_exec_lock_obj() again. This can happen when the object
>> +		 * is about to be cleaned up and we now hold the last reference
>> +		 * to it. Make sure that we don't unecessarily keep it around.
>> +		 */
>> +		drm_exec_drop_prelocked(exec);
>>  		ww_acquire_done(&exec->ticket);
>>  		return false;
>>  	}
>> @@ -175,16 +192,16 @@ static int drm_exec_lock_contended(struct drm_exec *exec)
>>  		dma_resv_lock_slow(obj->resv, &exec->ticket);
>>  	}
>>  
>> -	ret = drm_exec_obj_locked(exec, obj);
>> -	if (unlikely(ret))
>> -		goto error_unlock;
>> +	/*
>> +	 * It is perfectly possible that we see another contention before the
>> +	 * first one is fully handled.
>> +	 */
>> +	drm_exec_drop_prelocked(exec);
>>  
>> +	/* We move the reference from contended to prelocked here */
>>  	exec->prelocked = obj;
>>  	return 0;
>>  
>> -error_unlock:
>> -	dma_resv_unlock(obj->resv);
>> -
>>  error_dropref:
>>  	drm_gem_object_put(obj);
>>  	return ret;
>> @@ -212,35 +229,31 @@ int drm_exec_lock_obj(struct drm_exec *exec, struct drm_gem_object *obj)
>>  	if (exec->prelocked == obj) {
>>  		drm_gem_object_put(exec->prelocked);
>>  		exec->prelocked = NULL;
>> -		return 0;
>> -	}
>> +	} else {
>> +		if (exec->flags & DRM_EXEC_INTERRUPTIBLE_WAIT)
>> +			ret = dma_resv_lock_interruptible(obj->resv,
>> +							  &exec->ticket);
>> +		else
>> +			ret = dma_resv_lock(obj->resv, &exec->ticket);
>> +
>> +		if (unlikely(ret == -EDEADLK)) {
>> +			drm_gem_object_get(obj);
>> +			exec->contended = obj;
>> +			return -EDEADLK;
>> +		}
>>  
>> -	if (exec->flags & DRM_EXEC_INTERRUPTIBLE_WAIT)
>> -		ret = dma_resv_lock_interruptible(obj->resv, &exec->ticket);
>> -	else
>> -		ret = dma_resv_lock(obj->resv, &exec->ticket);
>> +		if (unlikely(ret == -EALREADY) &&
>> +		    exec->flags & DRM_EXEC_IGNORE_DUPLICATES)
>> +			return 0;
>>  
>> -	if (unlikely(ret == -EDEADLK)) {
>> -		drm_gem_object_get(obj);
>> -		exec->contended = obj;
>> -		return -EDEADLK;
>> +		if (unlikely(ret))
>> +			return ret;
>>  	}
>>  
>> -	if (unlikely(ret == -EALREADY) &&
>> -	    exec->flags & DRM_EXEC_IGNORE_DUPLICATES)
>> -		return 0;
>> -
>> -	if (unlikely(ret))
>> -		return ret;
>> -
>>  	ret = drm_exec_obj_locked(exec, obj);
>>  	if (ret)
>> -		goto error_unlock;
>> -
>> -	return 0;
>> +		dma_resv_unlock(obj->resv);
>>  
>> -error_unlock:
>> -	dma_resv_unlock(obj->resv);
>>  	return ret;
>>  }
>>  EXPORT_SYMBOL(drm_exec_lock_obj);
>> diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
>> index cc2937185a9f7..c92d69a2c793d 100644
>> --- a/include/drm/drm_exec.h
>> +++ b/include/drm/drm_exec.h
>> @@ -73,13 +73,15 @@ drm_exec_obj(struct drm_exec *exec, unsigned long index)
>>  
>>  /* Helper for drm_exec_for_each_locked_object(). Internal use only. */
>>  #define __drm_exec_for_each_locked_object(exec, obj, __index)		\
>> -	for (unsigned long __index = 0; ((obj) = drm_exec_obj(exec, __index)); ++__index)
>> +	for (unsigned long __index = 0; ((obj) = drm_exec_obj(exec, __index)); \
>> +	     ++__index)
>>  /**
>>   * drm_exec_for_each_locked_object - iterate over all the locked objects
>>   * @exec: drm_exec object
>>   * @obj: the current GEM object
>>   *
>> - * Iterate over all the locked GEM objects inside the drm_exec object.
>> + * Iterate over all the explicitly locked GEM objects inside the drm_exec
>> + * container, except for the contended and implicit prelocked one.
>>   */
>>  #define drm_exec_for_each_locked_object(exec, obj)			\
>>  	__drm_exec_for_each_locked_object(exec, obj, __UNIQUE_ID(drm_exec))
>> @@ -94,12 +96,13 @@ drm_exec_obj(struct drm_exec *exec, unsigned long index)
>>   * @exec: drm_exec object
>>   * @obj: the current GEM object
>>   *
>> - * Iterate over all the locked GEM objects inside the drm_exec object in
>> - * reverse locking order. Note that the internal index may wrap around,
>> - * but that will be caught by drm_exec_obj(), returning a NULL object.
>> + * Iterate over all the explicitly locked GEM objects inside the drm_exec
>> + * container in reverse locking order. Note that the internal index may wrap
>> + * around, but that will be caught by drm_exec_obj(), returning a NULL object.
>>   */
>>  #define drm_exec_for_each_locked_object_reverse(exec, obj)		\
>> -	__drm_exec_for_each_locked_object_reverse(exec, obj, __UNIQUE_ID(drm_exec))
>> +	__drm_exec_for_each_locked_object_reverse(exec, obj,		\
>> +						  __UNIQUE_ID(drm_exec))
>>  
>>  /**
>>   * drm_exec_until_all_locked - loop until all GEM objects are locked

