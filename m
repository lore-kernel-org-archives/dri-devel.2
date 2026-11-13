Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBBA606A32A
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 00:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A7PYtvUe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13DCA10E137;
	Fri, 13 Nov 2026 00:22:53 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25DB410E137
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 00:22:47 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-6b56c428212so526711a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 16:22:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794529365; cv=none;
 d=google.com; s=arc-20260327;
 b=hs3XhmLjJF3p6uaQbVAOXsUyzW99AlrcENFTuyxKfE1swA1Db2BpnMZ8/7Q3n8NkG2
 JMPGDjRhvcjyZZlm1I0GTsbQnOmXHPgWa7GkqLdNf6jUi4CKg53UIvM0r50SeQebFjcD
 jLwqF6sm2INVsI807/E3m5BcfAbihbcjWGMAuFoXSfktx++mlDP/i37yGS3GPg0B4Vvc
 XVguUWKRRi3mOaO+7wghK1xxZTiJmBLnLwkGCr4WH6naQBYnoJWNlWsKPm/uOmBpQX52
 lC2fZsp8GquA+XNjbYm9uWRyVuUd/GBHVX68Bsa5p1bmgWUdpNRIzGPiG0ZH+uYFUy6W
 bFaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AnmRYcOvOXVbMMOVVQI4OpXWX9/VfD/SJkN6Kk7rXKE=;
 fh=AjMNq8ZT6X7TpsNuurjxUAMiDfbcE0kByPJ35/mmxJ4=;
 b=QjCxggOt5ro0u1KLdPsXmnEjE2LRFPYb6RC9hFmn03v4uFsugyX5ZppSQ51OH0p6fP
 uVwA7zrdAf02bbxEL5vj8mEd6nGP/sD+DQ0X1B8eL0HsRweWC9C+tjj8qaAvG/c6Ypa8
 O17gGddwxJeKNrr1KT5lYek5XuyTYeGgrHj1CQOoEgZ387xZ3JMQX6V27gEAaSKieCh2
 FYwhLa6WWYgqtabaSoU8kUlrdEuTqGinb+PHBAzLi1ntvX0mVpeMV20aqFk7JIKBq+3N
 IlDcjGv+mPhi94/82jItvX7M2aqxAnEH6Sx2yVMts1Kze21p01ltuiAwZOv/4li7x+hi
 djxg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794529365; x=1795134165; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AnmRYcOvOXVbMMOVVQI4OpXWX9/VfD/SJkN6Kk7rXKE=;
 b=A7PYtvUewgD7XxtrVD5YoutA7p58R9r7r6WlaAAuvRpTHuVhM5wxiw6jgyCJyysrKm
 WXFmrfLedXTUuBdxdiMQfeXV2ZS3Z2XQuhf93oR+6biw3rzBRe9ud6vG3Z9SU9jOFi5E
 fUH/wTMlm+EZ2dacSqQAlrvT1qjHNX3qIDDpTCh/K0h3OfsxZmba15+atNTuY/5jbfMy
 +o5jrEALyLC21qrjbGS1XXPhjHSSl2+ZBOkRZ7Csv3SMsJakegBHSjs9KDzxPYkwtFpy
 r/34QtiiTHZLESGWL3GCZcaaXonvsfKW4MYovoavc2rUmtpovio/6EFgMjq4WV1uuFqw
 sI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794529365; x=1795134165;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AnmRYcOvOXVbMMOVVQI4OpXWX9/VfD/SJkN6Kk7rXKE=;
 b=ZGw3Dp3qz/iAo5bwKMqU4OYe7LHEcEqE4WeEgtRcWxIeVj0la7m+7MHKegzOIXVC/0
 zl1hGhmyP1eBdyYk/VqY6qeh04w+kVNkKdUamcFnoRS7aEu4nLeOYy2n/WjRk4DjN3YY
 2/7OPv+VThtkPFQge7aL/08oLHrIJ8YSc5WmLhnVdt3PPBHoxfKvr628jN9IqVnGs2g6
 wNVRNSftp2HrCPGJfKf/9v89ZgLCd18YKj7Np/PGvF6RSX9n8Mu8Fl3E10tkHex6PzJr
 720b4jOKfC9IQ+NWqvdvpogZNksM2I6fcIhW/X+pPO/znBHwcY9TJ0UzpIYIH2mo7o0j
 NYbg==
