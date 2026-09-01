Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBF3C624D4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8F0910F3E5;
	Thu,  3 Sep 2026 07:33:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NPLNc+rj";
	dkim-atps=neutral
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C08810E63D
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 11:26:39 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-90c522298d2so66390366d6.2
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 04:26:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788261998; cv=none;
 d=google.com; s=arc-20260327;
 b=paHELjX3YkF2p5jYeudMSVsrh/z6bPtXvUtPKXMI3sTbUsrskz3O+Mcq4jy5hbg1U8
 gHZykIjpAXlDqOTYoDRZoXzCCYs5haJMU4RMpJe72E9u0eGlcavDYO8NQXHBo1ww+K5r
 iS1ftGc+VpSrjXM1+OZy3SsJCLpjqTpOpd6PBn8mU0HblpX1mh8TH/pUmnltyhPR8OJm
 7QmQ4rHQ2p3449oWHlqCCUlzLW1UKASbHpoYpWDFCPC6kJPFAlb5xPwqaeA6OM1NCt7k
 /8TBvt2+sELC6FCTeVc6p2VEV+UBk8SMAoPoVOALqTuHBx+mO6bq3Grur68EfKFPBspv
 EPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=giTslEtXGSQwPV9RRaIioNPE/e48tpcU8ObIsZM9aC8=;
 fh=50Vr3zYTpaB2uGZJ521AWWPEg2+zNr7U+yxmx4a/8aI=;
 b=cT7ZWUpHSJG0iVa1td4IMdUWXd0ZPDYs3pqzqIFyU0PmyBpaF8IdF7wIHgcktenOrd
 URyqosSU0bfoXnMaqb9bfDjctbA48KiiurgXzB9cbMkjsSVu1l555ue3d0JWD0iuvUmZ
 i6q0txYobSvJVt5e+kW1I2uVWfFkFX6KTxWmS0/07CxdPZMGrAhJYGiJuY5ZpxH7y5Jz
 PQb2FKJVBvrvbGfFOn8KBQCYFSMSeJ1kKs4bir6MJ9+Scx47iFAtxCyF7VtYg0zH4hYG
 KGZjH1zK1s2PTiplJsRKuh9ZZuBK/oUjiCddIXFxcaKpmWdI1+XFgHwB2eyrbr/sa5KU
 d9jA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788261998; x=1788866798; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=giTslEtXGSQwPV9RRaIioNPE/e48tpcU8ObIsZM9aC8=;
 b=NPLNc+rjJRiIlPs46Ctijb84vLQzItKM39ZWNSwue+A03FLY+WwrwEN2qeQlZ5iJFJ
 W86FRk6vOKs27hPL5ZisEdFL47UHd7DtGT7G+qo4XFYrZO7bbVZ+hT0VD3JM/WdidxsU
 3e0m7CEU68E2wE4oqSxUsmQ97yarMJUkO/iXFs+/TVBo4VbnP/P4VjIQMTJ6qigE7VI0
 JXmi3/08LBynJtiqoYwd1/ko5Nm5Ak6ltj1d/B25YhIsgG1JAcE1IW8a4W7I/FrUANVj
 JVsUYEeYYZrsxKoL7mFP5ADPnpmq1JN/A+ZgS+F69u6fsbL2mgrCfBk5wnGfHeApCONw
 ZRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788261998; x=1788866798;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=giTslEtXGSQwPV9RRaIioNPE/e48tpcU8ObIsZM9aC8=;
 b=dIIvAkJ8X+N0iKXmi0dxcgtO3JYP03P2Wer3k1/ANTE/4+nrVqS9ZKDPxI6hFQQma/
 UXrpPdgmXiJ42Ur1mSMnj3RMN8lv5dn/z3uSH7MoGI7ReO+xjpYMNnsVV0SjICGOCOTY
 Y19GrOBhO0QA161iG1LO4Fqst6K/SmD3S7bkmp32U6+aIA2pBpQJzpObEyxGx+fufUqG
 /GM+h9vPX4jEP7Am0CzNO+OGbGukoG5b2W69gZTz63roo9pQ3WCFWjuCGm1ATG0P4iL/
 D/hd+NB2n+viWxCVBYLfx59Fyynn1XpXSHq9cCUs9yBxQMANY7Q/w2tDRCD/Aiy4B6dm
 4mUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXQiiAl57/IDsO18ILa8Sya2fGpaEycno/hTxnYQWb6PDQKDc44CpM46kBhiE/5hAkblSv5CmCBkM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nAbXh3HwqDmf7E+9wd2gS7BQpMpRPIi89MionvWtXIO5c+hXRd
 ymvztGDovH50SdxBs7N5Sm8AROFOrpmP9Z4Uwx1c/8nzA1yoGZ93IHHAaTxVYJhWTzXyU6fDlyR
 BqFIo05VAZlk1WCbqaUQ7LyeWOsVB8A==
