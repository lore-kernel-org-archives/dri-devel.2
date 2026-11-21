Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAB7606A693
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 05:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KnMGlQwz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B7E810E164;
	Sat, 21 Nov 2026 05:58:56 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DB1110E123;
 Sat, 21 Nov 2026 05:58:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E787145AF8;
 Sat, 21 Nov 2026 05:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D951F000C0;
 Sat, 21 Nov 2026 05:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795240728;
 bh=O0NY586JJmTpwCfLEWgpPjPCUQ+Hj6aJMCMiuUmKZ2c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KnMGlQwzj4gPQmCc8+qvAAoO0FdkBOwuqb0COgAfG/reEq7yuQtcEOpVIpRZGX33/
 q1Cx+GJ+007LxLCtw9Bc2hoR6X3quM69OOMZltFhVcomnS10cxP44S2Ti0IpTbza0l
 3/jgj/WwtWeMU2bZHCAPWYhscZJ2UBciILp4xyayO/vF9jcynIXD/wj0m6IL/pLUGw
 f7oB0r+bnRJtYFyA4knWj95R1o3HKXzF1IaJ/3lUSjYZwvGZ0ritZx8CQVXL/ebWZQ
 8JDfKMdCKNJ27OLoGwCS+xR594OJfmWgk3AzxIPLaVO+x10omaWp+Ral0SDJP18Da0
 6xAEZckD6kOzQ==
Message-ID: <sashiko-outbox-226691@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 23/24] dma-buf: Add dma_buf_mapping_map() returning a
 type-tagged mapping and implement it for sgt
To: "Alistair Popple" <apopple@nvidia.com>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261120-dma_mapping_type_v4-v3-23-c0183a409bdf@nvidia.com>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-23-c0183a409bdf@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 05:58:48 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] dma-buf: wrong dma_buf_attach_map_type() doc on
  dma_buf_mapping_type.unmap
--

commit bd9afecc501b0a6674a8f68fd07c287949304430
Author: Alistair Popple <apopple@nvidia.com>

dma-buf: Add dma_buf_mapping_map() returning a type-tagged mapping and impl=
ement it for sgt

This commit adds generic dma_buf_mapping_map() and dma_buf_mapping_unmap()
entry points that select a mapping type and dispatch through its callbacks,
and converts dma_buf_map_sgt() and dma_buf_unmap_sgt() to use them.

> diff --git a/include/linux/dma-buf-mapping.h b/include/linux/dma-buf-mapp=
ing.h
> index 0a1c2934a932a..98d5765cfdba9 100644
> --- a/include/linux/dma-buf-mapping.h
> +++ b/include/linux/dma-buf-mapping.h
> @@ -82,6 +82,32 @@ struct dma_buf_mapping_type {
>  	 */
>  	void (*debugfs_dump)(struct seq_file *s,
>  			     struct dma_buf_attachment *attach);
> +
> +	/**
> +	 * @map:
> +	 *
> +	 * Produce a mapping of this type for @attach, for which this type has
> +	 * already been selected. Called by dma_buf_mapping_map() with the
> +	 * dma_resv lock held. The result embeds &struct dma_buf_mapping, which
> +	 * the core fills in once this returns. A map that may unmap its result
> +	 * on its own unwind must record the entry in it first, since every
> +	 * unmap reads it. Responsible for pin-on-map of static importers if
> +	 * the type supports them.
> +	 */
> +	struct dma_buf_mapping *(*map)(struct dma_buf_attachment *attach,
> +				       enum dma_data_direction dir);
> +
> +	/**
> +	 * @unmap:
> +	 *
> +	 * Release a mapping returned by @map. Called by dma_buf_mapping_unmap()
> +	 * with the dma_resv lock held and with dma_buf_attach_map_type()
> +	 * naming the entry the mapping was made with, which need not be the
> +	 * attachment's current selection.
> +	 */
> +	void (*unmap)(struct dma_buf_attachment *attach,
> +		      struct dma_buf_mapping *mapping,
> +		      enum dma_data_direction dir);
>  };

[Severity: Low]
Should this @unmap comment refer to mapping->match rather than
dma_buf_attach_map_type()?

dma_buf_attach_map_type() returns &attach->matches[attach->selected_idx],
and dma_buf_mapping_unmap() calls match->type->unmap() without changing
attach->selected_idx, so dma_buf_attach_map_type() still returns the
attachment's current selection while mapping->match holds the entry the
mapping was made with.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-dma_mappin=
g_type_v4-v3-0-c0183a409bdf@nvidia.com?part=3D23
