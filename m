Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B676ACC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 17:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFC7C10E37C;
	Fri, 16 Oct 2026 17:39:32 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1994510E3B2
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 17:39:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfChtMXVK5f5+1mjs7ZGS2epIf+3bTCcr//7AfVedLFR1owuSAkurRqhFGyzWHaEcvQZwDOH2IKiKJwVsAw5arJwS10DfNPnklX6r/YeSEp/XunlivWPD+j7AWHltTZySX+ZuAjR4PPwUDcudJCDp3EyEL/wimg9LX9deLspTKx1pXUUghEc7RregfgYD3a4eF6mD80XcWM1RveD0taDLo9l2QcgApQvxfL4WvLq4VNoUsBqt3fZwF1p+oCy9BJri0sM5M+lfVxQupfj4jfu74NhVpA/gzAwFob18a5w2DEKSbWOtWORi41RyE+B/5KIWW5ARM//iah4627ko6VcKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWV9+crKJCaC+1g4MRbkHXYWmrMX1PSMFDxW2regO1k=;
 b=IOx4CcV6Xa0GxRUkmMIuh3SX2KSqxcSkoZdRAFntJFNCxHOmgzgFsJi970rVLjrdde9Wl5cfFosF361pz3UsRWuAWQY483HXBAHXsqCEaYS0Ba1XtyO1IRJFoQF886a/MmTZS/gPjK1Ct9rL2wlRo5FKA7WXoh5ol9kA8K1905ii6ua5ZLv57OjV7GMQEPjWdNIF8G3dIdvGdj6Buvb2WVuwHJtbD+O+5lrRLlGxDaYmtrDERtdC5k0YyEKz7wUpDa5kaudGtl7B2xHtxfKqKexYURcMVAOdsS23jWn01bp1oogx4AwQmFJO1nQYRLOCWZD63PJ8rRZaHk5YMOzrsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWV9+crKJCaC+1g4MRbkHXYWmrMX1PSMFDxW2regO1k=;
 b=Tr0p6zMo5JxBEEmrIvAhZqzNM62fuFOJyXkTs6r1/tnj6fZcDczmzzH9pLr8cXrr37QLGmxqvIISVCltbdW6pb5P2BJ35Pwt8b4Cjqyyqc5noUfrjeq8OTkLQAZz+tuQZ7sxrFxy+3OVQ8vVfOR6NgZ6KGDXAFTLRZEfYbrszTw=
Received: from SJ0PR05CA0187.namprd05.prod.outlook.com (2603:10b6:a03:330::12)
 by IA0PPF04DCE520E.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 17:39:18 +0000
