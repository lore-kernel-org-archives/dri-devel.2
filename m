Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84B110AB82A
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 23:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 258E610E025;
	Thu, 26 Mar 2026 23:01:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uC6FUYXs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3E4810E025
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 23:01:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D8779442F8;
 Thu, 26 Mar 2026 23:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72FBC116C6;
 Thu, 26 Mar 2026 23:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774566114;
 bh=hWP91/+v9GbxKHcEq0xDvazvOt7SnjyJCecS2W1Nck0=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=uC6FUYXsYA2hVJl5iSDrQcNjaUGyppZxh2cMNc1SfBl5vL1FKmH5kuvUINzhDqkcg
 ALgw3d84WUKpqTVOsc+tRRk7S284zdSQ3kbfPZHoSc29KtOdBgVdPp015gT0l60cWV
 1rDWDDZ5OZx94eS2+FevTgIhiCbWy3VWZu6bDR6GGQncKSAGrEwUwSYc7+AeC/FSBv
 KKdTm9/qbukTmfiIY4HtaNWbaXZgUHOut1RuKHYKih3Wc1cJ3JVNvg6riieEAJhoy2
 z6yRO1lEftV7QRVJNCS2w35WQbLltJbeox0BAAnbvHNQibVn147jMcQRLPad6X9ExI
 EBSgrZzHH5jHA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Mar 2026 00:01:50 +0100
Message-Id: <DHD36ONR7KSE.1NFF01QTXNHR6@kernel.org>
Subject: Re: [PATCH v5 05/11] drm/gpuvm: Add a flags field to drm_gpuva_op_map
Cc: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 "Steven Price" <steven.price@arm.com>, "Boris Brezillon"
 <boris.brezillon@collabora.com>, "Janne Grunau" <j@jannau.net>,
 <kernel@collabora.com>, "Asahi Lina" <lina+kernel@asahilina.net>, "Caterina
 Shablia" <caterina.shablia@collabora.com>, "Matthew Brost"
 <matthew.brost@intel.com>, =?utf-8?q?Thomas_Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
To: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260313150956.1618635-1-adrian.larumbe@collabora.com>
 <20260313150956.1618635-6-adrian.larumbe@collabora.com>
In-Reply-To: <20260313150956.1618635-6-adrian.larumbe@collabora.com>
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

On Fri Mar 13, 2026 at 4:09 PM CET, Adri=C3=A1n Larumbe wrote:
> From: Asahi Lina <lina+kernel@asahilina.net>
>
> drm_gpuva objects have a flags field. Currently, this can be managed by
> drivers out-of-band, without any special handling in drm_gpuvm.
>
> To be able to introduce flags that do affect the logic in the drm_gpuvm
> core, we need to plumb it through the map calls. This will allow the
> core to check the flags on map and alter the merge/split logic depending
> on the requested flags and the flags of the existing drm_gpuva ranges
> that are being split.
>
> Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
> Signed-off-by: Caterina Shablia <caterina.shablia@collabora.com>

Missing Signed-off-by.

> ---
>  drivers/gpu/drm/drm_gpuvm.c | 14 ++++++++++++--
>  include/drm/drm_gpuvm.h     | 18 ++++++++++++++++++
>  2 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
> index 4af7b71abcb4..0d9c821d1b34 100644
> --- a/drivers/gpu/drm/drm_gpuvm.c
> +++ b/drivers/gpu/drm/drm_gpuvm.c
> @@ -2386,6 +2386,7 @@ static bool can_merge(struct drm_gpuvm *gpuvm, cons=
t struct drm_gpuva *va,
>  		.va.range =3D va->va.range,
>  		.gem.offset =3D va->gem.offset,
>  		.gem.obj =3D va->gem.obj,
> +		.flags =3D va->flags,
>  	};
>  	const struct drm_gpuva_op_map *a =3D new_map, *b =3D &existing_map;
> =20
> @@ -2395,6 +2396,10 @@ static bool can_merge(struct drm_gpuvm *gpuvm, con=
st struct drm_gpuva *va,
>  	if (a->gem.obj !=3D b->gem.obj || !a->gem.obj)
>  		return false;
> =20
> +	/* For two VAs to be merged, their flags must be compatible */
> +	if ((a->flags & VA_MERGE_MUST_MATCH_FLAGS) !=3D (b->flags & VA_MERGE_MU=
ST_MATCH_FLAGS))
> +		return false;

This has nothing to do with this patch, the commit message only talks about
adding flags to struct drm_gpuva_op_map.

Please create a new patch for further changes, v4 of this was fine as is.

> +
>  	/* Order VAs for the rest of the checks. */
>  	if (a->va.addr > b->va.addr)
>  		swap(a, b);
> @@ -2459,6 +2464,7 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
>  					.va.range =3D range - req_range,
>  					.gem.obj =3D obj,
>  					.gem.offset =3D offset + req_range,
> +					.flags =3D va->flags,
>  				};
>  				struct drm_gpuva_op_unmap u =3D {
>  					.va =3D va,
> @@ -2480,6 +2486,7 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
>  				.va.range =3D ls_range,
>  				.gem.obj =3D obj,
>  				.gem.offset =3D offset,
> +				.flags =3D va->flags,
>  			};
>  			struct drm_gpuva_op_unmap u =3D { .va =3D va };
> =20
> @@ -2519,8 +2526,8 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
>  					.va.addr =3D req_end,
>  					.va.range =3D end - req_end,
>  					.gem.obj =3D obj,
> -					.gem.offset =3D offset + ls_range +
> -						      req_range,
> +					.gem.offset =3D offset + ls_range + req_range,

