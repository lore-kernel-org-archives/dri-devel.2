Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7251C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 00:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A2EE10F0A1;
	Thu,  9 Jul 2026 00:41:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="n+YDMA97";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013071.outbound.protection.outlook.com
 [40.93.196.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A94C410F0A1
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 00:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ia/VPtKi5ywurWLJNpuK1F+jFqbgkqKLiiGmDAupawUzgYqvpEryidasm+YKoQmwh++YFM1m0zVSZWfkR54aGMsgZan6XuYacqQ1AVJIPb/KVpT9jZOfhyGXMK1t1RdjcwdLyEv6Zt3Q0ZXo8xMtmKAjOkWfzgCt/UKC0acJUCOQSqKKUiWKC0onPTcJqRjXpcnJpVxnIT2r15L0LY1HzDKXwpTwzU/qigKuWBEmcpIm8VR9bn/O8pA+Md4A1wHvwCT9grzSiXLFWXADQZbAzxerhKo+kJUTM/kAHIRdfmEdFeV1FeVYBSs3e+HK/8fLpZtBh9LNa1EYwTvQ6WTkUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viec5/jsv1xyzoZXC3qsODtekLgyymjvY0Ty1ekMLgk=;
 b=zULsN/gEayy0A6G/pph/kk4q6GbLmlKlF3S02hbObYaW5kOu0Tf8N2ZX/NXlIoSfKbvbHMToZZZpDPQjikSfpqPwzX1N0RQIcqwh/p4L1tG6GG+LD63cGa0/XaXTz8cVIkEzUH67/tlMnsnUJZie1DJo8r757Zs/TfL+RcWDVvQ85rQcIppDHhw9Xs9WgdQXZDoEBh7t72MouJEi7FLNjMP6dEf7QZ2E4zsjU2DWv6Vc0W1/H2WUbaYn8x3vaNrwg42WL26k8ojzXnXKWkwDtIFxrWuGXJ0Hgx7SN85vgHd8zMwBiZMlNCV2744TVGLU2eoptIkZXuDtJplN1xwVAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viec5/jsv1xyzoZXC3qsODtekLgyymjvY0Ty1ekMLgk=;
 b=n+YDMA97G+EQC8Ki55ZzKMnYGKxy+BbRc+xEHwp52PvqaJq3IAScy0NwUmXoNpeYkzuF6Lm30GcaR0y+nablw8iwBj+3DurvgbLGqUJ1bHrPgNucm2suv8ww2hpJWm51hPPwjGgp+pyBSgZezc3+EL2rVGA/lFeuRFQgRSf1wwXCSMYmUSeRzPCl6IlCuBCSnVSk1FIu4R7imZxEW19bOLZl1nPIj0bqWGGKuCG4mOqBpXtzQ96myoneK6/xs3JvmpW5XcnmYbUKYI4HfrMokaQTLMhzSIu39/iFBYFtmzkQzYbv8sPc8IsaK6OVJNE5FUrLpLwhuyOuKeksX0sNGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DS5PPFB8FBD73EA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Thu, 9 Jul
 2026 00:41:03 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0181.008; Thu, 9 Jul 2026
 00:41:03 +0000
Date: Thu, 9 Jul 2026 10:40:58 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: nova-gpu@lists.linux.dev, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] gpu: nova: Add DRM registration data
Message-ID: <ak7tcGfBxAYQXyf4@nvdebian.thelocal>
References: <20260706053413.154135-1-apopple@nvidia.com>
 <20260706053413.154135-3-apopple@nvidia.com>
 <DJROO2091YJ9.2O9BMST1L8HQX@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJROO2091YJ9.2O9BMST1L8HQX@kernel.org>
