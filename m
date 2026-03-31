Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8E410F92FC
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 20:30:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E036410E0E0;
	Tue, 31 Mar 2026 20:30:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1dpig1ne";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010069.outbound.protection.outlook.com
 [40.93.198.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 016CA10E0E0
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 20:30:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3lsusc/f6sx2uno4WnIYZiYIHZBkz4isrbkas+HEFp0f7B5zOWlz43PTXvI8refrZ1f8tz1gNhph3F0fFUPmlaKpgRj66vBOoNI16hrZ9/CTF0RPgfTjLHuZoeTliU/N9UX3VCo0YGTxdcgRvZQhSwsLXluJS/mfZg3YtALiGPo71aqMs8/nkvtTyCQn3hiR1emHcU7ce6zS4bukReDxCcd7cKs4udPjbp9w3uRDygetgKhSS0Ip/nlzPhGfWmtgtoxEO/cLw73FTKazLSEM3l3IRFW9/9u4Sl1KfPHVPogVj4F5tIhuPKgosFxNRYT4fAY/rY5vGDEtCXo+WCY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lqt/USnOI7IjtFJjMeqj3M3nj6IxiKfgwkOAuAaa+ew=;
 b=K9kfhkr31FGiTRZNbET8sVwtfH+W5VZ5BUdeOs7+QclTstgrx+Cf40H4xWXJ/ciAp8Gi1k0uSHq3yyLn8AwHxmy1lU7U+grSsypdSV23x/5BLqwavcvXKyvcFmJVXALkT4Cj9qx2HUQUYFyHnu0/l29r+UVnHXxuSocWe8BITTn59+IP4SoQ1NEuU9DTsRk7BIegBxiiu9P58OtZkr6pNcYLx+fbUfZvPk6tJQ0JI5H0FWe8nrqZYQCYnA8BpYiLA7yd74D3uBTjdC3roiElzAt9Y0FX/mBSQI+l7fR/vIuLr/L4RlSeTUEbKUkZLpy5gqJqzoUTQq1BT2gLrq+d1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lqt/USnOI7IjtFJjMeqj3M3nj6IxiKfgwkOAuAaa+ew=;
 b=1dpig1neq3lSyDaIoyvDX3uh+hbktV7bvuXgfoHT8mzOvop/pI7bEnnbbQxV8LWZdtTd0+vPiyoa3Qfb9VbNctzVrjLUYhzvrMk2Xe1nV/P6vSGl5ZAHaO7RRPsJgiLlYEMPuSfg98Ex7s4Q7+w8nq/+5gjgjXMBigJkrXWre4I=
Received: from BL1P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::34)
 by SA3PR12MB7902.namprd12.prod.outlook.com (2603:10b6:806:305::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 20:30:07 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::a2) by BL1P222CA0029.outlook.office365.com
 (2603:10b6:208:2c7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Tue,
 31 Mar 2026 20:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 31 Mar 2026 20:30:06 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 31 Mar
 2026 15:30:03 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 31 Mar 2026 15:30:01 -0500
Message-ID: <12198193-b4ce-2e74-a82e-f583e79bf223@amd.com>
Date: Tue, 31 Mar 2026 13:29:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1 4/6] accel/amdxdna: Add AIE4 firmware loading
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <maciej.falkowski@linux.intel.com>
CC: David Zhang <yidong.zhang@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>, Hayden Laccabue
 <Hayden.Laccabue@amd.com>
