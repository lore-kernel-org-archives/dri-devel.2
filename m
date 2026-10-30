Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB73F606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 05:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Q0SWjC+u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1551C10E698;
	Fri, 30 Oct 2026 05:53:48 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 620AE10E680
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 05:53:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7Sntr+hiNyDkbk/jxYhyoKzMYaMPMXlvjLQAXXJVmjow8GHtGQPtRjIe2ymNgPxGyp05Si4z4IP9PBp8cGCgIbwvD36Mlyk7QwaIiCLnfPn9HDn//SzGMvVt/BQyR31qyJ6xGDtfkbyAY98gqgrwPdOHQ8hQSVPjKHMs6WDBT6PO31XjdoDBS6S6R6cGG29tZRnyQZcY/N3Vog8raq7Xoz0n9KhFcbFWRm87jQQKyPgb8nQ4DIJl2FeVdy8lJ8jfbbbu51IT7ze8dMrgcNDzpS6trRaxHxar2G31816/PDQQjcaWfDAURXI8JdhXw+GcZ/KVHB5HPo4GivKh34Z2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kT9TLGo6XRIOrevfd1ExeW/9TdUPnFCY2qEeGdwAY6s=;
 b=wo/vaSSPUVYvaD0sznl1MoA/gYLTVq+AFxFX76B0+zwJMUZZJW/sj0NB9bWG80MNVksDlLPrSShEjrumRoHWaqCNENvohvnNuKGpAUyr15qlj96F3USvYpPyzCLApyt9r1LT7fYYkF5lFuALpHfSZh37QE5OzVAlOpkHQdni4lJZwFBV96M8keyxXN5F42tHCnukezyTUfGjb5KAOBmQfokYHvdhFV2IYatirkbcholcz7Zb4P8CBJrL8D7i79W5pvvoioPlsSleKyr28eZXD61mGSobnfn1tqbkNxlUkafzg4tsg6PjKJc8XlrsXzgnV5P0WSfUi7uKHU02d50XdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kT9TLGo6XRIOrevfd1ExeW/9TdUPnFCY2qEeGdwAY6s=;
 b=Q0SWjC+uAqL1BrytnX+ZOjT4baid5Az3OHYIm4P7wbBtO9ZoCxnG54oPYRVpVW+lv+YxTZ5a4Nm07Oh1DSFrLc2b76yPiWNbbWIPz8GYyoK+7JYxVgatzW5ymlgdYaUFRa0djo2UJKMakXx6l/ySNuZ9GQzXEcmLdjPxcAzYujs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12)
 by PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 05:53:36 +0000
