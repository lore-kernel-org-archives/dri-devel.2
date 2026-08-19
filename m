Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D47FC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:56:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E98DC10ED3D;
	Wed, 19 Aug 2026 06:56:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IF4Z0oZ/";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4D7310ED3E
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 06:56:05 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c15ba3a2b4bso82357466b.1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 23:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1787122564; x=1787727364;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3ISvHdVx5NNV/ZYzWt2FMv8YK9yLKQC7l7IY+HralrU=;
 b=IF4Z0oZ/G4BE0freMqqYGceykVfcYccS4Ka2mWBz4opk+3cD9qrYxUhfl7+B1S4mTK
 OKZq6InBtqDt9oGUChTyL6ODOK5CY5cGjryqGqAjjaMrEsElkqYCUGPuXDVTxMi1rrMT
 GfwAW8N2UR7boD5S4vaQOIZkoi61UOZpWBe8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787122564; x=1787727364;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3ISvHdVx5NNV/ZYzWt2FMv8YK9yLKQC7l7IY+HralrU=;
 b=PpPVNmqC8+aB7uyR4ThSING3bsM2/h7C3gvERDueqVZWLmjTJMoG4DVbnEzg3qMWRy
 suH9bs0WM1It9paJt5Nqj3OZDnx0U1YRgqk8Pzr/bPtsdSvh7ngneAV6CQzr4mH3Bj3z
 RxQt16DWzxu54fjqISQLiE7X2JgA+EgadeN79P20UdN6jcozLojexPu+uA1wzLiIXN+O
 YA48fgLK7bp/N9xmdbirIZJLxOQ6/TAE2mAGtYpBK1ASvC/Vr5gvrH9wF94AeiTpXp7i
 Qu5uykJtqo77EkGugCj23o/Mlz9bYofZyBEkKAlx90dTQzJp/F4vc0cQPqVne/a/lntw
 tZYg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq5DyrF34KVHG5ZZU9yl17+9/xKT1ZciRpXCr6y7igmuRukfN2aSK7pJriVVdQspMklv1/LWDHCgfM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyiUYbARHPyacNYVAF36kumUQZwYPZlnKQYrF5ifD49fjtdFo+S
 jApr4xc71EecGueWml4q0dgJL5vW45Pc4+agr57UU17LSYGgoiGVTVFlOGJtcQYX1OEo+egYHHE
 dVa9O/JU=
X-Gm-Gg: AR+sD13CZ9roNiTle0yGxPuqeeCD70eEdjGPcR/YcPXfi/ZVHFZb/O4JWQG07k+Hkt+
 H874aA6flM8+BpBUO6CmB0gTZXamDFvT035aMrAdFhP4JPdasOk0RC0xRBQW5n3gYqbYdBcYEI3
 UNf8VDD/X3xPz/krdP0MD+3QFUflnSlgODG7kEUF8TFaX/zau+W0DJ0e2DDqAUHdV0wgbJ0fBKJ
 YJmRMAgk9BL5P8iedAdTjSyGASD5Tk7/8FQbTTf7vQi3lROA/LwUmmJOzJgz3FwcMiQyXZnFL6g
 CeKL0FFih7hcs4Qc5EL/VG39NKayaBLrHtnm33wewSAkI9PiZHK4FI7UNKXTnwp1YCt9kGX3+cp
 9IdmBWFWmIVdyJWg5/Wd8tG3ZTv31rV59jwHFS/D0d4UuWuPWr7YYELxm9IV70H7x3oT0BlURk5
 Y+DjDAW0mpO+/3X3/uAvBKBgZ2wjCRbP8KsaVWJsHXSF6GinRe0RyK6URWM5a0POYP/dUyKCkRN
 nAgQfpik+2olD4ExI49gNtJF8SVCkE7GFUzaw==
X-Received: by 2002:a17:906:ee89:b0:c21:2218:5c7b with SMTP id
 a640c23a62f3a-c23f9352b3emr121091966b.1.1787122563936; 
 Tue, 18 Aug 2026 23:56:03 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com.
 [209.85.218.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c243c5a078bsm35646866b.36.2026.08.18.23.56.02
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 23:56:03 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c214321dc32so116308166b.0
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 23:56:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RrEhTHfmHs0HiNj0M7VnsVEKf4U/5LjaJvkyOKrRf2ceI2mmCCVG+TS7fsMjdcfQgtedNAkc/3qjMk=@lists.freedesktop.org
X-Received: by 2002:a17:906:99cd:b0:c21:74ed:4608 with SMTP id
 a640c23a62f3a-c23f9750de3mr137322366b.10.1787122562579; Tue, 18 Aug 2026
 23:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whiv=b+dAvjaZDsZkfUEzjZMSSLExDOWVcbJ0exsCj6_Q@mail.gmail.com>
 <6874536d-ab1a-4dd7-a23f-2a071bda145e@lankhorst.se>
 <CAHk-=wj5aE1yVMb8RM2AuNUHSMnQDaGT+Vy+At5ds1vxBA+Kng@mail.gmail.com>
 <ahDAErDSE-SFA0oM@intel.com>
 <CAHk-=whX59mtUnU2ayMWoDQX6Ee2NXLK2NxQ+dZnb-Qc_mF1hw@mail.gmail.com>
 <af9278d3-4002-4e09-9bcf-bc75d1cf8145@lankhorst.se>
 <CAADWXX-pfvA3mKWSjdahnihAXHQB2VP9BOJDCXonG3Q_nxurLg@mail.gmail.com>
 <anYZ8nUFP5dnRy/h@gsse-cloud1.jf.intel.com>
In-Reply-To: <anYZ8nUFP5dnRy/h@gsse-cloud1.jf.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 18 Aug 2026 23:55:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=whyk2-u_1bTh5ZTeX6jW3HgAtjJh0mV_oWtgsqCe=3w7g@mail.gmail.com>
X-Gm-Features: AcwNN1XoNlB6Jg88sFbQERhyg6-m7rz4jXRQR6ymPHvlXUqlK934fTgVD-Ok8_Y
Message-ID: <CAHk-=whyk2-u_1bTh5ZTeX6jW3HgAtjJh0mV_oWtgsqCe=3w7g@mail.gmail.com>
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

On Fri, 7 Aug 2026 at 10:46, Matthew Brost <matthew.brost@intel.com> wrote:
>
> I think we may have found one. I haven't been able to reproduce any
> kernel job timeouts on drm-tip with this patch applied [1].
>
> If you're still seeing the issue on your end, it's probably worth
> pulling it in.
>
> Hopefully this fix will make it into your tree soon enough too.

Well, that Xe fix made it into my tree as commit 9f83c94469ff
("drm/xe: Order ring writes before ring tail updates"), but it turns
out that now I can generate those drm job timedout issues at will.

[  +1.222075] xe 0000:4b:00.0: [drm] Tile0: GT0: Engine reset:
engine_class=rcs, logical_mask: 0x1, guc_id=12, state=0x3
[  +0.000041] xe 0000:4b:00.0: [drm] Tile0: GT0: Timedout job:
seqno=4294967171, lrc_seqno=4294967171, guc_id=12, flags=0x0 in
systemd-logind [2068]
[  +0.048338] xe 0000:4b:00.0: [drm] Xe device coredump has been created
[  +0.000001] xe 0000:4b:00.0: [drm] Check your
/sys/class/drm/card0/device/devcoredump/data

But at least this time I have ssh into the machine, so now I have that
devcoredump data file.

I will send that separately off-list, because  it's 2.4MB in size.

                Linus
