Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C633606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KkS4f+Cw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 455391120FF;
	Thu, 12 Nov 2026 12:56:26 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CABE710E572
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:47:18 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6b2237b596cso8868987a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 00:47:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794473237; cv=none;
 d=google.com; s=arc-20260327;
 b=Wl7NF76p/FK577WH1zyxa81BoyXKSGaCGJSRsD0V4zoG/j3ezYpM3j3Kpbe8irVRvn
 dj1Qz7mqnX/dAfr+cZF+YJc0aGVLgK1Y2Ztl0HqmTP1eWiIPFBMmIoiunr8Dv1pJe30c
 3S+lspT1wwv3RyoyXtlFTNmWB8qyPrRHf0hNW3vLSLDv+so0yooTReoHSu+HBqjvRX3T
 V9o47JTbLfgBve4hBylEV9+/TeZwhM0mgcwl3DZG6jWkRLRA+/en4U4HZx2OXpTqGZSu
 QSuGJg8GFR41GatKztU+GxC75T8CNOHHhhPyWH8UIePcVXi28sVy/bwzqY+/b9cGMTIv
 vqUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RB86biYg+BPhq88d5PdaceEbdw/e2Gm1TW0EI7mBLjg=;
 fh=iZ+ZFiKN5MQfTIiJFkEv6peb70sD3/T1UUDa2jPk6dY=;
 b=pgErdRH/vUJ2N0d3aj+cHRxP/PuP47Xhb5To/s931RLN8UafcdfD7empXwqxW4/OV3
 XAuR3LflSe+3EEqGNeQ46CPOBGaj7DTaZoiH5pfciIRpPK6gF2ZcY1GdxodZIwSvLylN
 qYM8mV8ecxbul/i2jnuD7qqbXbh6UzH/LOpTdGuBcyNR22ZBIvQq4aRkryfFnKaRzaHL
 4H4Te/MzKnfQBx0/6l2jLVl7M06WICuGEqumBoSp+J7f6mU2va42r2dC03qqLnn2eFVh
 Gc89booI2yY5NEEiaCJpGvY7+upsfI8OieHnfo7GOgS9986QD2GPVNirg7LPjkNFyz2M
 mjqQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794473237; x=1795078037; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RB86biYg+BPhq88d5PdaceEbdw/e2Gm1TW0EI7mBLjg=;
 b=KkS4f+Cw4mThSOohw3A2lnDiMgNYMkwG3y3CrkSqLgE/yjXhcclU+s/9HmKj372nzH
 plViKwF+yw3Yyhg2qNAdntHa4RSNTcivh4Hh9oDaE78XD524CnyNTGVVXwWx+jMiWKKp
 na53gUxe1LyYhRGESzEa4j3jh622W9kroDEXhU5quMQRKFDCVbP1CGDffvAMtVTVD9ou
 oWCsXI20scaL/rciADwKk1iKH90krXkrLkq9uHznK2hh06NmAU0hAU6wVLYkWT1Vh7l8
 P1MceWKAQhZeZJnIi2ICWNccXRLR+tREr1nQaY37ml+OPaf7UhvQGl0a4njE6Tt+Wm42
 0dhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794473237; x=1795078037;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RB86biYg+BPhq88d5PdaceEbdw/e2Gm1TW0EI7mBLjg=;
 b=qCrYawvemD6C3O57vUG9OLh/W0utxYWwcN9gkCdWaUMnU5bi8ZlxpWwylmpx6A8zAH
 Em7fSzdSX6xcQT7ywsOwzHlWwhs/mtuV7+wPouJ9rwnQkoXPyXH9MhkdD8tzk9lzxMPY
 CDHWSLXqZqsmJDAlz4zsoyMpgCqtonDrLjVPYyOk+XwZXBNdgNVxMJaG4YFO0FhvzZAz
 BDxcwCYWlPV6NLcfyxvV/Ahxj3jqeNrHT51Z+QDTn8Ca0NuYAdAov9wOvYi80HNqVjsB
 rplYYsbElA+52IAFn3hPqGzDqlz4d321JYIYlbttn2UFYz5xsY+3PLUlNmxIZnE9Qqee
 QA/Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGji2oVKQAj4sC6/owsWEu6pasZsv77do0hC4wLUhYCc/MUhUCcZpyMDLjQnvt17oKPcrRRJIFWr28=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/gYZCpF2wHNMb3qKPwmE7RuC/GzTa0VZyWAlL2+wpUlcByFuBd
 A9EjAlVy+I0vQyYApDaCvO++RmK43K346l1u1Z9zS66ILhkDEl5dfv6Xs/+0XdNvNnyDbK1w8cO
 DlkXtnwFEsLgZSsMWbRJ3ohAAdXm4gGrxiq/7
