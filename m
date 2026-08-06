Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0BCC5ACA8
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1013710F367;
	Fri,  7 Aug 2026 06:47:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qG5g/jhW";
	dkim-atps=neutral
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD76E10F27A
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 17:37:56 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-8200b55dc47so34221487b3.3
 for <dri-devel@lists.freedesktop.org>; Thu, 06 Aug 2026 10:37:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786037876; cv=none;
 d=google.com; s=arc-20260327;
 b=gzZZCgA2IR1V1s7alrnv005Yr5y05Uotv6lx1PJ8DUWMPVlt0xWTiFII/bbQzbuO+Y
 rRuGPpa896xYikaesNSZ8cFIJ8tlk2Zbp1nfs1Khr8BwZdJOg2pzX62fhAUmBxxoH+jy
 j4WXY6i8iCXKHB8yLCJTRB8AfoipCNAfAJSJllkdvRCWg0CTlW2re73n7R71tMn8W6qK
 qx9EDrh/Fzt9UjC12qNTaAKBfjFeKwJ/GRg5PdWBIiPadf+ErLR26GzD5VqWnsfWE2mx
 3lVcvV2sHT2SUoZHSVFBu6JWPAKWTXrQBZNwRrxds+NjqXgztuW70cldNstArwuxZNwd
 WYcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=D8kpHb54C2TKax53/YGs9dz5FGU1BqIxSNHBWOKdGh4=;
 fh=rjVtj1aWP+5XhX0PeVQJXSZ8HQWFCxagqHmGkq0Z0us=;
 b=SagSq804C0hxcOwPCYlJULQ3T8jzxnGUDlD/sHsxFA/Kk5tMp9QsG5AwL/DQbwrCy4
 STl9kjZHsIVUA7IqP3bLccgk9xzJv6YRVlEtR/mHmAvdjFz4VwpxU/WPXwZXBnsb86w+
 AAy8yFJ34wrMVSf+CfGCpYIrDDgtswh1GVFGOZUcoITwSX0+/Jw0it7aHqsYqHX3R8C1
 HZoEunNapoj1devCwbqeyngQUNhVV1dktHZiC69CNJzxGIq9ezHrUHuecXTerY1y6lBj
 +q35gQB8MFtqI7ioqtKaaEC1WV7KWu2M9ssRD/P4jdF5gXV30iN75wkfxvDhrKKZJk2L
 eYSQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786037876; x=1786642676; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D8kpHb54C2TKax53/YGs9dz5FGU1BqIxSNHBWOKdGh4=;
 b=qG5g/jhWIuwHmFn7SN+kjgrB/FkQZeisoBkm/yXUV/hQBSAI1iVh9Un96Md3rY0h0z
 NO+JKS1YtsaYdWWD0ZcwsPs5+1do3ND5kgurVX8IEG0kb6eZEi2TSwCL5Wy6yl4b2SlU
 yhgpmF0OftwEYZnCh2VZzjhIqaV7CIHle5WaOhg5ePUhaowK4E7wPn4U2YcBJzmLlHVc
 2ediRzlBmpZlcTyeN//I5A/6SxIUPup9EZVYBfCWjz+vtjlO5xFueIjFuh9g/tV9inKY
 wA/f/3/CI1WmqQSQlp5F8j5+76q2x73Ozn9gfVtHup+qI/DLd4NmaA8yIwZRGUQD8VHE
 I6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786037876; x=1786642676;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D8kpHb54C2TKax53/YGs9dz5FGU1BqIxSNHBWOKdGh4=;
 b=GqIJUnYmbekN0Pefk+Gz4EAfDHSY1tuF2haYAINhRjHBME2uFlrhnABRswmpbbTsaU
 CNO6JGJQV3ftBqsJIHFhcayq32khZxsWv4ZzoAY/xQFoJvkVWneCbKOMdhDoHeENrk5Y
 HIdpy7udn+y4LqmhQMs2ZwsxTpCluNXuaxt9DiKhsVK42Vv9yxqpwBEl+BanUE/RJX/m
 sTlxUijdIE0XghzKc9/JsbYh/acRs0M7IWYD1Ksc/RFut31qljB6IwIcXWTE60oJKUcO
 3vP/h3tVYQOUOIXdQo+hHnT4XGfOyLdpZ3QN/wYQ15YqIfWucR/SAZWCFZoN3IFHjaEP
 GxWA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoiTt01pBbyJB4ESvIAkFfqhK9mHgVE3wo0nytczRDF5xuEsm1kaarSLH0wzAJqEuyV02asW4BJpq4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzD5dO4IPy8d39hkjHtHUgiGxBe5Rlu8OgVLeOxKZiUWpTEt4hY
 h2QT2na0VypQyCIxXdCvMjrDAc5jrOSz5RwTKQgQgUrOPfl+cbQXFCIJNGBjvwJxYHe1uGXqoth
 NIRlOTDFjcDFpW/roeCGpkZVsnrUaZ9qgBI2y
