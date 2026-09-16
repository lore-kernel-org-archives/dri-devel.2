Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075A6C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 05:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FB4B10E288;
	Wed, 16 Sep 2026 05:48:24 +0000 (UTC)
X-Greylist: delayed 365 seconds by postgrey-1.36 at gabe;
 Wed, 16 Sep 2026 05:48:22 UTC
Received: from mta0.migadu.com (out-145.mta0.migadu.com [91.218.175.145])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0571310E288
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 05:48:21 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 43fd191bf00716f2;
 Wed, 16 Sep 2026 05:42:13 +0000
X-Mizu-Trace-ID: 43fd191bf00716f2
X-Migadu-Flow: FLOW_OUT
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Sep 2026 13:42:07 +0800
Message-Id: <DLGI1ERWQ7ZU.2LGBZDSYVJUC9@oss.qualcomm.com>
Cc: <sashiko-reviews@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <Frank.Li@kernel.org>, <imx@lists.linux.dev>
Subject: Re: [PATCH v2] drm/imx: replace struct drm_simple_display_pipe with
 regular atomic helpers
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: "Thomas Zimmermann" <tzimmermann@suse.de>, "Ze Huang"
 <ze.huang@oss.qualcomm.com>, "Maxime Ripard" <mripard@redhat.com>
X-Mailer: aerc 0.21.0-146-gb5c16ebe1835
References: <20260716-drm-simple-kms-removal-v2-1-7e4a6b8528e6@oss.qualcomm.com>
 <20260716091459.1D8101F000E9@smtp.kernel.org>
 <DK1XPK73QJHC.JWFUMTTLOD1D@oss.qualcomm.com>
 <63cca05a-ec83-430c-abcf-c2f0b508446f@suse.de>
 <20260720-bold-jasmine-goldfish-d979e5@penduick>
 <DK45JBYJ8H1N.27UGNR6GBI6J5@oss.qualcomm.com>
 <c8e76f8f-aa64-44f1-93ad-b998c03ea731@suse.de>
In-Reply-To: <c8e76f8f-aa64-44f1-93ad-b998c03ea731@suse.de>
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

