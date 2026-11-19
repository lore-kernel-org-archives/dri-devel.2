Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88638606A326
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oLNmNWtJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D007711242B;
	Thu, 19 Nov 2026 13:57:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B07811242B
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 13:57:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0AD184078E;
 Thu, 19 Nov 2026 13:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C631F000C5;
 Thu, 19 Nov 2026 13:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795096661;
 bh=+JT0h6/LQKzOu/59CAf7m9l8pTm3b7Vc3i+I/Y4m4GI=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=oLNmNWtJqQkZZfLwzkUWs4mib3sQJV8ReTrErMtd1T/ximqSWlZ7T7s4Ri34l69j9
 hGkyBQBjRRimwrk+Tuvz/dsvPYesXWGt9aF3aHidteIAtRbaYsQS8I2eQJNFSeJt1D
 2G+uTRw0wa4qRKniYRb2B0PFWvFK4Yz4fwgoWEgMPCZPnK3FA2PIU+FOMlz2Rv7z+n
 ZFnrX+9ul23JUWLpAWxOzvKcjYem+L891mdjCuigh1n6UkKSsLy2MexeOqPvJybGVx
 g1h/hxrKdrX4FAgQmfsNMgI+zIZNFCqxFIILHR+F1wKX3rm9x/beBiKlGyJA+lnYW1
 A27ibuUtDuJfA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 14:57:37 +0100
Message-Id: <DMZ8NNSPL36I.15O2JQR7M65T0@kernel.org>
Subject: Re: [PATCH 1/4] drm/tyr: name resource lifetimes after their types
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <lossin@kernel.org>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <tamird@kernel.org>,
 <acourbot@nvidia.com>, <work@onurozkan.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261118233727.3147222-1-dakr@kernel.org>
 <20261118233727.3147222-2-dakr@kernel.org>
 <DMYTKRS80NRC.18PBQHK9SZ8K9@garyguo.net>
 <DMZ4C3GGD9U0.360KJBSFLEK61@kernel.org>
 <DMZ5HM326EKD.1I8KUFD65L91Y@garyguo.net>
 <DMZ6RL5X2UXE.33EY9MDLO2AJA@kernel.org>
 <DMZ7CHWBWU4O.3EA040FFBVCLG@garyguo.net>
In-Reply-To: <DMZ7CHWBWU4O.3EA040FFBVCLG@garyguo.net>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 19, 2026 at 1:56 PM CET, Gary Guo wrote:
> If a rule is to be established, I'd rather it being the following:
>
> - for invariant lifetime parameter, use the name of the borrowed resource
>   (because you know the exact lifetime).
>
> - for covariant lifetime parameter (especially if multiple resources are
>   borrowed and the lifetime is the shortest among those), pick a generic =
name
>
> - for covariant lifetime parameter referencing just a single resource, I =
think
>   either is fine -- (as long as it's unlikely to be used by unsafe code t=
hat may
>   assume that it covers the full lifetime, e.g. 'bound).

I think in the end it comes down to personal preference, so this is fine wi=
th me
too.

Though, I'd use a generic name in the latter case too, such that it doesn't=
 need
to be changed once a second resource is referenced later on.
