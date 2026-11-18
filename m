Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E198606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 23:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBEIwNmM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74E3E10FF46;
	Wed, 18 Nov 2026 23:35:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5DD210FF46
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:35:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2C21664299;
 Wed, 18 Nov 2026 23:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9011F000C4;
 Wed, 18 Nov 2026 23:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795044921;
 bh=cMXiA2wHTkXBJY5f41144k50qDMBqVjdUMjm5RqxngI=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=YBEIwNmMBtZycIcIFEUojZ0hNXvdLnDVF0sOFaZxrfwjsZ0MmwS7lcMGdoVyDI16q
 SKEERkyjz265pu66Xqes/FbGV1t6OzCy5HbthNuonM4Y7gDmRErEXSATWZLWu4p6L3
 TucLKK3GsX1ME2SoDNYP1NdUNA9MtRBaa8rCdZJf1ehvUnt7fAiBz/QkWWSCr43tOj
 6ks5PfMmMd4+G8A7t1/6qSjvBNCpZ+aKVkUrOfqD2KBx9oWpWtSi7fn+PvL9Zg+UN+
 vqDUVuh1JiwJvxp0kXM1VoTuiCQ3CJmJJoIVGYNCps4bvpCSIArqMmX9Kr7Ho8bCUb
 K/WZljxFoCvyg==
Message-ID: <sashiko-outbox-222189@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] drm/drm_ras: Extend DRM RAS interface to include
 telemetry nodes
To: "Zack McKevitt" <zachary.mckevitt@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261117233442.407877-4-zachary.mckevitt@oss.qualcomm.com>
References: <20261117233442.407877-1-zachary.mckevitt@oss.qualcomm.com>
 <20261117233442.407877-4-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 23:35:21 +0000
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
- [Low] drm/drm_ras: telemetry-attrs mode flags attribute uses u8
  instead of u32/uint
--

commit fd2287347a17ff8e49c9be2dea7e5b0d3b353084
Author: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>

drm/drm_ras: Extend DRM RAS interface to include telemetry nodes

This commit extends the DRM RAS netlink interface with a telemetry node
type and adds operations to list telemetry fields and read or write field
values.

> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/net=
link/specs/drm_ras.yaml
> index a88fdab7a1c74..28a89aef1e016 100644
> --- a/Documentation/netlink/specs/drm_ras.yaml
> +++ b/Documentation/netlink/specs/drm_ras.yaml

[ ... ]

> @@ -100,6 +105,41 @@ attribute-sets:
>          name: error-value
>          type: u32
>          doc: Current value of the error counter.
> +  -
> +    name: telemetry-attrs
> +    attributes:

[ ... ]

> +      -
> +        name: mode
> +        type: u8
> +        enum: telemetry-field-mode
> +        doc: >-
> +             Bitmask of access modes (read/write) supported by the
> +             telemetry field.

[Severity: Low]
Should the mode attribute in telemetry-attrs (and struct
drm_ras_telemetry_field.mode) use u32 or uint instead of u8?

Netlink attributes are padded to 4-byte alignment, so u8 saves no space on
the wire over a 32-bit attribute while permanently limiting the
telemetry-field-mode bitmask in the userspace interface to 8 flags.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117233442.4078=
77-1-zachary.mckevitt@oss.qualcomm.com?part=3D3
