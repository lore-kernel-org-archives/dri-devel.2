Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13E2109B462
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DBFB10E264;
	Tue, 31 Mar 2026 13:21:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="tZDE0aiM";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022094.outbound.protection.outlook.com [52.101.101.94])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4155B10E264
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 13:21:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YitA+WY0c3pLEsg0YhhH4d6EdtopQBe1thFbbpd9hhIV6/WsHxl0l9VL9B4XiyKH0VeQcqC/Bi2JQlw9Pf9GYXaFINZIes2GFl2pjlq1gNpuvW/gRcgJ2bZuquq3iYXH87oFDbXtQX/pkOFlLm+h3atS4ODzu7cSgG2F7cwQmWkIsNwtYgVFz+6MLaz67p9JODBGMd2ZNQtF43PKnBJN8CSbrhPSvxT/zsgQRIjuktzyqVsGgS6XfzV3puUCFZnpOb9zY47ePhOJA+SFRLRbtUkN5vUtqC2sz68YPt+KAX1ClaH6cbtiQ/BAgKpLU+gQgHgjqKfNmPK0WmCmUsVwBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5IW3ef7j+bmv7mZm8IzG0u01GxcZ9ozAhIsix5Cfxo=;
 b=J0imwKi2pxQMv01sFJ/xn8go2zvz/Uj1dnFkq0K4OvW1auGhbbOjtqk479nyTp4+EGWnM0sr+wFrGIszFAFgFu+6cuZ37fWijtEPurcPGqCHWwY+slefqzRKTfhhQf6SZtVN9swr+B/nyUYoY0dC2w8d+GWr1K+DtYR9xs+60S+zg3gwKB8gYfB7HDLbJxfVRxhmmGzC1XKP9WB/8g5emNRLk5hdHW/2NvwAwUtPC7gIDpLQP25N696lATaEAC7YBtC5D2OdttFkIU9LMOJmLDBGJJ2eYDp7yJFFIRYEsbwOE0X0wTAM2tpcNA0vuybME08PU8VFsPveyBTZagJeVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5IW3ef7j+bmv7mZm8IzG0u01GxcZ9ozAhIsix5Cfxo=;
 b=tZDE0aiMIFLlr3/KPU/lWx8b3+Ij/tlG0fGPNuJxx3Keh2HgJ3FhWWm91eODTehJ4Ayim84CDxa94whbWT0x0JF0gAkOND3VZ4bHP7rGCTwXRcaJz8mgmLlSrWp1CBShkyGuNh0jyzSkKxEOMTpNRCic5Im2aEhoTphDh/yqKDs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO3P265MB1770.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.36; Tue, 31 Mar
 2026 13:21:33 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 13:21:33 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 31 Mar 2026 14:21:32 +0100
