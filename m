Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB66FCD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BE8410E26E;
	Tue, 19 May 2026 07:51:48 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0C3210E26E
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:51:46 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.150])
 by APP-01 (Coremail) with SMTP id qwCowAAXu2aPFgxqyau+EA--.2354S2;
 Tue, 19 May 2026 15:51:43 +0800 (CST)
Message-ID: <18e182e92a41459da5e7be0e43e62048ff2eba52.camel@iscas.ac.cn>
Subject: Re: [PATH] drm/loongson: add cleanup path for lsdc_ttm_init
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Xi Ruoyao <xry111@xry111.site>, yaolu@kylinos.cn, lvjianmin@loongson.cn,
 wuqianhai@loongson.cn
Cc: chenhuacai@kernel.org, jeffbai@aosc.io, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Date: Tue, 19 May 2026 15:51:42 +0800
In-Reply-To: <580c761b3297a079b88823ce323c131b57696e71.camel@xry111.site>
References: <20260519074158.144134-1-yaolu@kylinos.cn>
 <580c761b3297a079b88823ce323c131b57696e71.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: qwCowAAXu2aPFgxqyau+EA--.2354S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1UtFyrAr4fCryrKr13CFg_yoW8ury8pF
 Z5JFy0kFWUCFZ29Fy7KF1kCF9Ivw4IgFWxXr48A343uw4qyr95KFyrWF47GFyv9rW7CF1a
 9Fs7Wwn7u3WDZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK
 82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
 C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48J
 MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMI
 IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
 87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUgeOJDUUUU
X-Originating-IP: [112.94.102.150]
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

=E5=9C=A8 2026-05-19=E4=BA=8C=E7=9A=84 15:43 +0800=EF=BC=8CXi Ruoyao=E5=86=
=99=E9=81=93=EF=BC=9A
> On Tue, 2026-05-19 at 15:41 +0800, yaolu@kylinos.cn=C2=A0wrote:
> > From: Lu Yao <yaolu@kylinos.cn>
> >=20
> > There has resource leak when TTM_PL_VRAM or TTM_PL_TT man range
> > init
> > failed.
> >=20
> > Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> > ---
> > =C2=A0drivers/gpu/drm/loongson/lsdc_ttm.c | 10 ++++++++--
> > =C2=A01 file changed, 8 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/loongson/lsdc_ttm.c
> > b/drivers/gpu/drm/loongson/lsdc_ttm.c
> > index d7441d96a0dc..c84bc582f77c 100644
> > --- a/drivers/gpu/drm/loongson/lsdc_ttm.c
> > +++ b/drivers/gpu/drm/loongson/lsdc_ttm.c
> > @@ -554,7 +554,7 @@ int lsdc_ttm_init(struct lsdc_device *ldev)
> > =C2=A0
> > =C2=A0	ret =3D ttm_range_man_init(&ldev->bdev, TTM_PL_VRAM, false,
> > num_vram_pages);
> > =C2=A0	if (unlikely(ret))
> > -		return ret;
> > +		goto err_vram;
> > =C2=A0
> > =C2=A0	drm_info(ddev, "VRAM: %lu pages ready\n", num_vram_pages);
> > =C2=A0
> > @@ -565,11 +565,17 @@ int lsdc_ttm_init(struct lsdc_device *ldev)
> > =C2=A0
> > =C2=A0	ret =3D ttm_range_man_init(&ldev->bdev, TTM_PL_TT, true,
> > num_gtt_pages);
> > =C2=A0	if (unlikely(ret))
> > -		return ret;
> > +		goto err_gtt;
> > =C2=A0
> > =C2=A0	drm_info(ddev, "GTT: %lu pages ready\n", num_gtt_pages);
> > =C2=A0
> > =C2=A0	return drmm_add_action_or_reset(ddev, lsdc_ttm_fini,
> > ldev);
>=20
> Isn't the error handling path also needed in case
> drmm_add_action_or_reset fails?

drmm_add_action_or_reset adds an action for teardown, and if it fails,
the teardown will immediately happen (this is what `or_reset` means).

The `lsdc_ttm_fini()` function will properly finalize both ttm range
managers and the ttm device, so it's not a problem here.

This patch is quite valid for handling the situation that some init
operations succeeded and some failed in this function.

Thanks,
Icenowy

>=20
> > +
> > +err_gtt:
> > +	ttm_range_man_fini(&ldev->bdev, TTM_PL_VRAM);
> > +err_vram:
> > +	ttm_device_fini(&ldev->bdev);
> > +	return ret;
> > =C2=A0}
> > =C2=A0
> > =C2=A0void lsdc_ttm_debugfs_init(struct lsdc_device *ldev)

