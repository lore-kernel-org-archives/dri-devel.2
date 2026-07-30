Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AE8C55160
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 12:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 183DD10EEB4;
	Thu, 30 Jul 2026 12:38:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JqQZ1Wem";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E98A10E160
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 12:38:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B956E600C8
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 12:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AD11F00ACA
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 12:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785415115;
 bh=mggr7wvIfCEo+6dv/C0d5uPBSyxJCecBvJHz21a0w1o=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
 b=JqQZ1Wem/W/7xLxCQm3EG3EkTkaXKflALH8qNzS3RVDmEiOS79agVsGHyEALzou3D
 GYUDku/DoBb52HTNcggTMGeLICvvemsWQlakuOY5bB+UmwfmBii4k2CukXAU2S7iDe
 wt69oS65mxwwR6vWL7PAIPlW5IuJmMjfeHnF9z4vvfvIBcEsbzREvQqtwkr3XeMNpL
 TRmxlhGCCQJI3k66rbIGtzo4Cl8XHAdq12B+9lnseX6lD4COHJG/nX7nmconEkwVYh
 HIZ7sq/ba32yxHFBy5FnWY9ypes/+veFhho8/C0RtSckRR8O1hGMGhjy/2oehu4DZ7
 ZLdwvjWEcZX6w==
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-39f1ac13687so15348641fa.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 05:38:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/FBQ85xkoUPZxNZylveyoGRgHK5g5cRkLh3f1shRC9zgT/sr299FbTXu4+9deDxtMcUCmus+HGd8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzcdG5lHYrpA2d/sg5gtcswmhZQLCwm2CLEQMd/si1ME364OOM6
 uES0PsxJiJKMMwg0Huor/BnVhxPtZXZmTwEaAmKUDz3rMauAWsbtIHcxc9Yz78t1RVzF/Rz3DW1
 ZlJ4nMDV/qnLjiayqsth2WoctGCQT9EQ=
X-Received: by 2002:a2e:a99b:0:b0:399:83a4:4f2c with SMTP id
 38308e7fff4ca-39f6d112905mr4228721fa.18.1785415113867; Thu, 30 Jul 2026
 05:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260728091804.382753-1-wenst@chromium.org>
 <amiqKRkFItYwD6oL@redhat.com>
 <CAGb2v64zUO-azpTuei6LCypad2noGFbg+EmaBC1iidoZ2stQzw@mail.gmail.com>
 <c1048eae-72c5-4e2e-ac49-25e2c4297018@collabora.com>
 <CAGXv+5EgGYFVt4TJCysQgRqA1J5=Qz9c0oWY5YTxgc5PnNC_AQ@mail.gmail.com>
 <36f2775a-d332-4913-8e9e-ca0429c3f713@collabora.com>
 <amswFn2qWkvypMH8@redhat.com>
In-Reply-To: <amswFn2qWkvypMH8@redhat.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 30 Jul 2026 20:38:20 +0800
X-Gmail-Original-Message-ID: <CAGb2v65yEtUH5LQ=kGL1io-urha12iOute=D2bbG872YXbK4fQ@mail.gmail.com>
X-Gm-Features: AUfX_mwS6SDXJLNyyEHek9sC4FMHJj30AO-N34TA1MSNgmBhhcn22gBEYkF6-6I
Message-ID: <CAGb2v65yEtUH5LQ=kGL1io-urha12iOute=D2bbG872YXbK4fQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] powervr: MT8173 GPU support
To: Brian Masney <bmasney@redhat.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>,
 Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Icenowy Zheng <zhengxingda@iscas.ac.cn>, 
 YoungJoon Lee <getfeus@gmail.com>
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
Reply-To: wens@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, Jul 30, 2026 at 7:06=E2=80=AFPM Brian Masney <bmasney@redhat.com> w=
rote:
>
> Hi Angelo and Chen-Yu,
>
> On Thu, Jul 30, 2026 at 10:23:14AM +0200, AngeloGioacchino Del Regno wrot=
e:
> > On 7/30/26 06:51, Chen-Yu Tsai wrote:
> > > On Tue, Jul 28, 2026 at 10:33=E2=80=AFPM AngeloGioacchino Del Regno
> > > <angelogioacchino.delregno@collabora.com> wrote:
> > > >
> > > > On 7/28/26 15:13, Chen-Yu Tsai wrote:
> > > > > On Tue, Jul 28, 2026 at 9:10=E2=80=AFPM Brian Masney <bmasney@red=
hat.com> wrote:
> > > > > > On Tue, Jul 28, 2026 at 05:17:58PM +0800, Chen-Yu Tsai wrote:
> > > > > > > Hi everyone,
> > > > > > >
> > > > > > > This is v4 of my MT8173 PowerVR GPU support series.
> > > > > > >
> > > > > > > This time around Mesa was ready for basic testing, using both=
 vulkanmark
