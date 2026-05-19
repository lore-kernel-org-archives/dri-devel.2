Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E93CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 02:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1105910E055;
	Tue, 19 May 2026 02:33:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y9foEj3E";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28AEC10E055
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 02:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEat5wa3/nRZE55UDrUax8JEYpho2saYuEqy25JX0qpWPVq5rIvMH39tDkQX0aEL4x2WtYrsqcLa62tKnM+TApLlRflR+WGFPpsQ2J5CRFDSgTWLmYfzwhh8uaDh+Vgd/6MqEURdhHSGjcaa62vPCngCSXcjdGQxqLc/f9XkIle37pypCJ+OF3LAeB6T1bhxP0vpx2WbZ2YjY2d4n4TYj/RL5hDZUjkHx54dUqOMBZeBZLbYZQkKTUbMrvPK10uu2Eeom9UcZTAZFHPvySN4Ocv7I/BoKonCsH5sJl4Y94OcrejjZYFZ2yanA24ypLZlwuiwZBxbSuYjGNrluz2fCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeV2f6JoNXe8JX4QVxTY7esfzTO4FZjVU8Eya4ROTE0=;
 b=S9efeWbCHJHKLMKW6ztYYcxdkh687I+iZ3X+b7bm/3u16JZYh7GovF9P3wln9trp5lsUrOF9cKHwnCevN5hUGHKNJucGoJnXi7FdkMYVkFBCLIVAqGMS9LC62uTJ73pudGsBSE9EFd1G2j/2hnjgqi4mNTgO+5FbQSl0zbjGU7jyi+HoLYORkBEpnT/JKi47Ijx0BGHvYtYu/JFUB85P+tqJwswDKsvvRBwWgjN2RvfZbOxrz9Fv65uJbS1KOfvcZmtv44vN0NTQqTnEAcC+8hFurvGCcWeck0CUlKeEaC3MfbAfnx40/1P4Fb3ps33B0wGczWQeRu4ND3T7hfYUJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeV2f6JoNXe8JX4QVxTY7esfzTO4FZjVU8Eya4ROTE0=;
 b=Y9foEj3EK1mkIn0uUZ3P+MLS5iG0fTYCUJ+MwblCgSsLbj+Ho3UUH/Zyv030TTEv7vprScfyN88qrmbUPdc9L4b2kmamS2gS+p0QvmEORJxjRcWGZYN+Ctcqvpj53tVYFVdkJe2A3wL0had8Fj0F1tuzawKjVAYr0H+5HYemix++dxItxKdGdJgqLOed9EbAhSqdN7MBlzbgv2BvwncM/x9h76lmyopxwcgB5C26WX6PkycNGNLX8Q8kywrgy7/ppGOx860QAWnEfaMguuoKV0kzf9Tzw2IjVh/CGDZB5FaF/sr/GCrbhd6yBF/Gfpr1+48FM3PXOHbV19TOKyamSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Tue, 19 May
 2026 02:33:30 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 02:33:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 11:33:26 +0900
Message-Id: <DIMAVKJECLKH.UXLZASCKVJK0@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v5 7/7] gpu: nova-core: run Booter Unloader and FWSEC-SB
 upon unbinding
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260515-nova-unload-v5-0-c4d6250ad160@nvidia.com>
 <20260515-nova-unload-v5-7-c4d6250ad160@nvidia.com>
