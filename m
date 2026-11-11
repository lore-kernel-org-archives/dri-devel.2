Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4763A606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WXL08RH0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7399010FD83;
	Wed, 11 Nov 2026 19:51:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A8E810FD83
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 19:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794426664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pd24Km/P434HUb31zAN/wsWSEZ40dQ4mBIne5ONpsUE=;
 b=WXL08RH03ldGpS3WyBl3a7NfnIkqqVyyEsHp3zsrz+PJTtFXJ7UT+8VuNYEWPnmEkMdxc5
 xPqNPdkuo9DI9vYJ72OXzlFd3WO0vC2LGOMnQsjQMOYRYpySLRzgyxDMD4P+EuQaEEvsec
 W7Xj45xwEQz5jlxk0hFfQqbGN6bqEV0=
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com
 [74.125.82.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-ZASAftFNOPq6B7zvg2A-lQ-1; Wed, 11 Nov 2026 14:51:00 -0500
X-MC-Unique: ZASAftFNOPq6B7zvg2A-lQ-1
X-Mimecast-MFC-AGG-ID: ZASAftFNOPq6B7zvg2A-lQ_1794426659
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1aa0fb7f157so5562319c88.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 11:51:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794426659; x=1795031459;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pd24Km/P434HUb31zAN/wsWSEZ40dQ4mBIne5ONpsUE=;
 b=ltpT1sXrtC9GKQ7aPiru2y3NmDkL74WVxC02BeTYUV0pzgZgOz0u4+X1gfLk3yErlh
 Lrq5NEnSd8ApCuEMBu6IGHDdF8YV1iT5thXog74hNZI6zchF75C8GscHNF1jWNh1D6qU
 nm6cDhDS9YAtHcsL9ssm1JMuNQnK+9sODNBEwPEZehu7Y0nZDhdbxjb6gXVpUXMsMsYj
 H2D+R1Fpo3BgsHTtQBylG+zJKcWyQ4LQEHjJqTuMjRHqy9cqvP7B2RdwT4fkFP+/Y68r
 OoV15eAY3Dm7ekqm4rG8RkBCZDzkDLR3DU1jQXkUXVN6hO3xeWASdwc/mDkacKPSuEEx
 t5vA==
X-Forwarded-Encrypted: i=1;
 AL+hErEf1jtqtf9ui6UNte/Sqazrl71OKYpidUSiiAx02bhMq5l/PALbQ/vcdDxldl7izH2hdcr2T/z3RrY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+dkTe65iqAEQi8HVAp91vGXcKwCLV9BYher2EFO6Xm6Po4jm8n
 XA3EmOKKuD7FXlx1FrLEu6CqAzE8g6IeognoHwxu+pTyHGz3scgSkkp7HMyYWcgmdTepgxo2uVz
 nUWXc597QHI+zfIyCa7TtHmwTF4El+gJnGqzjSyMFSkeaF2SN3QkXM9ZzQE0E5QahHvCL0279m/
 FIFk6mzJy+0ghyzFmRpx84lDOaBLBf2+nU0vS+aM0kXlRV
X-Gm-Gg: AYBFou3vp+z9/KFL9V5HERg2sjhtUReeLa7F1OdSlUgO6G75Jm8wA/Xdx1UJYqVeYoh
 iBml/j7mMf/9+xWvBJ6wEYxx7IhO5YT7YRCO3OouBtL/SnlRcC21uEzTLyUaQFEm0eBduGWJ2OP
 U9gg3/KdwrQ2QbdE6b0QFVj8SWE6D+fcs0RPpu7q7FbNUfTCMp0yqqNBboYDR6CCRdyOAihq356
 lUleLEdJ0OU/lsH
X-Received: by 2002:a05:7022:7f0f:b0:191:3c:aae7 with SMTP id
 a92af1059eb24-1b3c032edcamr2843624c88.26.1794426659207; 
 Wed, 11 Nov 2026 11:50:59 -0800 (PST)
X-Received: by 2002:a05:7022:7f0f:b0:191:3c:aae7 with SMTP id
 a92af1059eb24-1b3c032edcamr2843612c88.26.1794426658701; Wed, 11 Nov 2026
 11:50:58 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109-nova-timer-v6-0-5544a3bd8b28@redhat.com>
 <20261109-nova-timer-v6-1-5544a3bd8b28@redhat.com>
 <HgxksqDneCpV2KCW_EeAGi_PEZ4HXYdwPqm0pHMkGPQlo0kktMkB-lNOjxQyUZtYhs1JzEFfjHyQAgDlVAqMMg==@protonmail.internalid>
 <DMRKZL0RNSG4.3P7B0RM71I0CG@nvidia.com>
 <87zevfup32.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87zevfup32.fsf@t14s.mail-host-address-is-not-set>
From: David Airlie <airlied@redhat.com>
Date: Thu, 12 Nov 2026 05:50:47 +1000
X-Gm-Features: AclHuK-QOvDZJWTA27jrdMVki7iIGwSXEqRY0dpTdrg7OUvqQUE59SM30iopFhc
Message-ID: <CAMwc25qTnstXbR_z2pfWRKSezdGXBiX+XsG_37CQL7EMr3__zg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] rust: time: expose as_nanos for clock sources.
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, 
 Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Gary Guo <gary@garyguo.net>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9kX-L4CvUt3gDuwpJsKc_SWft9vf21JRIIJ8C2uUm2M_1794426659
X-Mimecast-Originator: redhat.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> "Alexandre Courbot" <acourbot@nvidia.com> writes:
>
> > On Mon Nov 9, 2026 at 10:55 AM JST, Dave Airlie via B4 Relay wrote:
> >> From: Dave Airlie <airlied@redhat.com>
> >>
> >> The nouveau C driver does ktime_to_ns(ktime_get()) to program
> >> the cpu ns into some hw/fw, so allow this method for rust drivers.
> >>
> >> This is needed for following nova patch.
> >>
> >> Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> >> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> >> Signed-off-by: Dave Airlie <airlied@redhat.com>
> >
> > This patch has also received a maintainer acked-by:
> >
> > https://lore.kernel.org/all/875wyoydqk.fsf@t14s.mail-host-address-is-not-set/
>
> You guys want to take this through your tree? Otherwise I will apply it
> to rust-timekeeping this week.

I think we want this to land through d-r-n whenever the timer patch
lands, I suppose we could merge it to d-r-n now actually.

Dave.

