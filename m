Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657DAC5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 12:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96C5410E53C;
	Mon, 24 Aug 2026 12:51:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="MaTokh/4";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013070.outbound.protection.outlook.com
 [40.93.201.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1089010E53C;
 Mon, 24 Aug 2026 12:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYluCBRvyK8BfWxKnv7VdR1sWqXj8q2hk2/L8I5/TZDuK9TPAUXooe6ZZ4fg54Y7UZmRkcC7x2DDShp3Ok5+c3ptjpLmOzvILKSYnuFGrXBlV6/JWghkRzO9dYZTjmJFiQmKMj8bnRa3/XVQi2XY04fQuKk9Hi5ECBO5RLupiJHWUwkpS4Ft9EAJL45Ar0/prdK7lTg5qY+/q7navs2aANmdrxbRyYehGJsxngE7huiy2QMgvtE0ii4CEzUvt96A7y9IXcT3nFSW8R0H6dO4sJc3cT1+2aRl/Cg4wxVnv676pT1ES2l/mw3nQoZF/Q6D+r6u3PrvlPe1cTR0pImqiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgSEBmZULIdaz/m/XfoHS8hzBBwJWcob1tt25nmNdoY=;
 b=kGqDHRxqwIhMgsI7YCHn0zZHkAGY1QkJX4m9QGtAArTLtJx2ibnUHeMMNQPTE8N352AZ426ubyzEhoGQswd43nH7uJBg2A2W511A4rIwCapAYvRLLxK/t3pz3hwfYOpMEfx+1dFNQyaFUzwYhg28hKp0g/8/LTptAIE+Pcx9u+nybzmIQknX/SdaxKR1dCJaLnZRYxPEiKjmyXFCx/ktWyxQNmU8Lt5z0ZQfImLHDWdHcjvmXIZkL5f7NB8qQ/6BicMT9hSqUXRKhAZoj4rv88sBnesWSkzNdq1zv0rcd3FZjBR60IXKpM6ORF605tIIXsZS2XUOjPGgl2FRQeBXzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgSEBmZULIdaz/m/XfoHS8hzBBwJWcob1tt25nmNdoY=;
 b=MaTokh/4ZFCmcorUxTTn4+p0RuzjNOgRlq5SkIdqWLTMo4SrWNbcmzsl5gp5S8S68jiP8xx6blmfjKhUtqyi5F2CSDmq4uoZ/qRfIa1QO31X/6ssBEN/T8o3bc1sLgUExPAvNnSUrsnwqR3GVnVdeh3leZZq4p/sI+2GZVjqDL/pnHA6ENpmofhUOOO1mcun1VdtKydL4gm8KPXEoNc4c1lde3/Y1WFLcIe5+pzNHvSY14ClI6CMUq9lxlPysE5CdV6/BE6CG2dNDaTujN2o6/wS/BSmXWVNHRUhcLB3orYZk7P/kdfk767szhSM/v0g5JbGLBAzlAUgrgFOgVMW7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.12; Mon, 24 Aug 2026 12:51:02 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 12:51:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 21:50:57 +0900
Message-Id: <DKX6R86RZJIW.2HMS6X0NUP15T@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 1/2] gpu: nova-core: fix barrier usage in CPU->GSP
 messaging path
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260819-rust-barrier-v3-0-d5b7bd7e6624@garyguo.net>
 <20260819-rust-barrier-v3-1-d5b7bd7e6624@garyguo.net>
In-Reply-To: <20260819-rust-barrier-v3-1-d5b7bd7e6624@garyguo.net>
X-ClientProxiedBy: TY4PR01CA0060.jpnprd01.prod.outlook.com
 (2603:1096:405:370::13) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS0PR12MB6486:EE_
