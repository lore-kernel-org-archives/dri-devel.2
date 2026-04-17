Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65DDF436B9
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 16:17:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4986810E2C4;
	Fri, 17 Apr 2026 16:17:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="woW7XXQy";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEB7E10E2C4
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 16:17:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIW0f1a/NsACINBA9+wW3V46nXUZSDzemzK9DES38SRHWucrpuIuz4czqnSP2qkDZ/goUKKTXeXPCs0PC9YCwzYKJhZ/ILrii8KCuCx6/X2qbTaBgK4y+WneWHN7XPBzCxeZgf57aNn+Ml/UStHX6Oi/ystdl0NmehD+wcd/QMPRTRn1ObqZl+8zvaPZ+Nw7c4JKNtqJ5IEzJ9uiQD1SQzyrjyxKHpbsqmss3KQzpd7wR02JEepFXdEMBWu237/caNt5nEvptCmuw/W8RCuG+4WPSiH7DTtxAzVieG2aohYnp8PpHI9zEUeqgSJ2R1jfB0F/lsi3SwGo68jdN3I1Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDDhRjH+bbJwmS2Tyhut50SddEsoVfomG80LQ7t4+No=;
 b=O6KLibceXA7JOdcuySMXUIggxWZgRrCYO+TVs2BYXnx9amjOsfT2WMOsl3BOh9F0HK3v+99+CUPmtw7NGRuE8xJ6olL2SpS5QXcCT1n9DlrSvqd/J1Yf3SWvEM4ISs0nXOCsPvTKc7M3aSvug+Mr89tH+opWF+iIl+qdD64S5xgOj5bZNo2zoHCXWOPMjzwlS6kythrzo2ElZWQUJYXnoa9N92jkQdg60a1hauvG3SS0vLxy3a7o8rpYHTuXdo/EkP3LQXA5Mvc2dFuQQFhlbgRB0wCcvFV1idhrCKXaJ3acwTdOgf8ZA09z2Lvw1ihYwlHp6/IBQjUa39/5M41kpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDDhRjH+bbJwmS2Tyhut50SddEsoVfomG80LQ7t4+No=;
 b=woW7XXQyLS2U4WQWUN4Xu26ayIqeS+JZasGbXbXA/jaMTg89gnV0M2xOSpUJpiP227BfQ/8DtdYSc+8RbmutdbCmvE96BJtf/CCrDfDQs71Llq64TOqHgfEO+4TY4mt3vW11MnU+cd2SdTAXx31VOecGTvMyxsa2pFemr6J9TBQ=
Received: from MN2PR01CA0049.prod.exchangelabs.com (2603:10b6:208:23f::18) by
 DS0PR12MB9323.namprd12.prod.outlook.com (2603:10b6:8:1b3::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.25; Fri, 17 Apr 2026 16:17:48 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::ee) by MN2PR01CA0049.outlook.office365.com
 (2603:10b6:208:23f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 16:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 17 Apr 2026 16:17:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Apr
 2026 11:17:47 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Apr
 2026 09:17:47 -0700
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 17 Apr 2026 11:17:47 -0500
Message-ID: <24a7ee40-32d1-29b9-c5bb-4aa6a5b633e9@amd.com>
Date: Fri, 17 Apr 2026 09:17:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2] accel/amdxdna: Get device revision to derive VBNV
 string
Content-Language: en-US
To: Mario Limonciello <superm1@kernel.org>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <maciej.falkowski@linux.intel.com>
CC: Max Zhen <max.zhen@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
References: <20260416190150.1040067-1-lizhi.hou@amd.com>
 <e02b5212-d066-419c-9191-1ffe31329f54@kernel.org>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <e02b5212-d066-419c-9191-1ffe31329f54@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|DS0PR12MB9323:EE_
