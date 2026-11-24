Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9640E606A323
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 22:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=tD+TSV2J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C36EB10E9D2;
	Tue, 24 Nov 2026 22:06:15 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D16E10E9D2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 22:06:09 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-8b4d543b6b6so29190357b3.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:06:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795557968; cv=none;
 d=google.com; s=arc-20260327;
 b=hRQ8l3CkBNahaH8VVvVBgZit3/Dx4YcBg+C9Cz65vqXptuq5EHVcfK8IBolbNo1v0e
 Ijfdw6lHsUVpHMLrJ5J2gaBwDPkmOn/h0Onkmz2R3AY69QUNIF5fhTkcN+P4kIaF8A1e
 +E5AKBlJusjHYEns/lAyeRCIGTD9KETrY18K5QSGc+lr8PT+IVdae1+ujWrewY0s6pMk
 SNzxWx/n/oJwv6JWyEYhXqO8hY9dw0DqzRDzZV1SeJdjGQs2ygqvZuWno0PTRWCFBUp0
 NzNYcCJgSSbIcpHDm21MEK6VdnVKv7N+7jp34Q1WXuT0LUfOcN4ahJUo9Psd/QWtTc03
 OxUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=csthBXWoYuqZlipfPcre6aDWuJqEg0KlKenjY0/u3Xc=;
 fh=12R71PwB7Jd4x30x0avyXlmtUHP8jZZKCtwFvjtsDi8=;
 b=dHK+9lzLGg723SkLPKlQ0npBhmlQcbIFSG4pgLGupSM2xJKOGGXTw2KYgQtlv4c/Vz
 djx63GGlG2U67UtmODip9PIoH0vG7ChrWXjhFySmsx3w1yabBNHZLI0GzNLJLKRyKJnx
 T5+STjhIRvRg8uTXEGwGDW/pCNqY0QS/XWOC9yNkMFHRS0nxA+dId+yNFmbo6IVZ0NSl
 LiUhbKxcOYDrb6GnK4IwlSg049RJ8bWjpPmFBIbYbwuAmA2dRgKsVB8GUV2V3pb39XoF
 q+C3eiH5y2MQwyBo8/M3s1TAg5yqtHYKRqmdIYGHY1IPMwcnRCDFdo+PA5lxWBkbK1kS
 BrHA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20260707; t=1795557968; x=1796162768;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=csthBXWoYuqZlipfPcre6aDWuJqEg0KlKenjY0/u3Xc=;
 b=tD+TSV2JfYITk3yHDdJc7WyjTBTHTkFfIDzJxVyG0rggg2tPKbomyqY762P8sX4oNR
 VV7NXgBTLNOEn/H0TLxSToZJSPjM1Bm7FO7L9/uCYL7QZKsyLvYmzkBN7MD5W+qZBmUU
 iwyMjYai+MLULXsfTK0/AOsyLH2EV6gpHnFCACyPU3vrzSwrf/jjjdQR/3INIUNA1bTk
 9GYl5MLIix0368no60DIc+UvfDbZ73GxkUdCCfGvWvYeae8Sxv2LSAp2WIen+5rlYkqe
 AoRa07d/uBkCiOf36wl3RP5+pBdcjUEkh5WLLU3m7E2af+iHCjLAAF2FTDBZHD7bGibT
 uoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795557968; x=1796162768;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=csthBXWoYuqZlipfPcre6aDWuJqEg0KlKenjY0/u3Xc=;
 b=ZC1/Ep0Ebj/hSgQuWq/p6vuva7kCuVbQ9OOamsGAT2orSsER7JEs7xIzgdqDbyiHDT
 mDRvVkGKsn2dt0Wo0n8J9Fzvh0SzAYBSr2vviJSWc7+IUaVvgQvsQj4KRDuYIPCTNRRb
 oW5xuXGvT4uxH/Mem/uETCLHapH5O8Td34J83DQHw9oAxPctAnkf/2fRrU2Q1JhPXlDK
 eomrWKKUllud0S0eOIrXfNURdZHkkodRCEy0iBRt4rD7El55Pufm6Tepk9dxDQ/gb6RT
 tKvoiddT2QNuUpf+4+M2ex5xnhiexWusNG4Pe3bz4JLek50dgSjPAPmzZ5muyYnZU4Ki
 mXvA==
