Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BB4C5DF9A
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 16:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17D8E10E328;
	Fri, 21 Aug 2026 16:48:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Xxv25+wG";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C8010F397
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 16:48:14 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6a1a546a6bbso2377794a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 09:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1787330892; x=1787935692;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7nSISwZ9zbCTnY56GQRDO+Ws9ZqBOePjZHKrCvOrhT0=;
 b=Xxv25+wGqDyjrnK7Sldti0OwI4weUYuMS+H/taalE3eK8Eu9Wu8DYrQ888SMB5LgHk
 RqaViTevHdXnoqQY3ThHqVf6N3PmQNHN/dSXDqxVcnSpa3IH41I0EN4YNVCB4TsFEBMd
 kUmYEtNCJ3kKMHOGRt9EsmaDYezHwJt+1PPYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787330892; x=1787935692;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7nSISwZ9zbCTnY56GQRDO+Ws9ZqBOePjZHKrCvOrhT0=;
 b=bPGR/Y869Upjh3DG5bSPFzpOS8QEYcw+Pp0GMP8RFI4ENJvwao52zYYRkGglEDAoiu
 9pkaijpsduYK7qVudPGsQXJkhzE5FZ7g5oOfdqlceYNv+vCCdFotEiWbGtKAWq+pnidD
 w49HD899vK/ti31Vth8WSLF5hbDs26VD/Naq9OM5pZ26mKpaMz9mdi+to1iVGQ6CVUQX
 80f8K2KVulPHbT6uXAkvofuHrRbhFGhkRf8u7bfyNp6wiX84Ugz3qESt2pm5AASsQajl
 qQEciE+FXPftwFFJ8K1e1+/xjKiG1sz790w0Vm4GfilVnsjGgjT7KO90w905KqK/6/KZ
 Xk5A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKs0e8l2JCKalOmvNxvgFf67zp6gIzS/ce9OJFtoeo4fWZX1YGFrmcU5PBxRYRtrp2A+cqNGQKJMo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n7xv+9dw1JyVPmZ1StF3conIb8oKxoqolRZIgxHB3fTbdy3j4L
 6u9kP7jnyHevUa0cvnNNSYDlrlbuchwXMEojXWqfWtZa/ozl1mbYRY5wAt/utCrKDbbIfCXLzeC
 Vn+dCyUCnOw==
X-Gm-Gg: AR+sD13bts9bcnyukhqY+9LMDhKjG61xfawIkiX2qigrClSJdL3MSGzVP22lSIhdW6J
 QgZSgZtJwh6vT6TcpdGLZtZKk9aY93+qWtaETJoetevSf6rDVbyNG4pAg8w/tADruyVYDmI4LNY
 yUSy/lz4rxCUhzYWvYgviFa3adYPXNEETC9aEuD+saIxCNIHP2tAUATAlUPk+73l7GqXY/UTI0+
 K5nyr4GGs2ZAbToMfdwBeEyGX+bcvXv7MVw8z90gs4jKVspViYyBeEL1BVFmoXzNCJnI9cq34fv
 AY/pzQgP5RZK9CKwLgQ7f864rX1KJ7K1cSHEPB0TKBj8ksTRq6J7/VOUNFwy6e5xmKCjB5/H/ZZ
 xresmgpetXirdQrSfQuaL6/knre4modFvP7qNKMKebKqYNg7nIDDSO41qBlkguR+o5hLG8xE5Bf
 YLFMN3L4/nWmyu9q1xHt1LP0qlUnlkcYgdt1eppOnOLxEX/0qUVs3u190VaNmz3pRrDQch3I2Zp
 hhLFmspCkjrqVDXgHopw+YPZL3fusKzAtcspw==
X-Received: by 2002:a05:6402:44d3:b0:69f:aca0:3b9f with SMTP id
 4fb4d7f45d1cf-6a42f1ec0b8mr7154095a12.15.1787330892288; 
 Fri, 21 Aug 2026 09:48:12 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com.
 [209.85.208.42]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff1567f8sm7405530a12.18.2026.08.21.09.48.10
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 09:48:11 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-69fc9f25118so1457447a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 09:48:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5TzE473nP6r4i6Vjjy6Ab+EegSVcYSuCAvP/s9fcIX3bHVL3mB82k4emDLfugq1iX4nXn1NbxSpU=@lists.freedesktop.org
X-Received: by 2002:a05:6402:44d3:b0:69f:aca0:3b9f with SMTP id
 4fb4d7f45d1cf-6a42f1ec0b8mr7153935a12.15.1787330890367; Fri, 21 Aug 2026
 09:48:10 -0700 (PDT)
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
 <CAHk-=wjJJH-1q6TK45=z0poSE92mp77JLsF3jHeWXibEtJu7EQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjJJH-1q6TK45=z0poSE92mp77JLsF3jHeWXibEtJu7EQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 21 Aug 2026 09:47:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZbz8v3M+qtzdPvDSshRX=2Krg=ByHyWOW9g+uLQgVkw@mail.gmail.com>
X-Gm-Features: AcwNN1U_08wqJRUkq37hZNlwYCBBtBhEMFoUPFfGtS4vdx8kzYilDETtJ4qKXNI
Message-ID: <CAHk-=wjZbz8v3M+qtzdPvDSshRX=2Krg=ByHyWOW9g+uLQgVkw@mail.gmail.com>
Subject: Re: drm: xe: Kernel-submitted job timed out
To: Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, 
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
 Lucas De Marchi <demarchi@kernel.org>
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

On Thu, 20 Aug 2026 at 20:50, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I committed the fix as commit 818bebeb63dd ("drm/xe: Don't hand out
> the flat CCS storage as usable VRAM").

Note: that is most definitely a real fix, but it's not necessarily the
*right* fix.

For example, I do not understand the old 128kB alignment at all. It
not only was definitely the wrong way around, but it made no sense in
the first place.

The comment for it said "SW must round up to nearest 128K" and the
original broken commit seems to imply that thatt comes from some
hardware document.

But the result isn't actually *used* for any hardware state, as far as
I can tell. It's just used for "vram_size" (called "usable_size" in
xe_vram_probe, which as far as I could tell is only used by the driver
for the allocator.

So the whole thing was just complete garbage, and I don't understand
*why*. I may be missing something, but yesterday I was so fed up with
the experience of spending 10+ hours debugging what ended up being a
one-liner that I just committed it as-is.

Now I'm back after a night's sleep, bright-eyed and bushy-tailed, and
still not really wanting to look at it, but at least wanting to tie
down some loose ends.

So I just want somebody who actually knows the Xe driver to look at
that thing. I only round down by 4k, not 128k. I think the 128k was
simply wrong and nonsensical. But that number came from *somewhere*.

I claim that the old 128kB number cannot be sane for another reason:
the other side of that

        if (GRAPHICS_VER(xe) >= 20) {

will return an offset that is at a 64k granularity, because that's
apparently the hardware field definition.

But the point is that the return value of get_flat_ccs_offset()
clearly is *not* 128kB-aligned and never was, so not only was the
alignment done in the wrong direction, it was always entirely
nonsensical. It cannot possibly be something that the allocator code
then depends on.

Anyway. It all now works for me, and apparently reliably. But the
keyword is "for me". I committed that thing because the old code was
clearly garbage, and the new code worked.

But the new code may be garbage too - for some reason that I simply
don't know about - so somebody competent needs to look at it.

                 Linus