> > > > > > > and glmark2-es2-drm (with Zink). Details below.
> > > > > > >
> > > > > > > Changes since v3 (all in the clk driver patch):
> > > > > > > - Changed pm_runtime_put() to pm_runtime_put_sync()
> > > > > > > - Added missing of_node_put() in remove function
> > > > > > >
> > > > > > > Changes since v2 (all in the clk driver patch):
> > > > > > > - Made COMMON_CLK_MT8173_MFGTOP depend on PM
> > > > > > >     - Needed since the driver implements PM domains using the=
 generic PM
> > > > > > >       domain library, which also depends on PM
> > > > > > >     - Fixes build breakage (kernel test robot)
> > > > > > > - Fixed "RST_DELAY_CNT" name (Brian)
> > > > > > > - Dropped unused mfg_desc (Brian)
> > > > > > > - Added check of clk_prepare_enable()'s return value in
> > > > > > >     clk_mt8173_mfgtop_power_on() (Brian)
> > > > > > > - Saved error value for return in IS_ERR(data->clk_26m) branc=
h
> > > > > > >     (Dan Carpenter / kernel test robot w/ smatch)
> > > > > > >
> > > > > > > Changes since v1:
> > > > > > > - Adapted to changed DT bindings
> > > > > > > - Dropped driver change
> > > > > > > - Use same power domain for "a" and "b" GPU power domains
> > > > > > >
> > > > > > >
> > > > > > > This series enables the PowerVR GPU found in the MT8173 SoC, =
found in
> > > > > > > some Chromebooks.
> > > > > >
> > > > > > I'm making a pull for Stephen for the clk changes. Should patch=
es 1,2,4
> > > > > > go through the clk tree? Patches 3,5 go through the DRM tree?
> > > > >
> > > > > Only patches 1 and 2 should go through the clock tree.
> > > > >
> > > > > Patch 3, 4, 5 can all go through the soc tree if Angelo wants to =
pick up
> > > > > DT binding patches. Otherwise I can push patch 3 through drm-misc=
.
> > > > >
> > > >
> > > > Not sure if I can really take the DRM bindings patch through soc.
> > > >
> > > > I will take the devicetree ones exactly right now, even though it's=
 going to
> > > > give warnings.
> > >
> > > Apologies for missing this, but the first DT patch depends on the clk=
 DT
> > > bindings patch for the clk ID macros. This is causing build errors in
> > > linux-next right now.
> > >
> > > Not sure how we can fix this right now.
> > >
> > > Brian, would it be possible for you to split out that patch into a
> > > separate immutable branch for Angelo to merge?
>
> Yes, I can split things out and make an immutable branch this morning.
> But it sounds too late for that.
>
> > >
> > > Otherwise Angelo might need to drop the DT patches until the next cyc=
le.
> >
> > Yeah, that's so bad.
> > I'd be happy to be able to resolve this, but it's too late on my side.
> >
> > I should've checked the DT patches more carefully, my bad: I got a bit =
too excited
> > to finally see this PowerVR stuff working on MT8173 and going upstream.
> >
> > Sadly, I have to drop the devicetree patches :-(
>
> Chen-Yu: Could Angelo add an Acked-by to the three patches, and then I se=
nd
> Stephen an additional pull with just those patches? Do you think he'd
> pull that?

(replying from my @kernel.org address again because I don't feel like
 pulling out my work laptop.)

I think the question is whether the soc & dt maintainers would be bothered
by it or not.

No need to sweat over it though. It's not like the GPU driver is production
ready anyway. We can just merge the DT patches in the next cycle. :)


ChenYu