X-MS-Office365-Filtering-Correlation-Id: b9c5eaf6-94a0-4417-91f6-08df01de599e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10070799003|10067099003|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FuA5KG12iND5voNo9QMsBGl8TAG2s8HzKD0zy4kMVQGw/eIPXsmN8dWldeQYrnBV9duwobER1vnCFiGQsL8MV6j3I9Q4A432J4Q0wElFsDjTUGxoI5G8BTN42FmprWL74iXsognuuQYZpVEm6Q9Drf3MiSMHmQvsu1RQ8dKkstlZF/O89dGGL+bQyOr59WF/kfezA39cKPwXrLHOll8mBog6OSDIcaAbl3ddZf77p89//oIipoJYVcW6mHMgIpRC6IuLGKhZ5dbbOJ7yej9UPQxhRUoqt17Ua7dgpppAuLa6tcxr2kZxSdnzGVTWxKd77rCc+O5vlqEp4GAM1PveCRdP0KS0pSzNlCFhi+/P59VG/kKYfrzKaVbotIiK3Po34IpgcQVVrSjFw19XDwbuf8DK2BmwIkjE77eD5HE19CO41i2b37s5Ap7Xl64xImo1kQCIdg0co3Q/J7iCOWltu0oyaKn4xR0Z+EzxPX4/cGzt6PGKS+gQowXstUcg9+/VAX95RoqOp+LS/9wQ2zuriY7WHYK0jV/ZOLVrTi0+QsyVkQeYxEZr2e7OAR147j//XdnKRc5bOeKHpbZjXKAOf6xENy3D/LyMszbcIIFIsMdOKLMrnasVCykUbMJ6UsJmWjnYkqXEhyCy4ncgxPkDiAoiO2OGmlPgHzbZ5R6xilk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10070799003)(10067099003)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHJZK0VYVWhOQTkwUmhHakdUWW13d2NJN2k4Z2hjN2x2SVlXcGRFalYzSXZ2?=
 =?utf-8?B?WEdVK3ZmNzVEQU5PbWdmQnZDcng4UmdxT05oZjRtTnRLRmlaZVl6TXZ1eDBr?=
 =?utf-8?B?T2xxR2FkTGQxcHg1dEhqYkg5Zi9ReGlDTGo1b3YyUmZubWE3YjUrK0xlMWVQ?=
 =?utf-8?B?U3hpSGZ1b2M4S01GQXJhQW4wZk5jSUc1TDhDWVdQR0tyWXB5cWM0QjR2cEZE?=
 =?utf-8?B?ZmxIMGRSdlRzcURLTmxzWEh4UDhaOEFaSFMzTGdVYW0wOERrWmZtdzh1NGQv?=
 =?utf-8?B?MVJkempwU1AwRTYzUFJFNWVVa3ptZHVMeVpNVmxBbTNLNlY1anRXMDl1cG1V?=
 =?utf-8?B?c0hKTXdYc1VkbHNpVlE1bFZRaUpmRmU0WFlIZFlHUG1oeTU0OE5xY08zc1ZV?=
 =?utf-8?B?WWkrZHpLaVNTYXA0R0tIYkdNSmZMby9VdWZ5U3YvcnNHRkVIM0laQmtYRERI?=
 =?utf-8?B?NVhxZDZjWTFPOWpFclhiOHZETjgzOW5SbFJ1c0FXR3JmMTVLcVpEeWczOElB?=
 =?utf-8?B?bkpmSjJ5VlllZnU2eE5rWU1zanJCY3U3eDlCemlGRXBtaXNCUndWTlFSV2Rw?=
 =?utf-8?B?Zkp0dXgxZ2M4NzZ0VVZRQks3MGdRd25CNTZyUElKekhrSkVXSmxCZG1wb0Ni?=
 =?utf-8?B?VEFRemxZZ20xemJQYzlyUm01dWcwK3NhL2NEemlYd0VXbTVIeGJLYm9kMEJZ?=
 =?utf-8?B?TVpKS3lneGhNREVkNFhsNEJYcHo4WUErcGhzYXBNVHVpcHpVRVFpMzFEbGlB?=
 =?utf-8?B?Tm9zVkVaRTVyK2IzWmloV3FpTTRJeCsrTmVCMG1lRHQxcHlvOEdJWlprNDA1?=
 =?utf-8?B?Mlo1ZWRhK0t3YVZJWnQwSitiTnBGU09UdkxrMWxEeHlUYzhQUWtCaDY5a1RM?=
 =?utf-8?B?WnE5RmxvcDd0alZ5NzQ4Zktrd1pGSlFjaHdRakt1VmhmcXQ1ODM3SWNRWXZ3?=
 =?utf-8?B?OVJtZERQNGxZQ0VxNEZyaUVCWnRrekJaVDd0NkhTT1VMZDI4VjVFSUhicVl4?=
 =?utf-8?B?aU0yZ2RRNmtEdUh4alNFVllrZFl6V0FjZFYybnp2a0E1QndKUm9mbWcrSjJJ?=
 =?utf-8?B?WjdWSUhySHpkWVFuWmhqb3BNVk1odTcyLzJvMnhaUkV5cWlaYk5sUWl4WThQ?=
 =?utf-8?B?WWJwWUNCR1IvQmlsRHdrRWVMUXR1ckxUSlhRU0xmV0VTUEp5V0lqTGZTUGFo?=
 =?utf-8?B?K2xUdXk5cnZscU9kZm81Y0dzSzUzbDlGSHpmSG13aEFGcEpSOG1BK1FPMGxD?=
 =?utf-8?B?R2hacXRrTk1uZ1hqVi84TmVLZFJ5a0ZQYUFvVDFGZjEwSnJEenBSK0M2QTI5?=
 =?utf-8?B?dDg5QzkrZURNcUpLbkR4bmZHVmRnVU5WQjVTd1Z1NVptUWhlSGlPcWdpY0tX?=
 =?utf-8?B?VENQeGJEOCtjNkhrTVJkczV2K3ExR2ZsTURFdjU2aW9VRUwwMmFuSDRPQTZz?=
 =?utf-8?B?NWd2aXJ4VmFKREExWmtYNkIxdHhsV1pCUzN2cXkxbDZFdFNkeGFWLzJIR3p6?=
 =?utf-8?B?MkVFcVVzVzdLbnlnREdFMkhId2dSeVp0M095MVpvNDdJZ2FXTEpEcXYvUHVh?=
 =?utf-8?B?a0g1Ui9kSHhBYTdmZi81dG84U2RoVlMyQnNqN2VUOUVMSWRaRVN5cE40N0pp?=
 =?utf-8?B?RVRib1ZQREQreVFDaVBYd3AwbjVtN2IrZmtnak1vaEdLc2dlYlJvN1p4emJp?=
 =?utf-8?B?ZFhpYU9VUFEwOVFCek5SWmp0OXc5d080aGtXbjFoMjRBOVhZUG1OVlREdy9R?=
 =?utf-8?B?STh2bERSckovZTFLZUZXVEJoRnZsWXN4c3VWWW1QSjFkYnk1NTJLS00yQTlL?=
 =?utf-8?B?dXZ5RzhCR3A5N01DNmE2WEk4TThoZUdyYkpYeHZwM0c0Y2hjNXF5bzE5b1Rm?=
 =?utf-8?B?MkR6Tk1ZS2FyVWZKaldNUHl6T1VLd1NzQ25BaW9ORDlsZ1NOQk1MUWovSXhK?=
 =?utf-8?B?bCswSmxoMXYwK1FTUmZ4NU9SclFTMzFwZTBvWWkxeXpvQ3ZkZ2tzV01qQ0hX?=
 =?utf-8?B?VEFFM3dPSk5Ga2FGYk9Xdlhvcm5rWFV0Vk5GQURmVzMyaGpLVW9PTFozaG5S?=
 =?utf-8?B?Qzk0aEdXdlZ2ZUhoR1k1cEpxQndVMzg1S0hTTm5NelNudXpERHFwVE5OQWdt?=
 =?utf-8?B?eGd6M2FyVngyd3Vydy9RN2RQMkhFaVZCdTVZVnNUanZSOGt3Y3p2c2EwWjhN?=
 =?utf-8?B?eEpaM0ZBMlJWWjIzVHA1V2F3eDFrNHovUEtDbExVNVBFaGdxZFpJdzdDQUwy?=
 =?utf-8?B?dFM3aDF4UkpSaVZCS3ZRZW9oci9FMmdOekVCdkZEaXQrVnlrTWNiOFo2Tklp?=
 =?utf-8?B?UFFiREQ2NDN4VGdyb2orTmRFVS8yMmVWdEhjVHR2M3NiNXIwOXZLMTJDeS9T?=
 =?utf-8?Q?2tJZGJXna8iUnnVd2ADPtegw7iFIbeoYJ2MVdUdae+3im?=
