Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5E1CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 10:11:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A3F910E30A;
	Fri,  8 May 2026 10:11:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (4096-bit key; unprotected) header.d=davidgow.net header.i=@davidgow.net header.b="iCbN+LJQ";
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="JyDnB/3g";
	dkim-atps=neutral
Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D272E10E30A
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 10:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
 s=201606; t=1778235076;
 bh=KgtJhIGG/oabZEQ8m54wP2EOXP+m+YCNMNV/vnXzHgE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=iCbN+LJQGiFTtJ5cF/yV7K33NP0p5gej0zTfQjzLQndImBB2vPwWTgDupuLk6JoZg
 JuJxsqR65JIis7lqY31r0bFGnZ4lxWSRGBMr+7AVRhAsEnUA9LUnrzyYMDbN63y4RA
 RSRd+mRbjvku8nuvqBKEcjYf/fs1um6EkPEGdtyp6yA1byCrtvs1vmF3r2RVFwb90e
 rh+Nmq9YwEUG7rO5qFjqG6j21YpdNMeaT6FdlI56Tjp40TAAjJrig7cXKQSpPw4iAR
 rEflZmY7KVQBTI8yc3omL4I9KWPz/Ix5t0Raq6W2xe2QW4fh9MHQShYIVbIOFF+inE
 DvINQaRWXjkn78dE1RGSuI5f4cGdlRbG3LysaVoKmmxSUvQdqOyldG2fN4o0vBICRS
 O5aXdmGtu6o2NA5M6dS8U3CY9MHuZ/rpTYojw25rwTBwJb+rzIpGAaxQbAOJzbWH+3
 HjTOhGjJBIYCn0z6RLgWbCMp5QhgL02C6dd+sLYxwHLdCIeeACDuJn3kjpXyR46lmt
 qnJawSp1grOckJjIsHGMg7LhBfWoMRHL0jaukODrdeInRPHIfLCNsgFJbg0cblGF2A
 7d6eeTEKfDHRq4qKcXZv/GSurwcb08Vceg61ck3VLQj7oTNfm9qv8KMKzLTePx6Z65
 VngAa+ZX7mgNybXjmBe+biKI=
Received: by sphereful.davidgow.net (Postfix, from userid 119)
 id 963031D804C; Fri,  8 May 2026 18:11:16 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
 s=201606; t=1778235015;
 bh=KgtJhIGG/oabZEQ8m54wP2EOXP+m+YCNMNV/vnXzHgE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=JyDnB/3gcDJfziHe3f8A/O6Bu3GBBOJHpG1l5DzaUEeBLF9mes/1cxeluMYxYLZjx
 7wRGZqvjczAcu7mghJ7VUiaJS7PsX2oJidB/NeChXXjnyq4mG/Y+yKvOjbGPCojZWi
 ySbUDU7c1/Ry+qWm/53P3tEq32V3CpeYxTsl14MqrU3rXc7/T9lb4OTsSxz0a5Lljq
 aopW8IQbgGsKLUVL2UF9jppv7GobQheeY1dQ4oIGmmQtSSIg5FsCwfm+r71bhZlpuc
 mlF2GoPzw6ntA4EjrmrvUMbUQ00c71ITlxrpf4ZD9bAkgsfFUWbXN+C+TWXBefJQmY
 S7Z20br9i6I4/SzkZwUKXpKua8JuVvI9vzRqsyTuUVpLUFlrD6nX5wzcmEZ/+crdj+
 cQUcvhyUXBi0WamxaWtHBYqgrrcsSuA4ipngc2JVzGf8JyLdzQ763awja+seUOWy2k
 QqykxE0iTulPFm+d6duMPkGhbAnRXsH4by6mRNhJ+1mo8bgtz/Sjk/wzMd201RRHOH
 sK1cN9FkKTvVd7EnYkSMTlw5Tfd9VFTIEVSJeQS4k05+wEjnIDp1Y8UR+Hqi5iaXk8
 jFAvhgustva340mXva8bAJibP/faX71gmOEFLUhxEkeFhMaKetHtlgvVT/JknOexyR
 ogCYSyRnGM6QZOVypnOQoNms=
