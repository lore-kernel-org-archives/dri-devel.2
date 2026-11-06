Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C7F606A32D
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OARTMpnc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D688E10E4AE;
	Fri,  6 Nov 2026 22:52:11 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF6B010E4B0
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 22:52:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ADA5760D09;
 Fri,  6 Nov 2026 22:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F911F0089F;
 Fri,  6 Nov 2026 22:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794005524;
 bh=NRJtjZhe6COOthmpVzgm2wGUmf0pbmHHsfeoCtwibtE=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=OARTMpncVGspn07uAf6Gv2Y//iYfaIfYprs8MVU8i/iVhNtD8XxKYi7fw/4Lnzb8c
 HJQocSQRjO5nwuNe6TyglHGIVtRsJ21gaW8eFnibkO9YIdkkbjIdej00Lp8/SttgI/
 MzL6GmV4SvOyobYM6Z7f+nYRrJyPoLf8mw8mpMgayKyBIeTtL1XzL5+CNc93SjMcKp
 nc2Pjelr5ptyQkSb6Z6MW5BJLaZ331jqfhstaWIe3fc3l2SuMHzx7lqQXVsqHPkswB
 RyYWTZ/WuygD20z4+OsJDLuZCflVqDFCcT/ady9kYxuyzYpc2xyXQb5tpa9bYajqwp
 BDt4fRZlSNROA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Nov 2026 23:52:01 +0100
Message-Id: <DMOHVQREU4JM.1A6IV5O5VMXKZ@kernel.org>
Subject: Re: [PATCH v6 0/3] gpu: nova-core: retain the GSP-RM log buffers
Cc: "vladazaharova2018@gmail.com" <vladazaharova2018@gmail.com>, "John
 Hubbard" <jhubbard@nvidia.com>, "gary@garyguo.net" <gary@garyguo.net>,
 "nova-gpu@lists.linux.dev" <nova-gpu@lists.linux.dev>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "aliceryhl@google.com" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>
To: "Timur Tabi" <ttabi@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261014154554.231015-1-vladazaharova2018@gmail.com>
 <b2ff5c437c41ba4f8c1a8f354d24d7e68517fbf3.camel@nvidia.com>
In-Reply-To: <b2ff5c437c41ba4f8c1a8f354d24d7e68517fbf3.camel@nvidia.com>
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

On Fri Nov 6, 2026 at 9:51 PM CET, Timur Tabi wrote:
> This tree is the future of rust-drm-next, and there have been some signif=
icant changes to
> debugfs that result in a lot of merge conflicts.

I know what you mean, but just to avoid confusion for people new to the
community: It's not exactly the future of drm-rust-next, but work that is
targeting to land in drm-rust-next in the future.

As for this patch series, it sits on my list of patches to deal with (for
probably too long). It also has been on the list for a couple of month now =
and I
don't think it should be delayed further, so I'll pick this up after some s=
moke
testing.

Thanks,
Danilo
