Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB39FCA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A6F510EACA;
	Mon, 28 Sep 2026 15:19:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BU70/X1x";
	dkim-atps=neutral
Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com
 [74.125.227.168])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4282510EADB
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 15:19:35 +0000 (UTC)
Received: by mail-pj2-f40.google.com with SMTP id
 98e67ed59e1d1-3a0f64df6a6so831050a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790608775; x=1791213575; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b0NvfzIhMgoDaAcmLO9lnbeC2A03mNxAZEcGsZ2ya18=;
 b=BU70/X1xK0iuUog+Sw9JFwUI+E4Mx6V0IERHuY30qfnqQ/3G2Sk1L7OKZarTlTNsHw
 UahOkqRnO81e/QfQW7Z/v4yqIRQCQW9JOM9S2UVOMGCKpaLZdg0GTvejAvmHKNUe0sps
 A2IpVYSI2CRblq5V/sb4i3wAkhX2VWbNALEZngKMEZVw2ofGwb7Wg+ICmm/gSMnfAXAM
 +2NSC0X02auUMNvcy6m/RsL4uIIWybKRT61nVTnEC4oNLNkPBkJxgX+fwKQk21d2p2MI
 gwfV5EW9tVaVWuROd1tBen6kYsAU2HRjDzGeVFrCwAbxzD+ukVXhgeceGT3Au/ajAK13
 S8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608775; x=1791213575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b0NvfzIhMgoDaAcmLO9lnbeC2A03mNxAZEcGsZ2ya18=;
 b=Q18u/6DMx41ZSYiVe2w9IrjABKCk+6hD6HqJKS+Hs3IuZSs2oFc9Gggs8527WIc33s
 +MSO/HUqx842Gbh46RE4FwSRCa4NY2oeW/Qm+NwgukgkuLidnYchmwobo8G0ZOzmzsWB
 dC8yPyJNhp/N18O0SHZuFhdEiF9Viv+8iov2k5CNNQ3xcKVFRvgtN4d+eCjDDsVaXc12
 lPkuNkC/XeUzlTZrDoDIAETG5GX+tBBOs+rjcf5PGNh2vzzB8mZZNhaC760Bl8JoyC3U
 dJ29Cdowg2HBqQylR/pop6iG4Kh3LfW1lGcmMvwGLMojjBqnxmF49z9RASuVFQ6/JReU
 9o2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOHqD/EW+sq34+rAMJUWjjssACjnalBa9SDKibUOlCzjky/VdvvF3SET3tbXcNgsWnqyhsnjENuKI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLeDpssHZVqQmNFzD9x4/DoIh85s45fcOKplwuZkyu4hCtPUpHs
 1achmlzySQuAeIJ4h9hd30EgR6Q29oHldTGyV2BOqUTE/y7O0u6LCyB2
X-Gm-Gg: AYBFou1aIrHpyVEz2bOIFPEr161tEghi0kXiejejs2735ZSKFycyiUAEbgAGvkxR5++
 W58vBS+ycwV+ZDsrVS5vRIIzyp1AUEnscDyxU/CkqwhAl0EGPCoinHSlSOGXru7b52ylLbrXfdO
 2SNVmGm/rCM2zgRK8YdaGJJccOuPFX3RLLLskWMBU/pNvQ/ea6zGVe2UPfSqahwPJktZX+XpObB
 q49LuzjR4aeqWtRtekZU5GPT+SyqL81W7T79yO0OgdoIRiv/gc6HALbr4FXeNhEi6OL1y9SNdR/
 pmzedufj7+PcjCE5H5Ja9Yotl2NJSXxfI6+KsLH72izUdge0UgKzB/xXL8L/f95JsBJk3O+q1R+
 qvnEVlwUNpLAwOyk/ZWK7vmxh+xLGbclEN6Qji0LtXPqoIZ1P7TEWMQ2XaNh4K1BPWJJFktCzjH
 czPX5TfqNF01V6Z7mODVJslE3AOfWszFQ4BUk9PfavRMILLmp9QeapHgAflAdHHm4J3GcoEQJaN
 +dttOsVk4dAvsLutCl7MNgQ7c3tDog28a1R/queMo6sLkZEpztbnj7Ey1/BLUzx1DB0IwnHonAm
 XT8UpdaS7AIux/Ftl1mDzFzOUYO6DIUAtmJgQBH9N/S3JtjCklJWl83aG3I=
X-Received: by 2002:a17:90b:384c:b0:39e:5acb:2849 with SMTP id
 98e67ed59e1d1-3a0bb576e5cmr8742632a91.17.1790608774215; 
 Mon, 28 Sep 2026 08:19:34 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b99e5220sm20891502a91.16.2026.09.28.08.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:19:33 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Kairui Song <kasong@tencent.com>, Johannes Weiner <hannes@cmpxchg.org>,
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Yosry Ahmed <yosry@kernel.org>, Youngjun Park <youngjun.park@lge.com>,
 Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
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
 linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] mm/swap: reserve swap areas for deliberate
 offload
Date: Mon, 28 Sep 2026 23:19:24 +0800
Message-ID: <20260928151924.2686290-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CACePvbWM8kMjtJbH4vc6Qt=TBZQ-0d-Yj9NOtkepZmtNN3wd9w@mail.gmail.com>
References: <20260926045517.3458413-1-matthias.goergens@gmail.com>
 <CACePvbWM8kMjtJbH4vc6Qt=TBZQ-0d-Yj9NOtkepZmtNN3wd9w@mail.gmail.com>
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

Hi Chris,

Thanks for resolving the conflicts yourself and reviewing it.

> What is the high-level user-visible impact of this series?

Being able to use more interesting swap backends and logic when the
machine is not under memory pressure.  It is much easier to write a
swap backend that may occasionally allocate memory than one that is
guaranteed never to, so today such backends are either unsafe as swap
or ruled out (btrfs, for example, refuses swapfiles that are
copy-on-write, checksummed or compressed).

> I am curious: if we never run out of swap file space on the
> non-offload swap area, does that mean we don't need this patch series?

No: running out of conventional swap isn't the point.  Without the
series, any active swap area may be written under pressure, so a
backend that may allocate can't be used as swap at all, however much
conventional swap there is next to it.

> However, direct reclaim can use both types of swap areas.

In v2 it can't: only memory.reclaim, per-node reclaim and MGLRU's
debugfs eviction may write new data to an offload-only area; direct
reclaim, kswapd, MADV_PAGEOUT and DAMON reclaim may not.  But I think
your suggestion to flip it round is closer to what I want: mark the
areas whose writes may allocate, and keep pressure reclaim away from
those, rather than tying it to what started the reclaim.  I'll work
that into v3, together with Kairui's suggestion to build on the swap
tiers work.

Thanks,
Matthias
