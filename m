Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBDDC624DD
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2A3810F3D6;
	Thu,  3 Sep 2026 07:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ReR29FTN";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6F7710E013
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 03:52:54 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c2530cabcf4so306469966b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 20:52:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788407573; cv=none;
 d=google.com; s=arc-20260327;
 b=NdNnXTt2w9mRhVMgqSNwoUyPLq+ZDK/BRSei+iAS8qC/BOoKmFYcbSUaF6/ormMRTM
 ps2gNilvpNT5YxHiu1OCLIvMey+Qp9mv4GOERnTuLQiHswxq7ZAR6P1PnnOcmzgSnzHv
 jtEQckBUc91YOge61xiQBz3hmg42CxhK4DA1O4jPL/Y3CK5ttUqWbAkv5JnAFJhiDz5C
 oQeebd5/+jr9BSP7qUniaOEsqiUOvbjUdvkC7vOPVIidMFTRgQjj+cyl1CBQxuuSUYEc
 B7kKj8dRerNVEIZOkfsZffZ5cB9NlIot1HDynG96gUPevw3AYcyk6YvNFFNFup527mpp
 LGDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0nG8U1FR8wXCOSjXTDfBvYxce9r58Wp20V47CS4+oyY=;
 fh=XYYUkZzO6XGENL69bOmOd5g2lG7dGTUv+J081huMGSw=;
 b=FosYs5JqUOMZAtIdBjUHSGaAhrfoaKzmbn6y2pQsRO9WwG2oyNb8B5FsdxePR8QhSv
 LOyx/88UpzVmP7NwNrQDgtnYh2og2sBSW6Ja5+aMyGmfXwdU1GIm31Esrby8APlZk67J
 PO2X+eshzcF5UESlNqQn/yfeRZkV2JtcywqMErn/h3m7OjZiorc/bfemuZDNiTe4xEJh
 I1KI4VkhScge8BKCONHr1GhP8Tr6dRLxuAFrBeYcdGVXgT3KdmTjiXIxg6DrJoh3Uprs
 eEhYJ2ObDc9ooPmpwQeqoAGz6ApYjhOmejqtszDeMQZIBysqWSWNZH0wPBCkbydg2tyl
 gkVg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788407573; x=1789012373; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0nG8U1FR8wXCOSjXTDfBvYxce9r58Wp20V47CS4+oyY=;
 b=ReR29FTN06G+TCQ0Z5lITG/3xWAOmJJaW+zkrhFYXFBVhrk88JQcTRHdN/CWMX1U+p
 8H5YJ4SVIxoN3R8fpMh6Wk8nPUq51vwkrr83gHTllhBQnNT0Ktcg6auJyPCyinTB3mql
 Cmb66Qr/cgPLHXlcqhX7lFiDWTqPUZa/yllNFkN9Llkmlj81o5fbshQNmD2IEs78yQSv
 AfBeqyxzLBiu8fcSc8aVtlL8U259u9h6iyhrZvo9xjFDLthdwsPiWbOM4sS7OKNcfNSm
 QVm4p4y0Gtl4FHyr0yTS/riDU2Ve0i/CfbSLa4/t9bRVcVvNklrhZoTAO6mPYXzDNh9A
 LE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788407573; x=1789012373;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0nG8U1FR8wXCOSjXTDfBvYxce9r58Wp20V47CS4+oyY=;
 b=hqset8nBDQoOzIFIJDD4A6heu/ORmrpPeEIfF4a3cLu1SVpNWjQOOMu9gMWTXP0hTr
 4XNWNzoargDiLnSNPzbZdfM7h+CFEHYpkFF1LDjSnNatyEO8M6TzyDsrxXCu7do3lfR6
 aZe0cVAhueG2dLPakGwynK4fIqSLTawrvxYSfhjh1HfsAw20mD6/RlNRWNC2cYW7TTSU
 UZsvQW8iynBBTCFkoTI3t6WbWGZsuGXl9I6h48o9W13zKz46VnC9C3iQJnkef2vTzpyD
 59ev9PzAzUJG6NYkB12BRMkgtQbEhlSYp4JqMy+Por57SFEkGbVP5t8JOFNfVbtwPcHk
 bHMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLP4+0MVxe3KApyUYGRZJnKO9J2T1t0Ke6aPt6FBybkp0plTLZLj9XCKGgzRQCX2znzLGqgr5IhBI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lsoLdMAOUqlGAG9p6t1TC8KJ4zFAKvGBCEyUYQRO6n8FnQFRqZ
 x1MvusJ70nkOsBxEtj9MvmC/Lzu/z1OdCeeXjdjfCyjnkuxTdNu4LFqoG0BxBfQtjNIobSnYnpV
 Yg77e36E+e98Zvdz9i2pYqOB1r0jXz/A=
