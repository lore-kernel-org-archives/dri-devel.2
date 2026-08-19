Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C2EC5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 16:30:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C44E110E15F;
	Wed, 19 Aug 2026 16:30:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x1FVJ24B";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 725B810E15F
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 16:30:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zbd01dxhxRgElYpkLsXVAsSriJ/ylXJSm9BM4nD4yWOk1p3/IlDYpuGZp6PEOz5R24JOZ5P0xSexiQpP0qp94SJu8zd8twPo45C69dwyHngMUGK4Lpsx4b7jmkdVOWTDtKz5YdAt/jfLJwwmK+fIyMH7CKVjDrvMQIDOnoN+1mQhgcubjqB7qfMyQ3v3PWm+IRddlK7uqeR76kHc+H2DJlBDj7bEHkc8qPKZ5zlxKvcMBtVp9Wbt+gq3b+whJp6G+yMSvtNPvKv193ZbJ6bsR/2bRBVlcbx1XMkcE4mrf35IA6N4Bx9g3Ls3ifJdlpZ24b/F10bcjdHNfggmTmOfaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtErqSaQgSfrR+ErkUfr3Aj4xmc80Qz3ufeMIKiLBBw=;
 b=ntO3fIGl/DRPuQps+CEf0tDdNu+sh30xyxXMgSqWgrpKkwOzlI7qAIJ1hNmw9ksi6tVgCJFtDJfshDJuUIyVxW8e9lnQ9Evqy0vdM7CCechRWVYo93DpHyCwl8rynzyom8sktjNb1m6s2cFKN7IY56GDHduUoOIDyARaANfWISg/hGAXzzQvIT4gT/ngN81rKtugdkw/5t+8p4LQ67tFnmzxODEHTVqJJnuhO5XGS7BwH5Eq1xdWTVh6YYdpaDB1qUJumLVdB1ZHenqOo/moBHdSzOffAGIH0OYde6A/kbNaevTH5yiWmzKRDkoa1Zz0LxtwHMbCyrgpXlGxsqreGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtErqSaQgSfrR+ErkUfr3Aj4xmc80Qz3ufeMIKiLBBw=;
 b=x1FVJ24BryWueTg7hXePSlkyOb7F3DljYpE9z4n4qVhTSGXQJbFeXw3QlfKEza7PmY4NdRYmGnssDfZesFyqE1vtYZE1ZDfOR4BplYHdX9JWK0Q3dgrJv99pfbGj1a2AZx03tPTlTSSTalUlqx4+gKSw1OC4oQoIrXFn3zFMHqc=
Received: from CH2PR18CA0033.namprd18.prod.outlook.com (2603:10b6:610:55::13)
 by LV8PR12MB9335.namprd12.prod.outlook.com (2603:10b6:408:1fc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 16:30:34 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::49) by CH2PR18CA0033.outlook.office365.com
 (2603:10b6:610:55::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 16:30:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 16:30:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 11:30:30 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 11:30:30 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 19 Aug 2026 11:30:30 -0500
Message-ID: <74575f6e-8284-882b-2a53-f804f92b439f@amd.com>
Date: Wed, 19 Aug 2026 09:30:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 0/5] accel/amdxdna: SYNC_BO correctness fixes
Content-Language: en-US
To: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>, <mamin506@gmail.com>,
 <ogabbay@kernel.org>
CC: <christian.koenig@amd.com>, <sumit.semwal@linaro.org>,
 <alexdeucher@gmail.com>, <max.zhen@amd.com>, <sonal.santan@amd.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>
