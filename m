Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8678C982CD
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C23D10E920;
	Thu, 17 Sep 2026 07:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BT7WYAGf";
	dkim-atps=neutral
Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com
 [74.125.230.235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEC9610E49D
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 13:14:58 +0000 (UTC)
Received: by mail-qk2-f43.google.com with SMTP id
 d75a77b69052e-52fb76bcb1fso8824121cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 06:14:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789564498; cv=none;
 d=google.com; s=arc-20260327;
 b=UqNXFalyT6BxTIdbp2J2Eklpt1BS2opHUk+uDugo/hsiHxWx1xm5iIeoCFksldCYPg
 TTCeO9HMBjFe+45xDepGI7rp11k+K0VCkkGVv6VAKNtZWdexnuYyVKqFVLI8Pf3SIgMf
 4ZNxH2nWNFSZTMDCkYTEyTndFYxx50oiiuVmmkAJT7CN9IA5OMeAFrakWBSa0wO5vduv
 tMUYRaRmiZ0wfCbvs1UlS2h8zIhPCdS7VPCcCH2NMyccVMSi3jxMMvRwCPIGjWlq4Sdh
 EwvuxwxLg5l9ayaSjwdb3Xpi+KhoL/3mM4I5aVrqAQxsrXeE7A7hCNpqUWMQhqTD7U7w
 sxng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ayPxym0az/dPYYVwbAryo+qLlPY3Bz4ZHUPUVaRwQrk=;
 fh=p/o2HYMM65dHjgVpQa9F1MIaDk7sg9iVvQubDtylISU=;
 b=YLfyXwhaE7R1Z2wsO8AcgCG5r7NZw/mOU4lX/s7mR85n1TQdE8bshpVfMYdv2jbY1O
 fGSUB8TMtSJ80Q3lDEKM9GxzPAm8qd0dLk2iYk0bt+gXe/FrgD54Bhxvd02aiI7+4y/f
 KKmB/69cjoRhxY0xlJOr944xdq81ELw/KZjRMAId3J1D2lnLew9ZHc7dMeLTgK5yNdXz
 6KBIBGfZHLKK4/DJqWRx+XEtAqjNkPZ1PUUZg8TzCnhggBAdVnQxMlRtk/gHA9o3xiaP
 19wkQw8xWpk5kiAW21KT/xJVqXw3akeJ9/qvDDn2HupkdRLvvBxANPiLEK39oRIn40jk
 Y2Ew==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789564498; x=1790169298; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ayPxym0az/dPYYVwbAryo+qLlPY3Bz4ZHUPUVaRwQrk=;
 b=BT7WYAGfGbbmWxnMT0P2b2CvBA7ogxIN0B1KETqsIIs3X9+jtFvYehFAqvyLI1Jd9O
 qn2ZK3qS2GtQu4fKTQBK7vXoH3JVtuofO6cw1QFQBmxa7zPhkMziNiUVENFlZpIgDSdy
 ajKhuVQrdAwJYXTcLpMWUxfBpjqDzw76KnL7oen+v4VJZi0ifcRuNElgG+DfoxAqa/n3
 3IAo9hAYo8TLxz8A6r+p8Sg+TRdxOvp54M1LvrYRdXbZ7Dy/nDgh2rPXoPGnkvaTNY5b
 6HY5hGDR8g8Tc3LlIe9XiBEib/vJNlkT7manvMrmM5lcyauBW1DLzI1A4g7oQEQq4xev
 N9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564498; x=1790169298;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ayPxym0az/dPYYVwbAryo+qLlPY3Bz4ZHUPUVaRwQrk=;
 b=xlpPMmtgjanVon5mSZYHwv2b8MVw7t2mxJpVkscOkX8XB5p9jm+MHnfB5xyIYdHbh5
 5CtU76Uyfuyf1srNyJrSvve1B8c4nBmILeG37W53fmRkosRqPT+SyJgF+KI/l5dRaIt5
 00I6iX0vjZmtkb734cFt+Z29213VQ3wcl+hq6EXVIye5jLcrXkAtt5bpXR4pJpH8c1R7
 pX+TqC+8XQJgBvvgT8eAWm/idd2hpFTyzsjwVNzpEe7WslTjBrjAy21xY8lDFjBEBn3l
 q92Th/9feoDtG1t/owGwDs7oI+wkZXq57Dmn6I7y+ZWhA8dwIx7QLqCX/KY270870Kdt
 orGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5l/HMoTFO/M2WyPVoENx0eN8LQQxrzPdGaS994MHosGbYWUVjOw6CudiIzgKKCAPRkFJLBYdQYXw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lC1jjNpPHx6QQ+4oAo9/Mu4xgKIGNpPADq7gF5RV+UqW29E6S6
 AEzDfxphi2ZI4Y3ykB1P1htPkzglwgI2OdjyT+Ua7ONa9j8+Ntj7eRawa/POdljkC/mGkI4rLuW
 KVyO1G4nTxvtUJ1HbkTvHpUIQt9xAhy8=
X-Gm-Gg: AYBFou0Vrii2ZUgJ6TLxzY/aoHJN7bNvplWh6Gve2envaLnwh4FhXdgaASAKLdbX9Y3
 +H6zpiZnVnZwx73UzynsmXqRtAfcdpH+j7LuEuP6uCIdzd33d3rajTb3mcHazDtjr47bSUAi529
 yfwA58MOoauVfjpifBzqrgFidd++JVU1eVNgX8Ztxu3tNO14WKfrYNL3ZbNzHw8XvnPvpNC8ei4
 bxiRIrIYjVsuOjAxAyWvfYSEa7mw2empnO3ZRLImfiegSxizaMf3dBq8W3vU7sMgleYEI06QOCb
 D+N/7FRBy3iIh82ERAfHDCG6nepabxjBCmo7w+QZ0Y+h/bvPJZshpkVW
X-Received: by 2002:ac8:7f04:0:b0:52d:cf85:aeea with SMTP id
 d75a77b69052e-5327eeb282emr41860711cf.24.1789564497846; Wed, 16 Sep 2026
 06:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260916093928.52057-1-palaomer100@gmail.com>
 <87ecet5xos.fsf@yellow.woof> <aqp4GA1q6cLKivZo@ashevche-desk.local>
 <CAKhZXnr0GdUrEu9vyMAWRCWyQzPM7cWQ6LRDa8fX0hnMkTN0RQ@mail.gmail.com>
 <87bj9x5pii.fsf@yellow.woof>
In-Reply-To: <87bj9x5pii.fsf@yellow.woof>
From: =?UTF-8?Q?=C3=96mer_PALA?= <palaomer100@gmail.com>
Date: Wed, 16 Sep 2026 16:14:38 +0300
X-Gm-Features: AcwNN1Vm49ztxlf0ieuaRYYQIq3zlaRFigYw8UrkluaAB1jpWTaPVqREkoTpZDM
Message-ID: <CAKhZXnqBko0LABgLa-A6G+ztt1Y4p6yXdcnGDp7HbC3psv9WUQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: fb_upd161704: replace udelay with
 usleep_range
To: Nam Cao <namcao@linutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, andy@kernel.org, 
 gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 17 Sep 2026 07:04:01 +0000
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

Nam Cao writes:
> A crucial difference is that we can call udelay() in any context, but we
> cannot call usleep_range() in atomic context. Thus, a test run with
> CONFIG_DEBUG_ATOMIC_SLEEP enabled is recommended.
> I don't know if non-deterministic delay is an issue, the datasheet would
> need to be checked. But udelay() is not deterministic either, for
> example the CPU may need to handle an external interrupt while the task
> is calling udelay().

Hi Nam,

Thank you for clarifying the atomic context restrictions and pointing out
CONFIG_DEBUG_ATOMIC_SLEEP. That makes total sense, and I now see why udelay=
()
is mandatory here to prevent potential kernel panics in atomic paths.

I am dropping this patch series. Thanks again to everyone for the valuable
feedback!

Best regards,
Omer PALA

Nam Cao <namcao@linutronix.de>, 16 Eyl 2026 =C3=87ar, 15:50 tarihinde =C5=
=9Funu yazd=C4=B1:
>
> =C3=96mer PALA <palaomer100@gmail.com> writes:
> > Thank you for the feedback and review. I note the line-length
> > formatting (~72 characters per line)
> > for my future commit messages.Second, do you understand the difference =
on what
> > code is doing before and after your change?
> > I understand that udelay() provides deterministic, busy-wait timing req=
uired for
> > hardware register initialization, whereas usleep_range() introduces sch=
eduler
> > overhead and non-deterministic delays.
> > Out of technical curiosity regarding the driver IC: theoretically, if w=
e knew
> > the exact window between the hardware lock/stabilization
> > time (min) and the internal state-machine timeout (max) from the datash=
eet,
> > would a range like usleep_range(min, max) be acceptable,
> > or does scheduler wake-up latency make it too risky for
> > timing-critical init sequences without hardware validation?
> > I will drop this patch series.
>
> A crucial difference is that we can call udelay() in any context, but we
> cannot call usleep_range() in atomic context. Thus, a test run with
> CONFIG_DEBUG_ATOMIC_SLEEP enabled is recommended.
>
> I don't know if non-deterministic delay is an issue, the datasheet would
> need to be checked. But udelay() is not deterministic either, for
> example the CPU may need to handle an external interrupt while the task
> is calling udelay().
>
> Nam
