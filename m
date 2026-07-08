Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FD9C44503
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E84710F1E0;
	Wed,  8 Jul 2026 16:35:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Laq8z0j";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013037.outbound.protection.outlook.com
 [40.93.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3B9B10F1F7;
 Wed,  8 Jul 2026 16:35:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOPOWx2UJDYiO0C+DfUjIJDdOb1+iq1h3syeV2cVR7D0p7GTEWOP1n4CIbaEX4H3dvPA+e8bqHIUQDOrqTkNRZGcB/1qnNHVEMqPLUhrrb47wianRGmvsGYMa5S9LfiqkQdw3VgUEfyzLIMrWf0LZPAO/XMId33Q7BgFCLBPCkYxiVEemov0jtYKY0FyMnyxDbrlB6WpYBpoewiadRA9ue8nuLfUKLC06NSx0Wkp3lSsqdrtq6HKQDmHVljVxzX7es1XJMYHseNnDzgl8WkuAvD06Ps9JFCddK+fotCpmS7YxXgCwuLzvhGcXMkhnzlJMGntxAVfPf9fz8z/mF50YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXB9M5vWnYDsxeNmhLwmd8bkSivTLSKmLjA/QIdtoIY=;
 b=B7ZFMW2bpZZ45IN/HDWe3FZZwW5QrJiIrWuFTRKFflrPzUZOOS+QttcloYaAX4vPxVB8Sng0R9oeC9V97mYBW/hwEVCFTM1odXj6NqQ7AWCGrZq1Q3hYm5ORQ27WzQ9F36Gg/Z8o8mo+L9I5GsMwh+RUZXP9+xyr8amAWTjAEjMVDb6Ka+E4R2uBndA6X3DlQ2G9QD2JruZWiz6Lk1855zOuPF7LLE8o47s/UwOeOkoDjQBnl+01gYLGz+R3u9N2LGy3o9L406EdS+T6OZmF/XRJwM1ZJjhHKkFAsx++oHIGvCAXCTnaaqZ3jRAfXXPfKru1EJP8BkzJiv0eyhuGcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXB9M5vWnYDsxeNmhLwmd8bkSivTLSKmLjA/QIdtoIY=;
 b=3Laq8z0jj1Frqq3XQa7AhYW81JpOkDhaR43NXoRO39DbDbAeHN0x5EimdHGMBf3saxWn6Muomhzln1BF4fNHC8Np2q+DPOulQeG+L3ec8J4hPURqzNrdSZA75qEsnEGnj7EposqZXp28hSkRNgrqvO/aVjGpXvdVpYJrwr6Frzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 16:35:40 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74%3]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 16:35:38 +0000
Content-Type: multipart/alternative;
 boundary="------------a6Q0JT9boBw70eh09QDt0i1t"
