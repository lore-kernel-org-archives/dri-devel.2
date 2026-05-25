Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95A8CD5BD5
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 533A510E318;
	Mon, 25 May 2026 13:05:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WKIT4LGW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6888E10E318;
 Mon, 25 May 2026 13:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779714342; x=1811250342;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=a8gnzDoSfgaEEDH5pXOUUXfrlR+0QEXO0LFuUGmlqGk=;
 b=WKIT4LGWVY+nJGbLZrGTzTGYjSHrauwOP34KaPP7KSXKcFOpIwE4teFt
 pwlltdXWnAxnQFHs/bx8lHarsPXKFZSJDo8VI4eLtNg66P+81sLBFirV4
 4IDLDKStYlO5n3PLDlBgYFfx/HovM8LU8+IY2O/Mu2D2VOmQqk3lWKdd5
 6jO5nqlP2yDsGnNqiXYdBFSCNC16fI+2TLOCRJscP4ncLW3HQvA2Anku8
 tbLMDiUi94OzAqYZ7afJC0x3i9EFWEE9jZiKEd4q8+fZZQ+MwS55vWU9A
 ExC76/QncaqH4pfUSOZE/jZAB8zb/fH+EJxz0jo4Ue8CXKzk0f3sh2fMp Q==;
X-CSE-ConnectionGUID: 7Fp7b3DTSmWm8cKEB7iVWA==
X-CSE-MsgGUID: ENeVoeGTQeiJ46lccR32bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80719963"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="80719963"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 06:05:42 -0700
X-CSE-ConnectionGUID: 9OOSjg3DTuuZ7d/AaJJqFA==
X-CSE-MsgGUID: E8zhZ4JyTpyh0OY+GsQ0Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="246571209"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.245.216])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 06:05:37 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Sean Paul <seanpaul@google.com>
Cc: Sean Paul <sean@poorly.run>, intel-gfx@lists.freedesktop.org, Rodrigo
 Vivi <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915/color: Fix plane color pipeline programming bugs
In-Reply-To: <CAOw6vbL-+YZED15LFH0PRbxWbKhkOohNd+fnJMmVtdvF=A31RQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260521180143.2143262-1-sean@poorly.run>
 <6d8e36e2aea806f9973b3c501aad4523f7316d6a@intel.com>
 <CAOw6vbL-+YZED15LFH0PRbxWbKhkOohNd+fnJMmVtdvF=A31RQ@mail.gmail.com>
Date: Mon, 25 May 2026 16:05:34 +0300
Message-ID: <e1f3d92808cf17842525815ee23ae0ee6e1064e4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Thu, 21 May 2026, Sean Paul <seanpaul@google.com> wrote:
> On Thu, May 21, 2026 at 2:39=E2=80=AFPM Jani Nikula <jani.nikula@linux.in=
tel.com> wrote:
>>
>> On Thu, 21 May 2026, Sean Paul <sean@poorly.run> wrote:
>> > From: Sean Paul <seanpaul@google.com>
>> >
>> > Fix two bugs in the plane-level color pipeline programming:
>> > 1. Fix a step discontinuity in the Post-CSC Gamma LUT when SDR dimming
>> >    is active by clamping Segment 2 to the last user-provided LUT entry
>> >    value instead of hardcoding it to 1.0 (1 << 24).
>> > 2. Fix a typo in the loop condition in xelpd_program_plane_pre_csc_lut
>> >    for Segment 2 degamma programming, changing 'while (i++ > 130)' to
>> >    'while (i++ < 130)'. Also clamp Segment 2 to the last user-provided
>> >    LUT entry value instead of hardcoding it to 1.0 (1 << 24) to fix
>> >    a step discontinuity similar to the Post-CSC fix.
>>
>> One fix per patch, please.
>
> Ack
>
>>
>> For #2 there's already [1].
>
> This isn't in drm-tip or drm-intel afaict. I'll drop it out of my set,
> but could you please apply it?

It's been merged.

The v2 replies here confused poor patchwork, please resend the patches
as a new thread.

BR,
Jani.

>
> Sean
>
>>
>> BR,
>> Jani.
>>
>> [1] https://lore.kernel.org/r/20260519075245.383864-1-pranay.samala@inte=
l.com
>>
>> >
>> > Signed-off-by: Sean Paul <seanpaul@google.com>
>> > ---
>> >  drivers/gpu/drm/i915/display/intel_color.c | 11 ++++++-----
>> >  1 file changed, 6 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/=
drm/i915/display/intel_color.c
>> > index 2d318e922671..9b807b024ec3 100644
>> > --- a/drivers/gpu/drm/i915/display/intel_color.c
>> > +++ b/drivers/gpu/drm/i915/display/intel_color.c
>> > @@ -3953,6 +3953,7 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb=
 *dsb,
>> >       enum plane_id plane =3D to_intel_plane(state->plane)->id;
>> >       const struct drm_color_lut32 *pre_csc_lut =3D plane_state->hw.de=
gamma_lut->data;
>> >       u32 i, lut_size;
>> > +     u32 lut_val =3D 1 << 24;
>> >
>> >       if (icl_is_hdr_plane(display, plane)) {
>> >               lut_size =3D 128;
>> > @@ -3963,7 +3964,7 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb=
 *dsb,
>> >
>> >               if (pre_csc_lut) {
>> >                       for (i =3D 0; i < lut_size; i++) {
>> > -                             u32 lut_val =3D drm_color_lut32_extract(=
pre_csc_lut[i].green, 24);
>> > +                             lut_val =3D drm_color_lut32_extract(pre_=
csc_lut[i].green, 24);
>> >
>> >                               intel_de_write_dsb(display, dsb,
>> >                                                  PLANE_PRE_CSC_GAMC_DA=
TA_ENH(pipe, plane, 0),
>> > @@ -3975,8 +3976,8 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb=
 *dsb,
>> >                       do {
>> >                               intel_de_write_dsb(display, dsb,
>> >                                                  PLANE_PRE_CSC_GAMC_DA=
TA_ENH(pipe, plane, 0),
>> > -                                                (1 << 24));
>> > -                     } while (i++ > 130);
>> > +                                                lut_val);
>> > +                     } while (i++ < 130);
>> >               } else {
>> >                       for (i =3D 0; i < lut_size; i++) {
>> >                               u32 v =3D (i * ((1 << 24) - 1)) / (lut_s=
ize - 1);
>> > @@ -4023,11 +4024,11 @@ xelpd_program_plane_post_csc_lut(struct intel_=
dsb *dsb,
>> >                                                  lut_val);
>> >                       }
>> >
>> > -                     /* Segment 2 */
>> > +                     /* Segment 2 - clamp to the last LUT value to pr=
event step discontinuity */
>> >                       do {
>> >                               intel_de_write_dsb(display, dsb,
>> >                                                  PLANE_POST_CSC_GAMC_D=
ATA_ENH(pipe, plane, 0),
>> > -                                                (1 << 24));
>> > +                                                lut_val);
>> >                       } while (i++ < 34);
>> >               } else {
>> >                       /*TODO: Add for segment 0 */
>>
>> --
>> Jani Nikula, Intel

--=20
Jani Nikula, Intel
