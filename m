Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D4ACDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:27:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D850E10F1C5;
	Thu, 25 Jun 2026 09:27:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="baN9CDMA";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011045.outbound.protection.outlook.com [52.101.57.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7346210F1C5
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:27:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3NyUDnVL/lukTjqCI9lssQZwR6EC4JWuF9N+xAxG9wcGG1HYBtIKwMeOxmRiT40EW6Y7ayNYxqsUmRgmkQEuD37MoVUM1nqfDHd/kMnyXp99zjRkvVBwvpjcvkBPdfumzfofgwoIFXZWVYANVH8AJEIJnjRKcZGkF6kQdNnDumWz0EPU/+VJFDnlN7ax1/D2oWTS5M/SfM5nFwk2wgmSl/cOcxHJ7RDyTaN3Xhi4/O/IURfs5p1MdXuThv+qrcEltYIdaHX19kAeAfOeAwiz8iXpz5KOqpEgBM6qFNEJRV/yVpR+vMXDcs7Fypf1p8aA5OEK1v61QTElxuMRdw/3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhhC/bzjY9G9pbMgV012D+VHiOVbjyhq4LsNktpxooA=;
 b=BXgvxy+wUI/lQNTOKj/b5xsF85jsGcn2N7lhv+QeE/KeFBPT3QFXDUFX6JmlXeN67OBPfdLX+5H347NWtNFQNpzjmBJ+JhiUJpxlfqp5ItZWZyy/5atbPtsdfK2051KScqHDE1dmvtJboFQYIn+MsbeT+U/GBCeJO1zSOxyL9ChtGHEoZ4B5dgddS7C+jJuUJ1jFk+rxxqY/VZkyjbPAW06afya5n+KLSAuL66l8YV6V/vzj9kYuF1LFCxDHQ863e259na1Qa0px9jihOxy0l4KM0Hap2NSmCcbAikxefMgrXPNeGHRKJUpyL9e5LTg1vh2kaeTvxLA5JQIxiRwZng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhhC/bzjY9G9pbMgV012D+VHiOVbjyhq4LsNktpxooA=;
 b=baN9CDMAUXoZxQ6QT7RPzFN9w1ROPVYihpLOAe7ZVtl8cnU3neEc5einfEoTPtRpBsWFvAgRi/GfLjdNf6azhf6EqI4eFxiAQ8QuoQ1bSuULZ6z+19rsw47A4c1ADdW3D4jY90UsbSnt5cl2UISI3JfB7sK3llx8eUVxQ1rTfH7A8s46eDqhOR1XhUEaay4wUsAHhrBqvYrXkgMZp+XMHXPzkwYCVrW9S3oeEw2Cl7lCSi3r88lD6W96ytOfLgM6O+Y1drhjkNh2P9xSBRnY2NtOsxDDzNjwRSfWEwQNeu0CffJQ4GyLaJzbsH4dQbLqcf+bH9jHU6Y+htKe3+5tWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 09:26:56 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 09:26:56 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-tegra@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: display: tegra: Make non-vm registers
 optional
Date: Thu, 25 Jun 2026 18:17:39 +0900
Message-ID: <NWz2vh3HRYqBDySgTFAF_g@nvidia.com>
In-Reply-To: <20260625-hospitable-antelope-of-diversity-f3456d@quoll>
References: <20260622-host1x-nohv-v1-0-65bc682a617f@nvidia.com>
 <20260622-host1x-nohv-v1-1-65bc682a617f@nvidia.com>
 <20260625-hospitable-antelope-of-diversity-f3456d@quoll>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0257.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::8) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SJ1PR12MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: a7061079-bb12-4320-f10d-08ded29be681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|23010399003|7416014|376014|366016|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: aJjPicxNsMLoQcKlVnGF6utwf6ST95UrW+Ddyc4cKTbyWYeoh8MdDVUOq2zBMeg8tvETGstq2yzUlAahzCtrgKdP2lFRFqlpmHS+CAg2rpE+dcPICL6J2yC9WKBsZLIDHME/fKaphMfqkJj/ThBD2dJVdFsYo4LAjUgcBBiXZMyRb5kk+UCIPjYcPPxCBttapgv+WqpX8ENzsQV3LiJUgy7aB+Smj3PVvIIgfKdPsc5Boz46rUY6pRSWNTlMm5Q/2NZIYy1MAqrDLMSg8ym61k3vCSdxTTtDrG1D8O3U/KRBwwLy2gggIj/FRGDvuc1Bq4CThZv4eBOOT3nYPnwav7kbC2/C1j1waMdcTrhU0tZNRCV3X5wXRdEzHfF7nxlRmApXAW0J8Ot70NFyA98j0rbGvMs2hQZqPwE7DL+dAJNy1ZQn1fJMvs251ySLH3PaPw5yeqrVDX5GlrzRhcpvTzEy2WCb+WlyBlaVYwdk94Sh1QSB9Qufuwz7MTUn/teFbsec5UuJehVExJCf3IzIPkZc9gGB1+8J3M0Yk+80mERDWTuYzBXabztnbOtjE7ymzgJbTfBd4ua5in3+FM+AOP2pP4mJcRQ/Qqai/dE7yzCZeJDaw+TQgpoypfKip1gcmrsm3KaMmyyXSvk2+P7t6PsBQu49qgIwNAK+Czxp5no=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(23010399003)(7416014)(376014)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ank2aXVsRUw2bWJPeCtzUVc4OURzdm5YZ0pCR1lOZlNuejVDOHFuaE5nbElw?=
 =?utf-8?B?eUhKWmZkYjg5WUZZYlNuV0FOa2dTVjFzTUhiSWNVVVhWbWQ2RWY0SnowTmxQ?=
 =?utf-8?B?MmJmSFNibW5KM3laRHdBbTJJZUhLV2llcmttMTA2YW1MaUpxL1FWYkFXVWhO?=
 =?utf-8?B?SWdiWnM1VkZzWlI1MmMrVEtkdHdvVkdncHM1TjVZQjVKdGtoM3pSS216Skps?=
 =?utf-8?B?ZlU2UllvNVhoNGJmbGZGTitQb1R4YTdoRVEwY2Y1Zy9lN0VndEQvTnJXUmlo?=
 =?utf-8?B?TWJ2RVNlMTBqRVU2dVowdzZYUVpjU3BnR3U5YUh2dnZqS3FUaXlFYzNHdEt1?=
 =?utf-8?B?ald3ZXlpOWJWMDdwd1E2MjU1UUlpTHRNUC9aWU5OcDNlZy8zN2ZhUEdkVWpI?=
 =?utf-8?B?MllUMnBzdlVYYWpjOWR0Q0xDODVlUUcvMlgyakNvdzJWM2lJODlBOGJNL1ZJ?=
 =?utf-8?B?SjQwdkJjcXRyU0lzWkJjV0ZPOWp4dDhlSERqYWJjaEdrekEvVHFoUXo5Q0Zw?=
 =?utf-8?B?OXZtb1Vxd3Y4Zjg4NFJtd2FMU2xwT3dLKzh2MlNCVE43VDV1UG5zVjg2a3Iv?=
 =?utf-8?B?MDl5c0hPNXFTQ2prSlVvcjNKSXVmQUtjRE9aRlc4cmV6V1pkMDdLTzJtOVlK?=
 =?utf-8?B?UEtNQTlFdXNheklLSlVPdC9na0plakRPR1BxZ2xQbmFEc0hndEM0K1lxSnpi?=
 =?utf-8?B?WE1JUEgzTWpTZkg2RDNwbDYxdUlKVTk0ZzFJVXBBOXpRblZQK2Rqa3gzYyt6?=
 =?utf-8?B?QzljRG84NTQ0ZEJoNGMzTVFHTm1NdVBXT0pLVlNYUmlObU9tWE5XQnV4aDd5?=
 =?utf-8?B?dHBQUEJyV2YvenhJek53RW9VZkFwWXlmUmUxSE1OUlYva0RZbThTZVJiNG85?=
 =?utf-8?B?ZkUzNEZnSUdsZkJ2S1llNTlmeVo1VktOZFZMb0ZjQTRLTVZPL3g2dXU1WDdn?=
 =?utf-8?B?QUg2RDJDMWZjSElMc3BKR3BJakFBZUNGb2JKU2VtWTRsNDMva2dBYjMzTml2?=
 =?utf-8?B?aHJxOWR0ajcwN21zS3ZITU0xWitNejI0d1V3dGpYaG05RFViS04wRUx6Ry9h?=
 =?utf-8?B?Zmtna0RQUktIOFRCTW83YXVZeWN5NzhNbVIvcVBkNERKNHNFbk91REIrUFZT?=
 =?utf-8?B?bmxDRWtvTkJkN3I1dmxYOWNvN094R3BUVWR0MFprZnJJL3VsWXB3UHNHV29r?=
 =?utf-8?B?OXZDVGhSTUxPU2JOUUEyNHFLK3lMV3hRM01EU0c0OEdvRE5VWmJaSDNpRUtV?=
 =?utf-8?B?Z0JmbnN5SmpSbHpDKzVSWlo0TlRXOTJKcWowMncxZkxJQUZyaGtPc1d4bWZk?=
 =?utf-8?B?L3gvNk9qclhoTGtuUmFtZE9TS0xua3dEbFRyUFdwTlo0TnAwRW16UkRVOG1n?=
 =?utf-8?B?WEN6MWxQd09wbW1JSFVSWGY0WFNYaGs4UVdLTnRTWVFlWmI2ay9rUjRiZTBr?=
 =?utf-8?B?YVZ2cEQ2M3ZjRDIwMjlFblRTaFpEcFZlektmSkJJdDBJME9YcGdMUWtxWElk?=
 =?utf-8?B?U0o3Z1ZKZ2RSVHptMSt0OXdvNU9qazdYeWRaTW9ENXZybEtZc1lvTDBLclBk?=
 =?utf-8?B?QTV1ek9TZTVyYUI0anZ5QXdCNEs2cWF4UmhyYjl2Z00xNGEzUW9DZkF0ZWNi?=
 =?utf-8?B?VXdNRy90cUh6K2c0Rmo2ckdHQ2lCTTV6Z21LSXZuaWdlSFY2aVF1eWdxbER6?=
 =?utf-8?B?a0dhY1JsaVdEMHZLY0NQSkZCOEJtMnJTQXhFam5ycEFrV29PT2FsTGI4UjVu?=
 =?utf-8?B?ZWVteTFiL2x6QnB4dzRGMmZNZGlYb3pLU1pLK01VajBrZm40a1ZiUml1bDY2?=
 =?utf-8?B?ckVzRllLQWZMenFIRGxQVlE0S3R5S2ZTVXFDRzU3dDZaRmdFU1VEYmJkZk5q?=
 =?utf-8?B?UWROOUR4cVg4QmowMHE3SytaUE1pQnRXU0diYTJDYTRYWnlVanFZc09lZHUv?=
 =?utf-8?B?ek5ldVdPaUQzOFRQbml1K2p0MXBoV25DUmZuQ1gvNVIzamNodXJJTS8vL0dt?=
 =?utf-8?B?WEQrWlRYMmxzWUx4dmxucjc3N2lDM2RLY2Z0L0tLam83UXFQbUxEaHJZU2wv?=
 =?utf-8?B?UjB3VmNWQjNFU0ZGcDIyTjN5OHAzZnhGMEFyTEtCNmk0a2ZDMDVKRGZHQlU2?=
 =?utf-8?B?bDJ6QmdnQnlId05Mdjl5Mk9wRDRQaktHaENOSDQzT01uZGRwS1RWRU53RUJK?=
 =?utf-8?B?c1FtZDdhcHRRWkdXZnBSRFdjWjc0QjNuUWVsWk84a05pdld5MkJyN25nR2xV?=
 =?utf-8?B?aVlaNURadkZyM0tMbndBRy82TGNhMXZQOW01d0JnaEgrb2Fia1ZHWXh6M2V3?=
 =?utf-8?B?SUt6cnFuMWJtcENZNzd6Z0pndW5kQXBsRjdBS1I5blErL1JwWVdGUkN2Q0hh?=
 =?utf-8?Q?bZ4MeDx1mBUVaBlCsKldkHUAQxc+CskXNP8fUPrpVx7YB?=
