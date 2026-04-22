Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F01F9EDC0
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B32D410E9DE;
	Wed, 22 Apr 2026 12:30:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (4096-bit key; unprotected) header.d=davidgow.net header.i=@davidgow.net header.b="DccY/31d";
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="jNVyt8Ok";
	dkim-atps=neutral
Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C694310E9D7
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 12:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
 s=201606; t=1776860548;
 bh=hML0sRIU1AntIFM+ox4LLB4AF8Mi3yfxqyKl/z6vcDM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DccY/31dgKbtTkDP35VUadpUwAVv8D2PwznFX8Y8n7CzsLhNIhqGUwHltCw4ZqYoi
 ix9e8doDnnboWWH+jEUlfR33rD4tWUMIlLHV1Vu32GoDlKOOnW9kgmrvdq0ABNUKkm
 /Ve3CVVjrKmKS+/mmeQgi5+wT+ulQaPbTxwP4kwuzpmgSs+4Mv0tX+qbqNNm/B8uxq
 9qEbdxOjxepgeC0hiT/eSypZa/bNiWQ2iWEz3rUJ86HdjLN1/VAKcc8N4Fs9lw6bjM
 xVaNfpPITOQOFupnM+BWhiizMZhj2Y2XuNm3C1UcBptxvUR5uYyRMjQPBoj0hEzhPF
 mM7LcUk96UIS4Ts70xMrUWnso0Vr7ttrGHeWAjaP6Pprommf9Kz5LBdmxsCgRuQ4Px
 ZmHjAtMvNOECoYmPKbRyZObi0J0m04SS34E+oxdulvBpyAZkKhDTiGNxQh/71Cz4wb
 N/Lf244q+eZOzholt0VWiMFtqGARV1kw2IpW38DoKJMivHbonUPzMwLngA8xwFQteo
 ia9j2uhFBH0nW6d+JtSBw+mYojhwnCSRTLL4lky31+zwVXroWZo3vP+og5yrEGl0GL
 jNqWw7ZzSvfTDgp1W03z13Q4uS4TJA7USwx4EAsIKV/MsxqRBix77wgcRhB0X9E7qa
 0CqdL+4bMynIx1wx5Bzv13XE=
Received: by sphereful.davidgow.net (Postfix, from userid 119)
 id 4AFE71E8D9B; Wed, 22 Apr 2026 20:22:28 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
 s=201606; t=1776860407;
 bh=hML0sRIU1AntIFM+ox4LLB4AF8Mi3yfxqyKl/z6vcDM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jNVyt8OkdIBSpjXWabbTvUHKJ8p72aH5MAJK+/mU5sb3vXN0juUur374rRTNXZ7av
 xQM9NpPjNZrukN6k8exxIJGc6FFvD4VOkOkXZLENKo0TiKHw6xZ5T9j/PtpxsC7t9b
 FVIxvVSvzT4TobiKh6ds4SPYnjqofmZF1hmsu+C3IsrOJjjiQpUkHX4iHv3HWiJGP2
 m4wcMoneg2Dl3fdpYXJurB0K/zQlUXVt9fPIy34sdNbhU9MbIgwKYIka+sGg5VkhHn
 ZvubupvqFKunOpZAOuzNxiS+/fMuoMB9u+r+Klk4cuI3qk3iTH0CponNRofm6JI6ly
 mAVJXhfm9hBzq+qbW2yT8PIPe6INR5KFlD/j5d9rRq+1T2xGgYJV/ZlsysGs22tySs
 R++ctEYJhia4snlXgpv/AzbKQZiG5JTaQ04mWTYSLrUELMPb3jU5HCyH9rrkXqCaNo
 yQsXud4TnJACWuPYyPg0XAjwIvpBJr4n6x4PHHWbgqHgSDBkkFkJEC8oSrnwp5YtjO
 3Nplf7JhC0+uVvUJLHpVCa246BtB3YFWTiJ8H1lT6268A/dAbhHBY3rQdzTVuSI1qd
 9iIKr3PoHEqFJJ4XztoWbMGW4CcYMg+p9KHVvKL4qMp567pfWh0uPSl33fG6WVUz2D
 iiwY2AK0pUHn3OcTpbPZO/7U=
Received: from [IPV6:2001:8003:8810:ea00:ed87:ca88:5326:e11d] (unknown
 [IPv6:2001:8003:8810:ea00:ed87:ca88:5326:e11d])
 by sphereful.davidgow.net (Postfix) with ESMTPSA id 3BD631E8D8A;
 Wed, 22 Apr 2026 20:20:07 +0800 (AWST)
Message-ID: <6209f24e-750d-4a7d-ad63-1695f5fd1caa@davidgow.net>
Date: Wed, 22 Apr 2026 20:20:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] kunit: Add backtrace suppression self-tests
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
 <20260420-kunit_add_support-v7-3-e8bc6e0f70de@redhat.com>
Content-Language: fr
From: David Gow <david@davidgow.net>
In-Reply-To: <20260420-kunit_add_support-v7-3-e8bc6e0f70de@redhat.com>
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
> Add unit tests to verify that warning backtrace suppression works,
> covering WARN() and WARN_ON() with direct calls, indirect calls
> through helper functions, and multiple warnings in a single window.
> 
> If backtrace suppression does _not_ work, the unit tests will likely
> trigger unsuppressed backtraces, which should actually help to get
> the affected architectures / platforms fixed.
> 
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---

Thanks very much for including tests!

