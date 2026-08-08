Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCE6C5B560
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:39:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FE0410E697;
	Mon, 10 Aug 2026 06:38:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sJ55MqEB";
	dkim-atps=neutral
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC2BF10E089
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 21:04:37 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-81e69a2db34so10651207b3.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 14:04:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786223077; cv=none;
 d=google.com; s=arc-20260327;
 b=tCBEb9glYjSH8q1buDjTtcWM9td6jYAWt6CLGoM9LuSN+AmzyMiRGH4F9zKFkQpY7E
 t8eJdcF+AR/d0HRpZStSO+XI+KM2CrqyVPKYvTbH4kkFnci/R1rav/49+e1v+d9rw+n8
 lFDoXBwq0fn3rar6WOA4nsBctwsEZK5XZpnOCnpy79oPab+hLhLj0s1Kl1gd3Z7hQL2U
 QEBv+WTbXRaxRO0L5toiSF0hg4tz+Rxr+bN7g7yeXTkezmHWeoSYLfFJicfaXIbXM7Ta
 1iCDebOl8XRJ8EI9daBeUyZ43S4tk6pO33KlDe24QPMr9gDZdrbg3NtGhjk3FZrk2b2n
 WFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rDjrYzYwcjgzAf6gXU53GgLWmrass+anAVqSq/dWIFY=;
 fh=lTM//nYeavBUFxqeoh096zBNfy5q0nZ4yQNDeD2RwEA=;
 b=i2duwA76b6IbD8So/tIrLtoOeUi34PWAksTRkinkt/msJnYpvd7upMOfDRT9e+CYdq
 qic2fZIxzdQVED4SrP8/3P86tMW+Dikw/fK05rKxf30LgtA6GLRzWwaW/IvUUuofq3lG
 c+A0ctD6gv1aG4aBQdUSJyWV6A6puT7s72DMed0c6/2tCX7cip0ALd60BicgDzbT5PAu
 6xI9RVei3BwTtUY90ecKaNScro6Iy1tM4bmXRy9p0mHHoTyoTW9EjA9ty4qmxf05UyJD
 emfQWMzLlaOKrckyQiU1p5TDPpQfy4xgXRfB5opIhyak9ILnxIJOZx3FoY1Hv21KLY0c
 lRbw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786223077; x=1786827877; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rDjrYzYwcjgzAf6gXU53GgLWmrass+anAVqSq/dWIFY=;
 b=sJ55MqEBPPyk8pL7syNDYX8TCs8ws5EQMLBVgVIdQcjNDIGkz0fbnRCKe6phg24Jp6
 B7luKrZPG3ivVDC2/Inh2rH0ci6o8yslxBfxgwwSXwuYPa3bm742sZLS1nxF+XcFcXM0
 8d9eZLMkSf4WL59295gEEjhMV6y8pmrBxX+ktRCQRhLMVFQK54KPRpi+fYihjj18JBXE
 iHyvbMcb1VQg/mbyZPqLEWV9VMlyvmXtjrWXr10fDXFZaWMsTDMnavgH1LWON8leNPkJ
 OD1L5q7wYbwT9FUkj9XjYe7BiJy9p1M9tFFpe8mt0fXYKEaRrfYwOwtjxCrTrBP2FiwY
 budg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786223077; x=1786827877;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rDjrYzYwcjgzAf6gXU53GgLWmrass+anAVqSq/dWIFY=;
 b=PpH5sLRPIAZVjG/ujxEGuGQuc1zYiTUANIVknJK89tVrsUMIMm9+TXHXzzux0Qfehv
 /v5omDEJVJHGpYCSlKVfxjHmQLzIfgjjncW9ipuEEuPeWnkMC9LPME1HRga4UI+KEpoT
 xG8OV4+Nhr0NvSn3P1ulxI8F54odIXGdcCfDuwqvZW9Qc35allUl84bcng6bgSi316x6
 KSxitIxHO/KoJG7sr4Y4DW79UAhNRoc29rInyIziSGlUd2032q7r5IkeNmAeIRQ9HgwI
 DFs2HNJNjhLC7bLHgHC18iCQt+5jz0wMsaUlh2zqBYkFQi5LTJKEV+a0vVG7AyXzGPMh
 iTOg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrvRBA45JsA637EcitL8zJm1MOj+HqQIYc7+h4z0GMu7nKgYwWhvXl8qLDQ4rPN2VhlfWBJ2808QmY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcrWqMeDR4pIpS7jUDHG1g7szjegd0+mqgZtgvkvFqBjsOygWK
 rfMe5BtA5/FcSD6DPw/vvsYqxp/CFCh6Ql2kRwyPIG0x6HuDy7KnNfRSopl/3d6PV1VNJ2H1WBT
 MAJHzyiu6Ylny34//mbydMSdNMYGeNxU=
