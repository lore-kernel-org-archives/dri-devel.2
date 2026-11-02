Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7314D607BDF2
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=itka6e4w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D846A10F06E;
	Mon,  2 Nov 2026 16:05:29 +0000 (UTC)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E89910F076
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 16:05:23 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-14388db1a6bso73447c88.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 08:05:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793635522; cv=none;
 d=google.com; s=arc-20260327;
 b=JLqLcY+5PI25yqnD4iEEpciiXM22L7jGyeg8dm/hlubal+mMYz495canIiR74O2/gJ
 1P3dLI/XWeHCXjIQ5/Zvetaz+adfDzXytaYqaZOLkJ7EYWjeBLsyMaXgeVdo8m7OqNvI
 l3mKb2EVUrei689WCp4cNjZ+xV8hUyHZXCu/E6H72K/q6rhRO1D2dqGU+dup42FRa3Fm
 CGo8Oamv1WuSDlSq+nmKKoK8A1fw5syDV0IrRVehTGzEa9NwSccpgdzkXttrPwTpK0Ol
 6dzDjfPCEUjEDY1wiWNx9WqYWzHMCK0+KFFPIUYCQnaf86zeic+iutwWaWTIOuQCznCH
 33EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qM2dyLxIJxVzLOT8NAS4jU2rvWxXsjk/TSdQCq7DDTQ=;
 fh=hTLr+uK6i4XuKV0Pu6KkYwvDoPGfGu220oyLVhyzH2E=;
 b=XnP8OXOac/rbH1qN1OuUmDOq6nd1DTsribC3gtLcjNPgBfQ6kd3x1zIzXPBXV9RyVg
 sn5oNZ7zYCvGjjBdL2zp/3f8hdWEeHiT36LSk30CiJHo3U3+iNuZQrcWEJtETKQLtknL
 +ekgxndk9fh955m4l7eBXW26ISno/ownvkatiGHhF8bhbZRALyKo0aAYsnY9YSMlfQgQ
 VV99J4fYOvEkrWo//rX9A/KSt1Jq5SG4zKS3OD79oEgyOdScR1LYlVhSMv4xbUyC2iZL
 HvqR3oCHHmaLTScDk0m27J3ZP3XFvgk6NrL3quI/nd1yG3u2URkprxqqQ9piapg1ok3N
 eByA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793635522; x=1794240322; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qM2dyLxIJxVzLOT8NAS4jU2rvWxXsjk/TSdQCq7DDTQ=;
 b=itka6e4w/AXkiyU+zIUWxi+JkxVSE554Fat/hPiC+8urWBL+gYbwEAaMZKX9bTX1y7
 sB7XAnn3WjDzMBu6klam9lupx/NfIg/lu8p69LFO85HFJU7iTsPzSg9splm1weuqQqr8
 sYHdHkpGiZaOnJ/NuogjC8Xjixk+6O9kTxHqIHBXjNbkZG+dA0KJ1o1U6hbgd1r7HjAU
 aALUetuQIeDOFAjoXVMgtvfjquXxzr3Tz9ssIH2QbcNeBNz4Vu0JPwzNIxfU51Ognbgq
 JD3PY99ESKoM4uqmSHgcFkYU2omM8wUshps6q8c/d2LdGE9u/iyHRJ/fQGASZY7fYjPs
 +D5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793635522; x=1794240322;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qM2dyLxIJxVzLOT8NAS4jU2rvWxXsjk/TSdQCq7DDTQ=;
 b=H1cRnVMdNuv6TDXYTInWPHb2s1X95/0moGosU9WHHp8jr2FopkMMRuP65eJPlYaYWE
 7hE41yX15NLBuGWq/E/i9cN2ABf7uUysW/tUH5doa+VDTnAZh8vLMJ+QzsvbJ4MXLFtN
 rAy8fqPjQM1eqWx4nbWN+SesNoacIBqC9ENHnzNhcdHEav4LltQNBUM3hfsdXginp6qe
 6x4tbsmvi0naeEY4CoabivvBYnfWVkd+k72ELb2Onem+d5byEY4QhHdL4SIZbE4Vgkgd
 pKRtJZUbHqv2vlGtYgUM+5ts/qSl2CJK5o/iNninw7hviZjljhfQ8nadggWveUrlbsvK
 Dn2A==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+ommbUYWlY2boBjXbMV4AMKaA1NvlPAnwL5T/cwjavXVL+8pDWL6B2EAxtcS8NfJAnVaNV9OESHo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJMDisgIErsyuAj9E/CWg7DCEDFvnbMiWKALn9npjYnseNLdA+C
 ZyBEbsRETdw6IJClp3g0E/nQfYL1f7nPo1tTvFf5caBIupz22+QSxAZfzZplIfg2/meys727Oc6
 EIrwvBbB/LFVbGAcYc7gWXytrqwY/pIE=
