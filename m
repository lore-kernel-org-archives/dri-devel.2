Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD35D1088E63
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 02:18:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42CEF10E7F2;
	Thu, 19 Mar 2026 02:18:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="sPLwvH3a";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB95E10E7F2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 02:18:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovrznsmEJQ6DEqMqT1/p2jB89zP9p4geeiDXCNA9T/r5u1G0+mBzEFnByYjbLn6BO9jYhsIsqmFmRxyuiV6/2K3Ty6lwEgSul+yt+3TpiTThq8l0kXMJk8FhprSEmc3DUjx1xT2l+U6cC51tLGr1hVkbdBmzqgkkXUCxmYT8Zzhc4Wy4lJm0EJKj68m3B+DZ0ZgQPuEMRZAcs8pykElniI40quaFbvwKVTFsky0F46Am+Wasmj5pZkXdKOUIlyvOHXUda7txXJfkCWqdjLZ2SPZsLuOaQQp20L9SpBgyben1o/YVsEhi5zxfZKPVhjuY6GlOV2pBzJXRKS9LacBJ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2rjNeoWysC+yh5o7AErTzBlASoP+hLFV3vxjyV6urQ=;
 b=WPPsmUlFyGeQKC7y2W2OncIWhS5dd2MQvRaQg/8kW02U2dnqeXDZbpNXdyTkx210oiUsMaI5FRV3qkVTnxr1alFw4/DpCjtrFCfY0Z6x2WlL//t/Sh7soYZE7vVhYN4gV0p4LFI0X5H+lPm9MUOamd7tvvP2MGHz5yx/G6PflpqAj6YFBkpMjNKBmCw8mKCPh+9pqQwnVEh1msv7W/5Frk3OvHql3LZFsIFDILuWyEJnU7D8SbDAkzNLnOeG8KqQNXhiV9Rt4cleK9ZbI1rlXxs12zZtBDHQSuPU7+joO39TLfj6XLn8pPugDCIJtaoTqwLO9W2scEBxTCx2rJmshg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2rjNeoWysC+yh5o7AErTzBlASoP+hLFV3vxjyV6urQ=;
 b=sPLwvH3a1Zbf/hBvYlCGiCk5JJrDiM/SzX8gn6RTyaztxlJ/nH6Ru/krjj711TELOg+U+yoDiQUFA7kcICsJP9LVLvWBvfRQfU9/kELGgVHbgF2xHyWrL+qEEGhJnnE6NucnPjVRlWNUSQsz7m66iXfPI/BRMJ4lnp1r5toYKwp84Zk4wp3SdKbPII4eV8FibtB6ndwwqrMlKYiceTy0B1LDpeu8vjEDkczW+UHxafW73qQvp1txc5qa/ZXAPUCe+GOLZ9JmhB+54cEJACS4cZZpdp37/4UuOqxwS8i49uuATPFDQlsGMJXLWdi6EZKJKnYU0HgFflp8cOTxMq9sdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8351.namprd12.prod.outlook.com (2603:10b6:208:40e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 02:18:03 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Thu, 19 Mar 2026
 02:18:03 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 11:17:59 +0900
Message-Id: <DH6ECIKZRESY.D4VBM1STGPH@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 5/8] gpu: nova-core: convert FUSE registers to kernel
 register macro
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com>
 <20260318-b4-nova-register-v1-5-22a358aa4c63@nvidia.com>
