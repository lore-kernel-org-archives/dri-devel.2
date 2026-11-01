Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE1D606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bRC4suxj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4288810E459;
	Sun,  1 Nov 2026 20:14:08 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D7DD10E459
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 20:14:01 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6b1ec41d8e9so2468469a12.0
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 12:14:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793564040; cv=none;
 d=google.com; s=arc-20260327;
 b=M0bj9GeeRSRb5igoSMofBRA1iByXcmuFBkOQRPXB9b0hkNmEe9Jt9FEn5SoaUsD0lm
 Bdu0arxHhjLQMENxKbkzeqNeD9DVZcevDKMMRTSdhNimgTvECElqbPu6yfd4hUaLnxP8
 pf5hf4qL34+kIB8vrizSXgaOMrNSrwFTh6Gmo2V4bFyVZ5BLlkHi0M+DAV5zRweeuRwZ
 qFg/SAZtiuDcDFOfnxYMb4v0n5mC9lndh4E6DMrIgdH+rPfJNE9InuNXSIsn1ylgGtNt
 Pe8qtsqEOo2V9by5fFffSLMRZqg3mpb1m8W3gLg6slLA3NDBpvJKicIuIIyJ5oM3pEjK
 HDVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=TKGxuClAalsnchJVZ7gZ5MBlHMINj3aT6+xMvJfAYBk=;
 fh=HLFknCB6Ud7B5TVATesfGwRhqZi7GQmY7UMSXB9UxLM=;
 b=H8gXGuJ3jQUwPYU0DlUPItFW2StMmGG3IMZ1Wd+qCYEw+HaNTq/HJvVBu9JOOQH6s0
 XqSAZHRAxG5paeOhUR+rCiJCinrrQBvjcFnTZ7DRIs4vAJ+EZPVu7jImUnPC7kMPGWCY
 sGzarRtAVm9uCHNkevGuIfZVfzyXKwB1bEz/2jz1aaXJxWSTb3fr4bdyzrDu4zZPW0Bp
 VLFcK8NQyAz0F1QHa38YLqlFfMQLsNbKGH3iHak0mHxBat15J13eTZmkDa7e6orqIXOF
 9Uo2XtlktDOZTsGPxzeB9sGEctXtFKqoNmMsb6kNxQwdpDZA+LhsCHlnNshdZtNBj50Z
 sR4A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793564040; x=1794168840; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TKGxuClAalsnchJVZ7gZ5MBlHMINj3aT6+xMvJfAYBk=;
 b=bRC4suxj07wgKtTjbhEOJY8tVj2B03ME/7ISFb3Si9HjBjRE3Eo93d6iesTEOlqQti
 qC6w5lnDW3YHtcaUei/ZleoYwRuig4R4qEpcrW/xFHV8etW0t4+fypUCNbuaZtWwti6v
 6G7OCbStF3nx1JgaIQ/Fxt2tDqtTNqbBIrgVJWlgNWErTbvDvg67m7nYOcHCLl1zdzT3
 /lgZj1ghc6UfoeBfzOBAjRbrROT1Uc1tOVUf773pNjpvc5w/43agwSgyfiWc1B85klOi
 BPnimZ/rrJTNxOcmZrQIHbrjAEGApL4nfPfFEbOXY4axZfCN4D7gneCKA7pgNidg2ISp
 jqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793564040; x=1794168840;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TKGxuClAalsnchJVZ7gZ5MBlHMINj3aT6+xMvJfAYBk=;
 b=cp7j88ndjGfAt6F1mqwyGs1J77BJRieyoOyvUWWtcK5l341fqpI0Tq6fXX8zyj1NYP
 q2gyLm1KVOke8HJesGpxqPGPZGG/Ipizo8DLmIL9nmOfrE61szmWgacr8TUwdtsq0cyU
 d0vUgvPr+1VqIubUla4cfdy9Q/TdvEY9Ab374q7TvzUnMkAYsplBvvJd+EvnQA/zE/Sq
 w0bvN0NEVPaRhHTX5c2xtP4/obJ6WZQtQu2ulG7rdcvPcxjkIjw9AJmlUv/FJiB6X3KU
 KCDozxQ0zu2m9YgE5nh8mNWgfshvVCX2TFp+W7xPwR4J9G3lOpGLO//Nc6G1I8OMCpnw
 5peQ==
X-Gm-Message-State: APuU4Z99Xhpr4Y8PHp2P/lDpez8xquLZPabeB/G3tn4/Fdlpm5PR1kyA
 /SRD/cSgmQmY/AkzoxewQrnuFOitRwxPn4Ps6ueFd1f7ozPck1eVqjDUGOF1JRxuHdivSGCQTL2
 CEf7VWqm09Hoglow0E+DfBDYVAM93Cv7nWEkcAbo=
