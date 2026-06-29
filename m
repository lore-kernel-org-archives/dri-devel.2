Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9210AC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 18:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1FAB10E0CE;
	Mon, 29 Jun 2026 18:01:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hx+otyOh";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F7BA10E0CE
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 18:01:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGE8yHL93jsVbEENkYOrICO0PNboTeHY6dqYsCq+KWiW1Q86iSS9p0ym2pZKFjtQ2SGdokR5SNSi5z3+0r0QVgwzRimMaBlGkK/XSCnlYzT/1XJo3OadJsPGeVvBJvTK+bN/9LGEwj04PE4f8tj5EOXV1D32ic0QnyRXscsH8OorLr5hpgYt6sy1PzPuLaJ8CsSx1wHvOlKJC/ksQcv0fzxbSwhx/p3/xQKwLYR8hdoeOxXQGJQ+Yc790tUwx7A6k+9JLvmaPfybT+IQaSvgM3Xj+j+UvEOO7W8M3j+TN6t5Q/rIvQGdxsmzmbIY5YaBGF/koKhn+If2jZ52efIbWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMM2ACmyCrbfsJASBPS7qW53vRrDmtfkpaf3bbG6ZT8=;
 b=yf/7IZdG2lKv8Mp6A+zhvf8DNRwcsasrvicxgkJ1/NTV+MnKdwTrSpbHgiizZYPaUGvfdMA7skp1y9VisIagXnDN3iO2tm2H14nnLxWt6SYxAs6ieEtjP3umHg83pk3F8El7s7lImjXjzYYcQfx7n2i1KetpLB4hQ00nNrOkI+rytBIDHG+KlX8nvkJX8S8UW+kIyuKceoJMhKmT1Bx+eSrhJR2F/ardyxglrqpljUdCvHqyOg56Q0bgW7uJMYOBvoiPDgUZHmhJCbHpaUGVco+v1sPEdpCTMjpRMLbmUZyutD96zzMTf7SXmAsfGG95jChhrtKmfoAq36plGsqrrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMM2ACmyCrbfsJASBPS7qW53vRrDmtfkpaf3bbG6ZT8=;
 b=Hx+otyOhFpUdFAmS+a29uwF+SxHltuJgrJO7M14lQLTYs3QCSX4YlIZ+NSz0MWPvBv4pu8tAIvSmoM3bI09BFRojZ8/zLOLUa90bJiu0PcKGnl4e5F72cXQZhpDMujAv2Zbw/1hfSoVxGt6TO1NVWiRXdWWf26xQUyLhxKmcIQg=
Received: from MN2PR15CA0062.namprd15.prod.outlook.com (2603:10b6:208:237::31)
 by IA0PPF04DCE520E.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 18:01:50 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::8c) by MN2PR15CA0062.outlook.office365.com
 (2603:10b6:208:237::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 18:01:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Mon, 29 Jun 2026 18:01:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 13:01:35 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 11:01:02 -0700
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 29 Jun 2026 13:01:01 -0500
Message-ID: <29b8e37c-2986-3354-9344-ddd065d41a86@amd.com>
Date: Mon, 29 Jun 2026 11:00:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 1/3] accel/amdxdna: Fix amdxdna_client lifetime race
 during device removal
Content-Language: en-US
To: Mario Limonciello <superm1@kernel.org>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>
References: <20260611055150.3070216-1-lizhi.hou@amd.com>
 <7a9d6acd-90db-4dfe-9fe5-55ba8adab577@kernel.org>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <7a9d6acd-90db-4dfe-9fe5-55ba8adab577@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|IA0PPF04DCE520E:EE_
