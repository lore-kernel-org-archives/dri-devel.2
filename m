Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A806FEEF2A
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 11:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C396110E339;
	Tue,  7 Apr 2026 11:57:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="Z+huIJ7v";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022085.outbound.protection.outlook.com [52.101.101.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F14710E339
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 11:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=poOlYFxbmSxkG2TN+uCph/raSCdgy3qoi85ntwvX/r7SikSikf4kv915foHXx0mYK6cKaWNQfuGg77cbE1YcsXYReEpqfHMlG1UOKjI4ej4Pfsuo1YEHpU6fSa42x7aeI666WDxEa0KpfRrexaqj7AjL/MPN725D3w3SWjHgPQPwb9iWa++eYLT5zAXdvIxBYHmVa0CXRXT7uSVJAimGaGvRg1qSjiGoRp2JSKpQDzg/OqSDJPuq7dDwYIYD/k+dX0OL9fJ6IYSlNd9Vw2L4B2hKOJBu0VfIFTOkTghzJx/LkaM5suprNFshmyWLOUjUjiSOBXaBYiSgCQpeB1QdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5mBv3rGw7eVGx+tji+SH9AsIpOLpBSNS/vQkAjiqj8=;
 b=fF9wFrfW5YWso6DFyMa9mEL3xQ3s+ldaSxmUcEcUJOOFK0fsYVoztvuPOxZ386UHaMTyrXcaqyEfhx8L5HayF76uOmb9aAaVOKHFnH9g2Eksnm7vrJoFDzHg667FntKU5MicJZ1Yb3PFhVnpjucrEXmTL57VnXM9Sp1qZyaT2n9687q7BpJ5vjK11tukP8C+5ivvyh3AH/JserP4Qg3lgk44658PfnoOQCcI7XndIOfo+wn7mc6uBxD71JukWX+wXMpEC6hjkb2y92XDlefrwpCfzZXv+lJt3L490lRiFy7EdQC79kSMobvwZyml732VCcZLgS+nGDW300yYlXhdHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5mBv3rGw7eVGx+tji+SH9AsIpOLpBSNS/vQkAjiqj8=;
 b=Z+huIJ7voNg7mRYszoxaXX8xO1H5zKg35ZsvQenNB7ZUyyI77/wAYmHJuqZRy6Fixwt5/6NNUcqW4zltyKNvsy0B1smneq5YKQ5LcNWbTluhikupHuYy8UKJ8CD80DLJ1AOqnt/sVlh+fLvtSi1I/iGsGWHwQjWEnn4SJbhOkEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB8564.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 11:57:13 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 11:57:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Apr 2026 12:57:13 +0100
Message-Id: <DHMWKCRVXZTE.3PQCUYLT930ZZ@garyguo.net>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] gpu: nova: require little endian
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>
X-Mailer: aerc 0.21.0
References: <20260407-fix-kconfig-v2-1-6b4fb06c690c@nvidia.com>
In-Reply-To: <20260407-fix-kconfig-v2-1-6b4fb06c690c@nvidia.com>
X-ClientProxiedBy: LO2P123CA0091.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 441b313f-71ac-4e29-a5b1-08de949cce9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|10070799003|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: DWejpYdJOsszmyN/JgXhfalqo+EkxXHM53Lw8NBo1g/FX8GCp8UyqGpC77Vyp3tnt+XFbNuD542E7qY04/wJ8CADVhXOOz2W8nd7jlFBBCTTYunZ8Qdg4lkwXol8kUL0e/5yoX6wwOAz5sytwonxFusfPXcpZWq27AMekzzU5UHs+PjexDxt1AL08HlbKvW8yYG5EAuLFqfFI27JyotrayvlYSRItPb0h3ErwV6098CtBZSHUZQlO0Jda2VwGd+5ffohjUqLAevdSDPrzR/9JUCtvznHWuZNPqtn6qN9hDkXJV2LHaUDpjAZXtNLcJftpTnfo497zhfUWDJK73703LNG4ndNBKJaJgwUktyvu4rmRD9YaOs7uX4HJJ+ZGZczLzl9k4/1nYZrhjzN29qg4guRbw2fVzKRyyHpsvURYJujq7iDWXtGhwtKBqnA6CbRaE/qlFV/hTPJvyBqKOQpgr98eNHzJW6iF/NlsxP5lOn+Cl9vhNSNM/JrbdzBDJOgFlSVjHjOdE2PEXXMXJhp2URKYDUtELmnyyy3eQRkK6PydwTyGIvgC2WQ3vPYEqEm/oe0Ue+4xGM1UhZQ/jArklpKYA6odac9zF9jsfcJijeLrh7vNYbqwjwYl6ZBhBsYTMy4tokhYmWiM5iudc1t7WXPv0dds7POALNMkZPttZIr8iW8aPoWogjDuRc1P9yU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTRJTE1MR0ZzZUhNbkhzdGxTVnVCWnFXOXl4YTJWU09EOXR2Zy9ObHd2L3FL?=
 =?utf-8?B?S3Uwd25XaVFUU2pMTlgzSEZwWldoa0J2WmFJNlNoWDZNSE0rRTFaNExPOUtK?=
 =?utf-8?B?QkorVWFvcFNMbWtVVnJnSGVqbWtQYU1XODVDRnBGSTZiemh0N1g3MGNLQ1gz?=
 =?utf-8?B?WUZ6b1NuNC9SWjNPRnlwTG80anNhS1d1dUdUSVA1YnBxK3Y2WUdDck1MSnFj?=
 =?utf-8?B?SjcyaE5uMzEwOHU0SEpybmNydXhsTFRKbkl4NEpZc2J4MFVyTWp2ZVpHNS9v?=
 =?utf-8?B?YnFwYU9aMWtUaXFvanUxa0tzK3EydWJlWC9YSW1MdXZqZlN1dkdBMXlXNWNG?=
 =?utf-8?B?blkxbC9aTVVYQTQ2RXh2MnBLZEdqSTNvYmZHdE1ybWlQazZtODRGeWV2RGh0?=
 =?utf-8?B?NUlTa2pEU044THdWWGhES1F3ZXppQmwxNmlETnN1U1o2Ukl6bDJrOWNOM3B1?=
 =?utf-8?B?RXlucEhzMnRCWHRjanhTUWlqd0RMemNzMUk2b0VaNjk5ckVBK2dyd3RNSUth?=
 =?utf-8?B?ZmZRakkwMFYyTDVHVThiVmNPOXh6S3I5S3hwK3RPa1NNMUQzTDFVeVVuL1lC?=
 =?utf-8?B?bXZ0bG1Dcnk5MTFVZENmRWs5MHFLTXJHbXRGM1NFY1NmN3B2ZmNQRlVORDFl?=
 =?utf-8?B?QkxONHBpMUMvTXMyVjVCSitRQlBzTzFhL1BuQitQelpKQmdSYXkrMGREY2FM?=
 =?utf-8?B?ZmlCUHpOQkkrNzJ1a0ZVOEFDeWFoaXVYcjF6OEVSNTVIRmxMb1VDMEFpemQ5?=
 =?utf-8?B?eEFMUG0xUVlIR08zdk0vWVdjYVAxQi96N1B6QTcxZUROeWVTc0VjZUhua1ZF?=
 =?utf-8?B?T0s2UlJOYk9yVk9wZ2hJVnBUb1FNY3EvUnF0a2o3dnlqTFlTZzdQbm5tZFV3?=
 =?utf-8?B?REhiMUNjclAvak5ZZUpjbXNoekZVRGVNNnMrMjVQWGZsSi8xVWdVRWFqZlVL?=
 =?utf-8?B?VkNpYmRxK2h5eFRyTCsrZkNCTW5vQU9mVDA0NTZUYUszTFVYQXBEK3QvUzhr?=
 =?utf-8?B?V0Vpbm9ab2cwc0paTG5TYkl2eXBCbDFLUXhhemdBYkx3ejRUSzNCcWhQYVBF?=
 =?utf-8?B?OTdFVFl5UnlUdGx2M0lZd2tOTXVzcUV6ZXVMUWtCUXNqNnhzUm13dG42OW5Y?=
 =?utf-8?B?M05TcGN3RFlMUU4yZmFwUWViNG80V2ExKzJGeXRkL3RXbUxSN2kvS1l2NWZR?=
 =?utf-8?B?Rmt1V0g4TlNBTGt4dFdvcXlSWGtneTBiY241RmVKS2M0UUl5OTlPYmR0OVBz?=
 =?utf-8?B?bFpUbWJhSHoyR1NicGJOOWIzY2pVK0hFLytyRS91VXJoWWJDaHE3QjJTUHBZ?=
 =?utf-8?B?WnFzUmpUVERrRiszRFhxSWVOZmdJMGw3b2Z5MlFmaW42Yng5ODlPbGsrc2tD?=
 =?utf-8?B?YmNac1BFM2ZWNHlZeFFpWGt1OXByMlNHME5kRm5GMnNUazkyNnpOdFJrY2Nq?=
 =?utf-8?B?QVdwK0EzOVJWY01TelVqekk1elg0NHJ5ZVFrUURBdk1YOW9xZ1NCd1hqa2po?=
 =?utf-8?B?TjhiZEVDUUxVNUp1UWNXNTFzSFNlRWttcmx6VmlqM1AvdGlhay90SWdPR2Zp?=
 =?utf-8?B?enFtZEtnd2JvUDBYYnN3bXQvSmwwMlB5VlQrWVp6djVlK0I5Y28rVEVaa3FX?=
 =?utf-8?B?RWFUSjhpV2ZkUUlDd1E4MjdWUm9zazdmZHg3bzN5L3hMRU5pdDBzOTNFQVY1?=
 =?utf-8?B?L1RyNmhyTG9XWU9ZUnU1KzIzTVZtNXVJMFQ3N1Z0aGVXcDRiNkVaNVFxbndD?=
 =?utf-8?B?Zk5ma3BBV01uVlZvTS82cG0ydkJDOXlCUEo5UlRvTWhhUHp6U3JSR3V4b2lP?=
 =?utf-8?B?M0JhankvOUtRMEE1aEttb29rdW1EMkVhbC9KZ2NPSXRleW5tU2pWRktaMW1o?=
 =?utf-8?B?Zi8wSTNqSWlNcy9WOCtyZ093WHFMOGZuTXJNN3lacERUcUFNWlRCVFpsWG9Z?=
 =?utf-8?B?SHdPaUh1WDVEdnBoaDNpbWg4K0U3Tnp1OTNSOWxTZll1cno4S0RpYjEvTDBp?=
 =?utf-8?B?TGRHM2ZxT1RKc2dBUG1nb0l0b295VXkvVnZnYlRJT0Z5d2FqS0VueGRjbXFZ?=
 =?utf-8?B?aEZ0OTFhWnd2Qi9PN1RwT0ZJZ0FhNEdHNW82RHJyT0FlNFo4UXh5Z0w5VDFD?=
 =?utf-8?B?bndnSnJWekRuK1NxcmcrNFlaNDNkbWFaQjR3V1hhV1NpVE9uWTI1dzFWaUhr?=
 =?utf-8?B?cnExZWhzcjdzZGV6OXBvVlFtMWtmN2Y0ZW1CazFsbFNyTFg4Rnh2dlJ3eUxt?=
 =?utf-8?B?WDRQOTdhS09lcEtZMDZkbTVIUmwvYlpaUGhPWjN1TVhQU0pSdkRZcFBGY241?=
 =?utf-8?B?T2ZRSG1BVmZxSDltb3RFQk9tRjhZQXBXKzloU0tVYUV1dVVSSlBrUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 441b313f-71ac-4e29-a5b1-08de949cce9d
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 11:57:13.5944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbaE90LndjEFHukcg+BwtLW8wUv7fstLxCdXxR9wPSM+7nWf2o+JQH5NYn+XGFMOfKddtgKcKDrBQ2STmTePHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB8564
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

On Tue Apr 7, 2026 at 4:59 AM BST, Eliot Courtney wrote:
> The driver already assumes little endian in a lot of locations. For
> example, all the code that reads RPCs out of the command queue just
> directly interprets the bytes.
>=20
> Make this explicit in Kconfig.
>=20
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> The current code assumes little endian in a bunch of places. I think we
> should either explicitly decide to be generic on endianness or explicitly
> decide not to - having some handling sprinkled around in various
> locations seems confusing to me.
>=20
> I believe that currently e.g. `RUST` transitively depends on
> !CPU_BIG_ENDIAN, so this is more about making the decision explicit for
> nova-core rather than fixing any kind of hole.
> ---
> Changes in v2:
> - Also add to nova-drm (Thanks Danilo)
> - Did not take Reviewed-by + Acked-by because commit changed
>   substantively
> - Link to v1: https://patch.msgid.link/20260406-fix-kconfig-v1-1-8f634499=
f7f0@nvidia.com
> ---
>  drivers/gpu/drm/nova/Kconfig  | 1 +
>  drivers/gpu/nova-core/Kconfig | 1 +
>  2 files changed, 2 insertions(+)

