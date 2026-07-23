Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A963BC44524
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E9CA10EFF5;
	Thu, 23 Jul 2026 07:12:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="SV3wQnqD";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 704FD10EFF5
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 07:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784790760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=YptBvMjzNl6TXw/MzlIx0RWlhYwnMtV1NARiux7hm2E=;
 b=SV3wQnqDVXQXKHXpeDHe4MQebrCPgkSXKxw5WEvcy2+mVFJPP5aUZX5NVNfDgAsAsCIWSS
 nfFPlWDdoRmpCR+8p8A9tsp4E+DRKp6rezIn6AxftPH6sjchxoPm5U1y/I5gJh6+Pd839j
 FNsXBIo5piKZMVlG5C8cQAy/aSNPAi0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-vA9m4ZcUMK-LyMV-J1fcCQ-1; Thu, 23 Jul 2026 03:12:38 -0400
X-MC-Unique: vA9m4ZcUMK-LyMV-J1fcCQ-1
X-Mimecast-MFC-AGG-ID: vA9m4ZcUMK-LyMV-J1fcCQ_1784790757
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-698ae260973so481902a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 00:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784790757; x=1785395557;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YptBvMjzNl6TXw/MzlIx0RWlhYwnMtV1NARiux7hm2E=;
 b=mKoZh9XtYdNAV5NoMQSX+Ucc2B4uQOG0mKT8ISz3f4hO19w20Hro8wn8WO3PpEv8Ue
 VsLHQBNgB7yuLhveA5oT3knsufxxvACPDaPvQQSxi+4lVUSk9QBbM7rNgaric2s4EZ0G
 si6FVND0R5hoZAZ7Dfgh7SZ1+XOWISHDJwtHobdh7SxfK6EsATftHY/xPHDrlrD/oOBk
 4/Jrf4RxODQqC/svC1ggQ0KHgGJEEg2vcEYqv1bKv+aHKUCUN5cAFY2zCzK6yl2zC0DQ
 5LaSZLei6UpYj2Ttm9mvb0Z2wUHf9MKe6D6tENBKUiv4Jcp6YvMN/syoB4wpy3c7A0Mv
 0flA==
X-Gm-Message-State: AOJu0YxK6G84uGPbL98UlfacBs1aSfKELMMiLfyjANq5ppEoz+LzwkMk
 JXwwuxe8UTC1foZXRDD+6dN8397sRqwhFWtg5t40fk8nyJpTrAz+TwVSGf61FWTHCIcfV9mu5Wa
 xABk5oH/7P4CST2aMXmEA9nZKMGUCSjbJ4vDd7u059ztd5ZbDpmclk6S5m8ol+zC41ANqQqoFxN
 mKCFstyiJ5wNbWhzj0Cm/MGfgc0IRDOhzBJaubXT1vxh0X
X-Gm-Gg: AR+sD112JwqxSB9cl2TBHPTN0qkoa3f5Sac9mqHSePBsyoWCHbNTKKd3Kx92klm1Z0X
 NWU57MzIffeh2xUp46ZRaQ0RgzLYbccaYsmib7xCL07cO9jMuI/1BJktyEyl2gsCjYBulnRWrJN
 zzWCgv1y4krRYU7QfxOhFzox5nM4ZcTnajSo9Ye1XR2Li0adm3TvGSBfF6696FpAqyWC52ou+1l
 NdJifOq9RF7wZOyIFA=
X-Received: by 2002:a05:6402:4303:b0:698:ad4b:abf4 with SMTP id
 4fb4d7f45d1cf-69f6bb0da62mr642262a12.3.1784790757533; 
 Thu, 23 Jul 2026 00:12:37 -0700 (PDT)
X-Received: by 2002:a05:6402:4303:b0:698:ad4b:abf4 with SMTP id
 4fb4d7f45d1cf-69f6bb0da62mr642250a12.3.1784790757193; Thu, 23 Jul 2026
 00:12:37 -0700 (PDT)
MIME-Version: 1.0
From: Lukas Bulwahn <lbulwahn@redhat.com>
Date: Thu, 23 Jul 2026 09:12:26 +0200
X-Gm-Features: AUfX_mw3jkq2rIcv_Qw_XooBYnNwtp4_eCT4CRTEjamaj3fRK6HKAwcpHLbBISE
Message-ID: <CAOc5a3NBcpJnjB=Tv3+tjFoD5aJe4dUTH7qmTFom2z7-eDQiqw@mail.gmail.com>
Subject: Concurrent Kconfig renaming, impacting your commit "drm/pagemap:
 Guard HPAGE_PMD_ORDER use with CONFIG_ARCH_ENABLE_THP_MIGRATION"
To: Matthew Brost <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f5FB7BkwzU1z8wDieJRpoDK_A7Y5WUtaYlgXcGInB40_1784790757
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Hi Matthew,

I noticed that the commit 0b6b1bb28482 ("mm: rename
ARCH_ENABLE_THP_MIGRATION to ARCH_HAS_PMD_SOFTLEAVES") on linux-next
renames the config option ARCH_ENABLE_THP_MIGRATION, which is referred
to in this recent commit 04b177544a040 ("drm/pagemap: Guard
HPAGE_PMD_ORDER use with CONFIG_ARCH_ENABLE_THP_MIGRATION").

You might want to have a look at that.

Best regards,

Lukas

