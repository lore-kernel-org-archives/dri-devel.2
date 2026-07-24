Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE8BC531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 05:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74BF110E449;
	Fri, 24 Jul 2026 05:34:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SNzYsZ3T";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DE1010E449
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 05:34:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C2CC3600AA;
 Fri, 24 Jul 2026 05:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C551F000E9;
 Fri, 24 Jul 2026 05:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1784871270;
 bh=yJpgQxTxm4jDRN2KRYXe9Fu81fij2GnkQjQHHYhOqwo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SNzYsZ3TdjAbEcgLuUgRZio7co1q1Mo6e2TCphJ9fHDRHddzKwvJfKKKnSuQWGRwc
 6mryL5UrbvXSFq+ACzQ4CtfeaWurAXHBQSAIy26VubpSD8Nvlj3gZ56IEbd8ODmw0r
 6/5yFdSVIqErRvJTAdhlOb67Ja19dEHqvqBzX0Jg=
Date: Fri, 24 Jul 2026 07:34:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Markus Probst <markus.probst@posteo.de>,
 Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Kari Argillander <kari.argillander@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Boqun Feng <boqun@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v16 0/3] rust: add basic serial device bus abstractions
Message-ID: <2026072414-dedicator-canopener-9d85@gregkh>
References: <20260718-rust_serdev-v16-0-5809384d2e1b@posteo.de>
 <20260723205912.3441137-1-dakr@kernel.org>
 <DK69583TKES2.2ECSGER5Z77I6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DK69583TKES2.2ECSGER5Z77I6@kernel.org>
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

On Thu, Jul 23, 2026 at 11:01:17PM +0200, Danilo Krummrich wrote:
> On Thu Jul 23, 2026 at 10:59 PM CEST, Danilo Krummrich wrote:
> > On Sat, 18 Jul 2026 15:33:09 +0000, Markus Probst wrote:
> >> [PATCH v16 0/3] rust: add basic serial device bus abstractions
> >
> > Applied, thanks!
> >
> >   Branch: driver-core-testing
> >   Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git
> >
> > [1/3] rust: add basic serial device bus abstractions
> >       commit: 99f59aa82341
> > [2/3] samples: rust: add Rust serial device bus sample device driver
> >       commit: 4b2c9156d312
> > [3/3] MAINTAINERS: serdev: Add self for serdev
> >       commit: 6b71fef6f05c
> >
> > The patches will appear in the next linux-next integration (typically within 24
> > hours on weekdays).
> >
> > The patches are in the driver-core-testing branch and will be promoted to
> > driver-core-next after validation.
> 
> Greg, since I've dropped it from the queue a few days ago I've now picked it
> back up.

That's great, thanks!