References: <20260330163705.3153647-1-lizhi.hou@amd.com>
 <20260330163705.3153647-5-lizhi.hou@amd.com>
 <0d5d0bdf-3a2a-4217-9552-1cd56210cbb2@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <0d5d0bdf-3a2a-4217-9552-1cd56210cbb2@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|SA3PR12MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: df2d1cb0-51ca-443a-601e-08de8f644c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: FR0bbDqRBw7wpvNFPb2uy8mNPa4ZVb3yf9LxxPY8Yyw17/DZTBOXXIOM0kSId1ER/OtyCL/npTv8vVQn/VzkrdrKLMFF3SreHw0Gxg5D/lS1mLlQWHLdqhMSfSntToHexedukvQ3zfmgl6rGnZnjithNv2PmgQzxTU90bDJVO+ovRoLsU2cJ3d3afIkyV1quguQWJPf0pG3XtbuTlo02Tg+TlQDEx6QuX23Jp01T/FU8ehkXZOXqJEVh7u51OaqhYjfceYYw7YCbKhqh50gpCy+Vom0tWiGNVW6vb7GBtXr7ym8xEi7G88v/OEfZ0IM7tJE3WwuqrPL2EDxCh4HVAt34/1VVsazIhE9em1RC6zivQRoHpwFLAqTsmbg/MUm/FMZikYOkIm2IfFRDcaI1dY0w0+JFmjGTCT4RohRuIcOwNBrxN+ryK5L9IMvFxJYhrj0YDZR2W6wKOETtyUSf3Gf4Uw7GaIhTH0eWvsgg2cupOX0uJvFm3T8D3PY8FKGtYF7QzOIkwcqxG6KjKpmlTmnnEUfjDYbE5CtL8KpwIBDmVyxvoZvUzONDvWFqZK3dTT6TMxOz3Ng1KRCYDXtXqM+AhAEv0b6VpyWbVyD/O5BOukFEHXz8TZ4NtG0YrveYSw5qeo0OUP8kqrYBUt2wKBpiJehHBdsamPUPsFajUbugooUMhw/921bMtVopV5yC37I8xK3X2KaBqKG++M1H477aI+5xPsdO47QPUDX4zSg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u+5S5OQ50tBY8NaTPfiTpXEP9y64lmwgad8dSNxCaj1hkbk9leZskMhX5FdqsxwPD+sfBN4u4csHoeugXg20WNKC6MC6+yfJdP8QA8fUrLBUS1shBzt3/99rnp/9dN/LUshuvMkKKNR/09zDVHZmerEiP7mpa4k94132uTVrmLOxo7czbQGRiAXpGuJvJUEIX182hy+jynJSBkecsiumvqR3FDziFU7naS6siNx4v09cVpYQB4vedL6kfLTuojEnU2M6kj1SKU54ZMS5RafqD739syVK646svFZvAXxdSuwNKZ3oBtI8VzPplu/wCjHFMqYYtuVqQdDXzftVy3NJsQeSn/zeaViMUZtVQxb1ySNt6OVBzt38lz6r4oSWzcZvin4Oie/kpuULaFQ4uLJr+1K/ORByaOanSKrdFMy6PbMS8YQJNGPV/y/LKyHtLyoJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 20:30:06.8199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df2d1cb0-51ca-443a-601e-08de8f644c0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7902
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