X-Gm-Gg: AYBFou31dIfv8WU84GP07/s3fLUqxyLlkMP8y1Z/P/4mF7j+Hc6Sj6vpgDBhFOd4mUg
 iekHwjwUQHcvVU4h6s7z6UMw3TDGh/yYmc+l/8lHzkb7rq55/b2ZFJ21rYpfoLLqXOr/Lj8ru5C
 wikkcRUkxajKhYGQY413tFnHWPHZEce+ZZNxqBRgUkquPPUCnxrKb8sTxcUbsnjtbQF6moaBMf7
 6LHGOVPCCaYcdkop3AJ0fS60pvPkDHn2Ufg/5U4UpJQpwWByFSa6c5uMgsL3vk+kw/kMCvphRss
 KYQ1oIrMNNQVof1Nhp3zB3UHDVmIGWeDuiFK9CFtq2UgV63SiOcHeFqRUTeW3gRI+0xOQJoNYVE
 jVjmpHiapmnUlj0PLV3ilket99teQoYhQzCBGptRsLbAeLxUltgupyXWVyRTt9cpKiD2uKQ==
X-Received: by 2002:a05:6402:22d0:b0:6b5:7ac2:b4b2 with SMTP id
 4fb4d7f45d1cf-6b7773eddb5mr3024443a12.15.1794473237126; Thu, 12 Nov 2026
 00:47:17 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111-vgacon-ioremap-null-v1-1-6dd05bf390ef@gmail.com>
In-Reply-To: <20261111-vgacon-ioremap-null-v1-1-6dd05bf390ef@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Thu, 12 Nov 2026 09:47:05 +0100
X-Gm-Features: AclHuK_fa-iP9Xeaq-QANT8HT3vhxni1COHVSdMAf4Lytq6Fso_wKtQBPBFi4S0
Message-ID: <CA+=Fv5SHTC9XWQJZY7DnZbpMPnk3b7eYNiiH6Dnii+eLJo9YgA@mail.gmail.com>
Subject: Re: [PATCH] vgacon: Fall back to the dummy console if mapping VGA
 memory fails
To: Matt Turner <mattst88@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Helge Deller <deller@gmx.de>, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
 stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 12 Nov 2026 12:55:13 +0000
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Matt,

On Thu, Nov 12, 2026 at 1:30=E2=80=AFAM Matt Turner <mattst88@gmail.com> wr=
ote:
>
> On Alpha, setup_arch() registers vgacon whenever CONFIG_VGA_CONSOLE is
> enabled. On Marvel (EV7) systems whose SRM console is serial, no VGA
> hose is set, so marvel_ioremap() finds no hose for 0xb8000 and returns
> NULL. vgacon_startup() then probes video memory through that NULL
> pointer and oopses in console_init():
>
>   Unable to handle kernel paging request at virtual address 0000000000000=
000
>   pc is at vgacon_startup+0x174/0x910
>
> VGA_MAP_MEM() is ioremap() on Alpha and powerpc and can fail. Treat
> failure like a failed probe and fall back to the dummy console. If a
> VGA card is present, locate_and_init_vga() still switches to vgacon
> once PCI is up.
>
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  drivers/video/console/vgacon.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgaco=
n.c
> index e7e6750f1f87..09f7c376b468 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
> @@ -324,6 +324,8 @@ static const char *vgacon_startup(void)
>         }
>
>         vga_vram_base =3D VGA_MAP_MEM(vga_vram_base, vga_vram_size);
> +       if (!vga_vram_base)
> +               goto no_vga;
>         vga_vram_end =3D vga_vram_base + vga_vram_size;
>
>         /*
>
> ---
> base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
> change-id: 20261111-vgacon-ioremap-null-ad4c7184b807
>
> Best regards,
> --
> Matt Turner <mattst88@gmail.com>
>
>

Nice fix! this must have been lingering here for a long time?
Cross-builds passed for generic Alpha, including Marvel. The shared
vgacon code also compiled successfully for x86-64.

Alpha QEMU fault injection confirmed the early dummy fallback and
successful VGA takeover when only the first mapping fails. Without
your check, the injected NULL mapping faults.

Forcing the later mapping to fail too exposes a separate takeover
issue: the console core installs vgacon despite the failed mapping,
leading to a NULL dereference. I don't see that as blocking this fix:
finding the VGA hose normally resolves the mapping failure on Marvel.

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>

Thanks,
Magnus
