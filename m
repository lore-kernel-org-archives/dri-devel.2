Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EE6C5DF66
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6989D10F25E;
	Thu, 13 Aug 2026 09:42:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="lUmGZq+s";
	dkim-atps=neutral
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 065DE10F122
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 20:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1786565451; x=1786824651;
 bh=zAb+/UlTEKpjblLRtzLovZ71X6BemvJ/aPgIQNATy+E=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=lUmGZq+soiASuXFrIJu7o/hPdEVMGPnDX4MvLJhHHh0EQkf4q5p4aLPRETkrCJB9G
 ULgVXqaBy+KX//cgIbqdbzKF4Esn7A/RZuhzsrUzx9hfDG+CAWS8qeEEYEUEbEwQ0P
 1tNSgSWgp0FmIBpl7IlnjDlY/7guuuys3sjn3i/RgD2u3yagn+ExGIWajviCnrQA6u
 Lb8AGY+vg7m4VAWHPE1QdtEd8etZssQwHICE936bW6XSgt2Yqxh52yAJ2XZ65H2bjk
 4mbufYQXSxCX4Lh61vhINZueEfSZQvaaw1AYlsyQnodrIxWasRVQqDcF0ZTVlBcAdJ
 yTZijBDZ9dKgA==
Date: Wed, 12 Aug 2026 20:10:48 +0000
To: Neil Armstrong <neil.armstrong@linaro.org>,
 David Heidelberg <david@ixit.cz>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
From: Esteban Urrutia <esteuwu@proton.me>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add bindings for Novatek
 NT37703
Message-ID: <318b749e-26db-4d74-b910-a368a9e51013@proton.me>
In-Reply-To: <05d2ad33-a681-41e4-87f7-e3aaeb5428a8@linaro.org>
References: <20260811-nt37703-bup-v1-0-34ad42b064a3@proton.me>
 <20260811-nt37703-bup-v1-1-34ad42b064a3@proton.me>
 <8c3e9384-7964-4d03-a3a9-de15d26de822@ixit.cz>
 <58d7ddd4-1488-4c34-be85-6345138aa238@proton.me>
 <7097b617-90be-492d-9637-4a2a101379e0@ixit.cz>
 <05d2ad33-a681-41e4-87f7-e3aaeb5428a8@linaro.org>
Feedback-ID: 147889766:user:proton
X-Pm-Message-ID: 8c128edce5c560b4767a5a3dae3ebf4c21f13b51
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 8/12/26 7:52 AM, Neil Armstrong wrote:
> On 8/12/26 10:46, David Heidelberg wrote:
>> bit I missed in the review the part:
>>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 comp=
atible =3D "motorola,bronco-tianma-v2-nt37703", "novatek,nt37703";
>>
>> Unless the driver is able to auto-detect the connected panel (unlikely),=
 novatek,nt37703 doesn't make sense. The DDIC without the panel is useless.
>>
>> For example, in sdm845-oneplus-fajita and enchilada, we have the generic=
 compatible because it was introduced before, so it's kept for compatibilit=
y reasons. There is no need to do that here.
>=20
> Yeah today the norm is to add the ddic as second compatible entry so the =
first compatible just describes the pane, so here it should be:
>=20
> compatible =3D "motorola,bronco-tianma-v2", "novatek,nt37703";
In that case first compatible string should be
"tianma,motorola-bronco-v2" since Tianma is the panel maker and this
"v2" panel is only used in motorola-bronco.

Regards,
Esteban

