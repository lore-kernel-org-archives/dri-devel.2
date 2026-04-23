Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B750FDEE4E
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 21:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A56510E031;
	Thu, 23 Apr 2026 21:02:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="MMvTPSSP";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C4B10E031
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 21:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776978146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KyHVAQVjpPbhuf4o1Xu8F6CsXTftROq8rBR/ZSbld3g=;
 b=MMvTPSSP+LpLA8FfdfIfYgnM5mU+fZadRMLxLFqkbBocnEjofF2431YZDCTCppkBDh/GAV
 HYOvByxC+QVIU5Mm4GK+OUmQ9C01h07FKN/OqpN74RZdflXUJX6SAxwoEJ2ENhZh//u/Af
 ffrDJxv2ijJnUDQhvhzU7en5GrPfgiU=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-YZ_r7hBGNR6JGhaL9sAV0A-1; Thu, 23 Apr 2026 17:02:24 -0400
X-MC-Unique: YZ_r7hBGNR6JGhaL9sAV0A-1
X-Mimecast-MFC-AGG-ID: YZ_r7hBGNR6JGhaL9sAV0A_1776978143
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2dd1c74508cso11639016eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 14:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776978143; x=1777582943;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KyHVAQVjpPbhuf4o1Xu8F6CsXTftROq8rBR/ZSbld3g=;
 b=TIEvvg6mmwElHJosQ7haylsGQPcVJEVjY0G1Oj0knZI6rXFXWzpWY1lxGmQral760A
 iGPGCldV/IFU4LfM0zIalbyKbjh4fixe9SmOh4L+PPFw3knTaubxRF5TVLb7b3nfzoyT
 x0OCmu6C6QT6sGQ6c+lTn9n4dFs3Vw3BaoJMEYmT5qc0L2qvCFdvxCVuVYRgBROnXVUi
 evcQOEIkLxeOaUEESu7R3kuy3jgXVt6+n4r+xdyq57sW9cI5i49n7riLZF5I48jecrN7
 rTegZByrahqPMcGIeoT0/c7qoy7Ps1MJ7avqN2mPx/Zeuuul9YQ8sK+hu1tl7cAi8ZKo
 31Vw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8sWG9Ypw8eBQSJnRC+HbzsQ4F4qOdUJQI2nW2kIxRmVoBDjae1EpqXoUCnMwzMhNVSKQtsY2Cd56M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFFFAgKwGq2a7jbmTFCnIUNfs1H+YTka/McoXUi4CLeN04Nm2Y
 aFYCl9XA+1em09ujmRhrT75JNbkZOIZvKzLc8tpc/SwtcUIxqJz9tJnS3e1QQNVNqrrmtp2Q24s
 15x0EiKOlPteMxDkOcs0hYr1Vk/ofuoGxApVNuqVT7P4ko1ck4tUV0fFBhKI/L9Ncc340v9FQVf
 Vdu1TaZwQk+cbokac2ewYRhiL6WxiH4kjAOeSZ0PiHClX5
X-Gm-Gg: AeBDiett/5q7jt/rr6YCgH/tBkhvK5JMmEZPLMMrB2UF6xe+xA5JMsSUgImq+yPmjiU
 MAdOxeHdSrGCNQbY6NgiGzI5Ye9ZA3YeZUlUZULVvdrKe9xKatwFoyiKxA00RVslyB/Qq4OH5wf
 8gmW6E43+z8B9uqgz3Yp+F5K9xfjMgjpgPPFdh6pJPlYVNNrASLVTM6w7b+hDuefsJ/538V5TmT
 A0Bej17Tz3DvYrHhoVlvDM2R87As7f3rUh5JdZ7uGmvr+A=
X-Received: by 2002:a05:7022:61a9:b0:12a:71ab:8235 with SMTP id
 a92af1059eb24-12c73f694b7mr14497403c88.6.1776978142944; 
 Thu, 23 Apr 2026 14:02:22 -0700 (PDT)
X-Received: by 2002:a05:7022:61a9:b0:12a:71ab:8235 with SMTP id
 a92af1059eb24-12c73f694b7mr14497377c88.6.1776978142129; Thu, 23 Apr 2026
 14:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <76aba88d-ec23-4b3c-ad91-83face0c3e94@intel.com>
 <a9d176ec-d19b-4f41-af16-cdc4e475a8cc@suse.de>
 <6ec01703-31e0-4998-9508-a5a115ae7bc9@intel.com>
 <14aa4840-29c4-46df-b60d-8e1b92494ad2@redhat.com>
 <e9cca01c-960d-495c-aaba-327eac43cad6@intel.com>
