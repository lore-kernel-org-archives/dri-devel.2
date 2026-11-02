Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9EC606A32C
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sW6+VnRr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 757E010E56C;
	Mon,  2 Nov 2026 08:33:30 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012035.outbound.protection.outlook.com [52.101.53.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A63B10E56C
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 08:33:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfvbuqiVWE98DLNL2ZcXuyD2QoaJaKUb68NqIvMZKdf8/xRjXYwRa5I4/2UrLrxSo9zL78bv5XIfDV4JQyVf30eG7PmvqGDrTrzlR/IaaoklU8ug2bG86Aucl9zVeKLHVsOr0o2UAIAxcNPCr3rPmr0vNSfOLi5SEeD54hHLIHO4IAHB1WfSzk1O3spRFLvm6xzjD2WKhxFJtscZcwUYl6/JuWZnFRTu5afHd9Y1qxf/KPUJWt58RYYL8ZTSF6eu+KyXcGfmInWa6lpzCfUYqlAjeqtkwu4PLFSbqcn0M3oguAEh8iLN3BI6jr2Gzx4A06mrumzLNrj0lmCkBPjrBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InFiA7roXHIiO2p6dcL0lbU+DMk3dk2Xr/NWKR/N3TA=;
 b=RQvK4arFXtpnaHAKzqpSnOgzPhdJRTIpoIZdxdZbIuO/3NG80jy397B2iRiWK/G55mpKkdLJwQKtYX0J5QpPuA225fld5qaP9rofFo3fFJ5rQLITHn3/WNnNpDSt01n6mGbVXJhi8XfBaTSdNCdJiL1cr93whkfK5kCQQLXJYweyUHtwJwckx00ZgXS28lkKm995T2QL/CGziGEVKZrYTfOXexrUHPhy8ZobnapqNOP5OKPqzOj/2RhFZc5Soaw3yzfqszXL7FzP/FEN93LqbPhyDeJsikGT9Ge8L5hxvcJAcTF0bVic6lepwiNFinaxDSvPGG45u6wAHApPdNacMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InFiA7roXHIiO2p6dcL0lbU+DMk3dk2Xr/NWKR/N3TA=;
 b=sW6+VnRrzNFcdXqEXHW9yelHETiEN9uublQG1p5bgDngQ8yF8C6dVuCOF6YkHTj2rfgEmPgljJJYDqqVZzEuRPpMvVLv4oNS56Nkj1t7SeOuUz6B7aYrj2h3gGb+BRpl1oa0xNRm6kqv2IrFl1eVQ0i14Dzqc/Eh3KaiAeNaMXSfRPKqdn++V7R+Jbwhs0WrJMyG8Z1wmFWLCjk92flMhAXmtcUJnAEIjA1c5/AvKAtPR6UmJjRfL7TAcn2mBw8PXwQfknYWPu2Q3rYyRO2nuQFRJujm58O0jm8icfdIIX6vHnH9Km8fOSDz3Xkpw/mLMUdreytTTFbviCPi6nnA9w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH7PR12MB7428.namprd12.prod.outlook.com (2603:10b6:510:203::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 08:33:13 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 08:33:12 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>,
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
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3 00/10] Make the 32-bit ARM DMA API work with normal
 IOMMU DMA default domains (+ Tegra PoC)
Date: Mon, 02 Nov 2026 17:33:09 +0900
Message-ID: <8hhoVlFLRDu49GHajB8t6A@nvidia.com>
In-Reply-To: <6fb3327c-766c-433c-b49d-dc62470d7102@samsung.com>
References: <CGME20261026092047eucas1p2686ac1a0ce893a16711cf7a137d081ce@eucas1p2.samsung.com>
 <20261026-b4-arm32-iommu-dma-cookie-v3-0-3901d74b1ff2@nvidia.com>
 <6fb3327c-766c-433c-b49d-dc62470d7102@samsung.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: OSTP286CA0047.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:217::18) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH7PR12MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 72583000-3b8b-4595-b5d6-08df38bbeea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|10070799003|6133799003|22082099003|18002099003|10067099003|56012099006|261009223027099003|921020|261022113327099003|261022105027099003|261022115727099003|261021130227099003|261021135927099003|261021123027099003|261021121427099003|261022075727099003|11063799006|4143699003|261026130827099003|261028144727099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: Bx91KJbQ/JbhEkMwfy37ouECPGQIyHriDd339TJ2kiBwc3lf/bxXZ1Ceap3A2IT8W+CIjzQhNKC1AyEkPFnoBE3SORkxjSBAq38hmW7DIcJB0uD5u25eLx2MtrCUi19tib8oOr49So7Mx7NMY/FA/ULQ86+9qC197g0b8FdMI/wYHcGfiAlpMfwD+rCUmbEpgaWr2p/zunFnEYwI9Wtt6E+NbGUTyhKUGJ1ekdx6MpN2mmvvoQzkiiYM4KjjTfGVE4ONLkhDbrXEtPLr+lAE6odhXl21lciK59CcXPbzNwGBZnkCzsudthIUYlCwb2AOUvANl4fyeg//INq7Uvjxjy94C6TRsKdFRw2+pFxiJd/FuAJPEDyxL4FnOeqk8VRS7HaXqO+T0CPvdmct/SwT9NH5NM9PcJxo5LoBzl0xQkKcmh23kBs8ycVUXMuJkcdfHRKAMX7WV1RxcazBllfHKuYMii4QPpFA8tDnAI+86HyrH0m3fZDRQAlRsD5q7fq4U/ZZVlwB4VY8cfFV2JY2ZIRYxaPU+IrqMwJ1QFH4TDUFGCU24QuxqyiISQAIXxTMZ+Fl7GiRwr4V23tnqPXrr2E4d+paS778C/jbZ4t+I02P168QP6jA/jz0/BUsKJ+BXdiRyJWR2SZssUuNeYEjIYgQ3FvDW/NhPySJceuBNR8x9ZZOk334mKp6DGbrIozqLTtIRPCb6CfOn+4SFYtgfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10070799003)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(261009223027099003)(921020)(261022113327099003)(261022105027099003)(261022115727099003)(261021130227099003)(261021135927099003)(261021123027099003)(261021121427099003)(261022075727099003)(11063799006)(4143699003)(261026130827099003)(261028144727099003)(261026140227099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MktlRnArVkZVUUFleFpycTZLaFJ6VW14TGlOMjU1T1JtbE1LeTdVeVI4RU1G?=
 =?utf-8?B?WTMrdEhsdXFvNVM5MXRsdlh1dCtZa3pVWmlnRWdyenY4eHNCTzQvSXR3VnBR?=
 =?utf-8?B?VWFvSHMzOEZiV1hGM1ZORzQ1NWVNTWlKYjRSWU1hTkFmUG5DaWVoYWZnSUIv?=
 =?utf-8?B?VlNma2N1U3UzOXZIYnY3TzBxUkxkMVVHSHRkcTFzUklXMDZxQ0ppbXRxa2pw?=
 =?utf-8?B?TGZ6OXFZcVU1b2pyaE5Xb1oxTzJyN2tKMnBndFNUdzBRL2w0Z01qU09ZSjBD?=
 =?utf-8?B?eU04YTkvNEFzSDZJczI3RmcyRng4NlNQeTMyMmNxMWc5Q21tR0VML2hDbjJ0?=
 =?utf-8?B?NVl5aGlJa2YzbXE3Z3VBdUtsSTdneFlwWWRaOTExeEdRMmUyRzNXUmtWa1FL?=
 =?utf-8?B?MUJXaUtmNkZ1QVBRNTJIcmx3Y29XcGdWL0N2OXZJQSt1UUlCSHhVUHlmVXZI?=
 =?utf-8?B?YVRLTnBRenVrWUthWENCWVBFR21XVm9mRVJXVmd0TEdHMGJlYzRiZEVnZ3Yr?=
 =?utf-8?B?WXdtMkh6YU41K2wzOEx3Q1NxeVNDVm5OVk96ZzRPaTJPbDNkUTdmOHdaVy9u?=
 =?utf-8?B?Q1E0MlhBelRsR3kzTnl6RHg2SXQwUEdGeUJGbzN6aUkxeWlDMWl2R2FDOXBq?=
 =?utf-8?B?Q081QWlMMkVzWmdpdlk2V2cxWisvOFV5R0JDY0hVT2RyYjJGN1NOdWx1RmRF?=
 =?utf-8?B?amttaDhlK0Y5aXR6VlRJbTYyajJvVzBzc1hQWnNncmlRdDQxMGcyN1BSUEZn?=
 =?utf-8?B?aDFQZlpsSkdjMkFpWU5JVCszNDhYbEtFSjBvQnU3V2dJa3lZOHFCNWRkU0Zx?=
 =?utf-8?B?dk1LckwvVDV4UFdWSkgxSlQyL2tHdUQ3ZndyYjk4NnQxMmk3dDJzWC9QelYv?=
 =?utf-8?B?U0JRS0NhV2pjT29BdkFNdTczRlFMTVc1dU52K0pvNzdPL0IzZ1dxMVVXM0xk?=
 =?utf-8?B?M1lGOU9BaVNRNW5oWGhvVy9Ibk1vbEVkdkdCZWwyWS9KS2YwR0JUUWxKRVNV?=
 =?utf-8?B?b3gxTnl4L20rTHRjak1MclFpeFBRTis2UVQveTlzTk9peVRONkZCQk5INFRK?=
 =?utf-8?B?QXpsOXNBS09ZNSsvYUJDOFVuMW9uNU9iYnZ4eUR1WGlxQ2toSEFSNWNhV2ZL?=
 =?utf-8?B?cWU3SG1MZnNMbVhlYUpLZmRDUXgzRUlxN0pKR2gvamZwUTVEL3FCVzF1SlpH?=
 =?utf-8?B?Mlc1Yk1iNE41S2x3OE1KVWpsd1Z3Q0dBYVM3ZUd6TUtUODAxNHBVMFA0QWJa?=
 =?utf-8?B?SWpLRDRtYkVnVzRkaDU1ZkR5U2dZQUNhYVVzRTRpSDRGRytqaXdMMmpMMm01?=
 =?utf-8?B?bEpCRjF6cy9Ub0pjeiswdGJOWGxoSnI2dDFXVW1qVW9td0RVZ1grN0JxZkY0?=
 =?utf-8?B?dTB5Y2ZMa2VibkJqR1phNE1CMzFPTkhVOFlFVDZLUnkvK1h1TkVBaVZKOFNh?=
 =?utf-8?B?b3R4cFc1VVRjOWtGQUk0MllueDg3Y2hwdExBekMxcW5XM21GL2ZNaFFqaUgw?=
 =?utf-8?B?VC9yQ2MyMXEwdlBKTWxNeU4xTk94dkpmNC9RTWtjdkw2WE5PT05pcUZoNldO?=
 =?utf-8?B?Q1Z6b3FiRTBqNklWVXlFYTJ6ZzNOMU1SVE5ua0xjK3Z0WGt1VlBHem4rQW4r?=
 =?utf-8?B?aXdCTlVXR0dteFhIcW9WQmdoV1hvVkRiWUdRVUtMUURWZmxXR2hTOTNqY3lk?=
 =?utf-8?B?TW5tcTNjWHdIRlBMTk5wU1FCMW9ORkhqeEZoMjBBTGVJclUwTGd4UlNEd0ph?=
 =?utf-8?B?d1d5K1drbXdZVjBPenpBTjhmSHJIK1F2NFZPdmpONitFNFZEeURjbEJxSS9u?=
 =?utf-8?B?QnZNdndLQjRsNXlPWE04V1JNaDAyWGV4QmJVSXlUMEVGWDFtajNrdEI5R2NO?=
 =?utf-8?B?L0JqN3FmbS9nVGNITG1IaEVYdmxzQmNNVjMvaU1RdFRXYkljKzVVcUk0enBI?=
 =?utf-8?B?WEMwT0FONlpZVFB1MVNCdUVTU1l5ajBSWWlKS2VMRG44Qkthdlg5NXFyVElP?=
 =?utf-8?B?UUsvNXBWOFUwellid2ZiN21vNHRRS1V6ZU8zWEY5RVl4Sm9yQnlReFJaRmc3?=
 =?utf-8?B?b0dSTXJsaExXcEc3YVBMc1NQNXF5VVZiSGRicW5mYkhDWGdqWXRKUzBPYWkr?=
 =?utf-8?B?V3Z1MWI1bmVGUWp4Y3ZjRW1YMWU1cWtuSnA2dGl0Z0w0K0dQb08wV2FyVWZt?=
 =?utf-8?B?czFCek4yb1hRcUdBeHBSejZxSnpsZ0NNbTd1aWloT2hrY0s5M0ppYmVtM0ti?=
 =?utf-8?B?T3pLUC80L05nNzBOTUw2dndsMnJDQ1dRaU95Wm1nc0dIc0lYa1MvWWdYMjlV?=
 =?utf-8?B?OUl4cy9wZnlwUis1dDVQeVBtaTNQNVRUNGl4UEpROEVzWUxRVjB5MU1WVmNF?=
 =?utf-8?Q?JENAOm1TSz3l/RSiXEZ1mAafuHkPClPUiXoYqLsoIjdME?=
