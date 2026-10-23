Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDA9606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 05:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cfAD4mi9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF3A0112974;
	Fri, 23 Oct 2026 05:12:38 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012010.outbound.protection.outlook.com
 [40.93.195.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B48D5112974
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 05:12:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmn2cjbP0iTq4FsAVDwozaKmmdSOMCM+aUu4zHrp2Vy7Rh14pIDYUNx2HfpZIhxDOtcbN6kPyw5s/u8LcE+2YlCdBDGvMZRwaDIAV15WnXWOfWNslmBZQoaciUTvGeT1KSUeKyKpeiSBB72jl4zZWEfRRO/HUxVV4H2Vtqqw0MJrQG2vetbrY9tz/maMiArjiN6BGo+dWrBdxWDRdmbLXK/XxkVohxzxkWe7H7lIucb1T5BxU2TjE4ujCrDgBKVyj9VN1VZ2D1Q0hvgrOpledcsZBBbTJA0F3NcXO7gSERmHTrhoCoG1rvAFGn5TEksAFM+6bovZtVFSoan3SszIDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URhNGCg0zC/uJhj6FBkBTsiXFzacY9MXoToqWVrzfw8=;
 b=FsWcpRWRi9hJ9wh7hEUezlSLcBKDs2zzNTmaAj8G+4n8lhwkGntGHO+DcGw3ZrKG1u3dcp+4O29mUCPnwpLXZAiepM35u1rUEwz7kZXsK91efnfZUBdUQe5UQZe0rl8OkyHXfeueE7l6B37/Vd/QR9Rqj2cLv7jA2JBSZpLbtHiNwQ83UxDI2kH4C+BYxTMU0ik4rcEMKajjwYv01nnltzvdrtDm4h2jKssOzlORQzcWtr6G6cMAHuZEmsPpc3F4qgu1xqnD1q1B6J98pBTPgBh91EuDPHLPkRXVI6Hb17GUh9lYXyS+Ha1/CKR95dcPo8vFt+o1PyIQEDna6FNLLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URhNGCg0zC/uJhj6FBkBTsiXFzacY9MXoToqWVrzfw8=;
 b=cfAD4mi9Wm1Oqzph4Ii4dKtzgZXEyadi2D4d7P0m9MBCl8W03i/BVxmujY9ULG+GoSKwMFR7FnRwVXVOqD1krMjsJ1NuBlX38KTIrRcq/75TqQXAcbTy4FJ79tZy+f1znF1hu+kyMQl9pfkJI61IX2zJFi5N20e/5gEilzxNL79Qsn6qnmj+yPVHabPSKWqI4UTzviPevJdpZ+0Ewqzqn3kqd7KK+QYE0fb8Ou2FgHSlB/kc3wj4oFAys0mZ+6+R5qdTSYffHPGTJmZecJx8mUFfYANOS3QA7VNl4FsTRXJjEBnlnsZeGWAjOuQR99c/Zj9SnZcJQvFbsGvSRwpmfg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 05:12:25 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 05:12:25 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Heiko Stuebner <heiko@sntech.de>,
 Thierry Reding <thierry.reding@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Krishna Reddy <vdumpa@nvidia.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-tegra@vger.kernel.org
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 04/11] ARM: dma-mapping: Implement and expose DMA setup
 functions
