Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA5DFEA806
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 05:53:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0BFF10E0BC;
	Wed, 25 Mar 2026 05:53:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lLS9UrNg";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83CAF10E0BC
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 05:53:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPAW1f9LhuRawPN4Vtrk52HOqp1uBa1rgm8HyrXIm9/Wtk7Vzbl5uUVlPaauUm/9LzRYSrF8KxwUcgO6Krf14a4b+6yo9fAULCnUFAYyqlpFhCZirm8raYyFbGv+udpjEaBNT4gZfcQAPNsFhDXufW7tRk7pmwXA4XkGqUOIeRMlHxFf85do52dF21/Lx6+2Yry4fKZt6otW5wFmQ2hXl3VxHCHuQDZUIHxCNqZbbqnAhrNv7hjiqoQA7x3VvEFPhYH7bjwXoDKsNb1fXEPUHgeEykjmksFOBGNTcDA5b88AWropOnhUQHwDMhUnIb2Oyma9d2VY/OWI2UJMbPeSZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7ma0TFlaonhs0DxONlL1ZI+vvfVMINp6ueDmA++YnE=;
 b=ZY9mgEX4sxD7ORsAhoh/mBmQX41cPf9mOUoTGYOF/wIY7VxVBlKIHPzo2MLFXB5ZGzvVfBtol3xPTdcaMIme5NRhZr4bPYlWPBpY5ITpw/3bC3wlxvX+y2yO0AQDRwMhZzV8MSXBWl11pwmGH+Q3Zpp1KlY30ynIcKrGReMqvl+y4RFQ3AXxY0XaAQO7GgwZAkdz97qiORTM7/J7ZY5qJa8dJPszWgU9w9duDkXuMDGrSRV6j5jEfldqWMvTX8Zm0vl8s2UcprpZHBaFAq7X4CK/IgtxFEFz19AV1WwpQFbBWVbbHT+EAv/6ZKt1if6ZSpK2+zd8i/xdGwF15OYZFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7ma0TFlaonhs0DxONlL1ZI+vvfVMINp6ueDmA++YnE=;
 b=lLS9UrNgr9A+s475nPClopNd73sKzH2vApnj1O+1iePMTtFL8J21nZdWKJExFDQZnbwO3O2AzI4djfa+L2RsbK3tzD6Ltb3EEC0aeNgmvCkTTGwY9DfW1sJMKGropS2yrC1tS53j88ejmJ8MJSbVUD+GZo9Lqs9tUVo/JCRGOn+JI5WEgYPXpmL1SeOaRyN4gWVe8NS2m3igNMBV/1XmSVzWiLNKMF4AiknutuzQ63QM1WENauq6vJV1by6+kCnNSPfTZu0qftSbwaDylXGlDTkdYRW9YZRuDO36pLsf5kEO6EQMtXkBuKedi1BbKPnhTWiOrIxptrGNWJizPk7TpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA4PR12MB9811.namprd12.prod.outlook.com (2603:10b6:208:54e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 05:53:30 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9769.004; Wed, 25 Mar 2026
 05:53:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Mar 2026 14:53:24 +0900
Message-Id: <DHBMOQ3E1OSL.2VG7175ZI563R@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>
Subject: Re: [PATCH v4 08/10] gpu: nova-core: convert falcon registers to
 kernel register macro
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>
References: <20260325-b4-nova-register-v4-0-bdf172f0f6ca@nvidia.com>
 <20260325-b4-nova-register-v4-8-bdf172f0f6ca@nvidia.com>
In-Reply-To: <20260325-b4-nova-register-v4-8-bdf172f0f6ca@nvidia.com>
X-ClientProxiedBy: TYWP286CA0023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA4PR12MB9811:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae3f9c4-829d-4202-c98b-08de8a32d724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|10070799003|366016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xcedhEAmdBXNb+LMfORQCeK8mp4b/YAs2uhxptgI1nSmrLYOfhFREtPxsLEclYcbOZQ3hIXnYtbjXMFZ2hGyugX5F1ilTmvi7vobW3KirSjuytZSnoHF4bHA5PGa2jrmYzRilVOmqcO40T7MRN0R+ZEvQmdGQMc41G5pL/Tirvpz8A8aIFe39Wlg3OGoufEAw1i0G7UZfN3dIM+/xNsdIf1sKF06gGgvGb0UoV046pRmZlPd1PT3Nwe32DpRdXEduWDU5bNlpLqva2jYnxZS0M1acKAU3yWBYKHXpRo4y7Z07164FtrhwxAluykJS79ioIerogkiopiyNSGWY8iEE+hl3bDg3OHEGU4tR22fkUJlCWlrvwwZ3imr8y6scsMA0QkQyRN0F3JmzmlRJlv+iOv8k5rB2fL5lDinscaXbOeqTumVOkmWdD+kS+H0BA5H0utXMrfIbsaVaB/YPUm1Gz7RXIMdUT+TXvOozYhbIVIVVn+8TkZwEgI+Wf5lExMPVr2J8t9gJV2f7nrAF2zMP+wU+gnTCp+K2Uri2Vw+dRAgRwavTQDuVtCQ/QItaHuEK0tcilG12atdyixh9+3+7U8w1exikTGlfuXYRZoDtscY8Dm3SPAOOhmhN8RD0Ms4Szc2ppX50p5FhMCmXDs+Kxj7ucbvbEQz4urS+7/Y0cMOD7lJ+SSCGk6jBk3W2K6cuu9ezsH1NkgKulifC/9BbnThGUJSPydkL+1hJuVishoykn7oc01E4DWw4KsaHV2UqdBobLcOqknaPXwXWX6B3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1Z4QzhDVkhRMEowUitJVklxWmhCSzJNSmt4RDdYME5ER29od0JmZ1ExdzN6?=
 =?utf-8?B?Qkp5S3pESkxqaU1hNmwzN0ZsZXkyTTJSVHNjdnpEK2kvd0xhTy9xUkJsTEM1?=
 =?utf-8?B?SjdxR05aT2FBNFBLWVNPWmZWck5ib0p4U3lkV3F5K0pxb25XdjJ1Qmp0T29w?=
 =?utf-8?B?VThCQU1pdElMbys4TDk1c3NEblpyUU5yTlNMRTl0c1Z4a0xrN1pZSWEzbmJl?=
 =?utf-8?B?RDM2S0ZaUFB0aWN4UjVraEh1MzFzQml0OGMvV2pBUUZSdmhLQ1NBeHJpVWVq?=
 =?utf-8?B?TGNpcW5GRUxhTmY3RVl2akhnendZSXdqY2hRZ3ZYVTJwUU5MamFHckpYc0ZX?=
 =?utf-8?B?dUxXSXVWQ2lXQXI0ZGM5dHdZc2NMVk1lWUs4SXJvQndLeElROGppRENtemhl?=
 =?utf-8?B?bmJTMEZ1bzRDZ1hjRi9PUWZiZFRWWDZMSWM5UDZHUWJxV2lOM0Iwelc1NTNj?=
 =?utf-8?B?QzhoVG1HSXFad0FVUm5oc3Z1bWRCd3hOaEQ3enl0b3RiZlhIUWdIMWlJUGdG?=
 =?utf-8?B?Qm5zeStLZW9YOWpnRjVJR3R5dTduNlVneHpYU1IrUmVCa2hLSzd6Zk5jMWo2?=
 =?utf-8?B?UDdabFREZEZsRmxPR1JmZ3Y4Q04wWlZwV1doaCt1V1MvOTdKbFFBR2NQTnY3?=
 =?utf-8?B?VmxLZDlSaWdJeGVONFJNTEU0OGQwZ2dRRXJyM2pnZXFyc04vMklMeUR3Ry9V?=
 =?utf-8?B?R1dvcUR4TUJ2UDdPeDM0Z2FITU82YUJPY1gxMTArK0pQWDI2cWZza2Q4cGNi?=
 =?utf-8?B?NWtuWFowNndVcXU5MjcrM042bk1GM3V0UzVIajdRQ1dQZmJJcHp6a202Z0pJ?=
 =?utf-8?B?eVNGVU01cEljTXF2WEVFaHlqb1ZMVm96em1nWEVCZUZxNDNOeDdsbFZybWh2?=
 =?utf-8?B?dUg5R1BWViszTWNPekplT2kwVW1McEFTRGJKZklWOGtIS21zRG9WaDNjVytH?=
 =?utf-8?B?SGpjRU50aDZqY1FWWUN3bzJWc0l0NWRSMjFiWXVLQ1NycXE1OURLVVVNdWtp?=
 =?utf-8?B?Z3J0ZnZkTXRjMGo1NFVQcUVaQlYxWWZYeG1xZkhsMGF2UzRRRmg1cWlmMGlY?=
 =?utf-8?B?d1Fvb3JDdU13YVlOSWloTThVNTMybDFQM2FHeXNOdXM5VVVwV25acmpvM3Vi?=
 =?utf-8?B?YmNaT3lpeEk1ZCtHNXZrdnN5S3lLeitGRm1zN0thbWNhRlFXenBhQzFJSm9E?=
 =?utf-8?B?K05Mc2xuamY3cGszY29lc3dCeUg1d2RCSEk2QjB5M2F1YkdmN0ZBazJ4ZlBN?=
 =?utf-8?B?VFBpdUxZeHRkdHdnZEpuU3JOU0o3V042Wm0wclJWZys4L3ZIemEySjdoMHRr?=
 =?utf-8?B?RkpZNmc2UExvbkVtc3hpa0x6ZnpXQ2Q5eXhZK2Z4WWhScXFwT2xueXFOSzVC?=
 =?utf-8?B?Y24xR3dLOUVCZHg1SGNJWFpoc1VHclRHUk9TQ0xxK3diSHZTUkQvTFFud0Rp?=
 =?utf-8?B?TFlReXZ6SlJwSFhWOVBzckxsN1BDWHd3U2Z3WWZDUzMvUFBrTzI5Szc1cjdp?=
 =?utf-8?B?TlA5SVVGQlREMlQ5dStEYVhKK0VJL3hpMlYzU2E1Ky9CeDZ4RXl2Qmd5Tmtw?=
 =?utf-8?B?b1NTOFRPbFFMNmwzNDk3bkswYjNKSkwwSE1yTnJDendINXZLQTdBWStOWStk?=
 =?utf-8?B?WjhvSytHM0FGSjhmOGVLQ2dTTjFZbnd0cVVROVRLMkhod1hndXozKzMrU1Jl?=
 =?utf-8?B?VTcwOXNXVDFpNVo4UzBOcGZxK0pJZW4wVHp1cHpCeUdvaEpQMitaL3hYdEJi?=
 =?utf-8?B?N3hyRjdxREZZck1XNVF1WmdzVUNsc1hZSEI2enFPeHdUSDdtT1hkbTJGekV3?=
 =?utf-8?B?T3EvUVQzajJBMUxzejZoZy9nOTUwZ2luL1gwOHdwbHViZjBUTTA1K1pRUjJo?=
 =?utf-8?B?eGFsU25GSlhMeElpVTkxeDFHN25qYllidWNaTlprd1FaWjFmOWdLM1lvT0h0?=
 =?utf-8?B?b1c1V05yM0QrV0lrUkRCYS8xNm01Y3FyRVByS2JvNXlxTWRlQVYwVDlZQWh0?=
 =?utf-8?B?RS9KMXkyMkh4WC9QWWZOQ2h5bEZkdHU0SWRQUVJqQkt5U0dBbmJGMDRkZlpy?=
 =?utf-8?B?T2NqQzFvUXlXVm5vSW4zajBsMDl1Z1FPYXFmVWJuRWNza3VQOEpuOFEzRTlu?=
 =?utf-8?B?Nzg1OFB1QlYwblM3Z1UyR3pwSlB5RUlGeWE0dXlIL29obGpiemMyT3Y4ZHlP?=
 =?utf-8?B?K0wvZElNeVZROW44cW1vdHN4L05TaEVHR0MranBCZnd1Qyt0WjNjLzZodkti?=
 =?utf-8?B?QWU2dzdZMGJucHhSendHNkJMclppdVA5U3RyeHVjOHVlREZ6djlWZEpoMXFS?=
 =?utf-8?B?M000aldSUDM2aFA0Mk9ZQ3hYYkx0SVN0NjZwQlQ1bVAzeXYxRXFkZi92V1lx?=
 =?utf-8?Q?GklYkgOuxxpoPfRETGPRmd3IqCN8uHUe4f0D52cinSUxn?=
X-MS-Exchange-AntiSpam-MessageData-1: CZ4zdKZVEhez/A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae3f9c4-829d-4202-c98b-08de8a32d724
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 05:53:29.9773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/jiWP9lQxMzN7zhiH+seo4hKsHrjCmfoNHKx83buJWwo0NDP7efEfpU1BHd6EYCpI7ibi+8TGtIzdRN4OFSIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9811
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

On Wed Mar 25, 2026 at 11:46 AM JST, Alexandre Courbot wrote:
> Convert all PFALCON, PFALCON2 and PRISCV registers to use the kernel's
> register macro and update the code accordingly.
>
> Because they rely on the same types to implement relative registers,
> they need to be updated in lockstep.
>
> nova-core's local register macro is now unused, so remove it.
>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/falcon.rs                    | 521 ++++++---------
>  drivers/gpu/nova-core/falcon/gsp.rs                |  22 +-
>  drivers/gpu/nova-core/falcon/hal/ga102.rs          |  55 +-
>  drivers/gpu/nova-core/falcon/hal/tu102.rs          |  12 +-
>  drivers/gpu/nova-core/falcon/sec2.rs               |  17 +-
>  drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  19 +-
>  drivers/gpu/nova-core/regs.rs                      | 353 +++++-----
>  drivers/gpu/nova-core/regs/macros.rs               | 739 ---------------=
------
>  8 files changed, 457 insertions(+), 1281 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falc=
on.rs
> index 123de6c55b45..f3c0ee4d82a6 100644
> --- a/drivers/gpu/nova-core/falcon.rs
> +++ b/drivers/gpu/nova-core/falcon.rs
> @@ -15,14 +15,20 @@
>      },
>      io::{
>          poll::read_poll_timeout,
> -        Io, //
> +        register::{
> +            RegisterBase,
> +            WithBase, //
> +        },
> +        Io,
>      },
> +    num::Bounded,

Apologies, I just realized this is a leftover which triggers the following =
error:

warning: unused import: `num::Bounded`
  --> ../drivers/gpu/nova-core/falcon.rs:24:5
   |
24 |     num::Bounded,
   |     ^^^^^^^^^^^^
   |
   =3D note: `#[warn(unused_imports)]` (part of `#[warn(unused)]`) on by de=
fault

Not sure how it slipped in as I build each patch individually in my
checklist script. Thankfully this is easily fixed.

The silver lining is that this shows that despite the heavy reliance on
`Bounded` for register bitfields, this heavy user does not need to
create a single one explicitly. :)
