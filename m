Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C078606A327
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=MMFw+NwU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 774A7112B47;
	Fri, 27 Nov 2026 14:52:20 +0000 (UTC)
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020081.outbound.protection.outlook.com [52.101.195.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCB0A112B47
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 14:52:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvd9p3MgQV7CuQrmI5fQzKDKYDPGjyZAXaQUKYPw9hwgWSL3Lfd/e9gk3w5EXn0V3vMBmmqLI1osJZYstbcxO9uFI3hukVV2qpjbbvrR88x9lC/CBTf4SZYe2NX3N8OaB/j0egFv1v6I6UEsLOREoymdwX+RNNNbOfP5CN/vLnxZlbKaZhJZ3m6Iz2z0WA6+hiEZCUndX8MgJQDZhDTVmd70OODkDHbeBdvMxjRtnARHBxSJ3kuS+qVKK7tHKXbgewwl7BK4sx4VT00la3/b6s7sIm/GR9FIdF9ipMuhkPBPV7GLeApItCGqC6D1Ocr5xabJR6axxHTKR6ZXlmRcaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhLkj9lvxuHtJ7q0dqbw/s951QlSTs7kqBBYFs0E9OM=;
 b=OthTmX+VsYantUciI61wyRMS4bfEPEF0iQPpc7V7Efxj99d2ydFC8zFaR3YUdEc1CMvFv2KLyAkqIlUy+M2ErctL+qJl7ZY1tE4z/SK+6oXiQrJzSdjeCmauXDirSZEgBudAEgC1FPgl6v0h9wKl5fnurSomh/0tsbJkw6FnaduoS3x3remy+bct4cLaz/NdUyBMsXpT6xfc1UsvM6C9y4Yac4/DOW1xpE5NFpq9VASlvYx+kWNBmsaXQNnRqoQYh3QsCNzE7S281Sbe/VJR8+WoCfQZt13hpyV4bhSrAlMTaI+sj2vA7ikl2hdoyuX3nFJ9ye4eQhh+Hhay7NE1DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhLkj9lvxuHtJ7q0dqbw/s951QlSTs7kqBBYFs0E9OM=;
 b=MMFw+NwUABQOoCJBq7WpmZZ2upV10BcBl6Lav8eCQukYsBE04o9eJVvMiURIfFbbWklMLeseO8GsaPCR2udoxFDlnNsOOKkT86LZO9wZfX280BD1JJZ8773aDgfZlaVOdOmqD+QXzvnTNOGCJ5HpR7f7496xw/3F7jj3alqmmJk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO8P265MB7495.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 14:52:09 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 14:52:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 14:52:06 +0000
Message-Id: <DN62TQN60XV6.1KE46URIS7JR4@garyguo.net>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] gpu: nova-core: gsp: add the r000 queue element header
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.22.0
References: <20261127-nova-r000-staging-v1-0-4eaf6e3c0942@nvidia.com>
 <20261127-nova-r000-staging-v1-1-4eaf6e3c0942@nvidia.com>
