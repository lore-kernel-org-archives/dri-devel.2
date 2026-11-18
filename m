Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AD4606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Is++7Tbx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B14FD10E80D;
	Wed, 18 Nov 2026 14:37:48 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E9C710E80D
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 14:37:42 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id B3BB1C4F77E;
 Wed, 18 Nov 2026 14:37:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D14A75FE9B;
 Wed, 18 Nov 2026 14:37:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4AD0D11BC229E; Wed, 18 Nov 2026 15:37:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795012659; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=lpqeT2rigFPgFS9l60+27LVDzSLTb24mL7bP9ItOtmo=;
 b=Is++7Tbxm0I5ZC1ofAck6n/JkeCBbgnUtBxLtSfqcfIvQ5BXw1Z7Fk0jIQ9g3pd+ZsSGzK
 Ntcvs8pmJuEduYUMwxzl6+Q+qpWQ3SnhNIydJ+mwZFqhwdYWcL06lKcwpUt9Vqgd/ZJftU
 PRinGuTry9s13+tBmsFqAeveDXYexMV+lanMDqWxBlTz2KQVZE4n3G9XQAlOvUCjNWtdu3
 +fAVBjHrBjQxSTMZkPzIoQQd6GcehGwf+6ZRAKXpHWxxDu1/H1hACblsaGVacoNvkm9VtH
 znsp3hOsIjRuAOUVkw6yUaLAnoc4++hpQvEG71lUQ4p+hlYGhFF1SdYJ4umu7A==
Message-ID: <af11c394-5cff-495f-82d5-c4cd6dd9b218@bootlin.com>
Date: Wed, 18 Nov 2026 15:37:34 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] drm/vkms: remove TEST_LUT_SIZE
To: Leandro Ribeiro <leandro.ribeiro@collabora.com>
Cc: airlied@gmail.com, alex.hung@amd.com, daniel@fooishbar.org,
 hamohammed.sa@gmail.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com,
 mripard@kernel.org, pekka.paalanen@collabora.com,
 robert.mader@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261106201813.129911-1-leandro.ribeiro@collabora.com>
 <20261106201813.129911-5-leandro.ribeiro@collabora.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261106201813.129911-5-leandro.ribeiro@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/6/26 21:18, Leandro Ribeiro wrote:
> This can be replaced by ARRAY_SIZE(), so drop it.
> 
> Reviewed-by: Robert Mader <robert.mader@collabora.com>
> Tested-by: Robert Mader <robert.mader@collabora.com>
> Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>   drivers/gpu/drm/vkms/tests/vkms_color_test.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/tests/vkms_color_test.c b/drivers/gpu/drm/vkms/tests/vkms_color_test.c
> index 18e73a8a5c31..3489513af352 100644
> --- a/drivers/gpu/drm/vkms/tests/vkms_color_test.c
> +++ b/drivers/gpu/drm/vkms/tests/vkms_color_test.c
> @@ -8,11 +8,9 @@
>   #include "../vkms_drv.h"
>   #include "../vkms_luts.h"
>   
> -#define TEST_LUT_SIZE 16
> -
>   MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
>   
> -static struct drm_color_lut test_linear_array[TEST_LUT_SIZE] = {
> +static struct drm_color_lut test_linear_array[] = {
>   	{ 0x0, 0x0, 0x0, 0 },
>   	{ 0x1111, 0x1111, 0x1111, 0 },
>   	{ 0x2222, 0x2222, 0x2222, 0 },
> @@ -84,7 +82,7 @@ static const struct vkms_color_test_lerp_params color_test_lerp_cases[] = {
>   
>   static const struct vkms_color_lut test_linear_lut = {
>   	.base = test_linear_array,
> -	.lut_length = TEST_LUT_SIZE,
> +	.lut_length = ARRAY_SIZE(test_linear_array),
>   	.channel_value2index_ratio = 0xf000fll
>   };
>   
> @@ -96,7 +94,7 @@ static void vkms_color_test_get_lut_index(struct kunit *test)
>   	lut_index = get_lut_index(&test_linear_lut, test_linear_array[0].red);
>   	KUNIT_EXPECT_EQ(test, drm_fixp2int(lut_index), 0);
>   
> -	for (i = 0; i < TEST_LUT_SIZE; i++) {
> +	for (i = 0; i < test_linear_lut.lut_length; i++) {
>   		lut_index = get_lut_index(&test_linear_lut, test_linear_array[i].red);
>   		KUNIT_EXPECT_EQ(test, drm_fixp2int_ceil(lut_index), i);
>   	}

