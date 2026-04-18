Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4E9F99C70
	for <dri-devel@archiver.kernel.org>; Sat, 18 Apr 2026 01:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7254F10EAE9;
	Sat, 18 Apr 2026 01:07:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GnNLD2Gb";
	dkim-atps=neutral
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39DFF10EAE9
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 01:07:12 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6729c6f0ca7so1675864a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 18:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1776474431; x=1777079231;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wm5VYK2EiBRWqrLDfGC2KLj896pADPvx2iw+mUCFV/g=;
 b=GnNLD2GbTsbV+Y0Ii1aQpPIn8ESiWUJPKELVZeU4/3/pCcCv2K3cJ71a8DVnzwUNBM
 LUDW9DkM8nd8I5pQduGJ+O+EHhnmTB0YL0i6/W/YyeJQ8B3vrkzp+zFh3nhcTLqWPMQ6
 XzWz+HKOQDZ3Vwp8AAWNfjEgxJZDKONlbWnrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776474431; x=1777079231;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wm5VYK2EiBRWqrLDfGC2KLj896pADPvx2iw+mUCFV/g=;
 b=V+5s6IvrTbolyPQdLdwnDou8seEPCCnohWtx8fbMi+4oteEqYL5K2YaEa+Kd9DmtZd
 VNWl6JF9tX/JmvZSnrKpq81F+ApwqcMBT3GcIAStGyMOHLg4qGgVHkc3BsetAA7eDpdR
 GU/0W/ekg7MeWz5Fe3WhVPZ4GjOEHTv2HMe44dwixZdTGeFc0M6qM+G/kTh15ub66KV4
 e5jzsw1lKdfoKsRApxDPgYowRjZ3yncxW2K6ngATplPoLCpwzcpkuEcMiFKTn0bHHQyi
 BLZjE3TNq35nVtny28shMCqmkdKWWCJW/MHDR+U1WJsCXjItQwiifgttyMc2S/p+9TP4
 J0xg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+yiTI0YHfz1pQ4T3ASy0CKjS+9tPh4q4nqga6HWfrHemcBUTah2urBeeXWgUOQSVwMlmJQ/ofF3V4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxo20I+mYSxZlzBUtPArll63J3cQ7ttEYrlRvOC1/2EG7/TiX0T
 s3vQXUHvdrLchePs7e+eD6PlqHQNTZ8rLn017sGi48W+Rsgm6g1yUgy5xnQXjorMtnxcFdaeyN1
 rbS4iH3A=
X-Gm-Gg: AeBDieuqCpYgte4aWuYgDNj+/8Wo1Sipr1aMESzK7qLXcKAmplr+gOs9rhtRBOpxLDI
 UQ3h4B47Wpnm4XPfBE2jC58qewP5o6D7ZSvhd9N49fX3izBLvhD+POy7inm8DxBJCjkhf768pSd
 k+lmlnHBQ0AxS+nvIDC1EDvpRTHLMm8wXmrN0Txf6Vq0RB6Sm6++0aci1Mg1n2C/e4nec82/qpj
 NEI4+nXgpyPl0oS4uRW89SSvVBGf4sCKZPNaCz1uHdplhw8tQ1pItSpJv+bg0u5S2TxYjMFe8NK
 BEwwv9dLsIqubrVoqzS4MVQz/i2kGIEhlbTitklBYl3qAbDbAPkXudhktDOKs5MttUXRVe4zR/R
 vxjqMZ+YK/uebr8FNQD2Va46Zd6UiViC2xzv7HWkMmC3fHp0Omb+3Cwi+KXM/vLZpPT0zHVMFch
 t+WiXX4U1gglM70AdDC5u892Ghvw0ePXD862Sf60cnoDWhwGijKnHTrkSOxxHglZGcYDxI6uC9H
 nG89RS3dfEiuTYKT/klPg==
X-Received: by 2002:a05:6402:1f8e:b0:66f:9f63:e537 with SMTP id
 4fb4d7f45d1cf-672bfdd3f01mr2253707a12.19.1776474430910; 
 Fri, 17 Apr 2026 18:07:10 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com.
 [209.85.208.42]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-672c47fe836sm710220a12.3.2026.04.17.18.07.09
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 18:07:09 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6715006f4f7so1989483a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 18:07:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ88sOaleph1tCI6VbU1SN7D7pQvEAhn58Bq5OQY52PTOgF4YXOzv+hVl3uu3p+H6Phj77K4+3WcjBw=@lists.freedesktop.org
X-Received: by 2002:a05:6402:c4f:b0:671:a6e2:97b0 with SMTP id
 4fb4d7f45d1cf-672bfc0f33cmr2343391a12.0.1776474429253; Fri, 17 Apr 2026
 18:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9ty+EifnaAF6xXLFChpc+5hZWUZJdR8zy=arPjrwjirf6Q@mail.gmail.com>
In-Reply-To: <CAPM=9ty+EifnaAF6xXLFChpc+5hZWUZJdR8zy=arPjrwjirf6Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 17 Apr 2026 18:06:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=whT=pCZGWxgT6+5vj37quG7QkMUBaCc=p0G+G5pzxemUA@mail.gmail.com>
X-Gm-Features: AQROBzDZgDOdpL5YHVNKS4gBK2ksONSAOOpdPNjvuqAv8tPSDqLn5QbLK1KS__Y
Message-ID: <CAHk-=whT=pCZGWxgT6+5vj37quG7QkMUBaCc=p0G+G5pzxemUA@mail.gmail.com>
Subject: Re: [git pull] drm for v7.1-rc1 (part two)
To: Dave Airlie <airlied@gmail.com>
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

On Fri, 17 Apr 2026 at 15:08, Dave Airlie <airlied@gmail.com> wrote:
>
>   https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-04-18

The reason pr-tracker-bot immediately told you it was merged is that
this tag seems to just point to the v7.0 release, not the actual drm
branch contents you presumably intended it to point to.

                   Linus
