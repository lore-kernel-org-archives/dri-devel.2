Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B19FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 12:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11CDD10E0E8;
	Tue, 28 Apr 2026 12:51:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="DCKimjtg";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020101.outbound.protection.outlook.com [52.101.196.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 689E610E0E8
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:51:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJ5PF1lTVo9HOV2W5fireEPVcYLlrPi/fOCXvRkIYdsdQWJ2Z+C6WK7d2EZUGclcmE5gRzh+UTa8njt1oi69+X2h63CjRfYcgm5J+CnC7hY1SQ6LU22lijFu5w8GKNYm+3Nkxfxx+H/XoGbXTprq6H+7+R8IFkyaZQQQPQIoQhnBVgwybVb945Wxe0qhbtjIqvWjvXG49j7BvzifpKyI90+YQB+9fiVi2okR4qCG/vSN1W2p9W2coKt9sgb7fLr/Vs0E92T7OWuQw8iIdCQykfwpQ2MYdI5iEsEbHxzuI2ZlZ2idtni1pa+gEclN+DuOLi0UOSHom94FGHypKxqbKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gS6gu+P7gukGgV2SzgLGdyoSOXoN7QiV26nOVGBdy8I=;
 b=CY9xs1QjXSgS4/VWH27vmLTDxZJGbYLIM9iVFdbAINUCmpprVgtwcEq02khevXUejgu17W/jx5j9NFK6GgjGY1NwebZWzsraMREWwOJCkCUKajSlEMVMsdT6X4XOGgrpZr6wwTHLEc7Ix1or39vWs6nRtz5qTdBpJ1bsrLXrGVWY/w7NZ/TbCMlLRDwsrM8NCCDg9jnbg7sVpMp1aK/o6B6Yu+js6qB9EQyEZnC2aZy/A6zYW4r0UWmQj6oRFH5e9NYvYIegQxjfLlacojcNXxO1PoTe2O37rGuIJ0yhqkY5OZEG+sJq7bF3Iy+r1Mj1gxOesdGb8kQBfcOKfdOkDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS6gu+P7gukGgV2SzgLGdyoSOXoN7QiV26nOVGBdy8I=;
 b=DCKimjtgBQmAVtrqEfzdXDBq5TRBgnE5lWFphEw2sQLe31mInceSi0cga/lK0wOrajpXAkr537goBjwwYXmjpqmR7YQJiilN7Fm7V3KZUIRT+sx5+bJHOoMiCcjN3Mn+9EU9iBgIJb7sQ8niOL3LzP3RtJljkBNX727vyw0F7D0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB7119.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1fa::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 12:51:00 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 12:51:00 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 13:50:59 +0100
Message-Id: <DI4SUYYUVHU4.29HTA4KRQYCG6@garyguo.net>
Cc: "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Alice Ryhl" <aliceryhl@google.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Alexandre Courbot" <acourbot@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: drm: fix unsound initialization in drm::Device::new
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Lyude Paul" <lyude@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260428-fix-drm-1-v1-1-755057178066@nvidia.com>
 <DI4SOY5IQR77.1D97MMFEQEOCW@kernel.org>
In-Reply-To: <DI4SOY5IQR77.1D97MMFEQEOCW@kernel.org>
X-ClientProxiedBy: LO4P123CA0394.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::21) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 723ee72e-17d0-4420-a333-08dea524cca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: F8Xom0Cn41sIOOX9cN84HHszTta1w1vT3zK9cY4pnVWFQbVrt0vrB8bSOll6TR1Ib7Qn+akwg7LaoQhRs8yIgEp+vANTl873SIgfZI+tnfGcOTP6HGNUSw45vhlMQi7BUo5GLXPrB40ngGc3LBdGAGWKQ42H4f0gIU0vZh3twGLkULUyWx25ek7RYEjkl+aPNsdzlk1rAtKEPMu/83PF5cTRWwnfsfrr7oCx58F7et5ze3U447wo/z1ypOQ6y7OvPD9wrbugmYCGwvJ4sLlqhGffavsuTzttdV/h8s02hd70J2J3VGVLORdAawHkqrE/GwgmxZWPBvTohYO4STHNbdyepPVxpYX/nu/EfMFRkn902mV0Cj9NUx8NWy77MA91WxYOX7k1cjb1ws/f2EDsW6BzKZUHTl07uFXJmcjRBxyUnk4mL6+wI2Qc7ch+Gb5Yq8m5B7Fov6dMFHVTUIT+z4Gj756AenBZKgxcEnBQLtu2ma3doD1XTysykrZRpGm/2t0hz471tijtmIn9dU37aJONd0VDwP4Cx3Zd1JeWtpmPhrtCrGooL5O1sBOzCjKL68Pgh0H04WR0nnk4kH8Vhhq9UcF45Xqy0fE19oRqQeFzEt/FiLOA3YRdbSAOY8n8mRESXYtUZIf54RB7G/ezosBN6cxfGJm7iybgZioCLPufkdp+7Qya+t/jI6cJ9mSh5mWgKgd4tVkRMkQnYJRStxqL4BQPlI1drehm96NZ7VU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFZPcTh1dXBFaFh2dU40ZHU2S2lmekhIQytEajA5T2FqT1hrbnlnQzFqZUhy?=
 =?utf-8?B?WXhHTllwQ2xqYUlMSE1BazU0OFNseXdaREpXK0RKd0MxR0FhREF3Lzc1V3E3?=
 =?utf-8?B?d0RSMEhicGdxQ1UzL25acytsVm1xcVZna3NvMXhrZ1FGY09LWTdDY215aGRJ?=
 =?utf-8?B?dVV3OG9ZNWI5MXgrbW5mZ09NdnB6TFM4TTB3RWZDSUxnTUJFRmVqYVBnc25B?=
 =?utf-8?B?QkJqSzV0YTRNemhxQ29aeUtQMEdWb05GWHdLNzZ6VmJxc2ZERkJQZm5iMDFl?=
 =?utf-8?B?V3J5c1JBZFZxaVlRcUd4cTZIN0lvUGUreHIzK3FBcmV6ZXBzSHAzM3lINmIy?=
 =?utf-8?B?Q3Z5QWV6OVA4bW94NzhmYy9qWGpIZWRwSGNGMXhQNitMNDJDWkltTTk1K2Yz?=
 =?utf-8?B?QUFXMUliRllmakM4UFVrN1huT0RVRzJnM2tJZmREK0pESytOUGRJMWpSZzk1?=
 =?utf-8?B?TGdCeVlYclVlL1JzL2RoOWVlTkE2dmxLTVh5ZkUyRWNLSlV3SnZpVUkxR1VI?=
 =?utf-8?B?R3JVbXcyUUt2ZmFwMjVIZmxUZ2E5R0VQaEtNdE5DaHNUVjhjdVdTd1BXTXMy?=
 =?utf-8?B?enkzc0krZEdxOVVpbWdsSnNhSFJZNnlISjd5QVdPVEMwOXBzVXc5SUhBT2Zr?=
 =?utf-8?B?dDEwRlRkaFJOYi9zYldZKzRCNVFyTkZMYmUrSWpsMTdKeU9lWmJXelRrMWg3?=
 =?utf-8?B?V2M2akkrUXZPS1R5aU5uWnU2Q0pDdVZRVjVQajM0MW1vaEpTTjZySnE0dGhh?=
 =?utf-8?B?V1pLZjY4ZlQyMC9nUU5yNkk0eUZCOVdIb1ZwaThKK3Q4TlE1ZWVpbU8za1Y2?=
 =?utf-8?B?NllnOTZVczRIRkJPUUN1R2tQbXNMeHdSNjFzbWVJZ3MrZDUxRVJ5ZzlYZHBL?=
 =?utf-8?B?azY3RlFXUGZBeW9GTWMyOUFGbmxTS3NrQTF4dkpZdDBvU093WTdUdFJPWXM2?=
 =?utf-8?B?M0dEb0xCQnp5ZWZrb3RCaE13Z1M2eUFRL0U0aE5YNmpNdytScjR0ZXNUeWFH?=
 =?utf-8?B?YmVuZDg5RHNQRW9YWUdYLzZpRXcwUzRBMmJJS0g4OWhpNkhEOVdoakZ3RWxt?=
 =?utf-8?B?R1V0SXM3bkx1bHNPbTBka3dGbHNlQUNUZFo1a09zYWVYb3VyLzEyQVhxRWs2?=
 =?utf-8?B?eFdVdkZZSWRZMnJKS1hNaUtWd0dEeStoOW83RjJWQU5SSmFvSml2eXlLY3hB?=
 =?utf-8?B?cGg3OGNuMk1iUGs5aGFhQzN1VGppdjZPaXc4cCtxTys5bjRRQWRXZHltLzV1?=
 =?utf-8?B?RUx5MDZzNGRwQmJRVjdOVU1yRXIza282MXBtcExmYUE5dVkyZk0rdWRMWjBn?=
 =?utf-8?B?YnR6UFFXTVZtTVpsRFI5anRHUVB3UW54dCtyL2NmNlFBcXQrdXkwendyVGxE?=
 =?utf-8?B?a0lKWENJK3BOVjBVWkNTSHphTkdndTJiTjhUdWNWQUFzbE1CN0dQUGFKZlJH?=
 =?utf-8?B?QTlnWjdDWm9WSVU4dVdSdm5NMnBuMGcvQ0RqNXpnWnpCdlhiL0JBUysxbVBW?=
 =?utf-8?B?Y1I0M1MxdjZsV0xNTUs4dDh5VERrQzh2NFpwUnpoYkNYVE1YamdZTXY3dWNa?=
 =?utf-8?B?MkFZQkY1ZFpTWUpJSFM4enRSWFFKcW9TOXRndUFZTTQ1N2s1TVBrZW9nVDVq?=
 =?utf-8?B?Q2tadTk1TExINmVicDFjazhMUjgyaWNHQ1dPRE1SR2owcnBtRWNFeDlIZXBC?=
 =?utf-8?B?ckw2dkNUaDFIdEgxbWc2Tm5KbFZNem1zbnpSRVFibTF2dGtHa2hQb3NXY1A1?=
 =?utf-8?B?Qng3ODdxY0pWeXE0YmxJaEtWNVVYUmYxMWlLUWQ5SVhacnlhcmJ0MFl1cmtV?=
 =?utf-8?B?VHczcmVvNnBISU1lTEt4WEVySVQvajVxQUNobFdLcUhGbXA0TW5PblFVTnVR?=
 =?utf-8?B?ZHl0Z0JoSlN1ZlhVUGpob3JCR0lHTE9kMThQZ1FRQlY2SktYUzlpdTVKQUh5?=
 =?utf-8?B?WWtsbWNUaTV1VWtOWFpTekV0Z3hXbm1Fbmx0Mkt4Y2ZNQ1hLd2Z5UkpROGRU?=
 =?utf-8?B?Y082TjhhMnBEamc0QUxGbmJUYW1FMU1UK0haSmlVbHpOL3ZsZEtUWHlDUzFY?=
 =?utf-8?B?SDg4ZExmc1FUWFY4L1JNbkI2L0wxRGRaaDYrU2ppNXpLeXBFTmUwLzlObGRp?=
 =?utf-8?B?N1ZPNWJjNDVTMTBDdmRnd1BGaXBUWmlMMGdxUS93WUdlTWRuWnFPQUltVUtn?=
 =?utf-8?B?RU1pRy9aaiszR3FMSEZXL2s1dytDOXJZNTd2YXlPeHVHK2hXeU1BQWRUTjRI?=
 =?utf-8?B?T2VxaWVjNVY3VTZxbmZhaUZlSm90dFN5anhHZC9teFlIQU9Uc1c2eWhlc2FC?=
 =?utf-8?B?U0YrdDdGYjlkMnFFMnFrVldwR2d0SHRxQkxFZFFoYW9vNWZqZVg5dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 723ee72e-17d0-4420-a333-08dea524cca0
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 12:51:00.5078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0LKb8qIt1VdcsP6vJ0C0GS6ANcSAfiga1tDbzX8PtBIeJrj+p1++UyfoPRzfTPdzUqt8ZdBFXiFdhyT0PnpbeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7119
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

On Tue Apr 28, 2026 at 1:43 PM BST, Danilo Krummrich wrote:
> On Tue Apr 28, 2026 at 2:20 PM CEST, Eliot Courtney wrote:
>> If pinned initialization of drm::Device::Data fails, it calls
>> drm::Device::release via drm_dev_put. This materializes a reference to
>> &drm::Device, but it's not fully constructed yet, because initializing
>> `data` failed. It should not be dropped either. Instead, if pinned
>> initialization fails, make sure drm::Device::release isn't called.
>>
>> Fixes: 2e9fdbe5ec7a ("rust: drm: device: drop_in_place() the drm::Device=
 in release()")
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>
> There's already a patch from Lyude for this [1].
>
> That said, I like the approach with the ALLOC_VTABLE.
>
> @Lyude: Do you mind if we pick Eliot's patch?
>
> Thanks,
> Danilo
>
> [1] https://lore.kernel.org/lkml/20260320233645.950190-2-lyude@redhat.com=
/

I have to second this and I think this solution is very clean. It does mean
that we're always duplicating vtable though, for just one pointer of differ=
ence.

Is it possible to have a shared vtable for drm devices that's in the
allocated-but-not-initialized state?

Best,
Gary