In-Reply-To: <20260515-nova-unload-v5-7-c4d6250ad160@nvidia.com>
X-ClientProxiedBy: TY4P286CA0039.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::7) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc29eb9-ea4f-4e20-c77f-08deb54f0330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|56012099003|22082099003|18002099003|3023799003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info: 4DEN4TkbU21b7jUzbPWqCy8Q9HmxiVXmoA1TDQFH72veNDhc43tFESJUbLrCvVHEDJbws18MF6CWrzntgMD4R6HHx/yiluqEpFhWsYqOBBA8Mo1BxgqdBENXlr/143nwi4UcixTjOkLWURESAAGlDfgWYWDKEZpGJXjfjcRzTQWOhAVzuupTsx9jgNnZDCOPY9Qw4XkyBRUR4ArO4yC7uECJYAlzq4Q+pwNEFln+bolZnlFgoaNefTtnr8TxuHhZCnLtRk9PU5l0cOT3JCQlBOJfuTjf/XxndTZR9kUzgkUur6X5m8bsVP/buhVCwKfi+RnrxlZKGNnbEQB4KdZzjuGgJOgkMLnzzSa8nqRUQ4CoRnC/YbvFXsjdAyO9WwEBpU90fRDuI9LFFb7OicNJrK1n3jIDVnOBLXYylaWs+BB+Xf/Gb8U8G0qalqJ5YD7v85dFoHp5U1R2niuC8PjwJTMu5K0mYsfAmprxTM94o73CpX0VJtuBWY8VuLFEoQgE6AIHQ4mYBxNB1tMAW4GzulbMJOvDdCLPklMzD2oJ2mT2nXvTSS3uSWOvMF6N07rqhUdzHdthC42qZOfrIgCRzP1jK7fONWk1+jEQidHNRPe8qkZ7/tJKzaRdZl1bTU+SjT8Mf6bG2WcKBh4QiNW0eK1Gi3k0pvIrXy8QeNeIFq2Y6CNvYZwJuDBikTfmtH5Y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(56012099003)(22082099003)(18002099003)(3023799003)(4143699003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anlpVGRUckZXTHJnTytRbkR1ZGhmNWR5azh5bXFiMVZyUEM4NG5YNHNoOSti?=
 =?utf-8?B?QWZ5U0ZKQzVmQllyVW11M3JPRG0yNVhvMUhVL2dYT05LMWRjU3AyMEs2bkVF?=
 =?utf-8?B?VktiUnNUUlBCRjU2L0dyKytVbVY5bUhxazluVDNzVG9CbVNmQkwrWEpJb1NF?=
 =?utf-8?B?bWdvUlpRcjNVTG9wSzM1M21xMURnUFVBbXJjR2UwUmxXQnEvR3llNVZYbmFi?=
 =?utf-8?B?S1kvVzVFR25TMGdSLzB4UE1VbS9GNkM2REtxeVl5RGF3RktTZDRGOTBsSWl1?=
 =?utf-8?B?b005cGtOUWpNRDhGUjdkRjdzeGhLZGZnWDJlUnFidUpDNGplbkczNEoxL1Jm?=
 =?utf-8?B?aGhJcW9mU2oyRmswN2lNcCtsM2dHSFVKcFdGT1NEcW5pdmpKU1M1VXRaMXY5?=
 =?utf-8?B?cDlQeW54ZFMxR01HYkRVUmlncEQ4ZXVaVzhuUXVVaTdIeXl3VUN2aW56MHVi?=
 =?utf-8?B?amh5T3dtL3JoUXNLbXdvdjMyUTR2L2tIM2RYeUx3VVkwK2xrZU5lREZvdXdh?=
 =?utf-8?B?dHNzVmVTKzRrQmxzL0tBNFdVNnlxT3dZaGdQODhuTzNUYW1KWjZHZFpvN01O?=
 =?utf-8?B?akc3WFhkMW0vS0xaL3dLZ3lvbkN4amNyY01rdXAzdklGRW1lb2dpZG1SSHho?=
 =?utf-8?B?bHdmYUZuYXhBSkVRcGJiWmZsdzA5SFdQM25UU3pYUHRvSDhiTGpSMTA4VFBJ?=
 =?utf-8?B?VER0SVh6VFRiY0krTU5TSk9Nd3RkSWk4a092MHNVMVlYSUJNTWczZnZKYS9o?=
 =?utf-8?B?WjBYNkNSeHkrM1dvdmhIRnJLaERESmxTeWVxVGJFVm91K2tlOHZZaUM3OXhL?=
 =?utf-8?B?YXVzTExQeUVFVHNzRVFEK1Q0QXptb0tGTDR6dWkzUUhIcVg4V290YUpnblh5?=
 =?utf-8?B?YXYraXFpZ0d5ZlNRblRWZFlHWGlGYlk2cEdRbm1kOHR4d2JYc2NqVmJBbWRs?=
 =?utf-8?B?b0NXOGhGNXJySEcvVFpOUHdvY1VHeHNBQ1RFaWs1cVA3Z21SSnJnUkZiSHR0?=
 =?utf-8?B?VEVnS2tmbk9DZmhTU045WTlEd25ya2N3UEliTXVvY2NMd2dVL0R3emZObGpl?=
 =?utf-8?B?MGd4VjFybVpCM1hhS1hjRW9UbmZKV05RMkNhZmxGK3l5blBVZ2h5VlJhMGN6?=
 =?utf-8?B?VVJLbkcwTS9TckxTV1JYeXZBNXA3NkEyM0VIRHB4T1NDQWF6aU5UZGhPT3hu?=
 =?utf-8?B?MzhyN2FGVklueFZVbW1TWUU4b0NXekd1dURTNVV0WHZJU1MvTTRrWnpjeXYy?=
 =?utf-8?B?UWdXVlhvdFZScDE3OEhNRmZsRWFXRGVMWnpZYUlYaXJzY1N1b3E4NS9hS1Zu?=
 =?utf-8?B?WVJwRWxuYnQvcFFwZzRzZDcyKzAvMXBsMWN1R3VCZklKWG5sRHNCMVd3SDNO?=
 =?utf-8?B?aGFqV2FJZ0dQa3VnM2ZrQnNlV0pORDhleC8rWFE3TmtsYkFpUEtrRktIdUpE?=
 =?utf-8?B?U0dvWnA4VjVPaThpd1JHbytKMnltN2N1RUtkdE5DSWE0cEhLdmFhc2FTVzZK?=
 =?utf-8?B?akZRN1pvSERwR2RBQXR2cVFQcCtxcGYvZEdsbjJOSFdiL1VBV3FvdWIrSUx2?=
 =?utf-8?B?Z3VrL25uVGlOa2JsaFByQ0xwTHMvY0l6ZnU2NW91dnMxc2UvREhCY000ZGFa?=
 =?utf-8?B?SEIzdlZhcjhudHp6bkdsMm81bmZ4SlJGTWkvS2tMYW1DNEU5dGttVlV5S0hD?=
 =?utf-8?B?ZGNGbnE0bkVja1dyUG1FZ1J3WDg2em10bzBOUGpsNENZYUk4SnVnQmR4YjFv?=
 =?utf-8?B?ZWtPTlBZWXMwbHhlelVhdkhEMkplTTZlQkpXQ3g5dVE5YkZFWGV1bmRNTGQz?=
 =?utf-8?B?OEZDQmR0Y3YxbnZZb0dvNlhKM1JxWGp6Nkk0MTlLb3ZmYlB6VmtWUTJCOEta?=
 =?utf-8?B?Q3dkelFqRHRSRTNZaTZYci9vOElYT1ZCTGt4SWxLWHR6Nm1EeWdYeVJmSVdp?=
 =?utf-8?B?dVZWVjNvbU5RN0hCRGQreDVJV0hVOTdpWDhXM09NU0FvbVZ6UXR0NEFjQ1Ur?=
 =?utf-8?B?bEZBZFhSellLRUkwNkpBMlpXcG1WSFFabjJnNmkrTnJLRU9OMjNidWJpbFpR?=
 =?utf-8?B?Tng1NWRYa25WR3RuNEIxTVpXSzhTSms3aVQvRHpXRUJpRDh1b1htcWlvZ0Q3?=
 =?utf-8?B?b2RsMjRjUUFMMnVwUmdUb1lydkdoSldxYzErdE5GSmx1SjUzV0s0ZzZkTmFo?=
 =?utf-8?B?WFVwSWVYZ0JZeDJsY1VLRUVKc0h6NHR3c2JpdlNEbXMveUxVenNMa0grcGtk?=
 =?utf-8?B?V3lSUS9QNXBpMytLWkhOSkhSUXpsRFhGVXBXRi90YzBSbnppRU52OHhxY2M5?=
 =?utf-8?B?THM1bU9Lb2NpNTlaM3ZWbzIwcFpTa3M1ZXBKdFhHNlFENUp2ZlN2NlUyaW5K?=
 =?utf-8?Q?U9ZlmrByk1341B822rxIug8RdHPlnDJ+UFNu0U52+SttS?=
X-MS-Exchange-AntiSpam-MessageData-1: OrJb7BYo6NSwSg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc29eb9-ea4f-4e20-c77f-08deb54f0330
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 02:33:30.1375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JlJXO9fJonazItQ/Le6cVkI87gV9yc7e7YlJonvfrk8V3fo+8tg2zguqYXxB2US0g7yl+331AZoEr60fmvK54w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844
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

On Fri May 15, 2026 at 3:12 PM JST, Alexandre Courbot wrote:
> When probing the driver, the FWSEC-FRTS firmware creates a WPR2 secure
> memory region to store the GSP firmware, and the Booter Loader loads and
> starts that firmware into the GSP, making it run in RISC-V mode.
>
> These operations need to be reverted upon unloading, particularly the
> WPR2 secure region creation, as its presence prevents the driver from
> subsequently probing.
>
> Thus, prepare the Booter Unloader and FWSEC-SB firmwares when booting
> the GSP, so they can be executed at unbind time to put the GPU into a
> state where it can be probed again.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/firmware/booter.rs |   1 -
>  drivers/gpu/nova-core/firmware/fwsec.rs  |   1 -
>  drivers/gpu/nova-core/gpu.rs             |   2 +-
>  drivers/gpu/nova-core/gsp.rs             |   3 +
>  drivers/gpu/nova-core/gsp/boot.rs        |  18 +++-
>  drivers/gpu/nova-core/gsp/hal.rs         |  21 ++++-
>  drivers/gpu/nova-core/gsp/hal/gh100.rs   |   7 +-
>  drivers/gpu/nova-core/gsp/hal/tu102.rs   | 141 +++++++++++++++++++++++++=
+++++-
>  drivers/gpu/nova-core/regs.rs            |   5 ++
>  9 files changed, 188 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-=
core/firmware/booter.rs
> index 6a41690e72c6..6f421906c272 100644
> --- a/drivers/gpu/nova-core/firmware/booter.rs
> +++ b/drivers/gpu/nova-core/firmware/booter.rs
> @@ -281,7 +281,6 @@ fn new_booter(data: &[u8]) -> Result<Self> {
>  #[derive(Copy, Clone, Debug, PartialEq)]
>  pub(crate) enum BooterKind {
>      Loader,
> -    #[expect(unused)]
>      Unloader,
>  }
> =20
> diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-c=
ore/firmware/fwsec.rs
> index 8810cb49db67..4108f28cd338 100644
> --- a/drivers/gpu/nova-core/firmware/fwsec.rs
> +++ b/drivers/gpu/nova-core/firmware/fwsec.rs
> @@ -144,7 +144,6 @@ pub(crate) enum FwsecCommand {
>      /// image into it.
>      Frts { frts_addr: u64, frts_size: u64 },
>      /// Asks [`FwsecFirmware`] to load pre-OS apps on the PMU.
> -    #[expect(dead_code)]
>      Sb,
>  }
> =20
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index 75fe1bdb80fe..bcd403781a1a 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -297,7 +297,7 @@ pub(crate) fn new(
>      pub(crate) fn unbind(&self, pdev: &'bound pci::Device<device::Core>)=
 {
>          let _ =3D self
>              .gsp
> -            .unload(pdev.as_ref(), self.bar, &self.gsp_falcon)
> +            .unload(pdev.as_ref(), self.bar, &self.gsp_falcon, &self.sec=
2_falcon)
>              .inspect_err(|e| dev_err!(pdev, "failed to unload GSP: {:?}\=
n", e));
>      }
>  }
> diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
> index 38378f104068..58b917172efb 100644
> --- a/drivers/gpu/nova-core/gsp.rs
> +++ b/drivers/gpu/nova-core/gsp.rs
> @@ -126,6 +126,8 @@ pub(crate) struct Gsp {
>      pub(crate) cmdq: Cmdq,
>      /// RM arguments.
>      rmargs: Coherent<GspArgumentsPadded>,
> +    /// Ready-to-run GSP unload bundle, if any.
> +    unload: Option<KBox<dyn hal::UnloadBundle>>,

nit: What about calling this `unload_bundle`?

>  }
> =20
>  impl Gsp {
> @@ -181,6 +183,7 @@ pub(crate) fn new(pdev: &pci::Device<device::Bound>) =
-> impl PinInit<Self, Error
>                          dir.read_binary_file(c"logrm", &logs.logrm.0);
>                      })
>                  },
> +                unload: None,
>              }))
>          })
>      }
> diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gs=
p/boot.rs
> index 59c1b4d030ae..61f10c0d2fd2 100644
> --- a/drivers/gpu/nova-core/gsp/boot.rs
> +++ b/drivers/gpu/nova-core/gsp/boot.rs
> @@ -56,8 +56,8 @@ pub(crate) fn boot(
> =20
>          let wpr_meta =3D Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::n=
ew(&gsp_fw, &fb_layout))?;
> =20
> -        // Perform the chipset-specific boot sequence.
> -        hal.boot(
> +        // Perform the chipset-specific boot sequence, and retrieve the =
unload bundle.
> +        let unload_bundle =3D hal.boot(
>              self.as_mut(),
>              dev,
>              bar,
> @@ -67,6 +67,7 @@ pub(crate) fn boot(
>              gsp_falcon,
>              sec2_falcon,
>          )?;
> +        *self.as_mut().project().unload =3D unload_bundle;

nit: get rid of the let binding and just assign directly?

> =20
>          gsp_falcon.write_os_version(bar, gsp_fw.bootloader.app_version);
> =20
> @@ -129,6 +130,7 @@ pub(crate) fn unload(
>          dev: &device::Device<device::Bound>,
>          bar: &Bar0,
>          gsp_falcon: &Falcon<Gsp>,
> +        sec2_falcon: &Falcon<Sec2>,
>      ) -> Result {
>          // Shut down the GSP.
>          Self::shutdown_gsp(
> @@ -139,6 +141,18 @@ pub(crate) fn unload(
>          )
>          .inspect_err(|e| dev_err!(dev, "Unload guest driver failed: {:?}=
\n", e))?;

Suppose that shutdown_gsp fails. In that case, we early return and don't
try to reset. Is that the correct behaviour? Maybe we still want to try
to reset even though shutdown didn't work. OpenRM looks like it still
tries the reset even if shutdown fails.

> =20
> +        // With the GSP shut down, reset the GSP so it can be restarted.
> +        if let Some(unload_bundle) =3D self.unload.as_ref() {
> +            unload_bundle.run(dev, bar, gsp_falcon, sec2_falcon)?;
> +        } else {
> +            dev_warn!(
> +                dev,
> +                "Unload bundle is missing, GSP won't be properly reset.\=
n"
> +            );
> +        }

It feels a bit odd to me to (conceptually) allow the unload bundle to be
run multiple times. IMO, ideally we would be able to take() this. Since
we don't have a mut self though we can't unless we add a Mutex or
something. If we do, we can update UnloadBundle::run to consume the
value so it can only be run once, which is nice. WDYT?

> +
> +        dev_info!(dev, "GSP successfully unloaded\n");
> +
>          Ok(())
>      }
>  }
> diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp=
/hal.rs
> index 4d8c1998f4cf..d9c324226dda 100644
> --- a/drivers/gpu/nova-core/gsp/hal.rs
> +++ b/drivers/gpu/nova-core/gsp/hal.rs
> @@ -29,9 +29,28 @@
>      },
>  };
> =20
> +/// Trait for types containing the resources and code required to fully =
reset the GSP.
> +///
> +/// The GSP unload code might run in a situation where we cannot load fi=
rmware dynamically (e.g.
> +/// because we are in shutdown and the file system is not accessible any=
more). Thus, the firmware
> +/// required for unloading is prepared at load time, and stored here unt=
il it needs to be run.
> +pub(super) trait UnloadBundle: Send {
> +    /// Performs the steps required to properly reset the GSP after it h=
as been stopped.
> +    fn run(
> +        &self,
> +        dev: &device::Device<device::Bound>,
> +        bar: &Bar0,
> +        gsp_falcon: &Falcon<GspEngine>,
> +        sec2_falcon: &Falcon<Sec2>,
> +    ) -> Result;
> +}
> +
>  /// Trait implemented by GSP HALs.
>  pub(super) trait GspHal: Send {
>      /// Performs the GSP boot process, loading and running the required =
firmwares as needed.
> +    ///
> +    /// Upon success, returns the [`UnloadBundle`] to be run (if any) in=
 order to properly reset the
> +    /// GSP after it has been stopped.
>      #[allow(clippy::too_many_arguments)]
>      fn boot(
>          &self,
> @@ -43,7 +62,7 @@ fn boot(
>          wpr_meta: &Coherent<GspFwWprMeta>,
>          gsp_falcon: &Falcon<GspEngine>,
>          sec2_falcon: &Falcon<Sec2>,
> -    ) -> Result;
> +    ) -> Result<Option<KBox<dyn UnloadBundle>>>;
> =20
>      /// Performs HAL-specific post-GSP boot tasks.
>      ///
> diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-co=
re/gsp/hal/gh100.rs
> index 9d7e9f4454b1..51e1099cda0d 100644
> --- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
> +++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
> @@ -17,7 +17,10 @@
>      fb::FbLayout,
>      gpu::Chipset,
>      gsp::{
> -        hal::GspHal,
> +        hal::{
> +            GspHal,
> +            UnloadBundle, //
> +        },
>          Gsp,
>          GspFwWprMeta, //
>      },
> @@ -40,7 +43,7 @@ fn boot(
>          _wpr_meta: &Coherent<GspFwWprMeta>,
>          _gsp_falcon: &Falcon<GspEngine>,
>          _sec2_falcon: &Falcon<Sec2>,
> -    ) -> Result {
> +    ) -> Result<Option<KBox<dyn UnloadBundle>>> {
>          Err(ENOTSUPP)
>      }
>  }
> diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-co=
re/gsp/hal/tu102.rs
> index d5da23cd8c90..c6c947696ba8 100644
> --- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
> +++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
> @@ -31,7 +31,10 @@
>      },
>      gpu::Chipset,
>      gsp::{
> -        hal::GspHal,
> +        hal::{
> +            GspHal,
> +            UnloadBundle, //
> +        },
>          sequencer::{
>              GspSequencer,
>              GspSequencerParams, //
> @@ -43,6 +46,124 @@
>      vbios::Vbios, //
>  };
> =20
> +// A ready-to-run FWSEC unload firmware.
> +//
> +// Since there are two variants of the prepared firmware (with and witho=
ut a bootloader), this type
> +// abstracts the difference.
> +enum FwsecUnloadFirmware {
> +    WithoutBl(FwsecFirmware),
> +    WithBl(FwsecFirmwareWithBl),
> +}
> +
> +impl FwsecUnloadFirmware {
> +    /// Loads the FWSEC SB firmware, as well as its bootloader if `chips=
et` requires it.
> +    fn new(
> +        dev: &device::Device<device::Bound>,
> +        bar: &Bar0,
> +        chipset: Chipset,
> +        bios: &Vbios,
> +        gsp_falcon: &Falcon<GspEngine>,
> +    ) -> Result<Self> {
> +        let fwsec_sb =3D FwsecFirmware::new(dev, gsp_falcon, bar, bios, =
FwsecCommand::Sb)?;
> +
> +        Ok(if chipset.needs_fwsec_bootloader() {
> +            Self::WithBl(FwsecFirmwareWithBl::new(fwsec_sb, dev, chipset=
)?)
> +        } else {
> +            Self::WithoutBl(fwsec_sb)
> +        })
> +    }
> +
> +    /// Runs the FWSEC SB firmware.
> +    fn run(
> +        &self,
> +        dev: &device::Device<device::Bound>,
> +        bar: &Bar0,
> +        gsp_falcon: &Falcon<GspEngine>,
> +    ) -> Result<()> {
> +        match self {
> +            Self::WithoutBl(fw) =3D> fw.run(dev, gsp_falcon, bar),
> +            Self::WithBl(fw) =3D> fw.run(dev, gsp_falcon, bar),
> +        }
> +    }
> +}
> +
> +// Contains the firmware required to fully reset GSP on chipsets where t=
he GSP is started using
> +// FWSEC/Booter.
> +pub(super) struct Sec2UnloadBundle {
> +    fwsec_sb: FwsecUnloadFirmware,
> +    booter_unloader: BooterFirmware,
> +}

Does this need to be pub(super)? It looks unused outside of this file.

> +
> +impl Sec2UnloadBundle {
> +    /// Load and prepare the resources required to properly reset the GS=
P after it has been stopped.
> +    fn build(
> +        dev: &device::Device<device::Bound>,
> +        bar: &Bar0,
> +        chipset: Chipset,
> +        bios: &Vbios,
> +        gsp_falcon: &Falcon<GspEngine>,
> +        sec2_falcon: &Falcon<Sec2>,
> +    ) -> Result<KBox<dyn UnloadBundle>> {
> +        KBox::new(
> +            Self {
> +                fwsec_sb: FwsecUnloadFirmware::new(dev, bar, chipset, bi=
os, gsp_falcon)?,
> +                booter_unloader: BooterFirmware::new(
> +                    dev,
> +                    BooterKind::Unloader,
> +                    chipset,
> +                    FIRMWARE_VERSION,
> +                    sec2_falcon,
> +                    bar,
> +                )?,
> +            },
> +            GFP_KERNEL,
> +        )
> +        .map(|b| b as KBox<dyn UnloadBundle>)
> +        .map_err(Into::into)
> +    }
> +}
> +
> +impl UnloadBundle for Sec2UnloadBundle {
> +    fn run(
> +        &self,
> +        dev: &device::Device<device::Bound>,
> +        bar: &Bar0,
> +        gsp_falcon: &Falcon<GspEngine>,
> +        sec2_falcon: &Falcon<Sec2>,
> +    ) -> Result<()> {
> +        // Run FWSEC-SB to reset the GSP falcon to its pre-libos state.
> +        self.fwsec_sb.run(dev, bar, gsp_falcon)?;
> +
> +        // Remove WPR2 region if set.
> +        let wpr2_hi =3D bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI);
> +        if wpr2_hi.is_wpr2_set() {
> +            sec2_falcon.reset(bar)?;
> +            sec2_falcon.load(dev, bar, &self.booter_unloader)?;
> +
> +            // Sentinel value to confirm that Booter Unloader has run.
> +            const MAILBOX_SENTINEL: u32 =3D 0xff;
> +            let (mbox0, _) =3D
> +                sec2_falcon.boot(bar, Some(MAILBOX_SENTINEL), Some(MAILB=
OX_SENTINEL))?;
> +            if mbox0 !=3D 0 {
> +                dev_err!(dev, "Booter Unloader returned error 0x{:x}\n",=
 mbox0);
> +                return Err(EINVAL);
> +            }
> +
> +            // Confirm that the WPR2 region has been removed.
> +            let wpr2_hi =3D bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI);
> +            if wpr2_hi.is_wpr2_set() {
> +                dev_err!(
> +                    dev,
> +                    "WPR2 region still set after Booter Unloader returne=
d\n"
> +                );
> +                return Err(EBUSY);
> +            }
> +        }
> +
> +        Ok(())
> +    }
> +}
> +
>  /// Helper function to load and run the FWSEC-FRTS firmware and confirm =
that it has properly
>  /// created the WPR2 region.
>  fn run_fwsec_frts(
> @@ -161,7 +282,7 @@ fn boot(
>          wpr_meta: &Coherent<GspFwWprMeta>,
>          gsp_falcon: &Falcon<GspEngine>,
>          sec2_falcon: &Falcon<Sec2>,
> -    ) -> Result {
> +    ) -> Result<Option<KBox<dyn UnloadBundle>>> {
>          let bios =3D Vbios::new(dev, bar)?;
> =20
>          // FWSEC-FRTS is not executed on chips where the FRTS region siz=
e is 0 (e.g. GA100).
> @@ -185,7 +306,21 @@ fn boot(
> =20
>          run_booter(dev, bar, chipset, sec2_falcon, wpr_meta)?;
> =20
> -        Ok(())
> +        // Last, try and prepare the unload bundle. If this fails, the G=
PU will need to be reset
> +        // before the driver can be probed again.
> +        let unload_bundle =3D
> +            Sec2UnloadBundle::build(dev, bar, chipset, &bios, gsp_falcon=
, sec2_falcon)
> +                .inspect_err(|e| {
> +                    dev_warn!(dev, "Failed to prepare unload firmware: {=
:?}\n", e);
> +                    dev_warn!(dev, "The GSP won't be able to unload prop=
erly on unbind.\n");
> +                    dev_warn!(
> +                        dev,
> +                        "The GPU will need to be reset before the driver=
 can bind again.\n"
> +                    );
> +                })
> +                .ok();
> +
> +        Ok(unload_bundle)
>      }
> =20
>      fn post_boot(
> diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.r=
s
> index 6faeed73901d..356fbf364ea5 100644
> --- a/drivers/gpu/nova-core/regs.rs
> +++ b/drivers/gpu/nova-core/regs.rs
> @@ -175,6 +175,11 @@ impl NV_PFB_PRI_MMU_WPR2_ADDR_HI {
>      pub(crate) fn higher_bound(self) -> u64 {
>          u64::from(self.hi_val()) << 12
>      }
> +
> +    /// Returns whether the WPR2 region is currently set.
> +    pub(crate) fn is_wpr2_set(self) -> bool {
> +        self.hi_val() !=3D 0
> +    }
>  }
> =20
>  // PGSP

