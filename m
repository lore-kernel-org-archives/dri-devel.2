Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1194B606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 03:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OdTwl9BS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D58410E08C;
	Mon,  9 Nov 2026 03:27:44 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012071.outbound.protection.outlook.com [40.107.209.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1947C10E08C
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 03:27:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5c5fOuBcwe00oFoL7KRQuyfe2MWJ/+KnhwJoMMk6kHKlFasTkhw/uGJGu5yMU26qx3sE1VbljpcbOvzCKNFD3bGGp6+z1bTcQ8O3yA+njKy4UP32nSUEtesipsAwt7hy5F/oIBx0TA+3iAMyOrQcBVx+yU2GzysgXcmYPnNIr/fjTXwBzNtnoZ9+jQJH84uL1AeQovcQvO6cnRMRcUMGXzazKyaMIvEtTjdYEwdQFdot6r6SEVSiBp9HGL+dB2jDlL4UavsDCE25vdvOowJ+7qVo5me9xLU39v1USJ9Cyq5BwhK2KMNZ5RHnGll9mwxEE4Po3pBr5bConkaJ4txIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rVSozZBEFOpbkbnGY6wiHwL82FFRs6WlS61KbRBroI=;
 b=CQH9cgkGAP/SxwmKzEiGnnjfztMfEs4QekiOBHY4SeeQL7GP1I0mIHLn48DO+INjNgjo6duxxbf9abGC5nU28TENcoX+XTpuWG49Jo1uyK3elyhMcZFQlvhBQjsjd8cNfABFoYuqHXq8zkJucD4CTTD1pWsASv1Rrg+upR4qbtkoFVhVXpxX41tCX9Q0NggltjRu2eRZ8IxiK2LG3vlxX+tukoy6n8ywtN/kokdEeapf1tG07C+mMZ+Eg2NjPedY6cGc7WGi7SixpxMwue48LhguY8m3p0tGwcegePlKp5LvITV8PT01t9h/EKyg2JZn6F0MkiLpLZKHN95yCmFXvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rVSozZBEFOpbkbnGY6wiHwL82FFRs6WlS61KbRBroI=;
 b=OdTwl9BSjeCPTjjlc8DXS2NIAHOKnmFt1vTXGIOAm3yg2z9bbWr0GDq8buRtDM4m92dSMBQwkqpBJ9xITxLZKbpJMYg7b0rWlJC4R8jFjSXEwKpBN5KcnR5Iqqht1hyP533WsYlD7SoDHdGlHP4uyXufAA53uelID9JC0GMDmr/fWzi7YxcNqgU0v5KBvJzq2xsTlniaQNT8OFskkQ9f2JpcE0IXRCmdBUUTQexJTTwTLn35gqtM0HIh2T9czMxpaXwG4Kfr9dzTUfuPA4Ed8Zdrgj1JVTCVB0AXFW/UGuAnBWq1VLxWMzXwl7GaoIVTuS+C11TI+vtQG/W49yMksQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by IA4PR12MB721289.namprd12.prod.outlook.com (2603:10b6:207:10b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 03:27:33 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 03:27:32 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: thierry.reding@kernel.org, linux-staging@lists.linux.dev
Cc: DelaySystem <DelaySystem@tubot.lat>, dri-devel@lists.freedesktop.org,
 luca.ceresoli@bootlin.com, gregkh@linuxfoundation.org, mchehab@kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 clamor95@gmail.com, jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
 skomatineni@nvidia.com, linux-media@vger.kernel.org, DelaySystem@tubot.lat
Subject: Re: [PATCH RFC 0/2] Uninterruptible host1x syncpoint wait for Tegra
 video capture
Date: Mon, 09 Nov 2026 12:27:29 +0900
Message-ID: <L2SDRXLsTSiAzYTWAeJY9A@nvidia.com>
In-Reply-To: <20261107-batch1-b1-host1x-wait-v1-0-8c8198adf600@tubot.lat>
References: <20261107-batch1-b1-host1x-wait-v1-0-8c8198adf600@tubot.lat>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0006.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::14) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|IA4PR12MB721289:EE_
X-MS-Office365-Filtering-Correlation-Id: 92cf8a36-28b7-4e05-1909-08df3e116429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|10070799003|376014|7416014|18002099003|22082099003|6133799003|10067099003|11063799006|261028144727099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|56012099006|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: OPjOmMbjsaM7Y7Z+DkAIEE4Iq1ULNWICsEpaFsvZ4nclGBCNUo+9IkZHgaTL8+t9s0sAUPR9kEffa8FmjcPe9jzWgJ47V6pBFeNP4RQSEXeeWjYFmmO5aYj/BOip9ml+Gkq9tdeizpU1a2gpUjQP7PxxOpEv/+MW2j04cXVvmFdoJrkzTnessa6atcCnAdi44hBkQtCicsIxRbDxuz8hvXNKVlc2ZrngSfd+77rE+IWfA68eB6dB2/wnD+2CMAE33dk7zKl+uPNrvO6GFUKDFDg8W9O+ytpIM/64SH0mTQS57TyJpmA34ZGpjTKNQjmf6CTOUY+8FSghINiA0VZPw0elg7WnpZiRTI1WNqEjKY8LE2ykwlRPwP2yba8YJaQlrWeCX96Mw6iDeQStMoDPjvLJaGagi2bwmZgbnIcGo66eyBleEYC9WGNJmorwIR9gVjgiaAAx9K8loR0ryOhj0zBUpG0wthzu9I6oWIM10jIoj6TjoAx2kC+9xFDAVGZIeet+N5Ik8tlmHW2QtUUFU2QvnOthcjkfT69y0H+XERXQMsj6rUwRNrOuDP5nT0ilaspWIrADHdr1VjSv4jWm1P1ARHoaRDKnprTu83UODr7AGUWDfmTPYG5xmWvaL0zE8m2oHBWY7w5x3JB+hj9E0sWALwd7dyTDgbg1vOcFMzA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(7416014)(18002099003)(22082099003)(6133799003)(10067099003)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(56012099006)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3lFU0hjRzhaejhaVHM2anZDbWpRQ3NDcDdHRXlacE5saXZaY3BnaXJ4ditN?=
 =?utf-8?B?MG5rVGZkWmNNbS9TLzhUY2hpbWR1RDZGcjROOFdnUEhFdkNiRUR0U2VEc0s1?=
 =?utf-8?B?Mlk4bHRQRFJONEh6MDFoU1ZBb0FoRzZEMktLMTVldlNPQnlxc3QwUkh5NkxE?=
 =?utf-8?B?ajZyb3Bjekc5a1BlZVk1OFZVSTlvSnAvSGpMRncvMzZpVVVrZTU3clJvRFNJ?=
 =?utf-8?B?MFNaR1hBSUVHelRtVXE1bWlwT1lMRWNQT202NGlwSi9TeHhRaWpnZUtocEhm?=
 =?utf-8?B?ZVpDbnhPWDFaT1Q5NTF3cjNaQW5JTkp2WGg0VThkem1GRDZwMDVYUGZFYldD?=
 =?utf-8?B?MXRkdVFMYmY5Z0FTcGtyZ1l5TUJpOUdDdjI1MXdFeUp0TlIwRUh1WklHSzNU?=
 =?utf-8?B?YWFscndNUFVsNFhtaHBVTmU2S2ZIOTRLWG5Eb3JaQzNsWjh2YzFWdkExbE5D?=
 =?utf-8?B?emxmRUFXb0N6NmxsV2FqajYyNHdnYk9iS3FYQTNwajN5WUpaQVNPc3RZSWNC?=
 =?utf-8?B?dDZDNUV0VjdEYlBkeTlZa3QvelkybTA5NmpMb0xwVEVoZ205cHZtR1l6QkVa?=
 =?utf-8?B?VXJ3M0twMDNMSnFjVkZhSGFiQnNab3NIOTlXTWpvZE5wcGRobWpKZk9RTG1D?=
 =?utf-8?B?TmswT21TL1RHVi84M0lQQytFaUFtbDRYcVhxV3BWZGRkb1VEdEJyOGk5cUlO?=
 =?utf-8?B?aG05SlcwR2tWVWFGRTJad0hVKzFLMms3UVZGQkd0OGxibWZGdktSMTUrMkp2?=
 =?utf-8?B?ZnloelE2c2ZBN1Rncnl2L0JuRTJmbGNMUWYxYlRvOTBCM3ROYmRyYmlaeTRT?=
 =?utf-8?B?OXYycmdNcXdSTHpGQ0hJb3NHSFpRNUxzTDdYRHBtWHMrM0JGY3cwWnFkUVNa?=
 =?utf-8?B?WTNiNFBpOU55NktUZTJVOGRlZlJyb29OWEdSdlV0eXNaUy9yNWhMalBVVWtG?=
 =?utf-8?B?ZnpVUlV2REpFRUZJQmlGNFYrRW9DeWZsMlozeTJiZThtamNJWFZlczlwTmJ5?=
 =?utf-8?B?Qm4za1AzREcwZVB4eDdMeldueXZ2dWR0NW1vMGFjY3Y3RFdsNk1HY3BzdjlS?=
 =?utf-8?B?dXlWaXo5MWNaVlRDQnB3OWdZV2lERVI3U1JwMW1Pb2Rva2FDcHBRMkM4RS9s?=
 =?utf-8?B?UkY3cWl6NXpycmhNMXhiL05JQUZyS0JmWkErbG1Ia1RCTVRISFFlU2dhTDU5?=
 =?utf-8?B?YTlrVjZDa2QxMDRNYTBKd3pyMVpDeThXaXpSeFFFWlRmYVNyV3hOaUUxN2Q2?=
 =?utf-8?B?Tk8yNUw5SDNqU3pFQlV3Q0xKZ2VSU1RidXluY3FXUnlsOWpyS0dVSVZPcW9Y?=
 =?utf-8?B?YUh1VW80bnptTS9Wd1IzY1ViRjBHZmxQTEJOcmZKd25ER3J4YVVaa1N4K05p?=
 =?utf-8?B?YUdUSEV6VXRQMmlXZVVuQnRIZkM0Z2hZN1Q4SkJkelRuNHNnT0tlaGM2bi9i?=
 =?utf-8?B?YmkyVE9FclFkaWpqRm1kYkZickxNTHMrTUh6OWt6bVpIbTJGK2YxSkFYT0py?=
 =?utf-8?B?QTRBYlJOeDVZZWQvVWhXYlBIaE1BWWRPQUhBQ2NnQ2U5WUhKK0xrOXVkeUdl?=
 =?utf-8?B?ZU1Gd0NtUzE1aDJBaXdERlBRbG9hQUE4cGdlNzNmUy9nQTFDdTdJc0dtUlB1?=
 =?utf-8?B?MnVaYmYxeGh3ZG1hdXVteHJRNG5DUmVMQklDNTNneGVRak1yZXlsZERhc1Br?=
 =?utf-8?B?SmJSM1ZEcjFxWjBRa1hPWExrOGFxREFJazRINk9WVkdHWk1CNDQ3a2FvNzJP?=
 =?utf-8?B?MHl2T2NrTW51ZkxhNEVvMXhTOUNJTnZRdmZFZURWZENtWW5IdHRyNWpxVWl4?=
 =?utf-8?B?NGdtakxjRVB4cmtIRVl2RzdEM3hUUG0wcEhpUFE5Y2xOYmtzajVqb0lYZUhU?=
 =?utf-8?B?OVpmMGtXbzJ5cHBsOTk1ZFc5b3VXTk9YUGEwN09uY0kvdVNLQ2RZZGJUZ2o1?=
 =?utf-8?B?V3Z6bGFpMFdlTmZXNmVWcllyR3NqZDdXUG1OMHMrMk1pc2M1aE94T25ESE9h?=
 =?utf-8?B?YXVPNXlERTA1K0xCKzIwVWVoYW9ieEIrdE9XQzRkY2Z2cGJ0UDRrWklyWk1I?=
 =?utf-8?B?alJxQjYrZWlJTUVlUVlHb2FQWTByZVZQWlFzQ3ptV1hWWTBZYTZRNko1VDEv?=
 =?utf-8?B?bmJYNUNSbGdTUzFncVJubXpmN3VwU0FXS2E0VXhSa1V6bVNwYlVUNllZaUR1?=
 =?utf-8?B?VGJOS0h2Sm9VRmF3SDRaR0hUTk1Xd09sRis1c3VXU0ZncUZQcW1wRzNWOWQz?=
 =?utf-8?B?WVEvalNUTVliNTZIemNyYnIvZnRPQ3M4K3VhelA0cEs5T0ZsaVFyK3EyZlF2?=
 =?utf-8?B?dUxxZE53VXYyRGc0TFAwQWkxWlFTTllxS01VMVRPcUd0UkhqN3JrM2RlVWxv?=
 =?utf-8?Q?VbqJCoIAdegUrZOKvmNQmzTA02L1ND7X1OHiehYZUi5/j?=
X-MS-Exchange-AntiSpam-MessageData-1: nP6/RyOToViRgA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cf8a36-28b7-4e05-1909-08df3e116429
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 03:27:32.6963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDODJY+8KeY4BiCbWRxWVEIvZZM2w2l4Q8hhuqhAQXzrpPl05aEzVGu+aBsl0N0CgH0r/FEf1jznUWAXzYObQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB721289
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

On Sunday, November 8, 2026 2:21=E2=80=AFPM DelaySystem via B4 Relay wrote:
> Signed-off-by: DelaySystem <DelaySystem@tubot.lat>
> The Tegra20 video capture path runs in a kernel thread and waits on
> host1x syncpoints with host1x_syncpt_wait(), which is unconditionally
> interruptible: any signal aborts the wait with -ERESTARTSYS. At high
> resolutions and framerates these spurious failures are common, so the
> driver wraps both waits in do/while retry loops, with a TODO asking
> for an uninterruptible variant of the wait.
>=20
> This series proposes one: patch 1 refactors host1x_syncpt_wait() so
> the interruptible behavior is preserved exactly for existing callers
> (including two DRM ioctls that are userspace ABI and must stay
> interruptible) and adds host1x_syncpt_wait_uninterruptible() for
> in-kernel users. Patch 2 converts the Tegra20 capture waits and drops
> the retry loops and the TODO.
>=20
> This is sent as an RFC because the API shape and the scope need
> agreement before a final series:
>=20
> 1. Is a separate _uninterruptible() variant the shape host1x wants,
>    or would the maintainers prefer something else (for example an
>    internal helper with a flag, or a different name)?
> 2. Tegra210's two waits (tegra210.c) have no retry loop: a spurious
>    -ERESTARTSYS currently fails the buffer. Should they convert to
>    the uninterruptible wait as well, or is failing on signal
>    intentional there?
> 3. drivers/crypto/tegra/tegra-se-main.c also waits with
>    MAX_SCHEDULE_TIMEOUT; left out of scope here, but flagging in
>    case its maintainer wants the same treatment.
>=20
> drivers/staging/media/tegra-video with VIDEO_TEGRA=3Dm, zero warnings).
> The tegra20.c change itself has no compile coverage here: that object
> builds only for 32-bit ARM (ARCH_TEGRA_2x_SOC/_3x_SOC) and no ARM
> toolchain is available, and there is no Tegra hardware for runtime
> testing. Hardware testing help is needed before any final series.

nak

>=20
> Testing: compile-tested only (arm64: drivers/gpu/host1x and
> ---
> DelaySystem (2):
>       gpu: host1x: add uninterruptible syncpoint wait variant
>       staging: media: tegra-video: uninterruptible syncpt wait for tegra2=
0
>=20
>  drivers/gpu/host1x/syncpt.c                 | 46 ++++++++++++++++++++++-=
------
>  drivers/staging/media/tegra-video/tegra20.c | 37 +++++++----------------
>  include/linux/host1x.h                      |  2 ++
>  3 files changed, 48 insertions(+), 37 deletions(-)
> ---
> base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
> change-id: 20261107-batch1-b1-host1x-wait-3cb3b92e9199
>=20
> Best regards,
> -- =20
> DelaySystem <DelaySystem@tubot.lat>
>=20
>=20
>=20




