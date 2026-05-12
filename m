Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFF3CD4846
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 01:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 959E810E23C;
	Tue, 12 May 2026 01:59:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SsP/yEev";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012062.outbound.protection.outlook.com [40.107.209.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D34E10E23C
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 01:59:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jh9AWAGLBtumjAIe4VKtAwrQgSOyLaV5I9sQcvKn66G9W+kwF4UsrClQGh0UE/j7g8xpAdj9Z9Fpjp2wulemGPmSAMF9KZ1Hc2UGAk4YXrCGXFOksLKa4as7sJpgvpGBIPMFnPcjh5A8n4E8NO9kH8k18P7Fy6VPt42IZvLCL/+MXX0fmsgi5W86vwANE3NHenccHwHBaJ237ihKY1DDMspGIUG+k+jnCe5QDCBNgClSfjUGqDGVyoRdhN9NQPdSOxwLzkXT771p6ZgfFvzRim3dTkhmmkV1MpIMC1wbM6pe4fnLXsR81lAEBqs74gLFQW3VgZQY4bCe2S7aCisIYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuQ51hW27QhU6Q8WNjw3167+jbbevYN8cpmdBIp43VA=;
 b=nrOoyRFhskw/4d0gVbS5PZB7d+e5hWYixKi1gcqX8sByEUbCcAucCtPIkmvelvxhYa76EbrEXJbI1ODCvizJs/xRYCJhhEtjqeNDOPjIViztHxFzrdz2p69/feRNGI+ajkLQGZAYA8XDs78He9jo+6XG6UG/k+lx5B6ar5OUlRBQQIYXdKLrsC8YUVC8S2ZpYrpcE8je66MN7HjDq1iK9i2W9elPctezldguW3zcv90cpihalJNXByIr/1JS2YClcvNNw4r6E+m0NNDZRYEVJsdOjn4aB2XEhZ7l9fbluFtn9obwbV+YFukoWxsFIKTxj3DjwTIS0fo9u9kZIVxOwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuQ51hW27QhU6Q8WNjw3167+jbbevYN8cpmdBIp43VA=;
 b=SsP/yEevyXt4V+TeFXp+WFC58cri8fSxn6kPtxQQhIz6SfEPxXJ+qZOa7EJIXG7FySFBQWk693934pbXrb2s4KIyA/zu4BgIVGj8MIMN7CUkPYbabStYkRf7A4/Wcv3p39cWgVmAOHmeNx57dSFdV0nf0Tor0htNTPIjcXk+tp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by PH0PR12MB8126.namprd12.prod.outlook.com (2603:10b6:510:299::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 01:59:16 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 01:59:16 +0000
Message-ID: <5d7067de-97b7-4232-9cf6-e4b978696482@amd.com>
Date: Mon, 11 May 2026 20:59:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 0/3] Add splash DRM client
Content-Language: en-US
To: Francesco Valla <francesco@valla.it>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Jocelyn Falempe <jfalempe@redhat.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-embedded@vger.kernel.org
References: <20260510-drm_client_splash-v3-0-a9aee9f0b2fc@valla.it>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260510-drm_client_splash-v3-0-a9aee9f0b2fc@valla.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:806:20::21) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|PH0PR12MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: bad2f571-95bb-4a87-4eab-08deafca12c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|56012099003|11063799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vPQQp6+d35fMS3TYcM/U15LJWDHSuSd86yWROlU/ueHKh5LTntdYbcTpKVqxb1WCyJqd90o/+blkXaaRGcAxdbzCWAR6XrzNecXg9s5JZ8tfC4WfQ0Wt1aq0ZQ2yDQ493PMLwcgyM4qJ1nLRoCPxFeaPKF7k/QrZC/KOvxqNXEnApOZ8H2GPIAcJbzkuzWnwaSCE0BNcC3dOrOciOYEaWfkCq2XI2reXpdwzcuiZjbrk1Uo4smsJG/UKFW2g7m/b2i1vaNl6cKJTo0g506aMraSSGp1QQQe6H2ph6g92sVQEktuzDA1LTBTdo3Ib/zb8+hOHN0W1lAEn9u9jErO4NgCBx+zMdIr+SBTLlPc/HtxEtYdLdyS78ySKNvCrC9JKFmhZrR+3rKn1nnLw+4uYWZ9Mia2WEQ6GO8FdX4KJnGrzP4mbd5Vgfn9xraGybRzxO4qtcrCEYRhFPpB/NS/HUDtF1fvupu82lHbgj37xUeQzoIo1stSFDm/DOVqHMn7PQuBIDJMzc31Guv9pvzx+RS/U9jwI/3FrTX2xlGwozw+DU90ojLxUcgtZ11W0N6Oovt6QzhAiAzPiF6c97hQ5Z1b+/GcgC4RdCx9FGIx7AHczIo6la6zUhNGtojdQjDfrVYvfevjCrkrIODwRd7/ee+RfWF/faHiszkrQ0QteB2TLEcj+MM9RIw+azJnMjIk/IHtlLUIgx2kVbzZz8T7tIXL3lkxnM40GkTDO/8+goAn5jVbCqc59DwfmLYtHml6b
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(56012099003)(11063799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTlLSHVKTjRzbkJiMkhjd3V5RDhoSS9rcitlQWo2WWh5ZmdMTnphMmFXaXQy?=
 =?utf-8?B?dVlBSzI2T3BqVUo4eEFYRHNvbW5KZWRFYW40eUpZT2ZWZUExLzB1WEdwVFBI?=
 =?utf-8?B?bW9rVjkwSTF4NU1laFA0VDNaa1hLQ3JnZm94VXViYUZOM0U1Q0tCamtGUXFy?=
 =?utf-8?B?OEpWZk02QmJRZy9oMlVSNWM4U3NvTkFuaHRtYitxcklwOEV0WmFzYkJHRjNt?=
 =?utf-8?B?TUZkdHI5cjYxMnhwOEVwcEZiQXZHMDhxZldPV0R0RnNEV1BvRjJKdWo4ZVFH?=
 =?utf-8?B?VlBtR2RoTlJEblNNMFZrWjVmUVdPVXpRaDBlTVg2R0c4UWFaWmV4MDBEMVBI?=
 =?utf-8?B?c3NnTTN6dnczd3psYkNRRGJhSllvWDFET0hsc2NUdFErWE8yemU3RG9LRll2?=
 =?utf-8?B?YlRkcGo5MFFjWXRsWnBUT1RCSnlzV3N0M2VicWp2RTV1WGxVam9hMWFhaGlE?=
 =?utf-8?B?M0Z1Z1U3ZU5LWlJxamFUb0x2MnAwbjI5VGpIaTFkdWJ2R25ZZ3RwNDgrQ1di?=
 =?utf-8?B?VlhQNC84c09KWEwxS1pXa2x3cStPdjBuYmpVVFB0UUUrMGIzWDc1c3lPZCtM?=
 =?utf-8?B?YTFRdWt6WGZhMGZqTUhOU1dwY3ZKeXNCV3ZQZmNaSVlMcDhpaHBxNnhCNC82?=
 =?utf-8?B?M2x6cStOdVhMRDZubWMwOGRNSU81QnBzVGsvK0ZYZFNTeWdpdis5YnFIeEVE?=
 =?utf-8?B?YUdRNVdNUkZ5Q1ZOZnFRZ3VRMUdXa1lIWlEyYWxvQVBVRWhmQzl0bVpxSHFw?=
 =?utf-8?B?M283REl6bGcyRGk4UlBMYW9PQVRjM1ZaQStmSlpHZEthTzVtRklVNVRLcEh2?=
 =?utf-8?B?Lzh0ZkkvQ2YvR040dG0xSjN0VHV2YjhoZTFON2dJZmE3dFFLdEtQQWFKWXJo?=
 =?utf-8?B?WFhpajJISW5PbDdBQVBEbG9iVkNBOUhtd3p5Tmg4dnpRK1N3cGhoUDFmanNC?=
 =?utf-8?B?UnpKemhkMDFjWkdMQnVPNUxrMkQvRjYyNFhKbFROcHQ2SXJyN1kwMXQxcWtJ?=
 =?utf-8?B?emtBb2YyWURZanUrc0RvSmgvNS93a2hjTWljQVQ2WThOQzBaQ28wQTY4TVJu?=
 =?utf-8?B?Q2I1dm9yMklJcXB1U2JFMlpzNENYRE5LMHdhK0RMZ3p4ekFOQytjMmtQVS96?=
 =?utf-8?B?UWttK0JBTjVBbXMyU0htOWVRTUhlOGU2bTF0THdvbDhDRGVDc1lZbHZLUzhu?=
 =?utf-8?B?bFNHbXArZ1IzNlJHaEZSaFA4VmJqYjdHN1VvekpUMFdkMDBNbFdzQkFXZ05u?=
 =?utf-8?B?Sm9XNHRSZE9BWFZReG1oWnlqZXNqaUVVSmFQT25HWDJVdDZZSWFESW1QWDkz?=
 =?utf-8?B?MmRWUmFDMnhoM2Y4Tmc5dlpsVVBvNHZha3FiZ3A5UXZiNnV0SWRtMmJXUmpp?=
 =?utf-8?B?UjFWUE52cHk1amd5TmVJOG9rVGhHTFMvL3VvdDlQRkQ0ejFsVnI1QXMwUGV3?=
 =?utf-8?B?a2QzOWVKU0hrTFc5NFVHNW51ZngzZk1WUWlXRzhib2JQRlMxbkZscGNhWHJN?=
 =?utf-8?B?Z1hxbVcwLzZGQzB0QnBvZklZdTVKL1dYanJSS3J5RS91VndGTDlET3kvazdV?=
 =?utf-8?B?TXVnQlE2eEQ0clZGUUs5Y2NBTFhXWlhqUE9OdGFlcXhxZ05PQW9DZDhOdnhq?=
 =?utf-8?B?RXJCY3R4emtRbW1JVkhMeUw2MDN5cDA5TmsxYTBqOThCeTMxL0VuOENZamI0?=
 =?utf-8?B?cFlJamM5ZExNUGNac3o3WFpHWm5nQVloZk5yaVZ5K1JOemVPdS9zaURLd3dy?=
 =?utf-8?B?ZE1KWVNFT3ViZUtja0Y2L3dtdEhKRk5IMDFGVTYxZFozRTJieWRyVjh2K3ds?=
 =?utf-8?B?L3R1OHBWNHpva0ZHa250WjhVWnhHVkRKcG9GZ3U5Znhzb1hhSHNSN3V6U0Q2?=
 =?utf-8?B?VlpmODZzbCtUZUM3emNzU002c0dNbFdFd1R3NkVQQmFlOXFjOFlxVlpPTi9q?=
 =?utf-8?B?TW5qYjY3akVEN2x5VnI4OVNuZlczdC9Md1BoeWo1VVlKV1FTVGRwTGxOZzQr?=
 =?utf-8?B?cHhOazc1WjVZWEtUa1RRYzgxb092RGdoV2Q1c3JVVzVabzF6NjZGMkF5bVJI?=
 =?utf-8?B?M1o0d2UwTURjQVNzeUdrMTZxU2ZtZE4raEJwZzh0NjRxRGp6R3N3TG1hcmRF?=
 =?utf-8?B?MnphMUc4cU1hLzhJSXczQVVwT0VLdXJMVENJNTBMZjNPWUFVYzRiczZZVUlK?=
 =?utf-8?B?R0RydTZtQllXNFRvdTdlWTJEb0tveGpHNVNiUmVQTlkvVjREZDAveUtNZ09m?=
 =?utf-8?B?emNLWGxUMXh2b1Myb1lJQVY2d2RnbE9nZGtrYnFxSzErdVJFVUxCUG1NSWVM?=
 =?utf-8?B?ckttbXF4TENVRml4Sm1HVEJBYTFUSHhQbFMxK0hwaHFrTitRS0JHdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad2f571-95bb-4a87-4eab-08deafca12c0
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 01:59:16.7910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxiSPTfMYMYbm+NNlAEA+CiK6bcF5YkCCLJ99kUisSfApEvhPLzfox8kRS4w2t43yeiTaz8dKZmAsmPiXxODBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8126
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



On 5/10/26 16:29, Francesco Valla wrote:
> Hello,
> 
> this is the third (and hopefully last) RFC version for the DRM-based
> splash screen.
> 
> Motivation behind the work can be found in v1 [0]; in a nutshell, the
> splash DRM client can draw a splashscreen using:
> 
>    - the BMP image supplied by the EFI BGRT;
>    - a BMP image loaded as firmware (either built-in or loaded from the
>      filesystem);
>    - a colored background.
> 
> This revision greatly simplifies the image seletion logic; now the EFI
> BGRT is always used as first source if enabled, with a fallback to BMP
> image loaded as firmware and then to a plain color.
> 
> Sanity checks on the EFI BGRT image have been borrowed from the efifb
> driver. More complete splash providers (e.g.: Plymouth) have an
> extensive management of platform-specific quirks, but I don't think it
> would be reasonable to introduce such complexity here.
> 
> Additional notes:
>    - Rotation is still not managed (and probably won't?).
>    - Support for tiled screens is untested.
>    - Plain color and BMP sources were tested on QEMU, Beagleplay and
>      i.MX93 FRDM.
>    - EFI BGRT support was tested using QEMU+OVMF.
> 
> Thank you in advance for any feedback.

Unfortunately I found that I couldn't compile with my normal Kconfig.

ERROR: modpost: "bgrt_tab" [drivers/gpu/drm/clients/drm_client_lib.ko] 
undefined!
ERROR: modpost: "bgrt_image_size" 
[drivers/gpu/drm/clients/drm_client_lib.ko] undefined!
make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
make[1]: *** [/home/supermario/src/linux/Makefile:2091: modpost] Error 2
make: *** [Makefile:248: __sub-make] Error 2

❮ grep ^CONFIG_DRM .config
CONFIG_DRM=y
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_DRAW=y
CONFIG_DRM_CLIENT=y
CONFIG_DRM_CLIENT_LIB=m
CONFIG_DRM_CLIENT_SELECTION=m
CONFIG_DRM_CLIENT_SETUP=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_CLIENT_SPLASH=y
CONFIG_DRM_CLIENT_SPLASH_BACKGROUND_COLOR=0x000000
CONFIG_DRM_CLIENT_SPLASH_SRC_BGRT=y
CONFIG_DRM_CLIENT_SPLASH_BMP_SUPPORT=y
CONFIG_DRM_CLIENT_DEFAULT_SPLASH=y
CONFIG_DRM_CLIENT_DEFAULT="splash"
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_AUX_CHARDEV=y
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_DSC_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_CEC_NOTIFIER_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_TTM=m
CONFIG_DRM_EXEC=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m
CONFIG_DRM_SUBALLOC_HELPER=m
CONFIG_DRM_SCHED=m
CONFIG_DRM_PANEL_BACKLIGHT_QUIRKS=m
CONFIG_DRM_PRIVACY_SCREEN=y
CONFIG_DRM_AMDGPU=m
CONFIG_DRM_AMDGPU_CIK=y
CONFIG_DRM_AMDGPU_USERPTR=y
CONFIG_DRM_AMD_ISP=y
CONFIG_DRM_AMD_ACP=y
CONFIG_DRM_AMD_DC=y
CONFIG_DRM_AMD_DC_FP=y
CONFIG_DRM_AMD_SECURE_DISPLAY=y
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y
CONFIG_DRM_PANEL=y
CONFIG_DRM_SYSFB_HELPER=m
CONFIG_DRM_SIMPLEDRM=m
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_ACCEL=y
CONFIG_DRM_ACCEL_AMDXDNA=m
CONFIG_DRM_ACCEL_HABANALABS=m
CONFIG_DRM_ACCEL_IVPU=m
CONFIG_DRM_ACCEL_QAIC=m
❮ grep BGRT .config
CONFIG_ACPI_BGRT=y
CONFIG_DRM_CLIENT_SPLASH_SRC_BGRT=y

> 
> Best regards,
> Francesco
> 
> [0] https://lore.kernel.org/all/20251027-drm_client_splash-v1-0-00698933b34a@valla.it
> 
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
> Changes in v3:
>    - Simplified the image selection and management logic, with direct
>      fallback from EFI BGRT to MP as firmware
>    - Used new drm_draw_can_convert_from_xrgb8888() API
>    - Added proper get_unaligned_ calls for EFI BGRT access
>    - Fixed Kconfig dependencies
>    - Link to v2: https://lore.kernel.org/r/20260106-drm_client_splash-v2-0-6e86a7434b59@valla.it
> 
> Changes in v2:
>    - Moved from raw dump to BMP format for static image source
>    - Removed support for configurable message
>    - Removed support for progress bar
>    - Added EFI BGRT as image source
> Link to v1: https://lore.kernel.org/r/20251027-drm_client_splash-v1-0-00698933b34a@valla.it
> 
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> To: Francesco Valla <francesco@valla.it>
> To: Jonathan Corbet <corbet@lwn.net>
> To: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-doc@vger.kernel.org
> 
> ---
> Francesco Valla (3):
>        drm: client: add splash client
>        MAINTAINERS: add entry for DRM splash client
>        drm: docs: remove bootsplash from TODO
> 
>   Documentation/gpu/todo.rst                    |  17 -
>   MAINTAINERS                                   |   7 +
>   drivers/gpu/drm/clients/Kconfig               |  63 +-
>   drivers/gpu/drm/clients/Makefile              |   1 +
>   drivers/gpu/drm/clients/drm_client_internal.h |   9 +
>   drivers/gpu/drm/clients/drm_client_setup.c    |   8 +
>   drivers/gpu/drm/clients/drm_splash.c          | 932 ++++++++++++++++++++++++++
>   7 files changed, 1019 insertions(+), 18 deletions(-)
> ---
> base-commit: afaa0a477099cb7256e26fe11289c753a225ac97
> change-id: 20251026-drm_client_splash-e10d7d663e7f
> 
> Best regards,
> --
> Francesco Valla <francesco@valla.it>
> 

