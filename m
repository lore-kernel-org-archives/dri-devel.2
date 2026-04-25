Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C49FF885C
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 14:41:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32BD710E226;
	Sat, 25 Apr 2026 14:40:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S2rwSufN";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013032.outbound.protection.outlook.com
 [40.107.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 107D010E1EA;
 Sat, 25 Apr 2026 14:40:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8XAJy2DBQKbWn80WxuOzYkSruA8Z3GEbAjVNn6k7Z47oCdGfAsECWxThcZlxgYcNNApSWOm5WdlZdtLYQ8If8VMGw6h6/c2podY/3lIFueMZMYu2JBh3EE/OVpda3pZSLerGdZyx/GrRj9Nx8rvjpnnV0z9v4ST5aBq/5EDghup2vqTywgXtj2C4Jwsip5Ml4usmKQXFvITQUhfoBF6BNg2sgrr/Vfcmd/LaKYtAcI2JueiZdKYqB/jfmtNOSf8UrVd1gSd/tvxsHvqX8p4tbCjTAA1aUAfP1+PAkOaQi1bo4xR/zZDpcjhQHl+0zbLUZtW4djzgnv5sc0QXlSRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U763d/6lgn/YGmzRECH0eCIACTa0S2e3ORMsORIcRTQ=;
 b=eeBueCLUtug0JjQT3RNJ7qHwg6Sm3kAQfNOxRyDHGK3NNuFDTK4aAEEZxyBP69iLFkcOLW/+YyI6rYkKMeKa886pjkDLB6/AvRZDq5a45Y19YD9DXL6WzEaWASgmrQH8Q3XbmTSVFrBSCa7XHSyAlLBxJlb5Vm7NhgHyajHh1cjVa+mSi6dwxzRYT4G6JwI+E66NqPOPL0E1jhhKnq9sMRpqKwHF1c6sJPCf/DcwuagOkJH6+IiBtwjEq69W1QlbCCJFiDLGS+EbHX4eZV80tOi4m4ZZ0Eoyh9mqgcVI3S+rjc+TJvTtD2Ev4AakVUHkooNJDv6k+tC71iR872VGZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U763d/6lgn/YGmzRECH0eCIACTa0S2e3ORMsORIcRTQ=;
 b=S2rwSufNk/N6PzSId8R63qjRPunlP8M6qk+xTqfbtt0hCRMCpHECeAD1AVksyFK3q5vZHALSw1UIPNBJuQ0//eJkd92q0n9dz/rr6IyzENjCpFInX6PhrEAwctBNGyPP8RtvVlMSxcn4/x03W0rYcHQXxsTgSyXBj6pyHeqD/ys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SN7PR12MB6960.namprd12.prod.outlook.com (2603:10b6:806:260::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.12; Sat, 25 Apr
 2026 14:40:52 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 14:40:52 +0000
Message-ID: <bec9ab80-cbb5-4e2f-afcc-e20221a365a2@amd.com>
Date: Sat, 25 Apr 2026 09:40:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] drm: link connectors to backlight devices
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20260424220953.167058-1-mario.limonciello@amd.com>
 <20260424220953.167058-4-mario.limonciello@amd.com>
 <k632yfxvm4od52pnnbclclffo4l73c3ztwysrwnkp5lfgpddfq@4ddwbap7o7vt>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <k632yfxvm4od52pnnbclclffo4l73c3ztwysrwnkp5lfgpddfq@4ddwbap7o7vt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0042.namprd04.prod.outlook.com
 (2603:10b6:806:120::17) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SN7PR12MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca36ed1-8ca4-43e8-cdb5-08dea2d8a670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: gvpAg/X8rIV0jYcA0nPYss2DOOYwaOlY631TZJV4zjXMEtdrzNSylTnSR9nDPGWlqAU5vNbcDkmDEAc3u2IGbixxab7YA6Z1aDcGmh+zc0fi+SwoAwmCR9RtAComzflHjMyhaMhU/JVcxUjf+rXBaG1PG5NN8sReh4e9Bx/TVULExaAViP7jlLR+HSW9y6dzOuVHO6+K2mJZMICs7zfBERWRCObF9/umPLFdRS+Jk5j80A2+LsPmdGpGAgKWrslDRqmssFxX/1ChhFU0vT3yEj6FMaGPgLo0LropSGZpkRq+VQlL2JVSVEUpkyHQ6P3FAU43UU2NHvJ5bfoDxJxtolnYtLghWMVBR5W4Klf7YUy+C5AIxEo/THUiXYKQOtO4pA5FJ5orz2lioV7a6VPaYFknMkVaWx9BsxROiuk4skiJ59a4A6DnOrWGHYUWDVf+DB3GGLkbg7qLbGMvG/qgwmxKLUpTk668ioGNM5y5+7PXGE4qvjpK+qf7hwyV0Z+Gy2/BcRdHp48TIbUkapa5oKX4mdHooxgJ7za9O1tRUGEAk7UzmplskazL146KhhBeYFuhGp1m3lXzgN+oQcc+kAEfemD6to3LdK2eYXttMHzcJ4uviW3T8Mc6rwdtxlsxnTOlkBqkVwRaLZ1wymnMMN1azdT2ZWi3ejvQKcFP3MAWjPzF1jGXsdkZz39UJWcbr6cgNM6FlGJUjVLPWIqUxtpqMZucaZ9/XfWBT+q5R8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDhaSVNmL0pMQjk0QTA5R05WSEN5emhrZHBXNENPRjNXSVJOWHBuRWt3NWZ4?=
 =?utf-8?B?eW1DcmRtUWc4Uzkrc3hSM09WZVZiUC81L2VMd1pDTW9CaWdiRm55c1FOYkd1?=
 =?utf-8?B?OElidVRWRXdYNDZMVG5JVnNLRUdaY00rK1puVi9XQTh6bEZzWVNnRjZGdXo2?=
 =?utf-8?B?aWMyWkd1RmtEWHRhNXp6Mk4yekVvZWw2NC85VGdabDNHaDhlc2V1WUtEMm9O?=
 =?utf-8?B?bGhLeHNqTEFRZ2IyVlZ4cFI1TGNsbGU3Tml1eW04RHZUVlg0N3czTzQ3OGFa?=
 =?utf-8?B?cStNS0RQVXVQZElTM3ZxUnBENXZPTENXbTBHRkgvOHRZcGc3d0J6UkFJODY2?=
 =?utf-8?B?bmRCMk10MWJuNWtxblJDWjdjUGsrWENaMlZneUhGakhOUXErSWFQck9EN0hU?=
 =?utf-8?B?L3d2QkhuRmlwKzg4NE9UbU16VGczZHNkcm02ei9POHZtQnpFN2JaRXoydG9V?=
 =?utf-8?B?bTdMZUtPeHZLd2xUeWFzWWJoUGhDRVlSUmcyNGs0MVdrMHM4VVdzZ1AyKzFj?=
 =?utf-8?B?aTlNZ1NIN2ZXT3V5c2lGMWNLMFJ6TG45a2JzQThUNm54ZndnM3QvTjEyWE4x?=
 =?utf-8?B?MU85aFl0R3BJMEl0amkzMXZzMVFnZ0t0Y0RVc2lMaTQ4aUdNcHpZUjU4L3Vx?=
 =?utf-8?B?aGgrbTliWlYwWnk1NXNybVFranpPdVNJM3NQdk9pZ3RlbnM5NzAwQWdUWGFE?=
 =?utf-8?B?Z0lRWmxOQ2I4VFQxRTYzbGM1RUpkR0xHOUFIcEdMT2R5ajhuYzh5bE54aGlX?=
 =?utf-8?B?dDVBaE5paXE5aUh6TkJySWtsM2lJbmNkMEZJZW5iRXB5amxWdko3RS9ETks4?=
 =?utf-8?B?L3pwbzAyc0NnbXpBUjQ2WWE0bDR1WExoSDVQMzVqbEpnTGRYU2MyZzkzcVZY?=
 =?utf-8?B?Q3pGVjlZQk1nKytBaTl5cHdIVi9zZUEyVCtzWVdkRlVFSlJod3VDMWtnOG0r?=
 =?utf-8?B?dG1BTDRsdGZON1VKTlNDZzZ0Qi9IZWhyWSs1MUFqOEpnVHErWE1sdnRsVWVr?=
 =?utf-8?B?SWNLaGw2ZjBFMmYzTHRYNWZyQUM5WU1QL3hSS1J0Y21HbGZTK21HZzNLcE1s?=
 =?utf-8?B?VUhheW1TWnE1cWNxQk5XMVlMMjZER1pmQVZoUjc3WmhUWEdaMWlMUXl6S0xE?=
 =?utf-8?B?bmJPcXNSODAwZkQveURlMUozRTM2Z2pvRThUQmdkd2RnR2xTL1J1cnZyU0sv?=
 =?utf-8?B?TEJJc0NJbWhQeUNpQnBSUkR4a0JQYjY5aVBLVTRha1Azclo4SlVJd3FmRmdq?=
 =?utf-8?B?Z2krUHRvUHhENUFPREtzOFdqa05MSnVSRFFqdU5FTXZ6R3dIblluVnZOem9S?=
 =?utf-8?B?c281ellsZHM5OTN3c0EzUzdHUk1Od0w4a015Y0xJR01HSXJOeFV5ZDYwNFgy?=
 =?utf-8?B?MUhyUHltcGdFckVpRHFLNjk3bnBTZ0lhV2VtNnlMRGxQOE5ZU20zUlFrVEJy?=
 =?utf-8?B?dGdaNEpubHR5SjFBUzR6cll3MVkyRW43TVBkMXY2ZFE1bWV5bVU5eDZEaWJx?=
 =?utf-8?B?Z1ZaKy8zL2tkY096Z1E4aEpMUStUamw0QU56UGZIWTAxQWppVk5CQmxOL3Zl?=
 =?utf-8?B?N295UFAxbUFoN3JxQzdnRjVFZlhvZndYcDhTOUxaYVNiZXY5bVJIRWFlNnUx?=
 =?utf-8?B?RG1TR1dqQWlRVWFDUWlsQ1IzSWVZMDg4NWVTRWFBOVB3YlMyMHV3cFBkT0VP?=
 =?utf-8?B?K1VCaW9JZDJ0cGZwQ2NsZDdDeFp3d05raVJXQnBIcXNWUXVGdGg0TlR1Tlh4?=
 =?utf-8?B?Y2twSGt4dERKdldlR2I3ZE9KYjA3Ri9uOU9ONDg3aTNKVFhvdGYrYjJnd1JK?=
 =?utf-8?B?Yy91NkVySnVrZE12d01UOG8weE8raTI4bHh3SFp5eURhQVNxQ1grVDZzMXRa?=
 =?utf-8?B?Y3p4WUhyckw3U2RUNDlFY2d6ODBySHIvU3JvMWl6K2lmTTBTdGpuS0xuY3pI?=
 =?utf-8?B?cGFEYmZLZHZlRkZGM0VjYW0vMllOTmJISzNyOEJETHVudFd3RnpWOFdvTE0v?=
 =?utf-8?B?MGVaTXc3dFpJcXVNYzBXRXd4a3kxL0VtemZyYmx0eFZwT2FnUERaTHN6SWht?=
 =?utf-8?B?SFczUEtsdnIrcEJmcGw0bWpoTk90SWFteUlvQVVROWtycDczaVM5RzJxQ2Jl?=
 =?utf-8?B?NFZtME55RnJFeUZGRUduVWNPbS9FREZ1MjN2a2RPdnkzUEJYOTFtNzA1OCt2?=
 =?utf-8?B?SGNhbWt1Q0FBRUJnYzEvQnN1Y1l3K1VjMFZ1WHF4YVUzVWtoNlFJeU5ickYw?=
 =?utf-8?B?OHFETFJhZ2NwckRodjhRZEoxYmM5emlyNGtHbDdDT2hEMjBoYUxCbEtrVC9w?=
 =?utf-8?Q?fYjSKSXEJemYPsdZLx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca36ed1-8ca4-43e8-cdb5-08dea2d8a670
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 14:40:52.5125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +KWpEWi6ablFdYTYhdB9Wowoci+ve2lqcFBXpegVuzml6hMjMzz4pf6n2EquM0TPNfHRPHIB954em4BBPZWSOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6960
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



