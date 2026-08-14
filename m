Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DEFC5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 18:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C44610E19C;
	Fri, 14 Aug 2026 18:35:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="hmWIu3zb";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 915F510E19C
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 18:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786732502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qTlxxfWDmvssP2owx2iEAGsDpou2bfInlO5vwknPmDE=;
 b=hmWIu3zbqW/tujAjKlRUFoIoDIGgn8L76kZi/VXVVEK1EiMx16C8z8+EkC6skT2FTNu6kl
 GcN5lG/LP7P5vRrBIUJmKYfylf1i+Z50L+SsPsK9hrJ6KMo22jTCR+LV9tZfXKvkGKVaic
 6JZJrmItC5CN4QMz82dFcgaKAfX0UTU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-W_DLzArwPVeGoqq-PbqUvg-1; Fri, 14 Aug 2026 14:34:53 -0400
X-MC-Unique: W_DLzArwPVeGoqq-PbqUvg-1
X-Mimecast-MFC-AGG-ID: W_DLzArwPVeGoqq-PbqUvg_1786732492
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cab3e9cd922so874070a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 11:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786732492; x=1787337292;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qTlxxfWDmvssP2owx2iEAGsDpou2bfInlO5vwknPmDE=;
 b=ac7GdeDXROHeEuqey1necC6ionsJqDk772yPKa5YuVfalNDBSaR4NFgSOW9216gjAo
 h6OG2WPDO5+XfGgnEuGknofAxM3gKip/pJDXIOKiiedMlBsOlGrZ8NOZ17ylVtVWkH/r
 6epWsORdv1ZsqFvsa8NH/UN0vAkQxU8fXUCkzDwCvGl7HBfnj1T/IxpUgfVJ4/c1L7vG
 qxrAsmpw9MBSn/M0rY9L4tO6hxp8ee5Y0dI78Pc/nLYWIm5BKgk+F5QRYCmhrGAtlMom
 eSeful63Bwwyre5DbbR2LvfhmVZNIGIJcfNAvs4Wi3a1CJoRPhK7wyArWh0s5FQtN5On
 J2xg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq7oNo9fjYYZFofAmr4pN0cFQ4gTildKSxNgrPlYusoSsspQMOFI6TvMkTHk4NDy4aYXtId/vqGz/c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw5s8J/uDD9dimR5Yb8OGwaDJAVxLHxg6p22BbYfSo4CDzn15LV
 JZfor3Ue7tlLgZieT6LbsAxquMz9am/PqA2M7gtE6LphVIrPr0eQuN6BFmwP9puXGzHiacMz/og
 WNMAsTeQwt4TNf4OVwcqs1wJIU4ofnq0dmbhbLpoAB50M59srIBIDBuydOjkRjI3YGQJudw==
X-Gm-Gg: AR+sD11B0tfLTR/CtLNxBkEhP+0PR2WanYmMkyIHOTw12PxVyQ6dnI7Sgkml0d15XZU
 a967LMoUy6Jm9IPZH2cwToiR/WNh9fALShkdRhNE0HkTqRgvPd0bhEn2thA5Zh1Fpypqg7MEpvh
 coKnmBNAfSG/dPznJDMmXWiq6mGlrTL5IoF25MkGsxbz7jJHedGHx20vdAF9npU4B1ZHWW1W1r1
 1FFrelpGXhobTxqbRf9Ca9jkMokFnurVKpZ7Sxel2e+8yqCLOraYYfx9HMcbjGDwF02B1JQ9EPc
 mdf77pUGREZQ1E4s4wqgw+Wf2lV2bVBpSI1m3VxblARDj1jX883OH6rjcmUjOfyGjgD8X3Pzvtz
 tAikRLESQADIhK6JQWuY1AicLqzEjeQ==
X-Received: by 2002:a05:6a20:d4b:b0:3a2:7ef4:81df with SMTP id
 adf61e73a8af0-3cc71cfd038mr9474641637.26.1786732491572; 
 Fri, 14 Aug 2026 11:34:51 -0700 (PDT)
X-Received: by 2002:a05:6a20:d4b:b0:3a2:7ef4:81df with SMTP id
 adf61e73a8af0-3cc71cfd038mr9474571637.26.1786732491044; 
 Fri, 14 Aug 2026 11:34:51 -0700 (PDT)
Received: from localhost ([181.122.135.46]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320ea8fe4c2sm6425438eec.29.2026.08.14.11.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 11:34:50 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Fabio Piparo <holofermes@gmail.com>, dri-devel@lists.freedesktop.org
Subject: Re: drm/ssd130x: stale pixels when the GPU renders into the
 framebuffer
In-Reply-To: <CAB3Lz5ZuAJcgKpx0L-O3a-1psk+vwBMeH_Eux+OAgaYcyfFm6A@mail.gmail.com>
References: <CAB3Lz5ZuAJcgKpx0L-O3a-1psk+vwBMeH_Eux+OAgaYcyfFm6A@mail.gmail.com>
Date: Fri, 14 Aug 2026 20:34:47 +0200
Message-ID: <87v79co8jc.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O24pSIPp6wgB5sMi56fYR-b5Z8yeT_UvvWeZtcQ21qc_1786732492
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Fabio Piparo <holofermes@gmail.com> writes:

Hello Fabio,

> The symptom
> ===========
>
> I am working with a Raspberry Pi 5 driving a 128x32 SSD1306 over I2C
> through ssd130x, brought up with dtoverlay=ssd1306, and a GLES client
> rendering into it. The GPU renders straight into the panel's framebuffer.
> The panel shows a blocky pattern that is affected by CPU load. The kernel
> is 6.18.39.
>

Thanks for the detailed report. I'm on vacation until September 4, without
access to a SSD1306 and limited connectivity. But I'll take a look to your
email in detail once I'm back.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