In-Reply-To: <20261127-nova-r000-staging-v1-1-4eaf6e3c0942@nvidia.com>
X-ClientProxiedBy: LO4P123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::11) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO8P265MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f51980e-aba8-47aa-1ef3-08df4c9601f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|23010399003|10067099003|56012099006|261021123027099003|261022075727099003|261022105027099003|261026121527099003|261022115727099003|261026140227099003|261021121427099003|261028144727099003|261102123227099003|261009223327099003|261009221727099003|261009223027099003|261009220027099003|261009221227099003|18002099003|22082099003|4143699003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: tRo0dQ6terjy4PyQuj8GL4Udfi2qAUfOXPgKNi9c3Fyh3GNolehHk0vN46lq+jMTEKXek05sQU690N8LAfO/KipsoRaF5etFTH590cAAJglp0vUGT4Uxpx81IpWOH6GpGLiOE8snTlU9caNvces5zZPkIqnJIuW2bKEiquy6km2qP77qaSOoFyZqvhX7W9S88TL6rRtKRH8y6LoE9EVSCQboVG92zTYfDUoz8e1pLoZLhb3yCTgMPgQ0D3WIrj2D3TkBlsxUfp/PCcbvXE5HfHM/X2aUVsbPO6foIwpOuf3DFjAKZWXQj4rj3/XkS8UoySzg1zZrCn4xlC2r4l211KDKq/IAB6UjaobJD3C15CW1r570kPf5gh+dHI6xKuRkq6p/TVMS34ypVdBF9Bh143U/6lU2xNdmAQ553CFnSpxjO2q8B9tVztEezuPDE44PDVh2HmeKED7Cx+ZCUzQypfp4AX85GEjzJ/eQUZq5NRWpYKCGU2hXGUHnSXYEExgLIUOESScJRQLDvHIZaLZPwKmM4WJIHOBtYumTllDutYuOVd5PBDbkJlrGo2kj0M5F11RZk5xNW5NO7JPb0V3Bd6KkUtKluXAO7ETrmO4eip+fPHNzAnIemDhEsC/+N8/qtFE49NbLRnwSrr+UpTPT4UyCgut5JnRdbSelT4DYlKE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(261021123027099003)(261022075727099003)(261022105027099003)(261026121527099003)(261022115727099003)(261026140227099003)(261021121427099003)(261028144727099003)(261102123227099003)(261009223327099003)(261009221727099003)(261009223027099003)(261009220027099003)(261009221227099003)(18002099003)(22082099003)(4143699003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTRCdXB2eW5IVFJNUTZZMEdaVzVxOVhzdDB2a3MwQ0JCamYrUjBtVk12M1NU?=
 =?utf-8?B?c2NLSHFRMFdMdGg3K2RCZVZUMjJkeHBHUitWU2tSclF0Qmw3U2tuNUczS082?=
 =?utf-8?B?ZVZwRnFYdm9tRGNXNzJvcjFpUm5hdmxmcGJaMWcxNmtlNVlLb3FGZDV0ZWdm?=
 =?utf-8?B?SnlyUGRaVU5BMnhERGhFbGRXd1puY0cyejdiUjZZNFdkMVlWNlNXeDFwd1pZ?=
 =?utf-8?B?N09zaE5jdW16UEExeHpyMFpKS3lOZnM3L2RJUURyc3pGK3VmRUdWUGRidU90?=
 =?utf-8?B?TUZMako2Sk9oRWwycUE0UEpLZEljWitmRUFldDJYcEFrVS9OZ1RDK3ZQYk8x?=
 =?utf-8?B?V2hPYWVjZjkwNjltUis0L280dXV3UjVKT0tITmUvRWFuRUhOVVZXS0NiRkps?=
 =?utf-8?B?QXhOQU5tMXc0K2dRVFE5TExHdFkxU281dndJcWpYQ2hPZjhqYjQ2cml4QmVZ?=
 =?utf-8?B?OWozaElKeEJBajA1Z29wQ1VPWW1DT2xrdmlHL0kwY0x0MTFSQ0VxTWhiRS85?=
 =?utf-8?B?R1lNVkNvK2d4aGY0YTNhZmk1VWUwcWZPb0Jld3BtVUxaR0ZrbFBPNm81OHpK?=
 =?utf-8?B?UW9UYzRTZEpaa2dnRHg2WVdQQ0dVdVM0clN0b3l2a2NQSUJwKzhyNjdlVWxW?=
 =?utf-8?B?STlrZEhrL1dFZU9CbjRLd2FJZVlYZTlGcWs2RXlicTJRQ2VYczQyN1R0YUVh?=
 =?utf-8?B?Zjdta1VGYkdCL2FFV3VmcFRPWEJpRzFmSU1tUldCSUVNcUhMdzdvc25xcUNI?=
 =?utf-8?B?UUdBUktIaHNDeDBLUzVvQWplQmk4UzhMTWg1K09NSUVXUUEyY0tVTVZETkt6?=
 =?utf-8?B?NnErY0hDbXl4NTNRTGRDL0p5L3FPS0ltRysveldkVjRXVXpjTlpxVnQyUDNV?=
 =?utf-8?B?dXAxMnRkODVnTHhRLzc4TE1LSkdrYldSSU4yVnRCUWRvbVZVUDIwRW5IQ2hr?=
 =?utf-8?B?YlVSbjJuS0srb3pOeEVrRTVnVDcyTUljTDdPK2VsSDR3WU1zcllTM3BjOW5p?=
 =?utf-8?B?N3h0cjhjaUtsM2F0SGdQR2ZSSEd0UVZnT3UzRFVzSGtTS0xZZG14bmZjeUpT?=
 =?utf-8?B?VlphNlVoYnZ4eUVYem16N25oT25Wb1Bzalo1V0ZVRmJxZzJDdFlWZURLNHpL?=
 =?utf-8?B?SWp4cHBIb2h4MGV2OUFFZytzaEs3VXg4Y1NjTlZySDk1aEhMWlFnV0ZKcTRN?=
 =?utf-8?B?aUErbkRKdXlvcDdsR1F6L3RRYWw3RzB6SWZxbzVqK29OZk1FNGxHZEdSUlRS?=
 =?utf-8?B?RXM2T0JRek9iaHhzT1pnZmJscU8yTGNwM00rL0pHNURKcE1rUUgzTWlEbVd6?=
 =?utf-8?B?cVFFdXdZOEFsc3F6YmRNeHhJYnpCS29NWTc1UlIrSERkQldKRUYzMU80N3Jj?=
 =?utf-8?B?OFZSVWVCQWlValhwaWU1cngxc1BTZm9zYVhZRE9PamNRMHZNTmVNRkFPazdX?=
 =?utf-8?B?S1cxeDY1MkdhdUJtNTBaWkp4T2VzK3NwMnVTTDhHS014WnRieGY2UkwrUVk5?=
 =?utf-8?B?MThENU03NkYwakJBa09VY2xYRGVINm1BdDZreE9RdVhKbElXcExTQ3cvdkhs?=
 =?utf-8?B?eFVpQmNNOHM5Rzl2a0tYQTJkeHlreEk1bVk3K2RpaTZTc3pXUHVGdlp4OGhq?=
 =?utf-8?B?Nm5vRHFFNUViUWZnWTBWcFNhK1czYWZCaWErb3YrcjlwUXY2ZGVpQTJQODJJ?=
 =?utf-8?B?UFdqTlBaVUkzSTVhWGIvT2puVWY0MzZ6WnBRT1VMeTVOU1pGWTZubklKbmRP?=
 =?utf-8?B?Zk5rNXI2ZUNOLzFBUWtwWW1iUnVUNmg1SklrMGdSNFI1WXptUFR0Qy82T3NG?=
 =?utf-8?B?em1iR0huOXNOZy8wc2VBQ1g3YWxvSVpnNlpnRGVhcFVIQkl0OFVNSDNwbUgv?=
 =?utf-8?B?M3N5V3BqeCtKb2JuZG1wVjBKeUk4NXYyQXpiQ2JHQ3V3M2QveG5ZcGlCYlFS?=
 =?utf-8?B?Wlc0dUp0eTVNMTUxQVlMTloyZW1naHV6ZllLOG5hZkxMa3MwMWdOc0xtd2py?=
 =?utf-8?B?c2x5S1UwRm00T29FVlI1Uytoem1IQWVENkpJWjdtMG53Nlh0cENRcFhYMXBW?=
 =?utf-8?B?c2RaUDBYMllyRFN0NTNaQTBkUytlMnl2SGpkV2FhM3A1TlVJczFid3BHVG4w?=
 =?utf-8?B?SHBSY1hpd2ljU21QSUd0YTI3QndDKytFelpmMll6NVBSdk9PUzIvOTNza1NF?=
 =?utf-8?B?OGZVQldyN3dhVnpFYmpldXcxdmFqVGpLa1NtTFV0a2xqWWtxK0lEVGorRGp6?=
 =?utf-8?B?OVFVMmFmcE40M2w4bDJVS2t5TnRJSFp5UTlOTnJqUVU2anRrTnJtRTVPZERO?=
 =?utf-8?Q?x76v/YXjoNJt6BY6QC?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f51980e-aba8-47aa-1ef3-08df4c9601f3
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 14:52:07.2844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XncE8UaCsgM3Hpwa3yxI1lLLmbQsuvIJa4UNZMJCKUBqtgJFAmz8+fXbcJ1ZJ3NJrlizB0jYTuk0+DuvVcb56g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7495
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Nov 27, 2026 at 2:04 PM GMT, Alexandre Courbot wrote:
> From: John Hubbard <jhubbard@nvidia.com>
>
> The upcoming r000 firmware uses a new queue element header that includes
> MCTP and NVDM headers describing the type of message (RPC or GMC) that
> follows.
>
> Add that header as the `QueueElementHeader` type, along with the two
> NVDM types that the GSP queues use and the MCTP version and NVDM vendor
> checks that validating it requires.
>
> The type is written out field by field rather than wrapped around the
> generated binding, as `GSP_MSG_QUEUE_ELEMENT` keeps a 16-byte encryption
> tag, only used with confidential computing, in a union with its last two
> fields, making the binding 16 bytes larger than what the GSP expects on
> the queues. Static assertions check every field offset and the size of
> the type against the binding.
>
> The header has no user yet: it replaces `GspMsgElement` at the transport
> level in a later patch that switches to the r000 firmware, and is built
> as dead code until then.
>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/fw.rs                  | 186 +++++++++++++++++=
+++++-
>  drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs |  97 ++++++++++++
>  drivers/gpu/nova-core/mctp.rs                    |  20 ++-
>  3 files changed, 300 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/=
fw.rs
> index 5c216d777dff..2e499a74fa46 100644
> --- a/drivers/gpu/nova-core/gsp/fw.rs
> +++ b/drivers/gpu/nova-core/gsp/fw.rs
> @@ -48,6 +48,11 @@
>          cmdq::Cmdq, //
>          GSP_PAGE_SIZE,
>      },
> +    mctp::{
> +        MctpHeader,
> +        NvdmHeader,
> +        NvdmType, //
> +    },
>      num::{
>          self,
>          FromSafeCast, //
> @@ -835,7 +840,7 @@ pub(crate) fn msg_length(&self) -> usize {
>          size_of::<Self>() + self.rpc_header().rpc_length()
>      }
> =20
> -    /// Returns the number of elements (i.e. memory pages) used by this =
message.
> +    /// Returns the number of slots (i.e. memory pages) used by this mes=
sage.
>      pub(crate) fn element_count(&self) -> u32 {
>          self.inner.elemCount
>      }
> @@ -901,6 +906,185 @@ pub(crate) fn function(&self) -> Result<MsgFunction=
, u32> {
>      }
>  }
> =20
> +/// First word of every r000 queue element: `"MCTP"` in ASCII.
> +const MCTP_MAGIC: u32 =3D 0x4D43_5450;
> +
> +/// Header opening every element of the r000 GSP queues.
> +///
> +/// A queue element is laid out as follows:
> +///
> +/// ```text
> +///     +------------------------------------+
> +///     | Queue element header               |  QueueElementHeader: MCTP=
 magic, element length,
