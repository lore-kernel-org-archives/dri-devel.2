Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D9DCD8C88
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 11:30:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FA6410EA03;
	Sun,  7 Jun 2026 11:30:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HFlpjZBw";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5F0E10EA03
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 11:30:36 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-304da3b4508so333520eec.2
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 04:30:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780831836; cv=none;
 d=google.com; s=arc-20240605;
 b=TjKyZqRVrKhycSAAnX3z1B0WUIC2RtUrq1gWX3Cumgc2gB1tE6A9YBCGgm11o474yr
 jW9nhg8Fn8jblWSZCHdD4PNFOlgk76A2dG1uwl0L5OaOVmInRzS9rPfDeksaVlw73Jmx
 yBwgEknAuKmTsG81z4JWW5qapbgXslldyrsnpHnWV0thWOlGDLfUeYpZdDNRQLQ9nqHp
 QcMuz7th2yrVVPrPirhkdNc7NdDjIzBLhHF9L3uFRNmqZZVv0hUsPv8RANeU3UaV1zOl
 k8bwCPWNJCxiX7GmvrLy7nJmvjJyluLTZUJYmFyRN4sVb2Eky9yJW42AvymkWjq4z/tg
 OhnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MRySgiTWfJabjMicfD7hcpZ6ySYoQUNxJP9qu6eB8rg=;
 fh=LoFs1vewADcReEiyP9Gw6YoAi/ml3p/lZsGvEgdjhr4=;
 b=FzoB8bUaW+yYu5/9oz8jOHkwYhj3GZ6OmKJXht5l43vVKDwUVfU4Xp43IY50zY1fjd
 5wRj4VNenBUrAQBgiLKLr/kWluxxmTDDZiRQSdF2kIfj5TpecpMijV+vfTgAETE4QgON
 u0usm6KN5RvoksgW5qCIMYNIlWVT8zue8MFvfVrxvAuGdnGPx2sC24jI/b0hsuFm/V+f
 GPcCe2zvUZ50Uy9tC2PBzEEtDf5ZIzglh7mbxa+lamCFrg6a2WjTmFGLPhanKbckTTew
 k/G8GZJjvDD5dU4ZcMUccOFDQgk34UuX1+QnNDXlFMOLVOBSPemY1NWxKqZjwQnHWjkd
 GAxA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780831836; x=1781436636; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRySgiTWfJabjMicfD7hcpZ6ySYoQUNxJP9qu6eB8rg=;
 b=HFlpjZBw+LOuUjkBNakhpu3NxLGY4quUpInLKDB3Gyv1r5PWCebx9VrFjubtn9HaCU
 qpBFZJJ3ZBAqbMM+lQMrzbMGbQRMg32FtAolL0IBuFnRSSPl69CD91vn/43p+pLw89p9
 s7iqrv15ZdD8QWcvQl1myrs7M44Ck/Lw8pRwKfu9E0pS4oZ2wy+i1IAyqF8znX+q+kPi
 z7koqDtNI0wBXgl/ePvOkmfC29U0q3KaDciV7OqPFU6ra7LawfIkdSJb9qRUrym3bJxl
 GnTKZDLtSNXkgmjPehDMibStoGemigH5rX6UVppaW9fnPpdEo7AbUymR7gkDRlX7H8FH
 j91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780831836; x=1781436636;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MRySgiTWfJabjMicfD7hcpZ6ySYoQUNxJP9qu6eB8rg=;
 b=DdTshG5aTDz0G6FD10RQfEduQSlkLK9vTZixv+giWbau7yEcD1bmOVJxEXRwc95v1g
 87ihT0LVjVBDmVw3KclrdQvKwFcBjxokSXM/bGDoG2MBI5q23mNV0rM9dQrR6JdmX/8v
 bPKHR4CpRdmTRl6SjHPwW9nRybi6yVHdiXBpgfHomV3sGNMov/jHzcPy6XpW7NnyviAC
 Wk6sAH4WachcJFHjniWb9x4Z5ZCCtGJLtvUqXqAb6MH5EgqN/ptYgGDqtnTvBXrd8OzN
 SwDPvB3368rWSiPSV4AQSWPqAg/NxpGMDoMgc4OaXeGrAIO0+37fmgc02in4yoUdoKSO
 Txyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+sFtl+VcZrbnJsif6/CqbZzITUFHzu0fmWPoOHRv7UX/HUTOHgTskhIKT9073pnmcZ8utyJSKUz7g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8kWLUTCw2aYP/Ey8x/MtKnHU48wleVeUhabMbCdNK9f7ukwpz
 9Ee7YfhtFCWsBdshugRgMLmKfXVs2U8Wn9Oomj1CSkXobMxIoEX7OgMvBzW7PjgAtpgpnSRK9DQ
 jsGCUKq5p86mh1RYTS6c8lRfinUwklbU=
X-Gm-Gg: Acq92OEurfBGpUX4lir4mWInbw6AF6IuhpQCv/HJdgZamBu7P9JbUcCT4XPob+HTCuL
 3uNkHgxr2f0jBHwfLw+dhRHCIej1OKjDkPJ53L6dZli4p16kxWhCqfmevcbLMjCfuoVB12k4fqZ
 RP1tksSHQKSEjSJO6bpiI2Xiqqm2Pn9a6WdojDqkNwlHLT7cjK53OgTjSd5HZ+kjgDmUUPr5rFV
 HLB1pn/GzQevyubul76Im/IgjmH0oweqxxZGlb6D5gXbimClqShuzp1k1r0J2NYShGSkiaG6PTJ
 Gf5Hz/NVD3vBrAujfCbMWlpikJghEyuhuSWCIjUrnOIFIttT9on6TnKO+tyecB3Fu9pN0mnZ5Hx
 CXxym+VmNRA8MSBG//cnknRvhLVqqd9GvQA==
X-Received: by 2002:a05:7300:5723:b0:2ea:5057:a320 with SMTP id
 5a478bee46e88-3077af4a612mr2921241eec.2.1780831835929; Sun, 07 Jun 2026
 04:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260604192740.659240-1-lyude@redhat.com>
 <DJ2G8D0N6EK7.2PDDSC28O8K4P@nvidia.com>
In-Reply-To: <DJ2G8D0N6EK7.2PDDSC28O8K4P@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 7 Jun 2026 13:30:23 +0200
X-Gm-Features: AVVi8CdeC5gDKTC7duruJvRpgjli4FYxW2S1H8-VJsB3l-jVir5nc-87EthTwdQ
Message-ID: <CANiq72==HqQnNdemJOrDwP6dCzz1KBs977MmgjLbssDstAG-Sg@mail.gmail.com>
Subject: Re: [PATCH v18 0/4] Rust bindings for gem shmem
To: Alexandre Courbot <acourbot@nvidia.com>, Danilo Krummrich <dakr@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 driver-core@lists.linux.dev, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>, 
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org, 
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 linaro-mm-sig@lists.linaro.org, Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, 
 Asahi Lina <lina+kernel@asahilina.net>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Sun, Jun 7, 2026 at 4:08=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
> This is fixed by [1]. Maybe we should merge that one patch separately
> and before the rest? I seem to be seeing these long symbol problems more
> often recently.
>
> [1] https://lore.kernel.org/all/20260605-nova-exports-v4-1-e948c287407c@n=
vidia.com/

I can take that one via `rust-next` unless someone shouts -- Ack's apprecia=
ted.

Cheers,
Miguel
