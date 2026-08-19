Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFEAC5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 191A110E579;
	Wed, 19 Aug 2026 15:23:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G09Xc/J5";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1887210E56C
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 15:23:55 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-84f3ab8750cso955868b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 08:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1787153034; x=1787757834;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=V60tevbddFfWBo1AUJqlLkHLzjHgSzjesmlx3BJhNy4=;
 b=G09Xc/J5JWcPghJx1QoNRem09ex3k48dDelP6TI1xUkM9RZJ6Hcx4vqLBPJms1x4Ej
 fX86y2eU3mQhjj2DLfdKJzYTNVTe8tHAIz0/zkEB6GZCeWS89Wq/Odh730OuVqUWtbCi
 3HCfUi7fSHrdt3Uz4C8RIxt9//bJsdh9+i99s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787153034; x=1787757834;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=V60tevbddFfWBo1AUJqlLkHLzjHgSzjesmlx3BJhNy4=;
 b=Xf+/fXJNZIhRFKW6/BKMHIr3whSdx4P1h/Rr5a1WB/D5tKI4E85b+qhBqBsZn7j7sy
 HWLXSmCHR4FUBsnw2UizdOMvc8lwaaf3exTwdhJ07q8OrwHd1oXWQ+JaSAm8eBdBM9yB
 aleFV+zps95hGWWEEDF/gN6gucIVjiZG6+9++4KmaB/BHO/Wyp+abV/HqHSBvnc3wG58
 0n6PpoQF92EOiXGyW7cH3KV1EravW9pNMzOKpmBkZVzxopZDY/Rzt4+sahXK5Qb5/vLT
 TkAwJqjicj4+5f3uTTgPKDT1qqpp6AHfHtLcLNAwNxuZOU/58gUeaP0Lq8Mf14tYFq4R
 nrfg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoDHhwwtTWQoTGtZTEAl7ZnFP4SsBDqbfv6cX5uUokldS6cB/XKxTXGYHP57ozbzQugpLbWUVC4StY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7BKKFHSboLccr70zI1OXijm2G3Zlga34ea2ein9uaLfhh7N3z
 xHD27J+sUsDaw+E+bjt132EA8mlFK7FOXj+2kUgpS6qepZRcYV2TGf9eBEdSd27gsSllJHHchEI
 A3Wdg7YM=
X-Gm-Gg: AR+sD11FZ+X2FbUnHy5v3WOEFrZJYsnZVWrorJ0MdPUTKsA0PG49osUJYJXvYnlf73e
 H8xK34gbbacKElCE+e7kK9IEnzilyUU+swnjcTkodUtwqCI6K3hx0n+VSyrkI06e8zUb6G5CwN1
 DNMSmW9AFW7Ho10UtWYmuA+zrYKDtuaxpvyKVymGr7Jw8kkCOOvJ8MJ0C1vbMidz7D8uScweFFo
 rpRkEqG8sCR6IALh6/ZseYIL8Y6Tx/WSXQZy3F8aRwN4b0vqcjPEJmwL1y7ebNEk4Vszr9rmaHY
 nycaJ776H5SL2AeQse9vjaJu7XDa30bSN4rPRYuOaVExmFgcQ/R/UWPpW9SvD6YNEOUEq7CqbOD
 MhG7DII6YRyY+IQv1Jl6TGyMOBJohN4+cv23E8ZK3jOzzJz9eocVdDU+GOFXXNT6l6z0dRBkwW4
 kCyhhPabe21/4p8uIw/NghnGUH+vksZUQ28/Dqo6If8TP/79nJ9sPd1G5XjBc6k6GUyB7ey8q7n
 Gq06Zyz1cKhBvpz01ZFh64VZ2vJ28s9eJ++Mg==
X-Received: by 2002:a05:6a00:84b:b0:851:8baf:5b29 with SMTP id
 d2e1a72fcca58-851d38ac0d4mr8350343b3a.10.1787153034339; 
 Wed, 19 Aug 2026 08:23:54 -0700 (PDT)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com.
 [209.85.216.51]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d366fa55sm784470b3a.54.2026.08.19.08.23.51
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 08:23:51 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-38e041ea211so1255717a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 08:23:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rpz0aOnPyGFm2Han8qBcjK2IGTCKAbyA52zOWceryCciECIaE2DjMYaEqkTq0yprwCu9NUGtI5OrY0=@lists.freedesktop.org
X-Received: by 2002:a17:90a:f94f:b0:37f:fdc8:71b4 with SMTP id
 98e67ed59e1d1-39580840397mr10513690a91.2.1787153030497; Wed, 19 Aug 2026
 08:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whiv=b+dAvjaZDsZkfUEzjZMSSLExDOWVcbJ0exsCj6_Q@mail.gmail.com>
 <6874536d-ab1a-4dd7-a23f-2a071bda145e@lankhorst.se>
 <CAHk-=wj5aE1yVMb8RM2AuNUHSMnQDaGT+Vy+At5ds1vxBA+Kng@mail.gmail.com>
 <ahDAErDSE-SFA0oM@intel.com>
 <CAHk-=whX59mtUnU2ayMWoDQX6Ee2NXLK2NxQ+dZnb-Qc_mF1hw@mail.gmail.com>
 <af9278d3-4002-4e09-9bcf-bc75d1cf8145@lankhorst.se>
 <CAADWXX-pfvA3mKWSjdahnihAXHQB2VP9BOJDCXonG3Q_nxurLg@mail.gmail.com>
 <anYZ8nUFP5dnRy/h@gsse-cloud1.jf.intel.com>
 <CAHk-=whyk2-u_1bTh5ZTeX6jW3HgAtjJh0mV_oWtgsqCe=3w7g@mail.gmail.com>
 <aoWHKmz17HQo2uy5@gsse-cloud1.jf.intel.com>
 <CAHk-=wjv7SCjtg6JGDabGMXdqobx+WHogHfQeMPF2g_HmAU5qg@mail.gmail.com>
In-Reply-To: <CAHk-=wjv7SCjtg6JGDabGMXdqobx+WHogHfQeMPF2g_HmAU5qg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Aug 2026 08:23:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=whskfzdWdUs3NwYm+e9py91xdiG5mLfYf=g_6QLpdaP4g@mail.gmail.com>
X-Gm-Features: AcwNN1VK8xm2EEhJ71tHkaXSYqe2wNMVKK0IEd-4YCwbEX0AGK9JHqpkPEveNyc
Message-ID: <CAHk-=whskfzdWdUs3NwYm+e9py91xdiG5mLfYf=g_6QLpdaP4g@mail.gmail.com>
Subject: Re: drm: xe: Kernel-submitted job timed out
To: Matthew Brost <matthew.brost@intel.com>
Cc: Maarten Lankhorst <dev@lankhorst.se>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-xe@lists.freedesktop.org, 
 dri-devel <dri-devel@lists.freedesktop.org>
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

On Wed, 19 Aug 2026 at 07:46, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> With the standard Fedora 44 kernel, it also hung, although at a
> slightly different point.

I take that back. It hangs at the same point.

I realize that it says

  GuC firmware: xe/bmg_guc_70.bin
  GuC version: 70.72.1 (wanted 70.54.0)

but that bmg_guc_70.bin is the newest version in F44:

    intel-gpu-firmware-20260810-1.fc44.noarch

which is just a few days old according to that name.

              Linus
