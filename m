Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19334C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6802710EBD4;
	Wed, 29 Jul 2026 12:23:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H5tYfE8y";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FF9510EBD4
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 12:23:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 796614185D;
 Wed, 29 Jul 2026 12:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FB91F000E9;
 Wed, 29 Jul 2026 12:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785327827;
 bh=1ow8LJXoKFZhsbjGUZoPkCtd1UWUBrZaJ0yEsvZjWEE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H5tYfE8yyRGLQphHbu8Yh7bUkoQjSRPMpx45UInkkj6L99FSdNrCw7Vnzzy2iR4Cj
 sBZXm2zusQOV1VWCbUiYND7KaxstFrMMdUj9pOVtfatv2gux8t78hW2j04eRYxEcXl
 Ve7s3YeuZJsaf4XsA5WF36v5Sy2lG++lUTrqJpB6nzXphYoMaPYRzqzkDsDNh2Q3wl
 5kLMqASmyYbDXwqUjbDk+LfnI6s1uT2TTiNjMpC+05MEEduETR0fYiRaJOKwoeJvP7
 IFrqBBTTFaD4AT0Dl8a0jvdWbRjnfQkQKpsjeJLu80daitYay6HM6dW1yCDQuvrZjN
 gh+f1Eptv8uKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/connector: hdmi: Implement "min bpc" property
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729-min-bpc-v2-2-7d0036ef437c@collabora.com>
References: <20260729-min-bpc-v2-0-7d0036ef437c@collabora.com>
 <20260729-min-bpc-v2-2-7d0036ef437c@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 12:23:46 +0000
Message-Id: <20260729122346.C8FB91F000E9@smtp.kernel.org>
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
- [Low] The new `min_requested_bpc` property is not printed in `drm_atomic_=
connector_print_state()`.
--

--- Patch [2]: [PATCH v2 2/2] drm/connector: hdmi: Implement "min bpc" prop=
erty ---
commit 1bb247d1cac675bb602431e3c391ddd31f8fed8d
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/connector: hdmi: Implement "min bpc" property

Act on the "min bpc" property's min_requested_bpc state in the common
HDMI state helpers, and register the property on HDMI connectors.
Also add two KUnit tests to verify that the property behaves as expected.

> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index 3ecc079404a10..f019bd5fef692 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -640,6 +640,10 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
>  	if (ret)
>  		return ret;
> =20
> +	ret =3D drm_connector_attach_min_bpc_property(connector, max_bpc);
> +	if (ret)
> +		return ret;
> +

[Severity: Low]
Since we are adding support for the min bpc property and using
min_requested_bpc in the connector state, should this also be printed in
drm_atomic_connector_print_state() alongside max_requested_bpc?

For example, looking at drivers/gpu/drm/drm_atomic.c in
drm_atomic_connector_print_state():

	drm_printf_indent(p, 1, "max_requested_bpc=3D%d\n", state->max_requested_b=
pc);
	drm_printf_indent(p, 1, "colorspace=3D%s\n", drm_get_colorspace_name(state=
->colorspace));

Without printing it here, the debugfs atomic state dump will not display
the min_requested_bpc field, which might make debugging atomic commits
incomplete.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-min-bpc-v2=
-0-7d0036ef437c@collabora.com?part=3D2
