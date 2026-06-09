Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54E1CD8CB2
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:37:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02C9010E3CD;
	Tue,  9 Jun 2026 17:37:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Za/d19Af";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94B5510E3CD
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 17:37:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E2AEE60218;
 Tue,  9 Jun 2026 17:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1648B1F00893;
 Tue,  9 Jun 2026 17:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781026636;
 bh=RkrpFVF9oRa3rOuk6LlbsggctcZ5zuC9pH00DxGtDH0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Za/d19AfGH0ViaXGJQ+JjQZ67Tn4stIkspI7Bo76CjO5xTBTKhoLWG4edpf/yKnIy
 HHR23BbpE2jJNmnto01gS1HOjzLucFOAO3OmjMbe3MUwoDqca219OKkysGYqqmH/AB
 U3KC04TJ71MtufQVYZtE+pIzuHsBlfzjfBo2n2uH4nZJbnhkhRO7uGqMSYM4LvXjkO
 tymy7+wNR1pScDHgn4DyRita7jqhSLAbXf/IOAZ/NtSP6cZ9B7E7aTzdB88TlIgjFI
 CIUelVEi7SujHFbl33ALeoJhpawkzUM9N/Vxk2Vw9vYFx7e/m2qTwBGgjiblKHRLzL
 PKgmcjMLGAavg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/8] drm/amd/colorop: Update to new pipeline API
To: "John Harrison" <John.Harrison@Igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609171941.169104-5-John.Harrison@Igalia.com>
References: <20260609171941.169104-5-John.Harrison@Igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 17:37:15 +0000
Message-Id: <20260609173716.1648B1F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing NULL check for kasprintf() when setting the color pipeline=
 name leads to a potential NULL pointer dereference in strlen().
- [High] Calling list_del on an uninitialized list head during error cleanu=
p causes a kernel panic.
--

commit 3a2ecacea83aea676a95a30af6588c8a29a29749
Author: John Harrison <John.Harrison@Igalia.com>

drm/amd/colorop: Update to new pipeline API

Switch to using the new method for building colorop pipelines.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> index 48f5c431eaf91..6b5741d9d98b0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
[ ... ]
> @@ -210,7 +212,7 @@ amdgpu_dm_build_default_pipeline(struct drm_device *d=
ev, struct drm_plane *plane
>  	if (ret)
>  		goto cleanup;
> =20
> -	drm_colorop_set_next_property(ops[i-1], ops[i]);
> +	drm_colorop_add_to_pipeline(ops[0], ops[i]);
> =20
>  	list->name =3D kasprintf(GFP_KERNEL, "Color Pipeline %d", ops[0]->base.=
id);

[Severity: High]
This isn't a bug introduced by this patch, but does this kasprintf() need a
NULL check?

If the memory allocation in kasprintf() fails, it returns a NULL pointer.
This NULL pointer is blindly assigned to list->name and then passed down to
drm_plane_create_color_pipeline_property() and eventually to
drm_property_add_enum(), which attempts to compute its length:

drivers/gpu/drm/drm_property.c:drm_property_add_enum() {
	...
	if (WARN_ON(strlen(name) >=3D DRM_PROP_NAME_LEN))
		return -EINVAL;
	...
}

Calling strlen(NULL) causes an immediate kernel panic during device
initialization. (This same pattern also appears in the Intel and VKMS
drivers' color pipeline initialization).

[Severity: High]
This is another pre-existing issue, but can calling list_del() on an
uninitialized list head during error cleanup cause a kernel panic?

When an error occurs early in color pipeline initialization (e.g.,
drm_mode_object_add() fails), the struct drm_colorop is zero-allocated but
never added to the global colorop_list. The error handling path in the Intel
driver unconditionally calls intel_colorop_destroy(), which delegates to
drm_colorop_cleanup():

drivers/gpu/drm/drm_colorop.c:drm_colorop_cleanup() {
	...
	list_del(&colorop->head);
	...
}

Because the list_head was never initialized with INIT_LIST_HEAD nor linked,
its prev pointer is NULL. The internal __list_del macro dereferences this
NULL pointer, causing an immediate kernel panic on driver probe failure. Is
this expected behavior?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609171941.1691=
04-1-John.Harrison@Igalia.com?part=3D4
