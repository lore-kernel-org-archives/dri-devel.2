Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6C5CD6E5D
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D86D10F71F;
	Wed,  3 Jun 2026 01:07:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cjd1cVlu";
	dkim-atps=neutral
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com
 [209.85.221.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 610D810F71F
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 01:07:01 +0000 (UTC)
Received: by mail-vk1-f178.google.com with SMTP id
 71dfb90a1353d-59b6227df10so3077185e0c.0
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 18:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780448820; x=1781053620;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ZFBsFKhHgWNbw+NYFmMvZVlExPBPgJq9/ChJIKCimY=;
 b=Cjd1cVluWSEeax9kvGigaRjLCO6OGMZ7KtSTS6QwvItSZttlfnV1ZtwE7O+YK/UUwj
 4Mlod6qQSjshDbmkwuHYp2Bqw3zQRHLqGoq2h92LI5+NEfTJWmN3nEwVA5QuQWa3M5kO
 87ZkJPmx8xqbZRBoxs90FxPJonxoSKwBqNEiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780448820; x=1781053620;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9ZFBsFKhHgWNbw+NYFmMvZVlExPBPgJq9/ChJIKCimY=;
 b=IJgZTaA1itqO8dQEBQEiph2/mgcr7SBRNyNjDVTmvaCdqtde8b1K34HXqRlxJvC81V
 a1iIiiUrm+zGY9cfCLu0dsjRABwYmY7qbpB9BEt40qpXWRl1S+KQpxNc72x2x6slB6sP
 dHyc+HlSCNWj8c0hYH26DkOzdJpGyuh3QN9DAlic667XwY7RwHOfHS3qtjYyJxa8veXA
 ITZasjrkhGuLIHnOz/pUF1aJaCQ478JALxYjsUarTl+HnvJKPjiUD2aIqLx6B8m12rWc
 kTPnSXWgq+U2qS4LTGDiocZlrAcam36zP9b7y4ew0Hdz/Uc6WGuhpO8VhxJPl5jR25gP
 AOzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Vav87+UVXMM9PjvFq4ypSkappiprJJzTLvLWur/lYHaxFFUvxxQ6jiM1YpfUroV6TBuU59+3o2o4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy41LWANdCvJtyjBVa4bK4NPfTpqsm1t4MnUfcM9m+Rdd/yZzIK
 NcDTJpEtozlLNfu5Jjvw0mfuuSUu1HYxPOBuW7KhOekx6S6LkLc1OjTtgXGq3uvXW48Z43TewbC
 Z6+o=
X-Gm-Gg: Acq92OEkUvAWpQLpM7pydACc/qoWWW+ZiZG9pxHw/iBlati5NSu+HUaNDVrqCUKkti0
 i8r+yM17O68Fb3oCN/sqgr8CNc7cFUuO7Ikdl1V4pCY4V3cFaHoRfHeXLzoZmxItSpbklgPmBMb
 9s4s1GoAThC9Efcl7YgH7sXlmVYml2rnRz0K/wB7pY7g1hQY4/mBzpCCIg4KCUF0NC4VWJ5Jv73
 BwHOFUgV2ehSy9ltRauwAPp2qcH6/RqVaEnyV9koRb9sQIpRapfOLZ39RP2mOmu1DbC+QGulY94
 o7317Ib01vBuM5P51E6IgLswj8gsVNhd7aLZ8Zj2tJJ8o3xjG6xfH7YBOt4HEVnePU1ArAZ9xw3
 9MsTJYUFfKd27weyf9GqfF3Syz4eCq4dtbLrzpsf5lZXtbedDXAZ1zjUVpM4EK5I3KbTAiFW9iF
 eR8VeNWbd9hTDuTp27fsFNXwWCthaYNg03xoXJMWCVV4yN5rnVxw8nubt3Uo0Cccst99GMn+MC
X-Received: by 2002:a05:6102:32c1:b0:660:e00e:720a with SMTP id
 ada2fe7eead31-6ec2c4c0abemr609333137.8.1780448820174; 
 Tue, 02 Jun 2026 18:07:00 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com.
 [209.85.217.50]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-9641414e1d7sm670206241.12.2026.06.02.18.06.57
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2026 18:06:59 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id
 ada2fe7eead31-6c87709aa26so2205686137.0
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 18:06:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9n36MiYxqECFvipMmI8YNWxegFaSQ/wEgeIAMe6vmxiB4GUqnGfu005BBVQH0oo403RWwnwXswHPE=@lists.freedesktop.org
X-Received: by 2002:a05:6102:1611:b0:631:ec2d:12bd with SMTP id
 ada2fe7eead31-6ec298856b1mr573739137.5.1780448817047; Tue, 02 Jun 2026
 18:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260523035734.6602-1-chintanlike@gmail.com>
 <ace48664-cd7e-4cb8-8940-04ffe6f93e19@minlexx.ru>
 <24a8d461-7393-4a37-b23c-3cbf44060350@gmail.com>
In-Reply-To: <24a8d461-7393-4a37-b23c-3cbf44060350@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 2 Jun 2026 18:06:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XZfLxxEWEF3c=b2d7ngFZEstY0=+DrzJb-RMQMpACSrg@mail.gmail.com>
X-Gm-Features: AVHnY4K83a2fc0Zzd7iRRmiAf7WT56feARLysrECtUhh-RdM_13IVfZHYIUeJYw
Message-ID: <CAD=FV=XZfLxxEWEF3c=b2d7ngFZEstY0=+DrzJb-RMQMpACSrg@mail.gmail.com>
Subject: Re: [PATCH v3] drm/panel: novatek-nt36672a: Inline panel init
 sequences
To: Chintan Patel <chintanlike@gmail.com>
Cc: Alexey Minnekhanov <alexeymin@minlexx.ru>, sumit.semwal@linaro.org, 
 neil.armstrong@linaro.org, jesszhan0024@gmail.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

Hi,

On Tue, May 26, 2026 at 9:17=E2=80=AFPM Chintan Patel <chintanlike@gmail.co=
m> wrote:
>
> >> @@ -162,8 +141,8 @@ static int nt36672a_panel_prepare(struct drm_panel
> >> *panel)
> >>       dsi_ctx.accum_err =3D nt36672a_panel_power_on(pinfo);
> >>       /* send first part of init cmds */
> >> -    nt36672a_send_cmds(&dsi_ctx, pinfo->desc->on_cmds_1,
> >> -               pinfo->desc->num_on_cmds_1);
> >> +    if (pinfo->desc->send_init_cmds_1)
> >> +        pinfo->desc->send_init_cmds_1(&dsi_ctx);
> >>       mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> >> @@ -173,8 +152,8 @@ static int nt36672a_panel_prepare(struct drm_panel
> >> *panel)
> >>       mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> >>       /* Send rest of the init cmds */
> >> -    nt36672a_send_cmds(&dsi_ctx, pinfo->desc->on_cmds_2,
> >> -               pinfo->desc->num_on_cmds_2);
> >> +    if (pinfo->desc->send_init_cmds_2)
> >> +        pinfo->desc->send_init_cmds_2(&dsi_ctx);
> >>       mipi_dsi_msleep(&dsi_ctx, 120);
> >
> > Hi!
> >
> > Here, the split of panel init sequence into 2 separate functions _1 / _=
2
> > is completely artificial and completely unnecessary. For some unknown
> > reason the initial version of driver had initialization procedure cut i=
n
> > 2 parts on the boundary of exit_sleep_mode + set_display_on commands.
> >
> > I think the whole init sequence should be glued together into one big
> > send_init_cmds() callback and have all these calls:
> >
> >      mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> >      /* 0x46 =3D 70 ms delay */
> >      mipi_dsi_msleep(&dsi_ctx, 70);
> >      mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> >
> >
> > included in the middle. This opens up a possibility for other panels
> > based on nt36672a to be supported in this driver, which don't have the
> > init sequence split this way. The location of exit_sleep_mode and
> > set_display_on commands there is different. And, importantly, the delay
> > is different too.
> >
> > I once did a very similar change to this driver [1] to add support for
> > more panels (ignore touchscreen changes there, look only at panel).
> > What is also important, that change was also tested on Xiaomi Poco F1
> > (xiaomi-beryllium) phone, which is the main user of this panel.
> > Unfortunately I never got to send it, even though I wanted to..
> >
> > What do you think?
> >
> > [1] https://gitlab.com/sdm845-mainline/linux/-/merge_requests/131
>
> Hi Alexey,
>
> Thanks, that makes sense and I agree the fully panel-owned init sequence
> would likely be a cleaner abstraction long term, especially for
> supporting additional NT36672A panel variants with different sequencing
> requirements.
>
> For this patch, though, I was trying to keep the scope limited to the
> original refactor requested during earlier review:
>
> remove the command table abstraction,
> inline the command sequences,
> and preserve the existing init flow/behavior as closely as possible.
>
> Since moving exit_sleep_mode, delays, and set_display_on into the panel
> callback changes the sequencing model itself, I was thinking it may be
> better handled as a follow-up cleanup/refactor patch to avoid mixing
> behavioral restructuring into this series.
>
> If that sounds reasonable, I'd prefer to keep this patch focused and
> address the sequencing abstraction separately afterward.

Yeah, I agree with Chintan here. I'd prefer to apply his patch as-is
and then I'd be happy to review and apply a followup patch if someone
posts it.

This patch already has my Reviewed-by and the changes from v2 to v3
address the nits I had on v2. Thanks! I'll plan to apply this patch in
a few days unless there is any additional activity.

-Doug
