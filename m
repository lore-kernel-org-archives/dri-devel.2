Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B17C606A325
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 03:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kOiG7qLF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5395510E1FE;
	Tue, 10 Nov 2026 03:55:47 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6B4710E1FE
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 03:55:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrPo7kpbDQJ432L33BqW/nlLTpShHrEpImFGY5OZ4GsjkagknO0oCFRxdpkslYvPjDrpJvUBijLoQl2xIIoF0LfTTZFSz9fgqDhGzIjav12n0XBTM2wSCRxrzBBUCPfpNUR04vmhATmkJGp4ePEDmMMRlSqGaFTxgdEgNjdzyZY0JYTIrxHuQpyP7pA/AG3mXHP8BDRX395BbNRYIROXYPzrdtOHUWPy8epm6B8LRGn3vMlc02GpK9gBBtCMvgsHkDgqHp14TvW10XD9rYIO+cJ4swWy56qAkBIdMBqS95ON9jyBZ3C/YvTsSjqXH6jHtRkc8iTKY53wfc4NMTnWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6UYnRbtns8rpu9+AhvFjoippi/YIybDZhgJ7jbcd38=;
 b=fThns5DTGr0KZ7iAu27Ng7jR0jedNZKuFKJX9gGzlrMd6A2e4QeGyOjwfY1T9A1GHz4u0dqPeGcoOZceK71KQFU49/fuDo6SsF3zc2B/p4n6BhwCt/rrI3J6y5PWWfznCtBLLOIr8P3auRsYK3bIAaEkyEluD4thJ8n2R1iMlElCRJ7lecjRPlwfS4DXG5nW/wLDuVWWwMk0Rj8+/0yIC/4vndX7mhE4PH0ocE1QfmFEBYSy6f4LH/Xmc76C00DPfabHPuJJ2zfNUvbH5IR6twy50MhjBsdaK7xHownCmSC9/+GGdtly/iuWw23mJxWBhMBtFH99cPEd9luFbyDwXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6UYnRbtns8rpu9+AhvFjoippi/YIybDZhgJ7jbcd38=;
 b=kOiG7qLFasGA0pToc7VXtIp+uMxVO/pAtXGneuHumCzp0kqr0A3SdXPAitxgn+FZReUWnjk9nd7ZF32Kn7GnypJYh7pgKNrSeoUSE03YQcSnoQMfRfct71iyU6vWIIJLtjnyjs/MYAjxDePPMWhXajqOiQZREkod0i63clVKKcA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 03:55:34 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%4]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 03:55:30 +0000
