Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94797C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBAD510E903;
	Mon, 28 Sep 2026 09:20:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="nKVgT43L";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010021.outbound.protection.outlook.com
 [52.101.193.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15C7110E900
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 09:20:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDR1Hscwo48yucwOWosexe21ysMtZq4afP+5uG6xRdAZGJlEDxTTUUIS3VC4smNbG3NqEAeIymK6DiQw3isG2KgAH/7+SuXYtCX2q0SVEXqxp+/jOV8SP5zJMtGjP84fARj0OxoHiJRAxaVSCa40liEvofTQACKperSF/yOAzkeVdga6lJoU3+uA3VYB/hbN3azXjV1/7cKMQCVgusrhimQyqj0RfUiTGj3dZS/SUJUddD58BJkwYecY9rywpZEwaMUNKkr1AwBu42q4RJ3I1ZerZE9Sr4A0KWzetYipnmHDqGoEDrhKRvBLBxyn04bIS+CEnPbtR6ZuVF5/DCBQ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLQy1oiMlttWEeZgzF4vigREpPUbkDwRzcIdHoH+sBo=;
 b=rfubzQ2ADX0iZXpPUDdoEe+i0a/DYJvK09YkXta/3hBX4xnjgk6n/HSgdlH2IEw53paBDFLewnDTVfYDLCO8uMVj1NKjSQsXkz6I4oaIhOrQ4+eniDxFAcz+ClwnP1lrbCaIaqzJ0PxcB7RLmdx3frnKjuJhgWnorhIaadVQCo4WBBEp409NX8mYP8ND+YNFTfG5F+j4dG8R4ECdjHot0neZ/4aQ0WCCDnWkSsM+WXXL4NOkY94voifgWi2aJZhy84aiiFpZP+V6o9+BiO0pxkCbYT6nvTnvU20/hodkXFXHgqes16kmzksP7U6MSlANS1jgNg+h6AhDWPHCiizv6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLQy1oiMlttWEeZgzF4vigREpPUbkDwRzcIdHoH+sBo=;
 b=nKVgT43LY0mZ66Msb1F1Rgp3Sb+FZbYJV1C9rvo3WdaMC/j8Ue07vbs+kvbtKopkuO9S2BcsM+r6DnDAnZ8keD62lXRoFRsb2aY8xbkOeHoG0TPYl2HhNRUi+WAkIpBzb20zLPWGm58tiJ2zvzo0cbpris6153qjUvCdj6GObS/PNOnO9vETmFJW/QiWnivzR8flYflYeP51zj9kpg3qiGQsktcDPonObefbF4NhphTkwp2bM11jr7Rq/QijxShoeGfbxH+5jyOSEEKAvcXBalbWwt3x8cD3FLQOmtyvvfx1cycojoqU/69pt+XNcKw6YB0VxONTjqAcqxr2Ap1Ndw==
Received: from MW4PR03CA0021.namprd03.prod.outlook.com (2603:10b6:303:8f::26)
 by SN7PR12MB7131.namprd12.prod.outlook.com (2603:10b6:806:2a3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 09:20:36 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:303:8f:cafe::2b) by MW4PR03CA0021.outlook.office365.com
 (2603:10b6:303:8f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 09:20:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 09:20:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 02:20:21 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 28 Sep 2026 02:20:20 -0700
Received: from inno-dell (10.127.8.10) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 28 Sep 2026 02:20:17 -0700
Date: Mon, 28 Sep 2026 12:20:15 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
CC: John Hubbard <jhubbard@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>, Gary Guo
 <gary@garyguo.net>, Alistair Popple <apopple@nvidia.com>, Timur Tabi
 <ttabi@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 8/9] gpu: nova-core: gsp: move the RPC commands into
 a sub-module
Message-ID: <20260928122015.3df66b3e@inno-dell>
In-Reply-To: <20260927-cmdq-rpc-v2-8-c3f66ae73be4@nvidia.com>
References: <20260927-cmdq-rpc-v2-0-c3f66ae73be4@nvidia.com>
 <20260927-cmdq-rpc-v2-8-c3f66ae73be4@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|SN7PR12MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: ec1086a4-ab41-4d21-78b1-08df1d41c196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|376014|1800799024|23010399003|82310400026|13003099007|3023799007|6133799003|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: V1PHi9+kAmOxNLHVyEIHAUmtm3G471shhlRFsxkIAUozrfCekK6UQ124LL0ke5/HZfsCCHOBLrWhBJJNv5KmFgvrC6Q4SDEeyl6OOjgW8NgkloCxjxXzpEK6BzdvXU/JkGLa/6D1yeMts/CpvG8QbCUVl39o8ficKkAc7MtDKJLj3mia+fi84Vb6VA9riCSl0A/N1goSAPAKgb7Uk+01BIw+hkGc7d1QLYBtimuK/IkTWgf6SFh00MkR9TqN83cJ+RP5/KDI8Hg8EorEOZNlmJL5hVmMVeCdLtgBntiJ4mpH6ETqexgWZvGnLnh5tPo211Aj+SIurdJhNn4GHUmbmHEMWHbKen9fejujLrQxbfXTWgGRUJPVl3OjmrHWgwuFF6KA5RL5JB/SFJWjGgpxXqWGt0HYix0Ec1Be/1yuejLogL9ndNCXyJrrrxM9HFxM+OJi2KA9v8yc8CXmqTeVYlNIxo31g5UoqO2ylG83DmOOIOdwypki5njwEh3lGY8UPsEZHe85Pv72XYPh+GSNXJz3ZYXSwnXxxOABsuugHPqZgjO0yQ5oos2gj65AIlameYXSFpd2mXoSBqmN+05Q6WPcy1QnxLxwNucqb/vYs8Flj2R+kU73+xml9hvenFtXOmoKJcIIDjYs+r7bRw85JgpdW7IUTzGmK+L6F6ih0ZoSJdi8GSYwA6y2wLrnoGJU/488ZWbdQRPoeVNvAN09dg==
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(23010399003)(82310400026)(13003099007)(3023799007)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2fTZ64YOZpSQ5aSb4rd5mYroydoUQfFsaylilW/uahEq0MR3zB2nGA5ixHvqrjT4q12cJmWxW3VKGEKjOGk6WK1f3EzOYjX4rcpimPZFJPclNPj8aXU/slsvxq7hQUB/FoCi7DfRDjd/SniOuFqQUpfHBvjeaNzT+HeNMOAjhUfm6YRVGTeMMm1bUn+vxXh+SrUrGgvL4rUXEnS40VdjIRdS47PM3BfaI7yCSd89YIwqI3a36RelP+VGDgM25l5pBezJy2UjNon57gzwsR3JUK1QnjmrZbUUT1hGwNdkETdjpz5NPlbLnU80BgEfgzjy7vESWFYLCEMywuSNZyN7d5uiAg/hcWolK2GWlIbFzFwXfm97RGaHoUa7s3sXNPCenWONKNIk4c3K6/nfCJYFfEetQ7lqAQi0+5S/6Dk9Vz2ROo7Eez8jfu81HUhBRJaC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 09:20:36.6769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1086a4-ab41-4d21-78b1-08df1d41c196
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7131
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

On Sun, 27 Sep 2026 22:46:25 +0900
Alexandre Courbot <acourbot@nvidia.com> wrote:

> Move the types and code related to RPC commands into the
> `rpc` sub-module, and update their users to reference them from their
> new location.
> 
> This is a pure move commit, with no functional change intended.
> 

Hi Alex:

What would be the plan for commands.rs in the future after the movement?
I was adopting the similar code structures (fw.rs/command.rs) for vGPU
manager's RPCs and GSP plugin RPCs, e.g. having RPC typed code and
function handler(wrapper)s, it would be nice that I can align with the
idea accordingly.

Z.

> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/api.rs              |   2 +-
>  drivers/gpu/nova-core/gpu.rs              |   2 +-
>  drivers/gpu/nova-core/gsp.rs              |   4 +-
>  drivers/gpu/nova-core/gsp/boot.rs         |  12 +-
>  drivers/gpu/nova-core/gsp/commands.rs     | 337
> +----------------------------
> drivers/gpu/nova-core/gsp/commands/rpc.rs | 339
> ++++++++++++++++++++++++++++++ 6 files changed, 350 insertions(+),
> 346 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/api.rs
> b/drivers/gpu/nova-core/api.rs index f02c6c7c7e51..84a15265e849 100644
> --- a/drivers/gpu/nova-core/api.rs
> +++ b/drivers/gpu/nova-core/api.rs
> @@ -16,7 +16,7 @@
>  pub use crate::gpu::Spec;
>  
>  use crate::gpu::Gpu;
> -use crate::gsp::commands::GetGspStaticInfoReply;
> +use crate::gsp::commands::rpc::GetGspStaticInfoReply;
>  
>  /// API handle for the auxiliary bus child drivers to interact with
> nova-core. pub struct NovaCoreApi<'bound> {
> diff --git a/drivers/gpu/nova-core/gpu.rs
> b/drivers/gpu/nova-core/gpu.rs index fb6f8a86a503..2a3bd619acf6 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -34,7 +34,7 @@
>      fsp::Fsp,
>      gsp::{
>          self,
> -        commands::GetGspStaticInfoReply,
> +        commands::rpc::GetGspStaticInfoReply,
>          Gsp,
>          GspBootContext, //
>      },
> diff --git a/drivers/gpu/nova-core/gsp.rs
> b/drivers/gpu/nova-core/gsp.rs index dda58095f40b..75a3ba7d50f4 100644
> --- a/drivers/gpu/nova-core/gsp.rs
> +++ b/drivers/gpu/nova-core/gsp.rs
> @@ -220,8 +220,8 @@ pub(crate) fn new(
>      }
>  
>      /// Query the GSP for the static GPU information.
> -    pub(crate) fn get_static_info(&self) ->
> Result<commands::GetGspStaticInfoReply> {
> -        self.cmdq.send_command(commands::GetGspStaticInfo)
> +    pub(crate) fn get_static_info(&self) ->
> Result<commands::rpc::GetGspStaticInfoReply> {
> +        self.cmdq.send_command(commands::rpc::GetGspStaticInfo)
>      }
>  }
>  
> diff --git a/drivers/gpu/nova-core/gsp/boot.rs
> b/drivers/gpu/nova-core/gsp/boot.rs index 4fb1b69ac9d5..8e446ad1eac2
> 100644 --- a/drivers/gpu/nova-core/gsp/boot.rs
> +++ b/drivers/gpu/nova-core/gsp/boot.rs
> @@ -43,9 +43,9 @@ pub(crate) fn boot(
>          let gsp_fw = KBox::pin_init(GspFirmware::new(dev, chipset),
> GFP_KERNEL)?; 
>          self.cmdq
> -            .send_command_no_wait(commands::SetSystemInfo::new(pdev,
> chipset))?;
> +
> .send_command_no_wait(commands::rpc::SetSystemInfo::new(pdev,
> chipset))?; self.cmdq
> -
> .send_command_no_wait(commands::SetRegistry::new(ctx.vgpu.state())?)?;
> +
> .send_command_no_wait(commands::rpc::SetRegistry::new(ctx.vgpu.state())?)?; 
>          // Perform the chipset-specific boot sequence, and retrieve
> the unload bundle. let unload_bundle = hal.boot(&self, &mut ctx,
> &gsp_fw)?.or_else(|| { @@ -79,7 +79,7 @@ pub(crate) fn boot(
>          hal.post_boot(&self, ctx, &gsp_fw)?;
>  
>          // Wait until GSP is fully initialized.
> -        commands::wait_gsp_init_done(&self.cmdq)?;
> +        commands::rpc::wait_gsp_init_done(&self.cmdq)?;
>  
>          Ok(unload_guard.dismiss().1)
>      }
> @@ -88,10 +88,10 @@ pub(crate) fn boot(
>      fn shutdown_gsp(
>          cmdq: &Cmdq<'_>,
>          gsp_falcon: &Falcon<'_, Gsp>,
> -        mode: commands::PowerStateLevel,
> +        mode: commands::rpc::PowerStateLevel,
>      ) -> Result {
>          // Command to shut the GSP down.
> -
> cmdq.send_command(commands::UnloadingGuestDriver::new(mode))?;
> +
> cmdq.send_command(commands::rpc::UnloadingGuestDriver::new(mode))?; 
>          // Wait until GSP signals it is suspended.
>          const LIBOS_INTERRUPT_PROCESSOR_SUSPENDED: u32 =
> bits::bit_u32(31); @@ -118,7 +118,7 @@ pub(crate) fn unload(
>          let mut res = Self::shutdown_gsp(
>              &self.cmdq,
>              ctx.gsp_falcon,
> -            commands::PowerStateLevel::Level0,
> +            commands::rpc::PowerStateLevel::Level0,
>          )
>          .inspect_err(|e| dev_err!(dev, "GSP shutdown failed:
> {:?}\n", e)); 
> diff --git a/drivers/gpu/nova-core/gsp/commands.rs
> b/drivers/gpu/nova-core/gsp/commands.rs index
> 25a5a8d33d64..5f1c944678be 100644 ---
> a/drivers/gpu/nova-core/gsp/commands.rs +++
> b/drivers/gpu/nova-core/gsp/commands.rs @@ -1,339 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA
> CORPORATION & AFFILIATES. All rights reserved. 
> -use core::{
> -    array,
> -    convert::Infallible,
> -    ffi::FromBytesUntilNulError,
> -    ops::Range,
> -    str::Utf8Error, //
> -};
> -
> -use kernel::{
> -    device,
> -    pci,
> -    prelude::*,
> -    transmute::{
> -        AsBytes,
> -        FromBytes, //
> -    }, //
> -};
> -
> -use crate::{
> -    gpu::Chipset,
> -    gsp::{
> -        cmdq::{
> -            rpc::{
> -                CommandToGsp,
> -                MessageFromGsp, //
> -            },
> -            Cmdq,
> -            NoReply, //
> -        },
> -        fw::{
> -            self,
> -            MsgFunction, //
> -        },
> -    },
> -    sbuffer::SBufferIter,
> -    vgpu::VgpuState, //
> -};
> -
> -/// The `GspSetSystemInfo` command.
> -pub(crate) struct SetSystemInfo<'a> {
> -    pdev: &'a pci::Device<device::Bound>,
> -    chipset: Chipset,
> -}
> -
> -impl<'a> SetSystemInfo<'a> {
> -    /// Creates a new `GspSetSystemInfo` command using the
> parameters of `pdev`.
> -    pub(crate) fn new(pdev: &'a pci::Device<device::Bound>, chipset:
> Chipset) -> Self {
> -        Self { pdev, chipset }
> -    }
> -}
> -
> -impl<'a> CommandToGsp for SetSystemInfo<'a> {
> -    const FUNCTION: MsgFunction = MsgFunction::GspSetSystemInfo;
> -    type Command = fw::commands::GspSetSystemInfo;
> -    type Reply = NoReply;
> -    type InitError = Error;
> -
> -    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
> -        Self::Command::init(self.pdev, self.chipset)
> -    }
> -}
> -
> -struct RegistryEntry {
> -    key: &'static str,
> -    value: u32,
> -}
> -
> -/// The `SetRegistry` command.
> -pub(crate) struct SetRegistry {
> -    entries: KVec<RegistryEntry>,
> -}
> -
> -impl SetRegistry {
> -    /// Creates a new `SetRegistry` command, using a set of
> hardcoded entries.
> -    pub(crate) fn new(vgpu_state: VgpuState) -> Result<Self> {
> -        let mut entries = KVec::new();
> -
> -        // RMSecBusResetEnable - enables PCI secondary bus reset
> -        entries.push(
> -            RegistryEntry {
> -                key: "RMSecBusResetEnable",
> -                value: 1,
> -            },
> -            GFP_KERNEL,
> -        )?;
> -
> -        // RMForcePcieConfigSave - forces GSP-RM to preserve PCI
> configuration registers on
> -        // any PCI reset.
> -        entries.push(
> -            RegistryEntry {
> -                key: "RMForcePcieConfigSave",
> -                value: 1,
> -            },
> -            GFP_KERNEL,
> -        )?;
> -
> -        // RMDevidCheckIgnore - allows GSP-RM to boot even if the
> PCI dev ID is not found
> -        // in the internal product name database.
> -        entries.push(
> -            RegistryEntry {
> -                key: "RMDevidCheckIgnore",
> -                value: 1,
> -            },
> -            GFP_KERNEL,
> -        )?;
> -
> -        if matches!(vgpu_state, VgpuState::Enabled { .. }) {
> -            // RMSetSriovMode - required when vGPU is enabled.
> -            entries.push(
> -                RegistryEntry {
> -                    key: "RMSetSriovMode",
> -                    value: 1,
> -                },
> -                GFP_KERNEL,
> -            )?;
> -        }
> -
> -        Ok(Self { entries })
> -    }
> -}
> -
> -impl CommandToGsp for SetRegistry {
> -    const FUNCTION: MsgFunction = MsgFunction::SetRegistry;
> -    type Command = fw::commands::PackedRegistryTable;
> -    type Reply = NoReply;
> -    type InitError = Infallible;
> -
> -    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
> -        Self::Command::init(self.entries.len() as u32, self.size()
> as u32)
> -    }
> -
> -    fn variable_payload_len(&self) -> usize {
> -        let mut key_size = 0;
> -        for entry in self.entries.iter() {
> -            key_size += entry.key.len() + 1; // +1 for NULL
> terminator
> -        }
> -        self.entries.len() *
> size_of::<fw::commands::PackedRegistryEntry>() + key_size
> -    }
> -
> -    fn init_variable_payload(
> -        &self,
> -        dst: &mut SBufferIter<core::array::IntoIter<&mut [u8], 2>>,
> -    ) -> Result {
> -        let string_data_start_offset = size_of::<Self::Command>()
> -            + self.entries.len() *
> size_of::<fw::commands::PackedRegistryEntry>(); -
> -        // Array for string data.
> -        let mut string_data = KVec::new();
> -
> -        for entry in self.entries.iter() {
> -            dst.write_all(
> -                fw::commands::PackedRegistryEntry::new(
> -                    (string_data_start_offset + string_data.len())
> as u32,
> -                    entry.value,
> -                )
> -                .as_bytes(),
> -            )?;
> -
> -            let key_bytes = entry.key.as_bytes();
> -            string_data.extend_from_slice(key_bytes, GFP_KERNEL)?;
> -            string_data.push(0, GFP_KERNEL)?;
> -        }
> -
> -        dst.write_all(string_data.as_slice())
> -    }
> -}
> -
> -/// Message type for GSP initialization done notification.
> -struct GspInitDone;
> -
> -// SAFETY: `GspInitDone` is a zero-sized type with no bytes,
> therefore it -// trivially has no uninitialized bytes.
> -unsafe impl FromBytes for GspInitDone {}
> -
> -impl MessageFromGsp for GspInitDone {
> -    const FUNCTION: MsgFunction = MsgFunction::GspInitDone;
> -    type InitError = Infallible;
> -    type Message = ();
> -
> -    fn read(
> -        _msg: &Self::Message,
> -        _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
> -    ) -> Result<Self, Self::InitError> {
> -        Ok(GspInitDone)
> -    }
> -}
> -
> -/// Waits for GSP initialization to complete.
> -pub(crate) fn wait_gsp_init_done(cmdq: &Cmdq<'_>) -> Result {
> -    loop {
> -        match cmdq.receive_msg::<GspInitDone>(Cmdq::RECEIVE_TIMEOUT)
> {
> -            Ok(_) => break Ok(()),
> -            Err(ERANGE) => continue,
> -            Err(e) => break Err(e),
> -        }
> -    }
> -}
> -
> -/// The `GetGspStaticInfo` command.
> -pub(crate) struct GetGspStaticInfo;
> -
> -impl CommandToGsp for GetGspStaticInfo {
> -    const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
> -    type Command = fw::commands::GspStaticConfigInfo;
> -    type Reply = GetGspStaticInfoReply;
> -    type InitError = Infallible;
> -
> -    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
> -        Self::Command::init_zeroed()
> -    }
> -}
> -
> -/// The reply from the GSP to the [`GetGspStaticInfo`] command.
> -pub struct GetGspStaticInfoReply {
> -    gpu_name: [u8; 64],
> -    gpu_short_name: [u8; 64],
> -    /// The 16-byte SHA-1 based GPU identifier (GID) reported by
> GSP-RM.
> -    pub gpu_gid: [u8; 16],
> -    /// BAR1 Page Directory Entry base address.
> -    pub(crate) bar1_pde_base: u64,
> -    /// Usable FB (VRAM) regions for driver memory allocation.
> -    pub(crate) usable_fb_regions: KVec<Range<u64>>,
> -    /// Exclusive end of the FB physical address space.
> -    pub(crate) total_fb_end: u64,
> -}
> -
> -impl MessageFromGsp for GetGspStaticInfoReply {
> -    const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
> -    type Message = fw::commands::GspStaticConfigInfo;
> -    type InitError = Error;
> -
> -    fn read(
> -        msg: &Self::Message,
> -        _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
> -    ) -> Result<Self, Self::InitError> {
> -        let mut usable_fb_regions = KVec::new();
> -        for region in msg.usable_fb_regions() {
> -            usable_fb_regions.push(region, GFP_KERNEL)?;
> -        }
> -        let total_fb_end = msg.total_fb_end().ok_or(EINVAL)?;
> -
> -        Ok(GetGspStaticInfoReply {
> -            gpu_name: msg.gpu_name_str(),
> -            gpu_short_name: msg.gpu_short_name_str(),
> -            gpu_gid: msg.gpu_gid(),
> -            bar1_pde_base: msg.bar1_pde_base(),
> -            usable_fb_regions,
> -            total_fb_end,
> -        })
> -    }
> -}
> -
> -/// Error type for [`GetGspStaticInfoReply::gpu_name`].
> -#[derive(Debug)]
> -pub enum GpuNameError {
> -    /// The GPU name string does not contain a null terminator.
> -    NoNullTerminator(FromBytesUntilNulError),
> -
> -    /// The GPU name string contains invalid UTF-8.
> -    InvalidUtf8(Utf8Error),
> -}
> -
> -impl GetGspStaticInfoReply {
> -    /// Returns the name of the GPU as a string.
> -    ///
> -    /// Returns an error if the string given by the GSP does not
> contain a null terminator or
> -    /// contains invalid UTF-8.
> -    pub fn gpu_name(&self) -> Result<&str, GpuNameError> {
> -        CStr::from_bytes_until_nul(&self.gpu_name)
> -            .map_err(GpuNameError::NoNullTerminator)?
> -            .to_str()
> -            .map_err(GpuNameError::InvalidUtf8)
> -    }
> -
> -    /// Returns the short name of the GPU as a string.
> -    ///
> -    /// Returns an error if the string given by the GSP does not
> contain a null terminator or
> -    /// contains invalid UTF-8.
> -    pub fn gpu_short_name(&self) -> core::result::Result<&str,
> GpuNameError> {
> -        CStr::from_bytes_until_nul(&self.gpu_short_name)
> -            .map_err(GpuNameError::NoNullTerminator)?
> -            .to_str()
> -            .map_err(GpuNameError::InvalidUtf8)
> -    }
> -
> -    /// Returns the total usable VRAM size in bytes, i.e. the summed
> lengths of all usable FB
> -    /// regions.
> -    pub fn vram_size(&self) -> u64 {
> -        self.usable_fb_regions.iter().fold(0, |size, region| {
> -            size.saturating_add(region.end - region.start)
> -        })
> -    }
> -}
> -
> -pub(crate) use fw::commands::PowerStateLevel;
> -
> -/// The `UnloadingGuestDriver` command, used to shut down the GSP.
> -///
> -/// Only used within the `gsp` module.
> -pub(super) struct UnloadingGuestDriver {
> -    level: PowerStateLevel,
> -}
> -
> -impl UnloadingGuestDriver {
> -    /// Creates a new `UnloadingGuestDriver` command for the given
> [`PowerStateLevel`].
> -    pub(super) fn new(level: PowerStateLevel) -> Self {
> -        Self { level }
> -    }
> -}
> -
> -impl CommandToGsp for UnloadingGuestDriver {
> -    const FUNCTION: MsgFunction = MsgFunction::UnloadingGuestDriver;
> -    type Command = fw::commands::UnloadingGuestDriver;
> -    type Reply = UnloadingGuestDriverReply;
> -    type InitError = Infallible;
> -
> -    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
> -        fw::commands::UnloadingGuestDriver::new(self.level)
> -    }
> -}
> -
> -/// The reply from the GSP to the [`UnloadingGuestDriver`] command.
> -pub(super) struct UnloadingGuestDriverReply;
> -
> -impl MessageFromGsp for UnloadingGuestDriverReply {
> -    const FUNCTION: MsgFunction = MsgFunction::UnloadingGuestDriver;
> -    type InitError = Infallible;
> -    type Message = ();
> -
> -    fn read(
> -        _msg: &Self::Message,
> -        _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
> -    ) -> Result<Self, Self::InitError> {
> -        Ok(UnloadingGuestDriverReply)
> -    }
> -}
> +pub(crate) mod rpc;
> diff --git a/drivers/gpu/nova-core/gsp/commands/rpc.rs
> b/drivers/gpu/nova-core/gsp/commands/rpc.rs new file mode 100644
> index 000000000000..0176ac79fb09
> --- /dev/null
> +++ b/drivers/gpu/nova-core/gsp/commands/rpc.rs
> @@ -0,0 +1,339 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA
> CORPORATION & AFFILIATES. All rights reserved. +
> +use core::{
> +    array,
> +    convert::Infallible,
> +    ffi::FromBytesUntilNulError,
> +    ops::Range,
> +    str::Utf8Error, //
> +};
> +
> +use kernel::{
> +    device,
> +    pci,
> +    prelude::*,
> +    transmute::{
> +        AsBytes,
> +        FromBytes, //
> +    }, //
> +};
> +
> +use crate::{
> +    gpu::Chipset,
> +    gsp::{
> +        cmdq::{
> +            rpc::{
> +                CommandToGsp,
> +                MessageFromGsp, //
> +            },
> +            Cmdq,
> +            NoReply, //
> +        },
> +        fw::{
> +            self,
> +            MsgFunction, //
> +        },
> +    },
> +    sbuffer::SBufferIter,
> +    vgpu::VgpuState, //
> +};
> +
> +/// The `GspSetSystemInfo` command.
> +pub(crate) struct SetSystemInfo<'a> {
> +    pdev: &'a pci::Device<device::Bound>,
> +    chipset: Chipset,
> +}
> +
> +impl<'a> SetSystemInfo<'a> {
> +    /// Creates a new `GspSetSystemInfo` command using the
> parameters of `pdev`.
> +    pub(crate) fn new(pdev: &'a pci::Device<device::Bound>, chipset:
> Chipset) -> Self {
> +        Self { pdev, chipset }
> +    }
> +}
> +
> +impl<'a> CommandToGsp for SetSystemInfo<'a> {
> +    const FUNCTION: MsgFunction = MsgFunction::GspSetSystemInfo;
> +    type Command = fw::commands::GspSetSystemInfo;
> +    type Reply = NoReply;
> +    type InitError = Error;
> +
> +    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
> +        Self::Command::init(self.pdev, self.chipset)
> +    }
> +}
> +
> +struct RegistryEntry {
> +    key: &'static str,
> +    value: u32,
> +}
> +
> +/// The `SetRegistry` command.
> +pub(crate) struct SetRegistry {
> +    entries: KVec<RegistryEntry>,
> +}
> +
> +impl SetRegistry {
> +    /// Creates a new `SetRegistry` command, using a set of
> hardcoded entries.
> +    pub(crate) fn new(vgpu_state: VgpuState) -> Result<Self> {
> +        let mut entries = KVec::new();
> +
> +        // RMSecBusResetEnable - enables PCI secondary bus reset
> +        entries.push(
> +            RegistryEntry {
> +                key: "RMSecBusResetEnable",
> +                value: 1,
> +            },
> +            GFP_KERNEL,
> +        )?;
> +
> +        // RMForcePcieConfigSave - forces GSP-RM to preserve PCI
> configuration registers on
> +        // any PCI reset.
> +        entries.push(
> +            RegistryEntry {
> +                key: "RMForcePcieConfigSave",
> +                value: 1,
> +            },
> +            GFP_KERNEL,
> +        )?;
> +
> +        // RMDevidCheckIgnore - allows GSP-RM to boot even if the
> PCI dev ID is not found
> +        // in the internal product name database.
> +        entries.push(
> +            RegistryEntry {
> +                key: "RMDevidCheckIgnore",
> +                value: 1,
> +            },
> +            GFP_KERNEL,
> +        )?;
> +
> +        if matches!(vgpu_state, VgpuState::Enabled { .. }) {
> +            // RMSetSriovMode - required when vGPU is enabled.
> +            entries.push(
> +                RegistryEntry {
> +                    key: "RMSetSriovMode",
> +                    value: 1,
> +                },
> +                GFP_KERNEL,
> +            )?;
> +        }
> +
> +        Ok(Self { entries })
> +    }
> +}
> +
> +impl CommandToGsp for SetRegistry {
> +    const FUNCTION: MsgFunction = MsgFunction::SetRegistry;
> +    type Command = fw::commands::PackedRegistryTable;
> +    type Reply = NoReply;
> +    type InitError = Infallible;
> +
> +    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
> +        Self::Command::init(self.entries.len() as u32, self.size()
> as u32)
> +    }
> +
> +    fn variable_payload_len(&self) -> usize {
> +        let mut key_size = 0;
> +        for entry in self.entries.iter() {
> +            key_size += entry.key.len() + 1; // +1 for NULL
> terminator
> +        }
> +        self.entries.len() *
> size_of::<fw::commands::PackedRegistryEntry>() + key_size
> +    }
> +
> +    fn init_variable_payload(
> +        &self,
> +        dst: &mut SBufferIter<core::array::IntoIter<&mut [u8], 2>>,
> +    ) -> Result {
> +        let string_data_start_offset = size_of::<Self::Command>()
> +            + self.entries.len() *
> size_of::<fw::commands::PackedRegistryEntry>(); +
> +        // Array for string data.
> +        let mut string_data = KVec::new();
> +
> +        for entry in self.entries.iter() {
> +            dst.write_all(
> +                fw::commands::PackedRegistryEntry::new(
> +                    (string_data_start_offset + string_data.len())
> as u32,
> +                    entry.value,
> +                )
> +                .as_bytes(),
> +            )?;
> +
> +            let key_bytes = entry.key.as_bytes();
> +            string_data.extend_from_slice(key_bytes, GFP_KERNEL)?;
> +            string_data.push(0, GFP_KERNEL)?;
> +        }
> +
> +        dst.write_all(string_data.as_slice())
> +    }
> +}
> +
> +/// Message type for GSP initialization done notification.
> +struct GspInitDone;
> +
> +// SAFETY: `GspInitDone` is a zero-sized type with no bytes,
> therefore it +// trivially has no uninitialized bytes.
> +unsafe impl FromBytes for GspInitDone {}
> +
> +impl MessageFromGsp for GspInitDone {
> +    const FUNCTION: MsgFunction = MsgFunction::GspInitDone;
> +    type InitError = Infallible;
> +    type Message = ();
> +
> +    fn read(
> +        _msg: &Self::Message,
> +        _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
> +    ) -> Result<Self, Self::InitError> {
> +        Ok(GspInitDone)
> +    }
> +}
> +
> +/// Waits for GSP initialization to complete.
> +pub(crate) fn wait_gsp_init_done(cmdq: &Cmdq<'_>) -> Result {
> +    loop {
> +        match cmdq.receive_msg::<GspInitDone>(Cmdq::RECEIVE_TIMEOUT)
> {
> +            Ok(_) => break Ok(()),
> +            Err(ERANGE) => continue,
> +            Err(e) => break Err(e),
> +        }
> +    }
> +}
> +
> +/// The `GetGspStaticInfo` command.
> +pub(crate) struct GetGspStaticInfo;
> +
> +impl CommandToGsp for GetGspStaticInfo {
> +    const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
> +    type Command = fw::commands::GspStaticConfigInfo;
> +    type Reply = GetGspStaticInfoReply;
> +    type InitError = Infallible;
> +
> +    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
> +        Self::Command::init_zeroed()
> +    }
> +}
> +
> +/// The reply from the GSP to the [`GetGspStaticInfo`] command.
> +pub struct GetGspStaticInfoReply {
> +    gpu_name: [u8; 64],
> +    gpu_short_name: [u8; 64],
> +    /// The 16-byte SHA-1 based GPU identifier (GID) reported by
> GSP-RM.
> +    pub gpu_gid: [u8; 16],
> +    /// BAR1 Page Directory Entry base address.
> +    pub(crate) bar1_pde_base: u64,
> +    /// Usable FB (VRAM) regions for driver memory allocation.
> +    pub(crate) usable_fb_regions: KVec<Range<u64>>,
> +    /// Exclusive end of the FB physical address space.
> +    pub(crate) total_fb_end: u64,
> +}
> +
> +impl MessageFromGsp for GetGspStaticInfoReply {
> +    const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
> +    type Message = fw::commands::GspStaticConfigInfo;
> +    type InitError = Error;
> +
> +    fn read(
> +        msg: &Self::Message,
> +        _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
> +    ) -> Result<Self, Self::InitError> {
> +        let mut usable_fb_regions = KVec::new();
> +        for region in msg.usable_fb_regions() {
> +            usable_fb_regions.push(region, GFP_KERNEL)?;
> +        }
> +        let total_fb_end = msg.total_fb_end().ok_or(EINVAL)?;
> +
> +        Ok(GetGspStaticInfoReply {
> +            gpu_name: msg.gpu_name_str(),
> +            gpu_short_name: msg.gpu_short_name_str(),
> +            gpu_gid: msg.gpu_gid(),
> +            bar1_pde_base: msg.bar1_pde_base(),
> +            usable_fb_regions,
> +            total_fb_end,
> +        })
> +    }
> +}
> +
> +/// Error type for [`GetGspStaticInfoReply::gpu_name`].
> +#[derive(Debug)]
> +pub enum GpuNameError {
> +    /// The GPU name string does not contain a null terminator.
> +    NoNullTerminator(FromBytesUntilNulError),
> +
> +    /// The GPU name string contains invalid UTF-8.
> +    InvalidUtf8(Utf8Error),
> +}
> +
> +impl GetGspStaticInfoReply {
> +    /// Returns the name of the GPU as a string.
> +    ///
> +    /// Returns an error if the string given by the GSP does not
> contain a null terminator or
> +    /// contains invalid UTF-8.
> +    pub fn gpu_name(&self) -> Result<&str, GpuNameError> {
> +        CStr::from_bytes_until_nul(&self.gpu_name)
> +            .map_err(GpuNameError::NoNullTerminator)?
> +            .to_str()
> +            .map_err(GpuNameError::InvalidUtf8)
> +    }
> +
> +    /// Returns the short name of the GPU as a string.
> +    ///
> +    /// Returns an error if the string given by the GSP does not
> contain a null terminator or
> +    /// contains invalid UTF-8.
> +    pub fn gpu_short_name(&self) -> core::result::Result<&str,
> GpuNameError> {
> +        CStr::from_bytes_until_nul(&self.gpu_short_name)
> +            .map_err(GpuNameError::NoNullTerminator)?
> +            .to_str()
> +            .map_err(GpuNameError::InvalidUtf8)
> +    }
> +
> +    /// Returns the total usable VRAM size in bytes, i.e. the summed
> lengths of all usable FB
> +    /// regions.
> +    pub fn vram_size(&self) -> u64 {
> +        self.usable_fb_regions.iter().fold(0, |size, region| {
> +            size.saturating_add(region.end - region.start)
> +        })
> +    }
> +}
> +
> +pub(crate) use fw::commands::PowerStateLevel;
> +
> +/// The `UnloadingGuestDriver` command, used to shut down the GSP.
> +///
> +/// Only used within the `gsp` module.
> +pub(crate) struct UnloadingGuestDriver {
> +    level: PowerStateLevel,
> +}
> +
> +impl UnloadingGuestDriver {
> +    /// Creates a new `UnloadingGuestDriver` command for the given
> [`PowerStateLevel`].
> +    pub(crate) fn new(level: PowerStateLevel) -> Self {
> +        Self { level }
> +    }
> +}
> +
> +impl CommandToGsp for UnloadingGuestDriver {
> +    const FUNCTION: MsgFunction = MsgFunction::UnloadingGuestDriver;
> +    type Command = fw::commands::UnloadingGuestDriver;
> +    type Reply = UnloadingGuestDriverReply;
> +    type InitError = Infallible;
> +
> +    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
> +        fw::commands::UnloadingGuestDriver::new(self.level)
> +    }
> +}
> +
> +/// The reply from the GSP to the [`UnloadingGuestDriver`] command.
> +pub(crate) struct UnloadingGuestDriverReply;
> +
> +impl MessageFromGsp for UnloadingGuestDriverReply {
> +    const FUNCTION: MsgFunction = MsgFunction::UnloadingGuestDriver;
> +    type InitError = Infallible;
> +    type Message = ();
> +
> +    fn read(
> +        _msg: &Self::Message,
> +        _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
> +    ) -> Result<Self, Self::InitError> {
> +        Ok(UnloadingGuestDriverReply)
> +    }
> +}
> 

