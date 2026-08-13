Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDF5C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:42:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3750D10F263;
	Thu, 13 Aug 2026 09:42:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HNJyRjbm";
	dkim-atps=neutral
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92E2310E4AC
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 02:40:50 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-81dfdbd86d1so16624717b3.1
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 19:40:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786588849; cv=none;
 d=google.com; s=arc-20260327;
 b=oRyA1VesiMFBnWWxK3ff4bkEb+uvhuGqAqAHcd3fQ7R6+FUUmqdaN8jQFwtLSL/sWf
 lb+sbcRGuvXId8s8GDOO8R5diQv1yPXKRym7p9jaARvYRz7j4TzV1jCCqCgCtyjS6mja
 BvwyUVtZc0lMrdUdGjEztLxC+FRzMwu8XsDzyfiMu/BKR0NdzIy78XxaUQ4k7rvANgdc
 gNavXf6L/2CivLUcZTk3tZcXEIO4irVzw5+CPYmdGCmjA+zAsO39aIu88QY9ddIUrElv
 oLx7blmoZ03pW89FnVVD2L87kYDlMqF1kXNnmVXTqCBv8Ii1jzOnJfmTNh43QBV3EUkb
 naYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1vUVj3VSZIxTxEfH3pUjPmxFhzWf7aK797/II9E+ANk=;
 fh=Fp85UcA9BkMo2cS1FQTcezCnw1JysVKpt5RZSOKRoRw=;
 b=LJhFUHWNq1Fs5dW9aMNQs7j1kU5waFKD0NZezpUrEB3dCkdUQYYWaha0p0pxftjGwj
 2MwXFnOR+UBF7TvPdrP5pfmRlZFlFQvej2GnNonY08HkGX8BIR2z8oVYdiqNIlqyrTgn
 N9c3zgW2ytAP3KjF6he2CVUkbatQPInudQVg2oEe7P2uX5XWvsgrTIPIusR0rf2wRSLB
 WnwmAkLbkj6ncvwpr+vVm26WLBJ5LyvXzXvXJZ/9aq2nnTLUTg4QGOZOWGc5STm9Pyzm
 hqKgmUuxReCz+NBVeMyOPZsJiuelsZ7OkUx/H88FN2ynT2N501J1+RS+XCGlv8te9Yvl
 90ng==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786588849; x=1787193649; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1vUVj3VSZIxTxEfH3pUjPmxFhzWf7aK797/II9E+ANk=;
 b=HNJyRjbm1RQDav8DbNIRosE3P65r4tndqCX3+7FGFIpAxPvhnQxtFNm5goYWyS6PxK
 Py2ti9kMO51XhB0P/8qfPSsyK1zOC9pVCUDl9OkuUX0I0ZxV2owwYgDQ6C2dC2x7pnkk
 s3qWjU0d4aj728GA7DK5ql61ukb9Lb2Nob3tT17GEvwf5FZx/amTdP7XGewazNDJun6D
 rgukcWR94zQpMyzTE3v7ghloZWRj3l2P7dT+s/OTLqIVhKeydhoy0vpxFdoG2VYJOsE2
 +4WUy1k3nnwG1sGivRfIW/AG2e9ak0Ekv+Jd46vqM/0MyMzAuoxsnI9GpRKNNxeYNJF/
 7mtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786588849; x=1787193649;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1vUVj3VSZIxTxEfH3pUjPmxFhzWf7aK797/II9E+ANk=;
 b=qBs+pHqXmd6HlA08c7I14RRxVj2UuXA03xpUgXhtzF6/TO1uxbYhByrHQrL7OJLZOi
 EPj9aySdQZIQJ0m0Wz0yUK6g/5eVN+XLwdlfFWIrv0ywc+JkSoPQatRmnZFx09ISo5TW
 q3zVKO98fvEvHyLn4rdqabJ4+39QIxeER6ZQ2k36J8GTcH7EgGjf2TYKl5/+pmSIlqfF
 luFwUDPCjd1rtSFocbucahh5EBb+C5QAixIn62F3+iK75dWZBeAGvlyhlWR+OrBmWqTg
 T+ZyLwWN0biblNIxFI21i+y9Znq55D0q6DuJ8CuV/QRmyJfZr6InWAnTuC7++NTCh7UT
 vAkg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrr9+z1/PiBFTbqF8XsdjpB4nP+R7KaBd2Rzzg5ry52LGt0GJGP3v9aYNLuridiYSCtW5UXLW26vuo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdMWE8ZGHyO8J95j+pNAL+HsFQD071Xn3pZJGbTh8FlYrPRLQu
 5MrnG657aXNvf/hfsy5zn0/GuvATy3b9cmTgp2rzLPqOnnDz7wOkAHJkRG0xcwynIA+8zS6fpxc
 iztQJHjL4MYKbBBoVZ5JErxu3hvoOJC7An/Uw
