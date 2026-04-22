Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3740BF9EDC4
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:29:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 003B210E9D6;
	Wed, 22 Apr 2026 12:29:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (4096-bit key; unprotected) header.d=davidgow.net header.i=@davidgow.net header.b="AxizSjGo";
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="n6gHOe9B";
	dkim-atps=neutral
X-Greylist: delayed 551 seconds by postgrey-1.36 at gabe;
 Wed, 22 Apr 2026 12:29:55 UTC
Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B957810E9D4
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 12:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
 s=201606; t=1776860655;
 bh=ny7vkY2fzG8mTBwVqO/QMWlF9EzgUJFVVOKu/qUlYIE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=AxizSjGo09n7KVJcalIYkFtRp9jEsbiLEVy/i/ApQS2RCCrmATHjk6P5xs5xyqFoL
 72hnBs1N/dMiJt7XUcJlYZ2zgtzDNuOCWmdR04qImHdilzrtx48Y9ALqOpaRX3hYYD
 ifZtLFq2YHdGN1yQqMC1EJsBfgpZpBXhYzhWAJB+XLMOATVghidr3X12eYhf5FTNIX
 /2WvHsi0D/QdKvCI5mKYpjsQHlTzcPw4zYVKk8/TmPR5ry8omXduzL0cwtiV1UwO3Y
 JrjZjVmPpMCVfvNaMaxY9eqhA7Kpi213zcuK6pcYmmtAXhlU2kXZpwC5jb0+9NL0kn
 8We+t0yVpaxaDHVqo2em/rfab31xmAoS4w0h30Lbp4dwmrwPIZw6V/Jb7/1v1mj+J+
 3T3w5AFjdHdqpWcT4jbMIgLU6SXF5ICac817uDHFnJNhkTUQCI+V+KtFTE2gOVgxzU
 vNeXAIoTbBS501NRNexZJtetY6/AAR2fUShSy9vm6cceiSYHw2aKiG6pGeZRbtaE/P
 jklhhsB7QdzuQDK9vZujnlMwjZNxYC/7gFV01940n1Ljcld1I5LE/Nnt/96MvMW7Bf
 UiFz6VV3QGAOmyFUAdfZ4WR+p9YlziNFwccYgodoETin9bM883BIFRSlTkz5wbkqlR
 g1sAZxtGQH7nDhN5vUmd6JRI=
Received: by sphereful.davidgow.net (Postfix, from userid 119)
 id 5DFFC1E8D9C; Wed, 22 Apr 2026 20:24:15 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
 s=201606; t=1776860426;
 bh=ny7vkY2fzG8mTBwVqO/QMWlF9EzgUJFVVOKu/qUlYIE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=n6gHOe9BzQy5I3LJfAPshR0ULJLuaobMTsQFvc9SrmIERn8nsNVk7EqptPSNkMfO/
 cxx2CYXvt38+3n71zY7BgVrGflkZlKVu8Fwv2bw5vbcJYZvLVr5dxrDWLPW6j3IYVV
 a1EzTAinrVYdri3M5EACB1zKxq6OOoxvAzxXfbmORh/Nn4VA7wg4EdvOl4gDfzGp/k
 yL7VLMqzA0AmRw9PWueFo487n3Q3IIgSoFxFFFBeeTPi21T6iz4/VRYSuuysbstjKh
 M3qYq1cbK7WIttnxGU79k5IjeRo7Cdbd6UVELtrREnkKuzQX8Bb3wt9RVUuJHIOKH9
 /sw0wkPu1e7r7mzTOmcHyS51v/uirWu3K0xtsm8XKSFoLCkYNXEwj/DX4mO9BSUXVY
 dqroH6mm63smzh1FyucpJpLnPwZ553BMSBy1+2j7LeDQPMYihOhZaP6wSSb8jtryAa
 VZDaFmc6SW7woWtCbaceE8iZykCpmW/dBWKYOqebaSh7Pb3jNCFr88wk/htV6j4D/k
 Cu/QEQ3zPJU+z3k2yiEb4DJ3wySFGBj4P1vwirHw3q4udLumafxgfoPswZpOFuDdPI
 uLjPnuRfU4/mm1wa56MN62Ya5mopAUSGL39f71SfNN1YrCQe1yScgo4cLDEuJYk2nj
 U1bsR2ays0hRqFVvOz0Xvthg=
