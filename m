Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32E0C5CFCF
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E478210E066;
	Thu, 13 Aug 2026 15:45:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZCorfhbo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAEEC10E066
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 15:45:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7BB3B41595;
 Thu, 13 Aug 2026 15:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347361F000E9;
 Thu, 13 Aug 2026 15:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786635908;
 bh=6QDwKX0CxJTd/lkQkK1yYV/IrDXnHjokyq+nTBKmYyA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZCorfhbohBNabD1mdZdek5A6GA7LyDbfLMysj1kxjWdhnRBn81/je7McWlPFkBS39
 ra8j6uDDiblxGm0pPQAxI3sgBAJfbjI0k378OIilER32XghfjBCwCDAITWVYQz0hKj
 WC67vOZWWGvQX+nrqhN7rLL+FJA62fKLy6dtaKWqZbVxDJNoECovdWN+gbmPscgO9d
 R/WVr+Ghf4/H0OH+v3H+1nnPASx8ngOx1x4N7mUKuoR/PFFd40FgBSqNcrLDs8uU1f
 V/uJpe34dsSAHEdgeevEiMmgiyljEB+oVK1sRkfbJrBO+ox5Gg4p6hL6cvfaJiDIDO
 cF+dtqphjw32g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/imagination: clamp freelist reconstruction requests
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813152759.35856-1-pengpeng@iscas.ac.cn>
References: <20260813152759.35856-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 15:45:07 +0000
Message-Id: <20260813154508.347361F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized kernel stack memory (union padding and trailing arra=
y elements) sent to firmware CCB (Command Control Buffer).
--

--- Patch [1]: [PATCH] drm/imagination: clamp freelist reconstruction reque=
sts ---
commit ba7e433ffb1bb57e684515b2def3023d1d0aff07
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

drm/imagination: clamp freelist reconstruction requests

This commit bounds the freelist reconstruction count from firmware to the
maximum array capacity to prevent out-of-bounds accesses. It processes
only the bounded subset and reports this bounded count back to firmware,
emitting a one-time warning if the limit is exceeded.

> diff --git a/drivers/gpu/drm/imagination/pvr_free_list.c b/drivers/gpu/dr=
m/imagination/pvr_free_list.c
> index e85cac83834c6..23dbc227b081a 100644
> --- a/drivers/gpu/drm/imagination/pvr_free_list.c
> +++ b/drivers/gpu/drm/imagination/pvr_free_list.c
> @@ -612,13 +612,20 @@ pvr_free_list_process_reconstruct_req(struct pvr_de=
vice *pvr_dev,
>  	};
>  	struct rogue_fwif_freelists_reconstruction_data *resp =3D
>  		&resp_cmd.cmd_data.free_lists_reconstruction_data;

[Severity: High]
This isn't a bug introduced by this patch, but does this initialization lea=
ve
union padding uninitialized?

The resp_cmd struct uses a designated initializer for cmd_type. This
zero-initializes only the first member of its cmd_data union (cmd_kick_data=
),
leaving the remainder of the union uninitialized.

> +	u32 count =3D min_t(u32, req->freelist_count,
> +			  ARRAY_SIZE(req->freelist_ids));
> =20
> -	for (u32 i =3D 0; i < req->freelist_count; i++)
> +	if (count !=3D req->freelist_count)
> +		drm_warn_once(from_pvr_device(pvr_dev),
> +			      "Firmware requested reconstruction of %u freelists, limiting to=
 %u\n",
> +			      req->freelist_count, count);
> +
> +	for (u32 i =3D 0; i < count; i++)
>  		pvr_free_list_reconstruct(pvr_dev, req->freelist_ids[i]);
> =20
> -	resp->freelist_count =3D req->freelist_count;
> +	resp->freelist_count =3D count;
>  	memcpy(resp->freelist_ids, req->freelist_ids,
> -	       req->freelist_count * sizeof(resp->freelist_ids[0]));
> +	       count * sizeof(resp->freelist_ids[0]));

If count is small (e.g., 1), the memcpy only fills count elements of the ar=
ray.
The trailing elements of resp->freelist_ids will fall into the uninitialized
union padding.

> =20
>  	WARN_ON(pvr_kccb_send_cmd(pvr_dev, &resp_cmd, NULL));
>  }

When pvr_kccb_send_cmd() copies the full sizeof(struct rogue_fwif_kccb_cmd)=
 to
the KCCB ring buffer, could it leak this uninitialized kernel stack memory =
to
the GPU firmware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813152759.3585=
6-1-pengpeng@iscas.ac.cn?part=3D1
