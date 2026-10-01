Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C73CA5FC4
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 00:40:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB73B10E2C4;
	Thu,  1 Oct 2026 00:40:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="Ml/HvVGL";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020099.outbound.protection.outlook.com [52.101.195.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F187A10E2AC
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 00:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qi6m8F+Lskse9Xrr1zuRF7wDylFt0bT5pPXNAtyJ0b3eD/gN1V82yV4YyXXlb4v69FYu7S9cYySM9x9Oc8YCD76Up5Tu51W5BNI6pLHTl4qa+m67q0fxLY37C7VjarAmNhP4bnzc0AYSFRiQGVRG82/WO/+A5+oycuDKuT0OfDISD11+MuUJo3rFH/ARXp/uJe7kfpXxDLLm4ADEQzBV5M/iiuatGGbooiraJ7DN9fCRSCGS3ade9ASS9rqHzbUFCQCpPlfXuVsKIfASKdLuLmKHqDBVvxxu718fUQ+SyKXsCi31rzV6QdwXLMuWHgBAo2fzdw+R06wwmVJCvHi8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHKaxJITzelT+QKZaLLgxRZ2C43WrN2eUZ1c0NcZlGA=;
 b=TpvPqNCZEr/w5yaE+1XbqiWPVdHpE07OgDgyuXJmF8Lq0Ngq0kia51oDHFy6j29tlHJ5AMBcxAWYghpKth7H/RIigJtOqn7QL/zo0zExtjkx170lMuK5KkXM+7h/GuryMmAsXLihOwQ/CLNlKUXoOsqIPF1JZ0crjeufyb1X2dg+knjZpyaGdjTuxSOyvEBEyBliDkoyRP9fcyIiNZKDnIUKFislPSJYMrnXA3uu/jI1IxN9XfTeFRXVGrNjuJw6cvhccsxmbI3g80hDbNVGEvv3hrSfFKhcvFk8s1UEv2D1+Zs6tZRidSH7ko0UytrTg8sbBgG124H3DFJlr0qKfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHKaxJITzelT+QKZaLLgxRZ2C43WrN2eUZ1c0NcZlGA=;
 b=Ml/HvVGLVf6yqBaa+E80cwcRhcyehkHWF0yT1mUqCXWLCzmd415QIv3xWco0g0Gx0k9wulEWIfdzUmWOJK3QrxUsnqQXOPfODqX3qF192wHN7rZra72xWXZy8MF1tNwR4iY8ETI+kvFq5eafiJJ8ahLv7eEL++wNPv+9f6UjIl8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO3P265MB2155.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:105::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 00:40:44 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.024; Thu, 1 Oct 2026
 00:40:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 01:40:43 +0100
Message-Id: <DLT30TMEHB4P.3PX7HPU1C6UDR@garyguo.net>
Subject: Re: [PATCH v9 3/9] rust: sizes: add sub-1K size constants
From: "Gary Guo" <gary@garyguo.net>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Burak Emir" <burak.emir@gmail.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.22.0
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
 <20260930-chid-v9-3-0d6cca376cff@nvidia.com>
 <CANiq72kcqVfvVj_b7KTHKrCDj63LMKpsfP30zafoYB8c924i2Q@mail.gmail.com>
 <DLSLNL9HDUKM.HN7Z0MACZZSB@nvidia.com>
 <CANiq72n5jjW8U9VkYJZYFpL9Z5rPe=nRfs3DqmUdfxCW39oMgQ@mail.gmail.com>
In-Reply-To: <CANiq72n5jjW8U9VkYJZYFpL9Z5rPe=nRfs3DqmUdfxCW39oMgQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0563.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::11) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO3P265MB2155:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f53e1c-3625-4dee-58f0-08df1f54a0a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|7416014|23010399003|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vm+OmJSZuKSZuoNNRByJANbCRlNwBg5iL2F5aUSo15CPJuZkNwDpsvkQOvDhygGyRb8rDjKTEKqXjuIPGr+B9BwfYrHB1HHPfeGW1ZTD1GSnLvK6fyJL3G8CS2vBxf7pzNjVaUO2SbaHpQcJKwRDDRPiNH3uFYKJu6ZBykNF+g/KUdrR7nTdwvyO1nGKXlvVBi/gwo5t6Y8e9riCxA0H6rVha1bffLPUD8R5EFhnR2Q1/ChL0KrY60XE5YlC3RUXSp5lpbTdCjwm5AEDfF2zl6NOiGqUUu6ijYTRxLj268UjylEvF94SuzHIO1DWXXr5g1Ky5OyALti7pbY6YZYamIw2v2U3+w+PmRfMkzK5UF0wYiU19N6SnQv8WfwswttRBnFSdgY9KoPCNaOttRvV00zHrS9XwRnxAcacosNO8JuT0DttLh/RncvTbjPxxMUh0G614oKn0m32b+ZOP2cO7ZNM7qPARsxkK9KH3hxyOe2dD1jNyEPSrlQ06lQjck5ZBaqtoBfPZyvvRgRC6hOeyq1PHUPq7gfCB2elL9XTBEk6sUp+vZWZqBQgXXwfcdC6WcS78Xk1SE+r5uvWDHvZ0E0vy9gpvFoDjID6S1QFXceiBnm00tVpi+zz4BZj9GRYf8lYN7+rJ72l+ESftP0L8f3sShC9by1TZxA1gu58tRU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(7416014)(23010399003)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzBXRmNwTzAwOXhRUkRhR1FIVUphak9URVhUWmRhUzBRa2hpcXQ2UlFpQW5G?=
 =?utf-8?B?Mm8zUmFVYjVmeVlVeHBFUWlrTENIcnlPdk45TldlMnZrU3ZjYksxN1F2eTQ4?=
 =?utf-8?B?WWpyZ0dZbmVkMjdGN1lmbzFOVjFhVXd6OUVUamVPZXZMUTMxUTNMdHc5VjBT?=
 =?utf-8?B?cXluWlJwakN1UHRLWWd2ajExZXBqekUwa3dLWFlNWXJOczlFQlhZMU41emoz?=
 =?utf-8?B?Y204dEI3REp1ODZOakZIdE1hQzQ1N2wxK202d0hxaldmNTRaUnVreEV1TVRM?=
 =?utf-8?B?OWs1RzVCS0tBTFkvZWNPU0ZLSFQvWmw2ekJCem11QWxTQy9EdUxTRERUZ2N0?=
 =?utf-8?B?aGdsMUdsSEkyN1pTcnh0UTNJK1VsMzhPNE84b2tqU0pqOHIybSs3WndCdW4w?=
 =?utf-8?B?NHNPc0ZlT0ZSdmR6UlhZY0RRTHBKNFBVNk1BeXJtbnBOd3VPTGc0VHpEcUFO?=
 =?utf-8?B?d3ZZaUNJWVFjdXA1cnhMazFsS3VmRUhJMFNPUkFwbG5BUC9lSllGWVdOZFdn?=
 =?utf-8?B?aWR4QzdIamcyRjRhUWlnM0FDNUo3Z1h2bnR2OWRZaEx2d1haUE5OVlAvbG5x?=
 =?utf-8?B?SVk1KzRzQko3Tm8zakxBdUduY0FrOFVzMldJZkxpcUhNRjdlaTZPUXBCVEtv?=
 =?utf-8?B?bEQvamM1Qk1leDFzMU1wOUFoeGxEdWZYMS9JakJsNnBxRlFWWUlsTmRUVDNU?=
 =?utf-8?B?U3BBTVFNMWtYT0g4M01jb3dISGRVZWpRWHlDUTh6NHJmUDV3SThzYmtxM2kz?=
 =?utf-8?B?alRSLzFySVpBYnE4aDBYdEhZUHplZmtKZ0hGUC9SUzI3TkpDeWpkMGcxajc2?=
 =?utf-8?B?ODV3bm13cXFud2pRcWlTMjIrbmhXUGpidVdidytZVUlTK3hrUVJGcEVmcnQ1?=
 =?utf-8?B?ZThCVGhuSjlIcVBmSWl5NGV2ZTZiNXVMbkxLSEdEbUQ0cm9RQ2VWZU1QZ2ov?=
 =?utf-8?B?TFRINmZIVnJDQ0xtNE0yWUE0SGJIcXVjbEFmZW1ZL1hFSVlaL3grMEh6Ui9i?=
 =?utf-8?B?RHlUNkxYK0dOZ0k4ZUN2VVpNYmxPNExaZkJCdDAyZ1ArcnY3b0tqWWNIY05W?=
 =?utf-8?B?NVFaK3JJamhNVDVWdnhuRHNGTXdFWGdZRElqWEZjVk4wMjBFWDU5VFpVVW9T?=
 =?utf-8?B?b0xOL1FZZm9GcFJiTCt1bDArY0FmOElYbW1mUnRLV1pHK2tNeTcrM2NCTW5m?=
 =?utf-8?B?QitiSU8yV1RJUkpHUmVKZ1RCVHR5aUE3UmVtK2oxUDBlU3FCcVA4S2gzbUFO?=
 =?utf-8?B?Q0lTd0MrTFVnN3hKR1VaazBBYnc5a0lPNkpYL0VGei81UmZjZURvMlU3UG1I?=
 =?utf-8?B?KzY2WG9uV1dtNDB4NVQ5Z1VTUmtFRVJhcy9xekxGYlVod0FhTWZQazd2ZEV1?=
 =?utf-8?B?TFdGWGlraldoWlNiRW00K3pUdzgwZ05KUGNrU1NFU2VLZ05jTXFrNG16bTRu?=
 =?utf-8?B?c3QzTUE5TXo3NDhkSW85ekRRU3Z4RlZ6NjRDTHhwc1pCcExzSXhYTFVoVndK?=
 =?utf-8?B?TUpldUZWUEROUVBEbVV2WGZkYXIxbVcyTnpCenVPc0Zvc3haNXZsRy9xbUtM?=
 =?utf-8?B?eWxJRUtIWFFueVRFZng2dGxib2JhYUtNUGFJUHFNRkpzUit5cXFtYWtDVUFx?=
 =?utf-8?B?V0IyclR1OThCNnBGRWtoN25zQUk3Z3h2bUFUcTk1TEQ0K0pMcXNSakpLUnMy?=
 =?utf-8?B?VFJlKzA1SFdZYUdOblRhSTFia3FRbnJoYnNsOFpINTVLbzZjMEFRVUVocXcy?=
 =?utf-8?B?OHU5RmpYbHZBcS9QdkVhUWJ3WDhMeEh5Sk0wc0I5RTgwc01qbkVVNlRTZ3No?=
 =?utf-8?B?ZTE5bGhpdWFQaTU5SkdRblZWWkt0WnUzL0lZdlhSVFRxb2RrUGtxZFlqamZ0?=
 =?utf-8?B?MlNXUXpDMTlxRHRhMlVXOWpQOVg4NHpXelhLZGJLUHdaRGErbDVldEdhVzVW?=
 =?utf-8?B?MnN2Z3dDaFd6UkhLU2F4NGx0a0I3c1BxK1BrSmhKVFFlR2haWnVpZW1pQU9M?=
 =?utf-8?B?SGxZblNpVndjZDBhbkh3R1Y3VERBeUY3VW1XdnIwVmE5V0JJeWZPRVphVmdD?=
 =?utf-8?B?WnYwd2NjTTQrVS9XZjJvaU0vV3hmZGhJWUEwTjZpeHNVRkw4QU1SbnZHQWNt?=
 =?utf-8?B?R3R1RlJMKzF2NU1mYkhTY3lUYUd4SWRIZTYxMEhTMzlYZVhpZ3pYY25UaTBS?=
 =?utf-8?B?bUJjMzMvd1czRXg3Z3g1ZTFlOGF0aVFOSktVK21XRkhzdnZsZzVONnBUZm15?=
 =?utf-8?B?T3QvSy81SDNDSTJyY1NIZ1M5RTl2cnA4dG1rRkpXNjM4aUVTdGVFblVpMUgz?=
 =?utf-8?B?U0ZlWk9DNnRvVVF0V0pvbEtrSVNRbWRYODB4T0dTUXZUVUZhNmdkZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f53e1c-3625-4dee-58f0-08df1f54a0a3
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 00:40:44.3260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hI1TWByCvJcSe7IvPXr91uN9xLEFdVOwBXbNBJU6Qk25hFmxGk6QABtWaWBsz4SJip6WuzjiJIilfO/r3x2edA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB2155
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

On Wed Sep 30, 2026 at 12:22 PM BST, Miguel Ojeda wrote:
> On Wed, Sep 30, 2026 at 1:04=E2=80=AFPM Alexandre Courbot <acourbot@nvidi=
a.com> wrote:
>>
>> I am considering picking the series through DRM, but it also has a
>> dependency on the `cv!` macro [1].
>>
>> Is this ok if we take the patch introducing `cv!` through DRM as well?
>>
>> [1] https://lore.kernel.org/all/20260917-cv-v4-1-547ef5727451@nvidia.com=
/
>
> I asked Gary yesterday if there was any more recent discussion on the
> tag thing from v3. Does anyone want to do some cleanups this cycle
> through rust-next with `cv!`?

Given close proximity to LPC probably not.

Best,
Gary

