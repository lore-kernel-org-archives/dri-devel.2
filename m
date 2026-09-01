Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FC2C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:13:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D20B010E3BB;
	Tue,  1 Sep 2026 09:13:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="mDySedQ3";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013063.outbound.protection.outlook.com
 [40.107.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC7A710E3B2
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 09:13:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cv2ewHX6AvGeBN31tAA8HgwQMPZ2PmJK7x1An/XGjAG+siKnVRIxm/TiZoCBX4f4YQkAIk8Xy9NpYwWRuu84U01uvVKeDyebKMEwgsn4Ahuf7GhQ8bRCAnUF4CX3zWeD2GwlvjhQLZLo4dsbvBJZituCzQh0e3chGxD7W7iu5nOYdRuE6ATagGkrCGXF9Nmk2gvXHRU+srspDo5XCse/x/uuPIQpdxWoiB8X+3/6XjxkDJZL4CcEnzP+HElktIbw279/w4ibzIXupcKwJjGbUAvAilQn9C6gKDFEllsKi27eU09SqxBPlX7fMB1TbY5261JxpKMDpNZw6WoViAPihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0aOHJ51RKjTh7W7o/Bxl2rIzMr48WHRX6P9sTo27+M=;
 b=c6XgdHO+MXNp6YEXUjeqCaPgsocmqSA7tGvB753FlyO75DZTvpxRbxRMV1Uwq7j7jlNKDAFFxh6MUvPwR1fAKlN8q32C9MdkHpe9kx+VENopCk9WnFUz5234LrYa231Q8ov2YtbWXAZ4YAJqJWIore8GmCzvB6yUGtIg7htz3kGdBJY2tTdYTUVsJn5tIftw8EhqSBy4Otx/DXEx6P+7UVL/54Q7VgPt+kGohW3PWQbukA74Rlrpm075/zo2VcWNOFrkeyK5KCZEvyWg9zZ1kv25z7uvz7PzAZ9GzXKfuNi8Gz+lClOfhv3PpuGrWhl6S2Iwv01zRNrIJ123PlUOSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0aOHJ51RKjTh7W7o/Bxl2rIzMr48WHRX6P9sTo27+M=;
 b=mDySedQ3F1udsqjQRc+IgixgXz5u7QeuJ/kkZF2gAVZ29oR0IUllUbHL+6txW5CYVQPcarRAcHH7XiHqRD2qpZk6h4/qgCoOmw3cguJMXBTpQV+duMQKXyK1Pbjt3FfKH7BVlrdmpBv5KRF0L9d1JkYVp/lxgYQb/HcH2roGPZ4z51cBDy2gamr+o40ud55oz9XJoeBH8rj+CvYumpM5Ujrbu9w30ToIVmE5T9xkWWIOoLFCMyJtMhCNyxu0kzYWL77IewcJlDXUO5X6Htnuf2uvmTmfQ0h0tAT13c/T2xlWPHqr24x/FsjtBvTbAxlscuMQKOM6JF1X5OOYMjWXfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by SA5PPF7D510B798.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:13:52 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 09:13:52 +0000
Date: Tue, 1 Sep 2026 19:13:46 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, nova-gpu <nova-gpu@lists.linux.dev>, 
 M Henning <mhenning@darkrefraction.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Benno Lossin <lossin@kernel.org>, Eliot Courtney <ecourtney@nvidia.com>, 
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 01/11] gpu: nova-core: Add public driver API to
 nova-core
Message-ID: <apaVyXAV7GvE6_ld@nvdebian.thelocal>
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-2-apopple@nvidia.com>
 <DL3EGE1IY4FL.3X49WKCS67UT@kernel.org>
 <DL3F6EKL2F6Z.2DRXPQLYLE7FM@garyguo.net>
 <apZ3_o8hxlMr6SoP@nvdebian.thelocal>
 <DL3SM4UA1QC5.3KA2M1DE6F0F7@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DL3SM4UA1QC5.3KA2M1DE6F0F7@kernel.org>
X-ClientProxiedBy: SY6PR01CA0075.ausprd01.prod.outlook.com
 (2603:10c6:10:110::8) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|SA5PPF7D510B798:EE_