Message-ID: <b05eee8c-ef32-416f-8c44-5eeec37d2e21@amd.com>
Date: Tue, 10 Nov 2026 09:25:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fbdev: xilinxfb: remove the driver
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 michal.simek@amd.com, deller@gmx.de, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, git@amd.com
References: <20261106170902.3656809-1-radhey.shyam.pandey@amd.com>
 <20261106170902.3656809-2-radhey.shyam.pandey@amd.com>
 <20261109-jumping-dolphin-of-refinement-14df24@quoll>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20261109-jumping-dolphin-of-refinement-14df24@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0190.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::15) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|IA1PR12MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d125edd-62e4-4672-ce4e-08df3ede768c
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|5023799004|11063799006|4143699003|56012099006|261022105027099003|261022075727099003|261021121427099003|261026121527099003|10067099003|261026140227099003|261028144727099003|261102123227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 6vAnwJHpd5XSAuPb0RbRLZOtFdQ7mxd6EMSVeDlxyajnK+G3WpfuNgL9wboooKkPDksloQRKFbFsgUDfM6wXG+7xs9R5RCMQCzc4I2ERXPg+QMZTfrFruoSpNXaKN5EfiUbEP4tRWPr4sJh3HZMf+wzTHG8BAJWDLYKdnMo83NAhGXy2n8Rc1MGnE68kYxaDhxCupYNzBA+tdkof5JGboeP40mZ4+vLUXGc78pk67Kn5XywwPa/8WO4JhMQIX8MrFSehMZ4Q7R9Es3GzApFQyLV9E9P11Jc4qEYul++tuaMeRaeHVNwqdMiqlFe2kOyZ7PtCfPVzpKoY6JR7C3omHKqQhLrARV1w6P6A+SJeO1BHp1rlnZNLyvsnMx9p47MxowaAMCIS3rgV/KPggkHJnG7KhtZEUYMACHFo3oj7cub3NMKeoM/p5phLuQTK1sQ/Jx27NxeYQm4/4rXBEv9zw7wf/JBtxclvFuTSEyE9Okpk74EU7JR7gx+5Ei3usY64XcJC46RMMTQ3G1Pt8ZqWSGtDZIeeBXeEkW+v6/GmjwV/JdeS6+m9xODA67UX4Pcb/BfQQHLUVf5FYiw9pRvfD4UD+jjEtxpbuycNXO58MiamI3SElvHJTkLZRgrNEaNJXgZSR+qQrGiPYYxaU4fh1ZKQJ3EkmumXxpK84eGT/Oc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR12MB9697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(5023799004)(11063799006)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(261026121527099003)(10067099003)(261026140227099003)(261028144727099003)(261102123227099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clNNRUJIYWFEOXBqL1lURkUrcnhvTk93T2MvV3BOMjhBb2NmL2FuRlVYM1R6?=
 =?utf-8?B?eklSVVRZWlJjSWxkNUhXbmIrV3ZBZlpXcmJobG9oZVJqcVFqcTMwYVNPaGtH?=
 =?utf-8?B?NlZCdnJZUVJDTzAzcjcwOGcrSFREdkVGekVlVHBRVkdSczBQNnNoRWdCb1k3?=
 =?utf-8?B?d1p2OXdHUzBtbTUrK0xRYWpPejFqcEFPSE5Db0kreDZhd0hLODJuY0MweFBU?=
 =?utf-8?B?bi9lUXN5aVhzNjZxTWtpd3ptajlNYkFSU1doRjlWWWRLT3NvbTFVSFBIZFEr?=
 =?utf-8?B?K2JpL3owOExEMElDbGlDYVlHOUpRZlpJY08yVUJ6WkorTER1eE9QYytIaXpn?=
 =?utf-8?B?NjlwMUIxOWpnMCtDOHFZKzZQQm1DVUxGQ2R1UFdoV3I1T3MrOHRGTzV1dExD?=
 =?utf-8?B?aUpNQ1RhL0wzbU52RS9SRER0NHJuaEtQL0pEOFpYZ0F5ZHdYU2pWWTZVaXlu?=
 =?utf-8?B?dEFHWms5UDVlOEw3eGZYU0wzWVBzWXdyYjBTc2VCUGZTam5Scjd6WVA2RzM3?=
 =?utf-8?B?WWtibnpqeWlCOENiMVNhbnFmeUhjZUsvc0xXT0crOXVWOExwQ3RuRVB5VnJx?=
 =?utf-8?B?L0gxZHdsckVPTEFFVnlUK2ZHSDBkV0E1RDdtTWpGZmM2UzNHT2V6OFYvRVMr?=
 =?utf-8?B?dGxDdlVkOGF2bmRsRTN0anBsR3lxTDNpeUlWanRWN0VNN0hoZERWUDBvMEsr?=
 =?utf-8?B?QWt2UlgyU3lWQ2tCMTRPSzRYai9mY3VkaTZrb1hBdkJDUVNHRUJmcW84OUFV?=
 =?utf-8?B?Vnd3VDdNVk9DZ3grUENBMHdNYmVXOExPdU5KY2wrcms5dTZNQnF0c2xKVE5Q?=
 =?utf-8?B?L0JjYlhhV08rYk9ITEJrVmZ1V2ZjQ0pLUUhHR05MdDNwUUQvdWY3aWRsZi9X?=
 =?utf-8?B?Z1BqNDMxQ3dXU1hqQllRNnpQblJ0aXlNWmZoV0NuS0ozUUFYQ3kwbStsbmRU?=
 =?utf-8?B?RGs1WFU4SW5vOGorZWp0Q1ZpaWdyY204RUVMUVp2Nm45ak8xeVN2MkRkZUcv?=
 =?utf-8?B?Vi84Vlp1blBZaEQwc3hRRTR6bndJWnJBVkpqZFNVMmVZQnB0VlJaTE9NYkxX?=
 =?utf-8?B?NlpobmVZZW9vUStGL2xPaktKVzlCTzJtMkdxbjUxY1R0QTl0OHRhWkhZYVRu?=
 =?utf-8?B?YjJteXhrdnkrMTB2d1UzU3g1MnpMSWdEbDRzU3M3Ti9pQ29kT0ZQNW0xa2l1?=
 =?utf-8?B?bHUyeWwwSXpKNzR6K1k0eUtIV0NXVGh3R25SRHVLVFp5UUVMd3hYeTU4M0xL?=
 =?utf-8?B?dnplOWI2eVZhOHhQZ3FpUFY0K1JOSGNiK1JmclhEZysrMjlReFpDNG5pK2dE?=
 =?utf-8?B?REhxY2RWd05DNVBXcDB4RmlLTWF6V1ZXY0x5VUk5dWFuaXYxbG5tSEZZSFZs?=
 =?utf-8?B?T3RZSTQzSHB0elo0NVg0S0VsYzE5SklOcjJvSk5rME16WFZNY01GUTlmaFd4?=
 =?utf-8?B?MnJXNndrWW41MHZOU1JKK2s0MTgzZ0paY1kyN2xjeDVhQURWMUdzSXNqVXVN?=
 =?utf-8?B?cHRtWURHZ1gzZzJLREIycGFsRmtNaFNPQ01oL1I0OXpBTFY3ZmNvSXNWSXo2?=
 =?utf-8?B?ZmVwY1R3bTVFREY5Q1FJTlhDb2IvaStqR1JRMTlZSDg1QVdKNkF5VEdJNCs5?=
 =?utf-8?B?VkdtNnNwK2hWU1ZXNlRGZDdlRk43RjU2c0w5L2VlTkpYNWlTNTIvRm5BclZr?=
 =?utf-8?B?L3FpbmY2S3JXc1pOSWxUTVlCWGwyNUNZZllKZSt4UnIrV3FMM2JtUTQxY213?=
 =?utf-8?B?c1J1cHRZSG95UjlSZGtVT2tialpBZmt4OWZsYUltbWZXcjBLK0kvWUI1RkxN?=
 =?utf-8?B?TmtZMFZmUlVydS9tT3hRV2MyT3NTSzhnTTdPNFhZZ2xDeHdWditXd1VrSTZQ?=
 =?utf-8?B?UU1vMWZTejFZR0RuZnpZVzhGUmJiSVhiMEhtMXR0OVNLSVJycWdCbUNpRmpJ?=
 =?utf-8?B?VlpabmRkckt1QjFBajdNdEJDSnB1RnNnL3QxTkJtdjAyQ3lVdEc5d3YvWWpK?=
 =?utf-8?B?MWtRRDZ4SmF5ZHphaDV2azNsVmZESE9VNWJOUmFUUitmYjdOcURvSVEvZDZu?=
 =?utf-8?B?Tnp2ellOZ0g0dFNFVm40aGxGODJ3aDhvNXVEUytlSnQzSWRZNkI3eVpSQlJI?=
 =?utf-8?B?MndDcEZpNUk4MGk4d01EcFBUMmVraU5ybnpML05uM2lmc1BNNk9aT3ltcXVS?=
 =?utf-8?B?NjZ1d0pkckxWWUNST29pY3VNM1VRUmZyaFRFNm5YL2xIVDMxMmlEeHZva0RQ?=
 =?utf-8?B?WkNKU2FsOEZUTUQ0cTFJelViTVdkTEJaekswNjVIcUVqSEtQdHZaMVNMNFVI?=
 =?utf-8?Q?lwgD9S5ZaVSbKCce2W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d125edd-62e4-4672-ce4e-08df3ede768c
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 03:55:30.4034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8cH9RBHwtZIPf64bMkzd6sfDxOKFQNM4fGIVz9Q/+YM7/vumn0DVRhqp+Z/yRLib
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/9/2026 7:17 PM, Krzysztof Kozlowski wrote:
> On Fri, Nov 06, 2026 at 10:39:01PM +0530, Radhey Shyam Pandey wrote:
>> Remove xilinx framebuffer soft IP driver. This IP core relies on Xilinx
>> Platform Studio (XPS) and the ISE Design suite, both of which were
>> discontinued by Xilinx years ago. Furthermore, modern AMD toolchains
>> (Vivado Design Suite and Vitis) provide no support for the legacy PLB
>> (Processor Local Bus) architecture used by these cores. As a result,
>> no new hardware designs can be built using this IP.
>>
>> Nothing in the tree document the driver compatible strings. Given the
>> complete obsolescence of the supporting hardware development tools
>> and the lack of upstream users, remove the dead driver.
>>
>> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>> ---
> 
> You can include here defconfig update.
> 

Thanks for the review. Based on Michal’s suggestion during the internal 
review, I left this out of the current series and plan to send defconfig 
update as a follow-up once this series is applied as it will go through 
his tree.

Thanks,
Radhey