X-Gm-Gg: AYBFou3u65ebPbDQkoM7acehRdhuwoU3FCYjo++sXMkSGp/zZzp8A14gcMO+V5d0mOv
 O1InPnIPiI40JXc56FG/VdHT5dcxD6KNSaYk/WVvgVYZwdEcfqBt67dnT3iNIFuPwMGDcMICh8l
 6VyEOJ4Jg1/tkurK10cZaLSiQpq4RpZ05GlqZh4QGnc2fCaa3/WkOfnzkiYhBPOL8uw6Y9mvavo
 DJ7l8QHg+Xak+BALhcvZ0cPGmumVGzyU8raC9WOslTjybDJAk2huDRyacgCDEYbhmof8YDB6/jG
 1UOzWZ1tFye61w+hNmGXwwtv1IwU1YMae/lPHSXZn33I7EQ+Zx59CNbNNqtLVTMSSnErpom0R+p
 /L3jBs66D6eofVeUmXxgKrfuyoZf9ccEef07KMjYhA2TtFMxfiwc3Eczz0D3UJkMnXxXqJA==
X-Received: by 2002:aa7:d386:0:b0:6b3:c422:9257 with SMTP id
 4fb4d7f45d1cf-6b4d4d7c182mr3860096a12.25.1793564039552; Sun, 01 Nov 2026
 12:13:59 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: "Operating System's Depression" <operatingsystemsdepression@gmail.com>
Date: Sun, 1 Nov 2026 17:13:47 -0300
X-Gm-Features: AclHuK_ghGiXJbNLygmZu6INvBTV9YV_XaXa3c0nYnDvY7T3gS2Nl40hIgxuh0s
Message-ID: <CAFGNeajNF_VMAvtDDVZPxdzskUR7Y6HPNQp+sH6eihf3PLviXw@mail.gmail.com>
Subject: [RFC] drm/gma500: SGX535 render ownership, MMU and failure handling
To: dri-devel@lists.freedesktop.org
Cc: patrik.r.jakobsson@gmail.com
Content-Type: multipart/alternative; boundary="00000000000075a410065f3cabf7"
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

--00000000000075a410065f3cabf7
Content-Type: text/plain; charset="UTF-8"

Resending after subscribing to dri-devel, as I could not confirm whether my
original message reached the list. Apologies if this is a duplicate.

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
SGX535 core 0x01130000/revision 0x00010201. Kernel work currently targets
antiX 5.10.240-antix.1-486-smp on 32-bit x86; it has not been ported or
qualified against current mainline.

There is physical evidence for a restricted 1280x800
600-frame/600-submission glxgears run, isolated native 2D copy/fill, and
bounded fixed-profile private-MMU jobs. These results do not qualify the
general renderer.

Recent experimental runs have also exercised the general-scene submission
path on physical hardware. Completion was observed, but COLOR/Z readbacks
did not establish correct rendered output. General-scene execution remains
unqualified.

Gallium frontend integration and shared COLOR/Z fence handling have passed
selected offline tests. Physical qualification of the integrated path is
still pending. Whole-desktop acceleration, GLES 2.0, desktop OpenGL 2.1 and
an installable driver remain goals.

The experimental design is deliberately serialized:

* GEM-backed objects are held by jobs with generation-checked private IDs.
A private GPU page directory maps retained backing with narrowed access;
CPU-only storage is excluded. Mapping/control pages and backing lifetimes
remain held until a verified release, or are quarantined on uncertainty.

* Native 2D, rendering and IRQ attribution share device exclusion. The
existing fixed-profile executor holds an endpoint mutex and the MMU writer
semaphore across root binding, issue, completion, CPU visibility,
default-root restoration and source closure. It does not yet implement a
production asynchronous queue or a complete dma_fence/dma_resv/syncobj
contract.

* Failure does not fabricate completion or root restoration. Unplug guards
revoke admission, while uncertain GPU state prevents unsafe reclamation or
rebinding. This is not proof that SGX DMA has stopped. PCI save/restore and
power-management admission checks do not establish reset, suspend or
runtime-PM safety.

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
public repository alone does not reproduce the latest experimental kernel
or physical runs.

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