Received: from CO1PEPF00018868.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::e) by SJ0PR05CA0187.outlook.office365.com
 (2603:10b6:a03:330::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 16
 Oct 2026 17:39:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00018868.mail.protection.outlook.com (10.167.249.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 17:39:14 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 12:38:48 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 16 Oct 2026 12:38:47 -0500
Message-ID: <4d30b12f-9a9b-8818-4731-fe5795742882@amd.com>
Date: Fri, 16 Oct 2026 10:38:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: wait uninterruptibly for jobs in the
 HMM invalidate callback
Content-Language: en-US
To: Max Zhen <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>,
 <yidong.zhang@amd.com>
CC: Matthew Brost <matthew.brost@intel.com>
References: <20261015183248.3414119-1-lizhi.hou@amd.com>
 <db7515cc-8549-4ce2-9c83-9d20e6776150@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <db7515cc-8549-4ce2-9c83-9d20e6776150@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00018868:EE_|IA0PPF04DCE520E:EE_
X-MS-Office365-Filtering-Correlation-Id: a96697d2-19fc-4a19-0bfe-08df2bac6578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|6133799003|22082099003|261009223027099003|10067099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: M/4iFVdhDPmB2CUemH8wSnGm2KR4lfpP5K+ez8puxKb65SJdVwFVvL7qTGR5kLy0H7xgMGxwsGdh2X7ZDUi+L6Mv6NoL1Z6yW7ymlxCAIeKqEL2TQ9vZDafONCMBfdnr33hp/5RQqhAp+RoMwHsO+PkgJ3BQEcPDxZGqfEQkCELqo6A/fV521utNPruvg+65INAHToDsOUJYbb24/rYJDJxv6nukFMWGwx/HMUywhPQ0h4zDIuO1xyf8fg5uGpdBk6QFcLd9nG4WR6VUJzq0+sM4VWwo50elclofNUAc91gvawme/4gFMZ2qIxyz6Zt5ks9BusuC6FrfH8WuUSntTZ0G5ZJrBZTJOdTv0+eZjSNWADwDswFKXWir+7g0mEmOOtcPpM0uE15f52xxY0yh/X23kPjWSb/wHHorKEpKTFlMl+sg9XyfSu/QeF+bPpURTHPSXmJ/Ct1PXj16EfUl2Eo9IkT0JgGP4IQw4QepNgZjQWs/2v64vjXaIw42fvHc24QT7lF0iK2V/GaKV+A45R/4uVPYAS+DxJ8LTLJCXI90P+nPbVlz4Asufu/ppT6lwcErSFDMDTqZ4Cccg2c/6uOj0wzq1aUMsE2khmCM1ylSTLcSlno3drf2I5fFmrHNxmllQGdJ0hF2zo/EJb7a7tLc2l+PGjv3XZE/158x4UpjGBOIaeUAHxpA+gB8ZAYHoeQBFnklxov2bjS8kdc46g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(6133799003)(22082099003)(261009223027099003)(10067099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZWdW+sgUgPfwXV87XoG0LtbZkbitZzogvt5suuVBOwe0Vloi3RxfuOW3CVIaZ2213fPND4paumEJNlDSULHuyVBzTAuUZ7mYynbvfwhXs4+bc1kS751v09H5bixYwPO+cWOofTnMu81XxKBaDNkoKvvbEVu7TILerUZNT1UuVyzNW8B1oX/LXn+Ge48kug4bOn/oagxWiHjESSCWJADVD4gpk/bBBy1ei0sc855l/2e92uF3jH9H3msiavC7HxSYTXHbXMDnU0DYv46Wpv7c2aCu6aIMEP/+XTkgCo2BxCGqWDps2vmySEtE9QUBSWL388//0zWWdL/lNPGjmTEV0Can/xTOWNI5w9ooczn4Y9n9jxccHfV0rrwjQdNcGMpvNe27fYo9vD70smY/LMeJgd5vtiQFD5z+6Yc7KFUVf77JiZBB5AZQghxtGqfQC30B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 17:39:14.5851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a96697d2-19fc-4a19-0bfe-08df2bac6578
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00018868.namprd03.prod.outlook.com
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

Applied to drm-misc-next

On 10/16/26 10:04, Max Zhen wrote:
>
>
> On 10/15/2026 Thu 11:32, Lizhi Hou wrote:
>> From: Matthew Brost <matthew.brost@intel.com>
>>
>> aie2_hmm_invalidate() waits for the jobs using a BO before the CPU pages
>> behind it are released, but does so interruptibly. When the task
>> triggering the invalidation has a signal pending the wait returns
>> -ERESTARTSYS immediately, the notifier completes and the pages can be
>> freed or migrated while the device is still accessing them through the
>> PASID.
>>
>> An MMU notifier cannot fail a blockable invalidation, so wait
>> uninterruptibly. With MAX_SCHEDULE_TIMEOUT an uninterruptible wait
>> cannot time out either, so drop the now dead error handling.
>>
>> Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
>> Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Max Zhen <max.zhen@amd.com>
>> ---
>>   drivers/accel/amdxdna/aie2_ctx.c | 16 ++++++----------
>>   1 file changed, 6 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index 9c6b7353cbe9..84ab8a55b7ab 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -1286,16 +1286,12 @@ int aie2_cmd_submit(struct amdxdna_hwctx 
>> *hwctx, struct amdxdna_sched_job *job,
>>   void aie2_hmm_invalidate(struct amdxdna_gem_obj *abo,
>>                unsigned long cur_seq)
>>   {
>> -    struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
>> -    struct drm_gem_object *gobj = to_gobj(abo);
>> -    long ret;
>> -
>> -    ret = dma_resv_wait_timeout(gobj->resv, DMA_RESV_USAGE_BOOKKEEP,
>> -                    true, MAX_SCHEDULE_TIMEOUT);
>> -    if (!ret)
>> -        XDNA_ERR(xdna, "Failed to wait for bo, ret %ld", ret);
>> -    else if (ret == -ERESTARTSYS)
>> -        XDNA_DBG(xdna, "Wait for bo interrupted by signal");
>> +    /*
>> +     * The pages must not be released while the device may still access
>> +     * them, so this wait must be neither interruptible nor time 
>> limited.
>> +     */
>> +    dma_resv_wait_timeout(to_gobj(abo)->resv, DMA_RESV_USAGE_BOOKKEEP,
>> +                  false, MAX_SCHEDULE_TIMEOUT);
>>   }
>>     int aie2_hwctx_heap_expand(struct amdxdna_hwctx *hwctx,
>
