Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516F9606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=V4xzcjyc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9CEB10E5F3;
	Wed,  4 Nov 2026 16:28:43 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE67510E5F3;
 Wed,  4 Nov 2026 16:28:37 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1641B40E0497; 
 Wed,  4 Nov 2026 16:28:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
 by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id TefcqjVVoH92; Wed,  4 Nov 2026 16:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
 t=1793809710; bh=9SHHUSf+T2bKBl5zTKVc7+4D9udfNKOS0jVoto10SB4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V4xzcjycP1+Wtqc6wgEWimId3M/6+viYYgNJsoST2dIljcHhD25I2Te+BT7jUHbJV
 LEUPPuH+S8feP9TbHkuD4SQfsNtHRtRt4F5RqIzd8qUpvgJVHGNWkXKRBvUKdjTQHJ
 SAdte27vaf/P0mVli7w120P9DjOAx/3YfLxBkUfawzctmP+cw0J96TiAXlSvmRLWNy
 MzQG77HLLr7RGBuyHbfg3j0xE0lCmrEP4EROND+CgK06dv/fEdKHxvj6eseIthtgQR
 hDqKvbseNqN8ndDFVnnBkuKh8saLpViSnLllDhhiKOhNWl3WB+7Y2RaX7d2sswN7EQ
 rVB7gAcJcK441nZYuOtWBn9miFBB/FWlRC5I8QeSKbVPWv6Uiek078rhtAIGAWxC5n
 n9aXv/A1o/pHQTI3YhqHGUaik/BGG0dEHrbYmpVlNpVvV4W0Pzh8Uv3k8UbFfExpWe
 xba+MGCUsMopyIh/RbUyPNiLI+U9zpzRyiLjyqPraytYUSCGGm9iS4mAKZYxMuoXXY
 ehpeg7LASildxIapP+I6QDmtnuQCL0260ZCVEdKD90U0Yjhkfm35HYacMcWd1Fwnd3
 2XMoxLPJ4WjYZEQf8jTJ2lvVDXejFRPPjMtxoYnXqvSOSjA3PllhmOEwVNpiNrlVcw
 zbpjWjIJIp1driYqfHXNCdhY=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest
 SHA256) (No client certificate requested)
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C227C40E02C2;
 Wed,  4 Nov 2026 16:27:50 +0000 (UTC)
Date: Wed, 4 Nov 2026 08:27:47 -0800
From: Borislav Petkov <bp@alien8.de>
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Xin Li (Intel)" <xin@zytor.com>,
 Brian Gerst <brgerst@gmail.com>, Nikolay Borisov <nik.borisov@suse.com>,
 linux-kernel@vger.kernel.org, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, llvm@lists.linux.dev
Subject: Re: [PATCH 0/4] Fix the x86 defconfig build with GCC 17
Message-ID: <20261104162747.GAautdA2q2lw2gsth2@fat_crate.local>
References: <20261104160722.1637541-1-vineet.gupta@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104160722.1637541-1-vineet.gupta@linux.dev>
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

On Wed, Nov 04, 2026 at 08:07:17AM -0800, Vineet Gupta wrote:
> Fix build warnings and failures (CONFIG_WERROR=y) with a GCC 17 build.
> GCC 17 adds -Wconstant-logical-operand which is strict about operands
> of && or || that fold to a constant other than 0 or 1.

Just from looking at it, my initial reaction would be to disable that option.

Because, frankly, I don't see the point.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
