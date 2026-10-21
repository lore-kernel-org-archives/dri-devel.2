Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC06F606A31B
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=LvzYnj5E
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6759410F8A5;
	Wed, 21 Oct 2026 03:01:04 +0000 (UTC)
X-Greylist: delayed 387 seconds by postgrey-1.36 at gabe;
 Wed, 21 Oct 2026 03:00:56 UTC
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 651BE10F8AB;
 Wed, 21 Oct 2026 03:00:56 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F097740E0487; 
 Wed, 21 Oct 2026 02:54:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
 header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
 by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id EmmrjdEt_qN3; Wed, 21 Oct 2026 02:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
 t=1792551262; bh=Ni7Wny37YhtUhYDW93wzK1StKJMKzK8lTsajyVnVHy8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LvzYnj5EYtqQ2oUtKT7B1ZtlGybG3QVSnya06TSSOslQJoQ8A8SvogYxvd+8ShzDh
 V/sAuIOuOXG6+i9lLwGhMijXxhA3XcXpdHThemIk4/mIOHBsMQPQh6XNN/kh4OQzDn
 Hf+nDmKcofyVwviYX//jYtd61ef7NEfGb9lqlAPDsTtcz8BH80rxnzHQLy+7O5Zdfl
 mlgtnXEbT/Pdcqyhzl+a2G0K5D43/zQn2tulub6xIsf2NT9Pf1eDSXVpSNuU2+LhMf
 o5pNmjPjncppImrrvL5ZyXIHrSuznM7xkQc6G4Wy+UO4p3jrGz19Pr/wDCyzEGjEWI
 Ri/sAc2YYsqiV3sXEWdcxN7rmjY8ZUifQMGY4bN+YLne6e6kI4UZ1caa7bDxsl3TkF
 CIJU4BOiylt0UjWJEKPy/2bOhXhSnftSReskW8knp/bZfC2EEbPfk8/tUbU9/zI/ee
 KYtPfcXpOku9tJrrhAGjzdXgEbrT6FUedkwsHWQsqLTplfB1n5JqDMzKDCTSq2FMA5
 bWNzQKfT3IbYPj07JkIyoqrARv1Ngd0oCtsQqZOk7OLezwm9arne14se7Zx6jzipV9
 JUIsQHHK9zNu/BovnqX5ysbsoJV82pyHef7E8lr0FSLrsguoNhGW58N10fGvjqli3j
 Vkwft0Rm9bfN5ZIHsaDg+bSk=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest
 SHA256) (No client certificate requested)
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 076B340E00DC;
 Wed, 21 Oct 2026 02:54:06 +0000 (UTC)
Date: Tue, 20 Oct 2026 19:54:03 -0700
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
Message-ID: <20261021025403.GAatgpS1rcSTOTs8sS@fat_crate.local>
References: <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <20261018174250-mutt-send-email-mst@kernel.org>
 <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
 <20261020021924-mutt-send-email-mst@kernel.org>
 <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
 <CAHk-=wipGHx_1Uztmu773yuTM2ka1fq996UmNoJpvKS0gqEdMg@mail.gmail.com>
 <atdqUYdIOqmiqqTt@gmail.com>
 <CAHk-=whrUi2M+whqwS8yfqZ=W9ts6NPOzxzGfBOwOfCC3ooeMA@mail.gmail.com>
 <CAHk-=wjFBSH9M2GYKRnd-jrMGaa-gPBoGhuscJAu4n1hGsuX7g@mail.gmail.com>
 <CAHk-=wj51-syPoqMBLnxMeLnsbCMDMXfKzKZCtOHhwWEk5DeRw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj51-syPoqMBLnxMeLnsbCMDMXfKzKZCtOHhwWEk5DeRw@mail.gmail.com>
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

On Tue, Oct 20, 2026 at 03:38:02PM -1000, Linus Torvalds wrote:
>  - The "either kernel or user pointer" situation. That was the x86
> coco/SEV case, and the alpha "is_prefetch" cases.

My SEV-SNP guest boots with it and we'll run more extensive tests soon to make
sure nothing falls out.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
