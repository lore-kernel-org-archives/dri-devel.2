Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D5C606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DeH+Fv5m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59FAA10EA7B;
	Wed, 11 Nov 2026 15:44:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B046710EA7B
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:44:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 279BE429D9;
 Wed, 11 Nov 2026 15:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18B81F00A05;
 Wed, 11 Nov 2026 15:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794411842;
 bh=ld4XtXK2SQe+LqDkNkGzQrapNgCtkHSKWE+dahSdXTg=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=DeH+Fv5mAMeLLg/J+R9mfE7F4/t0xvH8wO6g2P7seRNnqSJIpTnX/oASqbOQ/+dD1
 SA2LMDjRVaXwN/K5z6Q3+BsgXMUBtWa7BPQOw9K7P3UnzPD2GTODEuvgKTFtQ9oMs/
 j/kk53uAet017VgJ9rNq7XGTOn9h9MolMaWGGyWYbkV/daEGTrUwS4euT0BYHUQhZb
 /tK3eoRGLWn27cGr+ElPot9GR6bh1xwpToBtNf+BDSYxv5Hk6uYQyGo2L071WEbswQ
 1P1uyNzoAWVhMUDD+5DnojfwjgRYnI/lF4Ztqfr4QUj/E1M77mSg3OpxKhCpluwl6G
 bRXhBmWlgsrAw==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 16:43:58 +0100
Message-Id: <DMSHWQDVXVD5.H1UNOAA8I6XB@kernel.org>
Subject: Re: [PATCH] gpu: nova-core: use pin-init self-referential support
Cc: <acourbot@nvidia.com>, <aliceryhl@google.com>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <lossin@kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261110152746.140351-1-dakr@kernel.org>
 <DMSCIQ1NOV15.383LSC2I0TMON@garyguo.net>
In-Reply-To: <DMSCIQ1NOV15.383LSC2I0TMON@garyguo.net>
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

On Wed Nov 11, 2026 at 12:30 PM CET, Gary Guo wrote:
> From the changes made related to GspSubtree and other types I think I'm m=
ore
> inclined to just make `Cmdq` lifetime covariant using existential lifetim=
es.

Hm...this would also get us rid of the need for the existential lifetime bo=
und
on NovaCoreApi. At least for now.
