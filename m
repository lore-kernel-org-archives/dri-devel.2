Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5297CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 05:02:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02FD810E733;
	Tue, 13 Oct 2026 05:02:53 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
 [209.85.208.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9593B10E733
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 05:02:46 +0000 (UTC)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-3a980c01033so21265101fa.3
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 22:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791867765; x=1792472565; darn=lists.freedesktop.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=h5+rSj/bCzh4KisRqwxzi0aZUIfxwQb53cIVUp+xnT0=;
 b=DSljzJZ1vihmqi7CA1Zp0p5figQWU1/M8HUGeF203nxmq/wsWhesOLca/cGIfobTh0
 NoXe/nSpQVMYggsCwMRdRhKIK8sOWmMJK1jVt4wzB57FD65ok+3NWLnTnwfNfS4D4juz
 3xMZ7/tMvPQqBVUEkkjp9Sg8q43lM1nPAAsToY/yxz8IoSUweUyaTbr7/4gFFlC/oPWK
 BrOzjFmQ1IAVaUYa81sqcpdQOL51dodNDp7I6xOkrE98u7vi2E6ikcz+nmygO1e9X1bW
 QGIdwtoAixkoLnbldFcyC3JgPn7eMgWcjJtD5mN+KFpOkQ74G/65u7CO+mpDaIlhAdRO
 VIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791867765; x=1792472565;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h5+rSj/bCzh4KisRqwxzi0aZUIfxwQb53cIVUp+xnT0=;
 b=SSbZbqK4yTziMBGVR97cieRs6XazgVjt4xUbbPzegHIZy7WIuKxlNOlZbiMbtgsu0B
 X9xhSBvauje/u0uvUKwVixxuG7rt5p/H5R7dYRF6XxBBeIO6x/Ej4C7LmqTnV8ZReZgx
 nltTuvF24PgFLLWxjFmROZme8Z/7hSKJouT76jyROiPrpGhLQ7fG3m8EROpemzBDBp4H
 RiIHxTX1IAY/BfP/0fcMGTqPW8GocmhJnbnH2YVHmWjpUuZgzSolGsm5HmlsztE6hhG/
 uo+ToZIYDdMwnDt4boKKWCuGwfUVhmqN9JA3/73wd/E2VjV8hKv8e6EuG1On6O3z8r1s
 4rew==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDeMuinCUQ98qbHEw5Ie+ldUczxGYw5+BIVz1xi2C2yXrbx+d3WxoFELx/5bCMXsTWcIi4GGCsmd4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIndDfS7iQRKAHdIUoURRXkxU7Ry9AWhPCIYpQqv7Qt3qDVQz1q
 xzR2O8zznWEXRokuGDhLHslfyUqH7PgTIBrxWUf9sQgyw+Pm7HyoyZWw
X-Gm-Gg: AYBFou066WHVgTgdyIKjoVNHYZG9Wicf5UkwGc2u91Yr6pDdtetL4sH99sIEhDwubsy
 tW5nFjSuau2Pp8La4tZ2fh+SPHk4An1qCCat30hvBkDiiIPviSAchqxaI7RHbGEwwtjU5PuECAP
 jIw1H8aqPYJkqcAAqRtwjzdmoGMBDabQAv0GOMDR47ptbe61hrWnLv4iJiepiMv9dw2RB5Y7ynC
 D/Ghrbu9rixGj4ILVeaUJ1IwLiGDjwt9HJX6nOZ28Eg8FMpqLjMBNdv5YVxCtmU2gqkz+M2+zAv
 ff+rGq44i6yE0ddsunMylkwi1Z+1/OXm9bnYRfkeiviZdDyDXWYT/E+/DXJTf7OUdk3OgZcuNKI
 oJzSif1d7xux+NLsVCcodFqjvZ7rvUFX3/xanahuJ8dH6jNuboLGziJPpKkASSX6nEZz+yjweht
 9dmXXqZk2lLTmhwRBAKq6gjzhE047Rn5W87EyM9lOhnzZ7GNj4kL0xf8rpdkm2vdOt9WjCAUjpk
 X+hMMNFWxkGHk4eCW7UlYyvS5JhIQ==
X-Received: by 2002:a05:6512:3f20:b0:5b6:4ae:d87 with SMTP id
 2adb3069b0e04-5bcde6c3cb1mr3982535e87.27.1791867764438; 
 Mon, 12 Oct 2026 22:02:44 -0700 (PDT)
Received: from smtpclient.apple ([87.200.95.144])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcdde912a7sm3212589e87.18.2026.10.12.22.02.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Oct 2026 22:02:42 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.3\))
Subject: Re: [PATCH] drm/panfrost: reset the Amlogic GXM GPU on runtime resume
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <179184031154.1056803.12154076398577087527.b4-review@b4>
Date: Tue, 13 Oct 2026 09:02:27 +0400
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <daniel@ffwll.ch>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6B9C57A7-8BE5-461B-B44B-EF91FC2D2D93@gmail.com>
References: <20260930125629.2691968-1-christianshewitt@gmail.com>
 <179184031154.1056803.12154076398577087527.b4-review@b4>
To: =?utf-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
X-Mailer: Apple Mail (2.3864.700.51.1.3)
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

> On 13 Oct 2026, at 1:25=E2=80=AFam, Adri=C3=A1n Larumbe =
<adrian.larumbe@collabora.com> wrote:
>=20
> On Wed, 30 Sep 2026 12:56:29 +0000, Christian Hewitt =
<christianshewitt@gmail.com> wrote:
>> After its first runtime suspend, every power-off of the Mali-T820 in
>> Amlogic GXM SoCs times out and floods the log with shader, tiler and =
L2
>> power transition timeouts. Following a soft reset the cores report =
not
>> ready but PWRTRANS never clears, however long the driver waits.
>=20
> Would you mind building the driver from the latest drm-misc-next and =
testing
> whether this is still the case? Today I merged a patch series with a =
fix
> for a long-standing bug that prevented the device from going into =
suspension
> because of mismanagement of the PM refcount. It might be that what you =
report
> as an issue triggered by power transitions is something altogether =
different.

I=E2=80=99d tested with the v12 iteration of your series in my =
amlogic-7.3.y [0] tree
before generating the patch I submitted. I=E2=80=99ve now tested with =
v15 (as merged)
and other recent panfrost patches you submitted (which v15 depends upon) =
and
with this patch reverted, and the timeout issue with T820 remains. I =
also saw
a splat that I wasn=E2=80=99t seeing with the v12 iteration [1].

[0] https://github.com/chewitt/linux/commits/amlogic-7.3.y
[1] https://paste.libreelec.tv/desertic-cataleya.log

After reinstating this patch on v15 + dependencies dmesg is clean again =
[2].

[2] https://paste.libreelec.tv/leptosomatic-cherlyn.log

>> The transitions complete normally when the GPU comes out of a =
hardware
>> reset, as it does at probe. Use runtime PM with reset and clock =
control
>=20
> panfrost_device_reset() is always called as part of the PM runtime =
resume
> operation, so I'm assuming what you mean here is that reset control is
> deasserted at runtime resume when the SoC supports it

I=E2=80=99m firmly at the hobbyist end of kernel contributors and I=E2=80=99=
m not able to
technically explain the patch Claude created. It=E2=80=99s entirely =
possible that it
pokes around in the right area of code but is not the correct fix, but I =
lack
the knowledge to dig further without explicit guidance. I can also give =
you
remote access to a Khadas VIM2 board if that would be easier or useful?

Christian

