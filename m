Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9A1CCA490
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B97710E360;
	Fri, 16 Oct 2026 16:39:13 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011037.outbound.protection.outlook.com [52.101.57.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06A2410E360;
 Fri, 16 Oct 2026 16:39:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nri9RkFL/aAA8f1o3dPcJwutUOyN5+3ggYCwMavC6wTvPzkbdbpiTZ9TaUqR9ZMYGLFNoh6MivYl5bKU7fvFn8+71orUyzZPo4aQxYUDiJF7JDSGk0RbOXTNLnxpBg92v32qM5vAWLGqEo1SuwBi7Iw8K+ZpqSzn6PfbkrxNnd1f7bu1c5t2nJGlhScqDOw8I512rLfB21RJ88nHlv6t/ltbx9wNdeH/tXgv7E2e/5uf3nLiNgzCPN0m5wNBbPnXzJrlSTGlKxPur6Wbt43A9h/AN/dyIBspUvR8hVKp2StwZt/OqS6SxCf0DM6lzz0YCBWZmc3s6PtIRo98AQL7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGtqHPPKPE2byPtogaBl7v1hbXijvaMcZqT6mdOMOEw=;
 b=dNIabEvzD3+FX8FqsdE1LwBi/w6IR+MF3m6ZSmf9Q6CQXTnLOV1wjeIYrPr8jGoU9BUQMr15xid2Jk4Unp+HIeO5i0jRl6PXKqvmGAB9wKMQKK5VMMtsK5H1shHSEi/UXUtJe9nw2Zwe//HJQeWce6C9NbGhhjFF/lW19jZmVHlXqpDKUnIOnLHu4qyLxZlYITKt8rI8xy/uHrZ/FPpPxi3zPDl0HlGqVQ2H6VEZClA0nqIASHjHbtxT0TyA2qEHMDe4G+0sgwBGOpfv59nBKbjLQ8nWqL9XXTKU4DyWOVPVYhsoYsRjXA5UDjmOXRSPzqUuOLy5bF1Uqq9JI+htMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGtqHPPKPE2byPtogaBl7v1hbXijvaMcZqT6mdOMOEw=;
 b=nUVV365PXAdY/gASD6JH/l34B5gLvoNoMmP1i/Z2/xlhmWGeO6ldno2F+h7uSPOcu7ijdMlvxabYAj9+UFGu1x+elJcP/ikslgTiO2XSOFrDpg7ERAvUnUIhrSw5bcbzf7RnV5woskgnHI1hEH1nNMFAg0gdnZDpcp20AVyzxkw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 16:39:02 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 16:39:02 +0000
Message-ID: <38cc515d-ae4b-4031-a061-224d492826e1@amd.com>
Date: Fri, 16 Oct 2026 10:39:00 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix NULL deref when opening a closed DDC
To: Arthur Liberman <arthur_liberman@hotmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "harry.wentland@amd.com" <harry.wentland@amd.com>,
 "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
 "siqueira@igalia.com" <siqueira@igalia.com>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>
References: <DB9PR03MB73881C96FE86D964037ABEDB8A942@DB9PR03MB7388.eurprd03.prod.outlook.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <DB9PR03MB73881C96FE86D964037ABEDB8A942@DB9PR03MB7388.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:303:8d::11) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DSVPR12MB999171:EE_
X-MS-Office365-Filtering-Correlation-Id: ff057e37-ebee-4e50-9ff3-08df2ba3fc08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|56012099006|11063799006|261009223027099003|10067099003|22082099003|18092099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: Dl/8P5ECA76f+aNMxvJ9DBs34NUC8eZ6z6BG2Oc8yKIhpHdx5roW02SJ2Se+Ozg9j4QPYlhN6zqwNW3vNN7ZP7hUKcDF3m8r9rU1xGX6xKEWnxPYcyNFE7Uh+gDqJ4NJs2sl2ordYBLOey14e4kGC7GlKc9ngk7ALBL1yTdWo2Z7P5gY3yeV4Vu+MSqXVYRZUbM26/4h8XnVTrP4uHQs1dJw5uQ4JhcquBQLsDpkQM9v0GslClxuSiIj6xfvRJyTB4dzfIBPgb8tAo61NicFpQfqaTr1GKLst0nPGpT7uvwG4fvzdXTpGYfpUbNE71qtDwhfv7KSnw66IrfuWrfNImJ6vA2YG/9laDJAWfGQgtXou7vj9cDrqdhK+jmZJqFu+HuRdzaTYIQ1bHZpXE+xa8lqshaudKtRGJiGz2BQdNccBIigeTsyY/IavBX8Oy8KLFsTHA77kz1HM174Lt18oQarIAueIhpe5mcrqOi8kvTCbeWeIOdVy9CStbE+9446EV3zMT/ONNB51amQGZPyobUYJz7CgocC4iVpJS8l16ftMQNayrC1ks6gsmXjI8BDsV0uhweX2ZEDn/YZ+/CzRhNGTm0dEIIwGDsyT8PzbT/dQyCcTt4ReU+6JemFzS/l8l4gYQNoyAXHcSi3SyAGrIlmHGmvgrcVsCTsFBOdRz8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18092099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnFBa2x2MW5aOHlRTG53bHRteS9zaFFIU3VoMFpGZnRGU1h0WGJ2M2x2YkRW?=
 =?utf-8?B?Nkw1dkk1ZCtVMjh0VktRa0VLMG0wK2x1a29LV0h1Z3l0OWdTRXNvZ0NGLzZS?=
 =?utf-8?B?SDVNcDlEYUwyTnppRU5kM2I2TmtjOWY4TWt3OTh0VDZaRzh3Z3BYQjlXYzZk?=
 =?utf-8?B?NUlNcnlhd1B5eFhXcDNncklqdkd1NXNGSkJoSWE3Vm1sUVd6SGtjUkNuWktZ?=
 =?utf-8?B?YmtERnlDQ3BlL0dTaHFWd0hGNGFtYkt0NG5wWkkrN01sUzRqbnZEa21zZCty?=
 =?utf-8?B?Rk1pVnFHdEVadXQ2OWZ4dnJFUUNEVlZ5akxpZVJlaHZwQkJtQlRlbm0vWXZM?=
 =?utf-8?B?SGlvekhnaTFSMU1vcDZJWTFNWHY1WWFzb0thSXV6MXRMS3h4ZmEwL1ZmWnNv?=
 =?utf-8?B?bmM0RGtHbXdqdGFaS0sxbU1NN2pOVlF0VndCSXRxZGxyUXVPSitOT2tPM3Zn?=
 =?utf-8?B?VUJGdU0xbGgxbHRoK2syWEhjN2I0bThobmVHV2FzMUcwekEvUE9JbnpWc1Fy?=
 =?utf-8?B?bkV0RS9FV3hnZmZXcXJ6MGFDVTBrcG9DUjZzMWNSNmUxbEFibkpTUDRKbnpG?=
 =?utf-8?B?dCtYZy9KeXc5M0xRNmtGaXp1VUJhb0Iyb2Yvc29TYnQwT3I2cWRiVWtma1Ro?=
 =?utf-8?B?SEFqcDhsbm1LZVEwRXZWVXJjQ2xZaVgzRDlqVlVmQXZ5TUxNNjZjb2ZQMU9Y?=
 =?utf-8?B?L3c1ZHlnR25PY3lqZE9obWRoZzdkaDg5RDhoY3JZMm9BM3Zacm9vcTc1enF0?=
 =?utf-8?B?bzBnaHczdFduUm9VaXJQeG1pMEVwM0hJRWFuSFpxRjRFZGJpc1pvNlNOTG1D?=
 =?utf-8?B?dW95QmsxWFMxR0NsVStOS0pQcGNXNER0bU5tRVVMeVd0ZlVHNm9IVzVHTkRs?=
 =?utf-8?B?c3pDRTY0ZkRWd01IVlN5LzVvcFhUZ0VGRWFKc0pBVktXQmhzQXBBZ3MvSjNL?=
 =?utf-8?B?WXVnYXJOTDB2U0ZQTitObm1MZUM5MHNwNzJWdDdDMDMweWRFYjlTUnZYNG1o?=
 =?utf-8?B?Tzh3ckprS3NlMkhwWlU1NVZZckdWZmtUNjAwVGdXdDlNdVN4QVBpN3p0QmxM?=
 =?utf-8?B?SWtNWGhTWTY1STNSTUVMNUx0K2FjSk9MTGMwZ004dE0wR04xbTlVZm5JZ3d2?=
 =?utf-8?B?UjZZT3RUTWxRSDN0dlgrODFjZ05yZGV1bDJkTSs1ZkhmMXVGT2lZTDdZdWtq?=
 =?utf-8?B?bCtHdGkzS0F5dlJkdzdhV09NclUybkpFdHRmNE91R2hidC9SL080a1lwMnhl?=
 =?utf-8?B?M2tVRGRpSndMRlZqTktZUmNPdHdEZ0lSVWRQVEVWd1c5eTRHUVVxYVY4T0hw?=
 =?utf-8?B?QWg4bmE4ZG5FdjlOcU1HU25ESjQ0OXNaK2pCakZ3Z3RxK05YaWxySUN3clNj?=
 =?utf-8?B?dDU1L2V1djlOSHkraXBQV1BzekN6cGFCRDJNVWdubVNOSE9qSmsrMHF0d3BY?=
 =?utf-8?B?cmZBdU1ZSFdROTc2N0V6Q0FWODUydG5TSmZ2aExJWjhQOHFacisrTWQzMVNt?=
 =?utf-8?B?MUpzL2Y1YVRndEQ3dCt1cEFZekhVUGQ1MFQ3YXRCV09tZ0tLREJibXB6aCta?=
 =?utf-8?B?T25OMVVXMHBNU3Y2VWJCYnk1WVBRYnpxSjFUY2FtYXRLTkF1VE54aDFsUGdn?=
 =?utf-8?B?VUZnTGZid3JXcFBNRTFaMWJyZC9YMWdVTUp0eldhOVdPOFl0ZUEvVkxaTkhk?=
 =?utf-8?B?MWUyUjAxS1ZkS2tMOGxrK3RoSUVadGRRQ1hWQmgrTmNuS3lIbE5FS3MzbzRM?=
 =?utf-8?B?TG90VW5qenpuekhhSEZnTG9ERGQvU3NyY3RLTDZ3RTBrMDBHRDl5NTNxVUgw?=
 =?utf-8?B?TUsvTitWOTFPdFNCVVZHNWxVcU1iTGZnMU5jcjJCd0NXOFlJUHhIMndNTXEx?=
 =?utf-8?B?TjM3alZGVWwvYWFySm05RWhMUVlkTWUyYzVWWkJBN0VuNWMvRDIvMGRWbTZi?=
 =?utf-8?B?Zm0yak9EL1NEU0owZThZWGNzWWMyZ2o3SmZ4NG0zaGtpb3NFcWFrUjZDNStV?=
 =?utf-8?B?ODZpQi91K25uVVlXSk5YTXhiNlhSSDFOdzFjNzJlWlphYkFmVWxxMDRnZ2la?=
 =?utf-8?B?MVMyTTVMNTZqUWUvNHI0QnVwTGg5UnpxSWdzeXJSektZcDJFZ0xHaXQ1c01s?=
 =?utf-8?B?K0k0ZGVBcVAyU0J5SEs2OFdEbUZHb2UxY1RSTHozZ3lTcDNBOS80bHhpNnh6?=
 =?utf-8?B?Wmt5T2F1eldpZlR4K2F2UHZ4N0JFOVNUMyt6aDJYTkN5NFJ4ZHFkVUZwV3Ju?=
 =?utf-8?B?akZUUVFML3RMbmdJM2FnUGRSS1JQcVRFN1ZsVXJOaGxsdS9DQjMraktZYmtL?=
 =?utf-8?Q?9ftKB95uEH5+EnuyXm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff057e37-ebee-4e50-9ff3-08df2ba3fc08
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:39:02.0163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTtNwrGZ7ehLUYoGoMELa3r93KHq3sE727/5QxdN0/Zo17hwR3jp4fkUlbdRTRdSI5aEDrwgODfg4gWUW+WHXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999171
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

