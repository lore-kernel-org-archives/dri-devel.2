Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5B9CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 11:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B2D810E023;
	Tue,  6 Oct 2026 11:59:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hHieZMZ1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADEB010E023
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 11:59:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4387F407F0;
 Tue,  6 Oct 2026 11:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083E01F000FF;
 Tue,  6 Oct 2026 11:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791287978;
 bh=KLBg5gOMmajvv50NKPYdznqzA8Xm4/RPNREOrPeOwJk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hHieZMZ1KTLOrts+mmBIrpMCIbrOoy8eC1Aspn4UVOOnLgPQ/jKr7hdOIo3xzCI28
 7R0h1QjS+4XEN6DC/XdIIOefUxmvjY6RgKUzpBVxqzKsMJrQJEzTWpEHaPunGbuV8/
 PErvCTrPfF8Dqac0A0yOWle0pOpXm/KWdsRRYxNdJbIJNbdxowGJQnF3HAqRJSdJRt
 H6k6WkzHlUZsQcwQVl8+fJ6a6RgKJ/VSCb2xjjkyFnlXStAbq7JflBq1fZZc6ixAd6
 5uRaEkcZVjzvBXpJLGIcEdZHeb2g9FHTL/02z3NYCqxQaHQmq5+CK1jYswnLf5/+rS
 lYByM/e9RCq/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/imagination: Improve logging of unknown freelist IDs
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261006-b4-improve-logging-of-unknown-freelist-ids-v1-1-96ebcb132b80@imgtec.com>
References: <20261006-b4-improve-logging-of-unknown-freelist-ids-v1-1-96ebcb132b80@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 11:59:37 +0000
Message-Id: <20261006115938.083E01F000FF@smtp.kernel.org>
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
- [Medium] drm: missing rate-limiting on firmware-driven log messages
--

commit 48839b908b6b2c9825c18cddcc77e1ed32786c07
Author: Alessio Belle <alessio.belle@imgtec.com>
drm/imagination: Improve logging of unknown freelist IDs

This commit improves logging by adding warnings when the firmware sends
freelist grow or reconstruction requests with unrecognized IDs. It also
removes a WARN_ON() in the grow request path.

> diff --git a/drivers/gpu/drm/imagination/pvr_free_list.c b/drivers/gpu/dr=
m/imagination/pvr_free_list.c
> index e85cac83834c6..f8a333649933a 100644
> --- a/drivers/gpu/drm/imagination/pvr_free_list.c
> +++ b/drivers/gpu/drm/imagination/pvr_free_list.c
[ ... ]
> @@ -367,8 +368,12 @@ void pvr_free_list_process_grow_req(struct pvr_devic=
e *pvr_dev,
>  	u32 grow_pages =3D 0;
> =20
>  	/* If we don't have a freelist registered for this ID, we can't do much=
. */
> -	if (WARN_ON(!free_list))
> +	if (!free_list) {
> +		drm_warn(from_pvr_device(pvr_dev),
> +			 "Received freelist grow request for unknown ID 0x%x\n",
> +			 req->freelist_id);

[Severity: Medium]
Could this lead to log flooding if the firmware repeatedly sends requests
with an unknown freelist ID?

While the firmware is trusted, it is generally standard practice to use
drm_warn_ratelimited() for messages triggered by hardware or firmware
events to prevent kernel log buffer overflows.

>  		return;
> +	}
> =20
>  	/* Since the FW made the request, it has already consumed the ready pag=
es,
>  	 * update the host struct.
[ ... ]
> @@ -564,8 +569,12 @@ pvr_free_list_reconstruct(struct pvr_device *pvr_dev=
, u32 freelist_id)
>  	struct rogue_fwif_freelist *fw_data;
>  	struct pvr_hwrt_data *hwrt_data;
> =20
> -	if (!free_list)
> +	if (!free_list) {
> +		drm_warn(from_pvr_device(pvr_dev),
> +			 "Received freelist reconstruction request for unknown ID 0x%x\n",
> +			 freelist_id);

[Severity: Medium]
Similarly, could this unbounded warning consume CPU cycles and mask other
important errors if the firmware malfunctions or is compromised?

Using a rate limited logging function here might be safer.

>  		return;
> +	}
> =20
>  	mutex_lock(&free_list->lock);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-b4-improve=
-logging-of-unknown-freelist-ids-v1-1-96ebcb132b80@imgtec.com?part=3D1
