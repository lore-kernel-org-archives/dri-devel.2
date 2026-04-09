Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB755EA3C24
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 10:22:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C2D910E34F;
	Thu,  9 Apr 2026 10:22:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="LuPI/3Gl";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022125.outbound.protection.outlook.com [52.101.96.125])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82B1A10E34F
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 10:22:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIZaHoukekMKnNO3bH1gGoSbUzA2onKCyC8Bh9Ay+amHjNgcOjEK3eVNUTWdXTms6wARQXlQKmRKWoFn9C0c+oo5/+gl9A+ecguePmebBbDi5MvNGtaFzRCgQ3vlEUpXuk+0J9lyWRKpoFnePhs30fgMG9FjTTnWTEhMcrX3gKYz/DY6w+3cFxF3+JHjRMgGzbG4tpM94dvgwBPNPWFGt7i+IGSRqhFwBjB0YAvvufM3Y9x6/A0kKXGPGLLnMSXr/NG02wxJ6MGoRYvPXHeVFFZtRJoBM2eqgJvxtains2KseOPJRtkM+qg1E/P/wlEIJXWS1W+evitEEUB/FK12kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0buDy3YijhjBybQEmYE1knxZ/qSZXk/NhKSaxklJqk=;
 b=Qq608KQ5mEbiyL/jDBL5SQGc+cmOdeSBwISM5Px6oRvd8xJFaxJplXyWRIXqzEuoMDDTq6JVOnFgWFBOfLXX0uLkXPe0SYqFJ0dE4PXxqA0xMmm6IOCUiqO4rGwlkVSz+OPz34bbSVnFxg7jAAuk3SRYdHenL3A/hamE9kNPRZ0/12amuFj3O5yhiL25r7Pm1TtSE3gNbICjNHRmuT6/cevBAhmOIY2BvMoIIABAh401MJVoJyDRfA0zkKpjmJiOuqQokNofg2+A3/gLOaWqJOgSYMNV5Bu8Y9ifa+Uc9e+fBOh2Vasf/AT+EWDT/iD2Hvgmupo2lkaQ/GDmvYJckA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0buDy3YijhjBybQEmYE1knxZ/qSZXk/NhKSaxklJqk=;
 b=LuPI/3GlJd3PYdMQv+gY5pVeD+Zu5wvtDl5Tq1JtYZt6VEHdFxJ6BIeYnuK+SBSRjvFyXwNBTv3bDJtYhTR4iTBH+nGuJn1Ik8jtFUAysp8Axwqa8Md+zKl43z8du3zyxh61jikVUq+IQCzFJVCeGR6DU9qjSiwMho+lOfVwqps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7701.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ae::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Thu, 9 Apr
 2026 10:21:55 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.041; Thu, 9 Apr 2026
 10:21:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Apr 2026 11:21:54 +0100
Message-Id: <DHOJSH0AII57.2U2V9ZWH23EAC@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Steven Price" <steven.price@arm.com>, "Boris
 Brezillon" <boris.brezillon@collabora.com>, "Dirk Behme"
 <dirk.behme@gmail.com>, "Alexandre Courbot" <acourbot@nvidia.com>
Subject: Re: [PATCH v4 1/6] drm/tyr: Use register! macro for GPU_CONTROL
From: "Gary Guo" <gary@garyguo.net>
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>, "Boqun
 Feng" <boqun@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260402-tyr-use-register-macro-v4-v4-0-96a8d42f8bd1@collabora.com>
 <20260402-tyr-use-register-macro-v4-v4-1-96a8d42f8bd1@collabora.com>
