Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FC5C982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BEDB10E32C;
	Mon, 21 Sep 2026 07:00:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YyVJd6rK";
	dkim-atps=neutral
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com
 [74.125.230.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D66F10E165
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 21:17:32 +0000 (UTC)
Received: by mail-qk2-f12.google.com with SMTP id
 d75a77b69052e-52fb766bfd3so9087771cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 14:17:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789766251; cv=none;
 d=google.com; s=arc-20260327;
 b=ireT4fTDp4oE/f3n3Fh2zIC1hbRjf5wNKIRAqDL7yn+Z/2oQvwOFLSTpkCCL6tdI81
 RPkDSNIZ+vupZFyDPrPjz4uVziEpPtTlArX8S6kx+g/lhzklnzIPRHh1wbQeee+yN881
 PqEN8hzTUc+9ry2JHaJqBDeFbTeMWesv4VRERwTMBkBqtXCcuB3wBo8URjkefXgf1nCg
 pzTdihpmaY+yd3cv6pjtWGKxAA1nqIzhXJeYWOJjeS0SLiaDy0HMb5ppHMhNM14N65lY
 mrNDqCjq9ODtDBnSJyTDIRx97mOOmIL1xcQWKg3BdZpUbd8H56UJftkXc2YINobR3rQL
 x8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4BuYqrB2aE9YpUpS6fmvowho0DlzfKhs/auN02gUpKU=;
 fh=p13BCE/FbUgtwMhkCCTMGREdFK0xDW3Cr9ON2PwRuos=;
 b=KGQXlkWiPRaptPhQpHVYRp0o7/KZ3yiTcxpjg5tj9dRYoVeTYccvrJukTbo+OPUEag
 xOB9iAtEj2Qdo1v2aw0lM9CdSA6/ieX/uLjoXqsrNj7UgO+QIpzPVREFzXxVDe9uPZUS
 fvoBfW1v9AiqQNJmTvvPaLkOGZcEK5E/75rExEF1Kvrs/wQhsZt+myMDEnOd4S5Dzb6d
 lZCSRvANWRjoIMxUnZXCwM4YpGaHA3PybMY/myQnL1wgRVNkaUdDHtZXmRPe+mjt3HmZ
 dyaL85UCY94PnORP8/0tQTEoxDxUvsbfaoaGqJyvBqSNIBhbXBs59+wVZStmfFSVrTKQ
 8Y9Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789766251; x=1790371051; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4BuYqrB2aE9YpUpS6fmvowho0DlzfKhs/auN02gUpKU=;
 b=YyVJd6rKuNmwj7EHk7zhj9h8gKjbTXiXEh8jAQQJv/52mI5DLrJh02JKsErEa7OroK
 0vU8MUKh2JfVs4irfF9OTpCDx/vK2EDktOLAe+1y3G8FMW4deu6Q0a9dbKbW02iUyH9V
 2/Sjwt8E9+tkHJ1RAGv8vc0yIdGqn9bpWKIlCFmGbyukOxMTWaiiu06gvD2cIPjeNxrx
 veP2ePtv0X9ZyiWYBf/YBD+m8kHP4OOADGGJNXhG9Yo1sJr2C9SMP66pIkvFSlqmKo7X
 F5g4pLRiFT7jbhxRswv+3Su1iVGNzHG/bDtmiQY3ysahX6TXVx9aMc9WvUXM1WZlQsMD
 9wzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789766251; x=1790371051;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4BuYqrB2aE9YpUpS6fmvowho0DlzfKhs/auN02gUpKU=;
 b=rICJf1rQIpApn374SftwTftS0XYHQibthDBvlFX6mwa7IGsgSnVVZqR34oMlgF7eLD
 KtOx9QUIRH7xemaNV1xlnJxXuWpH9BDp/4pB1Uc/XK7sc5DaL6M5bmMyXF6o/y8oFyq2
 4Ao2a9iOrF8gJbeImxSWlPVRLp3gVvvdwV9yUHRrTNVuCtA5LpFV1UA62r+0e1lNZJxC
 h+WusSjgeETYnqC81k7F6+DmVRPkRVLxk1W+z7RbleU2i4UVDP1QLeFJAdpNwcjgGS2R
 68pcoK5WYvvjj2VxSvs5HmboMWNzz2Wkjbz5i+C+H/zKKUpmB+LRo3jLivSEKCAis2Ll
 MmVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCEtPPLN0hTR/1/wWA3YOLnN7NaWsI25/vToc1HmXEURUF+WlrK5MSxsT4PgbCBNI9vQJqR8ImayU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lsJkPMJKKa53An8W9Vwd4lcVWV1J7XvW86r78nZx3uh4w58ews
 eTqKzMqE5eEaj0Ad4ZEHcL3mAwVZ62P8xZwnw0MBeGHdYtXJZA1l7hSsF22MlPwTDea+l4AGg1S
 SfpNP/fxDWjyXijbwgOV0f3ScW7BAQ6M=
X-Gm-Gg: AYBFou0xUQA63nfvMes/RH40k3agfCWrLMvOQBoGbBCjJoAYYPPjqdquvd29lvm7LkY
 XFZ7bgrPu7ZUcRaf92+7bx7CMkDWJskA0H2/LO3g8ndrllXlro6Hw8qvejAuIcV/Fk+kzVDfprh
 wSkwAS2RVG0HCZRjvIJo1D/FslIochW9K49EiTgW93sIZqvdt8m2b4bgq2J8M6DN6q8veWSWXnh
 c+xtNeYhdYM9gS7qlBuTyZ+7m+VguzN+LDxleA1sRDYkivrFt3PgEz1mzlq+I+wjITN0KnA4Fg7
 L62sysL696eRtPzYM+bOBsJp27Thxxr3Q8x4tRBwOkW6xGBbCDkzQpfLjesppuT2yp9m1PmO7lv
 4nvzsZMhmM8Yq
X-Received: by 2002:ac8:7e81:0:b0:531:214b:426 with SMTP id
 d75a77b69052e-5329e31765fmr61440791cf.4.1789766251186; Fri, 18 Sep 2026
 14:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260917181312.12473-1-claire.m.dusoleil@gmail.com>
 <ac19e380-e93d-470d-841c-7bd3f2b0b86a@broadcom.com>
In-Reply-To: <ac19e380-e93d-470d-841c-7bd3f2b0b86a@broadcom.com>
From: Claire DuSoleil <claire.m.dusoleil@gmail.com>
Date: Fri, 18 Sep 2026 14:17:18 -0700
X-Gm-Features: AcwNN1WaljGdauGkBvfe9yPrQlXWP3R-UBkxQ6xVn22twCqnBT-VZH7PQ_xgAlg
Message-ID: <CAEcBvW0+SqM2zHbaDS+JycXxc-ztzvixKtHVSVQby9viVH=+eA@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: Fix GEM_CLOSE returning -EINVAL for
 PRIME-imported surfaces
To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Cc: Zack Rusin <zack.rusin@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Content-Type: multipart/alternative; boundary="000000000000a20dca065bc86d3c"
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

--000000000000a20dca065bc86d3c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I had Claude Code generate this patch so I could run Omarchy in a VMWare
virtual machine.  Without the fix, all I see is black screen.  It is
currently working but I have to re-apply the patch after every Omarchy
system update.

Claude originally identified the issue as a Hyprland bug but after further
digging, it's really in vmwgfx.  However Mesa has coded around it and I
also had a Hyprland fix that worked as well.  It seemed the best place to
fix it was vmwgfx.

I thought the patch had already been rejected so I do not understand why
anyone is still looking at it, especially since this has been a known
problem for many years.

Claire

On Fri, Sep 18, 2026 at 1:56=E2=80=AFPM Maaz Mombasawala <
maaz.mombasawala@broadcom.com> wrote:

> Hi,
> This looks llm generated, can you disclose the llm that you have used?
>
> As for the patch itself, it is too overly verbose for human review.
> Could you just describe the issue you were facing and what is the fix you
> have done?
> Describing the current behaviour and the overly narrative style is not
> necessary.
>
> --
> Maaz Mombasawala <maaz.mombasawala@broadcom.com>
>

--000000000000a20dca065bc86d3c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">I had Claude Code generate this patch so =
I could run Omarchy in a VMWare virtual machine.=C2=A0 Without the fix, all=
 I see is black screen.=C2=A0 It is currently working but I have to re-appl=
y the patch after every Omarchy system update.</div><div dir=3D"ltr"><br></=
div><div>Claude originally identified the=C2=A0issue as a Hyprland bug but =
after further digging, it&#39;s really in vmwgfx.=C2=A0 However Mesa has co=
ded around it and I also had a Hyprland fix that worked as well.=C2=A0 It s=
eemed the best place to fix it was vmwgfx.</div><div dir=3D"ltr"><br clear=
=3D"none"></div><div dir=3D"ltr">I thought the patch had already been rejec=
ted so I do not understand why anyone is still looking at it, especially si=
nce this has been a known problem for many years.</div><div dir=3D"ltr"><br=
 clear=3D"none"></div><div dir=3D"ltr">Claire</div></div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 18, 2026 at =
1:56=E2=80=AFPM Maaz Mombasawala &lt;<a href=3D"mailto:maaz.mombasawala@bro=
adcom.com" target=3D"_blank">maaz.mombasawala@broadcom.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
This looks llm generated, can you disclose the llm that you have used?<br>
<br>
As for the patch itself, it is too overly verbose for human review.<br>
Could you just describe the issue you were facing and what is the fix you h=
ave done?<br>
Describing the current behaviour and the overly narrative style is not nece=
ssary.<br>
<br>
-- <br>
Maaz Mombasawala &lt;<a href=3D"mailto:maaz.mombasawala@broadcom.com" targe=
t=3D"_blank">maaz.mombasawala@broadcom.com</a>&gt;<br>
</blockquote></div>

--000000000000a20dca065bc86d3c--
