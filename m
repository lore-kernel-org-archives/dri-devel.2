Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359D9C55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E24510EA16;
	Tue,  4 Aug 2026 12:48:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="eBqxB7f5";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D314010EA16
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 12:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785847686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V/8cjqgBsD+OEloLI1K1iMex5eqU9Q1Mx8Om0dbP7sg=;
 b=eBqxB7f5KbqEbM+KNQscqAzr5OAO4dk64XQ+AusGf6fbrp8ocaLwKgDM4gK7BuHMpFe7EK
 XXxiyZxFUryTgVT9iVZJT+PDNYSozIPqGobdNQphRek1xl/yHwdx2ArHPnQx4OIHW4gexq
 RyC84ag+KpGFNeNq/ZGIh60Z+nPJscU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-fQwc4wdSMYK9GX1uZZnTAg-1; Tue, 04 Aug 2026 08:48:04 -0400
X-MC-Unique: fQwc4wdSMYK9GX1uZZnTAg-1
X-Mimecast-MFC-AGG-ID: fQwc4wdSMYK9GX1uZZnTAg_1785847683
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-475e540a0ffso2934915f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 05:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785847683; x=1786452483;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V/8cjqgBsD+OEloLI1K1iMex5eqU9Q1Mx8Om0dbP7sg=;
 b=QmfLM+WFmy04RaH4MF+LmrI4RZ4YJtYIqy9COMcp5svIjn0OiNUrS1ZwbDjHkPBzIJ
 xKp+d1PPCS1Oyw8Trs7uI1lZOCvqqE6Y31k143YHsZZ5Z3b90vSUI0e9+eEN4Nq+spCi
 CyHkc409ZN5YWH5rCi7ENnz9jyNsnJxkcGkS6RCfMtrGoHpDORamrXyYs2cCT470WiEH
 CAke+KoESdX7VbiwzAwYss5Tblks4/ZePTFZ/LhUkkAVX3HEClmSONdZlasFxT//FnK0
 E/HPT8jXeGAyyHhEGT4AWZ+SsuXmEbeh78QywOwNMXH6LGFJbZRMkOf4Up1ih93QyMg8
 v0aQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpWY1oHn3Ru96MHst9dDCuZb6F4km8eZm6cFvefyl8AHPBviaZq6uD+H9tX3EXn6FTMRn3RCfaGwD8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwaQQ5GbEC66gg8yjty/bfVAJbWkSFX5UbAdxhpvLOUgSfBNPA/
 dk1GuR0xvenQAlSHqS/7PVr7GiPiTB/hUT1Pnp7ZyOS7jCyXrxLAqvqs0ymy6QkKCkWv3zXZ5Lq
 7dH1xB0qd6lU+OHaEy97LrDbR2nr9Pnq+8MaQVWQI5SEr+DlL6QXQUhmsz4KnSX72PWs/tXh/03
 VOANN9B8jjN7DET5gQ85cd6vD2lKQiNQ1C5xjx1izcvrMf
X-Gm-Gg: AR+sD104O2HhLzNB4mOpBOZvwOWqrSHtHRPTzwqo2TjNQ38OlGFv+khN8OD2SCKMzXY
 r3ht9XZwfLQh/JoDzAYeieKaurYISPq8GOtS5paFRGlg6AkhlWyz+C6t8efwaFNI9fSWBqg9Njg
 +B7mt0h9Fcbj1ld8LtkqySm/X43/yaSJNbkAfR/zN5XVkNkuua7teMoXQ2eeI1zzceaL5PyAOuA
 t8doI8Od/TvzOrhF0mLBcMLVBLVp4XHji8txxaa6bvWSAi++CoJKGW/ATI=
X-Received: by 2002:a5d:6347:0:b0:47f:7b75:9dfe with SMTP id
 ffacd0b85a97d-47fd72ba981mr33399481f8f.8.1785847683359; 
 Tue, 04 Aug 2026 05:48:03 -0700 (PDT)
X-Received: by 2002:a5d:6347:0:b0:47f:7b75:9dfe with SMTP id
 ffacd0b85a97d-47fd72ba981mr33399406f8f.8.1785847682947; Tue, 04 Aug 2026
 05:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com>
 <20260804120529.1730187-4-pbonzini@redhat.com>
 <20260804122128.838941F000E9@smtp.kernel.org>
In-Reply-To: <20260804122128.838941F000E9@smtp.kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 4 Aug 2026 14:47:49 +0200
X-Gm-Features: AUfX_mzc1UECOTjr13bdYLDwoSBcmazBIfNKBtso7fBXqj8NWhSnjvnTNjTJWfA
Message-ID: <CABgObfb9-cEUykbZD5C5LMz8Otk8hJk-OCzgRq=HvU3-s9NSVw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] drm/ttm, drm/vmwgfx: directly create writable PTEs
 when mkwrite is in use
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
 Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 dri-devel@lists.freedesktop.org, kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WmiP4KJ0zQmc-FlVCZLK4aYMIYMx9oi0lqjauFH9VlE_1785847683
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

On Tue, Aug 4, 2026 at 2:21=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> New issues:
> - [High] Missing dirty page tracking in vmw_bo_vm_fault() when prefaultin=
g fails, leading to silent data loss.
>
> Pre-existing issues:
> - [High] Inverted error handling logic in ttm_bo_vm_fault_reserved() hide=
s primary fault errors and propagates prefault errors.

Fixing the preexisting bug avoids the other issue - I sent a patch
separately at https://lists.freedesktop.org/archives/dri-devel/2026-August/=
586696.html.

Paolo

