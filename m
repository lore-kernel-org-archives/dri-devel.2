Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EAFCD13D3
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 19:59:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB0EE10F440;
	Thu, 30 Apr 2026 19:59:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D37FyE44";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 443A910F440
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 19:59:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D89ED4321C;
 Thu, 30 Apr 2026 19:59:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A84C2BCB3;
 Thu, 30 Apr 2026 19:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777579140;
 bh=LBnU4AivRmdyKTS0Xcm7sAN9nbgjFQEu0IgaPDtNX8A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=D37FyE44Yvvn2cExwQ3DmwgarHkzu8WUVgaowMhD+LmI77+KXzdBK44lKtn+fFUgO
 bDSpV9CoNJi+BNPgdd0UKnu4ogxf1eb7bKc3aQbAkOGlv1S0uL1gaj47H4jPYZGD6F
 ELGMa2Wzsk/mtTY92+5Ti3XPzZXWHt9gxb3Qe/WyFzeVbTCM6GeA+HIN1/HGJ5L3OL
 jAMGMxkf/Y5mCzAdwHsIGTNRCYNHpJi/prLhuFyMoP3cAGZI83iFkM8L7ZClWRXRz2
 W2CedreT/+hzZYdFf/jLgPz08IQck7uK1kQPtbXn8J0GMY1oTCQv1ZhHnUPsntX0hj
 iUkbOn6Q6Y2wA==
Date: Thu, 30 Apr 2026 14:58:58 -0500
From: Rob Herring <robh@kernel.org>
To: Markus Probst <markus.probst@posteo.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Kari Argillander <kari.argillander@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Boqun Feng <boqun@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v7 0/4] rust: add basic serial device bus abstractions
Message-ID: <20260430195858.GA1650658-robh@kernel.org>
References: <20260429-rust_serdev-v7-0-0d89c791b5c8@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-rust_serdev-v7-0-0d89c791b5c8@posteo.de>
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

On Wed, Apr 29, 2026 at 08:21:30PM +0200, Markus Probst wrote:
> This patch series adds the serdev device bus rust abstraction into the
> kernel.
> 
> This abstraction will be used by a driver,
> which targets the MCU devices in Synology devices.
> 
> Kari Argillander also messaged me, stating that he wants to write a
> watchdog driver with this abstraction (needing initial device data).
> 
> @Rob: Are you willing to maintain these rust abstractions yourself,
> as you are the expert on this subsystem, otherwise I would take care of
> it with a "SERIAL DEVICE BUS [RUST]" section in the MAINTAINERS file. In
> the second case, I assume you are going to pick those patches as-is into
> your tree, after they have been reviewed?

Well I can ignore the Rust part as much as I ignore the C serdev part... 
Honestly, I need to find someone else to maintain all of it as I don't 
really have the bandwidth. I don't think we should split it though.

And I don't have a tree for serdev. Greg picks up the serdev patches. If 
the Rust folks are fine with them, then I am.

Rob
