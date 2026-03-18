Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8337103E168
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 12:44:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56F4C10E7F9;
	Wed, 18 Mar 2026 12:44:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nfraprado@collabora.com header.b="cI5cy8WC";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC5C810E7F9
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 12:44:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773837818; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Hcjl9+vzue7SzWhzftZD+XWtH9Yf8T288QTE9F2ExKhdct03dWuK/PHw2vPlDPIzC/C/Ou3YwsioE8jHWQLRZxIEMMwFWEMHnca3/Zez0hbi6UedZ7BQ7/JOvEIxjiq4v51bIv68KpkXYoxv4ffC42hDeR0UdzDc/Gu6MjoTieo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773837818;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=EIzK+XJwL26FKWEfLAVTsG+0YLZHEvqVIhcFK4tOcqY=; 
 b=Y9p0I/mJr3WJ00wwmSz6u4dZaMRMhyxvuT1zoP0VWjF5ri6vaDUJP7SZD/T/qNpfs9vV0PNRlmUoo+dRC41HWivIVEo3l4LCqy0hrhGsoPUSe5N7YSK/JKsecxtMziOFayEYrobpY8FW8wKI8IzQAfy4aEUiDheXxIezNoStiuM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nfraprado@collabora.com;
 dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773837818; 
 s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=EIzK+XJwL26FKWEfLAVTsG+0YLZHEvqVIhcFK4tOcqY=;
 b=cI5cy8WCw9aIJg3VyKe8Jth+80B0ZoaE+cQzwOqWzZNKd+A2yR5yYY0snnWPmsIZ
 k1QMef+al2XTz2pAqdTOFyjuVqw9dU1+VQpYRVLjuioDCxki44ZYSg8gSCwLIrwXAUC
 eAfV2FQmKwkhp24z5H6MKxBA4eCGArTQIZsOY/8g=
Received: by mx.zohomail.com with SMTPS id 1773837815709511.22830844796204;
 Wed, 18 Mar 2026 05:43:35 -0700 (PDT)
Message-ID: <c1315144a464f8fee2d712d67f983ac0b3a94be8.camel@collabora.com>
Subject: Re: [PATCH 00/11] Plane Color Pipeline support for MediaTek
From: =?ISO-8859-1?Q?N=EDcolas?= "F. R. A. Prado" <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 CK Hu =?UTF-8?Q?=28=E8=83=A1=E4=BF=8A=E5=85=89=29?=
 <ck.hu@mediatek.com>, "pekka.paalanen@collabora.com"
 <pekka.paalanen@collabora.com>, "harry.wentland@amd.com"
 <harry.wentland@amd.com>
Cc: "wiagn233@outlook.com" <wiagn233@outlook.com>, "tzimmermann@suse.de"	
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>, 
 "mripard@kernel.org"	 <mripard@kernel.org>, Daniel Stone
 <daniels@collabora.com>,  "linux-mediatek@lists.infradead.org"	
 <linux-mediatek@lists.infradead.org>, "maarten.lankhorst@linux.intel.com"	
 <maarten.lankhorst@linux.intel.com>, "dri-devel@lists.freedesktop.org"	
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>, "chunkuang.hu@kernel.org"	
 <chunkuang.hu@kernel.org>, "kernel@collabora.com" <kernel@collabora.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,  "xaver.hugl@gmail.com"	
 <xaver.hugl@gmail.com>, "linux-arm-kernel@lists.infradead.org"	
 <linux-arm-kernel@lists.infradead.org>, "airlied@gmail.com"
 <airlied@gmail.com>,  "matthias.bgg@gmail.com"	 <matthias.bgg@gmail.com>
Date: Wed, 18 Mar 2026 08:43:32 -0400
In-Reply-To: <67acc82d-e145-4f98-88b2-d30cc73f73a0@collabora.com>
References: <20251223-mtk-ovl-pre-blend-colorops-v1-0-0cb99bd0ab33@collabora.com>
 <TY4PR01MB144323B0DDC18B05EE1472B5298BFA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <TY4PR01MB14432E7601C0BE848D25E80C398BAA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <cdf6a704-88f8-414a-adf1-65ea7237337f@amd.com>
 <20260206110901.660cf712@eldfell>
 <5963bca37996fa054ad75d4e5017d9c7e5158e9f.camel@collabora.com>
 <3efaa7ec40c68f0d463da00c3a57474a40d4fdae.camel@mediatek.com>
 <2e241629-2526-41c5-92fd-a0a0ec3ffc4e@collabora.com>
 <67acc82d-e145-4f98-88b2-d30cc73f73a0@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8 
MIME-Version: 1.0
X-ZohoMailClient: External
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

