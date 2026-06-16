Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F935CD98D2
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 07:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDB8F10E8B7;
	Tue, 16 Jun 2026 07:57:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="sqD53vPp";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4618110E8B7
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 07:57:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpeqJsqyku3LVTwESMZzHzgKEg/iwIiLliEEn80ReZXvWkiWGLnRvroJDfFDo2ks9MnKXgqD7hsW4vMF8fOoHiKw9XKxDZwMusvDtYirptYztTRmNEN/53t+jS7tKAR/kvc+dGbiUB2hVv2lYtPnQ8WK/DFHtPgcSkVIEKmtvC5Tq+Vcmf3hP5koOS1PcFZIhCuk/mJ5JVTRbbMljjWJAbHa0+RF9ZrTwZIOY5my4a0XlOOfs+8i81UPAOGe0P5g6x4Z8f39xspUFZMco8DNLCMLdQd8sJ5WSX3E00dOODBSd2pm4GdJ9hvPZGCDBmZasgmWANGwKjXBCtIHtcbwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMve4dBvO37MYLJ+4+tPP6nhvZAuTp2Iv5C3soVNAjs=;
 b=sg2CU4LrIEID98idhhL6CMZrDGmEqa5uyEY9Hs32Hdg1hr1wjS2DwcrUzxkVTFqpsqX2Eyb6eFJKZKy/b3MOG9OTECbaldgF0CRtpW3dLngkpfch+TZ/aQjMyiD3Hny4deJ2XZqbTGLqcVMwPAsIfXf7Hpz4vnXkvzUIt0XdL1AZhfwWXTpYw/wUIX17v/m0u41+vGfrptvCkf5bc9mDiGhEl22DK1w1UXvXDqGARcOUAiVuWMrpjdIrCksIXGtIJMxx3T91qk5T9COHE3edLNtur/z3NZEJDGLE/WZrP4Z4qG6sEBpUAoqRqE+U9xgwre1r0Il4sK3wUZd9Pagq9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMve4dBvO37MYLJ+4+tPP6nhvZAuTp2Iv5C3soVNAjs=;
 b=sqD53vPpWh8/kQ9mf5kU+NvFvE9dEMScTKTtW+OYQMZkBAVNStnz9h2xdh5qpm2R4iMSA9aa2ib/pYrsNNuM/q7wpPlxMqAnv6s3O6BdnwzBkD8ktSxU3HLSTwOkZx4U/SecA43Bv3camqnlPjdwPRLlbIZYRuIyqhR0rLMMzOPXnpEy50I9zZqGmTSfv2sw0sYAv8tV9o3OpYt/nHN/jGrmcHbezfPDA+5j2y+2PwsbDR5YlfRlUn+gpvkbRKLLIxzIVdnt/dlsoHAbwqMwqNwYa4LKhhvld68bE3/lC3D0ed6q09WMriqZ6ftUpdOUhV35w36Hasp+FQpdHWHBaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 07:57:42 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 07:57:42 +0000
Date: Tue, 16 Jun 2026 17:57:37 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Gary Guo <gary@garyguo.net>
Cc: Eliot Courtney <ecourtney@nvidia.com>, 
 Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>, 
 John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 02/13] gpu: nova-core: fsp: catch bogus queue pointer
 issues
Message-ID: <ajD-8-bp6Usjl56R@nvdebian.thelocal>
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
 <20260615-blackwell-fixes-v1-2-f2853e49ff7d@nvidia.com>
 <DJ9SJCIX1XUO.RTFCL56MKU0D@garyguo.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJ9SJCIX1XUO.RTFCL56MKU0D@garyguo.net>
X-ClientProxiedBy: SYCPR01CA0048.ausprd01.prod.outlook.com
 (2603:10c6:10:e::36) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4195:EE_