X-Forwarded-Encrypted: i=1;
 AL+hErGHbPuyl+zWj4R6cO6Hzd9fZkOTsDMigUCvlt/5Dj4/PxKHEoK9MQkWDKfEK4c9YdNGf4pqaDenl74=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/EUIpzAQ3xCFBu5yU3gC8QPlZvnax9XzN/7THCoalqXpBy+NIb
 vumOtt37cVg2WWASVv7goSVI1wrEaLsYeNEpWJ9/EbXxJtYMkP7BMkbY6Qr0FswMREWN61XYFvp
 9fvNZZaB6QO0u0sTjJQNkksYuguUODjE=
X-Gm-Gg: AYBFou3MI/zLOtoZTloN7qOkAWh04jRxZ8p7z6+JqQ481/IxP0WTdPm+iHDd04eQt67
 tcMJM4RxDu6mO90ktyADeCOXD63nq10ETIiYAay1dJdcf/nALTW/P16kXbJ8Zu+pK0TXdjWOw5K
 vT0BYLJbn2hCGdnRbifKbQfO9TSsk6BHYwuvuh/mdfGYc/4ehVX0s52gLhXOfu7JGc4MCUd0SWL
 RSMixvv9Rh+X22AZVBxGuZw3DsfZDWSojRr8h1iUad4xuNexvZStHBlwXkXjlLXCLY/svhl3Ukh
 8a6p9h+6Jn3Kz3XV+lby9NB2uF8I9MtkKxD/dG8L5UX3RgNhEKXiiATNOj/p+e1Lv2GMRN7a5dV
 OHvKTUXF+LW81frggBtu65zBvMkwdi+/47qJETw==
X-Received: by 2002:a05:6402:51d2:b0:6b7:aebc:fe53 with SMTP id
 4fb4d7f45d1cf-6b7c0c6fab7mr816211a12.29.1794529365073; Thu, 12 Nov 2026
 16:22:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAMeQTsb4+9NiSYzWVWxRt-_Q-t3E8qsC1jb6E_xD3ruGmao9Cw@mail.gmail.com>
 <20261112200219.6239-1-joseph@telaak.dev>
In-Reply-To: <20261112200219.6239-1-joseph@telaak.dev>
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
Date: Thu, 12 Nov 2026 21:22:32 -0300
X-Gm-Features: AclHuK_R5Jl2j-1TqLJQdm6sY5zfEHhOatn_JmHRM2b0snDQAWsKl8FK9Lux1iI
Message-ID: <CAFGNeajWk0aAnTHyHFmp+gEYJi_RMcLkw0s6yenBeZgT6uF9gg@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Joseph Telaak <joseph@telaak.dev>
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="0000000000005822bb06601d6dc3"
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
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000005822bb06601d6dc3
Content-Type: text/plain; charset="UTF-8"

Oh nice, I saw your RFCs here!

About the SGX544MP2, I was thinking about making a separate DRM driver for
Clover Trail+, since it's quite different from Poulsbo, but I'll take a
look at powervr_sgx too

I'd be happy to compare notes, especially about PDS and MMU stuff

Also, thanks for keeping me in Cc !

I've been following your project for a while now, back when mine was still
mostly documentation

--0000000000005822bb06601d6dc3
Content-Type: text/html; charset="UTF-8"

<div dir="auto"><p>Oh nice, I saw your RFCs here!</p>
<p>About the SGX544MP2, I was thinking about making a separate DRM driver for Clover Trail+, since it&#39;s quite different from Poulsbo, but I&#39;ll take a look at powervr_sgx too</p>
<p>I&#39;d be happy to compare notes, especially about PDS and MMU stuff</p>
<p>Also, thanks for keeping me in Cc !</p><p>I&#39;ve been following your project for a while now, back when mine was still mostly documentation</p></div>

--0000000000005822bb06601d6dc3--
