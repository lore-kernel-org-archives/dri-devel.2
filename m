Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2CDC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:42:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8B0F10E583;
	Tue, 15 Sep 2026 16:42:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="OPS9B9VO";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B97B10E583
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 16:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789490560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DLlkjfOuya7v+DEz1a4h/J49rgyXuu2hbrUFVJeEY/s=;
 b=OPS9B9VOMPab5aoyTonSF49qVAYt3Sd3GcFcbOdYt/6jPunRnxU5MBlz65c/Tvil2OFJJG
 TNKChQ3GKvnlYNMW04cffEJKIFPnp63Xs9IOC1HQ3iSqS4GtzmsWQcGamBoUWSNv3nIHYg
 UAiWZQbPdM4f+2e3m5DmkkPFNo66mUs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-oZkL0fDHOM-AAY5H_VmchA-1; Tue, 15 Sep 2026 12:42:38 -0400
X-MC-Unique: oZkL0fDHOM-AAY5H_VmchA-1
X-Mimecast-MFC-AGG-ID: oZkL0fDHOM-AAY5H_VmchA_1789490558
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-912348a0ffbso12984916d6.3
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 09:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789490558; x=1790095358;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DLlkjfOuya7v+DEz1a4h/J49rgyXuu2hbrUFVJeEY/s=;
 b=wPcRDkrd2gBd72qqNW8q9Oec+W3lOh1tVfFVU8wM78yz4U0YkARiV8v6aYsmEDSE8+
 WjgeveQM9sdjIx/mAzhZwrlOPk1XFYva9UGrU2fe7rM4eXHKp7Rnm/4J2OtNGRJPdqcs
 zlzxqRHuaKrlu5xFr4UvP0SzmmIWtj93wgp+k79TYEaoF3zx/isP3zIBzAMN+z9Y5l0o
 n//KICaz8hA45KxplrCma8ByO4HSB6N7Ny/slo0Y0yxx6w9/PWZ3pJ5tmFr3k81uzbos
 b0Z5NYmyyY1Ft7eBwRRUg9Ml9a/NYlCZ6JbZL/rkhjI7fR8MUrCNrvabZGPKT8hOC+V5
 V9CA==
X-Gm-Message-State: AFuF++l0dag7kLpqJtpg9jrqjJLaN7OYLlnOIz3vg3yJUHA+efh71Aza
 7J79+ROBaP0O+V/3aH8Zcxe92SCBx2dJ18OI7SX60LQj7Iw4EFWVFL/y5WbUJamJeyyKjUw5TrO
 NQ56LmNcAd+ZRTAN1oqwL3E9G/SZGRT6Iy36qFIfZqjwdht1mcqxrX1A0SVDqTyOufDnKL8pDNX
 Lo8g==
X-Gm-Gg: AYBFou15eKdFRdrYja1YA+Vhq/5DpncmWHTzslqObH5wONhR0OF3j4BGgOFQav6p5lS
 K37perWjylBQdqIe6818H848xDYVoAVG5cpAbRakKTDfI4lDUjZZxTZ4QYh3eO33yuZIqLnYHv/
 hAwEcYwArraWOS9bG82qHsnLJnXKVDHsSQrUaNOwWLxdbJVu4Hk9TzSrt+82P2UPJAQzgWkH4//
 E2XHNSfFkyxQQu2Li1sjp8Jq+eNE33gNlFFhAL6xycxQTCe+R920vl8W/en/X6FB2gColOzapUQ
 LFEQS/ajk6WdLEvkIFD77PQ/aC3f+LhYtDxnZNkcNbF6Bg/+Levk/zBot+aDjGlt/7gEWfl8
X-Received: by 2002:a05:6214:5012:b0:910:49a5:346e with SMTP id
 6a1803df08f44-9123a41e15dmr28824716d6.5.1789490558197; 
 Tue, 15 Sep 2026 09:42:38 -0700 (PDT)
X-Received: by 2002:a05:6214:5012:b0:910:49a5:346e with SMTP id
 6a1803df08f44-9123a41e15dmr28824076d6.5.1789490557581; 
 Tue, 15 Sep 2026 09:42:37 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9123be61d17sm2634486d6.14.2026.09.15.09.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:42:37 -0700 (PDT)
Message-ID: <13440da22f31b81af4ac27471ab6d10f1523018f.camel@redhat.com>
Subject: Re: [PATCH 1/5] drm/nouveau/gsp/r535: Add support for
 INTERNAL_GCX_ENTRY_PREREQUISITE
From: lyude@redhat.com
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Date: Tue, 15 Sep 2026 12:42:36 -0400
In-Reply-To: <20260911223650.8F0F61F000FF@smtp.kernel.org>
References: <20260911222428.752641-1-lyude@redhat.com>
 <20260911222428.752641-2-lyude@redhat.com>
 <20260911223650.8F0F61F000FF@smtp.kernel.org>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 76KV2xfXAN8YqBImWwFA4UvkPNvjTeYSI3RtECrAweA_1789490558
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

On Fri, 2026-09-11 at 22:36 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider:
> - [High] Negative error codes from `nvif_device_gcx_ready()` are
> treated as bitmasks, leading to unpredictable runtime suspend
> behavior.

Probably right

> - [High] Hardcoding `r535_gsp_gcx_ready(gsp)` bypasses the GSP
> function vtable and will cause a NULL pointer dereference on non-RM
> GSPs.

Completely wrong.

> - [Medium] `nvkm_udevice_gcx_ready()` bypasses the ioctl unpack
> protocol and returns a positive bitmask directly as a return code.

I think fine? But unsure if I actually agree with this, if anyone has
any thoughts on this let me know

> - [Low] `GSP_GCX_ENTRY_GC6_READY` and `GSP_GCX_ENTRY_GCOFF_READY` are
> defined but never used.

Correct

