Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB43AFED3F2
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 18:13:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E803510E0A2;
	Fri, 24 Apr 2026 18:13:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="flTNSQDk";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 084CF10E0A2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 18:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777054433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OeQosteTdD6VM7jZXWeJNravgroMD7pnnDdWYomsqZs=;
 b=flTNSQDk4iGEkK+XzM5UOP44uM8sB70PtTTtL0NOai7cYIce116BgAbxlWnAZaz4SfXOST
 JgQlSNpXslPqR2G0CB20PJ71GQkumZyfdS7+nI/nSj7Zec8rb9j1kj7eHzy7rDyEBujvOK
 EfJJ1LvxCauF/5jS8j2btPg4YJ6mZOg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-o6oE-jT3PaGFSuXcEOAYIw-1; Fri, 24 Apr 2026 14:13:51 -0400
X-MC-Unique: o6oE-jT3PaGFSuXcEOAYIw-1
X-Mimecast-MFC-AGG-ID: o6oE-jT3PaGFSuXcEOAYIw_1777054431
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8a5f6110cadso191227666d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 11:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777054431; x=1777659231;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OeQosteTdD6VM7jZXWeJNravgroMD7pnnDdWYomsqZs=;
 b=Pd3SbT2bm4Tmke9J8HGFJfd6BhwTKzoOiAPF3RcVcnwn1D2PySaKHm1rxEh17/H5nE
 MrhRBrW1yMxSvs9+efAjtV4tAm+drsUEfWOQpoHE96i3766+IwwEoBr5m5M2qQpGWphW
 BeOOVsW03hMTOw2bBLSghz6NN/GNWiQVOSYzgh5/GL9DStGhLBNsGeifQ7vH7IZYMmWR
 MsZHYfJM07soLYcxMYHgKbiTYuL/hiDoLjha/Dq6IrFDjasuOkCvki4E7ASNjYri2V8y
 yFLWXL2IO6mTVVEwIdQb6rxiwSbC6pggMRYcmidalZjTovK0I2YkSrVBA2XuFZJc/tr/
 ZdvQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8F/BuuhpPCjUFY7n6y4RF2kFSMIgaxX4f8DKBC7ezNYwy3pAVa6yIw4q9VHanRgRcsDect+bYjGqI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxkQ29EY/o+vznbHO/k+YIwpqE0YAVrNAfKCBbO1Jk05vjHtQ0
 XmVYvvD7bXJRxiYPNZHaXOCq2GcAf6CmHw+FL0j5h19AwIb9l037zVGWWU6mGuHFo4YKBQMVZSA
 /LLWP3AtsAIpPd1nEM7AkZ09VZ9l0a2FYKfUKXMpdOfOdx3FuXU7kqCpwEbLRWZ4Xh8Tm5Q==
X-Gm-Gg: AeBDiet7gk33VZUArOm99ojYCUXEdtr24GLls5ITbQ8P6UKtsqPegANjHp9KrjiB1Ep
 KiiC7qzCRn4yYREojMZVmll0wqKHffmGhoVbQS2hkGDqKAB3MChVFGCZ8Eu8AkNHVxjilrvIoER
 3p9bH5ycZQWHMMnsfalWIH7DfzdyWlAEk+LEEYZHVRJ2blKaMlNPGl7GAzJ8igedUiKszBNxWxK
 FS07nsAp8lG8ZLiUJwOA2ve8t3tM+MLeuzNEPANgHfwEs9p9YhGE8pR8/puiBNPIlSqK/en/v85
 tJaWw47tCczfSYlQBQS5VDQNagunc/AA4FAh9sCTuP/t2FhbjOuSM1d5cKDQiIVuTI4YW2R5MFW
 HjgS4U6iq9wkax7Y3R4XMaY21/HJe
X-Received: by 2002:a05:6214:27c2:b0:8ac:ab30:fffa with SMTP id
 6a1803df08f44-8b03addd7bdmr442488156d6.32.1777054431181; 
 Fri, 24 Apr 2026 11:13:51 -0700 (PDT)
X-Received: by 2002:a05:6214:27c2:b0:8ac:ab30:fffa with SMTP id
 6a1803df08f44-8b03addd7bdmr442487526d6.32.1777054430667; 
 Fri, 24 Apr 2026 11:13:50 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae86947sm253378776d6.37.2026.04.24.11.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 11:13:50 -0700 (PDT)
Message-ID: <4bccf3d1ab49dfdff29a69b2040c4d0aef0e87e3.camel@redhat.com>
Subject: Re: [PATCH v12 4/5] rust: drm: gem: Introduce shmem::SGTable
From: lyude@redhat.com
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: nouveau@lists.freedesktop.org, Gary Guo <gary@garyguo.net>, Daniel
 Almeida	 <daniel.almeida@collabora.com>, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 Matthew Maurer <mmaurer@google.com>,  FUJITA Tomonori
 <fujita.tomonori@gmail.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 christian.koenig@amd.com, Asahi Lina <lina@asahilina.net>, Miguel Ojeda	
 <ojeda@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Simona Vetter
 <simona@ffwll.ch>, Alice Ryhl <aliceryhl@google.com>, Boqun Feng	
 <boqun@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Krishna Ketan
 Rai	 <prafulrai522@gmail.com>, linux-media@vger.kernel.org, Shankari Anand	
 <shankari.ak0208@gmail.com>, David Airlie <airlied@gmail.com>, Benno Lossin
 <lossin@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 linaro-mm-sig@lists.linaro.org, Asahi Lina <lina+kernel@asahilina.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@vger.kernel.org
Date: Fri, 24 Apr 2026 14:13:49 -0400
In-Reply-To: <DI0MI6UF325Y.2TDWZGCN3WGIG@nvidia.com>
References: <20260421235346.672794-1-lyude@redhat.com>
 <20260421235346.672794-5-lyude@redhat.com>
 <DI0MI6UF325Y.2TDWZGCN3WGIG@nvidia.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Bs0yOM0ta9KpapPRh7i1HDOdoLCqNXRdeKcp1AZw7t0_1777054431
X-Mimecast-Originator: redhat.com
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

On Fri, 2026-04-24 at 00:01 +0900, Alexandre Courbot wrote:
>=20
> This fails on master:
>=20
> =C2=A0=C2=A0=C2=A0 error[E0432]: unresolved import `crate::sync::ARef`
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --> ../rust/kernel/drm/gem/shmem.rs:36:5
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> =C2=A0=C2=A0=C2=A0 36 |=C2=A0=C2=A0=C2=A0=C2=A0 sync::ARef,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^ no `A=
Ref` in `sync`
>=20
> Importing `sync::aref::ARef` seems to be the correct way now.

FWIW: as I mentioned in the cover letter, this series applies against
drm-rust-next - not master.

