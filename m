Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B46606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 04:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pgTzEvMd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 114CE10E698;
	Tue, 20 Oct 2026 04:01:21 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD82510E698
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 04:01:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzZboLHNwr7odS/60Kiuy9wl7bG7WgfhJ/n3CgENDqoUFRMfluzBkaYAZQItgjhNUMHw3UpreL+7eZUrWjp9X2DoceaCSNVQk2B3IacqdP4HTn2ak9IryIJNhVNoSnLZFyRdGo5EtJTwpAPOfS3vy4OtAxW9kr61zL8I56jDD1eDjjIEG9c/TFERzgc1Gv7ZdJbVC+8xAKlREtgdzuBLn4LV3dpYcRCOqcwpFCTEr9JI38dkw0q5p+rTgTjIp4orlSPmNEYImVg2h0PL6cTetFTh3bK8esSn9kKmN9cocaokH0gy1nSPGrYCgyLvrMORnoHVNQHRT+yNt6vtl8ZauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgdYgpQomLdg5fFZKsyixp7zR0FF+jv9PWI1w8Wp2dA=;
 b=hpGxHMnukcK7qCtnxBHfX55bqxIbpD/gokos2pdaamF7N+0jT1J4kkQJ300AgDBugkChvgH6amJlEcjAfEFMvmfLanCfjlmuleyMClY0dFZr4i5FJKwcQfvsSpa12wYu8gIBdHNeHvHGQ5dVUefDyCZWR+8KqEnmnxvDZA1GSFq9IIC2r52Y6rmcwvtC5p1GOdgQmUEUYc7Jks4HJZ/7HzI27HyBH8qtrD2+kKoc2GBzdf+zkeinlr1rgybpSB1WwqZLYIab13yEt+uJAcf06ilY4levDZuLWW8Y2OXd/ZlX4wLh5CEZ5gF1FQGV9UTPN9mafOEBRQa1VtQ6IzqgqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgdYgpQomLdg5fFZKsyixp7zR0FF+jv9PWI1w8Wp2dA=;
 b=pgTzEvMdFPZQbFG/8CBeHbiBRu/jC2U9oX1KHmO5J92/WzQwW1S0lYUuhE75V5wbOeIsnyGm0op5QtzI1JH4pQ9pPGUIDPWhSa3EvodcByeqC2EEXwmIgpM1zsYjgdNLUVJ/+kN3YzVyD6lqWbllaN06DZiQoL1lpWxa93rUDeLIx35PszNudltlsDd09ZsrjTKE8UW2aQoQb4aV6aHfL5ryNrwChHDBkPLf4bhR+y+WRRUqwflWmJtTiglUqJLiMQcdRQ1XbkL75ozAf0VZ61rfUsKt9qtPuH9L/Igz1IjYB3Y6c2EeoPy4DxxaAyIHjnEZEM/BbeKB+y4oYMeUog==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM4PR12MB9071.namprd12.prod.outlook.com (2603:10b6:8:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Tue, 20 Oct
 2026 04:01:07 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 04:01:07 +0000
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
Subject: Re: [PATCH v2 05/11] ARM: dma-mapping: Bypass the legacy path for
 core-owned DMA API domains
Date: Tue, 20 Oct 2026 13:01:03 +0900
Message-ID: <DYOnECbaRLa5lkvxB4-bMQ@nvidia.com>
In-Reply-To: <5173dbaa-2a49-420d-bf4e-97c9cc340bd9@arm.com>
References: <20261016-b4-arm32-iommu-dma-cookie-v2-0-b06842a01938@nvidia.com>
 <20261016-b4-arm32-iommu-dma-cookie-v2-5-b06842a01938@nvidia.com>
 <5173dbaa-2a49-420d-bf4e-97c9cc340bd9@arm.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4P286CA0023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::17) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM4PR12MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: 520c448c-7209-4b02-fb51-08df2e5ec47f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|7416014|23010399003|366016|921020|56012099006|4143699003|11063799006|261009223027099003|5023799004|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: tw/YEEd3mfqhhdk03QKXBCSR3WarnpRJA90tP8ZizBnQWlTWMS3L0r1a/llDZErgB/HgpYMQ106zuXG8xPyLpbl4Jxd5OsnM+UeSbokjPSN9DnVfPpE6bu65fQQ6vqS7myXvONjtKShnF+XmwhRby7Gb/vNb87ugZ0ouD+8cmWmm1hdBAa84FpRMCF9EDeHMw+kGZ8P+KPhso0HZ3NqQoTZzMV9BNt/Z+Iys2SO+pdNGp/focg4X+NaFuL5axaH7Y9tYCxOlxZjDFyZpklYAeqHWxro465Z5Lz3xBhy5Ga559vvzREKuEiHzLDoRRssOAP7tE4bCKjc6hMhpayjNteBhRLftKkBCdqWbovPNoH9tYOhjMeO9+NVAQ0C9a5sofzeoIRnXmLJhrpWNwbak4LOTi6ZHISIZMQLf3Gjvc4QNPMdgQpo9nXAcoF1lDD72YmnZendQh+Ce1HmfmzNxr4n8C51N/+ycBpNChPVC9NAbRvEavRdELrr2mG1WuRIXgoykFHvpQI0VvbUs5tVRHwMM0+H5IXZfWa0WaY96I1jj5Iqen/2HKx4XWuJT1njY6MhLCk+kdTQH2ih0LgbcAwYoNKsFnHB5+UYh/drC/nejD/R0tvXiSymr9KkUFL2/cXh8CKJEQfHQVbVhuSDn0+N2fOGFuZpgZ2KgUa8d6ru6wNaP0XlfPsu7QioLwGLYiFeFYQcAMpPdu4PHrpfHkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(23010399003)(366016)(921020)(56012099006)(4143699003)(11063799006)(261009223027099003)(5023799004)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFVRU2ZhWms3L1kxQmNnSW55Uy8weEZGYzdXOGpzdUpoeGJoTXh6bWdua0NN?=
 =?utf-8?B?Y3F6eGFFUHFCQmlKc2p3NUhGckRDbno0dE9RanRaTFlnYittNWt1WDlzbE9h?=
 =?utf-8?B?dHlnalNjMDZXVlVpYXNZcHpGaC9GMk1jdTNGcmduY0dxNVBBbVQ0VEQ3MkE1?=
 =?utf-8?B?S2pTUEVKQW5RQ3V0WGJPbzIvcHNoQWhoN0NjbzNkTWw1QlB1b1p5VnhFZ2py?=
 =?utf-8?B?UWpWTXM5cFRYR1BiRnRJVFR6dGFKbWZEMlFpNG14ZGdKaFlrcEprR0RCdytX?=
 =?utf-8?B?N2JGdStVOGNoVzZwWWc2Ykpxd3VaWEJoR2dxdjlMelY3NW5sZlFkNXEvM0RK?=
 =?utf-8?B?d2lDbXd0YUFtNmM4c2xIdVZkbGNoZ3pyd1RTOVpkL2pmM2NUZFlqM2tqS3NR?=
 =?utf-8?B?cEs0YldKeWhCSHg4Qnc4aXJvWTdQeUNEK1lJc2V2MDczYVZZa2J0T1BNTlEr?=
 =?utf-8?B?eG9lVTlYWnZLMHQrRVlISE1hNDUyTmRzKysvejBOYnpmV0xIcHlNdHdGRkNS?=
 =?utf-8?B?Zk02a2FMTW15Y2RTYUl0eXpqVmlMVFVFdXliT0R2RHhSeDNZZDhkQmdybDBO?=
 =?utf-8?B?bnB1R3VsNDV1ZUZqdm96M1VxV3NxWThvTU9HNFh5dHBtaWlsT243NldRbzVT?=
 =?utf-8?B?SWk5NC83c05RS0VQT3djZXEydG9lMU9tZTM0djExcXJnMDI0ZFpSd0VPUERZ?=
 =?utf-8?B?WmpWUlc4dkZZQXhuam5FMitaSHJlM1dmanZpRUpvandEZ1F2eUt2T21hK084?=
 =?utf-8?B?OWZUclQzTGp2bG1ZUE1PSnhENk5FRmhqUVpLZTU2cnBHSnJDaFIzc0VTcGxL?=
 =?utf-8?B?MHcvUmJZT1Jxb2tFVXlOSGpmM09ucHhrL01OeWd3RUpVZE0rVEJ2QlgzcFdP?=
 =?utf-8?B?OVIwTVFpdlo0a0pldzFXQWxXMkJ3NEdXamdRUlB1NmxUempraUwwN1pjWmF0?=
 =?utf-8?B?dEVTV21tYXVTS3dxbElRMzcwYzlyUlBCNmZNWWd5VGxvTlk4aGRmQlhQMjh6?=
 =?utf-8?B?azQ4aGYxb2RsRUR3U1VicStJQ0hibEVnTzlKR0QyR0dBZUVHckxyRnZOdFRP?=
 =?utf-8?B?bU53Z1VKdU5LQlA0Qyt1VExYV0VWTENDWncvUXY5S0tra2JXWWlORnFwWGJT?=
 =?utf-8?B?WHA3dFFEbGdYbGJDdllvNUg4MndGQSswUjZnOFhWblE1NUx4clJ0ejZ0OUlt?=
 =?utf-8?B?YXlvVjVmMGJjWVU2dmUwNkljd2NYYlhGcnd6RGVaSnNrcVNjM1pzRGNLdWE5?=
 =?utf-8?B?V3E0S3VHNHhrYnJaWWdkdE13ZDhFTy8rWXAxdmhEeGttV1l2d2hHdGZud3RT?=
 =?utf-8?B?amhoVGZ4ZkR6Tk1pTEtzQ1M1Tzd6bklURllOWVBucDZHaDl1ZUEwK0loNVhF?=
 =?utf-8?B?ZEpOVW5TYWFTZGZkTWZVejNqZ21GR1JKYkUxRlV2Q3hWOXQxS2FoWVp0Z3dH?=
 =?utf-8?B?c2NEc2NHeFBZTjduZk5LZTIxT2FzakY5QjJiQkZYWm5GRjJkSlJlRG5mSm1a?=
 =?utf-8?B?SVI0R0FzSXd4S04zK3ZaV0ZPcGVlV3BpNjNKSlhuQmJaUUFzUzcwUUJWSzI2?=
 =?utf-8?B?c1lwWE5sVkJPSzVhb2JubllaSkN3S0lsbmNnazZWdHVTZjFKMnZVTFJ2d2Ix?=
 =?utf-8?B?TUc5T3BOV1ViL2pPaVpkaG5IT1FPYUh4alFzUnhUZGVtTzEwNG96c0FVVzNP?=
 =?utf-8?B?M0NjakRqUVkzSGdMSWlTajR0cGhSWXRGdVZ4VnZhNHM4ZGNLb3U0M0hBY2sw?=
 =?utf-8?B?K1hKTDFzVDhFS3dPSGhYSDZwcDQ4NVMyNm5kb3I5MlM2cnJJZXJySFVQUHRE?=
 =?utf-8?B?WW1JbVhxMk9xRkFEWkdoRzRXV0VOQTQ2cjFqM3JPOVF5WkZzZEI4ZFYyd3pV?=
 =?utf-8?B?MkRGVkFGaW1PeWNsVnFHRkYxYWwwQzRrazBVYkJncjNEQmU5dTlBa0JxRndm?=
 =?utf-8?B?WldpVVB4ZTFVd0RuWVJ4SGx6TlhhdEE2WW9hOE51NnVleVFMdzlDYVBvUEFi?=
 =?utf-8?B?bmVrZldZOU9HaFdneE8zSTFYOU91Zm5tbXF1a09lamx4M09IT2o4QjNRTVJn?=
 =?utf-8?B?a0tqTnJyYWloNVd3SndhM2k1TCs1cFpUMWdKZG14eXp1ZDUyaGd5OENqaHBX?=
 =?utf-8?B?VWtBNTlyQXlBOUtKUXY5Unc3S01nOVZ0TjR2RlhTcTJsQzJIV00yYmZ5RlJa?=
 =?utf-8?B?bVR2T3Y1aXZrb3JVMDVabVFuOHczNnNScHdFTHNYWmFvb1hhUVdsbklncFJK?=
 =?utf-8?B?YW9VbmM0RmtlYTU5TkNQcXFXRzdXWU1MKzlrUEtEZUdOb2ZrMFV5bTFxTmQ1?=
 =?utf-8?B?WmpJTTR5ZDI3N09jVmdxaWJ6cVBCMnVkZHBqZlFIa2pYSnVhRGtHTmkyci96?=
 =?utf-8?Q?oB1plSln5QQ7geAWT5XgKucRNqM7vi1ZaISKHsxhCgRAi?=
