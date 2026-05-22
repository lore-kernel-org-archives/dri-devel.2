Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12ADFCD5BAC
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 20:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F3F110E090;
	Fri, 22 May 2026 20:55:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K6Eo7uY9";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63BB210E037
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 20:55:10 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-bd0209f25c1so1271043166b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 13:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1779483308; x=1780088108;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=teoGmOmvuonVsi8XRn7z1ELueXhQFKoxdcW1mi9qb4s=;
 b=K6Eo7uY9eNWXbId9iftofGBi64zLyKxJlTx5MrYA0sUDNKs1eiYNy3h3PzDfqkHFJS
 3oJTfOC/AaxDkEi2pf5Ks2oD4JV4DQoVJ8usSYUzkIFTMjJiR3iztzjQQKVvh9PEQDy3
 clKmM7x9TfypUaAL8Ckn7CrGKGmu+U+y3Y9CQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779483308; x=1780088108;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=teoGmOmvuonVsi8XRn7z1ELueXhQFKoxdcW1mi9qb4s=;
 b=a9R/LDDHUWkimiU4XLx49b13Bw5w2gTmH3a1mwhb19FaDJh8/p8+id9jL4i9A0IBsL
 dVvFzs0bDxRKt2jxbjfihG0p+Upu5spfxMKhbH+amC4ORB3FGZWwKK8DRWT3l8glwLA9
 ktFRAh1ciTW3kM8YbDK3/pO/SrtyG9NXujgogU6SQ2isoeRACVAnnRHVcop+lFafws6h
 dG5vW7muxVbJ+RfMT4DIEgt7+JG44/NvJqDz8YxuC+yje+j4QhjCHOdV5d2nDIamjQi6
 88MAkpYhCwAQQNLDWYq5KkYe+oGB78xlT95oobnD39H4hAu1Z36dyjpYa5s07kfWCZME
 L2SQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Q1AmidPBJTiydqHVsq8mNGB7X7CowUwcfAtj4H1Q7EIio/dEbgwrnaXjH4rl/c5teu9YjWCooCzY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxvcEGz0DA/blGMtXji7diJaFbbM/oUyD92edvyhgw1uyOZiVYI
 r3x5fpxi/xHQXV9hWO/RfoIGeqwjXywAB8KZdzCyV4t4DXsC9p1j+aLzlsyvQsvzZJ17fK4oXKE
 qLDdSYC8=
X-Gm-Gg: Acq92OFyuvTHjs6cDSOGvXaR+be2uK7mXvCdsb3d+wG8tWOIa/ky1f/VEXLJpCB9amW
 i3dXY6RYZbZ+u9QRTK8VhC79zWO98hZ+Jff05eD6K+BLDlvRmqmaT/JYwonWQCPIQ9+Htme1kSu
 LjL2j4Z4radOO8w5bhK85U8qIV7uHY7OtIACrap/B5f3BnJvVKwkjB0EOVCGWMzTmLtlLxJf4H4
 2FCdoSdZ4wVwjxXA4Uko6y/oOI6BRpQjWIv3z7chMOJV+CNqtm5QbuP4bZq6zWD701X87RFS/lB
 MTT+bTwpvU4dgCP93JjLZm22bIYXJjr6vdn57LjhCMwwT7LqOpIS1dp1tqAj6EQ+B9lI+bKiiY6
 cARMrK0hQJscfOKoOJuOI1T/T8hiakC1henzQoXnIX6Mpw4kbs1wi5KffLH8yWbMlPekDrZXLuW
 sSgVU2n+wLKUwruGcVEABUWYKmi6vSxf0dz4Qm6dk8rNAsvPDCrRXpkA3/MV8aMpHyhE4lw9/o
X-Received: by 2002:a17:907:741:b0:bd2:e940:db38 with SMTP id
 a640c23a62f3a-bdd2a4fe6a0mr394311766b.28.1779483308428; 
 Fri, 22 May 2026 13:55:08 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com.
 [209.85.218.53]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc68e0ad1sm87746566b.60.2026.05.22.13.55.07
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 13:55:07 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-bcceb394417so970994066b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 13:55:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8CzPE8Wz8u9FT3xdLQ7JdysAPf4CDmIZofR4zbEN4SxIJUhJl7SKSp+6ZXIGZT0I0XBo2NccM6c5s=@lists.freedesktop.org
X-Received: by 2002:a17:907:388b:b0:bd5:ca8:768c with SMTP id
 a640c23a62f3a-bdd2a4fdcf4mr356604766b.31.1779483307741; Fri, 22 May 2026
 13:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whiv=b+dAvjaZDsZkfUEzjZMSSLExDOWVcbJ0exsCj6_Q@mail.gmail.com>
 <6874536d-ab1a-4dd7-a23f-2a071bda145e@lankhorst.se>
 <CAHk-=wj5aE1yVMb8RM2AuNUHSMnQDaGT+Vy+At5ds1vxBA+Kng@mail.gmail.com>
 <ahDAErDSE-SFA0oM@intel.com>
In-Reply-To: <ahDAErDSE-SFA0oM@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 May 2026 13:54:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whX59mtUnU2ayMWoDQX6Ee2NXLK2NxQ+dZnb-Qc_mF1hw@mail.gmail.com>
X-Gm-Features: AVHnY4LSUSZZISY4Ze9pTdgwUNigEigmkg54d8irkN8W4SGjeBwz0QiHQuJ9u38
Message-ID: <CAHk-=whX59mtUnU2ayMWoDQX6Ee2NXLK2NxQ+dZnb-Qc_mF1hw@mail.gmail.com>
Subject: Re: drm: xe: Kernel-submitted job timed out
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Maarten Lankhorst <dev@lankhorst.se>,
 Matthew Brost <matthew.brost@intel.com>, 
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

On Fri, 22 May 2026 at 13:44, Rodrigo Vivi <rodrigo.vivi@intel.com> wrote:
>
> Any journal saving the kernel buf log of previous boots? Preferably with
> some drm.debug flags enabled 0xf likely

Note that this is very much not repeatable. I have no idea what
triggered it, and I don't think it was necessarily brought on by
anything recent.

I've seen timeouts before, but looking at my logs, the last time it
caused a complete hang was Feb 3. So a few months ago...

> What was the last drm-fixes pull you got in this 7.1.0-rc3-00073-ga6920214ba75 ?

That's just mainline commit v7.1-rc3-71-g31e62c2ebbfd with two random
small patches on top that change some build flags (this is my "built
by clang" tree)

So the last drm merge would have been 51d24842acb9 Merge tag
'drm-fixes-2026-05-08-1' of https://gitlab.freedesktop.org/drm/kernel

                    Linus
