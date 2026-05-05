Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217F1FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 18:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8031010E458;
	Tue,  5 May 2026 18:03:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v+dox4ht";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010022.outbound.protection.outlook.com [52.101.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1B0110E458
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 18:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oy2y/bv7u8cCHwtYWXf2sa0p/6OA/sVetqbNHjI6wB58X+xpSJYJIM/PoXtFsgly+Ul7QSfSELeL/kdxUdJj+B9tbH8EZVrL/INArfGhMaxndtxkCMdQp+ycHQMXx7vKADkOAS4l5O5aFG3E5p5I3BK6UOEDvi07hlXbClNWwY5hkrBosltfP6HrnxPDd2aW41T3DNaEz/VaMbLYOrCGhVk+LGHHWO36KiDb4HbL7eNot9JowyGoO2OMO+8uoaU6HXeYrMdbJaia4hodMOUhdlbCNK88dORAnm0g9CDiwfPiCix0uBBKA1MVKiHiemGmCZcw3Rh6ZDMsVPAO4kEIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UY0wpJCfCX5ufCzvmeckjiiAC2CsWYPelk70f+whcaA=;
 b=PySVXpsAuvRewqHPOnul1TuXW41pmDnvI01DnTsBV6f6hSyeKGF0kchWaCkGnAXBiyeiwTK+rbdSVUpU3NNyVrXKnxKnocqWVTbHgUKXO0RkXZqDwaos4fWBBu4o/4RbI5YqOZ00LgDW7K9ye59hlzWderSb89uu+cHCJ5Dx0ERvWyJbjuAUNerrIbRzywxukWPa9nxZpRJaMReBjHRwZDM/PqdnEpEax0gjOYag++60iw7p2A56j1/7zG14b7lvifcDpAv+DPdi2xdDUhRBib+52k1qURoIo5Hw2oMV10VtodygoaNMrUmyvGwb7WfVvNQgcA5wiJsnvkDQCSno2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UY0wpJCfCX5ufCzvmeckjiiAC2CsWYPelk70f+whcaA=;
 b=v+dox4htIR08DbsuJ7GNNJlnwfVF3C2dB4LZo2Z5c5Eee39ACiFpc5yAAhkbi0zLCVtw+oswo6hpdOb12EZV2wk+oXhzO0QC6Pqd+zVex7O+xBg3Blhjn0ZJtI6NbmFYEQdJ9lYY4uyMpHwdK8j3/4ysViJdwqz/jZomdI4BZjs=
Received: from BL1PR13CA0152.namprd13.prod.outlook.com (2603:10b6:208:2bd::7)
 by SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 18:03:31 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::1d) by BL1PR13CA0152.outlook.office365.com
 (2603:10b6:208:2bd::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Tue,
 5 May 2026 18:03:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 18:03:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 13:03:30 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 11:03:29 -0700
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 5 May 2026 13:03:29 -0500
Message-ID: <2193be15-b0ce-c8c3-140c-7278b86677f7@amd.com>
Date: Tue, 5 May 2026 11:03:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1 5/6] accel/amdxdna: Add AIE4 metadata query support
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <karol.wachowski@linux.intel.com>
CC: David Zhang <yidong.zhang@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>, Hayden Laccabue
 <Hayden.Laccabue@amd.com>
