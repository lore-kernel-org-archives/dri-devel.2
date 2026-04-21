Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5437F94CA7
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 20:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A4C210E082;
	Tue, 21 Apr 2026 20:18:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y/hzIhTG";
	dkim-atps=neutral
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82D8510E082
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 20:18:16 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-50d87610513so53112091cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 13:18:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776802695; cv=none;
 d=google.com; s=arc-20240605;
 b=FbKQe2DXly4AlwEnV3xtxq/sWWeLX7RZQN6hNladkw3D2qgm7zZC4S2VpWAe9z3uJB
 +pA5Fjlgb2FCu2BdtbydOlA/xnfjnxaCna9KarEsLp51p8SXosD5dSnvYJ++t98BvvAm
 82D5QalruEZtqhCTy6GM2x2VBTuMXWN2WHcMgx0G+BbE82hsnp3JDqloS2QUHWZiYQYv
 fo3ehotZeA0KCYGHVDb6DE10WatKt84m+NoRAT42ZycCcd3d0YnqdlCrXisbIn8IJOH5
 DCGdbQ1d9Mixse4qMjZQV/m4LkFOpvzH+5DOFfvhh3/DjAx4FZgtv3GYMBg92fhMLcV4
 WxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=L+8DDP3LcP2wMOz+05VmQfbHXZfy+2SE4V/Z5ATTvws=;
 fh=fvp7a33kZyL2/T9hpUycuNGTpT0B/cCO6EPLVfI2ujw=;
 b=cdmRwrq3V8OYi2kRhbH2FLgRRgwtB27PMOeRVH197L0sZfgsh/w59AWzcLPCckvf3Q
 LevNigi7NcszFNMUtQt2qyApC2OOZn5U+0ULQmY91f8F5gKwIhY910X9Nfv7Vo1J8BVj
 Nxb5rIXfxMmk2wL1pqLOw3pyrbBUV6MZHPcA8FBf6wz8tw1yN/hGeEHwACI3k4UrCMiW
 a1hTK+QPAC9b9G5RsgmZMUAPqLBwZHXNmW5kt4ejYFtcKD0Njf3J1+/dV7uGuHB5PoyL
 sUStWxz5rkShYjasSQG+jwcQA1P9iQjW4u9mNFKCLquOj7n966BzdzJ+RBzESoFuA/pL
 OHdQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776802695; x=1777407495; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L+8DDP3LcP2wMOz+05VmQfbHXZfy+2SE4V/Z5ATTvws=;
 b=Y/hzIhTGACULU4AYL4L553V6v8DTMqX07FOJyO2UmRFYlwOkNe/jI1DCtlgl+TiitP
 Qoyxcy4eV0EZpStQHW1o2F6atUGQnAkgH9ScIdg1HMotSi1AmR31ILN4UFBABxkYemJH
 lcFA2BixB8+uEgrVjhVGhDR1WVBsCdsjuh66x1fwcNTy0VgUEPPIAbRm4+L5bnqTYbGV
 BjHqAmbktd1VhWcv+49hxeH9ESWrXLAxqZCyihWFCBkrhECQF+kfhcTrMFhi6R6gVEZJ
 /I+MQrCZhV9ed6NK13yeAzk9HmYmD/ExJBENsgSHbyE3Jv6BHgifJrVA3ouqrToB52eH
 f9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776802695; x=1777407495;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L+8DDP3LcP2wMOz+05VmQfbHXZfy+2SE4V/Z5ATTvws=;
 b=tQefkzzzdr8tsSLlEyUSuUAwCIAqofOLeuzN6+Nk8YOqjnLVqIIr2jp50Tbwf7NDyh
 TI8x7XBh0zcEXXjcI2awepvXBOkEg/AvIfJrb42IuNLxxOqWdd3PlVYu1owYs1nE3PVR
 MrV8UCGeEkICwGB9GSb5TfPAX8NKXMufKQeryCE8uJg+LuCYk+6PT9yYZJRm/Il3oJCT
 ZwSzMpCZU1xixO0FARuMnJ/scm0p471dErANIT/N2StUYmf6cVXRkCYDdkLOGlLF0o2y
 85EVKz02XxI1lUgLa70m0Ac4SS5MbseGBwE7SmqCJV3eOoA5tNPArMuT10/hBULFgLtl
 Flow==
