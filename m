Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E50C61DD4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:45:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34C4410EF78;
	Thu, 27 Aug 2026 09:45:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=freenet.de header.i=@freenet.de header.b="UCXYE7kp";
	dkim-atps=neutral
Received: from mout.freenet.de (mout.freenet.de [194.97.212.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2016F10E208;
 Tue, 25 Aug 2026 18:57:22 +0000 (UTC)
Received: from [2001:748:400:1319::5] (helo=sub7.mail.fnrz.de)
 by mout3.mail.fnrz.de with esmtpa (ID viktor.jaegerskuepper@freenet.de) (port
 25) (Exim 4.98.2 #2) id 1wywKa-00000006T5j-0GWR;
 Tue, 25 Aug 2026 20:57:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de; 
 s=mjaymdexmjqk;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=jWLurX8RVOGPG1caSR8Fkl3oQ3/zoLa88KPfYJlQTfI=; b=UCXYE7kpfeNJPzW6m6k9rtELhh
 +Pgw0QSewj14njJOsY5vfF5mcL5wmMO0lh9wkdivDol6N3lVI2EBuMzMs7QqH6ADCnWbdTgeMppg/
 VBaAf876jKdr28cLWqx/SrLAwQKQmmsIA9NDpU6ODgHt0px/hsAq8sCMs5hIfjCeZzirNXRNI80do
 ASfKTloBs5X5h0qpq4jmpIpt1yvDcjqaClj6I4bXVx1TKmQ5wOilnVnfn59C7fnTiRApOIEh30yfV
 qQ1wI5dnivCv1F9lD+65ZdJYB9eFfvaWbQ7Zb/ERd6M/4xAG9AVg50bma7K6MBTRL1dvQldu3rkyD
 nPieXtZg==;
Authentication-Results: freenet.de;
 iprev=fail smtp.remote-ip=2a02:8071:a85:f020:3a1c:2bb:cc98:87a;
 auth=pass (PLAIN) smtp.auth=viktor.jaegerskuepper@freenet.de
Received: from [2a02:8071:a85:f020:3a1c:2bb:cc98:87a] (port=41120
 helo=[127.0.0.1])
 by sub7.mail.fnrz.de with esmtpsa (ID viktor.jaegerskuepper@freenet.de)
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (port 465) (Exim
 4.98.2 #2) id 1wywKZ-0000000BQrY-3iPD;
 Tue, 25 Aug 2026 20:57:07 +0200
Message-ID: <fed3be9d-1115-4910-8153-0c2940cbfa9d@freenet.de>
Date: Tue, 25 Aug 2026 20:56:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drm/amd/display: advertise PIXEL_NONE as blend
 mode for DCE generations
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
 Xaver Hugl <xaver.hugl@gmail.com>,
 =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?= <viktor_jaegerskuepper@freenet.de>
References: <20260813143605.106104-1-mwen@igalia.com>
 <20260813143605.106104-4-mwen@igalia.com>
 <512414f0-ca55-435e-8ca3-7dbf48d0c114@freenet.de>
 <2b6f24cb-c387-4174-9e81-0a1a7ef42581@freenet.de>
 <6faf80d8-2972-44a9-93f7-39ffee0d1fec@igalia.com>
Content-Language: en-US
From: =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?=
 <viktor_jaegerskuepper@freenet.de>
In-Reply-To: <6faf80d8-2972-44a9-93f7-39ffee0d1fec@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 17876842277E30DB55B4B1O
X-Scan-TS: Tue, 25 Aug 2026 20:57:07 +0200
X-Mailman-Approved-At: Thu, 27 Aug 2026 09:44:45 +0000
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

On 8/25/26 10:06, Melissa Wen wrote:
> 
> 
> On 24/08/2026 23:02, Viktor Jägersküpper wrote:
>> On 8/24/26 22:38, Viktor Jägersküpper wrote:
>>> [ Adding Timur ]
>>>
>>> On 8/13/26 16:30, Melissa Wen wrote:
>>>> DCE can support PREMULTI and COVERAGE blend mode depending on its
>>>> generation, however current driver implementation either doesn't expose
>>>> more than primary and cursor plane, or doesn't program registers for
>>>> any
>>>> blend mode other than PIXEL_NONE. To fix the missing-blend-mode-prop
>>>> warning according to current DCE plane caps, create blend mode property
>>>> with PIXEL_NONE only for primary planes, instead of the DRM default
>>>> PREMULTI.
>>>>
>>>> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel
>>>> format with alpha exposed")
>>>> Reviewed-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
>>>> Signed-off-by: Melissa Wen <mwen@igalia.com>
>>>>
>>>> ---
>>>> v3:
>>>> - fix indentation (Alex H)
>>>> ---
>>>>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 18 ++++++++++
>>>> +-------
>>>>   1 file changed, 11 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>>>> index ab9bbe8ca333..3b5b6943b67d 100644
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>>>> @@ -1923,14 +1923,18 @@ int amdgpu_dm_plane_init(struct
>>>> amdgpu_display_manager *dm,
>>>>       if (res)
>>>>           return res;
>>>>   -    /* TODO: Check which blend modes are supported in DCE-generation
>>>> -     * planes, i.e. DC_PLANE_TYPE_DCE_RGB/UNDERLAY and expose blend
>>>> mode
>>>> -     * property accordingly.
>>>> +    /* Blend mode support varies on DCE generations according to HW
>>>> caps
>>>> +     * and number of planes per CRTC. However, as current driver
>>>> +     * implementation only creates one primary and one cursor plane
>>>> per
>>>> +     * CRTC for DCE (overlay is only created if
>>>> +     * DC_PLANE_TYPE_DCN_UNIVERSAL), the primary plane blend mode
>>>> ends up
>>>> +     * being always PIXEL_NONE across DCE versions.
>>>>        */
>>>> -    if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
>>>> -         plane->type == DRM_PLANE_TYPE_PRIMARY) &&
>>>> -        plane_cap && plane_cap->per_pixel_alpha &&
>>>> -        plane_cap->type == DC_PLANE_TYPE_DCN_UNIVERSAL) {
>>>> +    if (plane_cap && plane_cap->type != DC_PLANE_TYPE_DCN_UNIVERSAL) {
>>>> +        drm_plane_create_blend_mode_property(plane,
>>>> BIT(DRM_MODE_BLEND_PIXEL_NONE));
>>>> +    } else if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
>>>> +            plane->type == DRM_PLANE_TYPE_PRIMARY) &&
>>>> +           plane_cap && plane_cap->per_pixel_alpha) {
>>>>           unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>>>>                         BIT(DRM_MODE_BLEND_PREMULTI) |
>>>>                         BIT(DRM_MODE_BLEND_COVERAGE);
>>> With this patch applied to the mainline kernel, my display freezes when
>>> Kwin is started (either by SDDM or by launching a KDE Plasma session).
>>> GDM and Gnome work fine. The journal doesn't have much information, it's
>>> mainly this:
> 
> I suspect KDE is not interpreting correctly the blend mode, but I think
> we can
> keep it working as before by adding PREMULTI. In the end there is no
> overlay
> plane for DCE, and PIXEL_NONE and PREMULTI are equivalent when one
> primary is composed on top of a black background.
> 
> Can you replace this commit by the patch attached?
> It might solve the issue as long as background continues being black.
> I didn't apply it to drm-misc, so let me know how does this new patch works
> on your side.
The attached patch solves the issue, I tested both KDE/SDDM and
Gnome/GDM, the warnings are gone as expected. You can add:

Tested-by: Viktor Jägersküpper <viktor_jaegerskuepper@freenet.de>

Thanks,
Viktor
