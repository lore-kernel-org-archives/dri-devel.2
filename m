Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3EFC624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 840B110E293;
	Mon, 31 Aug 2026 14:41:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VCqugcng";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 317FB10E2B7
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:41:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 00B21404EB;
 Mon, 31 Aug 2026 14:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5275D1F000E9;
 Mon, 31 Aug 2026 14:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788187309;
 bh=FgIb2siZsPSomjaTwvmt8zr4SEcbvg2+qR6QFbqzAE8=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=VCqugcng/IwD9wYujSc6GO4vIJ3UGy0Y9DDgx7oxQdjePynImVtwT6FJCTFQ3krfh
 RFfpTv/Z1XwehqEbKHRmbn0HZLB7jGhg3V+pepsNJW+o8Xc8+g5gNqoR6wc9Zz4Fdi
 Sd0f6IlrIzhNCqGsjStifcZLS2BN580CU8zkePtyyIlC3v0VNKy8y9mFM8Tw+LtnY2
 skc1Th5iYoQoCI8t/TEvi7wLTvD61hkcp1BcUd6gLYjRhSqDRjO5RJpdA3scKUFUyc
 E0m+pPTwwaMeeJR2fZ+cB4bnuJDs+tOqyHqH2jpxsJULm6jzoQxaKYLNr/mIWVyMM+
 adZmQLkOggPoA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 16:41:45 +0200
Message-Id: <DL37HVMJQP2U.126BSJ2S51HI0@kernel.org>
Cc: "nova-gpu" <nova-gpu@lists.linux.dev>, "M Henning"
 <mhenning@darkrefraction.com>, "Alice Ryhl" <aliceryhl@google.com>, "David
 Airlie" <airlied@gmail.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v5 10/11] drm: nova: Report GPU short name in GPU info
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-11-apopple@nvidia.com>
In-Reply-To: <20260828033531.1117754-11-apopple@nvidia.com>
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

On Fri Aug 28, 2026 at 5:35 AM CEST, Alistair Popple wrote:
> Add the short GPU name to the GPU info structure.
>
> Signed-off-by: Alistair Popple <apopple@nvidia.com>

Same as patch 9.