X-Gm-Gg: AR+sD11KBRg4ymi+nqz3KJkhbijdlwgXIykNTnidA1IKAeUyi/QmswJRYC9LnneNyff
 5gZszlg2Yiq+mOC+oV87gz4P063Fdp70NCJHOygmmG92g5NpEQ1lkdyzI9Wh6iM04xq0w/t6mm3
 BnQlEEMiZHiNJ69CWdHh1QjdY3h/fa97Xv4pBCTGsZrF2ShLu57ogUb3DtEkTFsTCCzCrMMUpJ7
 RrdgkTZMFeI5z7ZEcCQSjOnNW+jq7uGLGbiFXegaoLzeg0PMP6Gi+Pn8Ujzzh3Z4KtTdtooUd8r
 YKAMA/0ZPpORcc6eK8ht4RpNdLyLAKinE++Fhkbf4aBz6Ron3X1b6x4GN5KUx2dgUiB5fd5YwZ7
 Jd/km+d6uRmBJWyfxmNgLrP6Aiv7vfVdG
X-Received: by 2002:a05:690c:c747:b0:826:8128:3ba8 with SMTP id
 00721157ae682-8347577f07emr9811477b3.17.1786588849215; Wed, 12 Aug 2026
 19:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260804021441.3054424-1-talesam@gmail.com>
 <c0c50dff0f9b64a2db8e1470d75e450ba35cccde.camel@intel.com>
 <anJZSDD+lmzbaE7b@gsse-cloud1.jf.intel.com>
 <176e54adc75dc9b947caadbf95333df1b60c0240.camel@intel.com>
 <cb06c8e0-0cf8-4dc2-a586-77aafc95f0c0@intel.com>
 <CAHBRX4ErWF0e4X9DCXyycyqJUHaVcv36J=X0PRrNANqZxrzidg@mail.gmail.com>
 <49792f00-d8e3-41c7-ab2d-1d7efe4b5aca@intel.com>
 <CAHBRX4ELrBJcRj-8LLryKT_0Jnc-8R0ZFLc4N4fu6yDb6f=wDQ@mail.gmail.com>
 <3ee610ea-1707-4ab7-b0cf-20852b7c971f@intel.com>
 <CAHBRX4Eqx4WvHjv9-ByNmGiB-eE=GDGy1REZ8LhFKDwa=4Feqw@mail.gmail.com>
 <anvDzcPNwITTsZbu@gsse-cloud1.jf.intel.com>
In-Reply-To: <anvDzcPNwITTsZbu@gsse-cloud1.jf.intel.com>
From: =?UTF-8?B?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Date: Wed, 12 Aug 2026 23:40:38 -0300
X-Gm-Features: AUfX_myJ4sWDbmnGebzO5wHc9HGPmkIZAzgG00olHfr5NWO8YlgZ75qxnVLidvs
Message-ID: <CAHBRX4HK3x0BoaUgayq3J1m6pEKpMAYVD2FiW1Dbg139Zi+EkQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] drm/xe: diagnostics and workaround for GuC TLB
 invalidation ack stalls on ARL
