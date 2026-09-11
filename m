Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F3EC88E41
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 03:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8517910E03D;
	Fri, 11 Sep 2026 03:10:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="MK9wADO+";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020129.outbound.protection.outlook.com [52.101.196.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7DBA10E03D
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 03:10:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fup0A+25q5sHiwihJ5zLUeDieSYOiIKAqTWAHWXn8PmisoGi6kE538jrdb/0F382V2BHl3wzRpih6GCzuf5JV39aARnw6yTUIX74dPPl17pZ8Cx0KPAR3BqcGkTWRoqOacxE8kyJWru0IaSUxi18SOlyJ9x/kvp/IDN5P/+u4OhBS6t7VHLOCN9/AhIyJhA3Ti7EN3f0vv3ZAqQ7YCbTzg7Qtbnb2RNN9GzCCp8KMXIk9g9Vy0i7llH3cEjR/KAxu7x7Pr0p78WdQ6M4Lv8Ba3ITF13eNQJy2VeJHfr60I5ZXbLaUYZP/O9jMwJxVVv2VZtU7pwTGpkXG2N7yHjEbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVXUI3zawOoOtkOGoRUkNABK/ZoVc4ntJLtBykEYi8I=;
 b=uaGdgGBUqI56uNx08CSB4sSc5/b+/KUxVi/pj+EQsV1bOVlBtrEyNd0rv7w3mfKDYpNblnZGw5UFGbd1GiDkfn/vmrs07UXGVOJkpNzMxNzFa57xfwmbm5YdtH7k8ieKjmYMjhacojGGEmLtdPaFv6JHFmOavOTdUxETf4nCdXFawzhK/nbxFY7Oq6ra2dwWuk/KjfBr6YBeOATGXJvHU1bSzXqyGFIiUvi76kt74lZkrqGPRx78U3VqOXAC3QDt20Usgv+j+0//p7VafcwwrO1+NrLhQy6afe4a3Mdehxkk3xfUzqNYrwl8u2wzbsGrjCqiXUCdgbwD/skZshCtVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVXUI3zawOoOtkOGoRUkNABK/ZoVc4ntJLtBykEYi8I=;
 b=MK9wADO+Tjdq0SY7RRpzwzBEXrCu+2clSknN+Ffdx1Dq7NUeUJuUHauWJy89r2ZBvuIB2L74+CNI3o4fObq9tQ/pDDML3r1tK7PqBQ8TFXZh/JzLYRfHi2HgSFaPEMp6z0Q5IQMH1uqwnMJ63LB1XoS2CEgCHadBabhuJJ5Znxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWXP265MB2408.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:75::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 03:10:01 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 03:10:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Sep 2026 04:10:00 +0100
Message-Id: <DLC5O80MQGEI.2Y6VVE6C8WSKL@garyguo.net>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <gary@garyguo.net>,
 <laura.nao@collabora.com>
Subject: Re: [PATCH] drm/tyr: use bitfield! for non-MMIO fields
From: "Gary Guo" <gary@garyguo.net>
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.22.0
References: <20260910-b4-use-bitfield-v1-1-fdddfccff73b@collabora.com>
In-Reply-To: <20260910-b4-use-bitfield-v1-1-fdddfccff73b@collabora.com>
X-ClientProxiedBy: LO4P302CA0017.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::8) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWXP265MB2408:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce67632-9bd2-4a18-947d-08df0fb22b03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|10070799003|7416014|1800799024|376014|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: A7NPEelq+4vgGsXoDqJjjGUh8NOsMZPXYPupIlB4v3F+W/47Z+5iwsdbwTPdukIpPa1/pE+EAFt5nhNp5aDDrXvm2vfeFMSCaklnUQG9N1+2cQFyvjRYfOoyWZGupQGZmzH6T8PcVEavoETnaVz51zVpaJakAAwt3ZqKvzzh05sYgEs5zs4EvaOoli5fSod5ShME2WuZODqEKSwuIYIZRZTS41c6Ndhb6EaBUYMlpsrRTirf2HK35AmDc0SSprIE9hmALjGy5ff45MyxrNbMXEnfYz4tF6asbHnTr5UMycW5/V13hGv0muVzCTQIrm5pi+b8asDcFpphpHJ28Q6LuZBiMXQEuCUAc61RuDXjlt6DwkMClpzJGHE1JDMblcBoShzK/Z2TPdvIbGDyzl4DczyoPW1OqcgpzpAuKIUR30uYTPieaatgAudMuFQ/A6P3wvAkQ16mjOXPNHwCJmkOWQITu0BK2iu5bBWB6ccKDP8HiHWmBTEJBaXIbLFJGe0o8fhQEg91aL6kAV3OiJe9QtqvDSvJcXH74cnUEgjizrsXxl1kqRVzY3d3KR1UoztK34lyWbTn8PgkInHhFaN+i/hUavFVC77FDyzX7gAW0+Xl16RDB7Yljem9ud047/V8TvXH3MahGgazLMmScD7nXJeMvdYufzVnh24uFh0hrq8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(10070799003)(7416014)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlRwU0tTRTlsMUFXWWIzeTJRUGRvVm5lbXNPS3dWNGlzeGxTdTlXZWoyQjZW?=
 =?utf-8?B?TzNLMzJlQWNOdmd2Mk12QzZYZldYd0d0TGJ0Ylk2QVVvdUkvV3NzUDBrOHNu?=
 =?utf-8?B?YUZRVWhWZGZkU251dzJDajRia1BzazU1NmFrZHdqaklhNnJYU3N6UVhiRVZ2?=
 =?utf-8?B?eUlXcC8xdmY1QlNmdHVpUzZ6d2dKeHhnRWlQTHZOU2UyUCtQL0tIbytPNUpW?=
 =?utf-8?B?RnZoeTNMdDJkWWVCTGVIT0owdXVkZSt3eE9nNVNQaVJvb0ZLU0lURTI5WmF4?=
 =?utf-8?B?YkUwRi9aZS9TWDN0cDBnZ2pscExiNkpnOGNIZTc2S0pidTVyQS82VG5acW8r?=
 =?utf-8?B?a0MvUkVtOUhTN1dzUHZIVXppaCtHVFFTYkJnOWJVMHN2cVVIOFRkbTRHZSt3?=
 =?utf-8?B?Yys3c1paV2EzQzhFMHlzTWVRTEs3TDgxaFpTZU90d0lySUhZa3dDUVFzenY5?=
 =?utf-8?B?dFFSTk1YMkNsT1FuWXZJWVY1TlBPNzF0UTBjQVE3WXQ2T1UwQ09HWmQyN0xk?=
 =?utf-8?B?a09tNnRkbnJycVRWWUtpa2MvZGxtenBYUkR0UmpJYmlMVzN6bGlibFhOSkFE?=
 =?utf-8?B?TXgvOFc0dkY2OWsyeTdaNFVGMS93VzZFTjhOY25OUXhhNG1FdDNCNXBvaDJV?=
 =?utf-8?B?SXo3MStKcTMzditmSTBJVGtwMzE5T3h4aVFXaXdmekdqajhOZWlmVjRxMjVq?=
 =?utf-8?B?Q1lLQUszUTRMVWpLZlRJVEhOL2plQk5zd05KUDN1S0pKZFBmZUx1ZmJtQWxM?=
 =?utf-8?B?OWQ0SkxWanEvd3V2b0lRaHdLaEZTY0djV3IwZUE5N1crVFpkajdiSWdMUlBv?=
 =?utf-8?B?Ui96U25tWXA4cnN5aVVsNE1mdVVGTjRjSkxIMTY4VXZqSCtQNVl6N1pXK3VN?=
 =?utf-8?B?ejJJazJuUlR1QlE1dHYrc1djb2JxRHB3YlJJejhZNUR5YWMzKzhkNzgwUENo?=
 =?utf-8?B?UzZJRVFlaXRmbnB2ZVBzblVaZkpCU1RtMzBvTy9hTHlnUFFibHcrM3JCRi9D?=
 =?utf-8?B?Y2dIQkFMek1NSDdIZ0dFS3FVcjdTNnc2bTVBVnRDOEQ0YXJ4NlVhemplalBm?=
 =?utf-8?B?R3dBREIxeGdLV1gvOHFvR3RibEtXbCtlRTQwYThmaXRjY2RsZnFTYk8zVVlh?=
 =?utf-8?B?Qzg4WWptSVE1d01iNSswbmZsWVRvckVSaEtFZXIvRkdyUEVHYlBjbEl6UWxG?=
 =?utf-8?B?Sms0TGxPS1pYWEE5a3M2RzFtV2hQb1dYc2xodzJhNmVtS2ZJOGlYWW05OXdy?=
 =?utf-8?B?QWVRMFprQi9WQ2FOaWQ2a0R3dVpJWTQ1V01vRkMzUlZLY3pQVkxxMjhadHZz?=
 =?utf-8?B?YU5HOTBWV3VqaHltQ0FTeUhwZGV5dWFwcHJjcW95ZGRHbTNqL0xydVVKV29l?=
 =?utf-8?B?RG5wTUlLZkEzZ1BVYTdRUDd3b2RpblRpYkN5c1cxSnkxKzhnRGhWTE5zLzND?=
 =?utf-8?B?eVFmcXlZZEFZTmVkUmZZd213M04rak9MSHBzVmhheFBBaFVYL2p1VzJyUEhq?=
 =?utf-8?B?VHJFWGVudG9uYlp3MTZuNjZvM1JsakxiaE5DNVdyZ0hFbmlJS1pTUnRxSFRp?=
 =?utf-8?B?dTIxQ1ZTTzN6RUVPWlN3ZERYZ2IvT2pRMXc3VXBuRUlVNy9xRzY1dzBjSnFk?=
 =?utf-8?B?a3EzSGo4Wk9zLy9hZkhBWC96RnlZcittdVRXN2pINGNhemdDRmFmbWwxNEYv?=
 =?utf-8?B?MHRWeEcvWnBWOC94NllvK1R1KzNsbFdpSnVmOTRPZ2ZMNkw4L0p5NWl1N2Rh?=
 =?utf-8?B?R0RVc0d5elpFcW9STW11SVM2aHc4WkUvT0xPc0FDY2FiWEEwdW8yUVE4RU9x?=
 =?utf-8?B?cXI2MFE1clltM1Z0WWpMVzdMbXRGU25ybHkxWk4xQ0prSENkRnkzcmE0NEJD?=
 =?utf-8?B?WDJoSHExRDN2NmdlTjJkL0k4TTB5KzdqbTFyNG9zMldMVGsxdDFUODF0b3pt?=
 =?utf-8?B?NjdGQ1ZxcmZ0U0MrTDBUWG9PaFBEbG1NVVBXWkZjYzYvTVlseURKWHA2ODhS?=
 =?utf-8?B?V2V3K0Zic3hMc0FvbVk3dmltNi9sTDR4bitBSkZGZ05sdTd4TW9FV1ZLN1Qw?=
 =?utf-8?B?YlI2eHNuYzVuazFqaC9mckp3SVRGSUZGUE81aUQzN2tFYTJmZmtyY1J3VXJT?=
 =?utf-8?B?RHVueUZOekRpbDU5cm1KQjhtWlBKdC9JQnd0RStHS1FSdnQ2ekMwY1dqN2pa?=
 =?utf-8?B?azNMdEJJSmRKUC9aRnpVeHh3Q3I0eVlsMlRqY0pSWDRFaEhHWHhoeTR0NUU3?=
 =?utf-8?B?b3ZDYkJyZ3BkUmFrMXhBWVJoamdQQXNaMjg0eWVWQUlNUW1xZDhzdisybFo0?=
 =?utf-8?B?b2p5RUZDaEhWSldtUDM5bkVLNlBoQmFyelJqRGJTTjI3c25wY0cwQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce67632-9bd2-4a18-947d-08df0fb22b03
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 03:10:01.1182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDLkHg7ZzCNk67DyCQ5vhKQksmgUL/Ob1O3dBuotnlrZM4DwGhLs76F6psO8VgYij/KJhGxJpOM4KmuwUsXnoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2408
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

