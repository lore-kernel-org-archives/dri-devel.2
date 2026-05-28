Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4316BCD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 12:56:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A23410F13C;
	Thu, 28 May 2026 12:56:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="XaqiAI+r";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021099.outbound.protection.outlook.com [52.101.95.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E11A810F13C
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 12:56:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUcmfIvCFlbdJdxi8OV9y71HuF4xFh+NB07v0eeqiX/Fnck2Gw2wMAoDsmpco2qmwD5TgCUe6oPcmVuDzDcWnrop6Yn2u3Lxq7C31nzZQ9Osaf2TXIlJthjJc7q0dmW2vRj0xjr2KUBEUmx+JZfSodMLeUctw2fQiH+F4VyQ6AuzxPIiiBWw+eBUSyj8/U9bP2F/MEW6P/G+S1Gub8v54IXvEpGtBHxC/a5Vdk0vymZzCpSk5AP8u1czvjKmJiVOd/MAQEcyjdUv9rdKaPl0FUpg1UISaVjJYS4gzUpF5P98wJ+pmtK0QkbRTbkuGJyHVbUY2yvSd1VGVb1VgwLq8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exEWWo/jG/SV7/FxyqFfpFU8vuRAe6+HTca5trZtNdc=;
 b=naaWM7tiXBEf0xlr5Ee5wm//K7q9Y1R5pg4zr/D6j+ptpnUuD1TcJPF6hJ54eEXkBgxAwpm4A7Fm1JL5+GhD4crUVq3cpXe29NF/HLuqsH2otYyXt5vmMlML1FpgDKgU8iF+LKEu8KMpv5bJtZjFnm6TJ042YKD7yJ2DmjM/UoRWvEoN3vEf7HUOg606W5q31eaLgcLgCGpnLvmuVCOZPgDgg4EOiJIudf7ALkg6MFncjw0/g0BuFHd/GxT8Gy4K/JniszBakNfdT69hPY4J2QGNFSoENSFAkUeE16AV2GP74bu9t3/xYRNAfWpG0ZPJlaCmqO/paao3wpkvvq7XMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exEWWo/jG/SV7/FxyqFfpFU8vuRAe6+HTca5trZtNdc=;
 b=XaqiAI+rA3wZBf81ndod7XycDii0jaGiveauIqkdAer6DXhiR24BkSq5dmL5N2VKsquxLuAHg3Ut0u7xROSCyboKbVYKDiO+s6XpR34FH3btxDffWItlqDGAYjtdyb+8jjn+mitsQusEpGOuN5/jv9u9TqpsaE98ouY7R8Gemew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5987.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 12:56:07 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 12:56:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 13:56:06 +0100
Message-Id: <DIUBR87B0MIL.1DQDI5WUOBM0P@garyguo.net>
Cc: <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/2] gpu: drm: tyr: separate driver type from driver data
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <aliceryhl@google.com>,
 <daniel.almeida@collabora.com>, <boris.brezillon@collabora.com>,
 <deborah.brouwer@collabora.com>, <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260525230152.277820-1-dakr@kernel.org>
 <20260525230152.277820-2-dakr@kernel.org>