In-Reply-To: <20260318-b4-nova-register-v1-5-22a358aa4c63@nvidia.com>
X-ClientProxiedBy: TYCP286CA0015.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::19) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b6ca692-fe69-4c39-0a2f-08de855dbff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|10070799003|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info: jrvDOF33Xh47y0HdMvMAg+Ti59MHzmr15uXv4k/LR944aD7xIXb7Zj73s6uSqRMTqena4NA103Dbs0pEUU1YnegEN74UrVGIQYYS1lKVnwU52fSfSvbInCTxJ9DCNpba/plfqiW+T5eHWDZ7CyuTo3P98z9D96oiJyCESK3+dV4WTY7EFF/CNQrOg2m3YV/CsaKCKX5Y0IuqcDg6Zz3X/X9tBaNAMgH6r6qeaOTkmsg46IRlGFEXuUm/5x0+UHtwUSBqCYqOTjXeiW7fLLBkUAQy3zb69KdcnXcK9HYSnyJOCukQZIujWZIeg1TSozhxOk+eIR2T5oC83PSfJbY/tqY+IJkLda4B4AWlihiYXpa0AsCrtr0xJpWCUErYyQNuf39uTljp+OkYepZi/tp8dqBVBht9S0XFxsQoBLjmN0wyNjiYikbKkU+jTM6EsNjRRwT1BpMwn5JfgURGQTc/LdWSa3zrRWcE+qID2ckuHuml3S5+kpnbVZeCI9wNlQZHu4o5dvolhzwcK4ZITK3r9f7L1jsJ6k8v6/Y5w6Ei6YtWxGJiDSarPTfqLVyZ0BJaTOuCGJ2d5MkE/uXSrWwneBz2u0Hwg9MAOutsOMubDQaB6OrCSHFQnqrA2kJOEmYgylg7dt97p0X9MXgKBjCXewTEm9/6Bi/9epz7ETVCs5RJwg2eZQV5RVIa3H4WncMVTzapxcexzP16JT+/MuGv1y0r2LvV5MhbTfJpZcQWfJpU/HjYdq/RGNIvgpcmz7vhQoqJYvkpn9eSBx8ITpE80A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(18002099003)(22082099003)(56012099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1ppU0NEM0hNbDQzNVc4L3VTNDcxSGhBV3FoZHBiOTlhL2xCbGt0TWdxVnlp?=
 =?utf-8?B?VjZYVG5tcXF6cEtsOExSQVpUYkVRZ2xFTmxBb1c3NHVXc1prMTV6TVNwdHRW?=
 =?utf-8?B?RExxb0Nxd1FDR2JNaWh2eXN3dUl6WW1UaGptQ0FvNkNRWTRIUVJyT0tTMVJF?=
 =?utf-8?B?SVY5bGNjZzVRZ0VFV1hQT1orQU01Z1ZaM3JEZlpwUE55aHhkSVJFUVNUNnE4?=
 =?utf-8?B?eEhzVEJUcURpVnh6NHpEMEpNWVhhTjk4RTFqZFdDN01rUjNVNkpPWG4xT3JB?=
 =?utf-8?B?N1lxdE1iVHZzbVlTbGhSV3JxN1BITlk2YS9ZcVo1a0pDS3FUc2R2bmJnUlZZ?=
 =?utf-8?B?cHlwTCs3UUh1aDh1MlIzOS9VenNWaERMT1Bra28wVDBHWVhpN05ENmVFcHpv?=
 =?utf-8?B?ZWF0dmZZNkRDV0ErbXlCYTNtV0dYT0hYUlVNdGtUZjIvVHhIS0I1eUJ5YU5k?=
 =?utf-8?B?VE83eGNIQllYeUIyZHozcjUwblpqWHpOYm1sUDE0ZFpIWGRhOVpyTE1WQ1ZG?=
 =?utf-8?B?dXFXZlAyaStjYy9IaDdSdld6R2NrNzhmOGRaSUVjWWJPUzkvNE5kUTVPUGgw?=
 =?utf-8?B?NTZxU0tJbnVwOWpKK3IrUWdIYkRrOVg2QWdPVDdIREpBcEtEeGdONE1ZYzMz?=
 =?utf-8?B?TkVkcHJzQldYSGFKL1VkempxajFtTE92N05Od0FHR3dJTG1OVEVqZm9JWkt1?=
 =?utf-8?B?S1RYQmRRb0toWnVwcVd3cVlpSmt0Mk5TT3dwS3g0czgwUGtyZXB5ckQ1YVNC?=
 =?utf-8?B?bXZNSGUvYWN3QVZYWWJTK3hRelY5WmZrb0lERlYvR0hwajMzY0dXMW0xV3d2?=
 =?utf-8?B?b1pZRWd1dCtQZ2h5SW4wVTlvM1BWdUJhTXFLZmVOZ2hkVlB6VTRuT3c0dGMr?=
 =?utf-8?B?SGZHNldFYzhEbVArRDBDRUZHbG11UEN0M0JnYkkxblcweUpTSTM1eXRia3g2?=
 =?utf-8?B?MWRqSEUyQjh5cXNYR3hFZXNSelAwOTBkV0kxOEFKOFhGV1U1SGRJMHpjZUd4?=
 =?utf-8?B?QW85Zml6ZzB5S0ROSEc3SS9LV2tMeGIwOXlydG9qaWRWMGxvZGEraUxCcGpU?=
 =?utf-8?B?dnl6cXdZMkNNMlJySUIvbmxReCt2ZEg3L3V5UVdLNDcvNDcxTjN5MWI1a0JT?=
 =?utf-8?B?MCtOTzBGVmM0ZW9DNjRIZFZQQ2IxNTVSQk9VM2o1ZzgrZ09sOHRocklIWjlD?=
 =?utf-8?B?c0hwMzVFemF0SThjN3VFSTI2TkNhbFVrT1FuQUJVN3hGRnUvdFU1d0M2dG9l?=
 =?utf-8?B?OVdCNGZ1dGEweU51V0NHMlF1TjA2NktsK3c2Z1hFMGVCQlBuUkJOa1RwTFNH?=
 =?utf-8?B?OHB3TXl2ZThpL3dWR1hqS0p0bFhSUUlMbGhzdWlBL2RTTDU2MmRlSkFDd2hi?=
 =?utf-8?B?YmJ1UDVxNmR1UGJKZ2c4RW9IRlJaTFFhTzVzaHNZaTgrTGhTNitHckoxWVJC?=
 =?utf-8?B?K3hRNDJ2aW5mKzE2dVRJZ3IyY1BQcUYvOTF0VnBzbElTR214TS9VaVlpMGJE?=
 =?utf-8?B?eU1zbjNVY2RWLy83elF6Q3QxZGhldm5QeVhLeHdIZXZjNWJ6SjFqUnBmSDha?=
 =?utf-8?B?Zk5lbUdzc1hQZCtaZGQ2Mlk0c09iWWpKeFNpaG1qUlNCZE9kQmF1dnJZRjFy?=
 =?utf-8?B?MEtmcnR4eDczdWVmTGwwMzF3NEdOUFlQTXJVUUNtRlVZMDlTNDEzN0ZueExl?=
 =?utf-8?B?RkhhZ0RiR2lvenRpbmovNkNIUkJqeXJjNFNNamJHQUlXbEYzN1ZjV3cyak0x?=
 =?utf-8?B?Z3pUS3BMS3NBZEJkdkovUlNMWjEzOXQrNEI3eWR6UjlXNm1rdmplNXBwcVpI?=
 =?utf-8?B?TnVPNmxvRVl4bXBlS1FVa2N5ZWo0UXFUREppVDJ3aS9zRktIOVpDMG5HOEx0?=
 =?utf-8?B?UDdxZXpJaEQ1VHZkdTNNcW11a25pZ0dFU3o3UFRiQWV0eW95R0sxWmFqYkZ5?=
 =?utf-8?B?Y2FXdG9FMktuc25kVHBOVDJ2cVBRaTBCRmV6STVWc1ZKdVZnYjBYNkUzL1NI?=
 =?utf-8?B?dHZGR0tZRWs3WGh6VEgyVGtIVjU2akJwUGpIRU5wdVdDaUNOcmltL1orOHdD?=
 =?utf-8?B?SFg1Nmxvdk9ZY3h2RUxGUjRkUGd6QmpZYW53NmZxYUlVd2FzbWR3S3ZYYkp3?=
 =?utf-8?B?WlZ5Mm5PZE9aNDhobm9CVVFSYkR4VVU2Ynllb081NlNLTnRqYUswVHVsL2th?=
 =?utf-8?B?dkxVTVJYZ0lGbmF6enVoVUVZZkdaQlM2ZUtxNDZPcmtQTHFFRWx3VUY0Tmlj?=
 =?utf-8?B?dnZtRW8vclZyKzlmSzNJSkl0Qm1BYVZpOUlKYktwQkNCT0RMaVViL3dud2wz?=
 =?utf-8?B?QlBDOTBJY2hjUGJaMld1YWVOVUhkeS9JZzZNUnVqQTZRL2ZWZ0NVY0Mxa0tw?=
 =?utf-8?Q?WHQniqmqceTrclLcIA0l4wpZD5yDQXdr2FWrRPEC5OORD?=
X-MS-Exchange-AntiSpam-MessageData-1: XOzpzVBHNqorUw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6ca692-fe69-4c39-0a2f-08de855dbff4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 02:18:03.4910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWDXINt4HcDcgXKFf1de/lv5y4JMOLA7yy/uJmEewH/4fH43NAcYuL6Q89k9C4ZW8GTFL49WnKt7SSvba7GJWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8351
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

On Wed Mar 18, 2026 at 5:06 PM JST, Alexandre Courbot wrote:
> Convert all FUSE registers to use the kernel's register macro and update
> the code accordingly.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/falcon/hal/ga102.rs | 20 +++++++++++------
>  drivers/gpu/nova-core/fb/hal/ga100.rs     |  3 ++-
>  drivers/gpu/nova-core/fb/hal/tu102.rs     |  3 ++-
>  drivers/gpu/nova-core/regs.rs             | 36 ++++++++++++++++++-------=
------
>  4 files changed, 39 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/falcon/hal/ga102.rs b/drivers/gpu/nova=
-core/falcon/hal/ga102.rs
> index 8f62df10da0a..e3eb6189819f 100644
> --- a/drivers/gpu/nova-core/falcon/hal/ga102.rs
> +++ b/drivers/gpu/nova-core/falcon/hal/ga102.rs
> @@ -4,7 +4,11 @@
> =20
>  use kernel::{
>      device,
> -    io::poll::read_poll_timeout,
> +    io::{
> +        poll::read_poll_timeout,
> +        register::Array,
> +        Io, //
> +    },
>      prelude::*,
>      time::Delta, //
>  };
> @@ -60,16 +64,20 @@ fn signature_reg_fuse_version_ga102(
> =20
>      // `ucode_idx` is guaranteed to be in the range [0..15], making the =
`read` calls provable valid
>      // at build-time.
> -    let reg_fuse_version =3D if engine_id_mask & 0x0001 !=3D 0 {
> -        regs::NV_FUSE_OPT_FPF_SEC2_UCODE1_VERSION::read(bar, ucode_idx).=
data()
> +    let reg_fuse_version: u16 =3D if engine_id_mask & 0x0001 !=3D 0 {
> +        bar.read(regs::NV_FUSE_OPT_FPF_SEC2_UCODE1_VERSION::at(ucode_idx=
))
> +            .data()
>      } else if engine_id_mask & 0x0004 !=3D 0 {
> -        regs::NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION::read(bar, ucode_idx)=
.data()
> +        bar.read(regs::NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION::at(ucode_id=
x))
> +            .data()
>      } else if engine_id_mask & 0x0400 !=3D 0 {
> -        regs::NV_FUSE_OPT_FPF_GSP_UCODE1_VERSION::read(bar, ucode_idx).d=
ata()
> +        bar.read(regs::NV_FUSE_OPT_FPF_GSP_UCODE1_VERSION::at(ucode_idx)=
)
> +            .data()
>      } else {
>          dev_err!(dev, "unexpected engine_id_mask {:#x}\n", engine_id_mas=
k);
>          return Err(EINVAL);
> -    };
> +    }
> +    .into();
> =20
>      // TODO[NUMM]: replace with `last_set_bit` once it lands.
>      Ok(u16::BITS - reg_fuse_version.leading_zeros())
> diff --git a/drivers/gpu/nova-core/fb/hal/ga100.rs b/drivers/gpu/nova-cor=
e/fb/hal/ga100.rs
> index 629588c75778..1c03783cddef 100644
> --- a/drivers/gpu/nova-core/fb/hal/ga100.rs
> +++ b/drivers/gpu/nova-core/fb/hal/ga100.rs
> @@ -40,7 +40,8 @@ pub(super) fn write_sysmem_flush_page_ga100(bar: &Bar0,=
 addr: u64) {
>  }
> =20
>  pub(super) fn display_enabled_ga100(bar: &Bar0) -> bool {
> -    !regs::ga100::NV_FUSE_STATUS_OPT_DISPLAY::read(bar).display_disabled=
()
> +    !bar.read(regs::ga100::NV_FUSE_STATUS_OPT_DISPLAY)
> +        .display_disabled()
>  }
> =20
>  /// Shift applied to the sysmem address before it is written into
> diff --git a/drivers/gpu/nova-core/fb/hal/tu102.rs b/drivers/gpu/nova-cor=
e/fb/hal/tu102.rs
> index 515d50872224..281bb796e198 100644
> --- a/drivers/gpu/nova-core/fb/hal/tu102.rs
> +++ b/drivers/gpu/nova-core/fb/hal/tu102.rs
> @@ -29,7 +29,8 @@ pub(super) fn write_sysmem_flush_page_gm107(bar: &Bar0,=
 addr: u64) -> Result {
>  }
> =20
>  pub(super) fn display_enabled_gm107(bar: &Bar0) -> bool {
> -    !regs::gm107::NV_FUSE_STATUS_OPT_DISPLAY::read(bar).display_disabled=
()
> +    !bar.read(regs::gm107::NV_FUSE_STATUS_OPT_DISPLAY)
> +        .display_disabled()
>  }
> =20
>  pub(super) fn vidmem_size_gp102(bar: &Bar0) -> u64 {
> diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.r=
s
> index 4439464aae4d..9682a94b8b77 100644
> --- a/drivers/gpu/nova-core/regs.rs
> +++ b/drivers/gpu/nova-core/regs.rs
> @@ -294,17 +294,19 @@ pub(crate) fn vga_workspace_addr(self) -> Option<u6=
4> {
> =20
>  pub(crate) const NV_FUSE_OPT_FPF_SIZE: usize =3D 16;
> =20
> -register!(NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION @ 0x00824100[NV_FUSE_OPT_=
FPF_SIZE] {
> -    15:0    data as u16;
> -});
> +nv_reg! {
> +    NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION[NV_FUSE_OPT_FPF_SIZE] @ 0x00824=
100 {
> +        15:0    data;
> +    }
> =20
> -register!(NV_FUSE_OPT_FPF_SEC2_UCODE1_VERSION @ 0x00824140[NV_FUSE_OPT_F=
PF_SIZE] {
> -    15:0    data as u16;
> -});
> +    NV_FUSE_OPT_FPF_SEC2_UCODE1_VERSION[NV_FUSE_OPT_FPF_SIZE] @ 0x008241=
40 {
> +        15:0    data;
> +    }
> =20
> -register!(NV_FUSE_OPT_FPF_GSP_UCODE1_VERSION @ 0x008241c0[NV_FUSE_OPT_FP=
F_SIZE] {
> -    15:0    data as u16;
> -});
> +    NV_FUSE_OPT_FPF_GSP_UCODE1_VERSION[NV_FUSE_OPT_FPF_SIZE] @ 0x008241c=
0 {
> +        15:0    data;
> +    }
> +}

What about using data =3D> u16 here (like below with =3D> bool), then we ca=
n
avoid the into()?.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

> =20
>  // PFALCON
> =20
> @@ -517,15 +519,19 @@ pub(crate) fn reset_engine<E: FalconEngine>(bar: &B=
ar0) {
>  pub(crate) mod gm107 {
>      // FUSE
> =20
> -    register!(NV_FUSE_STATUS_OPT_DISPLAY @ 0x00021c04 {
> -        0:0     display_disabled as bool;
> -    });
> +    nv_reg! {
> +        NV_FUSE_STATUS_OPT_DISPLAY @ 0x00021c04 {
> +            0:0     display_disabled =3D> bool;
> +        }
> +    }
>  }
> =20
>  pub(crate) mod ga100 {
>      // FUSE
> =20
> -    register!(NV_FUSE_STATUS_OPT_DISPLAY @ 0x00820c04 {
> -        0:0     display_disabled as bool;
> -    });
> +    nv_reg! {
> +        NV_FUSE_STATUS_OPT_DISPLAY @ 0x00820c04 {
> +            0:0     display_disabled =3D> bool;
> +        }
> +    }
>  }

