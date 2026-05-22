Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35E4CD5BAC
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 19:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 441D710E2F8;
	Fri, 22 May 2026 19:05:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QSxj5RKT";
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A304210E294
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 19:05:54 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-bdce61897ebso178666466b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 12:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1779476753; x=1780081553;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8rBvsudGZR8H0khov1rpw2Hp8pJzILtOJ6oXxT/Ivh0=;
 b=QSxj5RKTGml9B7WtFBdo3jXAZcNZ255umknz/VSWa8qp+V2bol0qTD66axhUYApHsN
 TaPWoUwPU/o5zkY1Rp8wT2TUg//iyL7oHNUHFSfHLYOZSoviqrjGpc/SQN6UIH3JvgeL
 mDceyVva//YAv0Q51qU/lrSg0FAzM2LwVKssI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779476753; x=1780081553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8rBvsudGZR8H0khov1rpw2Hp8pJzILtOJ6oXxT/Ivh0=;
 b=LCgQ+YaY3jel9pyv0IhlV95hNBV6lyKKAdqlLqHvAWQE+iA7Mih0Z4T6CmbZ5kroLz
 sNDW6QUSJWdveLh00qSXuuCK5y+kKOlAqUUtQCuPVO/c2XfrZfdVS/AVVqhfawAbKS/K
 XV/m6/Ec9evpcnTG38UQTHdtAl35Gw9fR/IbQx3fS+LLbHc5gkAyEB4TO1lGRMTFUEYq
 hnXSX/+FzCTk1acbyt/84V7UfmPMO+L+JOYaju85IDxGuu5ESaLjiE/Lgv800dIYuRxx
 D3dPz8ISFJJDtPzdc9GxGTc69yW4V2M+ydKXKWXx2NSWv/OIxBy9h4vH+YMt3kZltCPH
 Cv8g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Jlpk2wCKsABNDi8ruxh09jS7S8XJLUMqAUHsvYa9Yv4vNDSWoEz6FOpQrdvLRQq6H7W092kGQhjM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCw/PQx/mv2swDrn/qAnvWAXzRMOB0OllnzA7eYnCswMWvvPgE
 OeEefy9i/jVMu+gMVEfbLlXO2VQB7QNGjiGSQtRjDh/6budQK3SslcCXhWYqh5ioJXIhqlOcXbk
 JRQ5dSiY=
X-Gm-Gg: Acq92OGuNbJhN+0uGT2n6sH2rqLNdq0WPkVZX+uq6QHFi97UlYaXCUv+s09JCRgBvJo
 k1IWj7xPiB0mYD46kPFMPVcDw38DyIHHp2YautRxNp5v/vu25eE9frQQLu8FmiPzV4jvrSTWlPS
 hglF9LmfWZb3+JLFM2+jO5kEak6SaE3RXVdhXPQxvi2QfVIXXK3eJO6Fc8nMNiM1GbetayiNu3u
 Vc/6bAW8GXfkOyKbNAiHv0+9xn41+56NLlXnAblr/arHVEY8Bsust4bIRxoVbsIvyvPNlURJArM
 VJWFgAToQWS9blfB9EjusNsoYBWZisRrwzf+w5TF2tMFxZiX7nbehoTykvHv1S2Vr1WCaiVV1fn
 Q08swtoLQiSCKv4/BKYx07+lqw2kzRIE7E1oeeo95w00uz2XCc8QG0SZZLBwfZOWPJZ9URMgzmq
 jfItUArnp0ahsgEm/GpVGXlWrUBFohW5Z0N8df3R4xhSAfFTET/WM+fYG5+cpdEaIDrByaVJxF
X-Received: by 2002:a17:907:72d2:b0:bdb:4cf3:7035 with SMTP id
 a640c23a62f3a-bdd253390b1mr306498266b.4.1779476752904; 
 Fri, 22 May 2026 12:05:52 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com.
 [209.85.218.52]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc62d4ff2sm84951666b.46.2026.05.22.12.05.52
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 12:05:52 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-bdce61897ebso178664166b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 12:05:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/Ya3OxstqFH6Ax95Si/6h8M1lyb9/xQNX3aAXyZ7JIdka70VWABG2aXn79TH4GdQyOu9HbwM7+JOE=@lists.freedesktop.org
X-Received: by 2002:a17:907:72d2:b0:bdb:4cf3:7035 with SMTP id
 a640c23a62f3a-bdd253390b1mr306496066b.4.1779476751943; Fri, 22 May 2026
 12:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whiv=b+dAvjaZDsZkfUEzjZMSSLExDOWVcbJ0exsCj6_Q@mail.gmail.com>
 <6874536d-ab1a-4dd7-a23f-2a071bda145e@lankhorst.se>
In-Reply-To: <6874536d-ab1a-4dd7-a23f-2a071bda145e@lankhorst.se>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 May 2026 12:05:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5aE1yVMb8RM2AuNUHSMnQDaGT+Vy+At5ds1vxBA+Kng@mail.gmail.com>
X-Gm-Features: AVHnY4KMC4fPrp0Eg8xTd3oOcWUbDhv_gUsDIVjBlefbcy08ljXF6ll0V_6051s
Message-ID: <CAHk-=wj5aE1yVMb8RM2AuNUHSMnQDaGT+Vy+At5ds1vxBA+Kng@mail.gmail.com>
Subject: Re: drm: xe: Kernel-submitted job timed out
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, intel-xe@lists.freedesktop.org, 
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

On Fri, 22 May 2026 at 11:55, Maarten Lankhorst <dev@lankhorst.se> wrote:
>
> There's a
> May 22 11:09:19 3970x kernel: xe 0000:4b:00.0: [drm] Tile0: GT0: Timedout job: seqno=4485322, lrc_seqno=4485322, guc_id=0, flags=0x73 in no process [-1]
> May 22 11:09:19 3970x kernel: xe 0000:4b:00.0: [drm] Xe device coredump has been created
> May 22 11:09:19 3970x kernel: xe 0000:4b:00.0: [drm] Check your /sys/class/drm/card0/device/devcoredump/data
>
> Do you have this coredump too?

Nope. I was assuming it didn't survive the reboot.

(This machine doesn't allow any remote logins - very much on purpose -
so when the GPU hangs, it's toast).

               Linus
