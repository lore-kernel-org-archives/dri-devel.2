Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D36606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RZP2xNmH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D6C210F77B;
	Wed, 11 Nov 2026 14:50:35 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 109DE10EA4A
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:50:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/7VmqytUrar+xuZlqXhGhqS/3rEZOab9SknXVF/pLQHCKVRDmyiAjnBvRskG1y/jPtebF9/mWhUGjGhZMIoamACC0RZx/pUTFRaJ3tZrlFqDqshWqltEliKPxW9OKQMQCl2f6zpvNCeLFk7VX9edIuNal48ozt4DVN8DfxW8iEgUVr7zfLPU0aBx3n8gidIFLcftac2is3ICpE+Dqlr3vzZVr1a3WH6vYXZ38jv1UvfDKxpU/aDHIZzRaNkclptMpXIstZioZI1nD2aanALNRhplBYtId9pnUMPpVgEtTIC/O7xLN5GLwy0u2VBhjUOiawOdDzOZzv9YhSvPyHXtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJNr2BGCPaFdH4NhXK9UHFWh2mv3xZdspGbt7V6zYks=;
 b=mud9h02ZXthAM0PQdndEiTXxUEIDaV1Ud/DDEk83d79BUZAm3PXO6ufZuhqSvjpjx0uJ1FPpJAJcISe2cpdUEzCtIYzCK0smq+OtXNSTbbSBukRlvaE6p772ycGHRcofC090FmWPsomuJGyoap4SAOqwJyA73e39ZBvoWKP9uAPEckpPniKzdUMICkwL7aIRdioN2LvmQg7wNHNasITq5kVMHOE7JzOf8yx7hoawxNkbiN2T+sQ3vQdGeWnaakDloqyH1e3fO8o8kbiuzValplYaPLSudk/YDfGQSBIV9RcgLB6hb4mxpG7Ms9SYMdFFP0c5yZ26Sdm53Y/nJ3gsjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJNr2BGCPaFdH4NhXK9UHFWh2mv3xZdspGbt7V6zYks=;
 b=RZP2xNmHMbp1E//TPKhZidI+/dBkXD9NFci4PlvgZJWUmloT5ebRbM3mmGWpnU4sHO6oU2q5oIbKhMY+GmxoanKHYLW3YEW+fNnd/YQouhG4tl0VCIKAq/DmYch3MJmo0PnfelzX/NK19PEmldsCQyZRnZL6UzC7/uO2e0xtmZQYvc1GlOk28Zwz2z+QQCpm2/4vXPsyklZvcXBRczNp6dGP6yJzdCQvGMUZ+TIAXfBTtdbIbWZDFHadVl4AkRGVC6feuc4ZUHlirAEAz57f4yX/jidQSIIaxFJiZ14Qcqr3p5FoVZHAdDsGKO0WeDkZ44dU/PZ/MQIqGYNoe/W9JQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by IA6PR12MB765073.namprd12.prod.outlook.com (2603:10b6:208:5fc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 14:50:00 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 14:50:00 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 23:49:57 +0900
Message-Id: <DMSGRDMGTD4J.30PUSSFQMZ4YO@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] gpu: nova-core: gsp: cmdq: increase MSGQ_NUM_PAGES
 to 64
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20261111-msgq-64-pages-v1-0-d8c56b6fdd6c@nvidia.com>
 <20261111-msgq-64-pages-v1-2-d8c56b6fdd6c@nvidia.com>
