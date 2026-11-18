Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51391606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:38:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FE4110FE00;
	Wed, 18 Nov 2026 15:38:16 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 042F510FDFC
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:38:14 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.23])
 by APP-05 (Coremail) with SMTP id zQCowAAXtLlhxv1qaYZpAQ--.17108S2;
 Wed, 18 Nov 2026 23:38:09 +0800 (CST)
Message-ID: <2103adaf3f073cd21c42a4b00cb724a8dc836aae.camel@iscas.ac.cn>
Subject: Re: [PATCH v2] drm/panel: ilitek-ili9881c: add Mingjun MJ070BI30IA2
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
 <jesszhan0024@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard	
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Wed, 18 Nov 2026 23:38:09 +0800
In-Reply-To: <20261102140524.1544755-1-zhengxingda@iscas.ac.cn>
References: <20261102140524.1544755-1-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: zQCowAAXtLlhxv1qaYZpAQ--.17108S2
X-Coremail-Antispam: 1UD129KBjvAXoW3tw13Xw1fCr4fJw18Xw1UJrb_yoW8Jr18Zo
 WYqF4vyan8WrW0vwn8C34Syrn7CanxCw18Kan8tFWvqas3ua18Ww1fWrs7JrZFqF93GFWI
 vF4xJ345X3yIqrs3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUY07k0a2IF6w4kM7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0
 x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj4
 1l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0
 I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAI
 w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
 4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxG
 rwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr
 1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
 x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07b0SoAUUUUU=
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

=E5=9C=A8 2026-11-02=E4=B8=80=E7=9A=84 22:05 +0800=EF=BC=8CIcenowy Zheng=E5=
=86=99=E9=81=93=EF=BC=9A
> Mingjun MJ070BI30IA2 is a 7" MIPI DSI LCD panel used by Lichee
> Console
> 4A, with a initialization sequence matching the pattern of Ilitek
> ILI9881C driver chip.
>=20
> Add it to the driver for ILI9881C-based panels.
>=20
> As the sequence provided by Sipeed is captured with a logic analyzer,
> some values are obviously wrong and I patched them with other panels'
> sequence as reference. This fixes a weird problem that the liquid
> crystal gets DC polarized when the panel enters sleep mode, and I am
> grateful to Sashiko for pointing this out.
>=20
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>

Is it okay for me to just apply it to drm-misc-next?

Thanks,
Icenowy

