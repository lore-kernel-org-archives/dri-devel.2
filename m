Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A521EC531CC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 20:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F31E710E5F4;
	Thu, 23 Jul 2026 20:59:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BYwSWiPw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B7C10E5F4
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 20:59:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 29BAA600B1;
 Thu, 23 Jul 2026 20:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFF91F000E9;
 Thu, 23 Jul 2026 20:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784840360;
 bh=5QlEtEB+KlYv+DW8jPCkBOH+68EPaADuCoS5PEm6aZw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BYwSWiPwuqD2kKCxGI2pr+TIGSE1pyF9pR6pHr23oOs9oOumzQ6nBN6YCuQT8d6qw
 scZe05tKL4XuEY4HRmVNBoM6ZCj2jiCNUebtZPIMnFozom1Sp3/5mK3JBuWY6Bmdgi
 slR32XwX0O+mdL+z+toFqIb/sbMBqxAeZmFFd9j1oK02JB3SDIvdy+61g5+71H/MP4
 0gd7tr5rTKqEl7i0qpu8hpCNFSxfHwpqDAcruahIoj1v2IlXEqluHKuNNhjEHj6kdU
 DK9cvbawwnr9JcuOpk8INMLDjagyIF8kPiHoQHjqZuK4oQAtj29ej+kR8Om+d6VXoK
 WbcqFtWsoh8eA==
From: Danilo Krummrich <dakr@kernel.org>
To: Markus Probst <markus.probst@posteo.de>
Cc: Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Kari Argillander <kari.argillander@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Boqun Feng <boqun@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v16 0/3] rust: add basic serial device bus abstractions
Date: Thu, 23 Jul 2026 22:59:12 +0200
Message-ID: <20260723205912.3441137-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718-rust_serdev-v16-0-5809384d2e1b@posteo.de>
References: <20260718-rust_serdev-v16-0-5809384d2e1b@posteo.de>
X-Patch-Reply: applied
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On Sat, 18 Jul 2026 15:33:09 +0000, Markus Probst wrote:
> [PATCH v16 0/3] rust: add basic serial device bus abstractions

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/3] rust: add basic serial device bus abstractions
      commit: 99f59aa82341
[2/3] samples: rust: add Rust serial device bus sample device driver
      commit: 4b2c9156d312
[3/3] MAINTAINERS: serdev: Add self for serdev
      commit: 6b71fef6f05c

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
