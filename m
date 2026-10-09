Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923B0CA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 04:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D38E210E0E7;
	Fri,  9 Oct 2026 04:21:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RRmXFF1O";
	dkim-atps=neutral
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com
 [74.125.224.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B26E710FE59
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 04:21:54 +0000 (UTC)
Received: by mail-yx1-f52.google.com with SMTP id
 956f58d0204a3-677dbe051d4so5681173d50.0
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 21:21:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791519713; cv=none;
 d=google.com; s=arc-20260327;
 b=cyJTx3CbUtzetH50LG+K4S43JDTFP6cB/H9D3prLIRyvONFj4z+FR+7k6e9hp6b3ss
 4Qaaq/LLNPT34gZYjyx/BPGZsewXdgAMGcKn45ZImDSlVDqk360mNlXZXQcn8jziHvJs
 6O/nRPxcISZBkH8JocEAQY6aJ6DfQ4vjMEYjggo5HTE9dxml7A23T6qpFH7YN6eZp9zc
 iN7nienSMqOsZQsfedDY5+DYC1TauMh7P1VDQu2N0TnYctZbUtx//uyMT3uZq0WXOxWp
 ngNqt0oj8b335SAiE0DlVpU9QCt5WrU8fqL9QvBcmerWnbcwEg4Kzpe4BcYeVelCc+lE
 E4gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BywDXOPv2ssWSV12Fq4ovlFzbKenjlyEsA0nv8jqMGk=;
 fh=Hl0chG7E+1m37j6iEdmZ1JxUm7u7II8XxRhTr8XZV3o=;
 b=G3A7wTpiO3Cngr19pMSX8QHVe4fa6yMrp8PmczUdsvCyfq3rdRwH7TfREMKbndzNdX
 eOQnnNg9H2ud7VQPy6fAbbUErG07D0852mS+DReXQCkQMeX0CIzmIPtg9rT+ZJHZcF1W
 O919RVpuvzkww42+/cNffhlTh4nOUo1pbiIqW7YtavkmrXwsRAtg/6Dd9rUeLrUQrDY0
 VpPOsxB/ijWszAte093mTp/yS0kE8B0vIiKiEWQv2yVFz/m9cpV1q64YWXj7ApT8H/rq
 YGH27R/NZJeFjNF1KqJfBNCgAcFkr+wdOhS5swP/RAmPkQcIzCvCPZayOGgT4CFA5+wM
 VOPA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791519713; x=1792124513; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BywDXOPv2ssWSV12Fq4ovlFzbKenjlyEsA0nv8jqMGk=;
 b=RRmXFF1OoBnXPaNeP5em4+ZuVVGtylcdVcRErALTLeOOkWsKvJFCPoG1uDq2ak7Vky
 il4WkRdLJrRRjZcC+0sbPOfJkprEGj2q2PosAkDCyfeFbHXBYGpGzSeGfu43bmxahc/W
 T+mbPoO9UdAxwyj3sugUdXJQpFL8gZt5nZrYGtRBqExk/JmY/7XCucRtL7JWrp6fZCuX
 v30Uf454mZ30OniVqgHNKsmMdRhCwYNWt5I+IkdK4ggb3rrzNuKj3x/YU5nV5CWpIIme
 G6g+HhzA6hsXPD6A/QzTEBKP0MXGk+u91gxRXN1u8b8LB1/G+l6VmuG582G/n+wtzWsN
 Dp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791519713; x=1792124513;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BywDXOPv2ssWSV12Fq4ovlFzbKenjlyEsA0nv8jqMGk=;
 b=lE/U9Yk8mhdrBx8aESePgCBfiQ8c9GJV9Cqvkqiw0+kGv7lTDmV+fTJEfro3m3yhZm
 6tYDXlAK2OVUdgX2BexfZ6h7mobry+yi2/hWmPqvVIkifih/0q7ULiOFhHZ2ouMm64/D
 q8KQJ40QDGrJYs3W31GsFUoFFxuoejds54Ypx93eQoAcHZxQgS0BsClSI0s02MtSc+kP
 j6SjKCsQ9vvugv6esCFVR308Si8WgCbghm/UCspva9wPRE82iCUhBgbF+Fwuywo+ZVPd
 aadhlt9/LAheg1BKKx/D9joMDhJdU1bszXcBt+rLjKZfO/MruwRdUyieKSC4jGO2zp7i
 SRFA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwd3fwpd631B7a6r45qcFhwIAKxMdj13zzqq1JdY2xSnnXgGAZ7ymNLaA1kj2tZZssqbFxozbf+kbE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI7RmkNlt3FH1IaGoi9/uuOQJHsqnEm2rObRt6njCvKbYoi+M9S
 9k9gf8emeyT0FvF1R7ECghFM7CrqpzeZl5bQsl/nQqxcmuuNuSNmaw13T3rXcQvEvEBNdPcgeFw
 pbyLAreaDGfQiJYWQZ6I3CTTm8BNPYaU=
X-Gm-Gg: AYBFou2tgxkHOgxSuFGGgEi/mt0W5O/cBuDOxW0Tqc8a/6MRwwWfkTw4OfyGUfibmzl
 FGN6yj2/r3sr0jARZJS3JDBws51wqawyWlBjLTnU11vmdeeBmxEeQj7HT3/4qi76z54l7kD1FJP
 nMC7I+guA5tQ8fUZgtXHIfJOHKjSrV7qabspBgbu2okkjZdf2gZ0/6e18Go5hV8Mzy18UorAJ3W
 UbYh36GcP6LnnFyAOula6wxuY5nWEXhbhB3n1NiUDCQFiOqO0EbhQyLYSZ78BK31VesUXeknYZ/
 fp2HWQqm12LX5FvK/DCz4jBwsQEh4Z6wJxKC+gRwTmnQbQtx/aah7ppyjQ==
X-Received: by 2002:a05:690e:4509:20b0:675:3142:bfb9 with SMTP id
 956f58d0204a3-679362a00abmr161562d50.109.1791519713466; Thu, 08 Oct 2026
 21:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20261001-pvr-fixes-a-v2-0-f58254e5dfb8@gmail.com>
 <20261001-pvr-fixes-a-v2-2-f58254e5dfb8@gmail.com>
 <64b915fe3c794567a04c955fa89184204e3b9552.camel@imgtec.com>
 <CAKbEznvDanJtt8yEL2UmTeLpA1SZOT693E6AD1Xau+mU4Mztuw@mail.gmail.com>
 <67ab8185350907d6fc6ff15ffcef4012902e0d96.camel@imgtec.com>
In-Reply-To: <67ab8185350907d6fc6ff15ffcef4012902e0d96.camel@imgtec.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Fri, 9 Oct 2026 13:21:42 +0900
X-Gm-Features: AclHuK8MEV-5zdcFNHIWE-2Un_-sTcc-b7az1tB-8pxj_ak2vbxL8zBUg9oyHpk
Message-ID: <CAKbEznusAuyr5wGKDw8f7rm_CtKJN_19fLK9LHNRVUvSbzjvTQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/imagination: Size page table preallocation by
 device address
To: Alessio Belle <Alessio.Belle@imgtec.com>
Cc: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, 
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "simona@ffwll.ch" <simona@ffwll.ch>, 
 Brajesh Gupta <Brajesh.Gupta@imgtec.com>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>, 
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, 
 Alexandru Dadu <Alexandru.Dadu@imgtec.com>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>, 
 "mripard@kernel.org" <mripard@kernel.org>
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

Hi Alessio,

> > I'll address the rest in v3 as well.
>
> Sorry for not waiting your v3, I wanted to be certain of having these bugs (OOM
> panic in particular) fixed in the next release candidate or release, so I went
> ahead and applied these patches to drm-misc-fixes. I've only updated the commit
> message for this one and left the comment update for another time. Many thanks
> for your patches.
>

Okay, thanks for applying them!

-- 
Thanks,
Gyeyoung
