Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F95FF885A
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 23:10:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91A9510E083;
	Fri, 24 Apr 2026 23:10:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Ox57Ghba";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24DBB10E083
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 23:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777072220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N09YNoupJhmv1sapC/t38hsbn3OUvdSVBkUzd+3dwtM=;
 b=Ox57Ghbaimk+jQcGIkzcbqK9WJL9ntd5Lp4/lyP9TvlWgzx0/4F+gci2Co4byOQAYVLcwF
 95KiuMrTV9rR0XaCOM1dP7xJiREMV6d/0rhDfO1OWkHzSlDpOrsGGU3b50bFPGvgZeTrlM
 j9qYAH6xmou+rfPEICFo7OratmFYSxc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-BRX_bQQnPnu0lUH62cT9KQ-1; Fri, 24 Apr 2026 19:10:18 -0400
X-MC-Unique: BRX_bQQnPnu0lUH62cT9KQ-1
X-Mimecast-MFC-AGG-ID: BRX_bQQnPnu0lUH62cT9KQ_1777072218
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8d5b5d607d1so1681188285a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 16:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777072218; x=1777677018;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N09YNoupJhmv1sapC/t38hsbn3OUvdSVBkUzd+3dwtM=;
 b=pspGbe50eoK03lYMx5MEXr5+pE4Unbp16mRe5U0MbnEhme/ngA2pPTozGX3YK8RjGs
 ZpSiIVDsEsh4m2/70z1cjzHvtdozJCSgS7vhKK+iy2YD1Hz7sZUWfqFewgoJprXtTD2j
 3Ac9uwjw9GajdHsGBu3BDgTp2eZQLkSHVEqGNmUgx77rnW7kUmH555WLzMgF4xx7L0gg
 +OTi0vJHOtRqH7mDV1KUJadTqOVyRYtcTJ9gj7InPADeJ3Levd9HeOqRjDHtww0sPV5h
 nPfF8CakSp8+EEVCjoX2/dgdvU91xeu4zw8QGMfIO+dYHreTL4S91dY+mhxpqmLXbKdz
 I35A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8mFCAby4Q0Ln4IAnr2+90W8aM3gKraXHWrKxfD6tNe6XO9xHFycsz4nyfb9J4I5vfW4fmELReBR1A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYCl2sGX2tlPcjvbkWY7W0tc1PTWlDb7qPQQbrBGKKdwcqUsSD
 2Q/2WydjN6H2SYhABk50XOppj+XeZI39AhC/dZ5/mMSUKKiEJCamsWSV1FciOl1PpWRQo3c4o2K
 auH8CeJYv64L7dljbrFlzsVLMxe5iaqihZLCxVL38vpuEyKfe7GpmfMZWzjx+0pP8QVpbyQ==
X-Gm-Gg: AeBDieuw2AHi5p/cV+EbZ7hBzYEbcMUhji/oPFwdVi6IDFVIe+/FE8Au/zKm3Ret6uB
 SZ276wVgod+1/WmOW1iK7HfGKg1hIQ5wY5Ns4j6EKQTrfTuSukayNonLWtUy8xaxp0TlwQaoOGW
 fV09W59rC9HpCKYyo6NJZC2B3dSvVKkvj9QcaBCqgGEXEN35SgqDXajRKhV6BNnimugYVxMs0ff
 FdCRKleCPoHuTJzW4DLfSKopiAabf/MUBqi6AOxXI5/YYn+UDBFbWWZdY89eIyv5PARKuoeT8YJ
 XU/Htfiytjf7GDf/jpOB8Fg3TpoUmDNzV8RHy0eb+08X1uHGlU4QDFaNSfkycQ7PvTrGtu30PNG
 /7rhljSGCamqvyuS0iaE22ojfxdSV
X-Received: by 2002:a05:620a:f0b:b0:8eb:cbf8:85e7 with SMTP id
 af79cd13be357-8ebcbf89261mr3123560985a.34.1777072217923; 
 Fri, 24 Apr 2026 16:10:17 -0700 (PDT)
X-Received: by 2002:a05:620a:f0b:b0:8eb:cbf8:85e7 with SMTP id
 af79cd13be357-8ebcbf89261mr3123553685a.34.1777072217335; 
 Fri, 24 Apr 2026 16:10:17 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d69ad48asm1913863785a.19.2026.04.24.16.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 16:10:16 -0700 (PDT)
Message-ID: <ed26658c461020547e058b237575324adcbaca59.camel@redhat.com>
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
Date: Fri, 24 Apr 2026 19:10:14 -0400
In-Reply-To: <DI0MI6UF325Y.2TDWZGCN3WGIG@nvidia.com>
References: <20260421235346.672794-1-lyude@redhat.com>
 <20260421235346.672794-5-lyude@redhat.com>
 <DI0MI6UF325Y.2TDWZGCN3WGIG@nvidia.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k8uf__5Anq1ZOK3Ic0hHC27kcBVUYk7wJz4cHRBd2YE_1777072218
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
> There are 4 sites where we acquire and release the DMA resv lock,
> each
> of which require unsafe blocks and carrying the risk that we forget
> releasing the lock in the end. For this method in particular we need
> to
> jump through hoops a bit and store the return value into a temporary
> variable so we can unlock the DMA reservation.
>=20
> Let's do ourselves a favor and implement a small, private guard type:
>=20
> =C2=A0=C2=A0=C2=A0 struct DmaResvGuard<'a, T: DriverObject>(&'a Object<T>=
);
>=20
> =C2=A0=C2=A0=C2=A0 impl<'a, T: DriverObject> DmaResvGuard<'a, T> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn new(object: &'a Object<T>) =
-> Self {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAF=
ETY: This lock is initialized throughout the
> lifetime of `object`
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe=
 { bindings::dma_resv_lock(object.raw_dma_resv(),
> ptr::null_mut()) };
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Self(o=
bject)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0 impl<'a, T> Drop for DmaResvGuard<'a, T>
> =C2=A0=C2=A0=C2=A0 where
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T: DriverObject,
> =C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn drop(&mut self) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAF=
ETY: We are releasing the lock grabbed during the
> creation of this object.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe=
 { bindings::dma_resv_unlock(self.0.raw_dma_resv())
> };
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0 }
>=20
> There here you would just do
>=20
> =C2=A0=C2=A0=C2=A0 let _dma_resv =3D DmaResvGuard::new(self);

I thought of doing this but lost track of how many times I was actually
grabbing this lock=E2=80=A6
BTW - want me to just give you authorship on the patch for adding
DmaResvGuard? Since on my branch I've pretty much only just added two
inline annotations, it's otherwise identical to what you wrote here.

