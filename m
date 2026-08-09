Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D911AC5AC80
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 05:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1A7C10E05B;
	Sun,  9 Aug 2026 05:42:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bcjj0caT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6227110E05B
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 05:42:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 58CE060008;
 Sun,  9 Aug 2026 05:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9C81F000E9;
 Sun,  9 Aug 2026 05:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786254174;
 bh=WHJ3eymfElXxxRV7HnA/scdXtVZqLjrtb5sNaoHtwjM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bcjj0caTdjm2THgl/JLTEl4BOTitEQGe6e2eYksL79oq/oyX6Y8p48BGHdvIsuvvR
 DmGGp+wJL8TXKURX/Ym787K82/zcZFQnEZwgGD/71ShMXGwhnfxxKHbg42RjYdau19
 6kQLjDDXPRUi9x4Ld/XxjIHEDDxl0hyxRSuRmfVXOFe5dRdb+4ZS5WXJVb6EYsMSPc
 LodaelxsRfMfYQwhV+xxlsTJsggxbiJP+HTC1hM+VCJfK0kf8V9pfyOHtZDmzmHcBL
 vJvVqu1C03PnN18KTkgfv7VbHTARpjuEZkPNfRA8fb5YDk+TvTd2CVnjbyH7yvWC1d
 UkpO1ahgHFgUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] drm/amdgpu/aca: Fix inverted validation logic
 and list cleanup
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260809051200.3276-4-sreekuttan2156239@gmail.com>
References: <20260809051200.3276-1-sreekuttan2156239@gmail.com>
 <20260809051200.3276-4-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 05:42:53 +0000
Message-Id: <20260809054253.DB9C81F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Using `list_del_init()` on a locklessly-iterated list causes a pot=
ential kernel infinite loop if a handle is removed concurrently with list t=
raversal.

Pre-existing issues:
- [High] A TOCTOU race condition exists between background RAS querying and=
 device teardown, leading to a use-after-free of the ACA error cache and it=
s mutex.
--

--- Patch [3]: [PATCH v3 3/6] drm/amdgpu/aca: Fix inverted validation logic=
 and list cleanup ---
commit 0f8631e3d7835b4beff6c092382f39cf69067a82
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

drm/amdgpu/aca: Fix inverted validation logic and list cleanup

This commit fixes the validation logic in aca_handle_is_valid() by ensuring
the handle is non-NULL, contains a valid mask, and is actively registered
in the list. It also updates amdgpu_aca_get_error_data() to return 0 for
invalid handles, and modifies remove_aca_handle() to use list_del_init()
to prevent potential use-after-free issues.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_aca.c
> index c76664af9902e..06cb3ad1ce623 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
[ ... ]
> @@ -717,7 +714,7 @@ static void remove_aca_handle(struct aca_handle *hand=
le)
>  	struct aca_handle_manager *mgr =3D handle->mgr;
> =20
>  	aca_fini_error_cache(handle);
> -	list_del(&handle->node);
> +	list_del_init(&handle->node);

[Severity: High]
This is a pre-existing issue, but does the ordering in this function create
a race condition with the background RAS query thread?

If the background thread evaluates aca_handle_is_valid() concurrently
during teardown, it might see a valid node because the background work is
cancelled after the handles are torn down:

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:amdgpu_ras_fini() {
	...
	amdgpu_aca_fini(adev);
	...
	cancel_delayed_work_sync(&con->ras_counte_delay_work);
	...
}

Because aca_fini_error_cache() is called before the node is removed from
the list, could the background thread see a valid node and then attempt to
acquire a destroyed mutex here?

drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c:aca_log_aca_error() {
	...
	mutex_lock(&aerr->lock);
	...
}

[Severity: High]
Does switching to list_del_init() here create a risk of an infinite loop
during list traversal?

The handle list appears to be iterated locklessly here:

drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c:aca_dispatch_bank() {
	...
	list_for_each_entry(handle, &mgr->list, node) {
	...
}

If a handle is removed concurrently with list traversal, list_del_init()
will set the node's next pointer to itself. Will this cause the lockless
iterator in aca_dispatch_bank() to get stuck repeatedly visiting the same
removed node?

>  	mgr->nr_handles--;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809051200.3276=
-1-sreekuttan2156239@gmail.com?part=3D3
