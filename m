Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441BBC5DF94
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:10:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 910ED10E959;
	Tue, 25 Aug 2026 08:10:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RfuoaXfd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCBD710E959
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:10:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B78FA404E6
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5CA1F000E9;
 Tue, 25 Aug 2026 08:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787645436;
 bh=LM2Skcm5xYA119hpslWGIfg+9IpTvOhhIHrK3ynfgmk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RfuoaXfdJ3vjgFx4bMiY8Dx2Nu7VAQuk3nJ2Se/+pxErmcx9h4KeM/nh/OBcrCpBG
 sGi9tq7kkPBwnNq9GKqflj3BommxnqxluIUpROypu5oFTJiuhfHL6Dch7IxNPYIXVd
 xY+0OLh2TncjwZHCaabUttEHjxV8H0lo4qExGV9U49DXLNzhrqzUblyVgAuzRg24y1
 4bLb8LFcHUkd+RGJLIecel5xu95qK+Da/BGziH3legHrHN2FzQCECbPGoKJHX+d5iR
 CxaRCxMBlc1n/u/9UafbtBU6iPue/TMSsgjUCEIKCEOfP1p7GCUn783ZHIid6CSK8Z
 zaRlzcxqJmdxg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 08/12] drm/fabric: add provisioning netlink uAPI
To: "Konstantin Sinyuk" <ksinyuk@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <2e6631d18a5a05e5a6217ce0b342fb5fedd2ca7d.1787552412.git.ksinyuk@kernel.org>
References: <cover.1787552412.git.ksinyuk@kernel.org>
 <2e6631d18a5a05e5a6217ce0b342fb5fedd2ca7d.1787552412.git.ksinyuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 08:10:36 +0000
Message-Id: <20260825081036.7B5CA1F000E9@smtp.kernel.org>
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
- [Medium] New provisioning commands (`fabric-new`, `endpoint-set`, `port-s=
et`, `port-peer-new`, `port-peer-del`) do not reply with a full message; mo=
st only ACK on success.
- [Medium] The `fabric-new-params` nested attribute introduces an unnecessa=
ry extra wrapping nest for request parameters.
--

--- Patch [8]: [RFC PATCH 08/12] drm/fabric: add provisioning netlink uAPI =
---
commit 99dd7c47ab1a93cd9f0234f8280e8cd261d71d5a
Author: Ilia Levi <ilia.levi@intel.com>
Subject: drm/fabric: add provisioning netlink uAPI

This commit extends the DRM fabric YNL specification with six privileged=20
provisioning commands for managing fabrics, endpoints, and ports.

> diff --git a/Documentation/netlink/specs/drm_fabric.yaml b/Documentation/=
netlink/specs/drm_fabric.yaml
> --- a/Documentation/netlink/specs/drm_fabric.yaml
> +++ b/Documentation/netlink/specs/drm_fabric.yaml
> @@ -108,6 +125,17 @@ attribute-sets:
>            or DUMP reply carries its snapshot's generation; a notification
>            carries the generation of its change. Statistics reads do not
>            advance it.
> +      # Provisioning request parameters
> +      -
> +        name: admin-state
> +        type: u32
> +        enum: admin-state
> +        doc: Requested administrative state.
> +      -
> +        name: fabric-new-params
> +        type: nest
> +        nested-attributes: fabric-new-params
> +        doc: Creation parameters for ``fabric-new`` (full nest).

[Severity: Medium]
Does this introduce an extra wrapping nest for the request parameters?

The generic netlink design rules for new families specify avoiding extra
wrapping nests. Wrapping the request parameters inside the fabric-new-params
nested attribute rather than placing them directly in the main drm-fabric
request attributes creates unnecessary API complexity.

[ ... ]

> @@ -421,6 +483,97 @@ operations:
>          reply shape (full fabric nest).
>        notify: fabric-get
> =20
> +    -
> +      name: endpoint-change-ntf
> +      doc: |
> +        Endpoint state change notification.
> +        Reuses the endpoint-get reply shape (full endpoint nest).
> +      notify: endpoint-get
> +
> +    -
> +      name: fabric-new
> +      doc: Create a new empty fabric
> +      attribute-set: drm-fabric
> +      flags: [admin-perm]
> +      do:
> +        pre: drm-fabric-nl-pre-doit
> +        post: drm-fabric-nl-post-doit
> +        request:
> +          attributes:
> +            - fabric-new-params
> +        reply:
> +          attributes:
> +            - fabric-id

[Severity: Medium]
Should this operation reply with a full message representing the object rat=
her
than just the fabric-id?

The generic netlink design rules require that all operations, especially
NEW/ADD, reply with a full message carrying identifying information about t=
he
new object. Replying only with the ID forces userspace to issue a separate
GET command to retrieve the full state.

[ ... ]

> +    -
> +      name: endpoint-set
> +      doc: Attach/detach an endpoint to a fabric and/or set its admin st=
ate
> +      attribute-set: drm-fabric
> +      flags: [admin-perm]
> +      do:
> +        pre: drm-fabric-nl-endpoint-pre-doit
> +        post: drm-fabric-nl-endpoint-post-doit
> +        request:
> +          attributes:
> +            - endpoint-id
> +            - dev-name
> +            - bus-name
> +            - fabric-id
> +            - admin-state

[Severity: Medium]
Does this command intentionally omit a reply block?

Without a reply block, this state-mutating operation will only ACK on succe=
ss.
Since once a command only ACKs, that behavior becomes unchangeable uAPI,
should this operation be updated to return a full message reflecting the
updated state?

[ ... ]

> +    -
> +      name: port-peer-new
> +      doc: Set a port's neighbor
> +      attribute-set: drm-fabric
> +      flags: [admin-perm]
> +      do:
> +        pre: drm-fabric-nl-port-pre-doit
> +        post: drm-fabric-nl-port-post-doit
> +        request:
> +          attributes:
> +            - endpoint-id
> +            - port-index
> +            - peer

[Severity: Medium]
Like the endpoint-set command above, should this ADD operation define a
reply payload rather than defaulting to an ACK-only response?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787552412.gi=
t.ksinyuk@kernel.org?part=3D8