X-MS-Exchange-AntiSpam-MessageData-1: SzZBQP+zM5t/Hg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 520c448c-7209-4b02-fb51-08df2e5ec47f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 04:01:07.0452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGOTL5QxbHltDZfE3B/cJAQF4tXmDUeGS+mVXR/rN6LBSwQvUZD4/BCP3dQ5HiEz3ajc3ps7UiMAkXD0H/flXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9071
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

On Tuesday, October 20, 2026 1:55=E2=80=AFAM Robin Murphy wrote:
> On 16/10/2026 7:46 am, Mikko Perttunen wrote:
> > ARM's arch_setup_dma_ops / arm_setup_iommu_dma_ops creates a custom
> > IOMMU domain for DMA API usage, and continues to do so when the IOMMU
> > driver doesn't explicitly request a DMA default domain type.
> >=20
> > When, however, that DMA default domain is requested and the core owns
> > the domain, we need to skip our own domain management. Add checks to
> > arm_setup/teardown_iommu_dma_ops for these cases. In such a case IOVAs
> > can be allocated from anywhere in the domain's geometry, so also add a
> > check to ensure the device's dma-ranges cover it. Presently, this is th=
e
> > case for all platforms except some OMAP platforms with a non-zero
> > dma-ranges base.
>=20
> It's probably worth adding some cleverness to arm_iommu_detach_device()=20
> as well - it might work out benign to attempt to detach from a real=20
> core-owned default domain, but we'll now want to set dma_ops and=20
> to_dma_iommu_mapping according to the default domain itself (since we'll=
=20
> now have the possibility of switching between an explicit unmanaged=20
> dma_iommu_mapping and the implicit default one.)

