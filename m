Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4B7606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ydCckOg/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6966F10E1F4;
	Mon, 16 Nov 2026 09:58:29 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F8E710EE19
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 09:58:23 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4bb69f5b161so6348165e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 01:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794823102; x=1795427902; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1IKEWtPTLjM1XYaZ0STp/scHGqJtVbGIZgdMjNsrQOo=;
 b=ydCckOg/MqtmZV9atyiuy+Fa0i9V45H1uFHl5jvn65SBc34v1SYjXGliqmseM3yf9d
 tE0GHQEUbP1ZMoDqZ5RXnAjUj1hMhJfvJ6ocTQvyWaC8E1RSDgcgissf+rzwIOrwUbvs
 9yO0sfXL7timxdGLB+LnRi2yTKH005Qy/80gMZC9zNu00UqgsDXQj/4GEyP1PCc86RAH
 LnlUzVdSHi634DkV/mkoe40/3Jl3n+4RpDzdCgLF33ewiFbuT79bU3z03wWSoOEneuBV
 kYYyo9BJ5lM2jaF1ejojBj1nFf7LyRamSohVEFgoKwGCsEKR16+bXlm9/FOWYPJz/DIY
 HMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794823102; x=1795427902;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1IKEWtPTLjM1XYaZ0STp/scHGqJtVbGIZgdMjNsrQOo=;
 b=MUtMcqo8XCE5c7WbnatqGOASi9Ip0QogFRdJmu0CMAwddOmhh4TpyV4eSAAp6gNDw/
 ZAod/gskkHwvP5Y21xMJZUzqTnBiJuu/6vyAVzxEbFZ8XK/YJzJpj/+W8ee7zVTRHwad
 NFEcVCkxQCYQG0ZwKdwiv3hTQt/jRpcUatcjSqPB3Yfv2jVEz923bRWZ1fii+TbutUwZ
 uQMyXQu+EgsMsDj2UK7CWjNLojDRUq8O1fmVZHGNm9FQbMbVCX4fwpOL/kie/CTrV5IO
 3DobluyTz81v1/OTKcYlmGyBMbbF/M3NoUGNj3np6n7R1OHJ7CjjcCmLMqPdiw/I7DPB
 hjeA==
X-Forwarded-Encrypted: i=1;
 AL+hErHMinrkDlnd+BmTztpIeLg5+Gb0Oqsf7jdN9zVw8aH6VwMFDVOqpYcjzOiFdJZwCHIVk9skDWE4E+M=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/6YN2RsIemkKifRlBDb+Vnp0PVeiYUnGH+nDh4pnOZvPKt8aZ8
 cE2zACzH/LC+INfesyJH5eyRl6gbaXJY6hXO1V9fngA4S+3z0eSlzWr+
X-Gm-Gg: AYBFou2TOZ/X4XtzA+s7sjFs/qqF4XVzhIllq8fRCn4BJVpFv/5N56nhGDk/EX2tQ9g
 mwxfKfoerTRe+HqUuK4PDeMa73JpJk+KsXCrHApaICsuNxq9iiqnsqBEsSSkNC8TxZ+qH5fQWVV
 0EUfQk8zD3nWsL7yNZ0CUS3BACdW348fqaX1XVACNSFEoAFlTIGr+mg1lNxapzv3z5IhKm0HYwH
 ffVTgIFBDi8lrdvGIGV7Q6hnegKLnfjQCsc9zM+7JGQGwiOXj2jQnff1Uz/GwF/xI/ay5MiuS3D
 LBAVI2yC/LelUWFfGHYaBS2DzK+XmKU+QrdHO2UjOmC/52LKZ5HdZ7RdvRiT0HJyCIcYG3vzDam
 m+KxTr6r0qZrhFcqrzu3C82ucLaa7OIPYTV74Im9hBK60PcQyDva6QF36UKLHHNqV1kw6J3JwV0
 JWCBfoiPsaxwnWEZppbxgb1VU1xUScG1WhfKcdUDAsL2hJt0CSJzwtXP7ICEDIJJVIn1R9KH50e
 NE4DCoeOGmYJuV4Kd6wF+9XVqrAdte4jpfvBOoXslXOUWtSW3DbuszhJHwIQTNQTYlzdZHRWB9P
 3rrO8CxN7IlZ1gL9FKfQO1BdFy7AwF5KioclLJpt/S1imPozcsvHibNu/CyB6c3TXl1CmFmR