X-Gm-Gg: AYBFou3rXg54BlT6yMNZDtseE3dvupYcbZitynKZ4s763YRjFSwVWQPaOYnKXvBq2dk
 cwQLA7jbmd7noh+hPrhgyBZG2HtuFeOtDMepqmnMLy0vQTy/LrQUmWVz58L8ALV2feie4JSdBj6
 J6D0prp/8KimXwm1e19GkorewhnL7rg81ZfF6xhqptJuugwCzjrdLv+6TTAlvI1y52wPGSLe3C7
 wNGF4MMl2rh3bFq6cabOyOmcCC4hELRjn7hYlnBdwQxW2zt61Th8utTF/FSFNni6KR2dhcA0jLD
 3OuXx6S+uAhAD4mLxacz/ReWJreY6JoNnHT0QV1Lxg+agsYHAvsKLSi2T1UR53QAWpphZTpb4Pb
 MrJTw2iSrhSc/tBZqzemUZTba9M3+Su7b
X-Received: by 2002:a05:6402:388d:b0:6a6:32f5:90b4 with SMTP id
 4fb4d7f45d1cf-6a682af9bf4mr6070931a12.22.1788407573017; Wed, 02 Sep 2026
 20:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <aoczaCuoaZfUkfm5@gsse-cloud1.jf.intel.com>
 <CAMpTW2cxRrG4oJ0HrRoKhHrVHxWO01-L+QDoWMLCAUaSfw75sA@mail.gmail.com>
 <CAMpTW2fxFRrpn1b5WGYBrtLLMfUo_fmx9s2D0b552GJp-sF5qg@mail.gmail.com>
 <8b7001c68c94491095f41d2a3dff45090c0a95cf.camel@linux.intel.com>
 <aoeUdfrPX+0ZnZMr@gsse-cloud1.jf.intel.com>
 <CAPM=9twBded3B553KYzwDtVd0NbhbAwbiVDGw_bdrmBnOKgtKA@mail.gmail.com>
 <CAMpTW2eXS9tBzppJvvfZ-FiwoJ5MKOAdB9sqYgCDPVQ_+___ZA@mail.gmail.com>
 <ao+acQG/wyZYNYfW@gsse-cloud1.jf.intel.com>
 <apfZcEF8IlDak/As@gsse-cloud1.jf.intel.com>
 <CAPM=9tw9dtxN+tZLrb4fvPGndUT+He7Y=o39ByMEva8wWyq56g@mail.gmail.com>
 <apflRScB/NTEiEzU@gsse-cloud1.jf.intel.com>
 <60f8132f-efc9-4dc1-bd02-b62391bf3fa0@amd.com>
In-Reply-To: <60f8132f-efc9-4dc1-bd02-b62391bf3fa0@amd.com>
From: Nathan Bourgeois <iridescentrosesfall@gmail.com>
Date: Wed, 2 Sep 2026 23:52:40 -0400
X-Gm-Features: AcwNN1XjM_3CDNM2RXbcW9bsYX8QLssOvGlmXwTLjeDvMA-uBLr1c2b3x6gwG1Y
Message-ID: <CAMpTW2d8Q0OXpw1G_9+cj0ohrYo9cONUPEBgC6kpLumosTxt+Q@mail.gmail.com>
Subject: Re: [PATCH] drm/xe: Fix unnecessary host-side population of ttm_tt on
 non-TT resources
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Matthew Brost <matthew.brost@intel.com>, Dave Airlie <airlied@gmail.com>, 
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Matthew Auld <matthew.auld@intel.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

> Nathan - the conclusion is validate in Xe.

Understood; I will begin working on that patch.

