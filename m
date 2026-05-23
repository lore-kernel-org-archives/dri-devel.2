Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9F2CD5BAC
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 14:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 482F610E30F;
	Sat, 23 May 2026 14:49:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FFfgHPm+";
	dkim-atps=neutral
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42A8010E309
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 14:49:02 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-67c4aaf76ecso13236627a12.3
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 07:49:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779547741; cv=none;
 d=google.com; s=arc-20240605;
 b=R+QZdeGm8ffo02eDJ76i6N9dz9CVejIZmdwXK91XlV1G02PrUIcbUYHYrkAJMaBqau
 hSTI8D6XvGxdEGtqjQhi/Pw09eJXhNGNu/Y+xt9gAVgLZOCpx9babVK3T07MOZ9rXPQX
 B+3csSNA/DzudfRFetS0UeED3+siSsvyISqKu3VX6x59daG7dCtpUDutgCw6/48wnuAz
 RBwZgXoyiW0Pekpt+28EHmnVITlIFPSBrmF9dsgIJZgSxBm3DGxYtbpatlnv3to+vLiN
 vBzM80/qSKZg41UhK8XOmt1vwtUxqFMSQtbF7CB2NAKYbo8JM4N1j9wBtmchW+iKflkM
 5IDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dJ6anXWxKYMTLL9fyM/A3M4Ad1F60HO0HgpiKzYTKao=;
 fh=ppVYJ1tc3ficFPyU1l5EAE5Egv+JTc8/4+cRvotOW5I=;
 b=P6oN3iQ5QbcqTJTCV/z4gigTKWymmPnBzw5qC5+alqO+angIj/pwKNUlxdmFWU3tQ3
 JAwTdSB6Zg22+Zoq4aBkaMlIBLqWkEC/jWnu86LnyoPWligeuYEH/MdGIDsSijdZ9/YP
 fC8WNIvX1EPTwa2MhaDC+zMRx6N+PTZyAayfsoVpoXs1sjmxAwTe+NXGyxmhylIl584H
 NEnjHTGkldCajjPsLFh19xEXe1CypSmsmHXFp3CRHXRYE1xiQ9Ulna7gB7do3LgGW041
 GUWBhx5Q1BfPX+Uz3lsKOH+3IeTP7QFhnwXbyz8/7xeq9TrlqvGBZx1vKo3AiOZxEFnQ
 0X6g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1779547741; x=1780152541;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dJ6anXWxKYMTLL9fyM/A3M4Ad1F60HO0HgpiKzYTKao=;
 b=FFfgHPm+7rJJioapygUO3msk76fcq2W/uffDMpNx6v99ojYH4BOTVzigIg8d9p8Mvf
 DmOAHu3xMUiz1NyrsMgdG6hf+OvrDOvuaXGAxVRFTMYQJxGI9QgVX+h4rIWgWUVfKrZl
 AL1EkJMTWah7DT3F9Xm7QHpp5UhUiyNXR0XyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779547741; x=1780152541;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dJ6anXWxKYMTLL9fyM/A3M4Ad1F60HO0HgpiKzYTKao=;
 b=Nc0bHK/eijIFWs5hvGoHjnQs4NP7AucH807aW79v+XI8LnxABU8Y1mxdQ+W4Pqm78v
 LChdliHjr7fUvIs0bJD5lxdtMjJYrCaqieogI1O6Z/sWvQqPKJld+dMc446lRXfeTglD
 5c/jMPnn9TIyPrOrDqjEjIvPoA1+YLyT4+/WtEU02kbE3fqQqhSqOm2JIHPdwC5CbbIc
 Ii8BNVIsP7duWF35PB/4xK37hX0l05CEhyzSRG3AsIWDyZFEWFDHJg8+VYntToTUif3M
 bI/Mwn1TpWIYBydgkThPmb3czTlLxEDe/mI46O2DuRrJF3MVZ5O1Aami7tbMN0N4qxdf
 gXLg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9fNVhWocu4w6I9D3pury+TpK70/4K6BKdWL63WJreo2tY890KnuQb/gaQCfQSuNx/jli+awMSDs2c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzEPxhpzjIT+WYIPuAdmHUZDikr6mjV9l763xGohH4CNJYXlQlx
 JFp+XgAefHMMIkcG+Wz+Tf2t0gSGEB/L1Uwhv8tzj+LpqcXGjMdfXVAmftovi6jorjDsHvFDPV0
 1MVpc9YPnU4GDZCZndKP68NdyGIs+BkfhLyHilIpmWA==
