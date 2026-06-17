Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0178FCD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 04:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A1ED10E926;
	Wed, 17 Jun 2026 04:31:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sufsdo7N";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71CB310E91A;
 Wed, 17 Jun 2026 04:31:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9yLYld9O36N3mzHrXrasW9D+MBLK6KesGQBkW8Vgjprm7rslXZEvOtHdJO10Y8vhjJ8Hpa1tLcrkke4j0kPuVyFSWwuMtJbp1WLCTSgmG4C3bfqq23Lt72frcv0kXvpfiGOiHlRIpR2O5pGsI3WEOijoWQkvHFtUPlSbuSIQ0XMbgpWWbi/GLU/BBhwvm98agX6HHF5GzefoZX+npRlU8Q97ULDEE4kbxwO16ZZ9Za5lmTvf/XA1Q8jAP+VZ51R2jpT2eD9+rjbmjjXF2WRXwfUsMqm31DnRCoJe8cBiLQzwEOHFcfRA06u6T+DOoyXkLeaVCjxg/LKMyoeuuq2KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHi2zCpBOnDA6kwVUaTAuXaYCTXS2E9sC+wvJFLRsTU=;
 b=IcTBIUBFQGJpmbhRECkpW4pBKk9gDCS/yYbT/IQv4CGZs6l+6NLNHRatVNqSY5kV2KgQalVFGK64CkYgrRZaGYU1L9F8GUyOskg8+ezymOaAUazBKwVkRnUz7wfFicTVAxZIMMGzjBIJPp5n7a+qKk6La7NV+qcFzl23QAoRswegp4SOs/4znEMKXHxH8+hNHBq+bJl45HBPZGHESODttKl74bCrah4yMZ6GWf08ZI/QRUeRu+EGaQHWHm0eLgMxuVh3xOP/y/jQbIn0XRfw0YXd4jCK0jQq/MnC3XFfkL/cZEpVDZTu+dXYvmU2vjWuKvSnPpdP1tO9pYPUVNP/kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHi2zCpBOnDA6kwVUaTAuXaYCTXS2E9sC+wvJFLRsTU=;
 b=Sufsdo7NoMPS8PNKyQo0sKWp3Y1fE0Fab3bIDMWDwaP2APSptSCexW7FmKbi1VGS/TleRnKLrWWN2D9FgdPIAXnBbBVz8b6vKdJmFsuq47tbfJLBECYce7uz3hl72I5JZ1Joh0TvZ5YvbkCwktnuqb4g05nAHjmm4V7fcCbUhM/HY74AWhsm1LxCC6xGE6KU7VNn3oUgYZXPtxI4OcXizZ3ooqpGHi4gy6e427FckFQBaPNOtChrGLe5x21HFNIqPRXEfuLNGxoinD/sFFYY/paU56oCB7RU9K/2TSEgNugycaaBA8zigMSmLDBQE3vX4NO6oFXUNN6/HGCjiKY9vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB6234.namprd12.prod.outlook.com (2603:10b6:208:3e6::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Wed, 17 Jun 2026 04:31:47 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 04:31:46 +0000
Date: Wed, 17 Jun 2026 14:31:40 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Gary Guo <gary@garyguo.net>, Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 02/13] gpu: nova-core: fsp: catch bogus queue pointer
 issues
Message-ID: <ajIgJh5JgWyI-jsS@nvdebian.thelocal>
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
 <20260615-blackwell-fixes-v1-2-f2853e49ff7d@nvidia.com>
 <DJ9SJCIX1XUO.RTFCL56MKU0D@garyguo.net>
 <ajD-8-bp6Usjl56R@nvdebian.thelocal>
 <DJAF4F8GJIWM.14MO2JWGG7OZM@garyguo.net>
 <DJB0OWXDA3SA.2C7C24RNJY2LQ@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJB0OWXDA3SA.2C7C24RNJY2LQ@nvidia.com>
