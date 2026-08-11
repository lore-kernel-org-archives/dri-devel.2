Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC19C5AD7B
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 04:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A31A210E167;
	Tue, 11 Aug 2026 04:05:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ecfoKKH+";
	dkim-atps=neutral
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com
 [74.125.224.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A20A710E167
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 04:05:58 +0000 (UTC)
Received: by mail-yx1-f52.google.com with SMTP id
 956f58d0204a3-6679d88abdcso3294584d50.2
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 21:05:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786421157; cv=none;
 d=google.com; s=arc-20260327;
 b=do6sl+/1vJWQ5gcPIa5p7iCIV0soMuPc04Sr2WrLlXRly92YNoTSEUHiIOJYOzqdJH
 9vUL7JqlN9ruRG0PuYClzqRfzfhbU8p9MPSVwcyywVU6+ckQeteaky+wwN64FZUjVHIY
 r5M3IYai1hSZTmXy896+mbf/fUzc0e1dVeBQHrrhX2YF0XzaT5PAY91Ix2XVWtGkq2W1
 zMbfLsh6bv+6riJFuh6XuVKnA4cyIwhtZ3szJFuhgLzw2rq6+SbYUQdxyDQMDI1nSIXH
 UpVi4uqsGT0zPzzpTCqff3myV9ZU17lh959JrNASOKqMJhrj1Pcgt4meWQXq929Xj2is
 BoTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cHpnkGdhgzlYq7979nZPO/96+5OTEhnencdtJNs5i5Q=;
 fh=iYJAQnYQKNEYtFVvjauRvM2QazdwLPoGACb+jJFW5Ww=;
 b=Bt1x8tuzJ1ohSlf3V2tbVbiK7QPX/SiMp9NPnrTGMMoUN4Q68hpIdtfVy3NxVdpqav
 ZcbDpZIk6CZ/XbS5pMuIyGwRJwodi0FfHv0u+Hy5oSbuqUxUq6xrxuXAE5DHFB9U6Vod
 NyDY4WPlzUrfVSPouy9nMlgiheZ1u5kSyri59UB77X1d/CDY6PgqAnk2VQ6x/uho37LR
 q6nkFvu/5wamDQ1Y7WWr/a6Vk+AcV+FXztL5j8NIWRF+rQ90RUMfzdfum8L5jYwZZuRz
 N/mnqP5p+LBQkyA8e5ZorQtU5LBxIttIZyybB6q9Agg0R7Yf+Eegeohu8wCzSocUZD+r
 znBg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786421157; x=1787025957; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cHpnkGdhgzlYq7979nZPO/96+5OTEhnencdtJNs5i5Q=;
 b=ecfoKKH+ibHW6lzi8iuVRK4LaJkztYPh+wpVEdAALMLwCXz1uAWEn8n33LPCo3XWBP
 9VvpvQMgTZ27yWegGZVwbHLpsL0o2hL92rWSgCM3CJ0WjZlpTtOtBThGavySsmZ+XiUk
 Crz6PbOwi0+8hKFfFWAoPtofKPBPTBwlB7XEbCvHmaEgozg1nCugDfqvTG+U6TqrXJ2A
 pMVu4EqmknGM7mTPeUX7ftvxxngBPFh95LkD5QSBELlqCNsX6CK6vnL0DfbQcLcL9e9s
 tGO5sbBCL6AKdWpi7z4ZQQtSIPfFRJuovTyRlx0Pq4uUw9EQUqf9EKNDY+2sayH/sSom
 RfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786421157; x=1787025957;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cHpnkGdhgzlYq7979nZPO/96+5OTEhnencdtJNs5i5Q=;
 b=GyPKQ+X7v308Qd+2sVwxYX0w42K6AXTY48seYhsVCqvTpJIMTfBvsn6X+j29e1uMIx
 4/hxpccdx7ndxRHGGdG/O3WU7sDrOH8UvSZuwX2PI1HgCKaq1PRR/uv8ntzVMILxnlY8
 NKqYrRAc+gnUNir7bXtbMuIBQmqHC7gWNYj6OYQ6wmUi0J7pbzTOkumCJutLYwBAjlqv
 c4q0MSG+Xke2LN9qTSxxY8ZcwNX5NqYu8YDLCYkVaAYicBLPYcjY+c3xroITwXYScOgq
 ctzyvJigwI+M3IPFjQGwVLSooOZdDpucopbEwU6gHAN535uG9cZ+7f/8NlPdR9uk1nQo
 h9vQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq98tjdURrWEp9mDom2oUm7z2nPe53F8jv6h08eEe77jGEZNIuhfZ+TIXOjUVxFJS4luix6d25EzME=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YymM+xIk3rthbxPbQ0CaHc8PFgZ5ST0eub8LPcd+pqzPwYpcn2S
 44Ke7ygF1PqhC0w8J5NyiS6FvLdUdRHaTVo2+DNQU1juOAtlAUZi9w3CcAAvHw3KCT68gBFGCef
 RMHgzSTjJM3TlH8XT0h5Cyeldv91SCqo=
X-Gm-Gg: AR+sD13EAdShTViZXSyWGRqil3+zC5irfczQp4+tTrlG0HpRe2kts/bMONn7nb0xAN7
 Jj5dVi9TEBWiCVBvM72oBtA2jrisBdUGDMVciy40n8cDUSGTjWy6C0QrJTX1VSew0Lc4LIIMrEN
 khrpk/NLK8EuzcXPhT/D6JEzfvR/xRMpbu32sP+WIB9b+qIUGj/J6E/bFOHtcI5iREImmPC5chB
 UGYxcCa+LW5jcuplJVg5XfRsPD29x7dkaI7FMFGBQT7Va8pKEDWno1H6TqesI3o/wJ2otrEQiVf
 5byiRGvNxpJIxiFoTuzfXwhxCDNMfnRtRzMrcqRSu3p692Db/gk5+BSCeyIUxp8pLsMyOUKCIxH
 F25WZERxE8B4Qp6Xs9n6jgv+MKjMGxw==
X-Received: by 2002:a53:acdb:0:10b0:666:541f:6355 with SMTP id
 956f58d0204a3-66b22ed1439mr132084d50.35.1786421157461; Mon, 10 Aug 2026
 21:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260808-nouveau-fixes-v1-0-c3ebdc17a89c@outlook.com>
 <20260808-nouveau-fixes-v1-1-c3ebdc17a89c@outlook.com>
 <CAMwc25qozGSRw8KKNzVhakH1jCNWsFS_z=mFn9hswxjdNNX0GA@mail.gmail.com>
 <55965C34-9026-4EE7-B2F0-1D5D9807D682@outlook.com>
In-Reply-To: <55965C34-9026-4EE7-B2F0-1D5D9807D682@outlook.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 11 Aug 2026 14:05:45 +1000
X-Gm-Features: AUfX_mygO8g3uDRlU_tKv8cfeWEPc5DomvcU0l-wKoJbB4Wcs1CRG-FE0Jl6bRo
Message-ID: <CAPM=9txG6wEwx_L5RsB+3gEuT6dYJQvrPpQnHHF4V1gFZpWNFQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/nouveau: bound sync and op counts in EXEC and
 VM_BIND
To: Junrui Luo <moonafterrain@outlook.com>
Cc: David Airlie <airlied@redhat.com>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yuhao Jiang <danisjiang@gmail.com>, 
 "stable@vger.kernel.org" <stable@vger.kernel.org>
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

On Tue, 11 Aug 2026 at 14:00, Junrui Luo <moonafterrain@outlook.com> wrote:
>
> On Mon, Aug 10, 2026 at 08:43:50AM +1000, David Airlie wrote:
> > Have you run a complete Vulkan CTS with NVK across this with no regressions?
> >
> > I'm weary of those limits being too low, but I think the only app that
> > might push them beyond CTS would be Forza Horizon 5 or 6.
>
> No, I have not. I don't currently have the hardware to run NVK, so I can't
> offer a CTS run or any other regression test for this.
>
> Is there a better guard that avoids a hard limit here, or does this need
> a test before it can go in?

Looking at xe it also has 1024 limit on number of syncs, but it
doesn't have any limit on number of binds,

                *bind_ops = kvmalloc_objs(struct drm_xe_vm_bind_op,
                                          args->num_binds,
                                          GFP_KERNEL | __GFP_ACCOUNT |
__GFP_RETRY_MAYFAIL | __GFP_NOWARN);

Maybe nouveau could do the same.

Dave.
>
> Thanks,
> Junrui Luo
