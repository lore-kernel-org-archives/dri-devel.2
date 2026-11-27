Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D11A606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jydChcVB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE96E1129EC;
	Fri, 27 Nov 2026 10:25:26 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28726112A05
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:25:20 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-490d59c3f0aso3631166f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 02:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795775118; x=1796379918; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mc1ssleJtu8B4w1hoFLbQA3D7PDsqJA2CqNZTg9L5j8=;
 b=jydChcVBwrtjzzGtfHu+ZJq+2M2441wfCQRd3h4GdswqRmkFQBxjmPjwqQ/U6R77UF
 gecPYgXjjL3wzWwMxb8nCqV3qqkDjBsKU2uPW8Cx3IIKvEu9m12NMpCkaEQWYX62Wyow
 rT5xnIWEWMTjLJE5NXTdHJey7hddugIKCoBTdqNY6VQQuyNpRtd01bYzAQgARkd0xIXA
 jngzevjRRQ+NFM79eia42WR9FGFCKN6//XELBW8XV6mHLQUb3jwMjtcI2zRBSniIjkwu
 M2Zl+gTPv6FaXGuIowHCENZXUsyjv9RRee+PUmkHR1egT+EsrbY37w9tTk8bpFKiZBSi
 tSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795775118; x=1796379918;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mc1ssleJtu8B4w1hoFLbQA3D7PDsqJA2CqNZTg9L5j8=;
 b=yTQtcN3h5Dn/B4e8iE2L0Ib8XDMcXp2D5pE5e6/MNu5J1q5LmRlYP+Z+0Out/2nP/4
 n5im73nCWh65RA4UjWytUpLk/+lM08ZfizEVt3w9wAu4IiliZqSQUoblCpsKayB8XoC8
 bnSDBKIRJW7Cpc60o6wZz8Sub3I8ty6udbY3eoPoTgvpLEhJce48t9YkFJvIBgqi4gwS
 vRQUicnVEN9uafwFN/CLcWJoOCpQhF/a+hw2cn5LA6W0g96At+mR9Sji5DQZ0s5k0/Au
 Qy4DGcBjo7cwcSPPp/DBRWE8VNhEHR7dVUrTbjmBf5LV5GTBGrTylTz8CHLn0vsh/tY3
 sv4w==
X-Forwarded-Encrypted: i=1;
 AL+hErERSblhKuhJukZRL9aWLdEmVisFhSYErmmKjabDy/PK7wKc54Vqo4IYog8K+kPv48qL0mK9Jrg1FA4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9jbn3W7g2+LJnF1oBKYVO2eWlv6z5w3oZtVQjvSfTZ6EltFNrJ
 5dwrm+nQcnigKp/rlze1rb0EkttJj5TLZ7SRjIJy+KQ2IfWDFcUBwyj3
X-Gm-Gg: AZFdTZfnr2JqmJr1RTi0KP/bXDuN52CFD0kWekFTeIviqR/pp2TdXK9UsoTVw+FN+jG
 z6ARbQpzeBHd5PgcuBC8zGJm10g5Qc8xjKk+WxvkX56RK9eQBpq0OCRbVJA8RYkRpaW5KZdEC3j
 1E6CTF52t5/ycJEiJgoI2S65/o0IM3DHIYxxlVVm77ZO8LAXyD6t/BnsseU3gdflpk0BEUJ9Bjj
 azbOaFirx70yYMzaThS8za6c7jtZPu/nUM4r07hh5P8FPov2BGR67IXcNCtMDZMg7S36c6z3kvo
 RXmeji9W95Le6nnNc9+n6e6it5ReZFeC45jYAPPCstopgYd2FdXQp191vGWafYXcwCIUkJY7d3O
 qXA6nbEZhrbHLewRqwUuDjXU/ud2p+p8Wwry/zPP4Kny0rIquvzwTR46zmdfG+Y7YnEX/WRf5ou
 USiez8few6JapWYIQv8/XvopHpBwugvYok+TME64OBRgkW4Rc+qG4aVmFuvKxIdBynewGNLHpus
 /QdaEdBqifOvDL8+mWlVM85hPDrKbD/QMoHPeDd2wdo1a9wpkYP+NutrTE3pboBzV+ehN2J3/m1
 fulQsT+94YGIq8OrzEY+TrGOaN28Nrc=
X-Received: by 2002:a5d:6f13:0:b0:4a7:a7d2:eb45 with SMTP id
 ffacd0b85a97d-4abb6d04777mr42212072f8f.44.1795775118151; 
 Fri, 27 Nov 2026 02:25:18 -0800 (PST)
