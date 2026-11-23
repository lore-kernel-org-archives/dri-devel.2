Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D4F606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 10:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=HBN+WdlF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3169210EBCF;
	Mon, 23 Nov 2026 10:16:01 +0000 (UTC)
X-Greylist: delayed 379 seconds by postgrey-1.36 at gabe;
 Mon, 23 Nov 2026 10:15:54 UTC
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FD6710EBCF;
 Mon, 23 Nov 2026 10:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
 s=mxsw2412; t=1795428945;
 bh=na+Qx5lxtdWvhLfCjtLB7gxG8BYD2XnZIK8peOF3Fyg=;
 h=Mime-Version:Date:Message-Id:Subject:From:To;
 b=HBN+WdlF9aY94iqra2wKTZT3PDmTgFreHWpaiX310ZQXblJF1+UZtCQWlG3ChXSMF
 Cg3kppVixVrLSo77fWqvzYkAkIrdcgz2eYL1HnN82/9lEKG1bjz/YQSySLMqEfGLr/
 MwFMl0Fqw4WhJArwyNIFClyIN5NgSdvGxcHbRyNk=
X-QQ-mid: esmtpsz21t1795428537t55d3ec12
X-QQ-Originating-IP: YRM8rmCD4m2EOmelJpoSAkd6C+Zo71Ofh6RWgSJHJN0=
Received: from localhost ( [120.237.158.181]) by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 23 Nov 2026 18:08:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6646035375502222729
EX-QQ-RecipientCnt: 19
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 18:08:54 +0800
Message-Id: <DN2IAQ05SK22.2BFO0AZF4IAH6@linux.spacemit.com>
Cc: "alessio.belle" <alessio.belle@imgtec.com>, "luigi.santivetti"
 <luigi.santivetti@imgtec.com>, "maarten.lankhorst"
 <maarten.lankhorst@linux.intel.com>, "mripard" <mripard@kernel.org>,
 "tzimmermann" <tzimmermann@suse.de>, "airlied" <airlied@gmail.com>,
 "simona" <simona@ffwll.ch>, "dlan" <dlan@kernel.org>, "troy.mitchell"
 <troy.mitchell@linux.spacemit.com>, "pjw" <pjw@kernel.org>, "palmer"
 <palmer@dabbelt.com>, "aou" <aou@eecs.berkeley.edu>, "alex"
 <alex@ghiti.fr>, "imagination" <imagination@lists.freedesktop.org>,
 "dri-devel" <dri-devel@lists.freedesktop.org>, "linux-kernel"
 <linux-kernel@vger.kernel.org>, "linux-riscv"
 <linux-riscv@lists.infradead.org>, "spacemit" <spacemit@lists.linux.dev>
Subject: Re: [PATCH v2] drm/imagination: re-check firmware idle state before
 runtime suspend
From: "Baihui Liang" <liangbaihui@linux.spacemit.com>
To: "Gyeyoung Baek" <gye976@gmail.com>
X-Mailer: aerc 0.17.0
References: <20261111-img-pm-autosuspend-v2-1-427689f6f2f9@linux.spacemit.com>
 <CAKbEzntsUc4D3Nvxfphy5yApWG+sGsx7VF1cYd3SLSoZKhiteA@mail.gmail.com>