X-Gm-Gg: AYBFou3Xdiae4aqdRoP/AW94UJklcHrjH6cxYo0KzJVO8Xwvz63KxeAbxT2D0Z/BEPJ
 xwTMpcHJkA+uXxtKFQqAiO7X+FvDvVWNMaG+H0Ysv0wj6wgWRbX55N5jYbILikVxiS3KaB+SYRe
 f9XfNiKkt94a12F6ijnJ4wCmceOF80g8V9f8H5ICSY0/5uF1am+rrfuD7j7jvzwtCdme7UmMEOd
 VUzLpZIYgOIFPTVYwO4aOckDlgujcWB6j6fRXsbUmSWn7Gu58dYzwNQAh0uX4gUS7gYaYtN7lSM
 +M+nS0ugZ+p3ZzVZNHeo01FbFj9+fimOnJGzEfDRBoxphVUuY5BGZJQ+wPgp0C75ICexLFoewgX
 6GqYlbW4B2XiYxf0nIQD64o/UDDccvLKvWlfbkOW8jSmV5edj4Fck/Xbr1g0mL4Fb0ouqWXM1aP
 OCT6IaDRMHtvBQEJKmWWzqRPY=
X-Received: by 2002:a05:7022:7e0c:b0:165:be2f:c56e with SMTP id
 a92af1059eb24-1ac5b7dcb2bmr26252824c88.2.1793635520495; Mon, 02 Nov 2026
 08:05:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <25995707c39c0c191e3ac46c4813f55a7f928403.1793131583.git.calvin@wbinvd.org>
In-Reply-To: <25995707c39c0c191e3ac46c4813f55a7f928403.1793131583.git.calvin@wbinvd.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Nov 2026 11:05:08 -0500
X-Gm-Features: AclHuK_T_9wl2_ge7HTrGL9Ufakev4qpuajb3TNVntCGEszFix2ZV1_vjQMYFjg
Message-ID: <CADnq5_NuQEvx8OpyPOuXgtzQB67jgaNtwW85X70UraOLaF=M=A@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: Allocate DCN32/1 dmub memory to
 GTT"
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Hung <alex.hung@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>, 
 George Zhang <george.zhang@amd.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed and applied.  Thanks!

Alex

