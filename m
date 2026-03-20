Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890DB1093172
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 04:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC88910E957;
	Fri, 20 Mar 2026 04:26:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="hhqBvqxl";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6634010E957
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 04:26:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpW7ldoLhPlhO+pcc8Tsw8Z40gZOmDNF+wEAGhapvlytkhi3ePweHUBslek97nQzbsgpoO7sH027w1UwkG660tcdreawSuCuyoC5yN7pBBofaTit8Yz0Z/LAQvRdDQ6qga0E/vzVpvNAe/zFAU6g6+H+77xKDsIdThkMpwtbitZagZoWwgJ3J4D70EAEVqQbpPhsAkbKmY1v51MzIrOQxtA2pu66zJ1O2GAltDva3ISOFX1t6f0nhJOk5PSMb/W636cOwFNROu5s0qpBOHAMj1yrBnbXpsoOcRS/LnDKMCZ0cj07AC45Pf7J6X3t7s62VF4uNePOmmWXxhAmkR3dww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urkBT4DJ9LsLPUxTZnwPQ5wCDx5aflyPWDNWWR0EhGw=;
 b=O0SU3z2u+vbcDNja2quue3+fAZ2FcimQ6YhuXEDZaXLKq4U1PmdeMz7KoiQQi0QbntpqjiUbaa+sandNVIQTsI0JmCJ0yrcTfirJBF6nrS2kjstzm0oUVoKvlNXCE/XkJjvxrWNjgqa9ffryrUVT3TGRHqyLEjpj9VHyPg/EsRjGTWgiavFo5ZedfhCJZv36twa8CYHXdL+E+oEKrvF9qNxnQXqhVA5eGXCuh7EP58LXkWZS0l/q3i7Cu1rKlxzFpaWMDTM87t9OPs4gVh7eYisq/9/cvSGJvi15L6bOHOBSFSlwPQ4iDeUZVnAJFIyFRkyVCrOxJBUhZ+k8g2P8VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urkBT4DJ9LsLPUxTZnwPQ5wCDx5aflyPWDNWWR0EhGw=;
 b=hhqBvqxlvI9NPNUEHIL9zvYL1qBgVRhRT6KW+1RlsJxKkku84fq6y/e4IE41yJOTHfcPPkCqCqbkAMJDiBN+k+lDepSy7z42Qd8NrrN8UMKOEN7ma65UIIh+gyaTjXrhfPKiG7g6fjXhlJqHLMl2b5J+zIUQ6r+MA6xVQtIHfS2DWUJoEFaTdNnTJWwvphEfK1cFaJ0qW0+2CkjlZNBTJ31Pk0bSKpxlJuT6fl5BuvNs5qqWJukTZs+6VQGeW2+JmkUohPVV5nVTZyCaoT+46JTQuW0k/t1AwrVpkDDALRZgkfV/B4t9hj42nLbfdNVMi2x23f5SlN01HR421Y/kVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Fri, 20 Mar 2026 04:26:16 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 04:26:15 +0000
Date: Fri, 20 Mar 2026 15:26:11 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, John Hubbard <jhubbard@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/9] gpu: nova-core: gsp: add types for RM control RPCs
Message-ID: <abzLtdN2-JCeSM8X@nvdebian.thelocal>
References: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
 <20260318-rmcontrol-v2-5-9a9fa6f1c4c3@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-rmcontrol-v2-5-9a9fa6f1c4c3@nvidia.com>
