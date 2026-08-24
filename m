Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A8BC61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24D9910EA96;
	Tue, 25 Aug 2026 14:35:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=freenet.de header.i=@freenet.de header.b="oTEu54tt";
	dkim-atps=neutral
X-Greylist: delayed 310 seconds by postgrey-1.36 at gabe;
 Mon, 24 Aug 2026 21:08:22 UTC
Received: from mout.freenet.de (mout.freenet.de [194.97.196.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BAFB10E855;
 Mon, 24 Aug 2026 21:08:22 +0000 (UTC)
Received: from [2001:748:400:3319::3] (helo=sub3.mail.fnrz.de)
 by mout1.mail.fnrz.de with esmtpa (ID viktor.jaegerskuepper@freenet.de) (port
 25) (Exim 4.98.2 #2) id 1wybon-000000095oD-1h3T;
 Mon, 24 Aug 2026 23:02:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de; 
 s=mjaymdexmjqk;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=viTPtO4EzFiMbsW2bbZg0sPvHVefray1jcgiCguHwrA=; b=oTEu54ttXK8IrZCtWS7mimDlXk
 JFwSo2pza2oY1viKOIwL4NM0b7cQJztPha4E56Bd6JEA1QHdNFmiZuu/otApkLuMks+/i93SiU99V
 7mE1uPMma8itg4EE04bVlt/kGkAsPO5QFX/Rh+ri7Wyt24A5yzQNYYEl7Elc7tsFUkz3szZEnnjhH
 boB34UkxZNU8uToWBEZIPwKtKaYlmZAG3lj1leIkc7WOa8G9wz5KBgR7fpCWojr5xsFZX/0j91h7e
 nB0bCteGJ5grRsczF9a6Zi1Ht3sBjIHdqfP1bMTFfMkjYGAhZeuGxbJ1bQGLx3GJ0hgShCS3fBaTj
 41NF0nJA==;
Authentication-Results: freenet.de;
 iprev=fail smtp.remote-ip=2a02:8071:a85:f020:af10:fa7d:f150:7bea;
 auth=pass (PLAIN) smtp.auth=viktor.jaegerskuepper@freenet.de
Received: from [2a02:8071:a85:f020:af10:fa7d:f150:7bea] (port=46368
 helo=[127.0.0.1])
 by sub3.mail.fnrz.de with esmtpsa (ID viktor.jaegerskuepper@freenet.de)
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (port 465) (Exim
 4.98.2 #2) id 1wybon-00000003avf-0zxa;
 Mon, 24 Aug 2026 23:02:57 +0200
Message-ID: <2b6f24cb-c387-4174-9e81-0a1a7ef42581@freenet.de>
Date: Mon, 24 Aug 2026 23:02:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drm/amd/display: advertise PIXEL_NONE as blend
 mode for DCE generations
Content-Language: en-US
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, daniels@collabora.com,
 harry.wentland@amd.com, leandro.ribeiro@collabora.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Alex Hung <alex.hung@amd.com>, Daniel Wheeler <Daniel.Wheeler@amd.com>,
 kernel-dev@igalia.com, Lyude Paul <lyude@redhat.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?= <viktor_jaegerskuepper@freenet.de>
References: <20260813143605.106104-1-mwen@igalia.com>
 <20260813143605.106104-4-mwen@igalia.com>
 <512414f0-ca55-435e-8ca3-7dbf48d0c114@freenet.de>
From: =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?=
 <viktor_jaegerskuepper@freenet.de>
In-Reply-To: <512414f0-ca55-435e-8ca3-7dbf48d0c114@freenet.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 178760537745F70456E7ECO
X-Scan-TS: Mon, 24 Aug 2026 23:02:57 +0200
X-Mailman-Approved-At: Tue, 25 Aug 2026 14:35:48 +0000
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

On 8/24/26 22:38, Viktor Jägersküpper wrote:
> [ Adding Timur ]
> 
> On 8/13/26 16:30, Melissa Wen wrote:
>> DCE can support PREMULTI and COVERAGE blend mode depending on its
>> generation, however current driver implementation either doesn't expose
>> more than primary and cursor plane, or doesn't program registers for any
>> blend mode other than PIXEL_NONE. To fix the missing-blend-mode-prop
>> warning according to current DCE plane caps, create blend mode property
>> with PIXEL_NONE only for primary planes, instead of the DRM default
>> PREMULTI.
>>
>> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
>> Reviewed-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
>> Signed-off-by: Melissa Wen <mwen@igalia.com>
>>
>> ---
>> v3:
>> - fix indentation (Alex H)
>> ---
>>  .../amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 18 +++++++++++-------
>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> index ab9bbe8ca333..3b5b6943b67d 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> @@ -1923,14 +1923,18 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>>  	if (res)
>>  		return res;
>>  
>> -	/* TODO: Check which blend modes are supported in DCE-generation
>> -	 * planes, i.e. DC_PLANE_TYPE_DCE_RGB/UNDERLAY and expose blend mode
>> -	 * property accordingly.
>> +	/* Blend mode support varies on DCE generations according to HW caps
>> +	 * and number of planes per CRTC. However, as current driver
>> +	 * implementation only creates one primary and one cursor plane per
>> +	 * CRTC for DCE (overlay is only created if
>> +	 * DC_PLANE_TYPE_DCN_UNIVERSAL), the primary plane blend mode ends up
>> +	 * being always PIXEL_NONE across DCE versions.
>>  	 */
>> -	if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
>> -	     plane->type == DRM_PLANE_TYPE_PRIMARY) &&
>> -	    plane_cap && plane_cap->per_pixel_alpha &&
>> -	    plane_cap->type == DC_PLANE_TYPE_DCN_UNIVERSAL) {
>> +	if (plane_cap && plane_cap->type != DC_PLANE_TYPE_DCN_UNIVERSAL) {
>> +		drm_plane_create_blend_mode_property(plane, BIT(DRM_MODE_BLEND_PIXEL_NONE));
>> +	} else if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
>> +		    plane->type == DRM_PLANE_TYPE_PRIMARY) &&
>> +		   plane_cap && plane_cap->per_pixel_alpha) {
>>  		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>>  					  BIT(DRM_MODE_BLEND_PREMULTI) |
>>  					  BIT(DRM_MODE_BLEND_COVERAGE);
> 
> With this patch applied to the mainline kernel, my display freezes when
> Kwin is started (either by SDDM or by launching a KDE Plasma session).
> GDM and Gnome work fine. The journal doesn't have much information, it's
> mainly this:
> 
> kwin_wayland[8402]: Applying output configuration failed!
> 
> and after that several KDE processes with:
> 
> <kde_process>[xxxx]: There are no outputs - creating placeholder screen
> 
> Any idea how I can debug this further? Maybe ask the KDE developers?
> 
> With only the first two patches of this series applied, Kwin works as
> before, but I get the warnings of course.

I completely forgot that I'm observing this with AMD Pitcairn running
KDE 6.7.4 on Arch Linux. The kernel is built from source (mainline as of
today) with this patch series applied on top.

Viktor
