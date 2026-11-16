Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB063606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QPyXr6w1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1404210E3A6;
	Mon, 16 Nov 2026 14:33:15 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 070EE10E3A6
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 14:33:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B14D2459A6
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 14:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F32E1F000CD
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 14:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794839588;
 bh=bY381tBpZ0JDNechNv9i/NECgodmDi16DU0CcXmzrM0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=QPyXr6w1dQ/89QeuFQ1KjnpFQ6Li+1rotUlAJIR6EV7qx49t+IRSpNEpHFSIDibg8
 lNYJQPhgvl5tG8VasH57evNHHgH1q/XodLOMAdXhbQ79whp0QdwDvgeapGmfzsRooV
 EyVO9AunbAWq0px/ZqGclYIsC8pacu4WUl7Fmq3r5xadAiLzX22FFdafvu0peKSdB0
 gN2CNk9ku+envrFidvHsh7k0ppZ2mjZgtuILLbN4fcypIsJWHVcy1Y4DZSMDr5HpJU
 +XMiDVtcXZk3CHnbE9AzK21Q0FKQYKbPJgfy1Uu8GIFO00VDLTZs+ufdNzDJMUVd53
 p/mEO2k92wymA==
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-1b3beeaf6f9so4031285c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 06:33:08 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErEvEA72PvAwcD3efz6oMooMiPQ2yKZ/zwKzfCB8RR8Lt30rZembLMVGNZQyy3ySlFgsLvD84pMbuSE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/OCTejHbPq4A4FWUaLcfPWRR4BkY+Owff/T2S7G/a18IQ2i2+T
 A8ziI+kQbSYxCXEuo9zIOMVt6oiTxCYT70O2W3RgfkTtcc77I//XjlnqEiK7iRRgLlzWR/SJaFB
 scx0obDLPRcRiwHhfERpvUmVmcVBfBA==
X-Received: by 2002:a05:701b:2706:b0:1a4:c892:b14f with SMTP id
 a92af1059eb24-1b50312144fmr9904001c88.29.1794839587963; Mon, 16 Nov 2026
 06:33:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261004-rbrue-suez-upstreaming-mtk-dsi-cmd-mode-v1-1-53a4f46ca489@gmail.com>
 <8c8ff7e2-d1a4-45c8-aacf-bca93439a32d@gmail.com>
 <524b9675fd10d0d21880821c10a4f0e188d24956.camel@mediatek.com>
In-Reply-To: <524b9675fd10d0d21880821c10a4f0e188d24956.camel@mediatek.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Mon, 16 Nov 2026 14:32:52 +0000
X-Gmail-Original-Message-ID: <CAAOTY__vpA+t+T5QM1J1pkcFYju5HjQ+MnwNt-60Gh_0wbTzzA@mail.gmail.com>
X-Gm-Features: AclHuK83NHlxO1R39k_ekBxI8gtiR3r3nltG-X9iF9NvNtWqqPTHxKvu6MAR4l4
Message-ID: <CAAOTY__vpA+t+T5QM1J1pkcFYju5HjQ+MnwNt-60Gh_0wbTzzA@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm/mediatek: dsi: force command mode in
 mtk_dsi_poweron()
To: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
Cc: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
 "ryanbrue.dev@gmail.com" <ryanbrue.dev@gmail.com>, 
 "airlied@gmail.com" <airlied@gmail.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
 "simona@ffwll.ch" <simona@ffwll.ch>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

CK Hu (=E8=83=A1=E4=BF=8A=E5=85=89) <ck.hu@mediatek.com> =E6=96=BC 2026=E5=
=B9=B411=E6=9C=8811=E6=97=A5=E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=882:43=E5=AF=
=AB=E9=81=93=EF=BC=9A
>
> On Tue, 2026-11-10 at 20:26 -0600, Ryan Brue wrote:
> > External email : Please do not click links or open attachments until yo=
u have verified the sender or the content.
> >
> >
> > Hi Chun-Kuang,
> >
> > Gentle ping on this one for mediatek-drm-next now that 7.4-rc1 is out.
> > It has CK's Reviewed-by and Roman's Acked-by, and it still applies
> > cleanly to v7.4-rc2 and mediatek-drm-next. I can resend it with the tag=
s
> > if that's easier.
>
> Hi, I'm Chun-Kuang [1].
> It's not necessary to resend.
> I would apply this patch later.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D93e97f715b24114169d18654e09c646fd9e14979
>
> Chun-Kuang.
>
> >
> > Thanks,
> > Ryan Brue
> >
>
