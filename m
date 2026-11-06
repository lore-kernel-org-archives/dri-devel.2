Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84171606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xnk0eucW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2E0110E3AD;
	Fri,  6 Nov 2026 06:31:42 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 319DE10E124
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 06:31:36 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6b65d69f5c2so290672a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 22:31:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793946694; cv=none;
 d=google.com; s=arc-20260327;
 b=Fo85Xvn5xIRr3hJhbRzVBd9VnUhVnscc0A33M2pr7PaViPltb+5BOi5cYPfsllDoj1
 qNnOLQ8dsKhwe/8R8hej3ce+7mhxbQ4AW+w/dGMPs8wAlKuLdpxTjUeFq910Tf/DMylu
 Bs0hTY8p82rLyI2GsOEV2r1nRgVABiQ+8Xg4I1rDj4ZIwr5K05qfh1HuQazKURDE87qg
 UY7MqP46xQPUOFDGE90LC7xIPPIbIKSYycl+LF/eutXemw1tk9/XhWLQnpmTCXcrY+Ph
 jqFQitr8c7ymk7Ulor3MUM02xFaqGh0G2xSWhbNdYvCuPK4vuPODkXns16HGNNpdkgWA
 SjAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=z0ln3FBSrCBegMeSdFvd2oFkd8/N2VnD89r8UIj5kgk=;
 fh=HLFknCB6Ud7B5TVATesfGwRhqZi7GQmY7UMSXB9UxLM=;
 b=o7o9mjJxvbDanu0rs4eP0kJ08ciMCbqr10KOYr4t+DselLZqkpTChuv5j1Kp+7YjKY
 yTrCAajKblBq1VZJfhmMpFo1lDL1RJ42L4cjHJ6XIWZL+odkIcXMe6+AkSLzPzPgUuJF
 T/y++25BP2jxvvsXBTr1d3YpiYWJu/7CaSR5sf5mH9M/PliU9lYg5amPhnZd5WtSKRMY
 UebpDQcd+OL36eRDK+/A5owEw9viy5RJyHMDBWu4ghkgfhe6RQnRqL64CXQLBO3zGLrv
 sFqIy6G2KQpgJCQVD74PrbFq4wZmGIY8fRnsx0+G6KlthlU7opXyD712CuyoJySh7qUT
 Emig==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793946694; x=1794551494; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=z0ln3FBSrCBegMeSdFvd2oFkd8/N2VnD89r8UIj5kgk=;
 b=Xnk0eucWREXVkM1HgsHR9pd+lPgq8Q8A6FMabuK/AaszbPSLpbqqadFgTLhQ7VrlwV
 e21la0aFOhX9IrFMj0PB8sH10MczS7qyTHNYu3fV4rpGQAAh9dhSmwdcDIcC6Wnwbo2m
 Qg+QRDe7zgTYV7bUf3EahF4L6VhqgM9W3LD5WV8I1wRlKEG1TCExZ8/bAByRmwRp7624
 YAvcf45aN1VvXyePgf86armAsaf0VrPOjf6m4uROPqJRUE/UcaG6rs2IEHcMDi4TnmlR
 0i4t+Rjq6aR9oQzPdD8TT/uyWoHvIok7Gg8nhNhUxFf1GxlHin2Tze4Anp1FFcD6WY8Q
 LB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793946694; x=1794551494;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=z0ln3FBSrCBegMeSdFvd2oFkd8/N2VnD89r8UIj5kgk=;
 b=tdfy25bohhpGWYIzlwfLZxBrWwUQ5prBWeB4QpxkJdx49IZgjXs+VIogV2ohTvBTPP
 brf3BYe1xikY9HUGNYdapymwIMgePmSqgeSbeKNRbl/gGuE5SND567MNi0NRzYjs/cHj
 7RJiYCVF8rSH1RZgbeBXzkrr02Qo2qJ9wo4KsoOw3jhBTCjOYlsEphUr2onV3o1wBnE+
 KlOxs5nQiTi6hn2EQ7IxpoNmfZJOamWugYQCgPlIW3EB5VV0rfA5JLT2fQfKz2d4mYg/
 pXQWVEuLiVmR9HXrKmUL/8/sGFd+JEXWJkMl9sx2otR49AxM/SpQR4t4Oco7T3TcVs04
 vYDQ==
