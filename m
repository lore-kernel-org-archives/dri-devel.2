Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD53C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AA9210E64A;
	Tue, 21 Jul 2026 08:26:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Hv8pxWHD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E262910E2F2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 08:26:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CAEFC43C2C;
 Tue, 21 Jul 2026 08:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841EF1F000E9;
 Tue, 21 Jul 2026 08:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784622389;
 bh=vFAdaoT7OamaEBVURNU0AFkYyr0nmD6m2RXog9dfwOg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Hv8pxWHDL6WcLm4flf4e6LRD87BpvKljGokYMAaYxda1w1lfj4D9+q5tLuS1Bem8Y
 /lIbT2koQpXyPaJqgZE2DU6wVv3Po2XTH9/+xD4jFFy2C8zyxldUNL/ogfQhONac9Y
 4qDG2JdKOUfePsJk8IjpuQJ7mahJK0EiYihpuBhvLtt0zisVYNUymdSe5wkBA69rMG
 Lxwg0puTuxt3GOFLWsyDPotqPhb/qjl0aR+0dkQwuMHihmPvNkvHgT9Vk/UIw/UWWJ
 drCFeOldZiuIBBu4MyYjZTUZjL2DOfPPvU606uABks2oTFJEWf08FDuB5ionuuc2LO
 crZ/fGNFDX3HA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] drm/drm_ras: Add drm_ras netlink error event
To: "Riana Tauro" <riana.tauro@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720082208.2648279-6-riana.tauro@intel.com>
References: <20260720082208.2648279-5-riana.tauro@intel.com>
 <20260720082208.2648279-6-riana.tauro@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 08:26:29 +0000
Message-Id: <20260721082629.841EF1F000E9@smtp.kernel.org>
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
- [High] The 'error-report' multicast group lacks the admin-perm flag, allo=
wing unprivileged users to listen to sensitive hardware events.
- [Medium] The exported API drm_ras_nl_error_event() unconditionally uses G=
FP_KERNEL for netlink message allocation, making it unsafe to call from ato=
mic context.
--

--- Patch [1]: [PATCH v5 1/3] drm/drm_ras: Add drm_ras netlink error event =
---
commit 50118022fc58ae5076236cbd29a79d06fb22c201
Author: Riana Tauro <riana.tauro@intel.com>
drm/drm_ras: Add drm_ras netlink error event

This commit defines a new netlink event error-event and a new multicast
group error-report in drm_ras to report hardware errors to userspace.
It also adds the exported function drm_ras_nl_error_event() to trigger
these events from drivers.

> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/net=
link/specs/drm_ras.yaml
> index e113056f8c016..8aed3d4515e5a 100644
> --- a/Documentation/netlink/specs/drm_ras.yaml
> +++ b/Documentation/netlink/specs/drm_ras.yaml
[ ... ]
> +mcast-groups:
> +  list:
> +    -
> +      name: error-report

[Severity: High]
Should this multicast group include flags: [admin-perm]?

The netlink commands for this family explicitly require GENL_ADMIN_PERM, but
this multicast group omits the flag. Without it, unprivileged users can open
a netlink socket and subscribe to the error-report group, potentially
observing sensitive hardware reliability events that could be used in
side-channel attacks.

> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index d6eab29a1394c..0b77e4358ea8f 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
[ ... ]
> +int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, cons=
t char *error_name,
> +			   u32 value)
> +{
> +	struct genl_info info;
> +	struct sk_buff *msg;
> +	struct nlattr *hdr;
> +	int ret;
> +
> +	if (!error_name)
> +		return -EINVAL;
> +
> +	genl_info_init_ntf(&info, &drm_ras_nl_family, DRM_RAS_CMD_ERROR_EVENT);
> +
> +	msg =3D genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);

[Severity: Medium]
Will this function be called from atomic contexts?

Hardware RAS errors are frequently detected and reported from interrupt
handlers or while holding spinlocks. If a driver calls this API from an ato=
mic
context, the unconditional GFP_KERNEL allocation will cause a sleep-in-atom=
ic
panic.

Would it be safer to accept a gfp_t mask as a parameter, or default to
GFP_ATOMIC, to support reporting from these contexts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720082208.2648=
279-5-riana.tauro@intel.com?part=3D1
