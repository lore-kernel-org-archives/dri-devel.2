Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6A2CD3424
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 14:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C5BF10F54D;
	Fri,  1 May 2026 14:05:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="dqCno/lC";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF9CE10F54D
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 14:05:56 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-43d73422431so1660128f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 07:05:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777644355; cv=none;
 d=google.com; s=arc-20240605;
 b=JY2GCHyH1nrEEddlxHwDnbYqwqjbIPloFKGt5H62l9YyU39D4RYco6CFuklb5BdUiG
 7NgvWK3QhAnlT2/JfXpFXeGQCZsTzdsZkD1DM3oAHZX7IR2I1a11+sHeImxD2Y6ZNxQ8
 InT8JNlXTBIKmxZz5KEORnc0Dd7q0BkRu0qAknxi6CRtMiVECzsGc7+Gw/Np3c9duM15
 zcLvqrcqHDErrHb5iIr6B7yX7FpcvSHLLo67oal8JC5kGTH/+2z391vnzs23rIbFqA1U
 gBo/BsI0sumuDIrp4rNRL75wCX7au2NXhOFasDYdbVKK2dYbt21Y8jr7LM1tKyDgExFA
 HCdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NP4+SywKrS+AL+u+d9g+gGa1xGNuBC/F08SK3PJVlls=;
 fh=kVYS01mQJhfZicuYnhtk3CxE8IA/raX/EKuSdo1o5Zs=;
 b=lqV1ayovpW40nOXMpbLWMoMbb4VubnPgONkLiJw8dItfk+khT0IhqQZd6YIripcgwy
 2VtkDrDaEKdOCuXiAmwJR2taInZ4uR6nYb/2pHXKInEtYbYgZVCTBtN2FXe88mkv9YN4
 wEEHSSpmz6HILmdBpj7gass7OGiHK6QwbihGyTvot/ZlbU49AIhvPnZlEZuN77liFn/r
 i6dVDo7SUCQteP0RPkzt1snwvpGXu7qnEf/ShL3q+J3pF0j55lACf8gwE2DWAIzpilCA
 D5ohsIDdINGAZSoSWjcbSkXAZbrVPkF4e8/DYlvz7Qe4us14tEMu9/jM6nxQjNHb+6PK
 7v0w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777644355; x=1778249155;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NP4+SywKrS+AL+u+d9g+gGa1xGNuBC/F08SK3PJVlls=;
 b=dqCno/lC1e3fTmJJuClYCUhIWXR+eSlJXgT6WYlx1w4/eCfrT25wIm2gbM5z/Y6adb
 hXPasn/ZBdFJkbh4tYdX/hvwJVJMbpk7EWzd4/8aefWCUXdrh7464LgTDu1xADb+5Sx7
 ilAB5cfkW48pv//pEaGLLzY4IUfty8wKmnAjCKOLoXJCjqkjWyelziesac2iS5h2Rcc4
 TIi/lnUmW2QhXY/9YQ59I1DMg6w/hkTpWoTsIPDb7huxPlSW5dN0pJNEdkqi7eYT/wwE
 OQK15sd10VNWxvUBhMFheUmBezhGmHZ+LQtUcuoxb44+CrgZU57GRxIMLBioGKUsoCzy
 Hd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777644355; x=1778249155;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NP4+SywKrS+AL+u+d9g+gGa1xGNuBC/F08SK3PJVlls=;
 b=Nt0dHvYv6+KOAUaYJpGdtillSmfrvJxk8IG5cfID5UyyxdAbUtOY8bImyH5WzadQg1
 jUtUmvqNWtdnx+Q2no5O/zZK8XveHmCltUECsqBgihcwBfaxaglS1SP74b1pMMhZk62Y
 4fVYgcuzwqirDgt4hDpkbuAbM8QKhJxQhKVD2PUGUkRUA3uM7ZaFBd+GPQ85TVu/Ii4A
 BYiG2x3a9NbGY+1pFkTQdXWerVloLvqleeIjmXYacZnJeY3Rmocgj5B2/GiXh0zaSKvO
 OxXQKxZxNT1aOtMtbF7R8QbNbyeUnLvo9UWtWAysBV/7k5uFNSWxdza576CyFiSJcAJG
 a2fg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9SH2A/xUKb1huFfyYgArMm9b0HtjbgQCHvOFQfjDTDuT1s0zpqSmoS9jYKC+NifjOBJ17O5KEFZk4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxrhlkix1Tnyo9uk4G0SXYQ/7R1t7BZmLHxS06UdBJR/8F0NqbO
 AdmpzZT6AechDHmOF1YY6morT3Wj2ygYbrTM5srhRX+Q0lcu96VR+l/QcNPxO/teLMWuJW9vA4c
 0hJW2/wUfRE2quXNEOV6TfxOz1bM+9aMm54NxQSvi
X-Gm-Gg: AeBDietml173IYnDbENC3YTSBzaTqjuZBdWABNjYBK6hvHZJtXBi07+oUid7QrgW24d
 oPXMF8+ZVN2pfssZOyGWm8ZthWYvvTqq3lK31Tg9leogF45SnvT0jiVM1nKclHoyvDzoR9rgbFJ
 1/6spUC5SNfL737PC4f3+K/J7UJkT0MhzFlCmSWvW466uuvloU2Q7YipCzJMgaFvHMWMdpbNihQ
 IwUus7zBG2hyajrl7GnPvHyo0SGXOOvks3tcNUSgVwWhZyWy0r4VPiLtwoyhmRvd42QhURyOaM0
 uNCZ7bGjOrqEN+VZE3ZQMk6HmHEaT39w3wl27WclTb3/hEykYjGNfNvaEp/INSVy/ScBXSg5/Cl
 Q7jp7eeJZVXlIXc0=
X-Received: by 2002:a05:6000:2f8a:b0:43c:cf25:f29a with SMTP id
 ffacd0b85a97d-4493cb4316dmr11164229f8f.8.1777644353800; Fri, 01 May 2026
 07:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260423-fix-gem-1-v1-1-e12e35f7bba9@nvidia.com>
In-Reply-To: <20260423-fix-gem-1-v1-1-e12e35f7bba9@nvidia.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 1 May 2026 16:05:41 +0200
X-Gm-Features: AVHnY4JCKmfa5Xur08olcjHreQXWW8CULXPA3kzTIG6tPdAYfFIYgp2iWwOpqE4
Message-ID: <CAH5fLghpvU19Qdkdvf1WD1jXKwvMnogNkxhU8G5q3-OH5v6rGQ@mail.gmail.com>
Subject: Re: [PATCH] rust: drm: gem: clean up GEM state in init failure case
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Alexandre Courbot <acourbot@nvidia.com>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
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

On Thu, Apr 23, 2026 at 2:37=E2=80=AFPM Eliot Courtney <ecourtney@nvidia.co=
m> wrote:
>
> Currently, if `drm_gem_object_init` fails, the object is freed without
> any cleanup. Perform the cleanup in that case.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Tricky stuff. I also concluded that this is correct.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

This is a bugfix, so:

Cc: stable@vger.kernel.org
Fixes: c284d3e42338 ("rust: drm: gem: Add GEM object abstraction")

Alice
