Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F0ECD343F
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 22:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 557A310E9D0;
	Mon, 18 May 2026 22:19:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qyZJUz3l";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AC5010E09B
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 22:19:16 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EBD54441DC
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 22:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECC8C2BCFC
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 22:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779142755;
 bh=QwPwsIbtmpQIwK98XGhoY5fkgFLxHo2PkgkWS665XEM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=qyZJUz3lOE231ha1IEgeYCxzXObaBETWrQBGKq7jiBGkIh4nlvzjaS1TAQZaKyghd
 WDzrb3TUj0axyMqG43s65YrlArYPvTovp39xj+zWXlSEZkB/C3psRaH3ys+YFPYef6
 5D60lPcDGQ9O33yd9uN09xwZPsQe9mQk8eG+BTp9LDFDDWUMfWG1b6yAGyIGkBv4Ag
 qfkGTVH7AgNRJ9Zo2irgcAte/2WSIdAcFzDGVpK3u/VaQrHckAWehw9ObBZIUPSVkk
 KAdRksrtZo+nB9IDEhi1kKHkcgOBBtfGXGlTzgrXAgWDx24Ws47LblQp1hDG5ZG9cU
 mkTW/MSf1zlTQ==
Received: by mail-vs1-f43.google.com with SMTP id
 ada2fe7eead31-636970cf66cso2135832137.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 15:19:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9Oxuy9naPi2cqnS59zrA3w+gOcNFXm+K6Ja8rieytnR9gQD16CmIliC904eTFh7JqY3aV/EybWqSM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxyNw4F6nxi4PFrYsL3XpvnSRgpEo/nJsbOGOmy6XgDbg45kFNJ
 lold1m1EsuxpjGa+I3w8ocvtFNAA8yUYvq2uRQA1PWddeVpehQPxELclEqrB+wOgTocYiJ1HHiN
 UFehm9hfHj1rZXR+LIN+n8EVqCiv2NhI=
X-Received: by 2002:a05:6102:6:b0:65a:fec7:137b with SMTP id
 ada2fe7eead31-65afec72d9emr1102084137.0.1779142755093; Mon, 18 May 2026
 15:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <8ef38815-6ae9-4359-86d4-042554357639@amd.com>
 <CABdmKX2uwZ12kYJYPJGfWxuMBOJS=64b1GRj72tfB5D=NKM22w@mail.gmail.com>
 <CAGsJ_4zjrFJYQQsLThTGXR6g+2PXzeAhjyDpLHfDFqVViWvyBQ@mail.gmail.com>
 <CABdmKX0gqg309hcXcOHSj_yTg0h1zwDL34GDk8mX3wp4YoyfDg@mail.gmail.com>
 <CABdmKX3wwgovwS-V8rVC3=+EZcTvPs_cttpQb1w6WemwLAVhsw@mail.gmail.com>
In-Reply-To: <CABdmKX3wwgovwS-V8rVC3=+EZcTvPs_cttpQb1w6WemwLAVhsw@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 19 May 2026 06:19:03 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4y=Gsv=FSUjJ5+99Gg6ULUnv0LRexCGOGetzChR3YA44Q@mail.gmail.com>
X-Gm-Features: AVHnY4I1qEOEZQdYFnOfKNfIzm2SBPuZfZoateaLto4Ne3PZjITQyUeamdYuj98
Message-ID: <CAGsJ_4y=Gsv=FSUjJ5+99Gg6ULUnv0LRexCGOGetzChR3YA44Q@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: "T.J. Mercier" <tjmercier@google.com>
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

On Tue, May 19, 2026 at 5:17=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
[...]
> > > > Yeah I think this might work. I know of 3 cases, and it trivially
> > > > solves the first two. The third requires some work on our end to
> > > > extend our userspace interfaces to include the pidfd but it seems
> > > > doable. I'm checking with our graphics folks.
> > > >
> > > > 1) Direct allocation from user (e.g. app -> allocation ioctl on
> > > > /dev/dma_heap/foo)
> > > > No changes required to userspace. mem_accounting=3D1 charges the ap=
p.
> > > >
> > > > 2) Single hop remote allocation (e.g. app -> AHardwareBuffer_alloca=
te
> > > > -> gralloc)
> > > > gralloc has the caller's pid as described in the commit message. Op=
en
> > > > a pidfd and pass it in the dma_heap_allocation_data.
> > > >
> > > > 3) Double hop remote allocation (e.g. app -> dequeueBuffer ->
> > > > SurfaceFlinger -> gralloc)
> > > > In this case gralloc knows SurfaceFlinger's pid, but not the app's.=
 So
> > > > we need to add the app's pidfd to the SurfaceFlinger -> gralloc
> > > > interface, or transfer the memcg charge from SurfaceFlinger to the =
app
> > > > after the allocation.
> > > > It'd be nice to avoid the charge transfer option entirely, but if w=
e
> > > > need it that doesn't seem so bad in this case because it's a bulk
> > > > charge for the entire dmabuf rather than per-page. So the exporter
> > > > doesn't need to get involved (we wouldn't need a new dma_buf_op) an=
d
> > > > we wouldn't have to worry about looping and locking for each page.
> > > >
> > >
> > > Hi T.J.,
> > >
> > > Your description of the three different cases sounds very interesting=
.
> > > It helps me understand how difficult it can be to correctly charge
> > > dma-buf in the current user scenarios.
> > >
> > > I=E2=80=99m wondering where I can find Android userspace code that tr=
ansfers
> > > the PID of RPC callers. Do we have any existing sample code in Androi=
d
> > > for this?
> >
> > Hi Barry,
> >
> > In Java android.os.Binder.getCallingPid() will provide it. Here
>
> ... let me try again
>
> Here are some examples from the framework code:
>
> https://cs.android.com/search?q=3DgetCallingPid%20f:ActivityManager&sq=3D=
&ss=3Dandroid%2Fplatform%2Fsuperproject
>
> In native code we have AIBinder_getCallingPid and
> android::IPCThreadState::self()->getCallingPid() (or
> android::hardware::IPCThreadState::self()->getCallingPid() for HIDL)
>
> https://cs.android.com/search?q=3DgetCallingPid%20l:cpp%20-f:prebuilt&ss=
=3Dandroid%2Fplatform%2Fsuperproject

Thanks very much, T.J. That is very helpful. I guess
that would require user space to understand the RPC
procedure, including single-hop and two-hop cases, and
make the corresponding changes.

You pointed out the SurfaceFlinger cases, which are
two hops. It seems that AI models are also using
dma_heap, at least from what I have observed on MTK
and Qualcomm phones. Likely, we need to understand
those RPC relationships in userspace and make the
corresponding changes.
I assume AI models are a single-hop case?

Best Regards
Barry
