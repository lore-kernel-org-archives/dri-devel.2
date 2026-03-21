Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98445109448A
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 17:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D543710E287;
	Sat, 21 Mar 2026 17:19:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="ACu1Bw3o";
	dkim-atps=neutral
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFE9510E29A
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 17:19:20 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-89c43c4c383so20375196d6.1
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 10:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1774113559;
 x=1774718359; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7vHL3NHwLvAmvTyDujeMAKynQAKPZxIj2hZIIbS3qhE=;
 b=ACu1Bw3ooe8k+OgOMoawPVnHkDxLtOBy5IlHmZiDWOWPTFzpfmOgl9qvsfwGNGQOI+
 7AAUV5fPxZLPMevRnjmQpEWmEAChVxYI8JD2IRG19CZwtt8ukxvPyhOMZopBu5dahhI4
 7SpnrIi0gAf/5VA/z6mLIXIBaS914Rn9HDTLwHJDxDL5MAEryc7jV2B0VN9i5xjuwsmd
 PRzZv8KA5h3nQtwUOko/TaGJTVgZYlRU7cei5tPy5TAO0aRAQjNf3WR5VFtYzo3enmmf
 NDW+69jZRmC7Nsvn3IAcitRTmd7B1WHmfSdfUloWwvfURGoIJ90jPnLWAR2OHBsZDyHW
 IvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774113559; x=1774718359;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7vHL3NHwLvAmvTyDujeMAKynQAKPZxIj2hZIIbS3qhE=;
 b=o1MnQPjI8oJqwgdYaJJXlWetHPOMrXwCxDWCXdg5DMc6HdgYNO1OQnwPaPMqermpdx
 q+mr0IMAghR0vtVMwQrsXie+YoSKcUXyrnW3rQhKJZ8w42jxk1ekv4LmrUbwYOAosb8S
 VkP7SBrk8ckTG1AIIlvQ/7pmA4xGyT1B9nt1ob2+DcZA/QUKg7D01kMfQ245IGbo1QIJ
 uP+46akdBVAi/HMoQzcLD2q9nq2Znytjg0becx3+AeJeX/P145CbrCim6BP20beIx6Jh
 J3dKNVZDNshAEBHvIRxIQl8QRIDutR9AqoSUdB2EOZv+7BVS7gKPDTQ3Culwaj+NArwt
 5GtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyeFn6I6CiUgx+LKImbqKWAEXAcTHz5FwxCVX7kH85IPefmkyprtfwqJGVCinB47CS4Ff9znCSBOk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyuP/BdMbpnbXJHfeS/0MQ052jvuqXaVoPgX7Oy0cf5yPKPC4au
 GRr6vNFjM3BZ6wSfSPINS3Q5cY9UWYADuNKfC/9ewLwH0jg9zvg3U1fZYHbc9qBjjabEHz+0jG8
 elx/u/gebeZeq
X-Gm-Gg: ATEYQzyPNcrJuTWWhmDi3T3r/8zf6HmKkBLUYI7FnY4ytE4aNGlmwzMLO+FuFPfxm7q
 r+6bgvbKmapYK9LwT0kib4FIBfL5jOBJ7AR+1YRS3+7DP9epGNOUMcz2FyOmenq4XKoHRZcP/Us
 VtbX2U3SRiN8rzso9YHmu7jW62yaDmVLVV4Yd+Xs9KBAhdZDVyo9gawnTz1P1hEhW5Vu7VjKzTC
 FrjHqqqSrucTvKN3NAl/HFEUgzknRtmoDl9mpke1E0kS8ymHsdQag0iep5FeAg7F1487dMNf+Iq
 mlKhWqlN7mO/6m3O2TcVYY3Xtt9AW01yc2Wn8BRn9z8vt8cx406DsXj7VzOeA3sigB8duvESTHh
 NGyp92skGlFjb5FzHpwCwPndEIU/sQgUxC2C+PDx4EFnyFT238/KX4O6rtafBhdijwn0qXtPP91
 ULuI3Yt9zWUZWyprBDwogMaADvpxGapD8mfHPuzH3Ftme4jO+/6LZx/qPGMg2nWg==
X-Received: by 2002:ad4:596b:0:b0:89a:f10:9980 with SMTP id
 6a1803df08f44-89c859e9030mr119031756d6.22.1774113558657; 
 Sat, 21 Mar 2026 10:19:18 -0700 (PDT)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com.
 [209.85.219.42]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c85214a87sm47808816d6.5.2026.03.21.10.19.17
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Mar 2026 10:19:18 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-899fb2b94c1so19110756d6.3
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 10:19:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCW6ViD+h6sGjQPvubQUawArkJS9QNWOeU3ICqXN6jrMF9YN5YVkVuAr5hRfzNsqFFt6mQFvU3gNiVc=@lists.freedesktop.org
X-Received: by 2002:a05:6214:2503:b0:895:4bec:c629 with SMTP id
 6a1803df08f44-89c85a4415dmr120844646d6.31.1774113557567; Sat, 21 Mar 2026
 10:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260306-neutron-v2-0-3019bd8c91ef@nxp.com>
