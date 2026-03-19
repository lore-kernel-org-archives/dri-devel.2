Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1841C1075279
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B73210E91F;
	Thu, 19 Mar 2026 08:51:36 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DB9410E91F
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 08:51:34 +0000 (UTC)
Received: from [192.168.1.204] (unknown [112.94.102.202])
 by APP-01 (Coremail) with SMTP id qwCowAB3H2sDubtpAUZ9Cg--.19908S2;
 Thu, 19 Mar 2026 16:51:16 +0800 (CST)
Message-ID: <0f020c50e0ad4d8aa6097a1fac06b36955e3318a.camel@iscas.ac.cn>
Subject: Re: [PATCH v2] MAINTAINERS: Update GPU driver maintainer information
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Thomas Zimmermann <tzimmermann@suse.de>, Jianmin Lv
 <lvjianmin@loongson.cn>,  David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst	 <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,  Qianhai Wu <wuqianhai@loongson.cn>,
 Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>,  Huacai
 Chen <chenhuacai@kernel.org>
Cc: Xuefeng Li <lixuefeng@loongson.cn>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 19 Mar 2026 16:51:14 +0800
In-Reply-To: <85ffc605-f665-4973-ae83-fcc1c53bd7e4@suse.de>
References: <20260318092349.11651-1-lvjianmin@loongson.cn>
 <85ffc605-f665-4973-ae83-fcc1c53bd7e4@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: qwCowAB3H2sDubtpAUZ9Cg--.19908S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyrtF4UCr4Dur4xGF13XFb_yoW8tw4DpF
 Z7Ga4akF9FyF47ArsIk3W7AFW5Ja95Ar98Crs8t3sxZr90yr1rtw4Uta15Ga1DXrW3GF42
 ywn2ya4ruan8tFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
 MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
 4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
 67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
 x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
 z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
 UI43ZEXa7IU84v3UUUUUU==
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

=E5=9C=A8 2026-03-19=E5=9B=9B=E7=9A=84 08:54 +0100=EF=BC=8CThomas Zimmerman=
n=E5=86=99=E9=81=93=EF=BC=9A
> Hi
>=20
> Am 18.03.26 um 10:23 schrieb Jianmin Lv:
> > I and Qianhai are GPU R&D engineers at Loongson, specializing
> > in kernel driver development. We understand that the current
> > Loongson GPU driver lacks dedicated maintenance resources
> > because of some reasons.
> >=20
> > As Loongson GPU driver developers, we have both the capability
> > and the responsibility to continuously maintain the Loongson
> > GPU driver, ensuring minimal impact on its users. After internal
> > discussions, our team has decided to recommend me and Qianhai
> > to take over the maintenance responsibilities, and recommend
> > Huacai, Mingcong and Ruoyao to help to review.
> >=20
> > And We'll continue to maintain it for current supported chips
> > and drive future updates according to chip support plan.
>=20
> Welcome and thanks for helping out.
>=20
> Yesterday, Icenowy Zheng also volunteered to help with the driver. If
> she's still interested, I think you should both co-maintain the
> driver.=20

I am still interested, especially for MIPS-based Loongson systems. I'm
okay to act either as a co-maintainer or a reviewer, and let Loongson
folks to decide it.

> Icenowy is already active in the maintenance of other DRM drivers and
> can certainly do good work here as well.
>=20
> Best regards
> Thomas
>=20
> >=20
> > Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 96ea84948d76..4232039b7282 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8626,8 +8626,13 @@ F:	drivers/gpu/drm/lima/
> > =C2=A0 F:	include/uapi/drm/lima_drm.h
> > =C2=A0=20
> > =C2=A0 DRM DRIVERS FOR LOONGSON
> > +M:	Jianmin Lv <lvjianmin@loongson.cn>
> > +M:	Qianhai Wu <wuqianhai@loongson.cn>
> > +R:	Huacai Chen <chenhuacai@kernel.org>
> > +R:	Mingcong Bai <jeffbai@aosc.io>
> > +R:	Xi Ruoyao <xry111@xry111.site>
> > =C2=A0 L:	dri-devel@lists.freedesktop.org
> > -S:	Orphan
> > +S:	Maintained

By the way, previously when Sui Jingfeng is in charge of this driver,
the status is "Supported" instead of "Maintained". Does this change
show any difference on Loongson's attitude towards this driver?

Thanks,
Icenowy

> > =C2=A0 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> > =C2=A0 F:	drivers/gpu/drm/loongson/
> > =C2=A0=20

