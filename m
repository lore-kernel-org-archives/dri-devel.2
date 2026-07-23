Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DCAC44532
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 02:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E6EC10EF6F;
	Thu, 23 Jul 2026 02:01:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mRwKWptb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CB2110EF6F
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 02:01:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C5876600AB;
 Thu, 23 Jul 2026 02:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519551F000E9;
 Thu, 23 Jul 2026 02:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784772068;
 bh=s3yMrTWvUp9juJgceu9qtZDFP+ds1g1rAbkb1qGHm7k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mRwKWptbO4nTuXiLIJCiI2aFMHzON8XcGJRIsDC+qn35OZwT9l4DHnFEOnuftgpL7
 hzxHGjzctiJcoLRA1jLYZ4OyBK3qpMDDjx4S1lmhlx9CynsT79aICiTKlj/IxI6IKp
 hSgaYrzxS/D1HqTHqyxOERDJnM0vkc917yf7vxqFnaRkuQf8DUg28T5AJhmFsKe1Kb
 0C7D64l2uX3CaV6+N9RZFJx0MukDde4ZbvmLE85Yr7glp21UNfAzEio9QwwPd0mNsP
 Qs94hajCdxGBp4vSknv5BC2mzYuXEkZAl1FUBM4BFlCV7Su8hUt+E7LMuD/vlh96Re
 FDd+f7Wmj9H+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 58/61] drm/connector: Remove drmm_connector_hdmi_ini2()
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260723-dw-hdmi-qp-scramb-v9-58-4fb12ea22ac9@collabora.com>
References: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
 <20260723-dw-hdmi-qp-scramb-v9-58-4fb12ea22ac9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 02:01:07 +0000
Message-Id: <20260723020108.519551F000E9@smtp.kernel.org>
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
- [Medium] Incomplete transition and missed cleanup of TODOs for HDMI conne=
ctor state fields.
--

--- Patch [58]: [PATCH v9 58/61] drm/connector: Remove drmm_connector_hdmi_=
ini2() ---
commit bc0f9c01790d98f211c2100593457435fcb56011
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

    drm/connector: Remove drmm_connector_hdmi_ini2()

This commit removes the transitional drmm_connector_hdmi_ini2() function
since all callers have been converted to the new drmm_connector_hdmi_init()
signature.

> All callers have been converted to the new drmm_connector_hdmi_init()
> signature.  Remove the transitional drmm_connector_hdmi_ini2() function,
> its declaration, its EXPORT_SYMBOL() and its kernel-doc.

[Severity: Medium]
If the transition is now complete, were the TODO cleanups in
drmm_connector_hdmi_init() missed?

There are still assignments left with explicit TODO comments in
drivers/gpu/drm/drm_connector.c:

	/* TODO: remove after conversion to new drmm_connector_hdmi_init() */
	connector->hdmi.supported_formats =3D hdmi_funcs->supported_formats;
	...
	/* TODO: remove after conversion to new drmm_connector_hdmi_init() */
	strtomem_pad(connector->hdmi.vendor, hdmi_funcs->vendor, 0);
	strtomem_pad(connector->hdmi.product, hdmi_funcs->product, 0);
	...
	/* TODO: remove after conversion to new drmm_connector_hdmi_init() */
	connector->max_bpc =3D hdmi_funcs->max_bpc;

Additionally, external consumers still appear to rely on the duplicated
state fields rather than using the funcs structure. For instance, in
drivers/gpu/drm/display/drm_hdmi_state_helper.c:

	if (!(connector->hdmi.supported_formats & BIT(format))) {

Since this patch marks the end of the transition, should these duplicated
fields be removed and their users updated to use
connector->hdmi.funcs->supported_formats instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-dw-hdmi-qp=
-scramb-v9-0-4fb12ea22ac9@collabora.com?part=3D58
