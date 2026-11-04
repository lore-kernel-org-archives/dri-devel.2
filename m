Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FA5607E486
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=TD9I12Fp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3196010E1CB;
	Wed,  4 Nov 2026 21:48:55 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71BD610E071;
 Wed,  4 Nov 2026 21:48:48 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 11C4F40E0299; 
 Wed,  4 Nov 2026 21:48:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
 by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id CrM7iBdwWbJE; Wed,  4 Nov 2026 21:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
 t=1793828922; bh=SHFgE/WaGAeK4UOjOp1+4JBcLoloJxsJmOJMM9MQxG0=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=TD9I12Fp2UZ5A34Ph3gVjDhiuACFFoBLifIOLvHudGewVLiKUN9jAJbCKSwAXN+U+
 qIRxDR5YTzSCMdNiaPUOyMkSRW1A3xzwOPt8I2TTswLk8GEWvbsLmjrNk6zpCcRRQq
 t9wEjIua0/4sejIJclDIU9oaErSzUdHDd3NZKl0qPcZo2E0jUCJQk0DwvmCyW/Yoj0
 C/ADlKjsqSqkpzwcc5Yee4JY8irCYXW54m9oz1ERiTQ4CZDiXN4ocSEtmdSiS1rVAe
 NmuvfID+rjCKdwFSVMdiv0bZp+AVR1RvdCgDbzCovgFgSnl1SLuSubxjFb7aa64mDM
 xKrkXEZxWGfajShqzsU93YnWZKdrDFO7SR3vkhmqy3lU3NVXb6V5QKXUfqEJ8lQsdS
 ZU3YUizwExg+8yHw4o9CAGqiqpcEMo3rI5teuL6NapqsljJSX50hhfDAdGL34zw3uS
 bMkouWGP8ubTWZ0N9CTxfwGwRmXvwt7ebe+H7wHhGGU0j/2MkhLRHVZmv8Xt9mVGgs
 J5YWUKnZkc+skWduuVEx07MRIFHMVCmW+54XnyF8zzonhE8C2LCuJr1GkwLf4CaLJd
 vjghyZks58S9u19Vb1DsRUR0M9a7xCIZJ/x6RZbY+K26AUYy0I3HzfN9NNSXPZA0LJ
 J92gFY3yG0hwSSXfsnqscL7c=
Received: from ehlo.thunderbird.net (mobile-166-137-178-199.mycingular.net
 [166.137.178.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
 (No client certificate requested)
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A861E40E0140;
 Wed,  4 Nov 2026 21:48:01 +0000 (UTC)
Date: Wed, 04 Nov 2026 21:18:41 +0000
From: Borislav Petkov <bp@alien8.de>
To: Vineet Gupta <vineet.gupta@linux.dev>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 =?ISO-8859-1?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Xin Li (Intel)" <xin@zytor.com>,
 Brian Gerst <brgerst@gmail.com>, Nikolay Borisov <nik.borisov@suse.com>,
 linux-kernel@vger.kernel.org, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 llvm@lists.linux.dev, Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH 0/4] Fix the x86 defconfig build with GCC 17
User-Agent: K-9 Mail for Android
In-Reply-To: <327c462a-3360-45fa-8398-4c23c1f2bd84@linux.dev>
References: <20261104160722.1637541-1-vineet.gupta@linux.dev>
 <20261104162747.GAautdA2q2lw2gsth2@fat_crate.local>
 <327c462a-3360-45fa-8398-4c23c1f2bd84@linux.dev>
Message-ID: <9A0C01CD-F821-4156-A975-E7FC67C636E1@alien8.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On November 4, 2026 6:05:27 PM UTC, Vineet Gupta <vineet=2Egupta@linux=2Ede=
v> wrote:
>+CC Jakub
>
>On 11/4/26 8:27 AM, Borislav Petkov wrote:
>> On Wed, Nov 04, 2026 at 08:07:17AM -0800, Vineet Gupta wrote:
>>> Fix build warnings and failures (CONFIG_WERROR=3Dy) with a GCC 17 buil=
d=2E
>>> GCC 17 adds -Wconstant-logical-operand which is strict about operands
>>> of && or || that fold to a constant other than 0 or 1=2E
>> Just from looking at it, my initial reaction would be to disable that o=
ption=2E
>>=20
>> Because, frankly, I don't see the point=2E
>
>Here's my 2 cents:
>
>I wondered if this brings any codegen improvements, since we are telling =
the compiler that something is 0 or 1 vs=2E some other range before=2E And =
it doesn't, because of the way it is used=2E So focusing on just 1/4=2E
>
>- Constant bit: __builtin_constant_p(bit) && MASK_BIT_SET(bit) folds at c=
ompile time to the same truth value, with or without the !! bool conversion=
=2E
>- Variable bit: __builtin_constant_p(bit) is 0, so && short-circuits and =
the mask is never evaluated=2E
>
>Basically, the masked value never reaches generated code, so compiler get=
s nothing new to work with=2E
>
>So I did some digging, and turns out that it can be helpful to catch bugs=
 in the source code itself=2E In fact GCC implemented the toggle at all, wh=
en Jakub spotted an issue with a typo: (data->flags && ff_genericize) vs=2E=
 (data->flags & ff_genericize)=2E
>
>In kernel, the predicate like *_BIT_SET() not returning a bool is not cle=
an IMO and it used to return 0/1 before anyway so its not like we are going=
 out of the way here=2E
>
>I'm mildly in the favor of keeping the warning, but ultimately your call,=
 I can respin with it disabled=2E
>
>Thx,
>-Vineet

You might wanna look at the W=3D switches we have for less popular and mor=
e noisy options
--=20
Small device=2E Typos and formatting crap
