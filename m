Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318A2CD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 12:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E9EE10E7D7;
	Mon, 18 May 2026 12:06:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wYV0vUgd";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 155E410E7D7;
 Mon, 18 May 2026 12:06:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0JPh85cypjVSs/HbfsNuHGHY68JWF0KkYwNG109n154mRjComVuXSxuVUWZlNPlIQ+DLYLr/rO/kicmMWpKLoHNU1hs8x7OQbUHT1SMvyInIjRO6vwzrzdOerTG96vTqXx3d+iA3Yy52vKAJtf8OWY497eMRQhk/2tOaH4Spq5s/HiRloNJbJftO8hwUXUv/97OSb8g9KkLCgwKcKz1f2OKo453a0ZJXIW3lTeRv3ETWXozxR2o0KJqhBRE+Vglmq2kO93ZXGLn/Yg/Ks7SHv/daOPh8bavkVDAh1L7cdPPPMtwN9TZ/tGa0Dh0bDQujYeOPjGJ+xt9p3KhmI8SKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASI6c8leuYmDiVqrKryFZ8HPJQqUU/5+I7X5J72JEjQ=;
 b=UDAnHfEoIoXiEUD+qE9Gejmr/fS3gzoYq2fN+TTViN6SfU8qvfmZ52/b27rsRO6neYAVBP3288V2q9eKgexh3BfWfPm7gT7m0jJT7ygQLXQbEc1lI88xk7voO2Hvq4HgryeEnI7Yb4yppkZAytTdOIDCiZuEOZtvJHF3EJXZyRGF9JqKHUAmfGhhPDOy5Oq01K4+QxE4u8qIHEOuZ/T9Ww60MRZPMkekYBJLhhsVzQA6RsH0mtjKnmmRvA0PKul9bkvMd2XMSr5cB5sbvKCdngKtCyZphxebU8TtruZYhlhgQBlXgwuAPQZ57ahBZNHmiFlKNgr0KuFk624xgcpvDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASI6c8leuYmDiVqrKryFZ8HPJQqUU/5+I7X5J72JEjQ=;
 b=wYV0vUgdn0brPH+0w9TdsBun97aENBSIcq80uT5MJI/zscxrHVb1gJ+3q+bg4JUoppN19asaddSrUkxymTYkDesmXmQVdSUCin0EfQy1bU6DhSBrGKZA4rC5eiPJPc7VuXs9cY6TtJMqWeSOEa6h7iA6jSDKGgTwkAd02OshSqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LVUPR12MB999160.namprd12.prod.outlook.com (2603:10b6:408:3a4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Mon, 18 May
 2026 12:06:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 12:06:25 +0000
Message-ID: <8602a990-e557-45e3-8b3a-f9e6aaa00e0d@amd.com>
Date: Mon, 18 May 2026 14:06:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] misc/syncobj: add new device
To: Julian Orth <ju.orth@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-doc@vger.kernel.org, wayland-devel@lists.freedesktop.org
References: <20260516-jorth-syncobj-v1-0-88ede9d98a81@gmail.com>
 <20260516-jorth-syncobj-v1-12-88ede9d98a81@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260516-jorth-syncobj-v1-12-88ede9d98a81@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LVUPR12MB999160:EE_
