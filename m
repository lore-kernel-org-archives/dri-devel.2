Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 554FEC5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 14:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF5D810EA94;
	Tue,  4 Aug 2026 14:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="b3we5V7U";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6760610EA94
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 14:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785854068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AkpbKoqkLE2ago1nKO8zeKKdehNgTrIPaOMhneanm5Q=;
 b=b3we5V7UvlhlD3TTG9R1sBM9eROLbjYrnKuw+fq/CN5lpvoGXBS33Rxag6DJstwW1aMFc9
 m1kzFk5iFziFyYifY28KKX1MqdZuKKpTMDfSjw+PFRVLR+QcOl0rV2tnvltblqIG7iUQyl
 IP9zYpw8Ztil/RJ2qInZyjdAgGV7MGQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-I3ad4OuwNcCl14CU73S0sw-1; Tue, 04 Aug 2026 10:34:26 -0400
X-MC-Unique: I3ad4OuwNcCl14CU73S0sw-1
X-Mimecast-MFC-AGG-ID: I3ad4OuwNcCl14CU73S0sw_1785854065
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4955e865174so19843295e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 07:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785854065; x=1786458865;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AkpbKoqkLE2ago1nKO8zeKKdehNgTrIPaOMhneanm5Q=;
 b=hN2UVWQC+OFFVcAqD82eztB6lhbUP/ahKdjkvQUtVPbBoVbORIN9LYYg9uI5oBD6Bn
 RtB/IV06PAZrX1bO0dGecGoeYmiQVogkvdYChfJER5bLZzNEfztucudlVQupuAqnQ7km
 +Qf4ScecjFg4iLw/NTA1ISHGckpimOZ9F0Waru3OMSfSr/owF4IA5svxw2aTwnOqzcAX
 Y188CjNt9NEil2Ey6Bpxjhm2BcfUT9SErZ+25VOrhO18fmATVVR4vEgSH6fWIIGreWCl
 d2cDRNK3/Jxi3sXWrwa3/olTl+1OuXy6nVKWxpIepOcqAP32Ra3UqK1ojv+jHel7JHra
 9J7A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrg18uvG8we024AtP0W1F7kGlR5c4boRVGFaxTOKsLZlUoOZx4lo8dSt7NprAf/AhZgqx9JeQXWRss=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDqnhUi3gJbmsekOo60xITIlzg0Rs/3RnRkBCetupkeDQTvkdR
 jRHPkc+ELvqzYIFfd3odAyW6dkIT3XUgsrcS7THIKnBHRdXUOKzs7Lw8F8Qc/EeJqYt8UFH4Chy
 aMZj4/zuOi/ookxm/3UlUBtw5eBCNIu3OPEXcqAFJNgxNgiYMojw3JTwUbSbThqkN9gCvI57FXh
 /FInr0+iAmgC6ypcuCf1IZGDzDJcjYSH5z3rfY8xJujc7m
X-Gm-Gg: AR+sD13uAHXc24i/Op3mZqDsrg36zOBj0PR6XEo82Q/wVi7/PFs2SXitcfg/5bKjkyc
 7CSpf5LKDOgaJsVIFkwfx2eyCft7LWkuVpmaAmGWAqty3XU1pIwJvlG2IqtKrxTpM/zfXeBTB7u
 ZGKsci+OwNmgakgoiktopA2Z592eQ+eqsv0uBWwk25BipsJXVsAs8sLoQgZNZ0+D6paizCSEW00
 Y8E2mwvweagF+6KL+7IfnBpXPpOKwZENoFdbj3mnftXY8T29IHmm7/F3k4=
X-Received: by 2002:a05:600c:4fc5:b0:494:6baa:ccef with SMTP id
 5b1f17b1804b1-4980f23257cmr337368835e9.11.1785854064906; 
 Tue, 04 Aug 2026 07:34:24 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc5:b0:494:6baa:ccef with SMTP id
 5b1f17b1804b1-4980f23257cmr337368035e9.11.1785854064514; Tue, 04 Aug 2026
 07:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com>
 <20260804120529.1730187-3-pbonzini@redhat.com>
 <20260804161549.4cd9a66f@fedora-21.home>
 <20260804161850.58c55c6e@fedora-21.home>
In-Reply-To: <20260804161850.58c55c6e@fedora-21.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 4 Aug 2026 16:34:10 +0200
X-Gm-Features: AUfX_my1qzxj9_dJklyDF5G5un-IXavjOuTxcyczoqFAniCfVGichGNEROtCVP4
Message-ID: <CABgObfbAveuhkjXzmemvGtycmcmDePKABr8Q35Y9mZP0den5aA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] drm/shmem_helper: use vmf_insert_pfn_mkwrite()
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 Alex Williamson <alex@shazbot.org>, bcm-kernel-feedback-list@broadcom.com, 
 Christian Koenig <christian.koenig@amd.com>,
 David Hildenbrand <david@kernel.org>, 
 dri-devel@lists.freedesktop.org, Fei Li <fei1.li@intel.com>, 
 Huang Rui <ray.huang@amd.com>, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
 Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Sean Christopherson <seanjc@google.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Hza2OtUAVD3DzItLaSS8E8ZAO9XFjjBhIY0pKbGbr7E_1785854065
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

On Tue, Aug 4, 2026 at 4:19=E2=80=AFPM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
> On Tue, 4 Aug 2026 16:15:49 +0200
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
> > Actually, if we're making the drm_gem_shmem_record_mkwrite() call
> > unconditional (for PTE and PMD updates) in that path, can't we drop the
> > drm_gem_shmem_pfn_mkwrite() call living in drm_gem_shmem_pfn_mkwrite()?
> >
> > Also, I'm not even sure we can end up with write=3Dtrue for PTE updates=
,
> > because our pfn_mkwrite implementation returns zero, not VM_FAULT_ERROR
> > or VM_FAULT_NOPAGE. This means the default RO -> RW PTE upgrade
> > implemented in finish_mkwrite_fault() [1] will take place. If we really
> > want out try_insert_pfn() to be called for those RO -> RW updgrades, we
> > need to call try_insert_pfn() from drm_gem_shmem_pfn_mkwrite().
>
> Nevermind, it's all explained in the comment you've added. Sorry for
> the noise. I keep wondering if we shouldn't call try_insert_pfn() from
> pfn_mkwrite() though, like is done in other places.

No, the .pfn_mkwrite() callback is invoked when a PTE already exists,
and mm/ already takes care of making it writable. So there's nothing
to insert, you just have to take note which you do with
drm_gem_shmem_record_mkwrite().

Paolo

