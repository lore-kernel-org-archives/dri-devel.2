Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C17DC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:24:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC5A710ED44;
	Wed,  5 Aug 2026 07:24:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X00Ud3K+";
	dkim-atps=neutral
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09C1110E10F
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 23:00:20 +0000 (UTC)
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-667923d86a7so756100d50.0
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 16:00:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785884419; cv=none;
 d=google.com; s=arc-20260327;
 b=OdqRqKg3GTWrdyOB+h30xxGpddv6nwGAUmWOrOYkDL6cL3KWDxSKDTLIIRU1BMpegT
 t3I4vdurAjTRDpxvMqCn7OBXb0kkIwodmCp5z7FOFmwkdyc2wCJ2h81rhIexgiUjbFMC
 1eMd2toA4OszjitzzNs6VJHSGyV+XDMOEDwtH8DZS7gr6hMsInmzKCssacQAlJKhcKeO
 xge9h3m/6iA5vzyB6461DF+316GwAFmopC2pzHwcY3Xw7FR+A7Z3ufDmRGofgtO2+cJJ
 lUyvJ/idHh1It8I2gT622UHK2zP30SPOPAxWo3jCJCVTGfqm5v3msNn9TBwMv2E3Q6+h
 cwTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=An314FrVXAD/aHWd9TcdfGjVphqZ+lKVIi1qm1zLpn4=;
 fh=QE3ADDHG2p2wRumxj2EVFXGqv7nCin/CQKttxK4403w=;
 b=jL40ySRJTPYvotJ1toWzHeAOFBfNJ9tUXFxkr75mjekReitBOra5pwUSMI/3iGhQQY
 KTeyUzXkUMXlwbygxu8+gF2PbJhff7vcsRDky8F9z+dEpOinlUns78EvamVkXR5N9QwU
 PFE08fQI90M0zbh2O6tfqIq6Qt5TgHLtYFrKZjxfij0qzLva0ub0IucXdHkBl/65DgMm
 4U1MXM2jVkQ4UiRiLixPX9fRKL09TZeB4bSYaD3BuP64yP3eAC8F4dJKPIMwRLSxEho5
 WDw/dZfxI7r+5LaMxI8o2KsuP1weqNvzi6+fTjzr0McVYwYR1GZ839t5Kf2HeVjpHXCA
 DVNQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785884419; x=1786489219; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=An314FrVXAD/aHWd9TcdfGjVphqZ+lKVIi1qm1zLpn4=;
 b=X00Ud3K+F3WaLL5AXy+O/6eapyP8Cr/ZQdnHCHk1vaEFaw/7CLOp8agXaFOJwdvYB8
 Nd0Yvb0DaWaiwMVn1f+hZYyEMbBB0tmljNnI/2uDYlPpn718nr5j4PZblBS10GcqQCVs
 hBwTDBbu+LeEQOAL35qq/7sNmHN7kP+gAy6NeYwF6GAylrktzbehwrYC19THJONSxBWf
 KD+knU4O8cf27yw6j5WyBSPgvZLqE4yf4UZjhidcvRAKC/lcMs8vsWHrzaYHQhienTTQ
 TkZqmkdBfbcIK+qbV81FG7QrbdGJ3DEWX2LRNLUPUW/7rL6q7JVSYOvJbHomqEa0hgay
 QbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785884419; x=1786489219;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=An314FrVXAD/aHWd9TcdfGjVphqZ+lKVIi1qm1zLpn4=;
 b=MYcdpfLxnUILnIBji/TjQhaCI8Gal68auiAqu/WM8my8hL5kyVH5vaDBQMRlRQ7TzC
 XJ2/9meI6fcwgDtOIyTgjBBq2TkxZ4Tf0q8KUH0zG51YBK7CU31dGLJZCTP4qee9oD+e
 TtlWb50m3FccC/kbw+VKqr7G0OC1scSKc9nsnPKLmLgprLJHkhFoh1/iSjpE41xRa9nw
 k+ahXYiH6Yk9tGBHoGnzHOPiOyfn/2PscS0Ztc7eosrRmjz7FPHK7qZqQRmBbGZsLN5v
 GklaUxrtCzQOaUxy3LmZLB/Bpa9BT2oJNkyW+ZVYnXJwRJQos1HNS9xTJd8Q+U9+wHc9
 FrKA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqrDLOL/2rCPTDpfdx7Rhpg8pSYipzyF4WIwSaTJvtZUjS95Xt2jjld38znIAE4t9wWajEClHXJS7c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjRAzeMm+nHzBmdPc4Hh9pfkox4XCe4OCg3zfq9713qxbzzT5N
 EddtvJfq3BkiR8SJ7gTXFLa7osbRTdHgFtJXBDrQQ2yacArSfazOKcnkPJdUZH1ld/MDEwXBcAd
 J/g2Dgv6F94tkJh8ukiGbwNidpapqH9M=
