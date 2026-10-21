Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243D7606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=k2XrJv+J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 711F710E03C;
	Wed, 21 Oct 2026 20:11:42 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 641D410E03C;
 Wed, 21 Oct 2026 20:11:30 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4971340E029C; 
 Wed, 21 Oct 2026 20:11:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
 header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
 by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id tE1uR1tM0KkD; Wed, 21 Oct 2026 20:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
 t=1792613485; bh=vQk51gmPv+LBlBEbVBQXQRvGpjkGw4cKMh26T2Gdvvo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k2XrJv+JTvqMvl2DTYYFZL4ga1deL0puF8VQie06yUPSeXb+Mxp9On9Fy8v4WlVb5
 UkKUtJxm6Md8A7mNC63GLXQcEGTlqiMMWMxRV7cICbRSXerxgtzCJwwtLuPdj3HkFW
 OVcXCEnVNdT8mOhCRkmyHEsvlMrcjoK0L6Q4tnUBoUvDhDDrp/3rqFDKzqkhCKUkm4
 UO1HyrEbqkUfqGZdcnEPSqDMu991Df3uN5d1MADQpH3Uy7aCK0PGQwnFD740dpAWdc
 hbkPdHiTgwxCF1/aFnsy2ko5SBZsU8ZOgV843zzkFxi8Ovp8WqmofiWI1bhfjeXOKm
 aYsGDPF/p3pf3BLRGiPJegHz3EJ5Zudl70gl9akq1+uCyDbznt+LCgCAcKOgjH2CNZ
 1jaQYg71Ffij6FfSarO+CYzFU96HJt3JyBvY+3794bvy09tG0Y2Be8j0bGKl8BipYG
 RGKnpjLPOJIyAKDOz/u/Hy0Prfx/rt9AixtNtb27ZgYa76UbPC4ZW3359vSA9LzGjc
 ccNYWdlJtKo84fPy3g4U2ZMjFzlh044CK/QeUyjDc83DXwkL89vVYzCS2kpcSw5Lx8
 6/i9iVtTgQ4xegP42VAEp2X8eItLyZQh0jL2hze69Xpt473Ft50E+mCuW1r9lIAIsn
 SXtwAHNQaKzpCZ+W/RrJN15c=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest
 SHA256) (No client certificate requested)
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8594640E00DC;
 Wed, 21 Oct 2026 20:11:09 +0000 (UTC)
Date: Wed, 21 Oct 2026 13:11:06 -0700
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Joerg Roedel <joerg.roedel@amd.com>, "Nikunj A. Dadhania" <nikunj@amd.com>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Removing __get_user / __put_user for good
Message-ID: <20261021201106.GCatkcWhRWnARw6bfH@fat_crate.local>
References: <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
 <CAHk-=wipGHx_1Uztmu773yuTM2ka1fq996UmNoJpvKS0gqEdMg@mail.gmail.com>
 <atdqUYdIOqmiqqTt@gmail.com>
 <CAHk-=whrUi2M+whqwS8yfqZ=W9ts6NPOzxzGfBOwOfCC3ooeMA@mail.gmail.com>
 <CAHk-=wjFBSH9M2GYKRnd-jrMGaa-gPBoGhuscJAu4n1hGsuX7g@mail.gmail.com>
 <CAHk-=wj51-syPoqMBLnxMeLnsbCMDMXfKzKZCtOHhwWEk5DeRw@mail.gmail.com>
 <20261021025403.GAatgpS1rcSTOTs8sS@fat_crate.local>
 <CAHk-=wgDm1nHurWJLESiLeYr0_0yv_F7W8YbvrmMEfbhxM1e_g@mail.gmail.com>
 <20261021184317.GBatkHxUL2xqH9EUkY@fat_crate.local>
 <CAHk-=wjs-DWseqMLciovdLmhcs5xhksPGOZRCoXK_sr8tmEiKw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjs-DWseqMLciovdLmhcs5xhksPGOZRCoXK_sr8tmEiKw@mail.gmail.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 08:55:39AM -1000, Linus Torvalds wrote:
> I think I need to upgrade my laptop eventually. It's a perfectly fine
> laptop, but it's from 2019. I'm sure there are more powerful ones out
> there that are still lightweight.

Yeah, I love a laptop because it is nice and silent but no matter how big it
is, allmodconfig is still faaat and takes foreva. So I've scripted all my
builds to go to test machines and the laptop is simply collecting results or
booting those kernel binaries in VMs and so on.

That's how I follow the merge order of when we send you tip branches and I go
and merge and build each one to check for build errors one last time and see
what merge conflicts will appear.

And I can't do that on a laptop. It just takes too long.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