X-MS-Office365-Filtering-Correlation-Id: bfdb1d7d-91d3-4dcd-75b7-08de9c9cddb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HfrWbkocCC8VrA+h18Cjg3WIoMCNHGnFWfLVFEJPG6Pvcqb8qTMiLHZDJeeETX6vEj9YAt+YjEWWDvfyg8w4aktY3pt5wqBifKXz8zhhkUS2j8mGtTNvn/iQVyJuTth4DndET4ih6nmAil1FbWM0Mx9lPnHytz1R7ZXXDreYAcd7oQ/+lL5170qJ/F1P+EEgjd7gy0m9l+I/trDNUGI3Kefz4QZTACOmU9uwJc0zbHKvhmRomRZOgx6qjL5zj46mWw3R2B2yufS2/VSGLDygIVahDRG6fhPnTCUQh9Wkmowa6rhlR8xOItXkdm3QqkZBbIPy2Y0M3+MZ6RLuFCL36LavpHkLrIxdaBUEQwJoZHrwICPVm1tydlIIPcEuEbemBAxtntPA+nHc4pAnB4314auyZoEd+7SPszsZKNwAUsrfEsL8uL46Pk423O3ZqlOn/e8iLTa3yhbx32fshI6PWzshsabxJ36bZ8JI+pPkvSqBeSXbBUKG9WDxS+rBIuFGIFt3rZmPZM/2ihjDlBEFMdCFp0+8Og7++PGyXlYOJHk7AYTNd/C/cHXy8uhhB3kwoU02BWw0lZerPChbVR/IQD1xOVZWnobh8vVoJEXfzIN6jNO4xoSURINb5leS6G5yFHJ6ZGA9/3zK5rq89ZHUR9h6KSCgz6e/U3ZgX6PvNSYMowmRhDvNCqgNVWzb6VC+lb1T2syatcagH1D0738aT41mi+6fZI0amoV5N+r7wZzBfp1YgnK+Xd81AG7omSssBPu7HlYkv6syDG59pUVKSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8kiq8FIH4SRxD9TAnR0+OTKrA6logAm4fOjhY9vYe98PS17Z4JRkywV0vgF/RcAK1NM5TsSZnWHnYapCe6wmcFQbrqxIS2zY18QlJbjknfBU6nZTi3lD1MSXNLawP2UjEtgJN9t+woS4X8LRgti8EPtoxCHji7PvMwKXABU52E9VlwC7Aji78E95oFdZjhi9Tabg56LYoSlnc2+f1i7c5a3+DLV54cLcpXxl8eQH1E87OF/sgbVHe/nQv6Y4x8ScYSUM1bX1fvih0Im+g9HqtugWC8Qkuhb47yzjsT7zMZnr2WW5r/WUU9fhjczM5WGA2t1XtYrDu2a6x9sJ2c3ST/Ajr2VfA53u5QXflikX+xooTT9ZhShgH2MMDpuLHy2m7J9MThk+K7BxaKXhhYdOlsWjQSZeTY5aK3SaNfwU78sOtORHFDeg/xS4lk4Stk+K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 16:17:48.1440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfdb1d7d-91d3-4dcd-75b7-08de9c9cddb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9323
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

