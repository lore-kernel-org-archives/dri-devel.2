Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7538BFF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 17:29:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3D28891E1;
	Mon, 27 Apr 2026 17:29:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="PqrH+zq1";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDABD891E1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 17:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777310975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KF7u6ZoNxfK3+BpCCoO5erH9nqzrz/OiFIJaWAx89LM=;
 b=PqrH+zq11Ei/swCxgFCEzYfc+FAYkYyenOijqDTIjqPIaqVOkswyxWkiaBkuGP3aRQSOcL
 4IotGw+ftxFz0iQ0vc82A206sb5E8s8PvVG98orQmwyWt0pSBdBMQgmvm70ehcqKZY4KkO
 R1ZjCRBW0MorYG6mRDa9V0wwA2X6pi8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-S1YJHXg0O7SLLWWYnemcPQ-1; Mon, 27 Apr 2026 13:29:34 -0400
X-MC-Unique: S1YJHXg0O7SLLWWYnemcPQ-1
X-Mimecast-MFC-AGG-ID: S1YJHXg0O7SLLWWYnemcPQ_1777310974
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50da529ff48so45830511cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 10:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777310974; x=1777915774;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KF7u6ZoNxfK3+BpCCoO5erH9nqzrz/OiFIJaWAx89LM=;
 b=LnnfuiTp1gnU2jlZSuBmRrzMvy2Di7FAZv+QUV6n4DXI4nmsDEVl4sflADDvSePY6X
 3ySbG8pIK6MoscmOBrtwApopFbjKvwkdn9PQpvYlBajqD5stqUNkFocRSzCukI4rFRiK
 I4jVh6ASx5LTTm6XlO9mn5ZCyLxmsBVypA+pUbof7/aVbenp+a7y8bJ9pa2SzkO3iWH1
 8qFOFXpFG17Tcs5iH9NBpKzBOsQku/ORA+wTIQaYsfoqyNvSlRyw/HzvEEIEX71pun/D
 Rodk03gWymzze4i3bQ+Bo8DOeRaOJZm6t5BjqDwfKfyGpAJUB5Z4jGZ7LVHKiAVwxYY6
 i++A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8rjgpE0ccTcycyli8cYdycBebXwzD1t4dZK2vr3p7ZL+bP1G1gtV9n2GuJzYQl/atuWytUH/wR9wE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYHnCGawOEFXmWXif9tTGpgXFZgMR/feR9uVmn5qK6u6GdcvD3
 LrS0BPyWNC7UwHQluOcbUmUziX6i3nnw7xu906iNdmo8ecsg3+f7YjM0wEBgFsOQyFHp2xpEyMx
 ABug8yV/ftnOPznJwQBdRdnzkDvPG0a+rq2qLgxCibddTqI5dPuR8SoqrxDfACBPLoyzEeg==
X-Gm-Gg: AeBDietoGep6UMhfr+3ovL/bLNtYDoKx7WyZPq6JHOsiSpH4sSfonEmuZIc77FyhjyW
 XbZAc3yOT6/aEW6BlD1Z3crycyFbrtJzouPdXApuy+c9KsfaBExxQyeOD6wzDmJeKusEqe2T+o3
 80YmrodK0jjC3pmgqf/4Ql1k4aQOIVUYIH5kcKl8inTnqdPcAEIP7L6tN0MF4GI9E18QBXiTN3P
 2ofcWUExpfQJN3JkyiwlL5EFjLHm3zuaBuWP9okHeIK1AC8n7ihQXRbN0ISvaKyEQo+2CzhgN0o
 LG2oncdfG4hNoSVC2oJCElRa4KCr+kZGFhIeDDTcc6Z1WqaE6UcBF2q0UY8cpkjnPMaL3ysbENc
 HG7Fmt5dMmP0KqIf5eojhJCRZ+aWo
X-Received: by 2002:a05:622a:486:b0:509:1009:e7a6 with SMTP id
 d75a77b69052e-5100c97933emr2571341cf.43.1777310973867; 
 Mon, 27 Apr 2026 10:29:33 -0700 (PDT)
X-Received: by 2002:a05:622a:486:b0:509:1009:e7a6 with SMTP id
 d75a77b69052e-5100c97933emr2570391cf.43.1777310973161; 
 Mon, 27 Apr 2026 10:29:33 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3e29932fasm285886d6.45.2026.04.27.10.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 10:29:32 -0700 (PDT)
Message-ID: <2f8a8b96473d99cee6f33075532a97f956ce21bc.camel@redhat.com>
Subject: Re: [PATCH v12 5/5] rust: drm: gem: Add vmap functions to shmem
 bindings
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
Date: Mon, 27 Apr 2026 13:29:31 -0400
In-Reply-To: <DI0MII8J4P2Y.309VKYVMQJNVK@nvidia.com>
References: <20260421235346.672794-1-lyude@redhat.com>
 <20260421235346.672794-6-lyude@redhat.com>
 <DI0MII8J4P2Y.309VKYVMQJNVK@nvidia.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: goqKgs4RrfUOcJzOuu8ejC5jBBGGZARv2CH4Ap5Y698_1777310974
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
> > =C2=A0=C2=A0 dropped before obj.
>=20
> I am not sure this is enough to solve the double-free issue -
> although my GEM
> knowledge is lacking, so please take this with a grain of salt.
>=20
> Take an object where we called `sg_table`, so the SGT has been
> created.
>=20
> When the object is dropped by DRM, `free_callback` is first called.
> It
> calls `drm_gem_shmem_release`, which frees the SGT.
>=20
> Then, the `Drop` implementation of `Object` is called, and `sgt_res`
> is
> dropped... which attempts to free the SGT again.
>=20
> I haven't tested that and rely only on a quick look at the code and
> my
> partial understanding, but the correct fix appears to be to clearing
> `sgt_res` in `free_callback`.

Whoops! No you're right, and so is Deborah (she mentioned this
previously, but when reading through it I completely forgot that
free_callback() was in the picture). We can't clear SetOnce, but we can
use mem::take() which should be essentially the same thing. Will fix in
the next respin

