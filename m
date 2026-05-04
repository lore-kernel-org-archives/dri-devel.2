Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128DDCD3423
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 03:56:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F11DD10E0B8;
	Mon,  4 May 2026 03:56:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rw/fKRby";
	dkim-atps=neutral
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE16310E0B8
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 03:56:37 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-8eb5ad01402so407612285a.2
 for <dri-devel@lists.freedesktop.org>; Sun, 03 May 2026 20:56:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777866997; cv=none;
 d=google.com; s=arc-20240605;
 b=fRa9ETZ9MKcYlIVV18M5T63GdejJ9T8o7SOC9tuDgda4Zqg/PrrMADsDhvY3E9BRkY
 D/9qz6ep0KW6pd0mGrYGxQcHj+tcQXy60hvbfDTHpe1NSeKqvyUnBk048b2GaqSju/3g
 Duo2lUxNWErk6vDoZGRCTkk40qkKjrNSMn1aN73t8M3DA+97mOusQcZ3u7Gk39hxKrNs
 bY0Q4GN+N6i100BCa6hL7lns4CaWmWjTdzugfsCOZf89YApQ/YuOOzK5+U9b7Qxb41gl
 zNdh1eX4i8kCF871zL6frwJzw3Zs7OXK/QHD9f3S+wgfpOKoctqNvW3xi5n9eILX+ZlB
 tQ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Y19V3fSw2nLa3PgRwVgUrqV+zuSj+iC5aF2Sowscyc0=;
 fh=e7hEWizzv6Rs1YAfPlEG2HhnKkE+1fdZa5ddQEyYZ6k=;
 b=E0tfaSH2E7ZX038cQoaLmm9BxOY1tP4UUgNbCCkWQXhhqKi6qRKyNCTFcqKyBL1NwO
 eigoF9Rg5HDcjvYhT+K8AopvOFL8j7jkPVn940oS0Icqx2AZMJbwjmYPBtfZfwxbM3ZG
 TrrV00mNTyOY+JGK4HvcnyZIszBgSpr6opqTFtvn5CqHKx9JXcwGCAFEAVBQMvwomP01
 yfUqtQ/FnVqd1RWDl/+KPae4s7Y52Ca0b8k8Aa1ot5UP3Qz11NWIGWdQyxyEThN88OeQ
 kNFNrnGjUGUFfI8xVXQyLEum9BNjxeeVsRAoMUpkpiVJYEzU54/JxGWyVExFs/BmabhO
 PkWg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777866997; x=1778471797; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y19V3fSw2nLa3PgRwVgUrqV+zuSj+iC5aF2Sowscyc0=;
 b=Rw/fKRbyvjKXtg0WhWXx+e7J40C9omuvawP6HKVqva6Bt12Ej/YoLcIWva1RFmBB1L
 PkVs+s0h95HgEBmMpUXzdjjd6BpfUi9ev15azrAB0k9XtDaQwqxdRT9ldC6J+JPjyy2V
 hXzZ2lKnItYG/F22kDaAx+vy4DVROHxr+YDg3wAEZQUw7MuSslKjvcRKyzG6JPTALfYS
 HgzxwTvO/wywjaEAvUl7iawFIXwNaQBgXAAeui59+kQTH7kPA0fpsZ8bI97qYpx0fws4
 S+Pe41pVBCahtLUj+DLhZGc3V122xu9oUVnUMJkObxvReL7XCW0gfbo7klu7T6YtU6IT
 qRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777866997; x=1778471797;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y19V3fSw2nLa3PgRwVgUrqV+zuSj+iC5aF2Sowscyc0=;
 b=XgsQPc6nhSnLPSaRnzauZ0wC7FlDZZ462DWi0uvsRIk/teBT+EX1hBVc6Ekysd6ePX
 jDr+9GaNLTojSHThkW9EunOFaUzIoa+vDTq9GisVpUZZGGNZ3NBdKXdohyrePNTV261N
 TwB9QBxtnIgtHqrUXmfoPEjDQhCPP0JxsFc8lLs7Lq3E0DEXsHzGcZRvniRgcEmIohyl
 8y4yse2P3w+3nP0L/OqwMLU/5z6OlZ0v08UhBoxnBZKOTdzktNRHDwY9gbHE8CC4/oCH
 9xBnQVm1rTeGPWdwekEwC0D7or4DtE1uyRh+F2G16khxVj6MsRODT/5Or4NjS/b4XA8H
 uhgg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+r3hzzxQBc77urQseuaNVjjFgnUJDh4y6M1uKtDKLXcVDq9pDJi+6mT48+N3Y3OmjyS0nI7dQuK4o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjxVCxYgJlhf++5BY7v7HKN5jkz8IP8gcnVWvrwM6waOeA5lAv
 LicRh2IaWuLyynfhC0ttN8kr+ru1s1QfcQwPTXaiMMw+Aqc12TxG3LbRBRAhkXGqVIpP9t2qbEB
 4R4WQlYlDa6p+TxUIJQPIC551S8woQkA=