In-Reply-To: <20260402-tyr-use-register-macro-v4-v4-1-96a8d42f8bd1@collabora.com>
X-ClientProxiedBy: LO6P123CA0043.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::17) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO8P265MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe6d064-193d-4581-c992-08de9621d312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RfqzUqzWCIFiNJ4NQU9dm6k17x3lWOuyLYtvhuGgQKHqGrMuVBl0sfwrOzeZmckAW6y38KhcVK73r4ZNH1PGoOdHz1CbcCqN7iF7ySByAquFDlQEsuCR9dKpxITXCM1OXpBtqCaOSLiSyo95W4yCPW9zAwuF9OGEjnhO1v+MWJbGYQj/H7bzuItUzV3RXKyzKNIBZPujdNtwSkgHvnjslmM6JUXGd7s1uF3+dgYi9TjLH5o0NlsEsOPbF5JTm4g3nDl1Fkq4JkDbWU/iJm0zZNXaBzkPoOwvLDDYA7aPYNeR2eJCmvZ8ghWGBpFNlw4oHnnEVOhc1JIBcjGMaeVjVkCGr6Cxem0pdAl8DyIO2IjHNug9+V1DnFEzruownHxwIta0envPIIEa5e/CKT9rro4fIip2gvpAqeUmslijXsbpHvYOO3FPcguziqPfDdRkM5mqtHkfg4cQSJwDioUhb/YPKpY0WqMbPIN69GyVs2Ii9b/FxutlJ6NN5BE9bzALQZs12kjUbcdJs81cJcYp0Sluxq/BM54u457I5XztFkoPl2aqToagNk9r8LUoKpGTe2VcrtZoiSFOboCONErUtqI3GryzGcayRhj7hYuG8n9mrNqzCeVQSPVZnEgCBfGbwsaNaMTg2foOLSHYefB552DBbU8SPQTbvCRB94n9DFr0MXPg4TAtpYrlRw5+9p/ygb5DgeZxvFSkb6J1oaQHXDZPp/E9vEFAywLSHe0Q0Nc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk81OVdiT0dONGF1RTdKM0cyQnJqZDUvWHV2SHV3S285UWp1YWVzWVRvV2Fu?=
 =?utf-8?B?ZHg2a0xpbHUxNG9DMnErM0RBSjVVUy9VK3VRYkpQRHRxVGVjeEw1L29VVGgv?=
 =?utf-8?B?MTQyRmo4aWFpby8wekVrUnE3NitQd2NNMHhXOVJGZlRoNU9RTW92b0JBZ0FY?=
 =?utf-8?B?OUxkSmlUb0ZReG10S0VDZmp2K1hVeXZPUWkwblcvVE1nZXFiWk8xZldTSENE?=
 =?utf-8?B?L0J4R0VxTHRKSGo2UFZZR2tEWXpjU1ZuelpRd1BqSkMxTGZuSW9VQkovS0tR?=
 =?utf-8?B?QkwvYTVHNXhLMzBlTVBaRnNUcHEyVGhGemFZclVHUFlZZEZUKzAyUlFiQTZx?=
 =?utf-8?B?R1p3bVpDVEVnbWxKbGNLdG9pUXZ5UDd5MkpnU2R6UnZ5cnNSTVRhN3lkcHFC?=
 =?utf-8?B?Rm1zSGtpTFkxNlJVMGJPS1k2bWFoSHVEV3F4VHBFVGhqKzl5S0dVUTB6R1Rj?=
 =?utf-8?B?My84WkJENjhreWNueTg4MFZEeWRkTHg4bFJDTlphbEhxcEd0MU1ZMFNIOXBX?=
 =?utf-8?B?YVVESmJ4L3JZM2FwK2VCWFVzcWd4dWJoN2xtRVV4YUlVRkFmNlVDWS9Odm1i?=
 =?utf-8?B?VGIzMVRmTithTzQza2hDZENaZ0p0akFyRVlUY1lGeld4QmpxUWVnaVJxbzFa?=
 =?utf-8?B?MWFneHJ6UEtuVmJiaGNrOEttZWNvU0FJUHJOVCtzQ3NqbGg3SkhaZ2dZUk1p?=
 =?utf-8?B?NHFNdUJUbm5BOFcxSVQwMDhVVEZGcVhuUndyR1RZMlo5NVFwVGZ3cUpMakpZ?=
 =?utf-8?B?L1U5S1pONUxjMmtOZmQ2KzY3K1drRUh0TDNaMEl6NWNIQTlhNkxrWHZaNytQ?=
 =?utf-8?B?cjZKVWhRenhvQllRcmVuNE4xVFhoV3Vtb01oNnVCbmtpSTJDRVhEZzVLK2J2?=
 =?utf-8?B?YWV2K3ByUlUxQ1p6eTRvcW1FTk0xVG14R2dERk9TZ2NJT3JKOVNMOENMOWxP?=
 =?utf-8?B?MHRQaU84Y0pvRlNxc2tQb2ZNNWhKYWdaMHZWN2tRdE5TcldyNW1PUmFEK0xv?=
 =?utf-8?B?dTdTb0Jxb2ZuT1JjdVRyVzBUckVBaDMyQ1dYNHp0dkYwT3NKMlNvSTJaTkVO?=
 =?utf-8?B?c0Y4U3hrN1RVZnNkQkhGOWswQUNtTHZGL054dHliS0RET3RyUXhQZVJKS1Nr?=
 =?utf-8?B?NFVCSmVXWjZRcmlaUWovdThCbEFONVpydCttTEE4K0VUT1VTcFZWMkZadEtO?=
 =?utf-8?B?YzF5WUs3OXZyQzlEbmFXUEhLM3NJTTBLU1BaZG1hWFVWZDJZTmlrd2UxMjdx?=
 =?utf-8?B?Z1dQUWd2TUc3S0pDRW9RWTRUaGdac2w5YytGZERCL3R1VnhtZUd1d3JhckZI?=
 =?utf-8?B?WjlRZkh0eDRCaFd3K3NMQnN0ZTU5d3VvVVo2OTM4Mk9KZU1zQVFFL2RuTmtW?=
 =?utf-8?B?RElTdFBmYkI5Q1hXVnl4ZlZCSTZHbmNuUDdYVktlY25YMTZpakhBMVd2dzZC?=
 =?utf-8?B?eTVKQnlkLy9ic3dnNGNqOHdTRWxHWlZlK0hPTlBKNlcvcTF3YTRrdWRHVnps?=
 =?utf-8?B?bXdVUGprN2FlUWxFOTdLTkovTWpaOWxOT29nNXpmUXV0b2hYR1RaUk9CMzFo?=
 =?utf-8?B?aVhzWHZNekZIMHg4NFZtYThvOWF2WWZNdk9VajMwUUpXL2hwNGVBSVhaRlFB?=
 =?utf-8?B?ZDN2WUhrRFhxSFJZQVkrTzBMdWtYOCsxWDM5RVphSTRqS044WnlVZ3NJTXk0?=
 =?utf-8?B?US9SeWVZSVdxWWh3MnpzaG40OFNHb093T0hOSmtNb1BPRVRXU2N0cG5RcnBU?=
 =?utf-8?B?K20wb01BVlpUK0ZZZk54Q0hqNGhhSlJ0WEErdkVFbTIrSWJjeHVnVEtZaVVJ?=
 =?utf-8?B?TUFyMG50blBwSURGTHlHUlZFUFltQWdpVXJLTnpERTVSb0RzV1dpS29SZHVK?=
 =?utf-8?B?aC9jaitSS0p5VDhVTFVoQ2taTjZrUlBnSjY4dU9qL0pvMG1GbTM5dkZDRlp6?=
 =?utf-8?B?K293d1VIckpLTmlaRWR0KzV6bm8rRDJoQ3RCK2lLbmRNc3NKZHZkelljR0sr?=
 =?utf-8?B?Ukx1bkI2YzFydmQvUlRIOFhWeTMyYnBYNUV5eHlkNHJyNElyb0dKOEZSRC9S?=
 =?utf-8?B?dzJJOTVlKzJhSGdxVGtxQ3F1WWZXMzQ4aFR6M3NCS0RvbDFxVlNlZitpbGRo?=
 =?utf-8?B?YkgvZEFwMVM0REQ1NEVSdktBN0RJNjlzU3NYa0syb3o0THcyWGhqREo2Z0pm?=
 =?utf-8?B?UUtSYzYyZ2pnRnZ4djlCYUN4RDlYejJnVDE1MThzT29MOEhrRWl4UFdISHow?=
 =?utf-8?B?dHVpVjNhYjJzY29hVFVBSnc0S014N1Bwa1doRjIxWTZhbWUwVUpxaC8vNVFU?=
 =?utf-8?B?YzlhbUdhUFh3QytKd25oN0RSMlVNT2tOODNwZnFsQ2ZsZjZ5MDFiZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe6d064-193d-4581-c992-08de9621d312
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 10:21:55.3427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8UdtiBXZ+qOd7lkwuatNUo0/j2o+B+uI2MrxxDz2SiGhRlEdHFyI7Ig1EDQeU7loROdFKOoAiwjUGeEaOr5vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7701
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

