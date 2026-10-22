Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B9D606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TWRhUV3P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6871F10E2C8;
	Thu, 22 Oct 2026 08:03:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FD6B10E23D
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 08:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792656205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W6J737TEl9B2egnW0p7z/YAbbC3wSedR9eDcIGXJuFs=;
 b=TWRhUV3PzJOupBLdaSvA87D/kDy3IyAb1pf0zSBAsRoBczAaBv8GD9LGgAKotLOUZNK4wV
 Tg8r1YvRL17aeqwGk/C9EEFq6Faai0fv4V68s8FmBLbanM+/6yy4bwaHx2shLjVMrKjiHS
 CtReXn2yikdYJhNlXhR3JqSEPAZQLHU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-fjuJkBmsPGi3YG2PD_MEmQ-1; Thu, 22 Oct 2026 04:03:23 -0400
X-MC-Unique: fjuJkBmsPGi3YG2PD_MEmQ-1
X-Mimecast-MFC-AGG-ID: fjuJkBmsPGi3YG2PD_MEmQ_1792656203
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a027f2e364so11477305e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 01:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792656202; x=1793261002;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W6J737TEl9B2egnW0p7z/YAbbC3wSedR9eDcIGXJuFs=;
 b=b1i4OAKkbETi8LkGuCKhS5N8eGnR27mGB1mtf37hjfpQKwj8/QM2aEBxjjWICHM1lu
 bknbxIx3URzQZ/6oba+fflU6QDqtap8cNEVHzvveYHK+1lPIfqWJFLbBF9qLcQgP/D0e
 yhs4PT6PSrUxWorm5zCvMHVHpVwGxpC0sYPiKqxMP2EL7m8aRi6pltY3zArixCaSGkdJ
 MJAsmRcPA6G/BourSGqHBJoRHrOvmDQJtqoZEGVdTdfI0QMDNTZZ8oKo9RfG7kZqP7uO
 ucI8/w8bPQvPL/vJOUmPxdfi5u44GDI0OxPqIH4BRL7dVxtV3euwPjbrprF7w+KZcW7i
 v1YQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByyk7te0RqxmIyExnBHFV7Cy/l/VH12kfUTNni2xuQULbKpLdxVDWLVFjcQYL06zVEk36CiNQc9q/o=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKAukrGXHKBXpNCok7P48r7vfwzAgigfHb+z0QqpaWsXx787b9F
 1rc7eIQLIeoo1ud9so+xhO+39BGxhRMiZoJshM6eN6AF/JvI3vRjDzYYrsUZVeh9Pm/cML7viLd
 vzPic7EuZ4Kgh8tnbIfwKq8M1RksfSGRvHrEp26yLqLQmK6JxbWuqRnG7l+XJNSuScV828fP+bg
 wnd7MkEEuhYG0Y13mP9yZbOZvx8QDpZXl3fyXy7MGMCO+F
X-Gm-Gg: AYBFou3zlLXA7j7LW/I6oqVIp9aGvPC+SPr2JrjNQLD5K53UARYskuCDC6Dr5YqpOH1
 GH1WWUvkGsguxLvdGxVQkT3LYbI+4x41dbXSHvsrs6eBEb35dbX1W30UKcRVVfd+rtpzmgdyIVC
 eJxIysYm8rww95hUoZn91Yqjme+8EFY2hTEBFkjk40JqJDVMJx4GtpopjU
X-Received: by 2002:a05:600c:3155:b0:4a2:803:a3c4 with SMTP id
 5b1f17b1804b1-4a20803a77emr19050505e9.13.1792656202198; 
 Thu, 22 Oct 2026 01:03:22 -0700 (PDT)
X-Received: by 2002:a05:600c:3155:b0:4a2:803:a3c4 with SMTP id
 5b1f17b1804b1-4a20803a77emr19049855e9.13.1792656201601; Thu, 22 Oct 2026
 01:03:21 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260721223244.1102276-1-matthew.brost@intel.com>
In-Reply-To: <20260721223244.1102276-1-matthew.brost@intel.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 22 Oct 2026 10:03:09 +0200
X-Gm-Features: AclHuK9lDSJzIh1F3yl4aopdz0Eiem3shCKhqffOA1TaZenWgjeQE26eptsBHE4
Message-ID: <CAASaF6z3gEFD41XiNA_dLruNc7QCjJvZr=yABKm_WMP8rpKquA@mail.gmail.com>
Subject: Re: [PATCH] drm/pagemap: Guard HPAGE_PMD_ORDER use with
 CONFIG_ARCH_ENABLE_THP_MIGRATION
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 kernel test robot <lkp@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yQ5SBQcn35QlSthYjoX8uZCYTkCBPSvfsiVY7bjL0ps_1792656203
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
> ---
>  drivers/gpu/drm/drm_pagemap.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.=
c
> index 15c78eca180b..951cd92c930c 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -12,6 +12,12 @@
>  #include <drm/drm_pagemap_util.h>
>  #include <drm/drm_print.h>
>
> +#if IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION)

Now that d547b1001755 ("mm: rename ARCH_ENABLE_THP_MIGRATION to
ARCH_HAS_PMD_SOFTLEAVES")
landed in Linus' tree, would you consider applying this again using
the new config name?

Thanks,
Jan

> +#define DRM_PAGEMAP_PMD_ORDER  HPAGE_PMD_ORDER
> +#else
> +#define DRM_PAGEMAP_PMD_ORDER  (-1)
> +#endif
> +
>  /**
>   * DOC: Overview
>   *
> @@ -579,7 +585,7 @@ static int drm_pagemap_cpages(unsigned long *migrate_=
pfn, unsigned long npages)
>                         order =3D folio_order(folio);
>                         cpages +=3D NR_PAGES(order);
>                 } else if (migrate_pfn[i] & MIGRATE_PFN_COMPOUND) {
> -                       order =3D HPAGE_PMD_ORDER;
> +                       order =3D DRM_PAGEMAP_PMD_ORDER;
>                         cpages +=3D NR_PAGES(order);
>                 }
>
> @@ -765,10 +771,11 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagema=
p_devmem *devmem_allocation,
>
>                 if (migrate.src[i] & MIGRATE_PFN_COMPOUND) {
>                         drm_WARN_ONCE(dpagemap->drm, src_page &&
> -                                     folio_order(page_folio(src_page)) !=
=3D HPAGE_PMD_ORDER,
> +                                     folio_order(page_folio(src_page)) !=
=3D
> +                                     DRM_PAGEMAP_PMD_ORDER,
>                                       "Unexpected folio order\n");
>
> -                       order =3D HPAGE_PMD_ORDER;
> +                       order =3D DRM_PAGEMAP_PMD_ORDER;
>                         migrate.dst[i] |=3D MIGRATE_PFN_COMPOUND;
>
>                         for (j =3D 1; j < NR_PAGES(order) && i + j < npag=
es; j++)
> --
> 2.34.1
>