X-Gm-Message-State: APuU4Z/Hz/y8+CFZFFUKAQxL/y7Zwk2NpCZYpDNHirdHHXurmzWDIBIr
 O82SPuJKmz5gQ1qn8IR6geAtmkW9JkcWTki5d7Z9K2MjabInXp6FyBYQZo0vCrPe0cvSg/OnS9Q
 jmSKHVPL10Gc0XnQlZn61X4S99ysJL5EOC1+Ncf8=
X-Gm-Gg: AYBFou0Qnwjao0jChiTsT5THgrUL4ISk27MvYep329egTY/z61tg29Kpa9XrptE+vMS
 DWYwCI4aNn0txWEV6/bJFYeUFYgvyz+GjTxsQWrndlo75srL0RV2CnOaVBZJIG2wjeCFItHl64x
 AXIAZpyo3TZkpS/MbiCUjxe+JaGa8GXNS0SYi+Qe9E0SgsRm0djN4+3IP1++3jHwP+OkiC9fLM+
 bg+jdfG46N8qJbqmk/Zqz0+Is+3BLpF91eBxdYdvhVVdfQXrGFHEzbZakSX9GX9eqfY6RsGExmj
 rJLNbhVy0RzcudZEqcK9cjID9ROl2+VrWZC5ayuNdWsngd9WXJ+essMLbAhuuzFtP3CRG09IsCq
 euy3c2iU8IwD5s5Bi+4g99LyhY6izA6jxZVMS/i9c4hndRoifRFApGSrdFQ==
X-Received: by 2002:a05:6402:27d3:b0:6b4:5909:138d with SMTP id
 4fb4d7f45d1cf-6b5977c7402mr957015a12.20.1793946694250; Thu, 05 Nov 2026
 22:31:34 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAFGNeajNF_VMAvtDDVZPxdzskUR7Y6HPNQp+sH6eihf3PLviXw@mail.gmail.com>
In-Reply-To: <CAFGNeajNF_VMAvtDDVZPxdzskUR7Y6HPNQp+sH6eihf3PLviXw@mail.gmail.com>
From: "Operating System's Depression" <operatingsystemsdepression@gmail.com>
Date: Fri, 6 Nov 2026 03:31:21 -0300
X-Gm-Features: AclHuK-kUKDtZB0z2alYk8ar5ZlFEN85yHBOXOUIaZEfKeI6_ouwrviNbo5qw0c
Message-ID: <CAFGNeaih0pByA9harSnSd4opyCu4EFKmSR9quD3cNzXEEp+0kw@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: dri-devel@lists.freedesktop.org
Cc: patrik.r.jakobsson@gmail.com
Content-Type: multipart/alternative; boundary="00000000000074f5f2065f95c3ad"
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
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000074f5f2065f95c3ad
Content-Type: text/plain; charset="UTF-8"

Hi,

Following up on my SGX535 render architecture RFC.

Since the original RFC, the experimental implementation has demonstrated
physical Gallium/NIR scene submission, GPU command completion and
retirement, and successful COLOR/Z24 readback on PowerVR SGX535 (GMA500)
hardware

These results have been validated on an Intel Poulsbo GMA500 system running
a Linux 5.10-based kernel. I'm currently looking for a lightweight Linux
distribution with a recent kernel to begin testing against newer kernel
versions

I'm currently planning a modular architecture, with clearly separated
responsibilities for GPU memory management and MMU mappings, GEM buffer
ownership and lifetime management, GPU command submission and execution,
completion fences and synchronization, and timeout handling, error
recovery, and device removal.

My current preference is to integrate SGX535 rendering within the existing
drm/gma500 driver, rather than introduce a completely separate DRM driver.

