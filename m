Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE37ECD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 19:29:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5862F10EC0B;
	Tue, 12 May 2026 19:29:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="re5CdU8s";
	dkim-atps=neutral
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1514C10EC0B
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 19:29:22 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-7c307937816so25558897b3.0
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 12:29:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778614161; cv=none;
 d=google.com; s=arc-20240605;
 b=Fo5PohDv3hP0Tr6kLCsLGSEthsw0rFm67scE2peerkZCcW97VPhc5hg0mYye3rA0hb
 iCsl5is27y3AW8kUUh4RUPvpi2ZFc/oDZeoH4b95w8xtZym493tjQ3rvy7TgH+puZysM
 BY9B4FieCgLJQIVu3j57CipEKMqIrBs52f9XICgZH6nTWqXCQ47/lzjeosZh1TEnuz4s
 BW1Ug/zrOMw4tPrLg4IlS/VYKO8/SZbmWtpJeO5eB6vHapCwqLG2BSrudusEKzswrCqw
 JmGkptE8LJ2sv7kNKE3xyBG3+eKQR9M8+laEwtV9QqnFufEHdkBbA8QdEvQMX2jiBZt5
 wtIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=y5V4NY9ZfIn3k+L0lU/q3EoovALvOkQaJ8OcuP6pZO8=;
 fh=cFxtc/R4kO8khNHXEN4PdhTzFIr9HDs4wYJJXejY5+Y=;
 b=gkVBsPVPFn368lMbAwKQfBq/EGN+f24j67m2lShL4pdz2L5+yfGwaeVezs3ZAg3w6Q
 w/BhJ0BDIh5HYoPr/1zXZDHympnutr+/OEQunxPJqlXzPEETUaSEbwUw9ofr8v8cQFYi
 KK6Y+mrpiSlkXtHFu1/MOsJXZYAqKswDAnvxCk8NPA1MMVB8moVBRWU6VXupsI14Qa5A
 cJPdICPK66SrA7Bdq0Xsv0PzgWQYyrmPICV1JrXadic7Iv+7cFscK3sGoRg8PysXOYXY
 yp5m6oIMohWdETbZkm9t3OdhotD9U+cj38Mnp7uBFUus/vDqbiNvXbw6wJgUE7h5ePW7
 J4VQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778614161; x=1779218961; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y5V4NY9ZfIn3k+L0lU/q3EoovALvOkQaJ8OcuP6pZO8=;
 b=re5CdU8saTmjZQK1HIZPZz9VHFj2qYQL5NtrkjoLYYrnxS9yI8vTbPV3yWoc24bjqv
 Wga0cK99ZAYYTCotlyN0h8upUsA7yItJF9HzEWOxfVLv1CugTblPGxCiytPnbN3PZzy5
 js1waGxTH7/Wy/4ecsCx5MPEXwwDi0i5sAWY+Pl1ghxNXqkFAzwCF+M4wbQigKExSEwC
 7BjlTDoLY2U8oosEzEbm5efBm676pZ8hsIW+SrtpZtZdCL1dofk0EWEwcAWpGAaH4hJc
 IAUvrjQ9R1lyYit9kLn0Bez7f4UvNIRjrNLG+lN15U7vnKf5fVV8tFYUB+GNrDyPcylz
 7RPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778614161; x=1779218961;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y5V4NY9ZfIn3k+L0lU/q3EoovALvOkQaJ8OcuP6pZO8=;
 b=QGPdPMc1zgSf10SMDf9x1UG/yWYCl4XT7f6ydkEXbqBQJ7QGd0dwwifgBlk7p/a/20
 chT/23uL3tT2kUpg0ZRyrkdbiGRJduBwOM+DzwYBO+7AqUOESGHgBLnleL8vqvI4Q76v
 VX9DuDaEibREpZqC2h4oqU8/9lN8o0NKq/oIZ6rDyybGbfcL4ZPdF743halRTKdIZXQo
 RqQLh1wcUtDcsOtCStoRFiqcxo7Dcnv7MqM7WC3PHVgrU+swW99saJDqgEfBIc7iCTXs
 PHiYnAomrTTpELah/Vx5gf61DmANe1Q/s7CSH/Z0j8rzxbCf/3eYr7rZ3ovuxytrl1yG
 sipQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+jaC6lFNVqJ6o0hQFVdom5XOoO02ilRHs4cmCI85Hm6oBspeZTcUE5uFARffugDIyd0QYlYWaUH+o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1WJRGFxoH6crHcVk7xKZ9LBCk3BkBtpbldUU+GunTI+Ei2bi0
 muDu07zIZIq+aMqdxy1wl9IUVqpIGOmuXqmj74A3r739UMoe/OBvQ/syBFCkWr3QuLQqCRZeeXu
 B4GPOR8zyQamuIxQXIivYpbaFoFLqEpc=
