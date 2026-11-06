Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6229606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kfLrDXa6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D02B51127C4;
	Fri,  6 Nov 2026 08:37:47 +0000 (UTC)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DF0010E117
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 08:37:41 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-4af173320f9so229264b6e.2
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 00:37:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793954260; cv=none;
 d=google.com; s=arc-20260327;
 b=UPouI2nSGSgL0uTVTDuy78z3vfT8+lBD77S+NuF7lIjix9W4bynn0yYR3s+BPTWcPw
 WIdyyHYmlNWDFyYckWz2+d6GufFOSLxJnC+SnAB59Clly1xc6jSWT2/0r0R17H3z//0G
 pBm6pgBLnSYzh7tiC/5Qhl+NhxzLtiofpj/CTlyX5CyYDOw2VAbyPy1RgYDBvFkCfCPo
 SV2tBOACwMUi1rzUoZLuFWiUBPthum/gcEJalkSHk+ZXvIMBIpjgfimUj7yGoLI/kqdh
 2KNFQdr4iTk/jVLt+Uv/7CrYeFeL75MgQEF658gfGL0YyjTixn08ASnyfS68r1104h7F
 prHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yuc/CuUWd+Sel3gSNxUvERKwTZoThyCDyBn6276wNqI=;
 fh=UvhXpY9Okb+hMuMufCG2ZnYjHwyJ1BUR6xoMcgb4nwU=;
 b=NgKZfyfuh0SQDWgj4Y+t9D+drG1e601mKltnEN9LJREoVFKmHdYbY2Gb136J80HAK8
 FTl3oQOb2fgHhSF6jDejJR6HlsY/RxfWCPH/xoAzLrDNQwxFW+mBQFS3XRQ0VvNj9ejV
 5YC7R2LJURzzWoI4Rk6ELohCHUvlQKP0Ke6XGOFNI+QrlAF80PG/VhYCNjNNuSpLfGwn
 ZkAZ2I/dvKDHCLKmmIbSzIE+4lwmFeeEhNfnntXgeAYw4LH+g2xMIY2JnzFmLTLL4Xos
 DaglYFo9fz2vLU2gTAqSPxqYA5zW3oyXbpPZHM30q+B+1pkl3mBMZJpL4zAV3gwUBXaX
 cVGA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793954260; x=1794559060; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yuc/CuUWd+Sel3gSNxUvERKwTZoThyCDyBn6276wNqI=;
 b=kfLrDXa6x9/vDvUV3qqkHJfg0XTodoNpwK0cQTYzLDUyFW+zlWzJAd9LHsVeWyQGm8
 zCfhM0kFzmyCHOAwpDZxD7CieeakzwRNXuokhng04sDj6WzIqvyI3ajcyEBivhMoA/tx
 0x3u3Je/noZKDlk86P/hJsti3HdUN0NR4+lFatql3+eGwBz61YVF5nHOK+mjBE+yg+87
 pswRe0188xY3Hgkdkw928KaawBVHMb13QzNleMiG434zgedMAvC5eF3XzyCW01/bnEuy
 LEWnOR6P/Bj9Od5p5V1hoOFfZPVJbguATSuXzHSP9x/hPdbGRVHTL86sNj91zvX8zAKg
 AfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793954260; x=1794559060;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yuc/CuUWd+Sel3gSNxUvERKwTZoThyCDyBn6276wNqI=;
 b=bIqltS6xxdzYzz8aup5h1ISmcGD2rtfOrdpIMmRiXwEeVgTyHK2R2m17571A3OpvG4
 HHMkwJ7+pTU60GWE7SENR5Lz5a7RcnzSTHQTMSLCb9jWhKu663xDdrsjlZuTwGDWnBuA
 43/jKV7TWFSs9QJHLKV3hnnQKA8lsTTopMAneDsWuhS6O93za8Si4IU0cTkAruoT4dq7
 +VDDeYg0jX7bActKx7Gju5RmuFSznuwWvxFrOCn/c2XQSwZWyPdrS7SknjPomPoTIE1i
 8cxkwFfWa1792UqQ44GkKq0BEEDc8zR/YEsNMBb8ZKTmXcU4fQTG/VQB3MzMp7mdZ+mZ
 1LuA==
