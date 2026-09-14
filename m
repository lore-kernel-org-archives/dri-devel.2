Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E37C88E73
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F86110EF09;
	Mon, 14 Sep 2026 14:21:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K9cJBTG+";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60B0710EF09
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 14:21:40 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396672b2569so228171a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 07:21:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789395700; cv=none;
 d=google.com; s=arc-20260327;
 b=UYO+eBsmtUJlCSb861Ng1wS+Xdvjrb/mMi+OQtD8v32VqablGpWqybQ+kmxLGrr1Nu
 Wv9utqj65CGf2EBJDU1P4L42sRjRRuCkO3IS/SaIsAqliuHnNyBbMHakn0M89vB/wllj
 6AzTrC/1BR+FmdN+A14gvSop+Zet8KeS2X3zQIZIixYwiRcNbsi6c75n9O5hLoDKcFNO
 YIY5eZhBMqQ87GFIiDOtyVw73xUN+E4HSFCTK60Kf6dsBav0tvIIub30Q3mDV9RgVA3U
 uM9U/MgTSAhtwH8jwVYK2GjRuidysKNUUPTlV2QNKWma6JF2L9sgO+lXXNtadLd/ZTqg
 jVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9wBaA/n/TmKjwu/wZ60gVcKCOeMtecNNHVqEiqLighI=;
 fh=RI7C/zUdEEC1ZYer1IJ9Y5Gq+B3KFoQLKcgSnINRSos=;
 b=AIju343TdpuuJwK0H5zlZHJv5fAfyCWBcAWCNtsVx8dqnkyKISX/abGZicPquzQMiw
 Sm6G6y9Yi2YDICIk824wdtiSrYKh5SVMarSPUQVN0aQhYkNeKwO3zDhvkFM4Ts1+bQa8
 /TtlPlUHqWuR2vCn/7zGsFBxsVYxIrzNKoc4sQ76RBtUOFsX32ze7ylejCVuYFbwQX/4
 qATVtjFZDV+6UAy0GCKDjyvl5t6q4xnL9hhlmrcfx7jqikR3HqdRAs7LJc7i4OHObe+9
 +2U3DwSyYSYH9ldDX8oMF85Ba3dji+77iLfDVlNHd448Yhw8FAEJmWTPJwgUG2uv/fwS
 nujg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789395700; x=1790000500; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9wBaA/n/TmKjwu/wZ60gVcKCOeMtecNNHVqEiqLighI=;
 b=K9cJBTG++WR4YANO3Gd8E7+VM9z8klDUnG41ouf7uRUgNOTNUuBYMNCUkufpEXX9KK
 bUvqqsP2sth4oUMG4yjEnAAvauUX2B8lILEWPcV7AcUtksgMXP3jHKYdlHkvGjNhrGJ0
 imGd64logls0wQUsoqAcOpchRbRpPVSVkTZFrFjeEy6k0WY3SdRBNTeviEGAzccHr3Vy
 PfU4LxWPhFZ8VxANpTF80GjhruE4Cc0U8Yk3z6F0h3gMwk/hbRZjJ32VokhsoDdFppHT
 oG3arbY9tkSEg53pE1zXXmQOdjlUNOpAHsdCh5Ayavb68uS1pOFyVq/EWybsc3HBDjGZ
 QK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789395700; x=1790000500;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9wBaA/n/TmKjwu/wZ60gVcKCOeMtecNNHVqEiqLighI=;
 b=gflaFEQqyqVB8sNrZ3fWkgnORiAgc/3xEYPlqkqeb40copdqqqyw3DZFdtwwmysBol
 JOS0hQkmXbqK3MhgSGZTtVLFHJ/Scfkvgs/SWoDe1+M4WhzqLLZ587hypdrIdwcFWigx
 bR6pAHtBpX17IGfZ4V/yAfRKHndjB26SBFWMUXic0ScAEvaM0yfzL+h4qyJQrYv48Ote
 tbHV7I0eTJz2OxcV/tG7p5M1tBHWuFKlxhsDQPSs1v41OSh+DC/Z1brnk9tyW4f1a9UG
 zyd9/0rWmhW8rhagWaF75ucMta60JJWDTy7xV1v3PT9ljZGTzTY3M4nw8z58o2YBYJj1
 gfQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwaAqyiQ3iW6OFoFg8C0yCo+rTM+mxywx3cwDtr3UL365oJjPaEByh1e8eXfUBZU3EgKgsKV9m+B2o=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l7XXuiG6LVOdUK3IUew8MjXsNDTs8PUpN3Zmj1yGXqyxoYDAX3
 JTAYW8v1rdu1mtnrwWEFacjAyIdolBIL+dW21DkSQ4G6EClkdRD/Jsutrn9MWVglp1SGiGOHs0S
 f9LGK44nxyHp2qgkl9afx5UeQkerDc5M=
