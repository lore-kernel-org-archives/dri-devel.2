Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04DECA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:11:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09A3589BA3;
	Mon, 28 Sep 2026 15:11:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="hjHFth8z";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F049589BA3
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 15:11:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oA8582gSKuNrnBej028cjxChmo/hCQwiNC9sp/NtRb8YeXzMQq5VdCTU2DqDkE/jPb7LY6GDg2NrO5t/T3Nv9USdwEEeUYkFlhZHlE4kIONrLoHEAUDIriQlhgaLz0es4/0vBXDpc/2V/4arj0tPYUX3b7FIO1Lblobs3HX46+pIWXLoVKITjU2dUx/4F/mUNcmLr8EgQ0urPtVAdJwDWhWf92+d87Op9vbUm3QSmMV+Lkr5ZL9twg/cdxqUT/hXrn/fXGpvRzBx5T4sfmGtIWZZg3wGorUQXG5YK4uUBSsoudf96HB1dF3nMDY1FEFzal/lLoTNPfFxThhQRhkVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NL1V2ZKoklmAUPAmm38CBH7IscW6dqQn3lZ2m4J0BI=;
 b=RmpQqqVrzHL85dPk8wxIJlLxHQroRnwsKXSXutyWW+669njNRwYdenRa08+IcSnuHVAcid00Iv8gdwV9XFDUrEmLLQbCDykel+h6u/KpbZmsF7abNLNjhhwwnY79CNUndsqtW4lB+LkvBa+S7zvfXpPpPl9z4umvCGEXLo4OQMlpJHwkoW83NpMVLxs1S9Fe4hTMJFE1NYnk9ipNE8vD9NwHAO04PnEZTOctpjwIZJr/9zaIVw5IYqz38ih9x5bHYld5y/shMDVlH0fiqbNo6YAH1K6THGYmhlK/iYuUIyFWGRf8R3bO9rhC8CGtAHiR2rWNfsjqD8FvVYCunkUrUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NL1V2ZKoklmAUPAmm38CBH7IscW6dqQn3lZ2m4J0BI=;
 b=hjHFth8z+m8oTQEAPmlzTkTW1kdDqaOKwZt0//qTsUKR0pTMok35RFaURQ/Qqhn3NfKt2wnXheoHY+mqwo5jHf7vmcwwMHzK6mfzHRUxx7VX4U47SRSJVRYJLdplV60YdS+54UZkc2/j+QQ79/qdagTL87yJBO2Qukw74JRD9SGbyf0wwoGUMUPVn7fmhTDYy/mBUk5Ge4HF3DhBBHDS+iPsqdJ3icO0rKVkKIPKtVmySZWwQRBTUGgxeOe69ERfKrvERPpODtznRqlStEsq34H5HbmHFmlYbwaV8M1sPPpChl/XF4DlBXwWbuN/SdQ6ytPl+WZbrbSFrwy3e+Coyg==
