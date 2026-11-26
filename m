Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DF6606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V1QHmQrE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0533D10EA22;
	Thu, 26 Nov 2026 13:59:17 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FC5D10EA22
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:59:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 027A043B9D
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B721F000CF;
 Thu, 26 Nov 2026 13:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795701549;
 bh=BUnBxZ5TOpW1AE3y1XW0jFiWlj+sMinsf6/9xM46Lqc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V1QHmQrEthigKZd/JGcLzshP5iEKCV5VRSuYtJR9YgalJ9D8sLKYqmLlPd2pZHaHB
 KmT3jz1ThIPl4JRSC2s7QGIZCKhupJDlAHYcI64M/OsPHw7Gl0W7+Mse0UvGASZJdB
 tn57Jk/HwVml0eXRIIpPba8hnBJCVK1Y58T65gVEPLQGzCPZCObr9zr2EGWTMd5Gyh
 ETG5z9NeHkxcL3gcLsl56B+DAKMIhOqySCsvUZVF/rOKJfsnKWbdAER0xU5rRuqmy5
 W+TkSNmSlDMwDACgOK2OJOWSOWS42vawvxOQYVlJ+X5VSYY78ZYtY20Cp1taHOmNmD
 rJNLpMj/uo/Jg==
Message-ID: <sashiko-outbox-235666@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/10] arm64: dts: qcom: sm8450-hdk: Add display card
 overlay
To: "Vladimir Zapolskiy" <vz@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261126134508.320700-9-vz@kernel.org>
References: <20261126134508.320700-1-vz@kernel.org>
 <20261126134508.320700-9-vz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 13:59:09 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] arm64: dts: qcom: sm8450-hdk sound probe fails due to enabled
  HDMI DAI link
--

commit 2845e74d5b67d8963c4614b68345c54b82ab8dfb
Author: Vladimir Zapolskiy <vz@kernel.org>

arm64: dts: qcom: sm8450-hdk: Add display card overlay

This commit adds a devicetree overlay for the SM8450 HDK external display
card with a Novatek NT36672E DSI panel and disables the mutually exclusive
on-board Lontium LT9611UXC HDMI bridge.

> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk-display-card.dtso b/arch=
/arm64/boot/dts/qcom/sm8450-hdk-display-card.dtso
> new file mode 100644
> index 0000000000000..3fcaae7f2abc0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk-display-card.dtso
> @@ -0,0 +1,144 @@

[ ... ]

> +/* Disable HDMI bridge related nodes (mutually exclusive with the displa=
y card) */
> +
> +&i2c9 {
> +	status =3D "disabled";
> +};
> +
> +&lt9611_1v2 {
> +	status =3D "disabled";
> +};
> +
> +&lt9611_3v3 {
> +	status =3D "disabled";
> +};
> +
> +&lt9611_codec {
> +	status =3D "disabled";
> +};

[Severity: High]
Does disabling lt9611_codec without disabling the HDMI MI2S DAI link under
&sound break the sound card probe?

In arch/arm64/boot/dts/qcom/sm8450-hdk.dts, the prim-mi2s-dai-link child no=
de
of &sound remains enabled and references <&lt9611_codec 0>:

arch/arm64/boot/dts/qcom/sm8450-hdk.dts:
	prim-mi2s-dai-link {
		link-name =3D "HDMI Playback";
		...
		codec {
			sound-dai =3D <&lt9611_codec 0>;
		};

When qcom_snd_parse_of() iterates the available child nodes of &sound,
snd_soc_of_get_dai_link_codecs() fails with -EPROBE_DEFER because
lt9611_codec is disabled and never registers a codec component, preventing
the entire sound card from registering.  Like sm8550-hdk-display-card.dtso,
prim-mi2s-dai-link can be given a label in sm8450-hdk.dts and disabled in
this overlay.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126134508.3207=
00-1-vz@kernel.org?part=3D8
