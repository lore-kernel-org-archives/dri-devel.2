Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93562CD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 15:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDCA610E451;
	Tue,  5 May 2026 15:51:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jP5C8Cne";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010026.outbound.protection.outlook.com
 [40.93.198.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 042FF10E451
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 15:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKqL77uIMc2kyorSqdrWihamLkDW2QKSDsPKAstY0n8+DU7DkSwajQdtffcVo62iE/nI8fjhgMKN2YwRFK0bvMbupBzYwIcKexLenzCzcfdwgnSwIGcBPHdS/urOHy/9PIDdsfSjqpYlUQf2ZJR9vTJ1tEMtvXTG0cuWOZf9r6byJrWsmVhWrHV13N4Lrc9fHjhNhY6pZoiP7mfGFLFHFFKeKQ4W8qFHu5/nYxEbcpSUD/HoJugvBuM+dPQeHTbeh6psAydTh78Oioj9hp6pdM0jzwsdlwdiyHQz248lxjdf0W/X0AlmrYCofl7+SYyEXExnItIwptd08b9sunaKOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tp1nIkSLuXxD94e4mrSbC051HzsB0ocn4gms5xgekk=;
 b=sgvzy2/ItVtmFfnMmgkrtvgCDhp2S43xLHiTFfDmcyg63l6ce3iLG7i2Qr3qVpGxKl3JIN+L0Idp5GdMCmabXREbXArFZOlJ/R0ftAn5rNB1lhvP/AzrFMOvf5JaXeKhCF5m8/wLspBCOEAo/CaiuMFl/GfTGtKQ4uOMBrn7EvHwWxvuQfvRyADASFO3kSIwoxgFzmuvS70sypfEKHQNC0yMJLtaEVh/L8ORfSh16iq09tEa92piZFzfflkMg/dNKEvVoFyOl6ihwOPT7pyG3o3fXTjKSD7Wc/fvRytAX+gHVgji3D+VgQE3nik/vgecr2CstSz9udcjg4coWLcgPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tp1nIkSLuXxD94e4mrSbC051HzsB0ocn4gms5xgekk=;
 b=jP5C8Cne4VWTvtRHsRddxQKqCfDbQuLYE4ZjApV6DZoJ/ox9vsHHZ4YJNXXRvMEuuh+JEw/eIu+TdJMZ2aZk5GAQF7voJj65scal/JILZfCxbZbyhfvyiCqbkSQLdelunXD8CbkziLqb5sif5J5roOP/ZK0WFxQbIEpSFJZRcMyivm74q+jse6ltAeCQa8hF+NltODz9L0PtBqVZmiUdxn0Z1PlXx3eudMHR0XMoT+C9C6Z6b75/zZJgAsATy1i0jpQp5mn1NMxbZo4nkF5q7xaeb0DGI3H7Jq2RnyBL7yFKHpeL9FvVQYz/sSC03vcWBYx+VL44WnW+ZCZ3HI4ZMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8)
 by CH3PR12MB8996.namprd12.prod.outlook.com (2603:10b6:610:170::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 15:51:05 +0000
Received: from IA0PR12MB8422.namprd12.prod.outlook.com
 ([fe80::b2c3:ee20:6aeb:7f6e]) by IA0PR12MB8422.namprd12.prod.outlook.com
 ([fe80::b2c3:ee20:6aeb:7f6e%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 15:51:05 +0000
Date: Tue, 5 May 2026 10:51:02 -0500
From: Daniel Dadap <ddadap@nvidia.com>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 linux-fbdev@vger.kernel.org, linux-acpi <linux-acpi@vger.kernel.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Subject: Re: Plan to fix nvidia_wmi_ec backlight issues, help wanted
Message-ID: <afoR5jUHLPXpYJ8a@ddadap-lakeline.nvidia.com>
References: <f10c039b-e9ef-4aae-8291-8f1e71074586@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f10c039b-e9ef-4aae-8291-8f1e71074586@oss.qualcomm.com>
X-ClientProxiedBy: BN0PR04CA0052.namprd04.prod.outlook.com
 (2603:10b6:408:e8::27) To IA0PR12MB8422.namprd12.prod.outlook.com
 (2603:10b6:208:3de::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8422:EE_|CH3PR12MB8996:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a03ecac-e79c-4217-fc93-08deaabe1d95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: NbX/UnMWIw7wiDP//VBgHXhTifZMX1K9/JYdQnO54ftcglr3y3hIMDmYt9Rs5XcaB/ylnYZCcfLch0yevMjuEItcyjjvF2MZDcjivOVs2mhnMsVYHS10E0JP/WZLiHTGbOYIXLFsm6KKRBT4wyskE2eUF9JkGuA4mOyTvfjlWWbgyTu279e8uxglSM/TQ4vsfWbBCVQEXQ/GTF/e8LWbgGds0Oh0Yws9zgO+iy2SiLnBItD0D2ehm3EamV13e8Iax8+svof7pc1K3hsvgLANsgt8kPw1Qxx9g2st8mPDHXlIKV9wVthjc13FMd/8HW8lvZcuCJFoQbHrWJkG1oZZZFxupuoMXO1giBtQS795YkaijWN472MIgU1/Zb4MqR36mT00mdZD0mLX4HbaqRRf6oAuPrDz5RjnLHkgEObdoZyoSvtQMawB5rE8uRBMEQA5yN5NsuKG5RxehHRj1VzopJGG97dVEpfxz0/gxXzJmztJZLffUYsUCJkhWJFClMMPNalFgmkyCj/dT4SJ46d0YzSD5uzGq/ULb8lcHl7jyZGrXcZEf2s7fXBhPXpzOhEJKzVXQT82KsLUo+kTqkGK2xpZplWvkebE1JAZRxqp3JS0ATbWU+fipRNZ7T+zL3+/2eY932ioxy0GgeaQia3HLcYlXNKLpdwXDc5reMQmkqGpiVcPrxNWXK3jg0xDC/Gu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8422.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MAmcX3Z/PO5g6ZwQgLdIRde7vjAgM+zrjW9tjVaXay1u2s53w3YYkNgAWx9O?=
 =?us-ascii?Q?hN0O1LbwQjNILCCrQpM26s3hU/XhVJq3YJsgH40MCzZoVJ3WMqoJ32kdZ8DS?=
 =?us-ascii?Q?wvdlKTwpDhq4+/+ms72lnD4z2YXsSLgEdIs2KIYA4RVHqHfQZ87ieVWcE7ZD?=
 =?us-ascii?Q?tucL9iuMobOHXGDTaZLlE1BErAMS8zLotlUnpbX7x+wEYJ1vUJedE399hJxZ?=
 =?us-ascii?Q?TqbeWdBniWH3fHauxlNAsh3kAqwZmiOg8n+s3EdFT/LU4E6kXyxbeaQcv3P/?=
 =?us-ascii?Q?m1iLQcOpHmUq5EGqDeVgCtmJAhlBmxl2uzG4t+A4ZbbOMKz3k+HKey826RHN?=
 =?us-ascii?Q?1ktK1LrRcxj/tdOs5wijb98snJI6ThR7J+a3kr2HjequH767mtk3IxqCEx3E?=
 =?us-ascii?Q?Qm0bJdxgJnOtf/AbixAR4k9DaZYh/M8tqXlBuoMM60BO9Xiq4Fqo6kP2kPpU?=
 =?us-ascii?Q?Gt4yrx+T3Jat6XiSYpVNBombW+Q4AOBmDVe012EqscZWRYl/wVhx4cUgca+P?=
 =?us-ascii?Q?7D3jhNdgRaOtJ943KOHSarahEDYq71po9cIq5svrTGafs4Uv3QrZjIIVrjgs?=
 =?us-ascii?Q?jfXGKnEafVLhPvfhBLoexWDm3su2LQmi51g1HGruPlxI5aWbk+tMZx4lfN/w?=
 =?us-ascii?Q?5DodYvDHgXHV0JP4+rnNJirK5lxV7NPQbZfEIgu7nruzXk00Nol2yOW2L0xz?=
 =?us-ascii?Q?m9XFwwb1nJS43XlJygBhG609hEoiPwSAzjJDlwWunYepZR6dyThNphv+wuzf?=
 =?us-ascii?Q?1eyYOZWH5heUnutSEgpkIRWp5K1MPMwilArXJMktfSTblWva9E70+A3COBOj?=
 =?us-ascii?Q?bdQjiJyYhXwxb6GrJwI8qDYW46esR9G8M2aynj4ZgGwnucTxYhEgGGH8iQAm?=
 =?us-ascii?Q?eBGzZ8tpAsguY5ZMrXKega+jehnT8nI7dLFp0xbrmaQyqQq8fzZ4PA53jD2x?=
 =?us-ascii?Q?47n10xxThqap0l7kjPIxNdtzNnvcdBFMbZnslpMSdUhQCUugNBZOxmhOFgxF?=
 =?us-ascii?Q?IWFpyvDzttv1woa27Om2oN5T5EkTp7i5IiJvLcJ7q+h/i8jLR9xcYFJVmLTb?=
 =?us-ascii?Q?wBDh7O4JQ8PXT2aWPKvCVxsYic5g5ztKWkliuxWlGarnUwWfxppeAYRaesTw?=
 =?us-ascii?Q?y7zoky/hxOpgAagt+CUSDELsJr/s9McKunylM3tiT2Y29H6idjhqo8TXpiBF?=
 =?us-ascii?Q?qGtEDu6wtYWO/Ca7jBKrxvx7iT5QGiCJEcqHRdzpgEkyx75C80j3sgIu7Esh?=
 =?us-ascii?Q?FDd2Z/A6ra7+8HVQZU6UofbVke1G/Y1Tig0s/1X3m6I8SLmQylc2MfNrsZ47?=
 =?us-ascii?Q?8A9f8FAvLbefs7y8MggAzyVovMsjcZSmP7C+NdidgB7dCr+vfdMUtQCKB3Kv?=
 =?us-ascii?Q?xsdR2AhSKFJSo0WsH23/AfFy3WsOGgpdtEUG26Ak132MZ8u/m/R3MrXUqgp8?=
 =?us-ascii?Q?gvhSEt62kuNDBDyZgUdMoiz99haP+BpkqkLoePaOZ9XsXAdBMWKKpLb6xATK?=
 =?us-ascii?Q?nLnSRoP/YuJCyYlx+VbOtSUJ+siyYUU0ex8H/YDQ21wjNGq9hUDEDuM5QicX?=
 =?us-ascii?Q?g/7DWfKVOKJsbXS8aUwnN3FE4PbZk0NwihwQ0z0zAvtu9PvShV5FdHmaG7I+?=
 =?us-ascii?Q?rcNudnROC8FlwRMXtlyC8AjrwU8vLz/bQIzROiU7hGBnbNeRIMWyzHGefJmw?=
 =?us-ascii?Q?t9TLoSVIMXi63D/ep1P9ZV1oYtBVEjlrEcxYhgX4BB8WgUjU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a03ecac-e79c-4217-fc93-08deaabe1d95
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8422.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 15:51:05.1724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N71YBHM6IwmBtsVBw/Qpw/WYnpan236Q/eEAcRBrD8NzVupYISvEXSuIG0tljwBLm0oa2Hzr8U9PVlvTDDv3Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8996
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

Thanks, Hans -

On Tue, May 05, 2026 at 11:52:55AM +0200, Hans de Goede wrote:
> <resend adding pdx86 list, sorry>
> 
> Hi All,
> 
> A while ago Nvidia introduced a new Nvidia specific firmware method
> for controlling the backlight on laptops with runtime switchable
> Nvidia hybrid graphics.
> 
> This is supported through the nvidia-wmi-ec-backlight driver, but has
> never worked 100%.
> 
> The new WMI firmware interface has a method to ask the firmware if
> the backlight is controlled though the EC and this the new WMI interface
> should be used; or if it is directly controlled by the GPU and the GPU
> driver's native backlight support should be used.
> 
> There are several bugs in the implementation of this on various laptops:
> 
> 1. The method to get the backlight control source sometimes does not
> report the correct value.
> 
> 2. On some laptop models which method (native-gpu vs nvidia-wmi) works
> changes at runtime, e.g. when plugging in a charger.
> 
> Known affected laptop models/bug reports about this:
> - Acer Predator PH315-55: needs acpi_backlight=native
> - Dell G15 5515 with RTX 3050: *needs* acpi_backlight=native
> - Dell G15 5515 with RTX 3060: *breaks* with acpi_backlight=native
> - Lenovo Legion Slim 7 2021
> - https://bugzilla.kernel.org/show_bug.cgi?id=217026
> - https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/work_items/784
> - https://gitlab.freedesktop.org/drm/amd/-/issues/4512
> - https://bugzilla.suse.com/show_bug.cgi?id=1217750

I believe there were also a couple of cases where different builds of the
same notebook (as far as DMI quirks tables could detect) would be driven
by different methods, exacerbating problem (1) because adding a quirtk to
fix one notebook would break other versions of the "same" notebook. (Oh,
maybe that's the two G15 5515 bugs linked above.)

> 
> It turns out that under Windows both a WMI backlight driver and a GPU
> native backlight driver get installed and Windows simply always calls
> both when the backlight changes working around these kind of firmware
> bugs.
> 

Yes, it's frustrating that so many notebooks have implementations of this
interface that have bugs that get masked by Windows always using both of
the interfaces. I wonder whether Windows behaves this way because bugs of
this type are so prevalent, or if the bugs are prevalent because Windows
always behaved that way so nobody noticed.

> When this first came up, about 2 years ago, I came up with the below
> plan to fix this. Nvidia was supposed to work in implementing this,
> but so far an implementation of this plan has not happened.
> 
> Note I do not have time to work on this myself. I'm posting this here
> in the hope that either Nvidia will pick this up after all; or that
> someone else can make this happen.
> 
> I'm more then happy to help answering any questions which may come up
> while implementing this; and to review the resulting patches.
>

Sorry about that - I totally forgot about this proposal. I'm still happy
to help here, although if someone else is especially eager to implement
these changes, I'm also happy to answer questions, test, review, and help
in other ways as bandwidth allows. I have some clarifying questions about
the plan - it's been some time since we talked about this, so I apologize
if I've already asked these questions and you've already answered them.
 
> 
> The plan
> ========
> 
> 1. Modify the core backlight code to allow registering a backlight-device
> for in kernel use only, disabling the registering of a class device under
> /sys/class/backlight .
> 
> 2. Add a new backlight-aggregate.c backlight driver, which exports a
> devm_backlight_aggregate_register_or_add() function. Drivers can call
> this passing in an existing backlight-device (with its sysfs interface
> disabled). This either creates a singleton /sys/class/backlight/aggregate
> device, or adds the passed in backlight to the existing singleton instance
> if it already exists.
> 
> This new driver always exposes a range of 0-255 to userspace. This acts
> as a proxie for any backlight-devices registered to be part of
> the aggregate, forwarding any brightness set calls to all backlights,
> scaled to their actual range. For reads this will report the last set
> brightness value (starting with the value of the first registered
> backlight-device).
> 
> 3. Add a new nvidia_wmi_ec_and_native type to drivers/acpi/video_detect.c
> for both DMI quirks and commandline handling.
> 

So by default both the native and GPU drivers would register a "normal"
backlight handler, and if the "both" quirk is set (or if requested via
kernel command line) they'll register with the aggregate device?

Would it make sense to make this more generic, with a parameter which
can be set via command line or quirks for which backlight devices to
aggregate? And then maybe instead of a new "nvidia_wmi_ec_and_native"
backlight type in video_detect.c, it could be called "aggregate" or
something else along those lines, used in combination with the list of
backlight types to aggregate.

Have we seen systems where both the iGPU and dGPU register their own
native handlers? I vaguely recall seeing such a system, but I do not
keep careful notes about this sort of thing, so I'm not certain. If
there are indeed such systems, then "native" might not be specific
enough, and it may be necessary to explicitly name backlight drivers
individually in order to aggregate them.

> 
> 4. Modify acpi_video_backlight_use_native() to also return true if
> the __acpi_video_get_backlight_type() call there returns the new
> acpi_backlight_nvidia_wmi_ec_and_native.

> 5. Add a new devm_backlight_device_register_native() helper which
> calls __acpi_video_get_backlight_type(true, NULL) and if that returns
> the new nvidia_wmi_ec_and_native type then registers the passed in
> backlight with the flag to not register a sysfs class interface and
> then on success calls the new devm_backlight_aggregate_register_or_add()
> with the just registered backlight device; and if the returned type
> instead is acpi_backlight_native register the passed in backlight
> normally through devm_backlight_device_register()
> 
> 5. Modify the i915 and amdgpu drivers to use the new
> devm_backlight_device_register_native() helper. Since this new helper
> checks the backlight-type itself, drop acpi_video_backlight_use_native()
> checks *if* the registration is the only thing guarded by that check.
> 
> 6. drivers/platform/x86/nvidia-wmi-ec-backlight.c to not return
> early from probe when acpi_video_get_backlight_type() returns
> the new nvidia_wmi_ec_and_native type and for that type make it
> registers its backlight with the flag to not register a sysfs class
> interface and then on success calls the new
> devm_backlight_aggregate_register_or_add().
> 

There still isn't anything tying a particular sysfs backlight interface
node to a specific display panel, right? Is there a plan to eventually
support this? How would this interact with that plan? I'm just a little
worried about designing ourselves into a corner that makes things harder
to untangle individual devices later if the need arises.

> Regards,
> 
> Hans
> 