In-Reply-To: <20260306-neutron-v2-0-3019bd8c91ef@nxp.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Sat, 21 Mar 2026 18:19:06 +0100
X-Gmail-Original-Message-ID: <CAAObsKDAzfib86rXqt9FjXV68yRkBzmijcyR+x=1MsPYd=MQWQ@mail.gmail.com>
X-Gm-Features: AaiRm51EiMaDZyOBoTxsmzhD9LKdQqqk1TUMHYTLZEpIizj3O9FXdJaoYzmTmY0
Message-ID: <CAAObsKDAzfib86rXqt9FjXV68yRkBzmijcyR+x=1MsPYd=MQWQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] accel: New driver for NXP's Neutron NPU
To: Ioana Ciocoi-Radulescu <ruxandra.radulescu@nxp.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Jiwei Fu <jiwei.fu@nxp.com>, 
 Forrest Shi <xuelin.shi@nxp.com>, Alexandru Taran <alexandru.taran@nxp.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Ioana,

Looks like the userspace portion of the driver is closed source
(libNeutronDriver.so)?

https://github.com/nxp-imx/tflite-neutron-delegate/blob/lf-6.12.49_2.2.0/CM=
akeLists.txt

Regards,

Tomeu

On Fri, Mar 6, 2026 at 2:27=E2=80=AFPM Ioana Ciocoi-Radulescu
<ruxandra.radulescu@nxp.com> wrote:
>
> Introduce a new accel driver for the Neutron Neural Processing Unit
> (NPU), along with associated dt-bindings and DTS node.
>
> The first patch extends the GEM DMA helper APIs to allow bidirectional
> mapping of non-coherent DMA buffers. While not part of the Neutron
> driver, it's a prerequisite allowing us to use the GEM DMA helper.
>
> Neutron is a Neural Processing Unit from NXP, providing machine
> learning (ML) acceleration for edge AI applications. Neutron is
> integrated on NXP SoCs such as the i.MX95.
>
> The NPU consists of the following:
> - RISC-V core running a proprietary firmware
> - One or more Neutron cores, representing the main computation
>   engine performing ML operations
> - Dedicated fast memory (TCM)
> - DMA engine that handles data transfers between DDR and TCM
>
> The firmware is closed source and distributed as a binary here [1].
>
> The Neutron software stack also contains a userspace library [1] and
> a LiteRT custom delegate [2] that allow integration with standard
> LiteRT tools.
>
> [1] https://github.com/nxp-upstream/neutron/tree/upstream
> [2] https://github.com/nxp-imx/tflite-neutron-delegate
>
> Signed-off-by: Ioana Ciocoi-Radulescu <ruxandra.radulescu@nxp.com>
> ---
> Changes in v2:
> - rebase on newer drm-misc-next
> - dt bindings: clock fixes and renames
> - update DTS to match new names
> - remove unnecessary fields from neutron_job structure
> - fix use of uninitialized variable
>
> - Link to v1: https://lore.kernel.org/r/20260226-neutron-v1-0-46eccb3bb50=
a@nxp.com
>
> ---
> Ioana Ciocoi-Radulescu (9):
>       drm/gem-dma: Add flag for bidirectional mapping of non-coherent GEM=
 DMA buffers
>       accel/neutron: Add documentation for NXP Neutron accelerator driver
>       dt-bindings: npu: Add NXP Neutron
>       accel/neutron: Add driver for NXP Neutron NPU
>       accel/neutron: Add GEM buffer object support
>       accel/neutron: Add mailbox support
>       accel/neutron: Add job submission IOCTL
>       accel/neutron: Add logging support
>       arm64: dts: imx95: Add Neutron node
>
>  Documentation/accel/index.rst                      |   1 +
>  Documentation/accel/neutron/index.rst              |  12 +
>  Documentation/accel/neutron/neutron.rst            | 131 ++++++++
>  .../devicetree/bindings/npu/nxp,imx95-neutron.yaml |  96 ++++++
>  MAINTAINERS                                        |  10 +
>  arch/arm64/boot/dts/freescale/imx95.dtsi           |  28 ++
>  drivers/accel/Kconfig                              |   1 +
>  drivers/accel/Makefile                             |   3 +-
>  drivers/accel/neutron/Kconfig                      |  16 +
>  drivers/accel/neutron/Makefile                     |  12 +
>  drivers/accel/neutron/neutron_debugfs.c            |  34 ++
>  drivers/accel/neutron/neutron_debugfs.h            |  15 +
>  drivers/accel/neutron/neutron_device.c             | 239 +++++++++++++
>  drivers/accel/neutron/neutron_device.h             | 155 +++++++++
>  drivers/accel/neutron/neutron_driver.c             | 262 +++++++++++++++
>  drivers/accel/neutron/neutron_driver.h             |  16 +
>  drivers/accel/neutron/neutron_gem.c                | 116 +++++++
>  drivers/accel/neutron/neutron_gem.h                |  14 +
>  drivers/accel/neutron/neutron_job.c                | 372 +++++++++++++++=
++++++
>  drivers/accel/neutron/neutron_job.h                |  43 +++
>  drivers/accel/neutron/neutron_mailbox.c            |  47 +++
>  drivers/accel/neutron/neutron_mailbox.h            |  42 +++
>  drivers/gpu/drm/drm_gem_dma_helper.c               |   6 +-
>  include/drm/drm_gem_dma_helper.h                   |   3 +
>  include/uapi/drm/neutron_accel.h                   | 130 +++++++
>  25 files changed, 1801 insertions(+), 3 deletions(-)
> ---
> base-commit: 6716101ae42949e98ad4b9e71eeba08c055be410
> change-id: 20260226-neutron-c435e39d167f
>
> Best regards,
> --
> Ioana Ciocoi-Radulescu <ruxandra.radulescu@nxp.com>
>