Message-Id: <DHGZZ3RV9OHJ.3LTA4S2JO38GE@garyguo.net>
Subject: Re: [PATCH] gpu: nova-core: bitfield: fix broken Default
 implementation
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260331-fix-bitfield-v1-1-ebe1a72b4fae@nvidia.com>
In-Reply-To: <20260331-fix-bitfield-v1-1-ebe1a72b4fae@nvidia.com>
X-ClientProxiedBy: AS8P189CA0008.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:31f::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO3P265MB1770:EE_
X-MS-Office365-Filtering-Correlation-Id: 8438e02c-bed0-4628-c2c3-08de8f286da1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|7416014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: HjY9kjqB/QGlu2zfrIfe4JoufXQcEX9TBoFJFxb17u/3AjdFdTXzX54k2EEvanLAsLrKFOfJF3fOt+cR9NAmpQrJ9LBD3cP2PucxStCLL9aR57ZxDp+LhGNJJKr2dIZQEvSKnMtTBTaZIYV1Von3Zfa3wU+t8hIpPmbURc7Ql3ZNZ/NF6khUJ3zPeU+GLOfsuSY39f2TCRP+oZWqjs4E5ezqKEqdwNFU9260GDcG0LvRVPt8bRC3E3LjeatFyJWjC/GG1PsiV0SUdkzG3nzFPtgMjWNq3xMFWi3KzH9p0pCnWqZm5U123gbrInIO1hB773Swx4bBsLoV09hh0E0ulvi3UPVtBZZ1m7UDnZxMxUGGO/bzTXIUXW+gr/5ax4RUFVSiRVA9vs03byBPcr/0E/fKKeggrnf6hgNhNWr0PVWi3Zji8oCu8exMVFy5d+peszUcpGm8/BzCfvzQTupIJk+l6hhI8my9YLRhaiWelkUW4Gcw7g53JwRB3MLKsJI4ju9AM+7/SB17rs+kBlqT8JDDOOTYlJ9c2uLfvo9wN/LugphEiEm41XuMmSRMlTgy2kt7M7FnW8K5gFjqF6nyOE/BXm8evDv4IQkuuLv7DIX5xQZ0zfj3FclBKnkGq0tqSeav219aYEZnfcdYQajdJnOpEJ2cHf88qdveHwFtPGVtucA6lroi+EvctHfT3doOYG72ISnx2JPN+oaBcvoikHNWDpIUwLvlaBtSkQqaDfg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1dWOE9rQXpXaFpPaFZJeHI4MGt3S3FiTFZCSTNNSlArZkRqV2RHa0NTRWJq?=
 =?utf-8?B?WDk4aFp5aVp1ZUg5MGJELzhERnMwbkRHL1dITHpIc2U5ZnFCa0RVUTJwM3Nx?=
 =?utf-8?B?N2lnRTNodWxzczArMVdERXBCVnk4azViemZ4OUhNczcvK0NiTGh5SnlXSXM5?=
 =?utf-8?B?bzFGOWFrOHZzdFJhaW9DTmgxLzR4RUJEbEZZWFo5NTdvUHVMUDViWDlLQVox?=
 =?utf-8?B?aTVwNzdybzFtc0ZBTWlwb2tMNmxNeTdIWHYzREZPUno1Yi9OdTlIcGlycG9Q?=
 =?utf-8?B?RGw1U3pQTmVyWFdiMEc0Si9nMVM5UElWL3pJYjhSSVZ3eC9UeU10SjcvYW5G?=
 =?utf-8?B?VG9JTkhXdHZTWjVnMENheUkrZ0t1YUdrMlh0RFpvZlN1UVNMNmxDRjlEWmVY?=
 =?utf-8?B?OU83dTYxamVjVG9Jbk9oci81OUtYYTVJN0Zoa1ZPdHZGcitaV2QvRjNnR05S?=
 =?utf-8?B?dHhDcm9oM1VoN0NSVFBMVW0zV3AvUFkvNVVOVS93a1JvVk9NUUpMZDZTdUxw?=
 =?utf-8?B?QkZYa25SKytXVGNkb1FITEFITUkzajBLQ0IzM3Zza2w1L3RUSnJNeFB1bVF3?=
 =?utf-8?B?MTgvdVdLSVdoUmFnNVF5R0M3dU5RK244MVhtcHRxbmRkRmVvaFFyZGU3Mjkz?=
 =?utf-8?B?MkIrdkRJKzM5NzRWVWk0ekM5U2cwSFJPZkFZSHY1RUNzbTdPVndGSFE3aVZi?=
 =?utf-8?B?LzMzMm56ZEVEd2NEVFoyS2hVdHVFTERzWDdzUVA0OHNHZXdxYTc1Y2t1cGh1?=
 =?utf-8?B?S3N4ejdEVUlwZDRRZXBRcm1aSHNNL29QcmNYemh6a1h0N0Z4YmpQTW9PREFL?=
 =?utf-8?B?bVYydWhxbXlRWlNLVkFVTG5YWHFTSE84Qlh4VC8vZlBXRXoxVmV2dXU0WVlw?=
 =?utf-8?B?clVFTzExb1RVOXVtV051bEFDb0RqUUdKU1hjVHNHbkhWWkR4MG11RFc0Wk4v?=
 =?utf-8?B?MS83NDlHNVV0Vkg2TGZRT21zZHlCTkdzTW5acVdRMXprWC9MMWIvbmZ4SG10?=
 =?utf-8?B?Q2duUUhCKy83WnJkSW5DbG1YOCtVcUl1enZSVkc3UFZ6STU3a3R5dUdHakFZ?=
 =?utf-8?B?a0h6VHdadzkyTVNvOUJULytLS3lRek9TSjRqcjN3VHhmcjNVeWZyRHpON0pH?=
 =?utf-8?B?NnEzdU4xOWR5ZmlSK3MyL3IvWVhjV2ZRNDhabVpWUEtqMUk4QUV2MzNadTJs?=
 =?utf-8?B?QTFUME5HR0hGYmRTcU1qcEl6SllwY3FNVGZ2MzQ3ekxxRE5ua0hFRUlTU0hy?=
 =?utf-8?B?VEJycHErMW9ESWY1YTQva0RQN2poVnBta1FreHB5NVBMa1FuSEpSZ1NRZUZz?=
 =?utf-8?B?M3BjbFRmbitkZExLbmQySnZEbWVmRW93K1JOdlNZeEVCM0g4SWNYQXB2VENw?=
 =?utf-8?B?ZG5jQ1NPRlk5NlNaYkVlOWNpbGFzdGlzSnVueFpiTmx6N0lXTDVmMHh6OFB0?=
 =?utf-8?B?WGNLa3dCTDRRNzI1cVFXOGdqbHl4RHlNSkNPV3RNRGRSWllhRGVzZVhIZ1lM?=
 =?utf-8?B?OXlSTnh4Nmhtc1Z2TWRqRzVxTFVycklOUG0xaU5aR0R1ODgzd3J0czFtUlZv?=
 =?utf-8?B?OG5LbXRZbnhQNGRDYkNsbVVzem00SlMxMVh1WFBVQVI1N2IrYWJSNlU0L09W?=
 =?utf-8?B?dlZTR0VMSVF2SXhKQXU4dG9qTTR1bnJ3ditmdDdLaTJVS1JkS3dZOWZDWUht?=
 =?utf-8?B?Y0NXTXk2b3dJUnFTR3R6bEZzWitGRzNZTXhUMTE1d0xCaTc0SjhETlptbzhZ?=
 =?utf-8?B?Yk1OODlXbU5sWExPaEowbGt3Mm4wQWlyWXN4WU1uZmc0OHhkRmlteE1kdTRv?=
 =?utf-8?B?aDJ4WnhxVEdsMlpJSlJHS1R2UzFSeVlxUmR6dldNL0dNRTZCUXVPSHViQjQ5?=
 =?utf-8?B?VlcyTlJ5K0Zpdk9DRHVaUFRmRWcwMFdwK1NqdGdqcHFDeXBWRzVDMmd3Mzg5?=
 =?utf-8?B?bGM0VjRKTWI3YXk1T0Fhb1dseUtTUzkweHVpeTI4YXhPOEZ5ZWNTQlJhdTRw?=
 =?utf-8?B?TGV4ZjNNY0h0Y29FaDE4TiszNXBXZEdTT2xnOFVlNnNwM0VsaG85bm1yUGxB?=
 =?utf-8?B?aG51ejk0bmk3L3Exelo1dENMcEh3UmRHODdEZEt1M3ZwMnBTZnN2cGtHcnh3?=
 =?utf-8?B?TDAyeGdpSFdTVGticDNHN2FDOXJLQTcvKy9Gcm1rWE1UUGthWGJEVi9DWjM0?=
 =?utf-8?B?OE1KdWxMdU1GQXNWSEpPbEdBSWV1dXJyKzYxMlhxbnRCMVQrVU56YVhsdlVj?=
 =?utf-8?B?cTVhbUJITmxpMXZoV3Y3bzN3MnoyTTNLaW9DV0xYRHdpTFVjZ3YybUhsbVh4?=
 =?utf-8?B?NGJFUG95SndxMVNsekc0ZVVJbWVrR25tbHROdGtwV0N5MmMzaGpMQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8438e02c-bed0-4628-c2c3-08de8f286da1
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 13:21:33.4744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0G5XKLdZaLKndpkjHKrxCy+qKyrASGktpMkwUOFqp4tViIxtaA09oqABTWJRZIBmkZj3h0+vWSmwWyGgZmYlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB1770
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