Received: from [10.19.105.19] (the2438111.lnk.telstra.net [203.45.164.113])
 by sphereful.davidgow.net (Postfix) with ESMTPSA id D56481D803D;
 Fri,  8 May 2026 18:10:14 +0800 (AWST)
Message-ID: <a66dc316-5c3c-447a-946c-ac02f523c8b9@davidgow.net>
Date: Fri, 8 May 2026 18:10:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/4] bug/kunit: Core support for suppressing warning
 backtraces
To: Albert Esteve <aesteve@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Brendan Higgins
 <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org,
 workflows@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-doc@vger.kernel.org, peterz@infradead.org,
 Alessandro Carminati <acarmina@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>, Kees Cook <kees@kernel.org>
References: <20260504-kunit_add_support-v8-0-3e5957cdd235@redhat.com>
 <20260504-kunit_add_support-v8-1-3e5957cdd235@redhat.com>
 <c5c28f16-3940-4960-84e6-33f5479a5450@davidgow.net>
 <CADSE00KLhyUpRD031-YveOv+o71jJ-NojX6VteSyF+SqxG0n4g@mail.gmail.com>
 <CADSE00L5OCSNH_XsUHSvi_wAwZWiC2=bUGmiXVAu-LZ=XtvDjQ@mail.gmail.com>
