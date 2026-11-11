Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D36060A262E
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uzBgq2wl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0305A10F81B;
	Wed, 11 Nov 2026 15:40:22 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011016.outbound.protection.outlook.com [52.101.57.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C5AF10F817;
 Wed, 11 Nov 2026 15:40:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UC98shLUIDmfRW+wQMDmzFYk8pfu9yIR857NC/doFp67rskIDEM30t48nD64WDx4YYxBiCns0muGFgGOuBGGwGJvr4L4QNGmSeiw7LAKxM0cO5/o/VJj/I1ZIbJL/1T3Xz24JsFk3RpjhhwZgVPv4vgLvB++rb+/8GyTP1TJtzsVQ1wrdfase6yM6mApylFTpwseRvTRV3eUBKAP2BBWKcn7aLFvM/PBnmKLTpvcf5ywPMe43H4WT4UZPdldkOhxUG0woBPPmWQiu+9GC+VrTEyNd6zgO+GlaxWy9OmwQ85NaD9yG2RGOrYvqPE0DxTR1tznaYJHYUKhESmpv+hcPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bmb8KtlGFijYTyao1jLup4NN9CCVDmeXsileHEvru1g=;
 b=EC9ullAP37P/aAmGFi1bhgDR1YsrUc1y3USYkNw9wexW/mnoapA9MPK560TeX+FC7sJO6MGOJrh6TExTrUib+JxQZVqVWRMiXlcDbDvf3eYCYJkyFal3MMGgPB5DlRA4M1TuzQv1R1NnG7CQi9r+oSeLXgwgPG2lUTS89etyHVwDI9wSzAQIumX2W8/PLr0DDESx0/owAf2+Tevb48J58ZklfHKQ+TUMsX6KJ/XidTP3tLOOKhfdRlYCl7Oai3PwiS2B+hFH88ye56hNJ2Kzg8E/HJ5KdsuHH3lUnhFOQKoGvsO1LghbVpUYVCX/uYTJFDGia3wklyhSGv4HSRSGmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bmb8KtlGFijYTyao1jLup4NN9CCVDmeXsileHEvru1g=;
 b=uzBgq2wlia2FGb7XscYTSMFumwLjZIV9TFoJOdm5mmssfLtkbYS9swlH1NgoZfhcGmWCtvt/I1ehdSap7rmsB74U98amiwE+fGEqEhRhzzELgjvu2Fgxf96pCtcnBfrhx9nuS3IoXbgAHHgEeYDmJR3TAZfdqo7uCpvNwxWmFuY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA6PR12MB893085.namprd12.prod.outlook.com
 (2603:10b6:208:601::18) by BN7PPF08EEA05B5.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 15:40:09 +0000
Received: from IA6PR12MB893085.namprd12.prod.outlook.com
 ([fe80::3f4e:1f38:3db2:270a]) by IA6PR12MB893085.namprd12.prod.outlook.com
 ([fe80::3f4e:1f38:3db2:270a%5]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 15:40:09 +0000
Message-ID: <e2957e08-8d6c-4946-a399-7c240bb70a81@amd.com>
Date: Wed, 11 Nov 2026 10:40:07 -0500
User-Agent: Mozilla Thunderbird
From: Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH 0/2] drm/amd/display: Fix FreeSync infopacket refresh
 rates above 255 Hz
To: Cooper Morgan <ext-github@cwooper.dev>
Cc: amd-gfx@lists.freedesktop.org, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261031041827.162730-1-ext-github@cwooper.dev>
Content-Language: en-US
In-Reply-To: <20261031041827.162730-1-ext-github@cwooper.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0288.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::8) To IA6PR12MB893085.namprd12.prod.outlook.com
 (2603:10b6:208:601::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA6PR12MB893085:EE_|BN7PPF08EEA05B5:EE_
X-MS-Office365-Filtering-Correlation-Id: c44c4074-1e24-48b9-2a77-08df400a1144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261028144727099003|261026140227099003|261026121527099003|261102123227099003|261021121427099003|261022105027099003|261021123027099003|261022115727099003|261022075727099003|11063799006|56012099006|10067099003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 798ZSAYXjkll9FD2XZNlV8oVQQNT1UBO5k71WkJxCWLAe51QJXDOUcv3jbQ7Pbx9tv8607BoMsnR7TctSFa9jJ/wo/cErq1PQmcWN07KTkjSHxTyT+xAl4JsmXGAiTXlyfSLukGc3mYnrqwm6P2rZy+f4ec/IMm9q1/A15ruLaaxLNUnVcLrNNPhU2z61CVO9LY4hQBz3TPwu3CoEM0CprxjVvcn81+gldbjKDgf1smTxNcpK/ztbdzn8fxywi5Bf+bXaDrpOakigJFLZiOVQWB/JAgWQCJxc3xz4VfuaKfRwxQ341l0EgjN2+QBlkVfY3syHvTF0KYM3ZX78Gr9MOh+Su5kLqbMlApjnf6blJASu79AAJ+l3GtgsTCGiu8SKlIbQ7+0qQ7s2Cw996+ZgDixpY4QtRPGyAqjrploaUkMf+fzNkiWRL664NTezpQJRfCZqOEIr4T+94rkUbB/Z5oehry6mOeUO7La+yUw8a8lAQ9Gfx5jQJPN9swucvxwi5iKGuh/SYsp9iRRdiqHI525cP947ZwYziblbxHMMeZpa+LGieGZJv3ER9hgcYXOjUsF9ap6j+m5nOoEF7KbsZ+AAzpmUv31JsULNMA2iedaGsZNDcyik5g1TrsxPSGF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA6PR12MB893085.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261028144727099003)(261026140227099003)(261026121527099003)(261102123227099003)(261021121427099003)(261022105027099003)(261021123027099003)(261022115727099003)(261022075727099003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGFvUGFaMkdHWHRLWldsMU8zd1pkbGtIVmFFS3NZTWljcmNGdVN2a09CbHIr?=
 =?utf-8?B?M2hFZ1JhQnRwd0xmQjRGODdobks2MTJMSklTb3l3dldqUEllOUNqVURGdU11?=
 =?utf-8?B?VnAvNUNKZDAvQzVnWlRJb2NJWDZZWlBJMEtZNU1jLzFFL1U2VlcyTW9mU1NP?=
 =?utf-8?B?dFFWd2VYWE9lWjVwU1dYVE52bVFRZUUvelZZMVp5Z25TTWEwV0dRZG1Hb0Ja?=
 =?utf-8?B?Z2JMaU1COW5HLzhkVVJ5QTVLU0JOSThGNXdueWRMeEJKRjhSL09OL2ZheDdw?=
 =?utf-8?B?SUdDblVwRFhoTTdXeTI1WW1zaTJwekZiaXFxZXJsTVVpM2d6bEFVc3NLZGhB?=
 =?utf-8?B?RWZCNDV5dDBwZ3F4ay9XL0c0Z1o1OC92d3FnUjUzS1NwNmtWTStNRW1Fc0Vl?=
 =?utf-8?B?ZzBERlR0aUFoZ0dkdXp0eHRiODNzUXJwYlJJM05VcEJSaWVpaUlSaVRvUHZV?=
 =?utf-8?B?RTFGa1NNSHFZbFJDMDVOQS9VZk1ZNGk4K1liYXdlVUg4a3hPTW0yV0hHaDhs?=
 =?utf-8?B?WUtrcnpjcEgwQm5ENWdvNldiZmFmalVmOGN2WWM2OTBwd3NNVS9mZUN5Q2Nj?=
 =?utf-8?B?Q3Npa2xyOXR1Qmp1VnRlUjluRnFvSDlrL0NiZEdnRkVyUzVGZ1hwWUkvaVo2?=
 =?utf-8?B?cUgwbHE1QzVPTDF3UlJGdXI0Y0JRMG1Yb3l5VTdVdm9SdVhTVzBuZk5lT2di?=
 =?utf-8?B?NElrVCtyY3ByMCtlK2EyelF0RlI2YWNCbGhvNGVwK2FyWVJvWU0wQ0ppdG5P?=
 =?utf-8?B?bGJQZ21JNWFyR3JmakYxNUhyNHRYUngxeWpGKzNMN1VzeS9SUGxsdWtOaUxV?=
 =?utf-8?B?dUtjemdQcGtadlJ1Y0QxNXhPbFI4RGZRM2RlaHkvbWc4dG1BdDc3dWVXUGE0?=
 =?utf-8?B?SHN5SURMWDhjUHd4VWdHdmNOcmlyY1hNNnhGdUxSZzJTWEt0YXdyQWFaNTd3?=
 =?utf-8?B?ckxxa3dzQkNGTWYvaE5YTU5sOTd5dWZ6N2EvN1oxZVpYN2xKbjNhTk1aV3Zq?=
 =?utf-8?B?ZFllRnFBdEJhQzNoT2FTekl5NWdReDh6RTVJTUc3dnVxL1YyNjJKaFRERDA5?=
 =?utf-8?B?MGp0dXhobDJBaGdjVmRzMjJlWXdZSXRXTEU2c2RPbmJBQWZxRFVFNTAzWngr?=
 =?utf-8?B?Y0p6bkVkUHFLakxleDNBeEZJcFRqNE1BQlRYWk9uRGMrVHg5ZlArYVlPT1po?=
 =?utf-8?B?UE9tekhrN2VCSEVxNDlueFZUZ2srUm9BMXgxSXBqQVdwSjliNmErY2l3NVJm?=
 =?utf-8?B?akc2bWpXRkJ0K1RXTHFPR2RKd2pHT1VsNGlVcWJDWm9uVk1PeXFGOXVseHZy?=
 =?utf-8?B?SVlYajc1REFzMlB6bGtpVzJaZk5QVDk1bkRqbWJDR3ZGYnlWRGJ6b3NpcFBJ?=
 =?utf-8?B?MkptNFhiNGk5bjdoVFplOUgycm1uNE1SYVRPemZMcU50czI5dGtVV3FhMTFi?=
 =?utf-8?B?dWFTSmZJR2o3cHEvV1VPUzByaVpNTmh1ZW5WKzRaYUVMb21MQmZhQU1VYk4v?=
 =?utf-8?B?S0VKdWhDWENPeWJWTWNiRmVqTm5JWE1vT05STWNBcGR0NVR1M1BCWHc3MlJr?=
 =?utf-8?B?RFFEd3dHYkhOd01sd2RyaU1mUDRHZmJ4Rmc5bEV1VUNncTdMbFgxRGovdDFS?=
 =?utf-8?B?NzN4Z3JQZHJCZHV3M0dGSHJqbTUrVEFCZTlnM1ZhRGpsSk5EdkxrdkhOWWtH?=
 =?utf-8?B?VjAvNkd0Q1A0cVE0RFdESzhEVGR4V212WG1CQXlOOUdKL29IVVNXcUlqQXd6?=
 =?utf-8?B?SW9YazJPTEN3Vmx5UE5vMkVMQmdYRGdUZFVrNXY2VjI4M0dVRlBDY05Cd1pn?=
 =?utf-8?B?NkJjamErOHlwRkxHaFRaRllCaTBNMWJoTVZTZ1BidFhDcnhpTUIybzFFQWFE?=
 =?utf-8?B?VDMxMGprckgxTUo2Uk1rS2RQTHZ0QkFWVHBsVHE5aXhqV3FEV3BoSnNreWxo?=
 =?utf-8?B?QWJQUS9kb1o4cWk0UjA3SjEySjFpS0Uxd21qSkZXc2IybHZ6WnhjaVNESldq?=
 =?utf-8?B?NURLRWh2dUNZQmpULzVnWnY2Uk9wOWZML2xYem9HRkY5VUEzUkhRQmZPZTVG?=
 =?utf-8?B?N2NFeGlpcFpvMnBpUzNya2FsRm9IaFpYbmVKQW1BaXhScFdwczBJNCtlcVNJ?=
 =?utf-8?B?NXZzbnZWYUMzQWYzdDBqSVZ2OXVmSjZ6MktDRWMwdDdVR3pNcFJBVW1Idy9D?=
 =?utf-8?B?d2xQVDkzTlowN05DNTQ4ejZIMXVLMDgxQVNXOWgrSVNEQzFDZFVtMWJpOFRa?=
 =?utf-8?B?YmNSMXdTdG5ZT0tYdENqK2R2bGN6Tk9VazNNUW8rV1JwR3VqMU5xZmZMT2FM?=
 =?utf-8?B?eGJHemVkV3EzbitYS0VaNEpYYzJxVm12M3ZhY0k3MGtnSTJvUzl1UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44c4074-1e24-48b9-2a77-08df400a1144
X-MS-Exchange-CrossTenant-AuthSource: IA6PR12MB893085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 15:40:09.4626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvR5vYFYKqppRqEpKHbFmqX3rruZz2Do/paKMYwhP+7c5Ku4QFuHaaekCJUZkYb9Ed4SXKRmShct9mpbx7oOTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF08EEA05B5
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/31/26 00:18, Cooper Morgan wrote:
> On my MSI MAG 271QPX32 (320Hz QD-OLED over DP 1.4, RX 9070 XT), 320Hz
> looks like a 720p image stretched to fill the screen whenever
> Adaptive-Sync is on in the monitor's OSD. Custom modes at 305-315Hz put
> it into its self-test pattern instead. Windows is fine on the same
> machine and cable. It's the same bug as
> https://gitlab.freedesktop.org/drm/amd/-/issues/5988, where an LG at
> 280Hz shows up as 24Hz.
>
> The cause is the v1 FreeSync infopacket, which native DP sinks get
> unless they're a whitelisted PCON or support Replay. It stores the min
> and max refresh in one byte each, so 320 wraps to 64.
>
> Patch 1 caps those bytes at 255 instead of letting them wrap. With the
> EDID range capped at 255, the monitor gets the same bytes patch 1 sends,
> and the picture was correct, so I tagged it for stable.
>
> Patch 2 sends the v3 packet to sinks that advertise AMD VSDB v3 and go
> above 255Hz, so VRR gets the full range. Sinks at 255Hz and below are
> unchanged.
>
> This builds on what sunryze and oystersuki worked out in that issue.
> sunryze found that the VSDB version was only saved for Replay sinks on
> DP and tested sending v3 on their LG. oystersuki suggested pairing that
> with a 255 cap for sinks that don't advertise v3. Neither has a public
> email, so they're credited here instead of with tags.
>
> Tested with the series backported to 7.2.13: 320Hz looks right, and
> with VRR on, the monitor's refresh readout follows frame caps at 300,
> 270, 240, and 100fps. Both patches add KUnit tests.

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

>
> Cooper Morgan (2):
>   drm/amd/display: Saturate refresh rates in v1/v2 FreeSync infopackets
>   drm/amd/display: Use FreeSync v3 infopacket for sinks above 255 Hz
>
>  .../display/amdgpu_dm/amdgpu_dm_connector.c   |   2 +-
>  .../display/amdgpu_dm/amdgpu_dm_freesync.c    |   7 ++
>  .../tests/amdgpu_dm_connector_test.c          |  25 ++++
>  .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c | 116 ++++++++++++++++++
>  .../amd/display/modules/freesync/freesync.c   |  12 +-
>  5 files changed, 158 insertions(+), 4 deletions(-)