> +///     |                                    |  MCTP header, NVDM header=
, message length.
> +///     +------------------------------------+
> +///     | Message header                     |  RPC header or GMC API he=
ader. The NVDM type
> +///     |                                    |  selects between the two.
> +///     +------------------------------------+
> +///     | Payload                            |  Message-specific data.
> +///     +------------------------------------+
> +/// ```
> +///
> +/// This is the `noEncryption` layout of the `GSP_MSG_QUEUE_ELEMENT` bin=
ding. That binding keeps
> +/// a 16-byte encryption tag, used only with confidential computing, in =
a union with the two
> +/// trailing fields of the queue element header, so wrapping the binding=
 would make every element
> +/// 16 bytes larger than what the GSP expects. The fields are therefore =
declared again here, with
> +/// their offsets checked against the binding.
> +#[repr(C)]
> +pub(crate) struct QueueElementHeader {
> +    /// Always [`MCTP_MAGIC`].
> +    mctp_magic: u32,
> +    /// Length in bytes of the whole element, this header included.
> +    ///
> +    /// Under confidential computing the GSP pads elements out to whole =
queue slots, so this can
> +    /// be larger than `nvdm_payload_size` plus the size of this header,=
 but never smaller.
> +    mctp_payload_size: u32,
> +    /// MCTP transport header of the element.
> +    mctp_header: MctpHeader,
> +    /// NVDM header of the message.
> +    nvdm_header: NvdmHeader,
> +    /// Length in bytes of the message following this header: the messag=
e header and its
> +    /// payload.
> +    nvdm_payload_size: u32,
> +    reserved: u32,
> +}
> +
> +/// Static validation of [`QueueElementHeader`] against its bindings typ=
e. Kept in a sub-module to
> +/// stay out of the way of the rest of the code.

