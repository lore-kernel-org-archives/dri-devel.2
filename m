Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13046CD37AC
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 23:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78A7910E031;
	Fri,  8 May 2026 23:52:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ALxe9ym2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DE3D10E031
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 23:52:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B64C3417AC;
 Fri,  8 May 2026 23:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3FDC2BCB0;
 Fri,  8 May 2026 23:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1778284324;
 bh=sRGeCV6w/1XLJmMiis3Zh7jmQgcOwgTRye0mEg75f10=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ALxe9ym2sHgz7eBUYTEuUFF41oSDC4cz3mXGbV78Dfm+oqqwoIPEWCG2MGsWVZ8Z4
 +kLExX711p4ifWyTbJVe/8ddxhSROJmkV+x4IqyVtlJY9/t7d0pJNbyrMmNlQj8ehW
 q/cmtclmZMfOII99C0Y3VrNtwUEN0IxC3cncAWjE=
Date: Fri, 8 May 2026 16:52:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Albert Esteve <aesteve@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Brendan Higgins
 <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, Rae Moar
 <raemoar63@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org,
 workflows@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-doc@vger.kernel.org, peterz@infradead.org, Alessandro Carminati
 <acarmina@redhat.com>, Guenter Roeck <linux@roeck-us.net>, Kees Cook
 <kees@kernel.org>, Linux Kernel Functional Testing <lkft@linaro.org>,
 =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Dan Carpenter
 <error27@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v9 0/4] kunit: Add support for suppressing warning
 backtraces
Message-Id: <20260508165203.1cd1b27e664754d18dbea899@linux-foundation.org>
In-Reply-To: <20260508-kunit_add_support-v9-0-99df7aa880f6@redhat.com>
References: <20260508-kunit_add_support-v9-0-99df7aa880f6@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Fri, 08 May 2026 17:02:44 +0200 Albert Esteve <aesteve@redhat.com> wrote:

> Some unit tests intentionally trigger warning backtraces by passing bad
> parameters to kernel API functions. Such unit tests typically check the
> return value from such calls, not the existence of the warning backtrace.
> 
> ...
> 
> Solve the problem by providing a means to suppress warning backtraces
> originating from the current kthread while executing test code.
> Since each KUnit test runs in its own kthread, this effectively scopes
> suppression to the test that enabled it, without requiring any
> architecture-specific code.

Thanks.  AI review has a bunch of questions:
	https://sashiko.dev/#/patchset/20260508-kunit_add_support-v9-0-99df7aa880f6@redhat.com
