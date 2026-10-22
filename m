Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA131606A326
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=RqXbR505
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DEE510E47F;
	Thu, 22 Oct 2026 21:10:35 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1C4810E47F
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 21:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=kzCUZY7PIb9I9YRhQJpxedmyaV7krb3GSjQv8r92ors=; b=RqXbR505PjcQ1K3Yqlz5lUhv+g
 xc+QiqUQp0ZdDdDzV+XMaDnx64+cwSIO2ePNOPpItvdziHQnF2aMEUy0jXOpszIVdFcfQr7oWbBhN
 da8e+gWNKU5rTAQ7eYU250oIQgPZkXnu4zDFCH9r0mf7hzfdjBn3aiODBtVg2fRtksoo+k7aiLp/B
 eAJYK7LpQdfq/u1wULHmU2t8L4iFG46knf5tJtjICtYnWJE49iOoPj7+gNqFx/wY+e49OQKqZAOQV
 NK//NXN5uXruEX780+vWmFajznezDki6h3zvtL3nXxBPVmsx25kcj7X7BSnLfI6+Zl36+VcDoZekf
 VDqZc+HQ==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=[192.168.1.133]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xK03O-007BVG-SE; Thu, 22 Oct 2026 23:10:27 +0200
Message-ID: <85a6e366-b6ae-4d60-897c-b04c7fbb273c@Igalia.com>
Date: Thu, 22 Oct 2026 14:10:22 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amd/display: Update colorop pipeline tests for
 new fixed matrix op
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20261022173655.2318987-1-John.Harrison@Igalia.com>
 <20261022173655.2318987-4-John.Harrison@Igalia.com>
 <sashiko-outbox-181891@kernel.org>
Content-Language: en-GB
From: John Harrison <John.Harrison@Igalia.com>
In-Reply-To: <sashiko-outbox-181891@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 10:50, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] drm/amd/display: undeclared DRM_COLOROP_FIXED_MATRIX breaks KUnit test build
> --
>
> commit fa1c05a038fce65c050bce3e6d89515560ce7081
> Author: John Harrison <John.Harrison@Igalia.com>
>
> drm/amd/display: Update colorop pipeline tests for new fixed matrix op
>
> This commit updates the expected colorop pipeline arrays in the amdgpu_dm
> KUnit tests to begin with DRM_COLOROP_FIXED_MATRIX.
>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
>> index 90cc5592ef5de..00f1d5b33b1f0 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
>> @@ -192,6 +192,7 @@ static void dm_expect_colorop_pipeline(struct kunit *test, struct drm_device *dr
>>   static void dm_test_initialize_default_pipeline(struct kunit *test)
>>   {
>>   	static const enum drm_colorop_type expected[] = {
>> +		DRM_COLOROP_FIXED_MATRIX,
>>   		DRM_COLOROP_1D_CURVE,	/* degam TF */
>>   		DRM_COLOROP_MULTIPLIER,
>>   		DRM_COLOROP_CTM_3X4,
>> @@ -257,6 +258,7 @@ static void dm_test_initialize_default_pipeline_caps(struct kunit *test,
>>   static void dm_test_initialize_default_pipeline_dpp_3d_lut(struct kunit *test)
>>   {
>>   	static const enum drm_colorop_type expected[] = {
>> +		DRM_COLOROP_FIXED_MATRIX,
>>   		DRM_COLOROP_1D_CURVE,
>>   		DRM_COLOROP_MULTIPLIER,
>>   		DRM_COLOROP_CTM_3X4,
>> @@ -278,6 +280,7 @@ static void dm_test_initialize_default_pipeline_dpp_3d_lut(struct kunit *test)
>>   static void dm_test_initialize_default_pipeline_mpc_preblend(struct kunit *test)
>>   {
>>   	static const enum drm_colorop_type expected[] = {
>> +		DRM_COLOROP_FIXED_MATRIX,
>>   		DRM_COLOROP_1D_CURVE,
>>   		DRM_COLOROP_MULTIPLIER,
>>   		DRM_COLOROP_CTM_3X4,
>> @@ -299,6 +302,7 @@ static void dm_test_initialize_default_pipeline_mpc_preblend(struct kunit *test)
>>   static void dm_test_initialize_default_pipeline_no_3d_lut(struct kunit *test)
>>   {
>>   	static const enum drm_colorop_type expected[] = {
>> +		DRM_COLOROP_FIXED_MATRIX,
>>   		DRM_COLOROP_1D_CURVE,
>>   		DRM_COLOROP_MULTIPLIER,
>>   		DRM_COLOROP_CTM_3X4,
> [Severity: Medium]
> Does this break the build when CONFIG_DRM_AMD_DC_KUNIT_TEST is enabled?
>
> This patch adds DRM_COLOROP_FIXED_MATRIX to the expected[] arrays in
> dm_test_initialize_default_pipeline(),
> dm_test_initialize_default_pipeline_dpp_3d_lut(),
> dm_test_initialize_default_pipeline_mpc_preblend(), and
> dm_test_initialize_default_pipeline_no_3d_lut() in
> drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c.
>
> The commit references Fixes: 6d103ad11583 ("drm/amd/display: Add fixed matrix
> colorop to color pipeline"), which in turn depends on f6c58e4ae87c
> ("drm/colorop: Add DRM_COLOROP_FIXED_MATRIX"), but neither commit is present
> in this branch.
>
> In include/uapi/drm/drm_mode.h, enum drm_colorop_type does not define
> DRM_COLOROP_FIXED_MATRIX:
>
>      enum drm_colorop_type {
>              DRM_COLOROP_1D_CURVE,
>              DRM_COLOROP_1D_LUT,
>              DRM_COLOROP_CTM_3X4,
>              DRM_COLOROP_MULTIPLIER,
>              DRM_COLOROP_3D_LUT,
>      };
>
> In addition, amdgpu_dm_build_default_pipeline() in
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c still starts the
> default pipeline with DRM_COLOROP_1D_CURVE:
>
>      /* 1D curve - DEGAM TF */
>      ops[i] = colorop_kzalloc_obj();
>      if (!ops[i]) {
>              ret = -ENOMEM;
>              goto cleanup;
>      }
>
>      ret = colorop_curve_1d_init(dev, ops[i], plane, &dm_colorop_funcs,
>                                  amdgpu_dm_supported_degam_tfs,
>                                  DRM_COLOROP_FLAG_ALLOW_BYPASS);
>
> Should this patch only be applied to a branch that already contains commits
> f6c58e4ae87c and 6d103ad11583?
>
What branch is Sashiko using? The web page report says it is based on 
77f548b127c6de34ce271fa09ba270cb1ef9f2da which is a hash that does not 
exist in any tree I have locally. My patches are based on drm-tip, which 
very definitely contains the FIXED_MATRIX support (merged August 27th 
according to the patch itself).

John.

