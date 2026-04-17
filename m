Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E57AF99C6C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 21:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 542DC10EAA1;
	Fri, 17 Apr 2026 21:55:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fbUXYcB/";
	dkim-atps=neutral
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E83EE10E0B5
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 11:31:20 +0000 (UTC)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-7986e538decso5110567b3.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 04:31:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776425480; cv=none;
 d=google.com; s=arc-20240605;
 b=Hugv5bkJ077FD0olBjI4cT97gwLJWhpluszgSj846NI2aRpyJ98lCT3cjZMnKHMWBC
 WdNaznSUxdhpPnONHmrPpyvQ+A+KaPIZiFLVDg53/xBTwUHFgl4XDFc24V+Ri0LgOA05
 KVz6eROqYteU0n4zbYPCsrmhuPvNxn7Z7C+atEZR0HCMDkmx6zQjrjB/5HYfLUIbbhm/
 fQMfSh3xKjtbgHK76x4VDzOKE0xAV6MR63z5xdOsNjIWnLBO/W24KkFTPeSRuexD4zBs
 WSENjZ2i4b9H5dHaQnUMl7dsLZxuO9gYRHsouszL66HSnVK8is82JSI2pDMFdRtdS1bf
 LMJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=z+zpHgYozD7vQZSnn9bC/lwPA6OaHSKhotflLOWUpro=;
 fh=pO2JzZcFeCDjbeR5WXCs3uvF/r+QhppIGF2p25XeWgI=;
 b=OhfOC/K9dVgCpUH7fViVjLER/s/KlDzcP86hkJ5hS5av/O1jvrHWpXJ8IHSadfA9IK
 S7aQYm4M5dKATeeTtz1k1n8w5jsJqSS+HxjcoOPBB51Zsc+gdZHN5M+1FEm0+ffPl9ho
 +uyJWIs5+8cg/kWlALDIwDLBvkbLOyDStDC3wwoLBIWdIHLUlXD4LBqEmsq8J5X2bE5W
 FDAqs2oYgYzkIOdb0fbOhX7IbM+3LD/6rmbopAHPnf5/9Hqs/SaXoharWl8pis9zKdfL
 mxuCwjbLfupGZnRHsM6Z02i7CAV8CnkEYo30Vr0iHh5BvucnnJhVfXlg4JWcVwChcFmX
 46xw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776425480; x=1777030280; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z+zpHgYozD7vQZSnn9bC/lwPA6OaHSKhotflLOWUpro=;
 b=fbUXYcB/K/o3AhtAZlofDgi9Tnj9fE6ogTENEEL6QSaoRR3KMHtk3Dk2TKq/dl+M7q
 wRHlx0riCfRnxRHGfRfLhGFB8Ch4Ov54fBrXkAgGRQ6VxtGTR5YR76LbeeLQFyW9yC0z
 vpj5ISqYOk3Y9wr2o6flug0w2jImSyISUHkglIwyKz80/OolO1JGROotPRUiyodwFC10
 oTS1fgaqfgQXDBFpZCo/yzkUJTucIMUR0D4ho41y3nc8SZHIkc8OD0Um6B/6AL+NgIqP
 B0n8uaT7UiUDBsd+UQzWcMuYyB8YnFmfP+gZTXsL/LMi9IBAIrAJnGS+7BfUetg2qsZU
 1DIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776425480; x=1777030280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z+zpHgYozD7vQZSnn9bC/lwPA6OaHSKhotflLOWUpro=;
 b=OAtIZ6N14Jg1EN+ISi0Q8mtIlFSvoxsJVFfHnGRdQt+u+ZVRVbuqbmNLl2c4VVfNps
 ZjJdUeMo8MhyRsO4v8oUUhK/jDDTMUNlmVhFmWkdaDSrzcHPzqEYFxLyBK1c/b2dDbo5
 ZfLnLh9yHbJMFyN1X0pZnA1sfBzP/viLRbx0PXsPdkgnZRgEsAOFeJ1ulXUEZ7wVeOft
 e63I6QuxUIX7EVhfR5uzlK9X0q4rORz2jy/d4yUk9PtqPcijUdxlRMgVc2mkGmxoY1LH
 zoCgc/ijFy4ETOi14uWydSq22xledEVjXrzbjo0R+WghgPD7ZfYZD+MJ2E488HXY/rkw
 UpMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+X+n5+BfEXHEmAjLXVnfg/yxRLP9wlZfLpiOSZpgdDArppqlaPAxnlGEp38IcHPo3BkqqTnGvOA5A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwfvChVSCxrTqfmxpoAKmy2yzKi2Kn6gSqQ4sXKxSevu8jZGJoG
 GvlnkAETdg7asrffl6qkmgInqP+Cw2fu2A32oU3XDFmpNqhe1Ma8AFyzbJ7WpvdWUvau+3BDJP3
 A6cMqHm638lBYpuxjaR4M5Z9bHL39Wmw=
