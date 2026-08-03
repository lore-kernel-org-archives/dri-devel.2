Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0328CC55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 13:06:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E617A10E1B3;
	Mon,  3 Aug 2026 13:06:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="crR3K2hO";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 283EC10E1B3
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 13:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785762399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TpAYiTbcaQ0jvMB05FtqLWtuoGIYX5W9PtOm3b1H6mI=;
 b=crR3K2hOK57YUbZNXOT8kIXaN97ruEq3wltYuO6JSBJlIoWIO/Ji14KtGB0TOkqiaf2ocm
 +0vmmKTH6BHKje+nbPb3ZbaNeBf0DCGysl3XB8NAUORRwIrBOuqa8bcDVCln4nTk6ad63I
 /Lc2Rf93m8KBUWQN1B3bfg05XfykxZQ=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-Xmn6620DPnyOYTzGVMlWMw-1; Mon, 03 Aug 2026 09:06:33 -0400
X-MC-Unique: Xmn6620DPnyOYTzGVMlWMw-1
X-Mimecast-MFC-AGG-ID: Xmn6620DPnyOYTzGVMlWMw_1785762393
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-81e8a76a273so112525717b3.1
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 06:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785762393; x=1786367193;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:content-type:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TpAYiTbcaQ0jvMB05FtqLWtuoGIYX5W9PtOm3b1H6mI=;
 b=jEFbcJu7e/KEyTdqY8/zWy3P8zVNzbgicJsGASS3T6jHRG+/4SI7u9wOzwK0rqUhoi
 AchQor0Kn5Tjvm38+7hGpNOzkBMTqOFwyKSTMddhnO/hDwiqdHfzeevt7fDLk+iJ/GkG
 fA2jzTjqvIj8Jbx7IrpYyWgf/FmfDN5GWaJNvClA9lZaz5n7EIddqqThO4MjakwCUeTe
 NoJ432jWUSQVMJn4kjSi1NBjCI7tpnnr8XUyt1ODvQ9jdnjvwOKBMayoqoxPAn1wYcOF
 mMPrqT8fa0Mc5SbZhoO2Ts/ugRAaFKR4BaUeWIBwzgcFqViQnlP4FA668T/kcpzCCgLl
 6ETg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNr31kAoN+K+2KtvK7ONwvZqT2pckcZyasAV3Li1vEBF50hx2a60Z52pDFZ3XKdrM/8FJVaqZWYLI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxrM2vOFqJbf9i3tV3l+CADP8zh1fQSDyBJ0/L/m3F7PmmwMUPa
 kegZlTGoNcRjf9hKpyBkuRPV1i97yKaOnDjf55sVbqErG2BgXD/6monHe4eiqM1+aYZk5yy4v09
 +8sDLc2ZI57CZ9L0E8t8c2Zq4VJ+vmmbPecSmpfjqYsPL2MI5SwPjfGx9EH4tTcLEbIasaQ==
X-Gm-Gg: AR+sD110nzLYS+W/vH6U9QUs8rscXs3i1DEgwnhJh6cSmx8OZGbSxDcQ+a6XUzgRyKs
 lsEPmz02xa1MxHaOa/L2cq6y33OsGVj8tr8Mp4x6VUJERaqeb1pkUlUjxzNPm42eZk3oD5jy2Gh
 zj84v4n6zmZFZZe7+MocLrEe4OXWjm+gjFRcKEsAisdETJEz4NOARWNM73Hndo/b7Tuai5ta1Si
 G2gMiiIYdCDFHOMPgEirJcTDuEO5d8LJWFP2OkVrUIb50xV5h5PNcq+R+lMQyw9VLZgiaj/O3Pf
 pQLf+p0ZbmPY8xSuLbj0eecVqzhkVXAY+zNtSqoNmoJvlrTFJDvQvjnD3JjEqJNZENk+F8d8qpi
 YoHtspOr2Ha4B3apoiW8VG6LrZQzGHkJi85g=
X-Received: by 2002:a05:690c:4b11:b0:81c:872a:5152 with SMTP id
 00721157ae682-81fd4bda24fmr120211177b3.30.1785762392618; 
 Mon, 03 Aug 2026 06:06:32 -0700 (PDT)
X-Received: by 2002:a05:690c:4b11:b0:81c:872a:5152 with SMTP id
 00721157ae682-81fd4bda24fmr120206447b3.30.1785762387273; 
 Mon, 03 Aug 2026 06:06:27 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net.
 [73.183.53.213]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-81fccf60a76sm54295687b3.13.2026.08.03.06.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 06:06:26 -0700 (PDT)
Date: Mon, 3 Aug 2026 09:06:20 -0400
From: Brian Masney <bmasney@redhat.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Maurice Hieronymus <mhi@mailbox.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Michal Wilczynski <m.wilczynski@samsung.com>,
 Boqun Feng <boqun@kernel.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org,
 linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 0/4] Clk improvements
Message-ID: <anCSTCxDpFtKmOgj@redhat.com>
References: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com>
 <20260731183735.15036-1-mhi@mailbox.org>
 <E20E4FD3-F4DA-4029-99F7-DB4F93AA2994@collabora.com>
MIME-Version: 1.0
In-Reply-To: <E20E4FD3-F4DA-4029-99F7-DB4F93AA2994@collabora.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M2jMEZNWubl8lwqBeztEuBqN58fUppPBYtEBmv3VQT0_1785762393
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

Hi Daniel,

On Fri, Jul 31, 2026 at 06:32:48PM -0300, Daniel Almeida wrote:
> > On 31 Jul 2026, at 15:37, Maurice Hieronymus <mhi@mailbox.org> wrote:
> > at your suggestion [0] I rebased my `clk_rate_exclusive_get()` binding for
> > pwm-th1520 on top of this series, so it is now waiting on it to land. As v5
> > has not seen any comments in the last few weeks, I wanted to ask what the
> > current status is.
> 
> Nobody has replied so far. I don’t think there are any further comments.
> 
> > 
> > If there are no blockers left and you expect it to be merged soon, I am
> > happy to keep waiting. Otherwise I would offer to send my series standalone
> > against the current `Clk` API and let you rebase on top of mine - it is the
> > much smaller of the two, touching only `Clk::rate_exclusive_get()` and
> > pwm_th1520.rs.
> > 
> > [0]: https://lore.kernel.org/rust-for-linux/140FE1B3-73CA-45EA-B978-648A1A48B577@collabora.com/
> > 
> > Thanks a lot,
> > 
> > Maurice
> 
> Your series might hit the same blocker as this one. Perhaps we can try to get
> both merged at the same time?
> 
> @Stephen gentle ping here :)

I can also provide an Acked-by here for clk. I'll admit that I'm not a
rust programmer yet (planning to learn this coming Winter), however if the
rust maintainers are happy with this, then I'm good.

It looks like there may be some outstanding comments on this series just
skimming the comments. I'll wait for the next version to leave an
Acked-by.

Brian

