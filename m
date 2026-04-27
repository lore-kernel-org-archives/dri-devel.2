Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE9CFF885D
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 00:18:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60EC210E230;
	Mon, 27 Apr 2026 00:18:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jS+NNRL6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1FF010E230
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 00:18:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CB6FE60138;
 Mon, 27 Apr 2026 00:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28EFC2BCAF;
 Mon, 27 Apr 2026 00:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777249079;
 bh=/IYygXAoENKbgEqtgqis7Wk6FfD7Ekordvwh+V5T9s8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jS+NNRL6OIyFXDcuKX98Ej7+D1O1cRA/ueskRCYRO5jbdQ1rsEw8kDexkLGMiV7Qy
 US9nYXLTxiwgvLiLImv0q6ui41YAegLfHtEasnBx22dJWkyrLB2WEs3e3yP8QKr42q
 tGFLu8R2DZgp56sb5x2g2sauMVAhkdXzyfKxhwS8/llIDGZGuO2raTg519KiEtHEbe
 2CgTfixs9eURqudlcYLkUxKAur+zZJL7s8zb5Xy+h5SyeYACPRIUAeAqMuWRpKzwfy
 5A6cJY7o4Fm+kq618IPGi10+iqHd5CLrvPWgifCVxNLdZe8Tm6rDBi2FE0BG7xw71O
 NA2HWz5WIvIqg==
From: Danilo Krummrich <dakr@kernel.org>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: dakr@kernel.org, aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, daniel.almeida@collabora.com, lina+kernel@asahilina.net,
 lyude@redhat.com, j@jananu.net, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/1] Rust DRM build fix
Date: Mon, 27 Apr 2026 02:17:50 +0200
Message-ID: <20260427001750.1559562-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260426094725.2188668-1-mkchauras@gmail.com>
References: <20260426094725.2188668-1-mkchauras@gmail.com>
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

On Sun, 26 Apr 2026 15:17:24 +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> [PATCH V2 0/1] Rust DRM build fix

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/1] rust/drm: import ARef from sync crate
      commit: 5f69165b7e42

      [ Add missing Fixes: tag. - Danilo ]

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
