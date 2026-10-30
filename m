Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D272E606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FA/eoKSf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02D7110E5AD;
	Fri, 30 Oct 2026 14:50:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77B2410E3F8;
 Fri, 30 Oct 2026 14:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793371793; x=1824907793;
 h=message-id:subject:from:to:date:in-reply-to:references:
 content-transfer-encoding:mime-version;
 bh=nyLCmrbdwzIWbMHnBKJ5fRhaDSgMS/dfBRFsetR6cl8=;
 b=FA/eoKSfQQBkZWDHH4Z119LeeR7eA+rVTnOwZC5KtlpZTgf1U6gMaOjM
 r5VVmZKVkQ7jZ7MZq4UZB7/rwWnrixUGwm96hAQm4ztsg4itAdmqpDxM1
 MKnaC78jq5+3B5FGK4OCEpyv4BaewLY61U0ZhCiskbRVjtlov4QsQT7Wl
 OaQZbT8clz1aLRRGsg6Qh8oZlJqgGbfhkkNBUJPCX1prW7XBDcwcIutpb
 gIdb7T2WtPTQA7RYhMT1pfgLqSCgEij4HGFiiK//dKqrkqf0/73ZDz7ad
 LwnTVeXpeWq6hQJXUCg5zsPLdcnC560zmqpmnIQCZ+u4gCTlwRaFCLZ7k Q==;
X-CSE-ConnectionGUID: jcqcvDPjSS6Gg9roOZ2t6w==
X-CSE-MsgGUID: N9ZhqNlRRNWcMB0eHEmj3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2029761"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2029761"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 07:49:53 -0700
X-CSE-ConnectionGUID: egHJb5bsT7yXNlxZEnaPWQ==
X-CSE-MsgGUID: Q0IXAp93R627KD9HbnVGVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5779249"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO [10.245.244.72])
 ([10.245.244.72])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 07:49:52 -0700
Message-ID: <1532eaf9c5c7203beaefc4c86c293cbbb635175a.camel@linux.intel.com>
Subject: Re: [PATCH v6 2/3] drm/ttm: Allow skipping to the next priority in
 the bo LRU cursor
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Date: Fri, 30 Oct 2026 15:49:50 +0100
In-Reply-To: <20261027224902.1085762-3-matthew.brost@intel.com>
References: <20261027224902.1085762-1-matthew.brost@intel.com>
 <20261027224902.1085762-3-matthew.brost@intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 2026-10-27 at 15:49 -0700, Matthew Brost wrote:
> Drivers walking a manager's LRU with
> ttm_bo_lru_for_each_reserved_guarded()
> may decide that the rest of the current priority isn't worth walking,
> for example when the priority is roughly age ordered and the walk hit
> a BO that is still too hot to evict. Today the only option is to stop
> the walk altogether, which also gives up on the remaining priorities.
>=20
> Add ttm_resource_manager_next_priority() to move a resource cursor to
> the start of the next priority, and ttm_bo_lru_cursor_skip_priority()
> to make the next ttm_bo_lru_cursor_next() use it.
>=20
> While at it, stop incrementing the cursor priority past the last
> valid
> priority once the iteration is done.
>=20
> Assisted-by: LLM
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