X-Gm-Message-State: APuU4Z8aas56KbCvH4qBHEAGZjisn9aLiCU7W+HK0c92qymgfu/Qnk1C
 rJrf+5brUDksHX0ftI4SnMlJfnG5Zw/OMYqhcFG+sADubw6bDBLSrpCWZ/zRWjeCcNOpzed9huH
 y6ot8RixYFxgWQWSBPuJccppAwg6oc3k=
X-Gm-Gg: AYBFou0bnKuL41exzXvi99epdufgp9nj4vJWpOzTE/u51Nj9mO4qNFIyGYlqooGmkEP
 j0hovHDo0gXIrKNwkggg0Hj+WB8Srlxm1Hp1sqlDgivi92UNYp30qUAPu/wcvnvJs8pdgoMpoO2
 yqoSr199L6oAiZ+s82iMUbDs5hTMY1roDXi10kRa1NUcX6Q/GgOTCPidQb/lBAIxYaKhwUytaI1
 hEmkKYbba/VPu3f3qBKmHh0HzUmzvUmYUwzuZ8/tpUMDCTLzEb9bFgckg+O2kAWdYUh1zkvZ2pU
 RKE+GYcuRuHfF4fEitCO06UZZD1O5OmxD28lPWi2oKKQvY9VByo2jEOdXsghZyl80kwaNms02Aj
 uPrvDzqNJ+H9Po7QDN8kLiKlEAOMsuVBOmUiTXIV4lG/cs5dpcoKqd1y+
X-Received: by 2002:a05:6808:4f4c:b0:4d5:295c:a831 with SMTP id
 5614622812f47-567e141d17bmr1221367b6e.62.1793954260523; Fri, 06 Nov 2026
 00:37:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAFGNeajNF_VMAvtDDVZPxdzskUR7Y6HPNQp+sH6eihf3PLviXw@mail.gmail.com>
 <CAFGNeaih0pByA9harSnSd4opyCu4EFKmSR9quD3cNzXEEp+0kw@mail.gmail.com>
In-Reply-To: <CAFGNeaih0pByA9harSnSd4opyCu4EFKmSR9quD3cNzXEEp+0kw@mail.gmail.com>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Fri, 6 Nov 2026 09:37:28 +0100
X-Gm-Features: AclHuK843WarVW34NjesUVFVzNz9EL4GjcVYkQNMj8QYGVIsokoEylcbeQZLLgs
Message-ID: <CAMeQTsZEwmb3iCPWUa7H2J00x2QBsaCG9GmKMn3U7iJgcHb_RQ@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: "Operating System's Depression" <operatingsystemsdepression@gmail.com>
Cc: dri-devel@lists.freedesktop.org
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 6, 2026 at 7:31=E2=80=AFAM Operating System's Depression
<operatingsystemsdepression@gmail.com> wrote:
>
> Hi,

Hi Gabriel,

>
> Following up on my SGX535 render architecture RFC.
>
> Since the original RFC, the experimental implementation has demonstrated =
physical Gallium/NIR scene submission, GPU command completion and retiremen=
t, and successful COLOR/Z24 readback on PowerVR SGX535 (GMA500) hardware
>
> These results have been validated on an Intel Poulsbo GMA500 system runni=
ng a Linux 5.10-based kernel. I'm currently looking for a lightweight Linux=
 distribution with a recent kernel to begin testing against newer kernel ve=
rsions
>
> I'm currently planning a modular architecture, with clearly separated res=
ponsibilities for GPU memory management and MMU mappings, GEM buffer owners=
hip and lifetime management, GPU command submission and execution, completi=
on fences and synchronization, and timeout handling, error recovery, and de=
vice removal.
>
> My current preference is to integrate SGX535 rendering within the existin=
g drm/gma500 driver, rather than introduce a completely separate DRM driver=
.
>
> The intention is to preserve the existing display infrastructure while ad=
ding rendering capabilities through modular components that can be reviewed=
 and maintained independently.
