Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29C7606A33F
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PdMR4Vjf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 257101125A1;
	Fri, 13 Nov 2026 14:05:30 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FF2511258C
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 14:05:23 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c2af2ae1258so19443566b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 06:05:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794578722; cv=none;
 d=google.com; s=arc-20260327;
 b=GlC+EY9ZgRfNtrHfLahMXxm1WH1bMwAp9G5MZtSO/KuwbSCnbtMV/zp8c+A1/Dntm6
 Gdu03TM/3pNWjYB01qmN5sdI/y1tva3wh/dWEvh9/R32tngxKvbcLILeTl3lS3P/+oKR
 QWf5tzSg65SesF1ymWTN3wtXtEgGWkW4008FCFqDFxurixAcZdKSQFsIk/xBISNnMXI0
 GkVN9FBEM89n9TWEOCxZWqPXe0QBx813k12W8iGvrdjh+MoT1fgnszTxDM7fdpNUnQt+
 aZ+Ix9CHyOGjYfJphqaLy/MkmeDDxSu1Cus40yIyBOYlYeA/c/dw45oJBS0JHgXtSHbW
 gycQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DNr5TSnyeXCioTMiWAjRgZq6UDA4HuekgOMRX+0ndmc=;
 fh=9Wu2hgbczM6NwNxo7ojrqZzIyx+v2/UXeDqEh+GFmCE=;
 b=BcBcN5Drqawof8MlraQAOcRx90ryPM669bVm5VJXDj56wfTDwNa8ytWObzjvpaqgS9
 itTCpb+gymeGujNNOwako+BT3DXFRlL/jI2FEXc3dINf2cPh/ZUPilFBQ69Ngj5AwsTs
 j+kVI6fnt14R8hWDgv/5qyBiEPHKZDjIxl5LToCtkzTbm0vXa3zYI7aY6PwJ+2LDKUnK
 tkR+zy1y5ffqm4evJZ40XjAqD2mTxlW8+7C5oe9DNTuodUyaELZMwloGjaGKX98yjPks
 nqBZi2Vz04Zf6bkc/zinVjnQLX7DTr+FiJ6h3fqQ7sPUXbDmqQt8oMPefHFTzvsmWgeL
 Gziw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794578722; x=1795183522; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DNr5TSnyeXCioTMiWAjRgZq6UDA4HuekgOMRX+0ndmc=;
 b=PdMR4Vjfewm5KoR4MAi9q0oGjZymppiWkG2EjFhQNitr0kWfsvOhw2L/odSImK3Gma
 NeVzv4dKqDesR/CrXumvLNeVUnb8augd0zKVV5CD05BUmnBGFKiaeKP7BuamqU6qLdmG
 SyZB2LlfHvoEC+6OZZJJmxfJC9b08XgIldIw44SEzarCkCv0blYjOhDVPgrMAgKe4w3A
 VzDhg2KUpsqoeGbNsazjFB+je5Hqdx/avF+SWR2FX/FWRbfYtVwMSFg/3dU1PQJGW65M
 l0xR4+L2zzYL6KXrjKZ4HrjdXM5NNfLWJ9WIHp20Imp/I7N7qVU7b6IuHFNT0FpByzXr
 I3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794578722; x=1795183522;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DNr5TSnyeXCioTMiWAjRgZq6UDA4HuekgOMRX+0ndmc=;
 b=IP2OSHB+LzvSkmvGx0BLmv35iU5ihjs88gZk2QnKCXZOxgc0+UyWR9rlBO7L/1dPmT
 MzIK0fb0+KHovcyCWi1oadSf0krGDEvnqdKOuX/UJbA9T8XsIP5Vt1QuwAKogoOUWdSo
 xbkv5wkrhNqE/T2uXOt6mSVVEiVGGV71Ws4OsUbAGGeTTnnr4IRNzT9l0nHYCPL5LKab
 zZlDDJGnole/IGPGRVv8Xu7WCIaAgGm8yxBkXfV+gfmN8r3I70qFCoIkz1FVTxdigu65
 JWNBFhi4v0aFX4Lub5J4qF+BqokGxOmor/p9OPtnb4bygAWJiHOkUs3d+BG+UGr6NT93
 b4Ng==
