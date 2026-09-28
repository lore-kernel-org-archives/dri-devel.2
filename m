Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E08ECA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EA4910EADF;
	Mon, 28 Sep 2026 15:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kZVKtMVh";
	dkim-atps=neutral
Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com
 [74.125.227.166])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A115810EADE
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 15:19:55 +0000 (UTC)
Received: by mail-pj2-f38.google.com with SMTP id
 d9443c01a7336-2d747ec6185so13642195ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790608795; x=1791213595; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EQrjkRZQeuYzERNWt13KrmtO7dHmdt8dryvfZkIliO0=;
 b=kZVKtMVhN8B0ZkD9XMpY3N/eULHLeJ70BNKh8cOlulOGwRB0J5pRkyd1p+KgQeRKE6
 KbvKvXz2eC5jWzqhi8C+3u0zbK77iSfOSKk4ojs6BKeTQjTp8eRgR0p/7/qSRHcpMcEN
 ttuknoVDeYc+nK8j2J9dHPkljvXjGHe4h05TnOjd+inEwTEZR2UabgulDA7duwduKCiq
 A9V3SggbFXv6vASa1wwTl2vCgc1zysPptojPsL4G9B3IYV/oV2s/80tu/xtG/BHzfCKs
 Dj39cJ3c3F63gwzaTYEuU4I+SwZR0PSJ9i9x6nDovYrd1M8uLBfyt2giv8w6b/+pQV5X
 NvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608795; x=1791213595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EQrjkRZQeuYzERNWt13KrmtO7dHmdt8dryvfZkIliO0=;
 b=Nw+sRkJugES8eub5Spo+mFrCrz/tg9DfQ9RiYvpBpI1CYMp9Zfo/MlKKfpH0OEvqg6
 A6PGE2ER0JssBBk+W7kV0ZS/ckQb0wJLqB7l6s5BHOtl6sgC11mrHoBT8xvEjmCU0olI
 XINpc5Ln46/LTXHxtDi2ZdKRnJqxifjH153v5mtJPUEEEcNMe3uCMo3h/U49MZKnF5Lm
 4MAVzY7GmWeuiJmd0dwA/Zqi2iCFchogXnfN2haEoa7ERMHoGY/AKuigoIsN8vhu41l4
 zFCCllVcyz+DwKpyULuNaPYFC1jJOCMQ0JuuTDSpCjR3JaVYA+/fXwRJ6pfz5Smt+nmL
 2tow==
X-Forwarded-Encrypted: i=1;
 AKwUvBzG2HhS+LUb7b7kEIIp9HWHP7HGUIUI7zo+1+P1PrYFNt5oelG3PzpGRc1iMEWDsbNUNHgdMhfm+UY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIMkvu+cBtlsr+9lI7JUfQ/Zoafi3UwIbS6WKiI8HqufLCKezwW
 92cvXkTdTP+i6mMYTsuS0+9544t5puLSs05EW9GhVzgiztUzq9TVyFnZ
X-Gm-Gg: AYBFou2kMgQ0gc54InuSvWW5/gdHofD/LkUlx+nnYNxKhpXZV19KcERnBvqu6Gj6s58
 sakIDGLniOF/2NXz+cDQwlU139IY49I3Ss9AKantyCta1NydKXFxJdRRcRcxUo/ptB9IhHHqQ2K
 GH+ZtxrNS2uMzl4CP2qyC0eM2xivCqbvocLoYaWgKe1In2Uj3F33ZWj7WSaCRbfHJt6dFidHm1t
 WmbdrZ7oLVo4y9IBj7tcP8m7BOs4/qKzWWT3ewqIqBQrgHWl2KIdnjYFI4I2WSCMuxDMsWNNilc
 3h0L61hCFx31/xFJgBIchhSY0PHXICyFlMElviZnAZeVcUfZ5fzc5T1j9elstIkJ4RMO6i7rAWt
 3MI18neo3a3a75J7/g6aMMYlBYPBKBA1zL8WKd4uA/D/NMJ3OMTsk0MHn3xqe3Jvt9/UzmFz+/c
 a8AtbTI7ance+96yUasfP+h599F89JmvmM6GcuXSceNd9DQ7APKItGPh15hfOHDxb/EM39RST38
 a3KzaGUiVmfcao+LUmoLmIicBF6kXKwuzIjGZ73Ki5tG2nDMg29sMmmaoTo4f6Q/R61Z79pTjXN
 tTTcrdfswYlo0FCXXwkjdZ3sauxjZTMbR77FrjU+02bPn3fEAcDKrVnT4bs=
X-Received: by 2002:a17:903:1987:b0:2dd:3ddf:b87a with SMTP id
 d9443c01a7336-2df7da68a41mr101388085ad.0.1790608794891; 
 Mon, 28 Sep 2026 08:19:54 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df91423df7sm43558615ad.43.2026.09.28.08.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:19:54 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Youngjun Park <youngjun.park@lge.com>, Baoquan He <baoquan.he@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>,
 Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Yosry Ahmed <yosry@kernel.org>, Barry Song <baohua@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-api@vger.kernel.org, Alejandro Colomar <alx@kernel.org>,
 linux-man@vger.kernel.org, Karel Zak <kzak@redhat.com>,
 util-linux@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, "Rafael J . Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: Re: [RFC PATCH v2 0/4] mm/swap: reserve swap areas for deliberate
 offload
Date: Mon, 28 Sep 2026 23:19:44 +0800
Message-ID: <20260928151944.2686626-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAMgjq7B7jem_dwtUEX7ZJPQm_pKBegR6WS9+B7nFp-gZugpUng@mail.gmail.com>
References: <20260926045517.3458413-1-matthias.goergens@gmail.com>
 <CAMgjq7B7jem_dwtUEX7ZJPQm_pKBegR6WS9+B7nFp-gZugpUng@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Kairui,

> Just like we already have a "swappiness=" parameter in the reclaim
> interface, perhaps adding a "swap.tier=" would be better and much
> cleaner to achieve the same goal? Based on Youngjun's work here:
> https://lore.kernel.org/all/20260916183437.2946306-1-youngjun.park@lge.com/

Thanks, I think that's the right base.  I tried it: on top of
Youngjun's v11, a "swap.tier=" argument to memory.reclaim is about 40
lines.  In a VM with zram at a higher priority than a disk swap
device, and a cgroup whose tier mask allowed only the disk, ordinary
reclaim in that cgroup stayed on the disk, while memory.reclaim with
"swap.tier=" pointing at zram went to zram only.

What it doesn't cover yet is reclaim outside any configured cgroup:
under global pressure, a cgroup nobody configured still reached the
zram tier.  So for v3 I'd like to add a system-wide limit on which
tiers pressure reclaim may use, on top of the per-cgroup settings.
I'll wait for Youngjun's v12 and build on that.

Thanks,
Matthias
