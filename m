Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C94CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 09:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A85AE10E51A;
	Wed,  6 May 2026 09:01:55 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C756810E51A
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 09:01:52 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.82])
 by APP-03 (Coremail) with SMTP id rQCowAAXOuF2A_tpYw44EA--.27547S2;
 Wed, 06 May 2026 17:01:42 +0800 (CST)
Message-ID: <de419b42100ae55bfc1d6db44cac3d763c57247b.camel@iscas.ac.cn>
Subject: Re: [PATCH] drm: verisilicon: support non-coherent DMA framebuffers
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Dominique Belhachemi <domibel@debian.org>
Cc: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>,  David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Paul Cercueil <paul@crapouillou.net>,  Michal Wilczynski
 <m.wilczynski@samsung.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Date: Wed, 06 May 2026 17:01:42 +0800
In-Reply-To: <CAAvaLCyZfdo+h+gYjEd6=kDug0A77rqH2e4U7JzpUEEGo_mvDA@mail.gmail.com>
References: <20260505042631.1916555-1-domibel@debian.org>
 <9f7eaea02c2cb52afac4f59fb78224e9acc1f160.camel@iscas.ac.cn>
 <CAAvaLCyZfdo+h+gYjEd6=kDug0A77rqH2e4U7JzpUEEGo_mvDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: rQCowAAXOuF2A_tpYw44EA--.27547S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4ruFWktF4DXr45Ar1UZFb_yoW8WFWrpF
 WkGF4YgrsxA34fZws2g3WjkayFy395Ary3X34kXw1xXrZ0vF1vvF1xAw4rWF17ur92g3W3
 Z3Wvkas5Ga4DGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
 MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
 4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
 67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
 x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
 z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73Uj
 IFyTuYvjxU2wIDUUUUU
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

=E5=9C=A8 2026-05-05=E4=BA=8C=E7=9A=84 18:25 -0400=EF=BC=8CDominique Belhac=
hemi=E5=86=99=E9=81=93=EF=BC=9A
> On Tue, May 5, 2026 at 5:03=E2=80=AFAM Icenowy Zheng
> <zhengxingda@iscas.ac.cn> wrote:
> >=20
> > =E5=9C=A8 2026-05-05=E4=BA=8C=E7=9A=84 04:26 +0000=EF=BC=8CDominique Be=
lhachemi=E5=86=99=E9=81=93=EF=BC=9A
> > > Wire up the standard non-coherent path matching the ingenic DRM
> > > driver.
> > >=20
> > > Tested on StarFive JH7110 (VisionFive 2 v1.3B).
> >=20
> > Interesting, I am curious about other patches added to test this.
> >=20
> Hi,
>=20
> I tested this on Debian unstable with a slightly patched 7.0.3 kernel
> [1].
> The test branch contains your verisilicon series, Michal's JH7110
> display series [2],
> and a JH7110 ccache change [3], which was also required to
> communicate
> with the BXE-4-32 firmware [4].

BTW did you run any rendering? I think the way currently powervr open
source driver works requires "coherent memory" (although it's usually
implemented as uncached memory).

>=20
> This change here is only used to remove the ugly framebuffer stripes
> on the console and in the desktop environment.

But I still think it'd be better to implement proper uncached memory
support instead of flushing caches with dirty tracking.

>=20
> [1] https://github.com/domibel/linux/tree/jh7110_dc8200_hdmi_v7.0.3
> [2]
> https://lore.kernel.org/lkml/20251108-jh7110-clean-send-v1-0-06bf43bb76b1=
@samsung.com/
> [3]
> https://lore.kernel.org/lkml/20260430035259.3402954-1-domibel@debian.org/
> [4]
> https://github.com/domibel/linux/tree/powervr_on_jh7110_visionfive2_v7.0.=
3

The POW_RASCALDUST thing looks quite interesting, maybe I should
investigate it further.

Thanks,
Icenowy
>=20
> Dominique

