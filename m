Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C87CD3427
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 17:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A2A710E7D0;
	Mon,  4 May 2026 17:46:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ne+4btdk";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013005.outbound.protection.outlook.com
 [40.93.196.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63DCB10E7CD;
 Mon,  4 May 2026 17:46:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyeXyWqmukpXaCaBi5uyWnpOAo89A5EmNQCdlIY+DsEtdFkhAW6l1yMmwbLO0d2yrjgafv2cp0pAD/tqcXT9MQJCONsuEuZJJMU7c17WpDfASv3ERcybevv+kHFTT3hIms4ma9iFg1wGISchCr9M84KuBL8yhX+F3CU9IriDrnwK4qyTEZ2wDVRv7yWO7ZgqhIkYj4YIoTvK6F/2BbvulmybTSY1/qE05SOIWWXZDBGw57Y8iznreXBZLCOP3YCuOHcDJB5TI4dViz4+RdE9nYRXD7gRS6GjdSZXT/W3sMXwCdRINpdjxjvRD1q+BYq4p4ktK7cE7qfvdOplFo+/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WE5VfAnLKY+5El7njVZydfHq4X62wNEOyhXt5cd1f0w=;
 b=kJNUGuGFhwZkyNv7fqXIe64hxhXKXHLPF173UaswxyH7Ptgum+ug4pMsfuSSKMcZFr/5jIqPFh1qI4N3vh799SWJJMgcii5zRIvq2NZusH1wUl1INKtyxDe9v9RAuvKGfSsDwwd38nvheR0hfsC5OgOuuNTGnOzCFjih/cTkZkSXJFmdmWx00f16st+WH5zubhQDUDKhGvQ2xvnDNPnAlrD9EIfJlJStt8Jh09PSBZZvAQ0jL9db9UlWssFyFVXdhInTHcdS54uz7vgKrjXJEijR+Vhty4YL2pT5+3li9eK/SVGlIc55jbbCUFTOyk3bFGbiwhqUVH5m8rV2MqgAOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WE5VfAnLKY+5El7njVZydfHq4X62wNEOyhXt5cd1f0w=;
 b=ne+4btdkrLGutVb9w20SpXAstaM0PmT1H6QJHui9tgrGplMEWcBLUu1PPSACRnPGG3Udusa5qbv7FEbeLK0HOa3XsXMQ7UNu2gUu97+qOgxVP+0FqioKEY5l3gHRe+wVWtjPaLoXO71wCkLPGgpvfRSvMMtCwh+c27q+/1yCAa0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by PH7PR12MB6441.namprd12.prod.outlook.com (2603:10b6:510:1fb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 17:46:03 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 17:46:03 +0000
Message-ID: <9e14facc-de6f-4e73-a294-e7b197c90854@amd.com>
Date: Mon, 4 May 2026 12:46:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] backlight: expose the current brightness in the
 new kernel API
Content-Language: en-US
To: Louis Chauvet <louis.chauvet@bootlin.com>, dri-devel@lists.freedesktop.org
Cc: harry.wentland@amd.com, Xaver Hugl <xaver.hugl@gmail.com>,
 amd-gfx@lists.freedesktop.org, Marta Lofstedt <marta.lofstedt@intel.com>
References: <20260424220953.167058-1-mario.limonciello@amd.com>
 <20260424220953.167058-3-mario.limonciello@amd.com>
 <58e0de7b-8c1b-4d93-848d-c5afebb678f7@bootlin.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <58e0de7b-8c1b-4d93-848d-c5afebb678f7@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0001.namprd11.prod.outlook.com
 (2603:10b6:806:d3::6) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|PH7PR12MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af6be18-da3e-4394-09ef-08deaa0502b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: /j/wlM52YjFhQ3lq5mdakgZLthRe6vUU95FwanDUIlFBuJqdHEvG3C30ydWzIoYbzcMN0+RVTYIa3jVTMChK3NpG91vfLNdQ3x9vHU8bp6qS+bde/kwkNGazs6wRJsaQazKXcPPY0ToEm/ugJxb+1ff2styQR2hlBVIQI279xYQMC5hVqf5sKunt2EKrkJ2lmtp2D32js4xC5Cw4mnjr93C0aM8qRRENfYj4adRzzb9zITQvDjAXRCf9YF0Ytsa2fSrvjVCi2HY7zKQeYN+j0L0Pw8poCSwYp1NHLdJzHRRTMaXJDQQ04hlGocTnI2rpS99hvEnadLwBSeSUpogOmY0EjHW5ZI5PgYfi+7cplP2y5Ui9zCD7+Vl3357GXb9pIXvkUNPKLNcIjmnr2hYgWFv2o4FUKZxgAqF9eMFhCD8DTHPrG4fcIN0PhOqeARGCwJQ8mtWE3kkE3TVio8T7V/MZL/9vchp/udmBfnzIGh3X5PK8fMvFMbD9+ETd/V06xC3MGH/OGwPgpGnpqLQ3gNNrhF5Rhib95BFkX05BoXjjczQEm+dYq4EL1+xbF5mXOKSpZ2TAEyL1RdOOPIGcnWelLUYM+U4Mge8P31BuS1K5RsTBgSiAcQFS8B7VTklIiUvNguoGYW7wsvYzHrYAv4aC33ZCzNynQK0+vet+1xJEfhBK5VnwD3RvZqyiv29C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGdYNEtyZmROQnU2dWxaanEwU0lGbU9Qa3paMS9vcE1LaHhxUkp4MnFTczQr?=
 =?utf-8?B?OTFHVkF1YlFvTHFpYjBSeGw3aDZnc3Z5blZvYlRESXA5OTJsNVJJdDJkL21I?=
 =?utf-8?B?ZEMwWW9sRm5FRk5pKzUxOHdOSlRyVjVPL1NONVAwL1pTVXNwbWZUSWhDamYv?=
 =?utf-8?B?STQrRFltWTFENVJtWnB1QTRkcHZQMytRcGsyMlkzMk9XNmpPODU2WUpkRCtr?=
 =?utf-8?B?c1VwK25RRm9EWGEyNndUTWYrZ0ZKeWhudjNiWTJPbXcxTXFWTE1lVHBiWWNO?=
 =?utf-8?B?eW5oekpraGJLdnVwdHRhcDl1b0RqRDVYOGVyeEhSejk3czA4NHVjSmJrWW5K?=
 =?utf-8?B?bjlGWTBTdndQOWthbTZ3cm5VYzZMYnZONmRCdC9iOUpFelpUeVc2enU0UzZ2?=
 =?utf-8?B?QVNXT1dqRDh2QlJlaXNlQ1F6VnFJU0lxVjNBTGZhYklKWVA3akhjblUrYjZU?=
 =?utf-8?B?d2NuVktndkt0OFMzZmdaWGQ1d01HQmxPQS9zak82TE5KWEQ2SDFRNnlnNmhG?=
 =?utf-8?B?U09yQ1FPMUVHWVJPdzU1bWlWanJDUUxneUNHZnZzdm5GcHBaR28zYTRTSXRm?=
 =?utf-8?B?L3hmUW5BalFDWHhETGJoY3NrV0p0V0x0d1loeWR4N1pibXhyNEdDUEZFTlJy?=
 =?utf-8?B?SDBVRnQrSThndUQxV2p4SWRGRTJjZ0R0VWgxdnNiVzEweTdsSm9nOERVRENp?=
 =?utf-8?B?bzVyNXM1NGl4YS93NXV4dDlmY2NrOUoxSnpKbG54OG9kQ1EvcXUvaU4yK0V1?=
 =?utf-8?B?eEVtUUszaFpsK2ovYU5zQyszeGM5cHdvTU0ydUs0YzFKTnFhVnhxMU1zZnVp?=
 =?utf-8?B?V1RaanlaaWQvakFsbHNlNXVXRW5lZTNUOGd3Wlh2TjVjOHJqVUNtOFAzWTlj?=
 =?utf-8?B?TXZTQ3RwcURoNTBidEdwOFJNTmxBeWZxbkQ1VkVMdnZaNitJYW80TitUTXpO?=
 =?utf-8?B?UkYya2ZOQ1U5M0tXa2dkNVlVWDFnN2c5WEdnQ2hTdXZEL3VoM3ZuNVFsWXFM?=
 =?utf-8?B?UVhRdmkvNlExRzR2d2I5MDhkZ3orMTd5dzJHREJpNjZlNS9rUW01aXdPTlRT?=
 =?utf-8?B?aDJxT3BZaGJPNDRJQzRjNFRhOHM3QTBFNkdiRXVxb1pKTEV4Q0VYbHhQc3Bm?=
 =?utf-8?B?Wjd1VjNYN1UrcFh4bTRnZnltVkVsVEJQT3kxOVpFYW1RNEU4QUZiT0Z0Sm1K?=
 =?utf-8?B?MWllVm83aGFXOWpsbmhnRzZPdDUrRXBhZXdaWnRycnFvNDdvOHg2UWJiZUQr?=
 =?utf-8?B?bFUzWlFNYjJ1aklSMUtyY1JVd3FadUlzRVFRVWlFRE9IOGhkdTlTV21SOFlI?=
 =?utf-8?B?SmZwYlNoampVOVNaeE1ISUFsaWIxb24yNm9wcSt2VFdmaXhLU001Qzl1bVEx?=
 =?utf-8?B?L3J1d3lmNDdQa3kxZ051UVdEU2QrREhHVG1Ib001TmdwY2tqM3NpRjhVa3dl?=
 =?utf-8?B?Z0o0d0RwYnAzRHkvbnZ0ZnZJOVdoK2xRVEp0Q05NUHlXYlpFUkEwVGVXN21B?=
 =?utf-8?B?aXdpdVVrdTdUWXlBRmZlMVNKVWVrc0JvMWZPS2tjbzIxR1JWN01FQUcvK1cw?=
 =?utf-8?B?T1ZTdmtxUVRPNWlRWXQyQU9MNTZwOWlFeHMwdWI2WkpmdC9BRHlLWDcwV2Zh?=
 =?utf-8?B?a0FmUFM0WjRlVW9hVmM4V2RFQ3h0U080djl6Q3VlNXA2TVc4dFM2OXJUQkpv?=
 =?utf-8?B?N2ZMcCtvdEkySE5HU0dJOWVDelZ2VVFTY0Y5WmMxb3NqYzFrc2lTaE91dkJY?=
 =?utf-8?B?NGkrRUZGQVB3WGo2TkdJSlJSNXFmTGI4dEdLS2U2QnFreFU0NXFrWEloWkV6?=
 =?utf-8?B?RUVOOHlzZkxRM3kwV29XdkplTktZQUszd0hsREVaKzY0a2VNekRERjR3SXg3?=
 =?utf-8?B?RnJZN3VVRUN3U1g5WVkweitXOFh2MkxDd0FDVGVRYmZWRnVqK0lUTWJ3VG4r?=
 =?utf-8?B?TzZvdkhCOSs1MUdXSFlPK2NjM0NPRS9hSnN5WXYvWjQwTGJ3TlE4UTlDYVV6?=
 =?utf-8?B?enNkZU9BbnVFOXVJUUtFWXlqSFBJRnhyWjBURTVrNytRVUpRNnpVTGg2ZGNN?=
 =?utf-8?B?TDJNeGRGZVhhaTdBQVNQaDArNVJadXZGTmJtSzJnWmpwM0RGS1hQbXVIblEv?=
 =?utf-8?B?QVVHSTJLVFBxYWtNNXlnU1o3L0V6NGNKOXpld08wOE92eFhseHBkMDA1aVY2?=
 =?utf-8?B?Z2FxN1E3dFNFbGEyYkYwWDBGTmdvZ3RZdzEySEN0dldpdC96ZlBOTDV5Sk02?=
 =?utf-8?B?eW9RU1lWb0ZUdFFxdkN4MWJEaHVNdEdDenlDdDNsWmZPOWRhbDNoQXZha2d6?=
 =?utf-8?Q?gEVtnUGAo5Jzfgh6sD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af6be18-da3e-4394-09ef-08deaa0502b6
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 17:46:03.2711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FV7PgLZOalv4ly1Slsa/k0y2E1vWFNsGXA5DlVKqWtTYURi+0T1JNwE9Z0jNDOSv3VpTslbVn/UAeHBDib7p6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6441
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



On 5/4/26 08:55, Louis Chauvet wrote:
> [You don't often get email from louis.chauvet@bootlin.com. Learn why 
> this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On 4/25/26 00:09, Mario Limonciello wrote:
>> From: Marta Lofstedt <marta.lofstedt@intel.com>
>>
>> Current brightness needs to be queried from drivers.
>>
>> Signed-off-by: Marta Lofstedt <marta.lofstedt@intel.com>
>> v3:
>>   * Rebase
>>   * Add description
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/video/backlight/backlight.c | 6 ++++++
>>   include/linux/backlight.h           | 1 +
>>   2 files changed, 7 insertions(+)
>>
>> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/ 
>> backlight/backlight.c
>> index c3673bee6d9cf..9bbfc16cf2d74 100644
>> --- a/drivers/video/backlight/backlight.c
>> +++ b/drivers/video/backlight/backlight.c
>> @@ -206,6 +206,12 @@ int backlight_device_set_brightness(struct 
>> backlight_device *bd,
>>   }
>>   EXPORT_SYMBOL(backlight_device_set_brightness);
>>
>> +int backlight_device_get_brightness(struct backlight_device *bd)
>> +{
>> +     return bd->props.brightness;
> 
> Hello,
> 
> The function backlight_get_brightness already exists and is already
> public, maybe you can use the existing function?
> 

Thanks for the suggestion.  I'll have a try with this.

> 
>> +}
>> +EXPORT_SYMBOL(backlight_device_get_brightness);
>> +
>>   static ssize_t brightness_store(struct device *dev,
>>               struct device_attribute *attr, const char *buf, size_t 
>> count)
>>   {
>> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
>> index 7e4fee65fddd9..851570b39d041 100644
>> --- a/include/linux/backlight.h
>> +++ b/include/linux/backlight.h
>> @@ -412,6 +412,7 @@ struct backlight_device 
>> *backlight_device_get_by_name(const char *name);
>>   struct backlight_device *backlight_device_get_by_type(enum 
>> backlight_type type);
>>   int backlight_device_set_brightness(struct backlight_device *bd,
>>                                   unsigned long brightness);
>> +extern int backlight_device_get_brightness(struct backlight_device *bd);
>>
>>   #if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
>>   void backlight_notify_blank(struct backlight_device *bd,
> 