X-MS-Exchange-AntiSpam-MessageData-1: 37H3+FJXDl0qvg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c5eaf6-94a0-4417-91f6-08df01de599e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 12:51:00.9248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlHTkBoJ/vzba28fPySdik9pm2c7WJdffeP7GNJor9uGqhLcffDdO0edS7N2gX4kjdrc3ikFAt4BqoY/Cvxvfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6486
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

On Thu Aug 20, 2026 at 2:28 AM JST, Gary Guo wrote:
> In the CPU->GSP messaging path, the code reads the read pointer from GSP,
> writes the command, advances the write pointer, and then notifies the GSP=
.
>
> A LOAD->STORE ordering is needed after reading the read pointer from GSP
> and writing the command. Control dependency exists here which provide the
> needed ordering, but it's best to avoid depending on it.
>
> A STORE->STORE ordering is needed after the command write and before the
> write pointer advance. This is currently incorrectly done after the write
> pointer advance (and before GSP notification), but this can cause issue i=
f
> GSP is still processing ring buffer, as it may observe the write pointer
> advance before command write. Thus move this barrier to be before the wri=
te
> pointer advance. Note that barriers are not needed between write pointer
> advance and GSP notification, as MMIO accessors already carries the
> required barrier.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  drivers/gpu/nova-core/gsp/cmdq.rs | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index 6da728201281..70674d2d0f77 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -27,6 +27,11 @@
>      ptr,
>      sync::{
>          aref::ARef,
> +        barrier::{
> +            dma_mb,
> +            Full,
> +            Write, //
> +        },
>          Mutex, //
>      },
>      time::Delta,
> @@ -272,6 +277,10 @@ fn new(dev: &device::Device<device::Bound>) -> Resul=
t<Self> {
>              (rx - 1, 0)
>          };
> =20
> +        // ORDERING: LOAD->STORE ordering needed to order `gsp_read_ptr`=
 read before data write.
