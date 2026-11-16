Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27592606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=Wxh3RMsU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A90210EF92;
	Mon, 16 Nov 2026 11:53:09 +0000 (UTC)
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021096.outbound.protection.outlook.com [52.101.100.96])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBEEC10EF92
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:53:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0YTralS73SmdH8h1rUvTXTz5OUzYhBhfMLRIJw7gb5rzipRNm3jXGN7LPaIzKuAb9K8SqFo7MgN/VDXrFC9MTBVoeXgAA7MjGXb1R3JfhcLj9rg68VhtMtvp0WLDGqlAZLje6l3+8uc8DOpcpEjeMDGYP0LmDj5mIMB3MKCXdSyExHSeFMtlSFUaFcNZieUvqFSzuivEK/AHyKv4JRYfDaAfK2ucfK0+o7ke1mI+X4Ts0eMursEsWAiJyhvtZ1LbZ+ng60gwvunuZ8nL6pgZI6HY8NO5n0UGzKMi4QT4JuI/ylyntRAU/6NcFbAC1Xa4TWT9oJ2zFP+kMuMdmB18g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvHwOp8IIVIgP3c6HTQNriERYme4Mq7ZuDbKiM5Uvvo=;
 b=hbT8veaTT2g9/7bc1akBtpkpazshVRBd45yg3HKqr9JpBRQU28Jk6RBiwYrGRnO4ujcn5Mz6fHOfYZxU1TRhjKpunl8/y2yC9+EmjnhpCn5d/fHidPDUwUsUXS83koYWe5wixxKy1c79/yaMhxLX7LJ9knsgUUb5lN2ZRYqHTh3DCUbpzW2bGvocSHLWm3WJqvrh404jphoFzj33sYsUuYZB15/ADks6ogOulJzY1A9ZNWLWP2UMxdjw/wHZQTD+IH3PzlEa4mTCUlzvYdDkOZonhWUh7fhKK50j62xhaKJNV5WxMZb+vST372YXSHmdsxIWvo9rzEAQLtAN73EZgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvHwOp8IIVIgP3c6HTQNriERYme4Mq7ZuDbKiM5Uvvo=;
 b=Wxh3RMsUenayKDjT67CwCb6ONTk9SSLT1W4UWJ9OokwhSv7wwetV8uOccHM1dgZzBELvq560OYnRWHZNF+nINEir+uyAt91FsoxekPcCQvRm3xzpm+PHKFEQiOqpz0w9jY5C82M6Bl3sK4RI3E1xXIK7L1srch642qp5j8c4PN8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by CWLP265MB1825.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:50::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 11:52:57 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 11:52:57 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 11:52:56 +0000
Message-Id: <DMWM4KAYL7PT.2ECY3BSNIA2P@garyguo.net>
Cc: <aliceryhl@google.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <lossin@kernel.org>, <gary@garyguo.net>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] gpu: nova-core: use pin-init self-referential
 support
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.22.0
References: <20261111161935.750047-1-dakr@kernel.org>
 <20261111161935.750047-2-dakr@kernel.org>
 <DMWH39UWW4KZ.1C5B2M4W1V3CF@nvidia.com>