X-Gm-Gg: AeBDietg7LlZx3qtdsV43T+0WE62nm/X5Y5OXt8UHaC1a7sfn/dsz7kSLr/YB+6QL9P
 8NCRtPIlzXLD5sbpLEDdQgotALVnsQm7ic8pgMxQityKqfjXPtFKKtIB5x2+dpIQVJYpBtD5K6y
 e5bns6FF6cAEAXUVw2kTETwanehZCDdjzTIzZxqCgDjeNAIRQ9xSB8QslKMlvTu8eN4HSb6DsEN
 WzqK7dMsd02zCibBh/RZtXKheL1fy8FgLKQbgTAKgUpFAYcES2k65qyMD2/s1sHxjF9UUQScCjh
 Q0Hw2V2vM3ngLfFrJA==
X-Received: by 2002:a05:690c:e3ea:b0:7b3:c611:7ef5 with SMTP id
 00721157ae682-7b9ece75f00mr23911117b3.6.1776425479720; Fri, 17 Apr 2026
 04:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260417101457.7599-1-prasaanth2k@gmail.com>
 <aeIXfMcia6e8cQvy@ashevche-desk.local>
In-Reply-To: <aeIXfMcia6e8cQvy@ashevche-desk.local>
From: Prasaanth Sakthivel <prasaanth2k@gmail.com>
Date: Fri, 17 Apr 2026 17:01:08 +0530
X-Gm-Features: AQROBzBwNdsVGp0JXxrk_7GMJHIBG6rRktYO_czLRjSB807ioahagedf6nuwujA
Message-ID: <CAHPaVe=vpcNopxmpvV7GMY9_mpDdfarQwyNp_TsD4fHHG4sreQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: fb_tinylcd: fix alignment in write_reg
 call
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-staging@lists.linux.dev, andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000b0511f064fa6490d"
X-Mailman-Approved-At: Fri, 17 Apr 2026 21:55:06 +0000
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

--000000000000b0511f064fa6490d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback, I understand.

I=E2=80=99ll look for more meaningful issues to work on.

On Fri, Apr 17, 2026 at 4:50=E2=80=AFPM Andy Shevchenko <andriy.shevchenko@=
intel.com>
wrote:

> On Fri, Apr 17, 2026 at 03:44:57PM +0530, Prasaanth wrote:
> > Fix alignment of multiline arguments in write_reg() call to
> > match kernel coding style
> >
> > Reported by checkpatch.pl
>
> NAK. Use a common sense.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
>

--000000000000b0511f064fa6490d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the feedback, I understand.<br><br>I=E2=80=99ll=
 look for more meaningful issues to work on.</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, A=
pr 17, 2026 at 4:50=E2=80=AFPM Andy Shevchenko &lt;<a href=3D"mailto:andriy=
.shevchenko@intel.com">andriy.shevchenko@intel.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, Apr 17, 2026 at 0=
3:44:57PM +0530, Prasaanth wrote:<br>
&gt; Fix alignment of multiline arguments in write_reg() call to<br>
&gt; match kernel coding style<br>
&gt; <br>
&gt; Reported by <a href=3D"http://checkpatch.pl" rel=3D"noreferrer" target=
=3D"_blank">checkpatch.pl</a><br>
<br>
NAK. Use a common sense.<br>
<br>
-- <br>
With Best Regards,<br>
Andy Shevchenko<br>
<br>
<br>
</blockquote></div>

--000000000000b0511f064fa6490d--
