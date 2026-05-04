Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB41FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 14:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AC5E10E721;
	Mon,  4 May 2026 14:36:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lJtfe/V7";
	dkim-atps=neutral
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67FDF10E721
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 14:36:47 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-7bd65714dcaso30208817b3.3
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 07:36:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777905406; cv=none;
 d=google.com; s=arc-20240605;
 b=KsesE75X7reTURDbqtTHB5PBktAuxeGBLq1swWptUjuj9XtjiPsvFU43KV55CjcUGK
 9VLu7tAMe0xyPKqXoDgzDui+qFR0rfN37M5c7V6Wfyg2yglE3LEMQcY4CznAIkHARgJ3
 17j3jylE9iG/bLpSmo9fAPEzFpzB+86gdzFaTNblp4nhjPg12Ryw1FLwDI3OhbJSmpPe
 eF50Y1cEAJElnkP1578Iwn+3ZvCCpz6pN0oa8kNzKXohDLLZmNC0CjpCNmTtHxTIj3Tq
 7CHMm/Ri0RGWn9neX+cNIFspEiMu/7fqdiYtAglboJ5N1adJ4sQdxexB8855r3YKHLuG
 Q16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kHghh6a2+CPV1qKjbWI0+uiVI/8JRZuHPkXDMZ/LBRI=;
 fh=NkNx5GsKptvBNDyO5PmliadMCWxbwQ0iFC6iGdHB76g=;
 b=a9WF6FO4EwiTMaRALSS5zinqod4CTBJukpCbypgvU/dVMkVxc0goKLPmGgtuldCu8U
 d4tJzmH57Io9fMWl6P3KCxzr51Bqu3HXLIsY6s5EKDYKIiWEN/OtHhX2xhRpVn0m0mDX
 nNhKR7UpYFD69nfOcgD9p8hHSuz2eInXMYzsoQlNMey0KNMMZ3dLFMWBwhhhX01UhJCu
 n/HWVt2evIz5k/8UIQ4SrS64G2s5FIaiEHhM8N2MdyOltqIxAJ3mLYjO4l52G/fTN+Te
 3KXFRItqBncagPVN2LyG0X+kYY1DHdSfJhAY+49iaCdsY2nnXHDiIizNizFBNOqBlQw/
 rF2A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777905406; x=1778510206; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kHghh6a2+CPV1qKjbWI0+uiVI/8JRZuHPkXDMZ/LBRI=;
 b=lJtfe/V75xDc5QuKXrTMSGn2/JHl0dvzysiEvJGahHMWsQr6Fa2Ay+5OjcmZshL/hA
 CdHsKmB3n0j9JXYHoBayiVnoHYHlrmpa9w4Awtf/l2o49w+Rshnc4qXzOrVkXEKuoGf4
 B3yS4535PiNkDxAWL7mI5Oh4kOkFElSMLmU9qHzza6Q71g8i94Ux6O2EV5r3PZ35CN4u
 qy18K9nUTKYl7EVZGZ1XHuAbtjeZRzrp8Pgn+bIp8M64tGt3Ln6E6MQ2nsMM1KgkUc6w
 Y3g8CwSjAnIcwrlgvrgKGdsNPk4bbBC/7pPpytGyD6R8bsrY/rLRKsuyS1IuCZHBXaYV
 lQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777905406; x=1778510206;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kHghh6a2+CPV1qKjbWI0+uiVI/8JRZuHPkXDMZ/LBRI=;
 b=sEG/hHC78Gab0Q6v1913TuDS8NcIJmNUBdNcuhkKfPOeYyUxu8qsFupcSDrcDZLiCj
 Gl6WQLT+GEizm7S2iSv9v+p23L9pZHte/hSdZaZpmtK5/vG+zIqaBgWAm4RsuVoVwXUB
 rgMEIvbPlabIlm3B+waCbMXOcfxRws/ua2K/0ypCvVkFwlyIAn2TEen4K4pyz8yt7cpy
 G/xzSmuwttDjaUoy3vY77hURWHh6J1Y8iInkF127y0zcJySpUhFOxw07p2yWsPRsROlz
 M0EYDKzRuGygJWpNTHyECifzplhfk1mMOfZZ6KCgKVpYOHpeoKl74CxT2PuycS1nO2gL
 vbhA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fGTXI2BGdCr+o8AKDTkOjkCeiROPEyO53X4SGZV8ZJbTJhWIag2gj0qifVsi/wKAyjJ/ekXKnois=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwnimEqKD+Oln1hD/RFjyMpkUdupT+7ogVG1/l6TzhoX2aB7q8Z
 FJGNw1fu2n24glrH8h2eGgFUccWxYRA80nno0B+K/1YARVzk+49c08FnNKOWc0WBaLArZnA1ZXm
 2ULqVpuUalbqM4zUPCCMp2urJPyK6uOE=
X-Gm-Gg: AeBDietDTrTXxd0x8BA2d41a+OpsmbNVZNmk0Ao4v0qhwmgzbrZ70j6wuYfiLiVez0r
 nScycMUL/J3F0ohD86nJ9Xw6y1hcYIxycT8jE1sL5qaJJ9X1HUXAsIJAje2XXirstFTWjBjbbX1
 30e9XaVbD38tKYVrPtpWompmHUGtpDq/SIIdE8iBaDvQVCXA5fLzWS2kTRAUIMgu0rgB0bZX3Wp
 GvcwW8sfEW3gdjZ27wePGuZotXBfu+/V8zWwrT9InIYJ6FsebNgTVZdWz7RYQIysCbBhJ0c+0pG
 0AMefEMeuINnmiU=