X-Gm-Gg: AR+sD108py33diu6OUMFaoEp31XkG8/mgUbGsrA6YjNwzR7aHCdRSNPu5u/oIX/TGtG
 z5xYz46Zxz2G1chQW0Sm67GunWS9abAh29nbbjlHr+Rlc0hK9e7HLgBYryeEuq8cxOTf8Gb7kBW
 o2Gab7VQbfe0WqbTmStJHle4z5uD6QZBlZMfW2DSFai9nmvmX8QV7WkIjySXtLXFAc3ofkJz9Sg
 IUqnKljrKjWralgzg+dOFLnt/hZX9PYIj6EJAzSsUp8Y83mheqOQBr/4s8kp2uK6mc678gZRQ4G
 TOV86nOmeaJ4lwRM1UpfaD2DdcA/+EVob49Idkc+7Ozk/YnZ0Fg78jr1EshsBLPTD8qZRtNjp/0
 BlE5g885IkswT15qwg4EqTE4hA/YHFOHE
X-Received: by 2002:a05:690c:6c02:b0:81d:4174:6818 with SMTP id
 00721157ae682-820222e4c47mr102819147b3.13.1786037875675; Thu, 06 Aug 2026
 10:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260804021441.3054424-1-talesam@gmail.com>
 <CAHBRX4GYEKniGb8jw-h=QYPi=FpbWRKwHHnfw-K5wYiy6AWfJA@mail.gmail.com>
 <anJZt4PzCE5t49Qg@gsse-cloud1.jf.intel.com>
 <anOcGqIyrA8LUHo/@gsse-cloud1.jf.intel.com>
In-Reply-To: <anOcGqIyrA8LUHo/@gsse-cloud1.jf.intel.com>
From: =?UTF-8?B?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Date: Thu, 6 Aug 2026 14:37:43 -0300
X-Gm-Features: AUfX_mzrBTONbYkxayjN2V6P4s7xW31SjVn7RfCgKTHZVTLxDuKWK5ijAujO2r4
Message-ID: <CAHBRX4FpsT3CwSrpbLA7dUEpasJOFJxdHTNkU7W81RcQw50AOg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] drm/xe: diagnostics and workaround for GuC TLB
 invalidation ack stalls on ARL
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, thomas.hellstrom@linux.intel.com, 
 rodrigo.vivi@intel.com, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 07 Aug 2026 06:47:17 +0000
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

> You've been approved in our CI for future revs.

Thanks!

> Also I came across this issue on i915 for MTL [1] which appears to
> indicate the same issue (ARL and MTL are very close and share the same Gu=
C
> firmware), the suggestion is to disable rc6. Unfortunately Xe
> doesn't have a knob for this, but per [1] you can turn off rc6
> in the BIOS. Maybe worth trying.

Good find - that does look like the same ~2.3s signature, and it being
visible on i915/MTL too is an important data point (Daniele asked
exactly that in the other subthread).

On the rc6 angle: I ran an A/B experiment earlier that should be
equivalent to disabling rc6 at the GT level - holding forcewake across
the whole GT for hours (C6 residency pinned at 0ms for the entire
window, verified) - and still hit 9 timeouts in a row, with the same
~2.3s request-to-ack. So at least keeping the GT out of RC6 does not
avoid the stall here. If the BIOS suggestion covers more than GT RC6
(e.g. package C-states), that would be a different experiment - my
consumer ASUS BIOS does not expose an rc6 knob, but I can look for
C-state options if you think it is worth isolating.

Next on my side: switching to the GuC 70.72.1 build Daniele posted and
reporting back, plus GuC logs from severe stalls are now attached to
the gitlab issue.

Thanks,
Tales