X-Gm-Gg: AR+sD10itX1WADdzqFSYf8Z6GU0RKh9THHNhEOpZt9mXc3rAs5pHFaIZ10CtGzg7w2m
 9HPNz5NG5hGxKqjggmWuFmhsdq4SVDXL1zLsrjHnE1YT1pp4bDIh/89CUKMp8DUoDJ11C+vyo+6
 vJo/tqb4Pd1W/Q1yu1i+50Y19P5AhlBSD2JMdlirw3KBt2q1cQoxlJGOYpRKX0BtEM6iZAGjafQ
 Z95ZZpbvCPXf1VGG0ieFKdGRIsUuEvzl2wvitnU8gcrUULu3TNvxI/mlaibn0jOFKkpUWgQ2CkM
 xLAQm2srqJy034DmOgzghM2GMKrTFPlfOU2eEqbDGQFSd7hpYS3k/wir8mPnoXqZewJdMFFx2eT
 oCqLBbVuIKqEdGSQ0aSc/AczPZUB0Vv8C
X-Received: by 2002:a05:690c:d0d:b0:81f:2825:de9 with SMTP id
 00721157ae682-82576533d01mr59885797b3.20.1786223076375; Sat, 08 Aug 2026
 14:04:36 -0700 (PDT)
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
In-Reply-To: <3ee610ea-1707-4ab7-b0cf-20852b7c971f@intel.com>
From: =?UTF-8?B?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Date: Sat, 8 Aug 2026 18:04:25 -0300
X-Gm-Features: AUfX_mz7g7XuTYj819Z5uDfLg221WMmvGik02I4KyP7pdJ9uRYspJPQVmWFTUTc
Message-ID: <CAHBRX4Eqx4WvHjv9-ByNmGiB-eE=GDGy1REZ8LhFKDwa=4Feqw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] drm/xe: diagnostics and workaround for GuC TLB
 invalidation ack stalls on ARL
To: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: "Summers, Stuart" <stuart.summers@intel.com>, "Brost,
 Matthew" <matthew.brost@intel.com>, 
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Vivi,
 Rodrigo" <rodrigo.vivi@intel.com>, 
 "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>, 
 "Filipchuk, Julia" <julia.filipchuk@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

Results: the GT1 cache-line theory is confirmed.

With XE_BO_FLAG_NEEDS_UC added to both CTB allocations (blunt version,
all GTs), firmware back to stock 70.53.0, same kernel otherwise:

  ~6h of my normal workload (sustained load 4-6), ~480k TLB
  invalidations per GT processed (per gt stats), ZERO stall events,
  ZERO fence timeouts.

For comparison, yesterday on the same workload (cached CTBs): 14 stalls
in the first ~1h45 of use, 59 stalls / 20 timeouts over the day. Every
previous kernel reproduced within the first hour, every day, for weeks.

So the GuC was replying in time all along - the CPU was reading a stale
cache line of the G2H CTB, and the near-constant 2.3s "stall" was just
how long the line took to get evicted naturally. That explains the
whole signature: H2G direction fine, G2H CTB "empty" at timeout, H2G
interrupt kicks unsticking only some episodes, firmware version
irrelevant.

I am happy to send a proper Wa_22016122933 implementation for xe. Two
questions on the preferred shape before I do:

1. Scoping: mirror i915 (media GT only on the affected platforms), or
   is there a reason to cover both GTs on MTL/ARL? My blunt test cannot
   distinguish - Daniele's decode showed failures only on GT1, but I
   applied UC everywhere.

2. Coverage: is the CTB buffer enough, or should the descriptor and/or
   the GuC log buffer get the same treatment (wherever the CPU polls
   GuC-written memory)?

I will keep running the UC kernel and report the full-day numbers, but
after weeks of daily reproduction, six hours at zero with ~960k
invalidations processed is already a very strong signal.

Thanks,
Tales

