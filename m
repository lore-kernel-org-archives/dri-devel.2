Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A683606A334
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XBN881Uo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A55010FAEE;
	Wed, 11 Nov 2026 11:15:09 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E239510FAF8
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 11:15:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0E67763C95;
 Wed, 11 Nov 2026 11:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23161F00A05;
 Wed, 11 Nov 2026 11:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794395702;
 bh=tAx/ZFlsqXKWFenehZ/MbbfKdZYuT66fnAo6orVBCkk=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=XBN881UoloAl+qdmKmPVrH4Sn4mrZ+nDx2hDHv8pvgq3leTwmjlP2OasxRSnWu6j3
 uHEogUzELOrIsIZghOIZKs4GSyulW+2Vib3GHirLE8fCWtj758itIRfrnuLNvnyoLs
 nq5Bf3G4qrFaKndvZZVT+FHiYQ/FVdQyfCWhnYeCImhzuagHE6tnxBPQxfV/Zc1gfu
 qF4dSMTJrPHA/KKdiAyL9eDe/xhrDf/4/eH09PJ7xsaZvvTUFTwSzo5K6/GhrtmZ4e
 KUXb/5YEClBabd5qR9xw31E3v/SiKbKwxaPazwx4mFeOSPFjrF6hgosYbJYCJjNUbp
 Qw/BuuECr9HXQ==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 12:14:59 +0100
Message-Id: <DMSC6S86RQ85.36H8JJYBI79L4@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] gpu: nova-core: use pin-init self-referential support
Cc: <acourbot@nvidia.com>, <aliceryhl@google.com>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <lossin@kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
References: <20261110152746.140351-1-dakr@kernel.org>
 <DMS93G8MYB71.3HF96QRH1AUN@garyguo.net>
In-Reply-To: <DMS93G8MYB71.3HF96QRH1AUN@garyguo.net>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed Nov 11, 2026 at 9:49 AM CET, Gary Guo wrote:
> On Tue Nov 10, 2026 at 3:27 PM GMT, Danilo Krummrich wrote:
>> Express all self-referential borrows through pin-init's self-referential
>> support [1], replacing unsafely derived references.
>>
>> Cc: Gary Guo <gary@garyguo.net>
>> Link: https://lore.kernel.org/all/20261008-dev-selfref-v2-0-e280b3c8fba5=
@garyguo.net/ [1]
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>
> There is already
> https://lore.kernel.org/nova-gpu/20261019133647.1279779-1-gary@kernel.org=
/

Ah, apparently this one has fallen through the cracks on my end, sorry.

> It doesn't include GspSubtree though, I suppose that is relatively new?

Yes, it is.

Given that this patch already covers it, mind if we just keep going with th=
is
one?

Thanks,
Danilo
