Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0CCC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:05:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 770A010F3FE;
	Thu,  2 Jul 2026 15:05:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bJdZKtAx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9EFB10F3FE
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 15:05:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E59D601CA;
 Thu,  2 Jul 2026 15:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672831F00A3A;
 Thu,  2 Jul 2026 15:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783004742;
 bh=EyRMADtcq1Zth8NXXL2Ld42UaBzINtA7u3ZQ0hYifG8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bJdZKtAxIg2OfZIEc/b1nVNEsurJzvmRugBlxQx+sA/gbnu+zVu1Fnukk0jvZw6fJ
 kVVC1mw6decTRy+0uQodUyxds4syYBfh2LjkmQ0h8f3NoT9W6Q2JDWb2ITYmBnY8+b
 FzIC08aWs2hWhZDfR2ItoRaoSN6JTNtOI9/+zmMeLzGzzI5JmyCpXbzkEMfZE8OdW6
 3OWfkFJSpCkuVAWysKRdiQaOOpCWUADnVclM3PMSZTyMmm7/ZJKiEK+vuLZzr1NlHO
 mWyu9mU1uVH68LepoNqMt0ytpmvn96t9Ga9N30qDQmQzc5232uCbFsE2zQ2SfSYZ/O
 kv76+uSrtPn2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/39] drm/display: hdmi-state-helper: Add fallback
 TMDS rate validation
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-9-d79890d00b6a@collabora.com>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-9-d79890d00b6a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:05:40 +0000
Message-Id: <20260702150541.672831F00A3A@smtp.kernel.org>
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
- [Medium] The fallback TMDS character rate validation is silently bypassed=
 for HDMI bridge connectors because the bridge framework unconditionally pr=
ovides a wrapper callback.
--

commit 98644f49de11eb659578421bd532a4a887719f94
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/display: hdmi-state-helper: Add fallback TMDS rate validation

Validate the computed TMDS character rate against connector limits when no
driver-specific hook is provided.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index ce17eeefc2da4..db76699093e87 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -566,6 +566,9 @@ hdmi_clock_valid(const struct drm_connector *connecto=
r,
>  		status =3D funcs->tmds_char_rate_valid(connector, mode, clock);
>  		if (status !=3D MODE_OK)
>  			return status;
> +	} else if (connector->hdmi.max_tmds_char_rate) {

[Severity: Medium]
Does this else if structure bypass the fallback logic for HDMI bridge
connectors?

The bridge framework always provides a wrapper for its connectors:

drm_bridge_connector_tmds_char_rate_valid() {
        if (bridge->funcs->hdmi_tmds_char_rate_valid)
                return bridge->funcs->hdmi_tmds_char_rate_valid(...);
        else
                return MODE_OK;
}

Because this wrapper unconditionally exists, funcs->tmds_char_rate_valid
evaluates to true in hdmi_clock_valid().

If the underlying bridge lacks its own validation, the wrapper simply retur=
ns
MODE_OK. Since this was checked in the first if statement, the execution sk=
ips
the else if branch entirely.

Will this prevent the max_tmds_char_rate limit from being enforced on bridge
drivers, potentially allowing unsupported display modes to be selected?

> +		if (clock > connector->hdmi.max_tmds_char_rate)
> +			return MODE_CLOCK_HIGH;
>  	}
> =20
>  	return MODE_OK;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-dw-hdmi-qp=
-scramb-v8-0-d79890d00b6a@collabora.com?part=3D9
