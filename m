Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48347606A320
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+yeLqAF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B754210E5EB;
	Wed, 28 Oct 2026 19:02:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C562E10E5EB;
 Wed, 28 Oct 2026 19:02:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1845460211;
 Wed, 28 Oct 2026 19:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF981F01828;
 Wed, 28 Oct 2026 19:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793214162;
 bh=YGMMhhJbzgW/QzPBpPTTD30RztuRbfCJwa//1MZPoEw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=T+yeLqAFaIV5ugdB5NjhA61e12w1L+BSrYB7OFrpfAcIR2R3bvk8VTeuph4Z05PLq
 lcmoQ2GTvN7w8itK8z23Fb7CvX7UrXcLfbyTBM3+olmVREQ8OYm4Vt9S2hUlYCCwvh
 YoLN/FbwlRtpVeWgrBQUKtpCMq2aSk6BZ96fzAPA1Zh/BUv05xwNUJnUgjyW+0NxCu
 MFHryYeChyS2NXG+hd5tU1QFjVZnyNZfQFjz6S4tMUSJw3XSKUGdfABAiPkqNVvbJb
 9OHQv7qk/nx3jGBDgbUSjb7yK9vqoj5fsPWRjo8ypvHtUbGQp1971XrK08vO1X/XlJ
 WlJINox/ORLVA==
Date: Wed, 28 Oct 2026 12:02:33 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Zhihao Cheng <chengzhihao1@huawei.com>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Sumanth Korikkar <sumanthk@linux.ibm.com>,
 Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev,
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-s390@vger.kernel.org, gfs2@lists.linux.dev,
 xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 1/9] Compiler Attributes: Add __must_init macro
Message-ID: <20261028190233.GA669046@ax162>
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-2-irogers@google.com>
 <202610281155.4D2AA663@keescook>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202610281155.4D2AA663@keescook>
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 11:56:08AM -0700, Kees Cook wrote:
> On Tue, Oct 27, 2026 at 03:38:36PM -0700, Ian Rogers wrote:
> > Note that Clang does not yet diagnose file-scope objects declared
> > without any initializer (initializers at file scope that omit the field
> > are diagnosed), see https://github.com/llvm/llvm-project/issues/232483.
...
> As part of this, can you open a Clang bug for the lack of detecting
> global initializers? It'd be nice to get that fixed.

Is that this linked issue or a different one? Looks like you filed that
one and it got fixed in clang ToT about a week ago:

  https://github.com/llvm/llvm-project/commit/58936cb3678b4b5b96177f24cac3940b9a389fe3

-- 
Cheers,
Nathan
