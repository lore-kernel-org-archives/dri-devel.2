Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9C5CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27D0410E0F2;
	Thu,  1 Oct 2026 22:15:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RUl0CxW/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0458D10E0F2
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 22:15:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A768602C2;
 Thu,  1 Oct 2026 22:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143191F000FF;
 Thu,  1 Oct 2026 22:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790892928;
 bh=NAhv9wxrC8g2egKWlW7N85bHFAS2i3TPhgTSaxR5TtQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RUl0CxW/BxWnm7UNf6fb6I8spN+PZOGpyR5ACx5T5P0QsTG2S1MckTYwtXnt5jUwV
 rI1099RTbxU7MF3xZnFAPMU7L7Y2iLY2hLiNwHw7TIZ9kMaeT57vIcdZS8HH4eOXTJ
 cyu0CDahrTN3+v8VcDLAMwMFbkldxFWLpbGnqF12uMjqZxEGGIKR8qexh9Wug94MqI
 sErW4tHGtbulHyesYc7QO+aYkY/zhwY6xoHRPpcABZBGe1XDw3N1jfIvtzf2mI5Nsp
 pOMpDUuZpuBac2OX4M15+JW/WlbQm2ouq2bs/EO/k+QYuL3LLpQuJdhi6TnMt6OPGi
 bKOn8z2rgCW3g==
From: Danilo Krummrich <dakr@kernel.org>
To: Lorenzo Delgado <lnsdev@proton.me>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 0/2] rust: io: convert ResourceSize into a transparent
 newtype
Date: Fri,  2 Oct 2026 00:15:20 +0200
Message-ID: <20261001221520.2989982-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260927-resource-size-newtype-v4-0-447a08af23fb@proton.me>
References: <20260927-resource-size-newtype-v4-0-447a08af23fb@proton.me>
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

On Sun, 27 Sep 2026 18:11:31 +0000, Lorenzo Delgado wrote:
> [PATCH v4 0/2] rust: io: convert ResourceSize into a transparent newtype

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/2] rust: scatterlist: return u32 from SGEntry::dma_len()
      commit: 2581f023a5a6
[2/2] rust: io: convert ResourceSize into a transparent newtype
      commit: 7db73c69c831

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
