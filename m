Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0F0FF8864
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 06:13:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BC9F10F4D8;
	Fri,  1 May 2026 06:13:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qc3VfKas";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010061.outbound.protection.outlook.com
 [40.93.198.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C111A10F4D8
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 06:13:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ReM20B28VITkINk2+CB9xrmcRmwmqeBiG0fRNxIH+mtVFL/ABUaC9m6ttyaVHM34y7FUO8X0QQ+CW8BWH2HTuj58kYTXuQq8BZMQEdsPtZFVUtM23TYmgxYOZ5dtCuRLZmnbXj25eTVwqVgNy79KRh6Vouewr5B7Vmh56ICVJJ6XB9iANPqR9i97QCPdFjhc7vu+hqrdtcfH1HeZMrEi+erJZnNXY/11/a7NlOjZpz9MTRKN2vjr6LzJqmAfXVNzdHfz0TqeNIDEK04svJu5XE3VWuKe2qsFFC2GjokLsINXN6E/g1CbFf8ew24LcAw2VbXYiGw0vCPQQl197R+r8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLbdC0K/N8GPxE0OZ1ENcrS+oKjBdlHf5Kgsrwue6YY=;
 b=QylptCA9n15agb+jyTK2prvoGytyMaBYDLZl+h2q8c1xXB2ggP8OuLHVJu7ner81hFnt/KXoQI2RHOoM1cmQGFzSgfto+RY7QeiqDkIuSE4CBdnmFtTVbgJk3L8X4EtGh2XDY+6HsVpJXxFHU36lNKBRH3F8qSrA6KqBYRie+/GbOIaXncoTyz+f3ZPkVWB9PqDA8sTpJzrlbzw2SoGRmsJv3+5MRKkuvKRVBhdV8CAwc95sjIcpex4GXIor2ATdU+nvHZOjP58a/qzoeNJjnGJknZnzakHGGQnlzjYIXWPOQWuDZbCAb1NUA7nT159b1GDFEwmVLB6Hy96eYA5knw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLbdC0K/N8GPxE0OZ1ENcrS+oKjBdlHf5Kgsrwue6YY=;
 b=Qc3VfKasHLjt9Ctq0drJdTihCHKY60k6Aw8fGI3Fk8oR0qprkpZijcRddqXp70GpTWxGP1c8IPsnAjLIyjo8vk3gGsCCMd15kPrrlElnTg0KOVXYHT5ZDyWgWkOIuGLBKH/QEabhrEczgZ5Sxs9z4N4V5p6V9tQ+CPSankTW7QMwFWjBD9QpTRQRdHRC/raGn23XyurvwfqZqdhyeFx7zRtwVUVoQ/swwsNwGmUXZ2wFLzoC+P5M6Xwi2fwF+pXe3MDdtTjKLMfdtJpGy9MS+yzG1iDE5ciz/p0CSnGZdrxnQifMcJQeV1NZQvfx2FpVvhdO46c35RJUxEqot4vqfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.21; Fri, 1 May
 2026 06:13:25 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Fri, 1 May 2026
 06:13:25 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 May 2026 15:13:21 +0900
Message-Id: <DI74A5EHEWFM.1V16VEQUEVMBW@nvidia.com>
Cc: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Boqun Feng" <boqun@kernel.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot
 Courtney" <ecourtney@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] rust: add warn_on_err macro
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260422-nova-unload-v3-0-1d2c81bd3ced@nvidia.com>
 <20260422-nova-unload-v3-1-1d2c81bd3ced@nvidia.com>
 <CANiq72=7u5O_58b6cnCwGz=j0D1tmf5+9Ntv1mkJZpACWXQpFw@mail.gmail.com>
 <DI6L3WUV1AX9.20T2183TYVJQR@nvidia.com>
 <4060e63f-010f-403d-af18-5d6c94763745@kernel.org>
In-Reply-To: <4060e63f-010f-403d-af18-5d6c94763745@kernel.org>
X-ClientProxiedBy: TY4P301CA0031.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a67deb-7f0f-473c-9496-08dea748c0f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hKK3pxzWmXuq+TcbYgBqLjFu7MPKuco+DIAw9bzBGlDhBErD7e+auFfZRVW6xUmb0OKji/ZiK9qbWvp5OguKrbvEtX19w5f7948pWbntZa9nP+kqY+5ZnfwREOEAWR514dGnuSi8WJm9NO5MVRGxIMWqlUg5ZV0fUuZe94GOQ9s+cEKypx71+b++O8MvGP0G4AkzfpCSgkJKx8fBwnZzk78xUn0r0VtSLyD4i7iVJ6xa4K+aDuMUO1DLl5J36aZDfzgOhoeLbD0LPNjSn3yJbBvaR0/dVCzghI5liL3O4VrqJmw7XDjLarij8tTEjwHNiHP6gCBRomaGmJ3IKpj3Lv+Ej9xUCAf2pBElbLvSaGtFbOw1r5AnmGxFWu8eq8O+hM3asktvSRqINlrQmL0L23Eh4N//OnIATdiWqe2SP11Tqkq6t2PVoYdHzIrL8/uHY0b2lgym+aJroDnR5HOHEkZfT/xFdcHrempKDRVZliXI8wm0QRd0mhESJAym+WRAfQpdum0GH/w7n05z8nsGzPD2uqrZiHW7n/6MNRMw4cPuJHlE4tsxkLDNqhLT0n9qGfjw/XNkFR6uO0Phll81j+INhjpGGrCQAovMKh+A2sQRlBwkqrPz6ebjZ69zD9Qg0RR7yHv2MJzzVKwKeoj+tO4lxMrc9T3e4fezDR56p1dCDFYY3nebwZcq3Hqdyn7F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(10070799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U29rSVQ2VUw2ZFN2aE9jY3B6MjEwajBBOE4vTThETkw5ZW84VkhDaHg4SC9o?=
 =?utf-8?B?VHlnYXpaYUV4MzFneFJHZkNoV21TaU9JWVozNDNXR1gxQmE1Y3gyN1Nuci9G?=
 =?utf-8?B?bmRZemhpNFg2MWdmVzlrQ3Y2MHBtUDVaSHZiNHFDR3g4SFNjejBBRmFBNldt?=
 =?utf-8?B?OXkzamNqNkl0K1hFRzFudUJVQStEWGNDQlN5QlA3NU9nTzhwT1RMT1gvc2Qx?=
 =?utf-8?B?ZVYrM2g4REtzMTFaTDl1dFkvU3pTQlNjOEJ4WFpVNTRPbm5zcThuUlFyN3Vt?=
 =?utf-8?B?ZlJUdGltZ1N4WUEzYTg5MkFjQzc3M3lLbXVXRnhUMGtqdVVBQWMvSnNveUpC?=
 =?utf-8?B?bmhIZDYrcmRzWGFEOGsxY3JVWGwyamk0ank3MDhyZ0hpSVJsbHA0c0V5QjFy?=
 =?utf-8?B?eEsyamo0YVRjRGgxcGNSUFRtNzh6a0x3NGE3ZW9NaTI0dlF3QUdGZHdxQm5Z?=
 =?utf-8?B?Njd4TVZTWU85QnZFc3ZoekQ1RVZBaGVHZU54TENBTzRmWXVEbmhZU3ZJeUdT?=
 =?utf-8?B?b2E3WHkwUzNteXNOMElVRmxiKzdoU2k2akZtei9aRHNYNDlDSjZpRzBIZFBr?=
 =?utf-8?B?VTNncUI1Q2dvbHFJNmY3NEpaTDNrcmUyd1ZYcFdhNG5UbmZUL1orV0pjdkQv?=
 =?utf-8?B?cU51dnZaNTRxUTBMVlVFWnBRNnZXOHRwajBZVXVNRFZVYjJ4ZEU2WC8yQ0da?=
 =?utf-8?B?Tm9CelQrOU5KaHQwcmN3U0pMNUN0aXZoUmszK3B2VE9lSHBmTmttVzFsdjdF?=
 =?utf-8?B?ZHRmMlZtcjB6N0MwbFViSE84akZNQkpaQmY1K243T2h6R1kxSlhlSEdyak9m?=
 =?utf-8?B?eHphUXpSTXMrdDQxU2wwNFRjMWRhOFNaTVMrbkZNN0xBOFBTQTJaZDNnNzls?=
 =?utf-8?B?MUk4T2Jjc2JDMVF0UFNhRlJJOXd5UnRiN2l5OFlONGZkTlplM1NTOEFMVGlU?=
 =?utf-8?B?SWs3WE5mT2JkLzhNTEl5S1RaYTNEaHh6UEJ6QUhxejdmckxDcWN3YUlMTWJx?=
 =?utf-8?B?czZzeWN1WUUzS29JMS9zTmgrVlZIVjIzMGMwNVJyQkN0YnhJR1hLTXRmSmkz?=
 =?utf-8?B?am5Fdms3RW1aWmpXbXRiVXpoVXljVTc3aWluMjk4Y09DeU56OVA1UEx2Mml4?=
 =?utf-8?B?ZXJIdE9hZGJHOTEzVzdQeFJhVFpRNnVvRTdHbEloeWF4emhGY1FQMG4xQ0Rl?=
 =?utf-8?B?T3Z1dUxFdkl5WjJxWjRHb2tIeTBPNHlnWVZ0aW5SSWplTTBiTDJjVGJvSVl1?=
 =?utf-8?B?RlBKQVNwQ2pXenhmOEtXeWcwK3l5VWF1eEVaNXRBaHZJcGpCOHdmTjNOa3kw?=
 =?utf-8?B?NEVOeVByb29lMW1kZ0t5UVJDaW5vWThXS1N0dGRmd0JMU2h0SlFlWk0za01F?=
 =?utf-8?B?aHlVK1VUMWlkRit3am5xSXlnNHk1SXFwbE9vZm9IWWk0R2VnRzF3bWNOZC96?=
 =?utf-8?B?SHNFWU5yallJdC96TnJ4c215eUs3amNTNHVTdm56Y0FMcG9jRzhuYm4yQXh6?=
 =?utf-8?B?ajRFL1JVTHp5a2FxNGFDNDcxTFNqR3dWck9WeDFRa25IeWc3VjBuOGZsbGo0?=
 =?utf-8?B?TFgzRTB1UXN5R3h6N3BmTVExL1VGdDJSTEtsZS9sLzNlYTBPMFlhaTFacjU1?=
 =?utf-8?B?d2l1RThBRnl3QmhNdXZBSVZjOXY3dytpQU5kUDJqZyt0OHY1eVVOeWZtSUph?=
 =?utf-8?B?RTIzaWV5bzI0SDRmVE8xaU1WOG1GRWt6L1NRSWRwdWdTdzhDaUgrSFlZNHll?=
 =?utf-8?B?YTJhRGpjU3NNQ1JDeTFZY0Q5UnBLb21XWGFXeWFQVTl2K1NQaEhCMkRaSExC?=
 =?utf-8?B?aEROWjZ3ZnJ3c3dhR3pyYlk5ZjB6U2ZHRE5CNXBFQ2RHODBxMUJmMk1yUG5N?=
 =?utf-8?B?bGJxeXZSelBvTWgvV0YzQ2M3bUI1RHJUcHZhbWZXVEhWTXRvK3NaQ0paOGlq?=
 =?utf-8?B?M0E2Zk5MZjJLSlZ5TlBvY1FmNzVsQWsvOWs0OFJ5SFcxSWdsUUFvY1FSdTdG?=
 =?utf-8?B?VmhDUm1MNmZ1clNiaHVPWTFpeXgxak1wVHRHK1pVZENoOC85MlBwSWhwdFdL?=
 =?utf-8?B?enQrVUpNQmdrQTFvNXRkeCtXdXRzQ0JDZ3Q3bUNVK05kVXpNeXdpMEJOWHhY?=
 =?utf-8?B?Mk9HS2JWdHdySjBrdm4yYkFtRlptbGswRUt4K0xTWU5JMmp0YWlDQkE3Y0NT?=
 =?utf-8?B?cVFoNmJuWW0xNHF0NStuY2Fqb05uUVovdFVuWlNjZldiRm4rOGkxbUMyK1c4?=
 =?utf-8?B?NGNaUFRNd0FrbE11QkF5UEpLZHJlOFA3c3FBWWM1U2JLYXZTZkNMenBaU3Z1?=
 =?utf-8?B?SExjRzh6UmQ1a2d0THVqZEpROGxBdGFhN0I3MDhaRFpTS3NCMzV4VUtBay95?=
 =?utf-8?Q?EvjgByTgNHNJ0YgGYapGWf7+EO9U0jnvJVnR1XQ3Xj+iC?=
X-MS-Exchange-AntiSpam-MessageData-1: 5K9LA0JGiB1c/g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a67deb-7f0f-473c-9496-08dea748c0f4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 06:13:25.1839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHHlRpfHTpTsL6l952LldCd05gOil2lXFRWbbBmLneeAytgSxmLqFYM7OzX3V0qV51plQgtGbp5ms1JTb+TTZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913
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

On Fri May 1, 2026 at 12:22 AM JST, Danilo Krummrich wrote:
> On 4/30/26 5:11 PM, Alexandre Courbot wrote:
>> Thanks - I will send a separate patch for this shortly, and take it
>> alongside the Nova unload series if it can be reviewed quickly.
> Do we still need this? It goes away with the lifetime series.

Even after the lifetime series we still have this bit:

    let _ =3D self
        .gsp
        .unload(pdev.as_ref(), self.bar, &self.gsp_falcon, &self.sec2_falco=
n)
        .inspect_err(|e| dev_err!(pdev, "failed to unload GSP: {:?}\n", e))=
;

where `warn_on_err` could apply, but it is definitely less essential.

However, since that pattern is likely to be common, I'd say it still
makes sense to merge it (albeit outside of this series).
