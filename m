Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155F3606A329
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+edzg6v
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38C1E10FE24;
	Wed, 28 Oct 2026 18:56:15 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C4D410FE0A;
 Wed, 28 Oct 2026 18:56:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 94BAC43E30;
 Wed, 28 Oct 2026 18:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D261F01828;
 Wed, 28 Oct 2026 18:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793213768;
 bh=df/xPPyuiQPcm1AE1rSPxuyp5dlFq4Se196rhHrJoBM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=K+edzg6vK4sYIgPI0EHAxslJmPd/aExnxCZkYatx9SKb8ztopQpN/Brte7D1uGHDc
 +PWfIYIXj2TwEIjrIeT9aSjpQlU/qFISxxHuWsvH08dCGPPiD4L4rx5Tz6bxLuFRvY
 RhA3+DjTqfNcnhfh/7faDIzX0CmFsTI2XpkHQ8+jhA2LaeatAD4sqfFj21cmIRpM5b
 W2D2wH60j2ajxxUPUQIplNGc0FcQFY/hgWtTB/gjNx5LU362Hvl/ouMKfNIqzO8whL
 EQwWzgrE3+OvEllJ5XwE13QwOyNwuhXlhNdKAwm9IJuUZrFACWCEqjTJXX2ww3Zp+t
 0+IngOv7LotGw==
Date: Wed, 28 Oct 2026 11:56:08 -0700
From: Kees Cook <kees@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
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
Message-ID: <202610281155.4D2AA663@keescook>
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-2-irogers@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027223847.652884-2-irogers@google.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 03:38:36PM -0700, Ian Rogers wrote:
> Clang supports the 'require_explicit_initialization' attribute on struct
> fields to indicate that a field must be initialized explicitly by the
> user when the object is constructed. When an aggregate initializer or
> uninitialized variable omits an annotated field, Clang emits a
> -Wuninitialized-explicit-init warning (enabled by default).
> 
> Add the __must_init macro to include/linux/compiler_attributes.h (which
> is included by include/linux/compiler_types.h and
> include/linux/compiler.h) so kernel structs with error-prone
> initialization (such as mandatory callbacks or cleanup handlers) can
> enforce explicit initialization at compile time, as discussed at the
> Linux Plumbers Conference. The shorter __must_init spelling, rather than
> the attribute's full name, keeps annotated struct members readable and
> was suggested by Greg Kroah-Hartman.
> 
> Note that Clang does not yet diagnose file-scope objects declared
> without any initializer (initializers at file scope that omit the field
> are diagnosed), see https://github.com/llvm/llvm-project/issues/232483.
> 
> Also teach Sphinx (Documentation/conf.py), kernel-doc
> (tools/lib/python/kdoc/xforms_lists.py), and checkpatch.pl about the new
> attribute macro.
> 
> Link: https://lpc.events/event/20/contributions/2392/
> Link: https://lore.kernel.org/lkml/2026101532-fantastic-deafness-e04c@gregkh/
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Kees Cook <kees@kernel.org>

As part of this, can you open a Clang bug for the lack of detecting
global initializers? It'd be nice to get that fixed.

-- 
Kees Cook
