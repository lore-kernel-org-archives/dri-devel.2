Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B35C624CE
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 00:19:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B91010E237;
	Tue,  1 Sep 2026 00:19:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o1sV0PeJ";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010046.outbound.protection.outlook.com [52.101.46.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D33CB10E0C9;
 Tue,  1 Sep 2026 00:19:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLkp9oOA9/bJROguSYx9La/FqYETdbiG+HogRoyvgM7vOTfxsSWwAARUQNkk7cb9jheSKDKKt4y6rCHZ3ZPqurXcLSI3zJkPyw6o+OehAnLRmBMEOjpvvD2rxGiXTM6lQJuPfSI1d4Obc3QRiyLIfogZl8+jdhgKlZ16T5vw2DZwrak/4fCGGOA3Sp2BKku6QyELp8vWzmVerp+2Ay1QwOk3Vq8A3voViXtJ5sYw21KVRMz28cJVlFp44b7RSLy9AFNDUUQM/xy111vJxuGnPSMZRYQouNZJ+cuSyumJsNfeOOPdBnNctvFlxd+cjip2nwwaXBvJ5xtTtIFN4XfK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FylUDG57w0qzBJu48bcuJjcI6YnXUxg5MvhSZjxTvLQ=;
 b=BHhgwtobRDlAq+8p6klUdEtGyaZ6SbGhrPXF/bU2Ih44gLUa9p+TQ5zSp8bwiXOnKvVgiGOOxKq4ieEJ5fpXUwT6LnxXISMIVLUYGeQz3XF2JFoPFUmEdJGtNnuK+738YqEy4IN8YiMMQCqXaXC2gYV0mNGB68FpP2Lgdxp8ZrP07lkzOXbMBexQmC6JjIzkqr49rmWEwlhPYJS+pWz4cGZlkEeQRO1APPN81EwxpjBz6RP7e26lYYajnptFsZ9tXk4oncLRPNszj5f+nz3BslxtPspXGWHz06wC8B5+/Ub+fNB0i7psMb3u3G2jc/gXQeg2oTmFS8wvIP/G2DG63w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FylUDG57w0qzBJu48bcuJjcI6YnXUxg5MvhSZjxTvLQ=;
 b=o1sV0PeJNIoxLTwYnWl4NeP5pXpvO5guuVqVyjq5rMqb9FEMfRdiZqZQgii+hupola8mzq2Bf3xfj3x79IgCEhDCkhTqmdXe21IvZGxUJXL6fesshBrdMTBBFTpcwrlQrfRHEzzPtS+pnhS0sliGnuWdqKVUz2HwoqehOgFol0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Tue, 1 Sep 2026 00:19:07 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 00:19:07 +0000
