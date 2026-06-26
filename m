Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32209CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 08:03:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E5D810F4C4;
	Fri, 26 Jun 2026 08:03:14 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A417110F4C4
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 08:03:12 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.101.182])
 by APP-03 (Coremail) with SMTP id rQCowACHf7Y6Mj5qcqLoFQ--.17620S2;
 Fri, 26 Jun 2026 16:03:07 +0800 (CST)
Message-ID: <cf9af38dfe52548649b9010f298341d4064aaa21.camel@iscas.ac.cn>
Subject: Re: [PATCH v5 4/7] drm/verisilicon: make axi and ahb clocks optional
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Joey Lu <a0987203069@gmail.com>, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, 	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 26 Jun 2026 16:03:06 +0800
In-Reply-To: <20260625094449.708386-5-a0987203069@gmail.com>
References: <20260625094449.708386-1-a0987203069@gmail.com>
 <20260625094449.708386-5-a0987203069@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: rQCowACHf7Y6Mj5qcqLoFQ--.17620S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar18JrW5WFyUWry3WFW3KFg_yoW8Gw48pF
 WkXayjva4fA34xuasxt34j9FyFy3WUtayrGw1kJayv9wnxArW5WFyxA348Xa4jvr9rGFWr
 Zrs5uF4UAFWayrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
 c7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
 1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
 14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
 IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
 87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
 IFyTuYvjxU2f-BDUUUU
X-Originating-IP: [112.94.101.182]
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

=E5=9C=A8 2026-06-25=E5=9B=9B=E7=9A=84 17:44 +0800=EF=BC=8CJoey Lu=E5=86=99=
=E9=81=93=EF=BC=9A
> The Nuvoton MA35D1 SoC integrates a DCUltraLite display controller
> whose
> AXI and AHB bus clocks share a single gate enable bit with the
> display
> core clock, so the clock driver does not expose them separately. This
> patch makes the axi and ahb clocks optional in the probe.
>=20
> Signed-off-by: Joey Lu <a0987203069@gmail.com>

```
Reviewed-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
```

Thanks,
Icenowy

> ---
> =C2=A0drivers/gpu/drm/verisilicon/vs_dc.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/verisilicon/vs_dc.c
> b/drivers/gpu/drm/verisilicon/vs_dc.c
> index 9729b693d360..fd1f5fe67a68 100644
> --- a/drivers/gpu/drm/verisilicon/vs_dc.c
> +++ b/drivers/gpu/drm/verisilicon/vs_dc.c
> @@ -90,13 +90,13 @@ static int vs_dc_probe(struct platform_device
> *pdev)
> =C2=A0		return PTR_ERR(dc->core_clk);
> =C2=A0	}
> =C2=A0
> -	dc->axi_clk =3D devm_clk_get_enabled(dev, "axi");
> +	dc->axi_clk =3D devm_clk_get_optional_enabled(dev, "axi");
> =C2=A0	if (IS_ERR(dc->axi_clk)) {
> =C2=A0		dev_err(dev, "can't get axi clock\n");
> =C2=A0		return PTR_ERR(dc->axi_clk);
> =C2=A0	}
> =C2=A0
> -	dc->ahb_clk =3D devm_clk_get_enabled(dev, "ahb");
> +	dc->ahb_clk =3D devm_clk_get_optional_enabled(dev, "ahb");
> =C2=A0	if (IS_ERR(dc->ahb_clk)) {
> =C2=A0		dev_err(dev, "can't get ahb clock\n");
> =C2=A0		return PTR_ERR(dc->ahb_clk);