X-MS-Office365-Filtering-Correlation-Id: a4752071-1743-4eda-dca7-08ded6087e73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|18002099003|22082099003|4143699003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: DfzcZ/eYMsCDTCH2VLIhuEupxxyK/cqo4K5aPUECeUNvVOVDrfEdM910hU3+tvtpU1WfJ6ZaRtXNLvwoJUtk5sguRsrjiJhTNquUnNN9IpcFLsdRsSsQpXERAd+6xMVNcZgWM2wsQdvVcjKhehulMyep7b7muGLVbpyojDrkzZxnkCkGD0KsUSPBu8Qv2UB6eTbbj1VSchPE6jb7QNNkLmlfPdqcdmkyQ06kpedE99TntjGb7s9vOJNrNZlZfFNqMyBLTYYDavwKN5jB7ifFJdepSQnS2CgvY8pXgYgGPz/lSpFTc+u41YMP9pscWAInefvJbPH1Lx459e/SLBg+WfJ/dkSZL0vmIftCrXeM6R050hmjrS5fN4MtYx/dP0fUtDlcWfDZT1CFHuhxGSa+ryGnipqFD9v3MbFUhOGP+VDSno+2kOBZfu//pG0OONoTKsl02uX61MDsN14pJKc77i32aaDjwMtkF52gRD/ThuLL0sen91hzOgGiNLAZSrTJ/P9eRNu5w8zoM7uK08h+eB7cGKkoeC1dnnGgNKEMg6xEiuRojeKD8xdVkCnCsHwhvsTU9x8sjTwiThgR7nIqJbaUT/IQTYyJ5ZywvMExi5MAqZohK8TTfqciN6pElEe0V3KU/c7gLIzzY4MRg1JPMHWmoRPV//2lcmJvb5zGGld6BMS3n6XTDtOnsqe50RShXuUh+4auqKVEfjOrrK2Vfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(4143699003)(11063799006)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GZHik4f21uvC5jFmsugqI0APC/+Zb6YhYPcO9fma45v44nSn0NDBdTjcW5xMXWvMgZSxRiJyUZlOblQynmJZCoMH6ioII6kMqW7agmtgaMjRqejO/OaSTXpNBi3XEsVIAm2BmGTEU21j536oTLejQg708MoWJ60ku/qHDjCyC8gfWqXRM3rZ9rbTpXxyKjW8IVmRdDvfZ3/1yyTxd8/GJE4QwC9Pk3XfCzj85wcCY3MRmKfb7HpnRDYokZkbw5T9CYME4TwOIljPmyQd0ArSBY3H7SCnQDsAbD9YBVm0kl7oT+zOJLCNEYVk9KfT0X0Cz74lyGm+ZTz5hb9nJZ/5/4XhQRc6vGrYkmH8Xu9izoodHnYkcn4UP/sS6BMKrYopjXflA+tJ5o5U68/A2aTBpUJMDL6ds9qlxWq2XOjWcHS9pymrnOwE5vupsG2BmhQj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 18:01:50.2366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4752071-1743-4eda-dca7-08ded6087e73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF04DCE520E
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

Applied the patches to drm-misc-fixes.

