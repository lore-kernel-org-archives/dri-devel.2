Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C23C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B69110E776;
	Thu, 17 Sep 2026 17:11:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZHo0zrHh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E640310E776
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 17:11:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 69A2860207;
 Thu, 17 Sep 2026 17:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C9C1F00893;
 Thu, 17 Sep 2026 17:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789665097;
 bh=dZO41uufujK+iupIyYnVeMZxw5jne5ZnddSeSFryDeY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZHo0zrHhbq6I0XnQnTB9YFT2Zu8GRlhffdPU8RFe43fLJTCqzjRF1vISlmNWHC5X8
 +b4ww4ZMJp5IV8/3a+aO2Fn1mdDEu94iEx3AfNg5+DVrjjJ7ml9jsVscAzmy/LmaSE
 8VWp3iV1dgcxrctTPVMFOKz3obAID5hzAI5f46cAVKpDcLS1diKvfpIUcYKKPtBGD1
 cpV3tOA1+AntJrQHIdUQAD89Y6FjRSMxa4cqSaGK6GaeqSWfjb63i+tbYsGB6KXNAT
 luZFXBrb6Qz70zg/8ijwFs5ris2xqsl1ScWRLb/6t86uyqUbnGYTUlIm9JQQkJOCUu
 X5Y5vmw+cvMog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/5] drm/nouveau/gsp/r535: Add support for
 MEMSYS_GET_STATIC_CONFIG
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260917170042.440276-3-lyude@redhat.com>
References: <20260917170042.440276-1-lyude@redhat.com>
 <20260917170042.440276-3-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 17:11:36 +0000
Message-Id: <20260917171137.00C9C1F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] nouveau: missing r535_gsp_get_static_memsys_info() call in r535 =
init
--

commit ea59a1e02ca1ca9ba089fd374c676d4e85191d91
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/gsp/r535: Add support for MEMSYS_GET_STATIC_CONFIG

This commit introduces support for MEMSYS_GET_STATIC_CONFIG to fetch memory
management characteristics from the GSP during driver load. It implements t=
he
fetching logic and wires it up for the r570 initialization path.

[ ... ]

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> index dfda6b0b910a2..dff2081ed764f 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> @@ -138,6 +138,14 @@ r570_gsp_get_static_info(struct nvkm_gsp *gsp)
>  		}
>  	}
> =20
> +	ret =3D r535_gsp_get_static_memsys_info(gsp);
> +	if (ret) {
> +		nvkm_error(&gsp->subdev, "Retrieving static memsys info failed\n");
> +		return ret;
> +	}
> +	nvkm_debug(&gsp->subdev, "memsys: Use raw mode for comptag allocations?=
 %s\n",
> +		   str_yes_no(gsp->memsys.use_raw_mode_comptagline_alloc));
> +
>  	return 0;
>  }

[Severity: Medium]
Since the commit title explicitly claims to add support for r535, does
r535_gsp_get_static_info() in=20
drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c=20
also need to call r535_gsp_get_static_memsys_info()?

Right now, it appears the initialization is only performed in the r570 path.
When loading the nouveau driver on a GPU that uses the r535 GSP firmware,
this leaves gsp->memsys.use_raw_mode_comptagline_alloc uninitialized (false=
).

Could this create a mismatch and leave internal state incorrectly initializ=
ed=20
for r535 hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917170042.4402=
76-1-lyude@redhat.com?part=3D2