If you just want "grouping" then

    const _: () =3D {
    };

is usually the way and you don't need `super::*` with it.

> +mod queue_element_header_validation {
> +    use super::*;
> +
> +    // Offsets of `QueueElementHeader`'s fields
> +
> +    static_assert!(
> +        core::mem::offset_of!(QueueElementHeader, mctp_magic)

Perhaps import offset_of in the scope?

> +            =3D=3D core::mem::offset_of!(r000_00::GSP_MSG_QUEUE_ELEMENT,=
 mctpMagic)
> +    );
> +    static_assert!(
> +        core::mem::offset_of!(QueueElementHeader, mctp_payload_size)
> +            =3D=3D core::mem::offset_of!(r000_00::GSP_MSG_QUEUE_ELEMENT,=
 mctpPayloadSize)
> +    );
> +    static_assert!(
> +        core::mem::offset_of!(QueueElementHeader, mctp_header)
> +            =3D=3D core::mem::offset_of!(r000_00::GSP_MSG_QUEUE_ELEMENT,=
 mctpHeader)
> +    );
> +    static_assert!(
> +        core::mem::offset_of!(QueueElementHeader, nvdm_header)
> +            =3D=3D core::mem::offset_of!(r000_00::GSP_MSG_QUEUE_ELEMENT,=
 nvdmHeader)
> +    );
> +
> +    /// The `noEncryption` member of the union of `GSP_MSG_QUEUE_ELEMENT=
`, which holds the two
> +    /// trailing fields of [`QueueElementHeader`].
> +    // Using `allow` instead of `expect` as rustc 1.85 ignores uses from=
 `static_assert!` and
> +    // reports this as dead code.
> +    #[allow(dead_code)]
> +    type QueueElementNoEncryption =3D r000_00::GSP_MSG_QUEUE_ELEMENT__bi=
ndgen_ty_1__bindgen_ty_2;
> +
> +    // Offsets of fields under [`QueueElementNoEncryption`] within `GSP_=
MSG_QUEUE_ELEMENT`.
> +
> +    // Using `allow` instead of `expect` as rustc 1.85 ignores uses from=
 `static_assert!` and
> +    // reports this as dead code.
> +    #[allow(dead_code)]
> +    const QUEUE_ELEMENT_NO_ENCRYPTION_OFFSET: usize =3D
> +        core::mem::offset_of!(r000_00::GSP_MSG_QUEUE_ELEMENT, __bindgen_=
anon_1)
> +            + core::mem::offset_of!(r000_00::GSP_MSG_QUEUE_ELEMENT__bind=
gen_ty_1, noEncryption);
> +
> +    static_assert!(
> +        core::mem::offset_of!(QueueElementHeader, nvdm_payload_size)
> +            =3D=3D QUEUE_ELEMENT_NO_ENCRYPTION_OFFSET
> +                + core::mem::offset_of!(QueueElementNoEncryption, nvdmPa=
yloadSize)
> +    );
> +    static_assert!(
> +        core::mem::offset_of!(QueueElementHeader, reserved)
> +            =3D=3D QUEUE_ELEMENT_NO_ENCRYPTION_OFFSET
> +                + core::mem::offset_of!(QueueElementNoEncryption, reserv=
ed)
> +    );
> +
> +    // Ensure the size of `QueueElementHeader` matches the `noEncryption=
` layout.
> +
> +    static_assert!(
> +        size_of::<QueueElementHeader>()
> +            =3D=3D QUEUE_ELEMENT_NO_ENCRYPTION_OFFSET + size_of::<QueueE=
lementNoEncryption>()
> +    );
> +}
> +
> +#[expect(dead_code)]
> +impl QueueElementHeader {
> +    /// Creates the queue element header of an element carrying a messag=
e of NVDM type `nvdm_type`
> +    /// and `message_len` bytes, message header included.
> +    ///
> +    /// # Errors
> +    ///
> +    /// - `EOVERFLOW` if a length does not fit its 32-bit field.
> +    pub(crate) fn init(nvdm_type: NvdmType, message_len: usize) -> impl =
Init<Self, Error> {
> +        try_init!(QueueElementHeader {
> +            mctp_magic: MCTP_MAGIC,
> +            mctp_payload_size: size_of::<Self>()
> +                .checked_add(message_len)
> +                .ok_or(EOVERFLOW)?
> +                .try_into()
> +                .map_err(|_| EOVERFLOW)?,
> +            mctp_header: MctpHeader::single_packet(),
> +            nvdm_header: NvdmHeader::new(nvdm_type),
> +            nvdm_payload_size: message_len.try_into().map_err(|_| EOVERF=
LOW)?,
> +            reserved: 0,
> +        })
> +    }
> +
> +    /// Returns the length of the whole element, this header included.
> +    pub(crate) fn element_len(&self) -> usize {
> +        num::u32_as_usize(self.mctp_payload_size)
> +    }
> +
> +    /// Returns the length of the message following this header, message=
 header included.
> +    pub(crate) fn message_len(&self) -> usize {
> +        num::u32_as_usize(self.nvdm_payload_size)
> +    }
> +
> +    /// Returns the number of slots (i.e. memory pages) used by this ele=
ment.
> +    pub(crate) fn element_count(&self) -> u32 {
> +        self.mctp_payload_size.div_ceil(cv!(GSP_PAGE_SIZE))
> +    }
> +
> +    /// Returns the NVDM type of the message following this header, or `=
EINVAL` if it is not a
> +    /// known one.
> +    pub(crate) fn nvdm_type(&self) -> Result<NvdmType> {
> +        self.nvdm_header.nvdm_type()
> +    }
> +
> +    /// Validates the framing of the element.
> +    ///
> +    /// # Errors
> +    ///
> +    /// - `EIO` if the magic, the MCTP version or the NVDM vendor is wro=
ng, or if the element
> +    ///   length is smaller than this header and the message together, o=
r larger than the
> +    ///   maximum element size.
> +    pub(crate) fn validate(&self) -> Result {
> +        if self.mctp_magic !=3D MCTP_MAGIC
> +            || !self.mctp_header.has_expected_version()
> +            || !self.nvdm_header.has_nvidia_vendor()
> +        {
> +            return Err(EIO);
> +        }
> +
> +        let element_len =3D self.element_len();
> +        if element_len < size_of::<Self>().saturating_add(self.message_l=
en())
> +            || element_len > GSP_MSG_QUEUE_ELEMENT_SIZE_MAX
> +        {
> +            return Err(EIO);
> +        }
> +
> +        Ok(())
> +    }
> +}
> +
> +// SAFETY: All fields are integer types or transparent wrappers over one=
, with no padding.
> +unsafe impl AsBytes for QueueElementHeader {}

Use zerocopy derives instead perhaps?

Best,
Gary

> +
> +// SAFETY: All fields are integer types or transparent wrappers over one=
, for which all bit
> +// patterns are valid.
> +unsafe impl FromBytes for QueueElementHeader {}
> +
>  bounded_enum! {
>      /// Commands of the GMC API.
>      #[derive(Debug, Clone, Copy, PartialEq, Eq)]
> diff --git a/drivers/gpu/nova-core/mctp.rs b/drivers/gpu/nova-core/mctp.r=
s
> index f62e79f56b05..e4d0639cde0f 100644
> --- a/drivers/gpu/nova-core/mctp.rs
> +++ b/drivers/gpu/nova-core/mctp.rs
> @@ -28,6 +28,10 @@ pub(crate) enum NvdmType with TryFrom<Bounded<u32, 8>>=
 {
>          Cot =3D 0x14,
>          /// FSP command response.
>          FspResponse =3D 0x15,
> +        /// RPC message to or from GSP-RM.
> +        RmRpc =3D 0x25,
> +        /// GMC (GPU Management Controller) API message to or from GSP-R=
M.
> +        GmcApi =3D 0x26,
>      }
>  }
> =20
> @@ -67,6 +71,11 @@ pub(crate) fn single_packet() -> Self {
>      pub(crate) fn is_single_packet(self) -> bool {
>          self.som().into_bool() && self.eom().into_bool()
>      }
> +
> +    /// Returns `true` if this MCTP header carries the version that this=
 driver uses.
> +    pub(crate) fn has_expected_version(self) -> bool {
> +        u32::from(self.version()) =3D=3D Self::VERSION
> +    }
>  }
> =20
>  /// MCTP message type for PCI vendor-defined messages.
> @@ -93,10 +102,17 @@ pub(crate) fn new(nvdm_type: NvdmType) -> Self {
>              .with_nvdm_type(nvdm_type)
>      }
> =20
> -    /// Validates this header against the expected NVIDIA NVDM format an=
d type.
> -    pub(crate) fn validate(self, expected_type: NvdmType) -> bool {
> +    /// Returns `true` if this NVDM header belongs to a PCI vendor-defin=
ed message from NVIDIA.
> +    ///
> +    /// The GPU firmware only ever sends such messages, so a mismatch is=
 a sign of corruption.
> +    pub(crate) fn has_nvidia_vendor(self) -> bool {
>          u8::from(self.msg_type()) =3D=3D MSG_TYPE_VENDOR_PCI
>              && u16::from(self.vendor_id()) =3D=3D Vendor::NVIDIA.as_raw(=
)
> +    }
> +
> +    /// Validates this header against the expected NVIDIA NVDM format an=
d type.
> +    pub(crate) fn validate(self, expected_type: NvdmType) -> bool {
> +        self.has_nvidia_vendor()
>              && matches!(self.nvdm_type(), Ok(nvdm_type) if nvdm_type =3D=
=3D expected_type)
>      }
>  }


