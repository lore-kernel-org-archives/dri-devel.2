Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86031CC6B2A
	for <dri-devel@archiver.kernel.org>; Sat, 17 Oct 2026 06:30:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FD0810E03A;
	Sat, 17 Oct 2026 06:30:34 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26C3010E03A
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 06:30:28 +0000 (UTC)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-91791ec1b83so5305916d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 23:30:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792218627; cv=none;
 d=google.com; s=arc-20260327;
 b=rrDrlA18YItaNh40Fw0rApBSCqGWsIqH52qZLLBBVd0GNFto+fDU7YU5TCwONAsv9D
 UBUjutpMehKq4jJWE7X04gU8h4CKJCbzTplVfsKRW36tIlTQwbGsXlHFhI0tlo7kcKv9
 wYn4EOM7UEts2RfCo8l8YnCWfx4rpmhyGg0Z7L6mSbQRulCirvJmLCFV3QJdZ2yzrJbu
 Gj9brZtAdQLUHiJU1snwbByHRAn4u5q3Ztk5U9/awdkDOtbCAM4KPDtgqQWodE+RrT0Y
 MqJ2NLL/9oVm4KmEbxXkX8NE9BXNx4MO5Krg4L8F7Q1/xI8OeGSBza9E36Cpl6ibgl5o
 klNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9+/72NBdno+j2crMEeoosJzc0n5Cq53P1qeqSGU//OY=;
 fh=zlr0mhPi2M8k+MmgyjrsNl1tEMXBd+8Ebr0BHu2Ikjo=;
 b=VXxaMVRvbYDnfs+0vJRKwqOZndRfu5rPQhvhcKxYy4kIZmWPIK6xtaB/5oL+VwFw58
 6n5fkaNhooGQkwnwGepJLCW01S5RiZQSxXglLa8ky50o1df65buAVQBLG9S5FKbig3if
 A8LgvKqzyS1o2fTTbrAnYwDRvSqdsR1b2U1cqfEtqubw3EX5lsuQMsUw4wC9UuJThPAk
 q0lURa2Je5BQVKLMLOeiou9V4mz83E7lEGpbb5occoATlBwpFb3gk8KwLeaN8p83TZUT
 JR+6qiHszv0gGC7KSie7OJBoVBPIhqnE3czNbD6KqYJl6bJKh6nreiybo6p/JclNm5y5
 d7PA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792218627; x=1792823427; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9+/72NBdno+j2crMEeoosJzc0n5Cq53P1qeqSGU//OY=;
 b=GRqLqFg3Sq9qcHJWu5zqn0T+UPcXYeEIkfmF2nRihlcs7Fr4jP2E5tdZsUR33pZNLF
 Q1YZzBSfCYOomA8OdXO4vCg1mdDTPyi/5odmhs6YqZpdSs43Vkx9U8kqWmBsykGGdu3+
 cUUORgcMf5qd6h0MyHfP+IjLwtwJL5U0HFyIYrvwLmYdh2vzsqxTdWfZTDml06NqyFZh
 uYgnQMWPwwyAr3z3FLeYHxQxgYeZ4PORxn+KxR4x9S2tL24oUG/kZpbT7WDlDRkgpMUu
 6uFIQj9MDG7FhHqfSCRebHYM2Y+A/mTH9m/uiY4bZGqKd7K9YCRAqp1qkJPZWOLGEv2i
 pBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792218627; x=1792823427;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9+/72NBdno+j2crMEeoosJzc0n5Cq53P1qeqSGU//OY=;
 b=P9OKq1tLDS26E7qMnLLEcIojEszPSDd9SYwfDQ7Ol3Mbeh+oIGZ99L1HydV5AVmbLP
 /2TGC8g7tf2nhb1Dmkjsbg9RT1crZOOPkudu2yYMP5RxbRjrHXRXP51QMjjZSPEDjQjN
 7PK8gbvJ4hh+5aUyJh/NwZgDWG+wvqYCrNziZXqxRKl2ERuAzvFT7G/Lsuai/0y8+Mip
 fevRA9oYJYlqfLcQvW4FPuwIGv6YE2X6VxBCQPJ1XK+M+wjp7QX2XmSwRJdwmV4935VJ
 SYXxLJZ0eGmKI+5QelL7ws3umXdrBRMD9xq0Y09/qsVSCyqL1jOYhRnvSFm5FBtZoTc4
 UqnQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxIj5lRCRSWsw9gCH3gpqvs9cmjdRHEPtKeVAQTyk4PQBY5vSQcvWsy/rwJQY0mQqrqyGRpwhnGUo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIv9W0NaTLkTxjyu6xpEboy7islIbCtRosf8c+swIs2n+BAPZxh
 o/RwQJCSe+rG57l9iI4GU2WB2HwYv9m/xjcfty35vvXnMYUrExqwfH1DmJLJqeSdplTym5xY2Kb
 DLQTuYMAXt0lx7XWjmpsDNA4XVCawvDY=
