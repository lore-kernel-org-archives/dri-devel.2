Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31E9CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 15:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DDFD10E28C;
	Tue, 12 May 2026 15:05:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="bNcXOg7d";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03F3310E28C
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 15:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778598334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2eX0USmLShQsb/8DMQ63vXaSE/VT5r1TpahlVnwh5Y=;
 b=bNcXOg7dgBlMSJaL1cbnPz2pmfiDmi0Ux/Rbpm1Ylaa/7uRcKDQmcv77cEY6nrAobEcAzP
 gH0eJlywHWPdSeNyCojL2r63E2JekoTd2rTRiRXZ72CfdfbTI8wdkA3Vc7vS6JFDq28BjG
 Ik0JuirZJnfQ/TwIhnV6J14RwnRzbHw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-BQEj1n3tOEeRVw2LeOKvow-1; Tue, 12 May 2026 11:05:32 -0400
X-MC-Unique: BQEj1n3tOEeRVw2LeOKvow-1
X-Mimecast-MFC-AGG-ID: BQEj1n3tOEeRVw2LeOKvow_1778598331
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-7bd66ec877aso120837917b3.1
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 08:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778598331; x=1779203131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W2eX0USmLShQsb/8DMQ63vXaSE/VT5r1TpahlVnwh5Y=;
 b=TLQyvVFrToe7K9B6UOcm6V4VEZGC5deW+cMusQk2FHYh6+gI6AUJWuWT0rZq+2d6Cc
 SpNGDcETUF8MyMadsKilaZqOXxLfa4lLIqe1jsiT0fponQI9GJ8ROv9gxy/JVKRvjc11
 o9+FWSgtSa/oP/MQrdCa4LQzH8X32r561sF4dkzVApleDo0H7JevsEa7lZeSB+FJE+rX
 IV5bZ/7PFxmHC08CpAb/yT4D7CGz+4VMQ4rOHCeMrwjoT8AkQE5U90l306Sc5o2jc0Ra
 GpnJPvmuEtS5H3W/l1YAvJ/Vtmco42RM8hZ7smfcmjVUF/kFV0jWt/UUmA7gNwDCuGbU
 JUxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QYrJKVrUCW1IrIdut3edE3KzEAZCCq0lVdkEF07hqM2QG5JEfrUHnGt0DRKEcnVZchKGeClAQCMk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRcxk80kxJZo8+VwyQC6nIdrdRBPQmXPkw/qUHu8+ue4LD8KGK
 Aol4OW/N2a/IykxWAOfVRfiLMIiOocs9LC2oiyf3bzkcFE7WAaYUkHEVQx3GtBLsqFscqaRg8S8
 siP5iHIWSpiwlyY+k+VxX0wc4GzrsPze2ElU1qWWGoZKKkXvgvLXehoEuSI/GAOOcMHieLQ/074
 bVIi3p2gwlNm5ZlG6Eosy2f+1HpHSYj/V3Khrx6aLUY+Xo
X-Gm-Gg: Acq92OEJx4n2YqNoi0mvVw7TT+TadSwvTWicSnTN9ajwm2T/5+X2aDHD32NAYo0Yyy1
 whdCb/QT02PfTLeXE4/MICkNm+urKLBCkD3Oa+AIovfAoBOj3e7HqLbCxaeE+hVXwZUOgKGETxi
 Z3wBzKfHAEomy9NbALQZEUMjW0e8w9RyTqNrdBSWHi3Oiyfb5A3aPhEP3oI5t8RynHlBzY1Gbt0
 pSXww==
X-Received: by 2002:a05:690c:34c9:b0:7bd:6a98:58d3 with SMTP id
 00721157ae682-7c50f7cdf32mr36554737b3.18.1778598331040; 
 Tue, 12 May 2026 08:05:31 -0700 (PDT)
X-Received: by 2002:a05:690c:34c9:b0:7bd:6a98:58d3 with SMTP id
 00721157ae682-7c50f7cdf32mr36553547b3.18.1778598330230; Tue, 12 May 2026
 08:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260508-kunit_add_support-v9-0-99df7aa880f6@redhat.com>
 <20260508165203.1cd1b27e664754d18dbea899@linux-foundation.org>
In-Reply-To: <20260508165203.1cd1b27e664754d18dbea899@linux-foundation.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 12 May 2026 17:05:18 +0200
X-Gm-Features: AVHnY4IjDWzPTwv7Lf1EJ-4smElfrpc1pe5LEGC8untQsvEPzH-woMO9H8PAPck
Message-ID: <CADSE00LNoc8KgVWR=7Va-Phb2U9sDzS9wntWckDFm66Uz89bnQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] kunit: Add support for suppressing warning
 backtraces
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
 peterz@infradead.org, Alessandro Carminati <acarmina@redhat.com>, 
 Guenter Roeck <linux@roeck-us.net>, Kees Cook <kees@kernel.org>, 
 Linux Kernel Functional Testing <lkft@linaro.org>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Dan Carpenter <error27@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Dck-MawnLLWxJJczv4ciT7OzcK17MJer5AiCUUcvWzk_1778598331
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

On Sat, May 9, 2026 at 1:52=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Fri, 08 May 2026 17:02:44 +0200 Albert Esteve <aesteve@redhat.com> wro=
te:
>
> > Some unit tests intentionally trigger warning backtraces by passing bad
> > parameters to kernel API functions. Such unit tests typically check the
> > return value from such calls, not the existence of the warning backtrac=
e.
> >
> > ...
> >
> > Solve the problem by providing a means to suppress warning backtraces
> > originating from the current kthread while executing test code.
> > Since each KUnit test runs in its own kthread, this effectively scopes
> > suppression to the test that enabled it, without requiring any
> > architecture-specific code.
>
> Thanks.  AI review has a bunch of questions:
>         https://sashiko.dev/#/patchset/20260508-kunit_add_support-v9-0-99=
df7aa880f6@redhat.com
>

Hi! Most look like valid concerns/issues. I will send a new version
addressing them then, and monitor sashiko to ensure I clear
everything.

Thanks for the link.

BR,
Albert.

