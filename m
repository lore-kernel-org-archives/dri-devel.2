Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEC6C55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 916AB10ED2F;
	Wed,  5 Aug 2026 07:24:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oBbaOA2c";
	dkim-atps=neutral
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com
 [74.125.224.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A4F810E1AE
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 16:34:33 +0000 (UTC)
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-664b05d408bso4307749d50.1
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 09:34:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785861271; cv=none;
 d=google.com; s=arc-20260327;
 b=ouylva+2L3M2z7ehArYhs73U6Hy8MetiRjZFIHlJAirDmu0XsHVszeHwjdP/i4GSvk
 f0zdUQRcuTIlD4c4P1OYq+77EV4tPIRaOObmucFsskhFbTkE8Qn2yGz8td7GoOuYcbz7
 G5BgHvA6IixVGlPPztnnrcnyWgo+GGRpwlLY4Y2/PG0VlhzjJSUrXMawKYrB4BsyMPHw
 PychCBDcTGmQdqyyMyMYjP9r8eyQBvGH62hJKFwxIcIzfXSXI8tUQQAbABSgYOGqmEL4
 BIXqm2+Qeeii1mlDmqZj45+togsegtMMRzL5Aux/5asMnoTtcLYOBJcetKeosXFrfMyb
 tNhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Hd/HrJIAJRgbvjsGqLhSe0FGOQYBV2Xuk+fFwAyumqc=;
 fh=MpP8xlIGZTzM/9+OrCSuBrcYYWWIc9sRLgh9+7Jzyqk=;
 b=kaiSTSpMnnOLE7ZrHyEvehR+FDNsZZVhK/DOVqfujKryxqkHicjzoCIHf++e7eW/RG
 G3IOuyASftkxzzEYzZVXU7F6UlvRJFi6eihFxRtlZzXLEuMUPXdMstCyWJPa4xFwwRMb
 hxZj25OfRFa3PAv2XvzDi28fFLjAz162ZTNSwTvr1KsSEsfrl+6sPqJlhsqnAfB5DaDB
 0YyKlnmeboE7ChQti9io6z6Z4/mYU8gsXvtiCuZuV/cowIbvu7sHKPgNH334xTek4VwC
 vE15YJpBMpRHGgGktB0Nq4hhLZwR4sJ5xc1Cif6E42xa/RE3gQ8/YUJ17L7ToeAAv4SD
 +vvg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785861271; x=1786466071; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Hd/HrJIAJRgbvjsGqLhSe0FGOQYBV2Xuk+fFwAyumqc=;
 b=oBbaOA2cuA1XhrnKUkoHCovKyadIQx9/r1ugxGtfLu2B5SgzBxRLamkDygOgh9fvjZ
 7G7prHI8+lN/RxE+Unp9CXeQwQWo4CD2fVpRuBpxJ/VWf7LOOVmnMJzjQAJT7/wuBUEk
 u54zXT7mS9ssB/q4oLUIGSsJXr0EF2jSxmQ+EYw1hiXzxcTnDhI59BDjxlfH0Y8mOJ0B
 t53f70Z64/3lav+7MTqNuzb5Uv4pgaBaVDAO0v4ItiT4GHCJPvuTTaF5SZjRQN8jPblk
 ZPh/4SXyAIkh/B9vsocy0YbZLoVGY+guGYM1Xg3iAdiZwSLG6/rIMMoTEZ2lUBh9YWox
 89+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785861271; x=1786466071;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hd/HrJIAJRgbvjsGqLhSe0FGOQYBV2Xuk+fFwAyumqc=;
 b=U3Inj4GJkLxNJN6U1IfpnwYntCDeUwczMaVRx7dcCfjKPCNSxPpdeL4OYkWKqmYALo
 Z72eaQTYcvX7m2JsKUO6KY8UX9PeVZLyN0ECiQnFL0lKFTd63CIIWHei0BkSZlZb+hen
 l8ScpZFqu/+E4d0JkIIRNi6fPBbW/QsFyl6in1XRjBOn1TbumZ4SCKn4GrEr3mDndtok
 SnSCCv8EcmCJFK3gnOawtbdVcN6+spHSjz0TV88Y5jAAKBykHkCV9zr0IPrDRlpMwSzg
 VVopRuLn15znL+TMmxzlEH6BkIjS4T3HPXveTda7NtF4FVj4xQWmL313uzFmnHAS2NHN
 vE1g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpHOhYOxKV/2rfnIbUFPxA/Xky96Eq2fRKb5TTRLzH6BwEshQ9axx7Of82AJ9UM7vJTxmhz15fZr+U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQP4GtIQGUdlJ1A5dmX8BWOncovXH22FdUUXt3bL6wrQ2/NcJx
 vGibABNuC1SdnfwYGw5LqL6rccDSwGOKg6WD4DyR7Ji7gyrkwdGWJnpOYLpkGM3apwILe8oH3KA
 YzMXY56jo/VgeVi/GbsomtFvmxPuOxDo=
X-Gm-Gg: AR+sD12Tn5BWdasjDYvdhSedwDgI28Rbi9+jSHq1DGX0d3N83qdTH9OZVtM84htyPnA
 pUJaxNQ8UTR61jo1F3DrwKFWFoVz8+dEGrJJWpTTJDCNucRclu0D/4KtQ8NBL/SpGmRMQXecgw0
 2o1HYhaEnQsP9phmjVXq5DhYD4mpXDn+8H27LM1E2TmHNTYPnxqngDF4iHHYTPvF/y+O5JNN+VL
 Tnhq+miO3dOpRqmrJV7pOipl0FGl14xz5i0v/fIJzBGfRmzzuzvrMkOIgJrWeuYkYqvfviCxpZD
 L8ROY1vV1iRWUwapUlODnCWtR5t4VLP9acpBBUvz8uco2XbDpPrjFrGVoFkYmJa0l46uyb5I2l0
 wp++/FgjCfK2Z2mP6MB0kYw6VCg6x3g==
X-Received: by 2002:a05:690e:21d1:b0:669:7a69:38d0 with SMTP id
 956f58d0204a3-6699a9a62bamr45130d50.3.1785861271186; Tue, 04 Aug 2026
 09:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260804021441.3054424-1-talesam@gmail.com>
In-Reply-To: <20260804021441.3054424-1-talesam@gmail.com>
From: =?UTF-8?B?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Date: Tue, 4 Aug 2026 13:34:19 -0300
X-Gm-Features: AUfX_myMA5DJ-TljhiuGTXuwlJM4IDbgiSgTM3Xo7ebSAXx22lyWaypKnlbNFo4
Message-ID: <CAHBRX4GYEKniGb8jw-h=QYPi=FpbWRKwHHnfw-K5wYiy6AWfJA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] drm/xe: diagnostics and workaround for GuC TLB
 invalidation ack stalls on ARL
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com, 
 rodrigo.vivi@intel.com, dri-devel@lists.freedesktop.org
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