Received: from [IPV6:2001:8003:8810:ea00:ed87:ca88:5326:e11d] (unknown
 [IPv6:2001:8003:8810:ea00:ed87:ca88:5326:e11d])
 by sphereful.davidgow.net (Postfix) with ESMTPSA id 943BD1E8D95;
 Wed, 22 Apr 2026 20:20:26 +0800 (AWST)
Message-ID: <0bd3f863-207d-4994-92cb-ec9999c0bc1b@davidgow.net>
Date: Wed, 22 Apr 2026 20:20:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] kunit: Add documentation for warning backtrace
 suppression API
To: Albert Esteve <aesteve@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, peterz@infradead.org,
 Guenter Roeck <linux@roeck-us.net>,
 Linux Kernel Functional Testing <lkft@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Alessandro Carminati <acarmina@redhat.com>, Kees Cook <kees@kernel.org>
References: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
 <20260420-kunit_add_support-v7-5-e8bc6e0f70de@redhat.com>
Content-Language: fr
From: David Gow <david@davidgow.net>
In-Reply-To: <20260420-kunit_add_support-v7-5-e8bc6e0f70de@redhat.com>
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

Le 20/04/2026 à 8:28 PM, Albert Esteve a écrit :
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
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---

Thanks -- it's always good to have documentation.

Apart from one note below, this looks good to me.

Reviewed-by: David Gow <david@davidgow.net>

Cheers,
-- David

>   Documentation/dev-tools/kunit/usage.rst | 30 +++++++++++++++++++++++++++++-
>   1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index ebd06f5ea4550..76e85412f240e 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -157,6 +157,34 @@ Alternatively, one can take full control over the error message by using
>   	if (some_setup_function())
>   		KUNIT_FAIL(test, "Failed to setup thing for testing");
>   
> +Suppressing warning backtraces
> +------------------------------
> +
> +Some unit tests trigger warning backtraces either intentionally or as side
> +effect. Such backtraces are normally undesirable since they distract from
> +the actual test and may result in the impression that there is a problem.
> +
> +Such backtraces can be suppressed with **task scope suppression**: while
> +``START`` / ``END`` is active on the current task, the backtrace and stack
> +dump from warnings on that task are suppressed. Wrap the call from your test
> +in that window, like shown in the following code.
> +
> +.. code-block:: c
> +
> +	static void some_test(struct kunit *test)
> +	{
> +		KUNIT_START_SUPPRESSED_WARNING(test);
> +		trigger_backtrace();
> +		KUNIT_END_SUPPRESSED_WARNING(test);
> +	}
> +
> +``KUNIT_SUPPRESSED_WARNING_COUNT()`` returns the number of suppressed backtraces.
> +If the suppressed backtrace was triggered on purpose, this can be used to check
> +if the backtrace was actually triggered.
> +
> +.. code-block:: c
> +
> +	KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), 1);


It might be worth noting that all of these must be in the same function, 
and the KUNIT_START_SUPPRESSED_WARNING() must be first. (And, in 
addition, there can't be more than one START/END pair per-function).

Of course, if the implementation is changed, that wouldn't be necessary. :-)
>   
>   Test Suites
>   ~~~~~~~~~~~
> @@ -1211,4 +1239,4 @@ For example:
>   		dev_managed_string = devm_kstrdup(fake_device, "Hello, World!");
>   
>   		// Everything is cleaned up automatically when the test ends.
> -	}
> \ No newline at end of file
> +	}
> 