The intention is to preserve the existing display infrastructure while
adding rendering capabilities through modular components that can be
reviewed and maintained independently.

However, this is still a proposed direction, and I'm open to a separate DRM
render driver if the maintainers consider that a better architectural fit.

Before proceeding with the initial patch series, I'd appreciate feedback on
three architectural questions:

1- Should SGX535 rendering remain within drm/gma500, sharing display-device
ownership, or would a separate DRM render driver be preferable?

2- What would be the preferred ownership model for GPU MMU mappings, GEM
buffer lifetimes, and completion fences, particularly when coordinating
rendering with the existing display infrastructure?

3- What is the minimum acceptable recovery contract for GPU submission
failures, timeouts, suspend/resume, and device removal?

The overall implementation remains experimental. However, parts of the
kernel-side infrastructure may already be suitable for an initial RFC
patch, subject to architectural review

I'm considering submitting a small initial RFC patch within the next few
days, focusing on foundational infrastructure and architectural integration
rather than submitting the entire experimental implementation at once

My goal is to keep the initial changes small, reviewable, and compatible
with the existing gma500 driver, while establishing a foundation for
subsequent SGX535 rendering support

I'd appreciate any early feedback on the proposed architecture,
particularly regarding driver ownership and the preferred upstream
integration path :D

Thanks!

Em dom., 1 de nov. de 2026 17:13, Operating System's Depression <
operatingsystemsdepression@gmail.com> escreveu:

