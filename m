Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B78606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pV6cD+Pf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7038310E9FB;
	Sun,  1 Nov 2026 12:00:44 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D40C10E07D
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 04:24:41 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6ae305e3bd9so3375185a12.0
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 21:24:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793507079; cv=none;
 d=google.com; s=arc-20260327;
 b=aS8M2FCvINZ6ilgbYkAlO6JxAY2be/RcKJ38LecEAX+xz2OErdIXslftduIZU+YfJm
 gtzvZAv4bYpIN47tfTZ0f5EoMM/lA/uDJXFrvASyKOlFZpdObQvUoNAqBMo0T4Wblbyz
 SPxf/UhkSUNgkpJsGDg3CRRM7CKiU3DWHMTGt/MdOQFClppZUqcKx9W7vgUJ1cgn/16x
 Mp6BPOUHR1CHdkY+m3D7ujldKvOyVWf2hUJzSNCsimtAC69S8gwOzKEbHhAzFaF57qlZ
 DGlKgB3PU0Af1ATV+Nk+8VBV10EcmEvD9sL76pdrXtqCw/3DTLXzcHMXCmiragZaLVc2
 2eiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=yhFzevq5GfU8qzHs3jt7FVj+2+O1xzGTWokk0py+L6o=;
 fh=HLFknCB6Ud7B5TVATesfGwRhqZi7GQmY7UMSXB9UxLM=;
 b=fSGQ1Nca5VeTbPuQB28u8jkX3RCdmyWNslmQdMY3q/71oB/c72oJvY4JF5PU0Mmz+C
 dtakpxANOXWFeyb1HZZHmey7QVJpCEKBS24aiG+BnFZUj4IhVJhwXHzqUWVMOeX3zUlW
 O66wvDa0km9XwT6fdebn2pLoC9NJSeBlYAOZTfnxovDa59B/gS4XFuQVXfKHoCtW/DI3
 tC8+0wAl9tpzOtTzLeQllmyoZo9FgVQXlJ1VlWaR2Y8E40HU8JbeytAVQsKI0a+HLjuY
 PYHLRnDdWG1xnbw0lyH96vtm8O1FOb2w6Ph/YITrymLWZJUIna1UIctIvwk4Q620uoyx
 6tZQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793507079; x=1794111879; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yhFzevq5GfU8qzHs3jt7FVj+2+O1xzGTWokk0py+L6o=;
 b=pV6cD+PfWPiVlz+qmBHRh7BlV4NZpAkIvvxiYnFPX+y3bGzE6uil6aR9Dt3sk0SBhO
 Vjnr452Y9yXzfNuk3ZAaSG/8kPAQ9ugt35J6AxRwNLBP7ADGCP7YM2y2v6QZgrJD0QPo
 gjgd7pnbDH/442BgUOthqEU1FVCsWPJKGuKEJwNtJ5rpcOSdoRz6Z3ZaYEss7x6oh60i
 fVSEgrtqItMaFAb8V1vxF8o8pLBpvLZr0OntyytjCqRF37hh9GLjS+gUlbHnXcjKscrb
 /4rUrD5K8vAiCpWW1450ttJpPw8hREUAur4/WrMD7eMT+y0G4FkbeTDaysf28EpVYLBE
 av/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793507079; x=1794111879;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yhFzevq5GfU8qzHs3jt7FVj+2+O1xzGTWokk0py+L6o=;
 b=uu/dioe8vz0k5u8gc13RUorhxRlumIq2oy2ZKy0E84cwI3462fRQ2Ufz/2CnPJekXd
 Vqjx74NKVBN1dP6YfyeNplLojtH7PknECevAm3ALK9Erj9S8DJgaBjvONxlaCqJxyZSq
 Dsd53k4ynaJ5iIP52kEWHWMph+cCheXrrqnSBJfBagS9UuupRRVfOymiRGPA+G0zm+84
 lfXdxUQ426exEv7O0z395CN4hC4xR7e+SqIlPWHeMPiAMtikV42aSmwUfsoMZiBVuGz9
 OruJsGJhvxp0F1MFJc7INigLhjEomIsI4gxG606E+T1MMOXVxrtiWTJMXFPM1EVG8eEq
 KSmw==