On Tue Mar 31, 2026 at 8:56 AM BST, Eliot Courtney wrote:
> The current implementation does not actually set the default values for
> the fields in the bitfield. Set it and add a test.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
> It doesn't actually set the default values for each field. I know that
> bitfields are being moved soon, so maybe this fix is unnecessary but I
> saw it and it's a simple fix.

Good catch! This is why I think it's important to use `with_` for this sort=
 of
methods as they are confusingly non-mutating :)

Could you add a Fixes tag?

Best,
Gary

> ---
>  drivers/gpu/nova-core/bitfield.rs | 50 +++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 47 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/bitfield.rs b/drivers/gpu/nova-core/bi=
tfield.rs
> index 16e143658c51..22d68fc21a1f 100644
> --- a/drivers/gpu/nova-core/bitfield.rs
> +++ b/drivers/gpu/nova-core/bitfield.rs
> @@ -4,6 +4,8 @@
>  //!
>  //! Support for defining bitfields in Rust structures. Also used by the =
[`register!`] macro.
> =20
> +use kernel::prelude::*;
> +
>  /// Defines a struct with accessors to access bits within an inner unsig=
ned integer.
>  ///
>  /// # Syntax
> @@ -314,12 +316,11 @@ fn fmt(&self, f: &mut ::kernel::fmt::Formatter<'_>)=
 -> ::kernel::fmt::Result {
>          /// Returns a value for the bitfield where all fields are set to=
 their default value.
>          impl ::core::default::Default for $name {
>              fn default() -> Self {
> -                #[allow(unused_mut)]
> -                let mut value =3D Self(Default::default());
> +                let value =3D Self(Default::default());
> =20
>                  ::kernel::macros::paste!(
>                  $(
> -                value.[<set_ $field>](Default::default());
> +                let value =3D value.[<set_ $field>](Default::default());
>                  )*
>                  );
> =20
> @@ -328,3 +329,46 @@ fn default() -> Self {
>          }
>      };
>  }
> +
> +#[kunit_tests(nova_core_bitfield)]
> +mod tests {
> +    use super::*;
> +
> +    #[derive(Debug, Clone, Copy, Default, PartialEq, Eq)]
> +    enum State {
> +        Inactive =3D 0,
> +        #[default]
> +        Active =3D 1,
> +    }
> +
> +    impl From<bool> for State {
> +        fn from(value: bool) -> Self {
> +            if value {
> +                State::Active
> +            } else {
> +                State::Inactive
> +            }
> +        }
> +    }
> +
> +    impl From<State> for bool {
> +        fn from(state: State) -> bool {
> +            match state {
> +                State::Inactive =3D> false,
> +                State::Active =3D> true,
> +            }
> +        }
> +    }
> +
> +    bitfield! {
> +        struct TestBitfield(u32) {
> +            0:0 state as bool =3D> State;
> +        }
> +    }
> +
> +    #[test]
> +    fn default_impl() -> Result {
> +        assert_eq!(TestBitfield::default().state(), State::Active);
> +        Ok(())
> +    }
> +}
>
> ---
> base-commit: 7c50d748b4a635bc39802ea3f6b120e66b1b9067
> change-id: 20260331-fix-bitfield-a03f6d1b9e00
>
> Best regards,
> -- =20
> Eliot Courtney <ecourtney@nvidia.com>