Em qua., 5 de ago. de 2026 =C3=A0s 17:25, Matthew Brost
<matthew.brost@intel.com> escreveu:
>
> On Tue, Aug 04, 2026 at 02:29:27PM -0700, Matthew Brost wrote:
> > On Tue, Aug 04, 2026 at 01:34:19PM -0300, Tales A. Mendon=C3=A7a wrote:
> > > Patchwork reports my address is not on the CI allowlist, so CI was no=
t
> > > triggered for this series:
> > >
> > >     Series author address 'talesam@gmail.com' is not on the allowlist=
,
> > > which prevents CI from being automatically triggered.
> > >
> > >   Could one of the project owners click 'retest' on the series (and/o=
r
> > > add me to the allowlist)? Series URL:
> > >
> > >     https://patchwork.freedesktop.org/series/171539/
> > >
> >
> > We'd have to resend this ourselves. I can do this, but I've requested
> > for you to be on our allow list as well. I'll ping here once that goes
> > through.
> >
>
> You are approved on our CI for future patches.
>
> Also I came across this issue in the i915 for MTL [1] which seems to
> indicate the same issue (ARL and MTL are very close and share same GuC
> firmware), the suggestion there is turn off rc6. Unfortunately Xe
> doesn't have a knob to do this but according to [1] you can turn off rc6
> in the BIOS. Might be worth a try.
>
> Matt
>
> [1] https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/14469
>
> > Matt
> >
> > >   Thanks!
> > >   Tales
> > >
> > >
> > > Em seg., 3 de ago. de 2026 =C3=A0s 23:14, Tales A. Mendon=C3=A7a
> > > <talesam@gmail.com> escreveu:
> > > >
> > > > Hi,
> > > >
> > > > This series is a follow-up to the TLB invalidation ack stall I have
> > > > been debugging on ARL, tracked in:
> > > >
> > > >   https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
> > > >
> > > > Summary of the issue: with GuC 70.53.0 on ARL (reproduced on 7d51 a=
nd
> > > > 7dd1 machines here, plus an independent Arc Pro 130T report on the
> > > > issue above), TLB invalidation acks intermittently stall for ~2.3s.
> > > > The H2G request is consumed from the CTB immediately and the G2H CT=
B
> > > > is empty the whole time - the firmware simply does not send the ack
> > > > until much later. The fence timeout fires at 2.25s and the ack land=
s
> > > > tens of ms after it. Userspace blocked on the invalidation (composi=
tor
> > > > buffer unmaps etc.) hitches for the full window.
> > > >
> > > > Patch 1 adds xe_devcoredump_gt() so this kind of hang - which has n=
o
> > > > exec queue or job to blame - leaves a devcoredump with the GuC log =
and
> > > > CT state behind (Matt suggested capturing devcoredumps when we
> > > > discussed the issue; devcoredumps from both machines are attached t=
o
> > > > the issue above).
> > > >
> > > > Patch 2 logs when the ack for a timed out invalidation finally
> > > > arrives. This is what established that the acks are late rather tha=
n
> > > > lost.
> > > >
> > > > Patch 3 is the RFC part: a delayed work that pokes the GuC (status
> > > > register read, CT flush, doorbell ring) every 250ms while an ack is
> > > > overdue. On my machines this converts the guaranteed 2.3s stall int=
o a
> > > > sub-500ms hiccup for the majority of occurrences; a minority of sev=
ere
> > > > episodes ignore 8-9 consecutive doorbells, which points at the GuC
> > > > firmware being internally blocked for the whole window. Full data o=
n
> > > > the issue. I am happy to rework the approach (different delay,
> > > > tying it to the G2H handler, dropping the status read, etc.) - main=
ly
> > > > I would like the firmware side investigated, since no host-side pok=
e
> > > > can fix the severe cases.
> > > >
> > > > Based on drm-tip. Tested for several days on both ARL machines unde=
r
> > > > desktop and VM-heavy workloads.
> > > >
> > > > Thanks,
> > > > Tales
> > > >
> > > > Tales A. Mendon=C3=A7a (3):
> > > >   drm/xe: Capture devcoredump on TLB invalidation timeout
> > > >   drm/xe: Log when a timed out TLB invalidation ack finally arrives
> > > >   drm/xe: Kick GuC while TLB invalidation acks are overdue
> > > >
> > > >  drivers/gpu/drm/xe/xe_devcoredump.c     |  68 ++++++++++++
> > > >  drivers/gpu/drm/xe/xe_devcoredump.h     |   6 ++
> > > >  drivers/gpu/drm/xe/xe_tlb_inval.c       | 131 ++++++++++++++++++++=
+++-
> > > >  drivers/gpu/drm/xe/xe_tlb_inval_types.h |  42 ++++++++
> > > >  4 files changed, 243 insertions(+), 4 deletions(-)
> > > >
> > > > --
> > > > 2.55.0
> > > >
> > >
> > >
> > > --
> > > Com os cumprimentos,
> > >
> > > Tales A. Mendon=C3=A7a
> > > talesam.org
> > > communitybig.org



--=20
Com os cumprimentos,

Tales A. Mendon=C3=A7a
talesam.org
communitybig.org
