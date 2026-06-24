Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97C7CDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 18:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4077610F034;
	Wed, 24 Jun 2026 18:06:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bGwmU8r2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4957F10F034
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 18:06:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7B50060018;
 Wed, 24 Jun 2026 18:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663D21F000E9;
 Wed, 24 Jun 2026 18:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782324373;
 bh=CWV2CodazpVWAzDgOY+6xdyScP/u+sw4Ii7YvacgkJQ=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=bGwmU8r25CyiS49E2J4yixw3fklzXhkreiNNGZCZJLrHEjUOrLHHgH2HzUKaZXD/T
 PdlNtWGc0Enj3hv4vYppf//zdQvDwHFs7g919BDTTbB3CDI4HGWEyo0bO9oOcWBbGB
 A4kzpbRJ6xuyfGyHmcSXFeaZTterFr//fT7MYJNcEONMoPQMdQbSgR0jLp8ay1ezQk
 4LZ0nwzRg/GFAIykoqSOqUtAdoXecWRq5ceqXxyHwUM00RD5xtmDxnF0Jt+EZ2L9WU
 mTgrY8NCMIx3VhOO61atxi3U9Wux+gNCIsQOuu09D4VHacGs8X7fNcDJ8iKtoMJLMC
 5N3MznGMNHk4w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 20:06:06 +0200
Message-Id: <DJHH9AKHNQ3C.3K4CWFQE5P3NU@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <acourbot@nvidia.com>, <ecourtney@nvidia.com>, <m.wilczynski@samsung.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <daniel.almeida@collabora.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pwm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 2/7] rust: types: introduce ForLt base trait for
 CovariantForLt
References: <20260618230834.812007-1-dakr@kernel.org>
 <20260618230834.812007-3-dakr@kernel.org>
 <DJHDQ7X94BXR.2XYSWSK79USDB@garyguo.net>
In-Reply-To: <DJHDQ7X94BXR.2XYSWSK79USDB@garyguo.net>
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

On Wed Jun 24, 2026 at 5:20 PM CEST, Gary Guo wrote:
> This is still unsound, as I mentioned in the last version that the prover=
 must
> be kept.

Heh, I think I just forgot to finish this up, good catch!