X-Forwarded-Encrypted: i=1;
 AL+hErE9xs756OhMPB0s1ALP0NomiSYRijQN955pwI80En9aHtpDB9IVXgoqSLPRiq85oCl/tsCp5xq/Xtg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8IWQI/oidLB5/OvCdQ5Q32loyGbBkK7UnYsECS9mR4lIw6htVi
 18H1YVCPinH52YsVEHJIyVkuhOwRqT9RJHMr6HfY/TY6h5tkfEqBiUzG1SWmV4slQ/15/VcsKli
 bvj7rKaVcTGLv2+QsKEE8NcsMedDTFi4=
X-Gm-Gg: AYBFou2wP9K3yJt6rl98bXJxkMtAmQbnPUKoGQ1dN9p4roIOCrEHRNGHWKY9ImDmSgK
 62KnpoJ7WzYZOpoNXwC0PH7x13ZQ3vZdEQDBEUzMkFX3l3RwBVZpRMRuAG9z03JXBaHWUk/jXjm
 p1wTyON3MbyrZF4rV5BfpAIBtYfrQOToebonCCEGPu2YdO0D6PjBU/lnsX9YQYqP8+kzKMSkYHe
 PFk7uLOJj9nkflQtW4i/XPLGMKibo3/HnzQ4H2wM9OCqf05gbTAJmO30lan2u3F9PwKoEmpH7We
 Tr+AReY2Ho6hhvAQ3bxcvfO1uzTJOC90Oq+XK200vmmLWGx3fRvcxRQcrP3M4IpjsEehWbGYXMK
 H2OMQ4SbSn145REDLziFyrCp0XT4ZWnJovFrh8CL8Xk6FKNk3edS4NbBNzKb3FSm3d5e3VbTgCW
 ISwfVSZN+mOHqNctpU5rKF+EQBGJgu7Yvprzy4cY2D6S0mfH7MmdZ+Wd5RPjg=
X-Received: by 2002:a17:906:f183:b0:c2e:3698:dbba with SMTP id
 a640c23a62f3a-c509642ceeamr231259866b.4.1794578721566; Fri, 13 Nov 2026
 06:05:21 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <8eb61179-c5b8-41df-a466-8b5c388b6b41@gmail.com>
 <CADnq5_OrGuMJT4Tvt+wktPzTYEopdkCjyqq8sSdvJou40-HoKw@mail.gmail.com>
 <a6093dab-c38d-4dad-af3b-7173a6eaa78c@gmail.com>
 <CADnq5_MRA2bQG5x9xiGAT5ddh0jHMqg=u2OhCPvJxPr3ddTurA@mail.gmail.com>
 <b9f69d90-73ef-4a22-a347-0d70f014a7de@gmail.com>
In-Reply-To: <b9f69d90-73ef-4a22-a347-0d70f014a7de@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Nov 2026 09:05:03 -0500
X-Gm-Features: AclHuK-JbGhOW0X8f8QmVd6MttZ4a5YiYIvDhIqm2gvUw0T3yQw5z9xjNDXU7XI
Message-ID: <CADnq5_PZ3B863S238TkrGSubWa_VExySu9pkh5xDfrST11y5GQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/amd/display: report synced displays to
 PowerPlay for MCLK switch