> ---
> Changes in v2:
> - Made all hex values in the initialization sequence lower case to
> match
> =C2=A0 other panels.
> - Fixed some obvious errors in the initialization sequence as pointed
> by
> =C2=A0 Sashiko. This also removes the need for doing soft reset in
> =C2=A0 unprepare callback.
> - Added Neil's R-b.
> - Rebased on top of drm-misc-next.
> =C2=A0drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 222
> ++++++++++++++++++
> =C2=A01 file changed, 222 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> index acc560dc5ea5d..0854c4cf7ebd7 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> @@ -2387,6 +2387,201 @@ static const struct ili9881c_instr
> dt300249_init[] =3D {
> =C2=A0	ILI9881C_COMMAND_INSTR(0xd3, 0x3f),
> =C2=A0};
> =C2=A0
> +static const struct ili9881c_instr mj070bi30ia2_init[] =3D {
> +	ILI9881C_SWITCH_PAGE_INSTR(3),
> +	ILI9881C_COMMAND_INSTR(0x01, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x02, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x03, 0x73),
> +	ILI9881C_COMMAND_INSTR(0x04, 0x13),
> +	ILI9881C_COMMAND_INSTR(0x05, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x06, 0x0a),
> +	ILI9881C_COMMAND_INSTR(0x07, 0x05),
> +	ILI9881C_COMMAND_INSTR(0x08, 0x00), /* raw capture 0x11,
> 0x00 */
> +	ILI9881C_COMMAND_INSTR(0x09, 0x28),
> +	ILI9881C_COMMAND_INSTR(0x0a, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x0b, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x0c, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x0d, 0x28),
> +	ILI9881C_COMMAND_INSTR(0x0e, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x0f, 0x28),
> +	ILI9881C_COMMAND_INSTR(0x10, 0x28),
> +	ILI9881C_COMMAND_INSTR(0x11, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x12, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x13, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x14, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x15, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x16, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x17, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x18, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x19, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x1a, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x1b, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x1c, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x1d, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x1e, 0x40),
> +	ILI9881C_COMMAND_INSTR(0x1f, 0x80),
> +	ILI9881C_COMMAND_INSTR(0x20, 0x06),
> +	ILI9881C_COMMAND_INSTR(0x21, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x22, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x23, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x24, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x25, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x26, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x27, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x28, 0x33),
> +	ILI9881C_COMMAND_INSTR(0x29, 0x33),
> +	ILI9881C_COMMAND_INSTR(0x2a, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x2b, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x2c, 0x04),
> +	ILI9881C_COMMAND_INSTR(0x2d, 0x0c),
> +	ILI9881C_COMMAND_INSTR(0x2e, 0x05),
> +	ILI9881C_COMMAND_INSTR(0x2f, 0x05),
> +	ILI9881C_COMMAND_INSTR(0x30, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x31, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x32, 0x31),
> +	ILI9881C_COMMAND_INSTR(0x33, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x34, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x35, 0x0a),
> +	ILI9881C_COMMAND_INSTR(0x36, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x37, 0x08),
> +	ILI9881C_COMMAND_INSTR(0x38, 0x00), /* raw capture 0x70,
> 0x00 */
> +	ILI9881C_COMMAND_INSTR(0x39, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x3a, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x3b, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x3c, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x3d, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x3e, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x3f, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x40, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x41, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x42, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x43, 0x08),
> +	ILI9881C_COMMAND_INSTR(0x44, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x50, 0x01), /* raw capture 0xa0,
> 0x00 */
> +	ILI9881C_COMMAND_INSTR(0x51, 0x23), /* raw capture 0x51,
> 0x22 */
> +	ILI9881C_COMMAND_INSTR(0x52, 0x45),
> +	ILI9881C_COMMAND_INSTR(0x53, 0x67),
> +	ILI9881C_COMMAND_INSTR(0x54, 0x89),
> +	ILI9881C_COMMAND_INSTR(0x55, 0xab),
> +	ILI9881C_COMMAND_INSTR(0x56, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x57, 0x23),
> +	ILI9881C_COMMAND_INSTR(0x58, 0x45),
> +	ILI9881C_COMMAND_INSTR(0x59, 0x67),
> +	ILI9881C_COMMAND_INSTR(0x5a, 0x89),
> +	ILI9881C_COMMAND_INSTR(0x5b, 0xab),
> +	ILI9881C_COMMAND_INSTR(0x5c, 0xcd),
> +	ILI9881C_COMMAND_INSTR(0x5d, 0xef),
> +	ILI9881C_COMMAND_INSTR(0x5e, 0x11),
> +	ILI9881C_COMMAND_INSTR(0x5f, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x60, 0x08),
> +	ILI9881C_COMMAND_INSTR(0x61, 0x0e),
> +	ILI9881C_COMMAND_INSTR(0x62, 0x0f),
> +	ILI9881C_COMMAND_INSTR(0x63, 0x0c),
> +	ILI9881C_COMMAND_INSTR(0x64, 0x0d),
> +	ILI9881C_COMMAND_INSTR(0x65, 0x17),
> +	ILI9881C_COMMAND_INSTR(0x66, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x67, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x68, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x69, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x6a, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x6b, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x6c, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x6d, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x6e, 0x16),
> +	ILI9881C_COMMAND_INSTR(0x6f, 0x16),
> +	ILI9881C_COMMAND_INSTR(0x70, 0x06),
> +	ILI9881C_COMMAND_INSTR(0x71, 0x06),
> +	ILI9881C_COMMAND_INSTR(0x72, 0x07),
> +	ILI9881C_COMMAND_INSTR(0x73, 0x07),
> +	ILI9881C_COMMAND_INSTR(0x74, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x75, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x76, 0x08),
> +	ILI9881C_COMMAND_INSTR(0x77, 0x0e),
> +	ILI9881C_COMMAND_INSTR(0x78, 0x0f),
> +	ILI9881C_COMMAND_INSTR(0x79, 0x0c),
> +	ILI9881C_COMMAND_INSTR(0x7a, 0x0d),
> +	ILI9881C_COMMAND_INSTR(0x7b, 0x17),
> +	ILI9881C_COMMAND_INSTR(0x7c, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x7d, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x7e, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x7f, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x80, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x81, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x82, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x83, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x84, 0x16),
> +	ILI9881C_COMMAND_INSTR(0x85, 0x16),
> +	ILI9881C_COMMAND_INSTR(0x86, 0x06),
> +	ILI9881C_COMMAND_INSTR(0x87, 0x06),
> +	ILI9881C_COMMAND_INSTR(0x88, 0x07),
> +	ILI9881C_COMMAND_INSTR(0x89, 0x07),
> +	ILI9881C_COMMAND_INSTR(0x8a, 0x02),
> +
> +	ILI9881C_SWITCH_PAGE_INSTR(4),
> +	ILI9881C_COMMAND_INSTR(0x6e, 0x1a),
> +	ILI9881C_COMMAND_INSTR(0x6f, 0x37),
> +	ILI9881C_COMMAND_INSTR(0x3a, 0xa4),
> +	ILI9881C_COMMAND_INSTR(0x8d, 0x1f),
> +	ILI9881C_COMMAND_INSTR(0x87, 0xba),
> +	ILI9881C_COMMAND_INSTR(0xb2, 0xd1),
> +	ILI9881C_COMMAND_INSTR(0x88, 0x0b),
> +	ILI9881C_COMMAND_INSTR(0x38, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x39, 0x00),
> +	ILI9881C_COMMAND_INSTR(0xb5, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x31, 0x25),
> +	ILI9881C_COMMAND_INSTR(0x3b, 0x98),
> +
> +	ILI9881C_SWITCH_PAGE_INSTR(1),
> +	ILI9881C_COMMAND_INSTR(0x22, 0x0a),
> +	ILI9881C_COMMAND_INSTR(0x31, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x53, 0x4c), /* raw capture 0xa6,
> 0xa6 */
> +	ILI9881C_COMMAND_INSTR(0x55, 0x3d),
> +	ILI9881C_COMMAND_INSTR(0x50, 0x9e),
> +	ILI9881C_COMMAND_INSTR(0x51, 0x99),
> +	ILI9881C_COMMAND_INSTR(0x60, 0x06),
> +	ILI9881C_COMMAND_INSTR(0x62, 0x20),
> +	ILI9881C_COMMAND_INSTR(0xa0, 0x00),
> +	ILI9881C_COMMAND_INSTR(0xa1, 0x17),
> +	ILI9881C_COMMAND_INSTR(0xa2, 0x26),
> +	ILI9881C_COMMAND_INSTR(0xa3, 0x13),
> +	ILI9881C_COMMAND_INSTR(0xa4, 0x16),
> +	ILI9881C_COMMAND_INSTR(0xa5, 0x29),
> +	ILI9881C_COMMAND_INSTR(0xa6, 0x1e),
> +	ILI9881C_COMMAND_INSTR(0xa7, 0x1f),
> +	ILI9881C_COMMAND_INSTR(0xa8, 0x8b),
> +	ILI9881C_COMMAND_INSTR(0xa9, 0x1d),
> +	ILI9881C_COMMAND_INSTR(0xaa, 0x2a),
> +	ILI9881C_COMMAND_INSTR(0xab, 0x7b),
> +	ILI9881C_COMMAND_INSTR(0xac, 0x1a),
> +	ILI9881C_COMMAND_INSTR(0xad, 0x19),
> +	ILI9881C_COMMAND_INSTR(0xae, 0x4e),
> +	ILI9881C_COMMAND_INSTR(0xaf, 0x24),
> +	ILI9881C_COMMAND_INSTR(0xb0, 0x29),
> +	ILI9881C_COMMAND_INSTR(0xb1, 0x4f),
> +	ILI9881C_COMMAND_INSTR(0xb2, 0x5c),
> +	ILI9881C_COMMAND_INSTR(0xb3, 0x3e),
> +	ILI9881C_COMMAND_INSTR(0xc0, 0x00),
> +	ILI9881C_COMMAND_INSTR(0xc1, 0x17),
> +	ILI9881C_COMMAND_INSTR(0xc2, 0x26),
> +	ILI9881C_COMMAND_INSTR(0xc3, 0x13),
> +	ILI9881C_COMMAND_INSTR(0xc4, 0x16),
> +	ILI9881C_COMMAND_INSTR(0xc5, 0x29),
> +	ILI9881C_COMMAND_INSTR(0xc6, 0x1e),
> +	ILI9881C_COMMAND_INSTR(0xc7, 0x1f),
> +	ILI9881C_COMMAND_INSTR(0xc8, 0x8b),
> +	ILI9881C_COMMAND_INSTR(0xc9, 0x1d),
> +	ILI9881C_COMMAND_INSTR(0xca, 0x2a),
> +	ILI9881C_COMMAND_INSTR(0xcb, 0x7b),
> +	ILI9881C_COMMAND_INSTR(0xcc, 0x1a),
> +	ILI9881C_COMMAND_INSTR(0xcd, 0x19),
> +	ILI9881C_COMMAND_INSTR(0xce, 0x4e),
> +	ILI9881C_COMMAND_INSTR(0xcf, 0x24),
> +	ILI9881C_COMMAND_INSTR(0xd0, 0x29),
> +	ILI9881C_COMMAND_INSTR(0xd1, 0x4d),
> +	ILI9881C_COMMAND_INSTR(0xd2, 0x5c),
> +	ILI9881C_COMMAND_INSTR(0xd3, 0x3e),
> +};
> +
> =C2=A0static inline struct ili9881c *panel_to_ili9881c(struct drm_panel
> *panel)
> =C2=A0{
> =C2=A0	return container_of(panel, struct ili9881c, panel);
> @@ -2699,6 +2894,23 @@ static const struct drm_display_mode
> dt300249_default_mode =3D {
> =C2=A0	.height_mm	=3D 121,
> =C2=A0};
> =C2=A0
> +static const struct drm_display_mode mj070bi30ia2_mode =3D {
> +	.clock		=3D 75750,
> +
> +	.hdisplay	=3D 800,
> +	.hsync_start	=3D 800 + 48,
> +	.hsync_end	=3D 800 + 48 + 32,
> +	.htotal		=3D 800 + 48 + 32 + 80,
> +
> +	.vdisplay	=3D 1280,
> +	.vsync_start	=3D 1280 + 3,
> +	.vsync_end	=3D 1280 + 3 + 10,
> +	.vtotal		=3D 1280 + 3 + 10 + 24,
> +
> +	.width_mm	=3D 94,
> +	.height_mm	=3D 150,
> +};
> +
> =C2=A0static int ili9881c_get_modes(struct drm_panel *panel,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_connector *connector)
> =C2=A0{
> @@ -2913,6 +3125,15 @@ static const struct ili9881c_desc
> dt300249_desc =3D {
> =C2=A0	.lanes =3D 4,
> =C2=A0};
> =C2=A0
> +static const struct ili9881c_desc mj070bi30ia2_desc =3D {
> +	.init =3D mj070bi30ia2_init,
> +	.init_length =3D ARRAY_SIZE(mj070bi30ia2_init),
> +	.mode =3D &mj070bi30ia2_mode,
> +	.mode_flags =3D MIPI_DSI_MODE_VIDEO |
> MIPI_DSI_MODE_VIDEO_BURST |
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MIPI_DSI_MODE_LPM,
> +	.lanes =3D 4,
> +};
> +
> =C2=A0static const struct of_device_id ili9881c_of_match[] =3D {
> =C2=A0	{ .compatible =3D "bananapi,lhr050h41", .data =3D
> &lhr050h41_desc },
> =C2=A0	{ .compatible =3D "bestar,bsd1218-a101kl68", .data =3D
> &bsd1218_a101kl68_desc },
> @@ -2924,6 +3145,7 @@ static const struct of_device_id
> ili9881c_of_match[] =3D {
> =C2=A0	{ .compatible =3D "wanchanglong,w552946aba", .data =3D
> &w552946aba_desc },
> =C2=A0	{ .compatible =3D "waveshare,7.0-dsi-touch-a", .data =3D
> &waveshare_7inch_a_desc },
> =C2=A0	{ .compatible =3D "ampire,am8001280g", .data =3D
> &am8001280g_desc },
> +	{ .compatible =3D "mingjun,mj070bi30ia2", .data =3D
> &mj070bi30ia2_desc },
> =C2=A0	{ .compatible =3D "raspberrypi,dsi-5inch", &rpi_5inch_desc },
> =C2=A0	{ .compatible =3D "raspberrypi,dsi-7inch", &rpi_7inch_desc },
> =C2=A0	{ }

