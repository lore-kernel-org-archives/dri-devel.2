Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E940E606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 04:26:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DC8810E079;
	Sat, 31 Oct 2026 04:26:37 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2391C10E079
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 04:26:34 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.150])
 by APP-03 (Coremail) with SMTP id rQCowABHGpvybeVqSLsJAA--.7893S2;
 Sat, 31 Oct 2026 12:26:27 +0800 (CST)
Message-ID: <20933d0650fcead77cb14dc1d07e0b05f0ce2448.camel@iscas.ac.cn>
Subject: Re: [PATCH] drm/loongson: Fix framebuffer selection in async cursor
 updates
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Evanshenf <archwse@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>, Xi
 Ruoyao <xry111@xry111.site>, Sui Jingfeng <suijingfeng@loongson.cn>, kernel
 test robot <lkp@intel.com>, stable@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Sat, 31 Oct 2026 12:26:25 +0800
In-Reply-To: <20261003090006.4e29fdce9913-1-archwse@gmail.com>
References: <20261003090006.4e29fdce9913-1-archwse@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: rQCowABHGpvybeVqSLsJAA--.7893S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4fCFy3urWUCrykGw1UGFg_yoW8Kr4DpF
 Z8t340krWkJw4vywsruF1fGFyfua1fWFyxKFyDGw1Fg34Yyr1Svry8u3yUWr47XrZrW34a
 vrsIkFn8KF4qv3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
 8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
 MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
 4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
 67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
 x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
 z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
 UI43ZEXa7IU84v3UUUUUU==
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=E5=9C=A8 2026-10-03=E5=85=AD=E7=9A=84 09:00 +0000=EF=BC=8CEvanshenf=E5=86=
=99=E9=81=93=EF=BC=9A
> An asynchronous cursor update swaps the new framebuffer into the live
> plane state. However, the driver reads both old_fb and new_fb from
> the
> live state before this swap. When an enabled cursor changes buffers,
> the
> address-update condition is therefore false and the hardware
> continues
> scanning the previous buffer.
>=20
> Read new_fb from the new plane state before swapping the framebuffer
> references. This updates the hardware address when the framebuffer
> changes while retaining the existing behavior for cursor movement.
>=20
> Verified on a Loongson 3A5000 with LS7A2000 using 32x32 and 64x64
> legacy
> cursor updates. Callback counters and read-only register observations
> confirmed the asynchronous path, the stale address before the change,
> and the new address afterward. Same-framebuffer movement and cursor
> disable/re-enable also passed, with the primary framebuffer and mode
> unchanged.
>=20
> AI assistance was used to investigate the existing report, prepare
> the
> fix and test tools, run the build and hardware comparison, and draft
> this message.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:
> https://lore.kernel.org/r/202311152357.4KFS0M8f-lkp@intel.com/
> Fixes: f39db26c5428 ("drm: Add kms driver for loongson display
> controller")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Evanshenf <archwse@gmail.com>
>=20

Applied to drm-misc-fixes, Thanks for your contribution!

Icenowy

> ---
> =C2=A0drivers/gpu/drm/loongson/lsdc_plane.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/loongson/lsdc_plane.c
> b/drivers/gpu/drm/loongson/lsdc_plane.c
> index bcc0ffa..7b9c65c 100644
> --- a/drivers/gpu/drm/loongson/lsdc_plane.c
> +++ b/drivers/gpu/drm/loongson/lsdc_plane.c
> @@ -230,7 +230,7 @@ static void
> lsdc_cursor_plane_atomic_async_update(struct drm_plane *plane,
> =C2=A0
> =C2=A0	new_state =3D drm_atomic_get_new_plane_state(state, plane);
> =C2=A0
> -	new_fb =3D plane->state->fb;
> +	new_fb =3D new_state->fb;
> =C2=A0
> =C2=A0	plane->state->crtc_x =3D new_state->crtc_x;
> =C2=A0	plane->state->crtc_y =3D new_state->crtc_y;
>=20
> base-commit: bca45af5998a05f34b13a2ef11e639bac9c62643