> ---
> =C2=A0drivers/gpu/drm/ttm/ttm_bo_util.c=C2=A0 |=C2=A0 3 +++
> =C2=A0drivers/gpu/drm/ttm/ttm_resource.c | 35 ++++++++++++++++++++++++++-=
-
> --
> =C2=A0include/drm/ttm/ttm_bo.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 19 ++++++++++++++++
> =C2=A0include/drm/ttm/ttm_resource.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> =C2=A04 files changed, 55 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c
> b/drivers/gpu/drm/ttm/ttm_bo_util.c
> index f9458a4d5a09..d626f014e61f 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -997,6 +997,9 @@ __ttm_bo_lru_cursor_next(struct ttm_bo_lru_cursor
> *curs)
> =C2=A0		if (first) {
> =C2=A0			res =3D ttm_resource_manager_first(&curs-
> >res_curs);
> =C2=A0			first =3D false;
> +		} else if (curs->skip_priority) {
> +			res =3D
> ttm_resource_manager_next_priority(&curs->res_curs);
> +			curs->skip_priority =3D false;
> =C2=A0		} else {
> =C2=A0			res =3D ttm_resource_manager_next(&curs-
> >res_curs);
> =C2=A0		}
> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c
> b/drivers/gpu/drm/ttm/ttm_resource.c
> index 4e6d3d658d85..e631507d7aa1 100644
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> @@ -674,6 +674,17 @@ ttm_resource_cursor_check_bulk(struct
> ttm_resource_cursor *cursor,
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +static bool ttm_resource_cursor_next_priority(struct
> ttm_resource_cursor *cursor)
> +{
> +	if (cursor->priority + 1 >=3D TTM_MAX_BO_PRIORITY)
> +		return false;
> +
> +	list_move(&cursor->hitch.link, &cursor->man->lru[++cursor-
> >priority]);
> +	ttm_resource_cursor_clear_bulk(cursor);
> +
> +	return true;
> +}
> +
> =C2=A0/**
> =C2=A0 * ttm_resource_manager_first() - Start iterating over the resource=
s
> =C2=A0 * of a resource manager
> @@ -723,16 +734,32 @@ ttm_resource_manager_next(struct
> ttm_resource_cursor *cursor)
> =C2=A0			}
> =C2=A0		}
> =C2=A0
> -		if (++cursor->priority >=3D TTM_MAX_BO_PRIORITY)
> +		if (!ttm_resource_cursor_next_priority(cursor))
> =C2=A0			break;
> -
> -		list_move(&cursor->hitch.link, &man->lru[cursor-
> >priority]);
> -		ttm_resource_cursor_clear_bulk(cursor);
> =C2=A0	}
> =C2=A0
> =C2=A0	return NULL;
> =C2=A0}
> =C2=A0
> +/**
> + * ttm_resource_manager_next_priority() - Skip the rest of the
> current
> + * priority and continue iterating at the next one
> + * @cursor: cursor to record the position
> + *
> + * Return: the first resource of the next non-empty priority, or
> NULL if
> + * there is none.
> + */
> +struct ttm_resource *
> +ttm_resource_manager_next_priority(struct ttm_resource_cursor
> *cursor)
> +{
> +	lockdep_assert_held(&cursor->man->bdev->lru_lock);
> +
> +	if (!ttm_resource_cursor_next_priority(cursor))
> +		return NULL;
> +
> +	return ttm_resource_manager_next(cursor);
> +}
> +
> =C2=A0/**
> =C2=A0 * ttm_lru_first_res_or_null() - Return the first resource on an lr=
u
> list
> =C2=A0 * @head: The list head of the lru list.
> diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> index 32791c4db2a9..2fc517dbf03d 100644
> --- a/include/drm/ttm/ttm_bo.h
> +++ b/include/drm/ttm/ttm_bo.h
> @@ -507,10 +507,29 @@ struct ttm_bo_lru_cursor {
> =C2=A0	 * unlock before the next iteration or after loop exit.
> =C2=A0	 */
> =C2=A0	bool needs_unlock;
> +	/**
> +	 * @skip_priority: Continue at the next LRU priority on the
> next
> +	 * iteration. See ttm_bo_lru_cursor_skip_priority().
> +	 */
> +	bool skip_priority;
> =C2=A0	/** @arg: Pointer to common BO LRU walk arguments. */
> =C2=A0	struct ttm_lru_walk_arg *arg;
> =C2=A0};
> =C2=A0
> +/**
> + * ttm_bo_lru_cursor_skip_priority() - Skip the rest of the current
> priority
> + * @curs: The cursor.
> + *
> + * Make the next ttm_bo_lru_cursor_next() skip the remaining buffer
> objects
> + * of the current LRU priority and continue at the next priority,
> for
> + * example when the caller decides the rest of the priority isn't
> worth
> + * walking.
> + */
> +static inline void ttm_bo_lru_cursor_skip_priority(struct
> ttm_bo_lru_cursor *curs)
> +{
> +	curs->skip_priority =3D true;
> +}
> +
> =C2=A0void ttm_bo_lru_cursor_fini(struct ttm_bo_lru_cursor *curs);
> =C2=A0
> =C2=A0struct ttm_bo_lru_cursor *
> diff --git a/include/drm/ttm/ttm_resource.h
> b/include/drm/ttm/ttm_resource.h
> index 714c533622c2..8cd70d1e5481 100644
> --- a/include/drm/ttm/ttm_resource.h
> +++ b/include/drm/ttm/ttm_resource.h
> @@ -499,6 +499,8 @@ struct ttm_resource *
> =C2=A0ttm_resource_manager_first(struct ttm_resource_cursor *cursor);
> =C2=A0struct ttm_resource *
> =C2=A0ttm_resource_manager_next(struct ttm_resource_cursor *cursor);
> +struct ttm_resource *
> +ttm_resource_manager_next_priority(struct ttm_resource_cursor
> *cursor);
> =C2=A0
> =C2=A0struct ttm_resource *
> =C2=A0ttm_lru_first_res_or_null(struct list_head *head);