X-ClientProxiedBy: SY5P282CA0196.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:249::7) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DS5PPFB8FBD73EA:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ee7745-743f-49f4-ec93-08dedd52c0ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|3023799007|56012099006|11063799006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info: qSBzRVj/PInxt+MeDLxhPD05Soo+QwoQrC2QErAvW91PYCdc9o++kDc+/MEQQvdYWU9gEX0DpAJuAGIEYUmpc3oaF2nGu8YXI3hfzf+YTl3hb7hZwx+Uc3elbgXl8HjaVuoCKOsZ5nPzz6bJEyFlbcUo0MqJlzHJbXjY4wOvSByCdPk7zjw+vO2P6xzxO2y+auYiL4seAzG0jd8fZKyiKJtVv9ZXF9l/yGfsduXKs1aFFxGW5nTBWmIB/zwik54FZw1Icgfj+L7R/lDn3KplrOLlkK8JdwSMiYnmoXEnGStBsZyOvEj6rMz/97pubI9oHxvQEdxXVFC4pcnSkmDrg196Mfc7wPQL93Yh/hnH0d8UJKFQ9RZehWpgAlNaKRLCWvXEbKnIqIAEXtOUJxZhGC5hEE8QJZZrCCvu5oHJqJqtav8elqRaFhVLNmCcfUOt5uKZ7lhHWbQMbHeVtXqZlPB0n6GrISzO3l0QDaMR2KKWwC68RE/tBaDcKsh3vHrO91NH1EqZw4iKPIRjw8Dik9sBYJaF1NEa9Z+yCnzDT9NiU+566cWKTnywjg+JyUviKToLuLkjzTMAF5ACpYhtFJsLcve1bDKgt/EHFYeNbH3ZFBAeVPx5vp7eXHB9rFxGIbdYwKDy8LMYpidJ6LuBml6KnjZj+NpNqjah23IjIoE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(5023799004)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mWLUMsfA/K/V5cNDNbPSRQ54HxX0ECb58diG6npG9DFgFIDhFiLRtUqU63x5?=
 =?us-ascii?Q?8Y6z79s7RR9qZO5Y5mLzAG5Sb4p7pkEBFWsUhBkxqgXNYm2lolR+O9kSJ7SN?=
 =?us-ascii?Q?khJ80QVDiESeNL9fkNj7/En2zLqGlgEJ9QBBkPaB9bbL+cTfD3s+7M/jS9zr?=
 =?us-ascii?Q?IguXgbh7COtU5Ua/9EvGogxcRCYvrkynypl6X7NJjotc9fyP6JJ4NlEHEwN4?=
 =?us-ascii?Q?PXOBW7JOEt5uF9Af3QkYs/CNXwwiZJ1D+YIwfOUK1uwrTk/soGraCvUSeDHK?=
 =?us-ascii?Q?6nXechjNoeJz5V/jb07ZWYifemh2prIMBR0Ge7mMlj39Ks3x6KwC+KNeecss?=
 =?us-ascii?Q?AsOXcV8Yk89pix9R7d6FJRaiDUFtkT7ULN3xeCROT2QVDAubBQCX3BY8W7Ib?=
 =?us-ascii?Q?vkBcwYihFUhSaDExkwL37T4lpWN9gSmmPh2D1wiRleroUJwTKgioulECMDcj?=
 =?us-ascii?Q?EShNGM0btKuSrvzHVxFAUYkiCp7APmkjxRgWHYTZCsGWJZq/G/uR/qmMfM8T?=
 =?us-ascii?Q?pq3+9Bn3KUnQHnJ6oCdhBgdOFwLmg9OrIAg8NfyYq9qZbnPfnRrhKIabPTxg?=
 =?us-ascii?Q?G53xJlSTAqFd/Jw7yXkAKObbixy/hHtx1U3gnDDaoPh/TtQZNLwD2g9rvonv?=
 =?us-ascii?Q?F8dq9CgxQukiBQ6ACaIjMoscLzW/PGJzry2vcsg9K5GmQMzau62+Y2Y4a9aI?=
 =?us-ascii?Q?ly9XIkgFUxJzfWWBuJyBv1it6J1Lu5JGwohYqFMyq5lVsNa2IHpXcbprkhbY?=
 =?us-ascii?Q?SwnlnF0jSkTvBhPAJIp4OZxfDJhZp8C+On/xyzKazdeMpNtHfi+rCJyJ8/3r?=
 =?us-ascii?Q?g3KVwrfyYBeCJplvgbo+2m+1O8FP3GdAJ8Z/wOyDodSmsZ3QXjJyKrBFHHje?=
 =?us-ascii?Q?BPA2jBatxGHr+N9eEb2ELQIgFYxV/9Ve8U2Yu2XvaBP63gp412kAHO87Sl+W?=
 =?us-ascii?Q?ljvM8Maa4T2j/M247aZIxiOC5IbgrpeSGZZLpKg7Z1NpMu055tuDUXDl9VGP?=
 =?us-ascii?Q?MF93bYMsheYvwk8lMTnOde3oqDdQK+oUryl6LYIvJfzxf/C/hUvE6BmtWdUt?=
 =?us-ascii?Q?AYuRAV5I70chNTY3YnTzzkDrGh4k80OHopawIKdjbf5hrSXmtrfXAfWUQ25U?=
 =?us-ascii?Q?YdtAis+6GiKQCENpra+XhFsYocHBhfaszZJ4bqMm5KQ62UepjHqlqgvMeqFp?=
 =?us-ascii?Q?NSfEg3ReXtZUAdWZBCHCSDnGKV9YJW6/DNLpYzOwxyRHSeOiF18ndo+Et7Vq?=
 =?us-ascii?Q?ZET1cNTT+FqJUdCmq5p8J+7wwc8wIcSKd0uPmfLAqL5KO64Qh2oSuVSXKkqs?=
 =?us-ascii?Q?RXOrj8C9mwhi5kxWRYp+f2zVmDX0Ieyb31UOL0H3g4kRZvj15Gtl7m0VFM7W?=
 =?us-ascii?Q?HHP92MzeP6EHJIP9wlHtBIe74C0AI7eI6NTxybxLHx9vy8zLfK6DeD5I82gS?=
 =?us-ascii?Q?hfTDN6mCoyzxhRPRtZZu3F3wRcDBdRp2cqUebuK6GcetM34uAviALs8hCkQM?=
 =?us-ascii?Q?xG8s0Aqmdyq/UDq4T3P+PPU0g9xzxTEesV6aPE3ePylDjl2ATbtosS/hpRfP?=
 =?us-ascii?Q?e0Hyur/nxcStFDq3vlBKE254uUurW/xq4uwcJkLLzyOdi8x8nFYw1e9DywQX?=
 =?us-ascii?Q?L6n39o74YrS1emZCTZK0eOfXq2WdCzrskWtTQqeHRD+sPj+/urYZ+dZh/Bjh?=
 =?us-ascii?Q?v/+KjKvvK6d1afUhmymoWP9wZSKmU0oqbY4GOhd2PpgnWfIzP4lyfHeWbt2o?=
 =?us-ascii?Q?94EqnWtESg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ee7745-743f-49f4-ec93-08dedd52c0ea
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 00:41:02.9733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJ/yisO9tj8wKukfz4kw2B8jARzv69N+cyreslcpLn+JPdmZNmfjiSD/QHOtb4LHQXzrihfys5xYkAJeYkUnJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFB8FBD73EA
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