To: Matthew Brost <matthew.brost@intel.com>
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>, 
 "Summers, Stuart" <stuart.summers@intel.com>, 
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Vivi,
 Rodrigo" <rodrigo.vivi@intel.com>, 
 "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>, 
 "Filipchuk, Julia" <julia.filipchuk@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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

> I'd scope this to mirror the i915 W/A.
>
> I don't know enough about the W/A offhand so say, but again I'd just do
> whatever we did on the i915 in Xe.

Done - v2 is out with the Wa_22016122933 implementation mirroring i915:
scoped via an OOB rule to the media GT on media version 13.00, with
coverage modeled on intel_guc_allocate_vma() (CTBs, GuC log, ADS and
SLPC shared data):

https://lore.kernel.org/intel-xe/20260813023016.805573-1-talesam@gmail.com/

Validated on both ARL machines here for several days - details in the
cover letter.

Thanks,
Tales

Em ter., 11 de ago. de 2026 =C3=A0s 21:52, Matthew Brost
<matthew.brost@intel.com> escreveu:
>
> On Sat, Aug 08, 2026 at 06:04:25PM -0300, Tales A. Mendon=C3=A7a wrote:
> > Results: the GT1 cache-line theory is confirmed.
> >
> > With XE_BO_FLAG_NEEDS_UC added to both CTB allocations (blunt version,
> > all GTs), firmware back to stock 70.53.0, same kernel otherwise:
> >
> >   ~6h of my normal workload (sustained load 4-6), ~480k TLB
> >   invalidations per GT processed (per gt stats), ZERO stall events,
> >   ZERO fence timeouts.
>
> Awesome.
>
> >
> > For comparison, yesterday on the same workload (cached CTBs): 14 stalls
> > in the first ~1h45 of use, 59 stalls / 20 timeouts over the day. Every
> > previous kernel reproduced within the first hour, every day, for weeks.
> >
> > So the GuC was replying in time all along - the CPU was reading a stale
> > cache line of the G2H CTB, and the near-constant 2.3s "stall" was just
> > how long the line took to get evicted naturally. That explains the
> > whole signature: H2G direction fine, G2H CTB "empty" at timeout, H2G
> > interrupt kicks unsticking only some episodes, firmware version
> > irrelevant.
> >
> > I am happy to send a proper Wa_22016122933 implementation for xe. Two
> > questions on the preferred shape before I do:
> >
> > 1. Scoping: mirror i915 (media GT only on the affected platforms), or
> >    is there a reason to cover both GTs on MTL/ARL? My blunt test cannot
> >    distinguish - Daniele's decode showed failures only on GT1, but I
> >    applied UC everywhere.
> >
>
> I'd scope this to mirror the i915 W/A.
>
> > 2. Coverage: is the CTB buffer enough, or should the descriptor and/or
> >    the GuC log buffer get the same treatment (wherever the CPU polls
> >    GuC-written memory)?
>
> I don't know enough about the W/A offhand so say, but again I'd just do
> whatever we did on the i915 in Xe.
>
> Matt
>
> >
> > I will keep running the UC kernel and report the full-day numbers, but
> > after weeks of daily reproduction, six hours at zero with ~960k
> > invalidations processed is already a very strong signal.
> >
> > Thanks,
> > Tales
> >
> > Em qui., 6 de ago. de 2026 =C3=A0s 18:13, Daniele Ceraolo Spurio
> > <daniele.ceraolospurio@intel.com> escreveu:
> > >
> > >
> > >
> > > On 8/6/2026 10:36 AM, Tales A. Mendon=C3=A7a wrote:
> > > >> That would definitely help, because if the issue does not happen o=
n i915
> > > >> it likely means that we're missing a WA or something like that in =
Xe.
> > > > Two data points on that, pulling in different directions:
> > > >
> > > > * My second ARL machine (7dd1) has been running i915 for 7 days now=
,
> > > >    with the same GuC 70.53.0, and there is not a single TLB invalid=
ation
> > > >    timeout or GuC error in its logs. Caveat: i915's TLB invalidatio=
n
> > > >    timeout is longer than xe's 2.25s, so short stalls could be sile=
nt
> > > >    there.
> > > >
> > > > * However, Matt just pointed at i915 MTL issue 14469, which looks l=
ike
> > > >    the same problem on i915 - so it may not be xe-specific after al=
l.
> > > >
> > > > If it helps I can also boot i915 on the primary machine (7d51), whe=
re I
> > > > can compare against days of xe statistics on identical workloads.
> > > >
> > > >> Just a bit of a terminology update here, to make sure we're on the=
 same
