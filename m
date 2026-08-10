Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF46C5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:23:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BE4A10E227;
	Mon, 10 Aug 2026 14:23:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="APpAHvNV";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020078.outbound.protection.outlook.com [52.101.195.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AF9910E227
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:23:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/yKGZxKYLofFPDl7H2oSchmMvw1G+6Kl8libC1IGghXyQId7UfZMZC7DcntXVHDIyZSX0paMwXxbzw7IcOtxO+/HNhRydEqu/uXQ4zDkdlDShh0zFWAJvjH/dn+9itPi95InVb3fBwSOuMeu5mZyFLPphINx+XkeY4nepu4lyGnQXT9kVPhncaQ0M4WF0omExjRT7+EvKAU3+ucsH/R9yf4ZJQfeaqxg2qcs7FECtvYdB+3F++oFgCL2cR1w68UOZSgcmbMFXkd9J+pUtibz7QHBm8GYLQiKw9XTEm7F9zwy2dvNTJxK8uepw1Z4gACDXNK/dR/WUgG13gD/NG3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAw6aAVyuV8jWN0l3ClGBXzotilVaCIIj6Su4PcJryo=;
 b=LWkTxNPjEYs0kpzCipZ98fkvD64/gUM6BKU/uFagaVujM2QLcDT3NUunObqvLlwQzCy6pjy0Tb0LdQjg0fCVCBbXD0xFmETZX/KivjnU9DTZpafUkbkvOjj0Nz3S3rFcVKpnzHl7iy1hpuSGDDXhebkL67T7Okil8EU3R7bTe3ZqNpzO1AtWA5MQFff+sgme80BqcwtmCADr0188Zgx4L45GZ4JugG3U3YnNMR9lcdtNlC4ZeFJtSrGuUyRMwuQiE0Utar3bxrXfvCQT/pEJxQmGrXULY9C85FkL4gdxr5JZMAb8v6APM2bpYBkoAj5OHOD9TtVrMh7XjPEQ64RbcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAw6aAVyuV8jWN0l3ClGBXzotilVaCIIj6Su4PcJryo=;
 b=APpAHvNVWBuBQSYHdb732dAO2EglwiEfNCITjyfiQ1HJSGeGwgIO52pjkoU/KO/QW8Tj9L5koPJi76+dwePhCUJYLRG7oJHb5J3SCvNEw+na/wS6CySAhF6EHfIUAOTVPUwDuSOSYrtDPoNhKu2FaDp66Hn8/63R80jU6/mKWpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO8P265MB7829.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 14:23:41 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 14:23:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Aug 2026 15:23:39 +0100
Message-Id: <DKLBYKUZSY6R.2K495H31XVY24@garyguo.net>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 02/12] rust: num: reject Bounded::shr overshifts at
 build time
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>
X-Mailer: aerc 0.21.0
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
 <20260810-pramin-split-v2-2-65a00b3c7309@nvidia.com>