X-MS-Exchange-AntiSpam-MessageData-1: 2U0NyqHOUk3ldw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7061079-bb12-4320-f10d-08ded29be681
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 09:26:56.3540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y22Ul7ke3bkJPHHnGYbmPyzTPkXY82XWzGatbXsaQ9YUx/b/aegBVt8WN58/mvjrMEGOsFrbEvaxjTzGUyTGAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6194
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

On Thursday, June 25, 2026 5:34=E2=80=AFPM Krzysztof Kozlowski wrote:
> On Mon, Jun 22, 2026 at 05:22:50PM +0900, Mikko Perttunen wrote:
> > Host1x can be used without accessing the hypervisor or common
> > registers. Adjust the bindings to make them optional.
>=20
> You still have these registers in the hardware, so it is not optional,
> not flexible. IOW, DTS represents the view of real hardware for the
> software, and that hardware still has this address space regardless if
> OS should use it or not.
>=20
> Otherwise you need to provide better background here.
>=20
> Best regards,
> Krzysztof
>=20
>=20

The intent is that the vm-only version is used in situations where the
other register regions are not available to software. Typically that
means running as a virtual machine, and the hypervisor owns the non-vm
register regions and doesn't pass them to the guest.

Since the guest runs under the hypervisor, its view of 'real hardware'
is what the hypervisor is exposing to it -- in this case with just the
"vm" register region.

I'll add further explanation along above lines to the commit message
if you're OK with it.

Thank you
Mikko


