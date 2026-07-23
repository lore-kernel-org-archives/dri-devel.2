Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455D8C531FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 07:28:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 967AA10F2E9;
	Fri, 24 Jul 2026 07:28:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k1MIp+zV";
	dkim-atps=neutral
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC13210F240
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 22:31:23 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-81ed2a00f12so10633137b3.2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 15:31:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784845883; cv=none;
 d=google.com; s=arc-20260327;
 b=CpmGaZ5wv7nNRLDUSiWsxhXQhQ5HjQOEKjzLYxbk892viE5uoa+X/B8RRBxqsdubnP
 Og6Ppu8GP5ckK8BYSUMosK8hE251fXVtznBJftO7IIJeF0Nc4ijX1yZcp9DPrnU9uZUr
 tuvGNuaOwoH11ZlOWeoLp2g2XWfEj640pUsBzzWBJWQejsabOQNp/+Q4tHAL8gFXvSxa
 iNPFkD5po4yjHe9VjG78/TcHQ7N8mCU+yO7FSz9tOXGFIRlJVRa0G0AFsCorbqaTqzi5
 Yooj4VYw6gRCGxYYDA9ikLY9nR0k0chh8cRI8ax5I0sUgzZVN3BOsAD5E+w4lmQQGnah
 RNdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=p4DOGnxEWenX1IClXiXqveLXWuc5Sh9trwdVrreBzOU=;
 fh=QM5ZjtQUIVjckVuqtRMybLpn+u4biaaq30EJLWaPACM=;
 b=jGaLBTyXLDJLUFsGzBW0c1un852Zh4vXBcVfYL6GAzWpGvlSpeFWL5jYEAuDvz5Rlr
 +ctBeNxXaVm8PAGKuKNAZMDs7t34nRTiAAi04UHk86GhhY5ZlgPP3Q6TfBUWBcR5ZOfv
 b/cOX8OI+4j2boL7xvnzfkfiXlzAuBk5fFxrZpgkCLh0UwX4shk3WBr7Rr/70mUSqCzK
 L8WMn0vSxL/mKoe0X0zapI/dtMOgOmCHva8ERe7P2qo/Hab9a2SmcYPX59ihgEQq6ofR
 7OscELw3GjyAqkU2YvhRKNBAcjgGYuHTTYO0DWJproVdrPeok0KCu1c2cmBxs2kltfrq
 stkw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784845883; x=1785450683; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p4DOGnxEWenX1IClXiXqveLXWuc5Sh9trwdVrreBzOU=;
 b=k1MIp+zVZrWmtGcVf8mLzFHO64J+G6GGd1DWVxXz3cByNmXGIrXj4sTli4e7bDkuK+
 0cvz1DBuI6I1Zhn24tMUycHq//t2mA7gQSdnbh+1G5OJc50/yg1jHgj69maDM3KzH+Mg
 JzeoeDeYehEJ+B5SIfLdvy7/9KWd0rS22x+dn5vHOD14dWN53BcUdvBbEEGCqiLjI4s1
 l2K7aLwEF/Gto8DvUT3yc99/xjpOlGN5sGkIoIFlDSb55+xs2gd90ihBwROGnNcYgOgY
 riFcbECOOPSI3HJ9254QVu7nLoIukMSzzR9e+RkAxd4KNprJmkuf4EjStjFRD6bPPcO7
 MRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784845883; x=1785450683;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p4DOGnxEWenX1IClXiXqveLXWuc5Sh9trwdVrreBzOU=;
 b=BsZMCJzwXz08HTDA2gKSp6PDWsZGunqDtI7UvYPEeoRa6iHco7/D+DNHIkNCXkpnJp
 b4vNhqacryiHvu1xddsklIXW+r4fRKDqyq+gMWzkNG36I/6TZ8I57mqranz2diUpiCIq
 G2XPTxTXgZp3lbm21L+Ea++jaLtqPBamWK+/fboBKQU+Q/1oi7ePAQl4dfWTBbrK4tB0
 ZeAsHGymcYwffhtWSXItp+BU2+D4RwGCKBcPVJ4Kvb83DIGHqxTRxsAmBQPV1KTif3aK
 OcrMTbtTOBhMyAg627xg9JCamr3Ge+wcFemLfw944Z2bhMfIeEQ8P6ASABFCINag3TMK
 NZmg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0h0LtwZ0kut5uv6XY8o5uxj9OO/s0QSzuCQZWz2Py1EM2EgNeu1xd8fompfnS03P8XvLYtcv6Mak=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyvh2/fLOXfofCkx0rrOg2fz4Em7GxpuTmoEbBJAHpzS8XhrMPy
 Cs6vsoJ8r57UDm4eFRaJJ9W7/Ck6Ny3JKI6cVbn9xHuyJyTvL1Ljrl9xhorVMvUw1pCw3COkXNy
 GmbPVc2B28oiSEkIiPsAopDmy+GJbNQg=
