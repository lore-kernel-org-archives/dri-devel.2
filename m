Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D51606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AiPXEGUx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA68210E3DC;
	Tue, 27 Oct 2026 11:01:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD22B10F3E0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793098910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mswFdaLeZadM3beKHgTV0+pA+8tp/9smRtFllvNXA0g=;
 b=AiPXEGUxZJEFydOVe/xa62W7XNMHwECKpeeaYgUWJxDkxcVGI4o6M2ZwwlKHVdzALEHsQ1
 Sgu4dKlwL1caNZKxUW6CFmPsfX7/UdfZ8ALB0q/w5li7VHBaeBHGNnFFgjXDoOuonHH37i
 516Fum1pgH8MPQoVKQtFk3el/ji9vfI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-JYVInPlvNIeQq5FGnvjZtQ-1; Tue, 27 Oct 2026 07:01:49 -0400
X-MC-Unique: JYVInPlvNIeQq5FGnvjZtQ-1
X-Mimecast-MFC-AGG-ID: JYVInPlvNIeQq5FGnvjZtQ_1793098908
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a20e41008cso27659145e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 04:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793098908; x=1793703708;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mswFdaLeZadM3beKHgTV0+pA+8tp/9smRtFllvNXA0g=;
 b=cf+xjak2qQbdYkE7Kj8ufVXrNNqovgKzg+KTgoVHAFeI16WhKDuzi0Y5jHj05hjUjg
 cCa5fx425ok8KOgnEwl7MDrU1DCvHQHUnFyp9bYpAui9Uzqp/q8I2PrWc64xcFimEMiL
 CPZYuYdW5/HM1TJ/tCRZJy8Q6VJGfn48u3GMk1LE1Ircq1x2nfDbEGpaoMXhPJDy7dPu
 jiYgWFODZGAhl2kK2r33HwzjlEfaSer31H+V586GIUJSjaHp+st06JSYdJsXt3DRm8yg
 Dyy9RxXscY1Lr6L6GQEiFu7wqvK53XS4+WgjsKwgYtPxvBvSftQbGk2z2cwSJSZ4BXO0
 k2+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxuwpG9k28oPEA9PlZHqqlM4A1ufU+lU1n4ZngcUmU4H5Ybson60lxbjNWi41J/RSP0VEOuAutOBeE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKD31gVgypslNeqb9l3ozfDvfzVcy51UmDhub4pEfifhTNn9Vr3
 upUaIBY7BK1njr/HLQlGIkOt6yClg0uzwMRPAcGhgSH5GcycYo3o9wa2xXAxB7VdgNUWkFOGJ+o
 HWkWcrZHaBoV8C4LLuAXnF9nX1kBsF8Y3oM/uMcZF8X79fX4WNDI3H6q8bAfyUK09XuZzEDCQ9h
 /7FF19pjEPB0b8+91zlu/w632ML6RaC5HlN5lGT6kFt7su
X-Gm-Gg: AYBFou1VsSGqesMKxyeww8OewH7z1Mv0XjIcFItGzZVoq4vs4pY4Z+3cZR02ZEQ93fF
 fshOCj7e1lmYVhJtfFFi7L8BrbylU3fcwCRk9X/F/aPxhzEDWEO47s7WtNtXlW9qiQV+9/Ffg/0
 VyAJaiCbiVmOgX7IdeH0XlWd/HXIWW03ZjCOBcJ7TBL0Sn8IzePK0bL6z7Ypab1A0hzApRAOqG9
 twD1mMq+42JZemzWD2pYzMqjgIUS53KcIPQ7DXcEneTW0yqUkeuopasoPrjXQ==
X-Received: by 2002:a05:600c:8b6d:b0:4a7:669c:c988 with SMTP id
 5b1f17b1804b1-4a7669cc9d8mr64989205e9.23.1793098906400; 
 Tue, 27 Oct 2026 04:01:46 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6d:b0:4a7:669c:c988 with SMTP id
 5b1f17b1804b1-4a7669cc9d8mr64987735e9.23.1793098905407; Tue, 27 Oct 2026
 04:01:45 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com>
 <at9ahKiYsVtH8kpU@google.com>
In-Reply-To: <at9ahKiYsVtH8kpU@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 27 Oct 2026 12:01:32 +0100
X-Gm-Features: AclHuK_gMHxkpSkqtzZpmI4E9n3tRQVDE0ExdUQ32JdSX7MqnvWed3WEPGPoNjU
Message-ID: <CABgObfYgZ87=W+6E=N=WwTuyYkaoKU3hqd84JDTSAvT3_9dh6w@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm,
 drm: fix interaction of .pfn_mkwrite() with fixup_user_fault()
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 Alex Williamson <alex@shazbot.org>, bcm-kernel-feedback-list@broadcom.com, 
 Boris Brezillon <boris.brezillon@collabora.com>,
 Christian Koenig <christian.koenig@amd.com>, 
 David Hildenbrand <david@kernel.org>, dri-devel@lists.freedesktop.org, 
 Fei Li <fei1.li@intel.com>, Huang Rui <ray.huang@amd.com>, linux-mm@kvack.org, 
 linux-s390@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
 Peter Xu <peterx@redhat.com>, 
 Sergio Lopez <slp@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sE2KR3TBy96B9VbFxRN-SodPwZ0iFYJAnrEwoWHs0r8_1793098908
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 2:50=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> > To sum up:
> >
> > - patches 1-3 introduce the new MM API, and use it in the DRM .fault()
> >   callbacks to install writable PTEs in response to write faults
> >
> > - patch 4 is a preparatory fix in KVM, eliminating inconsistencies in t=
he
> >   handling of !VM_READ and !VM_WRITE VMAs; these would return different
> >   error codes for a !VM_WRITE VMA depending on whether the PTE happens
> >   to be mapped (but with wrong permissions).  This needs to be here
> >   because the next patch would introduce even more inconsistencies.
> >
> > - patch 5 moves the check for writable PTEs from follow_pfnmap_start()'=
s
> >   callers to the function itself
> >
> > - finally, patch 6 is a KVM addendum that will have to wait until
> >   the next merge window; it removes yet another inconsistency in
> >   KVM's handling of !VM_WRITE but is technically userspace-visible,
> >   and therefore it shouldn't be included in stable kernel releases
> >   unlike the rest.
>
> What happened to this series?  It seemed liked something semi-urgent, but=
 AFAICT
> it got silently dropped?

It ballooned a bit and getting acks from everyone involved is hard...
Either I or Sergio will get back to it.

Paolo

