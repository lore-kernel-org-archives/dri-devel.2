Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0374F606AA40
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 05:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQXp2N+5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07A3F10ED27;
	Thu, 19 Nov 2026 05:36:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2016210ED1A;
 Thu, 19 Nov 2026 05:35:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C73CB48A17;
 Thu, 19 Nov 2026 05:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BF41F000C7;
 Thu, 19 Nov 2026 05:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795066550;
 bh=qNhv8f7ztG8ChBHtjnkmQwUUU8sDghC9Duib2Qq/9F0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aQXp2N+5qsAEyMVGb8vGotDLxaop3mmBEFSP+Vt/koL1VyVKRx6/Ft16nUyZkCR8Y
 LuQjS/GLsr0xIi7Gbtf1qDW+uKP0NLB+/y9LnY4i4IRyYfRIp1LdrqRrtibbMOVoGo
 jy0GKEjt5PVxfPoqYI822VUWM7kfMMw9DwZNMkwMtGBIbuRjy1JEUpT+sGIn3p02+N
 pb227LWZR8m7jztMESpyM1YsZvOpUa7e/ZugtVdNrvYm9qR9nUWZlPs8IkFJlxPlc6
 XhxYgMMj/19mpjfTDPb23zGSSsFOeK2bi/9pIWqB9DUt6yaoKAg7fOa40/1hgwuh3v
 y6RBNkHvsFEtw==
Message-ID: <sashiko-outbox-222493@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm/amd/display: Route connector DDC over AUX for
 native DP sinks
To: "Mario Limonciello" <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261118-superm1-amdgpu-ddc-v4-1-539eaeb4edd7@kernel.org>
References: <20261118-superm1-amdgpu-ddc-v4-1-539eaeb4edd7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 05:35:50 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/amd/display: stale link->aux_mode in amdgpu_dm_i2c_xfer()
  breaks DP++
--

commit bd7217b6334d8e26e4a44e7561c8afe2462a790d
Author: Mario Limonciello <superm1@kernel.org>

drm/amd/display: Route connector DDC over AUX for native DP sinks

This commit routes transfers on a connector's DDC i2c adapter through the
AUX DDC adapter when link->aux_mode is set so that native DisplayPort, eDP,
and MST sinks can be reached via the connector's ddc bus.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index b498fc5fbb140..f80de9e7f850c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -3373,6 +3373,22 @@ STATIC_IFN_KUNIT int amdgpu_dm_i2c_xfer(struct i2c=
_adapter *i2c_adap,
>  	int i;
>  	int result =3D -EIO;
> =20
> +	if (!i2c->oem && ddc_service->link) {
> +		struct dc_link *link =3D ddc_service->link;
> +		struct amdgpu_dm_connector *aconnector =3D link->priv;
> +
> +		/*
> +		 * DDC to a native DisplayPort sink (SST, MST or eDP) is
> +		 * tunneled over the AUX channel; the physical i2c pins only
> +		 * reach DVI/HDMI sinks (e.g. DP++ with a passive adapter).
> +		 * Use the same aux_mode selection as the EDID read helpers so
> +		 * the connector's single "ddc" bus works for either sink.
> +		 */
> +		if (aconnector && link->aux_mode &&
> +		    aconnector->dm_dp_aux.aux.ddc.algo)
> +			return i2c_transfer(&aconnector->dm_dp_aux.aux.ddc, msgs, num);
> +	}

[Severity: High]
As reported by Eren =C3=96zen on v2 [1], can a stale link->aux_mode misrout=
e the
passive DP++ dongle identification read over AUX when a native DisplayPort
sink is unplugged and replaced with a passive DP-to-HDMI adapter on the
same port?

link->aux_mode is not cleared on disconnect, and
detect_link_and_local_sink() only updates it after detect_dp() returns:

drivers/gpu/drm/amd/display/dc/link/link_detection.c:detect_link_and_local_=
sink() {
	...
			if (!detect_dp(link, &sink_caps, reason)) {
	...
		set_ddc_transaction_type(link->ddc,
						     sink_caps.transaction_type);

		link->aux_mode =3D
			link_is_in_aux_transaction_mode(link->ddc);
	...
}

During detect_dp(), dp_passive_dongle_detection() ->
query_dp_dual_mode_adaptor() reads DP_HDMI_DONGLE_ADDRESS (0x40) via
i2c_read() -> dm_helpers_submit_i2c() -> i2c_transfer(&aconnector->i2c->bas=
e)
-> amdgpu_dm_i2c_xfer() while link->aux_mode is still true from the
previous native DP sink.  Forwarding that read to I2C-over-AUX fails on a
passive DP++ adapter, causing query_dp_dual_mode_adaptor() to fall back to
DISPLAY_DONGLE_DP_DVI_DONGLE (SIGNAL_TYPE_DVI_SINGLE_LINK), which caps the
pixel clock to 165 MHz and disables HDMI audio and infoframes.

[1] https://lore.kernel.org/r/QU464501lRPW3X8es-jXBFOvvwqS3eKR3HRS33U6x6o5e=
YC6h5AKV7f3ZXRCaU7-sEcupJMHereqyDUsUSG_fsOMNwvGO_CcZRKsz1AgObk=3D@protonmai=
l.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-superm1-am=
dgpu-ddc-v4-1-539eaeb4edd7@kernel.org?part=3D1