> > > >> page: we usually refer to the notification you're sending to the G=
uC as
> > > >> an H2G interrupt and not a doorbell.
> > > > Thanks for the correction - I will use H2G interrupt from here on a=
nd
> > > > fix the terminology in v2.
> > > >
> > > >> It feels like when the
> > > >> issue occurs something is stuck in HW rather than GuC FW and trigg=
ering
> > > >> the interrupt causes the HW to get unstuck.
> > > > That fits a pattern I can now see clearly with more data. Since
> > > > enabling the bigger GuC logs (~1.5 days, 35 stalls): 12 stalls were
> > > > unstuck by one of the H2G interrupts within 0.3-1.5s, but 23 ignore=
d
> > > > 8-9 consecutive interrupts and ran to the end. And in those severe
> > > > cases the request-to-ack time is nearly constant: 2.28-2.34s, every
> > > > single time. It does not look like congestion - it looks like a fix=
ed
> > > > internal timeout expiring somewhere and releasing things.
> > > >
> > > > Related: an A/B experiment I ran earlier (holding forcewake across =
the
> > > > whole GT, C6 residency pinned at 0ms for the whole window) still hi=
t 9
> > > > timeouts in a row, so GT-level RC6 avoidance alone does not prevent=
 it.
> > > >
> > > >> Also, would you be able to capture the GuC logs when the issue occ=
urs?
> > > > Done. I rebuilt with the debug-sized log buffers (8M event data / 1=
M
> > > > crash dump / 1M state capture) and xe.guc_log_level=3D3, and the se=
ries'
> > > > patch 1 (devcoredump on TLB invalidation timeout) captures the GuC =
log
> > > > at the exact moment the timeout fires. I attached three devcoredump=
s
> > > > (4-8.7MB each, containing the full GuC log around severe stalls tha=
t
> > > > ignored 8-9 H2G interrupts) to the gitlab issue:
> > > >
> > > >    https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
> > > >
> > > > I have more captures if useful (9 so far).
> > >
> > > Do you happen to have the matching dmesg for those? I decoded the log=
s
> > > but there are thousands of invalidation calls in them; I looked at th=
e
> > > last few but from the GuC POV they've all been handled quickly. Dmesg
> > > error should log exactly which invalidations were delayed from the
> > > driver POV so I can just look at what happens around those.
> > > Also, I have noticed that the failures seems to all be on GT1. On MTL=
,
> > > there is a caching bug on GT1 and we do not implement the WA for that=
 in