Content-Language: en-US
From: David Gow <david@davidgow.net>
In-Reply-To: <CADSE00L5OCSNH_XsUHSvi_wAwZWiC2=bUGmiXVAu-LZ=XtvDjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Le 08/05/2026 à 14:52, Albert Esteve a écrit :
> On Wed, May 6, 2026 at 12:11 PM Albert Esteve <aesteve@redhat.com> wrote:
>>
>> On Wed, May 6, 2026 at 11:40 AM David Gow <david@davidgow.net> wrote:
>>>
>>> Le 04/05/2026 à 3:41 PM, Albert Esteve a écrit :
>>>> From: Alessandro Carminati <acarmina@redhat.com>
>>>>
>>>> Some unit tests intentionally trigger warning backtraces by passing bad
>>>> parameters to kernel API functions. Such unit tests typically check the
>>>> return value from such calls, not the existence of the warning backtrace.
>>>>
>>>> Such intentionally generated warning backtraces are neither desirable
>>>> nor useful for a number of reasons:
>>>> - They can result in overlooked real problems.
>>>> - A warning that suddenly starts to show up in unit tests needs to be
>>>>     investigated and has to be marked to be ignored, for example by
>>>>     adjusting filter scripts. Such filters are ad hoc because there is
>>>>     no real standard format for warnings. On top of that, such filter
>>>>     scripts would require constant maintenance.
>>>>
>>>> Solve the problem by providing a means to suppress warning backtraces
>>>> originating from the current kthread while executing test code. Since
>>>> each KUnit test runs in its own kthread, this effectively scopes
>>>> suppression to the test that enabled it. Limit changes to generic code
>>>> to the absolute minimum.
>>>>
>>>> Implementation details:
>>>> Suppression is integrated into the existing KUnit hooks infrastructure
>>>> in test-bug.h, reusing the kunit_running static branch for zero
>>>> overhead when no tests are running.
>>>>
>>>> Suppression is checked at three points in the warning path:
>>>> - In warn_slowpath_fmt(), the check runs before any output, fully
>>>>     suppressing both message and backtrace. This covers architectures
>>>>     without __WARN_FLAGS.
>>>> - In __warn_printk(), the check suppresses the warning message text.
>>>>     This covers architectures that define __WARN_FLAGS but not their own
>>>>     __WARN_printf (arm64, loongarch, parisc, powerpc, riscv, sh), where
>>>>     the message is printed before the trap enters __report_bug().
>>>> - In __report_bug(), the check runs before __warn() is called,
>>>>     suppressing the backtrace and stack dump.
>>>>
>>>> To avoid double-counting on architectures where both __warn_printk()
>>>> and __report_bug() run for the same warning, kunit_is_suppressed_warning()
>>>> takes a bool parameter: true to increment the suppression counter
>>>> (used in warn_slowpath_fmt and __report_bug), false to check only
>>>> (used in __warn_printk).
>>>>
>>>> The suppression state is dynamically allocated via kunit_kzalloc() and
>>>> tied to the KUnit test lifecycle via kunit_add_action(), ensuring
>>>> automatic cleanup at test exit. Writer-side access to the global
>>>> suppression list is serialized with a spinlock; readers use RCU.
>>>>
>>>> Three API forms are provided:
>>>> - kunit_warning_suppress(test) { ... }: scoped, uses __cleanup for
>>>>     automatic teardown on scope exit, kunit_add_action() as safety net
>>>>     for abnormal exits (e.g. kthread_exit from failed assertions).
>>>>     Suppression handle is only accessible inside the block.
>>>> - KUNIT_START/END_SUPPRESSED_WARNING(test): manual macros for larger
>>>>     blocks or when warning counts need to be checked after suppression
>>>>     ends. Limited to one pair per scope.
>>>> - kunit_start/end_suppress_warning(test): direct functions returning
>>>>     an explicit handle, for retaining the handle within the test,
>>>>     or for cross-function usage.
>>>>
>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>> Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
>>>> Reviewed-by: Kees Cook <kees@kernel.org>
>>>> Signed-off-by: Albert Esteve <aesteve@redhat.com>
>>>> ---
>>>
>>> This looks pretty good to me, thanks.
>>>
>>> Reviewed-by: David Gow <david@davidgow.net>
>>>
>>> It's maybe slightly over-the-top to now have three different ways of
>>> enabling warning suppression: I'd probably personally get rid of
>>> KUNIT_START/END_SUPPRESSED_WARNING() if we had to lose one. But if
>>> there's a real reason to prefer keeping all three, it's not actually a
>>> problem to do so.
>>
>> Thanks for the review!
>>
>> I think the three forms earn their keep: the scoped form is the go-to
>> for most cases, but the macros avoid indentation without requiring
>> users to manage a raw pointer. I initially removed the macros and
>> added them back later. Direct calls to the functions will be less
>> frequent, used only when you need the handle.
>>
>> That said, if it becomes a maintenance burden, the macros are the
>> easiest to drop since they're thin wrappers. Let me know if you prefer
>> them to be dropped, and I will send a v9 with that and the
>> `KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT` additions to the drm test
>> patch.
>>
>> BR,
>> Albert.
>>
>>>
>>> Regardless, this series is looking pretty ready to me. Let me know if
>>> you're planning a v9, otherwise we'll take this when you're ready.
> 
> I have been thinking, and despite my last response arguing against it,
> I think I will send that v9 and remove
> KUNIT_START/END_SUPPRESSED_WARNING(). Since the scoped approach with a
> reduced extent should be the default style for most cases, the direct
> calls can cover any other use cases without needing macros. Plus,
> since macros set the handler name for you, it seems odd not to be able
> to use them more than once per test.

Yeah, that was a part of my thought: all of the possible uses of 
KUNIT_START/END_SUPPRESSED_WARNING() can be replaced with the scoped 
version except for the one case where you want to check the number of 
warnings specifically after the scope. I'm not sure the latter would be 
common, and in the few places it's useful, the direct calls are not 
_that_ much more difficult to use.

> I hope that's ok. After that I think it should be ready (at least from my side).
> 
Sounds good: assuming no last-minute disasters, we'll take v9 then.

Cheers,
-- David
