Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A863C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 09:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83E1B10E193;
	Fri, 10 Jul 2026 09:43:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LCM5EWps";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C427210E193;
 Fri, 10 Jul 2026 09:43:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7468C600C3;
 Fri, 10 Jul 2026 09:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080321F000E9;
 Fri, 10 Jul 2026 09:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783676633;
 bh=ScooFFYQ6XqRhiFCaNLKyuErrz6NYpqfC1wRjvlV+ns=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=LCM5EWpsBhoI+aOA/uhP9x2JilktKNSYRvDe7zJirGZ8QUpdGnp9yw1oGHn1xz2mn
 qpfFXbMIamacbuZMctW+J2ooUzIB0czQZyda6LJwzkKcSvbn/yY410kbrnrmIak02T
 rje9zmCCa3ODGUf+PbQmq4Nql4Pmr6QJP/yWQGyC3MnZdhAx3ar6/hetrQblnCc3eE
 X5fpZfIvVWWHMq+Fu5zZuI7/qJs0tP5kgBPIdI9fEnlGcbTaeeJjnqPdZ4T21eanLh
 GgZCCU8e+XLjroidStjpnqTnC9cWM/f1D95PQvkiv6wNgWtTJ8Tsnb2k3/bnVjlYGo
 MeBRmpoMjOGag==
Message-ID: <7d6c228b-9b2e-4b4a-93a8-339cd35bbd11@kernel.org>
Date: Fri, 10 Jul 2026 11:43:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/amd/display: amdgpu_dm_plane_test.ko fails to
 build due to modpost "too long symbol"
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Randy Dunlap <rdunlap@infradead.org>, amd-gfx@lists.freedesktop.org,
 bhawanpreet.lakha@amd.com
Cc: dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
 george.zhang@amd.com, LKML <linux-kernel@vger.kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, christian.koenig@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, broonie@kernel.org,
 Linux Next Mailing List <linux-next@vger.kernel.org>, alex.hung@amd.com
References: <fde3656e-9e22-4e4c-937f-7e8cb918da6b@linux.ibm.com>
 <54f6efe8-cab8-4fc8-bf00-f012b3224e54@infradead.org>
 <85931e07-60eb-4df2-bc52-773c63f27f6c@linux.ibm.com>
 <14e618d3-34ea-4bc9-b9a8-3783e2b61e0a@linux.ibm.com>
 <4ccaca42-03c0-40aa-9a4e-9b0514735b45@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <4ccaca42-03c0-40aa-9a4e-9b0514735b45@linux.ibm.com>
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



Le 10/07/2026 à 10:52, Venkat Rao Bagalkote a écrit :
> 
> On 10/07/26 1:31 pm, Venkat Rao Bagalkote wrote:
>>
>> On 10/07/26 10:45 am, Venkat Rao Bagalkote wrote:
>>>
>>> On 09/07/26 11:53 pm, Randy Dunlap wrote:
>>>>
>>>> On 7/7/26 10:05 PM, Venkat Rao Bagalkote wrote:
>>>>> Greetings!!!
>>>>>
>>>>> linux-next is failing to build for me with:
>>>>>
>>>>> ERROR: modpost: too long symbol

Comes from here I guess:

/**
  * Record CRCs for unresolved symbols
  **/
static void add_versions(struct buffer *b, struct module *mod)
{
	struct symbol *s;

	if (!basic_modversions)
		return;

	buf_printf(b, "\n");
	buf_printf(b, "static const struct modversion_info ____versions[]\n");
	buf_printf(b, "__used __section(\"__versions\") = {\n");

	list_for_each_entry(s, &mod->unresolved_symbols, list) {
		if (!s->module)
			continue;
		if (!s->crc_valid) {
			warn("\"%s\" [%s.ko] has no CRC!\n",
				s->name, mod->name);
			continue;
		}
		if (strlen(s->name) >= MODULE_NAME_LEN) {
			if (extended_modversions) {
				/* this symbol will only be in the extended info */
				continue;
			} else {
				error("too long symbol \"%s\" [%s.ko]\n",
				      s->name, mod->name);
				break;
			}
		}
		buf_printf(b, "\t{ 0x%08x, \"%s\" },\n",
			   s->crc, s->name);
	}

	buf_printf(b, "};\n");
}

Where:

include/linux/module.h:#define MODULE_NAME_LEN __MODULE_NAME_LEN
include/linux/moduleparam.h:#define __MODULE_NAME_LEN (64 - 
sizeof(unsigned long))

> 
> I bisected this build failure and found that it is caused by the exported
> KUnit symbols:
> 
>    amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers()
>    amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers()
> 
> modpost rejects the resulting exported symbol name with:
> 
>    ERROR: modpost: too long symbol
>    "amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers"
> 
> I tested the following approach locally, which simply shortens the helper
> names to:
> 
>    amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers()
>    amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers()
> 
> and updated all corresponding users and KUnit references. This resolves the
> build issue for me and does not appear to introduce any functional changes.
> 
> Does this look like an acceptable fix?