On 3/30/26 19:45, Mario Limonciello wrote:
>
>
> On 3/30/26 11:37, Lizhi Hou wrote:
>> From: David Zhang <yidong.zhang@amd.com>
>>
>> Add support for loading AIE4 firmware through the common PSP
>> interfaces.
>>
>> Compared to AIE2, AIE4 introduces an additional CERT firmware image.
>> aiem_psp_create() performs CERT setup when the CERT image size is
>> non-zero.
>>
>> Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
>> Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
>> Signed-off-by: David Zhang <yidong.zhang@amd.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>>   drivers/accel/amdxdna/aie.h       |   4 +
>>   drivers/accel/amdxdna/aie2_pci.c  |   2 +
>>   drivers/accel/amdxdna/aie4_pci.c  | 109 ++++++++++++++++++++++-
>>   drivers/accel/amdxdna/aie4_pci.h  |   4 +
>>   drivers/accel/amdxdna/aie_psp.c   | 141 +++++++++++++++++++++++-------
>>   drivers/accel/amdxdna/npu3_regs.c |  23 +++++
>>   6 files changed, 247 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
>> index 124c0f7e9ca0..423ed34af9ee 100644
>> --- a/drivers/accel/amdxdna/aie.h
>> +++ b/drivers/accel/amdxdna/aie.h
>> @@ -57,7 +57,11 @@ struct aie_bar_off_pair {
>>   struct psp_config {
>>       const void        *fw_buf;
>>       u32            fw_size;
>> +    const void              *certfw_buf;
>> +    u32                     certfw_size;
>>       void __iomem        *psp_regs[PSP_MAX_REGS];
>> +    u32            arg2_mask;
>> +    u32            notify_val;
>>   };
>>     /* aie.c */
>> diff --git a/drivers/accel/amdxdna/aie2_pci.c 
>> b/drivers/accel/amdxdna/aie2_pci.c
>> index e4b7893bd429..0489e668cd73 100644
>> --- a/drivers/accel/amdxdna/aie2_pci.c
>> +++ b/drivers/accel/amdxdna/aie2_pci.c
>> @@ -549,6 +549,8 @@ static int aie2_init(struct amdxdna_dev *xdna)
>>         psp_conf.fw_size = fw->size;
>>       psp_conf.fw_buf = fw->data;
>> +    psp_conf.arg2_mask = GENMASK(23, 0);
>> +    psp_conf.notify_val = 1;
>>       for (i = 0; i < PSP_MAX_REGS; i++)
>>           psp_conf.psp_regs[i] = tbl[PSP_REG_BAR(ndev, i)] + 
>> PSP_REG_OFF(ndev, i);
>>       ndev->aie.psp_hdl = aiem_psp_create(&xdna->ddev, &psp_conf);
>> diff --git a/drivers/accel/amdxdna/aie4_pci.c 
>> b/drivers/accel/amdxdna/aie4_pci.c
>> index 0f360c1ccebd..e7993b315996 100644
>> --- a/drivers/accel/amdxdna/aie4_pci.c
>> +++ b/drivers/accel/amdxdna/aie4_pci.c
>> @@ -6,11 +6,15 @@
>>   #include <drm/amdxdna_accel.h>
>>   #include <drm/drm_managed.h>
>>   #include <drm/drm_print.h>
>> +#include <linux/firmware.h>
>> +#include <linux/sizes.h>
>>     #include "aie4_pci.h"
>>   #include "amdxdna_pci_drv.h"
>>   -#define NO_IOHUB    0
>> +#define NO_IOHUB        0
>> +#define CERTFW_MAX_SIZE         (SZ_32K + SZ_256)
>> +#define PSP_NOTIFY_INTR        0xD007BE11
>>     /*
>>    * The management mailbox channel is allocated by firmware.
>> @@ -207,13 +211,12 @@ static int aie4_mailbox_init(struct amdxdna_dev 
>> *xdna)
>>     static void aie4_fw_unload(struct amdxdna_dev_hdl *ndev)
>>   {
>> -    /* TODO */
>> +    aie_psp_stop(ndev->aie.psp_hdl);
>>   }
>>     static int aie4_fw_load(struct amdxdna_dev_hdl *ndev)
>>   {
>> -    /* TODO */
>> -    return 0;
>> +    return aie_psp_start(ndev->aie.psp_hdl);
>>   }
>>     static int aie4_hw_start(struct amdxdna_dev *xdna)
>> @@ -261,11 +264,98 @@ static void aie4_hw_stop(struct amdxdna_dev *xdna)
>>       aie4_fw_unload(ndev);
>>   }
>>   +static int aie4_request_firmware(struct amdxdna_dev_hdl *ndev,
>> +                 const struct firmware **npufw,
>> +                 const struct firmware **certfw)
>> +{
>> +    struct amdxdna_dev *xdna = ndev->aie.xdna;
>> +    struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
>> +    char fw_name[128];
>> +    int ret;
>> +
>> +    ret = snprintf(fw_name, sizeof(fw_name), "amdnpu/%04x_%02x/%s",
>> +               pdev->device, pdev->revision, ndev->priv->npufw_path);
>> +    if (ret >= sizeof(fw_name)) {
>> +        XDNA_ERR(xdna, "npu firmware path is truncated");
>> +        return -EINVAL;
>> +    }
>> +
>> +    ret = request_firmware(npufw, fw_name, &pdev->dev);
>> +    if (ret) {
>> +        XDNA_ERR(xdna, "failed to request_firmware %s, ret %d", 
>> fw_name, ret);
>> +        return ret;
>> +    }
>> +
>> +    ret = snprintf(fw_name, sizeof(fw_name), "amdnpu/%04x_%02x/%s",
>> +               pdev->device, pdev->revision, ndev->priv->certfw_path);
>> +    if (ret >= sizeof(fw_name)) {
>> +        XDNA_ERR(xdna, "cert firmware path is truncated");
>> +        ret = -EINVAL;
>> +        goto release_npufw;
>> +    }
>> +
>> +    ret = request_firmware(certfw, fw_name, &pdev->dev);
>> +    if (ret) {
>> +        XDNA_ERR(xdna, "failed to request_firmware %s, ret %d", 
>> fw_name, ret);
>> +        goto release_npufw;
>> +    }
>> +
>> +    if ((*certfw)->size > CERTFW_MAX_SIZE) {
>> +        XDNA_ERR(xdna, "CERTFW over maximum size of 32 KB + 256 B");
>> +        ret = -EINVAL;
>> +        goto release_certfw;
>> +    }
>
> Should there be a similar size check for NPU FW?  Not sure why it 
> would only be done for Cert FW.
This check is useless. The firmware size will never beyond 32K+256B. I 
will remove it.
>
>> +
>> +    return 0;
>> +
>> +release_certfw:
>> +    release_firmware(*certfw);
>> +release_npufw:
>> +    release_firmware(*npufw);
>> +
>> +    return ret;
>> +}
>> +
>> +static void aie4_release_firmware(struct amdxdna_dev_hdl *ndev,
>> +                  const struct firmware *npufw,
>> +                  const struct firmware *certfw)
>> +{
>> +    release_firmware(certfw);
>> +    release_firmware(npufw);
>> +}
>> +
>> +static int aie4_prepare_firmware(struct amdxdna_dev_hdl *ndev,
>> +                 const struct firmware *npufw,
>> +                 const struct firmware *certfw,
>> +                 void __iomem *tbl[PCI_NUM_RESOURCES])
>> +{
>> +    struct amdxdna_dev *xdna = ndev->aie.xdna;
>> +    struct psp_config psp_conf;
>> +    int i;
>> +
>> +    psp_conf.fw_size = npufw->size;
>> +    psp_conf.fw_buf = npufw->data;
>> +    psp_conf.certfw_size = certfw->size;
>> +    psp_conf.certfw_buf = certfw->data;
>> +    psp_conf.arg2_mask = ~0;
>> +    psp_conf.notify_val = PSP_NOTIFY_INTR;
>> +    for (i = 0; i < PSP_MAX_REGS; i++)
>> +        psp_conf.psp_regs[i] = tbl[PSP_REG_BAR(ndev, i)] + 
>> PSP_REG_OFF(ndev, i);
>> +    ndev->aie.psp_hdl = aiem_psp_create(&xdna->ddev, &psp_conf);
>> +    if (!ndev->aie.psp_hdl) {
>> +        XDNA_ERR(xdna, "failed to create psp");
>> +        return -ENOMEM;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static int aie4_pcidev_init(struct amdxdna_dev_hdl *ndev)
>>   {
>>       struct amdxdna_dev *xdna = ndev->aie.xdna;
>>       struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
>>       void __iomem *tbl[PCI_NUM_RESOURCES] = {0};
>> +    const struct firmware *npufw, *certfw;
>>       unsigned long bars = 0;
>>       int ret, i;
>>   @@ -282,6 +372,8 @@ static int aie4_pcidev_init(struct 
>> amdxdna_dev_hdl *ndev)
>>           return ret;
>>       }
>>   +    for (i = 0; i < PSP_MAX_REGS; i++)
>> +        set_bit(PSP_REG_BAR(ndev, i), &bars);
>>       set_bit(xdna->dev_info->mbox_bar, &bars);
>>       set_bit(xdna->dev_info->sram_bar, &bars);
>>   @@ -300,6 +392,15 @@ static int aie4_pcidev_init(struct 
>> amdxdna_dev_hdl *ndev)
>>         pci_set_master(pdev);
>>   +    ret = aie4_request_firmware(ndev, &npufw, &certfw);
>> +    if (ret)
>> +        goto clear_master;
>> +
>> +    ret = aie4_prepare_firmware(ndev, npufw, certfw, tbl);
>> +    aie4_release_firmware(ndev, npufw, certfw);
>> +    if (ret)
>> +        goto clear_master;
>> +
>>       ret = aie4_irq_init(xdna);
>>       if (ret)
>>           goto clear_master;
>> diff --git a/drivers/accel/amdxdna/aie4_pci.h 
>> b/drivers/accel/amdxdna/aie4_pci.h
>> index f3810a969431..ee388ccf7196 100644
>> --- a/drivers/accel/amdxdna/aie4_pci.h
>> +++ b/drivers/accel/amdxdna/aie4_pci.h
>> @@ -14,9 +14,13 @@
>>   #include "amdxdna_mailbox.h"
>>     struct amdxdna_dev_priv {
>> +    const char              *npufw_path;
>> +    const char              *certfw_path;
>>       u32            mbox_bar;
>>       u32            mbox_rbuf_bar;
>>       u64            mbox_info_off;
>> +
>> +    struct aie_bar_off_pair    psp_regs_off[PSP_MAX_REGS];
>>   };
>>     struct amdxdna_dev_hdl {
>> diff --git a/drivers/accel/amdxdna/aie_psp.c 
>> b/drivers/accel/amdxdna/aie_psp.c
>> index 8743b812a449..458dca7cc5a0 100644
>> --- a/drivers/accel/amdxdna/aie_psp.c
>> +++ b/drivers/accel/amdxdna/aie_psp.c
>> @@ -18,6 +18,7 @@
>>   #define PSP_VALIDATE        1
>>   #define PSP_START        2
>>   #define PSP_RELEASE_TMR        3
>> +#define PSP_VALIDATE_CERT       4
>>     /* PSP special arguments */
>>   #define PSP_START_COPY_FW    1
>> @@ -27,10 +28,20 @@
>>   #define PSP_ERROR_BAD_STATE    0xFFFF0007
>>     #define PSP_FW_ALIGN        0x10000
>> +#define PSP_CFW_ALIGN           0x8000
>>   #define PSP_POLL_INTERVAL    20000    /* us */
>>   #define PSP_POLL_TIMEOUT    1000000    /* us */
>>   -#define PSP_REG(p, reg) ((p)->psp_regs[reg])
>> +#define PSP_REG(p, reg) ((p)->conf.psp_regs[reg])
>> +#define PSP_SET_CMD(psp, reg_vals, cmd, arg0, arg1, arg2)        \
>> +({                                    \
>> +    u32 *_regs = reg_vals;                        \
>> +    u32 _cmd = cmd;                            \
>> +    _regs[0] = _cmd;                        \
>> +    _regs[1] = arg0;                        \
>> +    _regs[2] = arg1;                        \
>> +    _regs[3] = ((arg2) | ((_cmd) << 24)) & (psp)->conf.arg2_mask;    \
>> +})
>
> For AIE4, arg2_mask is set to ~0 (0xFFFFFFFF), which means the full
> 32-bit value including cmd<<24 is preserved.
>
> If arg2 uses bits 24-31, the OR operation could corrupt the cmd field. 
> For example:
>
>   arg2 = 0x02000000 (32MB firmware size, bit 25 set)
>   cmd = 1 (PSP_VALIDATE)
>   _regs[3] = (0x02000000 | 0x01000000) & 0xFFFFFFFF
>            = 0x03000000
>
> This puts cmd=3 instead of cmd=1 in bits 24-31, while the size field
> in bits 0-23 becomes 0 instead of the intended value.
>
> Should arg2 be masked before the OR to ensure it only uses bits 0-23?
It should be ok here because the arg2 does not come from user input and 
will never beyond 0-23bit.
>
>   _regs[3] = ((arg2 & 0x00FFFFFF) | (_cmd << 24)) & 
> (psp)->conf.arg2_mask;
>
> This would prevent arg2 from corrupting the cmd field on AIE4 while
> maintaining backward compatibility with AIE2 (which masks out the cmd
> bits anyway).
>
>
>>   struct psp_device {
>>       struct drm_device    *ddev;
>> @@ -38,7 +49,9 @@ struct psp_device {
>>       u32            fw_buf_sz;
>>       u64            fw_paddr;
>>       void            *fw_buffer;
>> -    void __iomem        *psp_regs[PSP_MAX_REGS];
>> +    u32                     certfw_buf_sz;
>> +    u64                     certfw_paddr;
>> +    void                    *certfw_buffer;
>>   };
>>     static int psp_exec(struct psp_device *psp, u32 *reg_vals)
>> @@ -47,13 +60,22 @@ static int psp_exec(struct psp_device *psp, u32 
>> *reg_vals)
>>       int ret, i;
>>       u32 ready;
>>   +    /* Check for PSP ready before any write */
>> +    ret = readx_poll_timeout(readl, PSP_REG(psp, PSP_STATUS_REG), 
>> ready,
>> +                 FIELD_GET(PSP_STATUS_READY, ready),
>> +                 PSP_POLL_INTERVAL, PSP_POLL_TIMEOUT);
>> +    if (ret) {
>> +        drm_err(psp->ddev, "PSP is not ready, ret 0x%x", ret);
>> +        return ret;
>> +    }
>> +
>>       /* Write command and argument registers */
>>       for (i = 0; i < PSP_NUM_IN_REGS; i++)
>>           writel(reg_vals[i], PSP_REG(psp, i));
>>         /* clear and set PSP INTR register to kick off */
>>       writel(0, PSP_REG(psp, PSP_INTR_REG));
>> -    writel(1, PSP_REG(psp, PSP_INTR_REG));
>> +    writel(psp->conf.notify_val, PSP_REG(psp, PSP_INTR_REG));
>>         /* PSP should be busy. Wait for ready, so we know task is 
>> done. */
>>       ret = readx_poll_timeout(readl, PSP_REG(psp, PSP_STATUS_REG), 
>> ready,
>> @@ -90,69 +112,124 @@ int aie_psp_waitmode_poll(struct psp_device *psp)
>>     void aie_psp_stop(struct psp_device *psp)
>>   {
>> -    u32 reg_vals[PSP_NUM_IN_REGS] = { PSP_RELEASE_TMR, };
>> +    u32 reg_vals[PSP_NUM_IN_REGS];
>>       int ret;
>>   +    PSP_SET_CMD(psp, reg_vals, PSP_RELEASE_TMR, 0, 0, 0);
>> +
>>       ret = psp_exec(psp, reg_vals);
>>       if (ret)
>>           drm_err(psp->ddev, "release tmr failed, ret %d", ret);
>>   }
>>   -int aie_psp_start(struct psp_device *psp)
>> +static int psp_validate_fw(struct psp_device *psp, u8 cmd, u64 
>> paddr, u32 buf_sz)
>>   {
>>       u32 reg_vals[PSP_NUM_IN_REGS];
>>       int ret;
>>   -    reg_vals[0] = PSP_VALIDATE;
>> -    reg_vals[1] = lower_32_bits(psp->fw_paddr);
>> -    reg_vals[2] = upper_32_bits(psp->fw_paddr);
>> -    reg_vals[3] = psp->fw_buf_sz;
>> +    PSP_SET_CMD(psp, reg_vals, cmd, lower_32_bits(paddr),
>> +            upper_32_bits(paddr), buf_sz);
>>         ret = psp_exec(psp, reg_vals);
>> -    if (ret) {
>> +    if (ret)
>>           drm_err(psp->ddev, "failed to validate fw, ret %d", ret);
>> -        return ret;
>> -    }
>>   -    memset(reg_vals, 0, sizeof(reg_vals));
>> -    reg_vals[0] = PSP_START;
>> -    reg_vals[1] = PSP_START_COPY_FW;
>> +    return ret;
>> +}
>> +
>> +static int psp_start(struct psp_device *psp)
>> +{
>> +    u32 reg_vals[PSP_NUM_IN_REGS];
>> +    int ret;
>> +
>> +    PSP_SET_CMD(psp, reg_vals, PSP_START, PSP_START_COPY_FW, 0, 0);
>> +
>>       ret = psp_exec(psp, reg_vals);
>> -    if (ret) {
>> +    if (ret)
>>           drm_err(psp->ddev, "failed to start fw, ret %d", ret);
>> +
>> +    return ret;
>> +}
>> +
>> +int aie_psp_start(struct psp_device *psp)
>> +{
>> +    int ret;
>> +
>> +    ret = psp_validate_fw(psp, PSP_VALIDATE,
>> +                  psp->fw_paddr, psp->fw_buf_sz);
>> +    if (ret)
>>           return ret;
>> -    }
>>   -    return 0;
>> +    if (!psp->certfw_buf_sz)
>> +        goto psp_start;
>> +
>> +    ret = psp_validate_fw(psp, PSP_VALIDATE_CERT,
>> +                  psp->certfw_paddr, psp->certfw_buf_sz);
>> +    if (ret)
>> +        return ret;
>> +psp_start:
>> +    return psp_start(psp);
>> +}
>> +
>> +/*
>> + * PSP requires host physical address to load firmware.
>> + * Allocate a buffer, obtain its physical address, align, and copy 
>> data in.
>> + */
>> +static void *psp_alloc_fw_buf(struct psp_device *psp, const void 
>> *fw_data,
>> +                  u32 fw_size, u32 align, u32 *buf_sz,
>> +                  u64 *paddr)
>> +{
>> +    u32 alloc_sz;
>> +    void *buffer;
>> +    u64 offset;
>> +
>> +    *buf_sz = ALIGN(fw_size, align);
>> +    alloc_sz = *buf_sz + align;
>> +
>> +    buffer = drmm_kmalloc(psp->ddev, alloc_sz, GFP_KERNEL);
>> +    if (!buffer)
>> +        return NULL;
>> +
>> +    *paddr = virt_to_phys(buffer);
>> +    offset = ALIGN(*paddr, align) - *paddr;
>> +    *paddr += offset;
>> +    memcpy(buffer + offset, fw_data, fw_size);
>> +
>> +    return buffer;
>>   }
>
> Two comments:
>
> 1) Can the integer overflow check be added here? If fw_size is very large
> (close to UINT_MAX), ALIGN(fw_size, align) could overflow:
>
>   fw_size = 0xFFFF0000 (4GB - 64KB)
>   align = 0x10000 (64KB)
>   *buf_sz = ALIGN(0xFFFF0000, 0x10000) = 0x0 (overflow)
>   alloc_sz = 0x0 + 0x10000 = 0x10000
The firmware size is not user input. It will be less than 4M.
>
> 2) virt_to_phys() on drmm_kmalloc() allocated memory assumes
> physical contiguity. Not sure size of this FW.
>
> For allocations larger than a few MB, kmalloc may
> not provide physically contiguous pages. Would dma_alloc_coherent() be
> more appropriate.

The firmware will be less than 4M. And the host physical address is used 
for PSP firmware loading. Please see the previous discussion 
https://lore.kernel.org/dri-devel/edaa7f7d-a3e8-1b1a-37b8-3fd5a8a7790d@quicinc.com/

A comment were added before psp_alloc_fw_buf().


Thanks,

Lizhi

>
>>   struct psp_device *aiem_psp_create(struct drm_device *ddev, struct 
>> psp_config *conf)
>>   {
>>       struct psp_device *psp;
>> -    u64 offset;
>>         psp = drmm_kzalloc(ddev, sizeof(*psp), GFP_KERNEL);
>>       if (!psp)
>>           return NULL;
>>         psp->ddev = ddev;
>> -    memcpy(psp->psp_regs, conf->psp_regs, sizeof(psp->psp_regs));
>> +    psp->fw_buffer = psp_alloc_fw_buf(psp, conf->fw_buf, conf->fw_size,
>> +                      PSP_FW_ALIGN, &psp->fw_buf_sz,
>> +                      &psp->fw_paddr);
>> +    if (!psp->fw_buffer)
>> +        return NULL;
>> +
>> +    if (!conf->certfw_size) {
>> +        drm_dbg(ddev, "no cert fw");
>> +        goto done;
>> +    }
>>   -    psp->fw_buf_sz = ALIGN(conf->fw_size, PSP_FW_ALIGN);
>> -    psp->fw_buffer = drmm_kmalloc(ddev, psp->fw_buf_sz + 
>> PSP_FW_ALIGN, GFP_KERNEL);
>> -    if (!psp->fw_buffer) {
>> -        drm_err(ddev, "no memory for fw buffer");
>> +    /* CERT firmware */
>> +    psp->certfw_buffer = psp_alloc_fw_buf(psp, conf->certfw_buf,
>> +                          conf->certfw_size, PSP_CFW_ALIGN,
>> +                          &psp->certfw_buf_sz,
>> +                          &psp->certfw_paddr);
>> +    if (!psp->certfw_buffer) {
>> +        drm_err(ddev, "no memory for cert fw buffer");
>>           return NULL;
>>       }
>>   -    /*
>> -     * AMD Platform Security Processor(PSP) requires host physical
>> -     * address to load NPU firmware.
>> -     */
>> -    psp->fw_paddr = virt_to_phys(psp->fw_buffer);
>> -    offset = ALIGN(psp->fw_paddr, PSP_FW_ALIGN) - psp->fw_paddr;
>> -    psp->fw_paddr += offset;
>> -    memcpy(psp->fw_buffer + offset, conf->fw_buf, conf->fw_size);
>> +done:
>> +    memcpy(&psp->conf, conf, sizeof(psp->conf));
>>         return psp;
>>   }
>> diff --git a/drivers/accel/amdxdna/npu3_regs.c 
>> b/drivers/accel/amdxdna/npu3_regs.c
>> index f6e20f4858db..fb2bd60b8f00 100644
>> --- a/drivers/accel/amdxdna/npu3_regs.c
>> +++ b/drivers/accel/amdxdna/npu3_regs.c
>> @@ -16,6 +16,15 @@
>>     /* PCIe BAR Index for NPU3 */
>>   #define NPU3_REG_BAR_INDEX    0
>> +#define NPU3_PSP_BAR_INDEX      4
>> +
>> +#define MMNPU_APERTURE3_BASE    0x3810000
>> +#define NPU3_PSP_BAR_BASE       MMNPU_APERTURE3_BASE
>> +
>> +#define MPASP_C2PMSG_123_ALT_1  0x3810AEC
>> +#define MPASP_C2PMSG_156_ALT_1  0x3810B70
>> +#define MPASP_C2PMSG_157_ALT_1  0x3810B74
>> +#define MPASP_C2PMSG_73_ALT_1   0x3810A24
>>     static const struct amdxdna_fw_feature_tbl 
>> npu3_fw_feature_table[] = {
>>       { .major = 5, .min_minor = 10 },
>> @@ -23,14 +32,28 @@ static const struct amdxdna_fw_feature_tbl 
>> npu3_fw_feature_table[] = {
>>   };
>>     static const struct amdxdna_dev_priv npu3_dev_priv = {
>> +    .npufw_path             = "npu.dev.sbin",
>> +    .certfw_path            = "cert.dev.sbin",
>>       .mbox_bar        = NPU3_MBOX_BAR,
>>       .mbox_rbuf_bar        = NPU3_MBOX_BUFFER_BAR,
>>       .mbox_info_off        = NPU3_MBOX_INFO_OFF,
>> +    .psp_regs_off   = {
>> +        DEFINE_BAR_OFFSET(PSP_CMD_REG,    NPU3_PSP, 
>> MPASP_C2PMSG_123_ALT_1),
>> +        DEFINE_BAR_OFFSET(PSP_ARG0_REG,   NPU3_PSP, 
>> MPASP_C2PMSG_156_ALT_1),
>> +        DEFINE_BAR_OFFSET(PSP_ARG1_REG,   NPU3_PSP, 
>> MPASP_C2PMSG_157_ALT_1),
>> +        DEFINE_BAR_OFFSET(PSP_ARG2_REG,   NPU3_PSP, 
>> MPASP_C2PMSG_123_ALT_1),
>> +        DEFINE_BAR_OFFSET(PSP_INTR_REG,   NPU3_PSP, 
>> MPASP_C2PMSG_73_ALT_1),
>> +        DEFINE_BAR_OFFSET(PSP_STATUS_REG, NPU3_PSP, 
>> MPASP_C2PMSG_123_ALT_1),
>> +        DEFINE_BAR_OFFSET(PSP_RESP_REG,   NPU3_PSP, 
>> MPASP_C2PMSG_156_ALT_1),
>> +        /* npu3 doesn't use 8th pwaitmode register */
>> +    },
>> +
>>   };
>>     const struct amdxdna_dev_info dev_npu3_pf_info = {
>>       .mbox_bar        = NPU3_MBOX_BAR,
>>       .sram_bar        = NPU3_MBOX_BUFFER_BAR,
>> +    .psp_bar                = NPU3_PSP_BAR_INDEX,
>>       .vbnv            = "RyzenAI-npu3-pf",
>>       .device_type        = AMDXDNA_DEV_TYPE_PF,
>>       .dev_priv        = &npu3_dev_priv,
>