X-Forwarded-Encrypted: i=1;
 AFNElJ/UTrCkUAFPXqLWAGQah508kDcPzUs6PVC9ZdpKqLVMnAn+alRkJxibRDhln5Kk1pZZq7tb/vqS2JU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw0jvxghZ4FZlM4Zcu11wnMlJP/VIYDFIvHiWYuyznu+KephabI
 PvQVeIPJ3QpJAViIuTYGCkzCESlruLMJUDndYF0Z5N1CbkLwK6VLNPLhNcG8M4gZkmGwLmWPU8b
 y2zBspLsdocH5EH+O0Ko4WmaA3wYncpQ=
X-Gm-Gg: AeBDieu+hwJ/T9uFzPrlw3D85S+3joPCpfITQCWDxRtt90UZRRF2QJZHzR0SHhGv4ON
 be0UD9MFV1lRJsmNUkZ15gsjgmX5FLF8108ZAvQlFOa98UAGdf/KGrz9rPO+ZJQd9JTMpj+kbPi
 ULdz3Jyxz+VoUNKX/vbFiwpAugQjIPiIA2cGxY8ijrxdlnoB7Ob1avsg+saFPgXeFfM/rIyDMP4
 X+PE6Db2R6Uh1Yydh+BggkwsfCGobs30qD5Nd8lLCT8vYK+OvI66cvQfCY4p6UsDXE5Oj3jekgd
 Z+TsFcalfyq/e0tJ4ArI2kpxbcLqcdjD+EAn5z1HNpvdwieAoQ60UnKPvnn9PTS+JUgkOm1BHi5
 +Rj8oiZBDRJds
X-Received: by 2002:a05:622a:429b:b0:50d:8049:2f22 with SMTP id
 d75a77b69052e-50e36b865f5mr272215931cf.3.1776802695503; Tue, 21 Apr 2026
 13:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9ty+EifnaAF6xXLFChpc+5hZWUZJdR8zy=arPjrwjirf6Q@mail.gmail.com>
 <CAHk-=whT=pCZGWxgT6+5vj37quG7QkMUBaCc=p0G+G5pzxemUA@mail.gmail.com>
 <CAHk-=wi4EgR1CGU9Bw+4iTChK6c35Q6w7vdDE7_3zVGUQ3HOOw@mail.gmail.com>
In-Reply-To: <CAHk-=wi4EgR1CGU9Bw+4iTChK6c35Q6w7vdDE7_3zVGUQ3HOOw@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 22 Apr 2026 06:18:03 +1000
X-Gm-Features: AQROBzDov401PU8a47pZ9_IzJg3iYY_tPhxkZneWfmv3GqzXYYs5do7P5ZnYQpc
Message-ID: <CAPM=9tyFXS8qwM7RAPW2G9aoCTcaEy5RcEan0yqoNUZj79pVog@mail.gmail.com>
Subject: Re: Ping ... drm part two
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Simona Vetter <simona@ffwll.ch>,
 dri-devel <dri-devel@lists.freedesktop.org>, 
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

Okay I appear to be asleep at the wheel, correctly guess, I'll resend
it properly in an hour.

My muscle memory did a pull request generate from drm-fixes not drm-next.

Dave.

On Wed, 22 Apr 2026 at 01:49, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 17 Apr 2026 at 18:06, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > The reason pr-tracker-bot immediately told you it was merged is that
> > this tag seems to just point to the v7.0 release, not the actual drm
> > branch contents you presumably intended it to point to.
>
> Pinging on this, because I suspect you saw the pr-tracker-bot reply
> and thought this branch was all merged and ignored the mail due to the
> subject line.
>
> Not so. The branch didn't have valid contents at all, and
> pr-tracker-bot said it was merged because there was nothing new in
> there to merge.
>
>            Linus
