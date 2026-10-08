Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A9FCA6013
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 16:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0F6210E3E8;
	Thu,  8 Oct 2026 16:17:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R7837uWe";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013032.outbound.protection.outlook.com
 [40.93.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85DD110E0A4;
 Thu,  8 Oct 2026 16:17:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTtHZ/5IXxLDgahmxYtWLG9jJpxe0oexS1nX3Jibe5bDOSutd66z96OI4H60qL2fyu/pFcldQTJRsHJv9uKhTPktzzndCuPcSvJzeD2docBa8TzJ4gYZc92NnJqApokXvTnAm5lGo2RkwGn0jORGerPBDiwekpLuoEvZ29F+6PawEPnLbdrcySav2yGhcnk2alGbRvF2hBUyHzyjcjHhbG/nuOpFdMe2TcMKTe0Yi80VZ//4gPMdwwVaUE5YwCRUL3aTJ4b7BS+HSoN9XAfUgKfqteVfue0MWf10NWYjszYPQguKktfzpYFl/Ij/MufS58sj2VezgQJN7E9D89Q0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOADTAPMxMPXmDXEnbe3pLYrYlGgX1aF/eSDpwqjqL4=;
 b=uOPRIAMbBKQjbD80fkjM6eVnX1OsuYHbf4KdmNz56ysqp9ZE17JFERKROGEx/53jcuZSx53sesTCeIeTmoBA9CiFZH4s8hTq6rzj2rxA/syJ8wE2nTTHILU7YH8A/vRmBoTYLVh2gi52637PVnYd4TeExC/fZCr47dU9eYUBqu5UV1t/DItcFYPU89AKMIVtclwN6u2ghbFrWleek+Q26YezVFSD7DTosyAk+K/TgJEGI2tyM654Hy9A72xuuwHSAEppyatC4XIiRDXRSVKPk8DJCcSpUAimdPTm/ILgu++FunXnPSNe9pRjGAzw0ifkhuJGHwCy5FoF86FhbSWhWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOADTAPMxMPXmDXEnbe3pLYrYlGgX1aF/eSDpwqjqL4=;
 b=R7837uWefNVq1uGjSDPWG1v/v6PWPnRwzSwfe/iBAzIfSca+YGDqXrCDFG/rc7ZPTWzxc6wPn7xVBL9kqVbDuqd9PBn8RcJaDByLoAa+1qe873A1laJZEaZbytJKe8pH0nstOTL2UBU7b/HqLaoVpr8GphrZQJzBqPL+xpdxgBs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB449095.namprd12.prod.outlook.com (2603:10b6:8:4fe::22)
 by CY5PR12MB6060.namprd12.prod.outlook.com (2603:10b6:930:2f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 16:17:31 +0000
Received: from DSVPR12MB449095.namprd12.prod.outlook.com
 ([fe80::76a6:7a4f:a0a5:18c0]) by DSVPR12MB449095.namprd12.prod.outlook.com
 ([fe80::76a6:7a4f:a0a5:18c0%4]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 16:17:31 +0000
Message-ID: <0b8f0025-0a76-47fd-b4e4-bcab26f70366@amd.com>
Date: Thu, 8 Oct 2026 12:17:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/exec: don't immediately add prelocked obj to array of
 locked objs
To: christian.koenig@amd.com, vitaly.prosyak@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20261007124657.9664-1-christian.koenig@amd.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <20261007124657.9664-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0347.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::18) To DSVPR12MB449095.namprd12.prod.outlook.com
 (2603:10b6:8:4fe::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB449095:EE_|CY5PR12MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: 64bcbfaf-12f3-4451-134f-08df2557a76e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|10067099003|260925021311599003|260925022911599003|260925021911599003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: m06PKKjSZgRWH3kD/3YwgFIY+iUSgo8XH1jSVSlvZRhRU5XjAbN0vZIoeH5+/UJfo3P8rR27cgnWnjfSYkP/TgFCQzYd83FWZQRMHApj7/Q2UEgz4k8MuvKEMJUHvy5iK4xGtsb/NIno/y8tC6NGrHYuxwaBpgke5rZjzr3XKDm814IGd2LO4M8MkFRsVUcfVkv15fo04jOs5LacDV1Rd6kUyGEIEGqons27NBJig1kD6o+jOoO/yr6xjDCIGESxfrOgaaBzGLWxJ2aiO4PJTJzqe6Isz6HsMQXbTU8zKc5qoof3J4gG7XY2ZKKxUzoBxsBojOE2DTNI07JQmRv2xzj32jJkOfJbELJhCaLo3BSI8xdBZ3W8eK8lKhl+oy52/Enc2BbXEgm+fyBOst2RF6GXlvLQ57dG6KSxDJ6jNeIEjQfSh/klwrvO8XA8mCN4i05xEI2RE+J3wzxPHx2BKpqFc/vnmI906eDniAML68iCrXBlAqcqfjaObIZEqVvfjYOyqvNjYNGAaMmw6lavMmgQFQBl1PHe0zBtSQI8Tdos0ki0a25PxDfDQLE3D7xPSc69OGGAnopnSbXYRYK9wJaRt10bgyvAJwavLyfCnLMo8Pp/Qieq/QmC7QnN/2UfUbiVQ+T7AcT6TBUUWgO9KE5A6k3I4AcLerfZIMxcyWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DSVPR12MB449095.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(10067099003)(260925021311599003)(260925022911599003)(260925021911599003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUVaQkZKNDU4SVNubXZmOWxUODg3cjJMbkRpK21PVEdudUo1ekNwSlJSWm5n?=
 =?utf-8?B?SDlqQTJpRG5LbXk1Qm15Q0lXb2hGcnlSRWVxakU1dGtxckloTWp0endNNjcy?=
 =?utf-8?B?dDFNbHMwZXFBY1c0QlhFNkdZL1ExT3liVjhCcHBWcWxER2tFbjUva29QdWIr?=
 =?utf-8?B?UWJtQm5WaDBtb0UzSjZ0T0VsZC80R2ZXVkJ6THFoN2s4eDYzSkw0cU1ZQlBW?=
 =?utf-8?B?b0N1bURZQTNiREc4TlA5Zk4rNmhYUnVsSmNFYTd3eE1XSUNRZzdyRzA5YXcv?=
 =?utf-8?B?RXJud3RZYWwzd0dVSEdYRDVFSWVxVEF1M3pMbWR3NGN1K1F3dzRMV04xUzlW?=
 =?utf-8?B?TXA4dUM0WTlCYkoxZGtJYTBNTE5YRUh5TTgvQi9UN2M1VTBqS2FMT2hwRVpa?=
 =?utf-8?B?dzJQYmROV3FOOUtMUW5KOE9oWCtOVjF0TlM2SHNlMUh5c0tCcGJFUzJNL2Zu?=
 =?utf-8?B?aHlIbU16YTRqSjNDZ2EwdGxCVFh4MEpTaDM3cTNRSzNJc243OElZWUg2QXIy?=
 =?utf-8?B?eWhlWTZ6dEhBejBSL1ZOSFJmVXRiV2V1aEgvRCs1Mmp0S21td1R1SFViNVB5?=
 =?utf-8?B?N2ZCMUg4Z1ZhWWtTcXRQNGJ2NThPWFowZ0FxbmpueWIydHJGOFROMVZnZnB4?=
 =?utf-8?B?TVBjaXhoS25RU2piTUowcnNXc1JzOUpLTUErQk1sUTI0OUc4bWphc1VIa3BY?=
 =?utf-8?B?RjFZSkRMdHB2RzhVM1BNS0pERHNTVFZnT2hncDQwZ21mcGVDY3ZUWVpCaExL?=
 =?utf-8?B?dS9pS3VYNmFKWlVWMm1DUnNlZng3WnFMaTRHeVJEa1F4M0VPSFdmc3Q1TlZo?=
 =?utf-8?B?YlhPODB5UGpIQnZ6WHdvSE02eXNuNVMxL2JjRWE0UUtoTUpZSHZCQ1ZHWWlQ?=
 =?utf-8?B?VW11QVErclJGUURQajNlRFlLTTVRU29ackt2WGt1eVlpb2p1SjFIWkhRQy9m?=
 =?utf-8?B?UWgzM0liR2ZocmI2ZTlwVDFKM1AzTys1RHIzSGcvY3lMcnR4dzYxd2x0d1Mw?=
 =?utf-8?B?Q0VTRXVrSWZXL29tNFJteUExalArbGZlL0tXRlFMV0dYcHpUUWlsb3R1a2U0?=
 =?utf-8?B?TTlFL2hWS1NiTlg2MmdxNDNkdy9BMlU1enZubkJkU25FWGlkR21DTE9WdSsv?=
 =?utf-8?B?V2VYNFptMTFRTjI5TXNLc0VwTUtWZWcyV1MvWm1sVFpTTnk3MEZDVlZhQmd0?=
 =?utf-8?B?RTVNajIwdm81cFNWTEU3bDNDazhUTGtUb1JLTTllWWN2ZnhvcXA2djhFb3RW?=
 =?utf-8?B?cFozd3lhV0Z4RVpLRnRNaHJnL2VlR3ZEOXNkeG1HWkp0alZWWTRqSHVLeGlK?=
 =?utf-8?B?NVA2MERFOTlFa2M5Q2xKV1hOZUI5QXhwWnE3Q2l5MTNyekVtcFYyTUFTWk04?=
 =?utf-8?B?ZkMwZUhQa0twZWQ4QVFmL0p2Qi9rZUdtNnNlYXltcVBzd3oxMTJTc2dSWE1x?=
 =?utf-8?B?WjVXOWlKWmtDTnRYcmNIVDh1SVNFbU5mSlIvcFF0WEQ1TzNFWUY5SDFHN1FK?=
 =?utf-8?B?NEV4SFRpWDFJZDJvZmtZUHBNZUJtdFRubU9tMHE3VHUrQk1VZzNEZ1NBSXVF?=
 =?utf-8?B?OWN1NXVzaHVTM1E4UXhMcThUU0lFVFhHY09RYkt0dkUyRW5PVnRzNmwyaFBM?=
 =?utf-8?B?aEx5bi9EMW9zS3psRjVTRk9yYmZRdjliMk5pSGFXazRYaHJtT09HVjJkS21t?=
 =?utf-8?B?bld6T1RUcU44cDcvRDVyOWpacWVGd1pxTkpDK3Y5LzdHM1BwV1JwWHdQbXNL?=
 =?utf-8?B?blpNSkxFYzl5L1Y5VXVxS0pVeE9XczRQTk9XL0NGeXRqa1grUFkwd0E5S1Qx?=
 =?utf-8?B?d0tqRXRjSWppQ3FMSXJpZzVsc0NlS2cwWUl1a2JtaXRYVCt2MXNjV3VYc2U0?=
 =?utf-8?B?NkxXKy9UUTNrV09iNkFjbFYwbWNhNHIxQVY3V09iNVFBMEVpQkoyTng0d3Q2?=
 =?utf-8?B?NlJZOWh5VnFFYjRBL2JzN3YwMXE2NERndDRNd0VYTlcxNzRqblhXUHdJb094?=
 =?utf-8?B?NnFGTThHSXhXWW8rRzFYdXpXVldKK044WTMvcVh2S3psNXlkaGpnSjhNVGo0?=
 =?utf-8?B?RzJYUkZNem03bzdoQWZkNzMremFtN0FoUm1jd3QzL3ZEZ3BjUnJlMThHTG5H?=
 =?utf-8?B?KzduazZrWURvaTNqb2x5VXNqWkN1bTFkQUVBWXVMbXBHWHVqeXo2QTBqQ1gy?=
 =?utf-8?B?MnlQQkhVa0FzUjg3QlRDTXBqZmhBdEUzYlZ3SkhtbjZUTVNZQms3S2lJU3RN?=
 =?utf-8?B?TjYyZGNNbnhNdG5OUk52ZU5rSVlidmhjSjl2bU1OVXpQUEYwS2poalJIeGZ1?=
 =?utf-8?B?ZVptdnRxK2Nua1FscTJvTS9hNm5RUlp1RmdBc01HSm9ORFVVYzYwUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64bcbfaf-12f3-4451-134f-08df2557a76e
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB449095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 16:17:31.3244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3FMyQVcKk79sOux774oxjR9zI3dxrQQ0yv0jdHFk82++fShqRt/A32sV3ZE3wc32YEgcLLi2U44k2ac6LxBIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6060
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

Hi Christian,

Thanks for the fix. Tested under the same conditions that previously
reproduced the crash at dma-resv.c:329; the crash did not reproduce
with this patch
2026-10-03T16:00:58-04:00 Intel-system kernel: kernel BUG at drivers/dma-buf/dma-resv.c:329!
2026-10-03T16:00:58-04:00 Intel-system kernel: Oops: invalid opcode: 0000 [#1] SMP NOPTI
2026-10-03T16:00:58-04:00 Intel-system kernel: CPU: 11 UID: 0 PID: 477 Comm: kworker/11:2 Not tainted 7.1.0+ #83 PREEMPT(full) 
2026-10-03T16:00:58-04:00 Intel-system kernel: Hardware name: ASUS System Product Name/ROG MAXIMUS Z790 HERO, BIOS 2703 10/17/2024
2026-10-03T16:00:58-04:00 Intel-system kernel: Workqueue: events amdgpu_userq_restore_worker [amdgpu]
2026-10-03T16:00:58-04:00 Intel-system kernel: RIP: 0010:dma_resv_add_fence+0x2d6/0x2f0
2026-10-03T16:00:58-04:00 Intel-system kernel: Code: 44 8b 88 30 0a 00 00 48 05 18 0d 00 00 50 4c 8b 45 08 48 8b 75 b8 e8 f9 01 35 ff 58 41 8b 45 14 41 39 45 10 0f 82 d2 fe ff ff <0f> 0b 31 d2 45 31 ff e9 ba fe ff ff e8 c9 a5 5c 00 66 0f 1f 84 00
2026-10-03T16:00:58-04:00 Intel-system kernel: RSP: 0018:ffffcb8682e5fb28 EFLAGS: 00010246
2026-10-03T16:00:58-04:00 Intel-system kernel: RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
2026-10-03T16:00:58-04:00 Intel-system kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
2026-10-03T16:00:58-04:00 Intel-system kernel: RBP: ffffcb8682e5fb78 R08: 0000000000000000 R09: 0000000000000000
2026-10-03T16:00:58-04:00 Intel-system kernel: R10: 0000000000000000 R11: 0000000000000000 R12: ffff88edd40ca500
2026-10-03T16:00:58-04:00 Intel-system kernel: R13: ffff88ed91d83f00 R14: ffffffffc1c3ee60 R15: 0000000000000000
2026-10-03T16:00:58-04:00 Intel-system kernel: FS:  0000000000000000(0000) GS:ffff88f53e2bc000(0000) knlGS:0000000000000000
2026-10-03T16:00:58-04:00 Intel-system kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2026-10-03T16:00:58-04:00 Intel-system kernel: CR2: 0000756822dd7000 CR3: 000000012e1d4006 CR4: 0000000000f72ef0
2026-10-03T16:00:58-04:00 Intel-system kernel: PKRU: 55555554
2026-10-03T16:00:58-04:00 Intel-system kernel: Call Trace:
2026-10-03T16:00:58-04:00 Intel-system kernel:  <TASK>
2026-10-03T16:00:58-04:00 Intel-system kernel:  amdgpu_evf_mgr_attach_fence+0x179/0x330 [amdgpu]
2026-10-03T16:00:58-04:00 Intel-system kernel:  amdgpu_evf_mgr_rearm+0x1ff/0x2b0 [amdgpu]
2026-10-03T16:00:58-04:00 Intel-system kernel:  amdgpu_userq_vm_validate_and_restore_queue+0x8f0/0xc80 [amdgpu]
2026-10-03T16:00:58-04:00 Intel-system kernel:  amdgpu_userq_restore_worker+0x64/0xb0 [amdgpu]
2026-10-03T16:00:58-04:00 Intel-system kernel:  process_one_work+0x22e/0x780
2026-10-03T16:00:58-04:00 Intel-system kernel:  worker_thread+0x1db/0x3d0
2026-10-03T16:00:58-04:00 Intel-system kernel:  ? __pfx_worker_thread+0x10/0x10
2026-10-03T16:00:58-04:00 Intel-system kernel:  kthread+0xfe/0x140
2026-10-03T16:00:58-04:00 Intel-system kernel:  ? __pfx_kthread+0x10/0x10
2026-10-03T16:00:58-04:00 Intel-system kernel:  ret_from_fork+0x3bd/0x470
2026-10-03T16:00:58-04:00 Intel-system kernel:  ? __pfx_kthread+0x10/0x10
2026-10-03T16:00:58-04:00 Intel-system kernel:  ret_from_fork_asm+0x1a/0x30
2026-10-03T16:00:58-04:00 Intel-system kernel:  </TASK>


My patch preserved the fence-slot request across retries. Your approach
instead excludes the implicit prelocked BO from iteration until explicitly
requested again, avoiding the extra reservation-count bookkeeping.

A few minor wording corrections:

- "keeping the prelocked object of the array" should be
  "keeping the prelocked object out of the array".
- "Should the prelocked object never been mentioned again" should be
  "If the prelocked object is never mentioned again".
- "might never given to" should be "might never be passed to".
- "unecessarily" should be "unnecessarily".

Tested-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>

Thanks,
Vitaly

On 2026-10-07 08:46, Christian König wrote:
> When a contention is detected the drm_exec object grabs a reference to
> the contended object, unlocks all other objects and pre-locks the
> contended one before anything else.
>
> The problem is that it is possible that this pre-locked object was about
> to be destroyed and drm_exec is now holding the last reference to it.
>
> So we never actually see this pre-locked object again to be explicitly
> locked and so also never reserve a slot for a dma_fence object on it.
>
> Should the driver now use drm_exec_for_each_locked_object() to add a new
> fence to all locked objects we eventually see a warning or even a
> BUG_ON() to prevent random memory corruption.
>
> Fix this by keeping the prelocked object of the array of locked objs
> until it was explicitly mentioned by the driver again.
>
> Should the prelocked object never been mentioned again by the driver
> just unlock and drop the reference at the end of the locking loop.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Reported-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Fixes: 09593216bff1 ("drm: execution context for GEM buffers v7")
> CC: stable@vger.kernel.org # v6.6+
> ---
>  drivers/gpu/drm/drm_exec.c | 73 ++++++++++++++++++++++----------------
>  include/drm/drm_exec.h     | 15 ++++----
>  2 files changed, 52 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
> index 2453ec41360f4..a910b0ad17ce4 100644
> --- a/drivers/gpu/drm/drm_exec.c
> +++ b/drivers/gpu/drm/drm_exec.c
> @@ -48,6 +48,16 @@
>   * See struct dma_exec for more details.
>   */
>  
> +/* Unlock and put the prelocked obj */
> +static void drm_exec_drop_prelocked(struct drm_exec *exec)
> +{
> +	if (exec->prelocked) {
> +		dma_resv_unlock(exec->prelocked->resv);
> +		drm_gem_object_put(exec->prelocked);
> +		exec->prelocked = NULL;
> +	}
> +}
> +
>  /* Unlock all objects and drop references */
>  static void drm_exec_unlock_all(struct drm_exec *exec)
>  {
> @@ -58,8 +68,7 @@ static void drm_exec_unlock_all(struct drm_exec *exec)
>  		drm_gem_object_put(obj);
>  	}
>  
> -	drm_gem_object_put(exec->prelocked);
> -	exec->prelocked = NULL;
> +	drm_exec_drop_prelocked(exec);
>  }
>  
>  /**
> @@ -118,6 +127,14 @@ EXPORT_SYMBOL(drm_exec_fini);
>  bool drm_exec_cleanup(struct drm_exec *exec)
>  {
>  	if (likely(!exec->contended)) {
> +
> +		/*
> +		 * The contended and prelocked object might never given to
> +		 * drm_exec_lock_obj() again. This can happen when the object
> +		 * is about to be cleaned up and we now hold the last reference
> +		 * to it. Make sure that we don't unecessarily keep it around.
> +		 */
> +		drm_exec_drop_prelocked(exec);
>  		ww_acquire_done(&exec->ticket);
>  		return false;
>  	}
> @@ -175,16 +192,16 @@ static int drm_exec_lock_contended(struct drm_exec *exec)
>  		dma_resv_lock_slow(obj->resv, &exec->ticket);
>  	}
>  
> -	ret = drm_exec_obj_locked(exec, obj);
> -	if (unlikely(ret))
> -		goto error_unlock;
> +	/*
> +	 * It is perfectly possible that we see another contention before the
> +	 * first one is fully handled.
> +	 */
> +	drm_exec_drop_prelocked(exec);
>  
> +	/* We move the reference from contended to prelocked here */
>  	exec->prelocked = obj;
>  	return 0;
>  
> -error_unlock:
> -	dma_resv_unlock(obj->resv);
> -
>  error_dropref:
>  	drm_gem_object_put(obj);
>  	return ret;
> @@ -212,35 +229,31 @@ int drm_exec_lock_obj(struct drm_exec *exec, struct drm_gem_object *obj)
>  	if (exec->prelocked == obj) {
>  		drm_gem_object_put(exec->prelocked);
>  		exec->prelocked = NULL;
> -		return 0;
> -	}
> +	} else {
> +		if (exec->flags & DRM_EXEC_INTERRUPTIBLE_WAIT)
> +			ret = dma_resv_lock_interruptible(obj->resv,
> +							  &exec->ticket);
> +		else
> +			ret = dma_resv_lock(obj->resv, &exec->ticket);
> +
> +		if (unlikely(ret == -EDEADLK)) {
> +			drm_gem_object_get(obj);
> +			exec->contended = obj;
> +			return -EDEADLK;
> +		}
>  
> -	if (exec->flags & DRM_EXEC_INTERRUPTIBLE_WAIT)
> -		ret = dma_resv_lock_interruptible(obj->resv, &exec->ticket);
> -	else
> -		ret = dma_resv_lock(obj->resv, &exec->ticket);
> +		if (unlikely(ret == -EALREADY) &&
> +		    exec->flags & DRM_EXEC_IGNORE_DUPLICATES)
> +			return 0;
>  
> -	if (unlikely(ret == -EDEADLK)) {
> -		drm_gem_object_get(obj);
> -		exec->contended = obj;
> -		return -EDEADLK;
> +		if (unlikely(ret))
> +			return ret;
>  	}
>  
> -	if (unlikely(ret == -EALREADY) &&
> -	    exec->flags & DRM_EXEC_IGNORE_DUPLICATES)
> -		return 0;
> -
> -	if (unlikely(ret))
> -		return ret;
> -
>  	ret = drm_exec_obj_locked(exec, obj);
>  	if (ret)
> -		goto error_unlock;
> -
> -	return 0;
> +		dma_resv_unlock(obj->resv);
>  
> -error_unlock:
> -	dma_resv_unlock(obj->resv);
>  	return ret;
>  }
>  EXPORT_SYMBOL(drm_exec_lock_obj);
> diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
> index cc2937185a9f7..c92d69a2c793d 100644
> --- a/include/drm/drm_exec.h
> +++ b/include/drm/drm_exec.h
> @@ -73,13 +73,15 @@ drm_exec_obj(struct drm_exec *exec, unsigned long index)
>  
>  /* Helper for drm_exec_for_each_locked_object(). Internal use only. */
>  #define __drm_exec_for_each_locked_object(exec, obj, __index)		\
> -	for (unsigned long __index = 0; ((obj) = drm_exec_obj(exec, __index)); ++__index)
> +	for (unsigned long __index = 0; ((obj) = drm_exec_obj(exec, __index)); \
> +	     ++__index)
>  /**
>   * drm_exec_for_each_locked_object - iterate over all the locked objects
>   * @exec: drm_exec object
>   * @obj: the current GEM object
>   *
> - * Iterate over all the locked GEM objects inside the drm_exec object.
> + * Iterate over all the explicitly locked GEM objects inside the drm_exec
> + * container, except for the contended and implicit prelocked one.
>   */
>  #define drm_exec_for_each_locked_object(exec, obj)			\
>  	__drm_exec_for_each_locked_object(exec, obj, __UNIQUE_ID(drm_exec))
> @@ -94,12 +96,13 @@ drm_exec_obj(struct drm_exec *exec, unsigned long index)
>   * @exec: drm_exec object
>   * @obj: the current GEM object
>   *
> - * Iterate over all the locked GEM objects inside the drm_exec object in
> - * reverse locking order. Note that the internal index may wrap around,
> - * but that will be caught by drm_exec_obj(), returning a NULL object.
> + * Iterate over all the explicitly locked GEM objects inside the drm_exec
> + * container in reverse locking order. Note that the internal index may wrap
> + * around, but that will be caught by drm_exec_obj(), returning a NULL object.
>   */
>  #define drm_exec_for_each_locked_object_reverse(exec, obj)		\
> -	__drm_exec_for_each_locked_object_reverse(exec, obj, __UNIQUE_ID(drm_exec))
> +	__drm_exec_for_each_locked_object_reverse(exec, obj,		\
> +						  __UNIQUE_ID(drm_exec))
>  
>  /**
>   * drm_exec_until_all_locked - loop until all GEM objects are locked
