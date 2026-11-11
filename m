Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AAD606A32D
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=aykb3gun
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1A1A10FA0C;
	Wed, 11 Nov 2026 09:25:35 +0000 (UTC)
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021115.outbound.protection.outlook.com [52.101.100.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ECF910FA0C
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:25:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRENqY3eErrBTjKllvH/X7nFaMTz/r+LGS6lc/KEDS/zsGndHe0d8HYy+8xs3kHbj7onYN35oMXAc84lCXDkJXEwHMjH+AH4DXd4aR5cjKQQUQmGaW4Tggh2ImfpQbepPwz2vOLDAXvyJePR9lH7WOmq3PcoPPXFPmtqx0eIF87ERnKGJuhqFWkzGMOsv7DdxlmdA6La3KnciTLXb2tu/XF9qh+1iUjP1wJ98YaDh8FTo9rcqdAt9GStV3eYJh8xKxhTiJ42QvvbcMfv1JwiiehNoflvDNyKlVAkmKd6g9I6XBXaX3we+XqRmzwt0pDIkq2IZYXKjwb5udSitNDQcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5LQM1KI6QmdweywW/sidoo22rxRYAyvGMYul4zAO3k=;
 b=VsZGhMsFU4lkasxrpWufs2vOlhT7Q95YgxMpAi2LEmA4x0aL3fcMI9qU/SUM2TIGGwS81sWZ2tO7bT3R9D+GeOAnVgBSR8Qf+uyBp2bvja3R1q9FfFfTr41Z7uid4dxdTv/VVT6WzJdPr5AmPUJKWN4d10pFZxHzzMxGRe49cRe6GdHBMNAaINLo9j39YZIonNUqF9vifNLow+yDtrKGi0LUt2fqCMAI3rV+TzxGnqgrrp3blnuqzglVFJXAQ1D8fKllYVK9DFRQRKowTxkyizgANVNH69jYcWw4ebWieNLtuLi7XurUlfyxemLgl0k1ERP7ijrYBgN39nUZENjP/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5LQM1KI6QmdweywW/sidoo22rxRYAyvGMYul4zAO3k=;
 b=aykb3gun8v/zH5tcQiM2ZN3d22I2ZRRi7pVXSzxVJdUJ4nEjZVUUcBJOBGORLcARbMCNhm0m03XE9p8C1zdxbbTvTvSQmRvMuDFqxmMzH6GzmYZZSt4gFRxhswWcK2Y+w4Z4iSlcpT9fUl5RY44Jx83fxS3CrjdTqmgmwQNeUTo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by CW1P265MB8830.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:25:26 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 09:25:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 09:25:25 +0000
Message-Id: <DMS9UW3YHO12.L5G6JDIYPAJE@garyguo.net>
Subject: Re: [PATCH v2 5/7] rust: drm: wrap fops open with RegistrationGuard
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <aliceryhl@google.com>,
 <acourbot@nvidia.com>, <daniel.almeida@collabora.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <tamird@kernel.org>, <work@onurozkan.dev>, <brauner@kernel.org>,
 <lyude@redhat.com>, <j@jananu.net>, <alvin.sun@linux.dev>,
 <deborah.brouwer@collabora.com>, <laura.nao@collabora.com>,
 <beata.michalska@arm.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20261107021427.2105374-1-dakr@kernel.org>
 <20261107021427.2105374-6-dakr@kernel.org>
In-Reply-To: <20261107021427.2105374-6-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0492.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::11) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|CW1P265MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ae7050-5e48-4549-f89a-08df3fd5b81c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|23010399003|376014|1800799024|366016|261026140227099003|261028144727099003|261009223027099003|261021123027099003|261021121427099003|261022105027099003|10067099003|261102123227099003|4143699003|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LGG1iEP5vdtZfz/01LiO9UUO3HlA6wepoDeY/CJgvYuRFpv3Wk7wmCYpCdDeh16B9XjJhz/S1TvMupRrz5+JAMukvO7jNnUg8T50jUYB1NpuJNxbobgkAfwnTMfy4bBv2r5UvMIl53Qrtdv+uhFGh8FoQ6rTrrFrixhmnd0I1Z5V71c5pfmdXmjztNdjSn/YySlVTiq2S9JcM5pL7W/+PmxOz56iOyO0d03Ca6uYwSrHOCizaFTYVeYPgT5pvUePbcVgaWduSK4NnMxh3CtJPm4+WlEEw82SB9iCEpaaykJUyPL2pj6589zxfm/0nYGrdN/pcFM710543QaKLzgg41bZvxSI3C4oD7ydh78SHSQ/D/LvVWgaaw5YHGJSVNY5gKA04cxmDs839uTaFmuVATnCInEinbJ/PPINrnDTXiI/CXWhNICnIF8fo5VSUmMm3wNqC+cFHBhBqsleyof5VeVAgjjbo1y4EaXih5DGPSIHr5zq5cXMMEjx0ehzvkk6lJrTmYtbHlHN7pLWcAhE1wCOd6HZqBn738WuycKb0Bspqjoe/W2IK8wP1/S1+KZDLRaxcFautyotZZ1hvcVZgF1LH2j4z+gir5mwW/LXwJHiqOn3jzUN35xPazqOcFOAtAYw2nWmxjM2wGeCO+mR6UahY/znI2lhd2A3EV2b4aabMt24z18ZBNllwjqicUouftGKdRgZO8oBhuoXn57OoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(23010399003)(376014)(1800799024)(366016)(261026140227099003)(261028144727099003)(261009223027099003)(261021123027099003)(261021121427099003)(261022105027099003)(10067099003)(261102123227099003)(4143699003)(56012099006)(921020)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1RUWmxVZ1RxTCtPVENNL3BVdDZUTEF2NVEweXNodzZTTktzWUlMZTNLMXZF?=
 =?utf-8?B?NmZwVVJ1Ulk3NjFkKzBBam10aW9nUll6M0ViSlNkUGZORERmUEpTWkRsdXRW?=
 =?utf-8?B?UTF5d2VHYWZaQzlIL2RpY2lKRTBkQUxJbWV2M2xMU3pTV2U0dGN2OVVUUFo1?=
 =?utf-8?B?K2JWczFBeDlwb3NycmFDYVhiSGp5ZmwveXpZUEp3TGxnMEZ1a0N4ZXBqbWZT?=
 =?utf-8?B?K1JqUm9OcUhaQXU3VnI1dWp0blJrZ283RHhuZzYzSWhYZytCK2RwSWI2V2NC?=
 =?utf-8?B?VGpYOWlQcEhyZ0Rsd1d6UE9zZTZscmxlbkx5NGNSR3BqNi9hdHprTjc0TVFn?=
 =?utf-8?B?TC96RjNzUzBRV3psN1BDRXBYT3NMenI2MWNGWGRZTkQ2ZzA1S3FmdlJ4bGp2?=
 =?utf-8?B?bTZwN25YQ0ZSWHBaZEJpdkpoc1RvMnhHL0NOb010cjkydk54WWsrcSs2YlhQ?=
 =?utf-8?B?SWNEaWJXYjBrWVdIRm9YRGovVjVlT3dqSTNpdVdFOW5qc25nZnpBL0tSM0hy?=
 =?utf-8?B?YzF5VmVZRmlxWWJUYm5vM1FFTzlWRlVoQU1sSzBWaEVzYmF5R1BiVGJVVW9m?=
 =?utf-8?B?SkZPaWpaMWxaVGRDKzdTVGRZZjNRNTZrNk84QThNckord3QrZ0tjSjZmTXRa?=
 =?utf-8?B?am1tY2puWnJKbFlRbFVCMTY0eWlpVDBYd1o0NU1nT2d1dkdTSzdONW95UUJn?=
 =?utf-8?B?QlJ6bWoxMmVvcE1uN1RhbGV0NjVlSVU3ZjUwbUxNWUtUUDhXbUpoOHFUc1VD?=
 =?utf-8?B?ZjlBWlBaY0prOG5yUlprU2RMVWJHbHoycGJCS2d6blBseUZUQmF0QlRqOW1S?=
 =?utf-8?B?Wm9BdzQzV1FqUi9NR3g3eXplQ1dkUGNJTnp3UDNDU0loU2ZTYkt6TlMrb3ps?=
 =?utf-8?B?T0dCUzNuZjRnczJmcTYzRi9Udmlsb2Qxd2UxdFVTU0RzclREaGVRdzhidThp?=
 =?utf-8?B?YU5hOWQ2UkZkNlhqcWlLeDN4NEk0aitHaGthclFEUkQxOUlMTG5qMWFCTG5D?=
 =?utf-8?B?UEUydDVVQ2FVa2MwTUVvcmV2TmNTVkptTEMyZ0dkMFZxOHd6S1JqY25JenUy?=
 =?utf-8?B?NFlZc3dOKy9zVjduclNuOVpMMTBLSGpJU04vdUZlZDZJT0hrWUNkRGhGblVX?=
 =?utf-8?B?V1pqNVJ6LytUZnZGZnFRaHBjcnFKYllaZGJpV05CdG95cndkWFVxN28xdk5i?=
 =?utf-8?B?UmtyMW9sVDkwT3JEV0xpd3drdWE1MVhSa3JTc253N0Zod0ZOeWFKWDRCdUZp?=
 =?utf-8?B?WkZrTVdmRThCQ1ZLSG9BL2I4eURGaFNzOCtaSjg0Ry9OVmVocXJnSVBTQXBY?=
 =?utf-8?B?Y3RueE9mRUMza1BObDVIYThiZkxJK3BibWZvWUZ3S2VSQVFSbmNYUVkxQUNr?=
 =?utf-8?B?QUFYWm9zZWlnS0xranFPcHliZUZtSmtIR1RWa3p3RXJwM2c3a0VSRmtocS81?=
 =?utf-8?B?dTMybW1JVmY4K045VkFNZmdqYkN6VlJGdFp3VGtQbDBmWXRjMlVLSnZSK2x5?=
 =?utf-8?B?NjZtMldUZGo5OGpVUUhZYUdWanU0enBkN3MrYlQ1MnYwWEhTZ1FUOEo2NGxo?=
 =?utf-8?B?cWtCWG9icWpieXZmN0UzNVRya0pLZ3A3UG1XUDJ6dTFpMGpDNE5JZnpMYnp2?=
 =?utf-8?B?QW90OERubDhxV2hHU1JXYzRIWTNib1MveTRCdDdjWlVYdy9YVDl0eXRzVjA1?=
 =?utf-8?B?TXA1ZlVjT1ZoTkFZc1J1NFNBOHRjbWpHZmt6RGJDVGJybCt6cVpGMldIdU8r?=
 =?utf-8?B?L0U0SUpKcitla0ZJcDFYVU16ekNtVEVvb1Ira0c0cGxQZVQzWGVuZG5jNnBX?=
 =?utf-8?B?R1JBMFBvSm0xdFAyeXZKRDdLak1vTzVESll6bWMxUzgvdXJYa2dSR0s5ZXJL?=
 =?utf-8?B?TGZoeGg3dEcwWlVUbVhMNG1zYmlQS2JtSkhtay8xQkdZQjFlZHE1R1h3QnN3?=
 =?utf-8?B?enUvbTJSNEdRYXFDenJTcTFvWXYwZFUwWlV4Njd6c2diUVlMRjhqRy9CSjVV?=
 =?utf-8?B?TnZQL2NQTmVEQ3N5UmYvUzdpZDZDczMwNFhmYlVtZlFHVEVOaHRjK2NTVWJz?=
 =?utf-8?B?NGh2aFVlRWJHTDJ3UFFrcFFzWlhYM1BCdm12Yi9DWUtyaldMNEt4MXhhOU4v?=
 =?utf-8?B?NERBMlRVdjRIY0dFUkE5OEZPdktJbXVLdG8wQ3pROVU1T1hSUk9aWjdZREFy?=
 =?utf-8?B?M1l5ck5yWVZSdHNBcGRLb21MM1Y5TVRzZnExL0pPWm1QRFMwYkJuTTBoMG10?=
 =?utf-8?B?c29GM0VIblcwUlRSVVIxOUdERzBXeFFvMU9SWEM2UXZQVElTYXMyRW5Id0Yy?=
 =?utf-8?B?dWZDWURZRXpXR1dkWmxITXpxbVp5YTBPekVUTkQrcXZSVVFXMi85Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ae7050-5e48-4549-f89a-08df3fd5b81c
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:25:26.0349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/vdVUMAbBwJODNDVo+LO5rTHCC4U3lFLBGr6BIOfu/KDRYjZPh/+q8Scko7YuLluNycDC4+3jmWWUj2yr5/Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB8830
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

On Sat Nov 7, 2026 at 2:03 AM GMT, Danilo Krummrich wrote:
> Add a Minor abstraction with RAII release and a fops_open() wrapper that
> holds a RegistrationGuard (drm_dev_enter / drm_dev_exit) across the
> entire drm_open() call.
>=20
> This guarantees that drm_dev_unplug() in Registration::drop() waits for
> the full open sequence to complete, so all files are visible in the
> filelist when iterating for cleanup.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

I wonder if the logic can be implemented in drm_open instead?

Regardless:

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/drm/device.rs | 63 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 62 insertions(+), 1 deletion(-)