Yes most likely. The alternat fix would be to increase MODULE_NAME_LEN 
but that would mean increasing the size of several tables for just 2 
symbols which are too long ?

Christophe

> 
> If so, I'll prepare and send a formal patch with proper changelog.
> 
> 
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/ 
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 1b564cfe2120..b58225338bc4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -328,7 +328,7 @@ STATIC_IFN_KUNIT int 
> amdgpu_dm_plane_validate_dcc(struct amdgpu_device *adev,
>   }
>   EXPORT_IF_KUNIT(amdgpu_dm_plane_validate_dcc);
> 
> -STATIC_IFN_KUNIT int 
> amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(struct 
> amdgpu_device *adev,
> +STATIC_IFN_KUNIT int 
> amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(struct amdgpu_device *adev,
>               const struct amdgpu_framebuffer *afb,
>               const enum surface_pixel_format format,
>               const enum dc_rotation_angle rotation,
> @@ -378,9 +378,9 @@ STATIC_IFN_KUNIT int 
> amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(s
> 
>          return ret;
>   }
> - 
> EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers);
> +EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers);
> 
> -STATIC_IFN_KUNIT int 
> amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(struct 
> amdgpu_device *adev,
> +STATIC_IFN_KUNIT int 
> amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(struct amdgpu_device *adev,
>                const struct amdgpu_framebuffer *afb,
>                const enum surface_pixel_format format,
>                const enum dc_rotation_angle rotation,
> @@ -419,7 +419,7 @@ STATIC_IFN_KUNIT int 
> amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(
> 
>          return ret;
>   }
> - 
> EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers);
> +EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers);
> 
>   static void amdgpu_dm_plane_add_gfx10_1_modifiers(const struct 
> amdgpu_device *adev,
>                                                    uint64_t **mods,
> @@ -927,14 +927,14 @@ int 
> amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
>          }
> 
>          if (adev->family == AMDGPU_FAMILY_GC_12_0_0) {
> -               ret = 
> amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(adev, afb, 
> format,
> +               ret = 
> amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(adev, afb, format,
>                 rotation, plane_size,
>                 tiling_info, dcc,
>                 address);
>                  if (ret)
>                          return ret;
>          } else if (adev->family >= AMDGPU_FAMILY_AI) {
> -               ret = 
> amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(adev, afb, 
> format,
> +               ret = 
> amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(adev, afb, format,
>                rotation, plane_size,
>                tiling_info, dcc,
>                address);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/ 
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> index 911fb2d73e22..55c33e051aee 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> @@ -92,7 +92,7 @@ int amdgpu_dm_plane_get_plane_modifiers(struct 
> amdgpu_device *adev,
>   int amdgpu_dm_plane_get_plane_formats(const struct drm_plane *plane,
>                                        const struct dc_plane_cap 
> *plane_cap,
>                                        uint32_t *formats, int max_formats);
> -int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(struct 
> amdgpu_device *adev,
> +int amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(struct amdgpu_device 
> *adev,
> const struct amdgpu_framebuffer *afb,
> const enum surface_pixel_format format,
> const enum dc_rotation_angle rotation,
> @@ -100,7 +100,7 @@ int 
> amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(struct 
> amdgpu_devi
> struct dc_tiling_info *tiling_info,
> struct dc_plane_dcc_param *dcc,
> struct dc_plane_address *address);
> -int amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(struct 
> amdgpu_device *adev,
> +int amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(struct 
> amdgpu_device *adev,
>   const struct amdgpu_framebuffer *afb,
>   const enum surface_pixel_format format,
>   const enum dc_rotation_angle rotation,
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
> amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
> amdgpu_dm_plane_test.c
> index 46c9af432e37..fc84f5a08596 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
> @@ -579,7 +579,7 @@ static void 
> dm_test_fill_gfx12_plane_attributes_from_modifiers(struct kunit *tes
>          plane_size.surface_size.height = 1080;
> 
>          KUNIT_EXPECT_EQ(test,
> -  amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(
> +  amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(
>                          adev, afb, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888,
>                          ROTATION_ANGLE_0, &plane_size, &tiling_info, 
> &dcc, &address),
>                          0);
> @@ -623,7 +623,7 @@ static void 
> dm_test_fill_gfx9_plane_attributes_from_modifiers(struct kunit *test
>          afb->base.modifier = DRM_FORMAT_MOD_LINEAR;
> 
>          KUNIT_EXPECT_EQ(test,
> -  amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(
> +  amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(
>                          adev, afb, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888,
>                          ROTATION_ANGLE_0, &plane_size, &tiling_info, 
> &dcc, &address),
>                          0);
> @@ -1187,9 +1187,9 @@ static struct kunit_case 
> amdgpu_dm_plane_test_cases[] = {
>          KUNIT_CASE(dm_test_get_cursor_position),
>          /* amdgpu_dm_plane_format_mod_supported() */
>          KUNIT_CASE(dm_test_format_mod_supported),
> -       /* amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers() */
> +       /* amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers() */
> KUNIT_CASE(dm_test_fill_gfx12_plane_attributes_from_modifiers),
> -       /* amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers() */
> +       /* amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers() */
> KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_from_modifiers),
>          /* amdgpu_dm_plane_helper_check_state() */
>          KUNIT_CASE(dm_test_helper_check_state_viewport_reject),
> (END)
> 
> 
> Regards,
> 
> Venkat.
> 
>>
>> # git bisect log
>> git bisect start
>> # status: waiting for both good and bad commits
>> # bad: [5c73cd9f0819c1c44e373e3dabb68318b1de1a12] Add linux-next 
>> specific files for 20260707
>> git bisect bad 5c73cd9f0819c1c44e373e3dabb68318b1de1a12
>> # good: [8cdeaa50eae8dad34885515f62559ee83e7e8dda] Linux 7.2-rc2
>> git bisect good 8cdeaa50eae8dad34885515f62559ee83e7e8dda
>> # good: [aac7863446a8e0cf380f4a5087bc3cdc9b8c14c0] Merge branch 
>> 'master' of https://eur01.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fherbert%2Fcryptodev-2.6.git&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cc5e7652b93e744143d1c08dede60b05d%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639192704027107259%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=4ydIlQe8Bb3klMVrBmwYKnhK77MZUni2JbITolWJGzM%3D&reserved=0
>> git bisect good aac7863446a8e0cf380f4a5087bc3cdc9b8c14c0
>> # bad: [fe28d02cde5372d7f71cc6132ccdef37a98ac750] Merge branch 'for- 
>> linux-next' of https://eur01.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Fi915%2Fkernel.git&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cc5e7652b93e744143d1c08dede60b05d%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639192704027140053%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=BMbR68vSHUPlm7pZCpn7niZgDfYLQWogR6OX7yiaGEw%3D&reserved=0
>> git bisect bad fe28d02cde5372d7f71cc6132ccdef37a98ac750
>> # good: [0639cb26862afe4e35a689a8b5df8b9117c19f52] Merge tag 'drm-xe- 
>> next-2026-07-03' of https://eur01.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Fxe%2Fkernel&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cc5e7652b93e744143d1c08dede60b05d%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639192704027161672%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=LumG%2BM7C9w7R38jDyGYGHjbhjb6LZ3y%2F2J%2F82%2FZciZo%3D&reserved=0 into drm-next
>> git bisect good 0639cb26862afe4e35a689a8b5df8b9117c19f52
>> # good: [4e9c8a9c322427055c4892183d266ba391af1bc8] drm/amdkfd: drop 
>> struct kfd_signal_page wrapper
>> git bisect good 4e9c8a9c322427055c4892183d266ba391af1bc8
>> # bad: [ea33aa1545535fdb4c1a208b7bfd63314c3a4aa2] drm/amdgpu: Drop 
>> legacy ACA log RAS error data code
>> git bisect bad ea33aa1545535fdb4c1a208b7bfd63314c3a4aa2
>> # good: [a17e79d01f22182a9fcbe79fcbe2ad1477d43e0f] drm/amd/pm: 
>> Validate pp_table header before reading size
>> git bisect good a17e79d01f22182a9fcbe79fcbe2ad1477d43e0f
>> # bad: [7a561c2b1b63abcffb55f625c0d0adb68ab2961a] drm/amd/display: 
>> Simplify boolean checks
>> git bisect bad 7a561c2b1b63abcffb55f625c0d0adb68ab2961a
>> # good: [53ef33c084c5778cc2dcd1efff25e31b6e231141] drm/amd/pm: 
>> Validate Tonga PPTable subtable bounds
>> git bisect good 53ef33c084c5778cc2dcd1efff25e31b6e231141
>> # good: [fe5966d4fdcbed91e6b3478ea6c89d9915d6ed4a] drm/amdkfd: move 
>> TBA/TMA from system to device memory
>> git bisect good fe5966d4fdcbed91e6b3478ea6c89d9915d6ed4a
>> # good: [7a39b1c3b2e6b27f4230a20ccf9ac5a2737fa8b0] drm/amd/display: 
>> Replace repeated no-native-i2c checks with force_i2c_over_aux field
>> git bisect good 7a39b1c3b2e6b27f4230a20ccf9ac5a2737fa8b0
>> # good: [88ae862060f05cd8279e764832f04eafafa505d8] drm/amd/display: 
>> Add more KUnit tests for amdgpu_dm_colorop
>> git bisect good 88ae862060f05cd8279e764832f04eafafa505d8
>> # bad: [2b147895be109e0860269a7a72c697cdf049a885] drm/amd/display: Add 
>> kunit tests for amdgpu_dm_plane
>> git bisect bad 2b147895be109e0860269a7a72c697cdf049a885
>> # first bad commit: [2b147895be109e0860269a7a72c697cdf049a885] drm/ 
>> amd/display: Add kunit tests for amdgpu_dm_plane
>>
>>>
>>>
>>> Regards,
>>>
>>> Venkat.
>>

