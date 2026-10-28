Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4423A606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 10:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2D4310FB19;
	Wed, 28 Oct 2026 10:01:20 +0000 (UTC)
Received: from aposti.net (aposti.net [185.119.170.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6C9E10FB19
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 10:01:19 +0000 (UTC)
Message-ID: <b4572f2ab818da900ee417b8356f55d3ddfdbd1a.camel@crapouillou.net>
Subject: Re: [PATCH v2 2/5] dt-bindings: display: Add the Ingenic X1600 LCD
 controller
From: Paul Cercueil <paul@crapouillou.net>
To: Krzysztof Kozlowski <krzk@kernel.org>, Olivier Louvignes
 <olivier@mgcrea.io>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard	
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Neil
 Armstrong	 <neil.armstrong@linaro.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter	 <simona@ffwll.ch>, Jessica Zhang <jesszhan0024@gmail.com>,
 Rob Herring	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley	 <conor+dt@kernel.org>, "H . Nikolaus Schaller"
 <hns@goldelico.com>, 	dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 	linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 28 Oct 2026 11:01:10 +0100
In-Reply-To: <465cb935-2648-458b-9cfc-9b7fd5dc53c5@kernel.org>
References: <20261025191640.13592-1-olivier@mgcrea.io>
 <20261025191640.13592-3-olivier@mgcrea.io>
 <20261027-hospitable-apricot-scallop-166448@quoll>
 <270ef5220fdd5ec3e0b88ba5c4ce044992fca41a.camel@crapouillou.net>
 <465cb935-2648-458b-9cfc-9b7fd5dc53c5@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Krzysztof,

Le mardi 27 octobre 2026 =C3=A0 20:50 +0100, Krzysztof Kozlowski a =C3=A9cr=
it=C2=A0:
> On 27/10/2026 20:04, Paul Cercueil wrote:
> > > > +
> > > > +=C2=A0 port:
> > > > +=C2=A0=C2=A0=C2=A0 $ref: /schemas/graph.yaml#/properties/port
> > > > +=C2=A0=C2=A0=C2=A0 description: The output, to the panel or bridge=
.
> > >=20
> > > No port for IPU?
> >=20
> > No IPU on the X1600 - the display IP is completely different there
> > (hence the new binding).
>=20
> But even if it is different, don't you need to represent the datapath?
> Your LCD controller does not need IPU?

There is no IPU.

Cheers,
-Paul
