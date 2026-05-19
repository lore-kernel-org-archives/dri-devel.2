Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319CFCD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 18:07:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 801A810E197;
	Tue, 19 May 2026 18:07:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="YfJAc5gy";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6278510E197
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 18:07:50 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4891ca4ce02so455e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 11:07:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779214069; cv=none;
 d=google.com; s=arc-20240605;
 b=GpJgtATjKZgskNSw+SB+sTfMPO6e/o0IoeBiQ4TnSu7BDHX7kLgqWQx3uzpc+9zFQK
 Y1g317va2KOGzHbhIRf2+6/+3X+kTSHPfXwXRIhIYXZb5uid7SUYZFYKtQqWIfD3kLNH
 Ck1wmhPHy0XO75weQV2KgSNIX5lQ+SLrC66pzS6EusY2z3YkOwAOYMXZTq4+FgpTtTG/
 2t5ha8fhXaO15+KYDimo9U1uNAyLcNYzSTObH5wYKZGt376kUBS01BwEs+0aXG6o1wod
 tPmkeTYIsaVb1DBoWietrAwfNoPoQsagBsW1L1249/At96Xi50G4+U+WwpSXOw85CfBD
 7Tbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xssGkiKE0NLLgIm8hq0sx4z1JVWvwtNlxiDz+CYQuyY=;
 fh=uwkBh/G60upMWUIsbfwEhn83luqGHav1p7lzA7SyWjQ=;
 b=d2ohzkudezvCBbEU7durWBt+jXIFUKpgpf8hltbOdozM9Q0eephYaOy1YChCJq/BTn
 sVSw+I1Ac+dBYEf9THpMnZDVOyQIpKuKjnfsUEvXAx0dbNG9/Xu7kYdm6cHP1vOdFVl9
 4gdPt+WY5Dgkbli5EYWa7pOOKiiD7hOpMDakdTo3IP/YQocw80A5elfeXc6IPo/9kg8U
 j5Wb1tHkpEpDAvL3/pkAntafnITuUO9nsT2utw/brDZwHc6eFW+QhkpQ0oKLcoT3QPvq
 7UshNNsOARG1Dz/F+1iFQHptEdCx2LVmQgE4vAwKF3p6TNVQ8sH5Qfp4sI/tCm5bgVfd
 YZUA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1779214069; x=1779818869;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xssGkiKE0NLLgIm8hq0sx4z1JVWvwtNlxiDz+CYQuyY=;
 b=YfJAc5gycNWA357FV//2FlRmETePTuS3G2fbU9EuYj7yPhZh5JJbgFWQLH8V8/E97p
 +cZPCfuH4cRxBz1psGKGmuqAbP97Lx025Fi26EryS+LZm5YcasHSyOeQ6Tt/DGbj3Y2e
 sKXUyO+m3QMG/8rZEK+uViX20QpbmOdtIRjFYqZu33Htlx/XVerHxnMn+6Z6RfIoSGNp
 TYQFkepkJZjoHdM01D+1Hxok6+M3sl15W81PmWHFpGeubzi3LvcWpNgPX58bCePsIwg2
 5cCjDIB/wnQ3Ix266a2nL/pdaLDEXmtS3gEmV6qeDlQf6pip1tC9Rd50HKNZnzlwcrpl
 cVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779214069; x=1779818869;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xssGkiKE0NLLgIm8hq0sx4z1JVWvwtNlxiDz+CYQuyY=;
 b=iHOHgndOsw+HI8yRz448aubwS3aNiL3l4MGxRbxNinrNcsf/HMaQtuUYv33/u9f1ZC
 HLhQR2NkYwx+BfvFom2g0W4E8MePHtZndNOnXhAfu6QOrVd03pthTYSMw6Ko5rzmLTRh
 +zyNEy9m1eRWaZz5Z69i26rLh5TJVwM2TGX5jsBfWNu7bKr/XffGSwXEST15Q0BCeSdj
 UtEF4X6tZ7aP5xP1lUFr5b0FsnwudZPUAhDX7XBcGajkG17tKtRgPceP3L/TOr1SPRRI
 hJHjqRSjWFg/uM4FX3lfMWfoU2cxAjMuLEJjlR0oPrdA39KkYh4EKs1oos0BDTH8Jw9v
 0WLQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4lWnh2D/whVumhic+lwHGUxLVbm0qqT+6oI6d9AxESLwtAw5Qq3wnkiqfikrk6UfTfOuZsX+J2bw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywk1OqiMRwZIo9Fj0vElNxXcEnykIPwrjQlhWS+0dYhSvR6IW0S
 yvFVuvcIzwInyUbKH5/MUnCiiJlDhSlDxNjbTQD3rE5+TeyMOwxBjEvLTwCQvbhyCknO1sQjCPC
 UprVS9+CKRPN3/JXUYSftLJ0wYb0b/00TWO0T1hes
