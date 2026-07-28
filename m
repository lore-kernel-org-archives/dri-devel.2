Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAE8C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5975A10E0D0;
	Tue, 28 Jul 2026 10:05:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="qrAs5Tbh";
	dkim-atps=neutral
Received: from out28-220.mail.aliyun.com (out28-220.mail.aliyun.com
 [115.124.28.220])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C95DE10E0D0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1785233133; h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 bh=bBH0cL6G6qap42QvvVNvtCdPPQMC/xd8/rQDEJIsUyo=;
 b=qrAs5TbhoHjJyGMbjA9DP9MkLDUMHBZtL2daCa3fFhWSUvtuexaIDOHXK4G8yeD9SJLoYAafTIqwH7kSZDEOEVUDDJ+pJ+kP/RL+W6gogTj4AqDmBeHf6oSM1SJXnBZ8ZsfYH3NSkBm+OQK3YumcSs5bzXNZA6M2Avnp8G81OjYAvir8ggIxRsT0BqYEHc6mvHMylyzW3Q+yx+Nsw+owQj4K/kzazhnMf+0thXm4/VwERi0uxcPCo19leHLJghf98ygDTEiyI/wRipYELi+tkwOMilfLKN6RitZaAMoCfn2WKjFz3p4uNIvxZWdyfQlk5T1HQL60ysw0G8zk8ITSBw==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.09451956|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.0493304-0.000723678-0.949946;
 FP=3202147417340437341|8|1|8|0|-1|-1|-1; HT=maildocker-contentspam033068016216;
 MF=syyang@lontium.com; NM=1; PH=DS; RN=1; RT=1; SR=0;
 TI=SMTPD_---.iXLMdl3_1785233131; 
Received: from mail-oi1-f182.google.com(mailfrom:syyang@lontium.com
 fp:SMTPD_---.iXLMdl3_1785233131 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 28 Jul 2026 18:05:32 +0800
Received: by mail-oi1-f182.google.com with SMTP id
 5614622812f47-4a43c2a126fso1378912b6e.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 03:05:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RokMbREPCPNkuq+xgleX4DwqcUiATCuoCne5ZJ5DBdE6MGwpcZ9yq1ObnJ2AKtna10x2jJlrEgXEL0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2nk1nm2915J038YsQh6sV39LNE7YdqSPkqmKydDjF4JYYNiyA
 Iiyl2jhObjDFUXCCyljaPYWSk5JU2KK3SF88hyhBhrwsq1V48hAdyjOkPRpTlLy03XbHlwxX5Ct
 shn/JsydCK6leJYn2nUrUyXVb9gbH2uw=
X-Received: by 2002:a05:6808:2211:b0:4a4:2424:eb23 with SMTP id
 5614622812f47-4ad5bb23138mr1059928b6e.27.1785233130334; Tue, 28 Jul 2026
 03:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260715015438.2770155-1-syyang@lontium.com>
 <tfkg2cjn4uznzy57rpkqwan26sduqzptnb7uwsucfboz37wz7k@rukuu36mozif>
 <CAFQXuNazLnXOr+qRug4De8W3U932aG9LVRVWgkHAE=ALSQ+ZGA@mail.gmail.com>
 <waw7uhdebjavtcdgcgvrdhos3vcervc3b6ggooj2zgkd6yq47v@kkzdagga6hoj>
In-Reply-To: <waw7uhdebjavtcdgcgvrdhos3vcervc3b6ggooj2zgkd6yq47v@kkzdagga6hoj>
From: Sunyun Yang <syyang@lontium.com>
Date: Tue, 28 Jul 2026 18:05:18 +0800
X-Gmail-Original-Message-ID: <CAFQXuNZGLkdcWe-nFhzV_1D83he26sxSGpW06aa=4wOD1vqufg@mail.gmail.com>
X-Gm-Features: AUfX_mywJFi7PauVGw8ltpx0PR28MU_m9SRfrVypOLPLzksh8-UysZnr9i1qcw8
Message-ID: <CAFQXuNZGLkdcWe-nFhzV_1D83he26sxSGpW06aa=4wOD1vqufg@mail.gmail.com>
Subject: Re: [PATCH v17 0/2] Add Lontium LT7911EXC eDP to MIPI DSI bridge
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org, mripard@kernel.org, 
 Laurent.pinchart@ideasonboard.com, tzimmermann@suse.de, jonas@kwiboo.se, 
 jernej.skrabec@gmail.com, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 xmzhu@lontium.corp-partner.google.com, xmzhu@lontium.com, rlyu@lontium.com, 
 xbpeng@lontium.com, qdchen@lontium.com, llzhang@lontium.com, 
 hfxia@lontium.com
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

Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=B9=B4=
7=E6=9C=8828=E6=97=A5=E5=91=A8=E4=BA=8C 17:46=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jul 28, 2026 at 09:56:11AM +0800, Sunyun Yang wrote:
> > Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=
=B9=B47=E6=9C=8828=E6=97=A5=E5=91=A8=E4=BA=8C 09:22=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > On Wed, Jul 15, 2026 at 09:54:36AM +0800, syyang@lontium.com wrote:
> > > > From: Sunyun Yang <syyang@lontium.com>
> > > >
> > > > The LT7911EXC is an I2C-controlled bridge that receives eDP1.4
> > > > and output mipi dsi. This series introduces:
> > > >
> > > > - A device tree binding YAML file describing the hardware
> > > > - A new DRM bridge driver implementing the basic functionality
> > > >
> > > > Signed-off-by: Sunyun Yang<syyang@lontium.com>
> > > > ---
> > > > Change in v17:
> > > > - dt-binding:
> > > > - drm/bridge:
> > > >  1. [High] devm leak and list corruption on panel rebind           =
                                       [sashiko-bot]
> > > >            False positive. The -EBUSY guard at the top of host_atta=
ch() (line 527) rejects re-attach
> > > >            when output_bridge is already set, so neither devm_drm_o=
f_get_bridge() nor drm_bridge_add()
> > > >            is reached on panel rebind.
> > >
> > > This is not a changelog. Don't mix replies, with the changes in the
> > > patches.
> > >
> > In the driver code, when I reply to the issues raised by the AI bot,
> > the AI bot does not respond to me.
> > In subsequent submissions, can I simply not reply to the AI bot's
> > questions and only modify the issues that are useful for the driver?
>
> AI is a _bot_. Talk to people. You should reply to the bot directly as
> that's what the reviewers will see and consider.
>

Thank you for the guidance, Dmitry. I will follow this rule in future
submissions and describe the change log.

>
> --
> With best wishes
> Dmitry
