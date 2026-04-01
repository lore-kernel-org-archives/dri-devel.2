Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2901ED35162
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 11:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C2E810EA26;
	Wed,  1 Apr 2026 11:19:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o1/mH9CQ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012065.outbound.protection.outlook.com
 [40.93.195.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5B7910E39A;
 Wed,  1 Apr 2026 11:19:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Go1KUTdSp254x4zFmBuWTr9bh1Zio+vt6FaZG0VKRdZhijqdwoS0SnuolRjDQ8g3p0ZaQ/BUVQoSIxi0rXujKQp1KfJXbCipWXCUC5AujgOktNDeoxRtup8f14UQI/OvrUauR5MiZzJMw65to7GmGltNYNrVA4pts1bfwb/DHGVVY/ia8nGaMmcg0DSBwo5JwHF92JtcUXBZquqefd2M63x2gUdId09rgw73EFW6im6At2AoO/VE/45f1HrP5dMSm7MqF9UTS2pkfHTFzMUgarT8yCiMvivAb/37pYev8LLo8jjtu+ofEG/HJ60hQDmvW88H/2tLbZt1M5CB7f3Vsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aV0u/2NwQRgdKm2XG3HlG97CwrFO+NrHIfaxIVdjqRc=;
 b=tUZpYXUZvCkdj6QUYy8tWXIFBMbQkzFbWC7ijZ7g+/M+/VwMIA1TSPPVGcmsjhalaEq3J92RDsRhJ+1+GLH835bH+rPc5odcFA7DoWiSkAx5I2svsIiLZKWtYwujss2cEc3a0UBtzmtLynTdWq8eiVCQUDbVPWL76oPLWP5MsRPcrFPvEAJtFBb0SuUyUnRbWAhwJ4SkGTycdWSY8Lh0fNOrOFP5HyNT5/MFGFciE2adNw9b+9ednJ0mQdYP/XvKI4FtMulqXm0GCNqLkjAwyRYh1fM2YT+Fnp8MR+fm2D0HVootiBlhue4qClIQiJ3cQJDeA5VeLyllm4NtYId9Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aV0u/2NwQRgdKm2XG3HlG97CwrFO+NrHIfaxIVdjqRc=;
 b=o1/mH9CQLeQfYQw/i62bHK9pkRV56YS8Qn9w4cd+PCB+VJZIqm29KaJsOrHVLLaMUrHWzSBE4chWVMf796BAVhb7AjBWQuMBwsitKaAlhSXan1x0PUhp3f5FRBcUHHM4bkrNkSIW3zjs4eT1udW66NIn1UkgBUVxlTdKB9lM69o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB6852.namprd12.prod.outlook.com (2603:10b6:303:207::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 11:18:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 11:18:54 +0000
Message-ID: <886eb53c-3a75-4b5a-9418-eb7f863da569@amd.com>
Date: Wed, 1 Apr 2026 13:18:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: use IRQ-safe xarray API for PASID
 management
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: lijo.lazar@amd.com, Eric Huang <jinhuieric.huang@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260401104859.36990-1-mikhail.v.gavrilov@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260401104859.36990-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0305.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: 46b2509b-ca92-4bec-a34c-08de8fe075bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: BtJCizbl3kpufJ/hKygJdctmHPitKLKMhmJauNRVNhfaqWoJ1YqefpDR6+USJh7MJrS9l2kD6gWKyQIGhPCIlPL0xVjUukPT3FQxpbTvWiyTHTnClGak7+DBPIWHGrzlAcAeyWQI7OmJRsCC1bwmv56d4q/dK5NbCaypW1MfPT39eFlmf0dP3YTwr457N3WGU0X0kBLP+JexhG1o4QpgbCD5WOnYM4/KCQPTZJEqlIR8rWR9LLdq+YbCsalVj7MHMXNzu037z7RCjme3K0AQQ/TyQqG/V6t2muAa10yhcC2J66AE0IDA1dhU0qr6jA4oGm48Bxl567J5W/nm8lxqPvxJzwgaf7HNKMppBVrvFpiHndDs5TKV5h74aDFxCVaeMAh7IfiYp7Uteg6unT4ypzEqi+3Z46Vvm1YX+gTTnRpPYdmXLCsXM0kv0t0QgesWfEUBi7k3dfsQT4DPonlKwXerokTkQh24dMMQl9Q1YmEbJjUqeH+/jRI7C+P97qbd38Jd9bvXc4J665mXrppViVwptfQ7hGZAE0Z3NOxP69vB+me+QngAQawnfirEegiA5mGXnF5TknZJ4nqK6A/KOAg/npaeSZoObh5Mq5C21sn77HAqoo5R25J5Vj0rqQ1I0xabDjLBP8tDkY+zn6BFDwf98dozC703xUKyN+qB6dlS4EZ834pRwdNodoxVitshQdAwlDw1uMmbPbJ9845VSxnXlKn09VkZ5UsIH8F4HAo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEVtMVRoYjU4alYrcDYyUy9ReGF6cjdEb3dZRkxRcjNuR0IwNVo1TGdZQVBH?=
 =?utf-8?B?R0h5bzBLQ3NBenJVUWpQUEJtSEJWdmJOdGxabzk0RUttSXU4alBmNE1GOURw?=
 =?utf-8?B?dlo5MjZVSFpVRkllYlZISWd6QWQrT2hEQW03cTJFS0pFcmxvR25JRFg0czg2?=
 =?utf-8?B?ZUc4NUxPdlRLckptMEdyVW1WazR4TVRlK2VmeTd3VzVVWDFUa3J2TnZHTFVP?=
 =?utf-8?B?VXBNaHZ3blE2empaLy90bE02Umphalp4OFRMcThyb3E4NkpDMWUrYTNaelNE?=
 =?utf-8?B?YW9aOGZ3S1pFTzQ0Wkh3Uk1HbmhWRUNmN2RNaUNidXFtNDBNbHRHY2FQZUhL?=
 =?utf-8?B?NkRmekZMdjRZeElQeDgzTGhhODc1aXFVbklyVzczZkduczc1am1sZE1mdVY2?=
 =?utf-8?B?S3MwYUd5bHM2V2pkaEZNL1JrcGlabUtiQlVDRDk3QmZmSmRKd2RENGRrdjBC?=
 =?utf-8?B?RzJobUlCVHF2U0pOVGV1OGVTV2k4bWVnb25ROUZPcjNMRzdBb3ZlOUpBRU42?=
 =?utf-8?B?MnFUb1VqU3RWYWtpdk95V2JiYTBYU0FJZ3dWMnZnY0JTWkxCRTFaQ0V0b2g0?=
 =?utf-8?B?ellNcHB3b2x3cVczUUNxTXVlWlBoUEVmR3ZjdFRMQkNYUk5sTGdhU2c4VFRB?=
 =?utf-8?B?Z2hCWnRYZFhyNE5BR0UycUtFRFQ1aVE5TWtGVWpITXArcU1pTS9PZ29EQTBo?=
 =?utf-8?B?WGNISFkwNzdoK2ZKM3Vsb0tyVTcyS3N6OGhERU5qZzRTS08vVFplaWJxdGwz?=
 =?utf-8?B?OENDMmhibTkwdFo5V0FBa0NSSWh6TUExQWdoN1hlUHAzSXZ6ZE1Fa21ScXA0?=
 =?utf-8?B?eXZEUEVZcVJSMEpGNllXU0pwaUdGWmdQMk1JYWM2SExwL0k1VE9kRFRqRjl6?=
 =?utf-8?B?ZnJoM0YraFNxTTJiby9kY3pSN3VRcGw4d0tSejJkU1ZCcW54enE5Z2cvWTk4?=
 =?utf-8?B?eGpoc3NtQTQ1WDdrRkpRVHhqNDVHUzZZWUVJaXJvVEl5cTNRYlVJVU9DWkc5?=
 =?utf-8?B?ZzdzY1RtTjR4S3YwMk9GUlU2RXdabTVMMUZyei9tcGJ0RVpTUU1pZjFDUndT?=
 =?utf-8?B?clV4YWpqZXRIZXZpRDd6dDhNUmhkRjZ3QzhVSS9UMXEvVGZqSUZPSHhsRTln?=
 =?utf-8?B?VGdwTjhnU1ZKTS9kQkVkSGlRdFlOZ2VnOUt3S3YweFlmbTRsUHRrWk5XOWQ2?=
 =?utf-8?B?eUphaUhncFE1TU1KM3c1eDBnRzVHNHZLRGk4YkF5SUpaZmQwc0YxaDVsaFBp?=
 =?utf-8?B?R2RUdEdmR0J6SDA1SFdqaEFyMVJoQXh4cXdORGNCZS9nVGwxQ3RWcGxyK3BO?=
 =?utf-8?B?OWZVeGoxQ0FVV2NOS28vVUs4YzZQOUI5eS95L01LMHNyV2ZCY0lqVUdYT294?=
 =?utf-8?B?eEx0ZXdsTmlrRGtrcDVxRFBMa0x3TDcvZm5TcFlYdWxqRmJqZkN5NmJlaFFC?=
 =?utf-8?B?UWdSQ0l3aUI3d21PTXhod2xJOWsyMmhwYTBkL3hJTlpIcmcyZ3QrQmZqSHhx?=
 =?utf-8?B?dlliUGg3cGgyQTFESHY0YnhLc1BpZVR4TmZ0ckgyWTkxY1JTV1pLbkhmZU9r?=
 =?utf-8?B?SlM2VTBCUnVKRnlVb3ROSTlkcUoyOFNwWWQ2aFlrdDN0Vnd4cC9nZmVSREI2?=
 =?utf-8?B?dkVxN1llNm1kRExWcllQMWhJY3JkcHMvUnI2ekViUk5ua25GbzhqeThXUHlN?=
 =?utf-8?B?THJEUzNxcXhJV0V4a3NuM2poMTJldGlDNTV6QWxGUkFnaXRIcmFWdmlybGhP?=
 =?utf-8?B?YXRESUt6V2lJOXpPcEZ3NDRrVUQrYmJDOWdpUUtVRmhBL0U0U0JaMkIyYkFj?=
 =?utf-8?B?UGRjNEM4S0JEbmMvTmlLT3YwQUJDSFplekJQMDRFV0hScjJYa1Vad0thVkh4?=
 =?utf-8?B?MkhVQ0EyUTdpVFdOSXNHYUlRYy9LbGl0MXZYWEZDZWtLWkRDZnpsMzFCRXpj?=
 =?utf-8?B?am05TUI0YWU3bWU1a21GajZMeEhMU1E4c2h1NFB5dHJVOHRtalhuaU9vSUI5?=
 =?utf-8?B?cWgrTjBmME1tQmQ3d1g4ZFpCaElYVFl1dzh5M01SZzV3aWVXUjBzdVpaLzUy?=
 =?utf-8?B?c3RuWmxnU0VzL2d6OXZjeTJWT1dqRmxlQWVjWis2SitDQm1hS0h1ZjVaWGlL?=
 =?utf-8?B?VWFTSVp2N05XY1h6UCtsV1RRTHpLcHFBZWVULzhpOWRDY1Z0K0V3WkZhTEVq?=
 =?utf-8?B?NVdTQlA5QWtHZy9qQW9EaTI3QmFBL0Z5Z280bVYxeE5TYmRPOGVRUTh4bHc3?=
 =?utf-8?B?d1k1L205ejE2RzdsMjJCb0szMk56ZWdSNVNVSlJRYTlrQ0tWYlU3WDJzZ2xm?=
 =?utf-8?Q?AYmEWAk9QnlfjbJn/Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b2509b-ca92-4bec-a34c-08de8fe075bf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 11:18:54.5631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/J++zsfHa4Q0IOkiayDEjwuyXMgBFVJH64VIcIdm6KjwmccXOKpcS7PcPvREjhM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6852
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

On 4/1/26 12:48, Mikhail Gavrilov wrote:
> xa_alloc_cyclic() and xa_erase() use plain xa_lock()/xa_unlock()
> regardless of XA_FLAGS_LOCK_IRQ — the flag only affects lockdep
> annotations, not runtime locking.
> 
> Switch amdgpu_pasid_alloc() to xa_alloc_cyclic_irq() which uses
> xa_lock_irq/xa_unlock_irq internally.
> 
> For amdgpu_pasid_free(), use explicit xa_lock_irqsave/__xa_erase/
> xa_unlock_irqrestore since this function can be called from hardirq
> context via amdgpu_pasid_free_cb, where xa_erase_irq()'s
> xa_lock_irq/xa_unlock_irq would prematurely re-enable interrupts.
> 
> Fixes: a3c0ee978e16 ("drm/amdgpu: replace PASID IDR with XArray")
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
> 
> v2: Use xa_lock_irqsave/__xa_erase/xa_unlock_irqrestore for
>     amdgpu_pasid_free() instead of xa_erase_irq(), since it can
>     be called from hardirq context where xa_unlock_irq would
>     prematurely re-enable interrupts. (Christian König)
> v1: https://lore.kernel.org/all/20260401073632.101796-1-mikhail.v.gavrilov@gmail.com/
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index a6ac3b4ce0df..6fc6859d9329 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -68,7 +68,7 @@ int amdgpu_pasid_alloc(unsigned int bits)
>  	if (bits == 0)
>  		return -EINVAL;
>  
> -	r = xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
> +	r = xa_alloc_cyclic_irq(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
>  			    XA_LIMIT(1, (1U << bits) - 1),
>  			    &amdgpu_pasid_xa_next, GFP_KERNEL);
>  	if (r < 0)
> @@ -84,8 +84,19 @@ int amdgpu_pasid_alloc(unsigned int bits)
>   */
>  void amdgpu_pasid_free(u32 pasid)
>  {
> +	unsigned long flags;
> +
>  	trace_amdgpu_pasid_freed(pasid);
> -	xa_erase(&amdgpu_pasid_xa, pasid);
> +
> +	/*
> +	 * Use irqsave because this can be called from IRQ context
> +	 * via amdgpu_pasid_free_cb.  xa_erase_irq() is insufficient
> +	 * as it uses xa_lock_irq which can prematurely re-enable
> +	 * interrupts in hardirq context.
> +	 */

Please drop that comment or at least shorten it quite a bit.

Apart from that looks good to me.

Regards,
Christian.

> +	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
> +	__xa_erase(&amdgpu_pasid_xa, pasid);
> +	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
>  }
>  
>  static void amdgpu_pasid_free_cb(struct dma_fence *fence,