On 4/16/26 15:45, Mario Limonciello wrote:
>
>
> On 4/16/26 14:01, Lizhi Hou wrote:
>> From: Max Zhen <max.zhen@amd.com>
>>
>> Add support for querying the device revision from firmware.
>>
>> Use the returned revision to look up the VBNV string during device
>> initialization, and fall back to the default VBNV when the revision
>> query is not supported or no mapping is found.
>>
>> This allows the driver to report the accurate VBNV for devices that
>> share the same vendor/device ID but differ by hardware revision.
>>
>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>> [Lizhi: Revise amdxdna_vbnv_init()]
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>   drivers/accel/amdxdna/aie.c             | 30 +++++++++++++++++++++++++
>>   drivers/accel/amdxdna/aie.h             |  7 ++++++
>>   drivers/accel/amdxdna/aie2_message.c    | 25 +++++++++++++++++++++
>>   drivers/accel/amdxdna/aie2_msg_priv.h   | 23 +++++++++++++++++++
>>   drivers/accel/amdxdna/aie2_pci.c        | 17 ++++++++++++++
>>   drivers/accel/amdxdna/aie2_pci.h        |  3 +++
>>   drivers/accel/amdxdna/aie4_pci.c        |  1 +
>>   drivers/accel/amdxdna/amdxdna_pci_drv.h |  6 ++++-
>>   drivers/accel/amdxdna/amdxdna_sysfs.c   |  5 ++++-
>>   drivers/accel/amdxdna/npu1_regs.c       |  2 +-
>>   drivers/accel/amdxdna/npu3_regs.c       |  2 +-
>>   drivers/accel/amdxdna/npu4_regs.c       | 16 ++++++++++++-
>>   drivers/accel/amdxdna/npu5_regs.c       |  3 ++-
>>   drivers/accel/amdxdna/npu6_regs.c       |  3 ++-
>>   14 files changed, 136 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie.c b/drivers/accel/amdxdna/aie.c
>> index 4b3d4493128e..66849ba9026a 100644
>> --- a/drivers/accel/amdxdna/aie.c
>> +++ b/drivers/accel/amdxdna/aie.c
>> @@ -87,3 +87,33 @@ int aie_check_protocol(struct aie_device *aie, u32 
>> fw_major, u32 fw_minor)
>>         return found ? 0 : -EOPNOTSUPP;
>>   }
>> +
>> +static void amdxdna_update_vbnv(struct amdxdna_dev *xdna,
>> +                const struct amdxdna_rev_vbnv *tbl,
>> +                u32 rev)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; tbl[i].vbnv; i++) {
>> +        if (tbl[i].revision == rev) {
>> +            xdna->vbnv = tbl[i].vbnv;
>> +            break;
>> +        }
>> +    }
>> +}
>> +
>> +void amdxdna_vbnv_init(struct amdxdna_dev *xdna)
>> +{
>> +    const struct amdxdna_dev_info *info = xdna->dev_info;
>> +    u32 rev;
>> +
>> +    xdna->vbnv = info->default_vbnv;
>> +
>> +    if (!info->ops->get_dev_revision || !info->rev_vbnv_tbl)
>> +        return;
>> +
>> +    if (info->ops->get_dev_revision(xdna, &rev))
>> +        return;
>> +
>> +    amdxdna_update_vbnv(xdna, info->rev_vbnv_tbl, rev);
>> +}
>> diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
>> index ba4c9ee21823..7a68b114f235 100644
>> --- a/drivers/accel/amdxdna/aie.h
>> +++ b/drivers/accel/amdxdna/aie.h
>> @@ -82,11 +82,18 @@ struct psp_config {
>>       u32            notify_val;
>>   };
>>   +/* Device revision to VBNV string mapping table entry */
>> +struct amdxdna_rev_vbnv {
>> +    u32        revision;
>> +    const char    *vbnv;
>> +};
>> +
>>   /* aie.c */
>>   void aie_dump_mgmt_chann_debug(struct aie_device *aie);
>>   void aie_destroy_chann(struct aie_device *aie, struct 
>> mailbox_channel **chann);
>>   int aie_send_mgmt_msg_wait(struct aie_device *aie, struct 
>> xdna_mailbox_msg *msg);
>>   int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 
>> fw_minor);
>> +void amdxdna_vbnv_init(struct amdxdna_dev *xdna);
>>     /* aie_psp.c */
>>   struct psp_device *aiem_psp_create(struct drm_device *ddev, struct 
>> psp_config *conf);
>> diff --git a/drivers/accel/amdxdna/aie2_message.c 
>> b/drivers/accel/amdxdna/aie2_message.c
>> index 976ad6281078..6e98af7b74db 100644
>> --- a/drivers/accel/amdxdna/aie2_message.c
>> +++ b/drivers/accel/amdxdna/aie2_message.c
>> @@ -1244,3 +1244,28 @@ int aie2_update_prop_time_quota(struct 
>> amdxdna_dev_hdl *ndev, u32 us)
>>       }
>>       return ret;
>>   }
>> +
>> +int aie2_get_dev_revision(struct amdxdna_dev_hdl *ndev, enum 
>> aie2_dev_revision *rev)
>> +{
>> +    DECLARE_AIE_MSG(get_dev_revision, MSG_OP_GET_DEV_REVISION);
>> +    struct amdxdna_dev *xdna = ndev->aie.xdna;
>> +    int ret;
>> +
>> +    if (!AIE_FEATURE_ON(&ndev->aie, AIE2_GET_DEV_REVISION))
>> +        return -EOPNOTSUPP;
>> +
>> +    ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
>> +    if (ret)
>> +        return ret;
>> +
>> +    *rev = resp.rev;
>> +
>> +    if (*rev < AIE2_DEV_REVISION_STXA || *rev >= 
>> AIE2_DEV_REVISION_UNKN) {
>> +        XDNA_ERR(xdna, "Unknown device revision: %d (raw fuse: 0x%x)",
>> +             *rev, resp.raw_fuse_data);
>> +        return -EINVAL;
>> +    }
>> +
>> +    XDNA_DBG(xdna, "Device revision: %d (raw fuse: 0x%x)", *rev, 
>> resp.raw_fuse_data);
>> +    return 0;
>> +}
>> diff --git a/drivers/accel/amdxdna/aie2_msg_priv.h 
>> b/drivers/accel/amdxdna/aie2_msg_priv.h
>> index b10552c627ee..a41c9797e265 100644
>> --- a/drivers/accel/amdxdna/aie2_msg_priv.h
>> +++ b/drivers/accel/amdxdna/aie2_msg_priv.h
>> @@ -33,6 +33,7 @@ enum aie2_msg_opcode {
>>       MSG_OP_REGISTER_ASYNC_EVENT_MSG    = 0x10C,
>>       MSG_OP_UPDATE_PROPERTY             = 0x113,
>>       MSG_OP_GET_APP_HEALTH              = 0x114,
>> +    MSG_OP_GET_DEV_REVISION            = 0x117,
>>       MSG_OP_MAX_DRV_OPCODE,
>>       MSG_OP_GET_PROTOCOL_VERSION        = 0x301,
>>       MSG_OP_MAX_OPCODE
>> @@ -519,4 +520,26 @@ struct update_property_resp {
>>       enum aie2_msg_status status;
>>   } __packed;
>>   +enum aie2_dev_revision {
>> +    AIE2_DEV_REVISION_STXA = 1,
>> +    AIE2_DEV_REVISION_STXB,
>> +    AIE2_DEV_REVISION_KRK1,
>> +    AIE2_DEV_REVISION_KRK2,
>> +    AIE2_DEV_REVISION_HALO,
>> +    AIE2_DEV_REVISION_GPT1,
>> +    AIE2_DEV_REVISION_GPT2,
>> +    AIE2_DEV_REVISION_GPT3,
>> +    AIE2_DEV_REVISION_UNKN,
>> +};
>> +
>> +struct get_dev_revision_req {
>> +    __u32            place_holder;
>> +} __packed;
>> +
>> +struct get_dev_revision_resp {
>> +    enum aie2_msg_status    status;
>> +    enum aie2_dev_revision    rev;
>> +    __u32            raw_fuse_data;
>> +} __packed;
>> +
>>   #endif /* _AIE2_MSG_PRIV_H_ */
>> diff --git a/drivers/accel/amdxdna/aie2_pci.c 
>> b/drivers/accel/amdxdna/aie2_pci.c
>> index afbe3f8f67ce..1d1fb012294a 100644
>> --- a/drivers/accel/amdxdna/aie2_pci.c
>> +++ b/drivers/accel/amdxdna/aie2_pci.c
>> @@ -608,6 +608,7 @@ static int aie2_init(struct amdxdna_dev *xdna)
>>         release_firmware(fw);
>>       aie2_msg_init(ndev);
>> +    amdxdna_vbnv_init(xdna);
>>       amdxdna_pm_init(xdna);
>>       return 0;
>>   @@ -1255,6 +1256,21 @@ static int aie2_set_state(struct 
>> amdxdna_client *client,
>>       return ret;
>>   }
>>   +static int aie2_get_dev_rev(struct amdxdna_dev *xdna, u32 *rev)
>> +{
>> +    struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
>> +    enum aie2_dev_revision aie2_rev;
>> +    int ret;
>> +
>> +    drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
>> +    ret = aie2_get_dev_revision(ndev, &aie2_rev);
>> +
>> +    if (!ret)
>> +        *rev = (u32)aie2_rev;
>> +
>> +    return ret;
>> +}
>> +
>>   const struct amdxdna_dev_ops aie2_ops = {
>>       .init = aie2_init,
>>       .fini = aie2_fini,
>> @@ -1269,4 +1285,5 @@ const struct amdxdna_dev_ops aie2_ops = {
>>       .cmd_submit = aie2_cmd_submit,
>>       .hmm_invalidate = aie2_hmm_invalidate,
>>       .get_array = aie2_get_array,
>> +    .get_dev_revision = aie2_get_dev_rev,
>>   };
>> diff --git a/drivers/accel/amdxdna/aie2_pci.h 
>> b/drivers/accel/amdxdna/aie2_pci.h
>> index 69b53c7bcb86..c44616065058 100644
>> --- a/drivers/accel/amdxdna/aie2_pci.h
>> +++ b/drivers/accel/amdxdna/aie2_pci.h
>> @@ -223,6 +223,7 @@ enum aie2_fw_feature {
>>       AIE2_TEMPORAL_ONLY,
>>       AIE2_APP_HEALTH,
>>       AIE2_UPDATE_PROPERTY,
>> +    AIE2_GET_DEV_REVISION,
>>       AIE2_FEATURE_MAX
>>   };
>>   @@ -258,6 +259,7 @@ extern const struct dpm_clk_freq 
>> npu4_dpm_clk_table[];
>>   extern const struct rt_config npu1_default_rt_cfg[];
>>   extern const struct rt_config npu4_default_rt_cfg[];
>>   extern const struct amdxdna_fw_feature_tbl npu4_fw_feature_table[];
>> +extern const struct amdxdna_rev_vbnv npu4_rev_vbnv_tbl[];
>>   extern const struct aie2_hw_ops npu4_hw_ops;
>>     /* aie2_pm.c */
>> @@ -286,6 +288,7 @@ int aie2_query_firmware_version(struct 
>> amdxdna_dev_hdl *ndev,
>>                   struct amdxdna_fw_ver *fw_ver);
>>   int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 
>> context_id,
>>                 struct app_health_report *report);
>> +int aie2_get_dev_revision(struct amdxdna_dev_hdl *ndev, enum 
>> aie2_dev_revision *rev);
>>   int aie2_create_context(struct amdxdna_dev_hdl *ndev, struct 
>> amdxdna_hwctx *hwctx);
>>   int aie2_destroy_context(struct amdxdna_dev_hdl *ndev, struct 
>> amdxdna_hwctx *hwctx);
>>   int aie2_map_host_buf(struct amdxdna_dev_hdl *ndev, u32 context_id, 
>> u64 addr, u64 size);
>> diff --git a/drivers/accel/amdxdna/aie4_pci.c 
>> b/drivers/accel/amdxdna/aie4_pci.c
>> index f50e0bc566e4..87f80f804f91 100644
>> --- a/drivers/accel/amdxdna/aie4_pci.c
>> +++ b/drivers/accel/amdxdna/aie4_pci.c
>> @@ -471,6 +471,7 @@ static int aie4_init(struct amdxdna_dev *xdna)
>>           return ret;
>>       }
>>   +    amdxdna_vbnv_init(xdna);
>>       XDNA_DBG(xdna, "aie4 init finished");
>>       return 0;
>>   }
>> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h 
>> b/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> index eabbf57f2b38..bdd0dc83f92e 100644
>> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> @@ -65,6 +65,7 @@ struct amdxdna_dev_ops {
>>       int (*get_aie_info)(struct amdxdna_client *client, struct 
>> amdxdna_drm_get_info *args);
>>       int (*set_aie_state)(struct amdxdna_client *client, struct 
>> amdxdna_drm_set_state *args);
>>       int (*get_array)(struct amdxdna_client *client, struct 
>> amdxdna_drm_get_array *args);
>> +    int (*get_dev_revision)(struct amdxdna_dev *xdna, u32 *rev);
>>   };
>>     struct amdxdna_fw_feature_tbl {
>> @@ -89,7 +90,8 @@ struct amdxdna_dev_info {
>>       u32                dev_mem_buf_shift;
>>       u64                dev_mem_base;
>>       size_t                dev_mem_size;
>> -    char                *vbnv;
>> +    const char            *default_vbnv;
>> +    const struct amdxdna_rev_vbnv    *rev_vbnv_tbl;
>>       const struct amdxdna_dev_priv    *dev_priv;
>>       const struct amdxdna_fw_feature_tbl *fw_feature_tbl;
>>       const struct amdxdna_dev_ops    *ops;
>> @@ -117,6 +119,8 @@ struct amdxdna_dev {
>>       struct iommu_group        *group;
>>       struct iommu_domain        *domain;
>>       struct iova_domain        iovad;
>> +    /* Accurate board name queried from firmware, or default_vbnv as 
>> fallback */
>> +    const char            *vbnv;
>>   };
>>     /*
>> diff --git a/drivers/accel/amdxdna/amdxdna_sysfs.c 
>> b/drivers/accel/amdxdna/amdxdna_sysfs.c
>> index f27e4ee960a0..d9e359ee8182 100644
>> --- a/drivers/accel/amdxdna/amdxdna_sysfs.c
>> +++ b/drivers/accel/amdxdna/amdxdna_sysfs.c
>> @@ -17,7 +17,10 @@ static ssize_t vbnv_show(struct device *dev, 
>> struct device_attribute *attr, char
>>   {
>>       struct amdxdna_dev *xdna = dev_get_drvdata(dev);
>>   -    return sprintf(buf, "%s\n", xdna->dev_info->vbnv);
>> +    if (!xdna->vbnv)
>> +        return sprintf(buf, "\n");
>> +
>> +    return sprintf(buf, "%s\n", xdna->vbnv);
>>   }
>>   static DEVICE_ATTR_RO(vbnv);
>>   diff --git a/drivers/accel/amdxdna/npu1_regs.c 
>> b/drivers/accel/amdxdna/npu1_regs.c
>> index f1141a65e64d..d7e50c6b06ef 100644
>> --- a/drivers/accel/amdxdna/npu1_regs.c
>> +++ b/drivers/accel/amdxdna/npu1_regs.c
>> @@ -137,7 +137,7 @@ const struct amdxdna_dev_info dev_npu1_info = {
>>       .dev_mem_buf_shift = 15, /* 32 KiB aligned */
>>       .dev_mem_base      = AIE2_DEVM_BASE,
>>       .dev_mem_size      = AIE2_DEVM_SIZE,
>> -    .vbnv              = "RyzenAI-npu1",
>> +    .default_vbnv      = "RyzenAI-npu1",
>>       .device_type       = AMDXDNA_DEV_TYPE_KMQ,
>>       .dev_priv          = &npu1_dev_priv,
>>       .fw_feature_tbl    = npu1_fw_feature_table,
>> diff --git a/drivers/accel/amdxdna/npu3_regs.c 
>> b/drivers/accel/amdxdna/npu3_regs.c
>> index 5a0bbc916094..acece0faddf2 100644
>> --- a/drivers/accel/amdxdna/npu3_regs.c
>> +++ b/drivers/accel/amdxdna/npu3_regs.c
>> @@ -69,7 +69,7 @@ const struct amdxdna_dev_info dev_npu3_pf_info = {
>>       .sram_bar        = NPU3_MBOX_BUFFER_BAR,
>>       .psp_bar                = NPU3_PSP_BAR_INDEX,
>>       .smu_bar        = NPU3_SMU_BAR_INDEX,
>> -    .vbnv            = "RyzenAI-npu3-pf",
>> +    .default_vbnv        = "RyzenAI-npu3-pf",
>>       .device_type        = AMDXDNA_DEV_TYPE_PF,
>>       .dev_priv        = &npu3_dev_priv,
>>       .fw_feature_tbl        = npu3_fw_feature_table,
>> diff --git a/drivers/accel/amdxdna/npu4_regs.c 
>> b/drivers/accel/amdxdna/npu4_regs.c
>> index 6ebf75ad5fb4..935999ced70f 100644
>> --- a/drivers/accel/amdxdna/npu4_regs.c
>> +++ b/drivers/accel/amdxdna/npu4_regs.c
>> @@ -98,6 +98,7 @@ const struct amdxdna_fw_feature_tbl 
>> npu4_fw_feature_table[] = {
>>       { .features = BIT_U64(AIE2_NPU_COMMAND), .major = 6, .min_minor 
>> = 15 },
>>       { .features = BIT_U64(AIE2_UPDATE_PROPERTY), .major = 6, 
>> .min_minor = 15 },
>>       { .features = BIT_U64(AIE2_APP_HEALTH), .major = 6, .min_minor 
>> = 18 },
>> +    { .features = BIT_U64(AIE2_GET_DEV_REVISION), .major = 6, 
>> .min_minor = 24 },
>>       { .features = AIE2_ALL_FEATURES, .major = 7 },
>>       { 0 }
>>   };
>> @@ -142,6 +143,18 @@ const struct aie2_hw_ops npu4_hw_ops = {
>>       .update_counters = npu4_update_counters,
>>   };
>>   +const struct amdxdna_rev_vbnv npu4_rev_vbnv_tbl[] = {
>> +    { AIE2_DEV_REVISION_STXA, "NPU Strix" },
>> +    { AIE2_DEV_REVISION_STXB, "NPU Strix" },
>> +    { AIE2_DEV_REVISION_KRK1, "NPU Krackan 1" },
>> +    { AIE2_DEV_REVISION_KRK2, "NPU Krackan 2" },
>> +    { AIE2_DEV_REVISION_HALO, "NPU Strix Halo" },
>> +    { AIE2_DEV_REVISION_GPT1, "NPU Gorgon Point 1" },
>> +    { AIE2_DEV_REVISION_GPT2, "NPU Gorgon Point 2" },
>> +    { AIE2_DEV_REVISION_GPT3, "NPU Gorgon Point 3" },
>> +    { 0 }
>> +};
>> +
>>   static const struct amdxdna_dev_priv npu4_dev_priv = {
>>       .fw_path        = "amdnpu/17f0_10/",
>>       .rt_config    = npu4_default_rt_cfg,
>> @@ -185,8 +198,9 @@ const struct amdxdna_dev_info dev_npu4_info = {
>>       .dev_mem_buf_shift = 15, /* 32 KiB aligned */
>>       .dev_mem_base      = AIE2_DEVM_BASE,
>>       .dev_mem_size      = AIE2_DEVM_SIZE,
>> -    .vbnv              = "RyzenAI-npu4",
>> +    .default_vbnv      = "RyzenAI-npu4",
>>       .device_type       = AMDXDNA_DEV_TYPE_KMQ,
>> +    .rev_vbnv_tbl      = npu4_rev_vbnv_tbl,
>>       .dev_priv          = &npu4_dev_priv,
>>       .fw_feature_tbl    = npu4_fw_feature_table,
>>       .ops               = &aie2_ops, /* NPU4 can share NPU1's 
>> callback */
>> diff --git a/drivers/accel/amdxdna/npu5_regs.c 
>> b/drivers/accel/amdxdna/npu5_regs.c
>> index 6d4596b9e61e..795bd1996845 100644
>> --- a/drivers/accel/amdxdna/npu5_regs.c
>> +++ b/drivers/accel/amdxdna/npu5_regs.c
>> @@ -105,8 +105,9 @@ const struct amdxdna_dev_info dev_npu5_info = {
>>       .dev_mem_buf_shift = 15, /* 32 KiB aligned */
>>       .dev_mem_base      = AIE2_DEVM_BASE,
>>       .dev_mem_size      = AIE2_DEVM_SIZE,
>> -    .vbnv              = "RyzenAI-npu5",
>> +    .default_vbnv      = "RyzenAI-npu5",
>>       .device_type       = AMDXDNA_DEV_TYPE_KMQ,
>> +    .rev_vbnv_tbl      = npu4_rev_vbnv_tbl,
>>       .dev_priv          = &npu5_dev_priv,
>>       .fw_feature_tbl    = npu4_fw_feature_table,
>>       .ops               = &aie2_ops,
>> diff --git a/drivers/accel/amdxdna/npu6_regs.c 
>> b/drivers/accel/amdxdna/npu6_regs.c
>> index 76181345b6d1..3125d1ce45ab 100644
>> --- a/drivers/accel/amdxdna/npu6_regs.c
>> +++ b/drivers/accel/amdxdna/npu6_regs.c
>> @@ -106,8 +106,9 @@ const struct amdxdna_dev_info dev_npu6_info = {
>>       .dev_mem_buf_shift = 15, /* 32 KiB aligned */
>>       .dev_mem_base      = AIE2_DEVM_BASE,
>>       .dev_mem_size      = AIE2_DEVM_SIZE,
>> -    .vbnv              = "RyzenAI-npu6",
>> +    .default_vbnv      = "RyzenAI-npu6",
>>       .device_type       = AMDXDNA_DEV_TYPE_KMQ,
>> +    .rev_vbnv_tbl      = npu4_rev_vbnv_tbl,
>>       .dev_priv          = &npu6_dev_priv,
>>       .fw_feature_tbl    = npu4_fw_feature_table,
>>       .ops               = &aie2_ops,
>