X-Gm-Gg: Acq92OE8kUDJ8/3yxi+4WMMwIWd33TX7ABMq5lgWpphc/bRqgMcwyapD4aPf5dR1IbW
 5BQkKGzQIZ8CrvlWTz8vAbtRNtKhTYj+kH97nJhRTtiiFxol4G6q6r1E4iU7EKrkzzdGyqrWfYF
 2PXAS9CePbqUZ/x2vTZjuXWDvNr7j1+5kwr6dX3ER5dXpkNGOpTl2WGGiyVwh5jhcxve6gufksE
 7cSGYOrGoYuomsMuxxi5Bg82Ettq2p+SZK68pXqbxrBNXWddk1VfprJdSFlvT2xjg6xE3o7+0iJ
 xFreHMJI/1J9uojrs8bsphPEGt3ZiuMZB8GU/8tHJX6Cw0BeVQ==
X-Received: by 2002:a05:6402:43c5:b0:676:9c6d:5c59 with SMTP id
 4fb4d7f45d1cf-6889c406c91mr4037615a12.2.1779547741254; Sat, 23 May 2026
 07:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whiv=b+dAvjaZDsZkfUEzjZMSSLExDOWVcbJ0exsCj6_Q@mail.gmail.com>
 <6874536d-ab1a-4dd7-a23f-2a071bda145e@lankhorst.se>
 <CAHk-=wj5aE1yVMb8RM2AuNUHSMnQDaGT+Vy+At5ds1vxBA+Kng@mail.gmail.com>
 <ahDAErDSE-SFA0oM@intel.com>
 <CAHk-=whX59mtUnU2ayMWoDQX6Ee2NXLK2NxQ+dZnb-Qc_mF1hw@mail.gmail.com>
 <af9278d3-4002-4e09-9bcf-bc75d1cf8145@lankhorst.se>
In-Reply-To: <af9278d3-4002-4e09-9bcf-bc75d1cf8145@lankhorst.se>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 23 May 2026 07:48:49 -0700
X-Gm-Features: AVHnY4KEVEpp75kX8G4Rhk0bsk3iMbWvcHaEkzBiByL61-bRiRVSFHCy-rN0x5w
Message-ID: <CAADWXX-pfvA3mKWSjdahnihAXHQB2VP9BOJDCXonG3Q_nxurLg@mail.gmail.com>
Subject: Re: drm: xe: Kernel-submitted job timed out
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-xe@lists.freedesktop.org, 
 dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, May 23, 2026 at 1:29=E2=80=AFAM Maarten Lankhorst <dev@lankhorst.se=
> wrote:
>
> Does it happen more frequently when loading VRAM intensive programs?

Well, "more frequently" is hard to say since it's happened twice, but
this time it certainly happened when launching a new program.

This time it was a markdown viewer.

I wouldn't expect that to be particularly VRAM-intensive, but hey,
since I run with two 6k monitors, I suspect *anything* with big
windows will chew up a few hundred megs of VRAM just for the frame
buffer side.

It's a B50 Pro, so it's a discrete card with 16GB on card.

I have no memory of what it might have been back a few months ago. But
I would expect it to be all the usual stuff - ten terminals, a web
browser with a dozen tabs, and whatever gnome and wayland do, and then
the occasional random other thing.

             Linus