Date: Fri, 23 Oct 2026 14:12:17 +0900
Message-ID: <EBsd2UhYS9u2iI-UFj7t_g@nvidia.com>
In-Reply-To: <6406c7b1-5e37-4c22-83c2-089c35ef54bf@arm.com>
References: <20261016-b4-arm32-iommu-dma-cookie-v2-0-b06842a01938@nvidia.com>
 <20261016-b4-arm32-iommu-dma-cookie-v2-4-b06842a01938@nvidia.com>
 <6406c7b1-5e37-4c22-83c2-089c35ef54bf@arm.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCPR01CA0163.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::8) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: da283f0b-6153-4d59-2831-08df30c439d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|10070799003|1800799024|366016|18002099003|6133799003|22082099003|10067099003|921020|11063799006|56012099006|4143699003|261009223027099003|261021135927099003|261022105027099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: CTgWzNOOPCla+iQLaiK99AVg9vSGtuktWv6/koFrPWKUAj0ZxfF+6hAK1Sz6qd5ww0MoVUjGn0KvOLPu6bbviVXUP9DVDhweUBJta/HBZ3MmWN0G+DPNH3/YI0JJTcMmLUfpaWA6Uo+086lTFpvxHtm7llHlmU6gTMs5gD/JE8P32trDfe9AIBrsUth0J+qDGICsOz8O2njXYnix8E/LhiglKUCS+uFPuqqqvfxfm3iM5iGm0sDhM64sdvIzJ0mHBnVzEUF462cSpyCnq35cDoLzwiJWDWIzA4Tswnb6Uhu84MBBvXeGnYeTCirzsSPPRvfK7pC/stDWGBYfTcM27w7h7LNYpe0ZiT6GVhfrJFfNeLFZWEuk8mKHO839/Qm268P2O0Hov+iVy2AFvlUA/7K4zwbrbik2e4nAN7sQSitgeQG1DL9yh8P4gHUxM1QIb+djgg1s9QNYXPkA6BtV6lSkLBaPd7xAIbS4mekkeMSbK+yVPiRfhKSTmCqLtztRKVzKzlJrI2Z7K6X3SfcDsojV4aEKhDKC1/S1ZFYx1Dxwf4HEZrE8dK+SHmdpAp8aQPu/U2N1tpuLZFqtv7KOusoJ88LGKruc3vVSJZSKCMBRTpzeU3Reu23nch6IlEHgaftwcY66SyRDPLNObxINnq0RNRgFgFA70BSzJSvvbQ6QDFfVLvBEwAAlXCeTzXMgJ/TXkVFiP5qkbn+SwB+mMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(1800799024)(366016)(18002099003)(6133799003)(22082099003)(10067099003)(921020)(11063799006)(56012099006)(4143699003)(261009223027099003)(261021135927099003)(261022105027099003)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWZjTjY0d1l1ZzFCYnZEcVpJVk1yRlFvS3l3WUl2bXNxRTJ6Q1lyZkgvSCty?=
 =?utf-8?B?TGhHWVg4MXg0Y1FaVjU1ZDdYamo5MnNJSTBIZEhWNXRZUGNEV0dBYTlxRU1I?=
 =?utf-8?B?M09obVFLT2poc2FZOFhUT1hWSzYzdHNKeDYzTVE1c0ZqTjRldkJZZWNGSkQw?=
 =?utf-8?B?SmtuUXdRWHlzeVRsTFpDRzRWSWJycVY1dGtXb01sVU9Xb3RkS0dFdHBxc0Jj?=
 =?utf-8?B?QTNYR1VsYmR0cHhXaXNVZXJGcFZpd1NYeDFIS1pHeGdEUTFFUVlHWTE1eThV?=
 =?utf-8?B?QnNsalJJNHR1Y0l4NTFMR2szbnNzQVdVVS9yaUNlb0xaeDBja2EweTZTaDAz?=
 =?utf-8?B?VllERU9wODRVeEdrK3UraWVqUkRwL2xVTHFVbjBKMC9KSWMvWU90Wk9aVXE0?=
 =?utf-8?B?bEVQMnN0TVRHNmZiWXdQL20yVWtmalBoVldwRlFEN01JRlV4OUlMVzZNT3J0?=
 =?utf-8?B?SlRJYjgrWDBMK2pnbU9QU211RE1udlZvOXRjNE1aeU9tcG4wR1ZXbXdVdk1z?=
 =?utf-8?B?cGtCR1JWS3JsaE1Sd29KWngyTDdDSDAxNEFBdm1FMXVXV01YbHQxb0Y0bUdh?=
 =?utf-8?B?QWxvVmxPSzR2VHZpRlRRQkdyUFBBZlU3cmFxOXZTUXhNWkw3dzR1c0k5aFpy?=
 =?utf-8?B?L29PN2ltTGpjL3JDOVp3b1lERjljU1lBUzR2MnExdm14SkZyNVdQZVB0Z25K?=
 =?utf-8?B?WkFTRWpKTW1DbDhhOGdYVXJkQ2V1aGpnaG54TFR0YXBScDk2MytrSzM1ejBQ?=
 =?utf-8?B?eW1Fa1N1WHgvVFd4MU1uRUx0cVAzeVFGY0hpNnVWMnIxb2V2RmlRYWUxcXUr?=
 =?utf-8?B?VnF6b29RdkJpY2lQeHJVdmRjZHdJcGN5MzQ1OFQ5V29TRlAzZ2hFUGw5UWNk?=
 =?utf-8?B?Z01iRTliOUlzcFFnSkladUpQcE1lM1dYcVgyM2ZLUmI3L01YUDNXc3JsOGNw?=
 =?utf-8?B?cGhTNUFERFBxWEIvNlUwNDJJcm1aK2grR3ZwUFpNY3o2TlpWWFp2dUN6SnIr?=
 =?utf-8?B?aXRGVUtPS0JIbGRVbXZpVTRNYXl0RmxCYkMxRktuVlVEbVlvNUF3Rno3a0h2?=
 =?utf-8?B?Nm1sZDNNK1l5amFTRXdDU0JoVWxSa2NVK2RnUlZuYzdyNzU3OHN6Tm5ESG1o?=
 =?utf-8?B?SEJGT25sNnV6STFlRU5weTI2VWM0SW9KQTM1dzJtRC85L3dXbWlQZnQ2R3RV?=
 =?utf-8?B?ZngrNVF5VmJkTUp1TldxV0lwZytpNVVXOEFKSGw3Q2JWZVZRNElQYjJUZnV5?=
 =?utf-8?B?Wi9xNDVCd2hMaHBtRmxSQmI4bWd6c2Y3MnIyejB6RXdCdGpicEpwOC8yQWNr?=
 =?utf-8?B?Q0hlSW1HK2RYYmZJb3FOWDRaTEJSMzBKTjdOS2hxbHY5aW95RkRvNmdmaFU0?=
 =?utf-8?B?MUQvK0JSWWx5R3NlUVdPbzMwSC9CQnpsZzA1V05wTnNEd1NHS2xGZW1EQmh0?=
 =?utf-8?B?ZVRDTndBRGdHY2lJZGdrSlNGK3ZBNnZkTlRWWDQxd2lRenBCNHpweVpkeWt4?=
 =?utf-8?B?V3hmSVlhK0dJeW80RjdlVzdwNzd2bXEzTTJieEY5Rk5GeXV1cVlLR1Q2RTNh?=
 =?utf-8?B?cTZNV25ZZTZ3c0lGOE5xK0VXZUgzWVc0YkJ3RGpZN2tqV0VjTmQ2TGx0bXhj?=
 =?utf-8?B?K3VmV1BqS3VycmhaS3VUdDVQemZtRHZBTlN0TFFuNnhnejZVUkNNTnJVd3V6?=
 =?utf-8?B?aVlaWjdJUkZSdXFvUzg0V08vVDNYSnRkZmFRLytydXYxdFJaUVhCL05YUE9q?=
 =?utf-8?B?QTdBeXRpTXp2WDJYdUdqT054Z3QxVXYveFplbXJXcGVYSWtva0ZSUi9yK29N?=
 =?utf-8?B?N21DU0hoM1VHK1VkVndTWjRmSFEzMlZBODE4STlEMlk0YXM2MHhKajlXMXFT?=
 =?utf-8?B?THJ3aWZmN2JNOEVvVEE5SWE4TlBmMXpjSmlza2hGU3o5bktXZnU1YXQrNUh4?=
 =?utf-8?B?aEhiT3pNUGZKVUdrbWxtOE5Rd1B4NHN6SW1CT0oxSWN2UG1PbUgvREZqK1Ft?=
 =?utf-8?B?QWVnSC9obVJ3cjBjSENhWmRsaStQNmYxbTVHWU9zd0RhL3FhUlorMmRTcXkr?=
 =?utf-8?B?UUlPeG9vaFJHejZXeEpWRHZOSEZlZEVOdU9Tb1ZCWHpOWVUyUlJMSkEybDk5?=
 =?utf-8?B?cXRMbS8vdXdwb0IweUVjWEh2ZGdTMkw1emtYL1JNTGxVMTZIZ0FhZ3R4cmha?=
 =?utf-8?B?TFBMeW5ubGV0bDRiRnRoQTRWZUVLSXNEejRyK1dsY0QyRW9ybWdmT3h1N2Vt?=
 =?utf-8?B?MHM3cVNoRkhXWklIOFZLNVlnd1JxVGdSSU9HbEtVeG5qQUQ4aHZWckU2NklW?=
 =?utf-8?B?RlZMcU92Vyt2UHM3Y0J3VUZUbVZFNjMwbFRJRHVwZEtWZkplL0VGNktjNS9a?=
 =?utf-8?Q?uqGAlOWbBUJHtsfG/SfnvXvVpLOWIBkLM1FO5h/9Hssau?=
