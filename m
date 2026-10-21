Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E95A606A31F
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D064A10E37C;
	Wed, 21 Oct 2026 18:43:47 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D635110E393;
 Wed, 21 Oct 2026 18:43:41 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A8F6540E047F; 
 Wed, 21 Oct 2026 18:43:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
 header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
 by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id unmjvmjmkCot; Wed, 21 Oct 2026 18:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
 t=1792608216; bh=NR++wQFM7W/RCMYyYRB+Of+fh8qFaAAT137dX+UdM7M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i+3nB9KOUtw5uiugvbg6TlGllwNKoAx0Ib3ewN7Vm/prl81X388RfLvss8sTMnwdw
 f8IygXuJ3ufjgvDXhs++ABh070Vk/1ejQDO01n61sYh/bDl9b6J1AB4azhhQHAy7+Y
 7njYd4hhOxddYCNiU4S6C6dtjINd+JchbOYc25Z9s3x8imrzXFlfMxG39yA+aDpkW7
 erb5/izeNUyBajSIgEEJatkKM3zt0rwstFoOStQ78Dhsx1QBO7v+Z5ZEe2va0eI3DC
 8QEM/+WVqKmEU9D2vERgDXtPz4bxKLAeLnwwXfgJUfyAJKgR8JEquvk1GNRHvFriHm
 dVdbvCVo6rX9GeFjADmQidOhXkixskil4+QIB6oDZLltw1KFMXwFIskobwak47SzOI
 2sQFKG/YnmfdIIS4/XYRAgzlaUp8iUCU03Eu4aQob/pCCKoqXExICCfw5s/b4pdesH
 N8B4nAd3g77cAM+FaKvJEdAtiZTc8p8DY5CS4GawRudL7esLa4nbyP9PWnOE4UlYxa
 qRvD81jobqt76v8UrSiE+E5H9sR7OQ6i6ECY02hzKbkNtvTumPvPGJdx1GNUkzANPD
 t/wnQlKfMArV0w1Q10qVq8gaSTs8xiT4iggxjXjhwYTusoxDe94EmxyYVOBnK7TyyD
 OHhH8AME2Ikeg/KYAs5P0MSY=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest
 SHA256) (No client certificate requested)
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D8DF340E01D2;
 Wed, 21 Oct 2026 18:43:20 +0000 (UTC)
Date: Wed, 21 Oct 2026 11:43:17 -0700
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
Message-ID: <20261021184317.GBatkHxUL2xqH9EUkY@fat_crate.local>
References: <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
 <20261020021924-mutt-send-email-mst@kernel.org>
 <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
 <CAHk-=wipGHx_1Uztmu773yuTM2ka1fq996UmNoJpvKS0gqEdMg@mail.gmail.com>
 <atdqUYdIOqmiqqTt@gmail.com>
 <CAHk-=whrUi2M+whqwS8yfqZ=W9ts6NPOzxzGfBOwOfCC3ooeMA@mail.gmail.com>
 <CAHk-=wjFBSH9M2GYKRnd-jrMGaa-gPBoGhuscJAu4n1hGsuX7g@mail.gmail.com>
 <CAHk-=wj51-syPoqMBLnxMeLnsbCMDMXfKzKZCtOHhwWEk5DeRw@mail.gmail.com>
 <20261021025403.GAatgpS1rcSTOTs8sS@fat_crate.local>
 <CAHk-=wgDm1nHurWJLESiLeYr0_0yv_F7W8YbvrmMEfbhxM1e_g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgDm1nHurWJLESiLeYr0_0yv_F7W8YbvrmMEfbhxM1e_g@mail.gmail.com>
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

On Tue, Oct 20, 2026 at 05:00:46PM -1000, Linus Torvalds wrote:
> I don't know that code at all, but from my reading it will only
> trigger in fairly unusual cases ("rep movs/ins/outs" that need
> emulation).

Right, and when the src/dst are MMIO, see 

        case INSN_MMIO_MOVS:
                ret = vc_handle_mmio_movs(ctxt, bytes);

which calls that vc_*_mem() gunk.

I presume you've also found:

  4954f5b8ef0b ("x86/sev-es: Use __put_user()/__get_user() for data accesses")

which explains why we use those.

> But the replacement code *should* do what __get_user/__put_user did
> before, just with a local helper, so unlike the i915 case it shouldn't
> actually change any semantics.

Yeah, I wanted to take a detailed look on a fresh head but you pulled it
again. :-P

I'll have a look when it shows up again.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
