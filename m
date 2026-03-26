Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1982C10A88E1
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 15:56:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6920E10E971;
	Thu, 26 Mar 2026 15:55:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="P01XFaBa";
	dkim-atps=neutral
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com
 [209.85.128.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DA9E10E971
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 15:55:58 +0000 (UTC)
Received: by mail-wm1-f74.google.com with SMTP id
 5b1f17b1804b1-48722073bd2so5907895e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 08:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774540557; x=1775145357;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=92aI30dHVxWTjN/LfnKmLTPU0BYok68bxkN3Q6QaYwI=;
 b=P01XFaBayi/miGCnvwWycYnyGNUHry+CEvKtvA06k2iL0Cxnuox9hANFlMs5kGC8f5
 DzXCjZG+NXFppEp11yN0RL8MDv5QLZ2/bsEX63Y3sTikmuASY8wXhVXjFEvyj7mEzhBU
 BUZe1i/6IQxRojruWxa9iUnz0SdL6wHf0a8o2Xw/THPtwGnsMG2Ev3+zLuAcaCN9hDUf
 F0FdUWTTyjZ/lPeRoXe6H/XbC2fc36SGl0HTmkNRPNUYphNfMvqU4H3VjnWLmDEgmSeL
 QuEv+sdY/10EdMzw+TOlWzE0wVTr2EWQQQl8vEFkBVRMrPpAHLA2/1Q9aJvUvSfJn0RJ
 ORFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774540557; x=1775145357;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=92aI30dHVxWTjN/LfnKmLTPU0BYok68bxkN3Q6QaYwI=;
 b=aHe0mqrHDE7riNUizUPFL2IhM6YdBi0ayw294dO6wDqxaVBZDL+TvsZgRG9LV5Xpit
 dMzUo2t2ikeergRFnTWasFpicrFuRE+jOYltfuWnCfA7ps6qjtW77WNujvWALEgwKyFs
 E7A91dSv1zozTq7hDgRcuCHACmN66nfWaCUjpfL33pC2adql9Uwuo7qpmPJls+JnF3XO
 2siiuwvg/xqD1KVDKrOujRekKWULezORYY0GwpgSW7coFKlfeORiACc6RrOAf4/Fw5ki
 J7LR8pY4dayR96QsrBTY/Xnx39PXnHT/mOuOngedomax1+gD1Rt6+54rkJYjEAsI3C4D
 tq8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr2Y/RpZAO11en0CBwRc2BMxoAwtmx9MhUBF1GsmZLcNefvT89OAQae5hmZcoS9tUuV/1XSNyczLk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhwUK3vK4aSE1uYhhOzGFNZw/2OPkvcLUzDX/S26P38uKtu4hO
 yN7Znbk8GG6m715R3oyEYHIMPMnokwZRrdxbkTrCNPHKVXvedT/YLOBhigLeCoghBGrZLs82ZY2
 drFfMRDMdfD8hMiwifQ==
X-Received: from wmbh25.prod.google.com ([2002:a05:600c:a119:b0:485:2cf0:2668])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b85:b0:487:12c:e7ea with SMTP id
 5b1f17b1804b1-48722ba914dmr32054575e9.5.1774540556778; 
 Thu, 26 Mar 2026 08:55:56 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:55:55 +0000
In-Reply-To: <DHCP6NB4HWXT.2L5XXIX1HNPRY@garyguo.net>
Mime-Version: 1.0
References: <20260323-cmdq-ub-fix-v2-1-77d1213c3f7f@nvidia.com>
 <DHAB9Z571FPB.25927BK1RGNGL@garyguo.net>
 <DHB3CGY1Z5HF.1KSJV8SP8YD8A@nvidia.com>
 <DHB40HKJD3OC.OMC04LASMS4G@garyguo.net>
 <DHCFJSHKE4ZB.3M1FFI3K5R670@nvidia.com>
 <DHCG03J1G63T.1A973DEM7DHQ3@nvidia.com>
 <DHCP6NB4HWXT.2L5XXIX1HNPRY@garyguo.net>
Message-ID: <acVXCzMaykipt9Dx@google.com>
Subject: Re: [PATCH v2] gpu: nova-core: gsp: fix undefined behavior in command
 queue code
From: Alice Ryhl <aliceryhl@google.com>
To: Gary Guo <gary@garyguo.net>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alistair Popple <apopple@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
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

On Thu, Mar 26, 2026 at 12:03:31PM +0000, Gary Guo wrote:
> On Thu Mar 26, 2026 at 4:51 AM GMT, Alexandre Courbot wrote:
> > On Thu Mar 26, 2026 at 1:30 PM JST, Alexandre Courbot wrote:
> >> On Wed Mar 25, 2026 at 12:15 AM JST, Gary Guo wrote:
> >>> On Tue Mar 24, 2026 at 2:44 PM GMT, Alexandre Courbot wrote:
> >>>> On Tue Mar 24, 2026 at 1:44 AM JST, Gary Guo wrote:
> >>>>> On Mon Mar 23, 2026 at 5:40 AM GMT, Alexandre Courbot wrote:
> >>>>>> `driver_read_area` and `driver_write_area` are internal methods that
> >>>>>> return slices containing the area of the command queue buffer that the
> >>>>>> driver has exclusive read or write access, respectively.
> >>>>>>
> >>>>>> While their returned value is correct and safe to use, internally they
> >>>>>> temporarily create a reference to the whole command-buffer slice,
> >>>>>> including GSP-owned regions. These regions can change without notice,
> >>>>>> and thus creating a slice to them is undefined behavior.
> >>>>>>
> >>>>>> Fix this by replacing the slice logic with pointer arithmetic and
> >>>>>> creating slices to valid regions only. It adds unsafe code, but should
> >>>>>> be mostly replaced by `IoView` and `IoSlice` once they land.
> >>>>>>
> >>>>>> Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bindings and handling")
> >>>>>> Reported-by: Danilo Krummrich <dakr@kernel.org>
> >>>>>> Closes: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@kernel.org/
> >>>>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> >>>>>> ---
> >>>>>> I didn't apply Eliot's Reviewed-by because the code has changed
> >>>>>> drastically. The logic should remain identical though.
> >>>>>> ---
> >>>>>> Changes in v2:
> >>>>>> - Use `u32_as_usize` consistently.
> >>>>>> - Reduce the number of `unsafe` blocks by computing the end offset of
> >>>>>>   the returned slices and creating them at the end, in one step.
> >>>>>> - Take advantage of the fact that both slices have the same start index
> >>>>>>   regardless of the branch chosen.
> >>>>>> - Improve safety comments.
> >>>>>> - Link to v1: https://patch.msgid.link/20260319-cmdq-ub-fix-v1-1-0f9f6e8f3ce3@nvidia.com
> >>>>>
> >>>>> Here's the diff that fixes the issue using I/O projection
> >>>>> https://lore.kernel.org/rust-for-linux/20260323153807.1360705-1-gary@kernel.org/
> >>>>
> >>>> Should we apply or drop this patch meanwhile? I/O projections are still
> >>>> undergoing review, but I'm fine with dropping it if Danilo thinks we can
> >>>> live a bit longer with that UB. It's not like the driver is actively
> >>>> doing anything useful yet anyway.
> >>>
> >>> I want to avoid big changes back and forth. We could use raw pointer projection
> >>> today, which could be fairly easy to convert to I/O projection:
> >>
> >> Thanks for the diff. I have adapted it to work on top of Danilo's
> >> suggestion to compute the end indices first as it works just as well and
> >> is cleaner. I have been running into a link error with this conversion
> >> applied though - let's discuss that on v3.
> >
> > Mmm, I guess this was because the optimizer could not prove that the
> > slices were within the bounds of the command queue as the expressions
> > passed to `ptr::project` were too complex with that version and this
> > makes the `ProjectIndex` check fail. I have better luck when doing
> > something closer to the diff you pasted.
> 
> I'm considering switching the projectiong `[]` syntax to become panicking
> instead, given that the slicing use case quite often is indeed hard to prove
> (and also, we already have panicking comments).
> 
> One option is to just change `[]` to do that, another option is adding a new
> `[]!` syntax to denote panicking projections. I'm more inclined to just the
> first one to keep consistency with Rust slicing syntax, but the second one is
> okay to me too.
> 
> Thoughts?

IMO you should just use [].

Alice
