Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA26CD4F25
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 14:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 045D910E157;
	Fri, 15 May 2026 14:25:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Xb1yUqBR";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7575F10E157
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 14:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778855128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x7Embi/4WSTFlWQtHoiZCAOUQi9JugMiQF8nvMXYC0Y=;
 b=Xb1yUqBRHOI60hOldUc5MtPDkRyBJTbVMJP11fWfFJYwCLrGZBTt4FoO3iY+WriIhx0lYY
 liXKO+TA2Sfyngvi1QaXiEG3WztQczPvy4s6AdUOuXkzSuFtkXCad0qQoypSObjvvW8TYZ
 zBPQy7XP8jOF8uAIF+usz2efv1Ceo2Q=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-q8Qh_3J6MdevHwxBWi6p6Q-1; Fri, 15 May 2026 10:25:24 -0400
X-MC-Unique: q8Qh_3J6MdevHwxBWi6p6Q-1
X-Mimecast-MFC-AGG-ID: q8Qh_3J6MdevHwxBWi6p6Q_1778855124
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-65c62ca395cso18263628d50.1
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 07:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855124; x=1779459924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x7Embi/4WSTFlWQtHoiZCAOUQi9JugMiQF8nvMXYC0Y=;
 b=Um2LlD2RH+AA93XIgGCICIOLLnV0brcm8lzNJ+WX2x3Cux9BN00QZHuFiyYEWA7FAY
 PgWxYX0q2BpfQXDOPbyYdokG9dzeilFtp/H9Bu7AVLAEQhiZcpFltWZMoqErSTcjDUsL
 /wG31xq1M8zcSqFX3NuwTTXm+/UUJYoyLrQDmhr3Ngh6Oqu4EqjcZNjzFEDAa8y3fMPX
 lz5a+yTibd7HoZWrgjux/dGRzJAZNmA3tMY1C24BOpuq4p1DmGpjsr6WyHxCszTAPIji
 So420vcBpv/XwXbRVlY6ws2Wu01FqpfMn/AfSfly+TdtmvyyJSPfEMzy3RCHg7TR8m0+
 xVmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9UHlsR1zBggAyFLyuU2gzYA1JFppaIG4NNGLgM8mtExZvfb6fTtMahc+mrEuCQE8I9C9dSzxVGddM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzrbN+90HDVs+/yNCTTmn9nT+VANFAJ7Zzzpbwy6f/fZ+d25IDD
 IAXfW84rC4dyMg5kxQqzcYIMEqT/hnEYW/1teIiKUNUztgUWM64v6ycFvzv6uI2gQGKJel/9a3g
 mpUal8yQX9tV5eA/7UGJurWNzHcMrzIVp7RPBh3TgXkuSmk+4AxevY+1wXJZr+AynC6rAM2HUh4
 PffKukPy9Q/wKrxrEWMyzNo7D4T8Lb/1QR9BI0JkDG8DyI
X-Gm-Gg: Acq92OFtNekYkcyHPJJ/aSwcALz3O399VJ4hMd9k9xQCdaGI+PLAu7dfvuRe0Q01Fno
 yPOpSoZzmBAU4odRL/oXsXmn6CDb2wCr+ODtnfRLgwP3/HcvmpTPClc/gpYCbvJ8XJuywzj/3+9
 GmC0rGrjO2J2NvMNJJx8eVQS6f64/CKwqaPdwDEWNEynPaDGKKEwUd1wuMwCVEHZSTIm8Nzmj7I
 WSRCw==
X-Received: by 2002:a05:690c:921a:b0:7b2:136d:240a with SMTP id
 00721157ae682-7c95a56fc91mr34928017b3.9.1778855123622; 
 Fri, 15 May 2026 07:25:23 -0700 (PDT)
X-Received: by 2002:a05:690c:921a:b0:7b2:136d:240a with SMTP id
 00721157ae682-7c95a56fc91mr34927427b3.9.1778855122973; Fri, 15 May 2026
 07:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260515-kunit_add_support-v13-0-18ee42f96e7b@redhat.com>
 <7bcead90-7d96-4101-bd13-dde2c5ded1aa@roeck-us.net>
In-Reply-To: <7bcead90-7d96-4101-bd13-dde2c5ded1aa@roeck-us.net>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 15 May 2026 16:25:11 +0200
X-Gm-Features: AVHnY4II_A6w9jZTl5s671EZUUpKeCpv5nVKmn-MiUqfHzgEw_QM_N-JJo0K588
Message-ID: <CADSE00JVgP50vud_3uvvjg6HDeEwc1TsK0E=gSKV07jKtT+vMQ@mail.gmail.com>
Subject: Re: [PATCH v13 0/4] kunit: Add support for suppressing warning
 backtraces
To: Guenter Roeck <linux@roeck-us.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
 peterz@infradead.org, Alessandro Carminati <acarmina@redhat.com>,
 Kees Cook <kees@kernel.org>, 
 Linux Kernel Functional Testing <lkft@linaro.org>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Dan Carpenter <error27@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sjGOa-Nd8Icr-5VeZytji8ukadAjk9-Y3hgsfiMshLQ_1778855124
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

On Fri, May 15, 2026 at 3:51=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> Hi Albert,
>
> On 5/15/26 05:29, Albert Esteve wrote:
> ...
>
> > Guenter Roeck (3):
> >        kunit: Add backtrace suppression self-tests
> >        drm: Suppress intentional warning backtraces in scaling unit tes=
ts
> >        kunit: Add documentation for warning backtrace suppression API
> >
>
>
> How much of that is from me at this point ? Wouldn't it make sense to dro=
p me
> as "author" of those patches ?

Hi Guenter,

I do not mind authorship either. Signed-off-by lines already attest to
everyone's contribution.

In principle I am done with Sashiko's reviews. I addressed all
comments in their respective patches. Some lead to the rabbit holes I
put myself into for previous versions.

I do not plan to send a new version unless a human review requires a change=
.

If that happens, I may update the authorship. Otherwise, I'd keep it
as is, since you said you do not mind :)

Thanks!

BR,
Albert.

>
> I would not mind. I had the idea, but others like you are doing the hard =
work
> of pushing it through.
>
> Thanks,
> Guenter
>

