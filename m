Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7DBC5DF86
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 19:20:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FD5810F173;
	Thu, 20 Aug 2026 19:20:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b+T//hQc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 709A710F16E;
 Thu, 20 Aug 2026 19:20:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 133C4414C3;
 Thu, 20 Aug 2026 19:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999551F000E9;
 Thu, 20 Aug 2026 19:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787253643;
 bh=c8sYhZELucWSPgVxwFHw1NRER/bn/rIXzWkl9h83cD4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=b+T//hQcQkVquzCqXS4W8Ekq1dN1VrHIB1hce1yUjhuXGNCn8fUk0xenQ2FCSbZW9
 fMc1rycOxsLezLkjbyj/m69A9yLr/ZiqEnYEaGuvfhQBi/aHnJFoOfrS3ycUc1BSLp
 pTSRJw+EuHYW9ZzmBCuPNbxZvhHpYzdnZnHoqZtmCUqqO1oNIJFE+iGJE9n6Ow7xkH
 Y0zz0HTv0GGdJ7r5rEfa08YOLJesdDqG5niEld+4yhqL+yiglOcJbP2bTDZC3QHXI9
 h2lBrIY9VrGaDdn1Za/bEiUwF+WR5p7qtdfWRCDDbSMbBnIf8yb+7hLziB4eYDEW9s
 gF6U0BPCGsBHA==
Message-ID: <e48a854b-1240-4fcb-a429-2c02be10da5d@kernel.org>
Date: Thu, 20 Aug 2026 14:20:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Drop KUnit tests for removed
 parse_hdmi_amd_vsdb()
Content-Language: en-US
To: Rodrigo Vivi <rodrigo.vivi@intel.com>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Alex Huang <Alex.Huang2@amd.com>
References: <20260820142802.1342066-2-rodrigo.vivi@intel.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260820142802.1342066-2-rodrigo.vivi@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/20/26 09:28, Rodrigo Vivi wrote:
> parse_hdmi_amd_vsdb() was removed when HDMI FreeSync detection moved to
> the common EDID parser, but its declaration and KUnit tests remained,
> breaking modpost:
> 
>    ERROR: modpost: "parse_hdmi_amd_vsdb" [...connector_test.ko] undefined!
> 
> Remove the stale declaration and the three dead test cases.
> 
> Fixes: f65198b3d073 ("drm/amd/display: Use HDMI FreeSync range from common EDID parser")
> Cc: Alex Huang <Alex.Huang2@amd.com>
> Cc: Mario Limonciello <superm1@kernel.org>
> Assisted-by: Copilot:Claude-Opus-5
> Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> ---
Thanks this looks correct to me.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

