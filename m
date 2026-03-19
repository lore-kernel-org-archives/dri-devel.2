Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2586109022A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 13:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22F8C10E896;
	Thu, 19 Mar 2026 13:55:14 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D182110E896
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 13:55:12 +0000 (UTC)
Received: from [192.168.1.204] (unknown [112.94.102.202])
 by APP-03 (Coremail) with SMTP id rQCowAD32uE0ALxpJvMlCw--.22136S2;
 Thu, 19 Mar 2026 21:55:01 +0800 (CST)
Message-ID: <2c40f4c40da3a5bdf66bb22f75e41b8ca1ab4934.camel@iscas.ac.cn>
Subject: Re: [PATCH v2] MAINTAINERS: Update GPU driver maintainer information
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Jianmin Lv <lvjianmin@loongson.cn>, Thomas Zimmermann
 <tzimmermann@suse.de>,  David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst	 <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,  Qianhai Wu <wuqianhai@loongson.cn>,
 Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>,  Huacai
 Chen <chenhuacai@kernel.org>
Cc: Xuefeng Li <lixuefeng@loongson.cn>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 19 Mar 2026 21:55:00 +0800
In-Reply-To: <8c04428b-dd00-c3d2-b3b1-56fd94b26b04@loongson.cn>
References: <20260318092349.11651-1-lvjianmin@loongson.cn>
 <85ffc605-f665-4973-ae83-fcc1c53bd7e4@suse.de>
 <0f020c50e0ad4d8aa6097a1fac06b36955e3318a.camel@iscas.ac.cn>
 <8c04428b-dd00-c3d2-b3b1-56fd94b26b04@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: rQCowAD32uE0ALxpJvMlCw--.22136S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWUAFWfXw47Cw43tr1UJrb_yoW5Aw4UpF
 ZrJ3WakFsrJrn7ArsrK3W7AFWUt34rJryDurs8J34fZrZ0yF1fKa18tay3CF4DXrWrGF42
 vw1xta4fuF45AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
 1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
 C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
 wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
 v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
 jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
 ZFpf9x07j0fOwUUUUU=
X-Originating-IP: [112.94.102.202]
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

=E5=9C=A8 2026-03-19=E5=9B=9B=E7=9A=84 21:08 +0800=EF=BC=8CJianmin Lv=E5=86=
=99=E9=81=93=EF=BC=9A
>=20
>=20
> On 2026/3/19 =E4=B8=8B=E5=8D=884:51, Icenowy Zheng wrote:
> > =E5=9C=A8 2026-03-19=E5=9B=9B=E7=9A=84 08:54 +0100=EF=BC=8CThomas Zimme=
rmann=E5=86=99=E9=81=93=EF=BC=9A
> > > Hi
> > >=20
> > > Am 18.03.26 um 10:23 schrieb Jianmin Lv:
> > > > I and Qianhai are GPU R&D engineers at Loongson, specializing
> > > > in kernel driver development. We understand that the current
> > > > Loongson GPU driver lacks dedicated maintenance resources
> > > > because of some reasons.
> > > >=20
> > > > As Loongson GPU driver developers, we have both the capability
> > > > and the responsibility to continuously maintain the Loongson
> > > > GPU driver, ensuring minimal impact on its users. After
> > > > internal
> > > > discussions, our team has decided to recommend me and Qianhai
> > > > to take over the maintenance responsibilities, and recommend
> > > > Huacai, Mingcong and Ruoyao to help to review.
> > > >=20
> > > > And We'll continue to maintain it for current supported chips
> > > > and drive future updates according to chip support plan.
> > >=20
> > > Welcome and thanks for helping out.
> > >=20
> > > Yesterday, Icenowy Zheng also volunteered to help with the
> > > driver. If
> > > she's still interested, I think you should both co-maintain the
> > > driver.
> >=20
> > I am still interested, especially for MIPS-based Loongson systems.
> > I'm
> > okay to act either as a co-maintainer or a reviewer, and let
> > Loongson
> > folks to decide it.
>=20
> Hi=EF=BC=8CIcenowy
>=20
> Thanks for willing to join us co-working the driver=EF=BC=8Cand I'll add =
you
> as=20
> reviewer in v3 patch, expecting a pleasant cooperation.
>=20
> BTW, it will help me to look into and reply your patch if you can CC
> me,=20
> thanks.

Well I will send a respin of this patch in this weekend.

Thanks,
Icenowy

>=20
> https://lore.kernel.org/dri-devel/c6013f25-fce0-41ba-a275-96188a6647c1@su=
se.de/T/#t
>=20
> >=20
> > > Icenowy is already active in the maintenance of other DRM drivers
> > > and
> > > can certainly do good work here as well.
> > >=20
> > > Best regards
> > > Thomas
> > >=20
> > > >=20
> > > > Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> > > >=20
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 96ea84948d76..4232039b7282 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -8626,8 +8626,13 @@ F:	drivers/gpu/drm/lima/
> > > > =C2=A0=C2=A0 F:	include/uapi/drm/lima_drm.h
> > > > =C2=A0=C2=A0=20
> > > > =C2=A0=C2=A0 DRM DRIVERS FOR LOONGSON
> > > > +M:	Jianmin Lv <lvjianmin@loongson.cn>
> > > > +M:	Qianhai Wu <wuqianhai@loongson.cn>
> > > > +R:	Huacai Chen <chenhuacai@kernel.org>
> > > > +R:	Mingcong Bai <jeffbai@aosc.io>
> > > > +R:	Xi Ruoyao <xry111@xry111.site>
> > > > =C2=A0=C2=A0 L:	dri-devel@lists.freedesktop.org
> > > > -S:	Orphan
> > > > +S:	Maintained
> >=20
> > By the way, previously when Sui Jingfeng is in charge of this
> > driver,
> > the status is "Supported" instead of "Maintained". Does this change
> > show any difference on Loongson's attitude towards this driver?
> >=20
> > Thanks,
> > Icenowy
> >=20
> > > > =C2=A0=C2=A0 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.=
git
> > > > =C2=A0=C2=A0 F:	drivers/gpu/drm/loongson/
> > > > =C2=A0=C2=A0=20