X-MS-Office365-Filtering-Correlation-Id: 01654bf6-afaa-474a-2668-08df08095748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1bnjq0diAOszePBV8JuSz7AojBGhO0NsoyML4Zr69ZX8NVNoyLV2cupopw5VJTq6eCbWUHkrczNUctColdm/npo5zfieljTDgltCuff/OtjA2RJPNcyZDIi0xGtpAci6Gd3O0N7iUF+X1MX8KyhOV6KvEQN12aqsp666g8nsv20wa4K//karNFwylNWG1Y91wtWrnYwvIE0zxnoyHjNDHgtP6yE0XkNnX8CwxZXtDYe8y7b/u+m5pQ4aV05usmueIvDDV0zDYyj6KyDEeP3w4aOi66LTMcDPFD3x8RNcRDmnyZV2B3H5XS4PX5PK3sSNsXi51Gp3dP3WmhKg/Hsf9kKDCuUmTyKVMsHjONqgTNoPb4WpqagPTFUDvf0MnB9G8WE7NVoF2W7PZ7FAzsbgGEueoxjWHfq2cCAVAm/qvOfCDjzogOYlzh6N+NA8ia+ANDsJnMdMzpkutty2gJdZGQy4KADrQ0OI98PSsMkwHzbLbKEMicITjI0Ablqhhblp2EFW1ZC5SsCtWinZgt7A/L/+fbp09+Rx/GoJVoNSNpseTYGXk6faEpDb11pdK4RiVYS1orWQHELBo9iDVG2wZSMEorxJ1L/wYMe6QP+6J9OxP+/0eJX5G4T1PdT6xL6lDedwlMxd3n4sbIrW7h6i1NKGXKkJgsVK6Sc3A6PR/9g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ov4I35blzRyqHMiFI4eAPZQWG9kcGmLlp3Q5fEQvTm6qZHaMt04NChXMzeNL?=
 =?us-ascii?Q?1Al9XreufrIFnrjWCMWVKFD+2ScQAyyfdqA14EK6QNSpddfLhQ+25AfUfOlZ?=
 =?us-ascii?Q?EzVD3ZD6GGRQ99HULkYXiDK7qKCBSGF075xYEcEXhUWYJnw88V9aaKpkrmRF?=
 =?us-ascii?Q?vD2u6bQCTBSWRhscAweUE0j3871248VkrIqpLLnBrJk97n2aCU3z4Z3IQUlO?=
 =?us-ascii?Q?lw57qF+FgO5/BQ9sNTKuBLmKkxVLQo4s9PlQAkGJ3HTjTMJf/oYERnHc/rza?=
 =?us-ascii?Q?ct1K2BbDBgo6MhWVb7Ds5r1R6yiJvcQ4f7Be3uJAxs5lq9FzaYmW1msuLsBV?=
 =?us-ascii?Q?MrdlJpA76eqea1OUz6Ijwroem70gMKX8CKtJRPxoVNSvJt83KPGOvXNEm2dA?=
 =?us-ascii?Q?fJM0DbXquyNPsR8jvwsgqnJcw5aYUZDKobuk6JYkNhttDn73gDOqCNRbOw1C?=
 =?us-ascii?Q?/jo5ZaNcYX46+vrIHDJzxXKn9N/I+HzPYVrVxfSopap9Fb5z8woPJ+z5ELFr?=
 =?us-ascii?Q?IIDNRN8CPumCJ7UraSRRT8IL/sa3GjRK2dCsYSFuOPQKEgVxrctDBHLDnZE1?=
 =?us-ascii?Q?yHEcBOaOPxAp680xq0VnCpyxZuqYsV+LQjhei7IJv+gSJPJRZkXHzVaAsa4P?=
 =?us-ascii?Q?QtUJE9HR7mOOEnq2u8t7J8UZ7KV9PcLd87tcKGFxO8z/qpZZEghaq6+n7i6u?=
 =?us-ascii?Q?bIVmcA4pKOYL1MpyjoHsyta42laLOqiBeCEYc/wlVCyJ36t4jyazgnfp7RQE?=
 =?us-ascii?Q?cNozH2sOP34O0nby2rJCO1sgsW5ispnaE8z3hOyAuPVjkvBWuWVjrKzFvEfd?=
 =?us-ascii?Q?xOOhm3pg7/xn2ki6t+anj+q2/fJuSRsaCepwpEqzs5i6biXbFuXh4OmZOYz/?=
 =?us-ascii?Q?ToCXHeRrVPvnHkQnfXsO+KwR1PMrnBhDzfyIXOs9LxxB/CCiQ8kneq/KPcot?=
 =?us-ascii?Q?hcBXlEP6yOJxPfAVQbYUsaouSNwEgn0Z4EKtcqWQRqHZgGtTB1dkHt0wbFsf?=
 =?us-ascii?Q?r1xNlZC+sxcGmKpudS25+kudDXVj8Q1HUZFGEklXE7/40obLhnEpwP6NYODW?=
 =?us-ascii?Q?cicPiaEJTH9zwLMVjQWK5vRtcTimUO0TuZ0l4imqGhfzMVwTOKFl8lNGgF9V?=
 =?us-ascii?Q?CXjE5nc9yhu/Em/Oavaa5nSdZh2s2CXCzDWu98Ze/5EIXE2YojY4MqZ7QEH0?=
 =?us-ascii?Q?EJrrjdr16Tu8jWqwz3xATFIYI71nakc99GPJ0z67tw9jGyIY8tXglB4E0Mln?=
 =?us-ascii?Q?ZkB1Nm3rDHNhJ1VxoRGyGzEdPlZgHOunbq3EhqnJlMAYwu2d8d/bXc3z/R0v?=
 =?us-ascii?Q?yRlYyI+Sxwj2LL9/oIpe80Nr6SG66m6hTcL4wE5IRwf8hKSG7NUiMxuURgO+?=
 =?us-ascii?Q?Xmrij1olqY45KyydL0o/BG7t6z+lufdpzvjn3SZ/HOrA4teOXUxBuipF6Ytc?=
 =?us-ascii?Q?44oZkzEwdd88J2ahjaKbt7STb3hHs/MQHPJS0/dyk/3lCXTASFU/B/0olvpQ?=
 =?us-ascii?Q?UgR0ne+EmUkskyJCzAcae1YAKFRVCPvfE1Iex2L3Gmp7QK42lMYQzYLLxowH?=
 =?us-ascii?Q?tfgeXGs51CWgkJ3kP58MJBd1+4VP01EuQPOtFYN57R0j0sRcSVYUi2bzq5tB?=
 =?us-ascii?Q?7tyKjeqh3FijXW85lC9SlqSNXciTm+9H6Cv+iYnBHholD8gkeRm9cmZDvyba?=
 =?us-ascii?Q?0UeKpQ0xDN1MdNNKYlG+4ydmKwQYidlwRT4g1Rqp7oIf5+RLszPRQbiwEk6w?=
 =?us-ascii?Q?u1UCvqpwyw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01654bf6-afaa-474a-2668-08df08095748
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:13:52.3814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SB+zAZeSZiyXwt1q8HeXFXzRd07PitrOO3CZg/+aan2L2UmN4+o1LBNTH3wXp0PDd+PtKXOSdMD0Azfbkzn1FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7D510B798
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

