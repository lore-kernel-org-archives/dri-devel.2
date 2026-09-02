Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F234EC61DFD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26ACF10F0B5;
	Wed,  2 Sep 2026 08:47:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OXD0toCg";
	dkim-atps=neutral
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com
 [209.85.161.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70C4810F0B5
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 08:47:46 +0000 (UTC)
Received: by mail-oo1-f54.google.com with SMTP id
 006d021491bc7-6b145a9623fso305739eaf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 01:47:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788338865; cv=none;
 d=google.com; s=arc-20260327;
 b=eIVQ9IJPYDYD1zzvYB6TlhHqJgS9TaZanQ63zJSMdm7Kc7kQ3Zaz5fdQENQoCycuBV
 1s8mvZj0EBuoNbyS7qmnXjmp1O0NiYxs9282ChHXhfDAhIMxMgDz1B5/jWV1+2kPOgGk
 hmDJboJN8b4xanUWaG0bmwSFauhrcIgK19kYgegE/3izSBAOZv6F8qGyLogCOippOdPg
 ZlS8TYy3wG3BtKOU1EwidgApKp9eE6/Rp8Xs55lqkkT6VI542WfHL8Ru4VbR3LPd6ox2
 sHjrdHXhRTSPSIKtkUgyBl0KLiFbKO1K1st0UUFJKH1XyNMTbTcWtwW33/OrsmAiSK1Y
 GVKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MYMnfWqyZs8fhoupAqZEoP21jVypdUTvrAIwa7LBw+w=;
 fh=E1agbXR3+IlDREubVMMtqjZb09AjwBvnEMRADPdwWh8=;
 b=oVFyAPJo8+2y8f8IKl/mCDAClr+1cb2n2ubN24h+eRys9g3XR9M9PmK9lvmjvMYu6W
 rXDWna2rwIoPH13hugPpNg4eES9j1gz23nRvimyejy7N8DMSXicorkGcpQ3tHKd+hVJz
 NN6hbSA6zXGfygs2VAjrj6C6bOpHapoiMg/XpheLjvap0jzPrnxFbZp6au4r+V+mZwuA
 NhkW2ZTVTVbTtrXfMqgP6juqdA6vZq+5QUtzz9jrd2MPelPBYYrTtNMujChk2pk27Kuo
 0H308l0QV83xCWu9WHZMnaU1ugYt6il0yb3P+Yy/YdX7NS4utazsHSEEY+2OiQPQIJ7Z
 O9wQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788338865; x=1788943665; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MYMnfWqyZs8fhoupAqZEoP21jVypdUTvrAIwa7LBw+w=;
 b=OXD0toCgxdgg5bUHFh5ednHZMqgqv8ATfy4Qzvn/Z9zkUODz5rTjohaJvcjFJV8uLN
 n3xT2l41TCrFmneCVFi5duRdn+et2cIHl+SZlBW+cYSwSQeSGY9atcDBiVczKrd/pizI
 3HgktPOfmIWYWQX9WML97ICpZENtnzaRtIVaXmlXmXF5JktSXbccxbNjOs5unvKyXNhq
 ZBUxo9uv4N/ZrVEBZ+baSWfs90nz3rDDirJOsP1CO0OUyWC08OxQu9hnQEyxlXG65aQk
 wRpCJvBAIzd7ZDHLhcILUJJeJ2tBEy9L8QeS8gOiLiKRCZb40QEPd/qdUbgsuySSA7bV
 Pufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788338865; x=1788943665;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MYMnfWqyZs8fhoupAqZEoP21jVypdUTvrAIwa7LBw+w=;
 b=cDM1X1HW1ZCfDoQbRkAvaZIMGAC0HFXGLYA0J/mFN+WexMp6EL8Q249RhgVVl40IbN
 ybeu/VHtnGorGbPJSxdXv4a174s1JKhA4yXABzRsSMs7RN8C69m6mp0szQPUtcFn+8d+
 rB4IR6L5P1jwNUdWkO8U5ZK+1pDrGKZL3K5P3cSQ/S9hc49siUTFK3Q4T7d2QDQgBXPh
 1LSe6mVOQLOsbd5ZKQy3BjFWxv7blJPezNkttAVDMsSAW2vrMfUn7U0sP0ta55JXKI5u
 13UF/JSpnOxFacYBBUI74hAVI6mGseBGW/AF1zYqGl7oiSs5Excm1tHMI980/Vx9sTvW
 v4yg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq7r9y5/V7XDlkhDEDuR3w+6Pj+kKKdSsyTOwggfZAeYiF852zqMz6wch/DKl/dOJeR6mc6Cp9E0KQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lZa6xcHrf+i4l/VPDWZel7IWyHgpvVfbM6Ka4BnmLdpvK0hdwG
 pSkcVN3jzIkUbpAsGqHYJWuIpgadiXgUNKk/Ga6Wc/f4ePcHsSeq2DtPhedZ/c1huqZ/rKBeEcw
 nxJxjQwwU0Ly7CrG+W5gTuorxWqtToXY=
X-Gm-Gg: AR+sD11j34i+7Li8qg1JfwxCmVM4CW0iuSYFZBBoO/XcvUeZGijcefuSo/ij19fEJt0
 b2tcXEGTkbpM9wBfS4EiNr/bV9wg0CS7F8hQlSTot33iFqgN+CcWcVBEmAXjzvtZiFg6iMPBOV7
 pdKPz0wfJ1xo0SpHMV1jUedAzTnXYkLebZTuTNgzr35zOybw0mixfQyOAe96soiDgQs880KkENW
 NJV0nZvmSrz4GaVvv4Jc3JaVsmA0QGjJmdAB589XL+M28b9wLii+2WqZRKrq21l2V7EjiB+Fvzb
 b6ljsuL5zY8wamcdEuZvLWEoA2gRQbSs8O6rIeT82v8Wj2bc6OzTWURHJf6EFX5VPpiaCCPo2bn
 x7Q==
X-Received: by 2002:a05:6820:189a:b0:6b3:68a9:79e5 with SMTP id
 006d021491bc7-6b47edceea1mr2290029eaf.6.1788338865560; Wed, 02 Sep 2026
 01:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260823111959.17029-1-amit.barzilai22@gmail.com>
 <20260823111959.17029-7-amit.barzilai22@gmail.com>
 <20260823113402.D7F9F1F000E9@smtp.kernel.org>
In-Reply-To: <20260823113402.D7F9F1F000E9@smtp.kernel.org>
From: Amit Barzilai <amit.barzilai22@gmail.com>
Date: Wed, 2 Sep 2026 11:47:33 +0300
X-Gm-Features: AcwNN1Vo44MBmJfOcBB8zzBfrsBJUHYQroJ08viZBYwnFe3YB46ZksIwW3AFHfo
Message-ID: <CAOEgbEqhvoz-J0o08_igTAJdfEHN6vZcxgd72An=BKO2L2jhOQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
To: sashiko-reviews@lists.linux.dev, 
 Javier Martinez Canillas <javierm@redhat.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, 
 dri-devel@lists.freedesktop.org
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

On Sun, Aug 23, 2026 at 2:34=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> [Severity: High]
> Will this cause a DMA fault on stack memory? Callers like ssd130x_write_c=
md()
> allocate the command array on the kernel stack (e.g. u8 buf[8]). Passing
> cmd + 1 to ssd130x_write_data() results in a regmap_bulk_write(). On SPI
> devices, this passes the buffer directly to the SPI DMA engine. Because
> vmalloc-backed kernel stacks forbid DMA, this might cause an immediate
> kernel panic or fault during device probe and runtime updates.

This looks like a false positive. regmap_bulk_write() does not pass the cal=
ler's
buffer to the bus. Since the map has a bus and val_bits is 8,
map->format.parse_inplace is non-NULL, so regmap_bulk_write() takes the
branch that kmemdup()s the data into a slab-allocated buffer and passes tha=
t
to regmap_raw_write(). Slab memory is DMA-safe, and the caller's buffer is
only ever read via memcpy(). The finding would be valid if the driver calle=
d
regmap_raw_write() or regmap_noinc_write() directly, since those can hand
the pointer straight to bus->gather_write() and into spi_transfer.tx_buf,
but it doesn't.