On 4/25/26 07:41, Dmitry Baryshkov wrote:
> On Fri, Apr 24, 2026 at 05:09:48PM -0500, Mario Limonciello wrote:
>> This adds generic backlight-device support to DRM connectors. Drivers
>> that need to link backlight devices to DRM connectors can use the new
>> helpers to create a backlight property and link them at runtime.
>>
>> Also add a brightness changed notification so that sysfs and DRM connector
>> can stay in sync and handle property updates around DPMS.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/Kconfig             |   1 +
>>   drivers/gpu/drm/Makefile            |   2 +
>>   drivers/gpu/drm/drm_backlight.c     | 406 ++++++++++++++++++++++++++++
>>   drivers/gpu/drm/drm_connector.c     |  12 +
>>   drivers/gpu/drm/drm_drv.c           |   8 +
>>   drivers/gpu/drm/drm_mode_config.c   |   7 +
>>   drivers/gpu/drm/drm_mode_object.c   |  66 ++++-
>>   drivers/gpu/drm/drm_sysfs.c         |  54 ++++
>>   drivers/video/backlight/backlight.c |  17 ++
>>   include/drm/drm_backlight.h         |  45 +++
>>   include/drm/drm_connector.h         |   3 +
>>   include/drm/drm_mode_config.h       |   5 +
>>   include/linux/backlight.h           |  13 +
>>   13 files changed, 637 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/gpu/drm/drm_backlight.c
>>   create mode 100644 include/drm/drm_backlight.h
>>
>> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>> index 8f5a8d3012e41..8c00f534d50b8 100644
>> --- a/drivers/gpu/drm/Kconfig
>> +++ b/drivers/gpu/drm/Kconfig
>> @@ -17,6 +17,7 @@ menuconfig DRM
>>   # device and dmabuf fd. Let's make sure that is available for our userspace.
>>   	select KCMP
>>   	select VIDEO
>> +	select BACKLIGHT_CLASS_DEVICE
>>   	help
>>   	  Kernel-level support for the Direct Rendering Infrastructure (DRI)
>>   	  introduced in XFree86 4.0. If you say Y here, you need to select
>> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
>> index e97faabcd7830..9912306e94950 100644
>> --- a/drivers/gpu/drm/Makefile
>> +++ b/drivers/gpu/drm/Makefile
>> @@ -78,6 +78,8 @@ drm-$(CONFIG_DRM_CLIENT) += \
>>   	drm_client_event.o \
>>   	drm_client_modeset.o \
>>   	drm_client_sysrq.o
>> +drm-y += drm_backlight.o
>> +drm-$(CONFIG_DRM_LIB_RANDOM) += lib/drm_random.o
>>   drm-$(CONFIG_COMPAT) += drm_ioc32.o
>>   drm-$(CONFIG_DRM_PANEL) += drm_panel.o
>>   drm-$(CONFIG_OF) += drm_of.o
>> diff --git a/drivers/gpu/drm/drm_backlight.c b/drivers/gpu/drm/drm_backlight.c
>> new file mode 100644
>> index 0000000000000..cbc6a855ed332
>> --- /dev/null
>> +++ b/drivers/gpu/drm/drm_backlight.c
>> @@ -0,0 +1,406 @@
>> +// SPDX-License-Identifier: MIT
>> +/*
>> + * DRM Backlight Helpers
>> + * Copyright (c) 2014 David Herrmann
>> + * Copyright (c) 2026 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#include <linux/backlight.h>
>> +#include <linux/fs.h>
>> +#include <linux/list.h>
>> +#include <linux/math64.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/notifier.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +#include <drm/drm_backlight.h>
>> +#include <drm/drm_connector.h>
>> +#include <drm/drm_device.h>
>> +#include <drm/drm_mode_config.h>
>> +
>> +/**
>> + * DOC: Backlight Devices
>> + *
>> + * Backlight devices have always been managed as a separate subsystem,
>> + * independent of DRM. They are usually controlled via separate hardware
>> + * interfaces than the display controller, so the split works out fine.
>> + * However, backlight brightness is a property of a display, and thus a
>> + * property of a DRM connector. We already manage DPMS states via connector
>> + * properties, so it is natural to keep brightness control at the same place.
>> + *
>> + * This DRM backlight interface implements generic backlight properties on
>> + * connectors. It does not handle any hardware backends but simply forwards
>> + * the requests to an available and linked backlight device. The links between
>> + * connectors and backlight devices have to be established by DRM drivers and
>> + * can be modified by user-space via sysfs (and udev rules). The name of the
>> + * backlight device can be written to a sysfs attribute called 'backlight'.
>> + * The device is looked up and linked to the connector (replacing a possible
>> + * previous backlight device). A 'change' uevent is sent whenever a link is
>> + * modified.
>> + *
>> + * Drivers have to call drm_backlight_alloc() after allocating a connector via
>> + * drm_connector_init(). This will automatically add a backlight device to the
> 
> I'd like to point out another kind of devices which might have been left
> w/o notice here: the panels. In a plenty of cases the driver creating
> the drm_connector (frequently through drm_bridge_connector_init())
> doesn't even know if there is a panel on the other side of the chain or
> not. Likewise connector creation doesn't involve any panel-related
> operation. Some panels provide backlight controls. Others don't and rely
> on the external backlight controls (see drm_panel_of_backlight() for
> example).
> 
> Can we work towards simplifying possible support for DRM backlights to
> the setups with drm_panel in place?

But to userspace it would interact with a connector not a panel directly 
right?

So doesn't the current design work well enough for this?  When there is 
a panel backlight control it could be added; and if there isn't just do 
nothing.

> 
>> + * given connector. No hardware device is linked to the connector by default.
>> + * Drivers can set up a default device via drm_backlight_set_name(), but are
>> + * free to leave it empty. User-space will then have to set up the link.
> 
> This sounds like a definite no-go. Think about any phone or any laptop.
> Do we need to involve userspace to let the kernel know that there is a
> connection between the DRM connector and the backlight present in the
> system?
> 
> What is the usescase for having dynamic connector<->link connections?
> 

Allowing userspace to setup the link was something in the original 
series by David and Marta that I left in place.  I don't have a problem 
with dropping that concept and requiring the driver to do the linking.