X-Received: by 2002:a05:690c:10c:b0:7bd:69b8:f2e5 with SMTP id
 00721157ae682-7bd76f56c5bmr99592367b3.3.1777905405996; Mon, 04 May 2026
 07:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260319161159.1149822-1-jim.cromie@gmail.com>
 <dfa88f76-02d9-46a3-8bd8-bba0f14defa6@collabora.com>
 <CAJfuBxyu2K0THVAyS9i18LoTD3sR8TB_j-3Op3cxr+G_=xsKiQ@mail.gmail.com>
 <db70ec3b-736f-478c-917c-f8a56726c13e@collabora.com>
 <cfc9c37f-fac3-4e71-a4b5-22de26de0ee1@collabora.com>
In-Reply-To: <cfc9c37f-fac3-4e71-a4b5-22de26de0ee1@collabora.com>
From: jim.cromie@gmail.com
Date: Mon, 4 May 2026 08:36:18 -0600
X-Gm-Features: AVHnY4KZurN6KaRdiw0QxR6SVojoFJf5tg9wIbW_-Jz9mKtChcL2UIB6oKeQ9cM
Message-ID: <CAJfuBxysawoZ79TjcXM5AKaCKrqVRtgfZBjxprZQ-MO-c_OWvw@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/ci: bump IGT version to v2.3
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: linux-kernel@vger.kernel.org, helen.fornazier@gmail.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
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

hi Vignesh

On Sun, May 3, 2026 at 10:43=E2=80=AFPM Vignesh Raman
<vignesh.raman@collabora.com> wrote:
>
> HI Jim,
>
> On 06/04/26 12:16, Vignesh Raman wrote:
> > Hi Jim,
> >
> > On 04/04/26 18:38, jim.cromie@gmail.com wrote:
> >> On Tue, Mar 31, 2026 at 11:45=E2=80=AFPM Vignesh Raman
> >> <vignesh.raman@collabora.com> wrote:
> >>>
> >>> Hi Jim,
> >>>
> >>> On 19/03/26 21:41, Jim Cromie wrote:
> >>>> IGT_VERSION is currently pinned to a sha thats ~1100 behind HEAD
> >>>>
> >>>> Lets bump it to the latest milestone/tag at v2.3
> >>>> Thats now only ~630 behind.
> >>>> Can we haz a v2.4 ?
> >>>>
> >>>> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> >>>> ---
> >>>>    drivers/gpu/drm/ci/gitlab-ci.yml | 2 +-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/
> >>>> gitlab-ci.yml
> >>>> index 56638814bb28..d546bd123a63 100644
> >>>> --- a/drivers/gpu/drm/ci/gitlab-ci.yml
> >>>> +++ b/drivers/gpu/drm/ci/gitlab-ci.yml
> >>>> @@ -5,7 +5,7 @@ variables:
> >>>>      UPSTREAM_REPO: https://gitlab.freedesktop.org/drm/kernel.git
> >>>>      TARGET_BRANCH: drm-next
> >>>>
> >>>> -  IGT_VERSION: 129d5b10baaadea1d6cd6377341c4cb42e7ee6fd
> >>>> +  IGT_VERSION: v2.3
> >>>
> >>> Thanks for the patch. We also need to update the expectation files al=
ong
> >>> with this igt uprev. Are you planning to do it?
> >>>
> >>
> >> I dont know what that means / entails,
> >> So, it's best I don't.
> >> When you do it, I'll then know how (if you cc me ;-)
> >
> > When mesa or IGT version is updated in drm-ci, we need to update the
> > fails/flakes files in the xfails folder, as the new uprev can introduce
> > new failures or make some tests pass.
> >
> > Example https://gitlab.freedesktop.org/drm/msm/-/merge_requests/213/
> > diffs?commit_id=3Daf95dfd73f307ce1bf4ba40826aabca3b60ceb84
> >
> > I will pick up your patch and run some tests, and update you. Thanks.
>
> I updated igt to v2.4 and ran the pipeline and updated fails.
>
> https://gitlab.freedesktop.org/vigneshraman/msm/-/commit/13cf56b5e0b7ce2d=
252ecd5849c1cba3881b1c22
>
> https://gitlab.freedesktop.org/vigneshraman/msm/-/pipelines/1658019
>
> Need to investigate the failures and see if it is caused due to
> test issue or it is actual failure in driver.
>
> Regards,
> Vignesh
>
> >
> > Regards,
> > Vignesh
> >
> >>
> >>
> >>
> >>> Regards,
> >>> Vignesh
> >>>
> >>>>
> >>>>      DEQP_RUNNER_GIT_URL: https://gitlab.freedesktop.org/mesa/deqp-
> >>>> runner.git
> >>>>      DEQP_RUNNER_GIT_TAG: v0.20.0
> >>>
> >
>

I took a look at the 1st red on the pipeline

There has been a runner system failure, please try again

ERROR: Job failed: failed to pull image
"registry.freedesktop.org/vigneshraman/msm/debian/x86_64_build:20260505-igt=
-uprev-v1--20260505-igt-uprev-v1--0d2527f6--aec7a6ce7bb38902c70641526f6611e=
27141784a"
with specified policies [if-not-present]: writing blob: adding layer
with blob "sha256:513a2cbb79943cb5cc909e10b22335ca9306cec2601a981528a83ae1c=
ffcf406":
layer not known (manager.go:238:43s)

Im pretty new at reading these reports, but IIUC, this is a transient
harness error ?

I see youve kicked off a new pipeline 8195, but its blocked on some
manual steps,
can you give it a nudge ?

And while Im here, let me ask a newbie question:
why is there no automatic pipeline run on the upstream:
https://gitlab.freedesktop.org/drm/kernel/-/pipelines

ISTM having one would give baseline test results so anyone running experime=
nts
would know the control without having to run it themselves.
It would also raise the profile of baseline test failures

thanks,
Jim