X-Gm-Message-State: AFq9FYK0Uun0sCnWY3PwBjRE8acEZ6zlB4DKwe5uLNwtqc5CZq6U4nUO
 AV6OLQ5NgCPuPflTdeQb7C5j8a5ja+7Osm8R6X3Dk1it3Bt2iWuvjnJWAZ3oVNMCW9A9CVEn6CK
 cXWvOlxdzBHEE9BMAXDwGccJjNOAckhwHrsIW
X-Gm-Gg: AYBFou343AA0U18JWWMyNnhloMc2rSjCMP/BuFxeVnTZSoB52/cr1wH7oIT9mjSzjLt
 +QNCQtB29BbZ+wZoNI1fs1SuYX0p/EYZOOa1xCMyqgqI+BIV7sDaxzJJfIihXH2mW3qngb29kG+
 3DKjIiyFoAJOy42TFZ17RyQiQJ2L1vg306KxCIDWitiKZiRhlHmzYjO0mckpcjgjbsBvfNxyRDX
 ezMX4xl/HU5m5HT9hoOVmsGQeJLvaly8YRtkfLU08ZNLU1m/zJ8n7cV7XwsSt5Lo7HWPJvdSeDo
 Qe9nu0jWQuDAVnQqNYWUvNJe6SJeByY3KVxn1bHtoknSeJeQqnjzB7RM9Sl9iKRuhMk2lhi2zdg
 w26JTsKmWWuJQzD/4LqvBIFLPLCZJ2eD7nKW26MRMetVNsxCk9G2QS0ZIKrSY99GESIuQbg==
X-Received: by 2002:aa7:c257:0:b0:6b3:e399:406b with SMTP id
 4fb4d7f45d1cf-6b4d4678029mr3363534a12.17.1793507079190; Sat, 31 Oct 2026
 21:24:39 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: "Operating System's Depression" <operatingsystemsdepression@gmail.com>
Date: Sun, 1 Nov 2026 01:24:26 -0300
X-Gm-Features: AclHuK83Ke2CJjJC0uEqSJHdLFVfjZPN5JXpqUVu50MmDQJ1IgjQA1_Q02W7vSo
Message-ID: <CAFGNeajP0gHhz4jNzppXD6YmkKzQRj-XQR5De+gSN9ApCpcFdg@mail.gmail.com>
Subject: [RFC] drm/gma500: SGX535 render ownership, MMU and failure handling
To: dri-devel@lists.freedesktop.org
Cc: patrik.r.jakobsson@gmail.com
Content-Type: multipart/alternative; boundary="0000000000005b7dfe065f2f68bf"
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000005b7dfe065f2f68bf
Content-Type: text/plain; charset="UTF-8"

Hello Patrik and DRM developers,

I'm developing SGX535-reMESA, an independent Mesa/Gallium rendering path
for Intel Poulsbo/GMA 500. Before designing a production submission UAPI,
I'd appreciate advice on the ownership and lifetime model alongside
existing gma500 display support. My intention is to preserve the existing
display functionality while exploring render support under appropriate
shared-device ownership.

This is an architecture discussion, with no patch series or request to
merge the experimental interfaces.

The test machine is a Dell Inspiron Mini 12, Atom Z520, PCI 8086:8108,
SGX535 core 0x01130000/revision 0x00010201. Kernel work currently builds
against antiX 5.10.240-antix.1-486-smp on 32-bit x86; it has not been
ported or qualified against current mainline.

There is historical physical evidence for a restricted 1280x800
600-frame/600-submission glxgears run, isolated native 2D copy/fill, and
bounded fixed-profile private-MMU jobs. Those results do not qualify the
current general scene path.

That path currently retains a 17-allocation graph and validates selected TA
syntax, direct references and USE program windows offline. Complete
PDS/indirect-fetch validation and ordered native execution remain
unfinished; it is not admitted for GPU execution.

The latest candidate module is built but uninstalled and unqualified. The
last observed stock X11 desktop still used llvmpipe. Whole-desktop
acceleration, GLES 2.0, desktop GL 2.1 and an installable driver remain
goals.

The experimental design is deliberately serialized:

* GEM-backed objects are held by jobs with generation-checked private IDs.
A private GPU page directory maps retained backing with narrowed access;
CPU-only storage is excluded. Mapping/control pages and backing lifetimes
remain held until a verified release, or are quarantined on uncertainty.

* Native 2D, rendering and IRQ attribution share device exclusion. The
existing fixed-profile executor holds an endpoint mutex and the MMU writer
semaphore across root binding, issue, completion, CPU visibility,
default-root restoration and source closure. It does not implement an
asynchronous queue, dma_fence/dma_resv or syncobj contract.

