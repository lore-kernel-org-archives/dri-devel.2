Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47594C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 17:56:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A39C310E6A5;
	Mon, 17 Aug 2026 17:56:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="du/ZPEA/";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011020.outbound.protection.outlook.com
 [40.93.194.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98F6610E6A5
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 17:56:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IoOnx7c52ewnqJvgL9k4UwDZsuQao3DwpW7ZUNCp6p1E9olz3cOHG92yuHQM6uZGKFW1h8up4wGpXybqHZIytveMMN1gRTGzF0QNZal9LBj0A2FD+7ETIq+UJ8JQN0+MKILov15P2K3w9cGiY7nWLR9gUUlAl1bq0/culeQKxCwaXeY6NEeGUcxv9U3E+WjEaEVFSocl6rxh/ivuvhi23IqSQtVy0l1sNYkAFMEqA2hxbFoTHZg0pTjAOI3XUs8TK+/x6mTBMnSmDJQU8sh7Sgkpvt5koDwGyewl3f/Lo9p/3u/8TveQ8r0lSpog7MxAsW0V6blRoSx/xNnn9UfAfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTedkcnqYCkIR47sGmH+H9JPd8QzOzuHy/JD1BichtE=;
 b=IZmOmYpr5hfPKRYNqEVBXzzVt3ZJgxQLWD1ekRmL9vOQl8uGFo6AuspZ1MuK+ZO1+/bQCycu0oflz4lBRrk8wrCltTMwIxmZqTSdpUQp2Sqwbf7CLh2YKb7YyO7flfYTVUFT1akSPCbqU8bxbX3onBJGs6Mqwe7scXxkR3TFIJtzgYL0hqboMBCfHfgCuf63EQtPWZ1yrHfARB+9diRg4bpM4Xow5BEGLzxRPPtnKVLt4eNHnJhaIJ6vcBieppc/7kusxLWd2j1KKzYGBTv0nq9g/vWgwAVaMm1AKQikrGH/1+XtXcETQlM8dzSS2cqfkwzayC+RRfpaseLlYAiDmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTedkcnqYCkIR47sGmH+H9JPd8QzOzuHy/JD1BichtE=;
 b=du/ZPEA/jHK7/aaxUJIMPIn6LaSMw1Rennl9PTlFb6YGsVsl7jocbFLIvCnY8mKNPJuGnhP0edn/J1XKx5SGepBne+Arxjol6MPNfuQQspxRXE6lhBhg2oKv+haL5XXUKUYQ/wku56FI2PIkU/iqHy7amqtS3hojucyiRR3eOJ0=
Received: from SJ0PR13CA0041.namprd13.prod.outlook.com (2603:10b6:a03:2c2::16)
 by DS7PR12MB9526.namprd12.prod.outlook.com (2603:10b6:8:251::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 17:56:07 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::88) by SJ0PR13CA0041.outlook.office365.com
 (2603:10b6:a03:2c2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Mon, 17
 Aug 2026 17:56:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Mon, 17 Aug 2026 17:56:06 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 12:56:06 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 17 Aug 2026 12:56:05 -0500
Message-ID: <1aba31b8-36a6-d3f0-8624-a603d319c54d@amd.com>
Date: Mon, 17 Aug 2026 10:56:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/5] accel/amdxdna: honour the SYNC_BO range
Content-Language: en-US
To: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
CC: Min Ma <mamin506@gmail.com>, Oded Gabbay <ogabbay@kernel.org>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>
References: <20260811231351.1011244-1-taimuraz@kaitmazov.com>
 <ee663474-5de0-4ffe-8ac1-1dcdff5dbc28@amd.com>
 <224dd281-da48-84b3-a048-016b51aa0362@amd.com>
 <a505f9e5-b416-43e9-934d-c5c29b8a70e9@amd.com>
 <9420bbe5-46a3-84be-eae8-596bc42bddac@amd.com>
 <20260813182905.124248-1-taimuraz@kaitmazov.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260813182905.124248-1-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|DS7PR12MB9526:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d22b77-2273-428d-c4d7-08defc88cfd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|10067099003|56012099006|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 0/KCSY5XmLpnTmZ45JU9qEc9s6/qQnnVnfQ+6t96sR2uFctpj/M/yUlGmQeI74iEdkwGNyJC9M6MLTEhp4IOnwneVSui5OQ4e326cT/VF7+wIvwzOHPlD4JPSMF/AIaxFD+Shad2vGVJ1lu76c5NAHQGea2aOOgclOWZnyLHQe8DkeW5fkwd8I5c4sxNUlkE/L8YL/qMb2qVi+B3xZwryrw5aKk8rZ74WrEJWgB+fk6GchROW6UiioAxWFC5d31MJioQ+esEuT4mUR3wCCW5xTrqS4MF9jMHPiFOkVTNTAo8sUmDAHHxcDXmCEufmIpHbleRbx5MC84QierbjkNfM4jeONNZJW+f2iJxP+gooTKfYqijOXFdTMidwUr1uwRfboHDD8kEmzIvZtzRIPUWlcdkSbBu/Y/2EaPpHRL4TJLcQzmO/9SkHFNYI0SaMcNULHxI9Rn7EisdCF00EQ2CYiCHiBaXQG1i4sXfAWh612r7latMUTPUkhwNSM6fPi83KWMjVuQuD3IzZZpJTz5LPtyQ18T2vGXYQd5H94K59xLhzo7Bq7TjpPU9ZdE0EcECu5D4yFf2uD8WqhXZMynckdVqVEuG3jxPKnW+p1Xde6QKNRFOf4axqDR6CBWFpCOsWbk18OW8z7jCtRDIfEJhKuFIgPNvVWLl0w+y5F0dk5CqPKritxJXw1isCTux9RgO4AVRlCyKS6bVlvdAcRq3zQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Fci0jueljnmOg7ICnOJcWbotkyZhgV2aPyDzmjqNfyx6n9ycrrxufsIq9ZFdtAqvHIA8YMbEUkQXnXoY9XOa0lrUZenY7kWutOsG2u9io9dgcdDE3j6A/6LIgitE1aBjE3trlWhldkHUBgIIhXm4H3bwRN6obnrBFCvI/wrspelkJSvVDoMAIk4qhq6iOsLSKxYOsVqTNt0luZc2ZnRvbPGDot8GJ2lnBodQJzqFuK+GonrW2HimQ6j8xfCTMGkLDBfD70nJG4OiYQuPowW2XpeMz2UrfE1GrvNVO10+Zf4Oi7yQsn+LESOEJj1WnDBpwT4MG72+ojpwm+0qorbFtro3cI/lJ+g7q+J6G+VoJbx4OOJ+8leUf0GHhGvoMCpaiJBORcSm0DP+e9Lrrk2nkBDB1DZwrwt2nes4Areo81XOP8VnZyZdt0He4O6Lbai6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 17:56:06.5412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d22b77-2273-428d-c4d7-08defc88cfd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9526
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


On 8/13/26 11:29, Taimuraz Kaitmazov wrote:
> Resending: my earlier reply does not appear on the lists, so I assume it
> did not reach you either.
>
> On 8/13/26 20:08, Lizhi Hou wrote:
>> The legacy NPU device is not cache coherent. And the next generation
>> (aie4) devices will be cache coherent.
> Confirming that with numbers, since I had measured it before your reply
> landed. On npu4, without a flush the CPU reads what the buffer held
> before the NPU wrote it, and the NPU reads what DRAM held before the CPU
> wrote it. Both reproduce on all 20 runs, and the stale read is most of
> the buffer, not a stray line: 3931 of 4096 values on average.
>
> Good to know aie4 is coherent -- that makes anything we do here a
> legacy-only concern.
>
> On 8/13/26 09:44, Christian König wrote:
>> An alternative would be to use DMA_BUF_IOCTL_SYNC from userspace
> Tried it against amdgpu, imported into amdxdna: stale on all 20 runs, no
> better than no sync at all. SYNC_BO on the same buffer is clean on all
> 20.
>
> Which leaves me no legal way to import a buffer the CPU also reads. Is
> there one I'm missing, or should a device like this just not import?
>
> On 8/12/26 17:45, Lizhi Hou wrote:
>> we need to unconditionally return -EOPNOTSUPP for imported BO
> is_import_bo() also covers ubuf and cbuf, so that stops maintaining our
> own userptr and carve-out BOs too. They take that arm today: on a 64 MiB
> userptr BO a 4 KiB sync and a full sync both cost 659 us, so the range
> is already being ignored there.
>
> Keying on dma_buf->ops instead would confine it to foreign buffers.
> Either is fine by me, tell me which you want.
>
> Separately: XRT's buffer::sync() clflushes in userspace unless
> Debug.force_driver_sync is set, so the stack does this to foreign
> dma-bufs whatever the driver does. And when the ioctl is used, a
> FROM_DEVICE sync returns -EINVAL after the flush has already run, out of
> amdxdna_hwctx_sync_debug_bo() when the BO has no assigned hwctx. Happy
> to send that as its own patch; the helper has one caller, so returning 0
> there is the obvious shape unless you want it done elsewhere.
>
> v3 is sent: patches 1, 3 and 4 only. Patch 5 is dropped, and 2 with it
> since it only serves 5. I have not tested 5 on a matching tree and its
> numbers came from the foreign import case.

Based on the discussion, could you add one patch to unconditionally 
return -EOPNOTSUPP for imported BO at the beginning of amdxdna_flush_bo()?

Lizhi

>
> Taimuraz
>
>
