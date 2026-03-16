Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D4BF53D7E
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 17:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24DB910E300;
	Mon, 16 Mar 2026 17:43:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mXCLhFxf";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010019.outbound.protection.outlook.com
 [52.101.193.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9174A10E0D4;
 Mon, 16 Mar 2026 17:43:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgHbXA1W3lbCeVLbjPhZZOC5bnxwPPHlwWsTBjmab3PrpWrDkOh3PyT04Xq5fdlNxEekw8fZWFg7HwwuQCCiz6OnQ/mXdw9Tjn8TwEwm5K/QPCObqOM83rJVLwm4epJmQDouUXYckv+SERTvnEG1/n2gNOQGvP3K/z9i95uNzFwbCwRBIA2Xx1FRd0teXj5bse1jci4GI/tJXjJlRCXTbIfRa5c/prMrnFhKwr5W2565ZYU/4wQ8IBPmZUnjFlQmBCO4daChepP35eXADt0sSBeU7JBAt45Nx3JELKWivVS6UI/BTKaAmrDE2v0s/uW41rGZglEtB69Pxy7VZi514w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIOdXCS/0e3SXEDMYw41yr3s/+y4J27J/DzJvfgPiHE=;
 b=NbafYvBVt2mGf0xZlYmMZ16wai3ZOqzjfh0ka9WcIlQTynxFaGMDh9kYZ4NyNxPfSsq0T/WmLFoDok/gxhHRhumbGfkgQaKPe5N2RfvJ60MTq5KmzyiIRk6dnSLSLp0sBRJlhBV5p41pp+mcI9CXvrLglnC21lL/rkW5szquDx69CB2q6KnMnar66NJvRCwspRjGJp9CKzSe7rkp6Go4Tqxh3UvBHIuoZI6a6lKAhK/J2W/U4LKXMPFQ/LC7OQRMXhpMPmDFcC6YYlxNwHzSSmJCG+DJfPXxHanemRnxjvu8twiyC9+72kSS215ceHSolMMurp5sa+bRKDYCj0KN3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIOdXCS/0e3SXEDMYw41yr3s/+y4J27J/DzJvfgPiHE=;
 b=mXCLhFxflKAUvDB6P7A+vEYymRQTptAnzcjUSPhqIl80SYn0a5JVQVR4uCZMEq4F9cgJ8FpN0so6U9fGYJASgdba3reukKJjpfUlSkdmtMSEXI8KtOxHmDjd2dV7fhMio0eamh7eWRMYWllOLEhkI9hUZSJLzcvUUoSWD/g/AjY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB9737.namprd12.prod.outlook.com (2603:10b6:208:465::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 17:42:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 17:42:57 +0000
Message-ID: <9a5f1dab-eeba-477a-84cc-8e565b9c5de6@amd.com>
Date: Mon, 16 Mar 2026 18:42:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm: Provide a drm_dev_release_barrier() function to
 wait for device release callbacks
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 dri-devel@lists.freedesktop.org
References: <20260316162002.13479-1-thomas.hellstrom@linux.intel.com>
 <20260316162002.13479-2-thomas.hellstrom@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260316162002.13479-2-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB9737:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e2a021c-83ae-433c-7eb2-08de838375da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: gEBp7Twt3df+fihM2R3koEVKb0lqdjLxtDam8422UmcnPhgpYlntyzfKHt9Z8cRmyfJ5EYhBr916BWH2y1DQXJd3UELjbJgjHA3sckvrIyXmuFDfm9v4PvHPi2C34Dup3QLJcv1jHLrM4Jp5m+5UsrfKWiyKmROZT8mKFDlsqE2ULEXNpGCdM4tzwRpqurlJpQcjN/ykPb6G4+Xj120155oUKUlNUWfH07/zWqHLdxGRuICjhHpWhS4D3hE991dtyfn9UuAv5BwQDOTFIlgvfJAXcBnBrVxpUfmR9jaKEMe1v4kmMBcNt95qhRv/bu03tiA8dj61j3FV3/xlahs7oBs8NvUHxI6tSSK8vXxXpoaG3fqdZqx/5+DdXJXNymHnQuF7c5A5PYEjVloiudBtaj+f1TYmID6YGTfAEilrBgGFxRrB7uzd0E8mYbGXD9ej8TwmZ3+kmNGN1HF033gydrQRHAuJp0/6MOm4QzsJoCBsdGkMC8a6H0egxvOF0tXAlHUTsg9BcV0LBV7hqI/VneR+MDrxlEPB4FKUoud6lMZyuKJadHNZGo6E4LNF7YRsx5s7jc+HXbzH6Vuxcjw1NogXo5rYThFMBNBc5P7YOsYzlmGPtxAMUBzA9RqPo269x89ywkUmOOqC1ZgSrM+ZHftwdItPe1NazucJRUTHSXjAqwx0f1PVLi+UG7yr7u90Ukifacwp3SaCwJTmcBbIYavTMC9CKYfadHf2rtN9G0s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTR4N0YvUDhsRjlRODNkeVB5ZitINmQwYWs0N1NRbmxaVkltYmp6TkZmNlJj?=
 =?utf-8?B?WWZ2YTB1bGFXQWpGRDY1Z1BGRm5NcFZTV1N5VDQ1bEZHQ0tMOFFqL1F1ODFw?=
 =?utf-8?B?VXMvOGk0blRCN1U5SmR1YVMxMkRheFFpTTI3L1VHZjhmT21tRjZKSjdQcE1z?=
 =?utf-8?B?cFBQYUsyNFJnNXNjNlQ0ZlZvWDI1NlRkTkdlYW9EUnJIaCtQWlpMeVJ5L3Vj?=
 =?utf-8?B?VC90VUtHU2VBU1hONWtHMVVhSFYvMG9jSTRncjRBUVJSOVk2RkVRVEVWQU5u?=
 =?utf-8?B?TWVxbHcwSHh1R1o2dHFIclRWaFhOblNIajRJMEpNS0lSOStKZExURzIvMmVO?=
 =?utf-8?B?ODhpWmhpYWFEY2t0cXVDbjNNMi80WVAyVkhhRkVNNUFVS2p1a3JZTGlncmlt?=
 =?utf-8?B?SHFvWlhUZTBWem1pM0lkWHp0YU1GZ3ZUenJuRGxoK2dkekNmcDlDV2F2eGV5?=
 =?utf-8?B?djNoNlg1NnpJaWpPWGVmUHBZZlZHK1JWbjhuZjNWaUdzY25xZTc0VWExVndQ?=
 =?utf-8?B?eExwWEhnejJPbDFadFJ6N1p1NGorRnhlTk1GcGNObm9SZkxWVFRMWEJjVlMz?=
 =?utf-8?B?Q3RHdENkUCt6QW5oV3pqbkVlcG8vS2NlRCs5UjdpK3JLdzRVU0hkcTNVTFpT?=
 =?utf-8?B?RVVBcHhUN1laK25HSHBwU21jclFLSGp6TGFhQjlNdGJSUzMrQ2NKaTdYUGFq?=
 =?utf-8?B?ZUFqY0tZWWp1YWdGSWVhcHdFZHp2VDZHRXZJV1NNRlpwNC8vQUJuVnpEM29Y?=
 =?utf-8?B?bmRWRkN2QnVjeEtjazFQTWdWVU9QV1FHN0ZjUm13ZVJkdmREeVNtNWxWVEJh?=
 =?utf-8?B?SHJ5L2RlOEkzSVZlNXRRRHg3RUNvQ3NGaTJ0dHAwOWFxRkt6S25Hb292WE5I?=
 =?utf-8?B?K01pV21iQXZsM0dmQWVSdXp0TzFYbnk4aXl2RU1pcFlkUzg4clNNZmFlMjA0?=
 =?utf-8?B?aklMblVtcUNRUkZhZ04zL0VCa2FMYkpkZjltRzk2NTNGVGVQblNkUGNCQXdV?=
 =?utf-8?B?bGs5dndoZUliNmhDcHpEOUg1MUQxaVFYWEZaaFVnckJMTkQ5TFdLWGRET29q?=
 =?utf-8?B?c0k4NEN4ODZiblFOblJTZ2xRYkV0QnVhWlRMWWd3cDBkdzRZUHJubll6WnMw?=
 =?utf-8?B?dVkzNGlIeFhyZlZKK2M1bnZ6bXRBYTJtZzNzMzEvMnNyVTlKdkdiNXlINUgv?=
 =?utf-8?B?dG9YYXRPV3pLNzFDQ1NKejdDdlJlMWRNQkZyeVpUc21NM2tJUUFjYVBJdmxI?=
 =?utf-8?B?ZEZLK2JYbWk3bGcxTFEyUzcrQk52M2pCYmE5QWhJajFrOENjeEZHRXBaVDJr?=
 =?utf-8?B?c2hLOUQySCs2RmpzK3UzTW1ySVhxcDczaVdCekFySEE1ZjkwYjdZa04zNEFv?=
 =?utf-8?B?YjZFdDY1OW5oTm1lMzNFTGVlUGRzOUFTQXZVaUxGTGR2TEdDdFYxckwwUCti?=
 =?utf-8?B?RFRHNjd1dFFGV3pVM1pwcG9HbVc4d0ZnNnRRaUNlZjNzTVE4cFRMelVleHIw?=
 =?utf-8?B?S2Ntcm4vbVV2cGhXNnNSUVBGblB3aTdoWFFNanVzeCtHUmRRM095KzhOUzNE?=
 =?utf-8?B?dW9pNGRXWlF0SjRmUS9qdFRoMGg4Mmlhb2VNVnJiV3ZBQ0RNTXl5UlRQRnVQ?=
 =?utf-8?B?cnE5dmwybVdUaEczeVdHTXl1dFhMbWpyUGc4N1VvMmFGeE03VFBudWc3Yk4r?=
 =?utf-8?B?RCtFVDdjNTFIdDRZMHZVT0FPWFF4eTc5Y1pCYnJTck1jRnJUWHo1VkRKYjFj?=
 =?utf-8?B?bk5HTitud3N3UUFlT1RNR2pwbkJUMGN4NDFpRVg5NGRiWE9LOVRYUWNVekFm?=
 =?utf-8?B?VXNuRFlQN1lWYzhRSzd1R2d3UzVLVmNLVCtTQjVjQTdPbVBQckxlS056ODZC?=
 =?utf-8?B?dVgvamxuSGQyT0FpSUtuc1doOXBlVi95b2M4b21ISm5RbUVSbzVtRG4xVndX?=
 =?utf-8?B?aDk2dE83aGx5MTdvV2lXQ2xNMVhDbGFaZzhOSFYydnRlZ24reGlkeFRlL1A4?=
 =?utf-8?B?bmxiS3NsY01kUEVyd29IVGJ1NWxUSDgxcG1idnRpdnF0ZTBQdkgxZzRodkk0?=
 =?utf-8?B?TGxCOXJFSGdpUWRwaU1TYlUyVnRocEk1MWd3dFJpM00yKzJaMTR3OUQvekgz?=
 =?utf-8?B?SU9TWDlFOXB2dnZEZS9hdWJnWmlBSDRFbDhPa0htWUh4NThFR0RsY25UZVBQ?=
 =?utf-8?B?ZWthaTkyTGl6MkFSWDhsRDBycGtlNlVUcDFaUXBUL3pCUUIxNVBQYlR0MDdE?=
 =?utf-8?B?K2Z6SzEycndUKzlJWlhRN0RaVDJjenhFQlFYVmxuUmZQTUxyUFJZYldsYy9y?=
 =?utf-8?Q?1NduHNbTj6E9+t7EcT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2a021c-83ae-433c-7eb2-08de838375da
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 17:42:57.6532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D00lxLk9X8byAooF5slBP7O/IuXFQPpj1YB8aCMlC2WaDW0OiiQ858wTOtZR0pfg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9737
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

On 3/16/26 17:20, Thomas Hellström wrote:
> If helper components, like for example drm_pagemap hold references to
> drm devices, it's typically possible for the drm driver module to be
> unloaded without that reference being dropped, 

That is an extremely bad idea to begin with, drm_devices should reference the module who issued them.

> resulting in execution out
> of freed memory. Such components are therefore required to hold a
> module refcount on the module that created the drm device, and ensure
> that module reference is dropped after all references to the drm
> device are dropped.
> 
> To relax that, drivers can keep a drm device-count and ensure that the
> module isn't unloaded until the drm device-count has dropped to zero
> and that the caller that decremented the last device-count has finished
> executing driver callbacks.

Stop for a second. The question is why would anybody want to relax that?

That unbinding a driver from a device is separated from module unloading is a design we had in Linux since the very beginning.

Regards,
Christian.

> 
> To help with the latter, add a drm_dev_release_barrier() function.
> The function ensures that any caller that has started executing
> device release callbacks has also finished executing them.
> 
> Use SRCU for the implementation.
> 
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/drm_drv.c | 25 +++++++++++++++++++++++++
>  include/drm/drm_drv.h     |  1 +
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 2915118436ce..9fa72adf173d 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -898,21 +898,46 @@ struct drm_device *drm_dev_alloc(const struct drm_driver *driver,
>  }
>  EXPORT_SYMBOL(drm_dev_alloc);
>  
> +DEFINE_STATIC_SRCU(drm_dev_release_srcu);
> +
>  static void drm_dev_release(struct kref *ref)
>  {
>  	struct drm_device *dev = container_of(ref, struct drm_device, ref);
> +	int idx;
>  
>  	/* Just in case register/unregister was never called */
>  	drm_debugfs_dev_fini(dev);
>  
> +	idx = srcu_read_lock(&drm_dev_release_srcu);
>  	if (dev->driver->release)
>  		dev->driver->release(dev);
>  
>  	drm_managed_release(dev);
> +	srcu_read_unlock(&drm_dev_release_srcu, idx);
>  
>  	kfree(dev->managed.final_kfree);
>  }
>  
> +/**
> + * drm_dev_release_barrier() - Ensure drm device release callbacks are finished
> + *
> + * If a device release method or any of the drm managed release callbacks
> + * have been called for a device, wait until all of them have finished
> + * executing. This function can be used to help determine whether it's safe
> + * to unload a driver module.
> + *
> + * Assume for example the driver maintains a device count which is decremented
> + * using a drmm callback or a device release callback. From a drm device
> + * lifetime POV, it's then safe to unload the driver when that device-count
> + * has reached zero and drm_dev_release_barrier() has been called.
> + */
> +void drm_dev_release_barrier(void)
> +{
> +	synchronize_srcu(&drm_dev_release_srcu);
> +}
> +EXPORT_SYMBOL(drm_dev_release_barrier);
> +
> +
>  /**
>   * drm_dev_get - Take reference of a DRM device
>   * @dev: device to take reference of or NULL
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index 42fc085f986d..b288a885cf45 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -489,6 +489,7 @@ void drm_dev_exit(int idx);
>  void drm_dev_unplug(struct drm_device *dev);
>  int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
>  			 struct drm_wedge_task_info *info);
> +void drm_dev_release_barrier(void);
>  
>  /**
>   * drm_dev_is_unplugged - is a DRM device unplugged

