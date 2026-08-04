Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78194C5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:50:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8A5C10E8AF;
	Tue,  4 Aug 2026 07:50:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Y/I/PAzH";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F18E10E8AF
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 07:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785829847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rrWIVUHqX1aTWPEdjHJhagxc6L1zuVCCqMoCE+Y7dZ0=;
 b=Y/I/PAzHpLTFj4CFeNfmbPSmPWjLpenZ3r5g/htVXPzfKGvZ7/w8mahOhOccVvx4aePipy
 B+e3FN5de830gYr+FxJQfkpWat1WClie3A5S7Uaf97WnWSjYFLuX/T6Aw1s37HoQvZGTQg
 3ohxQU1K5Kg/bRjWjubpCN23b8Ku1Vs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-oCmerRxeP1e4So4261mU4A-1; Tue, 04 Aug 2026 03:50:36 -0400
X-MC-Unique: oCmerRxeP1e4So4261mU4A-1
X-Mimecast-MFC-AGG-ID: oCmerRxeP1e4So4261mU4A_1785829835
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47fe85684b9so524205f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 00:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785829835; x=1786434635;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rrWIVUHqX1aTWPEdjHJhagxc6L1zuVCCqMoCE+Y7dZ0=;
 b=S0TttYHh9URAPuHjSv3t64AB74m0TA8Dv20N60K8VlZOuO1fEzALXL5EDTriZ/psQp
 4m80khjjZUDUsNzGDkzl5J0IZmxH09RzsHkBAc+ro5sNFl6sPSU1Y990QTrmdDRYuM/A
 zxL+eYpCNdKZPXipZctnFWg7WtDn5OSTr2zeDWbLUH8Ukb4xbMvbYSh19vvuXrIjp6QD
 Oo8ht+hCY1N7GFOvkEbBjCVAmx2m8brojConRWy+dCaBlTU7zvp53NgWV/206oJqoIA8
 zITzbKBwnTYmpCXm+8B0er22WPoRtfUtcEUO3vnUgaRc4biPpm9vlPgFITHtuIvRz6iG
 tnCw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMfZl2LVI81Y3V54bUZkCSMdahEhMAIFzc7pnCJP177oKc9uOMtlGGWw25ux7JMFV8yXDBs5ayHvQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZayFCbu38oie634yymuPj69bsO71c4Fh2OyJPqlg4M+pNLR4V
 SvXXhrAuLdap/OPjPjsMt5Cd5a1jI+Un7AxJwM7KV7L52/jXK7EwIVid9sR5kSK1EkqhYibfbfP
 AaYvMo1VanTZG3VsdwT1kfTK5+tOKRwphrK6bOLIBKapMhJYyjRCmtvsGnb/Pf318vdRgdXiWcg
 Ntf4qpJJ/jAzhR/zRMrnA3HFSK8F7NEU95cPic1DjG5VlL
X-Gm-Gg: AR+sD11Ikoau+K8G/oultAvXDOTqNPtvyeSWFbTRQQOAkTBXvSPNxAmzK+9wnV1GbBj
 0ryO1fw/PCd7gwFbd13dhEBlLnUCTZdKtxjO09YrYOWQvU2n5WpPsw/8wypxBLMWbAsDvGigQJd
 nMmx9EKvi7T9A9eUMjPZjIqAQEgtnynp9M9dxuZFFq0nn4nSUfrXsVqnmA0lq+1DJ5ofFh+17ov
 MFkLJiJ7C/DjG+NR0fYtEK2EJkV11SPtXM6lPYyvtQKC0FpZZ3fLnIOebA=
X-Received: by 2002:a05:6000:1886:b0:47d:fc20:e7ab with SMTP id
 ffacd0b85a97d-47fd729e70dmr34032593f8f.4.1785829834819; 
 Tue, 04 Aug 2026 00:50:34 -0700 (PDT)
X-Received: by 2002:a05:6000:1886:b0:47d:fc20:e7ab with SMTP id
 ffacd0b85a97d-47fd729e70dmr34032521f8f.4.1785829834408; Tue, 04 Aug 2026
 00:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260731164341.1109827-1-pbonzini@redhat.com>
 <8d94897f-0f56-4ecf-bcc8-50bffd6750b2@kernel.org>
 <58fc5ce1-b6f5-48df-bd3b-054443c60cdf@redhat.com>
 <f556ae97-efaf-4e7e-b4f0-0f90087c8555@kernel.org>
In-Reply-To: <f556ae97-efaf-4e7e-b4f0-0f90087c8555@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 4 Aug 2026 09:50:21 +0200
X-Gm-Features: AUfX_mzf_XARvVJuWyc5ctX7YzblMVOKgWg8l40HxuptWU1WxUk9kwBguF_a_eE
Message-ID: <CABgObfaCTroScRykMHRk6fLktzG7CT2Prp2f-CCCANfuagv_MQ@mail.gmail.com>
Subject: Re: [PATCH RFT 0/3] mm, drm: ensure .fault() does not have to be
 followed by .pfn_mkwrite() for write faults
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Michal Hocko <mhocko@suse.com>, Sergio Lopez <slp@redhat.com>, 
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
 bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org, 
 linux-mm@kvack.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: B9Pa2iejeJKS3M3CqZCPX60l_yZnWcWET6lqYMGPGFQ_1785829835
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

On Mon, Aug 3, 2026 at 5:18=E2=80=AFPM David Hildenbrand (Arm) <david@kerne=
l.org> wrote:
> >>> Handling this in fixup_user_fault() is problematic: the information
> >>> about the presence of *_mkwrite is only recorded in vma->vm_page_prot=
,
> >>> which is an opaque pgprot_t, therefore only follow_pfnmap_start()
> >>> knows how to retrieve it.
> >>
> >> How is mprotect() supposed to work in that case?
> >
> I was wondering about the following:
>
> mprotect(PROT_READ)
>
> followed by
>
> mprotect(PROT_READ | PROT_WRITE)
>
> You'd similarly end up without the writable bit in the PTE, and apparentl=
y there is not really a way
> to recover from this.

Why not? mprotect_fixup() calls vma_set_page_prot(), the PTE as you
say lacks the writable bit (unless pte_dirty(pte)), and then the next
fault calls .pfn_mkwrite().

Paolo

