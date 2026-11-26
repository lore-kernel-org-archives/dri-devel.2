Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A5F606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jhcn/KRJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4940610FF08;
	Thu, 26 Nov 2026 07:09:58 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012032.outbound.protection.outlook.com [52.101.43.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 876A810FF08;
 Thu, 26 Nov 2026 07:09:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tauSOUVQ/uA0Ua8e+flW3Rdf08veLXhYoU2Sz94vRD0aVxnze4893emUUCh13afo2/2KyJQWWYkbE2mMyaLJPGCGY3p4Jd3/wPdqwhsh7tGEXi4YIteAMswUvJ2YNaQd4GMicnyCbfvR6n8G7u2sENn0V8W6aw+LkaeKZcM9eB45tmHdVG7pUdsCZebhQ4JCC8oASYq02iUXgNej7lU1ztWq4IHsGEdwT2cbqHz6vAfB7f3UKre/FdAe7bPGxFn5nBestLQ/4L/g7P8PxnZ76cJI0Yln60drRZgC3DE5dAgD1HTAsKzFAh1YWSr0gEW3aprgfR3UI2UMuxbexJtcLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axM1dj/gNiR7L8LDkog9ZdPdhkAJ2jCwUv5mkjYXUU4=;
 b=aR3Z7vfNZIpHvEfXdk8wvd6rW9ZBtvmnErUnEsqyD29/JDw+GazJZjNsfkK3yU4/vbKGYxkx77s1JYfx7Bm9abHs4LFVR7t3Qaz3HoCT0m1ezkhd6gH2xdhDVHMnJy3ZtD2D/0NVMkQ8jXRIyG3e1QH0N3ZWHB/Kio4zwtiRhgsIhCLfhhDdLIrt6sNHbCwkzdurrY+lhNtlsIg05KJ69YKw5WNskj7T3ZXLsih7Gd+E19kY7FLLjvJtRsmCBi7UDjGvs/JTE4QpbWZut5MlZUl2IOBXHMPiWF9f6l60MxbaMkI5verKX5Tr5o57VTBLzgXGa1x5AeMQs3642Dp8Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axM1dj/gNiR7L8LDkog9ZdPdhkAJ2jCwUv5mkjYXUU4=;
 b=jhcn/KRJR5jAK8aQus4MAIqmlK+hl8hu6QEFeX8zYvwYgsxN9S0h7xEkMZqR6vGQ0gAFCvaqqM8XpOTwNwONvCA1G/cJ7v7QBsMEUTpOg8o4rWMTrU7WOg0jk+LaDPz1E7iLuocmqsjX7irLzwD/BF4zA8wNHGZMk9NriDh+whSDuq7fs31sU9GlN87caZwPIwFkuAI68DgK4XFlo2nAQmKxetFXF+1Hu7mW8o0fWrpGq/sh0dVH5+X5tCOWsaVEL8ULfvqZFxED9FnzghPeyefxaK4DK8dniTgRUuvORl4E34yGDhM3U3WfR1ix8ZGS+7QrPwtRQcyMSO1aOucO4g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CY8PR12MB7193.namprd12.prod.outlook.com (2603:10b6:930:5b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 26 Nov
 2026 07:09:46 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0639.012; Thu, 26 Nov 2026
 07:09:46 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Aaron Kling <webgeek1234@gmail.com>, 
 Diogo Ivo <diogo.ivo@bootlin.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] drm/nouveau/tegra: Keep the fuse clock enabled
 while the GPU is powered
Date: Thu, 26 Nov 2026 16:09:42 +0900
Message-ID: <vaif4BJtRCizzGlGyucUTw@nvidia.com>
In-Reply-To: <20261016160700.3831336-7-sashal@kernel.org>
References: <20261016160700.3831336-1-sashal@kernel.org>
 <20261016160700.3831336-7-sashal@kernel.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: OSTPR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:604:220::19) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CY8PR12MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: 0478ce89-23db-4a55-3987-08df4b8c40a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|10070799003|366016|18002099003|22082099003|4143699003|56012099006|11063799006|260925022911599003|260925021911599003|260925021311599003|261009223027099003|261026121527099003|261022075727099003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261021123027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: LuP8uviXSTKJMR/3LVsiGtmC9l9WymnetmCF1oeL5Z72w7v/6z4/8KUn+LChOVPkIFnCYL7mPERlepUvE47DF1AcWEL3dEykBrupA/cw5jryRUqytM4QzMhGSOQiGUabP1Ed4PHY2AZOxAUT6SvvuTlyaHyAXo1o4T/7f99r75a7LzX8l9oAAb4gdeLTnxajEH/tvasqUL/N8e+wHJaNnA7vwlI4nYFN+ZwOw7A1AJ38ubqFpajsqXd4+PViYFl/CHe6gP9dK3KWT0D4+lvve447jm6EzCE8YUlUNMu/tyb2v1WeYYJsU9j5dPIn5v6X/RwN2YAme/lGCF8lUJHv5ZPrrS+zT13KjxT9nDw0kRus90AIPVy81xW9YvdGikPmnxAvFD4G8f8wLXS0Y6TorxF5NiNidkR7FI4r6XIKcbX7CUdk80vZgIKH1Hqnff2HiS+9MyDm3hPlqFGkSP6r8RD19ip39OmEonbn8qZ/Qe/EwhHz1PFMSwWhak3XuUk3z25swzvLGT7UMd1IYScxCLW6vgYYG44nfrr3z17G8GvsPWGtWdrIw2t2sxDgi4b9m/eCD1GS8fty2Ecj3nZb/0mTJ4Vdf+oZY4lH1a2P1jETaxt2bf9TICBoV2rzOm2/qLVfYfNf8fXtAVM1GGNtEctdWf6mbq8x6+buzNQbjoI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(10070799003)(366016)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(260925022911599003)(260925021911599003)(260925021311599003)(261009223027099003)(261026121527099003)(261022075727099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261021123027099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUJRQnRjaDJQYzI4NlA4SDczU1dENzg5YW51VjBOUko1eHo5Rk55Tld4Zmdr?=
 =?utf-8?B?OFRNbDZiekVoRmV3MU9ZQkFBMEQ2WTduVElFQk1leGpZV1czTVN1aWExSlBa?=
 =?utf-8?B?RTlWd2sxVS9BU1JtaTlRWStkeEllQUx0aFZ0OWN4MEtJUHpoM28yQzI2aERN?=
 =?utf-8?B?Tjdva2NmKytXTWZDREFvR1dHd2NrQjBvbjhtdVF3M3J6ZlBJSzd0TTA2N3lT?=
 =?utf-8?B?cHJtR0N5UHNOWC84OWV5Uk4rMnJzUHhweGJKY3FIOE1WcWlyZTVrYVNyQUlx?=
 =?utf-8?B?UTFPSHNOb2RLVm5uRFRUby9ZdmhWOXVsRzlNNkNycENrVHJrclFHc3hOckJL?=
 =?utf-8?B?dmpxWVd6cHl6ZXFxRFU0Tk1SZ29UcHhvNGx1aE1EWFhLM083R3JyYUZpSStj?=
 =?utf-8?B?bHRJUkRLQmsrcGY2UWU5RlFtWTY0Sjk4SXB6SEVpN0RGVFA3aUd5K2xwdDZp?=
 =?utf-8?B?MkNIUHZhbHNUS3kyL05Gei9jc3JlQ3QxN1JJTExadXFoRnJ3enp5K3IrV3B4?=
 =?utf-8?B?Z3BOSmdJempQWnN5b25QQmZpN2d6WElUdXBWeXRVOHNyMkxNNEx6endFektk?=
 =?utf-8?B?emd0aWJDQVU2OVQrdE5ST3lmdUtyWHdROXhac2s0YnNEdGdKTXovMXhQS1VV?=
 =?utf-8?B?MmZWQ2w5amJtVzJIRE93bE40VHZGNkZES0p6THVXM1krOTJ0OHRXNysxQzhP?=
 =?utf-8?B?Q044Y0tBNE1kMVVadVl5ckVUa0xoQ1lTY0tZRUQ2dVNQcnNDZk9CZDN6OS9l?=
 =?utf-8?B?aFJrU2tWeHBRQnlzaUZqblFxZ0FKK3hvU3pDVGwxWDRHeGlabmFyUHF0cmUr?=
 =?utf-8?B?M2h6a2pZc2Q4WkU2TXE5elYrVlJ6MXdYeVdPVEFoc0xJZUxPSG5leHF4UzVK?=
 =?utf-8?B?QTRnMXBJU1hKZkcyNDNWSUhSMjVVblZaZ1c4QXc4VUNOaXJyOWYxVE1sYm9y?=
 =?utf-8?B?SGxDUDdZRmJPaXR5R1ltY1U0eDJSSm9ibUMxN3cyS09IRjBkTUo1bXl4RW1G?=
 =?utf-8?B?TlU3QzdBUU9wcXFpOUR5ODVsRzgraGYzM0VJdHJNUGdWcXV6US95NiszcDYr?=
 =?utf-8?B?YWRiNGRhUDZjUlp6M0MwMXlmek94elVqcjdWOTgybzlSZHhpTW1ZL0VjOXRN?=
 =?utf-8?B?QjBLc256Z3FXci9IS1pJQ1NDdW1mVmN4bnROTXVIOWRuTitCd0M3WXMraGhw?=
 =?utf-8?B?enBoVEw5MnV0aEtGOVVzZHhub1ZwUWJwS29HMm9kNjZBb0poK0JMVExIaFE5?=
 =?utf-8?B?Z1B1RytNUHF3czVUSWhJWUVBQTZ2MndieDF3aUJjQ1JuQW9zZW9yK21jSUd3?=
 =?utf-8?B?aUVHU1J2WkNNS3BYUTAvMTNoNlZPOXdHRkZJV3cwVkRIRW84WGRsWnJwR0J6?=
 =?utf-8?B?VjA3bTMyRng0eWpQNjd6Z3pyWGcxVldkaXVvTk9UZ1BlVDZ6ak5LUkVnRUJQ?=
 =?utf-8?B?WDJVR0F3OE9yUUVzaHJIdlpoVmZhTjRwUW9wb3B6Mnk4RmFIK0MvRlRNQlQ3?=
 =?utf-8?B?T2g2SFpCZm9hVGluL21xNWQyQ080SlFsVTFPRWg2N2xEOTFEZUF4TzFDcnF5?=
 =?utf-8?B?WWxhTHZxdGs1d2NtNVZ4ZWI5Nks1U1lEL1JVUG1ZUXZoYnFSZDNaNTdGeW9E?=
 =?utf-8?B?TWZTVlJQTXpVbENGUTVody9MQUlkdUFRdi9qbTlFL1RpZGRSYkp2b3lvU2JK?=
 =?utf-8?B?TlNiaTE0SmFQQVYzT2hLNW5GMVltd0RWMDBpaE5tdWRDRUlGOFlQMHA1VzFi?=
 =?utf-8?B?OTVzTlpTKzgxQ2pwSDZBcGxHWWE1NEpaSTVOQnVLWVJacFEzOUxXMSt6RExQ?=
 =?utf-8?B?UHM2Vnd2VExja1JHT0pTK0lodTMzSWcrYlV3SmFyai85UC9jeng5THFhQUhO?=
 =?utf-8?B?VGdCMzR2bHhYYXRDNkthOWtKanMyZjVJbU1OQmJJSVNsYTJTWjQxVkpYUU5K?=
 =?utf-8?B?R1g4M01jSnBVYWZMa1Jac2xVd3orOVJlZjh2NjRqalExamtvMmxaNVA5NG1K?=
 =?utf-8?B?OHcxOUp3Q3dzbXk0MHl0RVkwUm9QcEQvOEVPQVlaWHE4WHNwQlEwUDdWQ0t5?=
 =?utf-8?B?a0pqUUR2U1B5ZjBBZ0htbDg0cldjUHJzS0MwdUUvMFF4Y0tBVUJNc0dtTEpr?=
 =?utf-8?B?Q1gwRmdWRG9xNHE4T3kxRG9qRVVsK3B2QVVRbm4xZE16Q09SV2tHMGxYRmx2?=
 =?utf-8?B?aHJyWGlPalNMZ290ZkJ0UG04ZWRWOGdYRW05WTN3T1J5K050ZkFCNzFtOVFk?=
 =?utf-8?B?Ty9BekZDVkpIdVNYZEtnaUx1SHhwdHY4eVJianZydnRML0NseGdoVG8vR3Nw?=
 =?utf-8?B?Rk5HS0FiZFp3VStTcVkzWXpvOGRMMVFwN2VuODBaWVd6Y0lSanVtWGZLYVJQ?=
 =?utf-8?Q?naRa23O7kv+VO/0uQw5B5cTkraEZfC2kt4tSAmaQEL+Vc?=
X-MS-Exchange-AntiSpam-MessageData-1: Gdyu+ulkrthP5Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0478ce89-23db-4a55-3987-08df4b8c40a9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 07:09:46.5489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyMNCO8YviqFRvKPDSmw6G2kpSWeB8HRVPwEGqd8Q+MAUZWI52c7w9sAUGsQxfh6KYgzTI16bFQO9/Aq19l6gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7193
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Saturday, October 17, 2026 1:06=E2=80=AFAM Sasha Levin wrote:
> Since the GPU on the Jetson TX1 was enabled in commit d1b725476104
> ("arm64: tegra: p2180: Explicitly enable GPU"), nouveau often fails to
> bring up the GM20B. Either BOOT_0 reads back garbage ("unknown chipset
> (5ffefa47)"), or PRI reads of the GPC PLL time out ("MMIO read of
> 00000000 FAULT at 137000 [ TIMEOUT ]"), or the first register reads in
> nvkm_device_ctor() stall until an asynchronous SError. How often depends
> on the board; one board fails on every boot.
>=20
> nouveau powers the GPU up with the fuse clock gated: since commit
> 24a15252ff04 ("soc/tegra: fuse: Add runtime PM support"), the Tegra fuse
> driver only enables that clock around its own fuse reads. NVIDIA's
> downstream nvgpu driver enables the fuse clock along with the other GPU
> clocks whenever the GPU is powered. Do the same: take an optional "fuse"
> clock and keep it enabled from before the GPU rail is turned on until
> after it is turned off. The clock is optional so that device trees that
> lack it keep working as before.
>=20
> Tested on eight Jetson TX1 devkits, on mainline and on v6.18. Without
> this patch, the GPU failed to come up in 27 of 109 boots; with it, in 11
> of 291, none of them with a garbage BOOT_0. On the board that failed on
> every boot, 38 of 40 boots now succeed. The remaining failures are
> mostly a register read that stalls until an SError; wherever the console
> shows when, nouveau had already finished probing. Such stalls also occur
> without this patch and are a separate problem. The Jetson Nano, which
> shares the Tegra210 GPU node, still works (24 of 24 boots).
>=20
> Fixes: d1b725476104 ("arm64: tegra: p2180: Explicitly enable GPU")
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  .../gpu/drm/nouveau/include/nvkm/core/tegra.h |  1 +
>  .../drm/nouveau/nvkm/engine/device/tegra.c    | 22 ++++++++++++++-----
>  2 files changed, 17 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/include/nvkm/core/tegra.h b/drivers/=
gpu/drm/nouveau/include/nvkm/core/tegra.h
> index 6aaa30ef167f6..0189043382d02 100644
> --- a/drivers/gpu/drm/nouveau/include/nvkm/core/tegra.h
> +++ b/drivers/gpu/drm/nouveau/include/nvkm/core/tegra.h
> @@ -15,6 +15,7 @@ struct nvkm_device_tegra {
>  	struct clk *clk;
>  	struct clk *clk_ref;
>  	struct clk *clk_pwr;
> +	struct clk *clk_fuse;
> =20
>  	struct regulator *vdd;
> =20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c b/drivers=
/gpu/drm/nouveau/nvkm/engine/device/tegra.c
> index 3c8d0878891ad..74b292659ee9a 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
> @@ -32,6 +32,10 @@ nvkm_device_tegra_power_up(struct nvkm_device_tegra *t=
dev)
>  {
>  	int ret;
> =20
> +	ret =3D clk_prepare_enable(tdev->clk_fuse);
> +	if (ret)
> +		return ret;
> +
>  	if (tdev->vdd) {
>  		ret =3D regulator_enable(tdev->vdd);
>  		if (ret)
> @@ -76,26 +80,26 @@ nvkm_device_tegra_power_up(struct nvkm_device_tegra *=
tdev)
>  	if (tdev->vdd)
>  		regulator_disable(tdev->vdd);
>  err_power:
> +	clk_disable_unprepare(tdev->clk_fuse);
>  	return ret;
>  }
> =20
>  static int
>  nvkm_device_tegra_power_down(struct nvkm_device_tegra *tdev)
>  {
> -	int ret;
> +	int ret =3D 0;
> =20
>  	clk_disable_unprepare(tdev->clk_pwr);
>  	clk_disable_unprepare(tdev->clk_ref);
>  	clk_disable_unprepare(tdev->clk);
>  	udelay(10);
> =20
> -	if (tdev->vdd) {
> +	if (tdev->vdd)
>  		ret =3D regulator_disable(tdev->vdd);
> -		if (ret)
> -			return ret;
> -	}
> =20
> -	return 0;
> +	clk_disable_unprepare(tdev->clk_fuse);
> +
> +	return ret;
>  }
> =20
>  static void
> @@ -308,6 +312,12 @@ nvkm_device_tegra_new(const struct nvkm_device_tegra=
_func *func,
>  		goto free;
>  	}
> =20
> +	tdev->clk_fuse =3D devm_clk_get_optional(&pdev->dev, "fuse");
> +	if (IS_ERR(tdev->clk_fuse)) {
> +		ret =3D PTR_ERR(tdev->clk_fuse);
> +		goto free;
> +	}
> +
>  	tdev->pmc =3D devm_tegra_pmc_get(&pdev->dev);
>  	if (IS_ERR(tdev->pmc)) {
>  		ret =3D PTR_ERR(tdev->pmc);
> --=20
> 2.53.0
>=20
>=20

This enables the fuse clock first thing during power up, even before the=20
regulator. Have you observed this to be necessary? I'm inclined to think=20
that it doesn't need to be on before the regulator, and the code would=20
look cleaner that way.

During power down, we certainly should be able to disable it before=20
regulator disable with the other clocks. I've found some data saying the=20
fuse clock only needs to be enabled briefly during power up.

FWIW, I've tested this on Tegra194 and it helps even there.

Thanks
Mikko



