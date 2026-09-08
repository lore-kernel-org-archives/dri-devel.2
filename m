Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E751EC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 12:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 195E610EB8B;
	Tue,  8 Sep 2026 12:03:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Jt8PqJxe";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 949EC10EB8B
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 12:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788869028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IODJYP/ZIU5mRLLL1EclU6BuZdFE+q0XDMOw1Hy3TOU=;
 b=Jt8PqJxe2GclnPJucOyCni7bBT8NEzbvEAnAKb4hiJVNIC4E//vxEIBmqjYnR6svTd3A0e
 5YYCmajqGyTg/HCPo8vkdfTWj7fytgZdZBBYcJn277HJwmwxKaXc6KfGk3HN48PGAhw87j
 uOGzbNZcphFEIXCMOgeCnyG4hh1DQEs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-Wi-bsV3nNUuWey00BZaiwA-1; Tue, 08 Sep 2026 08:03:47 -0400
X-MC-Unique: Wi-bsV3nNUuWey00BZaiwA-1
X-Mimecast-MFC-AGG-ID: Wi-bsV3nNUuWey00BZaiwA_1788869026
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49cf5bd2f12so62005045e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 05:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788869026; x=1789473826;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IODJYP/ZIU5mRLLL1EclU6BuZdFE+q0XDMOw1Hy3TOU=;
 b=dqd3V529CopbEX8Rm2311i1zHTLXPnl53JsP2RcqlFOP3d6SlxRAzvg4TjFsTO+W93
 HAcEVOOeC4B1Ca7sqtWWld+yb6+sWZyQjGLQPuVLgpiiaLZQVzEHHPSijFHmN9Ke52ja
 IUlUc+ieT5Xyfo6jfniQHzIIEXtdS+bF51VHZOuf6kD2vIxwxDdsHz1XiQSVmn24NZA0
 sJvfne2oUeDcv+S+X5ymutpnEDSVxPFQunbUOj44lacRvrcbEgvlLgJLuFI1WvjWGTGm
 3tiXFCtZZciDwrTuQgmhpzqU5JZH3B78XbIK6MwnYcHK7S1qNMkgeaoDR3kWBCXiSRwG
 gFcw==
X-Gm-Message-State: AFuF++n9YCQDnfSzk1+Ru6PqmbuHgNsWtjraDsqpOIGjn1QkAgc8JY2V
 lh9q9rx2YbKtBjoUplhv/qOfR1/68Peb0R9FVXsBuSnC4nxqdjKYDEFym4LWphZlNkqrRvFseeg
 L+qif+cT0rJuoTKYBxri/o8WM8GAIk86W+vr1ymr2N7Tw+3JsU0yQd1/oO/MWvjU3a2tykDQw0t
 HLFg==
X-Gm-Gg: AYBFou3w0PFB38hkftnQpcN0gbbXklR1bMgTIs4GDG2JIJniexAgeC6bW3K9hRIPyx6
 6uTDdr4cHMO/IuCOpEPCgf5UMys1FhljD1K3ytZPzuAjaDrq37rjnPqXr2USidIklPpx8ywj+di
 04riqaUFEroZFCFxkiyNnw6xiBQ/93ngVWBwRzChZYohUveoP6TNFz+edNMMNUOMI6OaKG8qI7o
 lBoEeU4rXMzInDmOiiPqh0B4LgYh+7m7p/h3XUo+zr3IkVHlimarOySuYhrEUSPkCFzpC3qdPjZ
 u1Z/gWZQqP72w4Bg8gpyhXvJ5aNiLrnR5kvU1VhyBoGp6Np7DXcXmkd4BKmhJC6IMMoGNl20tLk
 rM1LDIX0jSmLfoHd0KnigfqYDIXLstEttsbge401Bui3dUL5LwWoKJnmmBA==
X-Received: by 2002:a05:600c:19d0:b0:49d:1840:4fd2 with SMTP id
 5b1f17b1804b1-49d18405074mr50611385e9.23.1788869026364; 
 Tue, 08 Sep 2026 05:03:46 -0700 (PDT)
X-Received: by 2002:a05:600c:19d0:b0:49d:1840:4fd2 with SMTP id
 5b1f17b1804b1-49d18405074mr50611055e9.23.1788869026032; 
 Tue, 08 Sep 2026 05:03:46 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d476esm519539055e9.1.2026.09.08.05.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 05:03:45 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Fabio Piparo <holofermes@gmail.com>, Amit Barzilai
 <amit.barzilai22@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/ssd130x: Set the address window in
 ssd132x_clear_screen()
In-Reply-To: <20260818191200.1300413-1-holofermes@gmail.com>
References: <20260817152500.703770-1-holofermes@gmail.com>
 <20260818083143.37939-1-amit.barzilai22@gmail.com>
 <20260818191200.1300413-1-holofermes@gmail.com>
Date: Tue, 08 Sep 2026 14:03:43 +0200
Message-ID: <87se3klzkw.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8CHvOqmbMsI4bzXCFRxBN2b5s5RMoTYwE3YVnL2mWwQ_1788869026
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

> Agreed on all points, thanks. I'll send a v2 with the set_window helper
> and a reworded message when I'm
> back in September.
>
> Thanks,
> Fabio
>

Thanks, I said that would push your patch but I'll wait for your v2 instead.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