On Tue, Oct 27, 2026 at 4:36=E2=80=AFPM Calvin Owens <calvin@wbinvd.org> wr=
ote:
>
> After commit a637a140ab860310 ("drm/amd/display: Allocate DCN32/1 dmub
> memory to GTT"), a machine with a Radeon RX 7900 shows random garbage on
> the screen. It reproduces sporadically, but at times it is so bad the
> machine is more or less unusable.
>
> The garbage is always horizontal bars extending across the entire
> screen, always approximately 200 pixels tall on a 3840x2160 screen,
> for what looks like a single frame. The bars are mostly black, but will
> sometimes exhibit striping and periodic artifacts which smell like
> non-framebuffer data is being rendered to the screen.
>
> It took some patience on the "good" side, but I was able to nail it down
> to commit a637a140ab860310818a14fb4d37e39e51a06be4 with this bisect:
>
>   bad: [cee9395acd8043be0644b25c34bfa86623f2b935] Linux 7.3-rc1
>   good: [8d3ae59288f1e7d58d76558a6ee96d533bc5019f] Linux 7.2
>   good: [55ab7e14222e5f0b0fd9f7711ca391d2924b35e3] Merge tag 'for-7.3/blo=
ck-20260819' of git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux
>   bad: [df51bdc5e80dae43cab81f6cc641e98638303c88] Merge tag 'mtd/for-7.3'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
>   bad: [29daacacf4cd84e6917f09de6a99fb170071c14c] Merge tag 'drm-rust-nex=
t-2026-08-08' of https://gitlab.freedesktop.org/drm/rust/kernel into drm-ne=
xt
>   good: [fff648aec5e2790d117a0ec5c849a284d9d33d70] drm/amdgpu: include am=
dgpu_video_codecs.h only where needed
>   bad: [336e0cd576817ac64a4b394ca2b3680029f3e37f] Revert "drm/amdgpu: fix=
 aperture mapping leak"
>   bad: [789f7486a384ca58b9d7a76abba5efa0e80e8dab] drm/amd/display: Test p=
lane colorop helper walkers
>   good: [e0e426f10ad653c5e9dd33fb4a76d55f06101992] drm/amd/display: Test =
helper_check_state rejects
>   bad: [982b2a43682b55e7d9800000f2592832ff2865ba] drm/amdgpu: Fix IP bloc=
k NULL check during soft reset
>   bad: [9102b39fa924dcc3dc75a3137bfa9633c40b88c0] drm/amdgpu/userq: fix i=
ndefinite fence wait during GPU reset
>   bad: [b23470a026afe64de5c1df4ad181587b49c22923] drm/amd/display: Exit L=
S for ISHARP before coefficient write
>   bad: [f02b2e47355e9d381a7f34acc997e1c47879ca21] drm/amd/display: Add KU=
nit test for wb jobs
>   bad: [c6a13d145cc811b19c8a0620f25868cf7d5700c0] drm/amd/display: remove=
 unused dcn42 socbb values
>   good: [1d8327353de6f1f34063840f362c208c84064f54] drm/amd/display: Fix V=
ABC Init and OLED Support
>   bad: [a637a140ab860310818a14fb4d37e39e51a06be4] drm/amd/display: Alloca=
te DCN32/1 dmub memory to GTT
>   first 'bad' commit: [a637a140ab860310818a14fb4d37e39e51a06be4] drm/amd/=
display: Allocate DCN32/1 dmub memory to GTT
>
> Sure enough, reverting a637a140ab860310818a14fb4d37e39e51a06be4 on top
> of v7.3 completely and totally eliminates the problem for me.
>
> Mikhail has separately reported this regression:
>
>   https://lore.kernel.org/all/20260829010525.29935-1-mikhail.v.gavrilov@g=
mail.com/
>
> ...but it seems to be much more consistent for me than for Mikhail, it's
> never taken more than 30 minutes even when the machine is completely
> idle. I've also never been able to reproduce any artifact one single
> time without commit a637a140, despite a lot of effort.
>
> I'm not sure reverting this is the right way forward, since presumably
> this would re-regress the timing issue Fangzhi alluded to in the
> original commit. But nobody has proposed anything concrete yet... so
> let's start the discussion here.
>
> I'm happy to help test other better ideas as well :)
>
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c    | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
> index 9ff25bc8ee5ae..870534b7cf46d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
> @@ -511,7 +511,6 @@ int dm_dmub_sw_init(struct amdgpu_device *adev)
>                 DMUB_WINDOW_MEMORY_TYPE_FB,             /* DMUB_WINDOW_CU=
RSOR_OFFLOAD */
>         };
>         int r;
> -       int mem_domain =3D AMDGPU_GEM_DOMAIN_GTT;
>
>         switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
>         case IP_VERSION(2, 1, 0):
> @@ -648,19 +647,13 @@ int dm_dmub_sw_init(struct amdgpu_device *adev)
>                 return -EINVAL;
>         }
>
> -       /* Limit to allocate dmub to GTT on DCN32/1
> -        * TODO: Other asics with GDDR7 may have worse latency
> -        */
> -       if (dmub_asic !=3D DMUB_ASIC_DCN32 &&
> -           dmub_asic !=3D DMUB_ASIC_DCN321)
> -               mem_domain |=3D AMDGPU_GEM_DOMAIN_VRAM;
> -
>         /*
>          * Allocate a framebuffer based on the total size of all the regi=
ons.
>          * TODO: Move this into GART.
>          */
>         r =3D amdgpu_bo_create_kernel(adev, region_info.fb_size, PAGE_SIZ=
E,
> -                                   mem_domain,
> +                                   AMDGPU_GEM_DOMAIN_VRAM |
> +                                   AMDGPU_GEM_DOMAIN_GTT,
>                                     &adev->dm.dmub_bo,
>                                     &adev->dm.dmub_bo_gpu_addr,
>                                     &adev->dm.dmub_bo_cpu_addr);
> --
> 2.47.3
>
