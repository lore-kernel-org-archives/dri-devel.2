Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF717C79F99
	for <dri-devel@archiver.kernel.org>; Sun,  6 Sep 2026 12:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D55ED10E3B4;
	Sun,  6 Sep 2026 12:47:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="M9rK7u+j";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022097.outbound.protection.outlook.com [52.101.101.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D650910E3B4
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 12:47:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sk7OLRmLAWBYyfVnimqJt5s1fummg7XNBN/gcYheuRDpFMBeM6wFYLemwXf+gGiznCMO/Vqd42C9Pj4uIbZT/zO+dVN40+0nxoma1wDlSlr/luChz+BCcSmDPqBAVZX6tJEQyg6gHN9zHUYFbkby8lNgnFZhtsgdW9Tj+eW8j6iFgLzpV15nw4JHR9PVm9WqLKa+GnZFKa/BeMLgNe5DXYeQXWrtkMfpis24rXQTCh2czHxjAvLjGl0ocTzSBd9DZLNJX6UlaOkq/6icdHUiBs08vSFjT57gQlASSygBYwTrf47hg+apiU0EviHqM1rSBta5qo1ZXVwI545FS5txJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ArJ/NwlKm5x3Wt4gtCx0trr8O6gWjwg7f6vKNrg66U=;
 b=sx2AuA1IihNhBcvpDZFPj6sRKvlkL43OWef0VlPlafDdHQOPGpv1Qtq6X0JFcX4xekpKUdBPcfBVdUyfhds2zGqFmPLlMd/bj3xepdPfEt+HWr6ginsFO/KX1kIkPRz+TIpp8e0KN1Jjhstn2Zf2v6KNVHBHfXks+Ia9PtPy5bqAcfi4nJJ0qu11igEDvraDVDyH2WrdsGDpLhj2ml6B859wXhOlfvnmBwKyqwFzVZyNuXtExIdkI3YZo7w2DHliCJxarBxIWi1Asm74P5i97caThi/XeeLr3mSqu+MW+ATZcgv3tb5kDAccdpEgUbPSoHS0VJar7v7KIMvX6ZRIvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ArJ/NwlKm5x3Wt4gtCx0trr8O6gWjwg7f6vKNrg66U=;
 b=M9rK7u+juZbyU9iu6NegEd7l23MWkhh8o+ki/KhOxHzATE1W1zJhujZ3XutHf0H1589NNABOr/dpYLi2H7C72oINZOwls4wtqBpL+i3ADYTHJLXKg7QiYIynKLhuqiasI5FWHy6+4NwFYKkfUUjDmfrtQjMHJHLkjAaM/oGrlHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB2699.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:14b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 12:47:43 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 12:47:43 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Sep 2026 13:47:43 +0100
Message-Id: <DL88TTRAVPIC.2ZQNHJ07179CK@garyguo.net>
Subject: Re: [PATCH 3/9] rust: sync: arc: relax `ForeignOwnable` for `Arc<T>`
From: "Gary Guo" <gary@garyguo.net>
To: <sunke@kylinos.cn>, <rust-for-linux@vger.kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Lyude Paul"
 <lyude@redhat.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <dri-devel@lists.freedesktop.org>, "Alvin Sun" <alvin.sun@linux.dev>
X-Mailer: aerc 0.22.0
References: <20260902-tyr-ioctls-v1-0-e0fdbf8bd108@kylinos.cn>
 <20260902-tyr-ioctls-v1-3-e0fdbf8bd108@kylinos.cn>
In-Reply-To: <20260902-tyr-ioctls-v1-3-e0fdbf8bd108@kylinos.cn>
X-ClientProxiedBy: LO2P265CA0491.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::16) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB2699:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e51db0-f983-4630-4ed3-08df0c150b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|10070799003|376014|1800799024|23010399003|366016|4143699003|56012099006|6133799003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: UYsYKQ/Z+5lmnx7e1jnR/VVA3v9Q2/fT/8zOzfIZwZ7x3SNKotIrEMyMJ7BXuwduo14INQo9J2sB3bOJUQcSbD891wBfamd67ss+eGg3fOhQrVte+gUdNO+kbE+E0M0F2J7bb2EtUtT5kVs5cwYkwqEsr6zbtnVo27v4U+wG9Rxo0UNLptJBOyHIfnh5qmkRB9ohSBs9ETuBAvilZFpjrfkKtmzt3PmFi59IXk1+tA/0cK6LPTYFSBZdQW/uQaB04XfBvm6KyIlNYavKkr7QzydlcLw4BcG9q1MPscNyBGhQuHmYxqZ595Al2vxYqmnF2kZ5Xl2YGZR5bLbG3VnxbYcSChSJMkdWkMKjxk+oVgqAl7nZeel4nomXjbOzSL/HWXtS8OoZoUepxIgKlC2R+mPYaoQ8W6lWW6DOvuuaeBMymrKpLlUzVEfjnejiSkLh8oDbEmtHQa838zTBHZgymJFTuKNxY9c84kYYlHW0RRDMbPLOP6V6dmARHn5YhnQfqPHwdDTgCwcRGJilxnoW/1M+YH6rQ0Q/c0z/R1wn7svtAJ4P4M9tSOlasBZQXg7VySfkvxokA5DrkFuTzquj/CvGYluBNGL1d/Lz3SzzlVEeFO+6uAEmQ2NriDw2/aZPhF/2MF7Z+UY5ysft5v1yJAG/jKyCZlt20fPZeXp1s+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(10070799003)(376014)(1800799024)(23010399003)(366016)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjdKN2tEK2lnMU9ZcjViR016RnFlTnQ2SjM3VXpUUlNVOVA0Zll1WEV1NXR3?=
 =?utf-8?B?OFJWWmFMWW9jdzk4K2dBbk5PNUY3ZjEvclNWUmh1NWVyRTJTZ0ZWbllkWHNv?=
 =?utf-8?B?T3FDL2tFbnk2NG9KWTdCTW1DdUtFTE1xbTdWY0RvQ1ZiOVRZUlkxamNLam1a?=
 =?utf-8?B?M0svUDRkMzRBVXZ2Qm9GVmdDeXR0ZVN1aldDNFhPTGkycU91QlZTUnA5RjN6?=
 =?utf-8?B?TXBBOGEzcnRicjV5dUpkdXlnQm9lUHJaZG41Wkd0VlRjMVk1ajlJdERMamV4?=
 =?utf-8?B?WDFuRFZYRitCdldGUlY0SU5nTUZ1VytzaU5YSGZkUzlTMGR0V2lmeUJWeHNi?=
 =?utf-8?B?VTRlVEVVVVI3cURiVFZYMytjNWR0VW1lZURoNE9rdlNHMVNneEJ5WVpVc2tt?=
 =?utf-8?B?bmFmbjZ6SjV6UHZPYUJYRWY5bnVUMmZYSjIvOUQxZHdLOTRmQWwya0ViNlk4?=
 =?utf-8?B?Nmp1MHZubk50cDY4TlpodXNRWEE1NnFZek5ZNXlsTSs4QXI0V0x5bFFxcURO?=
 =?utf-8?B?ZmJISUxTTnBhczNsSVU1NndCaW9QL3AvajRyRHFXcDl3MlJWbkpHaUVaakNx?=
 =?utf-8?B?TjEwL01Jall6VkNoWlQxVEliK0VaZUJ0RjlVckdyL1hiUEpwaXFiSzU0UEVG?=
 =?utf-8?B?V1B2RXVuRDUzMnFYSkxWVXhJV0NNbDYvUkxmN3p3aGZiOExRTkNudmZTYTlj?=
 =?utf-8?B?RC8yN1h0V2U5OGlGQlZjendnYmphc3VVenl4OFFya3lLdDZidER0UWNrWmxE?=
 =?utf-8?B?RWNmV3l6WXlBaERUVy93T0NidkJKOVl6eTdCUjRHTUY0a25tcEFMenZ3MmJa?=
 =?utf-8?B?RDYzcEduMW9yN2hmY2YwUjZQY1hZUVNSR3llSmN1bEZFd3Yxbyt3UmFTUHhy?=
 =?utf-8?B?V21VY3VEejQzOTFYR21xTGcwdGYycy94ZzRhSFFKRFF6Q0dRSTNCdEQxVzU1?=
 =?utf-8?B?M3NkWGRvcGZnRXdrUVMyWW9DMlZZNUkwaW90VEIyakRHaENmSVVYKytudm9L?=
 =?utf-8?B?eHZVRzlnNVg4azFrcVNOOFhOdmtiQ1BCTzJFbmRLSGM1VlZvR2RtbFNobUJT?=
 =?utf-8?B?WDhYY0RwemFEUURLUmVFWEoydmNGYXUxU1dwVzY3amdlZHhPdHR0ejhEWUx6?=
 =?utf-8?B?Q2R5aXRQK1lSMy9ZbFVSdUtYbUhBUlg5Q3ZyZDVlTG1mWFM1TzNEOUZTR0xM?=
 =?utf-8?B?OEJmWHRXUVYxVi9BdjB3c1Rkb042YTZ0eHBNQjV3bHQydDNVSEpKbHM3cHVs?=
 =?utf-8?B?UmlNRTdZb3E0NG5MZnVsY2pOc3Z0YU5pdE9WRXRpckdlOVFDcWpESFpHK3ZD?=
 =?utf-8?B?Y0FudTRsM3N2L21kT2JxU0Y1L2R3dHpvY0lqbkpRQ2h3aDBzMmhMQUw3Lytm?=
 =?utf-8?B?RU9xMGFpZDRHS2VxOFBKWWN5b2ZmTlZTd3BiZDVFMk4ycElPSmFPWW1yTytG?=
 =?utf-8?B?OHZWVFZtVGF3eVB0NkVTS05UaUVWUUtONWxjL00wOTlpVzAxaVJoa21HRXVp?=
 =?utf-8?B?aENqTkx1c3ZDb29RMy92Mi9UZzFYK1F1cjQyVHJSeGRGLzhCbHhsVmVZNUhO?=
 =?utf-8?B?MmFMbG1xZGZhMTJJcHd0OEYwUmoyTTRrM09OV0lBK0U3aWI3aFRUVUFqOEhC?=
 =?utf-8?B?Z2VFSjNGcWVkMHhuOVdZSG5GRTBkQXo4MVJOVVAxbCtCT2VNK2ZnTmZ4dW1L?=
 =?utf-8?B?bGovaFRLNW9lSDlwZEdaNjdFOThTR1FMVm04N2ViY090UGNNK21oNU15Yk9a?=
 =?utf-8?B?dFZ6ajdIay9sdjgxaFRVRVQ4YjU3RzFPU2FHY0FFZ2d5K3M1YlZySnM0Q2Jo?=
 =?utf-8?B?eXdFVVp1TDFFd3VqdDgydmtKZFZJMkh2alMwY29vbHN2V01vT29JWG5TSDRY?=
 =?utf-8?B?NVNnZmFPbnRJVDBPWW55MEkzQWhVays1SmZDbSt4a1MrSmJBV0g1Vmk1dllI?=
 =?utf-8?B?aUd4YXJ6cmVvZXl5VG5sb1RvNjJsU2JTRUlDKzlHNC81VkN2YVlnbHREelRn?=
 =?utf-8?B?b2VNMmVBR1J5SFRPdDZEUERsOVJubUVCS0tDaDJNN2hUL3FUMkhQUGtqR1Vu?=
 =?utf-8?B?OGRyV1dFRDgrcW95eEFPR3VRZFZLOUtmSmk2NytRRC9GV2ZMWlJzMWlvTTdu?=
 =?utf-8?B?ZmhVSkNNNk5yT0R3dUxMeUQwQUlUb21jbVhNdVZsSHZaVVVDM3g3eTJyK2hT?=
 =?utf-8?B?OFZtUGZCaGsvYU1TWGFwZWhOamxMVU5keXIxeW9iMUtnaWNzSHphZ3ZWOUND?=
 =?utf-8?B?d1RLNU5rR0Y5UmppWVU0UHp0d0c0NEh4T1R2NTlhU0FQUVRoU3JjQVBCdlhB?=
 =?utf-8?B?blh6OTg0T1BmRkROdUFma3RSMGtGdG1oQTZXektSRjJtS2lNbGtvQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e51db0-f983-4630-4ed3-08df0c150b96
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 12:47:43.8729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z151AyWCLS2gEaOqHudgL6HrFdADZTaSIt7gVxU+khYvBUZQZZ5QIoyWHOU/wEzfpmpABi3tqg4w1j0l8Wtvow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB2699
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

On Tue Sep 1, 2026 at 5:09 PM BST, Ke Sun via B4 Relay wrote:
> From: Alvin Sun <alvin.sun@linux.dev>
>=20
> Drop the `'static` bound so that refcounted values borrowing from a
> driver registration scope can be foreign-owned by the XArray
> abstraction.
>=20
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/arc.rs | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

