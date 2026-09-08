Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA32AC79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:31:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43A7C10E0F4;
	Tue,  8 Sep 2026 14:30:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d0ZzOD2n";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1640410E09B
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 14:30:58 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39666e7c9edso443418a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 07:30:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788877857; cv=none;
 d=google.com; s=arc-20260327;
 b=DKAU7Ac+6vppndGUsoTG3VfQd0KpViQTVYyFEz/PK67quVAJtId1YYY7zGGyxo7jmb
 i0ijTZXv7jL0P9hJdrI5Q4WUkVsBJ8ErsjWQXDD3pgw8R980kbw2V6zzr4EcL2MihiJw
 6PLL/s4qsjkkCjGSfHn+rOukG98cQUTaETlnSXPu3JYcAcy0llrGGjmAQRN+W8L3O8eP
 kMoTFARAmWZuuWkofdGCCB0Bct1qIqIant5VcvF8g0McdLBzJiRORbKt12tZK+7hf9uk
 30mj+Ba6vC4Z0Z8AgYLZkZE/qAP/YF3XayeFHl4c/t6n/85UxtmSTu8POAjI7zNTI+uk
 s73g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ONrg+ixeE+npwl1waDzdomaITThLQI9+1cKhJ6k/3o8=;
 fh=G0b5kvF3RY4SXv0TQwMYBioNFriWz2HvLcBAoAX4ero=;
 b=iQpNW6qoIDI6gpIQ3RmK55oMSecGQFvG45c1qvI50L8QUVj/nADYO5o0ZFrgsJwXUq
 lFC3B25A5muYxfxPQxgWQaQOw1MuG9CrqMZH4QheA1m5vz0WirrdVbi3UUDy9l+wztFZ
 A29LfbHJ2erHywujDunNDJSwjl/IJN1JTDkdCvAPQEZgqRb0s2RkU8l077SDgLPL7QB8
 XGVUrGXwvr5ZNSWi9dZfKKCfM9Fk+c6x4HLjIbDc+Fmst313iFNr5ZV9Y9yotibN+TzB
 benb2843Jazl7EfMe4OXh9Y1jBwEyJnurWWjb7t4pUMHg20EFTrpoLABguyREJenU1Tf
 +1NQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788877857; x=1789482657; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ONrg+ixeE+npwl1waDzdomaITThLQI9+1cKhJ6k/3o8=;
 b=d0ZzOD2n43H3FBN5IM06mdMdAZF5heg/DiVb/QimjztjhiTY4+H69VKne9vOsRD/ey
 C57w5fb/vkd4YSiIEOi2gntwrZjCryntHoEJGsxY7N7ImG1wzzkafHa56WEXvbzY2PZ+
 AUfk0EoAQHmHegTHk33kwx6VtfbC7zO5Fb7ppzL5gvyhwANrpPjjZwgC2cngEdUgtU1w
 NKjcsCBZ/kOcEnTsDC401h3xJCswYD6e16HTaoXSv8l2sQy52XwNUQiXkx5a/rR3kf60
 rmz14TjGsD9JxRVRSZwpj8IHci+wyQ8LjvkvEo3/tByndKCEkka4qzJN6NTPsqN8t7yY
 cMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788877857; x=1789482657;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ONrg+ixeE+npwl1waDzdomaITThLQI9+1cKhJ6k/3o8=;
 b=CErFh51vBezFJkBcbma8MFM596OKzysFBhga7XF/d2/JCQFrQ9+oedwPW1RO4V0B6I
 /aeQiUfX8sZZH0VX9T9cbTfTzCAYYefY+tHvR69zJlzPzCVSbaUUM7qm2laNqX4UvVL4
 oDzKLLoVfmp5mnhHW9oiQL2lcKnsLUaYKayYm8zeDAqAkpbjID2B8q+h51tSroPXyIp0
 OTfZ/wAyzVJGxnZnAQ3XhBuDsVsVEU6RbPbMbAQElGXdqdGyCg0lcZy/fQIBbKvQnQSy
 +gunpOwR0Vr6L/6rDTUqNfzz27qB6MzgnHtnZgUhyIBxpWoPeyY1yQ0rWIDojW6lV6ml
 0FlQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByhcR/Zi89wSa5gIXp+pyTjlD2OhlO2locAcGrqzyNSYna0RGWj4pmidC3mlx7ssZFsK628PZ9w/pI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mt4VoEvraX+9mHSjVZJ5wzH2hzgN59vlvYpp1k3sBjlW7myWb2
 Hob6KlU6HQqp31CvUhoei9qBuxpmNpuOhLg9EwCkAMpvDuToz/MKv53nVYefywH0korOx8nIE/6
 57WkkTE9/8uh4KAWzmdsxwwC1wQQMqPU=