> > > Xe (Wa_22016122933). Not sure if this is the actual root cause, but t=
he
> > > fact that it only happens on GT1 makes me suspicious (i.e., it is
> > > possible that the GuC is replying in time but CPU doesn't see the rep=
ly
> > > because the cache-line is not correctly updated, or vice versa). Not
> > > sure if there is an easy way to implement this in Xe to test, that's =
not
> > > really my field of expertise; maybe adding XE_BO_FLAG_FORCE_WC or
> > > XE_BO_FLAG_NEEDS_UC to the CTB allocation could work as a quick hack?
> > > But I'd like either Matt or Thomas to confirm.
> > >
> > > Daniele
> > >
> > > >
> > > >> I have pushed the latest GuC FW for MTL here in case you want to g=
ive it
> > > >> a go:
> > > > Downloaded and staged - I will switch to 70.72.1 via
> > > > xe.guc_firmware_path today and report back with a few days of data
> > > > (this machine currently reproduces 20-35 stalls/day under my normal
> > > > workload, so the signal should be quick).
> > > >
> > > > Thanks,
> > > > Tales
> > > >
> > > > Em ter., 4 de ago. de 2026 =C3=A0s 20:50, Daniele Ceraolo Spurio
> > > > <daniele.ceraolospurio@intel.com> escreveu:
> > > >>
> > > >>
> > > >> On 8/4/2026 4:00 PM, Tales A. Mendon=C3=A7a wrote:
> > > >>>> Are we seeing this on i915?
> > > >>> I have not tested i915 on the affected machines yet - the
> > > >>> instrumentation that measured the stalls (late-ack logging, kick
> > > >>> results) is xe-only, so I have no comparable i915 data. I can boo=
t one
> > > >>> of the ARL machines with i915 for a few days and watch for TLB
> > > >>> invalidation timeouts there, if that data helps.
> > > >> That would definitely help, because if the issue does not happen o=
n i915
> > > >> it likely means that we're missing a WA or something like that in =
Xe.
> > > >>
> > > >>> More generally: both machines here reproduce reliably (~1 stall/h=
our
> > > >>> on a desktop workload, much more under memory pressure), so I am =
happy
> > > >>> to test anything on them - including any GuC build the firmware t=
eam
> > > >>> would like data on.
> > > >>>
> > > >>> On Stuart's masking concern: fully agreed, that is why patch 3 is
> > > >>> marked RFC. Patches 1-2 are pure diagnostics and stand on their o=
wn; I
> > > >>> am fine holding patch 3 until the firmware side has been looked a=
t.
> > > >>> The data point it adds is that a doorbell ring unblocks the ack i=
n the
> > > >>> majority of episodes, while the severe ones ignore 8-9 consecutiv=
e
> > > >>> rings - hopefully that narrows where to look inside the GuC.
> > > >> Just a bit of a terminology update here, to make sure we're on the=
 same
> > > >> page: we usually refer to the notification you're sending to the G=
uC as
> > > >> an H2G interrupt and not a doorbell. I'm making this clarification
> > > >> because the GuC supports a separate per-context notification mecha=
nism
> > > >> that is referred to as doorbell and which we currently do not impl=
ement
> > > >> in neither i915 nor Xe.
> > > >>
> > > >> When receiving the H2G interrupt, the only thing that the GuC does=
 is