Received: from DSSP221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:3d5::19) by
 SA1PR12MB7412.namprd12.prod.outlook.com (2603:10b6:806:2b2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.23; Mon, 28 Sep 2026 15:11:43 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:8:3d5:cafe::8c) by DSSP221CA0002.outlook.office365.com
 (2603:10b6:8:3d5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 15:11:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 15:11:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 08:11:12 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 08:11:12 -0700
Received: from inno-dell (10.127.8.10) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 28 Sep 2026 08:11:08 -0700
Date: Mon, 28 Sep 2026 18:11:06 +0300
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
Message-ID: <20260928181106.06eca8fc@inno-dell>
In-Reply-To: <DLQX62L47S38.1D5416RRETLY3@nvidia.com>
References: <20260927-cmdq-rpc-v2-0-c3f66ae73be4@nvidia.com>
 <20260927-cmdq-rpc-v2-8-c3f66ae73be4@nvidia.com>
 <20260928122015.3df66b3e@inno-dell>
 <DLQX62L47S38.1D5416RRETLY3@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|SA1PR12MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e03a5ff-6aab-4ee1-452d-08df1d72ce04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|7416014|11063799006|56012099006|4143699003|10067099003|18002099003|3023799007|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: xMVxXBipd0JyighYH2KgBmnEkjxqlSWfB2xQojE/X4/TuiNr8CHOEBrTeCcviTNCt+VsVQV2wusMaiEFgdVdWt56XbK//QAKkKD7QkaZM/n+yd35zYs9maSDVdx2F7+zyUMuiHxQ+LEdbAXMMn8A04i2N3vf0Jkli4meAQbJuS55pEIVEUsbgmG88iS/+sISUa28LExRer5L9OfZ3RcnN0/9xrns1rRsbjRbBfH2nV0njodpT+4m5SeoMHFgxBro6j+4HUgD4Mzkv2tOB9g/DC4QLdxYyl/tYNuXO9f4nnA2IGwp3tuHJ7bkwcE37nONkLIGTGt0ldM3keRf8oIYwLATPDntcdTI11e2gllEbR/kqZoRwl33EEilkKAwMnlCODbr4Wq2mNDikq0tKYOiWHkMKFSGJtWv9SI2+D2RUAJk9tIFPCGJqDgQ4rxXohqB/kYhwephr7kRrZ26JtWRftxhyhcZ3vO3t0pvByxk+1N8A9XM/itWLi0Zkj3ysyGyRXm52C6Qs1f/DlbnBcYMZ7oW6Tgix9srfbwNAOLkQmZSOipuf3045a5yfIWXg5+qI23NJJrtcwvRYDh/9sZX0AOiKJUB0Tju51kWafMz1dUWZM80xLq42U7FRafIy/+daFVJrgscCkg2Gq5OUdGX2C2cHSqMZyfaT2vK12f9Aeo2pxxIAQqrhPvZzGY4/+hIjGA2kzaXd8swu9l/JdsQOQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(7416014)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(3023799007)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: k7273S+vR0kbsBNgL1k9lqRdBOch6y756paojNSHiDiT/69cmnaU+LPjDEH+IBX9OIoHdXLjFrOzMM4S0uxOHo/lAw1UxSb1vAZj2G3d+uX8EANH5nnM9kOfrEn/O7s9yena7PKPEQt6rDMPabpdvKPf1i8TKZldjn/6zHHakPkS2QCTFaDPMAVdt5cDZy/e0N0dl/m8tc7jJr9SkC65KoWW5kMucXhb3UErkYlLXYSoL36JHaJ9bPZdEqoFtPmZJHj57Mq8UgP+qd3NsvsfWzfklz5eLVq9TH+eq3r/M6kHt8KWzVKf2rWaS5E7LJ8rq179UAX+dkt2/42kO1nTaFbO9AYgtz+IQEMAicRLvST7ozk/H9XnVOtOciRcaTt3C0rm5JLWx7otR7ibUCgGdhDCarJTEpOqI0fmmn4cnLlb3wtM2L9l71hq1zSOFieM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:11:42.8419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e03a5ff-6aab-4ee1-452d-08df1d72ce04
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7412
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

On Mon, 28 Sep 2026 20:40:08 +0900
"Alexandre Courbot" <acourbot@nvidia.com> wrote:

> On Mon Sep 28, 2026 at 6:20 PM JST, Zhi Wang wrote:
> > On Sun, 27 Sep 2026 22:46:25 +0900
> > Alexandre Courbot <acourbot@nvidia.com> wrote:
> >  
> >> Move the types and code related to RPC commands into the
> >> `rpc` sub-module, and update their users to reference them from
> >> their new location.
> >> 
> >> This is a pure move commit, with no functional change intended.
> >>   
> >
> > Hi Alex:
> >
> > What would be the plan for commands.rs in the future after the
> > movement? I was adopting the similar code structures
> > (fw.rs/command.rs) for vGPU manager's RPCs and GSP plugin RPCs,
> > e.g. having RPC typed code and function handler(wrapper)s, it would
> > be nice that I can align with the idea accordingly.  
> 
> Can you point me to the the structure you have if it is posted?
> (sorry, too many series in-flight and I cannot find where it is ^_^;)
> 

No worry.

I am trying to maintain vGPU-related RPCs and GSP plugin RPCs in below
two files. Basically the maintaining schema is similar to current
nova-core fw.rs and commands.rs. 

IMO, nova-core and vGPU managers bindings should stay together, but
there can be quite many vGPU RPCs. Would it be a good idea to maintain
them together with nova-core's fw.rs and commands.rs?

https://github.com/zhiwang-nvidia/nova-core/blob/zhi/nova-vgpu-20260928/drivers/gpu/nova-core/vgpu/fw.rs
https://github.com/zhiwang-nvidia/nova-core/blob/zhi/nova-vgpu-20260928/drivers/gpu/nova-core/vgpu/commands.rs

> If you add vGPU RPC commands then I guess somewhere like
> `gsp/commands/rpc/vgpu.rs` would be a good place for them. But let's
> wait until this series is approved before settling on a design -
> moving code around is easy anyway.
> 

Sure.