X-Gm-Gg: Acq92OG3MggGAfWAPpQ+LM9A+gfPvfzjsFSJSvwwNQ2Tl6s2zhdk1wj9H02KEysnDqv
 LULO8zAXdi0N3hZzPA6LPIYVnNCPgsfGF89RIuezgyPYGYfnrSV1R2uQr6N9FD0ZOnnFLHEda5W
 ao6BCfJ12+oH8n7I0gLgjw7/usS7cThfV1MFolNlPyxutR6ufzQxL1RIzYBnzT3bvJ4aaquopSf
 Mg9i29/Iz3LJopAyNV63WQOk14OCFbK+XjvHvO1IbkgNKnQFVuy3n5QaZbGdxfyZhsBxVVJlDfY
 g53jRIJ3kksizX5BjDVVm62K8E0Ne8u5Jjc1bLMgPCtKJ1UP
X-Received: by 2002:a7b:cc8b:0:b0:48f:de33:777a with SMTP id
 5b1f17b1804b1-48ffd857abfmr3637845e9.11.1779214068422; Tue, 19 May 2026
 11:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <20260515-hinschauen-effizient-9e3a05a94f2e@brauner>
 <CABdmKX0d6Zsg+_TxXjB80UZR23ZvXzxYoWzORgwmx=ZiuE+Nzw@mail.gmail.com>
 <208fb820-d8eb-4832-a343-ef8b360e8120@amd.com>
 <CADSE00Lh95ygoXGKJGsYvQGEsFV8sVmwEC3uvh8M6r3ERzaJwg@mail.gmail.com>
 <88efe10a-8b93-4a81-8279-4a5559d0f17c@amd.com>
 <CABdmKX3yZubjDKbVqwrjHAiKyj_ioHzOoxd0wzFbJK=PAGOqcQ@mail.gmail.com>
 <01b6eefc-c107-4f8c-9d7c-3b86f54cabaa@amd.com>
In-Reply-To: <01b6eefc-c107-4f8c-9d7c-3b86f54cabaa@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 19 May 2026 11:07:36 -0700
X-Gm-Features: AVHnY4JsuFzXOj8AzAQ7jEDe53JgzbJyOG548qhgZV3zTdsbu0QldI49eMqYz9w
Message-ID: <CABdmKX1wLoLuWPUEY3D7afQhO0AUnOE7c3iE-VkPuKdeQixBxA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Albert Esteve <aesteve@redhat.com>, Christian Brauner <brauner@kernel.org>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, mripard@kernel.org, 
 echanude@redhat.com
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