On Thu, 2026-02-26 at 11:51 +0100, AngeloGioacchino Del Regno wrote:
> Il 26/02/26 11:26, AngeloGioacchino Del Regno ha scritto:
> > Il 26/02/26 07:24, CK Hu (=E8=83=A1=E4=BF=8A=E5=85=89) ha scritto:
> > > On Fri, 2026-02-06 at 08:28 -0500, N=C3=ADcolas F. R. A. Prado wrote:
> > > > On Fri, 2026-02-06 at 11:09 +0200, Pekka Paalanen wrote:
> > > > > On Fri, 2 Jan 2026 13:40:21 -0500
> > > > > Harry Wentland <harry.wentland@amd.com> wrote:
> > > > >=20
> > > > > > On 2026-01-01 07:37, Shengyu Qu wrote:
> > > > > > >=20
> > > > > > >=20
> > > > > > > =E5=9C=A8 2025/12/30 02:53, Shengyu Qu =E5=86=99=E9=81=93:
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > =E5=9C=A8 2025/12/24 3:44, N=C3=83 colas F. R. A. Prado =E5=
=86=99=E9=81=93:
> > > > >=20
> > > > > > > > > Given the lack of support for writeback connectors on
> > > > > > > > > the
> > > > > > > > > MediaTek KMS driver, combined with limited hardware
> > > > > > > > > documentation, I haven't been able to verify the
> > > > > > > > > correctness
> > > > > > > > > of
> > > > > > > > > each curve, only that they were visually sane (gamma
> > > > > > > > > curves
> > > > > > > > > made
> > > > > > > > > the image on the display brighter, while inverse
> > > > > > > > > gamma made
> > > > > > > > > it
> > > > > > > > > darker).
> > > > > > > >=20
> > > > > > > > Hmmm I don't think this is acceptable. sRGB/scRGB has
> > > > > > > > two
> > > > > > > > transfer
> > > > > > > > functions mentioned in original specification[1]. To
> > > > > > > > keep color
> > > > > > > > accuracy, we need someone from mediatek confirm whether
> > > > > > > > this is
> > > > > > > > piece- wise or pure power 2.2 transfer function, this
> > > > > > > > is
> > > > > > > > already
> > > > > > > > done in original amdgpu color pipeline series, sRGB
> > > > > > > > means
> > > > > > > > piece-wise while also dedicated power 2.2 function
> > > > > > > > exists.
> > > > > >=20
> > > > > > Not sure what you mean with this not being acceptable. This
> > > > > > is
> > > > > > about
> > > > > > enabling HW support for this functionality. Not every HW
> > > > > > has
> > > > > > writeback for testing. At some point you'll have to trust
> > > > > > the
> > > > > > driver
> > > > > > devs if you're going to use functionality of the driver.
> > > > > > We're not
> > > > > > always going to get everything perfect, but if that's
> > > > > > really such a
> > > > > > worry you can always use shaders to do precisely what you
> > > > > > want.
> > > > > >=20
> > > > >=20
> > > > > Hi Harry,
> > > > >=20
> > > > > yes, but I understood that in this case, the hardware
> > > > > documentation
> > > > > available is so vague that it's impossible to say what it
> > > > > will
> > > > > actually
> > > > > do. There are no formulas given or referenced in the
> > > > > documentation,
> > > > > are
> > > > > there, N=C3=ADcolas?
> > > >=20
> > > > No formulas at all, the only documentation I had available for
> > > > the
> > > > curves was the register definition, which simply lists the
> > > > possible
> > > > values: SCRGB, BT709, BT2020, HLG.
> > >=20
> > > Hi, Nicolas:
> > >=20
> > > In [1], it shows OVL could output data to WDMA which could write
> > > data into DRAM.
> > > Its control is similar to RDMA. RDMA read data from DRAM and WDMA
> > > write data into=20
> > > DRAM.
> > > Do you have interest to implement WDMA?
> >=20
> > I wrote a WDMA driver a long ago, but I couldn't get it to work
> > (though, I admit I
> > didn't try hard to actually get it working).... if you want to take
> > a look to check
> > if anything obvious is missing, the driver is here:
> >=20
> > https://gitlab.collabora.com/mediatek/aiot/linux/-/blob/mediatek-dev/dr=
ivers/gpu/
> > =C2=A0
> > drm/mediatek/mtk_disp_wdma.c?ref_type=3Dheads
> >=20
> > The driver I wrote was supposed to work on MT8781 Helio G99 (for a
> > personal project
>=20
> Eh, sorry for the double email, I was meaning MT6789 Helio G99 - just
> to be
> extremely clear, though that wasn't much important (given that the
> WDMA IP is
> anyway practically the same between the two..).
>=20
> > as in upstreaming of the Xiaomi Poco M5 smartphone) and on MT8195
> > as a PoC.
> > I did test both platforms and this driver didn't work on both...
> > not sure if that
> > was because I misconfigured the MMSYS routing (on both) or if
> > there's any actual
> > issue with the driver I wrote.
> >=20
> > Again, didn't invest much time on this, anyway, so some obvious
> > issue might be
> > present.

Hi,

Sorry for the delay.

Yes, I'm aware that the hardware supports writeback through the WDMA
component, but as Angelo's implementation still seems to need some work
(I quickly gave it a try but couldn't get it working), and I have very
limited time to work on this, I'm first trying to reach out to MediaTek
to see if more information can be obtained on this.

(We also considered other options like routing the output of OVL to
HDMI and capturing it from there, but again my time is the biggest
limiter right now)
>=20

--=20
Thanks,

N=C3=ADcolas
