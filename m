Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95575606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KXNykCJ6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04AA810F95D;
	Thu,  5 Nov 2026 17:56:28 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9683B10E95C
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 17:56:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqSpuUjtXc+2Jz5/wBRSZT6edLYi7i8/5EykKN/+tkUEX+CcSiSG1wiUPVevsBwdVcfXPeMW4kH9K6nUDMZe2J9ZZwXpTHlyDWAj8pCtoC3qF3Fhfs6HXSsJa8mhEvup6Rr34+8bw5o2/fhR4wdV5LRb+s0dsmr9A2o0XqrPQaZAP85ESyeJbXoOgprCf3i8zkxIycHrsZcX+z1+iukeiX/C2hki3c8KyMmcz9Q7qCOXl7gTR49oKKl1cFfUEyWUsd8K7x1cQylsx21E9XiwA0yJUGcKYEfL9YADS5nHg00UrSZ87UTtTsV3rms8zs87ojgBjXndIuvsmewDWPU0Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zthkif0s4mysXWOr6BcAsFXmvDfMlzCes4sBa8zmLkA=;
 b=d2OG5QTJ7xDLiR3FhOZz5iUMJ+vcMjp9Fj8r0+Edn612XmHe+AWIV40ubC5+Cc5h1QCPoRdVfd27VVfjd4cMy9ckTZBvgD4QdsJi0yVoRfcoU+ma4XQhiBAabGJ0fA16ND9ZpRqNySkejSeGCBGhmjs7PcTl8OVuGWkadfttTCHEz1RwcHS75hql2IXalRLRHiIntD0IeRR1vhyGvnMRbSZFrUO5jM8kiABGGBlb9KZiXPOq2FExjxzTUSDPLeYYhuGBeP0KspBI3yJU7WriU6+QP6beE+kYzeYye4vUOIBJq8diIioHc9ebvBs+KJU8LZ19mwMl4BynYL20ej6rSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zthkif0s4mysXWOr6BcAsFXmvDfMlzCes4sBa8zmLkA=;
 b=KXNykCJ6NN5vNnp9rUhrodpsGq1d8V4LDZiTAR0iURlJI+TVhrqsWSAPT40+b42lClVMrKDNzFD7k4Mwntj8RTmVBwiuDJdvqG1T3lZVeqIH45tbaKEB76NBDyACaB4SzqaypknZHoH0VA0LRGLx7hUTpqTzr8WTKNsrIRie0CA=
