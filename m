Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1E6C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:14:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EDB810E062;
	Tue, 14 Jul 2026 13:14:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b/B9V8GF";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 271B710E062
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:14:03 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-697bd21fdc2so1731352a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 06:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784034841; x=1784639641; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ny5+3yiTMDoQJssQpPJVjH5n2qiBSxJZzbYo0RMA4qo=;
 b=b/B9V8GFlzD86g8jMhR/oJ2tfjIUtWNwwMtYh8pQoDPwMmrxlva4yqNwl6VUC18UNr
 CRE3Lio7ADjbKce/MDsM3nj2j2NuSEj8B9viIYVc/noChR11EH3+Vo8sV+sav6Svc5Uc
 UVpRAtqiSdgzzR5aOH5QSPi62Fzf0z3EAAY2ugDkpJO8VVPHTzLPD+4i/ARdQqxfzJ+m
 ow1iVd2jahcZ+KwYYuwZRAy2fXLtbahEHihaINoOXKAuUBt5lSYpD6rSRHvUmMVZRpyl
 xe2ldynkculPXn29NCyj21EGVoSRY6RyrJJJEO/L879yeWysntRp/5XBsepxa8dPB7zV
 X9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784034841; x=1784639641;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ny5+3yiTMDoQJssQpPJVjH5n2qiBSxJZzbYo0RMA4qo=;
 b=iXjGpzKfER5MainI3YPDHsac1bqOM67o3n4WEgqR1UMzcVmoqT9diuVtIBSBTXtuGd
 +zV0UAxFfYeI0UGofl8PFe7zigH/feaI1dgvaJJF7MZ5WJjkU6EBH3azd/+3DAj9XeIR
 r/yALdZUsfWawQg3LUH7BOUl1/Wjr4pjqm8ePplj6XumT5i5vlA9sngC9IG5+Uify/9b
 37lonvMA8IFX1qyE+sYd1Lfi8icgeuBSPbBzyGRIhpulSB9yT+SKjxj4ltsabmxn7fyA
 1z3f4tx04obE6K55VlkiaD0ba4MdiPL2n2mmYhW7hfnbk9xut7RiO1DZqMF/TgEfr3dJ
 2Gsw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqSihaF7ZkAUyUvzPKCSsIdQvNOuN8eMFf2GfCQOLAyDvxMeNj+8Mr4eXTRRxpn9gpOOXID6dRP5xg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YykFI0+Tuvb4k4IZtyvvYUYK5heQntsRfjdp/iKs0ynVzOqqpF+
 3oLM+YNrILhZ4CVLpEHSf4GUbCJobQQF1IQ2fdkIIOYj9GBwxsjqQutM
X-Gm-Gg: AfdE7cl07efrviqnil3vhbS5RFfRAyYeswPlVxYRuNTXhH0LYGbYQ/1s7rBdY2f8ecs
 v0knxkwF4hX4Flhw/rk7NHXufRjvzDnjeFWrhRFM4LwqA618c2cNPOFu0SlU2db6Y71NSaAMHDb
 zlxUJqP3NYqPaSoSAEHfuRdVxvNCpYM5wyngjONy+VZSEj9Bkd6o4D/K6BxwYkAfgyaGyLepwl7
 aEKTjH4WvPIwIUu6zRZQr8au1sn8+UUovdgjBGbDklZlbAlPih+rsDEEI5usn7Gl2jYKseLIs5W
 a98yg/FwvPq982He6F75INGeXGUQyMPJa417qrgP8NUx221w3HTAgc6uxx4eYaGVNGCbRbnd4wm
 NVH484F6PE1Ibf+wbuGlYj3lA5jBU6i2yyteJr7ChA5yNt0c/hGhD8HfPV2FY+pqyfwi3XsRQBe
 PHRQGhGuI9WfhR0z6iUvMaY78SZTGI0TnKYjCQ+A+M9qpG7Cgk/g==
X-Received: by 2002:a05:6402:1e8c:b0:683:e394:cc0c with SMTP id
 4fb4d7f45d1cf-69c5ef84424mr6428415a12.4.1784034841275; 
 Tue, 14 Jul 2026 06:14:01 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69cd2952836sm1533316a12.27.2026.07.14.06.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 06:14:00 -0700 (PDT)
Date: Tue, 14 Jul 2026 14:13:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Baineng Shou <shoubaineng@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, "T . J . Mercier" <tjmercier@google.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey
 <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, Sandeep Patil
 <sspatil@android.com>, "Andrew F . Davis" <afd@ti.com>, Srinivas Kandagatla
 <srini@kernel.org>, stable@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dma-buf: dma-heap: don't publish fd before
 copy_to_user() succeeds
Message-ID: <20260714141359.7758575d@pumpkin>
In-Reply-To: <20260714114654.3885457-2-shoubaineng@gmail.com>
References: <CABdmKX21NHc2=9Sk2F-BFpu6is0vTg-QXLE+wiFNEPdsWWjvog@mail.gmail.com>
 <20260714114654.3885457-1-shoubaineng@gmail.com>
 <20260714114654.3885457-2-shoubaineng@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Tue, 14 Jul 2026 19:46:53 +0800
Baineng Shou <shoubaineng@gmail.com> wrote:

> DMA_HEAP_IOCTL_ALLOC allocates a dma-buf and installs an fd into the
> caller's fd table via dma_buf_fd() -> fd_install() before
> dma_heap_ioctl() copies the result back to userspace.  If the trailing
> copy_to_user() fails, userspace never learns the fd number, but the
> fd (and the underlying dma-buf reference) are already visible to
> other threads in the same process and are leaked for the lifetime of
> the process.
>=20
> The obvious "close it on the failure path" fix is unsafe: once
> fd_install() has run, another thread can already dup() the fd, send
> it via SCM_RIGHTS, or close() it and let its number be reused, so a
> subsequent close_fd() from the ioctl path can operate on an unrelated
> file.  This was pointed out by Christian K=C3=B6nig on v1 [1].
...

My 2c:

The other option is just to leave it as a 'problem for user space'.
No reasonable program is going to handle the EFAULT return by doing
anything other than exiting.
Even getting an EFAULT is really an indication that the application
is already in a real mess - most likely with a badly corrupted heap.

Anything else leaves error recovery code in the kernel that is pretty
much never executed and open to a variety of bugs.
While the recovery here is probably ok, there are some sockopt calls
where it is all more complicated.

	David