X-MS-Exchange-AntiSpam-MessageData-1: qMS6hVCKGj7sVg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da283f0b-6153-4d59-2831-08df30c439d5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 05:12:25.3117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59AHLx06/KjK6BDCMey88ARWKo+GIwDxzOejrFUKFI/MMVPfSQwsx4vtO4m3WnY14hG8mizM+5Mnf//mreTVRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thursday, October 22, 2026 10:16=E2=80=AFPM Robin Murphy wrote:
> On 16/10/2026 7:46 am, Mikko Perttunen wrote:
> > ARM DMA domains are currently allocated by the ARM DMA code, with struc=
t
> > dma_iommu_mapping owning the domain and the IOVA bookkeeping. To allow
> > the IOMMU core to own DMA domains as is the case with other
> > architectures, we have to allow that code to allocate the domain and ge=
t
> > the cookie from the ARM DMA code.
> >=20
> > Implement ARM versions of iommu_get/put_dma_cookie that create a struct
> > dma_iommu_mapping that doesn't have its own domain, as well as
> > iommu_setup/teardown_dma_ops that set the device's archdata.mapping,
> > allowing ARM DMA ops to seamlessly work on these devices.
> >=20
> > The code is protected by CONFIG_ARM_DMA_USE_IOMMU and mutually exclusiv=
e
> > with the same-named functions in the dma-iommu code; and not reachable
> > yet.
> >=20
> > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > ---
> >   arch/arm/include/asm/dma-iommu.h |  17 ++++++
> >   arch/arm/mm/dma-mapping.c        | 118 ++++++++++++++++++++++++++++++=
++++-----
> >   drivers/iommu/dma-iommu.h        |  50 +++++++++++------
> >   3 files changed, 154 insertions(+), 31 deletions(-)
> >=20
> > diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dm=
a-iommu.h
> > index 2ce4c5683e6d..85cf9b05faab 100644
> > --- a/arch/arm/include/asm/dma-iommu.h
> > +++ b/arch/arm/include/asm/dma-iommu.h
> > @@ -19,6 +19,14 @@ struct dma_iommu_mapping {
> >   	size_t			bits;		/* per bitmap */
> >   	dma_addr_t		base;
> >  =20
> > +	/*
> > +	 * Set for mappings created by arm_iommu_create_mapping(), where
> > +	 * @domain is owned by the mapping.
> > +	 * Clear for mappings that are a cookie of a domain owned by the IOMM=
U
> > +	 * core.
> > +	 */
> > +	bool			owns_domain;
>=20
> Do we strictly need this, or could we in fact already tell the=20
> difference via iommu_is_dma_domain()? (Since ARM-API-owned domains via=20
> iommu_paging_domain_alloc() will be IOMMU_DOMAIN_UNMANAGED)

We don't, I've removed it.

>=20
> > +
> >   	spinlock_t		lock;
> >   	struct kref		kref;
> >   };
> > @@ -32,5 +40,14 @@ int arm_iommu_attach_device(struct device *dev,
> >   					struct dma_iommu_mapping *mapping);
> >   void arm_iommu_detach_device(struct device *dev);
> >  =20
> > +#ifdef CONFIG_ARM_DMA_USE_IOMMU
> > +struct iommu_domain;
> > +
> > +void iommu_setup_dma_ops(struct device *dev, struct iommu_domain *doma=
in);
> > +void iommu_teardown_dma_ops(struct device *dev);
> > +int iommu_get_dma_cookie(struct iommu_domain *domain);
> > +void iommu_put_dma_cookie(struct iommu_domain *domain);
> > +#endif
> > +
> >   #endif /* __KERNEL__ */
> >   #endif
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index 4284950a9246..f2d3e8ec3487 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -1531,6 +1531,79 @@ static void __arm_iommu_free_mapping(struct dma_=
iommu_mapping *mapping)
> >   	kfree(mapping);
> >   }
> >  =20
> > +static int __arm_iommu_init_cookie(struct iommu_domain *domain,
> > +				   dma_addr_t base, u64 size)
> > +{
> > +	struct dma_iommu_mapping *mapping;
> > +
> > +	if (domain->cookie_type !=3D IOMMU_COOKIE_NONE)
> > +		return -EEXIST;
> > +
> > +	mapping =3D __arm_iommu_alloc_mapping(base, size);
> > +	if (IS_ERR(mapping))
> > +		return PTR_ERR(mapping);
> > +
> > +	mapping->domain =3D domain;
> > +	domain->cookie_type =3D IOMMU_COOKIE_ARM_DMA;
> > +	domain->arm_cookie =3D mapping;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * iommu_get_dma_cookie - Set up a domain cookie for ARM IOMMU-based D=
MA API
> > + * @domain: IOMMU_DOMAIN_DMA domain being configured
> > + *
> > + * Allocates IOVA bookkeeping for the domain based on the domain's spe=
cified
> > + * geometry. The aperture can currently be at most 4GB in size, otherw=
ise
> > + * fails with -ERANGE.
>=20
> Bit of a corner case, but I think that might technically break on=20
> stage-2-only arm-smmu implementations like MMU-400 where the default=20
> aperture will be 40 bits. It's probably better to explicitly cap our=20
> request to 4GB here to preserve the current behaviour.

Yes, fixed.

>=20
> > + */
> > +int iommu_get_dma_cookie(struct iommu_domain *domain)
> > +{
> > +	dma_addr_t base =3D domain->geometry.aperture_start;
> > +	u64 size;
> > +
> > +	if (base > domain->geometry.aperture_end)
> > +		return -EINVAL;
> > +
> > +	size =3D (u64)domain->geometry.aperture_end - base + 1;
> > +
> > +	return __arm_iommu_init_cookie(domain, base, size);
> > +}
> > +
> > +/**
> > + * iommu_put_dma_cookie - Free domain cookie for ARM IOMMU-based DMA A=
PI
> > + * @domain: the domain being freed
> > + */
> > +void iommu_put_dma_cookie(struct iommu_domain *domain)
> > +{
> > +	__arm_iommu_free_mapping(domain->arm_cookie);
> > +}
> > +
> > +/**
> > + * iommu_setup_dma_ops - Record a device's DMA API domain cookie
> > + * @dev: the device
> > + * @domain: the group's new default domain
> > + *
> > + * Records the cookie of @domain on @dev, or clears it if @domain is n=
ot a DMA
> > + * API domain. The DMA ops themselves are per driver binding and are i=
nstalled
> > + * by arch_setup_dma_ops().
> > + */
> > +void iommu_setup_dma_ops(struct device *dev, struct iommu_domain *doma=
in)
> > +{
> > +	to_dma_iommu_mapping(dev) =3D iommu_is_dma_domain(domain) ?
> > +				    domain->arm_cookie : NULL;
>=20
> It feels like we should actually set the dma_ops here for a real default=
=20
> domain. Sure it might make things a little more complex in the interim,=20
> but it'll be more logical when we come to remove the other path.

I've done a bunch of re-arranging: iommu_get_dma_cookie still allocates=20
the mapping, but the bitmaps are only initialized here in=20
iommu_setup_dma_ops because the domain geometry may not be available=20
earlier. And I moved set_dma_ops here as well. Those of course only=20
apply to the default domain case. I've also added upper bound limiting=20
to alloc_iova to not have the range checks in arm_setup_iommu_dma_ops,=20
and because the range information may not be available in=20
iommu_setup_dma_ops.

>=20
> > +}
> > +
> > +/**
> > + * iommu_teardown_dma_ops - Clear a device's DMA API domain cookie
> > + * @dev: the device
> > + */
> > +void iommu_teardown_dma_ops(struct device *dev)
> > +{
> > +	to_dma_iommu_mapping(dev) =3D NULL;
> > +}
> > +
> >   /**
> >    * arm_iommu_create_mapping
> >    * @dev: pointer to the client device (for IOMMU calls)
> > @@ -1541,28 +1614,32 @@ static void __arm_iommu_free_mapping(struct dma=
_iommu_mapping *mapping)
> >    * IO address ranges, which is required to perform memory allocation =
and
> >    * mapping with IOMMU aware functions.
> >    *
> > + * Unlike a default domain set up by the IOMMU core, the returned mapp=
ing owns
> > + * the domain it describes and releases it along with the last referen=
ce.
> > + *
> >    * The client device need to be attached to the mapping with
> >    * arm_iommu_attach_device function.
> >    */
> >   struct dma_iommu_mapping *
> >   arm_iommu_create_mapping(struct device *dev, dma_addr_t base, u64 siz=
e)
> >   {
> > -	struct dma_iommu_mapping *mapping;
> > -
> > -	mapping =3D __arm_iommu_alloc_mapping(base, size);
> > -	if (IS_ERR(mapping))
> > -		return mapping;
> > +	struct iommu_domain *domain;
> > +	int err;
> >  =20
> > -	mapping->domain =3D iommu_paging_domain_alloc(dev);
> > -	if (IS_ERR(mapping->domain)) {
> > -		int err =3D PTR_ERR(mapping->domain);
> > +	domain =3D iommu_paging_domain_alloc(dev);
> > +	if (IS_ERR(domain))
> > +		return ERR_CAST(domain);
> >  =20
> > -		__arm_iommu_free_mapping(mapping);
> > +	err =3D __arm_iommu_init_cookie(domain, base, size);
> > +	if (err) {
> > +		iommu_domain_free(domain);
> >   		return ERR_PTR(err);
> >   	}
> >  =20
> > -	kref_init(&mapping->kref);
> > -	return mapping;
> > +	domain->arm_cookie->owns_domain =3D true;
> > +	kref_init(&domain->arm_cookie->kref);
> > +
> > +	return domain->arm_cookie;
> >   }
> >   EXPORT_SYMBOL_GPL(arm_iommu_create_mapping);
> >  =20
> > @@ -1571,8 +1648,8 @@ static void release_iommu_mapping(struct kref *kr=
ef)
> >   	struct dma_iommu_mapping *mapping =3D
> >   		container_of(kref, struct dma_iommu_mapping, kref);
> >  =20
> > +	/* Frees mapping too, via iommu_put_dma_cookie(). */
> >   	iommu_domain_free(mapping->domain);
> > -	__arm_iommu_free_mapping(mapping);
> >   }
> >  =20
> >   static int extend_iommu_mapping(struct dma_iommu_mapping *mapping)
> > @@ -1595,8 +1672,13 @@ static int extend_iommu_mapping(struct dma_iommu=
_mapping *mapping)
> >  =20
> >   void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping)
> >   {
> > -	if (mapping)
> > -		kref_put(&mapping->kref, release_iommu_mapping);
> > +	if (!mapping)
> > +		return;
> > +
> > +	if (WARN_ON(!mapping->owns_domain))
> > +		return;
> > +
> > +	kref_put(&mapping->kref, release_iommu_mapping);
> >   }
> >   EXPORT_SYMBOL_GPL(arm_iommu_release_mapping);
> >  =20
> > @@ -1660,6 +1742,14 @@ void arm_iommu_detach_device(struct device *dev)
> >   		return;
> >   	}
> >  =20
> > +	/*
> > +	 * This pairs with arm_iommu_attach_device() on a driver-owned mappin=
g.
> > +	 * A mapping which is merely the cookie of a core-owned default domai=
n
> > +	 * must not be torn down from here.
> > +	 */
> > +	if (WARN_ON(!mapping->owns_domain))
>=20
> As mentioned, if we can't reasonably hide the proper default domains=20
> from external users of to_dma_iommu_mapping(), then I don't think we=20
> should warn here, just treat it as a quiet no-op - the reason for the=20
> "kick out the ARM domain" idiom is that it's in the way of attaching to=20
> a driver-owned domain (whether that be a bare iommu_domain or another=20
> ARM dma_iommu_mapping), but a real default domain is inherently out of=20
> the way already. That way we can freely convert the rest of the drivers=20
> to use default domains without impacting their users, then clean up the=20
> detach pattern from the client drivers separately afterwards.