To: Richard Lane <richardlanedev@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 7:15=E2=80=AFPM Richard Lane <richardlanedev@gmail.=
com> wrote:
>
> On 10/11/2026 19:59, Alex Deucher wrote:
> > On Tue, Nov 10, 2026 at 1:49=E2=80=AFPM Richard Lane <richardlanedev@gm=
ail.com> wrote:
> >>
> >> On 09/11/2026 20:34, Alex Deucher wrote:
> >>> On Mon, Nov 2, 2026 at 3:31=E2=80=AFAM Richard Lane <richardlanedev@g=
mail.com> wrote:
> >>>>
> >>>> When driving multiple displays or tiled panels with identical timing=
s
> >>>> (such as the two 2560x2880 tiles of an Apple 5K iMac panel), Display
> >>>> Core's program_timing_sync() aligns the CRTCs into a timing sync gro=
up
> >>>> in hardware during dc_commit_streams().
> >>>>
> >>>> However, on DCE < 12, Display Core leaves
> >>>> pp_display_cfg.all_displays_in_sync unset. Because PowerPlay is not
> >>>> informed that the streams have synchronized vertical blanking interv=
als,
> >>>> SMU7 prevents MCLK switching at idle or causes modeset underflows.
> >>>>
> >>>> If all active streams belong to the same timing sync group
> >>>> (timing_sync_info.group_size =3D=3D params.stream_count), report
> >>>> all_displays_in_sync =3D true to PowerPlay after committing the stre=
ams so
> >>>> SMU7 can safely downclock MCLK at idle.
> >>>>
> >>>
> >>> Looking at this a little deeper, the function bw_calcs() in
> >>> dce_calcs.c already calculates all_displays_in_sync using the helper
> >>> all_displays_in_sync().  Can you look into this and figure out why
> >>> that is not working as expected?  My concern with this patch is that
> >>> DCE and DCN have different logic for handling mclk switching so I'm
> >>> not sure it's safe to call dm_pp_apply_display_requirements() directl=
y
> >>> from common code.
> >>>
> >>> Thanks,
> >>>
> >>> Alex
> >>
> >> Moving it to dce_clk_mgr.c and using resource_are_streams_timing_synch=
ronizable() also works. Is that a solution?
> >
> > I think that would be preferred, but in general, why doesn't the
> > current flow I described work?  The function bw_calcs() dce_calcs.c
> > already calculates the all_displays_in_sync flag using the helper
> > all_displays_in_sync().  Is all_displays_in_sync() not checking
> > something properly or is the overall call timing wrong such that
> > all_displays_in_sync() can't properly calculate whether all of the
> > displays are synced at the point that it gets called?
> >
> > Alex
> >
>
> I think this could be limited to DCE 6,8,10 rather than DCE < 12 as in th=
ese
> cases DC uses dce100_validate_bandwdith() which doesn't call bw_calcs() a=
nd
> dce_pplib_apply_display_requirements() in dce_clk_mgr.c so
> pp_display_cfg->all_displays_in_sync is unset.

How about adding bw_calcs() to dce100_validate_bandwdith()?  Or if
there are issues there, just add the all_displays_in_sync() checks to
dce100_validate_bandwdith().

Alex

>
> Richard
>
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr=
.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> >> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> >> @@ -31,6 +31,7 @@
> >>  #include "dmcu.h"
> >>  #include "core_types.h"
> >>  #include "dal_asic_id.h"
> >> +#include "resource.h"
> >>
> >>  /*
> >>   * Currently the register shifts and masks in this file are used for =
dce100 and dce80
> >> @@ -319,8 +320,17 @@ static void dce_pplib_apply_display_requirements(
> >>         struct dc_state *context)
> >>  {
> >>         struct dm_pp_display_configuration *pp_display_cfg =3D &contex=
t->pp_display_cfg;
> >> +       int j;
> >>
> >>         dce110_fill_display_configs(context, pp_display_cfg);
> >> +       pp_display_cfg->all_displays_in_sync =3D pp_display_cfg->displ=
ay_count > 1;
> >> +       for (j =3D 1; j < context->stream_count; j++) {
> >> +               if (!resource_are_streams_timing_synchronizable(
> >> +                           context->streams[0], context->streams[j]))=
 {
> >> +                       pp_display_cfg->all_displays_in_sync =3D false=
;
> >> +                       break;
> >> +               }
> >> +       }
> >>
> >>         if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg,=
 sizeof(*pp_display_cfg)) !=3D  0)
> >>                 dm_pp_apply_display_requirements(dc->ctx, pp_display_c=
fg);
> >>
> >> Richard
> >>
> >>>
> >>>> Signed-off-by: Richard Lane <richardlanedev@gmail.com>
> >>>> ---
> >>>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
> >>>>  1 file changed, 10 insertions(+)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>>> index 74cd88d8d580..b4531383437e 100644
> >>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>>> @@ -4777,6 +4777,16 @@ static void amdgpu_dm_commit_streams(struct d=
rm_atomic_commit *state,
> >>>>         dc_exit_ips_for_hw_access(dm->dc);
> >>>>         WARN_ON(!dc_commit_streams(dm->dc, &params));
> >>>>
> >>>> +       if (params.stream_count > 1 &&
> >>>> +           dm->dc->current_state->stream_status[0].timing_sync_info=
.group_size =3D=3D
> >>>> +           params.stream_count) {
> >>>> +               struct dm_pp_display_configuration *pp_cfg =3D
> >>>> +                       &dm->dc->current_state->pp_display_cfg;
> >>>> +
> >>>> +               pp_cfg->all_displays_in_sync =3D true;
> >>>> +               dm_pp_apply_display_requirements(dm->dc->ctx, pp_cfg=
);
> >>>> +       }
> >>>> +
> >>>>         bool frl_stream_found =3D false;
> >>>>
> >>>>         for (i =3D 0; i < params.stream_count; i++) {
> >>>> --
> >>>> 2.55.0
> >>
>
