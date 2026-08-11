Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3391BC5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D0E210E387;
	Tue, 11 Aug 2026 20:58:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="fU0+qgYp";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 136C810E387
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 20:58:11 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-c9aea40d799so151224a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 13:58:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786481890; cv=none;
 d=google.com; s=arc-20260327;
 b=dbdOw9xRSbs9AaNJJV6XNQB1S4OyhB2Bc8foaAaP6fH1AAEQdwtwbT11NMHKscSvje
 GwxfFhjFdieQy+ro9j6W41DrQMX9XxzeKQO81cK4FyPqnytKoCYRHqRc5wiWI4GxsKX2
 n6HeNvdOaDI8P9j4Fdzn3KRrRHR3qVKYiZt9DLeKj4y8uSUec46GNyhHTGqOEtAuSALP
 NFEfJKJUYEMxBvazbXrAT6y4/VZ/YoA70AMVsrmy9xWEw4xOGPKVNgS5WzYwDoGgbp3G
 FpPU2SP7FoAyciBYjlvetk5Zmyn2w20uAxzAMfSDdz8btIylDMq+QK9nEYGgee+SJtNq
 4/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2HxJNolFAmmdynxiD24QiH/b/aKUErhnmhqEKLHulNk=;
 fh=I6D4mFu7RnA9dkJdwLhC3sfF5HCNPzrjj14tEGI+zQs=;
 b=gaBKho3qQ2iW6uhSIW1BKw20H6H9xCiVbliZZNsrnAfErRNmHYd2ONOGNoh4ZBx+y+
 rZqMWLGsiEcQi5hzktjGdX/nLOEwq1GdN3srfogtpyAOoQ153s+lDriqaLoNedRqmPrl
 7I59mYkeOm6ie0md7npAlAcjxGeyMT9dmf7+hVI1HWOwCTahh96pm5o6i31TAKs7416T
 nK8QzNRo2CNJRE1Ya6gOeufRkiFrSlQPEHKtUSO5BxD3fq0JEabZGypfKdAMe8IJtf8h
 Gro9UQFS9k0TSTUJf0HvmaDv87vBhbx7GhNy186MlSof0j/o1TMLXIKuMNVznvdnmbT7
 2Xaw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786481890; x=1787086690;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2HxJNolFAmmdynxiD24QiH/b/aKUErhnmhqEKLHulNk=;
 b=fU0+qgYp88LHUcXn9JexqF+Gqig2AAKpdE6nNgSUJyPdSOveeD8CPEUy1ulCB+Cd0r
 O5PBBxPA5016mhN/IN7Rr9j2xb3XJV1HKA54e2FzRp+sgmZugrnfp+3+WModp20EJwju
 dJCDBkE0xBGdq9SFiVle3CkgsSsM9V8L/zGQp9O8HZ6tpl+6OEa3R/G5SouFATcu8ocs
 Jg8VZdqdvFoXULzvx4yrBxLTHD/vlPkeynbBZZ11ZkoX+8SpwG2IW4N5oGdP8u1F6J3E
 4RNDWww6uL5f3iECNuWzxZRM8SVLZr3oWqA3gk6iVd36TZPJb1ZaoS7hgOPqVkpjUFVl
 qhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786481890; x=1787086690;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2HxJNolFAmmdynxiD24QiH/b/aKUErhnmhqEKLHulNk=;
 b=QrVR481eCnCm62DxDh9n51DL4tIcuH8k1E68qE4I5Jgg2W3Nk/Ef4jtIlJkxlOYNSi
 0MCLiVq3abegFGt1UQexuNWz6VkOftfQGJhfyaJ+i5NuQJRxomE0NbwcZbvjmmi1wTAp
 6G+ZxIKz0I5nxPRjB6yXMZQz7payjMWNZctGZbPABH7Y7dIwCL3SwNaHDWSd15bhn7Lw
 qVhx8/bkXSBGSdb+UPqBap50xCy009sD6oR4npeOzAOZdFmtRG2vpeY4nPC8KM4T0Ekw
 glK32jEGtL6vs1NKlS2rBz2KNmTdEQLRPX8W3wwS5qKoU+X28+UUB5mM2Qkz5K/mEiX7
 VmEg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqNk6XianGnMn6TdmcBeDs32Az6hMsqEBjjBX8aymoIFdoYRlDszUj5RGOMKM6jmZwUp6alz4cJWbs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1ngj5Cqul9Mo6+wFBrVSv0xlokkWidjOu4HX0r2bcrqiwwHtq
 NfQbqZcIKbEPEu9KJ+qJ4yin27vIyzHo4053tQHIyEmb6ERRMgzxxjXfPF7Z745IjidRvdQds/q
 2S04x50/MAxPyKLYEXfeXmu25t6Mf58rygCSFqVA=