X-ClientProxiedBy: SY5PR01CA0012.ausprd01.prod.outlook.com
 (2603:10c6:10:1fa::6) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c3439e-00c3-412d-3c57-08de8638d362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: TQq2SIcZgiwOu1N2DD+eiZFV9bxmOvu8WCXp3LmhQA4hzjWU9cHpgO9pF89IHNBkxkcesjsyrD/cDONOzLoG3RWH0fzp5hDQS3GyKSf/2FmtG5GvnV7lWv5g1dHNiWQlCtCUHm7yK48P+l68nyRtIj45GLpOjUxZpMVmZ2Y8pCA+LwaHbhmYWaxuOubI5oku7j1Zpm2GGYz8GBut13jS2tkpedVva7nOKh4mG5NywDycGcbzhHT4X2DXqq/rHcskCAwLViX2/r0bu0oxEz92eoz9MHt1k4b1kKhlcWwqccFhkWWXeIUWdfjWGeT+CTayGKC9xoqP0btYU7umNqRL4sugvh6LR9Jt4pfQV6scYU8YF4YA2JeDKgG6Q0f0ceqTcQWFzKt0atKnyD20XkCSNA5ROxsAc0t+x41Iw+4aOBWiKtuZDTTZX0edhm3wGJt8N8Plle4/Y90GUj7Cv4gxy6sYoiUNXn2qjgX7hV1/HP5Cf3JQOYJls1v6rUahfMxVy58x5jz/WSboJdnam73djYgRxL+p7zApHbrhmu1niTOxdCjic6pbbk+lBQLl5iygna8Pnfpc+yHpcle84HuQWG4o9YZ87WvIGlKVPhzoPpiNBLG6c5ekxkDK5jJ3V7O+na1pPYZgX4WOorabrCaOmMUJAMsBsV9aQVUuSgW6pbB1hJAx4gYAwU4RL3ttvqdqnUnmLvGN1sq0CULsUeT/jmGxjHYo2j4K9vmjNmwuZyU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NEJExln2mL8BdtFVhs/KtMd1BVogIPXyUUcTLaIDaQuDq38+MsGz/1pfSX5U?=
 =?us-ascii?Q?fI8Qa98NSkvF57FNBESeFHELyWX9KdyIUlqdzJq99Mc8IKksllAT3rwyIU9S?=
 =?us-ascii?Q?BrEGfammimYBZiCwyRaBcN3g9eGagKsZBbANqMzSmgYSyH6j9crL71MEzp03?=
 =?us-ascii?Q?3JNLM9p+ChHZaXESAgZoR2t0uRFmYfz95rtdMKu7yDpF9F9tOkFfoZ2MeBo0?=
 =?us-ascii?Q?MZ17P+N1yicP/bDoLQteSQj2NuF5ITjQMN4hPy3hgCNrN7gwEqyOfm4zpRaH?=
 =?us-ascii?Q?WIma6dEGhz8qS2CroLKtSrw/qz0xLpwCGHSkejy366BPvP9qmB3NxALA3Nd1?=
 =?us-ascii?Q?E6MAQacvZNagUPCRu5aUcSWightrTjxTQW1LJzrZWIkKKrhD7hi5YQkNBiDc?=
 =?us-ascii?Q?XU4hetJPY6rAfAkSfOxVRHXb6QfqFr9BMOi/3SatVu71M5kRI/xW8GO3FMfP?=
 =?us-ascii?Q?gQjboHcW+SmDYZrfOQav53IBBc5zk1N7W7ICF6dCrb5jsB2ERIFAXEJiDJ9t?=
 =?us-ascii?Q?I0zn6Np3+WqNlZFPbJ5nRLIMOoL4qVrQ7ixCXlHcl0hZcMS6b3gr6KFVXr1R?=
 =?us-ascii?Q?l/rk5Grzb139DmPFAbL9qOCw9Qs6T8m7UXJyCIwci/RSnpjKW7k/t1AwfSUd?=
 =?us-ascii?Q?f1Pw6TZBdOq+0FDXqTVE/j3w7aTANguc56xM44jkNybrXNISJS+fuEafsZMs?=
 =?us-ascii?Q?yduq6KMKZREdWF13jpLxLRN+JrwzkR+wMuviYHJuHW+T09/Z7TupcZ7UuRBV?=
 =?us-ascii?Q?xgbIcSEIer94PLzikfcpCcqsx86CBjXx1gGlL4NzVEdUXsR+0WfAdpuZFqOx?=
 =?us-ascii?Q?HelwdT1Ctcb54+vMD1ZkKgsBMlmsTsa3qkuV96NpbVjgn7ZdWFd4h4WBgGk9?=
 =?us-ascii?Q?qe3u9r2veQ86Jmt8GWLuwg9AmIknYBqesE/1ZSoKU8hH5sXCyXiUuKR5kZwo?=
 =?us-ascii?Q?ikOYn7ErvAXy5vzJgEKir34NKDrbc+uoFrWZEhdTL4VK1h+z67ALXHaFsVOk?=
 =?us-ascii?Q?T2L1XdWTrndYBp9wkBJQaktP6tM2/WSIXdhBLVdJkYLfVyZqRhmC+tFsXpr6?=
 =?us-ascii?Q?9xr0VnbV1mvWayhU0y6xr9Nzwwv3+UCPIZSDAYce2HcPhPlfKzlIQx08l8HK?=
 =?us-ascii?Q?NUDKuNHq0puVocMULKdS+/KZzHLsFodDfN5mSzq0eiXVct2sPSMbm+ZI4Zs4?=
 =?us-ascii?Q?4gsvVQjY9BspQmsJSLlkc6itJ8hSFliWUWqi5Eq8ErAWTrMSIXT3RjyE1PuW?=
 =?us-ascii?Q?we49qVbdrLGsORQw1wYx1ORg8WCxqZ1ifFzxdBOeipkCaGPGo14lDjDvwY+d?=
 =?us-ascii?Q?alhyKQ/t2bd986VKJxS4aIkSIcRnqjZG85T5Dyk0njKxYGRrl/9vPNXs680Y?=
 =?us-ascii?Q?dHneTgUwFIaCSdS7kC4+7W5z6MtruulScy28DgYlglHYQLMpsudKPf8hWfge?=
 =?us-ascii?Q?MXVQY/99mDaqMCWqJZ1gTxvEG9KG/4O6TWn0CV5+Zfp8nJRIUPvrPvZ/Sqid?=
 =?us-ascii?Q?n9Z/OGONeUEvzqS/K8lvXXMzhLNcbQbKHQFH/r15tJIk0dLv2WVuywlwDVL2?=
 =?us-ascii?Q?iGzYGntKMwykUt38Tn4PHzWv9D85WSzeNYTRKXXgyw6dbDshJ73pj1Ij3e7t?=
 =?us-ascii?Q?LGkqeFj2+HEtPB6yeS3sNosXlpnEd/GdC66wc1THbaJBUWi70g/a8dUlLPXW?=
 =?us-ascii?Q?1i7uhdNeDytw4Nog1eHgo30+Z05+X/iW8LD32Ofs2bBp8tFOdaG/avNwDYCi?=
 =?us-ascii?Q?BpULqJB47g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c3439e-00c3-412d-3c57-08de8638d362
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 04:26:15.8375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWA5n2L+I7hbztpY3Epz5kolgCrxTbrX3QzRhJ/ERp6XBezeY1Xo23irw49JSgTyWlAhFJ8cc2g3QBD2E+1dlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912
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