References: <20260505160936.3917732-1-lizhi.hou@amd.com>
 <20260505160936.3917732-6-lizhi.hou@amd.com>
 <0399e649-4759-412e-b89c-4759d1469fad@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <0399e649-4759-412e-b89c-4759d1469fad@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|SJ0PR12MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 1304587c-a1a0-4839-e579-08deaad09d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: qunYH1fV9FcYP715gzGXH8GPuJ4VqGBi/MX2p6J0mGeug1ytAYfw++itrseZgvrYQ73AHzK4SVW65pJpE02DUI4iRfoXuXostYExK6ETn6Jl94Dh2SFpu4szf4oU8T4F7pQ6J6BcoeP7wnVQfxx8hm661+T11dfYpAe/V9rpGQpMEOyVcQB3EVijPUlMkL9Dj4sa6rbVlWemlzA69bli+/UHtl5H+p0F9nXL34SV185WZgmD85P325F2YbAeIcXh1W+8Ir1YgdJ/oGd3ey9P79TlbScX1UncJHN+2Jfr/PCwWw6Q3F9x2WYzZExoY7sTYGv1D93BbKUGtZ23VrI52ek3Pe7fJqFdjZwvjwjPaINR681l5Php/1IuXumzU7HXf9Bxs3QN1nMDvfyC2y6wlgiSnGs8dPDDugc3LL1cone/2IUnipwXrgQN2biWHrp3Ai4m9cpws83xUCNlLNPOj/zh22Ale/UZFQudyRGpyHVgDfm8aTloUGNw72l/O9V9+7KCErKB45zmFWB2xC0HQ3zrZ1iw29zgXsAUSrpmsKDZX+RuQc4X5zhQt52QTheAHOwnxoJqhskd/Z6awi22c/9vlqlXVU2WPKIX+B1XprAmQKRjMWKuIKJaOHUPRd1w7Korlq6iy+HaE542V1zIGQ0QJZKCWc2BvqBQNEPDq2M/umEKjjHzb655o1FZNLp2NZcfuEYO4YTkHT8H1BJhHBy6cDWITcb+VvsX8P+DDpQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IGyqvops9xRUXaH/gZAF+E3vg8Jm9y+ed166Ray1EfWn5zIDod2yjSSc97IGE1VuvhlCc9VIr0hBUhDySWPFcL1UPGx6c1ybGz3nbHXWjw62LDwvr+lxQEujuuj8PKmsUL/0zNjA8ZWh2je+0pG3jJoo0AiJObpvUlEPfr0beyoHL68Paalls5rtv1kOFAXZF1gW6LnwENaglUJ8dkXuLUxuqXMpQjXOC5rguOBMferwB6jrgSjnqJ0HaKwZd4OvqDaRMN/agLZ/00crRIPw9dM0B+sDdRb4dflwwHM5Gy1yd/c2ZR9yC+UqFrQWLOOfGauzWpJ1KtxWhsm8htCJDn5Cn5Z89nDjftk7/IeupjZKCgobGgwLaLhGLSwDMd95ZymZMOaDH3hOXhSEFav3ftqkwKIoqlQ642CAorlLfteWftVlVxom6KBZqW35PTvy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 18:03:30.3511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1304587c-a1a0-4839-e579-08deaad09d67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007
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


