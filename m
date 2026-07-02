Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F801C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A43EA10F273;
	Thu,  2 Jul 2026 09:48:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Gutlxfz2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F346A10F272
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 09:48:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BAD6043AF7;
 Thu,  2 Jul 2026 09:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C191F000E9;
 Thu,  2 Jul 2026 09:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782985714;
 bh=pZOCz896+1h3J3ireaYjTWn981ZBHIZhmjtwt7A2VbQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Gutlxfz2Spx1UTIEGR4tzpu88HG5kFPngCScslSOeY+9D0PR1mMFreMDVKm+pQtSA
 JXVIWeP2S8IEZ+FD3IJwOdA7V0HgOhpoNDlO+z/Jp2xGpK1RyQAdCpOuOgBdg43Joa
 sRncBMe9Pt6KqUD7/u+f8hvM648UNFcEFDC1KONLMQ1gEy4HFOe+CBa56jH3krYjxo
 3E+ECFcSiiU6ha5ltfExlwLpkJXJTZaQMbBtTcM21rU6ffwbxLEKJsaVevG+At+gEf
 u8Ty9I0CJ4n7qCVuWhM3MpqNW1Y8yVRpAw362UwMuY52Qd0gli+sc7/IR/FBxr6VPo
 DFnzr7RxJJ2GA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] drm/drm_ras: Add drm_ras netlink error event
To: "Riana Tauro" <riana.tauro@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701094409.129131-6-riana.tauro@intel.com>
References: <20260701094409.129131-5-riana.tauro@intel.com>
 <20260701094409.129131-6-riana.tauro@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 09:48:33 +0000
Message-Id: <20260702094834.71C191F000E9@smtp.kernel.org>
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
- [Medium] Multicast hardware error events are restricted to `init_net` des=
pite the netlink family supporting multiple network namespaces (`.netnsok =
=3D true`).
- [Medium] Multicast group 'error-report' does not require net-admin privil=
eges, leaking restricted error data to unprivileged users.
--

commit 6e5a626b76568687a02f046e7898ab55e1095ab9
Author: Riana Tauro <riana.tauro@intel.com>

drm/drm_ras: Add drm_ras netlink error event

Define a new netlink event error-event and a new multicast group
error-report in drm_ras. Each event contains device name, node and
error information to identify the error triggering the event.

> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index d6eab29a1394c..77f912a4d101f 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c

[ ... ]

> @@ -222,6 +255,60 @@ static int doit_reply_value(struct genl_info *info, =
u32 node_id,

[ ... ]

> +int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, cons=
t char *error_name,
> +			   u32 value, gfp_t flags)
> +{
> +	struct genl_info info;
> +	struct sk_buff *msg;
> +	struct nlattr *hdr;
> +	int ret;
> +
> +	if (!error_name)
> +		return -EINVAL;
> +
> +	if (!genl_has_listeners(&drm_ras_nl_family, &init_net, DRM_RAS_NLGRP_ER=
ROR_REPORT))

[Severity: Medium]
Since the generic netlink family explicitly supports multiple network
namespaces by setting .netnsok =3D true, will hardcoding init_net here
prevent listeners in non-init namespaces from receiving error events?

> +		return 0;
> +
> +	genl_info_init_ntf(&info, &drm_ras_nl_family, DRM_RAS_CMD_ERROR_EVENT);
> +
> +	msg =3D genlmsg_new(NLMSG_GOODSIZE, flags);

[ ... ]

> +	genlmsg_end(msg, hdr);
> +	genlmsg_multicast(&drm_ras_nl_family, msg, 0, DRM_RAS_NLGRP_ERROR_REPOR=
T, flags);

[Severity: Medium]
Similar to the listener check above, does using genlmsg_multicast() route
the message exclusively to the init_net namespace?

Any containerized user trying to listen to these events may silently fail
to receive them if the events are artificially restricted to init_net.

> +	return 0;
> +
> +cancel_msg:

[ ... ]

> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> index dea1c1b2494e8..9d3123cc9f9ca 100644
> --- a/drivers/gpu/drm/drm_ras_nl.c
> +++ b/drivers/gpu/drm/drm_ras_nl.c
> @@ -58,6 +58,10 @@ static const struct genl_split_ops drm_ras_nl_ops[] =
=3D {
>  	},
>  };
> =20
> +static const struct genl_multicast_group drm_ras_nl_mcgrps[] =3D {
> +	[DRM_RAS_NLGRP_ERROR_REPORT] =3D { "error-report", },

[Severity: Medium]
Should this multicast group require net-admin privileges?

The get and list commands for drm_ras enforce GENL_ADMIN_PERM, but this
multicast group definition omits capability flags like GENL_UNS_ADMIN_PERM.
Will this allow unprivileged users to subscribe to the group and receive
hardware error data that they are otherwise restricted from querying?

> +};
> +
>  struct genl_family drm_ras_nl_family __ro_after_init =3D {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701094409.1291=
31-5-riana.tauro@intel.com?part=3D1
