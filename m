Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A71F9EDC0
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCD1D10E9D4;
	Wed, 22 Apr 2026 12:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (4096-bit key; unprotected) header.d=davidgow.net header.i=@davidgow.net header.b="deNpBR/Q";
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="UTgnOpLg";
	dkim-atps=neutral
Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBEDB10E9DE
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 12:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
 s=201606; t=1776860594;
 bh=b+jdMLz/f1OCxDME3vP0n+Ytlo9Zm1RnVo7KNc+DlTI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=deNpBR/Q7lyFcUmDWk3meLXWyvl0YU3YaO1zbonZyvyUajjWDNPpQYgizK8rRWsHC
 NqTQAjq4qR65WgkjuqKOuAs5lFM44SPQA+vWWhvRBG8AhiqSpLK6qaBqxoIZ5o8zzT
 efOmygx6mEu25jqPWGt/HfAWGl1G3gGAC9QRSbfXbggdKs1MZfQZiVXQKdO+aLtqgq
 aaA31C8d0MF8bs1eC5LOHA0RiJmIJpkGhXfbGdXioOtPteo9YXi7cKEHy7e0pn1FW2
 u4X2rkVn5g5DI2/z+WRNOSr5oN0zDFCTM9lvMPIAnKKeNtkKH/fwGpM3H72IW6EtuQ
 /jcSvjEqKwQOnGvnVrrYuo646knKY5CXGspdeCIc9vtLvQqeFqRUnaNqj1X39plgrA
 6ECRn6JKeHuBQi5vEpjIWjOPWgFsDV8yuFu9r0bC00t0ihO9p7Clk5vSI9PcYRvEc/
 rOaAkhTrRJAzXHblf8wvv8vU1TaDSJfcNO42DOJJfiY0zdC93tNdkDqT3FIJpDmBB/
 5XCDBwASeA6w3ZTvR588X8DFyEuVTRBD5iUGJobnBInozU2kL7gQyhHKPKmn+Q6pha
 FfmLgL6OqhRK9BvRK1+Vh124/rsx21DbxLdJDmfSVxzqpKyb77fFXGah8U/zolJGL8
 R8nq9W2GDMeKRPG9/BX/7W1M=
Received: by sphereful.davidgow.net (Postfix, from userid 119)
 id 4658C1E8D9F; Wed, 22 Apr 2026 20:23:14 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
 s=201606; t=1776860421;
 bh=b+jdMLz/f1OCxDME3vP0n+Ytlo9Zm1RnVo7KNc+DlTI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UTgnOpLgovcFqQ4HM6TnCdPdCX4lU52Z2jkOjv2W7HETijIRyCzB6BoC8r/EK6bfY
 mJ7NfuHEcDqnLvFSgMs1pdeyzJVGQV5kov6J/MgNsiI7b1HpHqg234/oQfO0uTf0Lb
 /5PFNtMklX/+fLZY5tne1c3TXUamwifgR2KWnbjjCCu118RVlVNvgbzxm5UgqNAfpo
 SGpxDNeABfxvwxRtbXRCnOxyv6YbuM8VZBGRA060eFIC/9/DNeem7O8ze1zbqd0ibS
 ywIBWABlVZWnWNc0b066lw1pqQfP04Vxp+8pfFT4xriUNtceMFG86XYgRMt7A1bpHy
 sn9Fe6pyQGSE+NNeNDdhuuy2byf78MzCytxyJVx0Sp+XYJjFpFxDSsIdKDyUD5Kia1
 c/n6FUXM6bwFsbCErfBKJTwSgtf3nIWy49hxNBxSlizXu5MtVUTvWigirXW3L6UQd3
 gKkBEwcwpSNXJYlHbohyKjyWOUr+YxncJ7jtbMd2KbopLO4orXUkgESGzN/pD7fTPE
 IatgVyeX+bFglXxao/qgsVhPOcDxXXqehEeSKAtwyOBhLSDTWVsDxX5ztsYBYts+pm
 Xj0toXWDqLkZSnP0ydze+uSbkHUT7EnaJZWOSp1loEPLaJ8oM5m36lUYvoAX1ihEqo
 u+E/jcn1K1CjEYqfkGYSGKJo=
Received: from [IPV6:2001:8003:8810:ea00:ed87:ca88:5326:e11d] (unknown
 [IPv6:2001:8003:8810:ea00:ed87:ca88:5326:e11d])
 by sphereful.davidgow.net (Postfix) with ESMTPSA id 9DF711E8D8B;
 Wed, 22 Apr 2026 20:20:21 +0800 (AWST)
Message-ID: <3922addf-32d8-4548-9a43-0e9bd861a5c8@davidgow.net>
Date: Wed, 22 Apr 2026 20:20:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] drm: Suppress intentional warning backtraces in
 scaling unit tests
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
 Dan Carpenter <dan.carpenter@linaro.org>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Alessandro Carminati <acarmina@redhat.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
References: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
 <20260420-kunit_add_support-v7-4-e8bc6e0f70de@redhat.com>
Content-Language: fr
From: David Gow <david@davidgow.net>
In-Reply-To: <20260420-kunit_add_support-v7-4-e8bc6e0f70de@redhat.com>
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
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---

Acked-by: David Gow <david@davidgow.net>

Some of the suggestions in the thread around __cleanup() et al. sound 
good to me, too. I suspect that it should work given the 
kunit_add_action() / resource system use anyway, so even if an assertion 
fires, things should be cleaned up properly.

Cheers,
-- David

>   drivers/gpu/drm/tests/drm_rect_test.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/tests/drm_rect_test.c
> index 17e1f34b76101..1dd7d819165e7 100644
> --- a/drivers/gpu/drm/tests/drm_rect_test.c
> +++ b/drivers/gpu/drm/tests/drm_rect_test.c
> @@ -409,8 +409,15 @@ static void drm_test_rect_calc_hscale(struct kunit *test)
>   	const struct drm_rect_scale_case *params = test->param_value;
>   	int scaling_factor;
>   
> +	/*
> +	 * drm_rect_calc_hscale() generates a warning backtrace whenever bad
> +	 * parameters are passed to it. This affects all unit tests with an
> +	 * error code in expected_scaling_factor.
> +	 */
> +	KUNIT_START_SUPPRESSED_WARNING(test);
>   	scaling_factor = drm_rect_calc_hscale(&params->src, &params->dst,
>   					      params->min_range, params->max_range);
> +	KUNIT_END_SUPPRESSED_WARNING(test);
>   
>   	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
>   }
> @@ -420,8 +427,15 @@ static void drm_test_rect_calc_vscale(struct kunit *test)
>   	const struct drm_rect_scale_case *params = test->param_value;
>   	int scaling_factor;
>   
> +	/*
> +	 * drm_rect_calc_vscale() generates a warning backtrace whenever bad
> +	 * parameters are passed to it. This affects all unit tests with an
> +	 * error code in expected_scaling_factor.
> +	 */
> +	KUNIT_START_SUPPRESSED_WARNING(test);
>   	scaling_factor = drm_rect_calc_vscale(&params->src, &params->dst,
>   					      params->min_range, params->max_range);
> +	KUNIT_END_SUPPRESSED_WARNING(test);
>   
>   	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
>   }
> 