I was thinking of just disallowing the explicit arm_iommu_* API for=20
devices that get a default domain and hoping that any device that opts=20
in to the "modern way" is capable of getting rid of the custom handling=20
:)

I'll add a check to arm_iommu_attach_device to disallow it if there's
a core owned domain unless you have other thoughts.

Thanks,
Mikko

>=20
> Thanks,
> Robin.
>=20
> > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > ---
> >   arch/arm/mm/dma-mapping.c | 25 ++++++++++++++++++++++++-
> >   1 file changed, 24 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index f2d3e8ec3487..d6315baeddb9 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -1761,13 +1761,33 @@ EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
> >  =20
> >   static void arm_setup_iommu_dma_ops(struct device *dev)
> >   {
> > -	struct dma_iommu_mapping *mapping;
> > +	struct dma_iommu_mapping *mapping =3D to_dma_iommu_mapping(dev);
> >   	u64 dma_base =3D 0, size =3D 1ULL << 32;
> >  =20
> >   	if (dev->dma_range_map) {
> >   		dma_base =3D dma_range_map_min(dev->dma_range_map);
> >   		size =3D dma_range_map_max(dev->dma_range_map) - dma_base;
> >   	}
> > +
> > +	/*
> > +	 * An existing cookie means the core owns the domain. Only set the
> > +	 * per-binding DMA ops. IOVAs are allocated from the whole aperture,
> > +	 * so the device's dma-ranges must cover it.
> > +	 */
> > +	if (mapping) {
> > +		const struct iommu_domain_geometry *geo =3D
> > +			&mapping->domain->geometry;
> > +
> > +		if (dma_base > geo->aperture_start ||
> > +		    dma_base + size < geo->aperture_end) {
> > +			dev_err(dev, "dma-ranges do not cover the IOMMU aperture\n");
> > +			return;
> > +		}
> > +
> > +		set_dma_ops(dev, &iommu_ops);
> > +		return;
> > +	}
> > +
> >   	mapping =3D arm_iommu_create_mapping(dev, dma_base, size);
> >   	if (IS_ERR(mapping)) {
> >   		pr_warn("Failed to create %llu-byte IOMMU mapping for device %s\n",
> > @@ -1792,6 +1812,9 @@ static void arm_teardown_iommu_dma_ops(struct dev=
ice *dev)
> >   	if (!mapping)
> >   		return;
> >  =20
> > +	if (!mapping->owns_domain)
> > +		return;
> > +
> >   	arm_iommu_detach_device(dev);
> >   	arm_iommu_release_mapping(mapping);
> >   }
> >=20
>=20
>=20




