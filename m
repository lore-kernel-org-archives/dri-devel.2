Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F70BCA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EB631120D2;
	Fri,  9 Oct 2026 11:57:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CFzVlb89";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012002.outbound.protection.outlook.com
 [40.107.200.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2A151120C5
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 11:57:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5GgKyTNreH2laoaFKIlqoFFdw0VU/gapLdtrcbBcBKi4wAq1qqQVE3/vfgJ1UWH/7KJc+EufRnF3WkHmv26sBg1SWuhpycoIW5gHi1afLGUzqiQ5agg55C0VXTuHzCzwEZWsm0HIYK996Ko8lotKLaK/XW0L3J08KiK6o50uxjdIr0kaCubAhoJx5ABKGV4vFSDij+ty9C93ZYOvtxcNZJ1dDf7wp5MI7eExUL9Qpuml6yDrC58xxZ4Xb+TYR2mDF9cYOw6wZSnLCZYNJALqGBF/yarOjOLYfNqcI+RPrpf/CbGodrZ+iONRs/A4nhQu8YauuZZluVWpShUHHJxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSocKVyq4LBtrYy7t0Pgg4n90onWKYw2P5PbuTtAZAo=;
 b=eOaXlPMfStx/E7Fwy8tzsmTpqeRm0LePBF9tFg08ejrUzNBDZJUAumpE1gOWmdlZRI+M5PeaQA71uyXgK1/ENSn9ApFKHfW5/5EP/wgJb44zD1ghBmXTx7z8yPIsAHGruOv0+pMoCJwGccJVlOcBLJkzY+n7M1V4yI+lCOnz7fCepKE5/fCTyTPpNHDBLVlx8dAeSTHy9ZTXOZGR23xcgLkQW4SVE1cvyiUkPJoocx1+DEwSXlGrWm7cQdo4FQNxRY73bBBMvMCVpfeslgMs6I1tAMFMJamR/2uMaa/WxWCBKe6YMMX35ZzvXgQ5ti/tpRjGdVi8+vU03+1Xkgsaeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSocKVyq4LBtrYy7t0Pgg4n90onWKYw2P5PbuTtAZAo=;
 b=CFzVlb89hCNhHe2Cab2IlZ0RVwVOgPnAinsQ5ktf0mBEX5Uvqa5sW/5v0oy2w9fMMhFkAy3sEBTnhm3PWu865sbhZ6tmGy5di7vMmnDXOTBiUVbx/uxFq5FbOrkA/14wDDTt+YtdrH6HccPAxqJA32n9lz8RQHS/P8OItbKKmec=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by LV3PR12MB9355.namprd12.prod.outlook.com (2603:10b6:408:216::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 11:57:27 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 11:57:27 +0000
Message-ID: <f427d07d-cfbd-4d68-b977-2578bc80ae15@amd.com>
Date: Fri, 9 Oct 2026 17:27:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: buddy: Drop the stale @p line from the
 gpu_buddy_print() kernel-doc
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Matthew Auld <matthew.auld@intel.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, dri-devel@lists.freedesktop.org
References: <20260907012125.21209-1-kmehltretter@gmail.com>
 <006076c6-50cc-41e0-9427-f54df628588f@amd.com>
Content-Language: en-US
In-Reply-To: <006076c6-50cc-41e0-9427-f54df628588f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::17) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|LV3PR12MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: a9705ad3-be02-4ca0-8a37-08df25fc7cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|4143699003|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Huo5sYxbWVX01Dsj8n/2G77xKgGiI3Yt+R+7IYoqhs2y+EfjabFWjx2grTOEUPSWkAyEi16FfiKuMPV4CtN5WwRIsQEorLj55kJKVBFwSoTNqRV7+VhOqEEr/10odQrVmZH7XVQD1qG0fF7loFPdPahBXtbuRjbzjigJb1JwSSqMCF2D3Ht31FHeDwbJzfMNqmD+xY0Q9lMwGAm61vu4sKedYCMXP66lnzr5jlzNbQK+aucTLvVdQRokLJFfLfP+Sbb6eqs8FuAMiklN8kIgXVWe9FQBaW+e+SWz28CLzSfc2L6lpVz66zXBva5MSGS0n9eO0ABYbk9aBYxNIJLZrFVKlbvVmHXYGqO7Kg/EDPAOxB3FZoUueRsnWefgEmPEUEUgTmpMe/gxs3iQpTqIQ21hpSXKyd02Wv4kJHSGlXb1QBOmJ4nLl8NUg17P6bh8eZ5CA1C3ml1+kbmPSyGjZWQ79D00TuqPxlbl6yZR1in1OpqiCyTGJwKE4imqBSRnJMochpGsdneF3OqswYgdftGfxvzZ+xoZ9Nk5LbEIe/A9iVJgVcXEuIfPdvU7qp7G3KgBXIm1MhH3WbQzW30F6U9N5M/Hc2hOvm6atY4kU+g12LlxnvCHrhvNyWJTcqcpO1cXtHr+bxnakcKxh/jDeJTx71twA2EX2hHGrSz8z8w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(4143699003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REkraVhGa25Jd2REemJjTGxGd1R1ZmtRZWc4NGVtdTJ4bHV3RjVUaDhTTy9z?=
 =?utf-8?B?V3V6RHFOWVhxV21wMjdnWmZwMGFzcjJQNFhFZ042Mll6ajB5bzVPaDE1Z1hN?=
 =?utf-8?B?UkIvQ2lSQ0dEVVQrQlJXMEswSkJSWG5iZlFCWXZYRVlkSmZsa0tNRFA4Mzcw?=
 =?utf-8?B?NzIrV0NkaWNJQXhIQ0pjc29CczJzdWI4NnNFdy93cmJ2elF2ZGx0QUxtaStP?=
 =?utf-8?B?SmREeGZtaWJvM05iazNnbm1DZVJNbXRQaG5LU0M4QXRyRU9oYXBTaWw5K2xG?=
 =?utf-8?B?dWx1bDYreGpXa3J5UlM4VUE2bSs0dlJLM2FHOFNpTmdwSTZlNGM5aitCMFFN?=
 =?utf-8?B?K3I3c0pTNXlTOTBEQm8reE44Vm54Zmd6ZVJJTlNhVzMzSWppb3VGZkhCdTVu?=
 =?utf-8?B?blJFb2V3S1ErdGFRR3VtKy9iNHlzWjl2YnJRRloxY0lHYzY3M2NPTk1hV250?=
 =?utf-8?B?Ujh5cENxdHcxTjArdU1zbXJSNkx2S3F6bEpUSXByQnFuaWYyRTBwS05XVmJs?=
 =?utf-8?B?MTYydTZLQ29STjlqSmpjRzZuQmpXNzR2L0h2WmlkZjY4d2dWWTE2d1pIWXhr?=
 =?utf-8?B?YnQ3UW1ZYVpRaWNVRmJ1eGM3eVVWbzcyYTNVR0FkZ0VBczQvSW5WVTJKNlZT?=
 =?utf-8?B?aE1Sa2hFNlNpWGRUeWRndGVxQlhwTkZtbGs3UU4yQzZYanJtTDFEUVByNG9T?=
 =?utf-8?B?UUNOZm5YVzNIYTJJRFBZUFl2M05uaXdPZGxIUFpoV3p5OCthU1pZMGN1ZWw0?=
 =?utf-8?B?TmRrS2lNa2owS0tabEJCVlhNSFZMcVd4UUp5ZHNGQkxTTUpMM3ROT3o0dGhS?=
 =?utf-8?B?R3BGc3hjaTdxQ1BuRXNZelBtbFZ1RTFQS2xVWVlOYW56ZWtub1NMOWFncGp5?=
 =?utf-8?B?UTBBWE5PT05WNjM0QnVqRG5VSkw5T1hMdnZQa2gybWQzbTJIbDJPUllHZ0cz?=
 =?utf-8?B?dnZROGhmRnkxTXpnb2UwOHgwcCtFc1BtbW40OTAvcC9aQ2grblRmc211TWFs?=
 =?utf-8?B?SXFnWjdwdjREa3R4YTA1cXFHUDlCc3cxMVVJU2RlczZCdW5aQ2t5Z2EzVDhU?=
 =?utf-8?B?bWQrcXJTOXN5U2U0K0ZuWXp6RTkrSktIaWVudnFDbkxBL0pQL04rcCszdXVp?=
 =?utf-8?B?dFJmKzlaa0hwUUZDOFY2a1A0b0w4RG0rT2NIMjcwa3JVWk0yZTlERTlDWmxp?=
 =?utf-8?B?N2lyaXFZRUFHaWpIODdIREYrUmJ2UVZjU0hkWkQ4Y1FCb2ZYblBuV2hhR0k3?=
 =?utf-8?B?Y0VGSEJpd1d5VFpQa1BQSEYyNGN0VjlKcXY2ZHlMcDVML1U1anAwQW4zUG5J?=
 =?utf-8?B?YTVtcFVLTExHSW5xWExUVlpoQWxEZjhIZHJLZTNnUTEzNjFRUzVhZzg1b1Y3?=
 =?utf-8?B?N2lTemRjTDZ1dzRBakg0S2VZUlVSZXFPaUxKNnpnREpYSTFlR1FzcGdjSWl6?=
 =?utf-8?B?bnlVTHhmK2xaZzIyYWM3cy9tUFNsMUpaZ040TFIwT3BHbHRQL01qWkFOU281?=
 =?utf-8?B?ZC9QT1drWHFSazJvSEsyd2xnTDM3YlhiTUFqTW0zNGEyTjFndXpHMi9aZFNy?=
 =?utf-8?B?S1pZMlhOK2oxUUY2OHozLzBnc2YvVGh3YXU4NzQ1YVZtQXlydWE5TXJ2VWI0?=
 =?utf-8?B?ZlRkVC95TGV5SkRsbm9mQUZlM1hjdDBFNXRhaG4yS2NCT0lQT2VZaHIxaFpa?=
 =?utf-8?B?Qm1nNDluL1duRzNFcEVPWmRKU1luTkNjNXU2OFFMVlZpb2kwNzMwd1RsdUEv?=
 =?utf-8?B?U0N5ejNEZ0lxN1BIUjI0SnhBWE1HWnM4alI3a1djdmtkMHd3TzJwR2UyS05U?=
 =?utf-8?B?Vkc2eTAreUtFSit6WVdvS0FLWEprNE9aTWk3RGs3dWJiR0l3TkE2WFU2TXQ1?=
 =?utf-8?B?RFhCaUdTT1B0YlU2bE5Yc2J5bGNLNUlyYU1sUVp1UmcwYWRNR0xUdVZyeVpV?=
 =?utf-8?B?NGFQSnNHbXlPQWkxOFFIVXIvZ0ZwNklqSUVQRDI4eEl3V2ZTV01naDIyUUxX?=
 =?utf-8?B?cUZUYXU5TDVHbjhyOFlsL2hJOUhYUnpaeHF6MU9zNCsyUk9iREJCUjFFQThk?=
 =?utf-8?B?elNaWElKb0lLZzRpMGtNbHVZdWdWZFpRL2xiMCs0RVVlNkp6T1NTbGxtVWpy?=
 =?utf-8?B?UWlGSXRKaWl2VFp4cUdwRWFrMVBydkRmTXk2MStHbWJpL3Zobzd0YVByYVU2?=
 =?utf-8?B?SzdFRjhuRkZIUmdXdHdoRkthNGJCOGU1UlhFajRDNzU0c0RNRDFRdGp1Vlpi?=
 =?utf-8?B?ZDJiTXJUY3Rqeis4eGtrMUx2aC84Q1Y2VUVUSEoyeGZOWXZFWEF0akZGcCtT?=
 =?utf-8?B?ZUhIUit2SlJ2aFRHRjc0aEluYXRJYlppcWlOdk9FY3ZEOUF1c0pOUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9705ad3-be02-4ca0-8a37-08df25fc7cd4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 11:57:26.9394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7N8xNR4heOAYqOutIbCAhOa+1XU6kO5Km+BFZNIRhdyx+IuBHlFv3KwtGaUTFqXDsKKHSYrI0QgQpUEX0s+eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9355
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

I have merged this patch into drm-misc-next.

Thanks,
Arun.

On 9/9/2026 12:30 PM, Arunpravin Paneer Selvam wrote:
> Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>
> On 9/7/2026 6:51 AM, Karl Mehltretter wrote:
>> gpu_buddy_print() takes only the allocator since commit ba110db8e1bc
>> ("gpu: Move DRM buddy allocator one level up (part two)"), but the
>> kernel-doc still describes a printer argument and kernel-doc warns about
>> the excess parameter on every docs build.
>>
>> Drop the line.
>>
>> Fixes: ba110db8e1bc ("gpu: Move DRM buddy allocator one level up 
>> (part two)")
>> Assisted-by: LLM
>> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
>> ---
>>   drivers/gpu/buddy.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>> index a5553fcec28c..cc993909b79e 100644
>> --- a/drivers/gpu/buddy.c
>> +++ b/drivers/gpu/buddy.c
>> @@ -1591,7 +1591,6 @@ EXPORT_SYMBOL(gpu_buddy_block_print);
>>    * gpu_buddy_print - print allocator state
>>    *
>>    * @mm: GPU buddy manager
>> - * @p: GPU printer to use
>>    */
>>   void gpu_buddy_print(struct gpu_buddy *mm)
>>   {
>