X-Received: by 2002:a05:600c:8483:b0:4bb:605d:8e92 with SMTP id
 5b1f17b1804b1-4bb605d90f1mr145813425e9.32.1794823101861; 
 Mon, 16 Nov 2026 01:58:21 -0800 (PST)
Received: from ?IPv6:2001:8a0:c4c6:f00:1399:6f7e:7235:850f?
 ([2001:8a0:c4c6:f00:1399:6f7e:7235:850f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb56719391sm112615705e9.1.2026.11.16.01.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 01:58:19 -0800 (PST)
Message-ID: <4c5562a2d384fc530be2773a49b7380f3b009e61.camel@gmail.com>
Subject: Re: [PATCH v1 0/2] dt-bindings: display: panel: Add LG LP156WF1
 dual-LVDS panel
From: Vitor Soares <ivitro@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang	
 <jesszhan0024@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nishanth Menon	
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo	
 <kristo@kernel.org>, Francesco Dolcini <francesco@dolcini.it>, Lad
 Prabhakar	 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Thierry Reding	
 <thierry.reding@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
 dri-devel@lists.freedesktop.org, 	devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org
Date: Mon, 16 Nov 2026 09:58:17 +0000
In-Reply-To: <20260529110518.624454-4-ivitro@gmail.com>
References: <20260529110518.624454-4-ivitro@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

On Fri, 2026-05-29 at 12:05 +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
>=20
> Add support for the LG LP156WF1 15.6" Full-HD dual-link LVDS panel and
> a Verdin AM62 overlay for using it through the Verdin Development Board
> with the Verdin AM62 Mezzanine LVDS interface.
>=20
> This is a follow-up to an earlier attempt [1], where panel-lvds.yaml
> was incorrectly extended to describe dual-link panels. Back in 2023,
> when a generic dual-channel LVDS binding was proposed, Rob Herring [2]
> pointed out that dual-link panels should follow the existing
> advantech,idk-2121wr pattern instead of introducing a new generic
> compatible.
>=20
> Following that approach, this series adds a dedicated binding for
> lg,lp156wf1, with the dual-link LVDS ports described by
> lvds-dual-ports.yaml, and excludes it from the generic panel-lvds
> schema selection.
> The second patch adds the Verdin AM62 overlay for the LG LP156WF1 panel
> on the Mezzanine LVDS connector.
>=20
> This series should be applied on top of [3] to avoid conflicts in the TI
> device-tree Makefile with the other overlay additions.
>=20
> [1] https://lore.kernel.org/all/20260521150038.103538-17-ivitro@gmail.com=
/
> [2] https://lore.kernel.org/all/20230130170441.GA2796575-robh@kernel.org/
> [3] https://lore.kernel.org/all/20260522161105.277519-13-ivitro@gmail.com=
/
>=20
> Vitor Soares (2):
>   dt-bindings: display: panel: Add LG LP156WF1
>   arm64: dts: ti: k3-am62-verdin: Add Mezzanine with LG LP156WF1 LVDS
>     panel
>=20
>  .../bindings/display/panel/lg,lp156wf1.yaml   | 105 ++++++++++++++
>  .../bindings/display/panel/panel-lvds.yaml    |   1 +
>  arch/arm64/boot/dts/ti/Makefile               |   5 +
>  ...verdin-dev-mezzanine-lvds-lg-lp156wf1.dtso | 131 ++++++++++++++++++
>  4 files changed, 242 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/lg,lp=
156wf1.yaml
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-=
lvds-lg-lp156wf1.dtso

Gentle ping on this series. The binding has a Reviewed-by from Conor,
and as far as I can see nothing is pending on my side.

Let me know if a rebase or a resend would help.

Thanks,
Vitor