On Wed, Sep 2, 2026 at 5:04=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 9/2/26 10:58, Matthew Brost wrote:
> > On Wed, Sep 02, 2026 at 06:54:55PM +1000, Dave Airlie wrote:
> >> On Wed, 2 Sept 2026 at 18:08, Matthew Brost <matthew.brost@intel.com> =
wrote:
> >>>
> >>> On Wed, Aug 26, 2026 at 07:01:21PM -0700, Matthew Brost wrote:
> >>>
> >>> Dave ping. Question below.
> >>>
> >>>> On Thu, Aug 20, 2026 at 10:34:49PM -0400, Nathan Bourgeois wrote:
> >>>>>> Shouldn't we just be calling xe_bo_validate() here instead of
> >>>>>> ttm_tt_populate? (With the correct xe_validation_guard() wrapping)=
.
> >>>>>
> >>>>>> Yes, this might be a better solution, making ttm_bo_setup_export()
> >>>>>> completely unnecessary.
> >>>>>
> >>>>> If ttm_bo_setup_export() is unnecessary, I'm happy to change the pa=
tch
> >>>>> or make a new patch. I will attempt to implement and test this loca=
lly.
> >>>>>
> >>>>>> This part looks good as different patch from what I'm assuming wil=
l be a
> >>>>>> TTM fix.
> >>>>>
> >>>>> Regarding this, what do you recommend I do, assuming the patch
> >>>>> remains local to drm/xe? I'm still learning the ropes of contributi=
ng.
> >>>>>
> >>>>
> >>>>
> >>>> For Xe I believe Thomas and I aligned a xe_bo_validate with a correc=
t
> >>>> xe_validation_guard is the Xe preferred solution in the existing
> >>>> design... But a question to Dave below before I commit to anything.
> >>>>
> >>>>> Nathan
> >>>>>
> >>>>> On Thu, Aug 20, 2026 at 9:08=E2=80=AFPM Dave Airlie <airlied@gmail.=
com> wrote:
> >>>>>>
> >>>>>>> Yes, this might be a better solution, making ttm_bo_setup_export(=
)
> >>>>>>> completely unnecessary.
> >>>>>>>
> >>>>>>> It's also a bit odd that, in flows where we don't have backing st=
orage
> >>>>>>> on export, we populate with pages and charge the system memory cg=
roup,
> >>>>>>> only to move the data to VRAM when the import attach is triggered=
,
> >>>>>>> resulting in a copy and a change in cgroup charging.
> >>>>>>>
> >>>>>>> I guess the question is why was ttm_bo_setup_export() introduced =
over
> >>>>>>> just a validation at export?
> >>>>>>>
> >>>>>>
> >>>>>> I'd like to think I had an answer for that, but I don't. Likely
> >>>>>> because I wasn't thinking about VRAM charging at all, and just
> >>>>>> worrying about making sure we had populated some pages for system
> >>>>>> memory ones, so the other side couldn't DoS us.
> >>>>>>
> >>>>
> >>>> Dave:
> >>>>
> >>>> We don't charge any cgroups yet, right? This would only come into pl=
ay
> >>>> once a version of [1] merges, correct?
> >>>>
> >>>> What would prevent the pages populated for a TTM BO from being
> >>>> immediately reclaimed and discarded? I'm fairly certain Xe's shrinke=
r
> >>>> could do exactly that, since we don't pin those pages. This seems to
> >>>> imply that we'd need to store the cgroup associated with the TTM BO =
at
> >>>> creation time and charge allocations to that cgroup, regardless of w=
hich
> >>>> task ultimately triggers the page allocation.
> >>
> >> This was actually to fix a non-cgroup bug with a possible priority
> >> inversion problems.
> >>
> >> i.e. a client could allocate a BO export it to a compositor, and then
> >> the compositor would populate it for the first time and get ENOMEM.
> >>
> >> This was to avoid that case by making sure a client had tried to
> >> allocate all the pages for the BO before exporting it, so it would get
> >> the failure at that time.
> >>
> >
> > Ah, this makes more sense.
>
> I was wondering why we did that as well, but yeah now I remember.
>
> >
> >> I don't believe xe should just be reclaiming and discarding these
> >> pages without swapping them to shmem first?
> >
> > Yes, the pages would be in shmem if swapped.
> >
> >>
> >> Validating is probably fine as well.
> >>
> >
> > Nathan - the conclusion is validate in Xe.
>
> I think we ran into a similar issue during some recent amdgpu work as wel=
l, so adding Felix on CC.
>
> Basically we sometimes need empty BO objects without resource nor TT obje=
ct to fill them with some resource object at a specific location.
>
> So far we just gave them a dummy system placement for the initial validat=
ion, but that is far from ideal.
>
> Any idea how to do that cleanly without breaking the compositor fix?
>
> Thanks,
> Christian.
>
> >
> > Matt
> >
> >> Dave.
>
