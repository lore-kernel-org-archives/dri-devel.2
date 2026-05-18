Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941B0CD343F
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 23:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B9F610E9CB;
	Mon, 18 May 2026 23:39:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="wWw8WV0d";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8637110E9CB
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 23:39:22 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-488940ccfa6so845e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 16:39:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779147561; cv=none;
 d=google.com; s=arc-20240605;
 b=g4VOztMZ1+cTE47UhLyvWH6cEuumIpyObpXLAL3FED6P0nCYVtCm+cpeZdwmlRHyg5
 FYfx6RzTiMBPfF5q4Yk22foDOZ1QZCrBoIXxgx4ZWLVX9hJw61h4sAW62Sr4amV0PBBF
 rpqBIzVFTV+uwuQ0vSMIYkAlCPNgjV6KnSXwXyPjfawWTFx7PZpkid5042R+9DmXJ5+M
 C65OSch59WiTnGd4BIakqpckyuI7ipPNkPp5KAN0Qv68ccxWHdJ2CoXbyfosGeW/7vYa
 3EH9pCvKtNU614MP4jLGTsm/jMDiyrGqPXr2abIAsam4gLorugEtWNYXODSpJdTMbCRN
 Tm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RlgWSbw/qDy0FEEgyFzO7eBFoHyyLd7vQDOSYcU9a5s=;
 fh=8AzCuTk9VmueLUtDgdjOqXG98M8XXWY+5AmtHr2aKG8=;
 b=TB4jkJhH4GKGnb2LX2ATJX7yMxivd9GZdDpqm2VjUMF6z9sexI2g3jEuCEUIJXVCzE
 9TZyMD8QDLI860vr8+max0oX0a/Y1c1XiUBOGG3LnsjCXm/pWpLAnN3d8ywI6rijhmnb
 lUxpPZCZoTxGiUtvbHJhqtVPXQfSaoJnxyaUvwQ/eBYfs31f8MLQgh3RQJRKk/WS8Y2P
 bVuexwBvWhFQqo+ole5TFsmvHubmHb8fFoFIyPVUxGtAykQl7NBaBu08gB8g1QD8AFdj
 JXksr3UK3Xv1WXnk88hr97s5IHszq8RTL8XD8dTSuJBC/ZznUIFCe21ADSMSr1yrPpZe
 fbbw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1779147561; x=1779752361;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RlgWSbw/qDy0FEEgyFzO7eBFoHyyLd7vQDOSYcU9a5s=;
 b=wWw8WV0dVJKO9SZ76yPhR/gXaWQE9+9lYqx4PPXPEi6ff6tyWEKEmWXkmUjzmOo9F4
 nUy4mN+KfykPLjd6Wz59vJd7+Ea5mz7s6OSwrRstVQmIBJdttsVKj2FjuHxFTaThjRL9
 cctUClIpJsBHmFFKH2QkA4IofFDJ/td9B8jjA4u1j+pP98JzA6BrYYzs0wXO2d4J5RhP
 DIHc1JFjyOMjCI5TsfGyFZ7fKzjnmm+r+ywYj20d86qqqIhTGwfow1Nq0i3hBBSIRrGe
 BxKM7m+eNiwfHYcIABBTfbxDnlBYiDF4qJ+YKvIpHEIGWPBEvHGX0oJ8Bd+Ah9gV17r1
 B8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779147561; x=1779752361;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RlgWSbw/qDy0FEEgyFzO7eBFoHyyLd7vQDOSYcU9a5s=;
 b=XOOy0aTRCLqLHzME121jYMEFBZb97HLYzqSnIRXyXapSfkTeA/0hXlfsJfij+gwoYh
 ZwZh6Hbv94/pZjyU/HIQLnaUqWfgqN1l2lTBhyKBFSKDpr0FL9U1QFdMa9SQW5J9LLk9
 RKvMUU2+mq2MrK8L3fIoHLu4u6dLNIeysH6yOcRoSVooHgfl21D1TEtCj7yyekQd5YhN
 AwTt1ZaGap6RjZ2wyjjBUCpqlcyk3WwzgxmjsOKK/xmtXmEHyMzBFpKppah1vq6m/q75
 KzECzAvuFPsdL2fbR8L2aAmPpTT4Laecxd53tFkcGGBt9WpU/rLpRJFMQnO32nsXaPWD
 UvwA==
