Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC462606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABV+o+uT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6495010E8E4;
	Wed, 25 Nov 2026 02:17:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DA6D10E8E4
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:17:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4DEB244E58;
 Wed, 25 Nov 2026 02:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C801F000C4;
 Wed, 25 Nov 2026 02:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795573066;
 bh=gBAzenmpcwPme1hRfQxhK7S392gYIIlb4xI4HrOvunw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ABV+o+uTJ0IqwVmbJSbaqO3HYZMsll074zR9ISHqx96z1OxcRqErj/dP6sLlRWv3A
 u5LenYaWaUBBrDQ6RPJbnjgUqgowWK0nNMa88SP9dsWdTcFIZrmodVaa4zar0Bwo8Q
 Jpk+/AE6FsXFe7fo9foGqB48Clh7U5uPK9yjV30h0FLVUNvp4aapAlm6Ql7FF4xDTa
 +ctnSwOHdlmWh5la1TbOGv0XoM1XGQSokFWNWelBxvyRCl0frt/CNzM6bz5+xW7e4Q
 LtUYsEsMiTdQCsNpt9Tkf94h1mhLBhXrIez05cTKbU7SEZ3x0Z14fJcROcy7K/iQpV
 KCLCStRIkziIQ==
Message-ID: <sashiko-outbox-232398@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] dt-bindings: backlight: add VIEWE I2C backlight
 binding
To: Hefei <3066883572@qq.com>, dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_655009C68D3E3EAD3EBE65084B9F9A7FE509@qq.com>
References: <20261125020944.137-1-3066883572@qq.com>
 <tencent_655009C68D3E3EAD3EBE65084B9F9A7FE509@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 02:17:45 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Low] dt-bindings: backlight: undocumented vendor prefix viewe
- [Low] dt-bindings: backlight: schema filename and $id mismatch
  compatible
- [Low] dt-bindings: backlight: redundant word binding in commit subject
- [Low] dt-bindings: backlight: empty commit body and invalid
  Co-authored-by
--

commit 30cc2981090ca10d47ee3c9cabb7273eb616720b
Author: Hefei <3066883572@qq.com>

> dt-bindings: backlight: add VIEWE I2C backlight binding

[Severity: Low]
The "dt-bindings:" prefix already indicates that this patch adds a binding,
so the trailing word "binding" in the subject can be dropped.

>
> Signed-off-by: Hefei <3066883572@qq.com>
> Co-authored-by: Cursor <cursoragent@cursor.com>

[Severity: Low]
The commit message has no changelog body describing the hardware or why the
binding is being added.  In addition, "Co-authored-by:" is not a valid
kernel trailer (checkpatch reports BAD_SIGN_OFF), and per
Documentation/process/coding-assistants.rst AI tools cannot certify the DCO
and should not be credited via sign-off or co-author trailers.

> diff --git a/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-b=
acklight.yaml b/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-=
backlight.yaml
> new file mode 100644
> index 0000000000000..9be4bc93087ae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-backligh=
t.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/viewe,i2c-backlight.ya=
ml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#

[Severity: Low]
Should this file and its $id be named viewe,7kf82-backlight.yaml to match
the single compatible string it documents, as required by
Documentation/devicetree/bindings/writing-bindings.rst?

[ ... ]

> +properties:
> +  compatible:
> +    const: viewe,7kf82-backlight

[Severity: Low]
Is "viewe" documented in
Documentation/devicetree/bindings/vendor-prefixes.yaml?  Without a vendor
prefix entry, make dt_binding_check and checkpatch fail validation on this
compatible string.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_EE81D0ED29E=
97716D56BDCF1A3C5AAE35B05@qq.com?part=3D3
