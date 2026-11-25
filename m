Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D92606A697
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 03:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uo4BA6Pz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A38C10E486;
	Wed, 25 Nov 2026 03:43:38 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012070.outbound.protection.outlook.com
 [40.93.195.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64D8710E486;
 Wed, 25 Nov 2026 03:43:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAD4pQGhPVL98jwR4ZkNp04nMpdf5i0dP7gzk7+K/3MR28cuhi+Ek+Iwv00aJ1PSqR7U5J3B5U6B7rXylTPMD6XAI8tDJb7zH0KhapezhJaWkbhKg9EGe5UH8N3zCAQ+ggW0GIoZz5Dtc/44uP804OFGv6woic4BQY04LmTC1IRC3QKXSlEWUK2jDEu6blZcXkV2c0Sn3nF/rsvWILj4kRoR9StbHx2X3xOkPGr4myb15GcKQUnxhBbOVWk6KeneZ1DErmbhj14DWXoP095VwkLbzRdrmBf9FMV+u/ovYFEVPSJ34bfu1xHNL6nqgTeQZHVfOIF25dTLU0w1dg27XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0oLOQACOMGmkdH+4I1ZJMI8Nu9Ri4ojFwbbOG3yLD0=;
 b=e6Dyka8nhcwzS9+lKE4ucyFtiBaMm9Ht3e4ek7zyWSTYXpPsdPR3aRuhab1Kx7kPXIKkJy/MOIIfGWw59DycCVjneNKLNelslEFuJfkxZilAkY/n7+hshDXHgpYuZMNCvTHKsDTjEOxuOzjtUqox6jStZjzeW6ZlG9t1/IpADKBSFXVz8EtewFNuyDyJ0tiyY062mDugADcgezyHo3WSav1KxG5DJj9/cPivzdGLRyFj9Jrupc90axUy88mIFhgLz4epNWBDUnvJJoErfR/ifkDpdvzIrAlzkwkdB5kcRS0jIqTIS/Tjn557Fat/Dtb2O6W8pQx8UmNhtWEwsnxdEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0oLOQACOMGmkdH+4I1ZJMI8Nu9Ri4ojFwbbOG3yLD0=;
 b=uo4BA6Pzm5aXGSU3XhNJ4bavYDvCVkXQXKWTJpqVcPYPFkWfewpMsbMB4KQ0JwM9GahaMQacRGyFHJBDTVriQhzn0+YTETha7K9OtrcEMMNZPOpwenUd+UfrA3/KE0/BO90OHwWamJAK4rfLdfpJnz6EbsMOkbzaIp2lAZX7qsU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Wed, 25 Nov
 2026 03:43:29 +0000
Received: from MW6PR12MB8705.namprd12.prod.outlook.com
 ([fe80::e75b:745c:ed13:f321]) by MW6PR12MB8705.namprd12.prod.outlook.com
 ([fe80::e75b:745c:ed13:f321%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 03:43:29 +0000
Message-ID: <22efb3e2-e101-4a4d-9ece-35141ceeb948@amd.com>
Date: Tue, 24 Nov 2026 21:43:28 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] drm/amd/display: Add Gamma 2.4 and 2.6 colorop
 support
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
References: <20261119195158.2546927-1-harry.wentland@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20261119195158.2546927-1-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0336.namprd03.prod.outlook.com
 (2603:10b6:303:dc::11) To MW6PR12MB8705.namprd12.prod.outlook.com
 (2603:10b6:303:24c::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8705:EE_|MN6PR12MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db5e86c-5349-4d95-9c68-08df4aa644f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|261026140227099003|261022105027099003|10067099003|11063799006|56012099006|261021123027099003|261009223027099003|261009221227099003|261021121427099003|261028144727099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1faRbQG0klhdMHNZKLhS4k5rYUMvkeoWBo/PxQYmoMs5IumPMhwXS/tZ0pNYTO6f+egykF9drSSYhWGSXy5CoYzKCORM5CJWsUDwSgy3Q4YlOfBFCN2nqXklu54GkuWedpwspl2cD8DfJkZmz5g7MNOTKtz/rrTsfluYBNILmaUJkauu4/ABByVjdLkQ2TGequ7cqF9ZqZVHNuSpWhRpaN78/biB1+yI4u+HK1rD9IGikvWHlpHl+s7J2w4jQRPsbtnLTXGleVVacyZUKyGxTwGYUPT4/Z5aUzgpyrLd8Zu4NO2ZY1QkFz9RdrgDzhW21BjzvCdMhjNk5N5/5bFEthwkm4GkKFnH99Pgl0hwa1kkCi36ZD0zG+Js4YvmQjoccN2uMXvk+AKeaCN/FXLdjFM0UwTH5jmPSVluk/IPBC2tVGps2SIPQGGC9F1sxSQUtmprDkwgOhh69yF2MMg636xcHMoVOKlzThDzpYduVPcNhj+hd3LNYr4/Tm5G0QYTu0X3seiRLsAffHMJb2+E9I2OZ0VU0zd6BYm1D8yJnEFtqce4kX5o3H9msqiiTZxKkwmIqGcl8J2bmAQ2MtI4SAKMYNl0FQIm7hAlEwzJ/PZX/cHjudos9iqQHEZV+csBqtS53zpNoSMDwT4ioD6sLYR8v7F0LXUEIQt4OFgPGOc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8705.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261026140227099003)(261022105027099003)(10067099003)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(261009221227099003)(261021121427099003)(261028144727099003)(261102123227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEw5NjN4NTBnS1YyTzhrUithdEF0M1EwdFZBcGNJR0loY0xxazBDd3RHZ2NJ?=
 =?utf-8?B?OTRXQlcyNzRDWHpncDgzcGYrVncyUDEzNDB4ZkhnNnVzei8vVmh6dUhFSGNq?=
 =?utf-8?B?d0VwQmhRQkUwUUdMaFZHeUtra1BCejZFZnpsV0dTVk0wUENkeEZ5WDdnZGYv?=
 =?utf-8?B?QnFVaVlIa3pDYUlHaU9MK0ZtQ0ZGTmFxVU1ZdzlDM0YvSjcvSW5Ca0x2Vlo2?=
 =?utf-8?B?T3BzRkpFREFEUnNWdzVldkJVT3lYak9qUWh6dUhFYlhwNlJ2eDZiQkdMbXR2?=
 =?utf-8?B?c2ZyZHlJeCtBTmRiSUozeFowQW5lcGlPYTE5REdoZmR1Y2p5ZEtEc1N3azRN?=
 =?utf-8?B?UDAxVStpbSt5V1o5RW0xcHIzc3c0NEhFMDV0aFREYUkxU1VsME1yeVdidkpF?=
 =?utf-8?B?c3J5anpoSnFXVDNtOFh5emxzblZrdzI3QmVCUVdmcXlRVldZcytHZkd3dmNE?=
 =?utf-8?B?Ukd5ZzIyZ2Y0NVVicEFSbU5qQjNTWHlMZmhTRjhkMWVFRzN2NGtpazlxNzQx?=
 =?utf-8?B?NkZYaTYyNmZOU1Z1V0UycktJWGcxYTBOaXJlT3psb01EUFBWQWd2WVdnZlFm?=
 =?utf-8?B?MWRYakNzRi9rdkJxeWdGc1E2bHc5YkZRNytUNmRYNjdoOGREM2ppU2p5V3Nv?=
 =?utf-8?B?bVljMmYrOWFiTTNUek1IbWhUMWtGejNzSC9naElSZFN4NzVhODlOQlBveWhX?=
 =?utf-8?B?c2JvaVdvcitzcVRwUDMxMk9tWVdYY2h2WTVEdUhUMWZQa1pWSUJOL3Q3eTl6?=
 =?utf-8?B?bjlnSXJBQlRQdFFLOWFhRUV5ZzBraVNvWWYyRlhDTkNvcUcxU0NQVWZWRWZ6?=
 =?utf-8?B?bmpOMnJmS2lzem1HN1IyeFJ3Qkp6UHU3YTQyZ3hEZzRUNWh0RS9xM2VHei95?=
 =?utf-8?B?R0Izek4yK3ozWlU3NEFnamhTR3NZVit1YlBVQWNKWVVuUXpLYUM0SEFKUUZq?=
 =?utf-8?B?ZG5HdTVBRXBkR1JHT0lYRUZSSy9TNlBXYnhjNFpMQk1xV0c1U2FwM0R3N1Vi?=
 =?utf-8?B?cDJ5UlNQSUZPd2JadUhLYW9mUEs0SUpxS3dCbUVLdHdKQmlpV2o5VGc5NnBW?=
 =?utf-8?B?WFpzd016OHZOL0FWdkl6YVgvWEQ2T0tKSzlsSUZQTTZHdFRhZlY5UnZCWFFO?=
 =?utf-8?B?clBPcWw5U1pvTDE5eXlUa0VrV0s0Zk5NRGIySDlHc2xvL3ZMZjQ1RFNDbFpJ?=
 =?utf-8?B?S25LcFZoemtyRDByWTYrTEJDblhNYXhIYWFESTAwZkxiZlZNT1o5VWVwTjZz?=
 =?utf-8?B?cWRzcDBoUHZpUEhGQkthWnNBRGFMaVBBdUtKaDJ6aTYzaVU5N1lkc3RBREZI?=
 =?utf-8?B?OSsvK2RqODQyd2VyRUZXUWtDcmo0WVV3aVBVTXNwYk5ybjQvVlhpNStTRUhM?=
 =?utf-8?B?R1VIWWZpTUo4Qldmc1dGRGwxSFdCcm9KTDRoUHpMSGo5TytGdE05SjZwOHhM?=
 =?utf-8?B?RGNSS1ZhbTdPd2liVmVsMVFSVXVEc0lDNDRhT0ZiOThLQkJmdXBYR2d2UFhp?=
 =?utf-8?B?WGhNSWxWdXBiTnc0ZVlTK2pMdm9BOVVIRTFvU2dBY1ZXc1Y2b0FQdXdZdFFh?=
 =?utf-8?B?RS9DZElVZzg4TkpWa0c1QXBJTVhRYkJaWWQwSFNFeXVrTUVSZUV1cndLY2My?=
 =?utf-8?B?T0R1YTJTMnR4ZWtPbkdMblR3Q3N5K00wZnY4YWlkOEM0UGtkUXlCc2c0Tjht?=
 =?utf-8?B?dU1kZ0RWMGZOekZ4dFlYUWJIMllEbVdFY3JsWEhyeHBrTmRST0p5V1hsSDFi?=
 =?utf-8?B?RHBkTGw0QWp0U0d6STI2a2RrQzlOdU8vSlNyQ1h1V1d1UXY5ejFHNVZjT3dM?=
 =?utf-8?B?REVZVGpjZjZaNEdoVWlubU5IeDMvR1VDVGxVRlB3cmtrd3JYbGhJRk9yNnd6?=
 =?utf-8?B?SHNRdU9ISGhSUVFnS3B0enN6VjZxYlgwaExyVlFSaFEvKzIrOUkyVjJBWk9k?=
 =?utf-8?B?OTJjZXFXMUp1UWFMZXJIbG5ENWRaeUw4MWFqVnlnaU5xMitGamQ1bUV0N2l0?=
 =?utf-8?B?VnA0cklLQ0RucnNtamVaME1qbTh1cWFrM3dKaHNOeS92dXppa2NwVWpiUnNK?=
 =?utf-8?B?NUNEdld4T05ET3JLRm9lV3N6ZkhVbTRDbXAyWHFuaHhCbGk4NXhTQ2UrU2VO?=
 =?utf-8?B?UnI5VjROZGFYNjFyZ0UzUXBVWHhSa0FlcHhTQ25Fa3BhcGZ6V3lNaml4a2tG?=
 =?utf-8?B?YSt5aFREeVRaM3FOSzkrcWNoeVN3dTlibU9rSDk2NmlldnpJYzFITVpwNkdC?=
 =?utf-8?B?akJKdlRFN2FTYmlTazVLV2N3K3BubDJzNitraC9JQ0ljR1p2dlVFYTdPSEp1?=
 =?utf-8?Q?fuOM0Ne2P/epxj+vUZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db5e86c-5349-4d95-9c68-08df4aa644f6
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 03:43:29.3712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxnzZRPHzfq5TyCuCDqAJx6EouP32HfuMFQD8yKJTPF1wAiLNq1xbEqE+a7tk52agISGqlbrxmkynWAVpns/ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8590
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nitpicks in patch 2, and this series is
Reviewed-by: Alex Hung <alex.hung@amd.com>

On 11/19/26 13:51, Harry Wentland wrote:
> Mutter needs a pure 2.4 power curve. The color pipeline only has 2.2.
> This series adds 2.4, and 2.6 for completeness.
> 
> Tested on Navi 48.
> 
> IGT patches for the Gamma 2.4 and 2.6 tests are on the igt-dev mailing
> list.
> 
> Changes in v2:
> - Put gamma 2.4 and 2.6 on the wide curve in
>    cm_helper_translate_curve_to_hw_format() as well (Sashiko).
> 
> Harry Wentland (4):
>    drm/colorop: Define Gamma 2.4 and 2.6 and its Inverse
>    drm/amd/display: Use the wide curve for gamma 2.4 and 2.6
>    drm/amd/display: Add support for 2.4 and 2.6 Gamma and its Inverse
>    drm/amd/display: Add KUnit cases for gamma 2.4 and 2.6 colorops
> 
>   .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  6 +++
>   .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 12 +++--
>   .../amdgpu_dm/tests/amdgpu_dm_color_test.c    | 18 +++++++
>   .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  | 54 +++++++++++++++++--
>   .../amd/display/dc/dcn10/dcn10_cm_common.c    |  4 +-
>   .../amd/display/dc/dcn30/dcn30_cm_common.c    |  2 +
>   drivers/gpu/drm/drm_colorop.c                 |  4 ++
>   include/drm/drm_colorop.h                     | 39 ++++++++++++++
>   8 files changed, 132 insertions(+), 7 deletions(-)
> 