Em qui., 6 de ago. de 2026 =C3=A0s 18:13, Daniele Ceraolo Spurio
<daniele.ceraolospurio@intel.com> escreveu:
>
>
>
> On 8/6/2026 10:36 AM, Tales A. Mendon=C3=A7a wrote:
> >> That would definitely help, because if the issue does not happen on i9=
15
> >> it likely means that we're missing a WA or something like that in Xe.
> > Two data points on that, pulling in different directions:
> >
> > * My second ARL machine (7dd1) has been running i915 for 7 days now,
> >    with the same GuC 70.53.0, and there is not a single TLB invalidatio=
n
> >    timeout or GuC error in its logs. Caveat: i915's TLB invalidation
> >    timeout is longer than xe's 2.25s, so short stalls could be silent
> >    there.
> >
> > * However, Matt just pointed at i915 MTL issue 14469, which looks like
> >    the same problem on i915 - so it may not be xe-specific after all.
> >
> > If it helps I can also boot i915 on the primary machine (7d51), where I
> > can compare against days of xe statistics on identical workloads.
> >
> >> Just a bit of a terminology update here, to make sure we're on the sam=
e
> >> page: we usually refer to the notification you're sending to the GuC a=
s
> >> an H2G interrupt and not a doorbell.
> > Thanks for the correction - I will use H2G interrupt from here on and
> > fix the terminology in v2.
> >
> >> It feels like when the
> >> issue occurs something is stuck in HW rather than GuC FW and triggerin=
g
> >> the interrupt causes the HW to get unstuck.
> > That fits a pattern I can now see clearly with more data. Since
> > enabling the bigger GuC logs (~1.5 days, 35 stalls): 12 stalls were
> > unstuck by one of the H2G interrupts within 0.3-1.5s, but 23 ignored
> > 8-9 consecutive interrupts and ran to the end. And in those severe
> > cases the request-to-ack time is nearly constant: 2.28-2.34s, every
> > single time. It does not look like congestion - it looks like a fixed
> > internal timeout expiring somewhere and releasing things.
> >
> > Related: an A/B experiment I ran earlier (holding forcewake across the
> > whole GT, C6 residency pinned at 0ms for the whole window) still hit 9
> > timeouts in a row, so GT-level RC6 avoidance alone does not prevent it.
> >
> >> Also, would you be able to capture the GuC logs when the issue occurs?
> > Done. I rebuilt with the debug-sized log buffers (8M event data / 1M
> > crash dump / 1M state capture) and xe.guc_log_level=3D3, and the series=
'
> > patch 1 (devcoredump on TLB invalidation timeout) captures the GuC log
> > at the exact moment the timeout fires. I attached three devcoredumps
> > (4-8.7MB each, containing the full GuC log around severe stalls that
> > ignored 8-9 H2G interrupts) to the gitlab issue:
> >
> >    https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
> >
> > I have more captures if useful (9 so far).
>
> Do you happen to have the matching dmesg for those? I decoded the logs
> but there are thousands of invalidation calls in them; I looked at the
> last few but from the GuC POV they've all been handled quickly. Dmesg
> error should log exactly which invalidations were delayed from the
> driver POV so I can just look at what happens around those.
> Also, I have noticed that the failures seems to all be on GT1. On MTL,
> there is a caching bug on GT1 and we do not implement the WA for that in
> Xe (Wa_22016122933). Not sure if this is the actual root cause, but the
> fact that it only happens on GT1 makes me suspicious (i.e., it is
> possible that the GuC is replying in time but CPU doesn't see the reply
> because the cache-line is not correctly updated, or vice versa). Not
> sure if there is an easy way to implement this in Xe to test, that's not
> really my field of expertise; maybe adding XE_BO_FLAG_FORCE_WC or
> XE_BO_FLAG_NEEDS_UC to the CTB allocation could work as a quick hack?
> But I'd like either Matt or Thomas to confirm.
>
> Daniele
>
> >
> >> I have pushed the latest GuC FW for MTL here in case you want to give =
it
> >> a go:
> > Downloaded and staged - I will switch to 70.72.1 via
> > xe.guc_firmware_path today and report back with a few days of data
> > (this machine currently reproduces 20-35 stalls/day under my normal
> > workload, so the signal should be quick).
> >
> > Thanks,
> > Tales
> >
> > Em ter., 4 de ago. de 2026 =C3=A0s 20:50, Daniele Ceraolo Spurio
> > <daniele.ceraolospurio@intel.com> escreveu:
> >>
> >>
> >> On 8/4/2026 4:00 PM, Tales A. Mendon=C3=A7a wrote:
> >>>> Are we seeing this on i915?
> >>> I have not tested i915 on the affected machines yet - the
> >>> instrumentation that measured the stalls (late-ack logging, kick
> >>> results) is xe-only, so I have no comparable i915 data. I can boot on=
e
> >>> of the ARL machines with i915 for a few days and watch for TLB
> >>> invalidation timeouts there, if that data helps.
> >> That would definitely help, because if the issue does not happen on i9=
15
> >> it likely means that we're missing a WA or something like that in Xe.
> >>
> >>> More generally: both machines here reproduce reliably (~1 stall/hour
> >>> on a desktop workload, much more under memory pressure), so I am happ=
y
> >>> to test anything on them - including any GuC build the firmware team
> >>> would like data on.
> >>>
> >>> On Stuart's masking concern: fully agreed, that is why patch 3 is
> >>> marked RFC. Patches 1-2 are pure diagnostics and stand on their own; =
I
> >>> am fine holding patch 3 until the firmware side has been looked at.
> >>> The data point it adds is that a doorbell ring unblocks the ack in th=
e
> >>> majority of episodes, while the severe ones ignore 8-9 consecutive
> >>> rings - hopefully that narrows where to look inside the GuC.
> >> Just a bit of a terminology update here, to make sure we're on the sam=
e
> >> page: we usually refer to the notification you're sending to the GuC a=
s
> >> an H2G interrupt and not a doorbell. I'm making this clarification
> >> because the GuC supports a separate per-context notification mechanism
> >> that is referred to as doorbell and which we currently do not implemen=
t
> >> in neither i915 nor Xe.
> >>
> >> When receiving the H2G interrupt, the only thing that the GuC does is
> >> look into the CTB and process anything in there; however, you've said
> >> that the contents of the H2G CTB are processed immediately, so the
> >> follow up interrupt should result in the GuC just bailing out and doin=
g
> >> nothing because there is no data to process. It feels like when the
> >> issue occurs something is stuck in HW rather than GuC FW and triggerin=
g
> >> the interrupt causes the HW to get unstuck.
> >>
> >> I have pushed the latest GuC FW for MTL here in case you want to give =
it
> >> a go:
> >> https://gitlab.com/dceraolo/drm-firmware/-/blob/f783b931555be057dafc24=
00b7eb4d445c953fec/i915/mtl_guc_70.72.1.bin
> >> . You can override the GuC firmware used by the driver via the
> >> xe.guc_firmware_path modparam; the path is relative to /lib/firmware/
> >> and the firmware needs to be in initramfs for the driver to find it at
> >> boot. Note that we haven't tested this image on MTL, so it might have
> >> unexpected results.
> >>
> >> Also, would you be able to capture the GuC logs when the issue occurs?
> >> The default guc log size is relatively small, so you'd have to capture
> >> right when the issue happens. However, you can make them bigger by
> >> building the kernel with CONFIG_DRM_XE_DEBUG or by simply modifying th=
e
> >> xe_guc_log.h file to pick the bigger size by default. If you go with t=
he
> >> latter, please also set xe.guc_log_level=3D3 on the command line (this=
 is
> >> automatically added by the kconfig).
> >>
> >> Thanks,
> >> Daniele
> >>
> >>> I will send a v2 addressing Matt's review comments (the
> >>> __xe_devcoredump unification and the fixes on patch 2).
> >>>
> >>> Thanks,
> >>> Tales
> >>>
> >>> Em ter., 4 de ago. de 2026 =C3=A0s 19:08, Daniele Ceraolo Spurio
> >>> <daniele.ceraolospurio@intel.com> escreveu:
> >>>>
> >>>> On 8/4/2026 2:33 PM, Summers, Stuart wrote:
> >>>>> On Tue, 2026-08-04 at 14:27 -0700, Matthew Brost wrote:
> >>>>>> On Tue, Aug 04, 2026 at 03:02:44PM -0600, Summers, Stuart wrote:
> >>>>>>> On Mon, 2026-08-03 at 23:14 -0300, Tales A. Mendon=C3=A7a wrote:
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>> This series is a follow-up to the TLB invalidation ack stall I
> >>>>>>>> have
> >>>>>>>> been debugging on ARL, tracked in:
> >>>>>>>>
> >>>>>>>>      https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8=
678
> >>>>>>>>
> >>>>>>>> Summary of the issue: with GuC 70.53.0 on ARL (reproduced on 7d5=
1
> >>>>>>>> and
> >>>>>>>> 7dd1 machines here, plus an independent Arc Pro 130T report on
> >>>>>>>> the
> >>>>>>>> issue above), TLB invalidation acks intermittently stall for
> >>>>>>>> ~2.3s.
> >>>>>>>> The H2G request is consumed from the CTB immediately and the G2H
> >>>>>>>> CTB
> >>>>>>>> is empty the whole time - the firmware simply does not send the
> >>>>>>>> ack
> >>>>>>>> until much later. The fence timeout fires at 2.25s and the ack
> >>>>>>>> lands
> >>>>>>>> tens of ms after it. Userspace blocked on the invalidation
> >>>>>>>> (compositor
> >>>>>>>> buffer unmaps etc.) hitches for the full window.
> >>>>>>> Firstly, thanks for the patch!
> >>>>>>>
> >>>>>>> I haven't looked in to all the details of the sighting you were
> >>>>>>> debugging, but we have had similar issues that were fixed in a
> >>>>>>> later
> >>>>>>> GuC version. I think around 70.60.0? It might be worth trying on
> >>>>>>> something later than that to see if that helps... (+Daniele)
> >>>>>>>
> >>>>>> I think this would require an AR on our end to make a new firmware
> >>>>>> version available.
> >>>>>>
> >>>>>> The upstream repo only has 70.53.0 available for ARL [1] (iirc, AR=
L
> >>>>>> aliases to MTL for firmware). (+Julia too).
> >>>>>>
> >>>>>> Presumably, the GuC changelogs should indicate whether an issue
> >>>>>> related
> >>>>>> this has been fixed. If so, we need to update all GuC versions acr=
oss
> >>>>>> both i915 and Xe.
> >>>>> Right... I guess I'd still like to see if we can test this in GuC (=
or
> >>>>> get confirmation we can't for some reason) before committing someth=
ing.
> >>>>> My worry is we will prevent bug reports like this by working around=
 it
