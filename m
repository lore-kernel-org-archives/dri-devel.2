Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9FECD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 09:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23F7910E529;
	Wed,  6 May 2026 09:43:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (4096-bit key; unprotected) header.d=davidgow.net header.i=@davidgow.net header.b="XVAO5csn";
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="kpsixPmy";
	dkim-atps=neutral
Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54B6410E529
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 09:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
 s=201606; t=1778060582;
 bh=ETJfHEFrnP7uwEuXnhfD4Juu41Z9IVYsTPtyUojN4Ls=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=XVAO5csnKteW2a7Ht1z9ksXuLHrf76d3mC+ECiaSUKZg/3qOqqzTxtL5dZqkDlmwX
 k1kjBAGd8mpvylmWxOoyULinDJXWzHhGDwGl/VuKV1Uk6xmji8v9FdsbKgGJHjLUZ7
 ULEOySAF52TB7Mp6s8RSAPKwe4+GqDGbCMyV3OeJkdS0a1oQpcRr1JTMXzhTfMOye2
 Nxa7TFxB9bFvuxgb7J65gMGDle8+Ld+wOJzae6Je8EKRR33Iy+/+8A6RvI05+k99rt
 d7CVNqCQR9Q+wHq7Z6RXDOtN7D23hmc5S/nNK8f6RqrF6EQyvvvGBW7uelRTJzreoz
 rTB8MDCYugx8apXl5hnbV4B5g3mAcIkgN75FzDkHnHN3xYpEafjVpYSZbC8lPeQGPO
 PbHLTMK6wZWYzFZil1/uLASedWVUIjXC3Qc1r4my40UHOuaDJ4Ln7LVeBwLRyfBDLJ
 +aQabxtWrm2n8K06d+0yHYtZ/D3Xo9tXzcySkYclnw9jnqFcv0JcxKnZsI6+mW51xa
 r7Jg7ppDWMvGJuosVx8Gkd4kMp39ZH3iyqhOlTwwPU9xUUFTmNTNJbKh2cO0KMPacr
 HqULwmYb/Aq9VrXlqN69e4WImg6RmT9oa2zfAKatfnMsM/8/m2cP2qhRH2Qtx6FWZN
 9VVXwwwl1Yx3NIiUZpDMM1cc=
Received: by sphereful.davidgow.net (Postfix, from userid 119)
 id B49911E9360; Wed,  6 May 2026 17:43:02 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
 s=201606; t=1778060332;
 bh=ETJfHEFrnP7uwEuXnhfD4Juu41Z9IVYsTPtyUojN4Ls=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kpsixPmylB0V+dRd32N8gl5QYouI/mT0Gr4xvKSSZKRcR9jfgZqq/ItCBGAzdhpUy
 97MynWIjsQAKdu6u93rZGz3wSEpT74sORdYEWxwAISJzKp/jsYQy4r+zcD/XN4x8or
 IQg3smj8AnZUFrQgTGNDZ0yZpmz/JOVw2FjxmwENeAijqYMqDTMVT76VtU1NDmbB06
 6Z4bvSCn9NXN88opGdeyVxAd8mIU2fHaUHZKLkCcJDG45p14lobHJmYYunHm4GL3XX
 otLPaJbmNdYoLi87IMFMMYnteJ0uh2b3+Pizz9ZEKD1ok0GUGeheVIoDuwYPGPUpY8
 f3TlhhQS/sYpNS4uPGaD76jbApZJZC9rw9HEUHo8Nw/B5IlyrecB3CIZnQ2Aba/qtb
 2Y9KaCieioXCSHIsNY5DzmwaBVZhGizJJSN2TlKSIiTLJ9zLIpaGrOi9vt9lXLFZK3
 wDUhoiZjH2HEtVsUzrrTsSnmZOqZleaGOzmlVtNA2qXSWL89TBQ0m/po1SUZoGagyp
 pp+PPO76CEBmjXMFWTzNQOydgMBwcFvMeCAxdhfrk8eSou5jjkybFGOsTuhbDwdEdZ
 vFW5+Dcz3duTxlS3xTrBeVD4mY9ZZRKFYWTsgbc4COYx8uV5Ue3CUhy0FiEd0++qkS
 6/4suRNaadZ2GBZ+65hdkh/I=
