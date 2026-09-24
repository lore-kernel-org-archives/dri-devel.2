Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB31C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 11:20:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A94610F46A;
	Thu, 24 Sep 2026 11:20:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4z0yE+rG";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D94C610E0EC;
 Thu, 24 Sep 2026 11:20:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avzPYfBYTRB+eZdQvftl2Ucghe9/b0mLWwV2EyRqI5wCFg/PTgHcjhKyod/xn163hQnnRhstdwT4KCI22lSXCZ5WEqSnNuScDVC5hWQiJmjAb3PNr4PZIDUv3gFP6S5s3QHR4MR0u/7qSwwH1Puyx5XbEcZodIRciBpb5YEYYFctio5bYEOS+sDxFf5eQlbyqakcGv1MgKrxncflNOrK70izZrAVOzu30KGoC2XUMoO0WzZx93AbZqxfwiTddO7ici3pgkDNe8GoDwwRzjJj3qE88Ilkw2qEQ19er5czcUskr2+Im7ieBE3yv0YkZ++g+kdLdRFEQ3vpSAXtayCRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAgyQqwUUU2wQjkVcEBpeF3W6YQL9T00Ax7FcUAaZOw=;
 b=Ag2/pvl4/p7p9SylpVn4mQleC0tKb8+DH2qtMvq+2F7KDwkKmmWG66MgCJ4REvw+H8C08kJZ899U+6WVklJVak0mEtdnkT17wTIBA5wS7dAl6f+9/BrdblVjav7XmleE0QocNsKXiSru29uXsgiHaHr0lHstkpB0lk6ERQWYFVa53HA6mSyM5ucUZ8rKsApx33FP2RZCqYD2LT/aTKIBDbL1/QjS67YG/PDYLXMi6GTXFR9n/wAQyrdpZVpc0b62nzbiOscXBRtkYGvNwOJlNxjt9KegH40FKtXHI3UYylQPspvmEa7tXGtnbsTWERVEV55R+32b3DDz8TWSnaVr1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAgyQqwUUU2wQjkVcEBpeF3W6YQL9T00Ax7FcUAaZOw=;
 b=4z0yE+rGuLfXos3aibfp1xwVjbHj8UbG7ym0PYTZzpdGM+zRfRN6SeDkW6ZKZz9c8LPCxM3ywY+DBmR6zuXWjcgcsYnTdRYVOpINLFKfz4hGaQJIiOwrXwg6ycEh00INwunRtvhdilw7omovbGc6kIzHvERuMbItOEEIDEphZyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8133.namprd12.prod.outlook.com (2603:10b6:a03:4af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Thu, 24 Sep
 2026 11:19:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 11:19:58 +0000
Message-ID: <bcff99b0-4933-4f31-a2ee-dc88da13d207@amd.com>
Date: Thu, 24 Sep 2026 13:19:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm: Provide a drm_dev_release_barrier() function
 to wait for device release callbacks
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Matthew Auld
 <matthew.auld@intel.com>, dri-devel@lists.freedesktop.org,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20260924080455.25458-1-thomas.hellstrom@linux.intel.com>
 <20260924080455.25458-2-thomas.hellstrom@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260924080455.25458-2-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: ccba61ee-f74d-42df-ba9b-08df1a2dc454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|5023799004|11063799006|6133799003|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: oAWv6TghBhr6APUvPcsaTxZBseZrIfGoyPh7x+04pUl3Tb1+ULgRIeX8jypRxJQU3zR17h/s4MXQNjub1EJtH8INSwCbD6heBIwHcrhZrG+X1FEJEi5gj9dTDrB87CqbBS+N4wXlxj4EpzN4yC+taqtTETs6fiTIm/Ur1s+gSggs3+PdMIvVydkjI5fno0c7PKd3Xj0bUMqhm0pmNPSF8wKRSDphxpIgp+6yJgVhUmxVeVcgad3/Avh7tsld0rlWzKbWphHIhhng43gZwwN1kgPIuU5E9x6wlaL3OIk5xBAQPXhHbnii19OkSbflqGLjjwfXo08yUPIIKKEDSnGmPmSmS3fuE3N7aSvrXdSf2+vmg5+7HFYg3liwd06H37CrviWJmFvf5ovaamCS68Sn7uRzhIviPdCVtanIRShDRuTWHCV3aOBO36yYMb63f6Yo5NGQxtGKE2IkB4kOtz3V79GIhBHpQFWCyZoY6QjdeeT2WUCLSu/vp5UyY5bp81Yxkx6Wu7q/fuYeBawmhg5cUGVSn9NCh3F2wSqulqmObIIQHwa5wcYvJ5aCQHXhp80fUymucoIudJ7qV+PCCeJYsbceEsn3oV3Zk3vRUn54aaQxwo2wDcqa8J2zk49NoTEk2u497HAVcaEykcjIz3HSzaHhPe6ibCAU1IqYTsJPpAs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(5023799004)(11063799006)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1dFeHNyZG9xZERDWVF6L2JMNlhzQ2ZENWwyaHV5K0FCWUZtTlJVTkozc3dv?=
 =?utf-8?B?VVFYbUpGamFoRmtwYUhSMnBFY0FOQmJBdzJRMXpBaXhDd0tIam9DdHJPb0VO?=
 =?utf-8?B?eS8zbjltVTVKcWtHQmpsYW9pU0pGckFWMjA2RE9DcE5qTUZiYnVwUzR2SHRI?=
 =?utf-8?B?R0kzR1IwNnBabERkQ3JZSk5TWmlMSFg1Zmt1NWpoTGVSTHViT1FHUFZ0NHJH?=
 =?utf-8?B?UXpwT0ZnTE9HcWpkbnQvcTZDTjdxbys5M3YwZllRc0o4akdQc05meWF1Yk1O?=
 =?utf-8?B?NzZwMkZLWDd0TXJaakZKZHJhTzBxZlRWay9hWDJlakY2anNVZmpBaGVFdXVV?=
 =?utf-8?B?QnliS1kvYkRRUkNMeUtwZmdFbHRMSEF2cjBpUWdUYlVoT2t3SmdIdUJFMnBz?=
 =?utf-8?B?UFFzdWVNVU13M3IrQlIyNjJwR1lwclFqaHdub09zakdybGNXandUODBDZUVK?=
 =?utf-8?B?M2tKTHRDZU5iUEhjZ2xzdzVJejJEczl1aUsxV3paTW1OSzBROUZlYVRWR2xa?=
 =?utf-8?B?SG9URHluTmhrNVVMUE1qakE1V0ZqcFZaSlVyV0ZaR2Z1R3lXcmFYejhLWUxP?=
 =?utf-8?B?L0JwbnorQnYvWlYrVW5VWFo5OXdBa1BaRGhpWWNZVERCbStvM2lYSk1nM1ZH?=
 =?utf-8?B?M3d0azBTbkpRL2h2dXhhTW4vazA0cWFHTncwREJXWi9NOVVhdE1ld1ZNUWky?=
 =?utf-8?B?K085ZFJZN1QzZUFMeWJYMUFzZVQvWmJlVFFkM2tFTFhRSjFnK1owdG96QUdj?=
 =?utf-8?B?cG9yOUlyUUl1VTBVcFFXcmw4U0gyNk1PTTI1aU9KeXpHdTJ4ejNlWlVPQUo4?=
 =?utf-8?B?Q2M4R0JZT3daQU1FM2hYQ29GSDhzQ3BHMnp5Zktod3Nzd1p5VENCSC80ZFpx?=
 =?utf-8?B?R29IRW1YKzlKNnlqclVrcE54WUhGc2RhNGF0WWxTcVZZRnV6a0xKSDNqeE9J?=
 =?utf-8?B?S2dmWklENE9RcE1FQjN5Qy80NlBRREl1ZFVFa2xIZFpRSHN4VGh0VHFSMk9T?=
 =?utf-8?B?WXliemJpNnNWOEZndGdwSWwwUXpQVkcwUXQ4OHlZaW1aSEFiVGhoNmRXY1d1?=
 =?utf-8?B?K2JwU3JwL3l5V3F2ckxxdlIrRmgxdnZOZ0h4a1VSV2QyM0F6MmdXNk1pdmpp?=
 =?utf-8?B?TWl4UEhyeWZMRnRCamR5a2w4WStDVUp2Qlo1UHE3S3BoOVZJN0tEYldRUnVZ?=
 =?utf-8?B?ZFAxbzVYOFhIcEt0akdFWWVVSGRsUVd3WVZ1cDVhOE8wSnFRT2Nlb1N2T2hI?=
 =?utf-8?B?cGJ4d3dIdmpTUVRZaXAyZU1WWWk5TzNUeGtXeCt0WDRWSXEzOEFrYS9qbmY1?=
 =?utf-8?B?RHRndzZIOWlRQndXTHBLYnorQko4NkE4V1AzUHQ0bGNRSWJQNmZvUVhkVVZF?=
 =?utf-8?B?ejNuRjdpRVJFUmVnQnZZbzJHcTBiUFFoSGdZcVorNDd0UGpzdkNhN1cwQTd5?=
 =?utf-8?B?dk9UdXF3UytLUEU1ZDlsRzVYS1ZaQVdTNkt5ZWh5YWs4aU12L0V2dzNrYUVz?=
 =?utf-8?B?VVMyd1JIOFd4M0xJdVFnSnFuR3FsdWw0U0Rkd054S3daK0REWDlKb2NRYVJy?=
 =?utf-8?B?emdFVmk1UmFkUmYzVGI3OWJhVEV1MnVWVTFablM1UDN5c29wZkNTYklVZWpI?=
 =?utf-8?B?NEJVeXFhbk8rZUJYUFVtaE85ZmJoNjFEcjZzY0l3SzZudjNIc3pOOElGbDlV?=
 =?utf-8?B?dXliNHcxWE9zdU8yVzR0R3M4RXV1a21va0VhN2ZGaVU4WkpxekhIRHY5NGpm?=
 =?utf-8?B?T0J5dG5nWnNvS3JkbnhNRUJGeXlpeTNDN0xwV3V0RXVWdnhLaFBoV3prckFn?=
 =?utf-8?B?WjJ4VEVKazNXRmZITW1iWnhCajlUc1dGektTUW9Zb2JtNFhLcHRacEtCVzFs?=
 =?utf-8?B?cHhHQjZ2Ym9SSHQrejFsZTRLOHRqTHZTOXRNU1lyUDFlazlPRitMWm5wWjVH?=
 =?utf-8?B?Kzh0V1RFaXAyOFFqU1lGRzhyMVRMRjlEbGFyeDBuaFJCNmdVLzJBWUZDdXdt?=
 =?utf-8?B?UGloSUJzclVzblNycEdod3FlTFB5NmpPb1FzdkdYciszRnVDeG5hTjRtTlNL?=
 =?utf-8?B?VVRpZ3dwWTBzL0F2L0liOVNaQTRWZjE1dFRIS0xlOVQwbkUzME43MEZOc3A5?=
 =?utf-8?B?MGZ2elBLZ3d5NmpVVnYxZjNpbUVZSkpDZExDSk1HVVV1cE9ueFRjM1A3UEhI?=
 =?utf-8?B?SHMrMi80a0tqRkpZMFAzTjNFRGlsYmtZRVdFSVptdlF1OXc1OUthaFpUdkVR?=
 =?utf-8?B?Mlpzc0VDNlhId3ZOMFNtc1hXSlB2NktBMklnVWRiNERSY0p4WTNtam5UQVBZ?=
 =?utf-8?Q?adO7Hf6ntdKgBlnpK5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccba61ee-f74d-42df-ba9b-08df1a2dc454
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:19:58.0741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M29LstaagrH5RaSQjF9ndwVxr12/7AlyenIxodkszzL0T6f9hDv34dqu8mL05wD2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8133
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

On 9/24/26 10:04, Thomas Hellström wrote:
> Driver and drm helper code is increasingly relying on holding a bare
> &drm_device reference (drm_dev_get()) without also holding a module
> reference on the module that created the device.
> 
> For example drm_gpuvm_init() takes a drm_dev_get() reference on the
> &drm_gpuvm's behalf with no accompanying module reference at all, and
> drm_gpuvm_free() later calls the driver-supplied gpuvm->ops->vm_free()
> callback, which lives in the driver module, before dropping that
> reference. xe also takes bare drm_device references itself from
> several asynchronous contexts, such as GuC submission fence workers,
> EU stall, OA and PMU sampling code, relying only on those references
> being dropped before the underlying xe_device, and eventually the
> driver module, can be torn down.
> 
> If the module that created such a device is unloaded while one of
> these bare references is still outstanding, and the corresponding
> drm_dev_put() only completes after the module has already been
> removed, the driver's ->release() callback, any drm managed release
> actions, or a driver callback such as gpuvm->ops->vm_free(), all of
> which live in that module's, by then freed, code, can end up being
> invoked out of memory that no longer contains valid code.
> 
> Requiring every one of these bare drm_device references to also take a
> module reference, as drm_pagemap does today via try_module_get(),
> doesn't scale to shared helpers and driver-internal code with many
> call sites, and is easy to get wrong.
> 
> Fix this properly by letting drivers keep a drm device-count and
> ensure the module isn't unloaded until that count has dropped to zero
> and until any release callback that had already started executing has
> also finished executing.
> 
> To help with the latter, add a drm_dev_release_barrier() function.
> The function ensures that any caller that has started executing
> device release callbacks has also finished executing them.
> 
> Use SRCU for the implementation.
> 
> Rather than a single SRCU domain shared by all drivers, which would
> mean drm_dev_release_barrier() could unnecessarily block a driver's
> module unload on unrelated drivers' release callbacks, require each
> driver that wants to use drm_dev_release_barrier() to supply its own
> SRCU domain via a new &drm_driver.release_srcu field. Drivers should
> define a static SRCU domain (DEFINE_STATIC_SRCU()) and set this field
> to point at it. Leaving the field unset means @release and drm managed
> release actions for that driver's devices simply aren't synchronized
> against, and calling drm_dev_release_barrier() for such a driver is a
> no-op that triggers a warning.

That sounds like overkill to me.

I mean I can understand that you don't want to use RCU, but a single static SRCU for the DRM subsystem should pretty do the trick.

Regards,
Christian.

> 
> Since &drm_driver.release_srcu is a new field, every existing struct
> drm_driver instance in the tree was scanned to confirm none of them
> would leave it uninitialized with indeterminate content. All in-tree
> instances have static storage duration (plain or const static
> file-scope objects), or are members of a KUnit test fixture zeroed via
> kunit_kzalloc(); no instance is stack-allocated or heap-allocated
> without zeroing. Objects with static storage duration are guaranteed
> by the C standard to have any member without an explicit initializer
> zero-initialized, so the new field is reliably NULL, and
> drm_dev_release() simply skips the SRCU critical section, for all
> drivers that don't set it.
> 
> v2:
> - Use plain WARN_ON_ONCE() instead of drm_WARN_ON_ONCE(NULL, ...) in
>   drm_dev_release_barrier(), since passing a NULL drm_device caused
>   the warning path itself to dereference that NULL pointer inside
>   dev_driver_string()/dev_name() (sashiko)
> 
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Assisted-by: LLM
> ---
>  drivers/gpu/drm/drm_drv.c | 56 +++++++++++++++++++++++++++++++++++++++
>  include/drm/drm_drv.h     | 24 +++++++++++++++++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 0cdc606af8d1..32a03170383c 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -921,18 +921,57 @@ EXPORT_SYMBOL(drm_dev_alloc);
>  static void drm_dev_release(struct kref *ref)
>  {
>  	struct drm_device *dev = container_of(ref, struct drm_device, ref);
> +	struct srcu_struct *srcu = dev->driver->release_srcu;
> +	int idx = -1;
>  
>  	/* Just in case register/unregister was never called */
>  	drm_debugfs_dev_fini(dev);
>  
> +	if (srcu)
> +		idx = srcu_read_lock(srcu);
> +
>  	if (dev->driver->release)
>  		dev->driver->release(dev);
>  
>  	drm_managed_release(dev);
>  
> +	if (srcu)
> +		srcu_read_unlock(srcu, idx);
> +
>  	kfree(dev->managed.final_kfree);
>  }
>  
> +/**
> + * drm_dev_release_barrier() - Ensure drm device release callbacks are finished
> + * @driver: driver whose release callbacks to wait for
> + *
> + * If a device release method or any of the drm managed release callbacks
> + * have been called for a device created with @driver, wait until all of
> + * them have finished executing. This function can be used to help determine
> + * whether it's safe to unload a driver module.
> + *
> + * Assume for example the driver maintains a device count which is decremented
> + * using a drmm callback or a device release callback. From a drm device
> + * lifetime POV, it's then safe to unload the driver when that device-count
> + * has reached zero and drm_dev_release_barrier() has been called.
> + *
> + * @driver must have &drm_driver.release_srcu set to a driver-owned
> + * &struct srcu_struct for this function to have anything to wait for.
> + *
> + * This function only waits for the &drm_driver.release callback and drm
> + * managed release actions to finish. It does not, by itself, guarantee that
> + * whoever called drm_dev_put() to drop the reference triggering that release
> + * has itself finished running. See drm_dev_put() for that invariant.
> + */
> +void drm_dev_release_barrier(const struct drm_driver *driver)
> +{
> +	if (WARN_ON_ONCE(!driver || !driver->release_srcu))
> +		return;
> +
> +	synchronize_srcu(driver->release_srcu);
> +}
> +EXPORT_SYMBOL(drm_dev_release_barrier);
> +
>  /**
>   * drm_dev_get - Take reference of a DRM device
>   * @dev: device to take reference of or NULL
> @@ -958,6 +997,23 @@ EXPORT_SYMBOL(drm_dev_get);
>   *
>   * This decreases the ref-count of @dev by one. The device is destroyed if the
>   * ref-count drops to zero.
> + *
> + * If this call may drop the last reference, the calling code itself is
> + * responsible for ensuring it isn't unloaded (for example as part of a
> + * module) before this call has returned. This matters in particular for
> + * drivers relying on drm_dev_release_barrier() to determine when it's safe to
> + * unload, since that function only waits for the &drm_driver.release
> + * callback and drm managed release actions to finish, not for whoever calls
> + * drm_dev_put() to finish calling it.
> + *
> + * A common case is dropping the last reference from a deferred context, such
> + * as a workqueue item. In that case it's the responsibility of whoever
> + * queued that work item to guarantee it has run to completion before the
> + * module can unload, for example by draining a module-lifetime workqueue at
> + * module exit time. Holding a module reference only until the work item
> + * starts running is insufficient: that reference would already be dropped
> + * before this call runs, even though this call is what may still need the
> + * module's code to remain resident.
>   */
>  void drm_dev_put(struct drm_device *dev)
>  {
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index b23830494ed4..30bb8727a896 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -48,6 +48,7 @@ struct drm_display_mode;
>  struct drm_mode_create_dumb;
>  struct drm_printer;
>  struct sg_table;
> +struct srcu_struct;
>  
>  /**
>   * enum drm_driver_feature - feature flags
> @@ -255,6 +256,28 @@ struct drm_driver {
>  	 */
>  	void (*release) (struct drm_device *);
>  
> +	/**
> +	 * @release_srcu:
> +	 *
> +	 * Optional driver-owned SRCU domain used to synchronize completion of
> +	 * the @release callback and drm managed release actions with
> +	 * drm_dev_release_barrier().
> +	 *
> +	 * Left unset, @release and drm managed release actions for this
> +	 * driver's devices aren't synchronized with drm_dev_release_barrier()
> +	 * at all, and calling drm_dev_release_barrier() for this driver is a
> +	 * no-op that triggers a warning.
> +	 *
> +	 * Drivers that want to use drm_dev_release_barrier(), for example to
> +	 * help determine when it's safe to unload the driver module, should
> +	 * define their own static SRCU domain (DEFINE_STATIC_SRCU()) and set
> +	 * this field to point at it. Each driver should use its own domain,
> +	 * so that drm_dev_release_barrier() only waits for that driver's own
> +	 * release callbacks, rather than also for unrelated drivers sharing
> +	 * the same domain.
> +	 */
> +	struct srcu_struct *release_srcu;
> +
>  	/**
>  	 * @master_set:
>  	 *
> @@ -485,6 +508,7 @@ void drm_dev_exit(int idx);
>  void drm_dev_unplug(struct drm_device *dev);
>  int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
>  			 struct drm_wedge_task_info *info);
> +void drm_dev_release_barrier(const struct drm_driver *driver);
>  
>  /**
>   * drm_dev_is_unplugged - is a DRM device unplugged

