Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A220CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 09:41:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5F3A10E527;
	Wed,  6 May 2026 09:41:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (4096-bit key; unprotected) header.d=davidgow.net header.i=@davidgow.net header.b="osGI1fYj";
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="SdlOkqYg";
	dkim-atps=neutral
Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9547C10E527
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 09:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
 s=201606; t=1778060510;
 bh=wxwOGGBU7axLHOdFPa8Se5eHpE8XygiR/3cms0LswXo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=osGI1fYjOtd3UzanRWXCO1zP9C1sT0LTJBeEapKAiAD4id+r1fuhmq4AIKiaD7987
 rhmpTLqwmTV9xk4wUa8BbVisKlW80W+Pr77B1Zn9IveTXykXGY3qGEDmvYhWakEy1k
 DAa+IdS8Zm5pJPWsT8++onZksyxbU9sgdn16xcVQYD/4oMUH2zwHgRp5pr9GvUdXEd
 UvV0asArb/yUMNaFhLK+zWxNY5UT3ih0T2nD1IHAdktLUzUXzsgK8VQmd1hXS8/SKl
 ywG2GmV3cRUWSjTx4TeqY28NFwaivludYkcP+KP3FRA6H1E80Lq1ltQQ15Jt9TCyhE
 UZZgYQOjNiSNZfg4NYKcezkUTC1cNvkPWyMmJIFBJPaHWdgYgqUIrPOj58nthgal0K
 PiD8u01Xuk4DJm3tIXOGdr1YrK4DybAt6az7Hw9/nP+2QkNvGQppw7epU7TKAujxJq
 4uzxfOUZQk1gl6bLLO2LN4VnMJQWJTeK8xFqgvRXrYP8ICJmC6QE7+dpSXqCyi+x4q
 FT9DM4tOyuiEHJCRRUinlQzkKgj+4+RCLrxW8BUheIvtHv7GI22zIdVIFeDcSQaz1I
 pohBcCg/xzVDS8j7SbrX/GCfBQOSSHxrXfP+HUxuUbe1UGXnMAicS4fuFqH306MzEW
 gEa32QvyaxEk2GJexnpd4/SM=
Received: by sphereful.davidgow.net (Postfix, from userid 119)
 id 03A0F1E935F; Wed,  6 May 2026 17:41:50 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
 s=201606; t=1778060330;
 bh=wxwOGGBU7axLHOdFPa8Se5eHpE8XygiR/3cms0LswXo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SdlOkqYgmpbMQ90PDsf4vRNjySF2VWn2s6xItWSlRvy0nYeO3PGdxzlfpOW5vgtu5
 if5hGy6bGoNdipM5VQuimgFIHIKNGdaOf4YHLD/yKZ9zJcTUB64QAGizb/oRwx+Ye7
 EBESj8bLMqCfGXWYHAoHJBNvORT2jw0kIPdJbdcd0HF4AGRpM/kXrcn5sXP00+JKH5
 I7gFjm7bxv07o23A4fCkIEWTkv4Cr3cV2pagCYU2FsvYSULSRKja7otRbXAjzHwllJ
 LhRpWRfUVdVyqd59KqHhJSlBa7IFXkeH9EUvF0d+P1fE2HK77hNjDwY5Jb4e28YaNx
 nRXi8j1lnAqoSYv5Hzln6sUO4HF1eRcT1YcgDK0EF2OXQhNxeO9qojKh37CVNzsDgU
 JlHxWPo+kyarDMyhaRCycdqITYW24zyT89S14QlGZsZQo9+PkOvxx8Bl6byrLQwfpz
 HA/GAysD6LLH5D3Dlp+ShA2aby8d6OQJpemmQvsJ4GmPqpCpw1p27I8U132VYpxfKF
 2OeuXk29pGwkognpCJCRBoWdZyGkznpQy/dZepv+oAGB4dmHUpwLFIoLM/CFv2lYcT
 bbCvdHx+egEMZyZmE+jALf8iR+mIDj8U75t/sVcSY6WWMfgwCcrDXNg8zVUEgi334P
 yVORKeqjzNqR+fBkv/oKVcMo=