> >>>>> and miss critical bugs that need to be fixed in the right component=
.
> >>>>>
> >>>>>> [1]
> >>>>>> https://gitlab.com/kernel-firmware/linux-firmware/-/blob/main/i915=
/mtl_guc_70.bin?ref_type=3Dheads
> >>>>>>
> >>>>>>>> Patch 1 adds xe_devcoredump_gt() so this kind of hang - which ha=
s
> >>>>>>>> no
> >>>>>>> Is there a reason we don't just re-use the main xe_devcoredump()?
> >>>>>>>
> >>>>>> This is my suggestion: the main devcoredump infrastructure is job-
> >>>>>> based,
> >>>>>> so it cannot be used for hangs that are not associated with a job.
> >>>>>>
> >>>>>> In my opinion, this is a gap on our end. Introducing something lik=
e
> >>>>>> `xe_devcoredump_gt()`, which can be used for non-job-based hangs
> >>>>>> (e.g.,
> >>>>>> TLB invalidation timeouts like those addressed in this series, or
> >>>>>> more
> >>>>>> generally any GuC protocol hang), makes sense to me.
> >>>>> Ok makes sense. We can do that here. It would be nice to have a mor=
e
> >>>>> inclusive implementation that lets us call this from anywhere so we
> >>>>> aren't duplicating things around for different use cases. But not a
> >>>>> blocker here.
> >>>>>
> >>>>>> I haven't looked at the patch yet, but at a high level, adding
> >>>>>> `xe_devcoredump_gt()` seems like a reasonable approach.
> >>>>>>
> >>>>>>>> exec queue or job to blame - leaves a devcoredump with the GuC
> >>>>>>>> log
> >>>>>>>> and
> >>>>>>>> CT state behind (Matt suggested capturing devcoredumps when we
> >>>>>>>> discussed the issue; devcoredumps from both machines are attache=
d
> >>>>>>>> to
> >>>>>>>> the issue above).
> >>>>>>>>
> >>>>>>>> Patch 2 logs when the ack for a timed out invalidation finally
> >>>>>>>> arrives. This is what established that the acks are late rather
> >>>>>>>> than
> >>>>>>>> lost.
> >>>>>>>>
> >>>>>>>> Patch 3 is the RFC part: a delayed work that pokes the GuC
> >>>>>>>> (status
> >>>>>>>> register read, CT flush, doorbell ring) every 250ms while an ack
> >>>>>>>> is
> >>>>>>>> overdue. On my machines this converts the guaranteed 2.3s stall
> >>>>>>>> into
> >>>>>>> I'm a little worried we're just papering over something here that
> >>>>>>> needs
> >>>>>>> to be addressed in GuC, particularly around GT going to sleep or
> >>>>>>> something around the time we're expecting a response, so the ping=
s
> >>>>>>> on
> >>>>>>> registers might be prematurely waking things up which is somethin=
g
> >>>>>>> we'd
> >>>>>>> want to happen in GuC, not the KMD.
> >>>>>>>
> >>>>>> In general, I agree with this. We should avoid papering over the
> >>>>>> issue
> >>>>>> and instead fix it properly in the GuC. That said, this workaround
> >>>>>> provides a pretty strong data point, since it appears to get the T=
LB
> >>>>>> invalidation unstuck.
> >>>>> So if we hit this issue I guess we're already going to have some
> >>>>> performance degredation and the workaround makes that better. I nee=
d to
> >>>>> look at the implementation, but we could be potentially introducing
> >>>>> performance penalties in other areas doing these pings.
> >>>>>
> >>>>> Again, I'd like to see if we can fix this in the right place before
> >>>>> implementing a workaround for it. Hopefully Daniele or Julia can gi=
ve
> >>>>> some direction there.
> >>>> Are we seeing this on i915 at all? Given that Xe does not officially
> >>>> support MTL/ARL and is missing several critical WAs for those platfo=
rms,
> >>>> the approach so far has been to only update the GuC FW if it is requ=
ired
> >>>> for i915.
> >>>> Looking at the GuC release notes, there have been a couple of
> >>>> TLB-related fixes after 70.53, but they're both marked as only affec=
ting
> >>>> PVC and Xe2+ platforms, so no fixes seem to be available for ARL (or=
 at
> >>>> least they're not listed in the release notes).
> >>>>
> >>>> Daniele
> >>>>
> >>>>> Thanks,
> >>>>> Stuart
> >>>>>
> >>>>>> Matt
> >>>>>>
> >>>>>>> Thanks,
> >>>>>>> Stuart
> >>>>>>>
> >>>>>>>> a
> >>>>>>>> sub-500ms hiccup for the majority of occurrences; a minority of
> >>>>>>>> severe
> >>>>>>>> episodes ignore 8-9 consecutive doorbells, which points at the
> >>>>>>>> GuC
> >>>>>>>> firmware being internally blocked for the whole window. Full dat=
a
> >>>>>>>> on
> >>>>>>>> the issue. I am happy to rework the approach (different delay,
> >>>>>>>> tying it to the G2H handler, dropping the status read, etc.) -
> >>>>>>>> mainly
> >>>>>>>> I would like the firmware side investigated, since no host-side
> >>>>>>>> poke
> >>>>>>>> can fix the severe cases.
> >>>>>>>>
> >>>>>>>> Based on drm-tip. Tested for several days on both ARL machines
> >>>>>>>> under
> >>>>>>>> desktop and VM-heavy workloads.
> >>>>>>>>
> >>>>>>>> Thanks,
> >>>>>>>> Tales
> >>>>>>>>
> >>>>>>>> Tales A. Mendon=C3=A7a (3):
> >>>>>>>>      drm/xe: Capture devcoredump on TLB invalidation timeout
> >>>>>>>>      drm/xe: Log when a timed out TLB invalidation ack finally
> >>>>>>>> arrives
> >>>>>>>>      drm/xe: Kick GuC while TLB invalidation acks are overdue
> >>>>>>>>
> >>>>>>>>     drivers/gpu/drm/xe/xe_devcoredump.c     |  68 ++++++++++++
> >>>>>>>>     drivers/gpu/drm/xe/xe_devcoredump.h     |   6 ++
> >>>>>>>>     drivers/gpu/drm/xe/xe_tlb_inval.c       | 131
> >>>>>>>> +++++++++++++++++++++++-
> >>>>>>>>     drivers/gpu/drm/xe/xe_tlb_inval_types.h |  42 ++++++++
> >>>>>>>>     4 files changed, 243 insertions(+), 4 deletions(-)
> >>>>>>>>
> >
>


--=20
Com os cumprimentos,

Tales A. Mendon=C3=A7a
talesam.org
communitybig.org
