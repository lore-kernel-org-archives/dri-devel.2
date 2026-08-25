Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0AFC61DBC
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:10:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99A9310E960;
	Tue, 25 Aug 2026 08:10:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I+NVZVl7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C939310E958
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:10:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 442126011F
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40DD1F000E9;
 Tue, 25 Aug 2026 08:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787645436;
 bh=JpJknGhwnUKD7Sjh7kH/pSZ16JlVkZLmgjI9goqNpnQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I+NVZVl7EdExNvA+dDFBlYOQsgLeqe7W9naOP9UIgUKneTEJZZvTVJvn6Ryl4vIJ9
 rCXl8NpF71madZiUXSk+Io3MchX4XiuOkUmaD+yc9L5b9zHsSwOa9RoIW/2PG8TrbJ
 Zb0Cs+CYovdc1IM6tI9xhtlfzRk+sTu1OXT4mp2W0Q18yecvzh0+bOIEC5RGG/X5KY
 ddHwH16TZ8zkkT0EAEIA9ifRTfHlyACoBa5bkOxpv+ZXPZbizUVf9aJKUeFbWILLgp
 c3JL7S4gFT76ACEPYKCOppqrW4RrXOP3axqAfdwQHTP5n8mV7vrwRCIk+FwTImY8jy
 ebNggV/pcmhfA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 02/12] drm/fabric: add query uAPI and generated headers
To: "Konstantin Sinyuk" <ksinyuk@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <5e89aa4e8c8cd5febf4146f2e6891272203be3a6.1787552412.git.ksinyuk@kernel.org>
References: <cover.1787552412.git.ksinyuk@kernel.org>
 <5e89aa4e8c8cd5febf4146f2e6891272203be3a6.1787552412.git.ksinyuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 08:10:35 +0000
Message-Id: <20260825081035.C40DD1F000E9@smtp.kernel.org>
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
- [Medium] The Netlink YAML specification uses fixed-width integer types (`=
u32`, `u64`) and `pad` attributes instead of the preferred variable-width t=
ypes (`uint`, `sint`).
- [Medium] The `port-peer-create-ntf` and `port-peer-delete-ntf` notificati=
ons use custom `event` subsets instead of reusing the `GET` operation shape=
 via `notify`.
--

--- Patch [2]: [RFC PATCH 02/12] drm/fabric: add query uAPI and generated h=
eaders ---
commit 180af4ca3a8c57e81df2225599a4c339598edf21
Author: Ilia Levi <ilia.levi@intel.com>

drm/fabric: add query uAPI and generated headers
   =20
This commit introduces the drm-fabric Generic Netlink family using a YNL
specification, along with generated userspace and kernel headers. It defines
the core object model attributes, operations, and multicast notifications.
The read-only ABI supports lookup, dump, and change notifications for
fabrics, endpoints, and ports.

> diff --git a/Documentation/netlink/specs/drm_fabric.yaml b/Documentation/=
netlink/specs/drm_fabric.yaml
> new file mode 100644
> index 0000000000000..778443d92a0d4
> --- /dev/null
> +++ b/Documentation/netlink/specs/drm_fabric.yaml

[ ... ]

> +  -
> +    name: fabric
> +    name-prefix: drm-fabric-a-fabric-attrs-
> +    enum-name: drm-fabric-a-fabric-attrs
> +    doc: Attributes describing a fabric object.
> +    attributes:
> +      -
> +        name: pad
> +        type: pad
> +      -
> +        name: fabric-id
> +        type: u32

[Severity: Medium]
Since this is a new Netlink family, should we prefer the variable-width uint
or sint types instead of fixed-width u32 and u64 integers?

The pad attribute is also generally restricted to legacy fixed structs.
Changing this before the uAPI is finalized might be a good idea to maintain
consistency with modern Netlink design guidelines.

[ ... ]

> +    -
> +      name: port-peer-create-ntf
> +      doc: A port's neighbor has been set.
> +      attribute-set: drm-fabric
> +      event:
> +        attributes:
> +          - endpoint-id
> +          - port-index
> +          - peer
> +          - topology-generation
> +
> +    -
> +      name: port-peer-delete-ntf
> +      doc: A port's neighbor has been unset.
> +      attribute-set: drm-fabric
> +      event:
> +        attributes:
> +          - endpoint-id
> +          - port-index
> +          - peer
> +          - topology-generation

[Severity: Medium]
Could we use notify: port-get for these notifications instead of custom eve=
nt
subsets?

Events are considered less idiomatic than notify operations, which share
contents with the GET op. Since peer information is queryable via port-get,
reusing the port-get shape here would avoid forcing userspace to implement
separate parsing logic for these notifications.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787552412.gi=
t.ksinyuk@kernel.org?part=3D2