References: <20260817230707.356828-1-taimuraz@kaitmazov.com>
 <1bd1644d-bc8a-45b7-af72-af64bc35ccb6@kaitmazov.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <1bd1644d-bc8a-45b7-af72-af64bc35ccb6@kaitmazov.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|LV8PR12MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: 216f8cb9-934a-49bb-7c46-08defe0f30f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|10067099003|56012099006|4143699003|22082099003|18002099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: 0kFwPNOmXoRKVEKtBlsqUiCfpGN5jPQQzHSxp4Nu6MuENX7Fw3dIhRIL9yhZ5aIzhCz+VJHvYJfgrOg/waVK/0dA3m7YoPEeLYzt9KIH+osaHdrI57mmEqz5ZqQp86EF/5PRERAzOGal2fN6JbDLBICAn8n3pIgzTOeWCYEuJ2rd81r9XAr0hp4vnHYIo7T8Fyvy5WusQ3E91PX5GlbsEk3RlUTuq/1AwSpuU3flwF3+UgelB+DJ0Ur+lKIsMfLaUTfCJBBEtz43xdZRIZ3R5ZkNXzEHTaKlSf25VMzZvRrUxwEIeajHW2vzYN89Lib1ZR6A7o1En6WBoVDj2ypV1CwreFKU4oiBMtPCjhTa1If82wbFImupy469ljDuvMdcHQHg8EHs/SSh2Zozp9aguIbJB5MJwBRHNy37kUl2M+xke28mJgyq937eyGkrLSGiqlCI/yWZk8Qq82ZgRxsYHgpMkflA0ZjDXPB/OBlKPbez+c668k5e0TbeeM3fNjTLKBdwrE270ppMLUZuFmdx43R9hX4ndAovhc0Aa32azmL+n4iIk35L0BsI0OgGYkALBfbtJLfbvnBuxjls6pTtApW7cCefi9M6MlLl9eqzOmlyUuKXwem9KEH8EJ7BrElStQ+/lKEwYpv9ZPgMWqU/XSpWVdRWejKDHWR2bld9jFB4X5C7RTt1KLYxsmaW8FxSSEQevhP2f7/D9E3cMBH4NQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5kFLW73nkYi2kZR0wUVRNiM4EusEh07tCB2otKz120Xy1GhXE7tuD47OEDyNBd5VUvf03NySvv9LAaMC3hYvyHa31lfCesrJbf3KpZBDO+gTKwGACZeabQoNyIKgDdTH9HKkFFPevMynwnbvjYDAldZZSTbfNr1BMXQeIpuV4Z94SJJk8QGQYdY/hisJws1oqOVcdABxXiJRpnjNpuPuMUp9OnxjcTBfNKjvNOvo1oHaznnt7LKKzJwM1q0i4OUsp9GAmEmFIA7HnjseAP8nzlrDaUHDaeURKymJh3vl9hHQbyyzzce5N6BdgH1/7Zjw4KaOXHIHOxP9H+niG8Hhrfy69TPn0/odWTf766fZiEWN82qNKd54meouyKyL1AIwB5v4ngWvFKGG1JE4wISH9Y2iECVU5uocuPTQMyefYQam/Ko9UZuAWMTUFxLdKCQu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 16:30:33.2256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 216f8cb9-934a-49bb-7c46-08defe0f30f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9335
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


On 8/18/26 14:40, Taimuraz Kaitmazov wrote:
> Patch 1 needs a prerequisite. It makes amdxdna_gem_vmap() answer NULL 
> on an iomem exporter, and the eight amdxdna_cmd_get_payload() callers 
> in aie2_message.c check neither the pointer nor the length it leaves 
> unwritten there. A command BO can be an import, so patch 1 alone turns 
> a silent __iomem write into a NULL deref with an uninitialised length.
> https://lore.kernel.org/all/20260818002459.377641-1-taimuraz@kaitmazov.com/ 
>

amdxdna_cmd_get_op() is always called before amdxdna_cmd_get_payload() 
for the same BO, and since amdxdna_gem_vmap() caches its results, the 
vmap inside get_payload() is currently guaranteed to succeed. The patch 
is therefore defensive rather than fixing a currently reachable crash.

Lizhi