X-MS-Exchange-AntiSpam-MessageData-1: zP9adxOFezWx/A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72583000-3b8b-4595-b5d6-08df38bbeea9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 08:33:12.6366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XaGBQE1G+B1cJpxT6O9sOSlbOQSgLp0KNewAbuTDk7lWEpWMGHbuQxdkGIBjXXef/VDaPG37njQ88rfi3UfrqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7428
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Friday, October 30, 2026 7:36=E2=80=AFPM Marek Szyprowski wrote:
> On 26.10.2026 10:19, Mikko Perttunen wrote:
> > Depending on the probe ordering, TegraDRM does not currently probe on
> > kernels with CONFIG_ARM_DMA_USE_IOMMU enabled, such as with
> > multi_v7_defconfig. The Tegra SMMU puts several display and 2D/3D
> > clients into one IOMMU group, and the legacy 32-bit ARM DMA API path
> > creates one UNMANAGED domain per device and attaches it with
> > iommu_attach_device(). That only works for one device per group, so
> > every client after the first fails to attach,
> > iommu_device_use_default_domain() rejects the group with -EBUSY, and th=
e
> > driver goes down with it. tegra_defconfig is currently working by virtu=
e
> > of not enabling CONFIG_ARM_DMA_USE_IOMMU.
> >
> > Robin suggested [1] that instead of teaching the legacy path about
> > groups, we should explore modernizing the 32-bit ARM DMA code a bit by
> > making it use domain cookies and have the core code own the domains, as
> > is the case on other architectures. Still, ARM's own DMA code is kept t=
o
> > support existing drivers and APIs that expect it, and because dma-iommu
> > is considered too big and unnecessary for 32-bit ARM.
> >
> > The series is in four parts:
> >
> > - Patches 1-2 are preparation in the IOMMU core:
> >   1. Add iommu_teardown_dma_ops, counterpart to iommu_setup_dma_ops.
> >   2. Add cookie type for ARM's DMA domains.
> > - Patches 3-6 implement the DMA API side on 32-bit ARM:
> >   3. Split up mapping alloc and init (bitmap alloc) code to separate
> >      functions.
> >   4. Implement parallel dma_ops / cookie APIs on ARM side.
> >   5. Avoid domain allocation when IOMMU core does it.
> >   6. Check upper DMA range limit during IOVA allocation.
> > - Patch 7 removes the forced IDENTITY default domain in core IOMMU
> >   code and adds explicit IDENTITY defaults to a few individual IOMMU
> >   drivers.
> > - Patches 8-10 convert Tegra:
> >   8. Fixes device parameter in calls to dma_get_sgtable.
> >   9. Allows deferring translation enable until driver handshake for
> >      selected devices.
> >   10. Switches to DMA default domain for selected Tegra devices.
> >
> > This moves 32-bit ARM devices from the unmanaged IOMMU DMA domain to th=
e
> > core-owned default DMA domain except for mtk_iommu_v1, ipmmu-vmsa,
> > omap-iommu, and msm_iommu. (tegra-smmu also stays on the legacy path
> > until the last patch in the series.) See commit 7 for further
> > information. Existing drivers are intended to continue working without
> > changes.
> >
> > Patches 8-10 are provided for demonstration; we can deal with them=20
> > separately if the rest of the series is accepted.
> >
> > Patches 1,2,3,6 are applicable independently.
> > Patches 4,5 depend on the previous patches.
> > Patch 7 requires the prior patches to be in place.
> >
> > Patches 1-7 only touch drivers/iommu/ and arch/arm/mm/ and associated=20
> > headers.
>=20
>=20
> I've tested this patchset on ARM 32bit based Exynos boards and it works
> fine, although I get the following warnings during boot:
>=20
> platform 13400000.codec: Adding to iommu group 0
> iommu: Failed to allocate default IOMMU domain of type 0 for group (null)=
 - Falling back to IOMMU_DOMAIN_DMA