Message-ID: <9229f48a-83da-4631-b07d-f2253545ced0@amd.com>
Date: Wed, 8 Jul 2026 12:35:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: free MQD managers on DQM init failures
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Oak Zeng <Oak.Zeng@amd.com>, Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260708105115.746474-1-lgs201920130244@gmail.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <20260708105115.746474-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: MN2PR18CA0005.namprd18.prod.outlook.com
 (2603:10b6:208:23c::10) To BL3PR12MB6425.namprd12.prod.outlook.com
 (2603:10b6:208:3b4::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6425:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 97ba5dbb-6df3-4c74-470c-08dedd0ef0c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|56012099006|11063799006|6133799003|22082099003|18002099003|8096899003|921020;
X-Microsoft-Antispam-Message-Info: w9GV0vEqfDKslXazqnxW8JZPIpTrq3rL7UmjXQkWzXxqCqg2DhestT4RadIYBv+r3xSM4ALyrpm/V2jNPILfA5fMTaaVz06ilRbgiauuNd3mKEbus1j65P5+peJgg5KdCh88g4bXdUKrVf7krSWz1XLd8aPne0gaWz4VPo2HNiIJlMvZOPJ4rSUU7z+AUhlzCWuh2JJae6cnCqpoYrLimR59djFWtJPIZB1j3XP1vWmnbRryX2WiNeRVb9WMcErmEuyqNZp9xX/CWGXye3DSfjAOKldZD71hkqeR7QSNEex8ilVRDc7MEcwPDpBf9MsX/PgAH0cCoCGGt5VaJxPswsQhNeiYAK9nQw69n3in6CXheUY++4X9ui9t0Ido0pomm2btTqkWnrx5lhWoR//jD5pN3lzDHz3iOn+/+c5VxY9SM/KFkHNZCPi4dvbbqlrzTH3Bnt6WLQpVyYbpXoFRICNSr4isOwfzRMtA1aKY9Xi5kg2X/AUzRDD8+Musg/TrdN1+5D0Hg2yIly+0Usjfco5EfE3CanavIYIBuCbMSrEeAbHRyWANHoW1xsVtQ/FlrE1BKUYoERbuazd8su7E87NY/FPhHE0W53d2JOmBC442P9kscgmybHj31mkujYWgMzxyG4Q6ZFWyU3j7DBCVR8bXX3tz/yiok19+lyrEU7H4ARnZSluwy9St+zhWBCt3lghlbg8MpjB6lBc7jnyhYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(8096899003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NisydVBVekxpNTZyUlF1SEgwaDlEOE9IZVQ0eERWcEtwbC9YeDk1aDdIMHRX?=
 =?utf-8?B?OWQxamVUUVlmcm9HRXVSMDZkZUJSakZEWm1VWkc2K2JES0pXTEdzcDY0K2pX?=
 =?utf-8?B?NXlmSG9XSWVhNThNbURYOG8vTDQ1cENITmhDMTZBK01hQjZxaFR5eU1wNnFR?=
 =?utf-8?B?cTUzSVZrR2NsK0NqbWRwZnUzOW4rOE1lWVlqTnhwUWlhVVR0NWhwOU5jU25k?=
 =?utf-8?B?bDdzUWMvYS9hOXVSZFFXbGY4bmF1UzdId2ZCNVo3OUNmTFYyR295amh6TGc2?=
 =?utf-8?B?cnVSOHlFNEdqOUp2empsWXJHN1F4VDdyVHh5VXZnVk0zM2lNK0JQUlp4anhn?=
 =?utf-8?B?aDFBTHhnZktpSDI3REwrZENjZDNraWlyK1BZOFJLVTFLc2VIVzNwc1Y3OWxL?=
 =?utf-8?B?RFJScXJEVHdKR0NjTHZwa3ZDSnhHSmNYQ085ZUpaSVVLZk8xMzJVY1RXRXIw?=
 =?utf-8?B?cUZ5WmcrUkpRZ1grQzV6V0Z3WUlhZkNyeDZHQ1lUSzRLMGRvZlBXQVVtMEpD?=
 =?utf-8?B?b28rSm1YdEhTNS9XWG5iaTBRcUFPaFRZb3l6aVI4VWNoNlBLempNYzVmNHVS?=
 =?utf-8?B?ZDRwbndIU0t4VGl6bGFEb0ZTbHJkNlZDVFVId3pzK25QS0xGQkN1YjdmQjdm?=
 =?utf-8?B?U2JKNzJkMzdKbVkvaHRCbE10WkdMbmZUcnVmazBuSm1IN2YzcmJhNElkOFk5?=
 =?utf-8?B?NGtOTUsvekcrTWVLQVZjRENyWUtGK2cvOSthbG8rdHBrLzNPOURJUGZmaDh4?=
 =?utf-8?B?YVdVV1RaVzFNWnRvY2M0Z3RvLzlVWGlvN3dHeDdJd2JtcXBMQTZFTW1ZQlA4?=
 =?utf-8?B?MWFEMVpNSkNhOGZONTVoVEVBa2xVRVNoWUdUNm5sN08xb08xRnV6ZExOMFV2?=
 =?utf-8?B?emVWdVdNRkNTWmlWTDk3d1JMUXMwU2ZHSVdWeG43OUVyaU5NWFNkdUQyS0pa?=
 =?utf-8?B?RitBQzlnYTdWZEI2MnhxQ2YwaTUwS3lLaHNCd2QwKzhxUlhBYlRNN2lDWGUy?=
 =?utf-8?B?VkV4bXMyR3l3UWJXZnNWM2p0aGJaV2w4S2hvR012MCtxenZobzhvd0JsWDFi?=
 =?utf-8?B?OHMvMk5mQWhBQTEyZi9HWHJsM0dHS0FzV3BESjN1V0hxQURYY1BQbEZEcWdx?=
 =?utf-8?B?bHExc0xsd0xiSTBWa0lLYmFTNTFpSmhQWGlTQ0dGZmkrMHJoMkhtTDNKUC95?=
 =?utf-8?B?ODltQ250d0NYVnNoQTZvWnhRUjBCanJMRTZsUWJlbWxOZ0RPZnFMazFtUTlL?=
 =?utf-8?B?RmI3TFdGZFhlSGFkd1E2QTVleUpXVy9rKzhvakN1VXM3S1lUZHVxcnR2WFpR?=
 =?utf-8?B?TEF5RUg5c1RsTksxZDc4WE1wbWd4ZkFFc3BrNmpBY20rK1dnK3BsVjBhbE4y?=
 =?utf-8?B?NG1CbXpmREpXaHVqd245c0hzejk5UUlraXRBN2ljY0xtN2RJdThtQnVyK1pw?=
 =?utf-8?B?WWkrc3pSejNtVFRJelBtSVROM3NVVjNEelhEYTE2M1BhcitnRkhid1dpTW82?=
 =?utf-8?B?TXNSZjBwRjJKSXdPOWR4dVZXSW52UUpHNDFPSDFXMjNCSHhUQlUrVmZmWXYv?=
 =?utf-8?B?TWhQYWx2a29KUW8yMm9ieFJEZUhYNkk0OHhabUU2SzBRSDZYOElrQmo1VGJ2?=
 =?utf-8?B?TDk0bXVidERjd0Q4aTZXcG1BeEhvOFUzU0ZpZjBScU8yWFpQdkRRTXMvWGtx?=
 =?utf-8?B?VUZmU3VjN0w5K0VmWmRielhCVzdvdGc5NjNnekVSUnZKODdXUmpXcnRiY25H?=
 =?utf-8?B?bnpabUtGejB3bHc5L1ZjWFRCT3lFb2diTU0rUm84U1YvTVk4SzBDTjRNSnNT?=
 =?utf-8?B?T1YvQTViLzZGMmFPa1VwNDZ1dkVjZXhiN01rdVdzYThwbGhrT0RPYm1Mc0ND?=
 =?utf-8?B?TFVUUE9MK0pFaDBJb1BYc2JRSDc5ajgweTkzR0poYXJGOHRPeURIQWJ3RXR1?=
 =?utf-8?B?OS9JWG9MTmIzVVZmeFI3WDhzU0hMT3RBejQwcUFLdDBuOGJRUmtCTWQvZUR4?=
 =?utf-8?B?eXNTVERzcWlMNDRlNCtFclVqUysydmhJd1dVd3VFanQwaVBYUHV5ZXFnUUJv?=
 =?utf-8?B?TG0zbW5FUHBIemNoWWk2SGM2c2FZdjJHaXI3TjJodmZsK25tN1ExYzdFOHRX?=
 =?utf-8?B?ekF4eHVOTm1XRXpwVEpFaE1xaGFsdkVaZ2E0KzJDM1ZxVTd0VWxhNUFEZ2Uz?=
 =?utf-8?B?eEpVWXNGcG5FTHlCS0NkelRBNVd3T2M3YytWN2NGQTRtWUJWdUU4NkhJM3hD?=
 =?utf-8?B?TysxOGJ6WHRLNzNOWmN2dEJ4UDlPOTFhS0Zza25rRFVLMXZJaFZWamhUd3h0?=
 =?utf-8?B?TnBTV3JOUC9kK1gycGczd3I0TGJLQm9vY2N2SGhJQWxqOVdyK3Njdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ba5dbb-6df3-4c74-470c-08dedd0ef0c4
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 16:35:37.6345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewzhuIgWz/LUbyOIaDIlJqofFZjHuH4jE16Wu556ckPC0HAlcdVBL8wQdfYyuNYyoKA9duwOKH0T8wOOisOLFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598
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

--------------a6Q0JT9boBw70eh09QDt0i1t
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/8/2026 6:51 AM, Guangshuo Li wrote:
> The change referenced by the Fixes tag releases the HIQ SDMA MQD trunk
> buffer when device_queue_manager_init() fails after it has been
> allocated.
>
> However, the same failure path can also be reached after
> init_mqd_managers() has succeeded. At that point dqm->mqd_mgrs[] contains
> per-type MQD manager objects owned by the device queue manager. The
> normal teardown path frees those objects from uninitialize(), but the
> initialization error path only frees dqm itself.
>
> Free the MQD managers from the initialization error path as well. This is
> safe for earlier failures because dqm is zeroed when allocated and
> init_mqd_managers() clears the entries it rolls back internally.
>
> Fixes: b7cccc8286bb ("drm/amdkfd: fix a memory leak in device_queue_manager_init()")
> Signed-off-by: Guangshuo Li<lgs201920130244@gmail.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 2e010c1f8828..be75fd3a9acc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -3103,6 +3103,7 @@ static void deallocate_hiq_sdma_mqd(struct kfd_node *dev,
>   struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
>   {
>   	struct device_queue_manager *dqm;
> +	int i;
>   
>   	pr_debug("Loading device queue manager\n");
>   
> @@ -3231,6 +3232,9 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
>   		deallocate_hiq_sdma_mqd(dev, &dqm->hiq_sdma_mqd);
>   
>   out_free:
> +	for (i = 0; i < KFD_MQD_TYPE_MAX; i++)
> +		kfree(dqm->mqd_mgrs[i]);
> +
>   	kfree(dqm);
>   	return NULL;
>   }
--------------a6Q0JT9boBw70eh09QDt0i1t
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 7/8/2026 6:51 AM, Guangshuo Li
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260708105115.746474-1-lgs201920130244@gmail.com">
      <pre wrap="" class="moz-quote-pre">The change referenced by the Fixes tag releases the HIQ SDMA MQD trunk
buffer when device_queue_manager_init() fails after it has been
allocated.

However, the same failure path can also be reached after
init_mqd_managers() has succeeded. At that point dqm-&gt;mqd_mgrs[] contains
per-type MQD manager objects owned by the device queue manager. The
normal teardown path frees those objects from uninitialize(), but the
initialization error path only frees dqm itself.

Free the MQD managers from the initialization error path as well. This is
safe for earlier failures because dqm is zeroed when allocated and
init_mqd_managers() clears the entries it rolls back internally.

Fixes: b7cccc8286bb (&quot;drm/amdkfd: fix a memory leak in device_queue_manager_init()&quot;)
Signed-off-by: Guangshuo Li <a class="moz-txt-link-rfc2396E" href="mailto:lgs201920130244@gmail.com">&lt;lgs201920130244@gmail.com&gt;</a></pre>
    </blockquote>
    <font face="monospace">Reviewed-by: Mukul Joshi
      <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com">&lt;mukul.joshi@amd.com&gt;</a></font>
    <blockquote type="cite" cite="mid:20260708105115.746474-1-lgs201920130244@gmail.com">
      <pre wrap="" class="moz-quote-pre">
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 2e010c1f8828..be75fd3a9acc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3103,6 +3103,7 @@ static void deallocate_hiq_sdma_mqd(struct kfd_node *dev,
 struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 {
 	struct device_queue_manager *dqm;
+	int i;
 
 	pr_debug(&quot;Loading device queue manager\n&quot;);
 
@@ -3231,6 +3232,9 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 		deallocate_hiq_sdma_mqd(dev, &amp;dqm-&gt;hiq_sdma_mqd);
 
 out_free:
+	for (i = 0; i &lt; KFD_MQD_TYPE_MAX; i++)
+		kfree(dqm-&gt;mqd_mgrs[i]);
+
 	kfree(dqm);
 	return NULL;
 }
</pre>
    </blockquote>
  </body>
</html>

--------------a6Q0JT9boBw70eh09QDt0i1t--