X-Gm-Gg: AR+sD11qgqLNsLwOjHXAeDXFTC3i22Wt6DKrQla7qMdHZor90tjDYm2NJaj+Vxt74U/
 RIKxE0FlaBN0jTzHKjdTzxeIUSICSMTQP8WR2TrDfsTQ3yCrHNNm2l72iCNDpCFCnAhaTkIPbmd
 WxAIdWN59qD57n4481oOzWdWrATV7kQNDXhUxBrVM5keEtUfhrtAJCYesqLr7N0HVdRu0WHxYiY
 cGpc/B16KIDO84k6nKGqFe3LcKP+YfEbWEo2TSSRoaA32ikFDEG9lcDzNQq82kq18VW40wmU+yV
 JNTwX7jPMGH6ORHtIAicPVOesq5C9K5EDtdKx7Wr8wGidJNL
X-Received: by 2002:a05:690c:d90:b0:81d:42e6:6a82 with SMTP id
 00721157ae682-81f4c1c1df6mr17102247b3.25.1784845882677; Thu, 23 Jul 2026
 15:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260722004654.744249-1-talesam@gmail.com>
 <20260722004654.744249-4-talesam@gmail.com>
 <amExusdY0Qhs3LIx@gsse-cloud1.jf.intel.com>
 <amE+Ltrb8qKNKWd2@gsse-cloud1.jf.intel.com>
 <CAHBRX4HbDnpiEqgFauZNMWPq+Wtp6RhYYLKMW=zNbTphAB_xgw@mail.gmail.com>
 <amFftEnuIfPJKFPX@gsse-cloud1.jf.intel.com>
In-Reply-To: <amFftEnuIfPJKFPX@gsse-cloud1.jf.intel.com>
From: =?UTF-8?B?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Date: Thu, 23 Jul 2026 19:31:10 -0300
X-Gm-Features: AUfX_myyax3VEOlP25T1dSkPZWHK-l9NwmFe1PJtF_rE2oReObrRDEeyhQ2VBCc
Message-ID: <CAHBRX4GTHiv+3YYiNoDFy0L8KAyb7ruqDZR1rV9MNGwHBmLhnA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] drm/xe/guc/ct: Queue G2H worker before flushing it
 in timeout paths
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 24 Jul 2026 07:28:31 +0000
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

> What about the H2G CT?

Hi Matt,

Thanks for the series and for the H2G question =E2=80=94 I extended my
instrumentation to sample the H2G CTB descriptor as well, and I now
have results from two ARL machines running your series 170939.

Setup:
- Machine A: ARL-H (PCI 7d51, Core Ultra 5 225H)
- Machine B: ARL-P (PCI 7dd1, Core Ultra 7 255H)
- Both: GuC firmware 70.53.0, kernel 7.1.3 with your two patches
backported, plus debug-only instrumentation that samples both CTB
descriptors and the GT C-state at TDR time and logs late acks. My
earlier G2H-flush patch (3/4 of my series) is NOT applied, so your CPU
flush WA is the only recovery path in place, with the stock
invalidation timeout.

Results, 7 timeout events so far (6 on machine A, 1 on machine B),
identical signature on every single one:

  TLB invalidation timeout gtidle: seqno=3D89335, gt_c_state request=3DC0
    timeout=3DC6, c6_residency request-to-timeout=3D2278ms, waited=3D2279ms
  TLB invalidation timeout g2h: seqno=3D89335, ctb pending=3D0 dw,
    head=3D23932, tail=3D23932, outstanding=3D1
  TLB invalidation timeout h2g: seqno=3D89335, ctb pending=3D0 dw,
    head=3D792, tail=3D792
  TLB invalidation late ack: seqno=3D89335 recv=3D89335,
    request-to-ack=3D2325ms, timeout-to-ack=3D45ms

To answer your question directly: the H2G CTB is fully drained at TDR
time =E2=80=94 head =3D=3D tail as read from the shared descriptor, i.e. th=
e GuC's
own view of its consumption progress. So the invalidation request is
not sitting unconsumed in the H2G ring. Combined with the empty G2H
ring (with one outstanding G2H credit) this means the GuC consumed the
request but did not send the ack until 2-45ms after the TDR fired,
roughly 2.3s after the request was posted.

Also worth noting: your "CPU flush WA resolved %u pending TLB inval
fence(s)" warning has not fired once across many hours on either
machine, while 7 timeouts went through the recovery path. So at least
on ARL the LNL flush WA does not appear to be the mechanism =E2=80=94 there=
 is
no G2H sitting unprocessed on the host side; the ack genuinely arrives
late from the firmware.

Everything points at a GuC 70.53.0 stall: request consumed, ack
delayed by seconds, firmware "wakes up" right around the TDR. If it
would help I can file a gitlab issue with the full logs from both
machines, and I am happy to keep collecting events (the two machines
produce a steady trickle).

I would also like to give xe_devcoredump_gt() a try as a separate
series, as you suggested, if no one else is already on it.

Thanks,
Tales
