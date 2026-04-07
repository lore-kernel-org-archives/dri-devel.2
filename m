Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94597EDB7D0
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 23:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD16810E16C;
	Tue,  7 Apr 2026 23:57:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="SgXffdpg";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2572E10E16C
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 23:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1775606264; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=R3YWF25vxFLOaPUCphouJV1vLKGCvJ524FY46ZZcj7kH/YgU+xHUwBkMCYhh2SU3niHp8TRmYvqMIsY1kB49fXct74dIBkw68u3dtOkYdYSR/691dwEmfq/EKgqes4d9PN0CQgOcwFaR0FUBMfQnmkZsSrzfth/eeZEBdjIO0Fk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1775606264;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=iD15/kL9UhG3IU8+njReBYhiRN4L+NtrlP0ygQ1wmLY=; 
 b=lksdA8J4LPxJgg1cxHkBhxMfMkypK969jgyUtJgfGUIccg72szvsoo1OCAWQSneefMNYb0gTTERxQZoT+vldYS1w38Ev8jU460WtEwEJwD9suwT8qKEx4LdCgKKEgXCJzvRWJBN4pN2+XspxB6ZilpJ/UPFdadVkLCnP+705mRk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775606264; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=iD15/kL9UhG3IU8+njReBYhiRN4L+NtrlP0ygQ1wmLY=;
 b=SgXffdpgI1S/tXfW/vPkTu6g9olAOUJ5ZQzhmWIY8sa7Lqoo34cBK6sMpDW4rcSr
 HVriWXMUYLQbayX8S5bbrWSlxZWcC1jxTSsjJeJj+A5NB1xOV9p9wDRQp8LWwjkmssA
 L80d9jinZTT6xRu6CrXLQrraJlhQZWAMUWiZLslA=
Received: by mx.zohomail.com with SMTPS id 1775606261016293.84450662279414;
 Tue, 7 Apr 2026 16:57:41 -0700 (PDT)
Date: Tue, 7 Apr 2026 16:57:40 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 Boqun Feng <boqun@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Steven Price <steven.price@arm.com>,
 Dirk Behme <dirk.behme@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH v4 3/6] drm/tyr: Use register! macro for JOB_CONTROL
Message-ID: <adWZ9NBQQLh7UjmB@um790>
References: <20260402-tyr-use-register-macro-v4-v4-0-96a8d42f8bd1@collabora.com>
 <20260402-tyr-use-register-macro-v4-v4-3-96a8d42f8bd1@collabora.com>
 <20260403092759.5d9aabe3@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403092759.5d9aabe3@fedora>
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

On Fri, Apr 03, 2026 at 09:27:59AM +0200, Boris Brezillon wrote:
> On Thu, 02 Apr 2026 16:35:33 -0700
> Deborah Brouwer <deborah.brouwer@collabora.com> wrote:
> 
> > Convert the JOB_CONTROL register definitions to use the `register!` macro.
> > 
> > Using the `register!` macro allows us to replace manual bit masks and
> > shifts with typed register and field accessors, which makes the code
> > easier to read and avoids errors from bit manipulation.
> > 
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
> > Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> > Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> > Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> > ---
> >  drivers/gpu/drm/tyr/regs.rs | 58 ++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 50 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
> > index d0f99a433dfd1f55b855744abfe26ff9b429f179..54145d90d4922b895a6ebbbd2cda4fddb8488e1a 100644
> > --- a/drivers/gpu/drm/tyr/regs.rs
> > +++ b/drivers/gpu/drm/tyr/regs.rs
> > @@ -28,7 +28,6 @@
> >  #![allow(dead_code)]
> >  
> >  use kernel::{
> > -    bits::bit_u32,
> >      device::{
> >          Bound,
> >          Device, //
> > @@ -893,14 +892,57 @@ fn from(status: McuStatus) -> Self {
> >      }
> >  }
> >  
> > -pub(crate) const JOB_IRQ_RAWSTAT: Register<0x1000> = Register;
> > -pub(crate) const JOB_IRQ_CLEAR: Register<0x1004> = Register;
> > -pub(crate) const JOB_IRQ_MASK: Register<0x1008> = Register;
> > -pub(crate) const JOB_IRQ_STAT: Register<0x100c> = Register;
> > -
> > -pub(crate) const JOB_IRQ_GLOBAL_IF: u32 = bit_u32(31);
> > -
> >  pub(crate) const MMU_IRQ_RAWSTAT: Register<0x2000> = Register;
> >  pub(crate) const MMU_IRQ_CLEAR: Register<0x2004> = Register;
> >  pub(crate) const MMU_IRQ_MASK: Register<0x2008> = Register;
> >  pub(crate) const MMU_IRQ_STAT: Register<0x200c> = Register;
> > +
> > +/// These registers correspond to the JOB_CONTROL register page.
> > +/// They are involved in communication between the firmware running on the MCU and the host.
> > +pub(crate) mod job_control {
> > +    use kernel::register;
> > +
> > +    register! {
> > +        /// Raw status of job interrupts.
> > +        ///
> > +        /// Write to this register to trigger these interrupts.
> > +        /// Writing a 1 to a bit forces that bit on.
> > +        pub(crate) JOB_IRQ_RAWSTAT(u32) @ 0x1000 {
> > +            /// CSG request. These bits indicate that CSGn requires attention from the host.
> > +            30:0    csg;
> > +            /// GLB request. Indicates that the GLB interface requires attention from the host.
> > +            31:31   glb;
> 
> Any particular reason you didn't go for
> 
> 		31:31   glb => bool;
> 
> here?

No, just an oversight, I'll fix it in v5.

> 
> > +        }
> > +
> > +        /// Clear job interrupts. Write only.
> > +        ///
> > +        /// Write a 1 to a bit to clear the corresponding bit in [`JOB_IRQ_RAWSTAT`].
> > +        pub(crate) JOB_IRQ_CLEAR(u32) @ 0x1004 {
> > +            /// Clear CSG request interrupts.
> > +            30:0    csg;
> > +            /// Clear GLB request interrupt.
> > +            31:31   glb;
> > +        }
> > +
> > +        /// Mask for job interrupts.
> > +        ///
> > +        /// Set each bit to 1 to enable the corresponding interrupt source or to 0 to disable it.
> > +        pub(crate) JOB_IRQ_MASK(u32) @ 0x1008 {
> > +            /// Enable CSG request interrupts.
> > +            30:0    csg;
> > +            /// Enable GLB request interrupt.
> > +            31:31   glb;
> > +        }
> > +
> > +        /// Active job interrupts. Read only.
> > +        ///
> > +        /// This register contains the result of ANDing together [`JOB_IRQ_RAWSTAT`] and
> > +        /// [`JOB_IRQ_MASK`].
> > +        pub(crate) JOB_IRQ_STATUS(u32) @ 0x100c {
> > +            /// CSG request interrupt status.
> > +            30:0    csg;
> > +            /// GLB request interrupt status.
> > +            31:31   glb;
> > +        }
> > +    }
> > +}
> > 
> 