X-Gm-Gg: AR+sD11hOxGY44Hdan5aNCLtAswB8sAIvTPLD6afUFmRbcTo/0i3UuojjgcF83TvX9U
 KH2OwvlvCSZaAKzxFKAvZI83+cn2tyJG5dWCqP1bddsA+bh7G7hWOugTEVxejdUmkhM9GeJQlWJ
 UfVXe/5ZSvVxYoNbzX73IQYc6a/AT6VsI3jyjLftxxZXqEwXN14vmPOF0xIVvFNhHWkrUtATJzJ
 TI807XeS3pucBNJ2qkBOf9uueaH6ZUqjjZj8ghb81hgvuJNHlI0VfbGVzBVt7jiwvgDD/AaoLaS
 6dMYAAj36Gt8wSGgx6alAHllsvFh+U96ECViExQaMi86xVyE8ANBOPIg8BH6AtFDdal+X/ylVtB
 0xXmCh7reZQ3K7Qw1IBcKxz3snv9ZlA==
X-Received: by 2002:a05:690e:4444:b0:668:99c8:bee7 with SMTP id
 956f58d0204a3-6699a1a5a71mr1256001d50.17.1785884418463; Tue, 04 Aug 2026
 16:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260804021441.3054424-1-talesam@gmail.com>
 <c0c50dff0f9b64a2db8e1470d75e450ba35cccde.camel@intel.com>
 <anJZSDD+lmzbaE7b@gsse-cloud1.jf.intel.com>
 <176e54adc75dc9b947caadbf95333df1b60c0240.camel@intel.com>
 <cb06c8e0-0cf8-4dc2-a586-77aafc95f0c0@intel.com>
In-Reply-To: <cb06c8e0-0cf8-4dc2-a586-77aafc95f0c0@intel.com>
From: =?UTF-8?B?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Date: Tue, 4 Aug 2026 20:00:06 -0300
X-Gm-Features: AUfX_mxQ8No64h3GXrFjgLDGL6PnlXymZvjU6-yP3-jsVXVZwB6EON_gjwL4y-Y
Message-ID: <CAHBRX4ErWF0e4X9DCXyycyqJUHaVcv36J=X0PRrNANqZxrzidg@mail.gmail.com>
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
X-Mailman-Approved-At: Wed, 05 Aug 2026 07:24:24 +0000
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

> Are we seeing this on i915?

I have not tested i915 on the affected machines yet - the
instrumentation that measured the stalls (late-ack logging, kick
results) is xe-only, so I have no comparable i915 data. I can boot one
of the ARL machines with i915 for a few days and watch for TLB
invalidation timeouts there, if that data helps.

More generally: both machines here reproduce reliably (~1 stall/hour
on a desktop workload, much more under memory pressure), so I am happy
to test anything on them - including any GuC build the firmware team
would like data on.

On Stuart's masking concern: fully agreed, that is why patch 3 is
marked RFC. Patches 1-2 are pure diagnostics and stand on their own; I
am fine holding patch 3 until the firmware side has been looked at.
The data point it adds is that a doorbell ring unblocks the ack in the
majority of episodes, while the severe ones ignore 8-9 consecutive
rings - hopefully that narrows where to look inside the GuC.