Hi Arthur,

When AUX already holds the DDC, dal_ddc_open() fails with
GPIO_RESULT_ALREADY_OPENED, and the HPD path then calls dal_ddc_close()
on pins it does not own.

Please try whether the following solution fix your KWin issue?


diff --git 
drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c 
drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index ad1a499b0d9d..1f53b33fc875 100644
--- drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -2604,8 +2604,6 @@ bool dp_is_sink_present(struct dc_link *link)

  	if (dal_ddc_open(ddc, GPIO_MODE_INPUT,
  			 GPIO_DDC_CONFIG_TYPE_MODE_I2C) != GPIO_RESULT_OK) {
-		dal_ddc_close(ddc);
-
  		return present;
  	}



On 10/7/26 11:47, Arthur Liberman wrote:
> dal_ddc_open() uses gpio->pin after dal_gpio_service_open() installs
> it. Close clears that pointer. HPD sink detection and a KWin atomic
> check can both open the same DDC: the check reads DPCD for DSC while
> the HPD worker closes the pin. The load of hw_gpio.store.en then
> oopses at offset 0x28 and kwin_wayland exits with IRQs disabled.
> 
> If either pin is gone after open, close what this call holds and
> return GPIO_RESULT_NULL_HANDLE so the AUX transfer fails instead.
> This does not serialize the two threads.
> 
> Cc: stable@vger.kernel.org
> Assisted-by: Cursor:xai-grok-4.7
> Signed-off-by: Arthur Liberman <arthur_liberman@hotmail.com>
> ---
>   drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
> index 95f8b7c7d657..a3145cd82d8b 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
> @@ -577,6 +577,17 @@ enum gpio_result dal_ddc_open(
>   		goto failure;
>   	}
>   
> +	/*
> +	 * dal_gpio_service_open() installs gpio->pin, and close clears it.
> +	 * MST bring-up can AUX-read for DSC while HPD teardown closes the
> +	 * same DDC. pin is NULL again in that window; do not dereference it.
> +	 */
> +	if (!ddc->pin_data->pin || !ddc->pin_clock->pin) {
> +		dal_gpio_close(ddc->pin_clock);
> +		dal_gpio_close(ddc->pin_data);
> +		return GPIO_RESULT_NULL_HANDLE;
> +	}
> +
>   	/* DDC clock and data pins should belong
>   	 * to the same DDC block id,
>   	 * we use the data pin to set the pad mode. */
> 
> base-commit: 41505ac433cc4c5179deee8860d197b04f6d1c1d