Received: from [IPV6:2001:8003:8810:ea00:ed87:ca88:5326:e11d] (unknown
 [IPv6:2001:8003:8810:ea00:ed87:ca88:5326:e11d])
 by sphereful.davidgow.net (Postfix) with ESMTPSA id BB24F1E934E;
 Wed,  6 May 2026 17:38:52 +0800 (AWST)
Message-ID: <428e61d7-bd94-4264-bf7b-950f1dea2da0@davidgow.net>
Date: Wed, 6 May 2026 17:38:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/4] kunit: Add documentation for warning backtrace
 suppression API
To: Albert Esteve <aesteve@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
 peterz@infradead.org, Guenter Roeck <linux@roeck-us.net>,
 Linux Kernel Functional Testing <lkft@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Alessandro Carminati <acarmina@redhat.com>, Kees Cook <kees@kernel.org>
References: <20260504-kunit_add_support-v8-0-3e5957cdd235@redhat.com>
 <20260504-kunit_add_support-v8-4-3e5957cdd235@redhat.com>
Content-Language: fr
From: David Gow <david@davidgow.net>
In-Reply-To: <20260504-kunit_add_support-v8-4-3e5957cdd235@redhat.com>
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

Le 04/05/2026 à 3:41 PM, Albert Esteve a écrit :
> From: Guenter Roeck <linux@roeck-us.net>
> 
> Document API functions for suppressing warning backtraces.
> 
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> Reviewed-by: David Gow <david@davidgow.net>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---

This is great, thanks!

Reviewed-by: David Gow <david@davidgow.net>

Cheers,
-- David

>   Documentation/dev-tools/kunit/usage.rst | 63 ++++++++++++++++++++++++++++++++-
>   1 file changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index ebd06f5ea4550..25724f7e72969 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -157,6 +157,67 @@ Alternatively, one can take full control over the error message by using
>   	if (some_setup_function())
>   		KUNIT_FAIL(test, "Failed to setup thing for testing");
>   
> +Suppressing warning backtraces
> +------------------------------
> +
> +Some unit tests trigger warning backtraces either intentionally or as a side
> +effect. Such backtraces are normally undesirable since they distract from
> +the actual test and may result in the impression that there is a problem.
> +
> +Backtraces can be suppressed with **task-scoped suppression**: while
> +suppression is active on the current task, the backtrace and stack dump from
> +``WARN*()``, ``WARN_ON*()``, and related macros on that task are suppressed.
> +Three API forms are available, in order of convenience.
> +
> +- Scoped suppression is the simplest form. Wrap the code that triggers
> +  warnings in a ``kunit_warning_suppress()`` block:
> +
> +.. code-block:: c
> +
> +	static void some_test(struct kunit *test)
> +	{
> +		kunit_warning_suppress(test) {
> +			trigger_backtrace();
> +			KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
> +		}
> +	}
> +
> +.. note::
> +   The warning count must be checked inside the block; the suppression handle
> +   is not accessible after the block exits.
> +
> +- Manual macros are useful when the suppressed region is large enough that
> +  extra indentation is undesirable, or when the warning count needs to be
> +  checked after suppression ends. ``KUNIT_START_SUPPRESSED_WARNING()`` must
> +  appear before ``KUNIT_END_SUPPRESSED_WARNING()`` in the same scope.
> +  Limited to one pair per scope.
> +
> +.. code-block:: c
> +
> +	static void some_test(struct kunit *test)
> +	{
> +		KUNIT_START_SUPPRESSED_WARNING(test);
> +		trigger_backtrace();
> +		KUNIT_END_SUPPRESSED_WARNING(test);
> +
> +		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
> +	}
> +
> +- Direct functions return an explicit handle pointer. Use them when the handle
> +  needs to be retained or passed across helper functions:
> +
> +.. code-block:: c
> +
> +	static void some_test(struct kunit *test)
> +	{
> +		struct kunit_suppressed_warning *w;
> +
> +		w = kunit_start_suppress_warning(test);
> +		trigger_backtrace();
> +		kunit_end_suppress_warning(test, w);
> +
> +		KUNIT_EXPECT_EQ(test, kunit_suppressed_warning_count(w), 1);
> +	}
>   
>   Test Suites
>   ~~~~~~~~~~~
> @@ -1211,4 +1272,4 @@ For example:
>   		dev_managed_string = devm_kstrdup(fake_device, "Hello, World!");
>   
>   		// Everything is cleaned up automatically when the test ends.
> -	}
> \ No newline at end of file
> +	}
> 

