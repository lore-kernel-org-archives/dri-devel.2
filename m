Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBBFC4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 05:22:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 871EC10E400;
	Wed, 22 Jul 2026 05:22:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="GMMXZ2fv";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 696C210E400
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 05:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784697729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zUwBUqB0UJ0jFJVhl6+u41ye61PbDg1BSsWyW+JC2Xs=;
 b=GMMXZ2fvB45WG35tJabaYxmI5q10zI2Y8tRij2n8XhNr0GyxDDyu5YHd7VYFdXgqxpm6RS
 P4iAUnwCZVBPBChYKG39IZ0oMzzvvJBfk8N+lUlLFLvhpc1AZ/cuohA/RELzoYqUtJmaCm
 emNr2MQdwLbp0EbwIpgLOttFs4t/0a8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-xogjPWZMP3G3wYBpejnG2Q-1; Wed, 22 Jul 2026 01:22:06 -0400
X-MC-Unique: xogjPWZMP3G3wYBpejnG2Q-1
X-Mimecast-MFC-AGG-ID: xogjPWZMP3G3wYBpejnG2Q_1784697725
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4926fa2cb17so40551935e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 22:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784697725; x=1785302525;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zUwBUqB0UJ0jFJVhl6+u41ye61PbDg1BSsWyW+JC2Xs=;
 b=Mfg/FpYm9pcl4+B7JAZU43NyqO8mw2jzzMhstQISKmvc6Mxyhk3zRPPQaRM1DuZy9V
 /FwkpADuuDvUoPvyT3MeGqcEC8oKw94YiVVrk40nVIEREUm5/Ju39DXqfLekhRsp242Z
 LaCCSNxkCw5CJnduTq0cuu27z/vmE2hacgWj0QA9y2jgTqwZsuk73jEFrNCw5BC0RViG
 RvW1d679+adg5gfmMdesdpxndHiiGXV6khLyEOUWXopyht6YVGN4r1v6schwLuT+WI2V
 RmY/zYiZQ0zPgVILYQhNRxZCM+TB4z9hadsg+BWIXiIhdQ2jzT9CbsUcgSczby1fp33g
 zCKQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp5hyArbUi6TFFqQ6AyUxGOuaf5yEZ99KH60iyi6HVqOT7gSFFKFpHRG7dPXMJPOeNH/XpTwlS95co=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1SvMUPS52Z3zw5XFjr/18l56zmi3laDKYfEh7uo4nRJJGJwJ+
 hkYKSrcp1SA2mqHl//Azz/WkAfsVxTMH22btjWWliI2GU4qIyeyO6JvSccL6/56cqRI3xMANOXz
 2XtV4sdBgeNRvVVf4lXaOeIZDVGqknp5uOEfllgOwgzmA/Z7gCOYqA6ehLrLIglkkR4hvi/W6x7
 n0Zhn0DZkLWxKs3wRCAE45xhjQk3fP38ez2US8ryBxD9pv
X-Gm-Gg: AR+sD10zq43Ra/s8IUNscahzpKtZ11qiQ59nOg1BNZYUxj5KvoVmZJaOmKCzNQ8w9/x
 7QDBqNn/dtVmKF1nNNEQYfaH9aGtoQdY695/t8fom02TuwREssqCxL5PIV4V9uCnX1Yyr4fNwwQ
 UxBnBYGR0Gc7VRZePrlZhaAsNsrcMAiz1M9MNK0b56v1vegfYTJY0L9gBH
X-Received: by 2002:a05:600c:548a:b0:493:f783:c46a with SMTP id
 5b1f17b1804b1-4956a4ef5d1mr23399505e9.6.1784697724938; 
 Tue, 21 Jul 2026 22:22:04 -0700 (PDT)
X-Received: by 2002:a05:600c:548a:b0:493:f783:c46a with SMTP id
 5b1f17b1804b1-4956a4ef5d1mr23399355e9.6.1784697724521; Tue, 21 Jul 2026
 22:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260721223244.1102276-1-matthew.brost@intel.com>
In-Reply-To: <20260721223244.1102276-1-matthew.brost@intel.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 22 Jul 2026 07:21:47 +0200
X-Gm-Features: AUfX_mwOdL_gU0Ukhn_BHxlTdYAhKkWBviF2rnNH5uTdN37yiHN3GNzhNE9VnzQ
Message-ID: <CAASaF6yWnMeEa6ZiKNGjh5bMAUy+1D2JdQoDhj-UEaMm_ygG8w@mail.gmail.com>
Subject: Re: [PATCH] drm/pagemap: Guard HPAGE_PMD_ORDER use with
 CONFIG_ARCH_ENABLE_THP_MIGRATION
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 kernel test robot <lkp@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KOy8vYqkwpiE2a-fx_Mc8az2VSPBnJEZKKlVCInbWJI_1784697725
X-Mimecast-Originator: redhat.com
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

On Wed, Jul 22, 2026 at 12:32=E2=80=AFAM Matthew Brost <matthew.brost@intel=
.com> wrote:
>
> HPAGE_PMD_SHIFT expands to BUILD_BUG() when CONFIG_PGTABLE_HAS_HUGE_LEAVE=
S
> is not set, causing a compile error when both CONFIG_TRANSPARENT_HUGEPAGE
> and CONFIG_HUGETLB_PAGE are disabled:
>
>  drivers/gpu/drm/drm_pagemap.c:480:12: error: call to '__compiletime_asse=
rt_458'
>  declared with 'error' attribute: BUILD_BUG failed
>    480 |                         order =3D HPAGE_PMD_ORDER;
>        |                                 ^
>  include/linux/huge_mm.h:117:26: note: expanded from macro 'HPAGE_PMD_ORD=
ER'
>    117 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
>        |                          ^
>  include/linux/huge_mm.h:113:28: note: expanded from macro 'HPAGE_PMD_SHI=
FT'
>    113 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
>
> Define DRM_PAGEMAP_PMD_ORDER, which maps to HPAGE_PMD_ORDER when
> CONFIG_ARCH_ENABLE_THP_MIGRATION is enabled and to -1 otherwise.
>
> This is safe because all code paths that use DRM_PAGEMAP_PMD_ORDER are
> reachable only when CONFIG_ARCH_ENABLE_THP_MIGRATION is enabled.
>
> Fixes: 139ab31aea8a ("drm/pagemap: Correct cpages calculation for migrate=
_vma_setup")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202607201914.LpAGsbXs-lkp@intel.com/
> Cc: Jan Stancek <jstancek@redhat.com>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>

Thanks for fix, this resolves (same) build failure I was seeing as well.

Tested-by: Jan Stancek <jstancek@redhat.com>