Message-ID: <0564eb9d-ca38-41c5-b55d-8ba423ce253a@amd.com>
Date: Mon, 31 Aug 2026 19:19:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/12] Add support for a DRM backlight capability
Content-Language: en-US
To: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Hans de Goede <hansg@kernel.org>
References: <20260831210531.2334221-1-mario.limonciello@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260831210531.2334221-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0134.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::7) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DM4PR12MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: dd27c657-9bf3-4672-5da9-08df07bea33e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|10067099003|6133799003|18002099003|22082099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: QTbZTw8OiUDpL7ea3RstyL1pXIYMQhGR5Bew8MuKZJ52uVhDFwXEGkbj+n7/3FZ5TdAo2RtFpCYrj/ra4IKviG0AuVJjMpsBUvuZsgExUAigdMS5NntLRxMMgsa3vaigAF0wqNHBC9aLhEH8mAb+jm+bGOK1lcSMaG5YHs0cwMhr/hNVUj91rxcVkYpo2fuHvoQ2K5duQovetew48BOKY2Y/cr9Ua3+ssdFrezcWrxrwtqnBXXCxfvxVuXHLHzIPVmp1dtj5DIM25iWzDkHyVbk3DNGqncqbri9uZIMfZfuA3xtYYS0U+2yu1ZheI9b/Q70M7GUWFuCHR3Kri0hax7SbGSBuIlQJ1a/p/8bq1OzBKTCREKZoPJYpY+RExdO2oJBFrGDgvRCptBytvOGWe22VmQc8/1Ju1dTdJYl0tB+wKp8a9vTbaHx0WsdvZJ05+Dx2T4mVdZlhjHWTZ2BONDJfb9eGJnhVg8XY7bHIwu9lwZF953IxDe/S+cy0R+XoNMi2Ikz1mcki93bWeoG/yEic1fpaU27UJaV/HWHSaw77HrK99Ix0dOolqFcuYD+pkWhuTg7fsLZvnoe7jx323DZ+9D9229MtTZw57WO1LNop9GKjMfM7j8SzTdZ0kuFa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWg4dHhsTFBpTlZmWW1VeHEzUVhIMkRsbWI2cTRYQlZJUTJkQ0VPZ2QyTVBM?=
 =?utf-8?B?UWtjMld0cldVOWhZVTZQS2dhRlRldG8yUVo0blZ5NGFERk56SmZEUnh5RGU2?=
 =?utf-8?B?ZEV1RGJpTlNqMnM5OUJPc2lRRUtrNjNpbC92aEtwaFdsbEFsTEJ1VnhSaTVO?=
 =?utf-8?B?M2pab3pTRGFEbEJBdVNFQ1U5MmtUR0ltNWw5clMzbXR5MmgxUHhlVXJYZHRj?=
 =?utf-8?B?Zk5lQzJNMlRleE90dUlVYlM0K0x5Y081QjA2U3R3UW8xVUdDbWMrdmNkNVhv?=
 =?utf-8?B?TzViOGVHVjd2MkdLL3NLNXhnQUVjWGo0NVR3bTVsSFhJSHVzZUVyY3B5a1Nv?=
 =?utf-8?B?WXBQNDBBeHluRzZFU1loemFXZU9VSXgwSFIySjRkZU5VYVc3aHVFbkVNNGRw?=
 =?utf-8?B?RHFEblFWRllXdk9jcVNzL0R5RXZDRHhaZDJnT21BQkowWGIrdXYvT0ErSzFz?=
 =?utf-8?B?Q3FPZGpRV1R0MTNESzg2MENLOTVqL3VwRWhlTndNK0tKeWt5WkhFWWZ3bUdl?=
 =?utf-8?B?MkI1dmN1VnkzYzk5bEhUZFZqeGhUQi9RQ3pCaVBOTVYxSkUwN01UVmN3RXJR?=
 =?utf-8?B?dE1rQTYzRlByTmVHdE43SnlHOGFjRE5WVUxYS1RNdm5ZMXlsQ09mNlRHOGQ0?=
 =?utf-8?B?RFFmT2NyMWhueFl2SXZJZDdsTTFZMjNoeWRORnZ2WXYyWk9ZSWZoTHhHcDJY?=
 =?utf-8?B?dVVKUEM0N0JmR2hxdGxKY2RTZ2h5QW1VZmM4RUtUQjJaTmU4Y25LN2Q5alBa?=
 =?utf-8?B?aEQ0TFVWU0Y1R3QxUnMxQ1J1NytOLzBpM0ZxZU5oeC9Wc2U4Z1hJMG1jcVJI?=
 =?utf-8?B?blg1K0xOVHVYUW5tMlZQTWVydXRKelI1ejVhRUxNSE9tZFZPUE5OeTJIV3Y4?=
 =?utf-8?B?bTVPazhBOGdFcWRWZDFLMGVtVEJZb2xmTSsvdFUrSEpuZzF0U0ErWXh6eGNt?=
 =?utf-8?B?RmxpeFA3cGc1VWw2UTZnMU9oV0NRbHZ5S3VuUk9pT3RpekJRU1ROZGJhMDJt?=
 =?utf-8?B?TXc5VlBESncybmhXLy9JRzZ2ZjcyeDNTbVQ5Wngxby8wZmRqc0txSWxXS0pn?=
 =?utf-8?B?RHhlYTVxZk9wbE9PVDZEMXZiZnFKVFU0VEJqdlp5bFM5dkx1M1h6TEplQzRz?=
 =?utf-8?B?MVJtTVk5ZW04ejNYWE1MaVFFUzBxMVkrdWNTZmxhUURHbk9MVDdpZmY5MWpo?=
 =?utf-8?B?OEFXdDlIVFF5YzI4U0cyOEV3UlVDM2JqQmVONFpmbjVBMUVkeUJCRVovSDlM?=
 =?utf-8?B?MmNlbHpxaCt5VUxtL1BJWEJuUHZqcU5sYXk2M1g0d1JJVDFoaFUvblpGRWFs?=
 =?utf-8?B?ZzhtZUY0eXVic21BTkhFVGRqUmh6dTQ5YTZaN3pWUzdOcm0yNzkvdEJDbTJq?=
 =?utf-8?B?V1B0anlCWkRDaDRnOTVEUFd3RFIzRUk3VmFrWDVveEtBN0pKUklQb0E0NnBR?=
 =?utf-8?B?TjM3aS9hb1IxK2JzWGFZSmpXdUh1c0d0QlBCdnlaNlhidCs4cEVpeEE1d1Q4?=
 =?utf-8?B?NGZ1RlVCUnlJakVYejEydmlDdG1BOWFmYTdJRDJRdVUyRUVmakRFODFxd1lj?=
 =?utf-8?B?WFgybXhZd3NMS2tLazNCbmNPT1Ficno3M003UzZtOVpYR2NWSytlT29tbHRG?=
 =?utf-8?B?TmsvUVlETVI5UldZdi9ySnh5WWZOQU8xR1dxOGlmaGZac0M4a29laU85TDV4?=
 =?utf-8?B?V0VNcmlkNHpRTENqWkJmM0VDemdKUVZsV1BXTFVvMklvK05UbEFoQTBTYVNz?=
 =?utf-8?B?dXhHRVBkWExuMXhPa25KVXZmZkk0bXdPUTk4djF0eUg4MnZ0bEZEYVV1bWZ3?=
 =?utf-8?B?ell3dkZiek9tcVJ0b08vWmtXM0JsbUQ1clpIME5CL2pJbDVOYTY2aktXSzNQ?=
 =?utf-8?B?RE83ZkJIbjZDNlhjd2VyQkh1NXRNTHA1dk9USHR1L2VnbXpUY2o0WnZMQlAx?=
 =?utf-8?B?TGRlTGpDbU04UEphR2tTVGJTcklzczBwTWRhS3dwaFN4eWFoSHJSMzNvRkI2?=
 =?utf-8?B?dUlKNWRvelRXcWR2QmYzREJ3VTMzTW9LRnhzQmdHVmdLbWtHd2pvU0ZQblZS?=
 =?utf-8?B?SW9jVHVUMzZzekF3eCt0RS9yNU5EWHMrR2haajJ4NFlHRTNHTkdCaGNUVWUy?=
 =?utf-8?B?OXMvVHcwdGVKK3RJSFlSVU1LdUNZeE53Q3luaW0xQVpNQkZZYUxJZGxnL1Yv?=
 =?utf-8?B?VHZZbTFJSmFtU0RxdzV3R2NmUlFNTjFtd1NSQVpwYmR5aUYvSzBWM01oWUMz?=
 =?utf-8?B?UUo1SEUyR0twbnQ3ME5xbEduQkZPVlUvYXRWKzA0Y09naW5ZMzl2aUE3cERM?=
 =?utf-8?B?bzNCR2hKdUdVREFIQVJOZWpCOTllK2NRT0czR1N6UGtPbVdlblV5Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd27c657-9bf3-4672-5da9-08df07bea33e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 00:19:07.5079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5ed0zXwnhHYzMrprdObfD8hTiKPpNuhqepFBJuynt4+dXsWAkvn0d/Ia+M92mYpHI8sT5K3nqhD4UPdsT8t3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592
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