> Resending after subscribing to dri-devel, as I could not confirm whether
> my original message reached the list. Apologies if this is a duplicate.
>
> Hello Patrik and DRM developers,
>
> I'm developing SGX535-reMESA, an independent Mesa/Gallium rendering path
> for Intel Poulsbo/GMA 500. Before designing a production submission UAPI,
> I'd appreciate advice on the ownership and lifetime model alongside
> existing gma500 display support. My intention is to preserve the existing
> display functionality while exploring render support under appropriate
> shared-device ownership.
>
> This is an architecture discussion, with no patch series or request to
> merge the experimental interfaces.
>
> The test machine is a Dell Inspiron Mini 12, Atom Z520, PCI 8086:8108,
> SGX535 core 0x01130000/revision 0x00010201. Kernel work currently targets
> antiX 5.10.240-antix.1-486-smp on 32-bit x86; it has not been ported or
> qualified against current mainline.
>
> There is physical evidence for a restricted 1280x800
> 600-frame/600-submission glxgears run, isolated native 2D copy/fill, and
> bounded fixed-profile private-MMU jobs. These results do not qualify the
> general renderer.
>
> Recent experimental runs have also exercised the general-scene submission
> path on physical hardware. Completion was observed, but COLOR/Z readbacks
> did not establish correct rendered output. General-scene execution remains
> unqualified.
>
> Gallium frontend integration and shared COLOR/Z fence handling have passed
> selected offline tests. Physical qualification of the integrated path is
> still pending. Whole-desktop acceleration, GLES 2.0, desktop OpenGL 2.1 and
> an installable driver remain goals.
>
> The experimental design is deliberately serialized:
>
> * GEM-backed objects are held by jobs with generation-checked private IDs.
> A private GPU page directory maps retained backing with narrowed access;
> CPU-only storage is excluded. Mapping/control pages and backing lifetimes
> remain held until a verified release, or are quarantined on uncertainty.
>
> * Native 2D, rendering and IRQ attribution share device exclusion. The
> existing fixed-profile executor holds an endpoint mutex and the MMU writer
> semaphore across root binding, issue, completion, CPU visibility,
> default-root restoration and source closure. It does not yet implement a
> production asynchronous queue or a complete dma_fence/dma_resv/syncobj
> contract.
>
> * Failure does not fabricate completion or root restoration. Unplug guards
> revoke admission, while uncertain GPU state prevents unsafe reclamation or
> rebinding. This is not proof that SGX DMA has stopped. PCI save/restore and
> power-management admission checks do not establish reset, suspend or
> runtime-PM safety.
>
> My questions, in priority order:
>
> 1. Device ownership and gma500 integration
>
> Would extending the existing gma500 DRM device be the preferred starting
> point for SGX535 render support, given the shared PCI function, GEM/GTT/MMU
> resources, IRQ handling and power state?
>
> I intend to preserve existing display support rather than introduce a
> competing PCI driver. What separation between display and render components
> would you recommend before proposing a render node or submission UAPI?
>
> 2. GEM, MMU and synchronization
>
> For an initially single-job design, should job-held GEM references,
> explicit per-job GPU mappings and one global exclusion domain be the
> baseline, with dma_resv fences for object hazards and CPU access?
>
> Which current DRM helpers or small driver would you recommend as a model?
>
> I want root switching and cache publication to have explicit ownership
> without treating the current private IDs or synchronous ioctl as ABI.
>
> 3. Failure handling, removal and suspend
>
> Without a demonstrated SGX reset/stop sequence, is a terminal wedged state
> with retained backing a reasonable development policy?
>
> What stop/isolation proof must removal provide before translations can be
> reclaimed, and how should active hardware detach be separated from later
> GEM destruction?
>
> In particular, old file/VMA/fault callbacks must not touch MMIO/GTT or PM
> state after unplug or a later rebind.
>
> Should suspend be refused while work/root state is uncertain until that
> same stop-and-restore contract is demonstrated?
>
> 4. Upstream development sequence
>
> Which current DRM tree should host the first reviewable work: small gma500
> lifetime/admission fixes first, then submission/synchronization together
> with real open Mesa userspace?
>
> I intend to forward-port and use current GEM/PM APIs rather than propose a
> cross-version abstraction around this 5.10 experiment.
>
> Are there specific gma500 constraints that should change that order,
> especially before enabling runtime PM?
>
> Project and public evidence index:
> https://github.com/reMESA-devgroup/SGX535-reMESA
>
> The current development snapshot includes local, unpublished changes; the
> public repository alone does not reproduce the latest experimental kernel
> or physical runs.
>
> The relevant source areas are kernel/remesa/gma500/
> (remesa_gem_private_execute.inc, remesa_mmu_private.inc,
> remesa_mmu_switch.inc and the private lifetime/power guards), integrated
> for the experiment by tools/remesa/stage_twod_reservation.py.
>
> Source staging is a build aid, not the proposed upstream patch format.
>
> I understand that a future DRM UAPI needs corresponding real open-source
> userspace, including error handling, reviewed for a suitable upstream
> project.
>
> I can follow up with a small current-kernel diff and a focused
> lifetime/state-transition description once the integration direction is
> clear.
>
> Feedback on the ownership boundary or the most useful first diff would be
> particularly helpful.
>
> Thanks,
> Gabriel Gama
> operatingsystemsdepression@gmail.com
>

--00000000000074f5f2065f95c3ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><p>Hi,</p><p>Following up on my SGX535 render architectur=
e RFC.</p><p>Since the original RFC, the experimental implementation has de=
monstrated physical Gallium/NIR scene submission, GPU command completion an=
d retirement, and successful COLOR/Z24 readback on PowerVR SGX535 (GMA500) =
hardware</p><p>These results have been validated on an Intel Poulsbo GMA500=
 system running a Linux 5.10-based kernel. I&#39;m currently looking for a =
lightweight Linux distribution with a recent kernel to begin testing agains=
t newer kernel versions</p><p>I&#39;m currently planning a modular architec=
ture, with clearly separated responsibilities for GPU memory management and=
 MMU mappings, GEM buffer ownership and lifetime management, GPU command su=
