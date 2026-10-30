Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8D4606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 05:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TOkEeLMO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39BFC112641;
	Fri, 30 Oct 2026 05:54:51 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BF2610E81A
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 05:54:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B7E9F43B5C;
 Fri, 30 Oct 2026 05:54:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621BD1F00A16;
 Fri, 30 Oct 2026 05:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793339684;
 bh=zc1mZxmk6KfQkLOLB1GDFYx1v5GLlDgwKgHVaRpjBpY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TOkEeLMOLKW7Kl02RhL8cXkhTV1AV7LC8BcQSioTGHJNCmue42otBWYA9JA05EICl
 Y4pYvkCRmLKTgxR1YKSHpe3V4cpxdyfIuMHYOmq6gY74QMWj9rU0rwq1eaOUXdbAde
 Rnze/i8+dUZSfRF3Pz6EhR02p/QTZtsDxARyLxq4Qv1m22sX4Ab3mEy2yDqZ7wXgPD
 CYIH4SqEvmEFsnyHEyiSFlI+fkjorppVJF7o2yYy1QOpwee83xeC2deixjLjtuclqC
 SQ15IAEdxYBX7RjOOkv1+4+aYepUM3EPiO6aUI57XEYFCCRuH34qgzlhdNf/k2Rt/d
 6GJQK/ItxH62Q==
Message-ID: <sashiko-outbox-190580@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] drm/panel: ilitek-ili9881c: add Mingjun MJ070BI30IA2
To: "Icenowy Zheng" <zhengxingda@iscas.ac.cn>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261030-mj070bi30ia2-v1-3-a0f65b65c290@iscas.ac.cn>
References: <20261030-mj070bi30ia2-v1-0-a0f65b65c290@iscas.ac.cn>
 <20261030-mj070bi30ia2-v1-3-a0f65b65c290@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 05:54:44 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/panel: ilitek-ili9881c: bit-shifted registers in mj070bi30ia2_=
init
--

commit 77fed3fe20435bd131c211abca1d6f6a36c89b5f
Author: Icenowy Zheng <zhengxingda@iscas.ac.cn>

drm/panel: ilitek-ili9881c: add Mingjun MJ070BI30IA2

This patch adds support for the Mingjun MJ070BI30IA2 7" MIPI DSI LCD panel,
including its initialization sequence, display mode timings, and device tree
compatible entry in the Ilitek ILI9881C panel driver.

> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/=
drm/panel/panel-ilitek-ili9881c.c
> index c3d5ab67121d9..83148c40e25ca 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> @@ -2198,6 +2198,201 @@ static const struct ili9881c_instr waveshare_7inc=
h_a_init[] =3D {
>  	ILI9881C_COMMAND_INSTR(0x36, 0x00),
>  };
> =20
> +static const struct ili9881c_instr mj070bi30ia2_init[] =3D {
> +	ILI9881C_SWITCH_PAGE_INSTR(3),
> +	ILI9881C_COMMAND_INSTR(0x01, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x02, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x03, 0x73),
> +	ILI9881C_COMMAND_INSTR(0x04, 0x13),
> +	ILI9881C_COMMAND_INSTR(0x05, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x06, 0x0A),
> +	ILI9881C_COMMAND_INSTR(0x07, 0x05),
> +	ILI9881C_COMMAND_INSTR(0x11, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x09, 0x28),
> +	ILI9881C_COMMAND_INSTR(0x0A, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x0B, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x0C, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x0D, 0x28),
> +	ILI9881C_COMMAND_INSTR(0x0E, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x0F, 0x28),
> +	ILI9881C_COMMAND_INSTR(0x10, 0x28),
> +	ILI9881C_COMMAND_INSTR(0x11, 0x00),

[ ... ]

> +	ILI9881C_COMMAND_INSTR(0x36, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x37, 0x08),
> +	ILI9881C_COMMAND_INSTR(0x70, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x39, 0x00),

[ ... ]

> +	ILI9881C_COMMAND_INSTR(0x43, 0x08),
> +	ILI9881C_COMMAND_INSTR(0x44, 0x00),
> +	ILI9881C_COMMAND_INSTR(0xA0, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x51, 0x23),
> +	ILI9881C_COMMAND_INSTR(0x52, 0x44),
> +	ILI9881C_COMMAND_INSTR(0x53, 0x67),

[ ... ]

> +	ILI9881C_COMMAND_INSTR(0x6E, 0x16),
> +	ILI9881C_COMMAND_INSTR(0x6F, 0x16),
> +	ILI9881C_COMMAND_INSTR(0x70, 0x06),
> +	ILI9881C_COMMAND_INSTR(0x71, 0x06),

[ ... ]

> +	ILI9881C_SWITCH_PAGE_INSTR(1),
> +	ILI9881C_COMMAND_INSTR(0x22, 0x0A),
> +	ILI9881C_COMMAND_INSTR(0x31, 0x00),
> +	ILI9881C_COMMAND_INSTR(0xA6, 0xA6),
> +	ILI9881C_COMMAND_INSTR(0x55, 0x3D),
> +	ILI9881C_COMMAND_INSTR(0x50, 0x9E),
> +	ILI9881C_COMMAND_INSTR(0x51, 0x99),
> +	ILI9881C_COMMAND_INSTR(0x60, 0x06),
> +	ILI9881C_COMMAND_INSTR(0x62, 0x20),
> +	ILI9881C_COMMAND_INSTR(0xA0, 0x00),
> +	ILI9881C_COMMAND_INSTR(0xA1, 0x17),
> +	ILI9881C_COMMAND_INSTR(0xA2, 0x26),
> +	ILI9881C_COMMAND_INSTR(0xA3, 0x13),
> +	ILI9881C_COMMAND_INSTR(0xA4, 0x16),
> +	ILI9881C_COMMAND_INSTR(0xA5, 0x29),
> +	ILI9881C_COMMAND_INSTR(0xA6, 0x1E),

[Severity: High]
Are some of the register addresses and values in mj070bi30ia2_init[] shifted
left by one bit (perhaps from a MIPI DSI bus capture or transcription error=
)?

When ili9881c_prepare() sends mj070bi30ia2_init[] to the panel controller,
four entries appear to have bit-shifted command addresses that leave their
intended registers unprogrammed while writing to registers that are later
overwritten:

1. In Page 3, between registers 0x07 and 0x09 (where all other ILI9881C
panels program register 0x08), the sequence writes to 0x11 ((0x08 << 1) | 1=
),
which is already programmed in its normal sequential position after 0x10.

2. In Page 3, between registers 0x37 and 0x39 (where register 0x38 belongs),
the sequence writes (0x70, 0x00) (0x38 << 1 =3D=3D 0x70). Register 0x70 is =
later
overwritten in the 0x5F..0x8A GIP output mapping block with (0x70, 0x06),
leaving register 0x38 uninitialized.

3. In Page 3, between registers 0x44 and 0x51, at the start of the standard
0x50..0x5D GIP sequence (0x01, 0x23, 0x45, 0x67, 0x89, 0xAB, ...), the table
has (0xA0, 0x02) instead of (0x50, 0x01) (0x50 << 1 =3D=3D 0xA0, 0x01 << 1 =
=3D=3D
0x02), and register 0x52 is set to 0x44 instead of 0x45.

4. In Page 1, between register 0x31 and VCOM2 register 0x55 (where other
ILI9881C panels program VCOM1 register 0x53), the sequence writes
(0xA6, 0xA6) (0x53 << 1 =3D=3D 0xA6). In Page 1, 0xA6 is a positive gamma
register that is unconditionally overwritten a few lines later by
(0xA6, 0x1E), leaving VCOM1 register 0x53 uninitialized.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-mj070bi30i=
a2-v1-0-a0f65b65c290@iscas.ac.cn?part=3D3
