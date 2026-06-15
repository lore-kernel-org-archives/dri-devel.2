Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D977CCD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 08:24:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4984210E2AA;
	Mon, 15 Jun 2026 08:24:16 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D8FA10E2A9
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 08:24:13 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.167])
 by APP-03 (Coremail) with SMTP id rQCowABHK+Knti9qMTnKFA--.4089S2;
 Mon, 15 Jun 2026 16:24:08 +0800 (CST)
Message-ID: <155be53c188ba9743ee5b9da4b9181ebc2db9310.camel@iscas.ac.cn>
Subject: Re: [PATCH v4 2/6] drm/verisilicon: add register-level macros for
 DC8000
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Joey Lu <a0987203069@gmail.com>, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, 	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Mon, 15 Jun 2026 16:24:07 +0800
In-Reply-To: <20260615065003.76661-3-a0987203069@gmail.com>
References: <20260615065003.76661-1-a0987203069@gmail.com>
 <20260615065003.76661-3-a0987203069@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: rQCowABHK+Knti9qMTnKFA--.4089S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWxGF4xJw4kGw4UGFy7Awb_yoW8Kryfpr
 47AayktryFy39a9397ta40kFZxG3W7Jw4ruFy8ZrZ8XF40ywn8urWjqFWfGFyqqry7A3yx
 Krnakw43u3ya93JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
 c7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
 1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
 14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
 IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
 87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
 IFyTuYvjxUzOJ5UUUUU
X-Originating-IP: [112.94.100.167]
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

=E5=9C=A8 2026-06-15=E4=B8=80=E7=9A=84 14:49 +0800=EF=BC=8CJoey Lu=E5=86=99=
=E9=81=93=EF=BC=9A
> Add register-level constants needed by the forthcoming DC8000
> (DCUltraLite)
> hardware ops:
>=20
> =C2=A0 VSDC_DISP_IRQ_VSYNC(n) in vs_crtc_regs.h: bit mask for per-output
> =C2=A0 VSYNC interrupt bits in DISP_IRQ_STA (0x147C) / DISP_IRQ_EN
> (0x1480),
> =C2=A0 which are the IRQ registers used by DCUltraLite in place of the
> DC8200
> =C2=A0 TOP_IRQ_ACK / TOP_IRQ_EN registers.
>=20
> =C2=A0 VSDC_FB_CONFIG_ENABLE (bit 0), VSDC_FB_CONFIG_VALID (bit 3) and
> =C2=A0 VSDC_FB_CONFIG_RESET (bit 4) in vs_primary_plane_regs.h: control
> bits
> =C2=A0 in the FB_CONFIG register used by DCUltraLite for framebuffer
> enable
> =C2=A0 and per-frame commit handshake.

Validated against DC8000 register list.

Reviewed-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>

>=20
> No behaviour change for existing DC8200 platforms.
>=20
> Signed-off-by: Joey Lu <a0987203069@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/verisilicon/vs_crtc_regs.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A0drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h | 3 +++
> =C2=A02 files changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/verisilicon/vs_crtc_regs.h
> b/drivers/gpu/drm/verisilicon/vs_crtc_regs.h
> index c7930e817635..d4da22b08cd5 100644
> --- a/drivers/gpu/drm/verisilicon/vs_crtc_regs.h
> +++ b/drivers/gpu/drm/verisilicon/vs_crtc_regs.h
> @@ -54,6 +54,7 @@
> =C2=A0#define VSDC_DISP_GAMMA_DATA(n)			(0x1460 +
> 0x4 * (n))
> =C2=A0
> =C2=A0#define VSDC_DISP_IRQ_STA			0x147C
> +#define VSDC_DISP_IRQ_VSYNC(n)			BIT(n)
> =C2=A0
> =C2=A0#define VSDC_DISP_IRQ_EN			0x1480
> =C2=A0
> diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
> b/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
> index cbb125c46b39..67d4b00f294e 100644
> --- a/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
> +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
> @@ -16,6 +16,9 @@
> =C2=A0#define VSDC_FB_STRIDE(n)			(0x1408 + 0x4 * (n))
> =C2=A0
> =C2=A0#define VSDC_FB_CONFIG(n)			(0x1518 + 0x4 * (n))
> +#define VSDC_FB_CONFIG_ENABLE			BIT(0)
> +#define VSDC_FB_CONFIG_VALID			BIT(3)
> +#define VSDC_FB_CONFIG_RESET			BIT(4)
> =C2=A0#define VSDC_FB_CONFIG_CLEAR_EN			BIT(8)
> =C2=A0#define VSDC_FB_CONFIG_ROT_MASK			GENMASK(13,
> 11)
> =C2=A0#define VSDC_FB_CONFIG_ROT(v)			((v) << 11)

