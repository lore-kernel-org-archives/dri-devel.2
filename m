Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65ADE10F286F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 20:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDC3B10EF72;
	Fri, 27 Mar 2026 20:58:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tD/f6+1h";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DAB910EF72;
 Fri, 27 Mar 2026 20:58:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C770406C2;
 Fri, 27 Mar 2026 20:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA31C2BC86;
 Fri, 27 Mar 2026 20:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774645120;
 bh=6jlUKI5SJaZ0+SeYdeQprWB7R4mJ7/L6ni+8RY3kuyU=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=tD/f6+1hibZ3IBUmKE7XL9cFeHAFRcnB5DyJyH14mdqqiHaza2YHRG8pjd8jyHFTr
 7xTcoF05LC9gsSp6YLwhwqHT0uefzvsc4697RIdXqKAsm6UlRq58PqUKUANaGL6qLF
 ZnwVt3Ot8TU8a7i1zge4q9n8rNMyBambKldhBHU5qp8N2Xnbhjl9iXjqI4EYIrv8gw
 Q/uB7Q6XBW4EznkgU7TYbPRU+fKLjOsDxwY7HbsHpeceBx/fBwRIXj4sHoid4rHBx7
 Lra2U+Ee0qR63jfEdgPUaAd2sF7m+1cYYTSAyBEMFrdERgt3aj2LHL4Q9vHsXuOc4C
 VnO0KlFvnL7vQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Mar 2026 21:58:34 +0100
Message-Id: <DHDV6UZK4LB0.1P98SCT5CMJMZ@kernel.org>
Subject: Re: [PATCH 2/3] rust: dma: generalize BinaryWriter impl for
 Coherent<T>
Cc: <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, "Danilo Krummrich" <dakr@kernel.org>
To: <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <abdiel.janulgue@gmail.com>, <daniel.almeida@collabora.com>,
 <robin.murphy@arm.com>, <a.hindborg@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <tmgross@umich.edu>, <ttabi@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260325003921.3420-1-dakr@kernel.org>
 <20260325003921.3420-2-dakr@kernel.org>
In-Reply-To: <20260325003921.3420-2-dakr@kernel.org>
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

On Wed Mar 25, 2026 at 1:39 AM CET, Danilo Krummrich wrote:
> Generalize the BinaryWriter implementation from Coherent<[u8]> to
> Coherent<T> where T: KnownSize + AsBytes + ?Sized. The implementation
> only uses size() and write_dma(), neither of which depends on the
> inner type being a byte slice.
>
> This allows any Coherent allocation with an AsBytes inner type to be
> exposed as a debugfs binary file.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Applied to drm-rust-next, thanks!
