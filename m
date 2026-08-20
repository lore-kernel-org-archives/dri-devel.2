Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBA9C5DF85
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 06:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D1A910E151;
	Thu, 20 Aug 2026 06:58:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ToZYJURG";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011006.outbound.protection.outlook.com
 [40.93.194.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B35410E151
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 06:58:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEBFJ1wIma/53goUA9l/Ix7ymgxf+OeGr+rhEsD1qtvlcU11VIR0/7CmiHYjx+Qva47KZtaME5Jx3a+PFYjov8po0pgZFTeWX2RFeVWqwn6yETbD9fEUv0f7V6pdVE2XokInO8TXy0QYSLNrvRq/iulG5qyjuvADuBLijgmYXSWb6w8zxMnouxcHOv2v3hw8JuhlZVpV4PleftKnn5HqgYZza1YcV5juMlh9Og6PFnVQFWaEyld9FCshKkZ6/rNaByFDNiiAZBrmWQjp7Die/7AQIusQyyXj/LwWwgPUnthNLWRs6JylIfS0kpCVae9JF4bqrF46R49JPnTP7w3+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aO9DAcBBtKBHXAV1OT/9qV94kGOK6Y+4LFy5jcN5SaY=;
 b=nO5N6cJE1VscOhlrZ8VI/khhXVdL5AvKsy6dCq3McpnTvDrVrzHMF1K7EKuRPIqk/itBDZCXPA17WSinD+XbCxdpSP62PmaMSqk3Hh6w90PW5B14oJtQnwmnROxCMpMkRtQNrbhFnrQNjRKEAyhhyNQx1hp0fkc9LK87eT0ePdGdc6aHE4U75dw7vHenLD3N0H6nXtjM1/QDj3W8ylbxS3hKW+b/CFPIvJNtJSpiFGorb1kdXLI7DkfYuXXV34KV5C9RxwhyImG95tnEw6TcHoSlW17CG6UMmHb/Ntq9gkjv3KTL8W0t38Uuh7rDL7A5y3AK0tjRkapOWx4KmvanPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aO9DAcBBtKBHXAV1OT/9qV94kGOK6Y+4LFy5jcN5SaY=;
 b=ToZYJURGbZvn75fw96NfkDA63MqJOXhSksimBxO9FIYfp6soNDT3TUfL2Lvsz37aJIqsuITEOeych/4G5Ak0dYyePtZxt7oKIjLUYsa4ajP+pFnNWC/l6wr0wtq/pXyzBnfIiaMSVLFkYx17knOd33E61TaZ3z0mbdZas5coN54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS2PR12MB9566.namprd12.prod.outlook.com (2603:10b6:8:279::16)
 by CH0PR12MB8529.namprd12.prod.outlook.com (2603:10b6:610:18d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Thu, 20 Aug
 2026 06:58:02 +0000
Received: from DS2PR12MB9566.namprd12.prod.outlook.com
 ([fe80::2d07:1044:6ee1:830b]) by DS2PR12MB9566.namprd12.prod.outlook.com
 ([fe80::2d07:1044:6ee1:830b%3]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 06:58:02 +0000
Message-ID: <c13b66fa-b3e7-4ac9-a889-36c924049b5f@amd.com>
Date: Thu, 20 Aug 2026 12:27:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fpga: versal: add dma-buf programming support
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
References: <20260816150734.2092802-1-aravind.thokala@amd.com>
 <20260816150734.2092802-3-aravind.thokala@amd.com>
 <20260816151831.E3C241F000E9@smtp.kernel.org>
Content-Language: en-US
From: Aravind Thokala <aravind.thokala@amd.com>
In-Reply-To: <20260816151831.E3C241F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0290.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21b::15) To DS2PR12MB9566.namprd12.prod.outlook.com
 (2603:10b6:8:279::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9566:EE_|CH0PR12MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e65334c-a3c1-49fa-4f2a-08defe8860cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|10067099003|11063799006|5023799004|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pvDhsWT5AWPk1YBYh0Q5op94AVvYF/OfIloUwI3sbfGYu15zkoihd8xtDabUf+9UVthLDOkx3NSoWsKZ5xKlDzcKm3nSr7qSPGkZbqIQnT5koorw0+EEQdiuOFdLUnaX4wpHnHFxCChnye9uLgIZgIjjOSYOw/oldFQy35/S5evSI8pUxk+X4JCDX0hBqmiPiArMz/hqbNaIPuNRDLHUxaSaAZlwc1VCaSmNWwLknRrQfX9DMVCPMFXAaRHQOREf26oqTEP4Tsyp0cP53DHLwAG215+cv5QL4U5Iiwrv3oaBrlZX6MFlhsavCq7NioQSIP2rRyQG5J5EjGZK98DMCE8H/odzjDGkzKJ3o4I5uQ3BWqxPEY/ns0cHlyLzF3gPfwPApV9N1LPmQIsv5FItu8hwgsGIszKZ5TT4UutxWgQ/IH81/sDcO6Ip9o50CNyWD7BwT6FIGNgRG0x4rSywz6OkeXEPVoc8uUYAni+AofrpvYevyfmhkTJcl/g1fHgL+Ck3IgXiJvz3I6cEUqS6ohxSkxQQopk7CJxKS9jK242o6+AZx/BT3S3Pz9EXypeNGb/RmAhINsv8m1TnFyu7xqSCj1gRfefreDfYVQCdcWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(5023799004)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWpBSUtYVHM2MlZLWHNQQTVhSHpDeTZQeWtxb0tPbUd4NENrK2RQbVF2aVA5?=
 =?utf-8?B?QlNOK2hPdUJDeDFLcmJMVzdYeEg5OFU3S2t1aWwxTjJKYmNVOVNyNjI3bVhj?=
 =?utf-8?B?QUgyYTBsTEVRcll4UFFUT0QvVGlhQXpvRzAyRjl1T2xtSzdXWVp3bTJiWUkv?=
 =?utf-8?B?dUlNVEs1cG9NOXFON3hUYXRNcm1wbFAxcDU4R1VxNmFqalAwci8rOWYxMFVo?=
 =?utf-8?B?NG00bjRZRDgyMnJnRjFaOEZYVjhmOG9GTXFoSjNGT0NMMS9kaUpqMCtwWUl3?=
 =?utf-8?B?K1BZRDFEOVJzbU03WDlwZmZuNjJxTXpUeTBha3VvaWowV1laWm42L1Y3ZmVJ?=
 =?utf-8?B?aWtKRzNkZi9Ob3JiSTRSS0c3MTVINWhGU2NNYWMwNCtweDFXbkxENE1UeWdE?=
 =?utf-8?B?TVZ1VFlKbnBYZFVtcXNzbVRXMTBkV251U1dEN3UyYy91am1CaDRHNEk2RHZ4?=
 =?utf-8?B?K3REZWhYak1PTWhxUlJTYkZKeWIvWUhHTEcvRU91TkpSTy9oRUY5N1lwY0Qw?=
 =?utf-8?B?UEZ0ZVpjZ3lCc1N1dVM3UEdUc1NGQkY3YVJOYytSOEh0L2UzdU8yTXo3a21w?=
 =?utf-8?B?U0l1aGg2QTAzampYWElFTGdPbDFVbTlYSGdnTFZBUG9vcDMvMUNXT1luL3pL?=
 =?utf-8?B?VER2alhMWG9zaVFHYlZmNm0rcmVVOEY3VmhRa0hSYXFSSnMzMWlaOUo5b1Zp?=
 =?utf-8?B?K0FHUUxQbmpXVExMcE12TFpnWmdlN05COUk2cnBvNDE1Z0c0VmNiNjBPSnAx?=
 =?utf-8?B?SHZiTkcvK2YvZDcySWFUY2tLYzlTeWwralF1RHN4Q3FmTk4rMmxNaHN5OFFu?=
 =?utf-8?B?ZlgzZTVWTDR6cEJUdGN3UGRGMnhXYkswQjJHSDVDUW11UEtDYnhhVzFrbHdy?=
 =?utf-8?B?OU91M0VFYWFON0xqaU5CUHdIcmJVTHpsUERrbVZxODgyUHlqSzhQWmdIcGpi?=
 =?utf-8?B?YjBCbUxrNEZZMkF1QmNhdWdJdFZ2Tm12L2dmS1BpbWx2eGk3ejc2VnJUR3lL?=
 =?utf-8?B?aUJTaWtsbHJXUldSOXZZNTJ0cDY1T3dHUVdONjNaajMxRTNaZVU3NDBpRkkx?=
 =?utf-8?B?UWR5a2tmNXZvUm42T245b1V6NlpxcFQ5SWFKY1dJSzZhc0ltSTVXSlpRd3pt?=
 =?utf-8?B?WUcwMm1NOUZ3UU9nMk1HUU11ckx0QXAxSVRBMEIwZlFTNUs4VkpWcVBRNXVD?=
 =?utf-8?B?bTBac01XQUNmSjQxdTB2MUJzcHd5L25xWEgrbS9LS1M1N09zOHZiS1JWdzRj?=
 =?utf-8?B?bW9PREU2Zk1wZ2wxSkxZNlNwOFJwaWE4OUVvM3lrbUhUdEdhYXVaNHgzZzRX?=
 =?utf-8?B?YWhyRlVBRGZuTFJ5cjg1MHd6R0oxNzArT2pQZ3A0NHlSM2tKSnNJSGJhK0R0?=
 =?utf-8?B?UEhtbnQzNTFJSjljS2o4djdNbEtrRmRJMDgzaEE4cmw4VWhBbUFzRDVMbHZW?=
 =?utf-8?B?YXEwRzhNV2pkYnFsMkN0U2JuUXZWbEszMm5iL0lsRGpabzR4Sm5pN2NCa0tn?=
 =?utf-8?B?MXZQTnE2SmdKbkx0Vkw5M0o4cURhUndhU3NWZDIzbDVreEdkZUtWeUlDalkr?=
 =?utf-8?B?VnNOY013bjRsb1QyTE5PalZJMzhhNUF4RzVFRUNtQm92M0hRalByV3h6NU8v?=
 =?utf-8?B?UjY4MkZ5Zkh6Y0lDWEU4V2dnanJJMlpNM2lVc1Z4SCtjcjN2ZHc3bThVSFpH?=
 =?utf-8?B?UHNnaVRVNFN1QkpscGFpQlkxZ213TG9sRkd4K2RwckFZMmZEMkpFYW1sMi9Z?=
 =?utf-8?B?c21Ed05SbEozeUZxdWhqOW1SWHd5T2I1a3R2VEt6dUs2d2c1NHZnREgwL3cz?=
 =?utf-8?B?OFRsdUJqd1c5OFNpOE1ZSUl1L2pkRVJBUFFBY3gzV0trL1cxVjg2YlBzWG8z?=
 =?utf-8?B?ZTFXeVJTOUppblczRjVqVFNYY1N6a25aRGRIdmJOaWJzUWtXaDlEZnQwU214?=
 =?utf-8?B?SS90d3ZEbmtOVkRBUFdkMVRhY0t0QlJLNG9tZndMUlpKT2hoeWNhNXRXVStL?=
 =?utf-8?B?V1RJNkdxVEZ2VndBaDBqMDVHMkpyc3FDNnhuelN0VzVKQXIvbGRlQXhTUEti?=
 =?utf-8?B?Q1RNZWhncE90YU5HUTdsSlhUek54QkJsY2kxMW5yUmVhYnFXMDY4ME4rT21C?=
 =?utf-8?B?QVRpOUJMVFNtd0dTMGZMUk1HUkFUaE5jYlI1UFRrZ0ZCOE93bG1QZklNem1N?=
 =?utf-8?B?STRaM0JxYUhuSXBBc0RZNVZSN2VPUGZFTy9YajBpZVJNcnRmbmduanZnTFdz?=
 =?utf-8?B?bkZBWXZZY3MzK3FPTUpKYTN6S09qcXFDS2N4Y0wxSkw1eUtnYW84ZFFCTmVV?=
 =?utf-8?B?ZkVQNmRlMkVHV3FtNERUNHYxcDRERHJhb0NjVWdYbFF0VE9rejJJdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e65334c-a3c1-49fa-4f2a-08defe8860cb
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 06:58:02.7155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FjlMtaFJVTDpcf7RdZTFB4+xniJC+SmP59uOvi/4xmOWqwQ/XxVHG46VFjd+HhkR4AaSNfn5C1uOd4jSpiIfZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8529
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

Hi,

On 8/16/2026 8:48 PM, sashiko-bot@kernel.org wrote:
> [You don't often get email from sashiko-bot@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Passing a user-accessible dma-buf directly to the PMC firmware introduces a speculative Time-of-Check to Time-of-Use (TOCTOU) vulnerability that can potentially bypass FPGA bitstream authentication.
> --
> 
> --- Patch [2]: [PATCH 2/2] fpga: versal: add dma-buf programming support ---
> commit 92384704c37fbbfe16cd9659151fbb8646c178cc
> Author: Aravind Thokala <aravind.thokala@amd.com>
> 
> fpga: versal: add dma-buf programming support
> 
> This commit adds a .write_sg callback to the Versal FPGA driver to support
> dma-buf based programming. It extracts the DMA address from the scatter-gather
> table and passes it directly to the firmware, avoiding an intermediate buffer
> copy.
> 
>> diff --git a/drivers/fpga/versal-fpga.c b/drivers/fpga/versal-fpga.c
>> index e6189106c4686..bdaa15a6c9913 100644
>> --- a/drivers/fpga/versal-fpga.c
>> +++ b/drivers/fpga/versal-fpga.c
> 
> [ ... ]
> 
>> @@ -37,11 +38,34 @@ static int versal_fpga_ops_write(struct fpga_manager *mgr,
>>        return ret;
>>   }
>>
>> +static int versal_fpga_ops_write_sg(struct fpga_manager *mgr,
>> +                                 struct sg_table *sgt)
>> +{
>> +     dma_addr_t dma_addr;
>> +
>> +     /* zynqmp_pm_load_pdi() takes a single base address */
>> +     if (sgt->nents != 1) {
>> +             dev_err(&mgr->dev, "dma-buf has %u segments, need exactly 1\n",
>> +                     sgt->nents);
>> +             return -EINVAL;
>> +     }
>> +
>> +     dma_addr = sg_dma_address(sgt->sgl);
>> +
>> +     return zynqmp_pm_load_pdi(PDI_SRC_DDR, dma_addr);
> 
> [Severity: Medium]
> Does this expose the firmware to a Time-of-Check to Time-of-Use (TOCTOU)
> vulnerability if the Xilinx PMC firmware double-fetches the payload?
> 
> By extracting the DMA address from the user-provided dma-buf and passing
> it directly to zynqmp_pm_load_pdi() without copying it to a kernel-owned
> isolated buffer, a process could potentially modify the bitstream
> concurrently during the firmware's authentication and loading process.
> 
> If a user with CAP_SYS_RAWIO maintains a writable memory mapping to the
> dma-buf (for instance, using udmabuf) and invokes FPGA_IOCTL_LOAD_DMA_BUF,
> they could overwrite the memory while the firmware reads it.
> 
> If the firmware re-reads any part of the bitstream after authentication,
> could this be abused to bypass secure boot boundaries?
> 
>> +}
>> +
> 
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260816150734.2092802-1-aravind.thokala@amd.com?part=2

This patch series provides a zero-copy path for FPGA programming by
passing a userspace-allocated DMA buffer directly to the firmware.
Secure bitstream authentication is outside the scope of this series.
It is handled entirely by the firmware.

This follows the same approach as the existing write callback, which
also provides a DMA address to zynqmp_pm_load_pdi().
The dma-buf path does not alter the existing security model.

Kind Regards,
Aravind.
