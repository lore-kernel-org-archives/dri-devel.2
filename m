Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B67DFF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 11:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66E9E10E309;
	Tue, 28 Apr 2026 11:19:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="BInQF80x";
	dkim-atps=neutral
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6C0910EB0D
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:19:54 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-38ea6a5a0b3so111683411fa.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 04:19:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777375193; cv=none;
 d=google.com; s=arc-20240605;
 b=QIiTCuOAtzh740TGFgP4mVdktnreYuKqu7zP/OyETX7blj+F+rc3hnsz6HuMbsJOGF
 M871mGBcaTc5Ns5w0mM83PmY5h4RfSNNNp8FEhe4MdHVdVNybdXSV0Z2k5QSLLEYdAKu
 ePEd8b5JE2lf1slKEBa9LbpyhbQDdJuJXBRHRVgalZONMQWxj7qXxOVl0oknW9lNoJRZ
 kT4VwJuvloa9Qby/2iK+s/XUPUKwdWd1wD8FHGc9USeIn5qH0d2gh18k6xoOZ6ZHinUZ
 opubm30ZfZ1djKLbOh0UYY0dOug3OHNdR0WPfKJrO0g/9f1HcPgecaNuBZQzGqa5z5sD
 K74A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+IRUtpTE2jLvhfuGmxg8F5bJAJ6d1P40MueucPpzBxk=;
 fh=gc768b3i4vmG/AWZ18mvHkReJYXQv+r/LVXCFXbynb0=;
 b=cdGCGyZDonstuth9N0dQuCQakmk5TewbYDXhIa/r/+RjLShMeDWJ3iy2HYmtZmclgP
 2Hp5hwnRAsCALr4PO9tcHzl6JpQ5Lu3eR2xMQwhF9IvSyd/h29B2IxJsx4+j/qDE92lT
 qg1JC87Sf429uDRYFOx0nNM/H6v5yRD5DqyvivX9fhZS1Z5ku7IkhbSNbosIUxkwyXUC
 zh9Vu3usFI8BGv56SUbS1E4frwVEoxyS8PAUvJqEGhDrQOuazLCSIrf2BZWI/BTreSBK
 jOLYyAf2UWw/9fMABCyE6C88CxEHUzVbKrQvv7ERZpeJu8oFBT+SnU/oHdY90gj3PhAh
 EANw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777375193; x=1777979993; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+IRUtpTE2jLvhfuGmxg8F5bJAJ6d1P40MueucPpzBxk=;
 b=BInQF80xHc+ro2wnFhkh6tHWVwOiNwSmYlOiOdbUmrxVvYPQG3QylfZlzh1bl0MfIF
 P/CHpjdc3MAyMTrBjTkM8Sqc+tTTHEmv12Uq9M7hBZFsD/jCbbjr9rQ4lGLw6TTh4huB
 yqFgI/IQMO8nClJl/5E+qtd4JjBezY/Jhlznl4e3MHG+Kc2TUo3s9EvzHFnhXaP0Bcjs
 nirOaLvutxq+vrR1FUMeatlIMGT7O876RMYdL465HIXwZMouyG452yYfJl2jlg5ARuVm
 uWCWgIdQlnze5UuJcpoupZr1Bb+dW73R/ro+OQIzVJ2J4yXWHIhM475TPd5WGZqAb5sC
 Ynig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777375193; x=1777979993;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+IRUtpTE2jLvhfuGmxg8F5bJAJ6d1P40MueucPpzBxk=;
 b=ZDkYk1BKtiqRrffCUlMeLobVxQxDYhelS7ebHBQM5A7bK7O+S5KsChtN/l1SYrVLpG
 KCBVAr8vUBl7vLrCFrtTmTJppDYoAHhZEM8jTHGNvJQllxEtXK3IiN1oFKiP41L6aBho
 CSlWUOSHgQYkotaZX6s3NVCmfn/25f5M+6IZuqxTjggrRBLRSPqcDlMDyxc+6TcP4ZdY
 9LDvE38BgoOBlpDSKQGbbBMmhRIwGPQh0E266akWuhipQsujkMy8EuB6Dp8NGp1vWv7Z
 caOixqsw0b0AeQPfIjBrhAuLFMYZJfP0fqW9S9FRCdiNVN0UmCHKld4PVd3CtX9B9ufd
 5wUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ZaE35tkMFjFx11cYduNdydR/lxXly01EU0w57qOVFvci4qi1DhstIDUEXNNP+6Q2F22f9elFv8dQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx4H79Etb09lMBk44ylhfPIIO6Z/B5MvsrpKE2Fw3ky8Ui85+RG
 bc9kfhkuIEO4jOBYAYfqUeY8G0dpdrT+MjjGE4+NDppXHcYCeflkrVTaVPf83mcPFWWteYzSfz5
 yGrX++rIvOHcVy4sFFy4rqV0aIv1Qu27aZhYyEMwwtQ==
X-Gm-Gg: AeBDievjNQlDlcbX/lebCwSZyMkqUmglSOGJmF2RYNQYJSbSni1Bkhi9RFFlaZs9EJ9
 Qu1EvJoevsre9z9lMSn/R0ZTJU7aztTy6Mvd9tn/r/e3Mbgxnk/jleKgDgvIh0LraryBQFm0JjD
 NyKKn+W/2fUAIhv8nas+tTrTlwmtxyuRluKFB/kswTYvOlAo1Pfw61qd6r7GdExt/92V3wLHJ7E
 qXnqRhANyNa8HfN9ZQ/RjmdlBdY5xGkX4sLTNKnIo3XOPHI3IFsHGPU3QLIF9Tf5NljKkYj+3Sb
 lEbcD2hSiJCtI6tde/J91tpDYMsuKp7dL8M3BtiNBD2pXHcHpkc=
X-Received: by 2002:a05:6512:a96:b0:5a4:61a:689d with SMTP id
 2adb3069b0e04-5a74661a267mr923326e87.41.1777375192783; Tue, 28 Apr 2026
 04:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20251031102020.95349-1-marco.crivellari@suse.com>
 <20260428105916.6108-1-dakr@kernel.org>
In-Reply-To: <20260428105916.6108-1-dakr@kernel.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 28 Apr 2026 13:19:41 +0200
X-Gm-Features: AVHnY4KwH8Y43d3g_jTF2J2S58XepR3U72Zf5vI5bw3Cr0gZhKgvpqnDIKMtYxo
Message-ID: <CAAofZF7QuYZOQEiOdU7FEP4+-WngGMCt3svQhMXaiF77J7dkJg@mail.gmail.com>
Subject: Re: [PATCH 0/2] replaced old wq name,
 added WQ_PERCPU to alloc_workqueue
To: Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Lyude Paul <lyude@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
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

On Tue, Apr 28, 2026 at 12:59=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> On Fri, 31 Oct 2025 11:20:18 +0100, Marco Crivellari wrote:
> > [PATCH 0/2] replaced old wq name, added WQ_PERCPU to alloc_workqueue
>
> Applied, thanks!
>
>   Branch: drm-misc-next
>   Tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git
>
> [1/2] drm/nouveau: replace use of system_unbound_wq with system_dfl_wq
>       commit: ef1b53284175
> [2/2] drm/nouveau: WQ_PERCPU added to alloc_workqueue users
>       commit: c82a16b0caac

Many thanks!

--=20

Marco Crivellari

SUSE Labs