Patchwork reports my address is not on the CI allowlist, so CI was not
triggered for this series:

    Series author address 'talesam@gmail.com' is not on the allowlist,
which prevents CI from being automatically triggered.

  Could one of the project owners click 'retest' on the series (and/or
add me to the allowlist)? Series URL:

    https://patchwork.freedesktop.org/series/171539/

  Thanks!
  Tales


Em seg., 3 de ago. de 2026 =C3=A0s 23:14, Tales A. Mendon=C3=A7a
<talesam@gmail.com> escreveu:
>
> Hi,
>
> This series is a follow-up to the TLB invalidation ack stall I have
> been debugging on ARL, tracked in:
>
>   https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
>
> Summary of the issue: with GuC 70.53.0 on ARL (reproduced on 7d51 and
> 7dd1 machines here, plus an independent Arc Pro 130T report on the
> issue above), TLB invalidation acks intermittently stall for ~2.3s.
> The H2G request is consumed from the CTB immediately and the G2H CTB
> is empty the whole time - the firmware simply does not send the ack
> until much later. The fence timeout fires at 2.25s and the ack lands
> tens of ms after it. Userspace blocked on the invalidation (compositor
> buffer unmaps etc.) hitches for the full window.
>
> Patch 1 adds xe_devcoredump_gt() so this kind of hang - which has no
> exec queue or job to blame - leaves a devcoredump with the GuC log and
> CT state behind (Matt suggested capturing devcoredumps when we
> discussed the issue; devcoredumps from both machines are attached to
> the issue above).
>
> Patch 2 logs when the ack for a timed out invalidation finally
> arrives. This is what established that the acks are late rather than
> lost.
>
> Patch 3 is the RFC part: a delayed work that pokes the GuC (status
> register read, CT flush, doorbell ring) every 250ms while an ack is
> overdue. On my machines this converts the guaranteed 2.3s stall into a
> sub-500ms hiccup for the majority of occurrences; a minority of severe
> episodes ignore 8-9 consecutive doorbells, which points at the GuC
> firmware being internally blocked for the whole window. Full data on
> the issue. I am happy to rework the approach (different delay,
> tying it to the G2H handler, dropping the status read, etc.) - mainly
> I would like the firmware side investigated, since no host-side poke
> can fix the severe cases.
>
> Based on drm-tip. Tested for several days on both ARL machines under
> desktop and VM-heavy workloads.
>
> Thanks,
> Tales
>
> Tales A. Mendon=C3=A7a (3):
>   drm/xe: Capture devcoredump on TLB invalidation timeout
>   drm/xe: Log when a timed out TLB invalidation ack finally arrives
>   drm/xe: Kick GuC while TLB invalidation acks are overdue
>
>  drivers/gpu/drm/xe/xe_devcoredump.c     |  68 ++++++++++++
>  drivers/gpu/drm/xe/xe_devcoredump.h     |   6 ++
>  drivers/gpu/drm/xe/xe_tlb_inval.c       | 131 +++++++++++++++++++++++-
>  drivers/gpu/drm/xe/xe_tlb_inval_types.h |  42 ++++++++
>  4 files changed, 243 insertions(+), 4 deletions(-)
>
> --
> 2.55.0
>


--=20
Com os cumprimentos,

Tales A. Mendon=C3=A7a
talesam.org
communitybig.org