X-Gm-Gg: AeBDiev6iEMNn5Mnp7gYj+nQizNnENX+4fkb22XHR++z98cujtDtuH1irWuTg7vzmMl
 CECys579htiGVg8dsGEj5yx2TupOf0jP3nvSwBCBBQa7PXqZ6MWc9jwz4OOh5VR/+KA+supHJXD
 dSPrCBS0GPPrb/DZRhvBH1GTgOrXZ/PxJsCKavabgkkQh6yFI8xK+xGuCDyOhaNJ5lb47mQs743
 2uiGjyW0OQy8OTP8MQmtmX1tTXfEmGxlxPCw/Fg/pjVx7PVQD/VtPd4Ro7kOJHR08F24MkBovu6
 WSdyxnL8LNFlebQO8gk4N0X3qlXS+qecp+A/DH3e2hthS9ZMdeypI7vAXYGK04TDU5zL/BURvW2
 YdXGAjE6O6N5y
X-Received: by 2002:a05:620a:4150:b0:8eb:605f:6cd6 with SMTP id
 af79cd13be357-8fd18834d2fmr1201121185a.60.1777866996695; Sun, 03 May 2026
 20:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260502065338.2720646-1-matthew.brost@intel.com>
 <7f927ef8-2d3d-4609-926d-b18535794f72@panix.com>
In-Reply-To: <7f927ef8-2d3d-4609-926d-b18535794f72@panix.com>
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 4 May 2026 13:56:25 +1000
X-Gm-Features: AVHnY4I1DugeXn269d7bGPSVS8oaqFDQvQNdyXAeNtAJBZHN4bL6ea4BTB9Etjo
Message-ID: <CAPM=9txfkvL4pWW53Pk0OtJ=vBaa-SCv6npSCK5f0zuOOJUfSQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/ttm: Fix GPU MM stats during pool shrinking
To: Kenneth Crudup <kenny@panix.com>
Cc: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>, 
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>
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

On Sat, 2 May 2026 at 18:14, Kenneth Crudup <kenny@panix.com> wrote:
>
>
>
> On 5/1/26 23:53, Matthew Brost wrote:
> > TTM pool shrinking frees pages by calling __free_pages() directly,
> > which bypasses updates to NR_GPU_ACTIVE and leaves GPU MM accounting
> > out of sync.
> >
> > Introduce a helper, __free_pages_gpu_account(), and use it for all page
> > frees in ttm_pool.c so GPU MM statistics are updated consistently.
> >
> > Reported-by: Kenneth Crudup <kenny@panix.com>
> > Fixes: ae80122f3896 ("drm/ttm: use gpu mm stats to track gpu memory allocations. (v4)")
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> >
> > ---
> >
> > v2:

Oops, good catch,

Reviewed-by: Dave Airlie <airlied@redhat.com>

Dave.