On 2026-09-01 at 17:14 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> On Tue Sep 1, 2026 at 9:07 AM CEST, Alistair Popple wrote:
> > On 2026-09-01 at 06:42 +1000, Gary Guo <gary@garyguo.net> wrote...
> >> On Mon Aug 31, 2026 at 9:08 PM BST, Danilo Krummrich wrote:
> >> > On Fri Aug 28, 2026 at 5:35 AM CEST, Alistair Popple wrote:
> >> >> +/// API handle for the auxiliary bus child drivers to interact with nova-core.
> >> >> +pub struct NovaCoreApi<'bound> {
> >> >> +    #[expect(unused)]
> >> >> +    pub(crate) gpu: Pin<&'bound Gpu<'bound>>,
> >> >> +}
> >> >> +
> >> >> +impl NovaCoreApi<'_> {
> >> >> +    /// Obtain a [`NovaCoreApi`] handle from an auxiliary device registered
> >> >> +    /// by nova-core.
> >> >> +    pub fn of(adev: &auxiliary::Device<Bound>) -> Result<Pin<&NovaCoreApi<'_>>> {
> >> >> +        adev.registration_data::<CovariantForLt!(NovaCoreApi<'_>)>()
> >> >> +    }
> >> >> +}
> >> >
> >> > CovariantForLt does not hold anymore on latest drm-rust-next, as Cmdq has a
> >> > Mutex. So, this needs ForLt now and therefore the approach that I shared in [1]
> >> > a while ago. I applied the changes in [2] to fix it up.
> >
> > I can see why the mutex means covariance no longer holds, but I would kind
> > of also expect it to not compile given it surely can't be safe here to treat
> > an invariant type as covariant. Is this just a limitation of the current
> > CovariantForLt implementation not being able to prove covariance or am I missing
> > something else? Thanks.
> 
> Well, it did not compile (as expected) on my end, which is how I caught it.
> What's your base revision?

I'm on drm-rust-next which I believe is:

commit b705c185105762676aa6ec16cf976101df87cc35 (drm-rust/for-linux-next, drm-rust/drm-rust-next)
Author: Alexandre Courbot <acourbot@nvidia.com>
Date:   Thu Jul 23 22:54:37 2026 +0900

    gpu: nova-core: fix incorrect naming/framing of GSP-FMC firmware

Reason it compiles is because the the Gsp has no lifetime parameter in the chain
to the mutex:

Gpu<'a> -> GspResources<'a> -> Gsp -> Cmdq -> Mutex<CmdqInner>

Which I think means using ConvariantForLt is fine in this context, unless there
is some other change coming which requires the lifetime. John's IRQ series hides
the Cmdq behind an Arc<> but that still works as there's no lifetime parameter
there either.

Not sure why you're seeing failures, what base revision are you using? (and
apologies, next time I will tell git to add the base sha1 to the series).

 - Alistair
