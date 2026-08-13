Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54B2C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 19:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04FBC10E054;
	Thu, 13 Aug 2026 19:02:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uRI+sTPc";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013024.outbound.protection.outlook.com
 [40.107.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CB3B10E054
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 19:02:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7DxFucLoeBhtwyrrOfNGZN/FwyI15+XUSrDNpqnCJoBeq0ju13tU1lFOe/DGEmu+/HDV2yfdGkCKt2em/WN8bvj9+Pptr4zctRSzAbgdyvKbX8Lq/yjHlhRV5Lm4qmybsWzHEbUE75VUgsHfwMLTvc0ACVGQDCdV8DCawtFtikDC7/X7Kdk+XR7oHrqPA9h4xv5MMRoT+7c6sZ21ZzJeg89O1EPD0evzsbql14T2zncA6MSooq4t6+NvDki5hFDcSCTLq+lLCVPv20jUm+2z6fXgHwd/SPrbexRkque3Tuz0su41X+BM+F4PuBSgJsm5HcSIkAo5YVT1qRXPlKzUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJABstt1Jx6xgKcBx6/rMvi66BgkmaDg/ELHCUtriaM=;
 b=ivBGE9ATvBYRzpM2gwRa+Gj+ufA0vRjnQltH+aC2YvPAf5mHAB2YjBWbKsLiaPGJUjUv98xfVDNTQ0BhS4j4I4mjMAhwKpO9tB8tt5gJNgzeVcrQk4zAuUNuxNcFx2u9qj3gU49MvhOzkGHXjEt4dmjcfYXxy5prHdJEpWn2fmO2gRsQ+NWBWdnSOozIZOQXeYr8jof0iOLstWXrK4f1qAS0CdvZIZMGSleG+lFhV+I1OBCtoEJhOC32tg8NCfUbIsl6R8vqYzbDNQopAT6MIOFfvajFRrl9BiVrj3qe63IJXs+0LclBvtZCRdbu5C+jXIRkRR/T+Er2CNHqXiL/PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJABstt1Jx6xgKcBx6/rMvi66BgkmaDg/ELHCUtriaM=;
 b=uRI+sTPc+MLb+LCe74pqypg07udiZHWLRn18NO8r6V6LvUbl4Hiuw6Ztd6REmPY08Bb3ScT7ZEHC+kcVj1Cn3Krbj5+Df5Sqb7oNIzP/MJBSzHLmrPlusrUP5fwczGgIEjEyv+PO1HD1Ls2n7BkF5FqTwncqpHtxL+NMoCQ9t/4=
Received: from CH0PR03CA0107.namprd03.prod.outlook.com (2603:10b6:610:cd::22)
 by SJ1PR12MB6074.namprd12.prod.outlook.com (2603:10b6:a03:45f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 19:02:01 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::2) by CH0PR03CA0107.outlook.office365.com
 (2603:10b6:610:cd::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 19:02:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 19:02:00 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 14:02:00 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 13 Aug 2026 14:01:59 -0500
Message-ID: <a218d2e7-62cc-23e0-386f-8b6e2a5c2297@amd.com>
Date: Thu, 13 Aug 2026 12:01:54 -0700
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SJ1PR12MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 039553e5-cf0b-4dae-b0ed-08def96d5b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: X/AEsOE4Wevh2X1Yv4cJTINoNeJlzPM1mznmspFPN7joVlW/dec9bxfeNpRLSE0puxr0XLC3wf1biwqpozd71KfdmMAg/zVRaTXwDxMAgM8FQwIwznhimetzzUXTEsrwihGzgzfnuDCCG9Xi6MdE5mXYhupC0A5Bn7Z+rZVwgkRzjGeQhFAUiHQVaq6RRqdF5O57nhDtfzZizjr+sD73UaXGz/xJUoAdMWhPe6CdbUcnQJTOkJe4bAShijG69LZo/+k9P3KQFiUIVOlqiGcj8c2e98QI50/q/vp0lYHoxyFvXMh8lFP1bx38w5k2SbkKRURDSyO8LNQ5k0Dbl3Tljd6VYY52hcxFmC6Kj4w/xDirjM0c0HnNuV6XpL2zCMnoE/77XESBrq+lQqUtvh6FPJZxyZtHciAITkvwFr8jM1MRuZwd39j9oraTIROwbOhEcHa/tnThso/Bh74bNRZOzyM1PTJVrKNxY2tSj2Iyo2Uy0EuEFYIzaJHR3uHG6/0HTHJofsl5pe2HSqkjKkOH9ZpuqvYXJr2YFXup84r6FBwUpV5BLpsr8N6EGk+CXmK+JEc6K1aZRgChLNM1ayZIJoZ5Vu+UXgv//NRqkysgT3fqceJOyUQTXjRFVaAN7j5OM8A/UXWAOVrRRV9yivCMd8jIY/fYJ+/TnzA/a+UN7o8IqyYKhBee3JLFAtbYo9b4JNTLbLgMe553D8VX1YazYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LbtQ/yQS7hY9Qoe6ahSgP7cFf/5JE0LhAzKsca3HRSIsL0kjpPioIuEfTx95hMv7VV695H6djZJbM95k7vxDj6rBax08JXNuqCwxuSKxgTlRL0KiigluEm/LzRNmmo5oJJ9s/qbC7R9oJoZv5GiLRRYF1IcM5hhVNQPB3Q9vgqzlcSYFwK8KcSyJORh6Mzhg77UBcYvawZL7iKU1KfXvEO8YzqZgy1whWSm0K5pUuZimFMA0hHNo4vIUWCagHJMK0SQ+U2DxGNMAfdfcx/gjJL5gDv9+Qg/NT8ka9wj6BrPEPWnHBSBp5GRoKr1OdY4qnif7S/Se6h57gIRhXhq54bw/y25NeY0Th37g/vh5frwcx4rQkC69LwRUfIcPdbHRnUtXjGgXcqyVGSxr+P6kjytq1Vvyoqw9ZP7g6Cwh59Q+NzpgkG+zPZ+iry6c+WwR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 19:02:00.7331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 039553e5-cf0b-4dae-b0ed-08def96d5b0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6074
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

I am working on removing the dma-buf part for ubuf BO because that is 
also not a good usage of dma-buf. So the ubuf will be a object soon. 
cbuf is mainly for debug and is disabled by default.


Lizhi

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
>
> Taimuraz
>
>