--00000000000075a410065f3cabf7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Resending after subscribing to dri-devel, as I could not =
confirm whether my original message reached the list. Apologies if this is =
a duplicate.<br><br>Hello Patrik and DRM developers,<br><br>I&#39;m develop=
ing SGX535-reMESA, an independent Mesa/Gallium rendering path for Intel Pou=
lsbo/GMA 500. Before designing a production submission UAPI, I&#39;d apprec=
iate advice on the ownership and lifetime model alongside existing gma500 d=
isplay support. My intention is to preserve the existing display functional=
ity while exploring render support under appropriate shared-device ownershi=
p.<br><br>This is an architecture discussion, with no patch series or reque=
st to merge the experimental interfaces.<br><br>The test machine is a Dell =
Inspiron Mini 12, Atom Z520, PCI 8086:8108, SGX535 core 0x01130000/revision=
 0x00010201. Kernel work currently targets antiX 5.10.240-antix.1-486-smp o=
n 32-bit x86; it has not been ported or qualified against current mainline.=
<br><br>There is physical evidence for a restricted 1280x800 600-frame/600-=
submission glxgears run, isolated native 2D copy/fill, and bounded fixed-pr=
ofile private-MMU jobs. These results do not qualify the general renderer.<=
br><br>Recent experimental runs have also exercised the general-scene submi=
ssion path on physical hardware. Completion was observed, but COLOR/Z readb=
acks did not establish correct rendered output. General-scene execution rem=
ains unqualified.<br><br>Gallium frontend integration and shared COLOR/Z fe=
nce handling have passed selected offline tests. Physical qualification of =
the integrated path is still pending. Whole-desktop acceleration, GLES 2.0,=
 desktop OpenGL 2.1 and an installable driver remain goals.<br><br>The expe=
rimental design is deliberately serialized:<br><br>* GEM-backed objects are=
 held by jobs with generation-checked private IDs. A private GPU page direc=
tory maps retained backing with narrowed access; CPU-only storage is exclud=
ed. Mapping/control pages and backing lifetimes remain held until a verifie=
d release, or are quarantined on uncertainty.<br><br>* Native 2D, rendering=
 and IRQ attribution share device exclusion. The existing fixed-profile exe=
cutor holds an endpoint mutex and the MMU writer semaphore across root bind=
ing, issue, completion, CPU visibility, default-root restoration and source=
 closure. It does not yet implement a production asynchronous queue or a co=
mplete dma_fence/dma_resv/syncobj contract.<br><br>* Failure does not fabri=
cate completion or root restoration. Unplug guards revoke admission, while =
uncertain GPU state prevents unsafe reclamation or rebinding. This is not p=
roof that SGX DMA has stopped. PCI save/restore and power-management admiss=
ion checks do not establish reset, suspend or runtime-PM safety.<br><br>My =
questions, in priority order:<br><br>1. Device ownership and gma500 integra=
tion<br><br>Would extending the existing gma500 DRM device be the preferred=
 starting point for SGX535 render support, given the shared PCI function, G=
EM/GTT/MMU resources, IRQ handling and power state?<br><br>I intend to pres=
erve existing display support rather than introduce a competing PCI driver.=
 What separation between display and render components would you recommend =
before proposing a render node or submission UAPI?<br><br>2. GEM, MMU and s=
ynchronization<br><br>For an initially single-job design, should job-held G=
EM references, explicit per-job GPU mappings and one global exclusion domai=
n be the baseline, with dma_resv fences for object hazards and CPU access?<=
br><br>Which current DRM helpers or small driver would you recommend as a m=
odel?<br><br>I want root switching and cache publication to have explicit o=
wnership without treating the current private IDs or synchronous ioctl as A=
BI.<br><br>3. Failure handling, removal and suspend<br><br>Without a demons=
trated SGX reset/stop sequence, is a terminal wedged state with retained ba=
cking a reasonable development policy?<br><br>What stop/isolation proof mus=
t removal provide before translations can be reclaimed, and how should acti=
ve hardware detach be separated from later GEM destruction?<br><br>In parti=
cular, old file/VMA/fault callbacks must not touch MMIO/GTT or PM state aft=
er unplug or a later rebind.<br><br>Should suspend be refused while work/ro=
ot state is uncertain until that same stop-and-restore contract is demonstr=
ated?<br><br>4. Upstream development sequence<br><br>Which current DRM tree=
 should host the first reviewable work: small gma500 lifetime/admission fix=
es first, then submission/synchronization together with real open Mesa user=
space?<br><br>I intend to forward-port and use current GEM/PM APIs rather t=
han propose a cross-version abstraction around this 5.10 experiment.<br><br=
>Are there specific gma500 constraints that should change that order, espec=
ially before enabling runtime PM?<br><br>Project and public evidence index:=
<br><a href=3D"https://github.com/reMESA-devgroup/SGX535-reMESA">https://gi=
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
abriel Gama<br><a href=3D"mailto:operatingsystemsdepression@gmail.com">oper=
atingsystemsdepression@gmail.com</a>=C2=A0</div>

--00000000000075a410065f3cabf7--
