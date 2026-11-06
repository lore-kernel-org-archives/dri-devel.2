Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83819606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1CXIUJS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7E17112BC0;
	Fri,  6 Nov 2026 10:10:10 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2B6A112BC0
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 10:10:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A8BA9605E2;
 Fri,  6 Nov 2026 10:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442CD1F0089F;
 Fri,  6 Nov 2026 10:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793959803;
 bh=AXW4MgKfQIlEWjR6zT5H5nY1ShSXvRDYBL61YIgEVE4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R1CXIUJScTDwI//m85gGcVpiFBbaatX6kKizsl92GmFylGRMFiAoJkZVC5Ttj9shO
 UFA+q6uletbemniROUgKT273QBEx8eHFlbKSZkjrWG1WfubbiSAjl/6ddiCaanxH3U
 PapNQOvT+vHvMJILOAZusgdmgBTRyjm6dpa+wJc77btXQHMiqMSyBlvsVHnqH0iB4s
 +M+2PzsVH5LzB58zjnUHy7OHbD1svoRI0B3env1fS1BYZYI1oL93WZoIY8aD+6l1uM
 Pukr+QmsaJgPcESSmtmwpcZJwGH91biwpVG/+TlV1LdCiD9/OPKgWC+OhRefwhp3Wv
 90JYb0nSgIg1w==
Message-ID: <sashiko-outbox-201188@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/syncobj: Fix fence and syncobj leak on
 dma_fence_chain_alloc failure
To: tongzhiwei <tongzhiwei@cmss.chinamobile.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106095730.166-1-tongzhiwei@cmss.chinamobile.com>
References: <20261106095730.166-1-tongzhiwei@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 10:10:02 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/syncobj: missing Fixes trailer for
  drm_syncobj_import_sync_file_fence()
--

commit de478817c7c05dbb269859f891ebb406ae0d952f
Author: tongzhiwei <tongzhiwei@cmss.chinamobile.com>

> drm/syncobj: Fix fence and syncobj leak on dma_fence_chain_alloc failure
>
> NOTE: this commit is worked by llm completely
>
> In drm_syncobj_import_sync_file_fence(), when point is non-zero and
> dma_fence_chain_alloc() returns NULL, the function returns -ENOMEM
> without releasing the fence reference (obtained via sync_file_get_fence)
> or the syncobj reference (obtained via drm_syncobj_find).  Both
> references are permanently leaked.
>
> Add dma_fence_put(fence) and drm_syncobj_put(syncobj) before returning
> -ENOMEM on the allocation failure path.
>
> Assisted-by: LLM
> Signed-off-by: tongzhiwei <tongzhiwei@cmss.chinamobile.com>

[Severity: Low]
This fixes a reference leak introduced with timeline sync_file import
support.  Should the commit message include a Fixes tag:

  Fixes: c2d3a7300695 ("drm/syncobj: Extend EXPORT_SYNC_FILE for timeline s=
yncobjs")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106095730.166-=
1-tongzhiwei@cmss.chinamobile.com?part=3D1
