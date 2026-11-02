Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E63606A329
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 23:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TqgRj0xN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 651DF10E742;
	Mon,  2 Nov 2026 23:15:58 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013005.outbound.protection.outlook.com
 [40.93.196.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0A3810E728;
 Mon,  2 Nov 2026 23:15:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tI1p+m8ALcq9anxDUB4YZuaMpjG4IUgLqiSwz/0sGHc+oBaP0lYomG4i9rguy7+ia5fy4rtOd19tyP/5tuzhSQ7xu6PFTnUcpl0BXjQB7neRo5QbQuDynmy2/2vutb5z0q2D2NxaXuTGWJ3l5BZPSFteimNUC16iwlIzBEU2h0z9m0SX6cwyVD+ehoBGQuOduMNELBHeVvgDGMOsu2arHq2xM3F7PVuEEJeve2QpDFR0OTsjVHNoTleFDlqAnfxEPKzAVGaBJJVI2Q5QhYI0jE9SZ9D8oO+9h0whV/n/bjwNcCVyuUsWmkzBPHi2lq1GwHO2u6yUr4N/LGyjm5LErw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elN4om4Wj4D2oY7z7Asjdi257X7pBBvpZ0YFHtI17Zw=;
 b=amebr1LUG/IGscwcr3CZ9YrKrfOjAUmmP56quJd9kOxJecO0WQsoVlxeD0uYSr5jIQIwILlE5QwzbAPIjawRLC8JOEK4NwDJbN8gEfQOIT3lCa+jjZcj2pUtQTZdfeypNMWgKxgKgdCR4c7i5QpUTh85R9E7dCnEMRWplVnHVzp3oMK45PES7+ghv9443+KtUJyYanfPijJz4oBPGDfAXRnkKreaSdOooOoKiRQF/mVvOzk1xs9Zru8qzS0UoPYO+2fVaPw+0Y9s9+Q664TbTLMzKgurF0D/L7gXycBMddOYOioC36igVQ0g1qvfg2642MCAoOOsIoEoG+mU2zIoiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elN4om4Wj4D2oY7z7Asjdi257X7pBBvpZ0YFHtI17Zw=;
 b=TqgRj0xNLjRsuGRFdw6GSQknV3RHeBwmhomH1ZOc0IOC5aek6bZYofIOfXRt2ElJmp8+56e7RyAkMOes/kBSXpzosnfpCCzZuc3DZbPOU0ICeY3Re+olFw6wG2HTkthOZNfLV8AsY7/JozTexqGEoTpwuAnbi5fT9oUPagoa9mI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DM6PR12MB4417.namprd12.prod.outlook.com
 (2603:10b6:5:2a4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 23:15:48 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 23:15:48 +0000
Content-Type: multipart/alternative;
 boundary="------------rIFxsPQmzn7utaYcA9q1MtLl"
Message-ID: <48908ea6-caed-4ba6-8aa2-21f29c7ca271@amd.com>
Date: Mon, 2 Nov 2026 18:15:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Only take the VRAM path for KFD device pages
 in svm_range_dma_map_dev
To: Matthew Krebs <matthewkrebs8@gmail.com>, amd-gfx@lists.freedesktop.org,
 Aveline Noir <jm5905938@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261101012500.7048-1-matthewkrebs8@gmail.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261101012500.7048-1-matthewkrebs8@gmail.com>
X-ClientProxiedBy: YT4P288CA0059.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::16) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DM6PR12MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: c3614b9b-8d56-40d0-8e36-08df39373a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|261102123227099003|261021133027099003|261021135927099003|261026135527099003|261021121427099003|11063799006|261021123027099003|56012099006|261009223027099003|261021130227099003|261028144727099003|261026121527099003|261026140227099003|261022075727099003|261022115727099003|261022105027099003|261026130827099003|261022113327099003|10067099003|18002099003|22082099003|6133799003|13003099007|8096899003;
X-Microsoft-Antispam-Message-Info: x3iQrOHEx9W/7iWpHZnnZIIxuEMyNuu2o0kYXelUJVY6s7j4Sut9jf53JmKIlECMPLzR+vhZq/+4mi5CDNgG1DXtIYw1nS5/qC6fBilNM5OyKsc6iTD97JOpCHHfvZgWSY6izeP3cNaCmObUEI1SNumZmnbNpNH5QxzoMk17f6Nmch9NnhalwnitZv/9rjIg1VOSrchyICqPW9+tZCL4J1GUvGKTQsjMlGMa01B2ObnDQDLnhR/NNyB+8N/CLWgg5mn63mYuqOrZJeFqgDfV+MAQ+teWepIPKKb+w+9H90AlzkqK/huupI9gMGEarEOhYJIgKgLRjG4o/IwU80ny8K579uZeTBj1I7GkZ6yIscVz/0+qe/iO07ACIWgAhEZ3u59qfrvJtj+0Y9/ICy+dVusgeFa9r9KqXCzc61s/N8W1rYwpqKLi1EMvoBgMr+13aJy6DVj6EJ32opRJfya9iKuJWxC1myts7iG2K0XYZEuaL5dIyPRKaRdSMny1ICu1bPXufHifjfAIanuBm/aG+5cNFDFycYnYTF9+YTypB1lEiqQVp9Sk/j2C+Dg6mWUaJBdmS/wczfX4jhFM+QJq2sKkMC5M66bqTt8d2RRj8pHj+Nh02lcsRfaqOGBa4qWk72beRFNcpkzGmdt1arUIipZDkESgabH8+9gLnuB1se8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(261102123227099003)(261021133027099003)(261021135927099003)(261026135527099003)(261021121427099003)(11063799006)(261021123027099003)(56012099006)(261009223027099003)(261021130227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022115727099003)(261022105027099003)(261026130827099003)(261022113327099003)(10067099003)(18002099003)(22082099003)(6133799003)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVNHdC9lOWdRYXc3MitrQThXZ3JFWmNlcnpTYkI2TTJEN2dhZjhGOGIwa3Bl?=
 =?utf-8?B?WkNJd2tTQkdYNkNxTXQwSFNpcWNyazY4dUpjb1FXN0RRV1oya012YUw4NUZ0?=
 =?utf-8?B?eFRqeldlQm91UGdiM0lxS2RpRkdVMTBHUnNOREJrRGZ4MVFYT3NUZ090amZY?=
 =?utf-8?B?R3hrVDJkdGtvQlVWV28yZ1dWaDl2Yk43NFFhZkc3S2RDR1ZYbHFCWXRySlhv?=
 =?utf-8?B?WGtTMHNGTFU1SndnTkxHVGF5R0F0eFBtcytsb1VBVHUxK3RBbmdPYytrUjMy?=
 =?utf-8?B?YVpmbGVPWGJhZ2pDQkwzRGkwN21wdEhyRC9SNmh4MUI5eThBRVpZU2l5WEdj?=
 =?utf-8?B?VDVWOHRodXlwaFlOZTBzNlczUm9jbFR6UzBDV1ZRamFrQmVkcWNRSVRsL0Vr?=
 =?utf-8?B?VERzTmZVTWtLSVUwZ0ZGY0xWS0t4bkFGdkFpRFhmK0oya1lyWTZlYWlydDYr?=
 =?utf-8?B?Nk5PWlVKYkZLaEx2TTAxYkNBNjFqUjFQbkdtK3oxNnM3eVFmU2JOeS8wbnBR?=
 =?utf-8?B?S2hRRnh3dzBVV0lOMExPNzZKNUdNejkyd1ZUQnNhM0RIbFY0WE00TUlkSHA1?=
 =?utf-8?B?QXk5UXB4Mm9xMFhoTk5lczZKZWpEU0p1Yjd2T25rNWV5TCtqSnFINnI4Q0dr?=
 =?utf-8?B?SnFIZHBXUDJ3RVdTTVRGckM2azFuMjQrNnBvTy9uUHRxQzczNmUzdVJxd09D?=
 =?utf-8?B?Tk1JK1h4WkVwR2dSdlVsSzlJMGE2Q1pRdytkaWZTUkVZSWllTjZtWk9CRFZp?=
 =?utf-8?B?SnNzQmhuY3lBb01qUzhuL283ZHhYcVBWdnk5cFlmTThWRVlVbGF0c3R6Ritx?=
 =?utf-8?B?RExhSzV2VXREY3Q3cHlFcDRNb3RJU2VJUVh2WHhUVWRXZFhUYjRYOE9ncGdZ?=
 =?utf-8?B?ajZFYTRPMWZyRStmRkp0RHJQa3JNaFo3VkJlRWliQ3QveFJoSFRhZDZwSWx2?=
 =?utf-8?B?ai9lUEY2TWFJM3dpMkxjc3pmYk9TeUZCaW56OEUvMFNjSlBuWHB2QVlHT1pH?=
 =?utf-8?B?cTRncmNHUGFabmluTitqamxWQTQveFMrNyswQ21wb0ExYjlNaGs5RE83MkIw?=
 =?utf-8?B?Y2NSWFlhN2FlYU9wOE45OHdrRlNHZ0RkYkM3QjJNNm96bGIyVFljZUpoRWJl?=
 =?utf-8?B?aXhZb1hLVVphYzJqMUZ2NzJSUWtiZVF1TjVzOVlDOU1ERWN5akhmTGpoNUpn?=
 =?utf-8?B?Yk5SZHRkbnZjcnh4dmFMOVhybEJnQU5qM3FOS2g3cFlGUEl3UEs4UytpY2NO?=
 =?utf-8?B?eittNU45S0o2cWdNNDB2TjlxZStHVlB3OUo5VWRRN3ZMdUtZRjJwbG12KzFB?=
 =?utf-8?B?dlRCUktRbkdBVHNIcWJWYllkWW1wYStJZERaSDg2K0VMbVlZOFRoVmhmNWdm?=
 =?utf-8?B?ZVFGY3Q3TXJiWnF3UDNNUWp3aE4ydWl6UmxiTlN2SmljTzlLR1N2WkNQekpZ?=
 =?utf-8?B?MVc1dklHNEQyRk9Vd2JpUVhsMVh3YW83TnhpMEIrUVczZHAvVFRKam9NLzJ6?=
 =?utf-8?B?cGxjV29RZFpGMnhSWFJOQUZsOHpidzZuQ2lma2x1MHFiWXpXeDFEMVkxY2t5?=
 =?utf-8?B?eEtjQ2VldnNJUkV5OHVRSzFYU0twV0c4bXJCNEpxcDZkc3htbVlQcjNHNFJ6?=
 =?utf-8?B?QzN0Ty9iR3FUS0NTRVN3ZVFVTGdxeWhDd0ljeXIySWNRNHBZcTQ0SkUrRGh0?=
 =?utf-8?B?WStyK3ZGOVlSWWU1Z2NQREI3ZW94U2pDWDFjdEFMYXJUV1h0WG05SkVIT05j?=
 =?utf-8?B?NjAyV01SalA3VHRCTTF3V0hIS2FHbTlxTmJLZ2UzeU1kMC94NThqcDRFeVFO?=
 =?utf-8?B?RVRqZDlDS2lHU0RBNUN6U2pJS1FCN0xXd1Ztdml5OTZRQ01pRXJncEw4Z2Fy?=
 =?utf-8?B?OForQWljajJNc3dqVTRiSVpJOWhOYXhtQ2ZDN05WZHhaeVRTZXh2R1RZeEIy?=
 =?utf-8?B?RndIbmNPckdQc2FjOFo2cmRULzBNNytUK3BnQTlPWUV0TzdDMVgxYjVTQWFp?=
 =?utf-8?B?aCtXSnEya2UwOUNxc2VaVll0d0tUSjlJdjNkcHA3UUNqWk0rc1l0VS92a0Jk?=
 =?utf-8?B?bjVNMFJmN1R5Y1JLRCtPMXVNZmtZK3hDazNkWEF2czBTRldTUzFoSFM3ajRk?=
 =?utf-8?B?YStvbml3cFQvUnhvWVJPTW84ZHUvQ3NwUmhLYlNEZEY2MEh2SHRDWE5Oa1BP?=
 =?utf-8?B?RUFVRUdTVzMyR2k4RzRvdXdpMVNVZGZsckk4UWdORWZTUENCaVBCWGs4SHU3?=
 =?utf-8?B?UXdNeEUrb0tUdnNCNEFNSTJTc3BuTkp5eCtQR1Q2bWlGelpibWpNU2tUUmJy?=
 =?utf-8?B?cHhxWXZUUmdnOGxjVmZWTXBPenRCNFBuTFpRaDhtWUkreG5YWXplZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3614b9b-8d56-40d0-8e36-08df39373a8a
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 23:15:47.9511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fiJJqBWAm//ValJe8Ls7pc9hDOCQeqb9OCsLgjvkG7/Jivtfi44qZAQnAYecjaoaCLLrfhztFjZAELqPou46Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------rIFxsPQmzn7utaYcA9q1MtLl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-10-31 21:25, Matthew Krebs wrote:
> [You don't often get email frommatthewkrebs8@gmail.com. Learn why this is important athttps://aka.ms/LearnAboutSenderIdentification ]
>
> svm_range_dma_map_dev() treats every ZONE_DEVICE page returned by
> hmm_range_fault() as VRAM of the range's SVM BO. KFD's own VRAM pages
> are MEMORY_DEVICE_PRIVATE or MEMORY_DEVICE_COHERENT, but fsdax
> (MEMORY_DEVICE_FS_DAX) and device-dax (MEMORY_DEVICE_GENERIC) pages are
> ZONE_DEVICE too. They are system memory.
>
> When a process maps a file on a filesystem mounted with -o dax and lets
> the GPU access it (for example hipMemcpy() from the mapping, which
> registers the range through the SVM ioctl), the range is in system
> memory and prange->svm_bo is NULL, so the VRAM branch dereferences it:
>
>    BUG: kernel NULL pointer dereference, address: 0000000000000078
>    RIP: 0010:svm_range_dma_map_dev+0x13b/0x300 [amdgpu]
>    Call Trace:
>     svm_range_validate_and_map+0x600/0xa70 [amdgpu]
>     svm_range_set_attr+0x450/0x8c0 [amdgpu]
>     svm_ioctl+0x62/0x80 [amdgpu]
>     kfd_ioctl_svm+0x5e/0xe0 [amdgpu]
>     kfd_ioctl+0x532/0x680 [amdgpu]
>
> The process is then left unkillable and later KFD calls in other
> processes can block, until a reboot.
>
> Even with an SVM BO the computed address would be wrong for such a
> page. Take the VRAM path only for device private and device coherent
> pages and DMA map every other page, as for normal system memory.
>
> Fixes: 1d5dbfe6c06a ("drm/amdkfd: classify and map mixed svm range pages in GPU")
> Cc:stable@vger.kernel.org
> Assisted-by:Claude:claude-opus-5-5
> Signed-off-by: Matthew Krebs<matthewkrebs8@gmail.com>

This may be superseded or enhanced by Aveline Noir's patch "drm/amdkfd: 
reject foreign device pages in svm_range_dma_map_dev()" that seems to 
attempt to cover a wider class of errors in the same area. I think the 
bottom line is, that we want to be sure that the page we're looking at 
is actually a zone-device page from the same BO. I think in your case we 
want to fall back to mapping the memory as system memory. In Aveline's 
case we have to fail. I'll look for a sensible way to combine these two 
patches.

I have one suggestion inline ...


> ---
>
> Notes:
>      Reproducer (needs a filesystem mounted with -o dax; an emulated pmem
>      from memmap=4G!12G and "ndctl create-namespace -m fsdax" works too):
>
>        fd = open("/mnt/pmem/file", O_RDONLY);          /* >= 64 MiB, on DAX */
>        src = mmap(NULL, 64 << 20, PROT_READ, MAP_SHARED, fd, 0);
>        hipMalloc(&dst, 64 << 20);
>        hipMemcpy(dst, src, 64 << 20, hipMemcpyHostToDevice);
>
>      An application doing this (hipMemcpy from an mmap of a file on the DAX
>      mount) oopsed as in the commit message. The minimal program above was
>      written afterwards and has only been run on the patched kernel.
>
>      Tested on Ubuntu 7.0.0-38-generic (based on v7.0.14) with this patch
>      applied to that tree (it applies cleanly), 2x Radeon Pro V620 (Navi 21,
>      gfx1030), ROCm 7.14, Intel Optane in fsdax mode, XFS mounted dax=always:
>
>      - Before: the application oopsed in svm_range_dma_map_dev on every
>        start (3 of 3, on GPU 0 and on GPU 1); the task was left unkillable
>        and a later hipHostRegister in another process blocked in
>        __synchronize_srcu until a reboot.
>      - After: hipMemcpy and hipHostRegister + copy from the DAX mapping,
>        64 MiB and 1 GiB, on both GPUs, data read back equal; the same on a
>        non-DAX file; the application (an LLM server mapping a 111 GB model
>        file from the DAX mount) starts and answers requests. No oops.
>      - With dynamic debug on svm_range_dma_map_dev, the pages DMA mapped
>        during the copy have pfns inside the pmem region, and KFD's own VRAM
>        pages in the same call still take the VRAM branch.
>
>      Not tested: MEMORY_DEVICE_COHERENT systems (the GPU memory registered
>      as coherent), device-dax (/dev/daxX.Y) mappings, other ASICs.
>
>      A stricter test would be "the page belongs to a KFD pgmap", e.g.
>      page_pgmap(page)->ops == &svm_migrate_pgmap_ops, which also rules out
>      another driver's device-coherent pages. I used the type test because it
>      needs no new helper; happy to switch if you prefer that.
>
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index ed5e33188..354184829 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -180,7 +180,12 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>                          dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
>
>                  page = hmm_pfn_to_page(hmm_pfns[i]);
> -               if (is_zone_device_page(page)) {
> +               /*
> +                * Only KFD's own VRAM pages (device private or device coherent)
> +                * take the VRAM path. Other ZONE_DEVICE pages, such as fsdax or
> +                * device-dax memory, are system memory and are DMA mapped below.
> +                */
> +               if (is_device_private_page(page) || is_device_coherent_page(page)) {

Could we check the page_pgmap(page) here as a more reliable way to check 
that the page is actually coming from our driver, rather than just using 
the page type? I could see hypothetical cases where a device_coherent 
page comes from a different driver and should be treated like system 
memory as well. Looking at the pagemap would catch that.

	if (is_zone_device_page(page) && prange->svm_bo &&
	    page_pgmap(page) ==prange->svm_bo->node->adev->kfd.pgmap) {
		/* local device memory, no DMA mapping */
		continue;
	} else if (WARN_ONCE(is_zone_device_private(page))) {
		/* fail ... device private memory from another driver, this should never happen */
	}
	/* system memory case with DMA mapping */

Regards,
   Felix


>                          struct amdgpu_device *bo_adev = prange->svm_bo->node->adev;
>
>                          addr[i] = (hmm_pfns[i] << PAGE_SHIFT) +
> --
> 2.43.0
--------------rIFxsPQmzn7utaYcA9q1MtLl
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2026-10-31 21:25, Matthew Krebs
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261101012500.7048-1-matthewkrebs8@gmail.com">
      <pre wrap="" class="moz-quote-pre">[You don't often get email from <a class="moz-txt-link-abbreviated" href="mailto:matthewkrebs8@gmail.com">matthewkrebs8@gmail.com</a>. Learn why this is important at <a class="moz-txt-link-freetext" href="https://aka.ms/LearnAboutSenderIdentification">https://aka.ms/LearnAboutSenderIdentification</a> ]

svm_range_dma_map_dev() treats every ZONE_DEVICE page returned by
hmm_range_fault() as VRAM of the range's SVM BO. KFD's own VRAM pages
are MEMORY_DEVICE_PRIVATE or MEMORY_DEVICE_COHERENT, but fsdax
(MEMORY_DEVICE_FS_DAX) and device-dax (MEMORY_DEVICE_GENERIC) pages are
ZONE_DEVICE too. They are system memory.

When a process maps a file on a filesystem mounted with -o dax and lets
the GPU access it (for example hipMemcpy() from the mapping, which
registers the range through the SVM ioctl), the range is in system
memory and prange-&gt;svm_bo is NULL, so the VRAM branch dereferences it:

  BUG: kernel NULL pointer dereference, address: 0000000000000078
  RIP: 0010:svm_range_dma_map_dev+0x13b/0x300 [amdgpu]
  Call Trace:
   svm_range_validate_and_map+0x600/0xa70 [amdgpu]
   svm_range_set_attr+0x450/0x8c0 [amdgpu]
   svm_ioctl+0x62/0x80 [amdgpu]
   kfd_ioctl_svm+0x5e/0xe0 [amdgpu]
   kfd_ioctl+0x532/0x680 [amdgpu]

The process is then left unkillable and later KFD calls in other
processes can block, until a reboot.

Even with an SVM BO the computed address would be wrong for such a
page. Take the VRAM path only for device private and device coherent
pages and DMA map every other page, as for normal system memory.

Fixes: 1d5dbfe6c06a (&quot;drm/amdkfd: classify and map mixed svm range pages in GPU&quot;)
Cc: <a class="moz-txt-link-abbreviated" href="mailto:stable@vger.kernel.org">stable@vger.kernel.org</a>
Assisted-by: <a class="moz-txt-link-freetext" href="Claude:claude-opus-5-5">Claude:claude-opus-5-5</a>
Signed-off-by: Matthew Krebs <a class="moz-txt-link-rfc2396E" href="mailto:matthewkrebs8@gmail.com">&lt;matthewkrebs8@gmail.com&gt;</a></pre>
    </blockquote>
    <p>This may be superseded or enhanced by Aveline Noir's patch
      &quot;drm/amdkfd: reject foreign device pages in
      svm_range_dma_map_dev()&quot; that seems to attempt to cover a wider
      class of errors in the same area. I think the bottom line is, that
      we want to be sure that the page we're looking at is actually a
      zone-device page from the same BO. I think in your case we want to
      fall back to mapping the memory as system memory. In Aveline's
      case we have to fail. I'll look for a sensible way to combine
      these two patches.</p>
    <p>I have one suggestion inline ...</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20261101012500.7048-1-matthewkrebs8@gmail.com">
      <pre wrap="" class="moz-quote-pre">
---

Notes:
    Reproducer (needs a filesystem mounted with -o dax; an emulated pmem
    from memmap=4G!12G and &quot;ndctl create-namespace -m fsdax&quot; works too):

      fd = open(&quot;/mnt/pmem/file&quot;, O_RDONLY);          /* &gt;= 64 MiB, on DAX */
      src = mmap(NULL, 64 &lt;&lt; 20, PROT_READ, MAP_SHARED, fd, 0);
      hipMalloc(&amp;dst, 64 &lt;&lt; 20);
      hipMemcpy(dst, src, 64 &lt;&lt; 20, hipMemcpyHostToDevice);

    An application doing this (hipMemcpy from an mmap of a file on the DAX
    mount) oopsed as in the commit message. The minimal program above was
    written afterwards and has only been run on the patched kernel.

    Tested on Ubuntu 7.0.0-38-generic (based on v7.0.14) with this patch
    applied to that tree (it applies cleanly), 2x Radeon Pro V620 (Navi 21,
    gfx1030), ROCm 7.14, Intel Optane in fsdax mode, XFS mounted dax=always:

    - Before: the application oopsed in svm_range_dma_map_dev on every
      start (3 of 3, on GPU 0 and on GPU 1); the task was left unkillable
      and a later hipHostRegister in another process blocked in
      __synchronize_srcu until a reboot.
    - After: hipMemcpy and hipHostRegister + copy from the DAX mapping,
      64 MiB and 1 GiB, on both GPUs, data read back equal; the same on a
      non-DAX file; the application (an LLM server mapping a 111 GB model
      file from the DAX mount) starts and answers requests. No oops.
    - With dynamic debug on svm_range_dma_map_dev, the pages DMA mapped
      during the copy have pfns inside the pmem region, and KFD's own VRAM
      pages in the same call still take the VRAM branch.

    Not tested: MEMORY_DEVICE_COHERENT systems (the GPU memory registered
    as coherent), device-dax (/dev/daxX.Y) mappings, other ASICs.

    A stricter test would be &quot;the page belongs to a KFD pgmap&quot;, e.g.
    page_pgmap(page)-&gt;ops == &amp;svm_migrate_pgmap_ops, which also rules out
    another driver's device-coherent pages. I used the type test because it
    needs no new helper; happy to switch if you prefer that.

 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index ed5e33188..354184829 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -180,7 +180,12 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
                        dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);

                page = hmm_pfn_to_page(hmm_pfns[i]);
-               if (is_zone_device_page(page)) {
+               /*
+                * Only KFD's own VRAM pages (device private or device coherent)
+                * take the VRAM path. Other ZONE_DEVICE pages, such as fsdax or
+                * device-dax memory, are system memory and are DMA mapped below.
+                */
+               if (is_device_private_page(page) || is_device_coherent_page(page)) {</pre>
    </blockquote>
    <p>Could we check the page_pgmap(page) here as a more reliable way
      to check that the page is actually coming from our driver, rather
      than just using the page type? I could see hypothetical cases
      where a device_coherent page comes from a different driver and
      should be treated like system memory as well. Looking at the
      pagemap would catch that.</p>
    <pre>	if (is_zone_device_page(page) &amp;&amp; prange-&gt;svm_bo &amp;&amp;
	    page_pgmap(page) == <span style="padding: 0px; tab-size: 8;" class="hljs diff colorediffs language-diff"><span class="hljs-addition">prange-&gt;svm_bo-&gt;node-&gt;adev-&gt;kfd.pgmap</span></span>) {
		/* local device memory, no DMA mapping */
		continue;
	} else if (WARN_ONCE(is_zone_device_private(page))) {
		/* fail ... device private memory from another driver, this should never happen */
	}
	/* system memory case with DMA mapping */

</pre>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20261101012500.7048-1-matthewkrebs8@gmail.com">
      <pre wrap="" class="moz-quote-pre">
                        struct amdgpu_device *bo_adev = prange-&gt;svm_bo-&gt;node-&gt;adev;

                        addr[i] = (hmm_pfns[i] &lt;&lt; PAGE_SHIFT) +
--
2.43.0
</pre>
    </blockquote>
  </body>
</html>

--------------rIFxsPQmzn7utaYcA9q1MtLl--