In-Reply-To: <CAKbEzntsUc4D3Nvxfphy5yApWG+sGsx7VF1cYd3SLSoZKhiteA@mail.gmail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M8rl2SmKK9clB/nH3khHcFo+iJCzGHeGi//qw/GhUeq7thEkha6KtLE4
 WcR2p1bCN7eMFQZDIxWxz01vemtK0IMyur910Cs8blfQ+lqMCgNTaIORUcFTkXT2Vw5XL/3
 NwoAZam6PIO49CntZI2yLPNE+jeg6L9yyYDdNZg85AwM/nH8BtDLJTHLvh9ZFaGvxSpbfiv
 BRRe7D3PH3hNUXBtVvPMX5o9SQ7LI+x1H4+vLPiQXxcy5Hv20CgrsAHgPZBS+OLEvpqpAP2
 mbscrKH7lgmpVrAYM1AhqK3G2TcgTCFR60Sga/HkvurEUo/TDWIpE4g+/+PtYKpXkMoSMZ0
 iThoj4rLYS+XVhYR/a3oap38dTj+tDjW7EIPXvuHeynnTzhr089co6foWXE0SPMYc3QqdLx
 l4jszdzptlNKgyZJp4qChGSJHamecwIlXHsYboKvzAIsuD8mkkGUiHza4AZAAGk0RUsKjc6
 nFAGn44UTGKO6KAcgejE6drr017CotndxpK0xuM8OTA2ObywWsrRmuuh+v9SDmUeMr/ALmC
 CNyTgmx9Hv8qq9RitfiBQGCw3Yirew3KPBYk3P8yImlX3jiSflAH91D4gDDsmV6svLkcZxD
 H54mMTYFhyfD6i+QhCBKD7xEx3JFMU4kPghdbwQD8onujsnYMV0gLjfUkObUm+hTvM6x4R2
 mVpqsuuwWTSEU96HywTHkVkSCtGvcUDkZ/ospPUIrHaIEEEh6xamDY7tskSNCxs9gP9WQpe
 zvqbLstg5raANksRKmxCDtJQN4Xobc3Udjm5rAwyg2YpzbO9itv4y30zjBu7g9baZTWxPEs
 OIG/+qjHD1RL7a5R987xOoeH2ElCF5JL61LZBM0Jige29n50bRIRdrrYc0P8ZWCMXC1RFpD
 6FLti47MXRLuZ6toDJupLm/rdpXqVcDLFNzNgfDov7sJysLU06nVMfqW+493uP1j8nsvqGJ
 MsC0x+3vO6bUAvW12YQ6I6f1+56E5PA02tGLnUO3n4hyF0Gim2HpVHxE2jl45GhqQU/d4aq
 ZHt00g/VwNrBgJuh+bUoZbM6HqlNxKLnJfIfOiax9/glDOsAEF
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun Nov 22, 2026 at 1:57 AM CST, Gyeyoung Baek wrote:
> Hi Baihui,
>
> On Wed, Nov 11, 2026 at 6:29=E2=80=AFPM Baihui Liang
> <liangbaihui@linux.spacemit.com> wrote:
> >
> > pvr_power_device_idle() rejects runtime suspend while the firmware
> > hasn't reached ROGUE_FWIF_POW_IDLE. The PM core doesn't reschedule
> > idle notification after rejection, so no further pm_runtime_put()
> > arrives on an idle GPU and the device stays powered indefinitely.
> >
> > Move the idle check into pvr_power_device_suspend() and return -EBUSY
> > after pm_runtime_mark_last_busy() so the PM core reschedules the
> > autosuspend timer and retries until the firmware is idle.
>
> My understanding of Sashiko's point (correct me if I'm wrong):
>
> - pvr_remove(): must power off unconditionally
> - runtime suspend: power off only once idle (-EBUSY otherwise)
>
> Since remove goes through the suspend callback, it can now skip the
> power-off on -EBUSY.

Exactly right.

> Moving the idle check into runtime suspend looks right to me, so how
> about keeping just the power-off logic in a common helper, called by
> runtime suspend after the idle check and by remove directly? Roughly:
>
>   pvr_power_device_off()        /* fw_disable + power_off */
>
>   pvr_remove()
>       pm_runtime_disable();
>       if (!pm_runtime_status_suspended()) {
>           pvr_power_device_off();
>           pm_runtime_set_suspended();
>       }
>       pm_runtime_enable();      /* balance devm_pm_runtime_enable() */

Agreed =E2=80=94 that's the shape I ended up with: a common power-off helpe=
r called from runtime suspend after the idle check, and from pvr_remove() w=
ith runtime PM disabled around it.

Thanks,
Baihui
