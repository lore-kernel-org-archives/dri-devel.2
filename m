Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CAC606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=B6zZgX2G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E872910F5D8;
	Wed, 11 Nov 2026 14:50:27 +0000 (UTC)
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022128.outbound.protection.outlook.com [52.101.101.128])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74D9A10EA4A
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:50:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4ILld7oaUbQrGpJEX/t0/Dnm+jyIUXGyrbvyN3iWVNfV3QFMPbl6euBAcoxGbwH3SPbX+mHKGfrfEG60A6W/iQbE1wDlssfkaAfOkJICl6WaHrCEYUAhMpOsrFWhe2DOQHsR6Ruqxa+ql0g/ApQ3QHvMjT+4ziWbHdfpMX+4dXk0plBdV/8pu+5T8zEeleDGxXEXKGI+k+vbr9lK6bKy4+V4xOcE/q7EvDwnm7ugTgagyo3C62dgIdQ/Rd83Il5SrPt90eOd8VuNZ32vgHEWEFJnz+jcrIpejHPEz08ULjo4dkAnwmU4q/JBXbj0zaZC+FzQhdz3RTMIG26xHIdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwcThwReGt7fXa2UvkjLM/2U7zUMDjWfAU1VRDTQZ/U=;
 b=fWXxFbPSXEEsuF0vHfTHmbFytnb9DuI08135/mBiKHZ0Vej76BLxYkZO7ntE9vcnaV0O/c34QR7mZVkeO2RAhVTFHNctRusxWtprSjw7aZ/C65juxmbgQVT3Jacgwjywsg1w0CduBZvibQfZ1lkBFf8v3dFrNTl6CE7u5cPqGE4GtW5d4cr/FO9BSJKbyCBNsk1fYCjxt4eOa0Mpe0Lsg7/V9MFpm79KqJEqqEG6OSrr9Kc8mZ7mbSqZsAR/sgzrXSTEC2BB/9o2TVsayK1VP7DZb61njKFnYftXB8p+UhzZyxyyHWEPPYVmgI8gK81XJ9q2FFode+17GifJB2wDIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwcThwReGt7fXa2UvkjLM/2U7zUMDjWfAU1VRDTQZ/U=;
 b=B6zZgX2GgiOaOCyegWH3viywZOe8D8DJIDaE8UgUZRJE0apihfWKoMzcRR70dEJ08P07Ye9H422NpYOgNFhQ8Fgy58FM8CO5gDQA6nDF1l/Rds4dFEyjv5Hu3vri2tY4fluoQX/tqTD3TGXjOnjm6HwInXj0767E8XJcAVMT1SM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO7P265MB7698.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:413::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 14:50:10 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 14:50:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 14:50:08 +0000
Message-Id: <DMSGRISBB9SJ.2BW4HDF3LY1AU@garyguo.net>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v6 1/2] rust: time: expose as_nanos for clock sources.
From: "Gary Guo" <gary@garyguo.net>
To: <airlied@redhat.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20261109-nova-timer-v6-0-5544a3bd8b28@redhat.com>
 <20261109-nova-timer-v6-1-5544a3bd8b28@redhat.com>