On Mon Sep 14, 2026 at 8:11 PM CST, Thomas Zimmermann wrote:
> Hi
>
> Am 21.07.26 um 11:46 schrieb Ze Huang:
>> On Mon Jul 20, 2026 at 10:08 PM CST, Maxime Ripard wrote:
>>> On Mon, Jul 20, 2026 at 02:36:19PM +0200, Thomas Zimmermann wrote:
>>>> Hi
>>>>
>>>> Am 18.07.26 um 21:12 schrieb Ze Huang:
>>>> [...]
>>>>>>> -	if (event) {
>>>>>>> -		crtc->state->event =3D NULL;
>>>>>>> +static int imx_lcdc_plane_helper_atomic_check(struct drm_plane *pl=
ane,
>>>>>>> +					      struct drm_atomic_commit *commit)
>>>>>>> +{
>>>>>>> +	struct drm_plane_state *plane_state =3D drm_atomic_get_new_plane_=
state(commit, plane);
>>>>>>> +	struct drm_crtc *crtc =3D plane_state->crtc;
>>>>>>> +	struct drm_crtc_state *crtc_state =3D NULL;
>>>>>>> -		spin_lock_irq(&crtc->dev->event_lock);
>>>>>>> +	if (crtc)
>>>>>>> +		crtc_state =3D drm_atomic_get_new_crtc_state(commit, crtc);
>>>>>>> -		if (crtc->state->active && drm_crtc_vblank_get(crtc) =3D=3D 0)
>>>>>>> -			drm_crtc_arm_vblank_event(crtc, event);
>>>>>>> -		else
>>>>>>> -			drm_crtc_send_vblank_event(crtc, event);
>>>>>>> +	return drm_atomic_helper_check_plane_state(plane_state, crtc_stat=
e,
>>>>>> [Severity: High]
>>>>>> Can fetching the CRTC state this way cause a kernel panic in the cor=
e atomic
>>>>>> helpers?
>>>>>>
>>>>>> If userspace submits a commit that modifies only plane properties wi=
thout
>>>>>> affecting the CRTC, the CRTC is not implicitly added to the atomic c=
ommit
>>>>>> state.
>>>>>>
>>>>>> In this scenario, drm_atomic_get_new_crtc_state() returns NULL. Pass=
ing this
>>>>>> NULL pointer directly to drm_atomic_helper_check_plane_state() cause=
s a crash
>>>>>> when it dereferences crtc_state->enable.
>>>>>>
>>>>>> Could this use drm_atomic_get_crtc_state() instead to ensure the sta=
te is
>>>>>> brought into the commit if it is missing?
>>>>> I think it is fine here; I'll just copy the pattern from [1].
>>>>>
>>>>> [1] https://elixir.bootlin.com/linux/v7.1.2/source/drivers/gpu/drm/mg=
ag200/mgag200_mode.c#L487
>>>> It could be that there's a long standing problem in the overall logic.=
 Not
>>>> having a CRTC (and hence crtc_state) should also mean !fb, so we'd ret=
urn at
>>>> [1]. If we have a CRTC on the plane but pass a crtc_state of NULL, we =
could
>>>> get a panic at [2], where it does crtc_state->crtc.=C2=A0 I'm not awar=
e of any
>>>> bug reports about this problem, but it's still an issue.
>>>>
>>>> A number of drivers get this wrong by using
>>>> drm_atomic_helper_get_new_crtc_state(). The bot suggests to use
>>>> drm_atomic_helper_get_crtc_state() instead.=C2=A0 This helper also ret=
urns the
>>>> new state. But=C2=A0 if there's no new state, it duplicates the CRTC's=
 existing
>>>> state. That's a bit of an overhead, but probably not an issue.=C2=A0 S=
everal
>>>> drivers use this helper, but also get it wrong. They tend to return ea=
rly in
>>>> the case of !crtc or !fb without calling _check_plane_state(). See [3]=
 and
>>>> [4] for examples.
>>>>
>>>> I think, going with the bot's suggestion to use
>>>> drm_atomic_helper_get_crtc_state() might be the best resolution for no=
w. It
>>>> still needs a crtc pointer, so the pattern is
>>>>
>> Thank you Thomas and Maxime for the detailed explanations.
>>
>> I will follow the suggested pattern here:
>>
>>>> crtc_state =3D NULL
>>>> if (plane_state->crtc)
>>>>  =C2=A0 =C2=A0 crtc_state =3D drm_atomic_helper_get_crtc_state(plane_s=
tate->crtc)
>>>>
>>>> _check_plane_state(plane_state, crtc_state);
>
> Is there an update to this patch available?

Yes, here:

https://lore.kernel.org/all/20260727-drm-simple-kms-removal-v3-0-de36e534f7=
a1@oss.qualcomm.com/

>
>> IIUC, atomic_check is the last stage where valid to extend commit state.
>> After that, the state is fixed and helpers should only use
>> get_new_crtc_state() or get_old_crtc_state().
>>
>> My only remaining question is about the doc warning [1]:
>>
>>    * WARNING: Drivers may only add new CRTC states to a @state if
>>    * drm_atomic_state.allow_modeset is set, or if it's a driver-internal
>>    * commit not created by userspace through an IOCTL call.
>
> I don't think this affects your work. If you just inline the existing=20
> simple-pipe it should be all good. (Or you duplicated existing bugs, but=
=20
> that doesn't make it worse either. :)
>
> Best regards
> Thomas

Thanks :)

>
>>
>> if we end up adding the CRTC state for a userspace non-modeset commit,
>> it could hit the requested/affected CRTC warning in
>> drm_atomic_check_only() [2]. That would still be more acceptable than
>> crashing, though.
>>
>> [1] https://elixir.bootlin.com/linux/v7.1.3/source/drivers/gpu/drm/drm_a=
tomic.c#L355
>> [2] https://elixir.bootlin.com/linux/v7.1.3/source/drivers/gpu/drm/drm_a=
tomic.c#L1746
>>
>> Thanks,
>> Ze
>>
>>>> And in this case, _check_plane_state() should work correctly. But you =
can
>>>> only use _get_crtc_state() in the atomic_check helpers! In the
>>>> atomic_update, atomic_enable, etc helpers, it's too late for the helpe=
r to
>>>> copy the CRTC state.
>>>>
>>>> I think some other DRM dev should look over this as well. It's one of =
the
>>>> trickier things in DRM to get right.
>>> drm_atomic_helper_get_crtc_state is safe in atomic_check. It's
>>> everything after that must use either get_new_crtc_state or
>>> get_old_crtc_state, as the global state cannot be modified anymore.
>>>
>>> Maxime
>>