X-Forwarded-Encrypted: i=1;
 AL+hErFb7BT+CXvl++XMLSP7yoz5efApMPUFh3mdswHUxRyoLlR+OJ9qOSZ3x0CoDqBExG+dPzFsv6pBceU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9THcqAH9TzKLA3MVkOBjp1xSs48MzbuuR8pioPkaMzAik6y35B
 P4xW1EcCnMWisxI3foRV3LbOwJzTC1Gi9ZFj46ITbp2ou/qwY015AkveQ45wGGr7d2nYFCOUF5L
 vxUreAHgzqoR0yw7shL9wvjfAKyBhu+M=
X-Gm-Gg: AZFdTZfQEcsHGnYZSQStDfqkAUK/Ctr0Xi7/LPAgjX615nM525P1VbAton0TdrnrcyK
 dWg429fh7KoYgpTo94byNHHp0yutMrLqgeXS2y5U2S/QXj4MqaV/2pqoFnMmUP/yxkUQ2khiuiz
 z+tqTC+hARA+E6jv/UfHZvqArG0bCHtSdxiN8WspvOceI6d+MsdjB4qVnH1XvYsQvLAWN4kPR6X
 PF54cGWws+HDLcV7gxWBwFNxlPoQverSCCcWsbtA+HL/+4ZHixD0uY6+Odke0hg+q6xup+0whz9
 7AZnh5mJkwLE6hKx6zjTm2MOS060QyLglNCBnVol1DpESysSavqiW8od+8jokuKa0oL4aEx0LVm
 bELfb0EKKVeknS5+LtUd37t7XkULmEe2WcgrULznkuaDwzpNgXKbmGyicdYKhyjS9h3r/2w==
X-Received: by 2002:a05:690c:4806:b0:8b3:33cf:1ff8 with SMTP id
 00721157ae682-8b52047e1abmr62214977b3.51.1795557968035; Tue, 24 Nov 2026
 14:06:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr>
In-Reply-To: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 24 Nov 2026 23:05:57 +0100
X-Gm-Features: Aa3M54obAOudEtwcvYkDuGnJHvL3A4XdBNW-oHonc9K3rZo32rUzvFY7EEi7VPQ
Message-ID: <CAFBinCD822UPQrrd_8ZbVRUVCVJ-3pGN69vbZBxUE+0yeMcysg@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] phy/drm: amlogic: Extract Meson HDMI TX PHY into
 a dedicated driver
To: linux-kernel-dev@aliel.fr, Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Vinod Koul <vkoul@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ulf Hansson <ulfh@kernel.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ronald, Hi Neil,

first of all: thanks Ronald for picking this up!
I like the overall approach. Before I dive deep into this series I
will finish the code-review of Valerio's AUDIN series.

Two quick notes below.

On Mon, Nov 23, 2026 at 8:38=E2=80=AFPM Ronald Claveau via B4 Relay
<devnull+linux-kernel-dev.aliel.fr@kernel.org> wrote:
[...]
> Overview of the series:
> - Patches 1-3: Fix compatible matching in meson-gx-hhi-sysctrl bindings,
>   add the new amlogic,meson-hdmi-tx-phy DT schema, and allow the
>   "hdmi-phy" child node under the HHI syscon.
It's been a long time, but I think we've been asked by the devicetree
maintainers to have reg properties for the nodes within &hhi
But I can't find the message at the moment.

> - Patch 4: Add the new Meson HDMI TX PHY driver implementing the HDMI
>   PHY configuration ops, along with the temporary legacy creation
>   helper.
At quick glance your PHY approach would also fit phy-meson8-hdmi-tx.c
There seem to be minor differences:
- two additional enable bits in HHI_HDMI_PHY_CNTL1 on GXBB and newer:
HDMI_FIFO_ENABLE=3DBIT(2) and  HDMI_FIFO_WR_ENALBE=3DBIT(3)
- newer SoCs seem to have HHI_HDMI_PHY_CNTL3..5

Meson8/8b/8m2 HDMI support is not upstream yet. That's why those SoC's
won't need the backwards compatibility code. So if you need to tweak
the driver: feel free, there's not much you can break!


Best regards,
Martin
