Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54494C55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 21:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 937C210EBD5;
	Tue,  4 Aug 2026 21:08:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="XQlQtUpf";
	dkim-atps=neutral
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 547B610EBD5
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 21:08:56 +0000 (UTC)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38dc085b0a7so337964a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 14:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785877736; x=1786482536;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Nz3aCp4Uyw3qY+MX7Sv/bu2ByRkx6w/quCe3kJ8ANw0=;
 b=XQlQtUpfsTUYj8Pu7naFwNhGzcclEBoXLmBRJ6AQYv9niICr4V3d01vSdsKvhY6K07
 7djKv+WfQbH4I5yr1K1bDDVO5JF7U3YLHxvCcILaFbaOKBUsp7G1uV9BVUKVXFwZDc6L
 evZ4Lsx/+mAoPj5fWKlr8kiFK86iMLHYO5BSPuczmv8em+YEVjWlhlRwxr/yAi7M4vQ9
 zsARx+xPeSxb2oJ3KjXLT3emG1guVUzoUqJZ0MOSUjcqluDTOSzQl6Mm5WVVJvfz8Eey
 qletbeey1uxsXNIYOJvLaG/gZP7sIuWipbb19tW8rutwyfwIzzlBh1wgUxSFi+HHxHot
 zgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785877736; x=1786482536;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nz3aCp4Uyw3qY+MX7Sv/bu2ByRkx6w/quCe3kJ8ANw0=;
 b=XHTef9Os1V7JKo4GUx5646JC4Zu8gASXsR191x5Ngj9Z/31HM76PIWJ24Moyw56urP
 WQ2uFOyCyS7utYBot8JBdbVJz3DIb6mBd7lYFw83l9yuNwEhGcpew7hBcf3W1d7fk0LR
 XDFRdkteMpzIGR4g9oU6PRTZvsEYYK+AjAnko82NtkkEksA4cum5a9L5C2jf/SBDIefB
 +Kc62KD8yM45BIENZBlfAmpselnr72ODbXMlJb5jHx5UwLoBjNMADgwGT5HcaM7DSoXY
 5qA6ER2Je5CB6vGlKop6rocwwDvyw6zOieZzNSxPGAzMs9SYGRmw6n2TFuCq3Gfr7ckS
 W4Aw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rol1b5YDowVBU84Nm+t0DVtrGapoAI7VLMFW3vm487V097B6c1OFSqxvsOOX+Efpx1Nn8MVtRFOObs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxzGwDWmyNigdjFuHEairzkVouGNuorHX47JcdMKgNpMTh5eKT0
 e1K7yZcVSx0/uh4uMLvCL6f1JLmJLvam0kxcNIWslkeBUGC0wj6P9zncpsTds8IscFkRsCycOaS
 mKGTBuw==
X-Received: from pjsa12.prod.google.com ([2002:a17:90a:be0c:b0:38f:e6f2:5944])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d644:b0:38e:2860:253f
 with SMTP id 98e67ed59e1d1-3903c582511mr1841710a91.12.1785877735649; Tue, 04
 Aug 2026 14:08:55 -0700 (PDT)
Date: Tue, 4 Aug 2026 14:08:55 -0700
In-Reply-To: <20260804120529.1730187-7-pbonzini@redhat.com>
Mime-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com>
 <20260804120529.1730187-7-pbonzini@redhat.com>
Message-ID: <anJU5-5xi3bcW0jf@google.com>
Subject: Re: [PATCH v2 6/6] kvm: return -EFAULT for writes to !VM_WRITE IO
 mappings
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 Alex Williamson <alex@shazbot.org>, bcm-kernel-feedback-list@broadcom.com, 
 Boris Brezillon <boris.brezillon@collabora.com>,
 Christian Koenig <christian.koenig@amd.com>, 
 David Hildenbrand <david@kernel.org>, dri-devel@lists.freedesktop.org, 
 Fei Li <fei1.li@intel.com>, Huang Rui <ray.huang@amd.com>, linux-mm@kvack.org, 
 linux-s390@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
 Peter Xu <peterx@redhat.com>, 
 Sergio Lopez <slp@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="us-ascii"
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

I strongly prefer "KVM:" for the scope, and it's waaay more common.

 $ git log --pretty=oneline --after 2015.01.01 | grep "kvm:" | wc -l
 1298
 $ git log --pretty=oneline --after 2015.01.01 | grep "KVM:" | wc -l
 16249

On Tue, Aug 04, 2026, Paolo Bonzini wrote:
> KVM's behavior when the guest writes to a non-writable VMA is inconsistent.
> For regular, page-backed mappings it returns KVM_PFN_ERR_FAULT and thus
> returns -EFAULT to userspace (which is ABI, and relied upon by tests);
> for VM_IO/VM_PFNMAP mappings instead it returns KVM_PFN_ERR_RO_FAULT
> and thus exits to userspace with KVM_EXIT_MMIO.
> 
> This behavior for VM_{IO,PFNMAP} was added by commit bd2fae8da794 ("KVM:
> do not assume PTE is writable after follow_pfn"), and even if it has been
> in place for five years it is unlikely that it is relied upon by userspace,
> since it is inconsistent with KVM itself.  Change hva_to_pfn() to return
> KVM_PFN_ERR_FAULT for all non-writable VMAs, and restrict KVM_EXIT_MMIO
> to the case of an explicitly read-only memslot.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Shortlog nit aside,

Reviewed-by: Sean Christopherson <seanjc@google.com>