In-Reply-To: <20260525230152.277820-2-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0290.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::17) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: b282314e-a2cc-49aa-db65-08debcb87ba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 0JTj1UQL05cb4XR/mM801JmNDFTjUexCC+OO2PdJvNMQCn5p7ptFxaMg19jJOfObP+XwPDicJBkqyy0XdB0bR1Mdd4ExILpcAp+WhBd4vu6L72G7uFWt+/YL7rFbNZC3S5T3r3SoQUtR7YkcnBM03XPBsdusEuxoi7CbKqgAtlDW5+9HpEci+E3ZslT7ZxwDFbqENI/o+hQevw8ZMYwRbF9wbEIzy/QJjjuCJ7SR31iaI0Ng8QS+pH/SKmznkaxPfOPzbY0SVxwmNc2KfutTUbwt27P2dv9rYDdkS04MhSEcx5VqnDNueL+OGJIOm9YD9R/6Hll2wmz1o1hnzOiXopKhLYvo/kT3tYTFPQoOfkKjIt3NPJMxzNj3GY2R57RiLFfL2gQWlaTxFzQ1QTPGpGGp8Jjez+Lw27igV14gWJ2qXfXVG6awAQNfsWuWOwEPttNBckjYgjv7PANAtAeSk8vvNK5vfdew4lgKUODUPPwL0Q8mVTOYW6LPpZnWBJK9q8Sbd3kB4mlrzcxQc1vD4HuwE+9eoiZsoDTWC4oRwqx4nzW6mjBuugDHsq7CUgVoYjNqU7aSGVdd94saZJqh7BTlkj5RNuI8lY9MSHlJGq5r8zDlqxsQ9vAxJZjtezmA9vd2Hsz+hT50S5Bv9IS4Hv/qJzOAy0sQZ4Gua+AUVhkJx5V/u/tIra+Zyt6g+DYN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emVLL0Z2TnpjdVl6eExOVkU0TTRJY01nOC9OU0czTlZjT1FCNFEwa2ZDemoy?=
 =?utf-8?B?WkcvbFhGWGo3am1wME9QNXo5SWMxejBGckVxQ0dYOXB0TDVZQlkxUWtTSk5r?=
 =?utf-8?B?VkV1UWZxS3NVUUZLZXRmOTZQUllxSklpK1ZxT1p2V1hoeVJnQTF3RTZyQWNL?=
 =?utf-8?B?NEZQUnh6U0dpdDdNN252dFl2OWNpVEk0V1N4Q055dXMxRFpQSEwyYjEwTC9U?=
 =?utf-8?B?TUoxK09MMitvb1JTYXhtMHlTQXpkR2xiUDltWlJrbkZtd1RaS2VSb0NRQTQ0?=
 =?utf-8?B?OEF6MTFMVWFTZmpCL2s2UDBXazZCMXRaSTVQMXYrcDlQaFhGNTB2R3ArRnVu?=
 =?utf-8?B?MnZWRmRIbmI2N2tCS3F5YmN0WEVxQ2trbGw5Z2d5LzlBUDR6L1o4czFEVzRC?=
 =?utf-8?B?WUhpKytRdTB4Vm1FZFB5bjdKUGhJYSttUGhxOFZ4REM0VFM4OTNEN24xbXFX?=
 =?utf-8?B?cVAydk1BdXNrYmtmQ1MxWXZGZGc1dkNnaEpuRlc4aWpBdDM2VHhZTE9mK2RD?=
 =?utf-8?B?UDVNejcyVjM1aWtDdG1tQkVHRjcweHp2RDh2ejdjVzZYS3J0eTZkRVFiYXpW?=
 =?utf-8?B?UHV2aHJiNFM0WlF6Z3p1TjByVi9oTDdaMzRzVWdIbXVtalc1UU1YbUtyeHE4?=
 =?utf-8?B?ZGVRZWxuUGJoTXdCZ2ExNTF2ckJpSW5xZHV6UkJIR2hidXFLaXlDeGt3VVNU?=
 =?utf-8?B?TVdBMkgzVTAySVBxNFlOS3kvYUhzSUhWNy9OTGV2aVBaem1TaHAyNEpqVjUy?=
 =?utf-8?B?SWFVVnV2aGxyYmtZTWlWVGgySTVDb1NPdzNCb2pKbzJUd1B3d3U3MHF6MDl6?=
 =?utf-8?B?dlB0ekhtQUdZL0diUmpZV3lNbGt2cENZVDZGRHVqRWxidE1tT0dVRVpDWmFy?=
 =?utf-8?B?Z244QVl4Mzk4VWRQYVdQcHdXbG1DSk9sdW14SWVIRHA0eEl2K0hCQ0wwUDVG?=
 =?utf-8?B?a1gzMytSazMxK3BZaWVCcGE1Y3h4NTNaeWszaHhDT2dYcHIxWmR4NnJPWjNX?=
 =?utf-8?B?OS9ZbGk1TllKQ0hWRis0WEtXNENEQUpUTU8rUGllSk8wbFd3UzNBV3ZaL242?=
 =?utf-8?B?WHZ0OXpTc0YzR3Z1cXJwUW5lTjNLUll1L09BeElLSXpYZEJJVVZ2MklOZC8v?=
 =?utf-8?B?bDhIQjJNSnltdjgwWENNMzdSL1I1eG5jdWYxZW9IV29TZlFqaE16M2NaOHJr?=
 =?utf-8?B?MVR1TjV5d3o0WXo4cmExS0U5MFlZOFhLNktzQWxiRzF0VlNVdVd1ajREdzBU?=
 =?utf-8?B?V1VoM1NNUWdDTlZkRG04Vm52OTU4SWZHRmxpbTZkSCtaakEwSVA2WUpUczZv?=
 =?utf-8?B?VVNTSzluRG43LzE5UkpZWWdCY1VyM256MzNCa3VuT1RwMTQ4eCtiYkhmNG9N?=
 =?utf-8?B?Wk92MVhSaFUxL3psbGM5bjRmRFAwdWlmYmJYa2ZvOXJyL0Y5MDcyUlk1b09W?=
 =?utf-8?B?dTcvN1FYeUk2VksyOHFTMjc1dFpiSEx6a09CL2JNN1VPeWVqRzBUYm1WWVpQ?=
 =?utf-8?B?WFBuOVNUdWlqbFdIQ3oxSHM1cm9NcWFFZ0dlTXZ2U1FpNC9CbmRQeGUwNDVR?=
 =?utf-8?B?WnQ1WWFiRDdBL1VROWkrNGNMcjBBZW16VytPbGRVdkFLaFFzaFVYeWQ3aGZo?=
 =?utf-8?B?aDFMcEhtNVBuWjgwMnU5aHpuRU9vRXBNQzk4V3pwYklGRWlGN0hyeUJ1dlhW?=
 =?utf-8?B?QTQzb3ZSdm0yZW42MFU3R0p2Q1dxYzF2UkFYYVJXc2cyOWUwYU9JMnZJbGdQ?=
 =?utf-8?B?Y3Q5Mk41SmtVS09IVVlsdEdGMWVuUjhZSXFud0hWRGllbHhZWFJSSmJ5Q2lZ?=
 =?utf-8?B?SkV1VW9ROUhGQXpDakF5OXNOcXREbHlwbzlWK1ZIbWZ3WnpYUGE4dG83OXFq?=
 =?utf-8?B?elExRUQ0TTliWGMzekxQUnN2WXJSMXpuQjVnM1pKcXlyenVVaTZVYXhQeHJH?=
 =?utf-8?B?TGNESHR0OWYvSEY4a3hLQzhUVjF1UDJQL2RFOUdtdnBEcVBXcjFIK0wzbXZ0?=
 =?utf-8?B?MlZSYy84V0FlSzB0QWdEVENwaFdzM2RLZG1JQ09hQjNibmUzVTFzZXVVNTBD?=
 =?utf-8?B?VnUzWDdrNkljMGVYUG5lRGo1aXRjVzdXak1BcmwySEh4bzJJZzA2dkpCdG82?=
 =?utf-8?B?ai9jTWNDa05MWTNIb3NmdlpGSFRRZzE3Y1BGRzJXYnorWU9hZEFsekwwcGhl?=
 =?utf-8?B?ZkNQbUdDL0pPcGo3a0ZCbU1aU0sxR0J3TUtYekx5RU1sN2gyLytnUW5RKzV1?=
 =?utf-8?B?VG1kU0ZuL2F1S2tFN2RwUEtKNTdhbjJGK0MyUXZZSUNjbmZXbEYyVXVydHJY?=
 =?utf-8?B?Z2c4YXZFWDBQSnVjK1RsbTJxUnRBVFh3OUkvY1JjNDhNa0RjbmJoQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b282314e-a2cc-49aa-db65-08debcb87ba5
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 12:56:06.8361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGPlinbqH3c2OG/6oV9MzVnRRfkIgpRwpK4/X8DO7s5UUCM6pUZWjs/e2w2BzWXLVcgZY7Bwo5bjiT5xKdg6xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5987
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

On Tue May 26, 2026 at 12:01 AM BST, Danilo Krummrich wrote:
> Introduce TyrPlatformDriver as a unit struct for the platform::Driver
> trait implementation and keep TyrPlatformDriverData for the private
> driver data.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/gpu/drm/tyr/driver.rs | 10 ++++++----
>  drivers/gpu/drm/tyr/tyr.rs    |  4 ++--
>  2 files changed, 8 insertions(+), 6 deletions(-)

