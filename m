Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669D7CD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 18:03:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5B5010E7C8;
	Mon, 22 Jun 2026 18:03:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="o0hae2ys";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2ED210E7C8
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 18:03:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 15C20601F3;
 Mon, 22 Jun 2026 18:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AFB1F000E9;
 Mon, 22 Jun 2026 18:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782151400;
 bh=K/GYJViJI5kalk51JPq0XHrSMDJTiy0e7Kj99pwes9w=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=o0hae2yst0KDlG4ZR9ay16s4yZKGonAUKlyxERaHI50Xu5eRYE7b6dlmnHlmzig89
 yKTn7X32AcWjy9kHvnAbez/lEAXY6QS+BdrBz1Spw4aLIRX8wAEQFsAEDPAny4QzsJ
 zisUTkeZrZ3XUVaWrmAu9H0Ym17ozWWvdHKDECcB/fcaYFkp+nAizmD+jqp6Mn47Wt
 aojMJmVg+ULCQhWLdlKiCjHWZhdOF1VBsDN1rZLFeaC0pcywq+AE/BAS8918TvSGz7
 h+AkghBDZjAFWSZ8aGnm/lkF/qGUDxs6AJu+9uHA3JW1igbNigigWJobfO+gfDuPZH
 wl+/MmS2kIR0g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 20:03:15 +0200
Message-Id: <DJFRY0UZD7C0.37LIP9LNMBDLL@kernel.org>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <acourbot@nvidia.com>, <ecourtney@nvidia.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "Lyude Paul" <lyude@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v4 06/16] rust: drm: restrict AlwaysRefCounted to Normal
 GEM Object context
References: <20260620184924.2247517-1-dakr@kernel.org>
 <20260620184924.2247517-7-dakr@kernel.org>
 <f476b05e5d57c312230fac93c2a52f1cbe061376.camel@redhat.com>
In-Reply-To: <f476b05e5d57c312230fac93c2a52f1cbe061376.camel@redhat.com>
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

On Mon Jun 22, 2026 at 7:52 PM CEST, Lyude Paul wrote:
> Maybe there's a reason for you doing this I'm missing but, wouldn't it be=
 a
> better idea to simply remove the DeviceContext generic from gem objects
> entirely and instead always (with the exception of Ioctl callbacks, of co=
urse)
> just use the Normal context?

I did consider that, but left it as a follow-up, since it is not directly
related to this patch series to drop the DeviceContext from GEM objects
entirely and I thought a discussion about whether to drop it entirely is be=
tter
suited for a separate patch.

One thing I had in mind is that we could have TTM callbacks that guarantee =
us a
Registered DeviceContext that could be represented by the corresonding GEM
object. Of course, it could also be represented by a separate
&Device<Registered> being passed to the callback.

- Danilo