Received: from SA0PR12MB4383.namprd12.prod.outlook.com
 ([fe80::825f:2fc7:9ad8:520]) by SA0PR12MB4383.namprd12.prod.outlook.com
 ([fe80::825f:2fc7:9ad8:520%3]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 05:53:36 +0000
Message-ID: <7a822adb-ddb5-4338-8949-3ccb0942e0a0@amd.com>
Date: Fri, 30 Oct 2026 11:23:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vmwgfx: Fix use-after-free race in vmw_dumb_create()
To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
 dri-devel@lists.freedesktop.org, zack.rusin@broadcom.com
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
References: <48e6780670395107cc9853bf63fa7ac1d034cdd7.1793249917.git.jayapalashwin.nair@amd.com>
 <DMHS7SIDIUGJ.168385UCMC4QI@broadcom.com>
Content-Language: en-US
From: "Nair, Jayapal Ashwin" <jayapalashwin.nair@amd.com>
In-Reply-To: <DMHS7SIDIUGJ.168385UCMC4QI@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0155.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::17) To SA0PR12MB4383.namprd12.prod.outlook.com
 (2603:10b6:806:94::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4383:EE_|PH7PR12MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: a48145c5-1483-4b81-861e-08df364a23af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|7416014|261026140227099003|11063799006|4143699003|261028144727099003|56012099006|261026121527099003|261021135927099003|261009223027099003|261009221227099003|261009223327099003|261009221727099003|261009220027099003|261022105027099003|261022075727099003|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 50hs5WtOMtyvYqN73mwXxzJm73zKvxDHOoJil3ZUyvHsBnwSyumhnosG4nvXTfgH+DUUXo/ZX3+t5EWlJojsdKuQeI3LXvl7RoMszscqlICeYTam9Yp2qazNAd6CNk7f8PzXS1z87in5PSoAQH4e3biStBOnWVCXfMFM+JvRwtOey4qhkXpuooKrUZkOa6kcD4rcTAE4XzIV+LsebC0thvDPKTa0PmIX4tIhF5SjbWhqMI/+8dV/IaJkYMZDzXAir42ZXkvWj0RpPTjHutXoUkFmqxwz+3Rb8LImpTvAgnI2tOx3BIVXR3cGoj3gYSu7Gq119keHeyXhGeY/grc8585mcu3B4dFxt40PZA9QL3HmAuqBABWAPwCWGlBLoenSCdRYVTd3f7aowY9nNZoE5cRxHOsIlUSJzRVxwUsO9oMQsP5FMNXzUmGH/OCX1QzIwhNSRD7UQTKMzaqx8TDkpDGVSvLICdsvYktmU4tOSFelXu39w7DqdVoVL22pJuP72DwgA4vO/AMcCweGr0v3bbkj/ZtAVBY5EZ4SucfqoeBCuJwWs4kjmHDyt4aPSd5WBGjV7DS0UD2UAF6OLvHxq6luNQ2LdGECWS4qP5yD4EsaWERInqEsA5tJY4ymTf4YwDmYzY5u8IAEOPSgzsRPcssVaGRn9yfMSOyGzjSC8XQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4383.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(261026140227099003)(11063799006)(4143699003)(261028144727099003)(56012099006)(261026121527099003)(261021135927099003)(261009223027099003)(261009221227099003)(261009223327099003)(261009221727099003)(261009220027099003)(261022105027099003)(261022075727099003)(10067099003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHpzbHBlRnBlNzhhQzQ5eXZMMDUxNU96RHgrZzdYUUVacjJ4L0lvM2VoVzdy?=
 =?utf-8?B?N3RRL3BNclJLUFVGby9idUMweWlNZTllUCsvVnBpcll1Yzd0bWNQNHYxcDJP?=
 =?utf-8?B?Z1lrZThiMUx0NVdERy9zUk9FQ2dOd21aNEEyQkpKZ2FrVzlkYUh2aXdrdE91?=
 =?utf-8?B?aWx5R0MzWkFpTDJLcHg3WEViOElWOFBQUWJoS3dqeXo2eVhtNG5pSEVyTlUv?=
 =?utf-8?B?ekxnUU81aG1HS2M3RlZLRjZITjVSaUNYbTl2UG1TL01sSTVKL3dPRWQ4Qi9q?=
 =?utf-8?B?L3JNV1NqVC92Ui9pTXMvSUNpQTluQnVNRHN2S2loVUxkaG5EaEZIcTdmYkts?=
 =?utf-8?B?UWZERzFuTjRNVm9pSXk0bUwvalBJODd6WkdKemQ3TEpwanRCRnlqbW93a09X?=
 =?utf-8?B?TjhURUhReGlrQTAzV2RGMFFQa2Z4MDBzc2pkZjQvSmxlNDZkeVRkTUlzOXlh?=
 =?utf-8?B?VzY3Ti9NdE9LaXRBV2VVeFVEd0ZWamgrSTlFOVJKWXN4RkJGSVVRbElQaGt2?=
 =?utf-8?B?VjhvSGRkRDNQcnFPMkxaOWFhOWhqbDBqWFdlUEhYaW50SDcrWGl4bDRrZlVw?=
 =?utf-8?B?UE5QNlp4czVkS2xRUFMxQVZVSG1ZTUgzK2FEU1pjOG1SbVQrMzRwRGp5UzZR?=
 =?utf-8?B?OGdIZmo2NzhvTXBHZ3Nyd2UzRTNMTzBnR0svWTFwSm9yY2FNaENYeEY1KzVt?=
 =?utf-8?B?VFVMZitPY0NYNk8reU1vRE5NN0xoUDVFVzUya1YxTWlsZWk1NzRYNHIrNStE?=
 =?utf-8?B?U2NBL2tmbW90RVZaYW5BS3lramNFWmdKdTJjVk85U2tRYnFNUE5Za1VDS01V?=
 =?utf-8?B?VnFOdGEwaytZbDNKWEJFMnZjcVFYUDBHMWRyd3E5VlNVWkVaM0ZzV0tKT0tZ?=
 =?utf-8?B?S0FLdXh1dXJva0QwaWwxZkdqZERKQ2dyNVhzSW5na1RXQ3kzVG01aG9vYW9u?=
 =?utf-8?B?c1dveXl2V1ZuNlo5c1BwMFdNY3dpVTFuR0p5KzM2VzhqOHEvK3VHeXAwQ2ps?=
 =?utf-8?B?NFVKWWc3elZpSERWNVlxeTIvSjc1MHlXcklHK2xyYkt5TnVwVUpXRFVRNkM2?=
 =?utf-8?B?N3dBS3loQ2pKc0l2M09pY0RBbEFVeWJTd2tkNndJREl3VFkwWUZXa283a0lR?=
 =?utf-8?B?cWZZR293QVpxaEpyanJUWEJCSXkzRnNteWtmNWRSMHd2aUp5OTB6UGEvZTdm?=
 =?utf-8?B?Y3FXdVR1N2JwWS9WYVJFL3Nxd01ac0dEUEhLUE4zZ1h2MlVHMi9wSDBtUHR3?=
 =?utf-8?B?bXRMOENqR2hINVNuOHhqQndnUGtBMHBic3lCb0JLVW9oUmdrTUI1QjArbFZJ?=
 =?utf-8?B?bDZ5Z1QwYktpRTkrZFd5bmJ1Vk5XeEt1YXJTcmdmL0o0U1BWNUNiV3E5SnB6?=
 =?utf-8?B?ZTZHVC9lazdERjRsTVdTaWd3UkRySkZ5cFZrbjJCRWdYVTJVRXRSb1VlOGgv?=
 =?utf-8?B?eTFOSHJTWlptZ25WeEtCY2dwQzhJUTE4S1o0SUdnVWQrb0VhRDJ2RnpSOGJH?=
 =?utf-8?B?U2RLL3hjNU9rOFFQbmw2cUplVGl1TWRUQXlsUXh0dVdDM0tGTHI5SkI5ZkVl?=
 =?utf-8?B?N25MN3NPdU05Q24vN3ZnUUFHc0d6YWNFWGh6MnRYRHBFOHpKVnVzcGJ2aVRJ?=
 =?utf-8?B?OTBobDd4OXFpb3JvRldGMCsyV1ZRN1MwWUxPNitpZnRLVjNHVlQ0eC9KRlo2?=
 =?utf-8?B?MEdJbUZ0THhUc3lDZWFZaWQ4dmVOdTZjV0pkOTZsUlk4Q0JlbVBqdHZRdDlp?=
 =?utf-8?B?YzlseVlPbHRYU3RZWlJGVmx3eXY4V01ORHk0YWg5YzY3a3ZXdjlNZWIrY3h3?=
 =?utf-8?B?S29ZejFGQU44VGhhN1RtOWVnTlJsUldpUXFGVGZ3V1dnVFVEcld2NUo0bzRy?=
 =?utf-8?B?TDMycFZYbS9TLzY5LzVaajQyQ2U5MjRQZFFNaC9IeDFoU2w1M0NyTEtrT3Ru?=
 =?utf-8?B?bnpUdkdHRkZ1Yit6Mlp3cG5xaGh5akRoNDdvamtsT1lVVG0rQzdFQ1c3NFl2?=
 =?utf-8?B?R2V3azI1MXJSRWNtVm9UN3Jmek5ua3RLU2ZRZXFQd0dSMGF5QVhPN3BHZnBq?=
 =?utf-8?B?RmVablJQck1IRURBNGZvWmFaRWxUaFI5WUtRYlBYSnpGVTRmbXY3UldYY3pq?=
 =?utf-8?B?aTJ3VDBibE5YbTFXbkt5TGRrQnJ2OElFdW00SzhVcDNxTDRYbml6YjhtdmFj?=
 =?utf-8?B?NGUyVmhmcXV1cU44VzZ0WXdCRWdkSUh2U2FmWDBXRUFwMEVvTWsyVFFKM3pD?=
 =?utf-8?B?RVpzcEhwczRpL3pFaElqMWFHMWlFVE9UL0RTeGJjayswQ3ovVitkTnlyRUhD?=
 =?utf-8?Q?ZzW32TV/EADhnSGvQo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48145c5-1483-4b81-861e-08df364a23af
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4383.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 05:53:36.5447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imP2gAmLlBwZcJrK4EGcWTA2V2bfOdxUAIjw+Z28hfF91APLuMuiex9dUaXtWwgF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5596
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 30-10-2026 06:59, Maaz Mombasawala <maaz.mombasawala@broadcom.com> wrote:
> How is userspace able to see the gem handle to call DRM_IOCTL_GEM_CLOSE
> on it before DRM_IOCTL_MODE_CREATE_DUMB has returned it?
> 
The handle is installed in file_priv->object_idr by
drm_gem_handle_create() inside vmw_gb_surface_define_ext_ioctl(), before
DRM_IOCTL_MODE_CREATE_DUMB returns it, and GEM handles are predictable:
idr_alloc() hands out the lowest free id starting at 1. On a freshly
opened fd the dumb buffer gets handle 1, so a second thread on the same
fd can spin on DRM_IOCTL_GEM_CLOSE(1), getting -EINVAL until the handle
appears. Once closed, id 1 is free again, so the race can be retried
indefinitely.

I tried this methodology and got a KASAN splat:

 BUG: KASAN: slab-use-after-free in vmw_dumb_create+0x705/0x850
   Read of size 8 at addr ffff88810fd5b2d0 by task poc/228
   ...
   Allocated by task 228:
    __kmalloc_cache_noprof+0x166/0x3b0
    vmw_bo_create+0xbc/0x660
    vmw_gem_object_create_with_handle+0xf9/0x190
    vmw_gb_surface_define_internal.constprop.0+0xe23/0x17c0
    vmw_dumb_create+0x415/0x850
   ...
   Freed by task 228:
    kfree+0x216/0x450
    vmw_bo_free+0x414/0x640
    ttm_bo_release+0x3bc/0x9a0
    vmw_dumb_create+0x6d9/0x850
   ...
   The buggy address belongs to the object at ffff88810fd5b000
    which belongs to the cache kmalloc-1k of size 1024
   The buggy address is located 720 bytes inside of
    freed 1024-byte region [ffff88810fd5b000, ffff88810fd5b400)
   ...
   BUG: unable to handle page fault for address: ffffffffffffffb0
   #PF: supervisor write access in kernel mode
   RIP: 0010:vmw_dumb_create+0x667/0x850
   R12: 0000000000000000
   Kernel panic - not syncing: Fatal exception

The read is vbo->dumb_surface (offset 0x2d0); it comes back NULL and the
subsequent usurf->prime.base.refcount_release = NULL store faults at
NULL - 0x50.

> --
> Maaz Mombasawala <maaz.mombasawala@broadcom.com>
> 
 