Received: from ArchOarora ([95.179.249.152]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b2052c8sm46450608f8f.41.2026.11.27.02.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:25:17 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 jose.exposito89@gmail.com, Jonathan Corbet <corbet@lwn.net>,
 Harry Wentland <harry.wentland@amd.com>,
 Lucas De Marchi <demarchi@kernel.org>,
 Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>, sebastian.wick@redhat.com,
 victoria@system76.com, thomas.petazzoni@bootlin.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v7 12/43] drm/vkms: Add KUnit test for device lifecycle
Date: Fri, 27 Nov 2026 11:24:57 +0100
Message-ID: <awlZ_hnb32taepmt@Oarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126-vkms-all-config-v7-12-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-12-21194cda2468@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 12:28:55PM +0100, Louis Chauvet wrote:
> The configuration objects are now reference-counted and their lifetime is
> driven by explicit get/put calls. Add tests aiming to spot UAF and leaks
> using KASAN.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/tests/.kunitconfig          |  10 +
>  drivers/gpu/drm/vkms/tests/Makefile              |   3 +-
>  drivers/gpu/drm/vkms/tests/vkms_lifecycle_test.c | 280 +++++++++++++++++++++++
>  drivers/gpu/drm/vkms/vkms_drv.c                  |   3 +
>  4 files changed, 295 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vkms/tests/.kunitconfig b/drivers/gpu/drm/vkms/tests/.kunitconfig
> index 6a2d87068edc..c9752bde8487 100644
> --- a/drivers/gpu/drm/vkms/tests/.kunitconfig
> +++ b/drivers/gpu/drm/vkms/tests/.kunitconfig
> @@ -2,3 +2,13 @@ CONFIG_KUNIT=y
>  CONFIG_DRM=y
>  CONFIG_DRM_VKMS=y
>  CONFIG_DRM_VKMS_KUNIT_TEST=y
> +CONFIG_KASAN=y
> +CONFIG_KASAN_INLINE=y
> +CONFIG_KASAN_VMALLOC=y
> +CONFIG_KUNIT_ALL_TESTS=n
> +CONFIG_DEBUG_KERNEL=y
> +CONFIG_DEBUG_KMEMLEAK=y
> +CONFIG_DEBUG_OBJECTS=y
> +CONFIG_DEBUG_OBJECTS_FREE=y
> +CONFIG_DEBUG_OBJECTS_TIMERS=y
> +CONFIG_PAGE_POISONING=y
> diff --git a/drivers/gpu/drm/vkms/tests/Makefile b/drivers/gpu/drm/vkms/tests/Makefile
> index d4d9ba8d4c54..a7810a12c9c8 100644
> --- a/drivers/gpu/drm/vkms/tests/Makefile
> +++ b/drivers/gpu/drm/vkms/tests/Makefile
> @@ -3,6 +3,7 @@
>  vkms-kunit-tests-y := \
>  	vkms_config_test.o \
>  	vkms_format_test.o \
> -	vkms_color_test.o
> +	vkms_color_test.o \
> +	vkms_lifecycle_test.o \
>  
>  obj-$(CONFIG_DRM_VKMS_KUNIT_TEST) += vkms-kunit-tests.o
> diff --git a/drivers/gpu/drm/vkms/tests/vkms_lifecycle_test.c b/drivers/gpu/drm/vkms/tests/vkms_lifecycle_test.c
> new file mode 100644
> index 000000000000..7f7b31368710
> --- /dev/null
> +++ b/drivers/gpu/drm/vkms/tests/vkms_lifecycle_test.c
> @@ -0,0 +1,280 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <kunit/test.h>
> +#include <linux/string.h>
> +
> +#include "../vkms_config.h"
> +#include "../vkms_drv.h"
> +
> +MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
> +
> +#define LIFECYCLE_ITERATIONS 50
> +#define STRESS_ITERATIONS    500
> +
> +/*
> + * vkms_init() may already have registered a device named DEFAULT_DEVICE_NAME,
> + * so give each test configuration its own name: vkms_create() fails with
> + * -EEXIST otherwise.
> + */
> +static void vkms_lifecycle_test_set_unique_name(struct kunit *test,
> +						struct vkms_config *config,
> +						const char *name)
> +{
> +	const char *new_name = kstrdup_const(name, GFP_KERNEL);
> +
> +	KUNIT_ASSERT_NOT_NULL(test, new_name);
> +	kfree_const(config->dev_name);
> +	config->dev_name = new_name;
> +}
> +
> +static void vkms_lifecycle_test_create_destroy_default(struct kunit *test)
> +{
> +	struct vkms_config *config;
> +	int ret, i;
> +
> +	for (i = 0; i < LIFECYCLE_ITERATIONS; i++) {
> +		config = vkms_config_default_create(true, true, false, false);
> +		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
> +		vkms_lifecycle_test_set_unique_name(test, config, test->name);
> +
> +		ret = vkms_create(config);
> +		KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +		vkms_destroy(config);
> +		vkms_config_destroy(config);
> +	}
> +}
> +
> +static void vkms_lifecycle_test_create_destroy_with_overlay(struct kunit *test)
> +{
> +	struct vkms_config *config;
> +	int ret, i;
> +
> +	for (i = 0; i < LIFECYCLE_ITERATIONS; i++) {
> +		config = vkms_config_default_create(true, true, true, false);
> +		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
> +		vkms_lifecycle_test_set_unique_name(test, config, test->name);
> +
> +		ret = vkms_create(config);
> +		KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +		vkms_destroy(config);
> +		vkms_config_destroy(config);
> +	}
> +}
> +
> +static void vkms_lifecycle_test_create_destroy_with_pipeline(struct kunit *test)
> +{
> +	struct vkms_config *config;
> +	int ret, i;
> +
> +	for (i = 0; i < LIFECYCLE_ITERATIONS; i++) {
> +		config = vkms_config_default_create(true, true, true, true);
> +		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
> +		vkms_lifecycle_test_set_unique_name(test, config, test->name);
> +
> +		ret = vkms_create(config);
> +		KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +		vkms_destroy(config);
> +		vkms_config_destroy(config);
> +	}
> +}
> +
> +static void vkms_lifecycle_test_create_destroy_minimal(struct kunit *test)
> +{
> +	struct vkms_config *config;
> +	int ret, i;
> +
> +	for (i = 0; i < LIFECYCLE_ITERATIONS; i++) {
> +		config = vkms_config_default_create(false, false, false, false);
> +		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
> +		vkms_lifecycle_test_set_unique_name(test, config, test->name);
> +
> +		ret = vkms_create(config);
> +		KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +		vkms_destroy(config);
> +		vkms_config_destroy(config);
> +	}
> +}
> +
> +static void vkms_lifecycle_test_create_destroy_writeback(struct kunit *test)
> +{
> +	struct vkms_config *config;
> +	int ret, i;
> +
> +	for (i = 0; i < LIFECYCLE_ITERATIONS; i++) {
> +		config = vkms_config_default_create(false, true, false, false);
> +		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
> +		vkms_lifecycle_test_set_unique_name(test, config, test->name);
> +
> +		ret = vkms_create(config);
> +		KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +		vkms_destroy(config);
> +		vkms_config_destroy(config);
> +	}
> +}
> +
> +static void vkms_lifecycle_test_stress_many_cycles(struct kunit *test)
> +{
> +	struct vkms_config *config;
> +	int ret, i;
> +
> +	for (i = 0; i < STRESS_ITERATIONS; i++) {
> +		config = vkms_config_default_create(true, true, true, false);
> +		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
> +		vkms_lifecycle_test_set_unique_name(test, config, test->name);
> +
> +		ret = vkms_create(config);
> +		KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +		vkms_destroy(config);
> +		vkms_config_destroy(config);
> +	}
> +}
> +
> +static void vkms_lifecycle_test_interleaved_create_destroy(struct kunit *test)
> +{
> +	struct vkms_config *configs[5];
> +	char name[64];
> +	int ret, i, j;
> +
> +	for (j = 0; j < 20; j++) {
> +		for (i = 0; i < 5; i++) {
> +			configs[i] = vkms_config_default_create(i & 1, i & 2, i & 4, false);
> +			KUNIT_ASSERT_NOT_ERR_OR_NULL(test, configs[i]);
> +
> +			snprintf(name, sizeof(name), "%s-%d", test->name, i);
> +			vkms_lifecycle_test_set_unique_name(test, configs[i], name);
> +
> +			ret = vkms_create(configs[i]);
> +			KUNIT_ASSERT_EQ(test, ret, 0);
> +		}
> +
> +		for (i = 4; i >= 0; i--) {
> +			vkms_destroy(configs[i]);
> +			vkms_config_destroy(configs[i]);
> +		}
> +	}
> +}
> +
> +static void vkms_lifecycle_test_destroy_uncreated_device(struct kunit *test)
> +{
> +	struct vkms_config *config;
> +
> +	config = vkms_config_default_create(true, true, false, false);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
> +
> +	KUNIT_ASSERT_NULL(test, config->dev);
> +
> +	vkms_config_destroy(config);
> +}
> +
> +static void vkms_lifecycle_test_double_destroy(struct kunit *test)
> +{
> +	struct vkms_config *config;
> +	int ret;
> +
> +	config = vkms_config_default_create(true, true, false, false);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
> +	vkms_lifecycle_test_set_unique_name(test, config, test->name);
> +
> +	ret = vkms_create(config);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	vkms_destroy(config);
> +	KUNIT_ASSERT_NULL(test, config->dev);
> +
> +	vkms_config_destroy(config);
> +}
> +
> +static void vkms_lifecycle_test_create_after_destroy(struct kunit *test)
> +{
> +	struct vkms_config *config;
> +	int ret, i;
> +
> +	for (i = 0; i < 20; i++) {
> +		config = vkms_config_default_create(true, true, false, false);
> +		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
> +		vkms_lifecycle_test_set_unique_name(test, config, test->name);
> +
> +		ret = vkms_create(config);
> +		KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +		vkms_destroy(config);
> +
> +		ret = vkms_create(config);
> +		KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +		vkms_destroy(config);
> +		vkms_config_destroy(config);
> +	}
> +}
> +
> +static void vkms_lifecycle_test_connector_ref_outlives_config(struct kunit *test)
> +{
> +	struct vkms_config_connector *connector_cfg;
> +	struct vkms_config *config;
> +
> +	config = vkms_config_default_create(false, false, false, false);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
> +	KUNIT_ASSERT_FALSE(test, list_empty(&config->connectors));
> +
> +	connector_cfg = list_first_entry(&config->connectors,
> +					 struct vkms_config_connector, link);
> +
> +	/* Simulate the rmdir while DRM hold the device */
> +	vkms_config_connector_get(connector_cfg);
> +	vkms_config_destroy_connector(connector_cfg);
> +	vkms_config_destroy(config);
> +
> +	/* The connector must survive, detached from the configuration. */
> +	KUNIT_EXPECT_EQ(test, kref_read(&connector_cfg->refcnt), 1);
> +	KUNIT_EXPECT_TRUE(test, connector_cfg->unlinked);
> +
> +	/* Last reference: connector and configuration are freed here. */
> +	vkms_config_connector_put(connector_cfg);
> +}
> +
> +static void vkms_lifecycle_test_connector_static_drmm_release(struct kunit *test)
> +{
> +	struct vkms_config *config;
> +
> +	config = vkms_config_default_create(true, true, false, false);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
> +	vkms_lifecycle_test_set_unique_name(test, config, test->name);
> +
> +	KUNIT_ASSERT_EQ(test, vkms_create(config), 0);
> +
> +	/* vkms_destroy() runs the drmm action, which frees and detaches the connector. */
> +	vkms_destroy(config);
> +	vkms_config_destroy(config);
> +}
> +
> +static struct kunit_case vkms_lifecycle_test_cases[] = {
> +	KUNIT_CASE(vkms_lifecycle_test_create_destroy_default),
> +	KUNIT_CASE(vkms_lifecycle_test_create_destroy_with_overlay),
> +	KUNIT_CASE(vkms_lifecycle_test_create_destroy_with_pipeline),
> +	KUNIT_CASE(vkms_lifecycle_test_create_destroy_minimal),
> +	KUNIT_CASE(vkms_lifecycle_test_create_destroy_writeback),
> +	KUNIT_CASE(vkms_lifecycle_test_stress_many_cycles),
> +	KUNIT_CASE(vkms_lifecycle_test_interleaved_create_destroy),
> +	KUNIT_CASE(vkms_lifecycle_test_destroy_uncreated_device),
> +	KUNIT_CASE(vkms_lifecycle_test_double_destroy),
> +	KUNIT_CASE(vkms_lifecycle_test_create_after_destroy),
> +	KUNIT_CASE(vkms_lifecycle_test_connector_ref_outlives_config),
> +	KUNIT_CASE(vkms_lifecycle_test_connector_static_drmm_release),
> +	{}
> +};
> +
> +static struct kunit_suite vkms_lifecycle_test_suite = {
> +	.name = "vkms-lifecycle",
> +	.test_cases = vkms_lifecycle_test_cases,
> +};
> +
> +kunit_test_suite(vkms_lifecycle_test_suite);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("KUnit test for VKMS device lifecycle, aiming to catch UAF and memory issues");
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 24572bc779b4..f73f136e5588 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -18,6 +18,7 @@
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_colorop.h>
> +#include <kunit/visibility.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_fbdev_shmem.h>
>  #include <drm/drm_file.h>
> @@ -252,6 +253,7 @@ static int __init vkms_init(void)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(vkms_create);
>  
>  void vkms_destroy(struct vkms_config *config)
>  {
> @@ -271,6 +273,7 @@ void vkms_destroy(struct vkms_config *config)
>  
>  	config->dev = NULL;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(vkms_destroy);
>  
>  static void __exit vkms_exit(void)
>  {
> 
> -- 
> 2.56.0
> 

Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>