> > > >> look into the CTB and process anything in there; however, you've s=
aid
> > > >> that the contents of the H2G CTB are processed immediately, so the
> > > >> follow up interrupt should result in the GuC just bailing out and =
doing
> > > >> nothing because there is no data to process. It feels like when th=
e
> > > >> issue occurs something is stuck in HW rather than GuC FW and trigg=
ering
> > > >> the interrupt causes the HW to get unstuck.
> > > >>
> > > >> I have pushed the latest GuC FW for MTL here in case you want to g=
ive it
> > > >> a go:
> > > >> https://gitlab.com/dceraolo/drm-firmware/-/blob/f783b931555be057da=
fc2400b7eb4d445c953fec/i915/mtl_guc_70.72.1.bin
> > > >> . You can override the GuC firmware used by the driver via the
> > > >> xe.guc_firmware_path modparam; the path is relative to /lib/firmwa=
re/
> > > >> and the firmware needs to be in initramfs for the driver to find i=
t at
> > > >> boot. Note that we haven't tested this image on MTL, so it might h=
ave
> > > >> unexpected results.
> > > >>
> > > >> Also, would you be able to capture the GuC logs when the issue occ=
urs?
> > > >> The default guc log size is relatively small, so you'd have to cap=
ture
> > > >> right when the issue happens. However, you can make them bigger by
> > > >> building the kernel with CONFIG_DRM_XE_DEBUG or by simply modifyin=
g the
> > > >> xe_guc_log.h file to pick the bigger size by default. If you go wi=
th the
> > > >> latter, please also set xe.guc_log_level=3D3 on the command line (=
this is
> > > >> automatically added by the kconfig).
> > > >>
> > > >> Thanks,
> > > >> Daniele
> > > >>
> > > >>> I will send a v2 addressing Matt's review comments (the
> > > >>> __xe_devcoredump unification and the fixes on patch 2).
> > > >>>
> > > >>> Thanks,
> > > >>> Tales
> > > >>>
> > > >>> Em ter., 4 de ago. de 2026 =C3=A0s 19:08, Daniele Ceraolo Spurio
> > > >>> <daniele.ceraolospurio@intel.com> escreveu:
> > > >>>>
> > > >>>> On 8/4/2026 2:33 PM, Summers, Stuart wrote:
> > > >>>>> On Tue, 2026-08-04 at 14:27 -0700, Matthew Brost wrote:
> > > >>>>>> On Tue, Aug 04, 2026 at 03:02:44PM -0600, Summers, Stuart wrot=
e:
> > > >>>>>>> On Mon, 2026-08-03 at 23:14 -0300, Tales A. Mendon=C3=A7a wro=
te:
> > > >>>>>>>> Hi,
> > > >>>>>>>>
> > > >>>>>>>> This series is a follow-up to the TLB invalidation ack stall=
 I
> > > >>>>>>>> have
> > > >>>>>>>> been debugging on ARL, tracked in:
> > > >>>>>>>>
> > > >>>>>>>>      https://gitlab.freedesktop.org/drm/xe/kernel/-/work_ite=
ms/8678
> > > >>>>>>>>
> > > >>>>>>>> Summary of the issue: with GuC 70.53.0 on ARL (reproduced on=
 7d51
> > > >>>>>>>> and
> > > >>>>>>>> 7dd1 machines here, plus an independent Arc Pro 130T report =
on
> > > >>>>>>>> the
> > > >>>>>>>> issue above), TLB invalidation acks intermittently stall for
> > > >>>>>>>> ~2.3s.
> > > >>>>>>>> The H2G request is consumed from the CTB immediately and the=
 G2H
> > > >>>>>>>> CTB
> > > >>>>>>>> is empty the whole time - the firmware simply does not send =
the
> > > >>>>>>>> ack
> > > >>>>>>>> until much later. The fence timeout fires at 2.25s and the a=
ck
> > > >>>>>>>> lands
> > > >>>>>>>> tens of ms after it. Userspace blocked on the invalidation
> > > >>>>>>>> (compositor
> > > >>>>>>>> buffer unmaps etc.) hitches for the full window.
> > > >>>>>>> Firstly, thanks for the patch!
> > > >>>>>>>
> > > >>>>>>> I haven't looked in to all the details of the sighting you we=
re
> > > >>>>>>> debugging, but we have had similar issues that were fixed in =
a
> > > >>>>>>> later
> > > >>>>>>> GuC version. I think around 70.60.0? It might be worth trying=
 on
> > > >>>>>>> something later than that to see if that helps... (+Daniele)
> > > >>>>>>>
> > > >>>>>> I think this would require an AR on our end to make a new firm=
ware
> > > >>>>>> version available.
> > > >>>>>>
> > > >>>>>> The upstream repo only has 70.53.0 available for ARL [1] (iirc=
, ARL
> > > >>>>>> aliases to MTL for firmware). (+Julia too).
> > > >>>>>>
> > > >>>>>> Presumably, the GuC changelogs should indicate whether an issu=
e
> > > >>>>>> related
> > > >>>>>> this has been fixed. If so, we need to update all GuC versions=
 across
