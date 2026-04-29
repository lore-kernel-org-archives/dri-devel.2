Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B96FFF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 12:15:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9813310E06D;
	Wed, 29 Apr 2026 12:15:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M+UohQVB";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012050.outbound.protection.outlook.com [52.101.48.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A716E10E06D
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 12:15:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/hZx65wUnI9bWAPi/lSsFjx/PpOBYSjoGb3vBpGZHgPasSHCH8PwiQFATEsJspxLeuT3wG2yzE2uZuyCZW0FakH4gaPlsAhnHfV5caKOaeYdq5KTzRwd2h2qMaX76nZM/oky3+mnJGj8TbG/mKzEBf0Kmlsy4X9vY5Uu/zBKoBA/F9RYEv15aONZ1yRhBOi0HQrRn2NcWN7bHHo2Egz0ygnm+9zPzu539GByO9Y4zJ6oRdZEBT3E3sgGGmD4gwdYKfD9j9VK3GMrIRTNXP17f3i/uBbaO3p0ndUBhD9MTzbcMSHlmpvDFtlqPPmVaOHjbceLZqwaOuiHqTqLg7Qeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QH5zVrU9WCWG4vQZiwszUM9i9kMFrlVD6ukZFO9YDTc=;
 b=CSaEeQGeeSUKM4bMABM6xRVshIU+kIo5fyXPPaCTSZyh97SVbVWrz7HoSsXWsMYaPHHuuAM82Qxf0NF5IThkJiBfys7QgpniGZYA/xE46XzbekblUr38OC/PXLswwsPJEACao1XrMFvrwDVS1nUg4qeXpfgVdIjhFPKsA9WgHTWVwUD/H0n1LGp8hd0oiZv0lQfAyew+YHGsnc3UQzMCeABIG4KMVJMZkpjH68BUbXmUOXHFme3Hq45eeNYP3rTynlANeuhmKGYWLDujFogEzLMWFB67Jy1lw7evx6CuTb6NXnXPlIFN4nb/w8OTGZCCuSDwZEq0olNJW45sN7bWxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QH5zVrU9WCWG4vQZiwszUM9i9kMFrlVD6ukZFO9YDTc=;
 b=M+UohQVB7fjkXhPA6/QaY7f6hkKfdjP4C50sz7bAtu5Rdb8tRbgJhi0kod2f7T3baSr2/Z4mXqmD6466HFe8k0rfgITLRmJ/r3NGVtfvHzV60Hz8u/L2Gbft5qDj1ZP3+4KoDn9wORrP4U1IFFBA7ejWw/x0oxv8fkygrhoHtbA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6694.namprd12.prod.outlook.com (2603:10b6:510:1b1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Wed, 29 Apr
 2026 12:15:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 12:15:49 +0000
Message-ID: <ae6bf1ee-d7f1-4e72-8e91-fd0af8879f5e@amd.com>
Date: Wed, 29 Apr 2026 14:15:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: Drop unused drm_device_class_(un)register API
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260429085726.69842-1-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260429085726.69842-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAP220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d4103a-f8e2-4056-c534-08dea5e90c97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: tCe9VoD/+JIpuppxiqhiZ93jqjIof0AIwBKmfOc7hOUGuAIEy8ZjAdVpNO+LludTEQRpnmODTG1jHR4slxo+LobdwaFJ7iNR/pieR737Dj8oGLJf3JIwYZWgD+dA/YpGpWfnsw6jKMsktyXIpNURJwBy18ja0VB3wpwwA1dKC5BwnZkflRWak1ZN7QR+jBTXLQSX+ypDx3JwpMc9xyJBJkdGBHuX5EeZ9B5PnAbv0kFhf0ZohQzw0BGV+y066l6xcgzGUdfmg+57ePop2AahFW26xj+bw9Sa7r7oStW03iuZLmwGBr4c8fPQF6lmC8YHya5oj9bH+fe0FQ8A1WgHCb30gZ25rGkIH0bKGCIypdb0xUM+gdXuG1o5Bjvgw14Arw2mozg8LKKGOhAG1SuC7XbEK3+oicN+DSICd2suM2xikVNnX3K14FhVz2pEJdthS6+P2GV7dM3Cnu6xkWFTJWh9MQKIl+T2pDa23A4b8f3OitwQhFCk1/JTUGGi2Gf/jUASvg+SWs8mzFZEgCuPyrPcqt534NONDHmwL9hoK+M4uFtXKYxP1Ond9FsAJxjsYp+ycCu4GOBwugyzBvPb7wr+TEtNWRz5hdDS0zZK2hCBrl35wQ2W3YKQoq2JVrC1AElVYf2QSAXm4Tel3yJV2pbgibhLMN/KyjEvbhBkr+wQnYI5dqYjarJ3/NcdjcpOArDblaLZIBF++iPTrFDJXGM7U+pqyjmngfDY/DmStd4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGluamlwVUQxcmZYbFFyVzllK0JHTTY0T25oandsYllRR0Rld1kvekZJZU9q?=
 =?utf-8?B?T2t6U1pHT3B0S3BMZ2MxTzlXSlgxdmR4TzJaanBUM2RlT3FFaWc5M0tJZGU1?=
 =?utf-8?B?TWpGcjZPRnppMWxxS1kwQlo1M0JjZFNocUN2SVd0MzRYNEJEQzN5MUE5eFp5?=
 =?utf-8?B?VXYxN2Jkdks1bW1wMk9iMkowTkhDSU51bEhGQzJyM0R6NkVubVVCS2VpWENL?=
 =?utf-8?B?NWVhR0NzemFoRG1GcFFTakRKd1BhWlAzTGVrMlBYaWg3QzlrYjlRdFY0NUVO?=
 =?utf-8?B?eDBOc1hUZUJBNUljYzIyVEF0dzlRYytLa28zQ1RJS3J4N1BGb2tpSTQ2NGRZ?=
 =?utf-8?B?NmtHM3MxSHZCdVlIZ2l3d1BvSnRHNXpSOFh0b1p3bnJKQUhwdWFVd3NubElm?=
 =?utf-8?B?R2lWWlBtN1hDUmZ3ajJxenVLekNjN0JBMUxzeTZSSVFVZUs5OWJMNFJYbWdx?=
 =?utf-8?B?LzcxdkU3cWNjaHhlVzUwZEhyS0sxZUkrYUJNSkRXQkNSK0QwcDRCKzA1Zncw?=
 =?utf-8?B?VkpFNXB6ZlAySWtvT0x0YmVtWkpWaDlRdExsVjJLdEhlWGd2emlQSzMrcUIz?=
 =?utf-8?B?SUEwZjZNcGE3cjhZcmlxT2tIbXFQeGJpcUF0Q25vKy9Mc3lGZlM3bEZ4ZUEx?=
 =?utf-8?B?R0tNcTFZZC9jUFNxYzVSNHYvMEFRK1BlRG12bmZRNjd2Z0RKdm1aWFFQQ28z?=
 =?utf-8?B?cHhiclRadGVna21xL1FsWFRQcnJBNDVSMlJiVStzSWF6ZTdkSVNERmhMU0Vl?=
 =?utf-8?B?em9QN0ZPZXNhd0c3V0lWRGpua2ZlSm9wdENsS0dJRXVMVlRKaFpPZ1A0eGty?=
 =?utf-8?B?eEdqSUJ0TENlTDZBTjNnZmV2aEhqRTJBeldiTVBSTUVOQitqc2tUalErbjhE?=
 =?utf-8?B?YUZ0dFBUV3dBUlJGVUJFOUsrOTJZMTRoaFVVeG9SUGJydFhwQ3plVncweUtO?=
 =?utf-8?B?bFI4eTF3bFpmQkFLQVFLZFpmRVNPRzREZlVMY29oelVaRGZWZGdLVkZHc3Fj?=
 =?utf-8?B?cXd1Zi8yZ2hOU2dza3lIM1lPNzdUa1hoSmRTMXMwUTQzNllvTk1COTQ0VitW?=
 =?utf-8?B?anl1bHlCb3NCQXVndlcwemxDRDlYZGxTeGdZd2JtS0pzSEtFUnpDVjVuNnVl?=
 =?utf-8?B?THIrQjhvb2FVcnNQS290d2Z3dWJUZ3B0dlpIMkEzTVlScnQwNU92WFNqS1Bq?=
 =?utf-8?B?YmNwSm9HeEI4ZUgwOTE1ZE9vaEdEbzhYU0Q3dEpPVWlvMkRheG4vOEVXM2ZO?=
 =?utf-8?B?VmhmYXFrUDJhRXZGQVgrbXJkSmNtaW5pdFFaTW9zSkpkcXF1OEovTlFEeFZk?=
 =?utf-8?B?MlIvTEgyYTZCdXozeEgwVDBWQy9iUk04ZUlSS2tyMGhTSjNRMHp5UGpJbVc5?=
 =?utf-8?B?TW9uWmxxQy91Q25hb2lMcjBWcDVrdXN6ek9ZRmdVRGtIQys5RXppWDJmMllm?=
 =?utf-8?B?R1llclExeHk0SDJWNHYzQTVtRnVKdzFnNEh4NnJRLzI4SG1kWE1BbEdZVVM3?=
 =?utf-8?B?cUIyU2JoMHF1TzdNRHR1NUNteHdGMDRkaEkvRTNUTWtLRmJZb3VaSm9ZRnVl?=
 =?utf-8?B?SlRkNXhDVUJ4QzJGcGpmN1NUV3ZJYk92bkdXcEZGNmlpOHRuaCtvNGdaQU9W?=
 =?utf-8?B?VFoyQkxLOSt3dWEzUzFJQ1EyMThGaFpWakpFckZwVjZ6L2xvb1ZIWWsxNDRn?=
 =?utf-8?B?WlRxR0lwZ09hdXJKa1Jpdlc5Mzc4dklqaTY2emFuTG80eHZYYVBhTlpMWGZq?=
 =?utf-8?B?eFI2dUNDblBiOUhORFkwUG05ZExOdjBYUDNoZ2podnJGL2dpOWh6anJLRjVs?=
 =?utf-8?B?VUQxclI3MHBjdWU3UXcxSEM3YnBkQmkzTElObGx1dWV2SFp5NW1Bb2RHSFBx?=
 =?utf-8?B?dmFXSmtTa2hiYXJSVHJXT3pxNWNYUmNoRkhlNmprSVUxcHYyaUhaOHJYNHBM?=
 =?utf-8?B?OVlQZTdKNC83NGpFYnZXaS9JMkw0c0hzT0xQV0FJZkZpcmJYT0txeS9ZVG1N?=
 =?utf-8?B?VmVKUCtFMTFqRVJlcE92SmpzeGFxbTIxd1Y2Y05CQkNCY2RuQzdINXBEb3RN?=
 =?utf-8?B?TTlCWFd3bC85UmhHM1R6eG0xaHI0TzkxL3Qyei9oODdaM0s3RFpFUTlqZVln?=
 =?utf-8?B?RXprUURFZTJmUmxZQWJLd24zY2xoUG9nRlF4amo5VjRJb0Vkd3ptRkprMnlH?=
 =?utf-8?B?NW52MHNxUGxwL0Y3TkQzY1d5U29tQkRBU2tZeHJZRUgxb3lQRWZXVEtCMmsx?=
 =?utf-8?B?WWxOa2VWaHIzakRRRmhCb0NjaEpFQndXTi9KMkd5dVgvOFN4dUhzMy9hT291?=
 =?utf-8?Q?zKzGJi/Y0SBMzBY0MS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d4103a-f8e2-4056-c534-08dea5e90c97
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 12:15:49.2133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdJERxA/c12Qw8Astw1U3rWYt2DLYZk+DVyWWODPdkPFBr8V/1c8snn6nJxmcWtu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6694
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

On 4/29/26 10:57, Tvrtko Ursulin wrote:
> The API has been unused since commit
> ed89fff97382 ("drm/ttm: drop sysfs directory")
> so lets remove it.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/drm_sysfs.c | 32 --------------------------------
>  include/drm/drm_sysfs.h     |  4 ----
>  2 files changed, 36 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index 43b2c3eaa7e4..7433bf8136cc 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
> @@ -645,35 +645,3 @@ struct device *drm_sysfs_minor_alloc(struct drm_minor *minor)
>  	put_device(kdev);
>  	return ERR_PTR(r);
>  }
> -
> -/**
> - * drm_class_device_register - register new device with the DRM sysfs class
> - * @dev: device to register
> - *
> - * Registers a new &struct device within the DRM sysfs class. Essentially only
> - * used by ttm to have a place for its global settings. Drivers should never use
> - * this.
> - */
> -int drm_class_device_register(struct device *dev)
> -{
> -	if (!drm_class || IS_ERR(drm_class))
> -		return -ENOENT;
> -
> -	dev->class = drm_class;
> -	return device_register(dev);
> -}
> -EXPORT_SYMBOL_GPL(drm_class_device_register);
> -
> -/**
> - * drm_class_device_unregister - unregister device with the DRM sysfs class
> - * @dev: device to unregister
> - *
> - * Unregisters a &struct device from the DRM sysfs class. Essentially only used
> - * by ttm to have a place for its global settings. Drivers should never use
> - * this.
> - */
> -void drm_class_device_unregister(struct device *dev)
> -{
> -	return device_unregister(dev);
> -}
> -EXPORT_SYMBOL_GPL(drm_class_device_unregister);
> diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
> index 96a5d858404b..7695873a9456 100644
> --- a/include/drm/drm_sysfs.h
> +++ b/include/drm/drm_sysfs.h
> @@ -3,13 +3,9 @@
>  #define _DRM_SYSFS_H_
>  
>  struct drm_device;
> -struct device;
>  struct drm_connector;
>  struct drm_property;
>  
> -int drm_class_device_register(struct device *dev);
> -void drm_class_device_unregister(struct device *dev);
> -
>  void drm_sysfs_hotplug_event(struct drm_device *dev);
>  void drm_sysfs_connector_hotplug_event(struct drm_connector *connector);
>  void drm_sysfs_connector_property_event(struct drm_connector *connector,

