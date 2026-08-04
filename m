Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7862DC55838
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD00F10EA08;
	Tue,  4 Aug 2026 12:44:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="KPxFt9EP";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F04DA10EA08
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 12:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785847495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AhCvAzGz5QWbk/302ntoX0RJ56FBrV8QY/YWkhL/+9Y=;
 b=KPxFt9EP5GqxlwskjyT9NEkaHe78JKqmsKYItSZhw60mKXod30UVSdN6WP9u1snf+2nfrH
 J6ZnP27ES+bhftOpxwBm39+EoFeCLWkRj4QTYZ8oqRXhI+QzNGn9xGwSjwpV76wiWbSm/H
 U0sDkH3x/BOx4nKLjOB/JI/9/L8HHO0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-MKHlRXtVPkaPrEaiWwjjfg-1; Tue, 04 Aug 2026 08:44:53 -0400
X-MC-Unique: MKHlRXtVPkaPrEaiWwjjfg-1
X-Mimecast-MFC-AGG-ID: MKHlRXtVPkaPrEaiWwjjfg_1785847492
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f84ac1990so3237323f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 05:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785847492; x=1786452292;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AhCvAzGz5QWbk/302ntoX0RJ56FBrV8QY/YWkhL/+9Y=;
 b=Yt0nmuu5M00hdJVGG8gwIe0nlhkKBapshelc1V3xSysuRYt09DywoYoH7eyt5yHKXA
 FX8LUZSooT2PPUeSvPvRIAU7Z/vsIg29c3yQoo/C5WSFKQWvkYWe+JvET0x9UHEmhBZ4
 BbOhVqhNr08BJ0wGAG1EzgtObTwRcX/4WZ2bdyoPuOOGFXXB5w+uudQXblCXMu2vrvmX
 EyGzjAJy/EHA4HOqhM1cdUKApOCH0m+ZMlCdQ0ryRRBSLFjsT8D4YyvNeBH+p+dKFOC0
 dFwOyClfLAMvcD+2GYFCBpBdCvKMfziU8vy2XhFDB/wdEgClrvgcZc0iGpMWh86N440Y
 /iOA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZhSY//ifE8NcqpPSrfCeW7z04U41yHO3GRa+3mfVziA3m4Ppa/DW3ySGF5e8v5owS+REyIr+juyQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz0xiPQRijYLbsk5Gpy8diULhzbK0P9BVVFBchO0aQwl0RKh4dY
 7aHjGJYUw/exeDiHZjXsZc6bJb5kW1+pk+Xq+0iVZTCraqsWHiNQMlHzgO7SRGNaowTi2M/2JQT
 UqMEySq54orLaAlpzjepzu22OHWH231xAPAIjo0L/vZ1XRXLAy5Xd/dISe56mIYjECmEo3bi0wa
 dnFgqPNEJj5MGwwq+tgOx/0N2CG2TEcDiT/h3pVXUojbL0
X-Gm-Gg: AR+sD12fi/0IA3m4mUgmCQnVGGMUOw/xO1tH5NWTdjcxOnS5dzpg27jIH3/JBQBXpfQ
 I+u3nFwAfo8SKMOyf8yZstgMjVVeE71iUwK8Ekf7hfBfYqqibEr+E7wpbHZiJkT4cgrzWoGyob5
 EtMnArkoKc2CGtKbThVc0yyEA94kDdld9hOJX71YWfZULBefrD4wTnEFl9mJ1xa36pqWGuBj9mE
 UPfWqAPfIR+ESNU10HPcmDhyo5tmcTA9C3T7/t4f7zhkqVzWH6s+pFl6Cs=
X-Received: by 2002:adf:e196:0:b0:47f:91f0:9a8 with SMTP id
 ffacd0b85a97d-47fd72d9daamr44077311f8f.23.1785847492515; 
 Tue, 04 Aug 2026 05:44:52 -0700 (PDT)
X-Received: by 2002:adf:e196:0:b0:47f:91f0:9a8 with SMTP id
 ffacd0b85a97d-47fd72d9daamr44077224f8f.23.1785847492081; Tue, 04 Aug 2026
 05:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com>
 <20260804120529.1730187-5-pbonzini@redhat.com>
 <20260804122348.AC6E51F00A3D@smtp.kernel.org>
In-Reply-To: <20260804122348.AC6E51F00A3D@smtp.kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 4 Aug 2026 14:44:40 +0200
X-Gm-Features: AUfX_mzeBd9D7i9RK65m6Y6i1uzG2a-w4C9IIV172eXDDgUNWsdPG5F7opYXrlc
Message-ID: <CABgObfbd63O_UkmCcik1z0J847Sr6a5rnFgwttBjBb0am=+2PQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] kvm: apply VM_READ/VM_WRITE checks to all VMA types
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 kvm@vger.kernel.org, 
 linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, 
 dri-devel@lists.freedesktop.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tPVlpxPVtc57xN-yo1HfTiq88Mp4K27COXemUYJ6f8E_1785847492
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

On Tue, Aug 4, 2026 at 2:23=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Write faults on write-only `VM_IO | VM_PFNMAP` VMAs are incorrec=
tly rejected, breaking guest writes to write-only device memory.
>
> If a guest performs a memory write to a guest physical address backed by =
a
> write-only host VMA (e.g. VM_IO or VM_PFNMAP mapped with PROT_WRITE but
> without PROT_READ), get_user_pages() will fail and fall back to this look=
up.
>
> Since the write-only VMA lacks VM_READ, this check will evaluate to true =
and
> return KVM_PFN_ERR_FAULT, skipping the VM_IO | VM_PFNMAP handler. Could t=
his
> prevent guests from writing to legitimate write-only device memory, such =
as
> command ring buffers or write-only PCI BARs?

This is theoretical only but actually a bugfix, because KVM does not
support write-only mappings and therefore it would not be possible to
enforce !PROT_READ/PROT_WRITE.

Paolo