bmission and execution, completion fences and synchronization, and timeout =
handling, error recovery, and device removal.</p><p>My current preference i=
s to integrate SGX535 rendering within the existing drm/gma500 driver, rath=
er than introduce a completely separate DRM driver.</p><p>The intention is =
to preserve the existing display infrastructure while adding rendering capa=
bilities through modular components that can be reviewed and maintained ind=
ependently.</p><p>However, this is still a proposed direction, and I&#39;m =
open to a separate DRM render driver if the maintainers consider that a bet=
ter architectural fit.</p><p>Before proceeding with the initial patch serie=
s, I&#39;d appreciate feedback on three architectural questions:</p><p>1- S=
hould SGX535 rendering remain within drm/gma500, sharing display-device own=
ership, or would a separate DRM render driver be preferable?</p><p>2- What =
would be the preferred ownership model for GPU MMU mappings, GEM buffer lif=
etimes, and completion fences, particularly when coordinating rendering wit=
h the existing display infrastructure?</p><p>3- What is the minimum accepta=
ble recovery contract for GPU submission failures, timeouts, suspend/resume=
, and device removal?</p><p>The overall implementation remains experimental=
. However, parts of the kernel-side infrastructure may already be suitable =
for an initial RFC patch, subject to architectural review</p><p>I&#39;m con=
sidering submitting a small initial RFC patch within the next few days, foc=
using on foundational infrastructure and architectural integration rather t=
han submitting the entire experimental implementation at once</p><p>My goal=
 is to keep the initial changes small, reviewable, and compatible with the =
existing gma500 driver, while establishing a foundation for subsequent SGX5=
35 rendering support</p><p>I&#39;d appreciate any early feedback on the pro=
posed architecture, particularly regarding driver ownership and the preferr=
ed upstream integration path :D</p><p>















</p><p>Thanks!</p></div><br><div class=3D"gmail_quote gmail_quote_container=
"><div dir=3D"ltr" class=3D"gmail_attr">Em dom., 1 de nov. de 2026 17:13, O=
perating System&#39;s Depression &lt;<a href=3D"mailto:operatingsystemsdepr=
ession@gmail.com">operatingsystemsdepression@gmail.com</a>&gt; escreveu:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><div dir=3D"auto">Resending after sub=
scribing to dri-devel, as I could not confirm whether my original message r=
eached the list. Apologies if this is a duplicate.<br><br>Hello Patrik and =
DRM developers,<br><br>I&#39;m developing SGX535-reMESA, an independent Mes=
a/Gallium rendering path for Intel Poulsbo/GMA 500. Before designing a prod=
uction submission UAPI, I&#39;d appreciate advice on the ownership and life=
time model alongside existing gma500 display support. My intention is to pr=
eserve the existing display functionality while exploring render support un=
der appropriate shared-device ownership.<br><br>This is an architecture dis=
cussion, with no patch series or request to merge the experimental interfac=
es.<br><br>The test machine is a Dell Inspiron Mini 12, Atom Z520, PCI 8086=
:8108, SGX535 core 0x01130000/revision 0x00010201. Kernel work currently ta=
rgets antiX 5.10.240-antix.1-486-smp on 32-bit x86; it has not been ported =
or qualified against current mainline.<br><br>There is physical evidence fo=
r a restricted 1280x800 600-frame/600-submission glxgears run, isolated nat=
ive 2D copy/fill, and bounded fixed-profile private-MMU jobs. These results=
 do not qualify the general renderer.<br><br>Recent experimental runs have =
also exercised the general-scene submission path on physical hardware. Comp=
letion was observed, but COLOR/Z readbacks did not establish correct render=
ed output. General-scene execution remains unqualified.<br><br>Gallium fron=
tend integration and shared COLOR/Z fence handling have passed selected off=
line tests. Physical qualification of the integrated path is still pending.=
 Whole-desktop acceleration, GLES 2.0, desktop OpenGL 2.1 and an installabl=
e driver remain goals.<br><br>The experimental design is deliberately seria=
lized:<br><br>* GEM-backed objects are held by jobs with generation-checked=
 private IDs. A private GPU page directory maps retained backing with narro=
wed access; CPU-only storage is excluded. Mapping/control pages and backing=
 lifetimes remain held until a verified release, or are quarantined on unce=
rtainty.<br><br>* Native 2D, rendering and IRQ attribution share device exc=
lusion. The existing fixed-profile executor holds an endpoint mutex and the=
 MMU writer semaphore across root binding, issue, completion, CPU visibilit=
