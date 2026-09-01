Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF1CC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 11:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A1810ECA1;
	Tue,  1 Sep 2026 11:50:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="dutT+lrH";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022072.outbound.protection.outlook.com [52.101.96.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99AB610ECA1
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 11:50:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGDQQ7Rra5nzWI24l0TXXyhsJ3lnmyW+Whn3HKW0luzDUzHThuyaL6rtk13RMj422x3vU2OtOCXWJrLgI+2yFdct3eDDHS2iJyd4pTY1XcprSx1R1tIzEGtPKJ+8PD9atQJideijw1GQzj8DPZW9XSbiZOUp8ZNZmFoBhr7iZ+Hq+cwByZFCUDiGIRTYv5y+zBYnskBZ4CvHxmY479BbaoJ9jaL25PKb1+aXS4tacnIHmXZyyQFJ/oag8ryQ1srXrnCJIbglRi+oA/usXhjekcsx8BlkFOL2ujD/mD5DzrzCWdeCFUVFQxnTu2AyWtVW2AEKVxmW1MvshNmP4oweHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bku2Mjz/K40d0ckvnAxnBq6+fEdquOoNz2vSXKzDgXI=;
 b=cf7aTa5Qwv53nOIeb/ZVWlsHYDmrNY8WO0zlL5LKfZYjpxu744iVZ/Ju1I4xjdzgxm75XcUGkHTha5ewQcFaWVnwZAdjNby+HmAaNYa5q1W3GBkucTGhswTRC4n5jmA5q1czRNjatHPLpTUBDsB7F2pflHWfDYPBuBrQtD3mH+MiDaw0pAg4aq3J3IpuTlyzzgK3Dz+C/NHw4oAwKB5cgU8Lde5eckWLc4hL3JA0h/AdViasHKaDaeXVDDfVq0WY/kS9Dt0eSk3Kg+mUOIND+XTwOWiyfo83YfiNhQitNGOqG9SWRkZcBStBuOLxSEIPEacDC+Z/D1D6KmMOIMgSnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bku2Mjz/K40d0ckvnAxnBq6+fEdquOoNz2vSXKzDgXI=;
 b=dutT+lrHqyUWomCq8Yn75ERb7UjZ2VG8/rmAdW9P+5m29It7cPeDEF9vHgD6Os5vNoECWwwrFOrvkPuIrofIUFvNlMJf/qidq1sdxIZRs4vQKfmmbF3DD/YX/tknPe3CTMgSyzZdlUkJ1vguOUawqMkDjTGR6CV+3jmCkyX3gV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO2P265MB2525.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:12f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 11:50:40 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 11:50:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 12:50:38 +0100
Message-Id: <DL3YHEOVTPTX.3LTWSZ05GAFAG@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 2/3] rust: prelude: add `num::cv`
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260901-cv-v2-0-446bc69d2ade@nvidia.com>
 <20260901-cv-v2-2-446bc69d2ade@nvidia.com>