>
> However, this is still a proposed direction, and I'm open to a separate D=
RM render driver if the maintainers consider that a better architectural fi=
t.
>
> Before proceeding with the initial patch series, I'd appreciate feedback =
on three architectural questions:
>
> 1- Should SGX535 rendering remain within drm/gma500, sharing display-devi=
ce ownership, or would a separate DRM render driver be preferable?

If you only plan on targeting gma500 hardware then I'd suggest you
keep the SGX535 code in the gma500 driver. If you plan to target other
devices it might be better to separate them.

>
> 2- What would be the preferred ownership model for GPU MMU mappings, GEM =
buffer lifetimes, and completion fences, particularly when coordinating ren=
dering with the existing display infrastructure?

IIRC, the old implementation of the MMU mapped the GTT and MMU
identically. This might not be desirable depending on what the MMU is
capable of, but I suppose you will need to figure that out during the
reverse engineering.

>
> 3- What is the minimum acceptable recovery contract for GPU submission fa=
ilures, timeouts, suspend/resume, and device removal?

Preferably suspend/resume, GPU reset and device removal should work,
but unrecoverable GPU hangs do happen and old hardware like SGX535
might not behave as well as we would like. I wouldn't worry too much
about this now.

>
> The overall implementation remains experimental. However, parts of the ke=
rnel-side infrastructure may already be suitable for an initial RFC patch, =
subject to architectural review
>
> I'm considering submitting a small initial RFC patch within the next few =
days, focusing on foundational infrastructure and architectural integration=
 rather than submitting the entire experimental implementation at once

Sure, I prefer you "submit early and often" rather than spending too
much time on something that is fundamentally wrong to begin with.

>
> My goal is to keep the initial changes small, reviewable, and compatible =
with the existing gma500 driver, while establishing a foundation for subseq=
uent SGX535 rendering support
>
> I'd appreciate any early feedback on the proposed architecture, particula=
rly regarding driver ownership and the preferred upstream integration path =
:D

I'm assuming much of this is AI generated so please be brief with
explanations and commit messages. I often get very long descriptions
from AI submissions and I usually end up not reading it just because
of that.

Also, we probably need to update the KMS code for the gma500 driver.
It's fairly ancient and could certainly need things like atomic
modesetting. I can have a look at that.

Patrik

>
> Thanks!
>
>
> Em dom., 1 de nov. de 2026 17:13, Operating System's Depression <operatin=
gsystemsdepression@gmail.com> escreveu:
>>
>> Resending after subscribing to dri-devel, as I could not confirm whether=
 my original message reached the list. Apologies if this is a duplicate.
>>
>> Hello Patrik and DRM developers,
>>
>> I'm developing SGX535-reMESA, an independent Mesa/Gallium rendering path=
 for Intel Poulsbo/GMA 500. Before designing a production submission UAPI, =
I'd appreciate advice on the ownership and lifetime model alongside existin=
g gma500 display support. My intention is to preserve the existing display =
functionality while exploring render support under appropriate shared-devic=
e ownership.
>>
>> This is an architecture discussion, with no patch series or request to m=
erge the experimental interfaces.
>>
>> The test machine is a Dell Inspiron Mini 12, Atom Z520, PCI 8086:8108, S=
GX535 core 0x01130000/revision 0x00010201. Kernel work currently targets an=
tiX 5.10.240-antix.1-486-smp on 32-bit x86; it has not been ported or quali=
fied against current mainline.
>>
>> There is physical evidence for a restricted 1280x800 600-frame/600-submi=
ssion glxgears run, isolated native 2D copy/fill, and bounded fixed-profile=
 private-MMU jobs. These results do not qualify the general renderer.
>>
>> Recent experimental runs have also exercised the general-scene submissio=
n path on physical hardware. Completion was observed, but COLOR/Z readbacks=
 did not establish correct rendered output. General-scene execution remains=
 unqualified.
>>
>> Gallium frontend integration and shared COLOR/Z fence handling have pass=
ed selected offline tests. Physical qualification of the integrated path is=
 still pending. Whole-desktop acceleration, GLES 2.0, desktop OpenGL 2.1 an=
