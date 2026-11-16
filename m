Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A593606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 19:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 058DE10E97D;
	Mon, 16 Nov 2026 19:18:50 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 300C110E97D
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 19:18:48 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2ee2072d1e7so11108245ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:18:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794856728; x=1795461528;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zxHFwiv2CGegSd5vdPBzRBrEsd+qXRKR2vTM6hfQEMo=;
 b=zcfCJO5/OsUH7KyVzJRlnW5AuH0ljMTLXZxjJQO50YH5MxVGp1JutgHEB/4SnRGAEx
 s0zJo4bRXPQtIf2JdpWa7Ou5PUKRlNHyXwZOexYmR+i+MX4obGebOmyVELCHn+BGEWao
 graisBWMK0XSdVhPo0eQCA8xaA0bKvljsXaTvn5oK7XM6nxQd2euT2mVSaPAd/rGnNuB
 Q8wCPIhKlPMs5X+V7dLMMxrTbgjNlbUgVlep0N3dy763gkaBVpx2+nFM6JTjTc5pswjt
 uhhKJQZt/rwG9mbBzKOua22e+ppgP5r2vPxL++bfc+dv6S68tJc6sTWIhmErMQXOBvMQ
 G8FQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGVw0w2U1xasen8cY1f5i43HF1op7tAMozPdM5FFn3VEuy9C+kzmAfPLScLTQBwo1x5Ej3vW443VLQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9MQ+HXlvZm3exLGzek1VL5VEhQ7g/E47tUaAhWsKTP7uPz8fU5
 iWHSJYKztTyoLqQbIiZ7QsKTsmvce32moeptgUEO8nkLy/Ol2Cg6qHyNFNM+ruGi
X-Gm-Gg: AZFdTZfhhHxw7Isgb/MtAvKp3v2OgdoBNc/+k00Hx1QdGJkjw2REz/WNA0cH1mngjnu
 0jqDrGyXmBFAp1fwwX2U8/HcEDHnJ66re+cjX8mDDUkcFp+gEMCp9xDj2GSYy5DyrEyJ9n66i/E
 3/7VjsbSsdM2K4tMFOMQnyVYpWznSXUTodYNgwBn76NVj/DMY4x125pASaTpvxBi+Q5BSkroNkd
 gwctkQIq2E85NRAARD6jg/BHyJaqcWGXSTF1xl7rY8bqlW0BZ+VGYNj6wL+Vjo0p2ykVk0Poc2Q
 7jTfZzRyFFlSatAQb/zE/brmVc8g76rMaxn7zh4yulvPJL4MgXMR9vt2vKrrMK21Q1Ma/tsqU1j
 7YRtYRY9nId0WFoV/ONxe3YOFG2krjfD42Jpq5D4l175+62K6ibSdH4xK76maXKaY+noqfZt9tx
 s59SkNXjp4jLE5V8uNceZB8giun4C5nUntGr0/Q4hccLleMniu7xcKRxucUFVeZ55LGTBLMsaTO
 jWlZHUtZAf+51CBgJI0pS8jV7Hu/tyJMfC6fmZL+zCH6xS3haWB2RSCXu0MqpP2la7MPUoC6ZTK
 jhysPzKoYcePdnYnK6IYsfUUiIJYtwy1i6yRL9jiRZUDfONZrKdDNb2P5qvrGepYHn+++bLQn+P
 VziB81lPnN2YTAzcBCVApzNfiKI3Afu4skym348/b8eJa
X-Received: by 2002:a17:903:1905:b0:2ed:2176:2452 with SMTP id
 d9443c01a7336-2ee0da7c0f7mr106671175ad.18.1794856727555; 
 Mon, 16 Nov 2026 11:18:47 -0800 (PST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com.
 [74.125.82.181]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2efd7a364f6sm3351895ad.27.2026.11.16.11.18.47
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 11:18:47 -0800 (PST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-36eb1cb7aabso4670447eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:18:47 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErEg2dJNIE+3Ay1R1cdIb6BGOhysVypqkzmiQEUSw0W21+y86gldTcT1c1L9ubenOrLuq/dq6j2ikKY=@lists.freedesktop.org
X-Received: by 2002:a05:693c:895c:10b0:35e:f1a5:9ba6 with SMTP id
 5a478bee46e88-37963a4f1femr11450893eec.5.1794856726547; Mon, 16 Nov 2026
 11:18:46 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAMeQTsZbLYpPKySm9ubYc8pw0t62ZEdKkkzc4h3Hdjq-9pGO6A@mail.gmail.com>
 <20261113085341.61992-1-jttelaak@hotmail.com>
 <CAFGNeajPo8DrqNbM+86AQz0LT98a69_+T7R8DoKAX4Q2LJE0kw@mail.gmail.com>
 <CAFGNeage70+BaM6SP-q7YAgp-tgrATuO7m-eEoN6ERr0mC55aA@mail.gmail.com>
 <17f2783e-9157-458b-8463-f98395e391ca@suse.de>
 <CAFGNeagxEcfPuEHFt3TxKhCDoZ0HODpXwXcKpuBxKK=09FkRMw@mail.gmail.com>
 <CAFGNeaiYntE7dQ=-sgaM8gRKuZ+wQ-479ShXKW8v99YVSdHn5w@mail.gmail.com>
 <CAMeQTsazkHgYiCnSEC67useW++0WEY8E0RS1ShssWybrWCGuiw@mail.gmail.com>
 <CAFGNeajczb-2Xcjfaj82hc-hprJXRHsr8uSudO32j6S17T+YQw@mail.gmail.com>
 <CAMeQTsb-Tjzu6i8Fa4X6Ta-JdRPd6vf--eEePTzZKvPuPX5GGg@mail.gmail.com>
 <CAPY4CJ5=+fXRX=29uS_oxwVQxstAf4WoFNVSYaUiYmWEjar5Kw@mail.gmail.com>
 <CAMeQTsab5H7F5CFvd_XkDndmMiBXRSYBhrMHAf9jynzEqaWp+w@mail.gmail.com>
In-Reply-To: <CAMeQTsab5H7F5CFvd_XkDndmMiBXRSYBhrMHAf9jynzEqaWp+w@mail.gmail.com>
From: Joseph Telaak <joseph@telaak.dev>
Date: Mon, 16 Nov 2026 14:18:35 -0500
X-Gmail-Original-Message-ID: <CAPY4CJ4Pq0gXUdGiEp-6srpVUBxYUXPQgOAJr1PJK3SeVn_Rew@mail.gmail.com>
X-Gm-Features: AclHuK8h6QI-51yrr7G_6lZmQka90FoYRpoGNp3DNyyiY1h9T4AVod2xbsHsdAU
Message-ID: <CAPY4CJ4Pq0gXUdGiEp-6srpVUBxYUXPQgOAJr1PJK3SeVn_Rew@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Gabriel Gama <operatingsystemsdepression@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 9:12 PM Patrik Jakobsson wrote:
> Thanks for the clarification. ImgTec have released an open source
> driver and documentation for later versions of their chips. Perhaps a
> way forward is to ask them to release the docs for SGX5xx?

Good idea, thanks. I'll ask them.

Joseph