In-Reply-To: <20261111-msgq-64-pages-v1-2-d8c56b6fdd6c@nvidia.com>
X-ClientProxiedBy: TYCP286CA0317.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::7) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|IA6PR12MB765073:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a71177-f918-4be1-4e91-08df40030fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|1800799024|366016|376014|261028144727099003|261026140227099003|261026121527099003|261102123227099003|261021121427099003|261022105027099003|261021135927099003|261021123027099003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003|261009223027099003|3023799007;
X-Microsoft-Antispam-Message-Info: CAYsL4wGOV/MpG6XDjLgmIGX/5wtLFVYwx98fYO2e++MJJQjluXl+vRL8XKsknZoH0wDdvjS7jdktp27Uxx+BnnkNeeThmDvmgztiH57arjGPpQs30kgfhm45xVmwFBZtQt68D7xY00aXgWKUuOtSpSUy4GBXHJvd+4Ly6ZUDegnh6Dnut0Z0xuT2TJm8AXT0C/r6LRbRs8qUoTRMxZdNmjuv9nEIBH9dbecT5JTlCyAcLVAe+9SISGKaENgX8qtT0/r0WOFHoYw29tfSpY+knX8lXLfUpQQI2xt64Wqzv6nl0+6SmHUyEABhKovQPWvjboWfhZGF7qCBl6QxsOXfQg/AZ20Ku2j23hsvIa0Y0YXC1pX0IDElE8KuTPUufrCtne2At9VA9o8sOzFWAgVROikkF6ROsDmSbLJbM/uXr+iESKoo03P9kuThkSxnBl3RmByQIZ5zphhUKJHmPadkLr2gWaR5+vCsudDBHRxMB8Zx3W0of1SQNqBFF+yYPmaTpqxH0uoIJKkkykMr4BZ7jpjdLou8+hFy5z5C4xA+4/OeGInKIS6ngyaeuCwA2tveRadQF+DX8JKogAoEbm8WtoFwzYs29hza0thRK8GBdpQ4d8YrnNTSH4keCC/mEpPKjUZSv/PvNrG2EF/g7eF+1CplRY5HnCudjiFnMVpF/w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(261028144727099003)(261026140227099003)(261026121527099003)(261102123227099003)(261021121427099003)(261022105027099003)(261021135927099003)(261021123027099003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1k4Ti9BVTJqSm1RVTU0bURZU0Q2eXdnRkVxc1NDbG9aR2R1K1hVNDJvcXVV?=
 =?utf-8?B?VW1iSDlTOTEzM3RyVWdzUFo5NFhZMnRoZnExTGRpWjZxN0xiVkNRQWlwRlVr?=
 =?utf-8?B?bDMrWWF1emhYanRTUlN2cmMvcjlvcDliVDkyTklEeWdrNFBpUi9xaG9GRDJs?=
 =?utf-8?B?NDBibGtYVGhxVGJ5S3BlSjFHcy9sN3dGQ1dtbHZrdVVYVkg1ZElER0tFOFda?=
 =?utf-8?B?YkdPNGVEVGg5UTB2NkVPaFQyUVNMWG1rZ2Q5Q3RyY0FwMENCbXprQmxVV2I4?=
 =?utf-8?B?aDA3ZjNab01tWDRINGhZdjBFTXB1NGdoMDNDck40NFZMT2FuWDI1QWMzS0pR?=
 =?utf-8?B?ZFpZY0NkUlNQRjJCL2gxMVcrOGFEamRzTjI4VXVwc3ZYVmZ6OWVBdEdRZU5i?=
 =?utf-8?B?TEh0c1YrNXJRMjJ4Y1RKVjdrTkd3UVhJa3NIaWhsVnFmM3c5aFJ4dktOQU8r?=
 =?utf-8?B?cXlOQVY3b0hSRFI3OWU5cTNjb2FyUVZqNmt1Wnd3ZENaRkxXb1NqOHhFRDlq?=
 =?utf-8?B?cnExVDFZUElmK0c2blZwRVBQa3hONStkaVFLYjNyNm5CRExsbit6NzhqOUt1?=
 =?utf-8?B?K2FjWEt2V1JpNVVvcXdvSDliTFZHWEVoZmliblJTaWRtakVWRDJUNGZCRjBN?=
 =?utf-8?B?WFJnMG1tRjNodHdDSUU0dFpJS25YUkNWRHlKaCtjTVEzdmdPbkpTdnkrUHFk?=
 =?utf-8?B?K2lna0taZ3ZPL3lDd2NXOGVmS0kyMGhtWWNHckI2N3ZIN21ub1lscW54b3VL?=
 =?utf-8?B?OWhiS1Y0OFIxSExJUVZYZFlOU2gzSUl3ZllJZEhYZXFZYytpUHJ0T29CK0pK?=
 =?utf-8?B?eWp5VmlubmUvUWhraUN4NWNpTHUvdWJQdjZKbStZcG1WRVBwYXBBNUxGSVd1?=
 =?utf-8?B?dHVWN1hzQ3ZiTzlvc2s2eVkvRG4wc2p1UWhiNzNxZWdzdHNSYW9kV0wxdUht?=
 =?utf-8?B?ajBXV0JOSm5pN2tPenVhZUI3bkY1RmZNWmdNSWNzTXcrTHN5WlRSem54WVUv?=
 =?utf-8?B?QWd3dlpLN3haMUF0TGQ5a05KOFM2K0xKWWcvQjZMZmp1UTMrYzZRYnpWZU1S?=
 =?utf-8?B?dUxxWWtNd2l0N3RvNHUxUCtpb05SckRJY0d2a0toSmhYVHE5M2hsaHk2R0lT?=
 =?utf-8?B?WDRxNXlYMURoMjl3ZTU1Wm9zNmp5REQzWHlnYU90aWhlZXErS3VYVitEekpV?=
 =?utf-8?B?WnVQRlZNbVhQS08vcWtGR09Ja1Y3RnF6RHcxTUQyZTIrcnBxWm15aWI5azNw?=
 =?utf-8?B?aUZ6RDViMWtHTU1USVpBSmpiU3NtZ1ViN0hNWTJFWWhEOFRLb1NEREZHY3Y5?=
 =?utf-8?B?bDVXWEozR0o0NWZNWStTWDhpaEdRWVR0ZWtBQjRJa05OcUhxa2tIVkdQSTBE?=
 =?utf-8?B?TVN5V2t5S2pRTU5tZEt5d1F3T280VHVQemZOdU9PanBKei83Tm5NZDNPSGFx?=
 =?utf-8?B?L3BxakpPVWRodS9DaTI5TUxaa2lrTkVNR0gwYTVQRmJRUmpGbEFjQjhZTExp?=
 =?utf-8?B?M1oxU1JaR2dXMU1yeFY2OVRQOEY1VDhmc0NyK1NTV2UzUHIyN2NkY3FuNHk2?=
 =?utf-8?B?bDA5QllEeWFhRFpselM2NWRORTFMUEUvQUFXeFFnaWcxVmNJZEdBbGVmdTNY?=
 =?utf-8?B?Z3lGcGdwWlc1d21JWFhCMHQ0aWlYMVcyV3pnRi8wWkRuY095bTE1QlpEWU5i?=
 =?utf-8?B?VjE0bzlwSVUrVEZoZlhlVEJvQjlob0FKZ2tIaHNyM2g4eXpHWkQyQ0Z6MXB6?=
 =?utf-8?B?NDRGN3NmYlJCNHdId2NnVVdJeHV0ZEhoTko4Q3BCMC8rRFZmUDlPQkRJRG5t?=
 =?utf-8?B?ZnNwU1ludStuU2ZNaVRSM0o2VmhINGlrdnRnTFd2bDNxWmJzOEtrREVzYmRa?=
 =?utf-8?B?ZTdkTU1IdGREMU1XWWlkeExZR1VXcDBKZmJQc1hjMkErK3dHNmxZK2ozN3pR?=
 =?utf-8?B?eXJFRTc4QWVYV0tMMDdWNENKOXlwNWFNMCtxS0pab2FCZ01ncHRCVmJHSGxw?=
 =?utf-8?B?b091WXgvUGs1ZHFRQkNpaUhUT1NFQ2JLdVl2OXFLREdoQXkwbmRaWWduYzJ1?=
 =?utf-8?B?K0lpWXM1elpvMkxtMTZMWXYwblJlN29rR0NsZGRkS2dtSWNSdTRSZmNTMGlI?=
 =?utf-8?B?OUxPK25jcXVpdEw3Q2JLVGVzYVdYYTVDUm1EcVdCUEZFb2xiTXpaa1VTQi90?=
 =?utf-8?B?bUJ3ZkFRVnovaFBpaEpZTktTaVFLeFlzNFprejVtL0tUTUNYZDRFdytsUnFp?=
 =?utf-8?B?bjAzVk1SUlNaK3l4ZURsREFPS1V3eGkvYmJ6Q3d4cmtZaEhiZHdmdkxkcU5Q?=
 =?utf-8?B?b0dCdkh3alRRTUxpTjJNYjFtT3R3TE1aRXhvTEFsZjNZZG9haC9UbUUwc1dE?=
 =?utf-8?Q?GtDWoyDpnho+GPlwf0CSAcnLOCHwGOFPCpYP6e0W/AN+2?=
X-MS-Exchange-AntiSpam-MessageData-1: 5py74qPWhvMajA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a71177-f918-4be1-4e91-08df40030fe3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 14:50:00.6656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZKsG8i1wWlpZfO+N3YKErhLgptPNUE8Wbud0KxCFmfFF9q8lSDwJ0jtwaTdgLtEpD85ykngmmrhLvXW/JNEBTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR12MB765073
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

On Wed Nov 11, 2026 at 10:37 AM JST, Eliot Courtney wrote:
> In the msgq v2 protocol, which the r000 firmware uses, the queue
> pointers are kept in u32 registers and increase monotonically until they
> wrap at 2^32.
>
> `MSGQ_NUM_PAGES` is currently 63 and does not divide 2^32. This means
> that on msgq v2, the slot can jump backwards when the counters wrap.
> For example:
>
>     (2^32 - 2) % 63 =3D=3D 2
>     (2^32 - 1) % 63 =3D=3D 3
>              0 % 63 =3D=3D 0    (slot 0 instead of slot 4)
>
> The writer can then overwrite slots before the reader has read them.
>
> Increase `MSGQ_NUM_PAGES` to 64 and check at compile time that
> `MSGQ_NUM_PAGES` divides 2^32.

Have we tested that this was also working on msgq v0?

>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/cmdq.rs | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index 33074bb53e8c..240ab42db557 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -84,7 +84,15 @@ trait CommandElement {
>  }
> =20
>  /// Number of GSP pages making the [`Msgq`].
> -pub(crate) const MSGQ_NUM_PAGES: u32 =3D 0x3f;
> +pub(crate) const MSGQ_NUM_PAGES: u32 =3D 64;
> +
> +// From version 2 of the msgq protocol, the queue pointers increase
> +// monotonically in `u32` counters until they wrap. If `MSGQ_NUM_PAGES` =
does not
> +// divide `1 << 32`, then the slot, `counter % MSGQ_NUM_PAGES`, can jump
> +// backwards when wrapping, which could overwrite slots that still need =
to be
> +// read. So, require that the last counter value, `u32::MAX`, maps to th=
e last
> +// slot.

That's a pretty convoluted way to say the number of slots must be a
power of 2 representable as a u32. :)

> +static_assert!(u32::MAX % MSGQ_NUM_PAGES =3D=3D MSGQ_NUM_PAGES - 1);

Same here, can't we use `MSGQ_NUM_PAGES.is_power_of_two()`?
