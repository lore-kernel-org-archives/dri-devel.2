Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0807BCD98D2
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11B7210F64A;
	Fri, 12 Jun 2026 18:39:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="gJqWBQgO";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0224B10F64A
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781289574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9hjvIQdDCosfn7FQViIiZN3fmJqSK0XtflTNuA4kTRI=;
 b=gJqWBQgO1fNUmJ5E/GXTE7jw1xKsYo76pvJRmcu8r0dBrVhWfyN94F2gZLnzjHI8ItueSm
 iMLSwKXoGt8Ef9nWBOlDbuCtNVhSw852gM6koRIL0dH2xdE4w0Pq9gcxpWnZIHfq+UqEua
 2Ot7szzdZEGCr0eTMOmUSYQjpUMwqic=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-MT3K1DRuOv-xu8rxHzwsQQ-1; Fri, 12 Jun 2026 14:39:32 -0400
X-MC-Unique: MT3K1DRuOv-xu8rxHzwsQQ-1
X-Mimecast-MFC-AGG-ID: MT3K1DRuOv-xu8rxHzwsQQ_1781289572
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-91598af506cso131542485a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 11:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781289572; x=1781894372;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9hjvIQdDCosfn7FQViIiZN3fmJqSK0XtflTNuA4kTRI=;
 b=eYnBRY1LzbimVzjAw5LQir6iRJZweoiKiaGwuwFqvqUzoO7lZm4qa+JlJwqh4MXZiR
 pA+NU40PQab2hwKzOjt7c9Q6s2DP6q2p8pEn8SvgsvQYMAsgNF1mILhHFw0XHy0Rz4z5
 MT/542QnSjR407VRQtIfqGTPMvk3qvIRPt9Uk2cvW20IN5YB5gxsHi4AKhroiIyP0+b8
 XJ8e22ctaBzcR8mZhzCIdOpGTLCi5XjtaY9Igyrp3KZALq10B8DGolza8jAKbaxSKGn3
 aXVwz/p2BvVPEfKFCYiVd3kQFHQSbPMCdqNLK6tP4ONRuYqIMdNAijErJrj2iXXj1Cds
 7bCA==
X-Gm-Message-State: AOJu0YxemhYxCRJ6Poe5B1JUUeHNAxcnqNoS6/5+fRPKGF4k6iTTvscK
 +GTFmsz4NHCWjRbksUm+2COwu4rr+b41XctyW0XBuLtKSngw0K+Dx1FR9rZzolBaEFarRPgXj+V
 0wy/yZqt2BClB31VILF6QwH03zkFoJN5GPpHMHsd7zjgyULWt3kA2+wGK412Xp6v2i6XAIg==
X-Gm-Gg: Acq92OESNlLRNF7HRwdvudfPWiEYextALTu+99NdZLihr+di8nN1iilw3rGAKz2BSxU
 oBFRYS4hv3X+3CagVJLpE302wBtglogI/JUAStT0wh1Mqbnpc8TgSwoqPMq2inLuhBewC0n/oMB
 AiArUpNmF+wWr3Z0zIHic5c+EtJgiiigqbNtIO41s2LILoDuHsyLHNg0kogTdXX1O1nf4BwEEBf
 qgdXMLUgjraFbmGX81mqeCjswUb8R2YLfmATZBUiT3wIqRUaZbTcA2oWtr66Yg/uKhKTZa8vbJ9
 rR0aAP4t9B8yqFp5Le31iokwkHMfodG22h19bIv4rY8EErhp+EiB7aCOKLY4ccP2iKUaP9h/rwO
 Em3JhlootMmUYIphOkQ==
X-Received: by 2002:a05:620a:8012:b0:914:c032:5870 with SMTP id
 af79cd13be357-9161bd604f9mr617287685a.38.1781289571979; 
 Fri, 12 Jun 2026 11:39:31 -0700 (PDT)
X-Received: by 2002:a05:620a:8012:b0:914:c032:5870 with SMTP id
 af79cd13be357-9161bd604f9mr617282985a.38.1781289571521; 
 Fri, 12 Jun 2026 11:39:31 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9161a03d6fcsm272275585a.35.2026.06.12.11.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 11:39:30 -0700 (PDT)
Message-ID: <da0dd5cf287f8739d6b099646b3fb98153670f3b.camel@redhat.com>
Subject: Re: [Linaro-mm-sig] Re: [PATCH v20 2/4] rust: drm: gem: shmem: Add
 vmap functions
From: lyude@redhat.com
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 nouveau@lists.freedesktop.org, Alexandre Courbot <acourbot@nvidia.com>,
 Gary Guo	 <gary@garyguo.net>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, driver-core@lists.linux.dev, Miguel Ojeda	
 <ojeda@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Alice Ryhl <aliceryhl@google.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org,  Sumit Semwal <sumit.semwal@linaro.org>,
 linux-media@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard
 <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Benno Lossin
 <lossin@kernel.org>, linaro-mm-sig@lists.linaro.org, Danilo Krummrich
 <dakr@kernel.org>,  Mukesh Kumar Chaurasiya	 <mkchauras@gmail.com>, Asahi
 Lina <lina+kernel@asahilina.net>, Daniel Almeida	
 <daniel.almeida@collabora.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Date: Fri, 12 Jun 2026 14:39:29 -0400
In-Reply-To: <airp4AHxiJKWn5tr@um790>
References: <20260610162433.923550-1-lyude@redhat.com>
 <20260610162433.923550-3-lyude@redhat.com> <airp4AHxiJKWn5tr@um790>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b2wv-DhXZGjb5yM06Rbt98be7sI1fIx79TwC12BMk_E_1781289572
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

On Thu, 2026-06-11 at 10:01 -0700, Deborah Brouwer wrote:
>=20
> Hi Lyude, i've got a clippy error here that "into_iter()" is
> redundant
> because it converts a Range<usize> into a Range<usize>.

Yep, that's completely correct! It looks like I was running my kunit
tests without WERROR and CLIPPY by mistake, which would explain how I
missed this :).

Will fix in the next respin in just a moment