Yep, true. This ends up cleaning up the series nicely as well.

Thank you!
Mikko

>=20
> Thanks,
> Robin.
>=20
> > +		return;
> > +
> >   	iommu_detach_device(mapping->domain, dev);
> >   	kref_put(&mapping->kref, release_iommu_mapping);
> >   	to_dma_iommu_mapping(dev) =3D NULL;
> > diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
> > index 349d6a57e5a0..71b23cb698c0 100644
> > --- a/drivers/iommu/dma-iommu.h
> > +++ b/drivers/iommu/dma-iommu.h
> > @@ -7,25 +7,24 @@
> >  =20
> >   #include <linux/iommu.h>
> >  =20
> > -#ifdef CONFIG_IOMMU_DMA
> > +/*
> > + * Both dma-iommu.c and arch/arm/mm/dma-mapping.c implement functions =
to set up
> > + * IOMMU_DOMAIN_DMA default domains. Only one provider can be compiled=
 in at a
> > + * time.
> > + */
> > +#if defined(CONFIG_ARM_DMA_USE_IOMMU)
> > +
> > +#include <asm/dma-iommu.h>
> > +
> > +#elif defined(CONFIG_IOMMU_DMA)
> >  =20
> >   void iommu_setup_dma_ops(struct device *dev, struct iommu_domain *dom=
ain);
> >   void iommu_teardown_dma_ops(struct device *dev);
> >  =20
> >   int iommu_get_dma_cookie(struct iommu_domain *domain);
> >   void iommu_put_dma_cookie(struct iommu_domain *domain);
> > -void iommu_put_msi_cookie(struct iommu_domain *domain);
> >  =20
> > -int iommu_dma_init_fq(struct iommu_domain *domain);
> > -
> > -void iommu_dma_get_resv_regions(struct device *dev, struct list_head *=
list);
> > -
> > -int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *des=
c,
> > -		     phys_addr_t msi_addr);
> > -
> > -extern bool iommu_dma_forcedac;
> > -
> > -#else /* CONFIG_IOMMU_DMA */
> > +#else
> >  =20
> >   static inline void iommu_setup_dma_ops(struct device *dev,
> >   				       struct iommu_domain *domain)
> > @@ -36,11 +35,6 @@ static inline void iommu_teardown_dma_ops(struct dev=
ice *dev)
> >   {
> >   }
> >  =20
> > -static inline int iommu_dma_init_fq(struct iommu_domain *domain)
> > -{
> > -	return -EINVAL;
> > -}
> > -
> >   static inline int iommu_get_dma_cookie(struct iommu_domain *domain)
> >   {
> >   	return -ENODEV;
> > @@ -50,6 +44,28 @@ static inline void iommu_put_dma_cookie(struct iommu=
_domain *domain)
> >   {
> >   }
> >  =20
> > +#endif
> > +
> > +#ifdef CONFIG_IOMMU_DMA
> > +
> > +void iommu_put_msi_cookie(struct iommu_domain *domain);
> > +
> > +int iommu_dma_init_fq(struct iommu_domain *domain);
> > +
> > +void iommu_dma_get_resv_regions(struct device *dev, struct list_head *=
list);
> > +
> > +int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *des=
c,
> > +		     phys_addr_t msi_addr);
> > +
> > +extern bool iommu_dma_forcedac;
> > +
> > +#else /* CONFIG_IOMMU_DMA */
> > +
> > +static inline int iommu_dma_init_fq(struct iommu_domain *domain)
> > +{
> > +	return -EINVAL;
> > +}
> > +
> >   static inline void iommu_put_msi_cookie(struct iommu_domain *domain)
> >   {
> >   }
> >=20
>=20
>=20




