Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893BBC44537
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CE7610EB8B;
	Tue, 21 Jul 2026 22:11:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BBE29qTM";
	dkim-atps=neutral
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B15B10E3A0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 16:36:35 +0000 (UTC)
Received: by mail-pj2-f3.google.com with SMTP id
 d9443c01a7336-2ccbff2e6a7so67612085ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 09:36:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784651795; cv=none;
 d=google.com; s=arc-20260327;
 b=DrOidS+LwOCPMTnaqx9NKW63UiNCfsLhxVKOFHvt9ePghPlKDpqpv2yRBSc2H0lBpn
 vjcmNELSqSAHh9H4+i8Y0JK0JoljDR85N5HRqkfaCHWLkFfu91iLC1FmlI8O+mDGyIY4
 3tRf674u+QP1WXM+tvH5H4IkRLKLMiOEUn51rRBIcnxwYD9cySE+a4XxHYjaTYdD+Yd0
 l8Ovq34AfXUH8Cm+poBKNx6EIM9BS8fw/Em/13S97qlFTHzv1hx7uV3lV9mRLBORslPr
 uZC3O6fNitzMRWXiJygGyU/rMcrfgnIUJraqwN2PR0yfVx4IgNY0ooew8e+u0ZTS+sgC
 y1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vVqgX84jQjtV56FO/L90fCXJ4uFy/82Ndepm6gSaM0k=;
 fh=ElUNJ9+jDSUEkd2CI8QFnHG1hmnrTyClxd+igxAMFRY=;
 b=p8q7vM777p1U6SgDF1Nq/eT6lpepR3uFVkyLKjtC6sUTTmsDJl46qgHro2VhiBxRux
 Nv296wgo+/oiyryaFcEItb3xJ6IWkm8cH9dpCbnxYNIeH5QQsFtqlY7h9Xmm0nOY+Rn3
 lvDL3F0V7XXJAD4N0djmrGF87iV71fHtDB4r1m9G6Orjo/ml3IWRg2YMnmBzYW95EEtV
 bapM1k2npaSmtfxFBX05Qfdu7V6JUc8W4fWaG22rdlTZGysx7E1d9uhcl0N3OY0cqPe+
 Bg27e9wrFx9kxPkqzBfe+15zhTNFVZDyP//ytHL24MgL2gpKfrzdtm97mI3GqjzRFfPS
 osNg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784651795; x=1785256595; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vVqgX84jQjtV56FO/L90fCXJ4uFy/82Ndepm6gSaM0k=;
 b=BBE29qTMembu/Ya5aglDxSJshwR6v+56QkO8qbBSR+UoSAqW8ck0mtCrYuGYCQG0DK
 ATOajazHXAoOE19+sHfOyKNZDc36th7Er6jxz/TfINULz8O7C9aRfDASIp78EZC3bmCa
 /iLWFjcoh+AZ27voqFceD6DjwPtCMq43LkOdKezs4GZteF7gaZOiDc/tk4ww1u3Rzx6W
 vZRJ9/3zly/1UR9LOoV/hw/L456YGDCdqNMh/IiPlN5TUds9qMSIaP2XoWpDcNlPSLT4
 qdm0E+fCGLaNjpVwwbM5tQKkN5aPa1lDwJ6Yxl2Hke4SSrYM8vfKYlYVE2bT+CUk/DeM
 rk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784651795; x=1785256595;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vVqgX84jQjtV56FO/L90fCXJ4uFy/82Ndepm6gSaM0k=;
 b=SLm7r3GfJXt8YdrtQFXcwdDqOfEN+/9T9Dd3RyFgZVBx4fqtvW8TanIR3JTEUio+cF
 i6EoHJAU93xFYnVy3uMuc7W01QaXgzsgC19OzbGyzR/UH9gpfodX1Ijb4hiXxxV+AGeN
 X0TInW6hoq/3dvbybwoGjLbTYNws61HMGKI3k64PmfQPxPipN/339GqHgVwNJQwvxwy2
 lrAEfMPIRw6F7hgpYeotXVgfiicPcMYwExXFAKYc/HrNfuQHT10HBaTnH/YPGKCSJ+fQ
 2as27Xd2wqIjik7LmBeNNsw/s5sDgtehn8SCsrDsJzMgvIfdx0zMBoE1nwE6jxIJemBL
 GSag==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6m4I3XX9jhwOWd6GQA5nqN5bxkXds+32JOAO7SbbOMY2iime+Gc6EhoE59MEcK/j4zRRusbYurE8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwuG97WlsyhE4DL5j0jM7YOzg025mf/SjShXAoTeR52hY7yyOo4
 2xonJMmnO29nqG0A1zqNPqncvECetfjCflalonJH09VJIGJGWfrGppr3FHUQ9KXxczOt9RdKWt3
 oTOLDpEoMjdjIIQxv1kyjlglHTaoqGA==
X-Gm-Gg: AR+sD11NMn9TTwu6W6jtJM5S+2TOOVjB55fs1WLZ7vxbr6hFN0ncpJjnhjNcGhHrkpH
 Aqw9Ra7OhvPJQUdRWLbQD69ug6/dMlKsWmvw3K9vqultdLbq18KI3AQ+nJPHbI+W+afpg1MJ88R
 A30ikbC7kc6ZTnjnj9RnAUfJ8SB9xvuHrTPX7mgscd4pAZTRy+SNvPh10Jciemepuqi4rJGNo4i
 lKZfoD0Ne14IDxLD0gPDUwQkldeWVIChsyvRBS9QPIx5uwCpyd+rtveU86HyyrAAiienGOoemTE
 UIF60Vyzw3pstklP5V4=
