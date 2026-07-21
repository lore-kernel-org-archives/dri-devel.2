Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B49C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 09:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F8A310E893;
	Tue, 21 Jul 2026 09:46:45 +0000 (UTC)
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com
 [91.218.175.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FA6E10E30A
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 09:46:42 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 17:46:19 +0800
Message-Id: <DK45JBYJ8H1N.27UGNR6GBI6J5@oss.qualcomm.com>
Cc: "Ze Huang" <ze.huang@oss.qualcomm.com>,
 <sashiko-reviews@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <Frank.Li@kernel.org>, <imx@lists.linux.dev>
Subject: Re: [PATCH v2] drm/imx: replace struct drm_simple_display_pipe with
 regular atomic helpers
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: "Maxime Ripard" <mripard@redhat.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>
References: <20260716-drm-simple-kms-removal-v2-1-7e4a6b8528e6@oss.qualcomm.com>
 <20260716091459.1D8101F000E9@smtp.kernel.org>
 <DK1XPK73QJHC.JWFUMTTLOD1D@oss.qualcomm.com>
 <63cca05a-ec83-430c-abcf-c2f0b508446f@suse.de>
 <20260720-bold-jasmine-goldfish-d979e5@penduick>
In-Reply-To: <20260720-bold-jasmine-goldfish-d979e5@penduick>
X-Migadu-Flow: FLOW_OUT
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

On Mon Jul 20, 2026 at 10:08 PM CST, Maxime Ripard wrote:
> On Mon, Jul 20, 2026 at 02:36:19PM +0200, Thomas Zimmermann wrote:
>> Hi
>>=20
>> Am 18.07.26 um 21:12 schrieb Ze Huang:
>> [...]
>> > > > -	if (event) {
>> > > > -		crtc->state->event =3D NULL;
>> > > > +static int imx_lcdc_plane_helper_atomic_check(struct drm_plane *p=
lane,
>> > > > +					      struct drm_atomic_commit *commit)
>> > > > +{
>> > > > +	struct drm_plane_state *plane_state =3D drm_atomic_get_new_plane=
_state(commit, plane);
>> > > > +	struct drm_crtc *crtc =3D plane_state->crtc;
>> > > > +	struct drm_crtc_state *crtc_state =3D NULL;
>> > > > -		spin_lock_irq(&crtc->dev->event_lock);
>> > > > +	if (crtc)
>> > > > +		crtc_state =3D drm_atomic_get_new_crtc_state(commit, crtc);
>> > > > -		if (crtc->state->active && drm_crtc_vblank_get(crtc) =3D=3D 0)
>> > > > -			drm_crtc_arm_vblank_event(crtc, event);
>> > > > -		else
>> > > > -			drm_crtc_send_vblank_event(crtc, event);
>> > > > +	return drm_atomic_helper_check_plane_state(plane_state, crtc_sta=
te,
>> > > [Severity: High]
>> > > Can fetching the CRTC state this way cause a kernel panic in the cor=
e atomic
>> > > helpers?
>> > >=20
>> > > If userspace submits a commit that modifies only plane properties wi=
thout
>> > > affecting the CRTC, the CRTC is not implicitly added to the atomic c=
ommit
>> > > state.
>> > >=20
>> > > In this scenario, drm_atomic_get_new_crtc_state() returns NULL. Pass=
ing this
>> > > NULL pointer directly to drm_atomic_helper_check_plane_state() cause=
s a crash
>> > > when it dereferences crtc_state->enable.
>> > >=20
>> > > Could this use drm_atomic_get_crtc_state() instead to ensure the sta=
te is
>> > > brought into the commit if it is missing?
>> > I think it is fine here; I'll just copy the pattern from [1].
>> >=20
>> > [1] https://elixir.bootlin.com/linux/v7.1.2/source/drivers/gpu/drm/mga=
g200/mgag200_mode.c#L487
>>=20
>> It could be that there's a long standing problem in the overall logic. N=
ot
>> having a CRTC (and hence crtc_state) should also mean !fb, so we'd retur=
n at
>> [1]. If we have a CRTC on the plane but pass a crtc_state of NULL, we co=
uld
>> get a panic at [2], where it does crtc_state->crtc.=C2=A0 I'm not aware =
of any
>> bug reports about this problem, but it's still an issue.
>>=20
>> A number of drivers get this wrong by using
>> drm_atomic_helper_get_new_crtc_state(). The bot suggests to use
>> drm_atomic_helper_get_crtc_state() instead.=C2=A0 This helper also retur=
ns the
>> new state. But=C2=A0 if there's no new state, it duplicates the CRTC's e=
xisting
>> state. That's a bit of an overhead, but probably not an issue.=C2=A0 Sev=
eral
>> drivers use this helper, but also get it wrong. They tend to return earl=
y in
>> the case of !crtc or !fb without calling _check_plane_state(). See [3] a=
nd
>> [4] for examples.
>>=20
>> I think, going with the bot's suggestion to use
>> drm_atomic_helper_get_crtc_state() might be the best resolution for now.=
 It
>> still needs a crtc pointer, so the pattern is
>>=20

Thank you Thomas and Maxime for the detailed explanations.

I will follow the suggested pattern here:

>> crtc_state =3D NULL
>> if (plane_state->crtc)
>> =C2=A0 =C2=A0 crtc_state =3D drm_atomic_helper_get_crtc_state(plane_stat=
e->crtc)
>>=20
>> _check_plane_state(plane_state, crtc_state);

IIUC, atomic_check is the last stage where valid to extend commit state.
After that, the state is fixed and helpers should only use
get_new_crtc_state() or get_old_crtc_state().

My only remaining question is about the doc warning [1]:

  * WARNING: Drivers may only add new CRTC states to a @state if
  * drm_atomic_state.allow_modeset is set, or if it's a driver-internal
  * commit not created by userspace through an IOCTL call.

if we end up adding the CRTC state for a userspace non-modeset commit,
it could hit the requested/affected CRTC warning in
drm_atomic_check_only() [2]. That would still be more acceptable than
crashing, though.

[1] https://elixir.bootlin.com/linux/v7.1.3/source/drivers/gpu/drm/drm_atom=
ic.c#L355
[2] https://elixir.bootlin.com/linux/v7.1.3/source/drivers/gpu/drm/drm_atom=
ic.c#L1746

Thanks,
Ze

>>=20
>> And in this case, _check_plane_state() should work correctly. But you ca=
n
>> only use _get_crtc_state() in the atomic_check helpers! In the
>> atomic_update, atomic_enable, etc helpers, it's too late for the helper =
to
>> copy the CRTC state.
>>=20
>> I think some other DRM dev should look over this as well. It's one of th=
e
>> trickier things in DRM to get right.
>
> drm_atomic_helper_get_crtc_state is safe in atomic_check. It's
> everything after that must use either get_new_crtc_state or
> get_old_crtc_state, as the global state cannot be modified anymore.
>
> Maxime