> > > >>>>>> both i915 and Xe.
> > > >>>>> Right... I guess I'd still like to see if we can test this in G=
uC (or
> > > >>>>> get confirmation we can't for some reason) before committing so=
mething.
> > > >>>>> My worry is we will prevent bug reports like this by working ar=
ound it
> > > >>>>> and miss critical bugs that need to be fixed in the right compo=
nent.
> > > >>>>>
> > > >>>>>> [1]
> > > >>>>>> https://gitlab.com/kernel-firmware/linux-firmware/-/blob/main/=
i915/mtl_guc_70.bin?ref_type=3Dheads
> > > >>>>>>
> > > >>>>>>>> Patch 1 adds xe_devcoredump_gt() so this kind of hang - whic=
h has
> > > >>>>>>>> no
> > > >>>>>>> Is there a reason we don't just re-use the main xe_devcoredum=
p()?
> > > >>>>>>>
> > > >>>>>> This is my suggestion: the main devcoredump infrastructure is =
job-
> > > >>>>>> based,
> > > >>>>>> so it cannot be used for hangs that are not associated with a =
job.
> > > >>>>>>
> > > >>>>>> In my opinion, this is a gap on our end. Introducing something=
 like
> > > >>>>>> `xe_devcoredump_gt()`, which can be used for non-job-based han=
gs
> > > >>>>>> (e.g.,
> > > >>>>>> TLB invalidation timeouts like those addressed in this series,=
 or
> > > >>>>>> more
> > > >>>>>> generally any GuC protocol hang), makes sense to me.
> > > >>>>> Ok makes sense. We can do that here. It would be nice to have a=
 more
> > > >>>>> inclusive implementation that lets us call this from anywhere s=
o we
> > > >>>>> aren't duplicating things around for different use cases. But n=
ot a
> > > >>>>> blocker here.
> > > >>>>>
> > > >>>>>> I haven't looked at the patch yet, but at a high level, adding
> > > >>>>>> `xe_devcoredump_gt()` seems like a reasonable approach.
> > > >>>>>>
> > > >>>>>>>> exec queue or job to blame - leaves a devcoredump with the G=
uC
> > > >>>>>>>> log
> > > >>>>>>>> and
> > > >>>>>>>> CT state behind (Matt suggested capturing devcoredumps when =
we
> > > >>>>>>>> discussed the issue; devcoredumps from both machines are att=
ached
> > > >>>>>>>> to
> > > >>>>>>>> the issue above).
> > > >>>>>>>>
> > > >>>>>>>> Patch 2 logs when the ack for a timed out invalidation final=
ly
> > > >>>>>>>> arrives. This is what established that the acks are late rat=
her
> > > >>>>>>>> than
> > > >>>>>>>> lost.
> > > >>>>>>>>
> > > >>>>>>>> Patch 3 is the RFC part: a delayed work that pokes the GuC
> > > >>>>>>>> (status
> > > >>>>>>>> register read, CT flush, doorbell ring) every 250ms while an=
 ack
> > > >>>>>>>> is
> > > >>>>>>>> overdue. On my machines this converts the guaranteed 2.3s st=
all
> > > >>>>>>>> into
> > > >>>>>>> I'm a little worried we're just papering over something here =
that
> > > >>>>>>> needs
> > > >>>>>>> to be addressed in GuC, particularly around GT going to sleep=
 or
> > > >>>>>>> something around the time we're expecting a response, so the =
pings
> > > >>>>>>> on
> > > >>>>>>> registers might be prematurely waking things up which is some=
thing
> > > >>>>>>> we'd
> > > >>>>>>> want to happen in GuC, not the KMD.
> > > >>>>>>>
> > > >>>>>> In general, I agree with this. We should avoid papering over t=
he
> > > >>>>>> issue
> > > >>>>>> and instead fix it properly in the GuC. That said, this workar=
ound
> > > >>>>>> provides a pretty strong data point, since it appears to get t=
he TLB
> > > >>>>>> invalidation unstuck.
> > > >>>>> So if we hit this issue I guess we're already going to have som=
e
> > > >>>>> performance degredation and the workaround makes that better. I=
 need to
> > > >>>>> look at the implementation, but we could be potentially introdu=
cing
> > > >>>>> performance penalties in other areas doing these pings.
> > > >>>>>
> > > >>>>> Again, I'd like to see if we can fix this in the right place be=
fore
> > > >>>>> implementing a workaround for it. Hopefully Daniele or Julia ca=
n give
> > > >>>>> some direction there.
> > > >>>> Are we seeing this on i915 at all? Given that Xe does not offici=
ally
> > > >>>> support MTL/ARL and is missing several critical WAs for those pl=
atforms,
> > > >>>> the approach so far has been to only update the GuC FW if it is =
required
> > > >>>> for i915.
> > > >>>> Looking at the GuC release notes, there have been a couple of
> > > >>>> TLB-related fixes after 70.53, but they're both marked as only a=
ffecting
> > > >>>> PVC and Xe2+ platforms, so no fixes seem to be available for ARL=
 (or at
> > > >>>> least they're not listed in the release notes).
> > > >>>>
> > > >>>> Daniele
> > > >>>>
> > > >>>>> Thanks,
> > > >>>>> Stuart
> > > >>>>>
> > > >>>>>> Matt
> > > >>>>>>
> > > >>>>>>> Thanks,
> > > >>>>>>> Stuart
> > > >>>>>>>
> > > >>>>>>>> a
> > > >>>>>>>> sub-500ms hiccup for the majority of occurrences; a minority=
 of
> > > >>>>>>>> severe
> > > >>>>>>>> episodes ignore 8-9 consecutive doorbells, which points at t=
he
> > > >>>>>>>> GuC
> > > >>>>>>>> firmware being internally blocked for the whole window. Full=
 data
> > > >>>>>>>> on
> > > >>>>>>>> the issue. I am happy to rework the approach (different dela=
y,
> > > >>>>>>>> tying it to the G2H handler, dropping the status read, etc.)=
 -
> > > >>>>>>>> mainly
> > > >>>>>>>> I would like the firmware side investigated, since no host-s=
ide
> > > >>>>>>>> poke
> > > >>>>>>>> can fix the severe cases.
> > > >>>>>>>>
> > > >>>>>>>> Based on drm-tip. Tested for several days on both ARL machin=
es
> > > >>>>>>>> under
> > > >>>>>>>> desktop and VM-heavy workloads.
> > > >>>>>>>>
> > > >>>>>>>> Thanks,
> > > >>>>>>>> Tales
> > > >>>>>>>>
> > > >>>>>>>> Tales A. Mendon=C3=A7a (3):
> > > >>>>>>>>      drm/xe: Capture devcoredump on TLB invalidation timeout
> > > >>>>>>>>      drm/xe: Log when a timed out TLB invalidation ack final=
ly
> > > >>>>>>>> arrives
> > > >>>>>>>>      drm/xe: Kick GuC while TLB invalidation acks are overdu=
e
> > > >>>>>>>>
> > > >>>>>>>>     drivers/gpu/drm/xe/xe_devcoredump.c     |  68 ++++++++++=
++
> > > >>>>>>>>     drivers/gpu/drm/xe/xe_devcoredump.h     |   6 ++
> > > >>>>>>>>     drivers/gpu/drm/xe/xe_tlb_inval.c       | 131
> > > >>>>>>>> +++++++++++++++++++++++-
> > > >>>>>>>>     drivers/gpu/drm/xe/xe_tlb_inval_types.h |  42 ++++++++
> > > >>>>>>>>     4 files changed, 243 insertions(+), 4 deletions(-)
> > > >>>>>>>>
> > > >
> > >
> >
> >
> > --
> > Com os cumprimentos,
> >
> > Tales A. Mendon=C3=A7a
> > talesam.org
> > communitybig.org



--=20
Com os cumprimentos,

Tales A. Mendon=C3=A7a
talesam.org
communitybig.org
