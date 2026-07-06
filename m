Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE06C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 146E110E8EC;
	Mon,  6 Jul 2026 11:44:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="NggWVh6K";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013036.outbound.protection.outlook.com
 [40.93.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E753710E8EC
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 11:44:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9PkXQmQmEzuXZafZsqeDbmOJ4rbPbnUdy6cZYRrKUNdMtLDLsG1SrrpBjRE50LHEphj8rDMM4g7pncUmA09euXUY4PlJl0xnVQR30LY5RGURNt9B8wxXjia7JtkhjtSpdZaKsifYOlPfQxMKd+8+7LZNyjWHm+lPktqorEu07iHG2JsjnNjq0xUhn7s5kE84WTcdNcot0EjKI/Td5NFQq9juVDl9noiA9WvUVl3wrwpE9TA8URbQXXJEvM9skEQ0EsMJQcMOZnRs6V6CtimHZoB70lGWbov16eDcmFGerDZPygipmJOR5rlBtwB1ftiixBTDkOA01KE8cc/UoOSBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50hSusGbINequJ6V8rQrPHZZwZ3qW2b4imyJ8FnwF88=;
 b=bi3IwrF8oRJKpyfu2W6vzb785b9Yg13uNxqMPaxMywY0Fb6M0AkmVRGVE7gpaTQ7uWQ+i3yg+DvVrh9naunsWzM5dIx57PrnxajdBYYqYiEmKTKD0kyZy8NRkqYIidkXXxXMpzb6fY+XsflYFIX+q+3uocw+iPGjca6izkWofEhlxdaJo4B+h84zOPZcBafbLk8IY3tFy25u794ojicHmGDbJxxhf8aPaIBifHXu4zl/ybivOscRCgex9sxpGq5u1ad+7HPbBV3AOPdRJNsYUe0qAdscItfmvopeRdOBHb3y9hN0Bc4ZBKiHuu/JyCNdd7kcp5KFjXqlD0G1pC/x5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50hSusGbINequJ6V8rQrPHZZwZ3qW2b4imyJ8FnwF88=;
 b=NggWVh6KjHy0x2MtkWucurajgY81dtfeIRzQcZxq2IY39kju3FdYZvy/9Yy2m380nwK0sCk9R/A14jE3ll72vKtXRnXLFP10or5xp7gtGH5OvQR1neqMEPHu9sRj0tb9K18MfI+WglFD+5osgD9U3sIyNhdwft8uCzSwUta0T0cZ4BE7z+pgbZ08SSXQR7BV2H/mSZuRkfhfAFVSzfA/cearaHcb6PFXUkOzAxIECxx7oBFj0HJLe2RGdRjkDXPtZ5Bl0gH3OKjd1EUV/vDaqJ037TpEfVg73NAgfz1MtD2smenyD86AXZtxB7n2h927VsoiUEHE9BvrKQOGGwR0Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH0PR12MB7929.namprd12.prod.outlook.com (2603:10b6:510:284::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Mon, 6 Jul 2026 11:44:45 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 11:44:45 +0000
Date: Mon, 6 Jul 2026 21:44:39 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Pedro Yudi Honda <niyudi.honda@usp.br>
Cc: dakr@kernel.org, acourbot@nvidia.com, nico.antinori.7@gmail.com, 
 aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch, 
 dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev
Subject: Re: [PATCH v2 5/5] drm/nova: use `zerocopy` in riscv.rs
Message-ID: <akuVDYsJHQanCsGe@nvdebian.thelocal>
References: <20260702120324.40388-1-niyudi.honda@gmail.com>
 <20260702120324.40388-6-niyudi.honda@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702120324.40388-6-niyudi.honda@gmail.com>
X-ClientProxiedBy: SY5P282CA0192.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:249::18) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH0PR12MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a98e28-623b-474f-1ce1-08dedb53f9f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|7416014|22082099003|18002099003|6133799003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: FABfW42y5V8DCpn2l6q33FIUcM4EonqoP/gGSDS/F00MRB5AF/1qpbghGOvKNbw0gJ1QkT/wwUmUkiIzvQOUWBbDuFVJbsdkL4bHa07WL6PpH8SfxCn9Ai865nOUMRveYYkQfKLrjXacDXXWe3ouHzoxSP4jjjWiU7zzlq5O9Z4hfkK6TNRmWOyb04YnOKav/f4W1bLakXoUTc9Uos6M/kz9gi47Y404/Cy6wKU2UgXrCDAzugrLfoA3k3ErNYl4MkiBhI9S9muO/WHCtCvH2TxrcNMLyF/v+ufrA3lzXoQQEd4P4GkJUktG4iujf8dsZ04dRpL+oXPxS2xdQn9Lb1nN1KZHjBAwCRy6TgD9MqnkiKCF8ItSJTtn0feCCzuEN7ouwgHDlDE1cCSvQ0jt0TfPFEnud2bs9PPKunIUtf06j+FwO59ZHWLjoqa6Jqimza7CV3X2/8j7VtqCy4aZLMXsKD8FblrfdAUqKFoWMxbhtAdqon8SU/KRKOpJdLZCKAvpsrr6d/V3M+u8vDUzo8yTkzQEHuHUEmOMw/fjyXf7Y0Ry8YyF611x5kT3Lsldj/7xa2Iy7Xc7sNGOowyIKplXUAgMPNIIa6SHEz/rthUECGnMk8Ae+6yD9FGBchwg5t3iOlP5BTwDk4hMGfnVmaH9FRBYJFSx/fi63kslvrs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zgvYO2Kwf7kSuKcpKFOIArjpfkZcTP+NYiHBVD+79BL/uCUNrSlr7N64K785?=
 =?us-ascii?Q?oB8Pr5EPBxf0XRcaFWrGqexsAyA6mah/lEia5DH6kSuopcCwX9XzZp9y8erP?=
 =?us-ascii?Q?L/Yq9PSf/FxUR9tS34uV0va85U/nPCiLXl5WmrgltT4cDNLiJ4as/tL7J5GM?=
 =?us-ascii?Q?VNUPkNTu1YgBMMaiWRXRoG2AbYLeLbC3UwwRIzbGVtaSg7EcCLnylMqBWGW4?=
 =?us-ascii?Q?OhFfx8JTV9sbx44NsQX9MqFAnPQgukN8Eu2nKLvNSKO6GztpXKKKxeDYRU4P?=
 =?us-ascii?Q?37ncbbBWhPhXIfeRq7uHSrd0XAicrOKXa39zrzuelhX0SmjnLNxD0r+zvnT1?=
 =?us-ascii?Q?IwdHvxFRfv//egftYG5WHRi7w154UmiiXFLR3GBUmsYdnIBlDCEc9yUiCmNb?=
 =?us-ascii?Q?1ELFQH5vW3ZTQCJQv3GOqNnIasHcceZre4yVWHKetTYe9Qi1LSlWN0OAzH/f?=
 =?us-ascii?Q?I63KLcQZoHwnGmUGBSSe9QFFwqJiNGgPLllK1XZrc0UEHB/w31vfE62eOery?=
 =?us-ascii?Q?S8z9BMrUVQsoxLfc/O5bBh+tCsc3fOqNpqUwtxRw3fDzoxGycpkx7Bet0Oh4?=
 =?us-ascii?Q?GxG+cec+irOFEvvH2NEkJpSfeUNeLthDd3MDdNUVLaAelxg/OjvkLhwPPs9y?=
 =?us-ascii?Q?58v43gYWvF/CEU6cgvyYsuj3WVgPDKLqWdqMynYymfCx0vFZZy5CpSC0V5KG?=
 =?us-ascii?Q?tIyQlEQQXUKCu6ZHelYYnNBD9rcLfbv4ANNPgRe/aSXhr4xpp7I9b3heHMen?=
 =?us-ascii?Q?FZA+5DU8HIqPgNuelzZfnc+JQST3d2qBgNct1fZhC9QKQBjPSujmrRjrjXY4?=
 =?us-ascii?Q?CqYSxPsMVbg4+77dxMXypcfDOiitA9Qp0XbgruMfkFWEWuCQjjVQOMTNjp39?=
 =?us-ascii?Q?BBJDSyg9xPZVY4X9nG9gIW11667hSQ8gvp7j4RhzfCiNlrMgkzO+6wBScsLb?=
 =?us-ascii?Q?axz1yD2tW5RMhZ1aDQ3RzemWJanhiSarm3bEufj0jpbfh1bwkDpFC5IvbmL3?=
 =?us-ascii?Q?VuQP3l6tmivi2Ir+MdWk6GIQcxlAUtberUfeMsgBA8Z/7/wx2W/6SWIC5v/k?=
 =?us-ascii?Q?pBSz8qQ8nrvqKgHyadpQZ52j50tdzoVDxclL/0ADX3olhTKJR+YXt3yU6B8D?=
 =?us-ascii?Q?Wusq1+Wgd79SoSzDcU9LivGjjWuyTYzyGPDvizn0InMPB6y8ry8bOhmfl/l3?=
 =?us-ascii?Q?wpnzBg7/B9BYExQWvX9nN0IrUnjKD6nYzL7xAtpfGZrZL/jEV/OK4SfiARWU?=
 =?us-ascii?Q?tssoeIADS4bRVVVTrwbYh87K7ioZZMEneufYrpJWkcsnXScNxuf5SHp1VmL4?=
 =?us-ascii?Q?DM2QoYsMDSajMWOzxE1ufzLEUAncm4PJ7B92nut804cbik+NazEy5K4GLR0c?=
 =?us-ascii?Q?HwKnfvf4pqL644mF1AqyfNYg+qJULj6WCgvBiHanIVifinppOrA0kNHuukYo?=
 =?us-ascii?Q?HqxNzAyPqUJhd0uV+kSBQ23ukXQG/2lAt5WL851PRjFpHVWI5E8FqJi7q+Jq?=
 =?us-ascii?Q?hnjc+a0crrMsVD8l9FBFSD/fRoyYXIW6T69QZ4DvWSyC+e1MVQ0sW8Rk0S/O?=
 =?us-ascii?Q?g7LMurPYMNteeXC8rPeB99fCnQIRJPAFjQ4r5aF5pbk6BadSXzbZYnhS1yuN?=
 =?us-ascii?Q?lAlgn5gIHsFIgrFjjmeZY773HON2P47WsaAE2sXPo1k237aZMw8YDIgNNar/?=
 =?us-ascii?Q?gR52a2o676Cn75jrp0kcKK3nv1Z2/PZF9FpvuRXbhA8WK2D7JJrj+AoDxJoa?=
 =?us-ascii?Q?cvUZloQg8g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a98e28-623b-474f-1ce1-08dedb53f9f1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 11:44:45.7020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRhQwTzewMoo01THS4K6q0BJAtNgwr2lMcXcSFdqW8Lrhl+BLtRlk/q8lHN6NqOe6AN5tQbahR/O/5jExK/zsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7929
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

On 2026-07-02 at 22:03 +1000, Pedro Yudi Honda <niyudi.honda@usp.br> wrote...
> From: Pedro Yudi Honda <niyudi.honda@usp.br>
> 
> In riscv.rs, replave the following `transmute` traits with their
> `zerocopy` equivalents:
> 
> - `transmute::FromBytes` -> `zerocopy::FromBytes`
> 
> Update call sites accordingly.

Thanks for the clean-ups.

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> Signed-off-by: Pedro Yudi Honda <niyudi.honda@usp.br>
> ---
>  drivers/gpu/nova-core/firmware/riscv.rs | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/firmware/riscv.rs b/drivers/gpu/nova-core/firmware/riscv.rs
> index 2afa7f36404e..ba56bc7d4188 100644
> --- a/drivers/gpu/nova-core/firmware/riscv.rs
> +++ b/drivers/gpu/nova-core/firmware/riscv.rs
> @@ -7,8 +7,7 @@
>      device,
>      dma::Coherent,
>      firmware::Firmware,
> -    prelude::*,
> -    transmute::FromBytes, //
> +    prelude::*, //
>  };
>  
>  use crate::{
> @@ -18,7 +17,7 @@
>  
>  /// Descriptor for microcode running on a RISC-V core.
>  #[repr(C)]
> -#[derive(Debug)]
> +#[derive(Debug, FromBytes)]
>  struct RmRiscvUCodeDesc {
>      version: u32,
>      bootloader_offset: u32,
> @@ -36,9 +35,6 @@ struct RmRiscvUCodeDesc {
>      monitor_code_size: u32,
>  }
>  
> -// SAFETY: all bit patterns are valid for this type, and it doesn't use interior mutability.
> -unsafe impl FromBytes for RmRiscvUCodeDesc {}
> -
>  impl RmRiscvUCodeDesc {
>      /// Interprets the header of `bin_fw` as a [`RmRiscvUCodeDesc`] and returns it.
>      ///
> @@ -50,7 +46,7 @@ fn new(bin_fw: &BinFirmware<'_>) -> Result<Self> {
>          bin_fw
>              .fw
>              .get(offset..end)
> -            .and_then(Self::from_bytes_copy)
> +            .and_then(|b| Self::read_from_bytes(b).ok())
>              .ok_or(EINVAL)
>      }
>  }
> -- 
> 2.34.1
> 
