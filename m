Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98C7C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F80210E130;
	Wed, 19 Aug 2026 14:46:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I0aykMg7";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1417F10E142
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 14:46:49 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c160420289bso146531266b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 07:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1787150807; x=1787755607;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OSCot2pCSk3hHSz91wsSuI86JXqDJ2hDA18HgPNG+K0=;
 b=I0aykMg7B1kX7dGil9XKw1fWb1Vx7fXVSoA1SbyWg780TxM+tdY/p1F0cpP3vqCcLZ
 AX3SU588uySUcKdf8cRfpa2MnvqnfGahEuhuQQc7uG6XZfWvffRbznSD2X1TDwpzYi+r
 qF5SzN9IdkdPpIQUjh0fL4wdcu+Mb161Pf7tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787150807; x=1787755607;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OSCot2pCSk3hHSz91wsSuI86JXqDJ2hDA18HgPNG+K0=;
 b=Yvf65mf5YgYh8i5p2o7ybWi9zYXd4ZMG8qBz1rdjD4LpXDl/m1no8zb2sRgdRl1RNw
 CUyq7Yfpl5WO3dvt7LljoZWq+gqXq57/DktiGCxca2u/4kGWpJVK5TTjv62R/YrfN9R7
 +kxwzCIPAoP+A/dk6JzyLEWtYIOhdpfHuAJXB2295NpxjNiHB2lsNp9g3rZqA2nwrJFg
 WUBCTVpRTPj8XK6aBmnqPQqOit6oFLcMDCqlhVm5Cyt6L3DIiA07SkeMfGUeaNFDt/VR
 ly9d0mR485UxCqQrzlRm2Y7zEqWiaaM6KqcmigH6AZN01sH5gnfr4S0NAIfBj4Stnw5p
 YcJA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3mg6V/t6HrnrTn0VMjuKLR2nD5rWYVK3KY2w+CvNUlkAr4uuwv4VtzYMWOUzovNI7uLGLBvCIPM0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBFwmFNq33ydE7vmiHV5VR+Ig+EguiS28EElj+xs6UFa9QGw8Z
 CJr0K94S27JFhc+n1q/qDMmt+nz588JfrcvDozt9jIiUxVm4oRarTvmFegG/2eRwt0kqpwu8CZP
 +2+XcDSQ=
X-Gm-Gg: AR+sD11IunT+YgOxDqqvtHktRwn6i+UquuEP1xZUbeuoyEiC6enD5BsAFANz+qumD3+
 V0TiIpO+i6x3NyT8OLbLlSghI2v5V9dd9cPabwan7wkzAqqk19IfsmERmtiduwcvJISFZqGq0Dx
 sxOa/BDT9NqYlQEE1SyZ6HZ3cS1brrYhVSKvVqUbZmJ5F25SAQ1g9xYFLKQWmT4m0XjicCB769D
 Hqf8XAYzVlCaooHY6xOg0PWqUxqbkgqILdCZ68Ewzf5gnWG1u+I2aoAhBiUvQSGA8CaKCCVJ4f9
 8I/VXqV2ASafFm9NHQKdh2lNojFCN91cHiuD3ge2Wfehr9tQ+vAHFlMvEqCKifiuoBqfjfHYy13
 mkR4HTa5XnMt+MAt/GRM//L9WwsBevEeC5KPDfMz8X5saMDDhIxulLqsO51TNV3yS01SnEmAELc
 YIENzPGCPQYVouSQ4HI+otTe9WjJvDE9FKx+Uw4fhgTrt3ZQxrGmX6ziJul0WQW3b5NTMZD2ogQ
 XH0On+zt5/uJtG1kmRuYOf+1pGXCCiCfwWHtQ==
X-Received: by 2002:a17:907:3e9d:b0:c20:1bc5:7002 with SMTP id
 a640c23a62f3a-c23f929d918mr330116966b.3.1787150807324; 
 Wed, 19 Aug 2026 07:46:47 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com.
 [209.85.208.46]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c243c27565dsm89827066b.59.2026.08.19.07.46.46
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 07:46:46 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-698ae09e356so1805718a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 07:46:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RpBvpzGRZR71qROFIVEgLRxZrUrUZ37xEAAcAABLeB6JJCASsaCKKhvJdWaYMzqg7o4FfD9YLqHSeU=@lists.freedesktop.org
X-Received: by 2002:a05:6402:2403:b0:6a3:e813:8457 with SMTP id
 4fb4d7f45d1cf-6a4032f9c61mr3585093a12.12.1787150806331; Wed, 19 Aug 2026
 07:46:46 -0700 (PDT)
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
In-Reply-To: <aoWHKmz17HQo2uy5@gsse-cloud1.jf.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Aug 2026 07:46:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjv7SCjtg6JGDabGMXdqobx+WHogHfQeMPF2g_HmAU5qg@mail.gmail.com>
X-Gm-Features: AcwNN1XSfxuGhCEkqbxxdrVDPc4dzGAfkF59OcVsFeLb7hasE9yujONmHOn6O7Y
Message-ID: <CAHk-=wjv7SCjtg6JGDabGMXdqobx+WHogHfQeMPF2g_HmAU5qg@mail.gmail.com>
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

On Wed, 19 Aug 2026 at 03:36, Matthew Brost <matthew.brost@intel.com> wrote:
>
> What is the kernel verison here? Is it trying to integrate all the PRs
> for 7.3 into an RC release? Or is this the released 7.2?

That was just tip-of-tree as of yesterday evening - it just has two
small commits on top that are due to how I do my local builds, which
clean up some generated assembly and switch to using clang by default
(because I'm too lazy to use the proper way).

So it was commit

  bd5f485f3f02 ("Merge tag 'soc-arm-7.3' of
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc")

from this merge window, with no drm merges done yet.

No, the reason it stopped working was just user space doing something
new when I did an update. Plain Fedora 44.

> I'm looking into it now, and based on the dmesg output, it seems to hang
> fairly after boot, so something is going wrong very quickly. I'll
> analyze the devcoredump and see if the problem is obvious.

Yes, it hangs basically when logging in the first time. It shows the
login screen, I can type my password, but then it's done.

With the standard Fedora 44 kernel, it also hung, although at a
slightly different point.

               Linus