In-Reply-To: <20260810-pramin-split-v2-2-65a00b3c7309@nvidia.com>
X-ClientProxiedBy: LO4P123CA0598.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::22) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO8P265MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab318bf-9a6f-4c3b-38eb-08def6eaf9ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|7416014|376014|1800799024|23010399003|921020|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +JyxNoa2ui6sxMIO62CG0jTFfMe27jvtGyMYdDglQpu1yKiaYUPQ0Uo2TNubTNy3yWw9hnoHJTxoxPJvgM63MLiAsKGib11SpBQFCd0XGyBwwy8LFtzz27n7aRymdqiLHNUvbcqQTCf1Hc8kGuPfM7mWnZGsmK2f8yyOG0EY+qZlHRkdWkR3dAVL90yN9rPxdhHYorkZvXCFNQCJRVZPHnsyz70F/NxJ2MIptrKp3z+iczNddPv4flGjF6KctRTGyWYo1nI7J7LECA010EekqJ8JKEDwr4jbwHp/Ix3dKxyp9W6Mc29MVzokJaNwJi4wqryVKCdKRkwCheD1KFjp8pf9Pl10+Qid2jAEDxr28yzGWWPONADFe/1tW+8Sj2CVCYksSLaB++ZKrXrAZLi3DZf4orYmSfHfksp9z1mc36xBLxxxSjJtuaTjzOuftQai15lwtpO3xZlK28EQpkEX5y3m7MCUYwhi9PCMg9m/jedZiY00oIzOqaiKw+R3Enf3tfZ3ZehKxm9Hwp7jp/yXVeJw81dh6lw0uE72jjsWDvkIqq+8ZAGViwnt4uTKtNaIhLpsCm0HriTPYnXRNrpihinm1k1ylviuKeUbvX6K9ncsKH+xR+GsyhEtx/zDq/cH6gUAuGjZKUgcfea5fUiXx0qU8YYr58eYXN2jSIQEoadBJz0fIm00Fr3XUFJ9j5uVwmdD2QveR2SoQLWPpGmdow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(23010399003)(921020)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW9xTHZyLzdJN05lL3RmZTJmRHVkaENrb1BHY0dzSEhMZjdZMUdHRzAyRjQz?=
 =?utf-8?B?NW94SCtsaVg4Yyt0TEppWGxvNUFLa2hPd2RZY0cvNUdad05XTTNjQ3hvVHhU?=
 =?utf-8?B?SFdkTmFLZXlpb01aQUszeE56QlZaem0xU3E5Nmx5TmpZTkxSSzg2Q2F0T2hM?=
 =?utf-8?B?RldheEtTd0dNVkNtaE1mUytpaUVMWXlOc1VValBLTE1CT1JvaDYrcmJiV2tB?=
 =?utf-8?B?M05RbGFucHZVSmhSdkZNL0VrUmc1MC9MeWNaS3pnNmY0M0dwVHh4S1Q2Sm5i?=
 =?utf-8?B?bU5qSVpyaUJUMUpqYTRDa1E0OTRuNExRSFNaMnhObDdCUnJ5NnJmNC9OdGQw?=
 =?utf-8?B?OHBHY3JsS29GTzR6SXBEamlyRFQzQlpRSUc2WTg2dFhJTDdCRWIyTkxtSDhR?=
 =?utf-8?B?N2F2YUcvV0RxcUtJb1FmS3d3M2dCWUtTNnhuRTFsWjg0UGZKRHZGT0d6L3ky?=
 =?utf-8?B?RjEwbHBFaDZXU0VXaEJRVkhjOUdrZlhNbGs3RU5XZHprK2o0RmhuanpKanVv?=
 =?utf-8?B?aWdKaktyZXltU0RUZzQwSm9BNk1DMXpxUUFZVlpXbVVtNjRmOUtZaklpSnpV?=
 =?utf-8?B?TW4rRlRNTXVpNVE4VFA0MU90SVlaNUZlUzFEZ05zV1FLVDVpMnZUS0JXb2la?=
 =?utf-8?B?REJvcUN0a0VabVFRNUpCamlKa3VYaXBMdDgybDlVaVpUWnFNd3BiL1lBZVly?=
 =?utf-8?B?OURFRExVS20rNGxzL3NXd2dDeTdrWlZIeldsNmdoeS9wTlM4NEdmT0UrRHYz?=
 =?utf-8?B?QkRaNmREaytHOWtFR2dBR2IvRlY3RU45STJ6K2hQcmwwd2hzTVl4WFNHKzhQ?=
 =?utf-8?B?WTE3RmVheHA2SUNybGNpVkY0WTBTcHBKWm5ZY3YwNUpaN1RyblhXakg5ZnZC?=
 =?utf-8?B?N0ZhNkZVVFpsaFA0MzhFUTlnZUhHZCtjbHpOZzZjb3dra1lSSWRVd05VMkRT?=
 =?utf-8?B?VXUwOS9jZlFzZzdpbG43WmFaSlhxSHpMUWVtbDNzR3dJVUc4czZSQi9YN1FU?=
 =?utf-8?B?VHpVZlBXdVZpRG5sK0NYUUhXSlRsSWc0OC93M1pqamVwNE01eForb2lVdWl1?=
 =?utf-8?B?OURua1VJRlFOQm1HcENtcFhTcmtTSGFvbm1pbk91NG12N2ttUlBENHhVNnZZ?=
 =?utf-8?B?Q3lPODBjVEtXd3BoaDRWb1BRWWJkZUdmbXE1dWsyclQvRE1XUUh4eFNtdVFw?=
 =?utf-8?B?bm5Nb1dKN0JjOHAwOGNLYyt3UHdBRG4xZS85c01xbDdSZlplSWJ6SkZnWnV0?=
 =?utf-8?B?L0JUdWlRaUEycmRoY1BCbXVxY1RCZTYwRTFJNk1vQ2R4Z3RQNVR1RGROV0NG?=
 =?utf-8?B?T0VYRC9GZWtDVFR4U0NMaERlVUlMdUppUURWK1RkU252cGxFYzN4WkJRZmp4?=
 =?utf-8?B?Wm5hWDF5TC91dFIzZGk3WVBxZUd2dlJhRnNlWGFHQVAxbG9Lb29DRkVBUkhv?=
 =?utf-8?B?R2YyL1FCdFRCNVQzdUhFMzlJWGh2amlFazJ6blkrbWRHSkpiVXlvSWc0SEQx?=
 =?utf-8?B?MkNBbjA5bjRpckFyWHRBdkNPR2MzdklsTEpaRld3dHBxdEJNRWZsUXR2ODEv?=
 =?utf-8?B?b1dtaUx1cjdVR3Z2WVBwZkhmbzJNQjNHc1JTaVhIRkRCR2t6bEhUMWlMcmIw?=
 =?utf-8?B?QTRiNVdCUWtuY0lRTnNvQTMzRjgvVktSWjh3d0RoNldzSEJUSkgxcFpkMGJr?=
 =?utf-8?B?dkJwTFNCU0EyS3M4VDZFM3lDT0JreVN2NWFhbHozMEM0bzZQcnNrRll2bEJi?=
 =?utf-8?B?Rk9vcDR3aDhiNXlrTXJOaVNMSnF2ZVA3MnF0VDlVbitINU1WWTVBRmhwR2Mx?=
 =?utf-8?B?Um9ZVStHa08vbzlldnhtWEVPZXpabTc2Qy9wYXorYjA4dlN0emZXU0pEVFhy?=
 =?utf-8?B?U2VQOWdkemtpaDgxYnJHdVVZL1VQWjZxZ2VKaE51Y2JkT1ZWa0dRMGYwZ1BX?=
 =?utf-8?B?MEtYM2NGL2xUM3dKSnhTQ1VaNEpCMmp1MUx6b2hGZ1VJNlVrb1Yvdkw1cDF0?=
 =?utf-8?B?Yk9oTTZhS3hnVjRjU0pZdWNseTZPd21OZHdrcFM1cC9pVklnVUhmR3A1Q050?=
 =?utf-8?B?MXBnWTVqZTdFSXJ2dTZmWEp4UnZHSnllem56MGJCRVZiWVRxWURKSWV5ZzJL?=
 =?utf-8?B?Y1VGaHJaSUhZVkN4TDZ5TUdrTjBqOERNWHJVRHl0WWdjQzd2TEpSa2RSa3FX?=
 =?utf-8?B?TVNxUXdxTFVWYVJUdlZGSlZVWXZ3WVhnY09kNTBKUFJIQ3EvK1NjLzEyS2Fo?=
 =?utf-8?B?TW9UMjI5SjFDSzZKbWdoYUk2aXA3RndMZXhIVTJ6M0ZmMEpNNG5lUW96b3p6?=
 =?utf-8?B?UWlUWms3MktiYk9VTlVuaWQ1Y2FvQTFEaEptdHJ1OFJSNE9yUUt4dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab318bf-9a6f-4c3b-38eb-08def6eaf9ce
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 14:23:41.1011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYexgmPRyW5QypKHScfPwgo7YOTq0D7F+oHnMvFoF1Zy/f7jlylxG6wkr8CAA8I3E2YbMVpfnIckOKVaXPr5wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7829
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

On Mon Aug 10, 2026 at 2:55 PM BST, Eliot Courtney wrote:
> Make `shr` reject shifts of at least the type's bit width at build
> time, instead of panicking or masking the shift amount at runtime.
>=20
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/num/bounded.rs | 1 +
>  1 file changed, 1 insertion(+)