Maybe it'd be nice to test that the suppression is disabled after 
KUNIT_END_SUPPRESSED_WARNING(). Of course, then triggering an actual 
stacktrace would be a pain, but maybe we could check that 
__kunit_is_suppressed_warning() returns false? If you wanted to be 
really fancy, you could test that it returns false on another kthread 
even while the suppression is active, too, but I won't hold you to it. 
Equally, you could try setting up a fake test context and ensuring the 
cleanup is called correctly, but I think that's mostly covered by the 
existing KUnit resource tests.

Otherwise, looking good. A couple of other minor suggestions below, 
which may require some reworking of the __kunit_suppress scope, but all 
optional suggestions.

Reviewed-by: David Gow <david@davidgow.net>

>   lib/kunit/Makefile                     |  3 ++
>   lib/kunit/backtrace-suppression-test.c | 90 ++++++++++++++++++++++++++++++++++
>   2 files changed, 93 insertions(+)
> 
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index fe177ff3ebdef..b2f2b8ada7b71 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -23,6 +23,9 @@ obj-$(if $(CONFIG_KUNIT),y) +=		hooks.o \
>   
>   obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
>   obj-$(CONFIG_KUNIT_TEST) +=		platform-test.o
> +ifeq ($(CONFIG_KUNIT_SUPPRESS_BACKTRACE),y)
> +obj-$(CONFIG_KUNIT_TEST) +=		backtrace-suppression-test.o
> +endif
>   
>   # string-stream-test compiles built-in only.
>   ifeq ($(CONFIG_KUNIT_TEST),y)
> diff --git a/lib/kunit/backtrace-suppression-test.c b/lib/kunit/backtrace-suppression-test.c
> new file mode 100644
> index 0000000000000..2ba5dcb5fef35
> --- /dev/null
> +++ b/lib/kunit/backtrace-suppression-test.c
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for suppressing warning tracebacks.
> + *
> + * Copyright (C) 2024, Guenter Roeck
> + * Author: Guenter Roeck <linux@roeck-us.net>
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/bug.h>
> +
> +static void backtrace_suppression_test_warn_direct(struct kunit *test)
> +{
> +	KUNIT_START_SUPPRESSED_WARNING(test);
> +	WARN(1, "This backtrace should be suppressed");
> +	KUNIT_END_SUPPRESSED_WARNING(test);
> +
> +	KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), 1);
> +}
> +
> +static void trigger_backtrace_warn(void)
> +{
> +	WARN(1, "This backtrace should be suppressed");
> +}
> +
> +static void backtrace_suppression_test_warn_indirect(struct kunit *test)
> +{
> +	KUNIT_START_SUPPRESSED_WARNING(test);
> +	trigger_backtrace_warn();
> +	KUNIT_END_SUPPRESSED_WARNING(test);
> +
> +	KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), 1);
> +}
> +
> +static void backtrace_suppression_test_warn_multi(struct kunit *test)
> +{
> +	KUNIT_START_SUPPRESSED_WARNING(test);
> +	WARN(1, "This backtrace should be suppressed");
> +	trigger_backtrace_warn();
> +	KUNIT_END_SUPPRESSED_WARNING(test);
> +
> +	KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), 2);

Would it make sense to test KUNIT_SUPPRESSED_WARNING_COUNT() more 
thoroughly here by checking that it's 0 before any warnings, and 
checking that it's 1 in-between the two warnings?

Of course, the first case doesn't work due to __kunit_suppress not being 
defined, but if the implementation changes to support this, let's add it 
to the test, too.

> +}
> +
> +static void backtrace_suppression_test_warn_on_direct(struct kunit *test)
> +{
> +	if (!IS_ENABLED(CONFIG_DEBUG_BUGVERBOSE) && !IS_ENABLED(CONFIG_KALLSYMS))
> +		kunit_skip(test, "requires CONFIG_DEBUG_BUGVERBOSE or CONFIG_KALLSYMS");
> +
> +	KUNIT_START_SUPPRESSED_WARNING(test);
> +	WARN_ON(1);
> +	KUNIT_END_SUPPRESSED_WARNING(test);
> +
> +	KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), 1);
> +}
> +
> +static void trigger_backtrace_warn_on(void)
> +{
> +	WARN_ON(1);
> +}
> +
> +static void backtrace_suppression_test_warn_on_indirect(struct kunit *test)
> +{
> +	if (!IS_ENABLED(CONFIG_DEBUG_BUGVERBOSE))
> +		kunit_skip(test, "requires CONFIG_DEBUG_BUGVERBOSE");
> +
> +	KUNIT_START_SUPPRESSED_WARNING(test);
> +	trigger_backtrace_warn_on();
> +	KUNIT_END_SUPPRESSED_WARNING(test);
> +
> +	KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), 1);
> +}
> +
> +static struct kunit_case backtrace_suppression_test_cases[] = {
> +	KUNIT_CASE(backtrace_suppression_test_warn_direct),
> +	KUNIT_CASE(backtrace_suppression_test_warn_indirect),
> +	KUNIT_CASE(backtrace_suppression_test_warn_multi),
> +	KUNIT_CASE(backtrace_suppression_test_warn_on_direct),
> +	KUNIT_CASE(backtrace_suppression_test_warn_on_indirect),
> +	{}
> +};
> +
> +static struct kunit_suite backtrace_suppression_test_suite = {
> +	.name = "backtrace-suppression-test",
> +	.test_cases = backtrace_suppression_test_cases,
> +};
> +kunit_test_suites(&backtrace_suppression_test_suite);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("KUnit test to verify warning backtrace suppression");
> 