X-MS-Office365-Filtering-Correlation-Id: 28abd6f4-866d-44a0-2caf-08decb7cf1b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|366016|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: WumcmpDED0JSRscQNEU4E1DjD+FayBrO4Vs+XBJlwg6UCeoyumtWFCebdNQXdM0SyRnF5lY4+WCEvtBEcTWdShlXRFB6D/Q4r9wEhUBi8h1ZIDBs+1fUD+AVbjytSExxCQgdW/tEYa7JXl+un08pzdU6xPJ7XvcOzXsYPrsasS+hBjl8NPPLWwKzteffUDrzPrFbw6AKxJJpPOaq7RyA6KIUhzgjcmuWZv9CvtwtpD9P41vUiKpeYCZsxV5qYtINI4cWzchXHkJgRLbICWmXtbqRGlTNczO0RHHmvO8oqL/hbOTrDLZr9kYoIIVz378s5qK1aDTd8LKFlz0qb/YeXMOqKs76f0H4iHphEb3MiDfQ3kLla6WzuMCmLQFJtivrGfSatbo1btbeW/Mor4EtCnroAo/vMjm8jNARkAFmbYEBcePdfGYwno3WdwNfLPuBuxa7vbMKYc3IIgOv5iGLM91V4HPyE7dAZaFZ/V0kSltnPuOF9wSKvV0YrVt8kdGlTZ3G0UDDPKejZ/JdznzidOKWWZpgxMxwBKpRo3WA54FoqcMVyfBbdP3rsQKlQsk/wreVNxF8hYm1yLHvnK6XUKZLQDQJ3tlnuwL0N+X/tZMWzCIWxtoFgOxR4ASA7geuSiHIxCzIicg96NqalSxuAMdv8mXciBICJrj91xnApC1thQDuDYeSTsBVoNVoHISK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XTorqzKYty1j2IZmMQqUZxnrT9nWsQ16qLolzlaXhjvqZu0wA7zYtImI599u?=
 =?us-ascii?Q?maPRWXnM1Mn2piuOzFdmWzpSjdpQecPUwsvR+LkyAUnrSgVOMM4k1LB3aoR4?=
 =?us-ascii?Q?bgcG+zJVWh7eNTVTiXcnfE3nzgI4TWNe816WLNzoZhchC3TY5gAwFk8ooYAU?=
 =?us-ascii?Q?nN3M1jov4J+ctXev0y7A44BvVIeMmpUqb9OHpdvmKZLBzoTRiinvDd4OuHCz?=
 =?us-ascii?Q?d2xaKPsL8phLfiWymq18HhNoxYjQG7xrOgiFaCUDupLj7IhdoJkcy3c+yDX2?=
 =?us-ascii?Q?wh+zTlHDqekrfVqF+h++HyP3UpDFi8CbdPevtyDQe7odfFi7nsJMiiNDJgcA?=
 =?us-ascii?Q?LjQh5QlMDwBq1A9WoyyhmXXv57B2n9kALdir7RUwjSf7JEfRmmyCFSOdcqh7?=
 =?us-ascii?Q?YkGPnttvsw2i1AoMSV1fwx0mhUpFMQ8BiSAaPy79mdgQQGc8YFOnU1BzOoNx?=
 =?us-ascii?Q?KHv35CtMkWa3pYbCIYaEKWXDVmpEwMNOfzrdsVOJKjlyXCz+H7Sm51HwfPDt?=
 =?us-ascii?Q?obthrpzczpC50KiNAfwR9xWkVpjOdyIV0atddRarSFgBiZXDfqT+DbFSE/H1?=
 =?us-ascii?Q?4HogCaE5yEizjgvLCAUWLhha/Y/YkpGeT3xwQrBdGFLWwWIlbeDMdb/Lg/rz?=
 =?us-ascii?Q?eQaB1ydQrzDmp3Yi9KXvhvGrSwRGqOcGgkCqAX83x1tFSvfbujp+yQvTlVDH?=
 =?us-ascii?Q?Z/OGsytCsa3g13NgzgYnHTRD3tgYlX8aVmzcaxgs/TgCYLAExkizfL67wOGI?=
 =?us-ascii?Q?GeF/NR5SZ7zcox0R588Vi/82v0VEoz5gzfhWFHgvf9IQcZirL5p0pEKmQn6i?=
 =?us-ascii?Q?IWyHbx8ySVefRk4K0ytw73s+3jayMVXso59wXqb0A+y9yHLKX1Bqt/l6fVl0?=
 =?us-ascii?Q?yB3lgsUCzrRdS9SHMtI6B0jrAaMO8k4xQ888ZnQsStsMCLzzd6KvZSNIvVLB?=
 =?us-ascii?Q?LQCdkpXEx/peR3ybLSvGmTwQLm+/Lm0qcIEa5WF0Vap2tRSvhM3mgEszsTNm?=
 =?us-ascii?Q?PCScNKNGjLPtCIt5pYyePpH/O+uIklHytjLhwfhOH8l3873x0oACHzXBGB3f?=
 =?us-ascii?Q?NwV+9pnYyRxwUiryExjHvr5Wd6KhwiofsHoJgbSNDFenspV6FDAVobSD2ypv?=
 =?us-ascii?Q?Jbj8ACM2r/suwFvc1AnYr3YY7r8bcfTBbTXGpZSTj2Oz7a9KeIS/MPPjnxfN?=
 =?us-ascii?Q?YMHrmdUurbQadh5/vYgWU0NZKpHdBtA0B6oaHH7/tAfA5jWxWkFtMMt6OB+Y?=
 =?us-ascii?Q?gfrkJp9Wy4ESQkgVUlNH540hBUQBzJG5b8/llYkCimdFDBEwkiNAnHSBFTI0?=
 =?us-ascii?Q?EPt4O0ViFSdoomBRwYGxmos11ENl4NcbLA55X+F+NjUxN6vlm1evzFc4YlOp?=
 =?us-ascii?Q?MvX3guIeP5bG/J4otRC7Ydiytod1za7noTTsYlcNml4Xy7dT50LEuxjgZPPa?=
 =?us-ascii?Q?nArIXxM2m5n09oQk6xLnpPX2XvsuR4vvsALNXqkTMlojILtkzwcDIYsLDzfu?=
 =?us-ascii?Q?Bg+Ax3KnFS+W+JG8l0mj9uSddpTHz7aaS7ofBx8EUTAFmZg28M2bs78yg3mO?=
 =?us-ascii?Q?BwFgay2Xl2mtNcGWQrZTUdBaKq9WxEMA7cLo5Jk72k0Zt0gjKRLK0mR4PkUh?=
 =?us-ascii?Q?gekwcoLMmy/SME9I9WmP7jT1Mi7IdN8MqoL7UK4VBMqJovv+zWXSLrRrmwWG?=
 =?us-ascii?Q?Jxg3ln/sJk9S6otll6WbHlhsZMWlCh6vXcXr0jmBagFaxAukj6dqa7v86g41?=
 =?us-ascii?Q?074wRVbNJg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28abd6f4-866d-44a0-2caf-08decb7cf1b2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 07:57:42.6090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghb/hBjpFMhXkZr9PtCUWYD8K427JLTF+uWtx0IitOdDpjbuB5p4Dq0HvQvTFU/CVgDM4DiXIIKC9iL+OWoHqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195
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