> +        // Control dependency can serve the same purpose here, but we do=
n't want to rely on it.
> +        dma_mb(Full);
> +
>          // SAFETY:
>          // - `data` was created from a valid pointer, and `rx` and `tx` =
are in the
>          //   `0..MSGQ_NUM_PAGES` range per the invariants of `cpu_write_=
ptr` and `gsp_read_ptr`,
> @@ -450,9 +459,6 @@ fn advance_cpu_write_ptr(&mut self, elem_count: u32) =
{
>          let tx =3D io_project!(self.0, .cpuq.tx);
>          let wptr =3D MsgqTxHeader::write_ptr(tx).wrapping_add(elem_count=
) % MSGQ_NUM_PAGES;
>          MsgqTxHeader::set_write_ptr(tx, wptr);
> -
> -        // Ensure all command data is visible before triggering the GSP =
read.
> -        fence(Ordering::SeqCst);
>      }
>  }
> =20
> @@ -683,6 +689,9 @@ fn send_single_command<M>(&mut self, bar: Bar0<'_>, c=
ommand: M) -> Result
>              dst.header.length(),
>          );
> =20
> +        // ORDERING: STORE->STORE ordering needed to order `cpu_write_pt=
r` write after data write.
> +        dma_mb(Write);
> +

Is there a reason this can't go into `advance_cpu_write_ptr`?

>          // All set - update the write pointer and inform the GSP of the =
new command.
>          let elem_count =3D dst.header.element_count();
>          self.seq +=3D 1;