In-Reply-To: <20260901-cv-v2-2-446bc69d2ade@nvidia.com>
X-ClientProxiedBy: LO4P123CA0476.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::13) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO2P265MB2525:EE_
X-MS-Office365-Filtering-Correlation-Id: b727210b-ff48-4ae8-7b3a-08df081f3e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|23010399003|376014|7416014|22082099003|18002099003|56012099006|4143699003|10067099003|921020;
X-Microsoft-Antispam-Message-Info: R4j7bybApCd2Zl2RyI3zh+JxATVndqeYG/0H33azR0i9St1/kk0QJB93noctQBbum0z2ElOaV5ACEJgFq/sUuwjBvLMASFJaWb8qzNk92BXBFuY+yjeRmUHdlMZ2DaSJ0a09JczmR9779PFrB6P9HkLB94bdjnCaB95u+XD0ZWGqKX3+D2Td2wvkTPMqPTvwrn3iu7OChJn8DxMTnfzRIWq/UmaHS78hsIBw0PZo0tFwYNk9s0WTG5Dyy+inG5iddVe4jLEihIi76Ckpnf+EJ0cUxkN6OHyus+P4kKDKwPuVwbTY3sokLyLVta9setAF2uY4EH0d3Zu4eI2ZIuOSq3lwPAmDZovBiiw+InW8wNsLML81jQ0J0w67i0BORzL9fNWX65ncinXUaY+TFYrmyJ6u71dR5RVN5sw1t0mWKaFuOswaJXk/FnWZ/tn/ZKeMjX6uP1xMbQB1X1FUeZLFCeoFHkvJ/EtcWkrE/h5aO6STwFnFa0awGsBDPpUNh7scZdrdENbkBQ4eQdhgaZpFnlNE6eL8hblPVOxr+4jGHD3+8uxKtU2QcGzSaDi10MVUrfaRNTpWYUY+HLSNAljfNwCnYdUwtKwrUWUg+Z5TtFpGH1DZiJyZNjEJQvj8sq4T6BM9I48vTAaNu3LjOnD4csUb+5Za08NAmdHKgHvi9CtM7iEFsW9Qs0Br5ZZ8aKT2ign29SB7pqU2fCc4c8efog==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHZBWFdINTdQeVBoaEpLNEQ1d0E3MzBDKzJmSDBubmF1MldmbEVJZ0JtRFZt?=
 =?utf-8?B?dWMwRmxQbkhpaGRHeE4vUklSQktoT29jRmF2bGUyN0VURklEVTV1SEozalJF?=
 =?utf-8?B?ZGFoSU5vc3ZjaWxpV0RUS2t5Y0xHVEJsWHplcWNLN2taZE1tN25KUkNaRWdC?=
 =?utf-8?B?R3g4Y1VZUTZEVERjZWozemdQZnc5RFFQY0xiaTQ1S2xsVWVzMWhDMXA2aTR4?=
 =?utf-8?B?TVZ6Qk1sL2U0WVAwNXY3Rjl4S29RNldud2ltWU5RdFVFV2JQMXp3YXFKbVBC?=
 =?utf-8?B?L2hCT2hkNnY4elBkTlBvZTM5KzA0R2ZPaytYZ3VPakxWa1ZKRFRINFk2Lzlk?=
 =?utf-8?B?RG5UVzc0YkNtbU5vdmpWUmNMZmNqOFNyYlo2ZzgvaVo5V3U0WmROd1p3Unpw?=
 =?utf-8?B?UnpzeEI1NGhjd2oxbldRaEhDTnNqb1p2N1NyQWNlMWgrK2dIeTdRMHlMSGVu?=
 =?utf-8?B?UE40dExJbGNqZUFlZmppVVRDMEtSaVhWcENObFlVaWUrOEZIbFJXc0g4b3BP?=
 =?utf-8?B?clQrZmJhMVVhRFhPcFF0dnc3RVlYUnBvQmh5SHppOFlab1IrL21WaWNSV21a?=
 =?utf-8?B?ZU9CTVZ3ZmRLRFl4QWYrVVVpSHhWczhCdmo5USt5VUtjZ1MwYnYxSFJWeFZS?=
 =?utf-8?B?UGRzbW5nVlE1QUpmbHlKYmZjWXpwTXN3dEdBdUZHRUhVVldjWExwVmsyaWFx?=
 =?utf-8?B?aVZ1QTNRS1hWdE1IdjdIYk1WSjNWM0c0TWJWWVZ6Q2tMZ1FlYjE4eGR3L2lk?=
 =?utf-8?B?ajh6MTBNbStGZXZ1c3BPUDNCN1RYVjhQNmJpanVIZmZLMDZsamsrRmRlWVZz?=
 =?utf-8?B?UHlHWmtMemxMVC84Y3Q3eE9pTTAvTTNmZFlFSWxLNHd1R1JpbVIydEdqdCtY?=
 =?utf-8?B?M0NMaHpBUTQzRkZwNldqYS9lUldpUUcrakJnWDJET0FHaDY0TUpCc25kSExy?=
 =?utf-8?B?cDVrMlNwMWcyZXRISHZObEp6cHFmM3IzMVRSNlFaT0VPNWcwSllLam1QY082?=
 =?utf-8?B?bHYzVk9QTXhTQTJ1OTJYdFp1SDBNTjcyWllqKzVKT3JTbXFpc1ZEK1ltak1s?=
 =?utf-8?B?MDJNSGp0Yk8vQmw0WXA5TUxUM3VZRlEreEVrZzdlWlRYN3VIZ3d3bHZuSkg2?=
 =?utf-8?B?d0NkS2ttZ3BYYWRUUDk4ckNxY2EyVDU5Q2Rrc3BBTHdlT3pDaExRTytGQ29r?=
 =?utf-8?B?YzI4M3UxaDdGTFZ4clJHOTlwN2pQdXlYczR1dFVhVjZvemhkWWl1Q1ZUaDZ5?=
 =?utf-8?B?VVE1Y2M1YWdQeElrN0NaQjI1UzQrZ0pFTVNUQTJqVmR6WW1XL21ha0tLZ3Bu?=
 =?utf-8?B?NEZHTWZTUWpUblc2eFhmcGhES29LM25hRi91dG90UWk2TStIWFBDYWtvSkYx?=
 =?utf-8?B?WTBmTTluOTB2SmFPeGJ5bWRKelJhSElDV1JsYXM0Tm41b2t5TnFtRTU5ZS8x?=
 =?utf-8?B?bUdQNFJwTzNRVEd4R2hhU3VjWlVpMnVGdzZSNTdLcWhvM2kydjhGeVJuZGFW?=
 =?utf-8?B?RFpIR2xCOUhwMWZSWDJkVlRZRGNLQlp6Qk9PZTdBc2gzZmRQN054Zk9MSDRF?=
 =?utf-8?B?UUFMTWdvLzY0bktQWm1aN25laFNtYlRubWxwYllGb1NkbWs2TmZ5bzhvOWVt?=
 =?utf-8?B?Zk50OTR5dDE0TkQ1b0xEZFZxRWdESUhxQytld1lNT2NveHRIVEF1c2VRTlVh?=
 =?utf-8?B?S1F2Yzg2dnB1QlJRTktrT3NQWkNIZzQ2OFNEL0ZlNzhBOGZMazlZQTFiRWVm?=
 =?utf-8?B?eXJsTU05TFBaVmIrTFMxMEx4TGVCYWxyaEtEY2tLajkvV29kdUxnL1crRitV?=
 =?utf-8?B?REt5MUVwQUZzSXp4L25KT1hSdUZiMEdlMmtrQ0ZsWnNET2dEUVpVcmk1OWps?=
 =?utf-8?B?dFNtODdwcGN6cFFZaUNvVXhWbmY5aktrdWdSMzJ4ZG5maVdDUlprWDRJUnJF?=
 =?utf-8?B?Syt2N3NUaEpkeWV1eFcvai9Eb2FnaDV5d0wwaUg0eDNXSkRUOUxpSjRvZnFT?=
 =?utf-8?B?ejF6eldtc1VFYjlGN2hsQVMzdEovUnJvVXBzeFYvK3hwNCsrelVDTjJRU1oy?=
 =?utf-8?B?SjZSdngvZVV4d2Zlci9jUHRGWStDcmQ3WGlLZWZEMU9Oa094OU15dFFhREND?=
 =?utf-8?B?ajB3TndXSTJoR1NOd3dRckpXSGhjMGtRamJBMVk4Q3lKZVp6aGhVZ2x1Mmhz?=
 =?utf-8?B?aEc0cVUyU0JIcHRJSFBSOVQrK2Q4WlJMWXlsaWdsWS8vUWVGc3ArNlBMYmZM?=
 =?utf-8?B?T1QxVmNldjB5dmY1bXpQY3l2cmkrZUhlcXdkdWZkd0g2c2hhSnAzN1ZpaEpB?=
 =?utf-8?B?MDViNklrdHIwaExkdU1taGhoSjROdjRLLzk1LzJaZldKaUF2RHZoQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b727210b-ff48-4ae8-7b3a-08df081f3e96
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 11:50:39.8005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlbc1aZjeGRACNUxA/fcgqRRCdCBp3DC6Md2F+UZRwNQYjp3u24eDV6c6yehrQp/i5MFaDhnABnekV/h/xHRVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2525
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

On Tue Sep 1, 2026 at 6:06 AM BST, Eliot Courtney wrote:
> Add the `cv!` macro to the prelude so it doesn't need to be imported
> explicitly to use it.
>=20
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/num.rs     | 1 -
>  rust/kernel/prelude.rs | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)