Spurious change.

> +					.flags =3D va->flags,
>  				};
> =20
>  				ret =3D op_remap_cb(ops, priv, &p, &n, &u);
> @@ -2554,6 +2561,7 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
>  					.va.range =3D end - req_end,
>  					.gem.obj =3D obj,
>  					.gem.offset =3D offset + req_end - addr,
> +					.flags =3D va->flags,
>  				};
>  				struct drm_gpuva_op_unmap u =3D {
>  					.va =3D va,
> @@ -2605,6 +2613,7 @@ __drm_gpuvm_sm_unmap(struct drm_gpuvm *gpuvm,
>  			prev.va.range =3D req_addr - addr;
>  			prev.gem.obj =3D obj;
>  			prev.gem.offset =3D offset;
> +			prev.flags =3D va->flags;
> =20
>  			prev_split =3D true;
>  		}
> @@ -2614,6 +2623,7 @@ __drm_gpuvm_sm_unmap(struct drm_gpuvm *gpuvm,
>  			next.va.range =3D end - req_end;
>  			next.gem.obj =3D obj;
>  			next.gem.offset =3D offset + (req_end - addr);
> +			next.flags =3D va->flags;
> =20
>  			next_split =3D true;
>  		}
> diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
> index 6a6e64cd2cce..5bf37deb282d 100644
> --- a/include/drm/drm_gpuvm.h
> +++ b/include/drm/drm_gpuvm.h
> @@ -63,6 +63,8 @@ enum drm_gpuva_flags {
>  	DRM_GPUVA_USERBITS =3D (1 << 2),
>  };
> =20
> +#define VA_MERGE_MUST_MATCH_FLAGS (DRM_GPUVA_SPARSE)

Please drop this indirection if the only criteria is that both must be spar=
se.

> +
>  /**
>   * struct drm_gpuva - structure to track a GPU VA mapping
>   *
> @@ -886,6 +888,11 @@ struct drm_gpuva_op_map {
>  		 */
>  		struct drm_gem_object *obj;
>  	} gem;
> +
> +	/**
> +	 * @flags: requested flags for the &drm_gpuva for this mapping
> +	 */
> +	enum drm_gpuva_flags flags;
>  };
> =20
>  /**
> @@ -1124,6 +1131,7 @@ void drm_gpuva_ops_free(struct drm_gpuvm *gpuvm,
>  static inline void drm_gpuva_init_from_op(struct drm_gpuva *va,
>  					  const struct drm_gpuva_op_map *op)
>  {
> +	va->flags =3D op->flags;
>  	va->va.addr =3D op->va.addr;
>  	va->va.range =3D op->va.range;
>  	va->gem.obj =3D op->gem.obj;
> @@ -1249,6 +1257,16 @@ struct drm_gpuvm_ops {
>  	 * used.
>  	 */
>  	int (*sm_step_unmap)(struct drm_gpuva_op *op, void *priv);
> +
> +	/**
> +	 * @sm_can_merge_flags: called during &drm_gpuvm_sm_map
> +	 *
> +	 * This callback is called to determine whether two va ranges can be me=
rged,
> +	 * based on their flags.
> +	 *
> +	 * If NULL, va ranges can only be merged if their flags are equal.
> +	 */
> +	bool (*sm_can_merge_flags)(enum drm_gpuva_flags a, enum drm_gpuva_flags=
 b);

Again, this has nothing to do with this commit, please add a separate patch=
 for
this with a proper commit message explaining the motivation.

Also, this callback appears to be unused and seems to contradict the static
check for compatible merge flags in the hunk above.