On 2026-07-07 at 04:01 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> On Mon Jul 6, 2026 at 7:34 AM CEST, Alistair Popple wrote:
> > diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
> > index 298c02bacb4b..855b6ffe696f 100644
> > --- a/drivers/gpu/drm/nova/file.rs
> > +++ b/drivers/gpu/drm/nova/file.rs
> > @@ -1,11 +1,10 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  
> > -use crate::driver::{NovaDevice, NovaDriver};
> > +use crate::driver::{DrmRegData, NovaDevice, NovaDriver};
> 
> Please switch to vertical import style.

Will do.

> >  use crate::gem::NovaObject;
> >  use kernel::{
> >      alloc::flags::*,
> >      auxiliary,
> > -    device::Bound,
> >      drm::{
> >          self,
> >          gem::BaseObject,
> > @@ -30,12 +29,12 @@ impl File {
> >      /// IOCTL: get_param: Query GPU / driver metadata.
> >      pub(crate) fn get_param(
> >          dev: &NovaDevice<Registered>,
> > -        _reg_data: &(),
> > +        _reg_data: &DrmRegData<'_>,
> >          getparam: &mut uapi::drm_nova_getparam,
> >          _file: &drm::File<File>,
> >      ) -> Result<u32> {
> > -        let adev: &auxiliary::Device<Bound> = dev.as_ref();
> > -        let pdev: &pci::Device<Bound> = adev.parent().try_into()?;
> > +        let adev: &auxiliary::Device<_> = dev.as_ref();
> > +        let pdev: &pci::Device<_> = adev.parent().try_into()?;

Actually I'd meant to drop this change as it's unrelated and was just me quizzing
my Rust undertanding :-)
 
> Nothing for this patch, but now that we can call into nova-core we can obtain
> the information from the pci::Device via NovaCoreApi.
> 
> The advantage is that NovaCoreApi can store the pci::Device<Bound> from
> nova-core directly, i.e. we get rid of the try_into() dance to obtain the
> correct parent device type.
> 
> Subsequently, we can remove this TryInto impl entirely. :)

That would be nice. I might add that as patch to this series.