>
> fixes the callers. Happy to respin on top if you prefer them together.
>
> Taimuraz
>
> On 8/18/26 02:07, Taimuraz Kaitmazov wrote:
>> Five fixes in and around amdxdna_drm_sync_bo_ioctl().
>>
>> Patch 1 refuses an I/O memory mapping the driver would otherwise 
>> store as
>> if it were an ordinary kernel address. Patch 2 checks the device-BO 
>> range
>> for overflow. Patch 4 refuses a flush of an imported BO, which is why
>> patch 3 comes first: the ioctl answers a rejected flush with drm_WARN(),
>> so without it an ordinary sync on an imported BO splats. Patch 5 stops
>> the ioctl reporting failure for a flush that succeeded.
>>
>> v3's zero-length patch has left this series. On hardware it turns out to
>> be a page fault in drm_clflush_virt_range() rather than the tidy-up its
>> commit message described, so it is a -fixes patch now, sent 
>> separately as
>> "accel/amdxdna: return early from a zero-length flush" with Fixes: and
>> Cc: stable. Patch 4 here needs its hunk, so this series wants that one
>> first.
>>
>> Changes in v4:
>>    - patch 1: the is_iomem check moved from the .vmap callback into
>>      amdxdna_gem_vmap(), per Lizhi, and it logs at debug level rather 
>> than
>>      error, since an unprivileged caller can repeat it.
>>    - new patch 3: an unprivileged SYNC_BO with an out-of-range offset
>>      already reaches that drm_WARN() today. Sashiko's review of v3 3/3
>>      flagged the same thing.
>>    - new patch 4: refuses the flush for every imported BO, as asked.
>>    - new patch 5: the debug-BO sync I mentioned on the v2 thread. 
>> Only a BO
>>      attached with ATTACH_DEBUG_BO has an assigned hwctx, so every other
>>      FROM_DEVICE sync ends in -EINVAL with its flush already done. The
>>      -EINVAL reproduces on a Strix Point NPU.
>>
>> On patch 4, one consequence worth deciding before it lands. A heap BO is
>> created through amdxdna_drm_create_share_bo(), so a device running on
>> carveout memory reaches its heap through a cbuf, is_import_bo() is 
>> true of
>> it, and SYNC_BO on every AMDXDNA_BO_DEV now answers -EOPNOTSUPP. Today
>> that path flushes nothing anyway -- amdxdna_cbuf_map() fills in only the
>> DMA address and length, so drm_clflush_sg() walks zero pages -- so the
>> change is silent no-op to hard error, and XRT's dbg_buffer::sync() 
>> reaches
>> it without Debug.force_driver_sync. If you would rather keep our own
>> exporters working, I have the variant keyed on the exporter's ops, which
>> confines the refusal to foreign buffers. Say which you prefer.
>>
>> v3: 
>> https://lore.kernel.org/all/20260813164700.43960-1-taimuraz@kaitmazov.com/
>>
>> Built on drm-misc-next, each commit on its own: x86_64 with
>> DRM_ACCEL_AMDXDNA=m, clang 22.1.8, no warnings. Patch 5's reproducer was
>> run against 7.1.8's in-tree driver, where that call is unchanged.
>>
>> Taimuraz Kaitmazov (5):
>>    accel/amdxdna: refuse an I/O memory mapping of an imported BO
>>    accel/amdxdna: check the sync range for overflow on a device BO
>>    accel/amdxdna: do not warn when a sync request is rejected
>>    accel/amdxdna: refuse to flush an imported BO
>>    accel/amdxdna: do not fail a sync for a BO with no debug context
>>
>>   drivers/accel/amdxdna/amdxdna_ctx.c |  3 ++-
>>   drivers/accel/amdxdna/amdxdna_gem.c | 27 +++++++++++++++++++--------
>>   2 files changed, 21 insertions(+), 9 deletions(-)
>>
>
>