I'm not sure where we should apply it though, it's from a conflict 
between drm-misc-next and Alex's drm-next pull.
>   .../display/amdgpu_dm/amdgpu_dm_connector.h   |  3 -
>   .../tests/amdgpu_dm_connector_test.c          | 73 -------------------
>   2 files changed, 76 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
> index 4e9eb3ff2c90..ce900844602e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
> @@ -153,9 +153,6 @@ void parse_edid_displayid_vrr(struct drm_connector *connector,
>   			      const struct edid *edid);
>   int get_amd_vsdb(struct amdgpu_dm_connector *aconnector,
>   		 struct amdgpu_hdmi_vsdb_info *vsdb_info);
> -int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
> -			const struct edid *edid,
> -			struct amdgpu_hdmi_vsdb_info *vsdb_info);
>   void amdgpu_dm_connector_funcs_force(struct drm_connector *connector);
>   enum dc_status dm_validate_stream_and_context(struct dc *dc,
>   					      struct dc_stream_state *stream);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
> index a54fd9529dc9..83d3be543202 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
> @@ -4874,75 +4874,6 @@ static void dm_test_get_amd_vsdb_supported(struct kunit *test)
>   	KUNIT_EXPECT_TRUE(test, vsdb_info.replay_mode);
>   }
>   
> -/**
> - * dm_test_parse_hdmi_amd_vsdb_null_edid - Test NULL EDID returns -ENODEV
> - * @test: The KUnit test context
> - */
> -static void dm_test_parse_hdmi_amd_vsdb_null_edid(struct kunit *test)
> -{
> -	struct amdgpu_dm_connector *aconnector;
> -	struct amdgpu_hdmi_vsdb_info vsdb_info = {0};
> -
> -	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
> -	KUNIT_ASSERT_NOT_NULL(test, aconnector);
> -
> -	KUNIT_EXPECT_EQ(test,
> -			parse_hdmi_amd_vsdb(aconnector, NULL, &vsdb_info),
> -			-ENODEV);
> -}
> -
> -/**
> - * dm_test_parse_hdmi_amd_vsdb_no_extensions - Test EDID without extensions
> - * @test: The KUnit test context
> - *
> - * An EDID that declares no extension blocks has no CEA block to parse.
> - */
> -static void dm_test_parse_hdmi_amd_vsdb_no_extensions(struct kunit *test)
> -{
> -	struct amdgpu_dm_connector *aconnector;
> -	struct amdgpu_hdmi_vsdb_info vsdb_info = {0};
> -	struct edid *edid;
> -
> -	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
> -	KUNIT_ASSERT_NOT_NULL(test, aconnector);
> -	edid = kunit_kzalloc(test, sizeof(*edid), GFP_KERNEL);
> -	KUNIT_ASSERT_NOT_NULL(test, edid);
> -
> -	edid->extensions = 0;
> -
> -	KUNIT_EXPECT_EQ(test,
> -			parse_hdmi_amd_vsdb(aconnector, edid, &vsdb_info),
> -			-ENODEV);
> -}
> -
> -/**
> - * dm_test_parse_hdmi_amd_vsdb_no_cea_ext - Test EDID with no CEA extension
> - * @test: The KUnit test context
> - *
> - * An extension block that is not a CEA block leaves no VSDB to parse.
> - */
> -static void dm_test_parse_hdmi_amd_vsdb_no_cea_ext(struct kunit *test)
> -{
> -	struct amdgpu_dm_connector *aconnector;
> -	struct amdgpu_hdmi_vsdb_info vsdb_info = {0};
> -	struct edid *edid;
> -	u8 *raw;
> -
> -	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
> -	KUNIT_ASSERT_NOT_NULL(test, aconnector);
> -
> -	/* Base block + one extension block that is NOT a CEA extension. */
> -	raw = kunit_kzalloc(test, 2 * EDID_LENGTH, GFP_KERNEL);
> -	KUNIT_ASSERT_NOT_NULL(test, raw);
> -	edid = (struct edid *)raw;
> -	edid->extensions = 1;
> -	raw[EDID_LENGTH] = DM_TEST_DISPLAYID_EXT;
> -
> -	KUNIT_EXPECT_EQ(test,
> -			parse_hdmi_amd_vsdb(aconnector, edid, &vsdb_info),
> -			-ENODEV);
> -}
> -
>   /**
>    * dm_test_parse_displayid_vrr_null_edid - Test NULL EDID leaves range untouched
>    * @test: The KUnit test context
> @@ -5647,10 +5578,6 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
>   	/* get_amd_vsdb */
>   	KUNIT_CASE(dm_test_get_amd_vsdb_unsupported),
>   	KUNIT_CASE(dm_test_get_amd_vsdb_supported),
> -	/* parse_hdmi_amd_vsdb */
> -	KUNIT_CASE(dm_test_parse_hdmi_amd_vsdb_null_edid),
> -	KUNIT_CASE(dm_test_parse_hdmi_amd_vsdb_no_extensions),
> -	KUNIT_CASE(dm_test_parse_hdmi_amd_vsdb_no_cea_ext),
>   	/* parse_edid_displayid_vrr */
>   	KUNIT_CASE(dm_test_parse_displayid_vrr_null_edid),
>   	KUNIT_CASE(dm_test_parse_displayid_vrr_no_displayid),