X-Gm-Gg: AR+sD13C0idYF0cSDKdj9nWscFUDakj8n1+YONlr2zEYlIiclZDVGWDm8nVT7iQ1ZzL
 H+gCo0v/zs/luMDzZ6afFbS0VO1Y6yuvE+0W5JtarmGpDh7QG8gcIBBEYNNeJ9QJLW9/sQluioE
 7903ka6L3CJM2qPYEs77gs/ksVgRcZKtdBF46HPFOo8CxL9jqy04I+Oho8tOPBXThh+7L8JvflA
 9aCEhx2zc+sdAnUXjjNQ6DznCr6VEbjM+BpsE3uk+gCUxZiU0rg9m/pdher5/jjQW14coIp6iUH
 /vU6pV+6RKeGaUaP8+f2aOEPS54akK7tit2Ur1vTKhyjKR3FqPZlydFALDUxB0gSFSZjRIzsdQe
 0zr3/8ZwSHJikleemOh8WdOVyJFbwL4/b1y4/97XDDtOj1kzJoG+UdGJjwnzeIp4sYPmokZ5k
X-Received: by 2002:a05:6a21:6014:b0:3c3:8d4c:6679 with SMTP id
 adf61e73a8af0-3cc2baf91c1mr8926509637.20.1786481889874; Tue, 11 Aug 2026
 13:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260811204123.3198370-1-tjmercier@google.com>
In-Reply-To: <20260811204123.3198370-1-tjmercier@google.com>
From: John Stultz <jstultz@google.com>
Date: Tue, 11 Aug 2026 13:57:57 -0700
X-Gm-Features: AUfX_myHUGWyest017h6R42yiKHyXXmXDv2AxIQm6g3i9kVslMqq8mjeEi_Jdwc
Message-ID: <CANDhNCp8TTQF4j3zCt0EaQYfvB+nGRrM73Q43aQi0jzUG+ormw@mail.gmail.com>
Subject: Re: [PATCH] kselftests: dmabuf-heaps: Open heap device files O_RDONLY
To: "T.J. Mercier" <tjmercier@google.com>
Cc: sumit.semwal@linaro.org, benjamin.gaignard@collabora.com, 
 Brian.Starkey@arm.com, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 christian.koenig@amd.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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

On Tue, Aug 11, 2026 at 1:41=E2=80=AFPM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> Write permissions on the /dev/dma_heap/* device files are not required
> to issue ioctls and allocate dmabufs. Applications should be opening
> these file as O_RDONLY. The BPF dmabuf_iter selftest already does
> this. [1]
>
> Users are pointing to these selftests as examples of how use dmabuf,
> and encountering permission errors on systems where write permissions
> are not available on /dev/dma_heap/*. Apply the principle of least
> privilege to selftests which open dmabuf heaps by removing the write
> access mode and using O_RDONLY for the open() instead.
>
> The same is true for the vgem test using /dev/dri/card.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c?h=3Dv7.1#n49
>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>

Acked-by: John Stultz <jstultz@google.com>

thanks
-john