I will send a v2 addressing Matt's review comments (the
__xe_devcoredump unification and the fixes on patch 2).

Thanks,
Tales

Em ter., 4 de ago. de 2026 =C3=A0s 19:08, Daniele Ceraolo Spurio
<daniele.ceraolospurio@intel.com> escreveu:
>
>
>
> On 8/4/2026 2:33 PM, Summers, Stuart wrote:
> > On Tue, 2026-08-04 at 14:27 -0700, Matthew Brost wrote:
> >> On Tue, Aug 04, 2026 at 03:02:44PM -0600, Summers, Stuart wrote:
> >>> On Mon, 2026-08-03 at 23:14 -0300, Tales A. Mendon=C3=A7a wrote:
> >>>> Hi,
> >>>>
> >>>> This series is a follow-up to the TLB invalidation ack stall I
> >>>> have
> >>>> been debugging on ARL, tracked in:
> >>>>
> >>>>    https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
> >>>>
> >>>> Summary of the issue: with GuC 70.53.0 on ARL (reproduced on 7d51
> >>>> and
> >>>> 7dd1 machines here, plus an independent Arc Pro 130T report on
> >>>> the
> >>>> issue above), TLB invalidation acks intermittently stall for
> >>>> ~2.3s.
> >>>> The H2G request is consumed from the CTB immediately and the G2H
> >>>> CTB
> >>>> is empty the whole time - the firmware simply does not send the
> >>>> ack
> >>>> until much later. The fence timeout fires at 2.25s and the ack
> >>>> lands
> >>>> tens of ms after it. Userspace blocked on the invalidation
> >>>> (compositor
> >>>> buffer unmaps etc.) hitches for the full window.
> >>> Firstly, thanks for the patch!
> >>>
> >>> I haven't looked in to all the details of the sighting you were
> >>> debugging, but we have had similar issues that were fixed in a
> >>> later
> >>> GuC version. I think around 70.60.0? It might be worth trying on
> >>> something later than that to see if that helps... (+Daniele)
> >>>
> >> I think this would require an AR on our end to make a new firmware
> >> version available.
> >>
> >> The upstream repo only has 70.53.0 available for ARL [1] (iirc, ARL
> >> aliases to MTL for firmware). (+Julia too).
> >>
> >> Presumably, the GuC changelogs should indicate whether an issue
> >> related
> >> this has been fixed. If so, we need to update all GuC versions across
> >> both i915 and Xe.
> > Right... I guess I'd still like to see if we can test this in GuC (or
> > get confirmation we can't for some reason) before committing something.
> > My worry is we will prevent bug reports like this by working around it
> > and miss critical bugs that need to be fixed in the right component.
> >
> >> [1]
> >> https://gitlab.com/kernel-firmware/linux-firmware/-/blob/main/i915/mtl=
_guc_70.bin?ref_type=3Dheads
> >>
> >>>> Patch 1 adds xe_devcoredump_gt() so this kind of hang - which has
> >>>> no
> >>> Is there a reason we don't just re-use the main xe_devcoredump()?
> >>>
> >> This is my suggestion: the main devcoredump infrastructure is job-
> >> based,
> >> so it cannot be used for hangs that are not associated with a job.
> >>
> >> In my opinion, this is a gap on our end. Introducing something like
> >> `xe_devcoredump_gt()`, which can be used for non-job-based hangs
> >> (e.g.,
> >> TLB invalidation timeouts like those addressed in this series, or
> >> more
> >> generally any GuC protocol hang), makes sense to me.
> > Ok makes sense. We can do that here. It would be nice to have a more
> > inclusive implementation that lets us call this from anywhere so we
> > aren't duplicating things around for different use cases. But not a
> > blocker here.
> >
> >> I haven't looked at the patch yet, but at a high level, adding
> >> `xe_devcoredump_gt()` seems like a reasonable approach.
> >>
> >>>> exec queue or job to blame - leaves a devcoredump with the GuC
> >>>> log
> >>>> and
> >>>> CT state behind (Matt suggested capturing devcoredumps when we
> >>>> discussed the issue; devcoredumps from both machines are attached
> >>>> to
> >>>> the issue above).
> >>>>
> >>>> Patch 2 logs when the ack for a timed out invalidation finally
> >>>> arrives. This is what established that the acks are late rather
> >>>> than
> >>>> lost.
> >>>>
> >>>> Patch 3 is the RFC part: a delayed work that pokes the GuC
> >>>> (status
> >>>> register read, CT flush, doorbell ring) every 250ms while an ack
> >>>> is
> >>>> overdue. On my machines this converts the guaranteed 2.3s stall
> >>>> into
> >>> I'm a little worried we're just papering over something here that
> >>> needs
> >>> to be addressed in GuC, particularly around GT going to sleep or
> >>> something around the time we're expecting a response, so the pings
> >>> on
> >>> registers might be prematurely waking things up which is something
> >>> we'd
> >>> want to happen in GuC, not the KMD.
> >>>
> >> In general, I agree with this. We should avoid papering over the
> >> issue
> >> and instead fix it properly in the GuC. That said, this workaround
> >> provides a pretty strong data point, since it appears to get the TLB
> >> invalidation unstuck.
> > So if we hit this issue I guess we're already going to have some
> > performance degredation and the workaround makes that better. I need to
> > look at the implementation, but we could be potentially introducing
> > performance penalties in other areas doing these pings.
> >
> > Again, I'd like to see if we can fix this in the right place before
> > implementing a workaround for it. Hopefully Daniele or Julia can give
> > some direction there.
>
> Are we seeing this on i915 at all? Given that Xe does not officially
> support MTL/ARL and is missing several critical WAs for those platforms,
> the approach so far has been to only update the GuC FW if it is required
> for i915.
> Looking at the GuC release notes, there have been a couple of
> TLB-related fixes after 70.53, but they're both marked as only affecting
> PVC and Xe2+ platforms, so no fixes seem to be available for ARL (or at
> least they're not listed in the release notes).
>
> Daniele
>
> >
> > Thanks,
> > Stuart
> >
> >> Matt
> >>
> >>> Thanks,
> >>> Stuart
> >>>
> >>>> a
> >>>> sub-500ms hiccup for the majority of occurrences; a minority of
> >>>> severe
> >>>> episodes ignore 8-9 consecutive doorbells, which points at the
> >>>> GuC
> >>>> firmware being internally blocked for the whole window. Full data
> >>>> on
> >>>> the issue. I am happy to rework the approach (different delay,
> >>>> tying it to the G2H handler, dropping the status read, etc.) -
> >>>> mainly
> >>>> I would like the firmware side investigated, since no host-side
> >>>> poke
> >>>> can fix the severe cases.
> >>>>
> >>>> Based on drm-tip. Tested for several days on both ARL machines
> >>>> under
> >>>> desktop and VM-heavy workloads.
> >>>>
> >>>> Thanks,
> >>>> Tales
> >>>>
> >>>> Tales A. Mendon=C3=A7a (3):
> >>>>    drm/xe: Capture devcoredump on TLB invalidation timeout
> >>>>    drm/xe: Log when a timed out TLB invalidation ack finally
> >>>> arrives
> >>>>    drm/xe: Kick GuC while TLB invalidation acks are overdue
> >>>>
> >>>>   drivers/gpu/drm/xe/xe_devcoredump.c     |  68 ++++++++++++
> >>>>   drivers/gpu/drm/xe/xe_devcoredump.h     |   6 ++
> >>>>   drivers/gpu/drm/xe/xe_tlb_inval.c       | 131
> >>>> +++++++++++++++++++++++-
> >>>>   drivers/gpu/drm/xe/xe_tlb_inval_types.h |  42 ++++++++
> >>>>   4 files changed, 243 insertions(+), 4 deletions(-)
> >>>>
>


--=20
Com os cumprimentos,

Tales A. Mendon=C3=A7a
talesam.org
communitybig.org