On 2026-06-16 at 03:15 +1000, Gary Guo <gary@garyguo.net> wrote...
> On Mon Jun 15, 2026 at 3:40 PM BST, Eliot Courtney wrote:
> > Currently, `poll_msgq` will report a message of size 4 if the queue
> > pointers are broken. It's easy to catch this if it occurs, so have
> > `poll_msgq` return an error in this case.
> >
> > Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> > ---
> >  drivers/gpu/nova-core/falcon/fsp.rs | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/nova-core/falcon/fsp.rs b/drivers/gpu/nova-core/falcon/fsp.rs
> > index e7419a6e71e2..21eaa8e261ce 100644
> > --- a/drivers/gpu/nova-core/falcon/fsp.rs
> > +++ b/drivers/gpu/nova-core/falcon/fsp.rs
> > @@ -107,19 +107,22 @@ fn read_emem(&mut self, bar: Bar0<'_>, data: &mut [u8]) -> Result {
> >      /// Poll FSP for incoming data.
> >      ///
> >      /// Returns the size of available data in bytes, or 0 if no data is available.
> > +    /// Returns an error if the queue pointers are bogus (`tail < head`).
> >      ///
> >      /// The FSP message queue is not circular. Pointers are reset to 0 after each
> >      /// message exchange, so `tail >= head` is always true when data is present.
> > -    fn poll_msgq(&self, bar: Bar0<'_>) -> u32 {
> > +    fn poll_msgq(&self, bar: Bar0<'_>) -> Result<u32> {
> >          let head = bar.read(regs::NV_PFSP_MSGQ_HEAD::at(0)).val();
> >          let tail = bar.read(regs::NV_PFSP_MSGQ_TAIL::at(0)).val();
> >  
> >          if head == tail {
> > -            return 0;
> > +            Ok(0)
> > +        } else {
> > +            // TAIL points at the last DWORD written, so the size is `tail - head + 4`.
> > +            tail.checked_sub(head)
> > +                .and_then(|delta| delta.checked_add(4))
> > +                .ok_or(EIO)
> 
> Whenever we fail with this, we should print a message (actually, the same thing
> probably should be done for patch 1 as well).
> 
> A plain EIO is going be very difficult to troubleshoot if this is ever hit.

I don't disagree with the sentiment - this is a problem through out the kernel
and I have spent way too long tracing where exactly error codes have come from
both in C and Rust.

But it seems odd to worry about these particular instances - they _should_
never happen or at least be extremely rare and very unlikely by an end-user.
More to the point though there are many other places in nova-core (and I'm
sure other drivers) where this pattern of just returning a fairly generic
error code exists. So it feels like it would be nicer to deal with this at some
other layer, eg. some kind of debug option to tag error codes with location
or something.

So I'm not opposed to the comment, but maybe it would be better addressed as a
separate question/patch series to figure out how to do this error reporting in a
more generic or consistent way across all of Nova at least?

 - Alistair

> Best,
> Gary
> 
> >          }
> > -
> > -        // TAIL points at last DWORD written, so add 4 to get total size.
> > -        tail.saturating_sub(head).saturating_add(4)
> >      }
> >  
> >      /// Writes `packet` to FSP EMEM and updates the queue pointers to notify FSP.
> > @@ -154,7 +157,7 @@ pub(crate) fn send_msg(&mut self, bar: Bar0<'_>, packet: &[u8]) -> Result {
> >      pub(crate) fn recv_msg(&mut self, bar: Bar0<'_>) -> Result<KVec<u8>> {
> >          let result = (|| {
> >              let msg_size = read_poll_timeout(
> > -                || Ok(self.poll_msgq(bar)),
> > +                || self.poll_msgq(bar),
> >                  |&size| size > 0,
> >                  Delta::from_millis(10),
> >                  Delta::from_millis(FSP_MSG_TIMEOUT_MS),
> 
> 
