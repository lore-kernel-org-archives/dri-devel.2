Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D331C44511
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B08D710F1DE;
	Thu, 16 Jul 2026 08:18:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RIx+isyS";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F3F110E0B8
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 16:09:56 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2cacb8416a1so11187555ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784045396; x=1784650196; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kdgMbrcVylxaBaGAreEv3T5etD7pXeCq9ZAv6P049TQ=;
 b=RIx+isySTjzsbBbfc0YR8RGG28DW2XOT1GUX1adp0MpZZjHHtU5JBxSszEsf5m4mIf
 8fY6Tvemd4qr8MMdnrcmqnJ02UlnSglQvnGC1AORwdWHm7jpgOiOd++PTlX6Tq4ybQTK
 rCwAwrOiBaFpTtevi7Ywtv+48CjQ7TjbuWxvFWB7jqenjOSo1pU0/hz5pnD13EdfYA4C
 8rbc04bpXHXKHAXtRQe8KwvcENFSzcooL72MVDL2mXD42Mo5qrTcc+m4bh9FDfo0yGN3
 FUlDXaF+yFenn+v/kKX/nLZGj1xZyb063t9XCUtIuGJuLPHwm6UZzo+6I/ly1FNeOqjY
 q4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784045396; x=1784650196;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kdgMbrcVylxaBaGAreEv3T5etD7pXeCq9ZAv6P049TQ=;
 b=Sj9FusCNyrPiENXVzyKu+FOXrWrWkC+KZ9wUATObvm2Vs4Y3XoiGJuvL9ZPWNiAbwV
 tmFdg4V3KZeCH/u3LP4WD7aECcJzoAIUtAldRxifkND8P0CqOgurYbL1hCNKgHxRKSGL
 HtwMUm4pSsXJaRKuVBKzJPtQnOzSA6Df1O9/tKA6/U0eGTGn6id3zHS0EWQGFNZSk0pK
 ksEsvpC5tsFseOrb0kRJULMZNJym0e/EFcSDnV7l93v4xUTHSufFMB37O+7rHRku0Ey9
 rNzqmErvCOxrnA9tPfbe+zONISlvXaGptjr0JuCw1F4briNRzBBq/ZyE8rM2shW61bGg
 IKvQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqNKmiq18F1hLd1DqdM0MgrwRxA+nYtxHMp6BZTjB26Kk03IoqlAgOSzkra2h/a3PCw1NDHPzrhVOY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwkO0Z2HV1rniuR9h/1aVvdIJEI9gTGYQDU1TS2VBQz/RRmmHi8
 EArIJ3mS4hkkDex67gRn3bX6z1ObtmXPeCFnci12yf4hs9yIT/nPDR4Y
X-Gm-Gg: AfdE7ck6V75PY0JcY8jhf1JJsNKkRk4h56WXUzyJFi7YY5u9VMOVg+iGcq7WZYUBwsV
 2F/b3yeVsHmnWdCFBn70GhTdgKEy+2Luyprr/CqF58wlcK47vYnJKK20FlQcMYC7JblFqH+8Kx9
 97EQYiPP5q3TRb5e5CEwIlrVOqB7L3rA68YZ47O/mKA5BOa4psuaR+qzRHQ91buyNviIo7Stvjh
 aI93q6K9GWqinpDiGFLd0BXC2BjwjlHeV0JJ90S1iA1e/0hkDKXi3UoflpAR6rh4JrHsKBlcRA9
 9WZw+Db1SLgdIrIiP2hhAMN34sV/mzdMJ0oGuGWmPe9JP7uV52KOMGhAgKwiVxNC+4civm5o55E
 /eGkAVKn+YCfs3/w2kiotgULG1losftiAGmgqujwmRhwp7f0ElwTGpIVQWOAUnplInXyWeX3vqu
 H65i/l7QD22cIAEQiSOQI1ZqCfG0Gpjq0RDNGVWH8CbNQIKIj/w1soTwA=
X-Received: by 2002:a05:6a20:d70a:b0:3c0:b55a:80ff with SMTP id
 adf61e73a8af0-3c11063d595mr15198722637.24.1784045395651; 
 Tue, 14 Jul 2026 09:09:55 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5b31628c1sm10020860a12.19.2026.07.14.09.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 09:09:54 -0700 (PDT)
Date: Tue, 14 Jul 2026 09:09:51 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, corbet@lwn.net,
 dakr@kernel.org, david@kernel.org, decui@microsoft.com,
 haiyangz@microsoft.com, jgg@ziepe.ca, kees@kernel.org,
 kys@microsoft.com, leon@kernel.org, liam@infradead.org,
 lizhi.hou@amd.com, ljs@kernel.org, longli@microsoft.com,
 lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, surenb@google.com, tzimmermann@suse.de,
 vbabka@kernel.org, wei.liu@kernel.org,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH v8 0/8] mm/hmm: Add mmap lock-drop support for
 userfaultfd-backed mappings
Message-ID: <alZfTxfypj39OrCE@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
 <20260710151151.1e193eedd0cf2591ae392f76@linux-foundation.org>
 <alG2-RSitzPWClAX@skinsburskii>
 <20260710224950.53bcb43ce7e564f07a1f6a8c@linux-foundation.org>
 <alVRU38lMfvmUFqJ@skinsburskii>
 <20260713154535.7656b3a630e2f6f076b4e76e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713154535.7656b3a630e2f6f076b4e76e@linux-foundation.org>
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:18:22 +0000
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

On Mon, Jul 13, 2026 at 03:45:35PM -0700, Andrew Morton wrote:
> On Mon, 13 Jul 2026 13:57:55 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> 
> > > > I rebased this series on top of mm-new right before sending it out.
> > > > Should I have used a different branch?
> > > 
> > > mm-new is good - Sashiko attempts that.  But it's changing rapidly at
> > > this point in the development cycle.
> > > 
> > 
> > I’d like to send another revision addressing a few comments and also
> > replace the `max/max_t` check with something simpler.
> > 
> > Which branch should I base it on so that Sashiko can apply it
> > successfully?
> 
> mainline Linus would be safest.
> 

Looks like linux-next/master has been updated with the v8 of the series.

I have v9 with a few small fixes, but it is too late to send it out already?

If it's not, then what should I base it on?

Thanks,
Stanislav

> > Or would it be better to send fixups against `mm-new`?
> 
> That should work as well, but it doesn't give us a Sashiko scan of the
> whole patchset.
