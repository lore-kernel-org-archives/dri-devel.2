Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB482C531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 09:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 446D110F04B;
	Thu, 23 Jul 2026 09:42:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cbQ1lrw/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9427E10F054
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 09:42:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4CF054340E;
 Thu, 23 Jul 2026 09:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069161F000E9;
 Thu, 23 Jul 2026 09:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784799763;
 bh=1lajitYV73ugkBBbQ4I//TC0/wcJqTL0kT1y4s0j0CQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cbQ1lrw/pPFsf/Z/IPDPIs70jaeNdzuX1I6LcNU5ym3OrriGVvq84tgjIAmiF1Z//
 zjWmyffrrlrJVr2bNR61lQ1n4H5Aw9zU+QHd3bmMQebLvOIR5SX7E90l2sjnXprDBn
 PpKQVwwd2oPD3NgcE7Dg/h/2dkm5sc1fTVB6qx6gO3hu9M1dOZde1ddl341zmliDKI
 trzuUsEuc8FIvbQbk9PB7mfIu00cidJddCAakQqYyWOuO3QGHdUHvzaSWBOMTQ3opD
 QZqPFJOT3IUM0xVlJa7jx9q7HEuY0TRJM1HzXyrIp7obOuB97y8oyivtDv7YGdJ960
 kyRaKx3MQWzmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] drm/drm_ras: Add drm_ras netlink error event
To: "Riana Tauro" <riana.tauro@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722094134.3036087-5-riana.tauro@intel.com>
References: <20260722094134.3036087-4-riana.tauro@intel.com>
 <20260722094134.3036087-5-riana.tauro@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 09:42:42 +0000
Message-Id: <20260723094243.069161F000E9@smtp.kernel.org>
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
- [High] Memory leak of the netlink message sk_buff in the error path of do=
it_reply_value().
--

--- Patch [1]: [PATCH v6 1/2] drm/drm_ras: Add drm_ras netlink error event =
---
commit 71a58eced6bfe5deeec605fb34ee6d129ff7cc14
Author: Riana Tauro <riana.tauro@intel.com>

drm/drm_ras: Add drm_ras netlink error event

This commit introduces a new netlink event error-event and a multicast group
error-report for the drm_ras family. It provides drm_ras_nl_error_event() to
allow drivers to broadcast device, node, and error information to userspace.

> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index d6eab29a1394c..39155fb514de3 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c

[ ... ]

> +static int msg_put_error_event_attrs(struct sk_buff *msg, struct drm_ras=
_node *node,
> +				     u32 error_id, const char *error_name, u32 value)
> +{

[ ... ]

> +}
> +
>  static int doit_reply_value(struct genl_info *info, u32 node_id,
>  			    u32 error_id)
>  {

[Severity: High]
This is a pre-existing issue, but could this leak the msg buffer?

Looking at doit_reply_value() in drivers/gpu/drm/drm_ras.c, msg is allocated
using genlmsg_new() at the beginning of the function:

        msg =3D genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
        if (!msg)
                return -ENOMEM;

If get_node_error_counter() fails, the function returns early:

        ret =3D get_node_error_counter(node_id, error_id,
                                     &error_name, &value);
        if (ret)
                return ret;

Does this error path need to call nlmsg_free(msg) to avoid leaking the sk_b=
uff
each time an invalid node_id or error_id is queried?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722094134.3036=
087-4-riana.tauro@intel.com?part=3D1
