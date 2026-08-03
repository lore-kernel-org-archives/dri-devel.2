Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9CAC55196
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 18:35:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A9E510E098;
	Mon,  3 Aug 2026 18:35:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZIn7DATT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB43A10E098
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 18:35:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7235842B6E;
 Mon,  3 Aug 2026 18:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044E41F00A3D;
 Mon,  3 Aug 2026 18:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785782101;
 bh=56dAQEl/uWsg2t/erpRYymTDZhcEWsarYH0GDBKSWtA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZIn7DATTcAA5pLYQavX33/o47O7vxRkp8KXGugRlaI7emd0H8f7FaXtP5v3qdEony
 xI2OOpc5+x/FtnksFzWWVgqt13how3VTlbN12SCLL7dYs7theiiEhWJASQlt7x6T1O
 3ZXPSB6dJ6O8V6+XgOv2xSuhU5N/AFV5Sa5E2tMYbGKxdx/cQ3YgpHBZw5hYcyvPW2
 Tv7k1YzQME0kJXyFlzz5we8ZhF9AaFqdemsvPZ50O+KUdB0U1CnWW0FwiJA7rl9cua
 4RHW09NFYaeIjpUS6mOHqRqQNC6E0yTR6VsHYVdk0ls/ky+W3kDZgAO3LM0d7CR3fG
 gHSgF2KeiA0jQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 09/22] drm/bridge: synopsys: dw-dp: Free output_fmts
 when none are valid
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260803-synopsys-dw-dp-improvements-v9-9-2e6e46135312@collabora.com>
References: <20260803-synopsys-dw-dp-improvements-v9-0-2e6e46135312@collabora.com>
 <20260803-synopsys-dw-dp-improvements-v9-9-2e6e46135312@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 18:35:00 +0000
Message-Id: <20260803183501.044E41F00A3D@smtp.kernel.org>
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
- [High] The DRM core's bridge bus format negotiation protocol contains a m=
emory leak when a driver returns an allocated format array but 0 valid form=
ats. This problem wasn't introduced by this patch, but this patch adds a dr=
iver-local workaround instead of fixing the core API.
--

--- Patch [9]: [PATCH v9 09/22] drm/bridge: synopsys: dw-dp: Free output_fm=
ts when none are valid ---
commit 91ba4a99e0fef78bbe1a7632011fef0a483a9e57
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Free output_fmts when none are valid

This commit modifies dw_dp_bridge_atomic_get_output_bus_fmts() to free
the allocated output_fmts array if the number of valid formats is 0,
avoiding a memory leak.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 22a244de08aa1..bde938b0d116d 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -1813,6 +1813,11 @@ static u32 *dw_dp_bridge_atomic_get_output_bus_fmt=
s(struct drm_bridge *bridge,
>  		output_fmts[j++] =3D fmt->bus_format;
>  	}
> =20
> +	if (j =3D=3D 0) {
> +		kfree(output_fmts);
> +		output_fmts =3D NULL;
> +	}
> +

[Severity: High]
This isn't a bug introduced by this patch, but should this memory leak be
fixed in the DRM core instead of adding a driver-local workaround?

Looking at the DRM core's bridge bus format negotiation protocol in
drivers/gpu/drm/drm_bridge.c, the core leaks the array when a driver returns
an allocated format array but 0 valid formats:

drivers/gpu/drm/drm_bridge.c:drm_atomic_bridge_chain_select_bus_fmts() {
    ...
		out_bus_fmts =3D funcs->atomic_get_output_bus_fmts(last_bridge,
							last_bridge_state,
							crtc_state,
							conn_state,
							&num_out_bus_fmts);
		if (!num_out_bus_fmts)
			return -ENOTSUPP;
    ...
}

The core returns an error immediately without calling kfree(out_bus_fmts),
silently leaking the dynamically allocated array.

The same issue appears in select_bus_fmt_recursive() for
atomic_get_input_bus_fmts:

drivers/gpu/drm/drm_bridge.c:select_bus_fmt_recursive() {
    ...
	in_bus_fmts =3D cur_bridge->funcs->atomic_get_input_bus_fmts(cur_bridge,
							cur_state,
							crtc_state,
							conn_state,
							out_bus_fmt,
							&num_in_bus_fmts);
	if (!num_in_bus_fmts)
		return -ENOTSUPP;
    ...
}

Would it be better to fix the core API to handle freeing the array when
num_out_bus_fmts or num_in_bus_fmts is 0, rather than patching each
individual bridge driver?

>  	*num_output_fmts =3D j;
> =20
>  	return output_fmts;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-synopsys-d=
w-dp-improvements-v9-0-2e6e46135312@collabora.com?part=3D9