In-Reply-To: <DMWH39UWW4KZ.1C5B2M4W1V3CF@nvidia.com>
X-ClientProxiedBy: LO4P123CA0454.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::9) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|CWLP265MB1825:EE_
X-MS-Office365-Filtering-Correlation-Id: 0822440e-48d3-4bdf-2d9c-08df43d827be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|10070799003|23010399003|261009223027099003|18002099003|22082099003|261022075727099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: ddqnoJybRUXQOs3Df6utoRCStz0rS7mNwYRL2BOCn0IdYmQ8axl6Xs3qWJy/giUXXni4U2e4Fo6OeF8d4sALgkE72phV/mW0xJCj5Du5fkXitS7QVDdEoPDlVrR4kn3VwkmIGhn95FspjskFAWsjvY1zNBJL9FNTxLtskhnW97Lv0O2s5E/1YTUwoWHqs1t8XxKpqNSsweHfI6IcCq7XYCY0FNkUvZotxt8EvW/wm7pdFvVwobmOdZIMNWAQw++ZctnLw7vjJAVr33GBRc7H4NScUVTRRpdGCOPSH7YJYn2zK7CTWob0Hhl/eiTh3SRBIvCFnEo8QnC8rUfr4DtaiMulFarrDRg0dJOZ21lf341iJooG59tIvH8/+qJpqiTpfmuLvSpLqkjxA+UL/7dWI97z7BmSipdsCa6ge5801JO9ylgdekgMr7G4voumbM8pw0ItWcVJcr/DUgvTh+SEK29dXXNBo1dVnLF+pLA6hNewarhKBFq1DL4E0rx8dup3lC96g6TCj/0YrRHLOvRkr1ButecaQaHYQWx0UsCvg/RVRCaxFFm07PEkHRb5tMk2ZUfxacSoTmmsGrf0hcC8IA8vsCGco2DN8GGi1ubc7GRYOwO3lD48w7+feugbKgz//sz6PA/iH6B9FXpFwsopwownERr63TyJBSG4WJzyaqQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(23010399003)(261009223027099003)(18002099003)(22082099003)(261022075727099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1FBV25wSzUzdUwrZTBhZ1JHNTkyMThqazVKTEVzeTd2NWN6QXdCb1k5SWpH?=
 =?utf-8?B?c294dHAvWVBZcjR2eHVjdGhEd2lpTHNaNGZGS2FvTDNGM2p2a3pKR3FEOFpP?=
 =?utf-8?B?OUpDV1JrRnV2YmhOcGJQL0VKZG90d1Q3SkRuVXpzQng3WExLZjF6VTNsV0ZX?=
 =?utf-8?B?eHZBSGozcHFwWTdhSUdPSjlETjViMW03YWhocmV4NFRibzgwaS9YQnp0REM3?=
 =?utf-8?B?TkM3OGFISzJscDBMc1g5S1NkR3I3QUE1Vk1PNG1pZTU4aEt2NTJYM0lEU1Fn?=
 =?utf-8?B?MDdsWHc5K3lpRHhlR2FyNkZmVXRwRDhOYWtDMmEwSUpuUjBWWWRySm5pNXd6?=
 =?utf-8?B?SkF4QWtnNHRRZWlScGZTVkRNcG5aM2xYNVpSeHZ0R204SVpvdkhUc0RONm5m?=
 =?utf-8?B?eStBa1pBVmxoeHVjaGYyM1Rad3BhTTJmMlJTY0thbG1VclAwMFQ2M2IwNi8v?=
 =?utf-8?B?SkdRYzQ2VjYrRHNwVXJMME16OGNYNXdYTnJFNmdEbGpJcjZJZ25qdm1GOU1K?=
 =?utf-8?B?T1ltQisvdm16czhVZDM1by8wK0U2N0ZxMzN5RUQ0MTdZbHFFNlhtMlAzOEZR?=
 =?utf-8?B?Rm5yM2dZeU9wUndNSzl5RzRHWlQ3d3hZQUYyTHFlUHVKS3ZUTFBFZ1ZmblN1?=
 =?utf-8?B?Umo5QndaRVZ5Q1htWmVBNnF0MTZJQ2wvcHN0bGoyby9NUkM4Q3lRRXN6blhz?=
 =?utf-8?B?M0xocDR3UjhEeGxqYUFKekZCZitobkVtSSt6OXowZUorOEsvejRaY0pBaDRw?=
 =?utf-8?B?Yjk1SUpISXVIM3JuUkRsdTZ0NUtwaUd5am1Sd0ZxMXltVnRiRXd0UldxckFD?=
 =?utf-8?B?UFEwcW1NZWZqandhNkdzSmV5bVVHSnBFSk1wMkl5MU4xVklmUDdPWDlCNnU0?=
 =?utf-8?B?YlhSWlhhaVlteTI5V3Nta24xclBRUmVZUlprcCtaVGhTZTU5RG5URFUrY1Zi?=
 =?utf-8?B?U2NJMGRxRk9pNVlqUkJRN0Jhd1RrRW1KWjR1TUNTbXVnUHdvRE9WMUhvOTN0?=
 =?utf-8?B?N3lxMldBWkJ6YmV2N2NvQUtNazdLcWtvMEp3UHFWbkJITXFWN2s2Z0NrQnlS?=
 =?utf-8?B?VUQrN2E4TGg5ZlVEZG9BZUl0NDRyR21RVlppdkVOd3FXUHhIUVliMVdvY2lq?=
 =?utf-8?B?WWo2S2crS2pHNVI5T09oNkhQcklGbnB2MHhoVlNqOU1TMldscXJ2VkJHYnVH?=
 =?utf-8?B?ZkNOMGVPcm1FeGc4RU5rdEw1YmpxUjlQNlZDMkxXZE9MWlRIa0cyZDA2ajVD?=
 =?utf-8?B?Z1ZDaG9FVG5WMmVPOGMyRzI1SlEzWTRwMEwzbkx2S1RZWitIS21LQmRpV2lu?=
 =?utf-8?B?RytPZlZDUlAyR1JxQlZrN3IrT2R3VUxaamxkamlGdFc3bS9wWFJLMHowQmNs?=
 =?utf-8?B?Y2k2VkVKaGxsTzVWS1ZQZDR5UjBIc1RHUUd4NE5Rb2J3TnlGTHRCUWY3bk9N?=
 =?utf-8?B?WWpnNGhQVEdHRmUyZmlGUnNXdFVoUndWajdSL0hlTVZuNzFxcDZCMlhFWTNq?=
 =?utf-8?B?WW8vbDkxY2lMQ3RMTWc5bWRoZUFrcHgvZGU0a1B6Rm9IUE9mV0U3QTVQanVY?=
 =?utf-8?B?SjdweDBVMmcxc0VncmhUZGtxSHdVbUNseW4wM2VKcWpodDlWSHROcDR2ZmQx?=
 =?utf-8?B?VURQcVpVMHU0VnZLZkhuUjZML2Y0VFdNaVZMV3lVUFphYUorYmI1YUlXUi8z?=
 =?utf-8?B?UXdNcWxjVmgrVkx3SW10NEkzWlBsc3NXOWFWS1hPUStzSTNaSGg3S2NhMUtp?=
 =?utf-8?B?Y1BvTHVRbHd2TE4xRzdya2YwdXJBNFRLVjJqUk90dlBGSDBiS21IaTYvU1lv?=
 =?utf-8?B?QkhydEFXN2pMb0RMNDg3QjZtM01tQXlYK2R0cWhCTTBxZDJ6alR5YXV3WC83?=
 =?utf-8?B?ZlpGR2VQRXpVSXFDRXdxSkFEaW5IclNCZnFhSCtVSDhITGZTRW1HT0Fiell5?=
 =?utf-8?B?Zm1HUlo0R0g0SzBaYXZRaFFkdFdUbVZVQ25obDBNb1E3aDRxNjMycGFvTUhR?=
 =?utf-8?B?RHk3Q0lLd3d6aExVNVVlS3BVVy8wSWxQZHBTRy83UUhleFNJU200ZVJNaWZq?=
 =?utf-8?B?UVdKZzdKOFJhVFl2eHdQRHpNaVdPU3dsMUNHaThibGZIejdlbE1kb3RxeFhT?=
 =?utf-8?B?U01nRnUraWU4N2E3d3p1UjFhK1VRUWs3NHBkU3ZYZURLVXVzVUF0ZGNRR2pj?=
 =?utf-8?B?SFBJNkpGenFQdzY3eGRUbm1OM2s5OUlXUTZxVm1ZbXVKb1FRR3RZYWtPVUVt?=
 =?utf-8?B?ak1Qclc4TDRuWGRoM013MXI3bFRVeVNCTVkvODN4RHU1dVNTbjN1bDBURVV6?=
 =?utf-8?B?RTBWemd3Slh2bUQxTWdadHlvejlJMG1pUTRaUksvWG5xNEZLblFVQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0822440e-48d3-4bdf-2d9c-08df43d827be
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 11:52:57.1224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpJ7DDZWlorHzFBo3FCRcDBVUXhlyGLdUWZLY6uGsFxCMiW2ZfX10SSRyCnVud+AU55WKGu9BSQVaQRHHucw7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB1825
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 16, 2026 at 7:56 AM GMT, Alexandre Courbot wrote:
> On Thu Nov 12, 2026 at 1:19 AM JST, Danilo Krummrich wrote:
> <...>
>>  drivers/gpu/nova-core/gsp/cmdq.rs     | 16 ++++++--
>>  drivers/gpu/nova-core/gsp/cmdq/gmc.rs |  9 +++--
>>  drivers/gpu/nova-core/gsp/cmdq/rpc.rs | 11 +++---
>
> The changes to these files look like they are a change on their own;
> they are not using the self-referential support but rather change how
> the queue lock is acquired. It should probably be a separate patch
> before the rest (which would be the last patch of the series).

This is actually integral due to variances, as the existing code more or le=
ss
relies on cmdq being covariant unsafely. Pin-init is going to enforce that =
so it
needs to be updated to use existential lifetime to make cmdq actually covar=
iant.

Best,
Gary
