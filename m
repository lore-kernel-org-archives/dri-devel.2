Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F43B606A322
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 04:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7245410E193;
	Sat, 31 Oct 2026 04:26:57 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C758410E193
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 04:26:52 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.150])
 by APP-03 (Coremail) with SMTP id rQCowACXaZoKbuVqW7wJAA--.8213S2;
 Sat, 31 Oct 2026 12:26:50 +0800 (CST)
Message-ID: <8639aa770c3289b83cc1b55e67885dd73c9e3efd.camel@iscas.ac.cn>
Subject: Re: [PATCH 1/2] drm/loongson: Fix double free on BO initialization
 failure
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Evanshenf <archwse@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>, Xi
 Ruoyao <xry111@xry111.site>, Sui Jingfeng <suijingfeng@loongson.cn>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 31 Oct 2026 12:26:50 +0800
In-Reply-To: <20261003093415.e64386de1e64-1-archwse@gmail.com>
References: <20261003093415.e64386de1e64-1-archwse@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: rQCowACXaZoKbuVqW7wJAA--.8213S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1rurWrJF1UJF47Zr1kKrg_yoW8ZF1Upa
 nxCa4jkryDJan2kr9rAF18C3W0ya1FgFWUuF45W3ZxWr13Cr1kCFyrua4jg3W7XFy7CF1a
 van3GanxWFn09wUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvlb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
 C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
 F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
 4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
 xwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
 W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
 1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
 IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
 x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
 DU0xZFpf9x07jUkucUUUUU=
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=E5=9C=A8 2026-10-03=E5=85=AD=E7=9A=84 09:34 +0000=EF=BC=8CEvanshenf=E5=86=
=99=E9=81=93=EF=BC=9A
> If ttm_bo_init_validate() fails, it drops the buffer object's
> reference
> and cleans it up through the supplied destroy callback.
> lsdc_bo_destroy()
> releases the GEM object and frees the enclosing lsdc_bo, so freeing
> it
> again in lsdc_bo_create() causes a double free on a synchronous
> failure
> path.
>=20
> Let TTM own the cleanup after initialization has started and return
> the
> error directly. Keep the explicit free on drm_gem_object_init()
> failure,
> which occurs before ownership is passed to TTM.
>=20
> Tested on LS7A2000 by making drm_vma_offset_add() return -ENOSPC for
> one
> selected dumb-buffer creation. The error reached userspace, the
> destroy
> callback ran once, and no handle was published or tracked BO
> retained.
> Normal buffer creation, zeroing, mapping, readback and release
> passed.
>=20
> AI assistance was used for the ownership analysis, fix, fault-
> injection
> tools, build and test execution.
>=20
> Fixes: f39db26c5428 ("drm: Add kms driver for loongson display
> controller")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Evanshenf <archwse@gmail.com>

Applied both to drm-misc-fixes, Thanks for your contribution!

Icenowy

> ---
> =C2=A0drivers/gpu/drm/loongson/lsdc_ttm.c | 4 +---
> =C2=A01 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/loongson/lsdc_ttm.c
> b/drivers/gpu/drm/loongson/lsdc_ttm.c
> index d7441d9..88536e2 100644
> --- a/drivers/gpu/drm/loongson/lsdc_ttm.c
> +++ b/drivers/gpu/drm/loongson/lsdc_ttm.c
> @@ -475,10 +475,8 @@ struct lsdc_bo *lsdc_bo_create(struct drm_device
> *ddev,
> =C2=A0
> =C2=A0	ret =3D ttm_bo_init_validate(bdev, tbo, bo_type, &lbo-
> >placement, 0,
> =C2=A0				=C2=A0=C2=A0 false, sg, resv,
> lsdc_bo_destroy);
> -	if (ret) {
> -		kfree(lbo);
> +	if (ret)
> =C2=A0		return ERR_PTR(ret);
> -	}
> =C2=A0
> =C2=A0	return lbo;
> =C2=A0}
>=20
> base-commit: bca45af5998a05f34b13a2ef11e639bac9c62643

