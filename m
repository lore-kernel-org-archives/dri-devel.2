Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7403C606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kOzwgi2h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA0BD10E2F3;
	Wed, 21 Oct 2026 12:44:04 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010006.outbound.protection.outlook.com [52.101.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C96B810E2ED
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 12:43:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQVCiQszeXDkxJcB0Z9BoSdf+ceV8jqKC/bhtQU4hfEZfSN/T+iIZS+FzlH8hZ9p/IUvOLep6+2kl+5CAw0RHp3ukl7eq2vXNMs1PpNMUrqHAn6lVFM974zfY5rNu+aUJkrxWp4QPot57gjQzeMYwuR7e1AbTxYNHNxW2Qx8hpOjqRA7Mp3jwOHqrol21j2RXMcT7oA/YQsHehFv3tEcRTRXzadS8cIlRs9FFir7hEePR0FE/6NNaO1R5yqfI6OIqat167VuGcddLDLEYs4DG7cNhN8Qmo4rEKZPrIz4X6DPyg8Ys7AiDcrvuKXfOPbvmb//juTGG1NaBFcQUclUhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xa7G3we/aVBM15Evrl8f/UwX4OFEnm9+SULdNQmrFo=;
 b=Zfp+BDBXw28+Ptq2oVZtYSh9mwV1PhPNCffvG17pZqe7f2Q+SYZ6FgmyNvj1KoszHBUaNt6W7pcPP3ut9IJvGt22ooq/slrcpPu2VY4H7OyUwrLiSZsZvoINTHu4xRkyutbytlMvEdTTUzX0nCbx3W3M/lAanuwR5s6bxB+75hWv76AevtDQR0A3cuuBqpeiOymJcse9Z9YWf1VdbdY/OSnXHvXu/Bgj1lABbAztyDCYLKoMOixoxYhpdyxcVLq298/PHV69TdXHBqB4h5N0ZmQgeWpfmWS624o/RZyxY5pty/R+yyOY3WbPKFQ6Z67wVYVwPQUXRge7CrNjSRX+yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xa7G3we/aVBM15Evrl8f/UwX4OFEnm9+SULdNQmrFo=;
 b=kOzwgi2hkxoCKuU2vEiXNBWhT1XxBJasKlaCHT35SKnZw2AEqLxoJ92cmBKjJKjQwdOQYTD5Cxr0ctIHXeURmdXTfF3R9ac53PcrcUo5rbxmcRi10l4J3eYhBmfo33ok2637nAhUBwlMcYuxjAtCcxqYRE7/FUROylBGycFT+4c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 12:43:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 12:43:56 +0000
Message-ID: <33b0fe8f-f9c5-4726-b38c-835b5dabc441@amd.com>
Date: Wed, 21 Oct 2026 14:43:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm: Log recovery method with wedged event
To: Raag Jadav <raag.jadav@intel.com>, dri-devel@lists.freedesktop.org
Cc: riana.tauro@intel.com, mallesh.koujalagi@intel.com,
 matthew.brost@intel.com, rodrigo.vivi@intel.com, andrealmeid@igalia.com
References: <20261021024726.250487-1-raag.jadav@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261021024726.250487-1-raag.jadav@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: 7469574b-8dbe-4eee-81c7-08df2f70f8bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|261009223027099003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nswehpYbiBLDmjHBYqXWc/V1NBMcAv6uinwqxuPB+xN+SzWZOS5HbZnk9gfZtTEQbf3vrlpaOFWT7ThI6ifkB9rKkMLc2ZiudkmgQeQFcrgJLjHjKktW3O7FxAJRNaKkoHXn0JgYhaRqDVVf+gDdW1Um96OBNSruIU0vSejcCChtWgYvis3o6E04FULa71KntBRMOgND+fUerEmtOh74TxCmGnf7nh1yElYFMhs78obYJikBY26Uv7+JzDIJ1r9tuifsc92SrOUiTz1qjd7cGmQ+EYxM1CE1dpd2ocIeV65VxEc8bOK95rWu13rR7u64zc2wHe3/6cclRlIk9JWzzq5/r+2y8sGsq23hmBCIhggN7vPJtEKKrLccKp73ln2ShP2685UicZlg4gJv6z4bel++OF+bVR2/sWCBE6xajcfCSEZ7AY4NeXjVi5btr5+HYtGPBUsnMjmujfZDyu1q8tSI28StN3C+oPCJISMGVER3jqg+vJDLP1dcwx81oTJM+tjgbgge2NvYcEfv7ssd0/aACBvxmy5nyMw2YEc8A8wGaoemikHo+h8wv2B1pWps7eBRKxCcC8cPp7Zpr7iVDRo9m2+ve+WXzoJaCntpBcwwQjzi3fs5xDeuL3NOgL5DqmLGIMUhRbjBFv9LZ6xVd32klw8eE8q+wI1itPYXGCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3VUSlZ1eE0zOXRuRXkvSFkvWkxmREM2OTZldmtXSFNseGFjUlN3VSthT0w5?=
 =?utf-8?B?Rm96cDB4SnQyK2JtdjAvTUtKdUY0b0Exam5MRjVXQ3hYc3MyYlpBQzFCOVl2?=
 =?utf-8?B?OER2cTd2TlRFelNCVVYxK2F3bmJuT2VRRXM5cFFWNkVEWVRPYVU2YjFIZDVW?=
 =?utf-8?B?ZVdpM3QrU0Q0aXZqM3AzelBaODZoOGJZSUhwZ3dubUluUENRN1BFOCtkd01U?=
 =?utf-8?B?SE9XSHZhcHBEWTI3L2RQSUh4b1RKcWNYQy9jNHRzaFhFVWxOUGVCcWtSeGV4?=
 =?utf-8?B?U29mejBVc1RiTm5sclVyVzZySms2cWl3MGVJV0hpekZjd3l4U2JKY3M4aStY?=
 =?utf-8?B?ZXg1di9QK0xPcUg2ejdLRWkvM2VPVkorUEhKRTY0WGx4cHNDZHR2RVN3YS84?=
 =?utf-8?B?NjlOcWlHY3VXb3VEWkY2dzdkc3Bsc0NyR0YrWkpnY3JTM05wenZ4bWF1NGMy?=
 =?utf-8?B?WTNTMEtMVm9KNnM0RzI4OVE2VEJzMlpKNzNtUlZGS0FRZVBqOGJHcWlUdHo2?=
 =?utf-8?B?cEsrZVJHMWtqazFTZ0lFb2dEd2xJRG5kdFVhL0FEcWpuVU4xcDFvL1M1WVdz?=
 =?utf-8?B?a3BUL0JTVC96NWE3OGdXYllrelIyaVBkNEE3ZXZNbndjMVpjRkJJaGRHWmJE?=
 =?utf-8?B?Yi9zNHU2UjlxWjZaN1JKZC81LzJWRy9pY1Y5TS9aZ2lwdWFvdlhTeEJKOTNN?=
 =?utf-8?B?NW9HWENaVE9paUF4NGZvYnRBeWcxRURpT2R2ZWVQclA2NEh6N3VQU0VxSDFm?=
 =?utf-8?B?cmN0T3JDYlo0b0xYcSsrSmtZb3QwdXF5RHdKTXVoNDhEWGtZRThxRHhXNVNN?=
 =?utf-8?B?aWlIeDdFM0dGOURTcnRHUU9MYzZDMjZybmozOTRiUXJibnFPV2tvYWpxVHdq?=
 =?utf-8?B?blBubjZUNDdzWHY4bnFMZTVrcnlRK05PdG1va0RzaWpjdzVvZGU0SUVUMlls?=
 =?utf-8?B?TC9zWU1IcGFjNzFWQk5RZTQ5SXN4eS83RkIvY1hVaDliNGdscTNnZXhFWGw3?=
 =?utf-8?B?bUdxSjhXendURDBPQ3NVTlZmYmVnY2YxaEQ5cnpkTTF5Ukh5M1VDbHZwcTVu?=
 =?utf-8?B?bFZrNnVwaGlKSmN4Mzd6QzR2Qm45MGpmQVpvNDJEeFJuMEM0YnRmdEs5a3lk?=
 =?utf-8?B?SjR2TmttenZhSk8vVVN5WlFGMXQrUjJ3WWlkVHhiYWthZ0tpTkNsVFc4clRq?=
 =?utf-8?B?QjMxQUFCcWRNZHBYNnFsYTBmNklWeWRRcDkwd0VhVWJMU1pjSXAyMFB5NGdv?=
 =?utf-8?B?WWdLSnFNWHRIUVZXVHd1N3JQMXJ3WkdWRW5NUXBjcjhZSjFRdnVZTGt1L05s?=
 =?utf-8?B?NTllL3BDZWVUUGtENDM2L2NyRG5FSFdRS21lTk43MWo5ZFdWbXlWYmVvaEVR?=
 =?utf-8?B?ZlFSSGZ5b0g5dnUwSkJxM0hweUQ2MVFIbmVKRjMwSWtkL1dxcUMxa0xVQkFF?=
 =?utf-8?B?Y0pKbTlOZVY5ZlFmYnlWcldRNlY1eUtxdUh3TUlEb2R4TVJUbVVyazlsaTF6?=
 =?utf-8?B?TlRMcWVRT3ZRL3hnTkFkZi9IdDNZQ1VwZHA4TTJEM1NTUlZHTFM2VWhsZDZE?=
 =?utf-8?B?dEFNb2RTSDNaNUZGOW9oTzl2ZnFZVGVnakVRUnlnVjd1MEZGRXN1ZE1BSlk0?=
 =?utf-8?B?a3gySU9HOXlvWEdaUUx2L2NabHFleTJoUWQvdm15d3UrY0NWcnJlRXkwU2Rn?=
 =?utf-8?B?bkVVdWJVd1BiMmF5dE92eFZDR3IzQ1BwQXQrRXZoOEdnZThoVXpoOHl6bFhQ?=
 =?utf-8?B?N2NFUVoyMHdmMnZmK2RmdHV4L3NKc2JiZ0p2U3hOZ2tybGt6Y1RiZURudDRw?=
 =?utf-8?B?NEJQbnJ2VTE5U2hLbFBGaWp6ZHEvR3NoS1g3bFllM0U1NmhvenN5YnZERS9l?=
 =?utf-8?B?ZCtTOXkyclorQklwVWJ5RThZZGZYVDlaTEhvamVoZFZFQ0puMmJNanpOTUVr?=
 =?utf-8?B?VDBUZmVQaVVvKytxTUFtYUp0S3AzajNmdlpRZ21QTlM3ZGQwSER0d2Rvb1Ir?=
 =?utf-8?B?RVdsM0hJRElraTZySkhOZ0hUNHgzTERpT2huTDBXT3YzcXVJazRNODRXS3ph?=
 =?utf-8?B?dnVrSDh0Nno3eTJUVC9ESXliOG0vSWhhL21vb1puejZSdFhlYXdGOU5sVlVW?=
 =?utf-8?B?Z0ZkZE5ha1B4K04wVXIvZ2lnaUkyWm85OVR1b1dwclJBanRkNjJsZTE0Zzhh?=
 =?utf-8?B?eW0wV2VMZ3o0dzlsSlJSQnNvZ2dxWDIyMVlQdVRNUmxLYzNTaWpLVE05em9K?=
 =?utf-8?B?VHl0eDcwdDNhaE9SQkQ1cEVGcS8ybW9LY3FPTTRaUzZGelVOd3c1Zm1kczkz?=
 =?utf-8?Q?Z33vs2nXwSxLuUVcsJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7469574b-8dbe-4eee-81c7-08df2f70f8bd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 12:43:56.7701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2M2B6dbf4Hdv6db2y6AjQmPtcEdZbxaJpQ057fr6FD53z1jDNevng92qx6fWdoY6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 04:47, Raag Jadav wrote:
> Currently, drm_dev_wedged_event() logs a basic message of device being
> wedged, but doesn't print the recovery method used by the caller. Log it
> for easier bug report analysis.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> v2: Distinguish between recovery and no recovery cases (Christian, Rodrigo)
> v3: Retain drm_info() (Christian)
> ---
>  drivers/gpu/drm/drm_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index cb53baa70995..43125d655f64 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -598,8 +598,8 @@ int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
>  		/* Caller is unsure about recovery, do the best we can at this point. */
>  		snprintf(event_string, sizeof(event_string), "%s", "WEDGED=unknown");
>  
> -	drm_info(dev, "device wedged, %s\n", method == DRM_WEDGE_RECOVERY_NONE ?
> -		 "but no recovery needed" : "needs recovery");
> +	drm_info(dev, "device wedged with method %#lx, %s\n", method,
> +		 method == DRM_WEDGE_RECOVERY_NONE ? "no recovery needed" : "needs recovery");
>  
>  	if (info && (info->comm[0] != '\0') && (info->pid >= 0)) {
>  		snprintf(pid_string, sizeof(pid_string), "PID=%u", info->pid);