X-Received: by 2002:a17:903:3bcf:b0:2ca:ed41:d33d with SMTP id
 d9443c01a7336-2cf34a80342mr224602735ad.45.1784651794678; Tue, 21 Jul 2026
 09:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260719175857.4071636-1-ap420073@gmail.com>
 <20260719175857.4071636-9-ap420073@gmail.com>
 <41e73be8-242a-4e7b-b085-439375303590@pixelcluster.dev>
 <8dfbef48-db20-4642-8f50-e37f46af6627@lunn.ch>
In-Reply-To: <8dfbef48-db20-4642-8f50-e37f46af6627@lunn.ch>
From: Hoyeon Lee <hoyeon.rhee@gmail.com>
Date: Wed, 22 Jul 2026 01:36:22 +0900
X-Gm-Features: AUfX_myNLtLISc21KdgKa-JpkJ-v8hHK4oD3B4RXKoOMKPs4a14geDJhHunEcxY
Message-ID: <CAJ=ss6_iUvP3Be735V6_dD0JTF96=NZWe5_G_p0nubdRvCZ==Q@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 08/13] drm/amdkfd: add GPU instruction
 emitter and disassembler
To: Andrew Lunn <andrew@lunn.ch>
Cc: Natalie Vock <nat@pixelcluster.dev>, Taehee Yoo <ap420073@gmail.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Alexei Starovoitov <ast@kernel.org>, 
 amd-gfx@lists.freedesktop.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Andrii Nakryiko <andrii@kernel.org>, Bill Wendling <morbo@google.com>,
 bpf@vger.kernel.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, David Airlie <airlied@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, 
 dri-devel@lists.freedesktop.org, Eduard Zingerman <eddyz87@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Eric Dumazet <edumazet@google.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Justin Stitt <justinstitt@google.com>, 
 Kees Cook <kees@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Leon Romanovsky <leon@kernel.org>, 
 linaro-mm-sig@lists.linaro.org, linux-hardening@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-rdma@vger.kernel.org, llvm@lists.linux.dev, 
 Mark Bloch <mbloch@nvidia.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
 Michael Chan <michael.chan@broadcom.com>, Nathan Chancellor <nathan@kernel.org>,
 netdev@vger.kernel.org, 
 Nick Desaulniers <ndesaulniers@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Shuah Khan <shuah@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Simon Horman <horms@kernel.org>, 
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Tariq Toukan <tariqt@nvidia.com>, 
 Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 21 Jul 2026 22:11:24 +0000
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

On Tue, Jul 21, 2026 at 5:53=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Jul 20, 2026 at 10:05:33PM +0200, Natalie Vock wrote:
> > On 7/19/26 19:58, Taehee Yoo wrote:
> > > Add the AMD GCN (gfx9/gfx10) instruction encoder used to build the GP=
U
> > > shaders that knod dispatches, plus a matching disassembler used for
> > > debugging the generated code.
> >
> > Is it really necessary to have a full-on compiler and disassembler in t=
he
> > kernel driver? This patch is massive and I'm wondering how much benefit=
 it
> > really provides. Is there really no way to move GPU compilation out of =
the
> > kernel, one way or another? Could you get acceptable perf with a static
> > shader that interprets BPF programs at runtime? Such a shader can be
> > compiled beforehand and just embedded into the kernel - there's prior a=
rt
> > there with the CWSR trap handler in amdkfd.
> >
> > In case you really, really need to compile the BPF to native ISA, could=
 you
> > still have userspace take care of that in one way or another?
>
> There was a long and painful discussion about P4, and offloading it to
> hardware. The proponents of that wanted to do the compilation stage in
> user space to produce a binary blob, but it was hard to prove that the
> P4 passed to the kernel for software processing, and the binary blob
> passed to the hardware actually where the same. It opened up the path
> for closed source P4 where the kernel never got to see the actual P4
> code. So it was not really offload, but kernel bypass.
>
> So having a compiler in the kernel is probably the correct way to go,
> if you want to be friendly to open source.
>
> The other option is to get the GPU to do the compilation itself, so
> you pass BPF byte codes to the GPU and it generates its own native
> code. I've no idea if that is possible, but clang can target OpenMP,
> so maybe it is possible to move this compiler into the GPU?
>

Hi Natalie and Andrew,
Thank you both for the review and suggestions.

We tried running a BPF interpreter on the GPU using OpenCL in an early
prototype. The interpreter overhead dominated because each BPF
instruction required many native GPU instructions, so the performance
was not practical. Since this was only an early feasibility prototype,
we do not have benchmark data suitable for a meaningful comparison.

Based on that result, we chose to compile BPF directly into native GPU
instructions. Moving compilation to userspace would also raise the
problem Andrew described: the kernel could no longer easily establish
that the verified BPF program and the submitted GPU binary are
equivalent. We have not tried compiling on the GPU itself, but that may
be worth investigating separately.

The disassembler is only used for debugging the generated GPU
instructions and is not required for execution. We can leave it out of
the initial series and submit it separately if needed.

Regards,
Hoyeon Lee

>       Andrew