X-Gm-Gg: AYBFou2UWoREg5Etzb+j+/99YRfaUNSu93fjzTLhoHZMqh0O2EolnKSb4Y1TfTTTV6W
 9Kfml/TSTFHn6xypvnd0aDbbc34LPBINRtPmVGCSzJpJ/Xqa/vx98Z5tcwjSprv//Z3Z+PgSHK9
 vp7UP/PFZJQhgPjlIu1Z4mTBhhAMRy/Sm6szORbadjvGPnPDkoEzi6Pp+h/wj73V7ASYM+Hwwcz
 vPNWfj2ZELXqa24N9wolGmlLGTV36XTuVQFE/7YaZc9f7a9Xa/gwXEDlLun90pSiQ+bAD32eLSn
 47FJgSURlf5x0zCxNyDcHdGntqTXCrFhgQX9XW/brT0OuHrCd4OSRjGvLgijSaDE1BplOY+eJBv
 FS1zdEK1hiJlih2orwltOI63DbRET52/NElYVuRY9vxCuy3oiOUQG
X-Received: by 2002:a05:620a:410c:b0:93c:b33a:5ee0 with SMTP id
 af79cd13be357-93f29d3f0d1mr345360085a.41.1792218626850; Fri, 16 Oct 2026
 23:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <2026092253-dimness-unethical-2515@gregkh>
 <20260922153334.136648-1-bub4z0r@gmail.com>
 <2026092320-reentry-lyricist-330b@gregkh>
 <32446a55-070d-4739-bd3a-d56c4b628e29@amd.com>
 <2026092332-alkaline-overthrow-494f@gregkh>
 <CAPM=9tyVcUdb-wjv2unksLV-BVcOxswqB0Y+H7agBU5vYGFKDw@mail.gmail.com>
 <2026101737-broker-output-d845@gregkh>
In-Reply-To: <2026101737-broker-output-d845@gregkh>
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 17 Oct 2026 16:30:14 +1000
X-Gm-Features: AclHuK8oTdGZtkAYns0vEGDb9KwY2aZC1M6hyDXrk7IpcqJ0wBLT9V-mKbZizfw
Message-ID: <CAPM=9twsgnL_SPf7hi+mnPUgJTyGVDFyQdbOSNhQZXSSoxZmNQ@mail.gmail.com>
Subject: Re: [PATCH 7.2.y] drm/ttm: fix swapped-out resources never leaving
 their bulk_move range
To: Greg KH <gregkh@linuxfoundation.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Vadim Nikitushkin <bub4z0r@gmail.com>, stable@vger.kernel.org, 
 thomas.hellstrom@linux.intel.com, dri-devel@lists.freedesktop.org, 
 skainsworth@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, 17 Oct 2026 at 15:45, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Oct 17, 2026 at 08:19:46AM +1000, Dave Airlie wrote:
> > So I got a report that
> >
> > "the backport of "drm/ttm: Fix ttm_bo_swapout() infinite LRU walk on
> > swapout failure" to yesterday's 6.18 missed "drm/ttm: fix swapped-out
> > resources never leaving their bulk_move range",
> >
> > So can we make sure this patch is in the stable branches the other one
> > went into?
>
> Sure, any hint as to what git id that is?

All of the hints:

6.18.57 has
commit 060f8f3020516d71bc4d6159d4d0beef85606a74
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
Date:   Tue Apr 28 11:44:42 2026 +0200

    drm/ttm: Fix ttm_bo_swapout() infinite LRU walk on swapout failure

    [ Upstream commit b2ed01e7ad3de80333e9b962a44024b094bc0b2b ]


upstream has two fixes, because we messed up,
commit 3db7d7d583419f7b1f2e141e36418802dbb25cf8
Author: Vadim Nikitushkin <bub4z0r@gmail.com>
Date:   Wed Sep 9 23:50:28 2026 +0300

    drm/ttm: fix swapped-out resources never leaving their bulk_move range

commit fcfe64715b425262af1b36f498f9197f3537ceed
Author: Vadim Nikitushkin <bub4z0r@gmail.com>
Date:   Thu Sep 10 17:34:51 2026 +0300

 drm/ttm: apply the swapout bulk_move fix to the intended condition


we ideally would want the proper resolution of those applied. which is
the patch in this thread.

So can we just apply the patch in this thread to stable, the squash
fixes the stupid in master, or apply both patches to stable and leave
the stupid.

Dave.