d an installable driver remain goals.
>>
>> The experimental design is deliberately serialized:
>>
>> * GEM-backed objects are held by jobs with generation-checked private ID=
s. A private GPU page directory maps retained backing with narrowed access;=
 CPU-only storage is excluded. Mapping/control pages and backing lifetimes =
remain held until a verified release, or are quarantined on uncertainty.
>>
>> * Native 2D, rendering and IRQ attribution share device exclusion. The e=
xisting fixed-profile executor holds an endpoint mutex and the MMU writer s=
emaphore across root binding, issue, completion, CPU visibility, default-ro=
ot restoration and source closure. It does not yet implement a production a=
synchronous queue or a complete dma_fence/dma_resv/syncobj contract.
>>
>> * Failure does not fabricate completion or root restoration. Unplug guar=
ds revoke admission, while uncertain GPU state prevents unsafe reclamation =
or rebinding. This is not proof that SGX DMA has stopped. PCI save/restore =
and power-management admission checks do not establish reset, suspend or ru=
ntime-PM safety.
>>
>> My questions, in priority order:
>>
>> 1. Device ownership and gma500 integration
>>
>> Would extending the existing gma500 DRM device be the preferred starting=
 point for SGX535 render support, given the shared PCI function, GEM/GTT/MM=
U resources, IRQ handling and power state?
>>
>> I intend to preserve existing display support rather than introduce a co=
mpeting PCI driver. What separation between display and render components w=
ould you recommend before proposing a render node or submission UAPI?
>>
>> 2. GEM, MMU and synchronization
>>
>> For an initially single-job design, should job-held GEM references, expl=
icit per-job GPU mappings and one global exclusion domain be the baseline, =
with dma_resv fences for object hazards and CPU access?
>>
>> Which current DRM helpers or small driver would you recommend as a model=
?
>>
>> I want root switching and cache publication to have explicit ownership w=
ithout treating the current private IDs or synchronous ioctl as ABI.
>>
>> 3. Failure handling, removal and suspend
>>
>> Without a demonstrated SGX reset/stop sequence, is a terminal wedged sta=
te with retained backing a reasonable development policy?
>>
>> What stop/isolation proof must removal provide before translations can b=
e reclaimed, and how should active hardware detach be separated from later =
GEM destruction?
>>
>> In particular, old file/VMA/fault callbacks must not touch MMIO/GTT or P=
M state after unplug or a later rebind.
>>
>> Should suspend be refused while work/root state is uncertain until that =
same stop-and-restore contract is demonstrated?
>>
>> 4. Upstream development sequence
>>
>> Which current DRM tree should host the first reviewable work: small gma5=
00 lifetime/admission fixes first, then submission/synchronization together=
 with real open Mesa userspace?
>>
>> I intend to forward-port and use current GEM/PM APIs rather than propose=
 a cross-version abstraction around this 5.10 experiment.
>>
>> Are there specific gma500 constraints that should change that order, esp=
ecially before enabling runtime PM?
>>
>> Project and public evidence index:
>> https://github.com/reMESA-devgroup/SGX535-reMESA
>>
>> The current development snapshot includes local, unpublished changes; th=
e public repository alone does not reproduce the latest experimental kernel=
 or physical runs.
>>
>> The relevant source areas are kernel/remesa/gma500/ (remesa_gem_private_=
execute.inc, remesa_mmu_private.inc, remesa_mmu_switch.inc and the private =
lifetime/power guards), integrated for the experiment by tools/remesa/stage=
_twod_reservation.py.
>>
>> Source staging is a build aid, not the proposed upstream patch format.
>>
>> I understand that a future DRM UAPI needs corresponding real open-source=
 userspace, including error handling, reviewed for a suitable upstream proj=
ect.
>>
>> I can follow up with a small current-kernel diff and a focused lifetime/=
state-transition description once the integration direction is clear.
>>
>> Feedback on the ownership boundary or the most useful first diff would b=
e particularly helpful.
>>
>> Thanks,
>> Gabriel Gama
>> operatingsystemsdepression@gmail.com