Received: from CH5PR03CA0017.namprd03.prod.outlook.com (2603:10b6:610:1f1::12)
 by CH3PR12MB570539.namprd12.prod.outlook.com (2603:10b6:610:346::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 17:56:16 +0000
Received: from BN7PEPF000000A4.namprd05.prod.outlook.com
 (2603:10b6:610:1f1:cafe::7b) by CH5PR03CA0017.outlook.office365.com
 (2603:10b6:610:1f1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 17:56:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A4.mail.protection.outlook.com (10.167.245.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 17:56:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 11:56:13 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 11:56:13 -0600
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 5 Nov 2026 11:56:12 -0600
Message-ID: <7c56b697-c69c-8200-aeb3-ed38ea63a704@amd.com>
Date: Thu, 5 Nov 2026 09:56:12 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] accel/amdxdna: Load the aie4 firmware variant the PSP
 reports
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20261105-superm1-lms-npu-v2-1-ad6704226d47@amd.com>
 <18efa128-ffd5-793c-fe4e-6538d6eacd24@amd.com>
 <d8287036-7b05-41b3-bc99-3d351a3bce90@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <d8287036-7b05-41b3-bc99-3d351a3bce90@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A4:EE_|CH3PR12MB570539:EE_
X-MS-Office365-Filtering-Correlation-Id: f6001bf5-b5ee-498b-e3bc-08df3b66165f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|260925021911599003|260925022911599003|260925021311599003|11063799006|261026121527099003|261102123227099003|261026140227099003|261022075727099003|4143699003|56012099006|261021121427099003|261021123027099003|261022115727099003|261028144727099003|261009223027099003|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZoPfysw0Tv7fFlgxg7ayLLhiCiXzWHSmnTHwz5ifMncZANekyYav9WU8Gq0Z617/QtD//41XfxVpNBJr7k7Q3xQK3Pfp6Hkw7RvQgsQYOYaA5mpZ9FPtCjTPlSd/PzN2Bm25dHIfw9hYI0z0VcIqWUw7YjfJENbmJrSCuw1HYlSCoeFg85185koa9yrC9gRlcmxfTiS/TrEqvUyBRB9gAHIv+ecCuq4R0PROGGT43iQf3NWUBLqQHrXt78fdY89vOyXEG1sTibRsrtxzy3y4iwbVRVUko5EmdgXuT5lxycfrAtkq9EBkwNt9u6ideg5HYsDNkqA/2+r/RuAaHIkZj5VGdo1vOQTAJ2+jjVFldFSuRJO3i+8BANsE4GvyNJJFBUhqy4WnZhWKxEtyASoWEFnpV47/pBfjFwwhdC9PbekseEgO4fpyPtTPRGXFd1Izn+w0tWPRkL/oERBf58x7P6mhp5c2wqOU5ql+LBoo2C3b2lTevv8BaI3O7FUcGW0OV5xJoLdeHgYVXLklOV8Ci7PtaUkl1iOuWprf34q5ggc+2JmaRU6oM/tIVqS3riPJGkVOMpep5dK3jE3BkowKc4RcRQhU/7jlECybVD62tRMz+xHamSceXea0BLU3uS8MbQFyCPh1F/+kU//0qWiJNa2J66RH8WyqkcZ2dp2TsKA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(260925021911599003)(260925022911599003)(260925021311599003)(11063799006)(261026121527099003)(261102123227099003)(261026140227099003)(261022075727099003)(4143699003)(56012099006)(261021121427099003)(261021123027099003)(261022115727099003)(261028144727099003)(261009223027099003)(261022105027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AjOHHlCZxdLe9w/U4NNLgGxCowvmjXnH+YRy8m1a7x3jycR3deUh181pvLmPcZldVh05ODtFEO4ZSCeRq6te2Mn+i2egK/8l24C/Kc9ojClJ+D8dAAUMkDsKVwVNS2JzGicoI+LtlCjrq3zRWx+0E0tgG91l0veXl5X5eL8mudXTmCi59asZj4EzD/vujv8yhw9ErFlQxVtZJY9K8yJcVhudPgdw26LD/k3lBwAsKmFmJc93Wdb9c9OAPqxvZ3NHu4S8l5WLFdyMDezI/OL2pESMyZsRd5OLRwDhDYcWyK4sV0xSFUPXlHymSSNOqiB7bWP6OGjPspEBJ2qkT9tc1EYToT/ZFoh05ekngMtiYKRTa4qib31D9gRhW3PUxoiz9VZS4BM8mYPYUoHODh3DzK950kfVWbyiodJ4sxdmrWpCG8sInRsKqOWPz71ciaQl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 17:56:15.7552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6001bf5-b5ee-498b-e3bc-08df3b66165f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB570539
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/5/26 09:52, Mario Limonciello wrote:
>
>
> On 11/5/26 11:47, Lizhi Hou wrote:
>>
>> On 11/5/26 07:51, Mario Limonciello wrote:
>>> Some Platforms ship BIOS with either a default or an alternative trust
>>> authority. The PSP validates the NPU firmware, so it must be signed 
>>> with
>>> the matching scheme. Firmware for the alternative scheme is named with
>>> an "_l" suffix before the extension. A preproduction part needs 
>>> firmware
>>> of its own, named with a "_p" suffix.
>>>
>>> The PSP reports the signing type in bit 6 of C2PMSG_63, and in bit 28
>>> whether this is a preproduction part. A preproduction part that also
>>> reports the alternative scheme is not expected, so warn about it and
>>> use the default firmware.
>>>
>>> Add MODULE_FIRMWARE() entries for the "_l" variants of the npu and cert
>>> images of the aie4 devices so that initramfs generators include them.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> Changes in v2:
>>> - Initialize val in aie4_psp_fw_variant() so a failed SMN read can't 
>>> leave
>>>    it uninitialized
>>> - Only read the PSP firmware variant after the npufw/certfw path 
>>> check, so
>>>    VFs (which have no firmware paths) skip the SMN access
>>> - Drop the redundant all-ones check, amd_smn_read() already returns 
>>> - ENODEV
>>> - Link to v1: 
>>> https://patch.msgid.link/20261104-superm1-lms-npu-v1-1- 
>>> dbffcc5abc23@amd.com
>>> ---
>>>   drivers/accel/amdxdna/Kconfig           |   1 +
>>>   drivers/accel/amdxdna/aie4_pci.c        | 162 
>>> ++++++++++++++++++++++ ++++------
>>>   drivers/accel/amdxdna/amdxdna_pci_drv.c |   8 ++
>>>   3 files changed, 141 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/drivers/accel/amdxdna/Kconfig b/drivers/accel/amdxdna/ 
>>> Kconfig
>>> index eddff490b4f75..cd17a89cf4146 100644
>>> --- a/drivers/accel/amdxdna/Kconfig
>>> +++ b/drivers/accel/amdxdna/Kconfig
>>> @@ -6,6 +6,7 @@ config DRM_ACCEL_AMDXDNA
>>>       depends on DRM_ACCEL
>>>       depends on PCI && HAS_IOMEM
>>>       depends on X86_64
>>> +    depends on AMD_NODE
>>>       depends on AMD_PMF || !AMD_PMF
>>>       select DRM_SCHED
>>>       select DRM_GEM_SHMEM_HELPER
>>> diff --git a/drivers/accel/amdxdna/aie4_pci.c 
>>> b/drivers/accel/amdxdna/ aie4_pci.c
>>> index 02dcb2f813d45..26c6162893760 100644
>>> --- a/drivers/accel/amdxdna/aie4_pci.c
>>> +++ b/drivers/accel/amdxdna/aie4_pci.c
>>> @@ -11,6 +11,8 @@
>>>   #include <linux/debugfs.h>
>>>   #include <linux/firmware.h>
>>>   #include <linux/sizes.h>
>>> +#include <linux/string.h>
>>> +#include <asm/amd/node.h>
>>>   #include "aie.h"
>>>   #include "aie4_msg_priv.h"
>>> @@ -558,46 +560,124 @@ static void aie4_classic_hw_stop(struct 
>>> amdxdna_dev_hdl *ndev)
>>>       aie4_fw_stop(ndev);
>>>   }
>>> -static int aie4_request_firmware(struct amdxdna_dev_hdl *ndev,
>>> -                 const struct firmware **npufw,
>>> -                 const struct firmware **certfw)
>>> +/*
>>> + * PSP C2PMSG_63 (SMN) bit 6: 0 = default firmware signing, 1 = 
>>> alternative
>>> + * PSP C2PMSG_63 (SMN) bit 28: 0 = production part, 1 = 
>>> preproduction part
>>> + */
>>> +#define AIE4_PSP_C2PMSG_63_SMN_ADDR    0x38109fc
>>> +#define AIE4_PSP_FW_SIGN_ALT        BIT(6)
>>> +#define AIE4_PSP_FW_PREPROD        BIT(28)
>>> +
>>> +enum aie4_fw_variant {
>>> +    AIE4_FW_DEFAULT,
>>> +    AIE4_FW_ALT,        /* "_l" images */
>>> +    AIE4_FW_PREPROD,    /* "_p" images */
>>> +};
>>> +
>>> +/*
>>> + * The PSP only trusts firmware signed with the scheme the platform 
>>> firmware
>>> + * uses and a preproduction part needs firmware of its own. Reading 
>>> which one is
>>> + * in use is optional and only used as a hint for which images to 
>>> try first:
>>> + * anything but a clear answer is treated as default.
>>> + */
>>> +static enum aie4_fw_variant aie4_psp_fw_variant(struct amdxdna_dev 
>>> *xdna)
>>>   {
>>> -    struct amdxdna_dev *xdna = ndev->aie.xdna;
>>> -    struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
>>> -    char fw_name[128];
>>> +    u32 val = 0;
>>>       int ret;
>>> -    ret = snprintf(fw_name, sizeof(fw_name), "amdnpu/%04x_%02x/%s",
>>> -               pdev->device, pdev->revision, ndev->priv->npufw_path);
>>> -    if (ret >= sizeof(fw_name)) {
>>> -        XDNA_ERR(xdna, "npu firmware path is truncated");
>>> -        return -EINVAL;
>>> +    ret = amd_smn_read(0, AIE4_PSP_C2PMSG_63_SMN_ADDR, &val);
>>> +    if (ret) {
>>> +        XDNA_DBG(xdna, "PSP firmware variant not available, ret 
>>> %d", ret);
>>> +        return AIE4_FW_DEFAULT;
>>>       }
>>> -    ret = request_firmware(npufw, fw_name, &pdev->dev);
>>> -    if (ret) {
>>> -        XDNA_ERR(xdna, "failed to request_firmware %s, ret %d", 
>>> fw_name, ret);
>>> -        return ret;
>>> +    if ((val & AIE4_PSP_FW_SIGN_ALT) && (val & AIE4_PSP_FW_PREPROD)) {
>>> +        XDNA_WARN(xdna,
>>> +              "Preproduction part with alternative signing, using 
>>> default firmware");
>>> +        return AIE4_FW_DEFAULT;
>>>       }
>>> -    ret = snprintf(fw_name, sizeof(fw_name), "amdnpu/%04x_%02x/%s",
>>> -               pdev->device, pdev->revision, ndev->priv->certfw_path);
>>> -    if (ret >= sizeof(fw_name)) {
>>> -        XDNA_ERR(xdna, "cert firmware path is truncated");
>>> -        ret = -EINVAL;
>>> -        goto release_npufw;
>>> +    if (val & AIE4_PSP_FW_PREPROD)
>>> +        return AIE4_FW_PREPROD;
>>> +
>>> +    return (val & AIE4_PSP_FW_SIGN_ALT) ? AIE4_FW_ALT : 
>>> AIE4_FW_DEFAULT;
>>> +}
>>> +
>>> +/*
>>> + * Images for the other variants have a suffix before the ".sbin" 
>>> extension.
>>> + * Returns -ENOENT if @path has no such variant.
>>> + */
>>> +static int aie4_fw_name(struct amdxdna_dev *xdna, char *name, 
>>> size_t size,
>>> +            const char *path, enum aie4_fw_variant variant)
>>> +{
>>> +    struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
>>> +    const char *suffix;
>>> +    size_t len, base;
>>> +    int ret;
>>> +
>>> +    ret = snprintf(name, size, "amdnpu/%04x_%02x/%s",
>>> +               pdev->device, pdev->revision, path);
>>> +    if (ret >= size) {
>>> +        XDNA_ERR(xdna, "firmware path %s is truncated", path);
>>> +        return -EINVAL;
>>>       }
>>> -    ret = request_firmware(certfw, fw_name, &pdev->dev);
>>> -    if (ret) {
>>> -        XDNA_ERR(xdna, "failed to request_firmware %s, ret %d", 
>>> fw_name, ret);
>>> -        goto release_npufw;
>>> +    switch (variant) {
>>> +    case AIE4_FW_ALT:
>>> +        suffix = "_l.sbin";
>>> +        break;
>>> +    case AIE4_FW_PREPROD:
>>> +        suffix = "_p.sbin";
>>> +        break;
>>> +    default:
>>> +        return 0;
>>>       }
>>> +    len = ret;
>>> +    if (len < strlen(".sbin") || strcmp(name + len - 
>>> strlen(".sbin"), ".sbin"))
>>> +        return -ENOENT;
>>> +
>>> +    base = len - strlen(".sbin");
>>> +    if (strscpy(name + base, suffix, size - base) < 0)
>>> +        return -EOVERFLOW;
>>> +
>>>       return 0;
>>> +}
>>> +
>>> +static int aie4_request_one(struct amdxdna_dev_hdl *ndev, const 
>>> struct firmware **fw,
>>> +                const char *path, enum aie4_fw_variant variant)
>>> +{
>>> +    struct amdxdna_dev *xdna = ndev->aie.xdna;
>>> +    struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
>>> +    char name[128];
>>> +    int ret;
>>> +
>>> +    ret = aie4_fw_name(xdna, name, sizeof(name), path, variant);
>>> +    if (ret)
>>> +        return ret;
>>> -release_npufw:
>>> -    release_firmware(*npufw);
>>> +    ret = firmware_request_nowarn(fw, name, &pdev->dev);
>>> +    if (ret)
>>> +        XDNA_DBG(xdna, "firmware %s not loaded, ret %d", name, ret);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +/* The NPU and cert images are validated together, so both use the 
>>> same variant */
>>> +static int aie4_request_firmware(struct amdxdna_dev_hdl *ndev,
>>> +                 const struct firmware **npufw,
>>> +                 const struct firmware **certfw,
>>> +                 enum aie4_fw_variant variant)
>>> +{
>>> +    int ret;
>>> +
>>> +    ret = aie4_request_one(ndev, npufw, ndev->priv->npufw_path, 
>>> variant);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = aie4_request_one(ndev, certfw, ndev->priv->certfw_path, 
>>> variant);
>>> +    if (ret)
>>> +        release_firmware(*npufw);
>>>       return ret;
>>>   }
>>> @@ -645,18 +725,40 @@ static int aie4_prepare_firmware(struct 
>>> amdxdna_dev_hdl *ndev,
>>>       return 0;
>>>   }
>>> +/*
>>> + * The firmware can only be started once. It is the PSP that 
>>> decides whether it
>>> + * accepts the images, and it does that when the firmware is 
>>> started, so there
>>> + * is no trying a variant and falling back. Pick the variant that 
>>> the PSP
>>> + * reported (the default one if it can't be read) and use the 
>>> others only if
>>> + * its images are missing.
>>> + */
>>>   static int aie4_load_fw(struct amdxdna_dev_hdl *ndev,
>>>               void __iomem *tbl[PCI_NUM_RESOURCES])
>>>   {
>>> +    struct amdxdna_dev *xdna = ndev->aie.xdna;
>>>       const struct firmware *npufw, *certfw;
>>> -    int ret;
>>> +    enum aie4_fw_variant order[3], hint;
>>> +    int i, n = 0, ret = -ENOENT;
>>>       if (!ndev->priv->npufw_path && !ndev->priv->certfw_path)
>>>           return 0;
>>> -    ret = aie4_request_firmware(ndev, &npufw, &certfw);
>>> -    if (ret)
>>> +    hint = aie4_psp_fw_variant(xdna);
>>> +    order[n++] = hint;
>>> +    if (hint != AIE4_FW_DEFAULT)
>>> +        order[n++] = AIE4_FW_DEFAULT;
>>> +    if (hint != AIE4_FW_ALT)
>>> +        order[n++] = AIE4_FW_ALT;
>>> +
>>> +    for (i = 0; i < n; i++) {
>>> +        ret = aie4_request_firmware(ndev, &npufw, &certfw, order[i]);
>>> +        if (!ret)
>>> +            break;
>>> +    }
>>> +    if (ret) {
>>> +        XDNA_ERR(xdna, "failed to load firmware, ret %d", ret);
>>>           return ret;
>>> +    }
>>>       ret = aie4_prepare_firmware(ndev, npufw, certfw, tbl);
>>>       aie4_release_firmware(ndev, npufw, certfw);
>>> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c 
>>> b/drivers/accel/ amdxdna/amdxdna_pci_drv.c
>>> index f233eb70a2957..dab8603e2381f 100644
>>> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
>>> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
>>> @@ -37,6 +37,14 @@ MODULE_FIRMWARE("amdnpu/17f1_13/npu.sbin");
>>>   MODULE_FIRMWARE("amdnpu/17f1_13/cert.sbin");
>>>   MODULE_FIRMWARE("amdnpu/17f2_13/npu.sbin");
>>>   MODULE_FIRMWARE("amdnpu/17f2_13/cert.sbin");
>>> +MODULE_FIRMWARE("amdnpu/17f1_10/npu_l.sbin");
>>> +MODULE_FIRMWARE("amdnpu/17f1_10/cert_l.sbin");
>>> +MODULE_FIRMWARE("amdnpu/17f2_10/npu_l.sbin");
>>> +MODULE_FIRMWARE("amdnpu/17f2_10/cert_l.sbin");
>>> +MODULE_FIRMWARE("amdnpu/17f1_13/npu_l.sbin");
>>> +MODULE_FIRMWARE("amdnpu/17f1_13/cert_l.sbin");
>>> +MODULE_FIRMWARE("amdnpu/17f2_13/npu_l.sbin");
>>> +MODULE_FIRMWARE("amdnpu/17f2_13/cert_l.sbin");
>> need to add entries for "_p" images.
>
> Let me tell you my thought process in excluding them.
>
> They are only for pre-prod hardware, and so *most people* who use this 
> driver after the product launches shouldn't need them in their 
> initramfs; they'll just bloat the initramfs.
>
> If you think they should still be there; I'll spin a v3 an add them.

Ok, sounds good to me.

Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>

Lizhi

>
>>>   /*
>>>    * 0.0: Initial version
>>>
>>> ---
>>> base-commit: e32e83a6c5ec031a7f59d4794113d8484b220254
>>> change-id: 20261104-superm1-lms-npu-6bc3bbe38c29
>>>
>>> Best regards,
>>> -- 
>>> Mario Limonciello <mario.limonciello@amd.com>
>>>
>