y, default-root restoration and source closure. It does not yet implement a=
 production asynchronous queue or a complete dma_fence/dma_resv/syncobj con=
tract.<br><br>* Failure does not fabricate completion or root restoration. =
Unplug guards revoke admission, while uncertain GPU state prevents unsafe r=
eclamation or rebinding. This is not proof that SGX DMA has stopped. PCI sa=
ve/restore and power-management admission checks do not establish reset, su=
spend or runtime-PM safety.<br><br>My questions, in priority order:<br><br>=
1. Device ownership and gma500 integration<br><br>Would extending the exist=
ing gma500 DRM device be the preferred starting point for SGX535 render sup=
port, given the shared PCI function, GEM/GTT/MMU resources, IRQ handling an=
d power state?<br><br>I intend to preserve existing display support rather =
than introduce a competing PCI driver. What separation between display and =
render components would you recommend before proposing a render node or sub=
mission UAPI?<br><br>2. GEM, MMU and synchronization<br><br>For an initiall=
y single-job design, should job-held GEM references, explicit per-job GPU m=
appings and one global exclusion domain be the baseline, with dma_resv fenc=
es for object hazards and CPU access?<br><br>Which current DRM helpers or s=
mall driver would you recommend as a model?<br><br>I want root switching an=
d cache publication to have explicit ownership without treating the current=
 private IDs or synchronous ioctl as ABI.<br><br>3. Failure handling, remov=
al and suspend<br><br>Without a demonstrated SGX reset/stop sequence, is a =
terminal wedged state with retained backing a reasonable development policy=
?<br><br>What stop/isolation proof must removal provide before translations=
 can be reclaimed, and how should active hardware detach be separated from =
later GEM destruction?<br><br>In particular, old file/VMA/fault callbacks m=
ust not touch MMIO/GTT or PM state after unplug or a later rebind.<br><br>S=
hould suspend be refused while work/root state is uncertain until that same=
 stop-and-restore contract is demonstrated?<br><br>4. Upstream development =
sequence<br><br>Which current DRM tree should host the first reviewable wor=
k: small gma500 lifetime/admission fixes first, then submission/synchroniza=
tion together with real open Mesa userspace?<br><br>I intend to forward-por=
t and use current GEM/PM APIs rather than propose a cross-version abstracti=
on around this 5.10 experiment.<br><br>Are there specific gma500 constraint=
s that should change that order, especially before enabling runtime PM?<br>=
<br>Project and public evidence index:<br><a href=3D"https://github.com/reM=
ESA-devgroup/SGX535-reMESA" target=3D"_blank" rel=3D"noreferrer">https://gi=
thub.com/reMESA-devgroup/SGX535-reMESA</a><br><br>The current development s=
napshot includes local, unpublished changes; the public repository alone do=
es not reproduce the latest experimental kernel or physical runs.<br><br>Th=
e relevant source areas are kernel/remesa/gma500/ (remesa_gem_private_execu=
te.inc, remesa_mmu_private.inc, remesa_mmu_switch.inc and the private lifet=
ime/power guards), integrated for the experiment by tools/remesa/stage_twod=
_reservation.py.<br><br>Source staging is a build aid, not the proposed ups=
tream patch format.<br><br>I understand that a future DRM UAPI needs corres=
ponding real open-source userspace, including error handling, reviewed for =
a suitable upstream project.<br><br>I can follow up with a small current-ke=
rnel diff and a focused lifetime/state-transition description once the inte=
gration direction is clear.<br><br>Feedback on the ownership boundary or th=
e most useful first diff would be particularly helpful.<br><br>Thanks,<br>G=
abriel Gama<br><a href=3D"mailto:operatingsystemsdepression@gmail.com" targ=
et=3D"_blank" rel=3D"noreferrer">operatingsystemsdepression@gmail.com</a>=
=C2=A0</div>
</blockquote></div>

--00000000000074f5f2065f95c3ad--