X-Gm-Gg: Acq92OFcJNpq9IG8b2/rK6IZBwAgjytM8CYhf7bwMPj/b3LsSpMfAnhVDk64TVjKsO0
 8DEfbCIi9uhABnTNTn4Qw69jLWsJ2SWNmPUlj8M6SkWTT7x7YJKulSzV3veVfy4Nh0Vt9sp6ft7
 M7gYMm7kkyRzEBjvcnQQVwqIWC+jY+caqoGFp0sTm9P05cfuA5FfNmjjkVe0LuRGSueJEARFfAX
 wLRW27An0pE+kWrurxQcS7mdhg3fQsTCchu2+xELr8UErX9nTp/Zj4DJdi/iVKqRzePYpCFoga2
 s8ureHeOF364u9msI0PjY38RpFp0T3T8bJOAHxAT3RSeVON7A6uJZzUfwwqhzpUu2luRcjUBNQ=
 =
X-Received: by 2002:a05:690c:e1c6:20b0:7ba:ded4:df58 with SMTP id
 00721157ae682-7c6af0e9211mr1421377b3.49.1778614160912; Tue, 12 May 2026
 12:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-5-95c614a739cb@collabora.com>
In-Reply-To: <20260512-panthor-signal-from-irq-v2-5-95c614a739cb@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Tue, 12 May 2026 12:29:10 -0700
X-Gm-Features: AVHnY4LZGt2tTHvS8w_-mzH3Xwl1p-HxDkmqLvgqqCkQCREgtsIxFFFiHnraLjA
Message-ID: <CAPaKu7TknZnxZJ_c3TVeZxOsA+TVVQv=uCNkC0DMokY1Nh+agA@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] drm/panthor: Make panthor_fw_{update,
 toggle}_reqs() callable from IRQ context
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Tue, May 12, 2026 at 4:54=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> If we want some FW events to be processed in the interrupt path, we need
> the helpers manipulating req regs to be IRQ-safe, which implies using
> spin_lock_irqsave instead of spinlock. While at it, use guards instead
> of plain spin_lock/unlock calls.
>
> Reviewed-by: Steven Price <steven.price@arm.com>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  drivers/gpu/drm/panthor/panthor_fw.h | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panth=
or/panthor_fw.h
> index a99a9b6f4825..e56b7fe15bb3 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.h
> +++ b/drivers/gpu/drm/panthor/panthor_fw.h
> @@ -432,12 +432,11 @@ struct panthor_fw_global_iface {
>  #define panthor_fw_toggle_reqs(__iface, __in_reg, __out_reg, __mask) \
>         do { \
>                 u32 __cur_val, __new_val, __out_val; \
> -               spin_lock(&(__iface)->lock); \
> +               guard(spinlock_irqsave)(&(__iface)->lock); \
>                 __cur_val =3D READ_ONCE((__iface)->input->__in_reg); \
>                 __out_val =3D READ_ONCE((__iface)->output->__out_reg); \
>                 __new_val =3D ((__out_val ^ (__mask)) & (__mask)) | (__cu=
r_val & ~(__mask)); \
>                 WRITE_ONCE((__iface)->input->__in_reg, __new_val); \
> -               spin_unlock(&(__iface)->lock); \
>         } while (0)
>
>  /**
> @@ -458,21 +457,19 @@ struct panthor_fw_global_iface {
>  #define panthor_fw_update_reqs(__iface, __in_reg, __val, __mask) \
>         do { \
>                 u32 __cur_val, __new_val; \
> -               spin_lock(&(__iface)->lock); \
> +               guard(spinlock_irqsave)(&(__iface)->lock); \
>                 __cur_val =3D READ_ONCE((__iface)->input->__in_reg); \
>                 __new_val =3D (__cur_val & ~(__mask)) | ((__val) & (__mas=
k)); \
>                 WRITE_ONCE((__iface)->input->__in_reg, __new_val); \
> -               spin_unlock(&(__iface)->lock); \
>         } while (0)
>
>  #define panthor_fw_update_reqs64(__iface, __in_reg, __val, __mask) \
>         do { \
>                 u64 __cur_val, __new_val; \
> -               spin_lock(&(__iface)->lock); \
> +               guard(spinlock_irqsave)(&(__iface)->lock); \
>                 __cur_val =3D READ_ONCE((__iface)->input->__in_reg); \
>                 __new_val =3D (__cur_val & ~(__mask)) | ((__val) & (__mas=
k)); \
>                 WRITE_ONCE((__iface)->input->__in_reg, __new_val); \
> -               spin_unlock(&(__iface)->lock); \
>         } while (0)
>
>  struct panthor_fw_global_iface *
>
> --
> 2.54.0
>