X-Gm-Gg: AYBFou2M307iMNwwd2oZNmtJhGVnRh3ALboBpyQ21Ix/7VxZZ07Kzjgip3LKYhvk5Q+
 qD5HlYRWPdA0X8ijKwyRAOCUgYiueEHL7ZwVKFEeOeqIqv9KcENJnLe8pymTvbXp5pEPSnxDpcO
 kwvOO9EChNSbhMaI8EwAP91E41nNqcD2z5UYSWOBixgRATa2OFx/fDoAMFr7LDRXWgwIUL1ha4B
 bt5lbw7d/HaYGO//rd8hA4xuGqWbQdMlIZEdskE5nr5VeNAXI0XgM0LreIE/rVMEAbgevZ9voQy
 lRfJKPvvegww6PctQ9/MsfHFkAEwCpa5CSeRqXpQE9mYLn46/cfOSSq7f0F4V6vgcKDk3RMnAVs
 BGd4h/bMuQYDaB6Y9H0YR1s0NQkofCAI3cuCb8puBDQ==
X-Received: by 2002:a17:90b:2885:b0:39d:e75d:97ee with SMTP id
 98e67ed59e1d1-39dec20812bmr3973206a91.5.1789395699726; Mon, 14 Sep 2026
 07:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_PNt5Huo-bk=tqdCLorUp3BDCtdGmaFJDxfVbcKx-CPoQ@mail.gmail.com>
 <20260913005048.1167-1-atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <20260913005048.1167-1-atharvatiwarilinuxdev@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Sep 2026 10:21:27 -0400
X-Gm-Features: AcwNN1U5A3gc_t-YjPsElm0l5p0KUKIEFT2aA5LkNx_lSR2zyJsX3P4tqP1oEE8
Message-ID: <CADnq5_NyBdPbavmiPVdsHkP_Oi1w7ngX0kPSNce+BWN-YkuAFQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/pm: defer UCLK DPM enablement on Apple Navi 14
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: 062bel313@gmail.com, Alexander.Deucher@amd.com, Christian.Koenig@amd.com, 
 Kenneth.Feng@amd.com, airlied@gmail.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, ed@aicharmers.com, 
 linux-kernel@vger.kernel.org, simona@ffwll.ch
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

On Sat, Sep 12, 2026 at 8:50=E2=80=AFPM Atharva Tiwari
<atharvatiwarilinuxdev@gmail.com> wrote:
>
> > Applied.  Thanks!
>
> Hey, so im the author of the original patch:
>
> https://github.com/t2linux/wiki/issues/743#issuecomment-5347204171
>
> The author of the patch mentions this:
> > Combine Atharva Tiwari's delayed-UCLK proposal for 0219 with the Navi p=
ost-init implementation for 0218. Retain the revision restriction for
> > 0218 and the revision-independent 0219 match from Atharva's proposal.
>
> So as the main developer of the patch, i would like you to remove this pa=
tch,
> as it dosent give me credit, and also this is not the solution to this pr=
oblem
> as i have mentioned here:
>
> https://github.com/t2linux/wiki/issues/743#issuecomment-5608044095
>

I can drop the patch if you feel strongly, although it is pretty
similar your original patch, it just keeps all of the logic within
navi10_ppt.c which is cleaner in my opinion rather than pulling navi1x
specific logic into the core pm code.

Alex