Received: from [IPV6:2001:8003:8810:ea00:ed87:ca88:5326:e11d] (unknown
 [IPv6:2001:8003:8810:ea00:ed87:ca88:5326:e11d])
 by sphereful.davidgow.net (Postfix) with ESMTPSA id 279381E934B;
 Wed,  6 May 2026 17:38:50 +0800 (AWST)
Message-ID: <47d78cad-0839-4602-9cb3-d1f672739e7e@davidgow.net>
Date: Wed, 6 May 2026 17:38:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/4] drm: Suppress intentional warning backtraces in
 scaling unit tests
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
 Dan Carpenter <dan.carpenter@linaro.org>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Alessandro Carminati <acarmina@redhat.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
References: <20260504-kunit_add_support-v8-0-3e5957cdd235@redhat.com>
 <20260504-kunit_add_support-v8-3-3e5957cdd235@redhat.com>
Content-Language: fr
From: David Gow <david@davidgow.net>
In-Reply-To: <20260504-kunit_add_support-v8-3-3e5957cdd235@redhat.com>
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
> The drm_test_rect_calc_hscale and drm_test_rect_calc_vscale unit tests
> intentionally trigger warning backtraces by providing bad parameters to
> the tested functions. What is tested is the return value, not the existence
> of a warning backtrace. Suppress the backtraces to avoid clogging the
> kernel log and distraction from real problems.
> 
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
> Acked-by: Maíra Canal <mcanal@igalia.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> Acked-by: David Gow <david@davidgow.net>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---

I'm happy with this either with or without the extra check for the 
warning count.

Acked-by: David Gow <david@davidgow.net>

We'll take this patch in the kunit tree along with the rest of the 
series once everyone's happy.

Cheers,
-- David

>   drivers/gpu/drm/tests/drm_rect_test.c | 23 +++++++++++++++++++----
>   1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/tests/drm_rect_test.c
> index 17e1f34b76101..818e16e80c8f9 100644
> --- a/drivers/gpu/drm/tests/drm_rect_test.c
> +++ b/drivers/gpu/drm/tests/drm_rect_test.c
> @@ -409,8 +409,16 @@ static void drm_test_rect_calc_hscale(struct kunit *test)
>   	const struct drm_rect_scale_case *params = test->param_value;
>   	int scaling_factor;
>   
> -	scaling_factor = drm_rect_calc_hscale(&params->src, &params->dst,
> -					      params->min_range, params->max_range);
> +	/*
> +	 * drm_rect_calc_hscale() generates a warning backtrace whenever bad
> +	 * parameters are passed to it. This affects all unit tests with an
> +	 * error code in expected_scaling_factor.
> +	 */
> +	kunit_warning_suppress(test) {
> +		scaling_factor = drm_rect_calc_hscale(&params->src, &params->dst,
> +						      params->min_range,
> +						      params->max_range);
> +	}
>   
>   	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
>   }
> @@ -420,8 +428,15 @@ static void drm_test_rect_calc_vscale(struct kunit *test)
>   	const struct drm_rect_scale_case *params = test->param_value;
>   	int scaling_factor;
>   
> -	scaling_factor = drm_rect_calc_vscale(&params->src, &params->dst,
> -					      params->min_range, params->max_range);
> +	/*
> +	 * drm_rect_calc_vscale() generates a warning backtrace whenever bad
> +	 * parameters are passed to it. This affects all unit tests with an
> +	 * error code in expected_scaling_factor.
> +	 */
> +	kunit_warning_suppress(test) {
> +		scaling_factor = drm_rect_calc_vscale(&params->src, &params->dst,
> +						      params->min_range, params->max_range);
> +	}
>   
>   	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
>   }
> 