X-Gm-Gg: AYBFou1HPqhaxepayxvA1IkpGWdrQsg5yv7DsOFLOY9VohNKQev2jcJtbf1xXoibfxZ
 74i6EEXodwU5+x9OVuNNXIxyMxF3FmGExooLL2IXVdZfbaNE2h0mzO97FV9ejCxC3OQ46Iy0erX
 DND+zkI8y3JgKqH5W5BN7VUpPOWqjMHZEjSrX6B5fAetteO86RQKtETJQXmRif2Pj19RNAkwqDL
 M4/jugi7eW0zhwgTosjDAX2nMS59PHcLkIcN/USXCLrHG37isBN4iB9vJ8gJDm+MD+McwgBG8xF
 r1oPQ7cFPF0s1inQr50jBaJE/fEJOpVWRVFTKjutFcgJRh+qajia602YZGfnm3sBCT9+w07Ubvp
 wL0cyOWsmMGw4JPQ5XvEEUYyIcnm1Gt4=
X-Received: by 2002:a17:90b:528c:b0:38e:7069:7117 with SMTP id
 98e67ed59e1d1-39b3d3f7890mr24314330a91.0.1788877857404; Tue, 08 Sep 2026
 07:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260820142802.1342066-2-rodrigo.vivi@intel.com>
 <e48a854b-1240-4fcb-a429-2c02be10da5d@kernel.org>
 <CADnq5_PvMKVbmukOJW9oHK-bw3110eAf97WXfUVi-urhcEGMMg@mail.gmail.com>
 <CAPM=9tws_bMnxt9QVjt4bP_bO9YM5h2n4FtNZMg1p0ZLsrLw5g@mail.gmail.com>
In-Reply-To: <CAPM=9tws_bMnxt9QVjt4bP_bO9YM5h2n4FtNZMg1p0ZLsrLw5g@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Sep 2026 10:30:45 -0400
X-Gm-Features: AcwNN1W8K8dzDY33k3zIoH3vtY8e1CWQdy1FWANClREVCmYHU1Mq0Bl_djRIt1M
Message-ID: <CADnq5_Nt97pLDz6V3hB8CBSDcKA1OXiPnLP5USnN5xj=1NYDMQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Drop KUnit tests for removed
 parse_hdmi_amd_vsdb()
To: Dave Airlie <airlied@gmail.com>
Cc: Mario Limonciello <superm1@kernel.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Alex Huang <Alex.Huang2@amd.com>
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

On Tue, Sep 8, 2026 at 6:27=E2=80=AFAM Dave Airlie <airlied@gmail.com> wrot=
e:
>
> On Fri, 21 Aug 2026 at 07:30, Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Thu, Aug 20, 2026 at 3:30=E2=80=AFPM Mario Limonciello <superm1@kern=
el.org> wrote:
> > >
> > > On 8/20/26 09:28, Rodrigo Vivi wrote:
> > > > parse_hdmi_amd_vsdb() was removed when HDMI FreeSync detection move=
d to
> > > > the common EDID parser, but its declaration and KUnit tests remaine=
d,
> > > > breaking modpost:
> > > >
> > > >    ERROR: modpost: "parse_hdmi_amd_vsdb" [...connector_test.ko] und=
efined!
> > > >
> > > > Remove the stale declaration and the three dead test cases.
> > > >
> > > > Fixes: f65198b3d073 ("drm/amd/display: Use HDMI FreeSync range from=
 common EDID parser")
> > > > Cc: Alex Huang <Alex.Huang2@amd.com>
> > > > Cc: Mario Limonciello <superm1@kernel.org>
> > > > Assisted-by: Copilot:Claude-Opus-5
> > > > Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > > ---
> > > Thanks this looks correct to me.
> > >
> > > Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > >
> > > I'm not sure where we should apply it though, it's from a conflict
> > > between drm-misc-next and Alex's drm-next pull.
> >
> > I'll pull it into my next -fixes PR.
>
> I think this should be merged into drm-misc-next ASAP, since the merge
> is in there.

Applied.

Alex