On 8/31/26 16:05, Mario Limonciello wrote:
> At Display Next Hackfest 2026 we reviewed progress moving brightness
> control into the DRM connector properties.
> 
> There is a range LUMINANCE property that will default to 0->0.
> Once a driver attaches a backlight it will be updated to 1->max.
> If the panel supports the minimum backlight turning off the display
> the range can later be updated to 0->max instead of 1->max.
> 
> The legacy sysfs interface is synchronized with the DRM connector.
> When a compositor using this feature is loaded, sysfs writes are disabled
> to prevent legacy tools from going out of sync with the compositor.
> 
> This has an implementation initially for amdgpu, i915, and Xe with eDP
> connectors.  It can be extended to other connectors like DP for displays
> that can be controlled via DDC as well later.
> 
> The following compositors have implemented matching support:
>   * Kwin: https://invent.kde.org/plasma/kwin/-/merge_requests/9298
>   * Mutter: https://gitlab.gnome.org/swick/mutter/-/commits/wip/kms-luminance-prop
>   * Wlroots: https://gitlab.freedesktop.org/wlroots/wlroots/-/merge_requests/5384
> 
> v6 -> v7:
>      Core rework (feedback from Maxime Ripard):
>       * Make the DRM backlight core backend-agnostic. Add a struct
>         drm_backlight_funcs indirection so the backlight subsystem is just
>         one backend; other backends (DDC/CI, MIPI-DCS, ...) can be added
>         later without touching the core.
>       * Stop dynamically allocating the DRM backlight. struct drm_backlight
>         is now embedded in struct drm_connector and initialized by the
>         core, so drivers no longer allocate it or handle allocation
>         failure.
>       * Drop the "drm/amd/display: Allow backlight registration to fail"
>         patch; it is no longer needed now that nothing in the alloc path
>         can fail.
>       * Update the LUMINANCE property only through the atomic path. Remove
>         the synchronous backlight writes from the property-set and legacy
>         paths; the hardware is now touched solely from the atomic
>         commit/enable path (via a workqueue, so slow backends never stall a
>         commit).
>       * Move the inlined luminance/DPMS logic into helpers and fix the
>         comment style to match kernel conventions.
> 
>      Per-connector property (fixes a multi-panel bug):
>       * Replace the single device-wide LUMINANCE property with a
>         per-connector property created from the linked backend's range.
>         Previously all connectors shared one property object, so linking a
>         second panel corrupted the range reported for the others.
>       * Never mutate the property min/max after creation (avoids racing
>         GETPROPERTY). Add a kernel-internal drm_property.is_luminance flag
>         to accept value 0 (DPMS off) without a device-wide pointer
>         comparison.
> 
>      Kconfig (feedback from Thomas Zimmermann):
>       * Drop "select BACKLIGHT_CLASS_DEVICE" from DRM. Add config
>         DRM_BACKLIGHT which "depends on" BACKLIGHT_CLASS_DEVICE and
>         provides no-op stubs when disabled, so DRM no longer forces the
>         backlight subsystem into the kernel. Builds verified with the
>         option both enabled and disabled.
> 
>      Documentation (feedback from Hans de Goede):
>       * Document the LUMINANCE range table (1-N vs 0-N), that 1 is the
>         minimum visible brightness, and that 0 means the display is turned
>         off (with its vblank/pageflip implications).
>       * Document BACKLIGHT_UPDATE_DRM.
> 
>      Misc:
>       * backlight: fix a copy/paste kerneldoc on
>         backlight_unregister_notifier and add a struct notifier_block
>         forward declaration in backlight.h.
>       * Split the old "drm: link connectors to backlight devices" patch
>         into "drm/property: add a per-connector luminance flag" and "drm:
>         add connector backlight (LUMINANCE) infrastructure", and rework the
>         capability patch into "drm: add DRM_CLIENT_CAP_LUMINANCE".
>       * Drop all Tested-by tags; the series has changed substantially and
>         needs to be re-tested.
> 
> Mario Limonciello (12):
>    Revert "backlight: Remove notifier"
>    backlight: add kernel-internal backlight API
>    drm/property: add a per-connector luminance flag
>    drm: add connector backlight (LUMINANCE) infrastructure
>    drm: add DRM_CLIENT_CAP_LUMINANCE
>    drm/amd/display: Pass up errors reading actual brightness
>    drm/amd: Indicate driver supports luminance
>    drm/amd/display: use drm backlight
>    drm/bridge: auto-link panel backlight in bridge connector
>    drm/xe: Indicate support for luminance on the connector
>    drm/i915: Indicate support for luminance on the connector
>    drm/i915/display: use drm backlight
> 
>   drivers/gpu/drm/Kconfig                       |  18 +
>   drivers/gpu/drm/Makefile                      |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   5 +-
>   .../display/amdgpu_dm/amdgpu_dm_backlight.c   |  15 +-
>   .../display/amdgpu_dm/amdgpu_dm_backlight.h   |   2 +-
>   .../display/amdgpu_dm/amdgpu_dm_connector.c   |   2 +
>   .../tests/amdgpu_dm_backlight_test.c          |   4 +-
>   drivers/gpu/drm/bridge/panel.c                |  15 +
>   .../gpu/drm/display/drm_bridge_connector.c    |  11 +-
>   drivers/gpu/drm/drm_atomic_helper.c           |  39 ++
>   drivers/gpu/drm/drm_atomic_uapi.c             |  49 +-
>   drivers/gpu/drm/drm_backlight.c               | 515 ++++++++++++++++++
>   drivers/gpu/drm/drm_connector.c               |  56 ++
>   drivers/gpu/drm/drm_drv.c                     |   8 +
>   drivers/gpu/drm/drm_file.c                    |   5 +
>   drivers/gpu/drm/drm_ioctl.c                   |  17 +
>   drivers/gpu/drm/drm_mode_config.c             |   1 +
>   drivers/gpu/drm/drm_property.c                |   6 +
>   drivers/gpu/drm/drm_sysfs.c                   |  26 +-
>   .../gpu/drm/i915/display/intel_backlight.c    |   4 +
>   drivers/gpu/drm/i915/display/intel_display.c  |   7 +-
>   drivers/gpu/drm/i915/display/intel_dp.c       |   1 +
>   drivers/gpu/drm/i915/i915_driver.c            |   1 +
>   drivers/gpu/drm/xe/xe_device.c                |   3 +-
>   drivers/video/backlight/backlight.c           |  99 ++++
>   include/drm/drm_atomic_helper.h               |   2 +
>   include/drm/drm_backlight.h                   | 158 ++++++
>   include/drm/drm_bridge.h                      |   1 +
>   include/drm/drm_connector.h                   |  20 +
>   include/drm/drm_drv.h                         |  14 +
>   include/drm/drm_file.h                        |   8 +
>   include/drm/drm_property.h                    |  10 +
>   include/linux/backlight.h                     |  63 +++
>   include/uapi/drm/drm.h                        |  22 +
>   35 files changed, 1195 insertions(+), 15 deletions(-)
>   create mode 100644 drivers/gpu/drm/drm_backlight.c
>   create mode 100644 include/drm/drm_backlight.h
> 

I don't think everyone else received it, but there was a good share of 
Sashiko generated feedback from this and a lot of it looks valid.

Don't worry about reviewing v7 of the series.  I'll take into account 
the feedback, re-test and post a v8 when I'm done.