> platform 11840000.jpeg-codec: Adding to iommu group 1
> iommu: Failed to allocate default IOMMU domain of type 0 for group (null)=
 - Falling back to IOMMU_DOMAIN_DMA
>=20
> This looks like an issue in iommu core, which doesn't expect devices with
> iommu to come up so early.

Excellent, thanks for testing. I'll take a look at the warnings.

Mikko

>=20
>=20
> LLM proposes the following fix for it:
>=20
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 197a8f70c6de..612933306684 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -225,10 +225,8 @@ static const char *iommu_domain_type_str(unsigned in=
t t)
>         }
>  }
>=20
> -static int __init iommu_subsys_init(void)
> +static void __init iommu_init_def_domain_type(void)
>  {
> -       struct notifier_block *nb;
> -
>         if (!(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API)) {
>                 if (IS_ENABLED(CONFIG_IOMMU_DEFAULT_PASSTHROUGH))
>                         iommu_set_default_passthrough(false);
> @@ -254,6 +252,11 @@ static int __init iommu_subsys_init(void)
>                         iommu_dma_strict ? "strict" : "lazy",
>                         (iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
>                                 " (set via kernel command line)" : "");
> +}
> +
> +static int __init iommu_subsys_init(void)
> +{
> +       struct notifier_block *nb;
>=20
>         nb =3D kzalloc_objs(*nb, ARRAY_SIZE(iommu_buses));
>         if (!nb)
> @@ -2939,6 +2942,12 @@ EXPORT_SYMBOL_GPL(report_iommu_fault);
>=20
>  static int __init iommu_init(void)
>  {
> +       /*
> +        * Select the default domain type before any IOMMU driver can reg=
ister
> +        * and create groups, which may happen before subsys_initcall.
> +        */
> +       iommu_init_def_domain_type();
> +
>         iommu_group_kset =3D kset_create_and_add("iommu_groups",
>                                                NULL, kernel_kobj);
>         BUG_ON(!iommu_group_kset);
>=20
> Best regards
> --=20
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>=20
>=20