On 6/12/26 11:25, Mario Limonciello wrote:
>
>
> On 6/11/26 00:51, Lizhi Hou wrote:
>> In amdxdna_remove(), all amdxdna_client structures are freed after
>> calling drm_dev_unplug(). However, drm_dev_unplug() does not force
>> existing file descriptors to be closed, so amdxdna_drm_close() may be
>> called after amdxdna_remove() has completed.
>>
>> As a result, accessing client->pid for debug output in
>> amdxdna_drm_close() can lead to a use-after-free, since the access is
>> not protected by drm_dev_enter().
>>
>> Fix this by decoupling hardware teardown from client cleanup.
>> amdxdna_remove() only performs hardware-related cleanup, while
>> per-client resources are released from amdxdna_drm_close() when the
>> corresponding file is closed.
>>
>> Fixes: be462c97b7df ("accel/amdxdna: Add hardware context")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>   drivers/accel/amdxdna/amdxdna_pci_drv.c | 23 ++++++++++-------------
>>   drivers/accel/amdxdna/amdxdna_pci_drv.h |  1 +
>>   2 files changed, 11 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c 
>> b/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> index 65489bb3f2b0..470bf4fc744b 100644
>> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> @@ -138,9 +138,11 @@ static int amdxdna_drm_open(struct drm_device 
>> *ddev, struct drm_file *filp)
>>               xdna->dev_info->dev_heap_max_size);
>>       mutex_init(&client->mm_lock);
>>   +    mutex_lock(&xdna->client_lock);
>>       mutex_lock(&xdna->dev_lock);
>>       list_add_tail(&client->node, &xdna->client_list);
>>       mutex_unlock(&xdna->dev_lock);
>> +    mutex_unlock(&xdna->client_lock);
>>         filp->driver_priv = client;
>>       client->filp = filp;
>> @@ -174,18 +176,14 @@ static void amdxdna_drm_close(struct drm_device 
>> *ddev, struct drm_file *filp)
>>   {
>>       struct amdxdna_client *client = filp->driver_priv;
>>       struct amdxdna_dev *xdna = to_xdna_dev(ddev);
>> -    int idx;
>>         XDNA_DBG(xdna, "closing pid %d", client->pid);
>>   -    if (!drm_dev_enter(&xdna->ddev, &idx))
>> -        return;
>> -
>> +    mutex_lock(&xdna->client_lock);
>>       mutex_lock(&xdna->dev_lock);
>>       amdxdna_client_cleanup(client);
>>       mutex_unlock(&xdna->dev_lock);
>> -
>> -    drm_dev_exit(idx);
>> +    mutex_unlock(&xdna->client_lock);
>>   }
>>     static int amdxdna_drm_get_info_ioctl(struct drm_device *dev, 
>> void *data, struct drm_file *filp)
>> @@ -372,6 +370,7 @@ static int amdxdna_probe(struct pci_dev *pdev, 
>> const struct pci_device_id *id)
>>           return -ENODEV;
>>         drmm_mutex_init(ddev, &xdna->dev_lock);
>> +    drmm_mutex_init(ddev, &xdna->client_lock);
>>       init_rwsem(&xdna->notifier_lock);
>>       INIT_LIST_HEAD(&xdna->client_list);
>>       pci_set_drvdata(pdev, xdna);
>> @@ -442,18 +441,16 @@ static void amdxdna_remove(struct pci_dev *pdev)
>>       drm_dev_unplug(&xdna->ddev);
>>       amdxdna_sysfs_fini(xdna);
>>   +    mutex_lock(&xdna->client_lock);
>>       mutex_lock(&xdna->dev_lock);
>> -    client = list_first_entry_or_null(&xdna->client_list,
>> -                      struct amdxdna_client, node);
>> -    while (client) {
>> -        amdxdna_client_cleanup(client);
>> -
>> -        client = list_first_entry_or_null(&xdna->client_list,
>> -                          struct amdxdna_client, node);
>> +    list_for_each_entry(client, &xdna->client_list, node) {
>> +        amdxdna_hwctx_remove_all(client);
>> +        amdxdna_sva_fini(client);
>>       }
>>         xdna->dev_info->ops->fini(xdna);
>>       mutex_unlock(&xdna->dev_lock);
>> +    mutex_unlock(&xdna->client_lock);
>>         amdxdna_iommu_fini(xdna);
>>   }
>> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h 
>> b/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> index 34271c14d359..a997d27a504d 100644
>> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> @@ -120,6 +120,7 @@ struct amdxdna_dev {
>>         struct mutex            dev_lock; /* per device lock */
>>       struct list_head        client_list;
>> +    struct mutex            client_lock; /* client_list */
>>       struct amdxdna_fw_ver        fw_ver;
>>       struct rw_semaphore        notifier_lock; /* for mmu notifier*/
>>       struct workqueue_struct        *notifier_wq;
>