On 2026-03-18 at 18:14 +1100, Eliot Courtney <ecourtney@nvidia.com> wrote...
> Add `RmControlMsgFunction` which mirrors `MsgFunction` in fw.rs. This
> denotes the type of RM control RPC. For now it contains a single
> discriminant only (which will be used later), which is needed to prevent
> compile errors when using an otherwise empty enum.
> 
> Add `GspRmControl` which wraps the RM control RPC structure from the
> bindings.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/commands.rs             |  1 -
>  drivers/gpu/nova-core/gsp/fw.rs                   |  1 +
>  drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs |  1 +
>  drivers/gpu/nova-core/gsp/fw/rm.rs                | 88 +++++++++++++++++++++++
>  4 files changed, 90 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
> index f3566f3ea6a7..8c9599aa227b 100644
> --- a/drivers/gpu/nova-core/gsp/commands.rs
> +++ b/drivers/gpu/nova-core/gsp/commands.rs
> @@ -77,7 +77,6 @@ pub(crate) fn new(raw: u32) -> Self {
>      }
>  
>      /// Returns the raw handle value.
> -    #[expect(dead_code)]
>      pub(crate) fn as_raw(self) -> u32 {
>          self.0
>      }
> diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
> index 37831034ec3e..8cbe90ce8271 100644
> --- a/drivers/gpu/nova-core/gsp/fw.rs
> +++ b/drivers/gpu/nova-core/gsp/fw.rs
> @@ -2,6 +2,7 @@
>  
>  pub(crate) mod commands;
>  mod r570_144;
> +pub(crate) mod rm;
>  
>  // Alias to avoid repeating the version number with every use.
>  use r570_144 as bindings;
> diff --git a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
> index 05e205e6dc58..ece31cc32f5b 100644
> --- a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
> +++ b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
> @@ -44,6 +44,7 @@ fn fmt(&self, fmt: &mut ::core::fmt::Formatter<'_>) -> ::core::fmt::Result {
>  pub const GSP_FW_WPR_META_MAGIC: i64 = -2577556379034558285;
>  pub const REGISTRY_TABLE_ENTRY_TYPE_DWORD: u32 = 1;
>  pub const GSP_MSG_QUEUE_ELEMENT_SIZE_MAX: u32 = 65536;
> +pub const NV2080_CTRL_CMD_CE_GET_FAULT_METHOD_BUFFER_SIZE: u32 = 545270280;

I'm sure you can guess my comment here based on my comments for patch 1 and 4 :-)

I wonder if it would be better to just add all the bindings in one patch at the
start of the series?

Everything else here looked sensible to me and my limited experience though, so:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

>  pub type __u8 = ffi::c_uchar;
>  pub type __u16 = ffi::c_ushort;
>  pub type __u32 = ffi::c_uint;
> diff --git a/drivers/gpu/nova-core/gsp/fw/rm.rs b/drivers/gpu/nova-core/gsp/fw/rm.rs
> new file mode 100644
> index 000000000000..4a4f97d88ecf
> --- /dev/null
> +++ b/drivers/gpu/nova-core/gsp/fw/rm.rs
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use kernel::{
> +    prelude::*,
> +    transmute::{
> +        AsBytes,
> +        FromBytes, //
> +    }, //
> +};
> +
> +use crate::gsp::commands::{
> +    Client,
> +    Handle, //
> +};
> +
> +use super::{
> +    bindings,
> +    NvStatus, //
> +};
> +
> +/// Command code for RM control RPCs sent using [`MsgFunction::GspRmControl`].
> +#[derive(Copy, Clone, Debug, PartialEq)]
> +#[repr(u32)]
> +pub(crate) enum RmControlMsgFunction {
> +    /// Get the CE fault method buffer size.
> +    CeGetFaultMethodBufferSize = bindings::NV2080_CTRL_CMD_CE_GET_FAULT_METHOD_BUFFER_SIZE,
> +}
> +
> +// TODO[FPRI]: replace with 'FromPrimitive'.
> +impl TryFrom<u32> for RmControlMsgFunction {
> +    type Error = kernel::error::Error;
> +
> +    fn try_from(value: u32) -> Result<Self> {
> +        match value {
> +            bindings::NV2080_CTRL_CMD_CE_GET_FAULT_METHOD_BUFFER_SIZE => {
> +                Ok(Self::CeGetFaultMethodBufferSize)
> +            }
> +            _ => Err(EINVAL),
> +        }
> +    }
> +}
> +
> +impl From<RmControlMsgFunction> for u32 {
> +    fn from(value: RmControlMsgFunction) -> Self {
> +        // CAST: `RmControlMsgFunction` is `repr(u32)` and can thus be cast losslessly.
> +        value as u32
> +    }
> +}
> +
> +/// RM control message element structure.
> +#[repr(transparent)]
> +pub(crate) struct GspRmControl {
> +    inner: bindings::rpc_gsp_rm_control_v03_00,
> +}
> +
> +#[expect(dead_code)]
> +impl GspRmControl {
> +    /// Creates a new RM control command.
> +    pub(crate) fn new<T>(
> +        client: Handle<Client>,
> +        object: Handle<T>,
> +        cmd: RmControlMsgFunction,
> +        params_size: u32,
> +    ) -> Self {
> +        Self {
> +            inner: bindings::rpc_gsp_rm_control_v03_00 {
> +                hClient: client.as_raw(),
> +                hObject: object.as_raw(),
> +                cmd: u32::from(cmd),
> +                status: 0,
> +                paramsSize: params_size,
> +                flags: 0,
> +                params: Default::default(),
> +            },
> +        }
> +    }
> +
> +    /// Returns the status from the RM control response.
> +    pub(crate) fn status(&self) -> NvStatus {
> +        NvStatus::from(self.inner.status)
> +    }
> +}
> +
> +// SAFETY: This struct only contains integer types for which all bit patterns are valid.
> +unsafe impl FromBytes for GspRmControl {}
> +
> +// SAFETY: This struct contains no padding.
> +unsafe impl AsBytes for GspRmControl {}
> 
> -- 
> 2.53.0
> 