On Fri Sep 11, 2026 at 1:06 AM BST, Deborah Brouwer wrote:
> SectionFlags and MMU_MEMATTR_STAGE1 describe bitfields rather than
> hardware registers. Use bitfield! instead of register! so they aren't
> confused with actual registers.
>

I've sent
https://lore.kernel.org/dri-devel/20260910165734.80378-1-gary@kernel.org/
already.

Best,
Gary

> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
>  drivers/gpu/drm/tyr/fw.rs   | 11 ++++-------
>  drivers/gpu/drm/tyr/regs.rs | 11 +++++------
>  2 files changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
> index 7edb5eff1707..8d11f888a9b9 100644
> --- a/drivers/gpu/drm/tyr/fw.rs
> +++ b/drivers/gpu/drm/tyr/fw.rs
> @@ -14,6 +14,7 @@
>  //! [`Section`]: crate::fw::Section
> =20
>  use kernel::{
> +    bitfield,
>      device::{
>          Bound,
>          Device, //
> @@ -27,7 +28,6 @@
>      },
>      num::Bounded,
>      prelude::*,
> -    register,
>      str::CString,
>      sync::{
>          Arc,
> @@ -39,8 +39,7 @@
>  use crate::{
>      driver::{
>          IoMem,
> -        TyrDrmDevice,
> -        TyrRegisters, //
> +        TyrDrmDevice, //
>      },
>      fw::parser::{
>          FwParser,
> @@ -101,11 +100,9 @@ fn from(value: CacheMode) -> Self {
>      }
>  }
> =20
> -register! {
> -    base: TyrRegisters;
> -
> +bitfield! {
>       #[allow(non_upper_case_globals)]
> -    pub(super) SectionFlags(u32) @ 0x0 {
> +    pub(super) struct SectionFlags(u32) {
>          0:0 read =3D> bool;
>          1:1 write =3D> bool;
>          2:2 exec =3D> bool;
> diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
> index 0c419c4e1186..3377b8fc5029 100644
> --- a/drivers/gpu/drm/tyr/regs.rs
> +++ b/drivers/gpu/drm/tyr/regs.rs
> @@ -986,6 +986,7 @@ pub(crate) mod mmu_control {
>      /// This array contains 16 instances of the MMU_AS_CONTROL register =
page.
>      pub(crate) mod mmu_as_control {
>          use kernel::{
> +            bitfield,
>              num::Bounded,
>              prelude::*,
>              register, //
> @@ -1130,14 +1131,12 @@ fn from(val: MemoryType) -> Self {
>              }
>          }
> =20
> -        register! {
> -            base: TyrRegisters;
> -
> +        bitfield! {
>              /// Stage 1 memory attributes (8-bit bitfield).
>              ///
> -            /// This is not an actual register, but a bitfield definitio=
n used by the MEMATTR
> -            /// register. Each of the 8 bytes in MEMATTR follows this la=
yout.
> -            MMU_MEMATTR_STAGE1(u8) @ 0x0 {
> +            /// This bitfield definition is used by the MEMATTR register=
.
> +            /// Each of the 8 bytes in MEMATTR follows this layout.
> +            struct MMU_MEMATTR_STAGE1(u8) {
>                  /// Inner cache write allocation policy.
>                  0:0     alloc_w =3D> bool;
>                  /// Inner cache read allocation policy.
>
> ---
> base-commit: 73e5616f3d197c1af5a04a481fe0f13aa3913bd1
> change-id: 20260910-b4-use-bitfield-512214360810
>
> Best regards,


