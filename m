Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF4EC79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:51:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAA2B10ED9C;
	Tue,  8 Sep 2026 20:50:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="t1i3lBxT";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022102.outbound.protection.outlook.com [52.101.101.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2307010ED9C;
 Tue,  8 Sep 2026 20:50:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8rDCnwNab9OcuGR9hVMSYKw0qe6nCfolCUPQsqX2+Xb15S+S3iEdMXog8izrCd73jWUfKFW3WHGVBeZ6w1lAB7H1UON6eX0BWBWMX9YEN3GJuAYbaZfl1n7Wlmi7HR+azTLYiQy7v9em5AIY712Y+/wICFj/kyIUuAsf6ug7CleFMX9CZtHVQR7XcHeLdf78zG8AC8U3bj52nEO/rMlYZpXHPwCYPzpR5vxm8j2bIprDQWkKEJy0LQN9mE9vzWJgk7GVy9LFmgCiXP/9q9kfIQUC9KaVuXZRQL4Nu8idSEcOPqYVfRRiDSEZXAhM8cXhvyniyNK/qPTUILwG6pEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chQChBeSjx1UB0pM03IvI2fDn6JNa3pWfYrc/WcCCro=;
 b=AEKwFD8vDy/0wf+levG4lA9c71ZasToC2wpJ+l4jIy6HwF66u5E3AavCqU2yJ744/rvv2HlprN83Mkxtzh65XrN0HPT3ThM++Sd6DRXkPXOsU+Rgcd6xiZz7vfVHycQeUZ2S0Dj9wr7ESlri3RSww8PNQnNRH7oowg62QYJ2tgal1oEgnOLRY47wltxDiJRK7LAUTc4WhgnMKGNUNvTD5EfiGESHJyr9Z0tilgn+MlG9QbILOqMQ9mgkVbAyTxyNdDAi3BxTMEgryiZOgJ8CbQZ6RZg76JBbFuUcYrNRA6R1HYqsCkzd8NQ08OjVZF3IQLR/a1EotwrzfqdcH8j2RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chQChBeSjx1UB0pM03IvI2fDn6JNa3pWfYrc/WcCCro=;
 b=t1i3lBxTRoBY+okzgX6z/K7iPMhkPt5fTJofCJaqcsx+ceztecvb+0zu+biWkFZ77MnisbnqxE70Y/QiJ9XuYdlI7wkgxAr+YXbN51ykPdzMpBwf8JyTlOlSKtQhc1N7eHfc+un9gcn6Ra+aDmuusSVc+Tuw17Dn8Fm5DK4cUsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWXP265MB5513.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 20:50:53 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 20:50:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Sep 2026 21:50:51 +0100
Message-Id: <DLA8CU2LX62I.3PVH3HG52YA2J@garyguo.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Deucher"
 <alexander.deucher@amd.com>, "Mukul Joshi" <mukul.joshi@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Thorsten Leemhuis" <linux@leemhuis.info>,
 "Manuel Ebner" <manuelebner@mailbox.org>, "Gary Guo" <gary@garyguo.net>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust/drm/gem: initialize callbacks with
 ..pin_init::zeroed()
From: "Gary Guo" <gary@garyguo.net>
To: "Klara Modin" <klarasmodin@gmail.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>
X-Mailer: aerc 0.22.0
References: <20260908175427.47207-1-klarasmodin@gmail.com>
In-Reply-To: <20260908175427.47207-1-klarasmodin@gmail.com>
X-ClientProxiedBy: AS9PR06CA0455.eurprd06.prod.outlook.com
 (2603:10a6:20b:49a::16) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWXP265MB5513:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed5f0d6-d3af-4782-8dcd-08df0deadf80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|10070799003|376014|7416014|366016|10067099003|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 0tKWfuqHfWVwwW9+2ncKmMqoXoyk1NXwY0PNG5jz7AGurEjp9TduZwFfS7j/Hnl8OxgNVhA4cLq8y23mNJOGlMuHKthiQIv7dVn4znydZzkCTWajpXgXX0/EEQRRXxwfrCd1F/ljX28LzDAYXeLg3Aifj/T77667Ezla9QITFFQLy8cd5SSfinZgbybLsHtktRYDcYTOjGe7/2zNq1pWSbWH1GYUr3iXL/sJgeWv2+bjwEadYfmfIWslsOQqxnEjA4xCOfTHyvAUY5tB6XBmMAYv3oTr538kT050ghxJ9TYyASA6bMfYp4OJOFlaFLN7ia1rHP4eGW5pQSNLB1UJ29oaTowyU0xbsOXTZJ/4dXBYJYeNErXJldeZw+tZXg3NYqKAfOlXhJvTBnqFWDeC0/UpudwJ4OvptVxyiyw1FIuZC10o9VgC1df4jwG6c7bQecm5fiOPsQFLRF8vvP+RlCk81IrLKjmWmPYcBoJLa+J7eAUxA9EgkewRkVxaJoU8u7wsBZSzLtWKA1PQVt/xfBmpeb9JjJEFxdDM+PVGXFwzfnP61Pf1IAVJl2VwNHcCMNNbZ68IOYo2Rnye6RTrN/S95qCY0aO/v7RgXed6Xvo15gryoxeDNOecd4+dlBh9UjnjXdlG5AVH0Iml/+JZDC0vNpwobegStqE3seUPlJY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(10070799003)(376014)(7416014)(366016)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjlFMG9oMTNIMnQxTFoxMHNNZGtaQjNGcGQzUXdEeS95T2dQSFVRc0ZwS2Yw?=
 =?utf-8?B?VWJveSs4THdxNzNjRHBjdjA5MjBBa0ZwNk01ZkZoT3JJZ1phdHY0SHNER0x0?=
 =?utf-8?B?WGJ4cUxzQU5sN2Z4VTFKNXRaODdwTmo4ZjkwT3l2czdkdlh5WWdHQkhGVFBH?=
 =?utf-8?B?Wk51WFdobm1HYjJwSDdJbW9aT0hNbGNkeXhaSWpDKzZoODdQK2ZseHdCQnFI?=
 =?utf-8?B?ckJSNVBMZ3RhTGhFMU96a2xZMmVaL3gxbTgrTVZSVzJwSUNweWhpT1RDR0VE?=
 =?utf-8?B?ejNNT3NhZ0lxRkV2eVJYaXdrU3BlSnJuaTZUUnBrQnNvUVMySGRrZ2lKbFJ5?=
 =?utf-8?B?TE5UR0M1RnRRODBBV3IxOWFJZmllQ3VjK05mWWI4WlJSK1I2YVB6b0xvd3p0?=
 =?utf-8?B?eHVvMFl1emo2dkczOVdzZjVUbzhkTWVqYzVyZDkvTVA4aHZvaEpIY2N3c2U2?=
 =?utf-8?B?aDFTM2w5YkJvdzIzSEFLczdWa20yWmJZVXhUdzJ4eDBReE1BQWxrTXRBcFZw?=
 =?utf-8?B?Qkt5QlJIMXM5RkJjZ2ZZK2RQOFA4SmdNaFdxRGJVcCtRVzQ1YnhBZmZOYmlt?=
 =?utf-8?B?RFJGMG1XZGplekFjeWx5MXlIZGJYd2lSYS9UOHh3bllDajRJVkZHN3pGNytV?=
 =?utf-8?B?U01xM2NES3Q0ZXJWRUVndTNoZEhyQ1Z1RmRQeFhXMUZCTitxTU82MHd0ck9C?=
 =?utf-8?B?VWFEeTc3UlF6SFprb3VETlh6TmdGWlZ6YjlpMG5ZR0ZCT3BIZ3lGSDliaDlU?=
 =?utf-8?B?V2gydStGUXZyc3B6MnRJVmlURW1oMDB2UFQ2Q2IzZUlLWEhOU2F5bnZOUnJ3?=
 =?utf-8?B?VktZUVBOdy9KN3lBa2grUitHUnhIellmOHdpTC9ZTHl4WEtRTzhMR1dJRXEy?=
 =?utf-8?B?WURHSGtVdTVuclJXQzFRZC9MaVFwRUZ3bE9ma2I1Mk1US1lpYWVIaGMyWkw4?=
 =?utf-8?B?ZXJLdEc1bStwOU9DNmVoaXZtVGY3UnhWUUFRdVoxMXVDV0NnTHhUZDI0T2dY?=
 =?utf-8?B?TUhxQTk5WStZZWNYdFBwUytmbUJsZHZNNWJ1dUF1UnEremhrOXVNNlBBZ1RV?=
 =?utf-8?B?MFc5K0N0a2RLRWY1WUxWajdabG1kYmhnZ2g1RS9KV2NWRXNMQk15ZkRSS2pp?=
 =?utf-8?B?d2tNMU82dG9CZktkR0RpSXgxd3V6anpmelZKeDBLV0VjUzlMdzlqSldXaHd3?=
 =?utf-8?B?Z1hINVRzNEN5eGJUYUF5a3lXeVRnck9UcG9FWmFSYTNhVXZ2cU1SVjdZK01o?=
 =?utf-8?B?SVo0bEI5aGJzN011VGVKcE9obDE3TTR6MzlBQlFHVEVLS2J6SWpSVFFBU2Fh?=
 =?utf-8?B?Wk9vQVovdnUxT2dMR3d0djBOWnk5cnEwN3JnNVhtTGJTeDE3YU4zUDNyaW1q?=
 =?utf-8?B?dDBBOFpyK3p1dTlRbTE1VUFqYlVWUkkxdHBuT3BvcXZTdXZrOSt4TTkrVlY4?=
 =?utf-8?B?OGtqTHM0MGdNV015Q2pKV3RjUEdTVzhYQmVJcExja0RXczNTaEY3MHl6bUZV?=
 =?utf-8?B?UVVjUnpiWmhJc2hPcGcyZkIvMW1vOWNOUWM4OTZCK3NQM05aTGp3aUV2WlV6?=
 =?utf-8?B?TUhMdjZ5SkdLeitqckVKdEhzL1JSRWJFRUdSa3R2NThZZGZ3cmM4cjdCazRz?=
 =?utf-8?B?MzgvS0VBVU1Bc3o0dG9JdXFTN1A5RWw5Q2RtUVlJOXFrNTUyTFo5MjQxTHZI?=
 =?utf-8?B?bG5mdjk1NSt2YU93TG5KYStWQk9rcFJieis3QWo0WGNkV3BFckNraW9FTDNw?=
 =?utf-8?B?aWZYQkNHTS9NNjVXOEsyRTFjazQycitlOUt5VVNpZWJOYzhaelUyUEd0MVhj?=
 =?utf-8?B?VnBvZUdnU1hrbTU2dHNFVHdhWFd5K285VExoZVVYM1dYMVdnSTJXT1hTR21h?=
 =?utf-8?B?M0FUMno0NU1ydkg0UCtTc1RzS05LWmVnYlZUdmc1d1ZSR0lTaEVRZDFXZmFJ?=
 =?utf-8?B?WmEwUU9kUGg1OE5TbU1yc0MyK1pGSDJCOHBSczg2dURmd0h4dHkvTkZ6QXlH?=
 =?utf-8?B?dS9LNzNXbWpsTmhjSXRyUkZOaEZUZXcyL1Bia2J1ZDJVOXMrOHVoVVhWS2hF?=
 =?utf-8?B?NUVkc0JZenFKN2hhQ2RPN0pPdm5MQUt0Wi94S3dKUUc1ZzJFVU16eTJHSnFy?=
 =?utf-8?B?dk54VE1yMG14YjVFRG5IMjB3eGNDdGx3R01GYzFJWTVhNHZQbVZKaWRNMWZL?=
 =?utf-8?B?RlBQR010ZjlITjZ1UjBHZjNlSFV5aDVKa1J4T1RZK0tPQzFmVE8vdktZU3Fr?=
 =?utf-8?B?ZVdHZ1JpSGdDRlpXSFE0TXpWRC9MQU9rVnIvYTNsYTkxeEJaYkhtbkVSU2l4?=
 =?utf-8?B?NVpPcGdnaSs3MENGclJDOUtTTW9OWVlnLytONzlnL0NhUy9JMEpsZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed5f0d6-d3af-4782-8dcd-08df0deadf80
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:50:53.4007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmQOLsYakR04Hs1eo2/hlIZBeaLIRixzeWRx/NL4fvvrPv9pMbtY09769vb8avxImyIE9Sl5nU1eYOODowrKHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5513
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

On Tue Sep 8, 2026 at 6:54 PM BST, Klara Modin wrote:
> When the commit b67d2d039f64 ("drm/gem: Add callback for when handle
> count goes to 0") added the handle_free callback, it did not update the
> rust abstraction, which will cause a build failure when that is enabled.
> Rather than just adding another None initializer, use
> ..pin_init::zeroed() to make all unlisted callbacks None, and remove the
> existing None-initializations.
>
> Fixes: b67d2d039f64 ("drm/gem: Add callback for when handle count goes to=
 0")
> Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> Closes: https://lore.kernel.org/all/aaef18cd-ab55-4fb8-8563-ca3a5ea9cbc6@=
leemhuis.info
> Suggested-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Klara Modin <klarasmodin@gmail.com>
> ---
>  rust/kernel/drm/gem/mod.rs | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index 80d8f524f9d5..af8274134a71 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs
> @@ -266,18 +266,8 @@ impl<T: DriverObject, Ctx: DeviceContext> Object<T, =
Ctx> {
>          free: Some(Self::free_callback),
>          open: Some(open_callback::<T>),
>          close: Some(close_callback::<T>),
> -        print_info: None,
> -        export: None,
> -        pin: None,
> -        unpin: None,
> -        get_sg_table: None,
> -        vmap: None,
> -        vunmap: None,
> -        mmap: None,
> -        status: None,
>          vm_ops: core::ptr::null_mut(),

This line can be gone too.

Best,
Gary

> -        evict: None,
> -        rss: None,
> +        ..pin_init::zeroed()
>      };
> =20
>      /// Returns the `Device` that owns this GEM object.