* Failure does not fabricate completion or root restoration. Unplug guards
join protected CPU entry points and revoke admission; retained state
prevents reclamation/rebind where necessary. This is not proof that SGX DMA
has stopped. PCI save/restore and PM admission checks likewise do not
establish reset, S3 or runtime-PM safety.

My questions, in priority order:

1. Device ownership and gma500 integration

Would extending the existing gma500 DRM device be the preferred starting
point for SGX535 render support, given the shared PCI function, GEM/GTT/MMU
resources, IRQ handling and power state?

I intend to preserve existing display support rather than introduce a
competing PCI driver. What separation between display and render components
would you recommend before proposing a render node or submission UAPI?

2. GEM, MMU and synchronization

For an initially single-job design, should job-held GEM references,
explicit per-job GPU mappings and one global exclusion domain be the
baseline, with dma_resv fences for object hazards and CPU access?

Which current DRM helpers or small driver would you recommend as a model?

I want root switching and cache publication to have explicit ownership
without treating the current private IDs or synchronous ioctl as ABI.

3. Failure handling, removal and suspend

Without a demonstrated SGX reset/stop sequence, is a terminal wedged state
with retained backing a reasonable development policy?

What stop/isolation proof must removal provide before translations can be
reclaimed, and how should active hardware detach be separated from later
GEM destruction?

In particular, old file/VMA/fault callbacks must not touch MMIO/GTT or PM
state after unplug or a later rebind.

Should suspend be refused while work/root state is uncertain until that
same stop-and-restore contract is demonstrated?

4. Upstream development sequence

Which current DRM tree should host the first reviewable work: small gma500
lifetime/admission fixes first, then submission/synchronization together
with real open Mesa userspace?

I intend to forward-port and use current GEM/PM APIs rather than propose a
cross-version abstraction around this 5.10 experiment.

Are there specific gma500 constraints that should change that order,
especially before enabling runtime PM?

Project and public evidence index:
https://github.com/reMESA-devgroup/SGX535-reMESA

The current development snapshot includes local, unpublished changes; the
public repository alone does not reproduce the latest private kernel or
physical runs.

The relevant source areas are kernel/remesa/gma500/
(remesa_gem_private_execute.inc, remesa_mmu_private.inc,
remesa_mmu_switch.inc and the private lifetime/power guards), integrated
for the experiment by tools/remesa/stage_twod_reservation.py.

Source staging is a build aid, not the proposed upstream patch format.

I understand that a future DRM UAPI needs corresponding real open-source
userspace, including error handling, reviewed for a suitable upstream
project.

I can follow up with a small current-kernel diff and a focused
lifetime/state-transition description once the integration direction is
clear.

Feedback on the ownership boundary or the most useful first diff would be
particularly helpful.

Thanks,
Gabriel Gama
operatingsystemsdepression@gmail.com

--0000000000005b7dfe065f2f68bf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hello Patrik and DRM developers,<br><br>I&#39;m developin=
g SGX535-reMESA, an independent Mesa/Gallium rendering path for Intel Pouls=
bo/GMA 500. Before designing a production submission UAPI, I&#39;d apprecia=
te advice on the ownership and lifetime model alongside existing gma500 dis=
play support. My intention is to preserve the existing display functionalit=
y while exploring render support under appropriate shared-device ownership.=
<br><br>This is an architecture discussion, with no patch series or request=
 to merge the experimental interfaces.<br><br>The test machine is a Dell In=
spiron Mini 12, Atom Z520, PCI 8086:8108, SGX535 core 0x01130000/revision 0=
x00010201. Kernel work currently builds against antiX 5.10.240-antix.1-486-=
smp on 32-bit x86; it has not been ported or qualified against current main=
line.<br><br>There is historical physical evidence for a restricted 1280x80=
0 600-frame/600-submission glxgears run, isolated native 2D copy/fill, and =
bounded fixed-profile private-MMU jobs. Those results do not qualify the cu=
rrent general scene path.<br><br>That path currently retains a 17-allocatio=
n graph and validates selected TA syntax, direct references and USE program=
 windows offline. Complete PDS/indirect-fetch validation and ordered native=
 execution remain unfinished; it is not admitted for GPU execution.<br><br>=
