Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F342E606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JdFXYXi0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BCA110F25A;
	Mon, 16 Nov 2026 15:11:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F2EF10F267
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:11:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3E85862D94
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68111F000CD
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794841883;
 bh=NFaRubGQ2uSM82AzOw+nsHIeODCdYiKnFpnw0Wrcf/c=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=JdFXYXi0sztEjaW0m29nlrJdi9t2WrR8uv3y83FxfqQx/yVCZfOBLIdKv7hPG/903
 TTRzbw1hTVkIFQWTDBpUSkupm7eW6t/ahEultY759TMx444M05wpcJLkWObh6ryWQ8
 VkqX8noN1+2uYk0ET8OuVKjjNwD1bYTh9sEL26m/uBsfExN+kyBZXetFYJJZ/9Rvwn
 vIvaeRl2JvgbGBPCErKH5LN0fF1IT+xmWocjpNlLF999YxihcGGmw4prYDbtSmVPTD
 CnqQ+AIgUSEbxAyEBhRRY5qSUGxYbCyJ3YowiQGPUCVrQ3/2bDksSbYxBjIbGp/ebM
 j81/uLJoR5iIw==
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-1b3a05f8b5bso4368089c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 07:11:23 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErG/TRBhusBRXECZ4vfKZk1IInXL5OrAvoGwmS52l7yhD7t82pM93PC2p4BONDGZ9hFMc9/RuIIK2hI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+QDvIxg2sM2vudkg5sBNAbFphoQCUdUPFKgj3lJGCFGbpg11ZO
 bYf+yjUUGEbWKaCjF9f7wwsfPJR8/sLBfk0nHPtC5xuvcX6HTLqevXKHNVHwQDViqrVn/BPkEcD
 wiE4lls+1orcaF4WegpYFKylDvl1z/g==
X-Received: by 2002:a05:7022:ea24:b0:1a9:e382:cedc with SMTP id
 a92af1059eb24-1b5030fb905mr11645158c88.46.1794841883321; Mon, 16 Nov 2026
 07:11:23 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260924083456.461815-1-peng.fan@oss.nxp.com>
 <57deb2ae1a6235e9e0b84458ee228b1ce8ed418a.camel@mediatek.com>
In-Reply-To: <57deb2ae1a6235e9e0b84458ee228b1ce8ed418a.camel@mediatek.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Mon, 16 Nov 2026 15:11:10 +0000
X-Gmail-Original-Message-ID: <CAAOTY_8Kuqod1ahnK4enW_qtUcTo6mhZdQiUnsO4tr3YW+7erw@mail.gmail.com>
X-Gm-Features: AclHuK87v-swgB4tyftV1cjviFzSnuNyxXDhT4UWABAFzKQ_MREyYceQWgdsnHc
Message-ID: <CAAOTY_8Kuqod1ahnK4enW_qtUcTo6mhZdQiUnsO4tr3YW+7erw@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: hdmi: use regmap_assign_bits() for
 conditional set/clear
To: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
Cc: "peng.fan@oss.nxp.com" <peng.fan@oss.nxp.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, 
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "airlied@gmail.com" <airlied@gmail.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
 "simona@ffwll.ch" <simona@ffwll.ch>, "peng.fan@nxp.com" <peng.fan@nxp.com>, 
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

CK Hu (=E8=83=A1=E4=BF=8A=E5=85=89) <ck.hu@mediatek.com> =E6=96=BC 2026=E5=
=B9=B410=E6=9C=8812=E6=97=A5=E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=887:34=E5=AF=
=AB=E9=81=93=EF=BC=9A
>
> On Thu, 2026-09-24 at 16:34 +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Replace multiple if/else blocks using regmap_set_bits()/regmap_clear_bi=
ts()
> > with the simpler regmap_assign_bits() calls throughout the HDMI v2 driv=
er.
>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
>
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
