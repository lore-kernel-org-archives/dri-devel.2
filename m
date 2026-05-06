Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FB8CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 18:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 721BD10E575;
	Wed,  6 May 2026 18:00:30 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 262CC10E575
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 18:00:27 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.82])
 by APP-01 (Coremail) with SMTP id qwCowAA33Gevgftp9QJ0Dw--.26398S2;
 Thu, 07 May 2026 02:00:16 +0800 (CST)
Message-ID: <02da4b80a80e2ed9e90af8469f3c3ffb6f2f42a1.camel@iscas.ac.cn>
Subject: Re: [PATCH] drm: verisilicon: support non-coherent DMA framebuffers
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Dominique Belhachemi <domibel@debian.org>
Cc: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>,  David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Paul Cercueil <paul@crapouillou.net>,  Michal Wilczynski
 <m.wilczynski@samsung.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Date: Thu, 07 May 2026 02:00:15 +0800
In-Reply-To: <CAAvaLCznuRK86JkQA0EaFswyagnmaOnDCCEWDoC86+_Gc0wYqQ@mail.gmail.com>
References: <20260505042631.1916555-1-domibel@debian.org>
 <9f7eaea02c2cb52afac4f59fb78224e9acc1f160.camel@iscas.ac.cn>
 <CAAvaLCyZfdo+h+gYjEd6=kDug0A77rqH2e4U7JzpUEEGo_mvDA@mail.gmail.com>
 <de419b42100ae55bfc1d6db44cac3d763c57247b.camel@iscas.ac.cn>
 <CAAvaLCznuRK86JkQA0EaFswyagnmaOnDCCEWDoC86+_Gc0wYqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: qwCowAA33Gevgftp9QJ0Dw--.26398S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr13KFWUJF4UKF4fAr18Zrb_yoW8Kw13pF
 WDKF4YgF4DJr97Zws2gw1YkF4Fy395JFy5Xwn5Xw1xXrZ0vF18ZF47JrW5uFnFqryv9F4a
 v3WFvas3Xa4DGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvlb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
 F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
 4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
 xwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
 W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
 1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
 IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
 x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
 DU0xZFpf9x07b0SoAUUUUU=
X-Originating-IP: [112.94.100.82]
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
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

=E5=9C=A8 2026-05-06=E4=B8=89=E7=9A=84 13:38 -0400=EF=BC=8CDominique Belhac=
hemi=E5=86=99=E9=81=93=EF=BC=9A
> On Wed, May 6, 2026 at 1:14=E2=80=AFPM Icenowy Zheng
> <zhengxingda@iscas.ac.cn> wrote:
> >=20
> > =E5=9C=A8 2026-05-05=E4=BA=8C=E7=9A=84 18:25 -0400=EF=BC=8CDominique Be=
lhachemi=E5=86=99=E9=81=93=EF=BC=9A
> > > On Tue, May 5, 2026 at 5:03=E2=80=AFAM Icenowy Zheng
> > > <zhengxingda@iscas.ac.cn> wrote:
> > > >=20
> > > > =E5=9C=A8 2026-05-05=E4=BA=8C=E7=9A=84 04:26 +0000=EF=BC=8CDominiqu=
e Belhachemi=E5=86=99=E9=81=93=EF=BC=9A
> > > > > Wire up the standard non-coherent path matching the ingenic
> > > > > DRM
> > > > > driver.
> > > > >=20
> > > > > Tested on StarFive JH7110 (VisionFive 2 v1.3B).
> > > >=20
> > > > Interesting, I am curious about other patches added to test
> > > > this.
> > > >=20
> > > Hi,
> > >=20
> > > I tested this on Debian unstable with a slightly patched 7.0.3
> > > kernel
> > > [1].
> > > The test branch contains your verisilicon series, Michal's JH7110
> > > display series [2],
> > > and a JH7110 ccache change [3], which was also required to
> > > communicate
> > > with the BXE-4-32 firmware [4].
> >=20
> > BTW did you run any rendering? I think the way currently powervr
> > open
> > source driver works requires "coherent memory" (although it's
> > usually
> > implemented as uncached memory).
>=20
> Yes, GPU dispatches run with [4].
> Compute shaders run fine, but rendering crashes after a few frames.
>=20
> > >=20
> > > This change here is only used to remove the ugly framebuffer
> > > stripes
> > > on the console and in the desktop environment.
> >=20
> > But I still think it'd be better to implement proper uncached
> > memory
> > support instead of flushing caches with dirty tracking.
>=20
> Maybe, this patch is just a working alternative.

I wonder whether it's possible to detect the availability of uncached
memory.

At least detecting using `of_dma_is_coherent()` isn't enough because it
will only be true when the device is fully coherent with the CPU
(snooping CPU cache).

Thanks,
Icenowy

>=20
> Dominique
>=20
> > >=20
> > > [1]
> > > https://github.com/domibel/linux/tree/jh7110_dc8200_hdmi_v7.0.3
> > > [2]
> > > https://lore.kernel.org/lkml/20251108-jh7110-clean-send-v1-0-06bf43bb=
76b1@samsung.com/
> > > [3]
> > > https://lore.kernel.org/lkml/20260430035259.3402954-1-domibel@debian.=
org/
> > > [4]
> > > https://github.com/domibel/linux/tree/powervr_on_jh7110_visionfive2_v=
7.0.3
> >=20
> > The POW_RASCALDUST thing looks quite interesting, maybe I should
> > investigate it further.
> >=20
> > Thanks,
> > Icenowy
> > >=20
> > > Dominique
> >=20
> >=20