X-Forwarded-Encrypted: i=1;
 AFNElJ91HPkCgxjXhP3XIM2bzWxRq5zIWPM8yfotB7CCRgqs78XSm+ncvswjYlc49k32sBWpNZGcS0HzNTs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRt7Tr30HKOA+r+SaZIWAb0ExxclEs0lHOcQ44N760367PK1SX
 q+R+Aq5bBPzm3tPuytRWl5hguAUAhCgFx0veybT96hQqfV+9O3OFBS2hNPuxHYqRKqbsEc0MWR+
 VkDGOmELW6Deqpwm42dfqz9HF2RHyL2rT6A29FFGt
X-Gm-Gg: Acq92OHls2bcOfgXOOQ6yugbUjINo7Pv9T3TD8uRRv1ABNa10YgUrFwd/IQKffg1+cf
 3EIRcGr8zf1xkhwkeu5/MZ9fObMKi/ksOgjB9jbn5TVDRamKzDrEMxzoXQbCMVzWy3Vnsei5AaA
 Si6LfLiKIyPS5BwceS6vAm9bfYeRgxy+IbA7cbKVyAzQbi7/7cm7j5sKtEJTIUFR7svLxeOvdfy
 49M3iU47mcrrdg1UwvTRNCn7SQLIAfFDggKfcgs6al/mC5Dyglin0TKuHHaE3tziO9fzTuiiQMO
 yoz6SrX5qQidwVp8IkDikSQPo0/Z1uONOJqHCaEb9lw4Vcc/
X-Received: by 2002:a05:600c:534b:b0:48f:d634:b18d with SMTP id
 5b1f17b1804b1-48ffa5e1260mr1775015e9.8.1779147560622; Mon, 18 May 2026
 16:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <8ef38815-6ae9-4359-86d4-042554357639@amd.com>
 <CABdmKX2uwZ12kYJYPJGfWxuMBOJS=64b1GRj72tfB5D=NKM22w@mail.gmail.com>
 <CAGsJ_4zjrFJYQQsLThTGXR6g+2PXzeAhjyDpLHfDFqVViWvyBQ@mail.gmail.com>
 <CABdmKX0gqg309hcXcOHSj_yTg0h1zwDL34GDk8mX3wp4YoyfDg@mail.gmail.com>
 <CABdmKX3wwgovwS-V8rVC3=+EZcTvPs_cttpQb1w6WemwLAVhsw@mail.gmail.com>
 <CAGsJ_4y=Gsv=FSUjJ5+99Gg6ULUnv0LRexCGOGetzChR3YA44Q@mail.gmail.com>
In-Reply-To: <CAGsJ_4y=Gsv=FSUjJ5+99Gg6ULUnv0LRexCGOGetzChR3YA44Q@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 18 May 2026 16:39:07 -0700
X-Gm-Features: AVHnY4LTFYlENC6xQVXK8AijxUAKUMiH_YZR8cEYxhyMaKCwg0sVArYGdEg8UAo
Message-ID: <CABdmKX3GgCogr9pQFybnV1p_zuo1V9fqJLCXvk-HAnk1gwLoDw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: Barry Song <baohua@kernel.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Albert Esteve <aesteve@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, 
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, Shuah Khan <shuah@kernel.org>,
 cgroups@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, 
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, mripard@kernel.org, echanude@redhat.com
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

