Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BB7CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:37:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1F9910EAE2;
	Tue, 19 May 2026 07:37:26 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8372D10EAE1
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:37:25 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.150])
 by APP-01 (Coremail) with SMTP id qwCowABXAGwuEwxq+0++EA--.3719S2;
 Tue, 19 May 2026 15:37:19 +0800 (CST)
Message-ID: <5b7b28558aece1d99e93c1d69ce2c381929813a2.camel@iscas.ac.cn>
Subject: Re: [PATCH v2 2/4] drm/verisilicon: add model ID constants and DCU
 Lite chip identity
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Joey Lu <a0987203069@gmail.com>, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, 	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 19 May 2026 15:37:17 +0800
In-Reply-To: <20260519055114.1886525-3-a0987203069@gmail.com>
References: <20260519055114.1886525-1-a0987203069@gmail.com>
 <20260519055114.1886525-3-a0987203069@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: qwCowABXAGwuEwxq+0++EA--.3719S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF17JrW3Kr15ur4fZFWxCrg_yoW7XF4UpF
 47AFWvk3yrA39aq3s7AryjkFyay3Z7Ja1fWr1kZrWYvr4rtw1UWry7X34Y9FWDXr97Ja4I
 gFsakF47urW2yF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
 c7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
 1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
 14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
 IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
 87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
 IFyTuYvjxU7UDGUUUUU
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

=E5=9C=A8 2026-05-19=E4=BA=8C=E7=9A=84 13:51 +0800=EF=BC=8CJoey Lu=E5=86=99=
=E9=81=93=EF=BC=9A
> Introduce symbolic constants VSDC_MODEL_DC8200 and
> VSDC_MODEL_DCU_LITE
> to replace magic numbers in the hardware database and probe path.
>=20
> Register the DCU Lite chip identity (model 0x0, revision 0x5560,
> customer_id 0x305) in vs_chip_identities[], making the existing
> vs_fill_chip_identity() path able to recognise Nuvoton MA35D1
> hardware
> purely through register reads.

The HWDB change should be added in the end of the series, making it a
gate to the newly added changes that is finally opened when
everything's ready.

>=20
> Also add three register-level macros for forthcoming DCU Lite
> support:
> - VSDC_DISP_IRQ_VSYNC(n) in vs_crtc_regs.h, for per-output VSYNC IRQ
> =C2=A0 bits used by the DCU Lite IRQ enable/status registers.
> - VSDC_FB_CONFIG_ENABLE, VSDC_FB_CONFIG_VALID and
> VSDC_FB_CONFIG_RESET
> =C2=A0 in vs_primary_plane_regs.h, for the framebuffer enable and
> =C2=A0 commit-cycle bits used by the DCU Lite plane update path.

Maybe you can split the register change=20

>=20
> No behaviour change for existing DC8200 platforms.
>=20
> Signed-off-by: Joey Lu <a0987203069@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/verisilicon/vs_crtc_regs.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0drivers/gpu/drm/verisilicon/vs_hwdb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++++++++++--
> --
> =C2=A0drivers/gpu/drm/verisilicon/vs_hwdb.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +++
> =C2=A0.../gpu/drm/verisilicon/vs_primary_plane_regs.h=C2=A0 |=C2=A0 3 +++
> =C2=A04 files changed, 19 insertions(+), 4 deletions(-)
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
> diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.c
> b/drivers/gpu/drm/verisilicon/vs_hwdb.c
> index 09336af0900a..a25c4b16181d 100644
> --- a/drivers/gpu/drm/verisilicon/vs_hwdb.c
> +++ b/drivers/gpu/drm/verisilicon/vs_hwdb.c
> @@ -90,7 +90,7 @@ static const struct vs_formats
> vs_formats_with_yuv444 =3D {
> =C2=A0
> =C2=A0static struct vs_chip_identity vs_chip_identities[] =3D {
> =C2=A0	{
> -		.model =3D 0x8200,
> +		.model =3D VSDC_MODEL_DC8200,

I don't think such a macro is needed.

> =C2=A0		.revision =3D 0x5720,
> =C2=A0		.customer_id =3D ~0U,
> =C2=A0
> @@ -98,7 +98,7 @@ static struct vs_chip_identity vs_chip_identities[]
> =3D {
> =C2=A0		.formats =3D &vs_formats_no_yuv444,
> =C2=A0	},
> =C2=A0	{
> -		.model =3D 0x8200,
> +		.model =3D VSDC_MODEL_DC8200,
> =C2=A0		.revision =3D 0x5721,
> =C2=A0		.customer_id =3D 0x30B,
> =C2=A0
> @@ -106,7 +106,7 @@ static struct vs_chip_identity
> vs_chip_identities[] =3D {
> =C2=A0		.formats =3D &vs_formats_no_yuv444,
> =C2=A0	},
> =C2=A0	{
> -		.model =3D 0x8200,
> +		.model =3D VSDC_MODEL_DC8200,
> =C2=A0		.revision =3D 0x5720,
> =C2=A0		.customer_id =3D 0x310,
> =C2=A0
> @@ -114,13 +114,21 @@ static struct vs_chip_identity
> vs_chip_identities[] =3D {
> =C2=A0		.formats =3D &vs_formats_with_yuv444,
> =C2=A0	},
> =C2=A0	{
> -		.model =3D 0x8200,
> +		.model =3D VSDC_MODEL_DC8200,
> =C2=A0		.revision =3D 0x5720,
> =C2=A0		.customer_id =3D 0x311,
> =C2=A0
> =C2=A0		.display_count =3D 2,
> =C2=A0		.formats =3D &vs_formats_no_yuv444,
> =C2=A0	},
> +	{
> +		.model =3D VSDC_MODEL_DCU_LITE,

The number is 0x0 and the whole public name of this IP is
"DCUltraLite", w/o any numbers.

I suggest leave it at 0x0 and add a comment saying this is DCUltraLite
-- Verisilicon people are abusing suffix for their IP names now.

> +		.revision =3D 0x5560,
> +		.customer_id =3D 0x305,
> +
> +		.display_count =3D 1,
> +		.formats =3D &vs_formats_no_yuv444,
> +	},
> =C2=A0};
> =C2=A0
> =C2=A0int vs_fill_chip_identity(struct regmap *regs,
> diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.h
> b/drivers/gpu/drm/verisilicon/vs_hwdb.h
> index 92192e4fa086..cca126bd2da5 100644
> --- a/drivers/gpu/drm/verisilicon/vs_hwdb.h
> +++ b/drivers/gpu/drm/verisilicon/vs_hwdb.h
> @@ -9,6 +9,9 @@
> =C2=A0#include <linux/regmap.h>
> =C2=A0#include <linux/types.h>
> =C2=A0
> +#define VSDC_MODEL_DC8200 0x8200
> +#define VSDC_MODEL_DCU_LITE 0x0
> +
> =C2=A0struct vs_formats {
> =C2=A0	const u32 *array;
> =C2=A0	unsigned int num;
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

Should the new IRQ register to be added here too?

Thanks,
Icenowy

> =C2=A0#define VSDC_FB_CONFIG_CLEAR_EN			BIT(8)
> =C2=A0#define VSDC_FB_CONFIG_ROT_MASK			GENMASK(13,
> 11)
> =C2=A0#define VSDC_FB_CONFIG_ROT(v)			((v) << 11)

