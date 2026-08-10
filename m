Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256CAC5AD7B
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 10:05:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4371110E78C;
	Mon, 10 Aug 2026 10:05:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="FsBPv4ES";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AE4D10E78C
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 10:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786356314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KTE9q723VNHgSKbOmtVFOArX1damMhZ8BQEArvWAKkE=;
 b=FsBPv4ES9kyKNgKlWzIgi+oXz7XsakdZRO4Fymvkux04hbvXb7lklDLmqSqch4fCKsNYpn
 eVbyB2o1oLHP3QJvYMKYJP1MCmfcZQEgd+4myGUYNnVy1jMRiTlhUq5Iq8gmsaJ+Wxkay8
 1aFqCEaNCzr+IOSeDBLPEDn4VyDrNjE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-gqT7_sTeOJSvCjDBVK7OdA-1; Mon, 10 Aug 2026 06:05:10 -0400
X-MC-Unique: gqT7_sTeOJSvCjDBVK7OdA-1
X-Mimecast-MFC-AGG-ID: gqT7_sTeOJSvCjDBVK7OdA_1786356309
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49955a9dbcdso10290955e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 03:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786356309; x=1786961109;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KTE9q723VNHgSKbOmtVFOArX1damMhZ8BQEArvWAKkE=;
 b=EhZl8zD0p9H4Paj26gxZnk4X32y7iLlq67rHDygvjlnqyFItmGSgItJrgw514YZviY
 oGPLO7ue6q6n1ga66xw5ci6/OkLcfQZvhdOeBaFcBIj3K5Jq40GR7fpeAd3540XZznH1
 N2dmh+SkTUZvX9wP+biKN+08DWv+pxz9Y30gpNrQFwGT2WIpfMDd5YGYCUut8eklFya7
 6rVyxpk/qVvwSvGmxpJJmuTIp5wx9ZH/hvupNQmtnNj5FGt8XLtseuf3BJqbCISsMzt0
 mxdHinVGr4y64UDrdimtisigSOr/l8CRu3dpC3Lc3tt10DXsHtWS9LGVCWqhk3/308tG
 wyfA==
X-Forwarded-Encrypted: i=1;
 AHgh+RokumPxCeze8qT2B9W2X/L2aD5PJynlqKdcnXZcg6+SFk5Iuve2psdMwkG05YdoqXt3RV5KNRpvPHU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCKtLqZ13lWVaDlcZGUQDNXreMlNMuw+MsrrhsLDUt08gwlRlV
 anC1YfKZAW0dlzdCGS/jVj2pvKf9z2qR6iP9hRQM8Lu55C69FRwxmjYFHXX390ZvxJAEkC94rim
 WLiONumfg3pisUfDWvirNdbgINa1Ad6/0pZoNEfkJ/HSyxcbgRZH4Sw0s0Vfc1xiwG+LN6+x4Pg
 vNkUh3Jm2uiOuah+O/evH1w7grrSzUmIimSBuDWNUgKkpG
X-Gm-Gg: AR+sD115VJ/Fm5f+ZNSqd6WCk7aRr3E5Nptv6ycISjXCfN5I/bUZELGzaV7z0Ayi+ou
 Odtt06INcp9/aK/fBpxJxl9x4VbKVpy2aomUqSHRP1l6fAsrMUccC6juqsBVLZLoyqRW9g24Nd9
 M8hP2yIRqhj5pVetu46NtSt1mBxuXK/rvT7B3SnRVIfs4fpYFx4w3wpx1jfXi1ZwWko+7mnQ9eO
 l3cvnkBfGqQmHw+kHiiNIOu0NzpAWW+xlOUpK1EumXcax6xcHvyjFnk5pY=
X-Received: by 2002:a05:600c:3226:b0:490:e5c1:b8bf with SMTP id
 5b1f17b1804b1-499727a3b84mr5344235e9.13.1786356309215; 
 Mon, 10 Aug 2026 03:05:09 -0700 (PDT)
X-Received: by 2002:a05:600c:3226:b0:490:e5c1:b8bf with SMTP id
 5b1f17b1804b1-499727a3b84mr5343835e9.13.1786356308812; Mon, 10 Aug 2026
 03:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com>
 <20260804120529.1730187-4-pbonzini@redhat.com>
 <49840a84-6d73-4a15-adae-800eccfb1c7d@amd.com>
In-Reply-To: <49840a84-6d73-4a15-adae-800eccfb1c7d@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 10 Aug 2026 12:04:48 +0200
X-Gm-Features: AUfX_my6VzuSeHJgh3uVKaTYyn_VnWzP5xLi-qQ5sWEuv-5l4TAmINZeor_-704
Message-ID: <CABgObfYvz_SrBBXmzJfiW0VsQyRa8OWQdP7myfY=WAws63oguw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] drm/ttm, drm/vmwgfx: directly create writable PTEs
 when mkwrite is in use
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 Alex Williamson <alex@shazbot.org>, bcm-kernel-feedback-list@broadcom.com, 
 Boris Brezillon <boris.brezillon@collabora.com>,
 David Hildenbrand <david@kernel.org>, 
 dri-devel@lists.freedesktop.org, Fei Li <fei1.li@intel.com>, 
 Huang Rui <ray.huang@amd.com>, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
 Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Sean Christopherson <seanjc@google.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GYqfIh2LtBxp6oDNle9IQ4oGJf9f3B7l-jgigeB44Vg_1786356309
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

On Mon, Aug 10, 2026 at 12:01=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
> > -             /* Never error on prefaulted PTEs */
> > +             /* Never error on prefaulted PTEs and never map them writ=
able */
> > +             mkwrite =3D false;
>
> As far as I can see that is a really bad idea, we do want the prefaulted =
PTEs writeable.
>
> The whole prefaulting is essentially an optimization for cases where taki=
ng a fault has massively overhead (virtualization for example).
>
> Wasn't vmf_insert_pfn_prot() making them writeable before?

In general yes and they still will be, but not if pfn_mkwrite was used
(as in the vmwgfx driver). I'll change the comment to "never force
them to be writable". Setting mkwrite to false is exactly the same
behavior as before, setting it to true is a superset.

Paolo