On Tue, May 19, 2026 at 12:19=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/19/26 01:39, T.J. Mercier wrote:
> > On Mon, May 18, 2026 at 7:07=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 5/18/26 14:50, Albert Esteve wrote:
> >>> On Mon, May 18, 2026 at 9:20=E2=80=AFAM Christian K=C3=B6nig
> >>> <christian.koenig@amd.com> wrote:
> >>>>
> >>>> On 5/15/26 19:06, T.J. Mercier wrote:
> >>>>> On Fri, May 15, 2026 at 6:53=E2=80=AFAM Christian Brauner <brauner@=
kernel.org> wrote:
> >>>>>>
> >>>>>> On Tue, May 12, 2026 at 11:10:44AM +0200, Albert Esteve wrote:
> >>>>>>> On embedded platforms a central process often allocates dma-buf
> >>>>>>> memory on behalf of client applications. Without a way to
> >>>>>>> attribute the charge to the requesting client's cgroup, the
> >>>>>>> cost lands on the allocator, making per-cgroup memory limits
> >>>>>>> ineffective for the actual consumers.
> >>>>>>>
> >>>>>>> Add charge_pid_fd to struct dma_heap_allocation_data. When set to
> >>>>>>
> >>>>>> Please be aware that pidfds come in two flavors:
> >>>>>>
> >>>>>> thread-group pidfds and thread-specific pidfds. Make sure that you=
r API
> >>>>>> doesn't implicitly depend on this distinction not existing.
> >>>>>
> >>>>> Hi Christian,
> >>>>>
> >>>>> Memcg is not a controller that supports "thread mode" so all thread=
s
> >>>>> in a group should belong to the same memcg.
> >>>>
> >>>> BTW: Exactly that is the requirement automotive has with their nativ=
e context use case.
> >>>>
> >>>> The use case is that you have a deamon which has multiple threads we=
re each one is acting on behalve of some other process.
> >>>>
> >>>> At the moment we basically say they are simply not using cgroups for=
 that use case, but it would be really nice if we could handle that as well=
.
> >>>>
> >>>> Summarizing the requirement of that use case: You need a different c=
group for each thread of a process.
> >>>
> >>> Hi Christian,
> >>>
> >>> Thanks for sharing this atuomotive usecase. If I understand correctly=
,
> >>> the actual requirement is attributing dma-buf charges to the right
> >>> client, not putting each daemon thread in a different cgroup?
> >>
> >> Nope, exactly that's the difference.
> >>
> >> The thread acts as a filtering agent for both memory allocation and co=
mmand submission for somebody else, the process on which behalve the daemon=
 does things can even be in a client VM, completely remote over some networ=
k or even something like a microcontroller.
> >>
> >> Everything the thread does regarding CPU time, GPU driver memory alloc=
ation as well as resources like GPU processing and I/O time etc.. needs to =
be accounted to one client which can be different for each thread of the pr=
ocess.
> >>
> >> The only thing which is shared with the main process thread is CPU mem=
ory resources, e.g. malloc() because that is basically just needed for hous=
ekeeping and pretty much irrelevant for this kind of use case.
> >>
> >> The problem is now you can't do that with cgroups at the moment but un=
fortunately only the kernel has the information you need to know to do this=
.
> >>
> >> So what you end up with is to define tons of interfaces just to get th=
e necessary information from the kernel into userspace and then essentially=
 duplicate the same infrastructure cgroup provides in the kernel in userspa=
ce again.
> >>
> >>> If so,
> >>> the `charge_pid_fd` approach achieves this directly by passing the
> >>> client's `pid_fd`, without needing to add per-thread cgroup
> >>> infrastructure.
> >>
> >> Well it's already a massive improvemt, we could basically stop doing t=
he whole duplication part for the GPU driver stack and just use cgroups for=
 this part.
> >>
> >> Doing that automatically for CPU and I/O time would just be nice to ha=
ve additionally.
> >>
> >> Regards,
> >> Christian.
> >
> > Hopefully I'm following correctly here.... So you are duplicating the
> > GPU driver stack to achieve remote accounting on a per-thread basis?
>
> Not quite, we are duplicating the handling cgroup provides in the kernel =
in userspace.
>
> For this memory usage information as well as execution times of the GPU k=
ernel driver is exposed in fdinfo for example.

Oh I see, thanks.

> > Does this mean for GPU allocations you currently have some GFP_ACCOUNT
> > magic in your driver to attribute GPU memory to the correct remote
> > client?
>
> No, we just expose what the kernel driver has allocated for itself. E.g. =
page tables, buffers etc...
>
> When userspace allocates something using memfd_create() for example we ju=
st ignore that.
>
> > So this series would close the gap for dma-buf allocations,
> > but what about private GPU driver memory allocated on behalf of a
> > client?
>
> Well we would need a cgroup which isn't associated with any process were =
we could charge the GPU driver allocations against.
>
> But good point, charging against a pid wouldn't work in this use case.

It would be pretty low overhead to put a process doing while(1)
pause(); in a separate cgroup for this purpose, but I guess a fd for
the actual cgroup would be a little cleaner in this case.

> Regards,
> Christian.
