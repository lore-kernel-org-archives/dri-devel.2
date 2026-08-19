Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149EAC5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:31:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7287F10E094;
	Wed, 19 Aug 2026 19:31:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NL257vv3";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42CD610E02D
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 19:31:25 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c15cd3fd760so193492466b.2
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 12:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1787167884; x=1787772684;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZvM++zWE35JZ0EuwwCczeFEIRqyaMO3WW3zX3kGMupw=;
 b=NL257vv3d+DlH6HvTJhp0JpyT65mbPA+TTdXCgMCCGCiX19omuKD+k+AZwlBdSkMFD
 pY5IlsW2yU8YE0q7ZhfGuWBmEt/+RxwzgFJIoG7U2fCAHp7rpHVBdgh+Guh3r25NMCXA
 KVp2F/xi3ttuLjbjTEn3WmNPaSZo+uPPpfHrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787167884; x=1787772684;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZvM++zWE35JZ0EuwwCczeFEIRqyaMO3WW3zX3kGMupw=;
 b=JW4FqBBtN6VAiTsI0imTtiKuUAnlUvtLlmZ2tK6YGejnktUF7Q7ytqDQRreT3IiP1z
 g5zKH1Y6763qG/PYFAC6UAWcor6T1gtCxyOWL3qNzKuZk2eWEYnUWp0LPH2j535hR1yx
 Myaf8/enRT2OXXkGMJ5WUCbLA1HjE+R8vUPi3UkKajnGf94W8pDOub+gW5k5qkfY4uzt
 B3vsj0can94ZfamQgcHp0Zdds9WfK9bgQtD+CiK6D8lVsAmEmIY2SGFbizRxm7ZeB9ux
 /ab1piQ0ic2XOKPS9KJmq/lkWwag0wIcUXEiN/6kq45ClAlFz05alHu7iOum75Q1eR6S
 FI7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2xWqG2Pvu8ITJxACkTzeVelUKClRZQxIp6JGBZmphFkh7je+UK75Jlg/CRyAsKC/+VBKp9W+Szm4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywkr26vRHtNhnRJTxWOXKBxuYkJz5HMcJw5N/TTs1VbXctAtzot
 uvbvr0N04kn8J46+dyflnY6a92CxdbUMVHc6Ik9a/6iEQSDsqZLI3wCM7jJTG3IfXOGb2DWVNx4
 cgQT1MNc=
X-Gm-Gg: AR+sD10FCjsJldTTImjoPpSqZzfbR0KRkgpST35RQqiBpMvhIN9vfgU7wTfS8jZZe/M
 z5gVx8v4EYBaddCkyvOXPNxWRkX5awTQP7yhtg4jpYEL3KW48vgk0+p+nPPx4LFEM3L65TNcXyx
 F187EUauHTgf8vwI1elikVEyu7el95Gm8ObH1qcYTy4Hpp+NX5ZpkqiguwAiPFPGStR8WgaPLqO
 blEYLTR11Vbjti5Wi16o+9nQPrt49iZvLysL7NRzdguzYlrENIsrEhrOviWwwQTSfwOK7FinadE
 Y777jng7dHuAj5D+ZxqnPr1TSQ4WkgqkqO7thMoa9iQDNZnnypqTILpo6fqfhwa5jwK0n9KhjRd
 4DoyEBqN9bQjEeNjDfBMHCgMLgbVm6YJ6aBy3YDI51ZcTfs1wF+OjHg5MYqshtU2SXbRVc3v1ft
 mYSjpHzGMgxXb6W0nMM8uYkY+irhodJKLLCY94jd6YD6QxEoilMuk5V0347ieSmTDQMuYJDBg2d
 e0c/WJ3DjoRpkv3TaER4Gx1C4JUY0RXLHzzIg==
X-Received: by 2002:a17:907:a643:b0:c21:7f24:968e with SMTP id
 a640c23a62f3a-c23e87191camr543241566b.11.1787167884149; 
 Wed, 19 Aug 2026 12:31:24 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com.
 [209.85.218.47]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c243c38b029sm112204966b.47.2026.08.19.12.31.23
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 12:31:23 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c15cd3fd760so193489366b.2
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 12:31:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RpwZ7lL/tDh72Jq43Z2AzD0jirpTm8tISWrA9new5jen1tqXXxHIyAKoGnx7MmkDZCwXIssKpgjZys=@lists.freedesktop.org
X-Received: by 2002:a17:906:ef0e:b0:c1c:5aa1:de57 with SMTP id
 a640c23a62f3a-c23f92c35edmr510964966b.13.1787167882929; Wed, 19 Aug 2026
 12:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whiv=b+dAvjaZDsZkfUEzjZMSSLExDOWVcbJ0exsCj6_Q@mail.gmail.com>
 <6874536d-ab1a-4dd7-a23f-2a071bda145e@lankhorst.se>
 <CAHk-=wj5aE1yVMb8RM2AuNUHSMnQDaGT+Vy+At5ds1vxBA+Kng@mail.gmail.com>
 <ahDAErDSE-SFA0oM@intel.com>
 <CAHk-=whX59mtUnU2ayMWoDQX6Ee2NXLK2NxQ+dZnb-Qc_mF1hw@mail.gmail.com>
 <af9278d3-4002-4e09-9bcf-bc75d1cf8145@lankhorst.se>
 <CAADWXX-pfvA3mKWSjdahnihAXHQB2VP9BOJDCXonG3Q_nxurLg@mail.gmail.com>
 <anYZ8nUFP5dnRy/h@gsse-cloud1.jf.intel.com>
 <CAHk-=whyk2-u_1bTh5ZTeX6jW3HgAtjJh0mV_oWtgsqCe=3w7g@mail.gmail.com>
 <aoWHKmz17HQo2uy5@gsse-cloud1.jf.intel.com>
 <CAHk-=wjv7SCjtg6JGDabGMXdqobx+WHogHfQeMPF2g_HmAU5qg@mail.gmail.com>
 <CAHk-=whskfzdWdUs3NwYm+e9py91xdiG5mLfYf=g_6QLpdaP4g@mail.gmail.com>
 <CAHk-=wjr-6qT89G6TLAPPYpzPbq-JYS0C5e4i_KAUXwNzeStzQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjr-6qT89G6TLAPPYpzPbq-JYS0C5e4i_KAUXwNzeStzQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Aug 2026 12:31:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wij8MOxRrWqeCWzAaFr=zcDxOiXu_2jwAwagBxyN35Ekw@mail.gmail.com>
X-Gm-Features: AcwNN1XhQOXFxxzSI0Z1whZuW1PyyMF-vSEMPXVZhrPSBP5oHt9tD_ds6YZfnMo
Message-ID: <CAHk-=wij8MOxRrWqeCWzAaFr=zcDxOiXu_2jwAwagBxyN35Ekw@mail.gmail.com>
Subject: Re: drm: xe: Kernel-submitted job timed out
To: Matthew Brost <matthew.brost@intel.com>
Cc: Maarten Lankhorst <dev@lankhorst.se>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-xe@lists.freedesktop.org, 
 dri-devel <dri-devel@lists.freedesktop.org>
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

On Wed, 19 Aug 2026 at 10:25, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Update: with a single 6k monitor and no rotation, it works.
>
> In fact, it seems to work ok with a single 6k monitor and rotation
> (orientation: "Portrait left").

Ok, that was not true.

It's the rotation. I can change the rotation dynamically, but then
gnome - or gdm, or whatever - remembers it, and the next time I log in
it will hang at login.

So even a single-monitor setup breaks in the landscape left setting.

                      Linus
