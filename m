Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629B6CD98CC
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CE6C10EBEB;
	Wed, 10 Jun 2026 21:10:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="QSHwlDt8";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4E6810EBEB
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 21:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781125830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zn+metQNd/XG/ZUgXyMP5j+F+hyFwWJJHw2ChAA//AA=;
 b=QSHwlDt8YaZFEWNaTf8riVMPUM53THBzoeGFkMIHvA2ZZcrSvGmx6XrEHRpWWgQtvcDuFK
 xfKoULX2a6MRRLKIAxT9lufMGQNkM7QZZDEvBpmLVeUBv0g9UMLtqtHf7KXO/vf87N6bJb
 cTs1rq+qcGHD2kxlcddb1oBxicNeTJk=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-dUDHHjR5PUCEiyJfUOSf1A-1; Wed, 10 Jun 2026 17:10:27 -0400
X-MC-Unique: dUDHHjR5PUCEiyJfUOSf1A-1
X-Mimecast-MFC-AGG-ID: dUDHHjR5PUCEiyJfUOSf1A_1781125826
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304df51ff3eso7968025eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 14:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781125826; x=1781730626;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zn+metQNd/XG/ZUgXyMP5j+F+hyFwWJJHw2ChAA//AA=;
 b=jbUQZqHNB0yNBGx+M8JKtlQb9O6La8dmIu/MI+cPOhT82JA6cihRAf3zEnFrtnDOs4
 M+n/O2bTql34TNgHqQMC0Ky5cV7U86YD8IvJF8l0sESj9vGX6LE1J6Gx/0eMYrJDIkjl
 Z5OjVCsgvcVZOSu11lfcvVoPc25yNHv/wWOG0pRzRdWEyinRifCt9wgbYj/KmFYqVNGi
 hnU0qDqgY/gTLaRVThpf/B7gQs3NyIpqvRuSC95hd6YEKylfvo7Bjc5NQN21ts/ex28X
 xr5xvOellsxcCiIr3f/VJ8dm5PzGASNbLYsrFWwSncn9Q5nqO6kEsY5KV/9kjwNEjEwV
 q+Pw==
X-Gm-Message-State: AOJu0Yzeq4jo3GWR2GPsRX9HsQ//uzlmQW/iXKC45eKrizELx1Ybwq7R
 u/Pmu+pyAUUBWoATxwXSlwdLtVCnQU5MXeZyLeMI2IyaGJ4vPyj4//mexZtQm0yu/xt0ZaPLaL/
 lzll7Q/6C9spajhoD4WDfexfhlZjxQEIV+nCYv/fEKRRKRs/+A//K0VE0/l6oESKUY7QQLqZWLs
 q9e467Qx7m+s4VAxTwJuJHyyFUGpzyBkAFEG5YZwjYpwnt
X-Gm-Gg: Acq92OGb1WyuQ/yNOCw5CUwP81MQ4euMENsY5XQ3vB4vgvTlECqGKTzkc65gFBgR3CX
 fH4sofj5bmaYx6hmLBbv7sAHVYozyFzygNGKKwZ+HO9meD8drhZ6bGGB2luHB6Z07FNdSGk1bey
 ZNCBYYS7f+36x0W4/ml38dbhr8AcoLyCNOxh7i44xh9wVL7ldsrHJP/LZ+VnZ2YK5W6+UJpaFZj
 /fttUU4cfE3mJ2DtTTl5UTNRvDcloCQaf2c3TatdVPHKgaB
X-Received: by 2002:a05:7300:8ca0:b0:2ed:e12:376d with SMTP id
 5a478bee46e88-307ff820bdbmr662239eec.35.1781125825974; 
 Wed, 10 Jun 2026 14:10:25 -0700 (PDT)
X-Received: by 2002:a05:7300:8ca0:b0:2ed:e12:376d with SMTP id
 5a478bee46e88-307ff820bdbmr662199eec.35.1781125825460; Wed, 10 Jun 2026
 14:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260610141549.555605-1-jani.nikula@intel.com>
In-Reply-To: <20260610141549.555605-1-jani.nikula@intel.com>
From: David Airlie <airlied@redhat.com>
Date: Thu, 11 Jun 2026 07:10:13 +1000
X-Gm-Features: AVVi8Ce5IWVyE8AXhZUnTXwJ31lTOn-qBi0p3ZXgtCPUjD5gRdicD1lr4IH92yI
Message-ID: <CAMwc25ow-MehYN8u0EFkEW-JB2CYL+od9xja0WBK0-msWMHOww@mail.gmail.com>
Subject: Re: [PATCH] drm/displayid: fix Tiled Display Topology ID size
To: Jani Nikula <jani.nikula@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -0KaDQrurOxVRiOdA92bEy4YJ3b_Ie6sYloQK3bFXFk_1781125826
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

On Thu, Jun 11, 2026 at 12:16=E2=80=AFAM Jani Nikula <jani.nikula@intel.com=
> wrote:
>
> The Tiled Display Topology ID of a DisplayID Tiled Display Topology Data
> Block consists of three fields:
>
> - Tiled Display Manufacturer/Vendor ID Field (3 bytes)
> - Tiled Display Product ID Code Field (2 bytes)
> - Tiled Display Serial Number Field (4 bytes)
>
> i.e. a total of 9 bytes, not 8.
>
> The DisplayID Tiled Display Topology ID is used as the tile group
> identifier.
>
> Update both struct displayid_tiled_block topology_id member and struct
> drm_tile_group group_data member to full 9 bytes.
>
> The group data was missing the last byte of the serial number. I don't
> know whether there are known bug reports that might be linked to this,
> but it's plausible the last byte could be the differentiating part for
> the tile groups, and fewer tile groups might have been created than
> intended.

I pulled out my spec, and indeed I can confirm this is the correct reading!

Reviewed-by: Dave Airlie <airlied@redhat.com>

