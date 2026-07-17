Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D7CC44516
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5CC110F50D;
	Fri, 17 Jul 2026 11:33:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iq42tPbO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3637710F518
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 11:33:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 92C0560A5E;
 Fri, 17 Jul 2026 11:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546FB1F00A3A;
 Fri, 17 Jul 2026 11:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784288003;
 bh=eIjS9piUmE57cYRXDTfna1Rukyb5JMZSPthrMyRy+dI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=iq42tPbOoZtO6nh+GKjVtUHfeIfHZK1bmON1BBNXij/itmb7LzRjjBIJY8GKdmjGP
 1JUZugohNu6nNjBQ3aato7NA94Hnl1Fngrs2kPfUVZvhy5/RcJ/q+HaW0sxbVW5SWH
 sb60zNG2UeU5cBwkdVxIJrxNQrz4rO88mC/vlk/zLOnm+uZ0JY+NoeqUn2ugpYXilx
 vw5TXrxruuDeqeUtA8m/+nR4R2eIyXaEMGkeji5naXwDFnkHgRtqN0TrY05ZeiAg3l
 P1wpDK2SXbmf9z22nXHLmBPsM6BXwmw/RJpng9h+X66d5J+c9Eil+Rs5SFgny6uA1C
 1/oEcd/H4t+0g==
Date: Fri, 17 Jul 2026 12:33:17 +0100
From: Will Deacon <will@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Jean-Philippe Brucker <jpb@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 maz@kernel.org, oupton@kernel.org, hch@infradead.org, jgg@nvidia.com
Subject: Re: [RFC PATCH v1 0/8] Arm Core Local Accelerator Driver
Message-ID: <aloS_T3LQvpHeZUV@willie-the-truck>
References: <20260717104759.123203-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717104759.123203-1-ryan.roberts@arm.com>
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

Hi Ryan,

I haven't bothered to look at the code (looks like Sashiko is having fun
with that), but I'm going to jump at this bit:

On Fri, Jul 17, 2026 at 11:47:44AM +0100, Ryan Roberts wrote:
> * User space availability: The kernel driver exposes the capabilities of the
>   hardware to user space. Arm plans to open source a user space driver, but does
>   not yet have any committed date. I'd like to understand if the availability of
>   this component will be a prerequisite for upstream acceptance of the kernel
>   driver; either way, I'm hoping we can at least progress with some discussion
>   in its absence.

From my perspective, I'm not particularly interested in having code in
the upstream kernel tree that we can't meaningfully exercise or benefit
from. I also think that the incentive for Arm to open source the
user-space driver practically disappears if we merge the kernel part
first. So, at the moment, this just looks like a burden to me, especially
as it appears to create a brand new, device-specific UAPI for what is
ostensibly a form of SVA - something which the community is actively
working on already.

Relatedly, is there a spec and/or fastmodel/qemu (sorry...) support for
this?

> I'm deliberately constraining the scope to bare-metal support for now.
> Virtualization is something we are considering (and have prototyped), but plan
> to post a separate RFC for that as follow-up, once we have agreement on
> direction for the bare-metal driver.

I'd actually like to see what the virtualisation part looks like first
because doing it as a bolt-on later feels like the wrong approach. The
structure you have at the moment is remarkably clean, given the
architectural/CPU interactions (this thing even apparently builds as a
module, nice!), but I'm unsure how far you can push the separation once
you need to start hacking at KVM. Maybe the MMU notifiers are enough,
but I can't tell.

Will