X-Gm-Gg: AR+sD13nsVG6ZZDAxw/tltNFJHRKGB4uqm/B4eOqvn9BdSAo95rbiJsyxfUb/Xe3DVq
 ZBZYh8cSHq0zFidCzkhShkCqFx52E/6MEjvqHRtEfoK2pgZsHnlCX2eXfxIwHCfz/RAMPK3Sdyy
 9W3jAkZuVCRczLOzLm76UBMTj1bcEDyX6Vcmla/64re6LQie6eKr/Sz0wP/Zl6vzVsGswoBqQN+
 dsDwXuqoqDtCryMOZZlcQ45AJ8H1ysmi8AntkAol39BJA/os/5wdnvi302T3qvkGB2bASb3AOhH
 3VsY0caW0N5BYnG4rxlgwZBmxdptW+GJV+C39qHWd1av
X-Received: by 2002:a05:620a:440b:b0:939:5551:1e09 with SMTP id
 af79cd13be357-9395551236emr206040185a.29.1788261997538; Tue, 01 Sep 2026
 04:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <CANkdJ2VvJQSBzyOq=LgSW1=Z8-YiN_r9Py2iJ0UJDo55+dbfuA@mail.gmail.com>
 <83f89e11-b265-4d12-97c0-f158e0b5b82d@leemhuis.info>
In-Reply-To: <83f89e11-b265-4d12-97c0-f158e0b5b82d@leemhuis.info>
From: Robson Candido dos Santos Alves <robsonalves.us@gmail.com>
Date: Tue, 1 Sep 2026 08:26:00 -0300
X-Gm-Features: AcwNN1UAl4fHdpkC9IMZ4Sd1yE0VyhaIPoDKzGW1bUu8pkc_c8sFdn5XOcj-MY8
Message-ID: <CANkdJ2Xv-RrTGYt-YyBH4ShE+h05tj_J4ipw5s9X8UdLd1HnWA@mail.gmail.com>
Subject: Re: [REGRESSION] amdgpu: "pixel format with alpha exposed but blend
 mode not setup" warnings introduced in v7.3-rc1
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

Hi Thorsten,

Thank you for the quick check and for linking the fixing patch set!

Good to know the warning is safe to ignore. I will keep an eye on the
series and test it once it lands.

Best regards,
Robson

Em ter., 1 de set. de 2026 =C3=A0s 04:16, Thorsten Leemhuis
<regressions@leemhuis.info> escreveu:
>
> On 8/31/26 15:46, Robson Candido dos Santos Alves wrote:
> >
> > After updating from kernel v7.2.2 to v7.3-rc1, several DRM plane
> > warnings regarding unset blend modes for pixel formats with alpha
> > channels started appearing in dmesg during initialization.
> >
> > Good Version:
> > - Kernel: 7.2.2-070202-generic
> > - Display Core: v3.2.384
> > - Result: Driver initializes cleanly without plane/blend mode warnings.
> >
> > Bad Version:
> > - Kernel: 7.3.0-070300rc1-generic
> > - Display Core: v3.2.392
> > - Result: Driver emits the following warnings in dmesg:
> >
> > [drm] [PLANE:44:plane-0] pixel format with alpha exposed but blend
> > mode not setup. Please fix.
> Thx for the report. Not my area of expertise, but I guess that is caused
> by 9813e158d13d ("drm/drm_blend: allow blend mode property without
> PREMULTI") and will be fixed by the patch set "drm/atomic-state-helper:
> fixes for blend-mode-prop warning":
> https://lore.kernel.org/all/20260826104143.39077-1-mwen@igalia.com/
>
> That patches are afaics scheduled for inclusion in 7.4 -- but afaik the
> the warning is safe to ignore.
>
> Ciao, Thorsten
>
> #regzbot introduced: 9813e158d13d
>
