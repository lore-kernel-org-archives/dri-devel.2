Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969BF1061B1E
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 20:31:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3BFA10E7E5;
	Mon, 30 Mar 2026 20:31:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pKw+fdqJ";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013002.outbound.protection.outlook.com
 [40.93.196.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 901EF10E7E5
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 20:31:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+yH4TyUJMQgsnL4ku0tDVCwhLsgn/q1l/k/bloEJ6MnRPELXX0OqIcZsufNCiVMUriBR8lNUlCPsM+FuXxfRk1ZZ1NUFnhwAbQqDIucdueBF5oqkyUIJvnRZuU2T2srnNsRTjAlxKjMSaLIoH0YzKvLxkNmFIvBEh+hnFunQsnSa0ZSNVKZ/7EzW5QXhNUtNcrIhPYQqfWj6XvoOgwr/z2TTl82nzxKhqScWmpYRpE8RwyH7XpGBuhOrzKAUm+7P61Dtx6YF5sZQM4m+Dp7UDDX6bvGzM7sKm4RqUwTveipuwUMJho6R86IifRk2iz2Ovdub/DFQV4iDy+DbOVJkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpYxtfKfJb5tO3u0FHtTih+y4btXkyuh2a83VLmOQnw=;
 b=uaWpcql2quNDLgVKUT1oR7G56nnlmP5MLeFpQLa9U/Fn1iEkdt36nJtTpR7mZ71HOmbCCsV+V4aPwzo/Vto0KSgkt/IXQoawsjM6Inh58AvGKnc3YPpITWxgykSgJBSqaxyc2b9cA2OpSAGY0ypKLuuMIT3LHV344/p6vnTPgd2bqJ0ARW5l7lz9MuQaqo5R9QpqZlUE9kaRJe4qtrzL/VU+MBFLXwMkQVXzfSwnQ4ANfnc7DP8Owxa6qfzoR0Fhv066Alx5G3njBmem7oIW2zduAtDZp6SnpuiJ2xMih7+e6QS4+hmP1rshB75ptFmAWjyA5KYO65UzWfunKu/W2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpYxtfKfJb5tO3u0FHtTih+y4btXkyuh2a83VLmOQnw=;
 b=pKw+fdqJ1ExbyyYmrhr3VL/2GqeYX01E7bYod1Y778E3cJqgeaCst6e3cS30m992AW7hSt62TBRhQnMR2BEBVtZITHugyL3mli01KoHRC0sc0kZGyBJQTaTWt88rLZUUKtLwZwxEdGtQp+FCTcH2JzBOnMucUsUvf6CYxp2auEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9062.namprd12.prod.outlook.com (2603:10b6:208:3aa::14)
 by PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 20:30:59 +0000
Received: from IA1PR12MB9062.namprd12.prod.outlook.com
 ([fe80::28c6:3cbd:6e97:5257]) by IA1PR12MB9062.namprd12.prod.outlook.com
 ([fe80::28c6:3cbd:6e97:5257%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 20:30:58 +0000
Message-ID: <7240334c-c745-4b98-952a-c81ce4eeb65a@amd.com>
Date: Mon, 30 Mar 2026 13:30:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 4/6] accel/amdxdna: Add AIE4 firmware loading
To: Mario Limonciello <mario.limonciello@amd.com>,
 Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org, quic_jhugo@quicinc.com,
 dri-devel@lists.freedesktop.org, maciej.falkowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com,
 Hayden Laccabue <Hayden.Laccabue@amd.com>
References: <20260330163705.3153647-1-lizhi.hou@amd.com>
 <20260330163705.3153647-5-lizhi.hou@amd.com>
 <4a1ebe69-3bcb-46c3-874c-907e7e5942d5@amd.com>
Content-Language: en-US
From: yidong Zhang <yidong.zhang@amd.com>
In-Reply-To: <4a1ebe69-3bcb-46c3-874c-907e7e5942d5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::19) To IA1PR12MB9062.namprd12.prod.outlook.com
 (2603:10b6:208:3aa::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9062:EE_|PH7PR12MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 498aa604-ace9-4477-2f27-08de8e9b3ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: zYlKmGBCSBfJttArfX5RVnenvzf5RbG8z0GnTmicCjGU74IE5CeG+2EfjDcqpsYmt7QKvjOvJHBgjQt73e49SXkRdiTBoX9dJdbLhGtPGcBz1JLL8LhABqBgwoYbI9DWuGBELINPrqpWrroIezD1vmzuvqYnSV7voBP4sKuk/riZdbk0LNObcAuwquxfacDp1hxERZr4J+XxPEkJ3j09TWjm0lzG1h5/fJj6Bu5adrOYyDMdszQ+HgpX1QVLZQjGrYyNiBfWkfGf1JCbyF84iF8XsrCcbPSHR4GWZq4jQvGTjgLMS/IQTw+MeguooWr+PIYrE1RA6Dc3q3D08Ie3BMqgKRFn9K7M0vlTP5fuzW8Amq1xl+Ih4pGDDICK8TeKU/GUiMMzw0MU011+TMFRSSVvrccrk/Nj9KRZjXjXcvpIA5gXiaHleIzenr87eoOKcTVY4uJsAM0TiRGKE5E9TjY5vgE89nkrLs01rkuHf7rr3AjrG+EuvldbJIpVu82p3nWPNapjk/Bu1M33pjXpviEWHLFdtbTMPGAKbOjvuAYr2a1jVaFJ+PFC8Xecppg0sEtqRPD4hE7Pq6k0V1+56omSxt/FmqCQYyg2mo6xCnxox7FmXc1bltn+cV1mzwwdIkhyG2iRQXUVXoOGakRaT/d/TeCMmpvda7lzhb1XT4IVR7/IWDsLpsQgdekzuhjmquISMpomdQfBmubhQ4zxVMFUVqcDVQCeft2tOGQ2W2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB9062.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXBQR2oyKzVxSlVPRFZxRnBSa29yaTJuR0RmZEN0ZlJOakFhTG4zVXBuNFAr?=
 =?utf-8?B?MVJQSldwZGtSNVdBeC8wNGlEZmdydWtWNm1NcnRDSlJ4Uk5CUHNDMnV1WWFE?=
 =?utf-8?B?MDZvT1pXemo3RUlkeUdCclZ5cy9HUythN0duNUdnN2RZWHlMSTRkZU1TOHhG?=
 =?utf-8?B?SGRJSy9NcWViOUhDMmpVbE5xQUhWSWcyRnF4NitOUW0wTWdWRm1QT3JBeTI3?=
 =?utf-8?B?Z1dLaUxCdlRTcVBMeWt6SzNFbkZ3aWFuVW5FbGt0WVY2VnVZUU10UkZDQlo4?=
 =?utf-8?B?aEtYbE84NGFOOU5iVmlVOC9UVG9BUXBWa2ZaSVdlT284aUNNRWVQRVJqM2dh?=
 =?utf-8?B?MzNSVFJTZS9vWmt2RC9UZE9yMmVFMlZ2SERXVnloWGowR1hmck5vaUhJbVoy?=
 =?utf-8?B?NXNkV1FVdnIvR0FlSGxHS09DSTFwU29YUzUxVFZwWDJMdVlYUHJTVDVNaHNT?=
 =?utf-8?B?Uk5tTHluQ0FCcnhXNVYyMGxiK3pzaGRJNk03NkRtM0FUTEJTc1ZEdDBkU2Vs?=
 =?utf-8?B?Zm4yME9sMjZsZklGbkZCWkc5cDZBU1Q2ZG5FMDY5SXFVZ0N1cUs3VlZyV24v?=
 =?utf-8?B?REVyc3ZxbzNtSHptdTJkMnBOeE9IU2orN2p5ZldBNGxnR09oQnkxYVRIS1Zx?=
 =?utf-8?B?VlFPNjY5eU1FNmltNkVBMFdQUGh4Rk9oaldVNHJiOUJuSzcwU0xpRFdKZk9s?=
 =?utf-8?B?aDJuREtYMW5xeVBkdkJXYVhXVjdmWjZMcXZFSFZvbis0N2RvYld2YlB5ZU5p?=
 =?utf-8?B?UmpUL0FSN1hBVHVVWlJjRWlFaEFYK3RKVERmcS92OHEreE5GMmUybTI4UHQw?=
 =?utf-8?B?cVhSelRmVlZXbHFiSmVEckZTY1E4WTRqVFRPNVlyZ2ExTkdUYnBUWTdlUTdj?=
 =?utf-8?B?K2tOdXNCTThQV1R4UTIwL1BRdk56QjJaa1gvakpsdEc5M1hQbVVSR3lFNGhR?=
 =?utf-8?B?RmRlWmRDVzk0WkZVeFBITGZCU0xJVVIzQXBKYW5TT0lTa2ZXYkhSTy9HY3Js?=
 =?utf-8?B?OHNoNUM3OU9BcEJXVEQ3UTRxSXh4dGtYL0xHMDdRWVhYNWJxd3ZveElyK04r?=
 =?utf-8?B?VlBiQVFTUFFCRnZJdlVtbVRmeG84cjBpdmsrU0luOVd0ajBIMGs3SkM1Mm1y?=
 =?utf-8?B?M0wrM0xrVEdZa1hSMHFVSjVDRUxMaEdMeStlWXdNNVlaeUs2L2pnWVVJUEZo?=
 =?utf-8?B?NWlJNnozTjgyRFFKcXhCUHFUVkpqNVVkbjQreURGNnBEaUNTb0tTV0JpVUFJ?=
 =?utf-8?B?VGpUZ1RzWXI4cFl1U01SYk1CTml1ZEwwamtDUHNrRXdETC8vck9Bb3NwckFP?=
 =?utf-8?B?UVFsZ0hTYUphcnNpVFpHYmh5MkdKeWorRFl4STZhcFh3Nkp1RDRhRWRHMllI?=
 =?utf-8?B?NGoyRGJraTVqamZ3a1J3QnNLdWtKNnA2WmtWeURMTnhBS1kwMCtGZmVNQXFl?=
 =?utf-8?B?T0FLSGtpWUtHTnVIZ0FYUzZVd2lobzRoMlpTei9SL3Y3SzZHZVN0R0twSnBP?=
 =?utf-8?B?L1Zka2Y5bnFTbVR6RnhDVDVuYmdmVTU0cjVCd1BDNnpvVkNjTGVzbGpNWkVn?=
 =?utf-8?B?TklIRVhzaWVNdHNPdUlmc0RwR3pQWnh6V2pUSmxpNjdUS0NPWEdmSFRFdlNx?=
 =?utf-8?B?NnFlc1VLV0RKYXRqdkUvYzZNUkRaUzFXcGcxZFZDSzNWTWdRajhoUTZOSHdw?=
 =?utf-8?B?R0ZUUUVLRGxKMG9KWitEYTY3aENra1RMR0pTOG9aM1NiTFFpMmZ0Q3Q4bVhx?=
 =?utf-8?B?Ujk5S3ZTNlJxSXhaazZhVFYyZlM3VFFsZ0x1bk4rTWh6UjZIbzhwVHFNU21U?=
 =?utf-8?B?L1VwSW5ZMDFJdFFuNWZuUkMxc0RLM1FlUVVIUlZDb0FXbzVERHFxOU50czJE?=
 =?utf-8?B?Ly9xUkxJd0RuQlRxbjljekk1S0k0dVhELzZIQWFCQUpObThYbnR3UkY4VjVE?=
 =?utf-8?B?d2pzZFo3cXg4bUcvTzBHNTNnb0ZGdHBSZ2kzc3orbWZLQ1BTWmpoSE41c29P?=
 =?utf-8?B?WllCNHVMZE1QUTJsQ0o1Tmt6cURQalQ0NFo1djZVQVE1TlE0MzJoMXZSdVRB?=
 =?utf-8?B?Szk5b0IzZFVMQytaQlNIL0x6K2NWRlBlUmJCdG12RUNuMWVzNHM5T0RmOVNX?=
 =?utf-8?B?Q1lFeHlNN2NaTEJ4YjhvMzR0SkRycmo4bGkxNGIwZEZRN0Vua0VWcTIyNkdN?=
 =?utf-8?B?aE4va3h4MTJ0WG1iMmRNbzM4Unpwc0tPMnZlOUtraXJza004cDYvc3ZwVWlu?=
 =?utf-8?B?VUpsU2hqMDloc3Z5Q1JxaUdIRTU1OVU3dDBVU2Q1aTAvSEoyeVBDamxRMjl6?=
 =?utf-8?B?b3QzYjNyZzdQQlZWaU1zR0tMU1VKdEZva3lpN0s5ZXZMKzJiSGlXdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 498aa604-ace9-4477-2f27-08de8e9b3ff9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9062.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 20:30:57.9117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwNIaLncUoA2E5pEtYniSCtO2+1x8xKnjkigVeDwqliCavHBjHzNrz5n3XCiXGzbKKcpwPpSFUyhmFARXfwfRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6833
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


On 3/30/26 13:17, Mario Limonciello wrote:
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
>> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
>> index e4b7893bd429..0489e668cd73 100644
>> --- a/drivers/accel/amdxdna/aie2_pci.c
>> +++ b/drivers/accel/amdxdna/aie2_pci.c
>> @@ -549,6 +549,8 @@ static int aie2_init(struct amdxdna_dev *xdna)
>>         psp_conf.fw_size = fw->size;
>>       psp_conf.fw_buf = fw->data;
>> +    psp_conf.arg2_mask = GENMASK(23, 0);
>> +    psp_conf.notify_val = 1;
>>       for (i = 0; i < PSP_MAX_REGS; i++)
>>           psp_conf.psp_regs[i] = tbl[PSP_REG_BAR(ndev, i)] + PSP_REG_OFF(ndev, i);
>>       ndev->aie.psp_hdl = aiem_psp_create(&xdna->ddev, &psp_conf);
>> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
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
>> @@ -207,13 +211,12 @@ static int aie4_mailbox_init(struct amdxdna_dev *xdna)
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
>> +        XDNA_ERR(xdna, "failed to request_firmware %s, ret %d", fw_name, ret);
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
>> +        XDNA_ERR(xdna, "failed to request_firmware %s, ret %d", fw_name, ret);
>> +        goto release_npufw;
>> +    }
>> +
>> +    if ((*certfw)->size > CERTFW_MAX_SIZE) {
>> +        XDNA_ERR(xdna, "CERTFW over maximum size of 32 KB + 256 B");
>> +        ret = -EINVAL;
>> +        goto release_certfw;
>> +    }
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
>> +        psp_conf.psp_regs[i] = tbl[PSP_REG_BAR(ndev, i)] + PSP_REG_OFF(ndev, i);
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
>>   @@ -282,6 +372,8 @@ static int aie4_pcidev_init(struct amdxdna_dev_hdl *ndev)
>>           return ret;
>>       }
>>   +    for (i = 0; i < PSP_MAX_REGS; i++)
>> +        set_bit(PSP_REG_BAR(ndev, i), &bars);
>>       set_bit(xdna->dev_info->mbox_bar, &bars);
>>       set_bit(xdna->dev_info->sram_bar, &bars);
>>   @@ -300,6 +392,15 @@ static int aie4_pcidev_init(struct amdxdna_dev_hdl *ndev)
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
>> diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
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
>> diff --git a/drivers/accel/amdxdna/aie_psp.c b/drivers/accel/amdxdna/aie_psp.c
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
>>     struct psp_device {
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
>> @@ -47,13 +60,22 @@ static int psp_exec(struct psp_device *psp, u32 *reg_vals)
>>       int ret, i;
>>       u32 ready;
>>   +    /* Check for PSP ready before any write */
>> +    ret = readx_poll_timeout(readl, PSP_REG(psp, PSP_STATUS_REG), ready,
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
>>         /* PSP should be busy. Wait for ready, so we know task is done. */
>>       ret = readx_poll_timeout(readl, PSP_REG(psp, PSP_STATUS_REG), ready,
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
>> +static int psp_validate_fw(struct psp_device *psp, u8 cmd, u64 paddr, u32 buf_sz)
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
>> + * Allocate a buffer, obtain its physical address, align, and copy data in.
>> + */
>> +static void *psp_alloc_fw_buf(struct psp_device *psp, const void *fw_data,
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
>>     struct psp_device *aiem_psp_create(struct drm_device *ddev, struct psp_config *conf)
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
>> -    psp->fw_buffer = drmm_kmalloc(ddev, psp->fw_buf_sz + PSP_FW_ALIGN, GFP_KERNEL);
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
>> diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/npu3_regs.c
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
>>     static const struct amdxdna_fw_feature_tbl npu3_fw_feature_table[] = {
>>       { .major = 5, .min_minor = 10 },
>> @@ -23,14 +32,28 @@ static const struct amdxdna_fw_feature_tbl npu3_fw_feature_table[] = {
>>   };
>>     static const struct amdxdna_dev_priv npu3_dev_priv = {
>> +    .npufw_path             = "npu.dev.sbin",
>> +    .certfw_path            = "cert.dev.sbin",
>>       .mbox_bar        = NPU3_MBOX_BAR,
>>       .mbox_rbuf_bar        = NPU3_MBOX_BUFFER_BAR,
>>       .mbox_info_off        = NPU3_MBOX_INFO_OFF,
>> +    .psp_regs_off   = {
>> +        DEFINE_BAR_OFFSET(PSP_CMD_REG,    NPU3_PSP, MPASP_C2PMSG_123_ALT_1),
>> +        DEFINE_BAR_OFFSET(PSP_ARG0_REG,   NPU3_PSP, MPASP_C2PMSG_156_ALT_1),
>> +        DEFINE_BAR_OFFSET(PSP_ARG1_REG,   NPU3_PSP, MPASP_C2PMSG_157_ALT_1),
>> +        DEFINE_BAR_OFFSET(PSP_ARG2_REG,   NPU3_PSP, MPASP_C2PMSG_123_ALT_1),
>> +        DEFINE_BAR_OFFSET(PSP_INTR_REG,   NPU3_PSP, MPASP_C2PMSG_73_ALT_1),
>> +        DEFINE_BAR_OFFSET(PSP_STATUS_REG, NPU3_PSP, MPASP_C2PMSG_123_ALT_1),
>> +        DEFINE_BAR_OFFSET(PSP_RESP_REG,   NPU3_PSP, MPASP_C2PMSG_156_ALT_1),
>> +        /* npu3 doesn't use 8th pwaitmode register */
>> +    },
>> +
>
> Spurious whitespace here that you ping pong in the later patches.


Thank you so much! I will fix this.

/David

>
>>   };
>>     const struct amdxdna_dev_info dev_npu3_pf_info = {
>>       .mbox_bar        = NPU3_MBOX_BAR,
>>       .sram_bar        = NPU3_MBOX_BUFFER_BAR,
>> +    .psp_bar                = NPU3_PSP_BAR_INDEX,
>>       .vbnv            = "RyzenAI-npu3-pf",
>>       .device_type        = AMDXDNA_DEV_TYPE_PF,
>>       .dev_priv        = &npu3_dev_priv,
>