X-MS-Office365-Filtering-Correlation-Id: 460be9ec-f18e-4246-68f1-08deb4d5e27b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|4143699003|3023799003|11063799003|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: oSQcW+7BITq+NYaNdWClcKBnFBX+sTj/keH6guagmFGnLsWpgvuBEacRTFYrln5wsAIMwBPjDL9B9Tm0unT5aLWOMjzzKeKR2esOtOEvBH7n/Q9MmyLcaYq8xkH2T9AK9mei1u9cE/PYFqgr6L8QvsP4IRZ5Nkrv30GlaLn3AVkic2n405z8ACb9+29Ut9KgiNQmf/YMy+T/jZdRc6EzJiqwWW2acp1UHMwhHKuxOiHYVc1CBoYec0pQXr2NMTIMmGBNrOrhFrYz8DMBNA1UlBwpYMGnwHTai0vWG90w78QKJeR806nfrMX2wYrsZrJ9Mn3R1ZXts+S3x9rOzKuwLcoRHFOoj1N9Hi4IbM1PSWuoSnGNBc5D6d7C0ru6F4K7agrPJPF27dt4zmFMMmtQiCIxIXWDCSAIIOzDIfv0edY2nHsA5gYTEcx6PZAOg7FJTfIlYAA0dKNEuhtnynjSYlu0LePzRc/xcusQ7uZAdMvJrcl2rvt4+2Px6rUNMGFfiOkVbW3J9kFfrB0iVuIGLFBa62NTG8Xi7wd+8SwmwT6WllIppy/i3Cjru9ZGB22UjmcJOpUH35q4OwJ7gc8Cma4bP9PQTddLKcKnWhT3WJ/OpY/1ODzo8iCLnrCgw4SpPCYkLd/23UlEciX7xuyFt/rDssUSuRWZuUuSj6FGZjrElvS34H6xJctUDYZ/RWhOxIONwmk+XqaJf2d87knvyr6tOV/GBGE9SOfzgVXaiLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(4143699003)(3023799003)(11063799003)(56012099003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXZoZFpiRzUzQ3BEL2FqVFQxYlRMdk9BZnE1a1pqMjBia0FzYWhLZlVPOEJQ?=
 =?utf-8?B?WWkvbVEweXNzR1NTWEdHYlFqVEUxTXNobUNzR1ZISDJ2UzN0OXMzYjNBRnBs?=
 =?utf-8?B?ZkN4Q2ZFWUZ2dE9TZktXeHJPVjZoVXZLZktkOGpyTmFiTGU2ZFRzeXFuWXNW?=
 =?utf-8?B?V2UzdU4vQkZXWlljNG92Wm1CUnpzbFhwWU9ETXdnWFlCYTYxS1RobjVURFlv?=
 =?utf-8?B?cDBpTVhFTUp2UkZzdGtzeituRzFBbG5iVXR2cGR4eUsxaGpOOExuaGdQWVVX?=
 =?utf-8?B?d09JRTlaZmNnYnBFa2lPQ042UFkyS2Q4QmNXUy9GY2ZiZWY0KzlXcUhsRXFM?=
 =?utf-8?B?RlNWcTN6OGh2T2JvNDlUQ3MzTmFhdit2emZGUFZyRjd3NDJGNWhualEwY0ZD?=
 =?utf-8?B?WXoxTWgvUEg4UnR6dE83c0dvaFhISnh5U1FrcUFraUdOUWJiTjRNKzlHcGJp?=
 =?utf-8?B?aTRyZ1lNZkJlenF2U3NOT2x3bE4rejdUZlU0VGIyQ0h3NTBQaVZRUFhiMFZl?=
 =?utf-8?B?VWJmeU54bUt4SzMvTVgzNkx2VW56b1pET0c2alFzeE0yaklTY2grRmlEOHY5?=
 =?utf-8?B?ZmVyWGg0QTN6cEN5WG53RjU3aTh6VTN6cEdGb2lpS0puZ3pEa0o5Sm93QWxP?=
 =?utf-8?B?eGNpb3UrdGlMVkp3K0RFM0ZUOFJtcnB6aXBtNHE1UXE5QXROUTJBM29ma3FZ?=
 =?utf-8?B?MzhwR0wxMlRxbXRLZkJ3R1A1QTFIblFRdENzckwrMmZUanBIRG1RV25oL2pM?=
 =?utf-8?B?TWNJQm4zUWdXNW9LQmJqNmU1MXFhQzJtcGJiVnI1YUVvMDFCZTIyZVkvaHV0?=
 =?utf-8?B?Q0ZSZjExbEROelpaVjJuU2xpeisrUkdhSHc5M1psQ0xIRnlldVhMc2N1U3pU?=
 =?utf-8?B?M2dXV2RNK0hlZ01zS0tDQnpPZklSUFVrU0pVQjFaS1JBOVdzUFBkTnF6TTN4?=
 =?utf-8?B?N2xFclQ4Skg3cUlCb1ppcGJ4Mm5rc1ozNGg4YVV4enZXNDZXY2VCbWs3Qmdx?=
 =?utf-8?B?UDkzZ3FrZlhvSHVsaFp1ZXkyUHJJOUJxaWlJM2Q0WUhYK3pBZ2g5ODBmdEd6?=
 =?utf-8?B?NnBrN0NwdzBjcnVoc2pZd0g3R0FsQTVlTTBmQlg4a0M3UFR4Y0xwNE93QUU2?=
 =?utf-8?B?dWFuSmIwL0pwUC9iSTFBUjR5SjBlYnYya3FIWEQyYm9qamZkT24vTDJvYnh5?=
 =?utf-8?B?c2p4a05GSFRGOGRvYXhFV21XcHVQbWQ3VFk2VlQrWE1rSExGbDZXeVBTOGV0?=
 =?utf-8?B?aHlKOWxBN3ZTVk03NjJyRjBLaUFTOGhhS3crNThpYksyN0Q2aThrb01tREJQ?=
 =?utf-8?B?OUtMQ1hhenA5ckFNOVdVN0VmZE1kUFVTcTEyaUVQSHVSV01DYW4rNFltVjhY?=
 =?utf-8?B?WFFDdDNWOUdNVUsvTll1VStCeUk3NFFrZjVsM0dMZU5uVE42dGp5V2NTN25a?=
 =?utf-8?B?UnZlcythODV1UGljOGhPbWFQR3FGMkZ4cnlvUHROZDQyYnJFQjI4Y21DMHJj?=
 =?utf-8?B?eDVBMHlPYk5mbG5pcjhkZTZFQVBOeS94bDdhN1JPUi9RYW5wWXRFWTJoMjhn?=
 =?utf-8?B?Y1F5SE5XUHRzUU9iQk1sSE9wTzQxYTl6NDBJYS9xK2FHQmlxVlJGRW40T3NF?=
 =?utf-8?B?WldTVU4xdGpYZnJBb3cza3MxNWZiU0ltSXFRcURtQVlVaFFNRndDRW1URXpC?=
 =?utf-8?B?MURuZ3lPS0NWa1pvTlpzR3FVYTdTblpKbjhvQjN4dWtsSDFwQjMyMmNhTGJQ?=
 =?utf-8?B?V1BscFQrY1VqT3NlZjh1RHhtenJPZHJhalZpWTJ0ckhRa053RDBxUDB0R0Uz?=
 =?utf-8?B?SmdBRzlmWE43RHhRdEpOb2hqRGpSMmVxalN5TlExUTMwdnluZTJsQkdGcmJs?=
 =?utf-8?B?TjIvL2xITjY1SVJ3eHo1R3g5OHkxNld2NGgvRVhqMTc0UFluck9xYTJjbGtx?=
 =?utf-8?B?TjdOdkpuQUcvRHErelBkeHJSaW1QNzNRTGk5OEtZakZhdy84MDNyeXowZWtD?=
 =?utf-8?B?dGZ0SEFLc0dFUHl0amtubkhEc3pOMDhSTTUybjdQaUVKTk9hS043R0NUcm1w?=
 =?utf-8?B?MkRDNW12dkRiOFF4c2lMZVU4STZxUitEdXp6YWFhU1NCZzhRZGJ0bXpPUjVS?=
 =?utf-8?B?SU11RkViQy91NS85ckJ3d0pYc1BtYnNzODlBWnppb3RXREdLYnZyUXVHaXN0?=
 =?utf-8?B?eUpzeDMwVzZuUEhnMHdKQ0dhdW1SaVhGMHpIUVZKb2g5OE1NMS9qM2NJc1dw?=
 =?utf-8?B?VnZvY0FIdlpTdkJmZUtlckhaMHluazZidnBvNzRqTFhmYlZBUTM2WWVkNHdr?=
 =?utf-8?Q?m2phzgSnZi/gJB/rFu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460be9ec-f18e-4246-68f1-08deb4d5e27b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 12:06:25.5584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NefEDun5CFGzhyhYycrzVGitWuZ44HZVCaPslCqBHF2mbdwRmJJDouqGItOSQJbz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999160
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

On 5/16/26 13:06, Julian Orth wrote:
> This device makes the DRM_IOCTL_SYNCOBJ_* ioctls available via a
> dedicated device. This allows applications to use syncobjs without
> having to open device nodes in /dev/dri, on systems that don't have any
> such nodes, or on systems whose devices don't support the
> DRIVER_SYNCOBJ_TIMELINE feature.
> 
> Wayland uses syncobjs as its buffer synchronization mechanism. Most
> compositors use the DRM_IOCTL_SYNCOBJ_EVENTFD ioctl to perform a pure
> CPU wait for syncobj point. DRM devices are not involved in this process
> except insofar that a DRM device needs to be used to access the ioctl.
> 
> Similarly, a software-rendered client might perform rendering on a
> dedicated thread and use the wayland syncobj protocol to submit frames
> before they finish rendering. Again, this does not involve DRM devices
> except insofar ... as above.

That use case is invalid.

Usually drm_syncobj can only be filled with dma_fence objects and it is impossible to create one of those for software rendering.

What could be used is the drm_syncobj wait before signal functionality, but that usually requires special handling on the Wayland/Compositor side which as far as I can see doesn't make sense here either.

So the justification to use this for software rendering is very weak. Either I'm missing something or that is not going to fly at all.

Regards,
Christian.

> 
> As an added benefit, this device removes the need to translate between
> file descriptors and handles.
> 
> Signed-off-by: Julian Orth <ju.orth@gmail.com>
> ---
>  Documentation/userspace-api/ioctl/ioctl-number.rst |   1 +
>  drivers/misc/Kconfig                               |  10 +
>  drivers/misc/Makefile                              |   1 +
>  drivers/misc/syncobj.c                             | 404 +++++++++++++++++++++
>  include/uapi/linux/syncobj.h                       |  75 ++++
>  5 files changed, 491 insertions(+)
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 331223761fff..5e140ae5735e 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -395,6 +395,7 @@ Code  Seq#    Include File                                             Comments
>                                                                         <mailto:michael.klein@puffin.lb.shuttle.de>
>  0xCC  00-0F  drivers/misc/ibmvmc.h                                     pseries VMC driver
>  0xCD  01     linux/reiserfs_fs.h                                       Dead since 6.13
> +0xCD  00-0F  uapi/linux/syncobj.h
>  0xCE  01-02  uapi/linux/cxl_mem.h                                      Compute Express Link Memory Devices
>  0xCF  02     fs/smb/client/cifs_ioctl.h
>  0xDD  00-3F                                                            ZFCP device driver see drivers/s390/scsi/
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 00683bf06258..c1e7749bd356 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -644,6 +644,16 @@ config MCHP_LAN966X_PCI
>  	    - lan966x-miim (MDIO_MSCC_MIIM)
>  	    - lan966x-switch (LAN966X_SWITCH)
>  
> +config SYNCOBJ_DEV
> +	tristate "DRM syncobj device (/dev/syncobj)"
> +	depends on DRM
> +	help
> +	  Creates a /dev/syncobj device node that provides DRM synchronization
> +	  objects (syncobjs) without requiring a DRM device.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called syncobj.
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index b32a2597d246..9e5deb1d0d76 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -75,3 +75,4 @@ obj-$(CONFIG_MCHP_LAN966X_PCI)	+= lan966x-pci.o
>  obj-y				+= keba/
>  obj-y				+= amd-sbi/
>  obj-$(CONFIG_MISC_RP1)		+= rp1/
> +obj-$(CONFIG_SYNCOBJ_DEV)	+= syncobj.o
> diff --git a/drivers/misc/syncobj.c b/drivers/misc/syncobj.c
> new file mode 100644
> index 000000000000..11ef46ddfeef
> --- /dev/null
> +++ b/drivers/misc/syncobj.c
> @@ -0,0 +1,404 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * syncobj.c - Standalone device for syncobj manipulation.
> + *
> + * Copyright (C) 2026 Julian Orth <ju.orth@gmail.com>
> + */
> +
> +#include <linux/fdtable.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/uaccess.h>
> +#include <drm/drm_syncobj.h>
> +#include <drm/drm_utils.h>
> +#include <uapi/drm/drm.h>
> +#include <uapi/linux/syncobj.h>
> +
> +static int syncobj_array_find(void __user *user_fds, u32 count,
> +			      struct drm_syncobj ***syncobjs_out)
> +{
> +	u32 i;
> +	s32 *fds;
> +	struct drm_syncobj **syncobjs;
> +	int ret;
> +
> +	fds = kmalloc_array(count, sizeof(*fds), GFP_KERNEL);
> +	if (!fds)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(fds, user_fds, sizeof(s32) * count)) {
> +		ret = -EFAULT;
> +		goto err_free_fds;
> +	}
> +
> +	syncobjs = kmalloc_array(count, sizeof(*syncobjs), GFP_KERNEL);
> +	if (!syncobjs) {
> +		ret = -ENOMEM;
> +		goto err_free_fds;
> +	}
> +
> +	for (i = 0; i < count; i++) {
> +		syncobjs[i] = drm_syncobj_from_fd(fds[i]);
> +		if (!syncobjs[i]) {
> +			ret = -EBADF;
> +			goto err_put_syncobjs;
> +		}
> +	}
> +
> +	kfree(fds);
> +	*syncobjs_out = syncobjs;
> +	return 0;
> +
> +err_put_syncobjs:
> +	while (i-- > 0)
> +		drm_syncobj_put(syncobjs[i]);
> +	kfree(syncobjs);
> +err_free_fds:
> +	kfree(fds);
> +	return ret;
> +}
> +
> +static void syncobj_array_free(struct drm_syncobj **syncobjs, u32 count)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < count; i++)
> +		drm_syncobj_put(syncobjs[i]);
> +	kfree(syncobjs);
> +}
> +
> +static int syncobj_ioctl_create(void __user *argp)
> +{
> +	struct syncobj_create_args args;
> +	struct drm_syncobj *syncobj;
> +	int fd, ret;
> +
> +	if (copy_from_user(&args, argp, sizeof(args)))
> +		return -EFAULT;
> +
> +	if (args.flags & ~SYNCOBJ_CREATE_SIGNALED)
> +		return -EINVAL;
> +
> +	static_assert(SYNCOBJ_CREATE_SIGNALED == DRM_SYNCOBJ_CREATE_SIGNALED);
> +
> +	ret = drm_syncobj_create(&syncobj, args.flags, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = drm_syncobj_get_fd(syncobj, &fd);
> +	drm_syncobj_put(syncobj);
> +	if (ret)
> +		return ret;
> +
> +	args.fd = fd;
> +	if (copy_to_user(argp, &args, sizeof(args))) {
> +		close_fd(fd);
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int syncobj_ioctl_wait(void __user *argp)
> +{
> +	struct syncobj_wait_args args;
> +	struct drm_syncobj **syncobjs;
> +	signed long timeout;
> +	u32 first = ~0;
> +	ktime_t t, *tp = NULL;
> +	int ret;
> +
> +	if (copy_from_user(&args, argp, sizeof(args)))
> +		return -EFAULT;
> +
> +	if (args.flags & ~(SYNCOBJ_WAIT_FLAGS_WAIT_ALL |
> +			   SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
> +			   SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE |
> +			   SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE))
> +		return -EINVAL;
> +
> +	static_assert(SYNCOBJ_WAIT_FLAGS_WAIT_ALL        == DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL);
> +	static_assert(SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT == DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT);
> +	static_assert(SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE  == DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE);
> +	static_assert(SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE   == DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE);
> +
> +	if (args.pad)
> +		return -EINVAL;
> +
> +	if (args.count == 0)
> +		return 0;
> +
> +	ret = syncobj_array_find(u64_to_user_ptr(args.fds),
> +				 args.count, &syncobjs);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (args.flags & SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE) {
> +		t = ns_to_ktime(args.deadline_nsec);
> +		tp = &t;
> +	}
> +
> +	timeout = drm_timeout_abs_to_jiffies(args.timeout_nsec);
> +	timeout = drm_syncobj_array_wait_timeout(syncobjs,
> +						 u64_to_user_ptr(args.points),
> +						 args.count,
> +						 args.flags,
> +						 timeout, &first, tp);
> +
> +	syncobj_array_free(syncobjs, args.count);
> +
> +	if (timeout < 0)
> +		return timeout;
> +
> +	args.first_signaled = first;
> +	if (copy_to_user(argp, &args, sizeof(args)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int syncobj_ioctl_reset(void __user *argp)
> +{
> +	struct syncobj_array_args args;
> +	struct drm_syncobj **syncobjs;
> +	u32 i;
> +	int ret;
> +
> +	if (copy_from_user(&args, argp, sizeof(args)))
> +		return -EFAULT;
> +
> +	if (args.flags)
> +		return -EINVAL;
> +
> +	if (args.points)
> +		return -EINVAL;
> +
> +	if (args.count == 0)
> +		return -EINVAL;
> +
> +	ret = syncobj_array_find(u64_to_user_ptr(args.fds),
> +				 args.count, &syncobjs);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 0; i < args.count; i++)
> +		drm_syncobj_replace_fence(syncobjs[i], NULL);
> +
> +	syncobj_array_free(syncobjs, args.count);
> +	return 0;
> +}
> +
> +static int syncobj_ioctl_signal(void __user *argp)
> +{
> +	struct syncobj_array_args args;
> +	struct drm_syncobj **syncobjs;
> +	int ret;
> +
> +	if (copy_from_user(&args, argp, sizeof(args)))
> +		return -EFAULT;
> +
> +	if (args.flags)
> +		return -EINVAL;
> +
> +	if (args.count == 0)
> +		return -EINVAL;
> +
> +	ret = syncobj_array_find(u64_to_user_ptr(args.fds),
> +				 args.count, &syncobjs);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = drm_syncobj_timeline_signal(syncobjs, args.points, args.count);
> +
> +	syncobj_array_free(syncobjs, args.count);
> +	return ret;
> +}
> +
> +static int syncobj_ioctl_query(void __user *argp)
> +{
> +	struct syncobj_array_args args;
> +	struct drm_syncobj **syncobjs;
> +	int ret;
> +
> +	if (copy_from_user(&args, argp, sizeof(args)))
> +		return -EFAULT;
> +
> +	if (args.flags & ~SYNCOBJ_QUERY_FLAGS_LAST_SUBMITTED)
> +		return -EINVAL;
> +
> +	static_assert(SYNCOBJ_QUERY_FLAGS_LAST_SUBMITTED == DRM_SYNCOBJ_QUERY_FLAGS_LAST_SUBMITTED);
> +
> +	if (args.count == 0)
> +		return -EINVAL;
> +
> +	ret = syncobj_array_find(u64_to_user_ptr(args.fds),
> +				 args.count, &syncobjs);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = drm_syncobj_query(syncobjs, args.points, args.count, args.flags);
> +
> +	syncobj_array_free(syncobjs, args.count);
> +	return ret;
> +}
> +
> +static int syncobj_ioctl_transfer(void __user *argp)
> +{
> +	struct syncobj_transfer_args args;
> +	struct drm_syncobj *src, *dst;
> +	int ret;
> +
> +	if (copy_from_user(&args, argp, sizeof(args)))
> +		return -EFAULT;
> +
> +	if (args.pad)
> +		return -EINVAL;
> +
> +	if (args.flags & ~SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT)
> +		return -EINVAL;
> +
> +	static_assert(SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT == DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT);
> +
> +	src = drm_syncobj_from_fd(args.src_fd);
> +	if (!src)
> +		return -EBADF;
> +
> +	dst = drm_syncobj_from_fd(args.dst_fd);
> +	if (!dst) {
> +		drm_syncobj_put(src);
> +		return -EBADF;
> +	}
> +
> +	ret = drm_syncobj_transfer(src, args.src_point,
> +				   dst, args.dst_point, args.flags);
> +
> +	drm_syncobj_put(dst);
> +	drm_syncobj_put(src);
> +
> +	return ret;
> +}
> +
> +static int syncobj_ioctl_eventfd(void __user *argp)
> +{
> +	struct syncobj_eventfd_args args;
> +	struct drm_syncobj *syncobj;
> +	int ret;
> +
> +	if (copy_from_user(&args, argp, sizeof(args)))
> +		return -EFAULT;
> +
> +	if (args.flags & ~SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE)
> +		return -EINVAL;
> +
> +	static_assert(SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE == DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE);
> +
> +	if (args.pad)
> +		return -EINVAL;
> +
> +	syncobj = drm_syncobj_from_fd(args.syncobj_fd);
> +	if (!syncobj)
> +		return -EBADF;
> +
> +	ret = drm_syncobj_register_eventfd(syncobj, args.eventfd,
> +					   args.point, args.flags);
> +
> +	drm_syncobj_put(syncobj);
> +
> +	return ret;
> +}
> +
> +static int syncobj_ioctl_export_sync_file(void __user *argp)
> +{
> +	struct syncobj_sync_file_args args;
> +	struct drm_syncobj *syncobj;
> +	int ret;
> +
> +	if (copy_from_user(&args, argp, sizeof(args)))
> +		return -EFAULT;
> +
> +	syncobj = drm_syncobj_from_fd(args.syncobj_fd);
> +	if (!syncobj)
> +		return -EBADF;
> +
> +	ret = drm_syncobj_export_sync_file(syncobj, args.point,
> +					   &args.sync_file_fd);
> +	drm_syncobj_put(syncobj);
> +	if (ret)
> +		return ret;
> +
> +	if (copy_to_user(argp, &args, sizeof(args))) {
> +		close_fd(args.sync_file_fd);
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int syncobj_ioctl_import_sync_file(void __user *argp)
> +{
> +	struct syncobj_sync_file_args args;
> +	struct drm_syncobj *syncobj;
> +	int ret;
> +
> +	if (copy_from_user(&args, argp, sizeof(args)))
> +		return -EFAULT;
> +
> +	syncobj = drm_syncobj_from_fd(args.syncobj_fd);
> +	if (!syncobj)
> +		return -EBADF;
> +
> +	ret = drm_syncobj_import_sync_file(syncobj, args.sync_file_fd,
> +					   args.point);
> +
> +	drm_syncobj_put(syncobj);
> +
> +	return ret;
> +}
> +
> +static long syncobj_dev_ioctl(struct file *file, unsigned int cmd,
> +			      unsigned long arg)
> +{
> +	void __user *argp = (void __user *)arg;
> +
> +	switch (cmd) {
> +	case SYNCOBJ_IOC_CREATE:
> +		return syncobj_ioctl_create(argp);
> +	case SYNCOBJ_IOC_WAIT:
> +		return syncobj_ioctl_wait(argp);
> +	case SYNCOBJ_IOC_RESET:
> +		return syncobj_ioctl_reset(argp);
> +	case SYNCOBJ_IOC_SIGNAL:
> +		return syncobj_ioctl_signal(argp);
> +	case SYNCOBJ_IOC_QUERY:
> +		return syncobj_ioctl_query(argp);
> +	case SYNCOBJ_IOC_TRANSFER:
> +		return syncobj_ioctl_transfer(argp);
> +	case SYNCOBJ_IOC_EVENTFD:
> +		return syncobj_ioctl_eventfd(argp);
> +	case SYNCOBJ_IOC_EXPORT_SYNC_FILE:
> +		return syncobj_ioctl_export_sync_file(argp);
> +	case SYNCOBJ_IOC_IMPORT_SYNC_FILE:
> +		return syncobj_ioctl_import_sync_file(argp);
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +}
> +
> +static const struct file_operations syncobj_dev_fops = {
> +	.owner		= THIS_MODULE,
> +	.unlocked_ioctl	= syncobj_dev_ioctl,
> +	.compat_ioctl	= compat_ptr_ioctl,
> +};
> +
> +static struct miscdevice syncobj_misc = {
> +	.minor	= MISC_DYNAMIC_MINOR,
> +	.name	= "syncobj",
> +	.fops	= &syncobj_dev_fops,
> +	.mode	= 0666,
> +};
> +
> +module_misc_device(syncobj_misc);
> +
> +MODULE_AUTHOR("Julian Orth");
> +MODULE_DESCRIPTION("DRM syncobj device");
> +MODULE_LICENSE("GPL");
> diff --git a/include/uapi/linux/syncobj.h b/include/uapi/linux/syncobj.h
> new file mode 100644
> index 000000000000..c4068fbd5773
> --- /dev/null
> +++ b/include/uapi/linux/syncobj.h
> @@ -0,0 +1,75 @@
> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_SYNCOBJ_H_
> +#define _UAPI_LINUX_SYNCOBJ_H_
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +#define SYNCOBJ_CREATE_SIGNALED			(1 << 0)
> +
> +#define SYNCOBJ_WAIT_FLAGS_WAIT_ALL		(1 << 0)
> +#define SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT	(1 << 1)
> +#define SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE	(1 << 2)
> +#define SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE	(1 << 3)
> +
> +#define SYNCOBJ_QUERY_FLAGS_LAST_SUBMITTED	(1 << 0)
> +
> +struct syncobj_create_args {
> +	__s32 fd;
> +	__u32 flags;
> +};
> +
> +struct syncobj_wait_args {
> +	__u64 fds;
> +	__u64 points;
> +	__s64 timeout_nsec;
> +	__u32 count;
> +	__u32 flags;
> +	__u32 first_signaled;
> +	__u32 pad;
> +	__u64 deadline_nsec;
> +};
> +
> +struct syncobj_array_args {
> +	__u64 fds;
> +	__u64 points;
> +	__u32 count;
> +	__u32 flags;
> +};
> +
> +struct syncobj_transfer_args {
> +	__s32 src_fd;
> +	__s32 dst_fd;
> +	__u64 src_point;
> +	__u64 dst_point;
> +	__u32 flags;
> +	__u32 pad;
> +};
> +
> +struct syncobj_eventfd_args {
> +	__s32 syncobj_fd;
> +	__s32 eventfd;
> +	__u64 point;
> +	__u32 flags;
> +	__u32 pad;
> +};
> +
> +struct syncobj_sync_file_args {
> +	__s32 syncobj_fd;
> +	__s32 sync_file_fd;
> +	__u64 point;
> +};
> +
> +#define SYNCOBJ_IOC_BASE		0xCD
> +
> +#define SYNCOBJ_IOC_CREATE		_IOWR(SYNCOBJ_IOC_BASE, 0, struct syncobj_create_args)
> +#define SYNCOBJ_IOC_WAIT		_IOWR(SYNCOBJ_IOC_BASE, 1, struct syncobj_wait_args)
> +#define SYNCOBJ_IOC_RESET		_IOW(SYNCOBJ_IOC_BASE,  2, struct syncobj_array_args)
> +#define SYNCOBJ_IOC_SIGNAL		_IOW(SYNCOBJ_IOC_BASE,  3, struct syncobj_array_args)
> +#define SYNCOBJ_IOC_QUERY		_IOW(SYNCOBJ_IOC_BASE,  4, struct syncobj_array_args)
> +#define SYNCOBJ_IOC_TRANSFER		_IOW(SYNCOBJ_IOC_BASE,  5, struct syncobj_transfer_args)
> +#define SYNCOBJ_IOC_EVENTFD		_IOW(SYNCOBJ_IOC_BASE,  6, struct syncobj_eventfd_args)
> +#define SYNCOBJ_IOC_EXPORT_SYNC_FILE	_IOWR(SYNCOBJ_IOC_BASE, 7, struct syncobj_sync_file_args)
> +#define SYNCOBJ_IOC_IMPORT_SYNC_FILE	_IOW(SYNCOBJ_IOC_BASE,  8, struct syncobj_sync_file_args)
> +
> +#endif /* _UAPI_LINUX_SYNCOBJ_H_ */
> 

