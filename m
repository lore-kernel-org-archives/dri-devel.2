Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBADAC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:45:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B3DB10E939;
	Tue, 28 Jul 2026 14:45:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JvHqpuTk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D306510E939
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 14:45:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 81EC545098
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 14:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1A31F00AC4
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 14:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785249913;
 bh=+zoBoxVP0tu54EmP44Kgg99nD/WSNJ3du1BUA30wzps=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
 b=JvHqpuTk00lMlu3XNouaDMT787Xmh5ZH9xAHaW5qASWPVyM9MjIS7H0CGU0mQQuab
 gzeYGF1Nxv3+XToSFj77YXsWsnuAm0Pyl54PJAOH3G0CpqoEYRMvEy+TTACdHOk8Qe
 mMZnxHR/Py7bD7SdJcCMFk4e7CgPSHuGkZqfyuh+OyL5Hmw14p1prf5nctoiKnHXee
 nmJJBy6ATQOgancwoqpT4Hhoxt55L+UvtmAgpFC5nQZ3iZX4KlmcNBelebHc00vsKY
 KwjbsVfsklTSXyl/hmZqOuWsPGgGq+adSgvQL3icu3qn6QI1GuoX2GFJwLHTD8zBhZ
 9C+k0pMDylctg==
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-39c9452243cso37259771fa.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 07:45:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/nPf5FXQ5wPF/+4gm0CDpZAlEhEJdxBpGyxhkZwF9iWBZC1fHyihmxP3pvcTf96Sau3znXIkpxws=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YydGJdFbjk3YlfG8+6JEYyrSRNHBWLFMFeSXYlaEfYUxVvNngWc
 g+w7DE/NBpwrEFv7tBoMgW/GC9giGsljjbNFTpy5CKB32Wi2Gq3cx2Hkpg+MO68HUMuJr6WRDmJ
 dQn2cSbw4BBe0CDayzDRzNzly4WFi8GU=
X-Received: by 2002:a05:651c:1472:b0:39f:334:5417 with SMTP id
 38308e7fff4ca-39f51e78500mr5509941fa.31.1785249911724; Tue, 28 Jul 2026
 07:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260728091804.382753-1-wenst@chromium.org>
 <amiqKRkFItYwD6oL@redhat.com>
 <CAGb2v64zUO-azpTuei6LCypad2noGFbg+EmaBC1iidoZ2stQzw@mail.gmail.com>
 <c1048eae-72c5-4e2e-ac49-25e2c4297018@collabora.com>
In-Reply-To: <c1048eae-72c5-4e2e-ac49-25e2c4297018@collabora.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 28 Jul 2026 22:44:58 +0800
X-Gmail-Original-Message-ID: <CAGb2v67VRhy_xzkdwUAYhzM_sWzoXyfZ3rYSHYLYaxuve9H17w@mail.gmail.com>
X-Gm-Features: AUfX_mx6JNGZEk5lcOTAkXuDdaZ1OKJc8XncWYJ1mBU23rnRHL1R5sda5IuVL9U
Message-ID: <CAGb2v67VRhy_xzkdwUAYhzM_sWzoXyfZ3rYSHYLYaxuve9H17w@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] powervr: MT8173 GPU support
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Brian Masney <bmasney@redhat.com>, Chen-Yu Tsai <wenst@chromium.org>, 
 Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
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

On Tue, Jul 28, 2026 at 10:33=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> On 7/28/26 15:13, Chen-Yu Tsai wrote:
> > On Tue, Jul 28, 2026 at 9:10=E2=80=AFPM Brian Masney <bmasney@redhat.co=
m> wrote:
> >>
> >> Hi Chen-Yu,
> >>
> >> On Tue, Jul 28, 2026 at 05:17:58PM +0800, Chen-Yu Tsai wrote:
> >>> Hi everyone,
> >>>
> >>> This is v4 of my MT8173 PowerVR GPU support series.
> >>>
> >>> This time around Mesa was ready for basic testing, using both vulkanm=
ark
> >>> and glmark2-es2-drm (with Zink). Details below.
> >>>
> >>> Changes since v3 (all in the clk driver patch):
> >>> - Changed pm_runtime_put() to pm_runtime_put_sync()
> >>> - Added missing of_node_put() in remove function
> >>>
> >>> Changes since v2 (all in the clk driver patch):
> >>> - Made COMMON_CLK_MT8173_MFGTOP depend on PM
> >>>    - Needed since the driver implements PM domains using the generic =
PM
> >>>      domain library, which also depends on PM
> >>>    - Fixes build breakage (kernel test robot)
> >>> - Fixed "RST_DELAY_CNT" name (Brian)
> >>> - Dropped unused mfg_desc (Brian)
> >>> - Added check of clk_prepare_enable()'s return value in
> >>>    clk_mt8173_mfgtop_power_on() (Brian)
> >>> - Saved error value for return in IS_ERR(data->clk_26m) branch
> >>>    (Dan Carpenter / kernel test robot w/ smatch)
> >>>
> >>> Changes since v1:
> >>> - Adapted to changed DT bindings
> >>> - Dropped driver change
> >>> - Use same power domain for "a" and "b" GPU power domains
> >>>
> >>>
> >>> This series enables the PowerVR GPU found in the MT8173 SoC, found in
> >>> some Chromebooks.
> >>
> >> I'm making a pull for Stephen for the clk changes. Should patches 1,2,=
4
> >> go through the clk tree? Patches 3,5 go through the DRM tree?
> >
> > Only patches 1 and 2 should go through the clock tree.
> >
> > Patch 3, 4, 5 can all go through the soc tree if Angelo wants to pick u=
p
> > DT binding patches. Otherwise I can push patch 3 through drm-misc.
> >
>
> Not sure if I can really take the DRM bindings patch through soc.
>
> I will take the devicetree ones exactly right now, even though it's going=
 to
> give warnings.
>
> I trust that you'll make the binding get into linux-next before it's too =
late.

Rob beat me to it. :D