The latest candidate module is built but uninstalled and unqualified. The l=
ast observed stock X11 desktop still used llvmpipe. Whole-desktop accelerat=
ion, GLES 2.0, desktop GL 2.1 and an installable driver remain goals.<br><b=
r>The experimental design is deliberately serialized:<br><br>* GEM-backed o=
bjects are held by jobs with generation-checked private IDs. A private GPU =
page directory maps retained backing with narrowed access; CPU-only storage=
 is excluded. Mapping/control pages and backing lifetimes remain held until=
 a verified release, or are quarantined on uncertainty.<br><br>* Native 2D,=
 rendering and IRQ attribution share device exclusion. The existing fixed-p=
rofile executor holds an endpoint mutex and the MMU writer semaphore across=
 root binding, issue, completion, CPU visibility, default-root restoration =
and source closure. It does not implement an asynchronous queue, dma_fence/=
dma_resv or syncobj contract.<br><br>* Failure does not fabricate completio=
n or root restoration. Unplug guards join protected CPU entry points and re=
voke admission; retained state prevents reclamation/rebind where necessary.=
 This is not proof that SGX DMA has stopped. PCI save/restore and PM admiss=
ion checks likewise do not establish reset, S3 or runtime-PM safety.<br><br=
>My questions, in priority order:<br><br>1. Device ownership and gma500 int=
egration<br><br>Would extending the existing gma500 DRM device be the prefe=
rred starting point for SGX535 render support, given the shared PCI functio=
n, GEM/GTT/MMU resources, IRQ handling and power state?<br><br>I intend to =
preserve existing display support rather than introduce a competing PCI dri=
ver. What separation between display and render components would you recomm=
end before proposing a render node or submission UAPI?<br><br>2. GEM, MMU a=
nd synchronization<br><br>For an initially single-job design, should job-he=
ld GEM references, explicit per-job GPU mappings and one global exclusion d=
omain be the baseline, with dma_resv fences for object hazards and CPU acce=
ss?<br><br>Which current DRM helpers or small driver would you recommend as=
 a model?<br><br>I want root switching and cache publication to have explic=
it ownership without treating the current private IDs or synchronous ioctl =
as ABI.<br><br>3. Failure handling, removal and suspend<br><br>Without a de=
monstrated SGX reset/stop sequence, is a terminal wedged state with retaine=
d backing a reasonable development policy?<br><br>What stop/isolation proof=
 must removal provide before translations can be reclaimed, and how should =
active hardware detach be separated from later GEM destruction?<br><br>In p=
articular, old file/VMA/fault callbacks must not touch MMIO/GTT or PM state=
 after unplug or a later rebind.<br><br>Should suspend be refused while wor=
k/root state is uncertain until that same stop-and-restore contract is demo=
nstrated?<br><br>4. Upstream development sequence<br><br>Which current DRM =
tree should host the first reviewable work: small gma500 lifetime/admission=
 fixes first, then submission/synchronization together with real open Mesa =
userspace?<br><br>I intend to forward-port and use current GEM/PM APIs rath=
er than propose a cross-version abstraction around this 5.10 experiment.<br=
><br>Are there specific gma500 constraints that should change that order, e=
specially before enabling runtime PM?<br><br>Project and public evidence in=
dex:<br><a href=3D"https://github.com/reMESA-devgroup/SGX535-reMESA">https:=
//github.com/reMESA-devgroup/SGX535-reMESA</a><br><br>The current developme=
nt snapshot includes local, unpublished changes; the public repository alon=
e does not reproduce the latest private kernel or physical runs.<br><br>The=
 relevant source areas are kernel/remesa/gma500/ (remesa_gem_private_execut=
e.inc, remesa_mmu_private.inc, remesa_mmu_switch.inc and the private lifeti=
me/power guards), integrated for the experiment by tools/remesa/stage_twod_=
reservation.py.<br><br>Source staging is a build aid, not the proposed upst=
ream patch format.<br><br>I understand that a future DRM UAPI needs corresp=
onding real open-source userspace, including error handling, reviewed for a=
 suitable upstream project.<br><br>I can follow up with a small current-ker=
nel diff and a focused lifetime/state-transition description once the integ=
ration direction is clear.<br><br>Feedback on the ownership boundary or the=
 most useful first diff would be particularly helpful.<br><br>Thanks,<br>Ga=
briel Gama<br><a href=3D"mailto:operatingsystemsdepression@gmail.com">opera=
tingsystemsdepression@gmail.com</a>=C2=A0</div>

--0000000000005b7dfe065f2f68bf--