In-Reply-To: <e9cca01c-960d-495c-aaba-327eac43cad6@intel.com>
From: David Airlie <airlied@redhat.com>
Date: Fri, 24 Apr 2026 07:02:10 +1000
X-Gm-Features: AQROBzCAwImz-5abHg3S9yFtZXMvK-v6ehmaz9_dEpaHs7XDYGIfhoinZbUVrYo
Message-ID: <CAMwc25o=3EHkJYG=qYrgtmmB9raqbsaif6hOKLi0awG-ydWZWQ@mail.gmail.com>
Subject: Re: further issues with MGA G200 graphics chipset
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Pasi Vaananen <pvaanane@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ffs6rYM92mVBSXAk1HfMR5ciIM4-XL29PAvce1TV0wQ_1776978143
X-Mimecast-Originator: redhat.com
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

On Fri, Apr 24, 2026 at 5:42=E2=80=AFAM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
>
> On 4/23/2026 12:22 PM, Jocelyn Falempe wrote:
> > On 23/04/2026 18:35, Jacob Keller wrote:
> >> On 4/23/2026 12:44 AM, Thomas Zimmermann wrote:
> >>> Hi
> >>>
> >>> Am 23.04.26 um 01:55 schrieb Jacob Keller:
> >>>> Hello,
> >>>><snip>>>> I'm also curious if its possible to stop polling for so
> > long with udelay
> >>>> in the i2c logic somehow? I am not very familiar with i2c, but it is
> >>>> frustrating that this driver is causing yet another stall that is
> >>>> impacting timing sensitive data. Even if in this case its due to a
> >>>> faulty cable.. it is frustrating that such result causes the PTP
> >>>> failures. Would switching to WQ_UNBOUND be helpful here at all?
> >>>
> >>> Try Dave's suggestion to avoid polling.  The driver won't be able to
> >>> detect changes to the connector status, though.
> >>>
> >>
> >> That's fine. I don't think we're even using the device. It looks like =
it
> >> might only be in use for BMC, and the VGA connection isn't actually
> >> physically available, so there are no changes to detect.
> >>
> >> Is this polling really only to detect when VGA is enabled? Would it ma=
ke
> >> sense to only poll on platforms which actually *have* that VGA
> > connection?
> >>
> > Polling was introduced with https://patchwork.freedesktop.org/
> > series/131977/
> >
> > The driver needs to know if a VGA monitor is connected or not, to
> > provide the right available resolutions to the userspace.
> > Otherwise you can set a high resolution that works from the BMC, but
> > then connecting a VGA monitor will not work, as the driver won't notice
> > that something has been connected.
> >
> > The mgag200 doesn't have an IRQ or a register to check if something is
> > connected on the VGA port, so the driver uses the i2c and tries to read
> > the EDID.
> >
> > Unfortunately, there is no way to know reliably if a VGA connector is
> > present. It's possible to disable polling on some machines using DMI
> > quirks, but I don't think this approach will scale.
> >
>
> Timing sensitive setups like mine must have system admins who know to
> manually disable mgag200 or disable polling. Many users won't be aware
> of this. If the polling were not intrusive, this would not be an issue.
> But....
>
> Faulty hardware (perhaps just a cheap pull down resistor on the VGA
> connection as Dave Airlie suggests) means that any such affected
> platform has a polling routine that causes significant issues on any
> timing sensitive applications.

We could write a patch to just say if we see 10 bogus EDID polls we
just give up and loudly say in the logs.

This might break some crash-cart plugins in some data centers though,
I don't think we have contracts in Matrox or the server vendors who
make the hw to say how they recommend finding this info.

It might be in ACPI or dmidecodes.

Dave.


>
> Right now, I am stuck in a situation which means that I have to fight to
> reach every customer who uses one of these platforms and confirm they
> either disable polling or ban the module so it won't even load.
>
> This is frustrating, as it is unlikely I'll reach everyone.
>
> I doubt that I'm the only one with users who are affected by mysterious
> performance or timing problems related to this. While its true that not
> *every* instance of the device is problematic (at least not now that we
> fixed the other issue with the udelay...), but many systems using the
> controller *are* negatively impacted even with the timing fix, as I have
> now seen...
>
> Unfortunately, I also have no better idea than a DMI quirk table to
> record known platforms that include the controller but don't have a
> physical VGA connection exposed.
>
> Thus, I'm wondering what else we can do? Using WQ_UNBOUND might help
> somewhat? I have no idea if its safe to sleep instead of spin while
> reading the i2c connections... As far as I can tell the non-atomic
> version has nothing that *strictly* prevents sleep.. but maybe i2c
> access has tighter timing requirements than what usleep_range can
> fulfill? I am not sure...
>
> I'd just really like to not have to worry about going to every single
> user and asking them to unload and ban a driver for these big server
> platforms...
>