X-ClientProxiedBy: SY5P300CA0036.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fd::8) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ffd4904-e950-43fe-e763-08decc295744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|56012099006|6133799003|4143699003|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Yq8W9rly/36x5WBXuxKFPrvBN4kzjeLCj2MWAYMy5dfN753hFuMvg5HQ2FsZCV53ZFRZMhrVmrBp6adeK1bhQ9DmNbiyqLD0CFGuka108076elX30m+yTMM7g+/B/rM872z5htRvIKXwsEo6G6MpbP3cdQw/ctXEMSTqwk4JCxK7NX2l2DEI/OKPdR766poxzkAp3+mBxTQFV8QomT+hMi3B8lry1hr8gjQVvJ4O2xl5xDkI22QVFEK0n01AajqeIYVyEbWT71gsQS73WKkIeibv/9FYPoO/gYZ1sftyqGmHQ14eXTc/rHohuJ75iq/SvRxThSVtqFmrM3wzTg+7bH5AQ3jOKesI9gQtvUDZG3ifJiR5L7XiURsenAjpsBD4tFEmqSdG4l46UCE43y/WabM6u32T14lTC83hifLbYgS3+s3VstRXwqjE0ZwDWwLZAY0Ys+6H4cN8C4RZeq2YuAMU7axMiWm9JOhgvawo8g9/lAruxLNM2JZfAZs62QZAm5V37LrmcuF1n8dKyBToOJEyfkP469LXzPeeLk0h9p5Jebx0LKc8i4JozX5z6OkV2SLncybmc0+vtKcSuXGomzD96MCikwW7XkLcyv6OBqACkykQviPojQdZArxOD5hcP9C53TVMpFbsI7VI4fkOxNz1kXwlgONzGk9IVXc92DWHyD5S095HomLbopGwhR6N
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(56012099006)(6133799003)(4143699003)(11063799006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gLxNA6ijJVZEde+4h8sHbdIK/YBGPy7pz1lYyRnwqzEa831rt+XGf6uE2IGS?=
 =?us-ascii?Q?Bkm9PXP8XPFUWGcEEEs1tl3BEeB+3rxuJhUF67KstOZcW+BxTWAxvCrO5otY?=
 =?us-ascii?Q?beEMVS2/d/m0u+HxHzynv3x3ZqRMYbnlStCZ8Cee53mTKBg8tPUeG2Vn4ve2?=
 =?us-ascii?Q?yDJ/y92F9rtsSmhAnoUH/zmZ30jQjjFt2hEf9CHa4OMZMd0KNTr8pmHiKukv?=
 =?us-ascii?Q?Uw5X2wOw4sIUn3dzsz3REzJqyyJ0BxR1xVxtOy1j34XcnE4tI/DHwBdByhmi?=
 =?us-ascii?Q?w95j08tBiSuYZBe49RGnsvHqVTmtI7cw5m02IZRtBqZt10ZzheqKvA4wKvGq?=
 =?us-ascii?Q?kuW+uDZkCf8Zrp0VAbFb03hbFyaqV0uGgbuoojfufxk32fjNJlSm864dnxWR?=
 =?us-ascii?Q?F3C1Y1vwUw6vUiptEFeYoNH4Ozx5YFvQWijbqiRfsgYmG1J+ooOdstCHNCMI?=
 =?us-ascii?Q?DJUfgElzqwj+kxH3zlkhKENr9YUwxwSK7OVJ975I95xVmdqU9aySyXlQTq93?=
 =?us-ascii?Q?/NJ22LGGy/DpuvRzky3DDjP59/9f+ICDyd3KJdSqSbQId46gvHCPZV1W8ET9?=
 =?us-ascii?Q?/hQtyap8fPRx67jwb8M/inJ8eJadhpnzmXR6IhhbkvyUO8ecPMuSJBxucnwd?=
 =?us-ascii?Q?jAgWQCgqbQQUxEyufB5ucIQoMMBXru+f2aW5wVSP1Ox98OLBuCR6GrBiUyJJ?=
 =?us-ascii?Q?fVi9soEwV0cb2C3wD/P6eIoilI1P1VZ35XDeiY8BQ0e+ZLa9Ref/95GOYm0F?=
 =?us-ascii?Q?KLVyPzOjTcGj1qARLQ6b5jgTpMFYaiKxYPDSUgdMO/InOVJCbkXA5Si9zqdw?=
 =?us-ascii?Q?WZ3yKX9oQC3NUu5c16tGHNaCDaC+PK8MjEUS1fCDaIjOwjj1r5snplUCvkFA?=
 =?us-ascii?Q?EDR1iuZhG8K8ftZ/MTAOGplss8fdrCFFYd5KoQpbNofulw8NDyGm3cKo9Pue?=
 =?us-ascii?Q?l07bP6L9/8uzIxTmH22gqq4HFEztmouAp/TgWRrk0Bt1KVtP92LYWTKkQ/yX?=
 =?us-ascii?Q?+48x9QZxdG8nAegyIV8U4sUB1i6mpt9MC4AKs7bGBdNVMLq2IMu9xvQuUKkW?=
 =?us-ascii?Q?daQxCRlnIoKNXgkWsOSaq+AnggkhL4cICEN46eTW5IKwlWyiu71qRQAvJoH/?=
 =?us-ascii?Q?TK8aR33Fu83MBfcqO7C+/21bo6y3qwPtcduHxJaXQFQvRbjVDH2bp8xabguX?=
 =?us-ascii?Q?+wbevs+LK869LQJlGl7Hif77+EJmv8QHgAFI2QN4wgfygbFnSJxVAMWtzIlz?=
 =?us-ascii?Q?0y9UtqHLRnGNWMYDyrLtQ/EpbFWajgaL9YER+6jUolca7DiwJP8648tpcazZ?=
 =?us-ascii?Q?CkWk1EwVvk1rKgcduuvdB9HF73Xa5AlICyfwvNSVSPNuKefYdVGQP2xEVbpd?=
 =?us-ascii?Q?n9DjpIXhKJC/9ha1uO4xY0scCcnKPh3ycoBXtSGSrmp44ruSj0IZWEohUIYz?=
 =?us-ascii?Q?tDGsvofQzoBsrP3jmcA/kOtOppPel+PP0qo6m9klzMqXW3FIJpTsZAMNiBOM?=
 =?us-ascii?Q?bEZqKUd4hvKZQh1InP/Q0GKyqjRkGeoHFJL57ppMJrq0THU01l2XfrZGuAzI?=
 =?us-ascii?Q?L0/mkWrCNNmundk8sg0vd8SGjp48LndNytLaDVe9H/sSCFv5CTma11Q0/9kt?=
 =?us-ascii?Q?9hSDYHy30eMmm8uhnmsui5Akwabj10YDAqerZ/N2yL8km8FIPaCRRVTqKStg?=
 =?us-ascii?Q?/r4uG4s898KmILC/vutI4hTX4xh3ceLZw+aVmjLksDWBFb+IaZK2WSpd6dOw?=
 =?us-ascii?Q?fabFaVIQ1A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffd4904-e950-43fe-e763-08decc295744
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 04:31:46.6988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9AYywdzPtahXIIgNgnTTeFI+Cq91zOZ4zp18TykrNKDxawskWyu4NTc7uCRD2vaDnz1O9AIlf0x+4+ksClFcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6234
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

On 2026-06-17 at 13:51 +1000, Eliot Courtney <ecourtney@nvidia.com> wrote...
> On Tue Jun 16, 2026 at 7:57 PM JST, Gary Guo wrote:
> > On Tue Jun 16, 2026 at 8:57 AM BST, Alistair Popple wrote:
> >> On 2026-06-16 at 03:15 +1000, Gary Guo <gary@garyguo.net> wrote...
> >>> On Mon Jun 15, 2026 at 3:40 PM BST, Eliot Courtney wrote:
> >>> > Currently, `poll_msgq` will report a message of size 4 if the queue
> >>> > pointers are broken. It's easy to catch this if it occurs, so have
> >>> > `poll_msgq` return an error in this case.
> >>> >
> >>> > Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> >>> > ---
> >>> >  drivers/gpu/nova-core/falcon/fsp.rs | 15 +++++++++------
> >>> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >>> >
> >>> > diff --git a/drivers/gpu/nova-core/falcon/fsp.rs b/drivers/gpu/nova-core/falcon/fsp.rs
> >>> > index e7419a6e71e2..21eaa8e261ce 100644
> >>> > --- a/drivers/gpu/nova-core/falcon/fsp.rs
> >>> > +++ b/drivers/gpu/nova-core/falcon/fsp.rs
> >>> > @@ -107,19 +107,22 @@ fn read_emem(&mut self, bar: Bar0<'_>, data: &mut [u8]) -> Result {
> >>> >      /// Poll FSP for incoming data.
> >>> >      ///
> >>> >      /// Returns the size of available data in bytes, or 0 if no data is available.
> >>> > +    /// Returns an error if the queue pointers are bogus (`tail < head`).
> >>> >      ///
> >>> >      /// The FSP message queue is not circular. Pointers are reset to 0 after each
> >>> >      /// message exchange, so `tail >= head` is always true when data is present.
> >>> > -    fn poll_msgq(&self, bar: Bar0<'_>) -> u32 {
> >>> > +    fn poll_msgq(&self, bar: Bar0<'_>) -> Result<u32> {
> >>> >          let head = bar.read(regs::NV_PFSP_MSGQ_HEAD::at(0)).val();
> >>> >          let tail = bar.read(regs::NV_PFSP_MSGQ_TAIL::at(0)).val();
> >>> >  
> >>> >          if head == tail {
> >>> > -            return 0;
> >>> > +            Ok(0)
> >>> > +        } else {
> >>> > +            // TAIL points at the last DWORD written, so the size is `tail - head + 4`.
> >>> > +            tail.checked_sub(head)
> >>> > +                .and_then(|delta| delta.checked_add(4))
> >>> > +                .ok_or(EIO)
> >>> 
> >>> Whenever we fail with this, we should print a message (actually, the same thing
> >>> probably should be done for patch 1 as well).
> >>> 
> >>> A plain EIO is going be very difficult to troubleshoot if this is ever hit.
> >>
> >> I don't disagree with the sentiment - this is a problem through out the kernel
> >> and I have spent way too long tracing where exactly error codes have come from
> >> both in C and Rust.
> >>
> >> But it seems odd to worry about these particular instances - they _should_
> >> never happen or at least be extremely rare and very unlikely by an end-user.
> >
> > I think we should either consider it possible and add prints, or consider it a
> > bug (hardware or driver) and add a `WARN_ON`, or consider it impossible and not
> > add failure path at all.

I think we have had this discussion previously for Nova and we settled on
progagating errors even if they are "impossible" because programmer mistakes are
always possible, even when trying to reason about an error being "impossible" :-)
 
> I am new to this, but IIUC it's normal to guard against
> hardware/firmware bugs - currently, for this error case, we would try to
> create the `FspResponse` in `send_sync_fsp` and print an error "FSP
> response too small: 4" without this patch. With this patch, we would
> output "FSP response error: EIO\n". I think the latter is marginally
> easier to debug, but both you would find it pretty quickly looking at
> the code.

Right - there are plenty of other "impossible" error paths in Nova where we just
return an error without printing. I don't see anything special about this case
that warrants treating it differently.

If we do want to solve the problem of the cause of return codes being ambiguous
or difficult to debug then I think that should be done as a concerted effort
across Nova or the kernel. I don't there is much value in doing it ad-hoc in some
places and not others.

> I am not that opposed to adding a print, but it seems low value to me,
> since it's very unlikely this will occur and we have a print in the only
> calling function right now (`send_sync_fsp`).

I agree - I'm not totally opposed to a print being added but I think it's low
value especially given we don't consistently do that now.

> I think the semantics are clearer with this patch (no need to reason
> about what happens when the saturating sub + add are hit).

Yeah, patch looks good to me so:

Reviewed-By: Alistair Popple <apopple@nvidia.com>

> >
> >> More to the point though there are many other places in nova-core (and I'm
> >> sure other drivers) where this pattern of just returning a fairly generic
> >> error code exists. So it feels like it would be nicer to deal with this at some
> >> other layer, eg. some kind of debug option to tag error codes with location
> >> or something.
> >
> > This should happen whenever the information is lost. Creating a generic error
> > code would be such occasion. Handling it at upper layers is okay if the
> > information is kept for longer. For example:
> >
> >     enum NovaError {
> >         ...
> >     }
> >
> >     impl From<NovaError> for Error {
> >         fn from(err: NovaError) -> Self {
> >             // Print here
> >             EIO
> >         }
> >     }
> >
> > Would be fine to me because the information is emitted to user when it is lost
> > by the concrete error -> error code conversion.
> 
> It feels very odd to me to have a From implementation have side effects
> (printing) although I agree semantically with the "information is lost"
> idea.

It's an interesting idea - maybe not a print directly but some kind of debug
tracing infrastructure that would allow us to see where exactly an error is
first generated. It's actually something I've thought about before. But IMHO
that's a separate concern that could/should be dealt with independently of this
particular patch series.

 - Alistair

> >
> > Best,
> > Gary
> >
> >>
> >> So I'm not opposed to the comment, but maybe it would be better addressed as a
> >> separate question/patch series to figure out how to do this error reporting in a
> >> more generic or consistent way across all of Nova at least?
> >>
> >>  - Alistair
> 
