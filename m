Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9B0606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D957N++n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B5FA10FA1D;
	Wed,  4 Nov 2026 09:20:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0902010FA1E
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 09:20:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E6C3B41752;
 Wed,  4 Nov 2026 09:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895EB1F0093A;
 Wed,  4 Nov 2026 09:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793784034;
 bh=uMjF/chQexJDpp0ppaFT0lAl4UCDmFJoHUtF6hICr4E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D957N++nNtq8987qJYSGyF54XrANbX6L3mJUGX1dQ9lqzscegcx2P4AkFyRO6P/O6
 5nxqAbu8neA1pd4pEteOruPt73Yf4He0aNmnGiBteA9Ji8jhyxJaD8GoArXbV013/h
 XeTUqTpVfFFGx4Zd32wjooV5ZXBs06vopXaLlNPgx+oNAl1lWdDZDUE0eYMA/KdfvX
 pTYLGWSYjtn6yquzniVT0bjIauN3X0M8jaM7K5Nn8R7c/23Fyh4Y9bjgFdkq2rS8aV
 h6FltXvclzur7EXvs6fKeMFPoRl1yilsVIFpeTtM+E8kQjdFbWQT0sACHxpSRGXFf+
 FVhK0+mQqddkw==
Message-ID: <sashiko-outbox-196944@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add Novatek NT37802
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261104-jshekhar-nt37802-v1-1-58e5e7fb2556@oss.qualcomm.com>
References: <20261104-jshekhar-nt37802-v1-0-58e5e7fb2556@oss.qualcomm.com>
 <20261104-jshekhar-nt37802-v1-1-58e5e7fb2556@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 09:20:34 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: display: panel: maintainer email mismatch in nt37802 s=
chema
--

commit 5aac2d7c3f53fb607c4bdfc23eafa7cc910f9e16
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

dt-bindings: display: panel: Add Novatek NT37802

This commit adds the Device Tree binding schema for the Novatek NT37802
AMOLED DSI command-mode panel.

> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt37=
802.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt37802.=
yaml
> new file mode 100644
> index 0000000000000..14a59a9b0feca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt37802.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/novatek,nt37802.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Novatek NT37802 AMOLED DSI Command-Mode Panel
> +
> +maintainers:
> +  - Jayant Shekhar <jshekhar@oss.qualcomm.com>

[Severity: Low]
Should the maintainer email address in the maintainers list match the
jayant.shekhar@oss.qualcomm.com address used in the commit Author and
Signed-off-by headers?

When scripts/get_maintainer.pl queries
Documentation/devicetree/bindings/display/panel/novatek,nt37802.yaml, it
extracts jshekhar@oss.qualcomm.com from the maintainers list instead of
jayant.shekhar@oss.qualcomm.com.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-jshekhar-n=
t37802-v1-0-58e5e7fb2556@oss.qualcomm.com?part=3D1