On Fri Apr 3, 2026 at 12:35 AM BST, Deborah Brouwer wrote:
> From: Daniel Almeida <daniel.almeida@collabora.com>
>
> Convert the GPU_CONTROL register definitions to use the `register!` macro=
.
>
> Using the `register!` macro allows us to replace manual bit masks and
> shifts with typed register and field accessors, which makes the code
> easier to read and avoids errors from bit manipulation.
>
> Acked-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
>  drivers/gpu/drm/tyr/driver.rs |  24 +-
>  drivers/gpu/drm/tyr/gpu.rs    | 232 +++++------
>  drivers/gpu/drm/tyr/regs.rs   | 909 ++++++++++++++++++++++++++++++++++++=
+++---
>  3 files changed, 969 insertions(+), 196 deletions(-)
>
> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.r=
s
> index 611434641580574ec6b5afa49a8fe79888bb7ace..3ebb5e08bfca342f136e8d365=
b1d9dcb6cc3dbca 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
> @@ -13,7 +13,10 @@
>      devres::Devres,
>      drm,
>      drm::ioctl,
> -    io::poll,
> +    io::{
> +        poll,
> +        Io, //
> +    },
>      new_mutex,
>      of,
>      platform,
> @@ -33,8 +36,11 @@
>      file::TyrDrmFileData,
>      gem::TyrObject,
>      gpu,
> -    gpu::GpuInfo,
> -    regs, //
> +    gpu::{
> +        gpu_info_log, //
> +        GpuInfo,
> +    },
> +    regs::gpu_control::*, //
>  };
> =20
>  pub(crate) type IoMem =3D kernel::io::mem::IoMem<SZ_2M>;
> @@ -78,11 +84,15 @@ unsafe impl Send for TyrDrmDeviceData {}
>  unsafe impl Sync for TyrDrmDeviceData {}
> =20
>  fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Resul=
t {
> -    regs::GPU_CMD.write(dev, iomem, regs::GPU_CMD_SOFT_RESET)?;
> +    let io =3D (*iomem).access(dev)?;
> +    io.write_reg(GPU_COMMAND::reset(ResetMode::SoftReset));
> =20
>      poll::read_poll_timeout(
> -        || regs::GPU_IRQ_RAWSTAT.read(dev, iomem),
> -        |status| *status & regs::GPU_IRQ_RAWSTAT_RESET_COMPLETED !=3D 0,
> +        || {
> +            let io =3D (*iomem).access(dev)?;
> +            Ok(io.read(GPU_IRQ_RAWSTAT))
> +        },
> +        |status| status.reset_completed(),
>          time::Delta::from_millis(1),
>          time::Delta::from_millis(100),
>      )
> @@ -127,7 +137,7 @@ fn probe(
>          gpu::l2_power_on(pdev.as_ref(), &iomem)?;
> =20
>          let gpu_info =3D GpuInfo::new(pdev.as_ref(), &iomem)?;
> -        gpu_info.log(pdev);
> +        gpu_info_log(pdev.as_ref(), &iomem)?;

This causes all registers to be re-read again for some reason?

Why is the function signature of `gpu_info_log` changing from a method to a
standalone function? The commit message doesn't mention any.

> =20
>          let platform: ARef<platform::Device> =3D pdev.into();
> =20
> diff --git a/drivers/gpu/drm/tyr/gpu.rs b/drivers/gpu/drm/tyr/gpu.rs
> index a88775160f981e899e9c9b58debbda33e1b7244d..8ae39137a1d190ef026351d47=
a6cdd89063ed0fb 100644
> --- a/drivers/gpu/drm/tyr/gpu.rs
> +++ b/drivers/gpu/drm/tyr/gpu.rs
> @@ -5,14 +5,16 @@
>      DerefMut, //
>  };
>  use kernel::{
> -    bits::genmask_u32,
>      device::{
>          Bound,
>          Device, //
>      },
>      devres::Devres,
> -    io::poll,
> -    platform,
> +    io::{
> +        poll,
> +        register::Array,
> +        Io, //
> +    },
>      prelude::*,
>      time::Delta,
>      transmute::AsBytes,
> @@ -21,7 +23,10 @@
> =20
>  use crate::{
>      driver::IoMem,
> -    regs, //
> +    regs::{
> +        gpu_control::*,
> +        join_u64, //
> +    }, //
>  };
> =20
>  /// Struct containing information that can be queried by userspace. This=
 is read from
> @@ -29,120 +34,55 @@
>  ///
>  /// # Invariants
>  ///
> -/// - The layout of this struct identical to the C `struct drm_panthor_g=
pu_info`.
> +/// - The layout of this struct is identical to the C `struct drm_pantho=
r_gpu_info`.
>  #[repr(transparent)]
>  #[derive(Clone, Copy)]
>  pub(crate) struct GpuInfo(pub(crate) uapi::drm_panthor_gpu_info);
> =20
>  impl GpuInfo {
>      pub(crate) fn new(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Res=
ult<Self> {
> -        let gpu_id =3D regs::GPU_ID.read(dev, iomem)?;
> -        let csf_id =3D regs::GPU_CSF_ID.read(dev, iomem)?;
> -        let gpu_rev =3D regs::GPU_REVID.read(dev, iomem)?;
> -        let core_features =3D regs::GPU_CORE_FEATURES.read(dev, iomem)?;
> -        let l2_features =3D regs::GPU_L2_FEATURES.read(dev, iomem)?;
> -        let tiler_features =3D regs::GPU_TILER_FEATURES.read(dev, iomem)=
?;
> -        let mem_features =3D regs::GPU_MEM_FEATURES.read(dev, iomem)?;
> -        let mmu_features =3D regs::GPU_MMU_FEATURES.read(dev, iomem)?;
> -        let thread_features =3D regs::GPU_THREAD_FEATURES.read(dev, iome=
m)?;
> -        let max_threads =3D regs::GPU_THREAD_MAX_THREADS.read(dev, iomem=
)?;
> -        let thread_max_workgroup_size =3D regs::GPU_THREAD_MAX_WORKGROUP=
_SIZE.read(dev, iomem)?;
> -        let thread_max_barrier_size =3D regs::GPU_THREAD_MAX_BARRIER_SIZ=
E.read(dev, iomem)?;
> -        let coherency_features =3D regs::GPU_COHERENCY_FEATURES.read(dev=
, iomem)?;
> -
> -        let texture_features =3D regs::GPU_TEXTURE_FEATURES0.read(dev, i=
omem)?;
> -
> -        let as_present =3D regs::GPU_AS_PRESENT.read(dev, iomem)?;
> -
> -        let shader_present =3D u64::from(regs::GPU_SHADER_PRESENT_LO.rea=
d(dev, iomem)?);
> -        let shader_present =3D
> -            shader_present | u64::from(regs::GPU_SHADER_PRESENT_HI.read(=
dev, iomem)?) << 32;
> -
> -        let tiler_present =3D u64::from(regs::GPU_TILER_PRESENT_LO.read(=
dev, iomem)?);
> -        let tiler_present =3D
> -            tiler_present | u64::from(regs::GPU_TILER_PRESENT_HI.read(de=
v, iomem)?) << 32;
> -
> -        let l2_present =3D u64::from(regs::GPU_L2_PRESENT_LO.read(dev, i=
omem)?);
> -        let l2_present =3D l2_present | u64::from(regs::GPU_L2_PRESENT_H=
I.read(dev, iomem)?) << 32;
> +        let io =3D (*iomem).access(dev)?;
> =20
>          Ok(Self(uapi::drm_panthor_gpu_info {
> -            gpu_id,
> -            gpu_rev,
> -            csf_id,
> -            l2_features,
> -            tiler_features,
> -            mem_features,
> -            mmu_features,
> -            thread_features,
> -            max_threads,
> -            thread_max_workgroup_size,
> -            thread_max_barrier_size,
> -            coherency_features,
> -            // TODO: Add texture_features_{1,2,3}.
> -            texture_features: [texture_features, 0, 0, 0],
> -            as_present,
> +            gpu_id: io.read(GPU_ID).into_raw(),
> +            gpu_rev: io.read(REVIDR).into_raw(),
> +            csf_id: io.read(CSF_ID).into_raw(),
> +            l2_features: io.read(L2_FEATURES).into_raw(),
> +            tiler_features: io.read(TILER_FEATURES).into_raw(),
> +            mem_features: io.read(MEM_FEATURES).into_raw(),
> +            mmu_features: io.read(MMU_FEATURES).into_raw(),
> +            thread_features: io.read(THREAD_FEATURES).into_raw(),
> +            max_threads: io.read(THREAD_MAX_THREADS).into_raw(),
> +            thread_max_workgroup_size: io.read(THREAD_MAX_WORKGROUP_SIZE=
).into_raw(),
> +            thread_max_barrier_size: io.read(THREAD_MAX_BARRIER_SIZE).in=
to_raw(),
> +            coherency_features: io.read(COHERENCY_FEATURES).into_raw(),
> +            texture_features: [
> +                io.read(TEXTURE_FEATURES::at(0)).supported_formats().get=
(),
> +                io.read(TEXTURE_FEATURES::at(1)).supported_formats().get=
(),
> +                io.read(TEXTURE_FEATURES::at(2)).supported_formats().get=
(),
> +                io.read(TEXTURE_FEATURES::at(3)).supported_formats().get=
(),
> +            ],
> +            as_present: io.read(AS_PRESENT).into_raw(),
>              selected_coherency: uapi::drm_panthor_gpu_coherency_DRM_PANT=
HOR_GPU_COHERENCY_NONE,
> -            shader_present,
> -            l2_present,
> -            tiler_present,
> -            core_features,
> +            shader_present: join_u64(
> +                io.read(SHADER_PRESENT_LO).into_raw(),
> +                io.read(SHADER_PRESENT_HI).into_raw(),
> +            ),
> +            l2_present: join_u64(
> +                io.read(L2_PRESENT_LO).into_raw(),
> +                io.read(L2_PRESENT_HI).into_raw(),
> +            ),
> +            tiler_present: join_u64(
> +                io.read(TILER_PRESENT_LO).into_raw(),
> +                io.read(TILER_PRESENT_HI).into_raw(),
> +            ),
> +            core_features: io.read(CORE_FEATURES).into_raw(),
> +            // Padding must be zero.
>              pad: 0,
> +            //GPU_FEATURES register is not available; it was introduced =
in arch 11.x.
>              gpu_features: 0,
>          }))
>      }
> -
> -    pub(crate) fn log(&self, pdev: &platform::Device) {
> -        let gpu_id =3D GpuId::from(self.gpu_id);
> -
> -        let model_name =3D if let Some(model) =3D GPU_MODELS
> -            .iter()
> -            .find(|&f| f.arch_major =3D=3D gpu_id.arch_major && f.prod_m=
ajor =3D=3D gpu_id.prod_major)
> -        {
> -            model.name
> -        } else {
> -            "unknown"
> -        };
> -
> -        dev_info!(
> -            pdev,
> -            "mali-{} id 0x{:x} major 0x{:x} minor 0x{:x} status 0x{:x}",
> -            model_name,
> -            self.gpu_id >> 16,
> -            gpu_id.ver_major,
> -            gpu_id.ver_minor,
> -            gpu_id.ver_status
> -        );
> -
> -        dev_info!(
> -            pdev,
> -            "Features: L2:{:#x} Tiler:{:#x} Mem:{:#x} MMU:{:#x} AS:{:#x}=
",
> -            self.l2_features,
> -            self.tiler_features,
> -            self.mem_features,
> -            self.mmu_features,
> -            self.as_present
> -        );
> -
> -        dev_info!(
> -            pdev,
> -            "shader_present=3D0x{:016x} l2_present=3D0x{:016x} tiler_pre=
sent=3D0x{:016x}",
> -            self.shader_present,
> -            self.l2_present,
> -            self.tiler_present
> -        );
> -    }
> -
> -    /// Returns the number of virtual address bits supported by the GPU.
> -    #[expect(dead_code)]
> -    pub(crate) fn va_bits(&self) -> u32 {
> -        self.mmu_features & genmask_u32(0..=3D7)
> -    }
> -
> -    /// Returns the number of physical address bits supported by the GPU=
.
> -    #[expect(dead_code)]
> -    pub(crate) fn pa_bits(&self) -> u32 {
> -        (self.mmu_features >> 8) & genmask_u32(0..=3D7)
> -    }
>  }
> =20
>  impl Deref for GpuInfo {
> @@ -182,38 +122,68 @@ struct GpuModels {
>      prod_major: 7,
>  }];
> =20
> -#[allow(dead_code)]
> -pub(crate) struct GpuId {
> -    pub(crate) arch_major: u32,
> -    pub(crate) arch_minor: u32,
> -    pub(crate) arch_rev: u32,
> -    pub(crate) prod_major: u32,
> -    pub(crate) ver_major: u32,
> -    pub(crate) ver_minor: u32,
> -    pub(crate) ver_status: u32,
> -}
> -
> -impl From<u32> for GpuId {
> -    fn from(value: u32) -> Self {
> -        GpuId {
> -            arch_major: (value & genmask_u32(28..=3D31)) >> 28,
> -            arch_minor: (value & genmask_u32(24..=3D27)) >> 24,
> -            arch_rev: (value & genmask_u32(20..=3D23)) >> 20,
> -            prod_major: (value & genmask_u32(16..=3D19)) >> 16,
> -            ver_major: (value & genmask_u32(12..=3D15)) >> 12,
> -            ver_minor: (value & genmask_u32(4..=3D11)) >> 4,
> -            ver_status: value & genmask_u32(0..=3D3),
> -        }
> -    }
> +pub(crate) fn gpu_info_log(dev: &Device<Bound>, iomem: &Devres<IoMem>) -=
> Result {
> +    let io =3D (*iomem).access(dev)?;
> +    let gpu_id =3D io.read(GPU_ID);
> +
> +    let model_name =3D if let Some(model) =3D GPU_MODELS.iter().find(|&f=
| {
> +        f.arch_major =3D=3D gpu_id.arch_major().get() && f.prod_major =
=3D=3D gpu_id.prod_major().get()
> +    }) {
> +        model.name
> +    } else {
> +        "unknown"
> +    };
> +
> +    dev_info!(
> +        dev,
> +        "mali-{} id 0x{:x} major 0x{:x} minor 0x{:x} status 0x{:x}",
> +        model_name,
> +        gpu_id.into_raw() >> 16,
> +        gpu_id.ver_major().get(),
> +        gpu_id.ver_minor().get(),
> +        gpu_id.ver_status().get()
> +    );
> +
> +    dev_info!(
> +        dev,
> +        "Features: L2:{:#x} Tiler:{:#x} Mem:{:#x} MMU:{:#x} AS:{:#x}",
> +        io.read(L2_FEATURES).into_raw(),
> +        io.read(TILER_FEATURES).into_raw(),
> +        io.read(MEM_FEATURES).into_raw(),
> +        io.read(MMU_FEATURES).into_raw(),
> +        io.read(AS_PRESENT).into_raw(),
> +    );

Without the signature change the old code is all accessing from self.

Best,
Gary

> +
> +    dev_info!(
> +        dev,
> +        "shader_present=3D0x{:016x} l2_present=3D0x{:016x} tiler_present=
=3D0x{:016x}",
> +        join_u64(
> +            io.read(SHADER_PRESENT_LO).into_raw(),
> +            io.read(SHADER_PRESENT_HI).into_raw(),
> +        ),
> +        join_u64(
> +            io.read(L2_PRESENT_LO).into_raw(),
> +            io.read(L2_PRESENT_HI).into_raw(),
> +        ),
> +        join_u64(
> +            io.read(TILER_PRESENT_LO).into_raw(),
> +            io.read(TILER_PRESENT_HI).into_raw(),
> +        ),
> +    );
> +    Ok(())
>  }
> =20
> [snip]
