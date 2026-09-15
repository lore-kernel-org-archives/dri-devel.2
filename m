Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBD1C982C1
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 22:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDD4910E0EF;
	Tue, 15 Sep 2026 22:55:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gJ36Dkp1";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB19E10E0EF
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 22:55:17 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c25ef7a3ce9so47401966b.3
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1789512916; x=1790117716;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
 b=gJ36Dkp1ACVy7bFPXlvxMSKyh3tlXOBty/09/uydkjfeK9YRshWa990l9b7kV64BZ8
 KJwZGah/XsPBLQ6C6tre5PCsv5IbYSFEJk7naGxIqn7SuzUZjdWkt0aaMmnvt6eJBR4i
 U2huh/6dSmjXqD+vfi01WD+h4wAqRWdT/iA64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789512916; x=1790117716;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
 b=SmqfMaMYteocwJ3sTwjLQQ91LWqtuwtKQWRadj6PFAsT95q/q6rfnjnJ/rKsf7lGRa
 F7H3YP6B72gPR53hTEhK5rAA5Wl2jf4pxyN25EBFDfE3912lDoL5jI8KXHOqv56M/vl/
 SXfA53THQu0Nh2G1BY312wtRqfikQbE6EpcBZQMAP3xDQu9Awc2YtPZUnubC9CybLBxy
 adW1LLZ92z/O1fPUFV3a2wlJjyjGLqBhHheyqdzXTP7+ZFiFhHTv26XRBRON3bXPR6Kw
 AVmabTzCY7acZD35Zf95jaRWrdjQDl/KyD3CPFCstFb5E6GjngL/2yJe1eTlUAfzsY/k
 v5Yg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwOJPXzJBdi2kJ3iyT4UfB9LFmeL3k+mC9uETqjAYI4UqKwbJ/L9Ocxk0t854FPMkIEybLxcmltoCc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l5ndYjt1zc7JdCEyjTNYrU/MR3OHZ6n+fPM+m6XLI5kBVUEuuH
 FiTBxkWY6djjpHFDR0LBCjZBGZPpxyJecbpTVc9EevrRw0tawJ5ZfKfBYiW48BbaiiOF/PxNok1
 B6DytBmSOCw==
X-Gm-Gg: AYBFou2saGdvVimBcaI0eEltwdyvGsgBHkpK5TZZoffNi1ZtfdyjBogvx0hgLJKj7DB
 vD+Qg7g1HzzJ1ohfkOKyxY3Xz5BG0fxSm2Lh892Q6xwTRZf4gDqy09bQI3lPBx21AxD6DNvhjSn
 o2acnGNtmwPEmQ7g9vi1eQjaAAIlDUggtqz69u7sr6JWgm0YeyclekhIONY6PQ4OKwO/ZZhUczt
 IqEAgPxfSIfmU638E/udmfAPKKD0Ke5t/j/9J+l2MkJLQL3rHnTu0y/3Lg1SEK45alHL6ZI8W0a
 b3CDyU8cdSi8MjQtHcPQTa/T9v2vYbG+AHROs74Bt19b9ylECfhDqYzfhDlqC8G9sg7LnXJxmeo
 KKw2dCz8PpRcN8OE7GfCCrMWau9vutlq7mpt+jpNEBjkjGSqusQIeWaeBeu5gLXW9X70+uF+zOx
 cHoVhdngvKppht4JOPUIYY7WkHj/EoMLJc6dl0IpuQFeVriC7yChYvO9+Yv4y8Wt6QZsZgNqx0K
 zxJfQiMfFciE4ib1aY0L+bVEC9qeiQxKxN7jlWNGjFxF/Hj
X-Received: by 2002:a17:906:c113:b0:c26:3107:71dd with SMTP id
 a640c23a62f3a-c29e5207742mr9708366b.13.1789512915809; 
 Tue, 15 Sep 2026 15:55:15 -0700 (PDT)
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com.
 [74.125.228.76]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29de454014sm34886166b.13.2026.09.15.15.55.14
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 15:55:14 -0700 (PDT)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a605844571so457271a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:55:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvByGtxHknRyqw2jteuAft/jjlSJ+90PeZHS1l40uhVvL0B1KqUwqjjaGGBzjtJmFy077DWEGhDHZZfE=@lists.freedesktop.org
X-Received: by 2002:a05:6402:5d1:b0:6a9:a6c0:e5ef with SMTP id
 4fb4d7f45d1cf-6aa2244ef06mr218172a12.37.1789512913950; Tue, 15 Sep 2026
 15:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
 <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
In-Reply-To: <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 15:54:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhJF91TCO0Zqeuf+caG2tQZ4AzbLr2qFmRmnMM4dbh4g@mail.gmail.com>
X-Gm-Features: AcwNN1Wx2MaYDtFtmeOlL6MnzYY7doY_FEPpziKatTBWbLOeKsjmritQ5JuAL3M
Message-ID: <CAHk-=wjhJF91TCO0Zqeuf+caG2tQZ4AzbLr2qFmRmnMM4dbh4g@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: rob.clark@oss.qualcomm.com
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>,
 Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
 io-uring@vger.kernel.org, 
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
 David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, 
 kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
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

On Tue, 15 Sept 2026 at 15:21, Rob Clark <rob.clark@oss.qualcomm.com> wrote:
>
> With fd's it is more than just about error rollback.. exposing an fd
> to userspace mid-way thru an ioctl is an easy security bug to write..

That isn't very common code. It's something that is done by a few
strange cases, and yes, those cases should just do it right.

But "those few cases should do it right" does not mean "make a whole
new subsystem for this thing that makes a simple "open" actually be
slower and stranger".

             Linus
