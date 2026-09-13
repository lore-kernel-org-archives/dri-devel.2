Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286D5C88E56
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 08:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F56710E880;
	Sun, 13 Sep 2026 08:53:40 +0000 (UTC)
Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C0C610E880
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 08:53:39 +0000 (UTC)
Received: by sphereful.davidgow.net (Postfix, from userid 119)
 id 42E381EAB33; Sun, 13 Sep 2026 16:53:37 +0800 (AWST)
Received: from [IPV6:2001:8003:8802:7000::41b] (unknown
 [IPv6:2001:8003:8802:7000::41b])
 by sphereful.davidgow.net (Postfix) with ESMTPSA id 4EA6A1EA8D4;
 Sun, 13 Sep 2026 16:53:35 +0800 (AWST)
Message-ID: <8aab06f1-89ed-46f7-87a7-846c820d6d4f@davidgow.net>
Date: Sun, 13 Sep 2026 16:53:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kunit: configs: Enable DRM tests
To: Mark Brown <broonie@kernel.org>,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
References: <20260911-kunit-drm-v1-1-c5c0f18fc7b0@kernel.org>
Content-Language: en-US
From: David Gow <david@davidgow.net>
In-Reply-To: <20260911-kunit-drm-v1-1-c5c0f18fc7b0@kernel.org>
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

Le 12/09/2026 à 04:25, 'Mark Brown' via KUnit Development a écrit :
> There are a number of KUnit tests in the DRM subsystem but these are not
> run as standard since they are gated behind the main DRM config option
> and all_tests.config does not ensure that is enabled.  Add it.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

I think this is overall a worthwhile change, but the 
drm_sched_scheduler_overhead_tests do fail on UML at the moment.

I've sent a potential fix out (the test seems to fail if CONFIG_HZ is 
100) here:
https://lore.kernel.org/all/20260913084155.520015-2-david@davidgow.net/

Ideally, that'd land first so we don't end up with yet more breakage, 
but otherwise we can perhaps disable those tests on UML for now.

Regardless, this is:

Reviewed-by: David Gow <david@davidgow.net>

Cheers,
-- David

>   tools/testing/kunit/configs/all_tests.config | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
> index bccc2c77196d5..bee893f9fbbc6 100644
> --- a/tools/testing/kunit/configs/all_tests.config
> +++ b/tools/testing/kunit/configs/all_tests.config
> @@ -59,3 +59,5 @@ CONFIG_SND=y
>   CONFIG_SND_SOC=y
>   CONFIG_SND_SOC_TOPOLOGY_BUILD=y
>   CONFIG_SND_SOC_CS35L56_I2C=y
> +
> +CONFIG_DRM=y
> 
> ---
> base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
> change-id: 20260911-kunit-drm-9cce0032e098
> 
> Best regards,
> --
> Mark Brown <broonie@kernel.org>
> 

