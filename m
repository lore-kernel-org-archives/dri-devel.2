Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355DAC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 567A110E181;
	Tue, 15 Sep 2026 12:47:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hqay66Jc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89BAC10E181
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:47:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 95026600D1;
 Tue, 15 Sep 2026 12:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D981F000FF;
 Tue, 15 Sep 2026 12:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789476445;
 bh=AcF743jMb+sO2uh/JqmPECcRpmkx5/Xnhg8uC18e1iI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hqay66JcOYVuojWRYIzbr+03Iako3s9gcE43A5l+thsgwox9g1dCBi6ihzTuMYRRx
 h/wNzG+Qgi/chxrxGnRRMLXvMy3g4UZ2zmfsVPVv1djMUIVjI83QZQ0+zza5z0rNbL
 zPBw5EUS+VUIYwlCLbxG7npkceTpaV8NLmWlzyLeqIrWxUZaKJhE/IJhTi2ZZkKpZs
 ktp3BWhEzJ2CmAKdbpUuGumdavGCaQTw59kXqub1VMd8JigkrRLQ4vLJYg8hCnnVzN
 wAvtNhhkuEu6rxYwKieHF10JkOp7gLmoZmO+GVN4EDZFLrP8jsnLiYPT9nGM6ctbqO
 yXCspdZD41z6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI
 DSI to HDMI driver
To: mohit.dsor@oss.qualcomm.com
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260915-lt9611c-v7-v15-2-88f9e9387eab@oss.qualcomm.com>
References: <20260915-lt9611c-v7-v15-0-88f9e9387eab@oss.qualcomm.com>
 <20260915-lt9611c-v7-v15-2-88f9e9387eab@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:47:24 +0000
Message-Id: <20260915124725.11D981F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/bridge: lt9611c: incorrect interrupt clear logic toggles unhan=
dled bits
- [Medium] drm/bridge: lt9611c: missing delay after reset deassertion on su=
spend error path
--

commit 1c8b096eca4758947d0ce62950c84436cc31f839
Author: Sunyun Yang <syyang@lontium.com>

drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver

This commit introduces the driver for the Lontium LT9611C(EX/UXD) DSI to
HDMI bridge, supporting conversion of single or dual MIPI DSI to HDMI.

> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/b=
ridge/lontium-lt9611c.c
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
[ ... ]
> @@ -758,26 +758,26 @@ static irqreturn_t lt9611c_irq_thread_handler(int i=
rq, void *dev_id)
>  	if (!(irq_status & BIT(0)))
>  		return IRQ_NONE;
> =20
>  	/* Clear interrupt: hardware requires two writes with delay */
>  	regmap_write(lt9611c->regmap, 0xe0df, irq_status & BIT(0));
>  	usleep_range(10000, 12000);
>  	regmap_write(lt9611c->regmap, 0xe0df, irq_status & (~BIT(0)));

[Severity: High]
Can this second write unintentionally clear or toggle other pending
interrupts?

When clearing BIT(0), writing irq_status & (~BIT(0)) to the register
asserts the mask for any other bits that were active in irq_status
during the read. This might leave them in a partially toggled state or
inadvertently clear them without handling their events, potentially
dropping important hardware interrupts like HPD or EDID status.

> =20
>  	schedule_work(&lt9611c->work);
> =20
>  	return IRQ_HANDLED;
>  }
[ ... ]
> @@ -1193,17 +1193,17 @@ static int lt9611c_bridge_suspend(struct device *=
dev)
>  	disable_irq(lt9611c->client->irq);
>  	cancel_work_sync(&lt9611c->work);
> =20
>  	gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> =20
>  	ret =3D regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->=
supplies);
>  	if (ret) {
>  		dev_err(lt9611c->dev, "regulator bulk disable failed.\n");
>  		gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
>  		enable_irq(lt9611c->client->irq);
>  		return ret;
>  	}

[Severity: Medium]
Is a delay required here before re-enabling the interrupt?

In lt9611c_reset(), the driver uses a 400ms msleep after deasserting the
reset GPIO. Re-enabling the IRQ immediately on this suspend error recovery
path might interact with an uninitialized MCU, which could trigger I2C
timeouts or IRQ storms while the system resumes.

> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-lt9611c-v7=
-v15-0-88f9e9387eab@oss.qualcomm.com?part=3D2