In-Reply-To: <20261109-nova-timer-v6-1-5544a3bd8b28@redhat.com>
X-ClientProxiedBy: LO4P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::22) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO7P265MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 85257458-5f7b-479a-f9b8-08df4003152c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|23010399003|366016|1800799024|10067099003|261028144727099003|4143699003|56012099006|261022105027099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: fZb6g3LV5kgKWK974MuYxr4euxvd1LvCLSY9XV5nfB8bKQXG9ILqKLKAPv89PT2KSzVCw5aKwGCG4g8GOsQPCqxxNZHEWDVzkUoPlgI+qV4vOU3RtkovEGRJ4qxfKZ7WqigEFx7KMrCGVF6UoSxMnOmB0cDjmImT21mKSmprzyFWewxyz2MdufZomdmV2uFMSOJPOqjEn/eV3dBIDaz+qaYQGesLNsp4reQqFWoWy+Sf2/PrSGvq7dyfaQUzoU9eZ0uDqo5PCkP+zSFI+WOq+0NnI8uSAOEi+lcr/DqPtOwHevw6YrSMBSWu2gXDbxP3mTuAOJUu9vqUQNekESjI/yuwWX0HkebFPgh9kxa6bl5cMUdL/LyfkbD5gFpkm96Hb+XeJg8oRdJZy+j7x7tMpSJg7m+0HHx3CPIfmacMRM1jfdumHM7PsrSgfL3Zp0IRMgIVfP5pq7JN5H0BFhheK5lHiKUgxIu4eDqfWgnf/mFw3XMJwQsVLBenJu155Tj8FfqqCvbqw5IU45Z6wpuZ+uG8cgdUAKTOqSV9qpdbSjhjSOnrLxsfRGpOVAwUKCRGh4PbibLH+6KQbu7RMRQ3x7G9et3lfcSgvFtaTOrB1D4hETYH8XVLaLA6Q7qq3oc5IoUlvYzYnXVL9+DVZHJSc34lOXqZ8HKXExUEpWmosXk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(23010399003)(366016)(1800799024)(10067099003)(261028144727099003)(4143699003)(56012099006)(261022105027099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261102123227099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzVnck00K3B0N3RxRm12djl6TEZxR1pYV04zZ0xUbjZ4UUlsN1B2bDhTS1Fx?=
 =?utf-8?B?QzA0Nk1lazZyZ2UxUmhtOXgxVkt5UUJ0OUxhM2l3TmJIQ2l3MDhTUWtCRnNI?=
 =?utf-8?B?QkVBS2xrb1duSFViN1YwT2VPaW5NUEt4a014UDNQNFAveFZGcngvWUd3ZXp5?=
 =?utf-8?B?em5EZGJOTEh0MGFQNHNoNVZrbU05am9YeGtTN1NVQVRTZ0FQSDBvNFl0OHBz?=
 =?utf-8?B?VVJ2amZ4Q0t4RjdXVC9vQzB4Sk95SjEyeU01aGlteitJb2xOc21FMFJUekVy?=
 =?utf-8?B?cGxOQ0NreWNpZmNIMkpEUTVSNUNObVZiOFA3YzZQUlJKOFBTRko4cHRIVmUr?=
 =?utf-8?B?THdGc1ZXNmRSQWdaU05jcnFLZjhDZ2FGL1ZvcmUrL1hZUmM5OE4xRHNtaGF5?=
 =?utf-8?B?Rm1oQnBkNGxlNUoxSXE1bUM0cElnaTlLWk9FeWMwUmlqZ2FxQ0JHQVdQT2lv?=
 =?utf-8?B?cXBFMVpXWUI4aGlueGt2bW02alBVcUgyUDJRR1BNV3lGdE5iTzBkeEE4SWNH?=
 =?utf-8?B?Qm5YT2EvMjZDNHNQc1NBRHdYWlN5UVNwcjFmVTB1NHlPT05VQ3NuZ2NWblFv?=
 =?utf-8?B?QkJ6Z3UvZm1VSzJsbVNtaGFrdWx4MGxURGVCV1FUVUdKNG1RTXNmRFVHY0Uv?=
 =?utf-8?B?ZmY0cFIrYUFYSGU1V3RlYUsrMVRIL1c1eTZXS1c5REl3THdveTRSeHBzNlcr?=
 =?utf-8?B?U3ZTZ2NYOCtyQ09CVGZLdXdNRnR4RVk1cldLTmhKT00xc0Rrcm9kcXJSYjg3?=
 =?utf-8?B?Rkh2NFZseSt0U3h3Wm5LTXFqc01MRWVlVHIzWWNxMkVzWU1GTHpNRk93c2FZ?=
 =?utf-8?B?TkFhc04zZ1ViVEFwQi9lYzV0VCt1OWkrM3djdnpxaFZ4ejR6ZEVSNFdzdXF1?=
 =?utf-8?B?WGc0SlZmdEkxM21YYWMzREdCWmJYank3b3NTb1FuS2pyRnErejJ6Tjh3ZE5J?=
 =?utf-8?B?QlMyU04yQno0OTB6YzdyK0xEa0FvRU15bzJsRlVHUUJtL2ZRQWVuNW5qNFpC?=
 =?utf-8?B?U0FNUWJBTWc2amcrbm02ckN6WjAzeElQZDdJb3I0VE9yQURrM0o3VjVHakly?=
 =?utf-8?B?QUozSnRHcVBTUlFNWitVMFBuUm1kTk5xZHYyaFFLODhTNzU4dUZVNnVsTnF2?=
 =?utf-8?B?VlJSSkwwYnl1TzdSRDZxNnR0LzZvQXJmb1E4SGFiTFBjZFVXSXVSRGZvVjZL?=
 =?utf-8?B?emdDQ2pDSGJlNlYzVHVpckFFTkVNV2xpME1nUksya2pISnlrUVovZHFqenl3?=
 =?utf-8?B?ZU9rVmtRWFlEOEo1WWhvZHRlUEJWM2FVdFZqU3d1OC9uOHlEUWNGTzlnVE1I?=
 =?utf-8?B?bnY1cTNTZS9EM0o3L3A2OXRST0p4QmxJdWE3M01OTlp5alRBQjVsem02b1BR?=
 =?utf-8?B?ZENYck8wMFhqY3VaZG90ZGVQRmJVNlE0ZnBRWmpNTVhHRlE2UW1WKy9zMG9X?=
 =?utf-8?B?VUNLQW1Yanh5bk92TitYRmZOMzlTWFY5TDUyYXkrT3hTN3Q5cWZMSlJ6UmxD?=
 =?utf-8?B?M25oTFEweElmZ0lIczhjUVluVXZnUlluLy9zS25kVm9TcDMwRUtDMXhPQmdh?=
 =?utf-8?B?WmtRZ20waCtXMGRJbEVTT3MrRkZPRGlvWmZPK3JMNmsrbXd2d2pFcUd6Uk0w?=
 =?utf-8?B?K3JBV0RaVWlablk5RFFPMjc2Z1R1S1NCdVkwVjF3YVJVZEU3WFRIbE5iSE9w?=
 =?utf-8?B?cGFheTJETHd3eU5sMThQSTM3WTB0WTBMQnhHQVYzV0FXNjVVWk1POWhhZ3hR?=
 =?utf-8?B?RVJURUNma0w3ektOelc5cEpnSkFBdldtTERCdStlWXhkNE1LU3RsOGl2c0V4?=
 =?utf-8?B?RlVhb2YwYVd2aHJPWUhOcG40VWg2NFNweWl4STdBYk5aWTdxOUlTRUlkRGgv?=
 =?utf-8?B?bmJKNENaM1p6RUM2YlZzR0hrcHBEM0xybjFQYWlRTXdDOWxiUDlRejFBSkxq?=
 =?utf-8?B?OUVMTkJWZHBzUU5xcEJVWFdzZ0grZ25UclVTckFxaS9BWTU4Vk5iTkNMWE9h?=
 =?utf-8?B?dkhBeXExQ3BhQytsVHZ2NlNmYzZOSG1tTzBvUEFzR3loMFF6STZITmtEYTZh?=
 =?utf-8?B?aDVEdVdlYXhtZ0xUQXZnYktGcklLcmU1R3NFZlc4a1dueFQ4NXNlbzkrQ05x?=
 =?utf-8?B?WlhDU2RnT3VYdTdndHlZeFpDKzBDMUQvZ3FGQjZYWVRIWjNxQTNFeHBtZlIz?=
 =?utf-8?B?UFlVdUhrU1hBREVGWkV1a1FXakp5b2t3SlRpK0RFL3RNZ2ZkTk8rTHJrUnQ0?=
 =?utf-8?B?YjM4Mlo5Nmo5VzJxTFBNK3RDTFlKSmVSNUdqMlBxb2FsY3dmTmFEL2JQbGJl?=
 =?utf-8?B?dWVOQWpQNlF6b3E4cEN0eEhqS3ZRVlVjU3BsS09lUExjUm85UG4vdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 85257458-5f7b-479a-f9b8-08df4003152c
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 14:50:09.5926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhf5pQvPy0d88AdtgFogH+CDjiT/40CWzuzxK/3eMKpZeLO/KyWUNUbz9JWV679mvIZotFpTivX5TB0r8vjkwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7698
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

On Mon Nov 9, 2026 at 1:55 AM GMT, Dave Airlie via B4 Relay wrote:
> From: Dave Airlie <airlied@redhat.com>
>=20
> The nouveau C driver does ktime_to_ns(ktime_get()) to program
> the cpu ns into some hw/fw, so allow this method for rust drivers.
>=20
> This is needed for following nova patch.
>=20
> Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Dave Airlie <airlied@redhat.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/time.rs | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