On 5/5/26 10:14, Mario Limonciello wrote:
>
>
> On 5/5/26 11:09, Lizhi Hou wrote:
>> From: David Zhang <yidong.zhang@amd.com>
>>
>> Add support for querying device metadata on AIE4 via a mailbox message.
>> Refactor aie2_get_aie_metadata() into a common helper by moving it to
>> aie.c and renaming it to amdxdna_get_metadata(), allowing both AIE2
>> and AIE4 to reuse the implementation.
>>
>> Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
>> Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
>> Signed-off-by: David Zhang <yidong.zhang@amd.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>>   drivers/accel/amdxdna/aie.c           | 45 ++++++++++++++++++++++
>>   drivers/accel/amdxdna/aie.h           | 27 ++++++++++++++
>>   drivers/accel/amdxdna/aie2_ctx.c      |  4 +-
>>   drivers/accel/amdxdna/aie2_message.c  |  2 +-
>>   drivers/accel/amdxdna/aie2_pci.c      | 54 ++-------------------------
>>   drivers/accel/amdxdna/aie2_pci.h      | 24 ------------
>>   drivers/accel/amdxdna/aie4_message.c  | 37 ++++++++++++++++++
>>   drivers/accel/amdxdna/aie4_msg_priv.h | 34 +++++++++++++++++
>>   drivers/accel/amdxdna/aie4_pci.c      | 30 +++++++++++++++
>>   drivers/accel/amdxdna/aie4_pci.h      |  1 +
>>   10 files changed, 181 insertions(+), 77 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie.c b/drivers/accel/amdxdna/aie.c
>> index 66849ba9026a..a31051cc1ec8 100644
>> --- a/drivers/accel/amdxdna/aie.c
>> +++ b/drivers/accel/amdxdna/aie.c
>> @@ -117,3 +117,48 @@ void amdxdna_vbnv_init(struct amdxdna_dev *xdna)
>>         amdxdna_update_vbnv(xdna, info->rev_vbnv_tbl, rev);
>>   }
>> +
>> +int amdxdna_get_metadata(struct aie_device *aie,
>> +             struct amdxdna_client *client,
>> +             struct amdxdna_drm_get_info *args)
>> +{
>> +    struct amdxdna_drm_query_aie_metadata *meta;
>> +    int ret = 0;
>> +    u32 buf_sz;
>> +
>> +    meta = kzalloc_obj(*meta);
>> +    if (!meta)
>> +        return -ENOMEM;
>> +
>> +    meta->col_size = aie->metadata.size;
>> +    meta->cols = aie->metadata.cols;
>> +    meta->rows = aie->metadata.rows;
>> +
>> +    meta->version.major = aie->metadata.version.major;
>> +    meta->version.minor = aie->metadata.version.minor;
>> +
>> +    meta->core.row_count = aie->metadata.core.row_count;
>> +    meta->core.row_start = aie->metadata.core.row_start;
>> +    meta->core.dma_channel_count = 
>> aie->metadata.core.dma_channel_count;
>> +    meta->core.lock_count = aie->metadata.core.lock_count;
>> +    meta->core.event_reg_count = aie->metadata.core.event_reg_count;
>> +
>> +    meta->mem.row_count = aie->metadata.mem.row_count;
>> +    meta->mem.row_start = aie->metadata.mem.row_start;
>> +    meta->mem.dma_channel_count = aie->metadata.mem.dma_channel_count;
>> +    meta->mem.lock_count = aie->metadata.mem.lock_count;
>> +    meta->mem.event_reg_count = aie->metadata.mem.event_reg_count;
>> +
>> +    meta->shim.row_count = aie->metadata.shim.row_count;
>> +    meta->shim.row_start = aie->metadata.shim.row_start;
>> +    meta->shim.dma_channel_count = 
>> aie->metadata.shim.dma_channel_count;
>> +    meta->shim.lock_count = aie->metadata.shim.lock_count;
>> +    meta->shim.event_reg_count = aie->metadata.shim.event_reg_count;
>
> Looking at the code the structures for
>
> struct amdxdna_drm_query_aie_metadata
> and
> struct aie_metadata
>
> Look identical.  Rather than copying every member, can you just use 
> copy everything from aie->metadata to args->buffer directly?
>
> That could let you save the kzalloc/kfree call.

Agree. I will just remove the redundant structures in V2.

Thanks,

Lizhi

>
>
>> +
>> +    buf_sz = min(args->buffer_size, sizeof(*meta));
>> +    if (copy_to_user(u64_to_user_ptr(args->buffer), meta, buf_sz))
>> +        ret = -EFAULT;
>> +
>> +    kfree(meta);
>> +    return ret;
>> +}
>> diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
>> index 7a68b114f235..4bb3719ee0c0 100644
>> --- a/drivers/accel/amdxdna/aie.h
>> +++ b/drivers/accel/amdxdna/aie.h
>> @@ -14,6 +14,29 @@
>>   struct psp_device;
>>   struct smu_device;
>>   +struct aie_version {
>> +    u16 major;
>> +    u16 minor;
>> +};
>> +
>> +struct aie_tile_metadata {
>> +    u16 row_count;
>> +    u16 row_start;
>> +    u16 dma_channel_count;
>> +    u16 lock_count;
>> +    u16 event_reg_count;
>> +};
>> +
>> +struct aie_metadata {
>> +    u32 size;
>> +    u16 cols;
>> +    u16 rows;
>> +    struct aie_version version;
>> +    struct aie_tile_metadata core;
>> +    struct aie_tile_metadata mem;
>> +    struct aie_tile_metadata shim;
>> +};
>> +
>>   struct aie_device {
>>       struct amdxdna_dev *xdna;
>>       struct mailbox_channel *mgmt_chann;
>> @@ -26,6 +49,8 @@ struct aie_device {
>>         struct psp_device *psp_hdl;
>>       struct smu_device *smu_hdl;
>> +
>> +    struct aie_metadata metadata;
>>   };
>>     #define DECLARE_AIE_MSG(name, op) \
>> @@ -94,6 +119,8 @@ void aie_destroy_chann(struct aie_device *aie, 
>> struct mailbox_channel **chann);
>>   int aie_send_mgmt_msg_wait(struct aie_device *aie, struct 
>> xdna_mailbox_msg *msg);
>>   int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 
>> fw_minor);
>>   void amdxdna_vbnv_init(struct amdxdna_dev *xdna);
>> +int amdxdna_get_metadata(struct aie_device *aie, struct 
>> amdxdna_client *client,
>> +             struct amdxdna_drm_get_info *args);
>>     /* aie_psp.c */
>>   struct psp_device *aiem_psp_create(struct drm_device *ddev, struct 
>> psp_config *conf);
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index 139825ac8515..7d6094aefb6f 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -489,12 +489,12 @@ static int aie2_hwctx_col_list(struct 
>> amdxdna_hwctx *hwctx)
>>       }
>>         ndev = xdna->dev_handle;
>> -    if (unlikely(!ndev->metadata.core.row_count)) {
>> +    if (unlikely(!ndev->aie.metadata.core.row_count)) {
>>           XDNA_WARN(xdna, "Core tile row count is zero");
>>           return -EINVAL;
>>       }
>>   -    hwctx->num_col = hwctx->num_tiles / 
>> ndev->metadata.core.row_count;
>> +    hwctx->num_col = hwctx->num_tiles / 
>> ndev->aie.metadata.core.row_count;
>>       if (!hwctx->num_col || hwctx->num_col > ndev->total_col) {
>>           XDNA_ERR(xdna, "Invalid num_col %d", hwctx->num_col);
>>           return -EINVAL;
>> diff --git a/drivers/accel/amdxdna/aie2_message.c 
>> b/drivers/accel/amdxdna/aie2_message.c
>> index 6e98af7b74db..f555ffecea6f 100644
>> --- a/drivers/accel/amdxdna/aie2_message.c
>> +++ b/drivers/accel/amdxdna/aie2_message.c
>> @@ -375,7 +375,7 @@ int aie2_query_status(struct amdxdna_dev_hdl 
>> *ndev, char __user *buf,
>>       u8 *buff_addr;
>>       int ret;
>>   -    buf_sz = ndev->metadata.cols * ndev->metadata.size;
>> +    buf_sz = ndev->aie.metadata.cols * ndev->aie.metadata.size;
>>       buff_addr = aie2_alloc_msg_buffer(ndev, &buf_sz, &dma_addr);
>>       if (IS_ERR(buff_addr))
>>           return PTR_ERR(buff_addr);
>> diff --git a/drivers/accel/amdxdna/aie2_pci.c 
>> b/drivers/accel/amdxdna/aie2_pci.c
>> index f0ddb843eb21..6c8a0f70b73d 100644
>> --- a/drivers/accel/amdxdna/aie2_pci.c
>> +++ b/drivers/accel/amdxdna/aie2_pci.c
>> @@ -219,13 +219,13 @@ static int aie2_mgmt_fw_query(struct 
>> amdxdna_dev_hdl *ndev)
>>           return ret;
>>       }
>>   -    ret = aie2_query_aie_metadata(ndev, &ndev->metadata);
>> +    ret = aie2_query_aie_metadata(ndev, &ndev->aie.metadata);
>>       if (ret) {
>>           XDNA_ERR(ndev->aie.xdna, "Query AIE metadata failed");
>>           return ret;
>>       }
>>   -    ndev->total_col = min(aie2_max_col, ndev->metadata.cols);
>> +    ndev->total_col = min(aie2_max_col, ndev->aie.metadata.cols);
>>         return 0;
>>   }
>> @@ -658,53 +658,6 @@ static int aie2_get_aie_status(struct 
>> amdxdna_client *client,
>>       return 0;
>>   }
>>   -static int aie2_get_aie_metadata(struct amdxdna_client *client,
>> -                 struct amdxdna_drm_get_info *args)
>> -{
>> -    struct amdxdna_drm_query_aie_metadata *meta;
>> -    struct amdxdna_dev *xdna = client->xdna;
>> -    struct amdxdna_dev_hdl *ndev;
>> -    int ret = 0;
>> -    u32 buf_sz;
>> -
>> -    ndev = xdna->dev_handle;
>> -    meta = kzalloc_obj(*meta);
>> -    if (!meta)
>> -        return -ENOMEM;
>> -
>> -    meta->col_size = ndev->metadata.size;
>> -    meta->cols = ndev->metadata.cols;
>> -    meta->rows = ndev->metadata.rows;
>> -
>> -    meta->version.major = ndev->metadata.version.major;
>> -    meta->version.minor = ndev->metadata.version.minor;
>> -
>> -    meta->core.row_count = ndev->metadata.core.row_count;
>> -    meta->core.row_start = ndev->metadata.core.row_start;
>> -    meta->core.dma_channel_count = 
>> ndev->metadata.core.dma_channel_count;
>> -    meta->core.lock_count = ndev->metadata.core.lock_count;
>> -    meta->core.event_reg_count = ndev->metadata.core.event_reg_count;
>> -
>> -    meta->mem.row_count = ndev->metadata.mem.row_count;
>> -    meta->mem.row_start = ndev->metadata.mem.row_start;
>> -    meta->mem.dma_channel_count = ndev->metadata.mem.dma_channel_count;
>> -    meta->mem.lock_count = ndev->metadata.mem.lock_count;
>> -    meta->mem.event_reg_count = ndev->metadata.mem.event_reg_count;
>> -
>> -    meta->shim.row_count = ndev->metadata.shim.row_count;
>> -    meta->shim.row_start = ndev->metadata.shim.row_start;
>> -    meta->shim.dma_channel_count = 
>> ndev->metadata.shim.dma_channel_count;
>> -    meta->shim.lock_count = ndev->metadata.shim.lock_count;
>> -    meta->shim.event_reg_count = ndev->metadata.shim.event_reg_count;
>> -
>> -    buf_sz = min(args->buffer_size, sizeof(*meta));
>> -    if (copy_to_user(u64_to_user_ptr(args->buffer), meta, buf_sz))
>> -        ret = -EFAULT;
>> -
>> -    kfree(meta);
>> -    return ret;
>> -}
>> -
>>   static int aie2_get_aie_version(struct amdxdna_client *client,
>>                   struct amdxdna_drm_get_info *args)
>>   {
>> @@ -1039,6 +992,7 @@ static int aie2_get_preempt_state(struct 
>> amdxdna_client *client,
>>   static int aie2_get_info(struct amdxdna_client *client, struct 
>> amdxdna_drm_get_info *args)
>>   {
>>       struct amdxdna_dev *xdna = client->xdna;
>> +    struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
>>       int ret, idx;
>>         if (!drm_dev_enter(&xdna->ddev, &idx))
>> @@ -1053,7 +1007,7 @@ static int aie2_get_info(struct amdxdna_client 
>> *client, struct amdxdna_drm_get_i
>>           ret = aie2_get_aie_status(client, args);
>>           break;
>>       case DRM_AMDXDNA_QUERY_AIE_METADATA:
>> -        ret = aie2_get_aie_metadata(client, args);
>> +        ret = amdxdna_get_metadata(&ndev->aie, client, args);
>>           break;
>>       case DRM_AMDXDNA_QUERY_AIE_VERSION:
>>           ret = aie2_get_aie_version(client, args);
>> diff --git a/drivers/accel/amdxdna/aie2_pci.h 
>> b/drivers/accel/amdxdna/aie2_pci.h
>> index f12073175676..c884fed610f9 100644
>> --- a/drivers/accel/amdxdna/aie2_pci.h
>> +++ b/drivers/accel/amdxdna/aie2_pci.h
>> @@ -77,29 +77,6 @@ struct amdxdna_fw_ver;
>>   struct amdxdna_hwctx;
>>   struct amdxdna_sched_job;
>>   -struct aie_version {
>> -    u16 major;
>> -    u16 minor;
>> -};
>> -
>> -struct aie_tile_metadata {
>> -    u16 row_count;
>> -    u16 row_start;
>> -    u16 dma_channel_count;
>> -    u16 lock_count;
>> -    u16 event_reg_count;
>> -};
>> -
>> -struct aie_metadata {
>> -    u32 size;
>> -    u16 cols;
>> -    u16 rows;
>> -    struct aie_version version;
>> -    struct aie_tile_metadata core;
>> -    struct aie_tile_metadata mem;
>> -    struct aie_tile_metadata shim;
>> -};
>> -
>>   enum rt_config_category {
>>       AIE2_RT_CFG_INIT,
>>       AIE2_RT_CFG_CLK_GATING,
>> @@ -178,7 +155,6 @@ struct amdxdna_dev_hdl {
>>         u32                total_col;
>>       struct aie_version        version;
>> -    struct aie_metadata        metadata;
>>       struct aie2_exec_msg_ops    *exec_msg_ops;
>>         /* power management and clock*/
>> diff --git a/drivers/accel/amdxdna/aie4_message.c 
>> b/drivers/accel/amdxdna/aie4_message.c
>> index d621dd32ac40..ac89a9a842b2 100644
>> --- a/drivers/accel/amdxdna/aie4_message.c
>> +++ b/drivers/accel/amdxdna/aie4_message.c
>> @@ -25,3 +25,40 @@ int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev)
>>         return ret;
>>   }
>> +
>> +int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev, struct 
>> aie_metadata *metadata)
>> +{
>> +    DECLARE_AIE_MSG(aie4_msg_aie4_tile_info, 
>> AIE4_MSG_OP_AIE_TILE_INFO);
>> +    int ret;
>> +
>> +    ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
>> +    if (ret)
>> +        return ret;
>> +
>> +    metadata->size = resp.info.size;
>> +    metadata->cols = resp.info.cols;
>> +    metadata->rows = resp.info.rows;
>> +
>> +    metadata->version.major = resp.info.major;
>> +    metadata->version.minor = resp.info.minor;
>> +
>> +    metadata->core.row_count = resp.info.core_rows;
>> +    metadata->core.row_start = resp.info.core_row_start;
>> +    metadata->core.dma_channel_count = resp.info.core_dma_channels;
>> +    metadata->core.lock_count = resp.info.core_locks;
>> +    metadata->core.event_reg_count = resp.info.core_events;
>> +
>> +    metadata->mem.row_count = resp.info.mem_rows;
>> +    metadata->mem.row_start = resp.info.mem_row_start;
>> +    metadata->mem.dma_channel_count = resp.info.mem_dma_channels;
>> +    metadata->mem.lock_count = resp.info.mem_locks;
>> +    metadata->mem.event_reg_count = resp.info.mem_events;
>> +
>> +    metadata->shim.row_count = resp.info.shim_rows;
>> +    metadata->shim.row_start = resp.info.shim_row_start;
>> +    metadata->shim.dma_channel_count = resp.info.shim_dma_channels;
>> +    metadata->shim.lock_count = resp.info.shim_locks;
>> +    metadata->shim.event_reg_count = resp.info.shim_events;
>> +
>> +    return 0;
>> +}
>> diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h 
>> b/drivers/accel/amdxdna/aie4_msg_priv.h
>> index 7faa01ca3436..69e220e40900 100644
>> --- a/drivers/accel/amdxdna/aie4_msg_priv.h
>> +++ b/drivers/accel/amdxdna/aie4_msg_priv.h
>> @@ -18,6 +18,7 @@ enum aie4_msg_opcode {
>>       AIE4_MSG_OP_DESTROY_PARTITION                = 0x30002,
>>       AIE4_MSG_OP_CREATE_HW_CONTEXT                = 0x30003,
>>       AIE4_MSG_OP_DESTROY_HW_CONTEXT               = 0x30004,
>> +    AIE4_MSG_OP_AIE_TILE_INFO                    = 0x30006,
>>   };
>>     enum aie4_msg_status {
>> @@ -96,4 +97,37 @@ struct aie4_msg_destroy_hw_context_resp {
>>       enum aie4_msg_status status;
>>   } __packed;
>>   +struct aie4_tile_info {
>> +    __u32 size;
>> +    __u16 major;
>> +    __u16 minor;
>> +    __u16 cols;
>> +    __u16 rows;
>> +    __u16 core_rows;
>> +    __u16 mem_rows;
>> +    __u16 shim_rows;
>> +    __u16 core_row_start;
>> +    __u16 mem_row_start;
>> +    __u16 shim_row_start;
>> +    __u16 core_dma_channels;
>> +    __u16 mem_dma_channels;
>> +    __u16 shim_dma_channels;
>> +    __u16 core_locks;
>> +    __u16 mem_locks;
>> +    __u16 shim_locks;
>> +    __u16 core_events;
>> +    __u16 mem_events;
>> +    __u16 shim_events;
>> +    __u16 resvd;
>> +} __packed;
>> +
>> +struct aie4_msg_aie4_tile_info_req {
>> +    __u32 resvd;
>> +} __packed;
>> +
>> +struct aie4_msg_aie4_tile_info_resp {
>> +    enum aie4_msg_status status;
>> +    struct aie4_tile_info info;
>> +} __packed;
>> +
>>   #endif /* _AIE4_MSG_PRIV_H_ */
>> diff --git a/drivers/accel/amdxdna/aie4_pci.c 
>> b/drivers/accel/amdxdna/aie4_pci.c
>> index 9ff34ce57fcb..8b5eff0e45c1 100644
>> --- a/drivers/accel/amdxdna/aie4_pci.c
>> +++ b/drivers/accel/amdxdna/aie4_pci.c
>> @@ -269,6 +269,11 @@ static void aie4_partition_fini(struct 
>> amdxdna_dev_hdl *ndev)
>>           XDNA_ERR(xdna, "partition fini failed: %d", ret);
>>   }
>>   +static int aie4_query(struct amdxdna_dev_hdl *ndev)
>> +{
>> +    return aie4_query_aie_metadata(ndev, &ndev->aie.metadata);
>> +}
>> +
>>   static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
>>   {
>>       int ret;
>> @@ -308,6 +313,10 @@ static int aie4_vf_hw_start(struct 
>> amdxdna_dev_hdl *ndev)
>>       if (ret)
>>           return ret;
>>   +    ret = aie4_query(ndev);
>> +    if (ret)
>> +        goto mailbox_fini;
>> +
>>       ret = aie4_partition_init(ndev);
>>       if (ret)
>>           goto mailbox_fini;
>> @@ -535,6 +544,26 @@ static int aie4_doorbell_mmap(struct 
>> amdxdna_client *client, struct vm_area_stru
>>       return ret;
>>   }
>>   +static int aie4_get_info(struct amdxdna_client *client, struct 
>> amdxdna_drm_get_info *args)
>> +{
>> +    struct amdxdna_dev *xdna = client->xdna;
>> +    struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
>> +    int ret;
>> +
>> +    switch (args->param) {
>> +    case DRM_AMDXDNA_QUERY_AIE_METADATA:
>> +        ret = amdxdna_get_metadata(&ndev->aie, client, args);
>> +        break;
>> +    default:
>> +        XDNA_ERR(xdna, "Not supported request parameter %u", 
>> args->param);
>> +        ret = -EOPNOTSUPP;
>> +    }
>> +
>> +    XDNA_DBG(xdna, "Got param %d", args->param);
>> +
>> +    return ret;
>> +}
>> +
>>   static int aie4_pf_init(struct amdxdna_dev *xdna)
>>   {
>>       int ret;
>> @@ -581,4 +610,5 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
>>       .hwctx_fini        = aie4_hwctx_fini,
>>       .mmap            = aie4_doorbell_mmap,
>>       .cmd_wait        = aie4_cmd_wait,
>> +    .get_aie_info        = aie4_get_info,
>>   };
>> diff --git a/drivers/accel/amdxdna/aie4_pci.h 
>> b/drivers/accel/amdxdna/aie4_pci.h
>> index b69489acd53d..1886cffc62db 100644
>> --- a/drivers/accel/amdxdna/aie4_pci.h
>> +++ b/drivers/accel/amdxdna/aie4_pci.h
>> @@ -56,6 +56,7 @@ struct amdxdna_dev_hdl {
>>   };
>>     /* aie4_message.c */
>> +int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev, struct 
>> aie_metadata *metadata);
>>   int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev);
>>     /* aie4_ctx.c */
>