On Mon, May 18, 2026 at 3:19=E2=80=AFPM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Tue, May 19, 2026 at 5:17=E2=80=AFAM T.J. Mercier <tjmercier@google.co=
m> wrote:
> [...]
> > > > > Yeah I think this might work. I know of 3 cases, and it trivially
> > > > > solves the first two. The third requires some work on our end to
> > > > > extend our userspace interfaces to include the pidfd but it seems
> > > > > doable. I'm checking with our graphics folks.
> > > > >
> > > > > 1) Direct allocation from user (e.g. app -> allocation ioctl on
> > > > > /dev/dma_heap/foo)
> > > > > No changes required to userspace. mem_accounting=3D1 charges the =
app.
> > > > >
> > > > > 2) Single hop remote allocation (e.g. app -> AHardwareBuffer_allo=
cate
> > > > > -> gralloc)
> > > > > gralloc has the caller's pid as described in the commit message. =
Open
> > > > > a pidfd and pass it in the dma_heap_allocation_data.
> > > > >
> > > > > 3) Double hop remote allocation (e.g. app -> dequeueBuffer ->
> > > > > SurfaceFlinger -> gralloc)
> > > > > In this case gralloc knows SurfaceFlinger's pid, but not the app'=
s. So
> > > > > we need to add the app's pidfd to the SurfaceFlinger -> gralloc
> > > > > interface, or transfer the memcg charge from SurfaceFlinger to th=
e app
> > > > > after the allocation.
> > > > > It'd be nice to avoid the charge transfer option entirely, but if=
 we
> > > > > need it that doesn't seem so bad in this case because it's a bulk
> > > > > charge for the entire dmabuf rather than per-page. So the exporte=
r
> > > > > doesn't need to get involved (we wouldn't need a new dma_buf_op) =
and
> > > > > we wouldn't have to worry about looping and locking for each page=
.
> > > > >
> > > >
> > > > Hi T.J.,
> > > >
> > > > Your description of the three different cases sounds very interesti=
ng.
> > > > It helps me understand how difficult it can be to correctly charge
> > > > dma-buf in the current user scenarios.
> > > >
> > > > I=E2=80=99m wondering where I can find Android userspace code that =
transfers
> > > > the PID of RPC callers. Do we have any existing sample code in Andr=
oid
> > > > for this?
> > >
> > > Hi Barry,
> > >
> > > In Java android.os.Binder.getCallingPid() will provide it. Here
> >
> > ... let me try again
> >
> > Here are some examples from the framework code:
> >
> > https://cs.android.com/search?q=3DgetCallingPid%20f:ActivityManager&sq=
=3D&ss=3Dandroid%2Fplatform%2Fsuperproject
> >
> > In native code we have AIBinder_getCallingPid and
> > android::IPCThreadState::self()->getCallingPid() (or
> > android::hardware::IPCThreadState::self()->getCallingPid() for HIDL)
> >
> > https://cs.android.com/search?q=3DgetCallingPid%20l:cpp%20-f:prebuilt&s=
s=3Dandroid%2Fplatform%2Fsuperproject
>
> Thanks very much, T.J. That is very helpful. I guess
> that would require user space to understand the RPC
> procedure, including single-hop and two-hop cases, and
> make the corresponding changes.

Yes, this is solvable by having a policy in allocator services where
the caller is implicitly charged, while also supporting cases where
the RPC includes additional explicit information about who to charge.
This needs security checks to prevent arbitrary remote charges at both
the ioctl() level (selinux charge_to from patch 4), and at the RPC
level (not sure yet but maybe a private interface between system
components and gralloc), so that only privileged components can
initiate remote charges.

> You pointed out the SurfaceFlinger cases, which are
> two hops. It seems that AI models are also using
> dma_heap, at least from what I have observed on MTK
> and Qualcomm phones. Likely, we need to understand
> those RPC relationships in userspace and make the
> corresponding changes.
> I assume AI models are a single-hop case?

It's currently a mix because AI model loading is largely controlled by
vendor code right now. Some implementations use
AHardwareBuffer_allocate, but that comes with unnecessary RPC overhead
for the AI use case. So I think we should be trending towards direct
allocations from dma-buf heaps because model loading time is
important.
