Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AC3C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 681FE10E769;
	Thu, 17 Sep 2026 21:15:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="d1GVNPoq";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6500B10E769
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 21:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789679741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uMX1xa7O2baIigkolBDenb0sPwHls/I6ce8sNPUkCdY=;
 b=d1GVNPoqAo51rSpA0S9JRXe+1QOWyzOSrHsHCiOqejxZiDrVgFViQ7ijmjf/GgAMrt9vkr
 rzY786BmWNfxDTxwiEkcjksjFzH81MMYtEpZMs1VlursOi7tyMxkr5cXGfuKLVsHvTt+O8
 gBy2MzcwOORHmTC291C2OiR6BwDS9xE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-yRgkondqPUOn4W0YVfsrIw-1; Thu, 17 Sep 2026 17:15:38 -0400
X-MC-Unique: yRgkondqPUOn4W0YVfsrIw-1
X-Mimecast-MFC-AGG-ID: yRgkondqPUOn4W0YVfsrIw_1789679738
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a0050a554so14160985a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 14:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789679738; x=1790284538;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FcHAxEYZKIcFoVqZlfPkF3Bn5KNnhL0CKGPEHukkwQU=;
 b=hWSEMTcz4+DbbwMDvGOYCCTeCkZX/0GE563JsG1UzT3u0cb5hQ3L9x0XbEzqBYm4dz
 GNFDuSI+tputWFX3zWbCu05hydgjfeKZbBKPYUxBFAo39axFTATRvApftGtBkpB3JFsP
 WNzw5JVcdAkgIsR0CXa+SXo2djqYJhTPJ9srGqB/njCnSZd6QEoVGOsx/qChxP6HQle5
 xETUKmhbdNqX7in1W5nFdb3Qm7lWEZPKK2GOy1qAS6i6MQCOo953wucUrd+maPjFcXdU
 orGPdZ4saXvBnwOWg8C0OMRWbpK8Xrd8AmoSygP3e0CKrFl0D+WuoQh+WyFye0PCYfGp
 mWCQ==
X-Gm-Message-State: AFuF++ngoWAzicHuw2GGNZvtUe0LM9bL0ckt9hyE1NB01Wrr70me2I6w
 Z1v7y0FckKM7Z1op+OLXQu2DGv+Z/r83AhzjMr8FXZLwp5cSFTddBdInAiN7NAi07ngzpqwecD2
 cva9OlG3zkkwhRPAJ5X9U3gNWRiDDckj7LxZ43DVyqla35brR8RfLrGt5p41WCQEPW2uPjw==
X-Gm-Gg: AYBFou1AUNDEt/vPc8RtGwHQCJpU2daHrnmu8sb7Oo2fxe6knJbJtyLcq1SJITZ1WNC
 YPvTeTj9e83U3ZlwJ+0pviSlD4sLLJMFbt9a2ipxU75R2eQXY0wjj32bWszF/1fMw+TfGo4r3y4
 Sfi+tpcRf3A7hzxya3kiQL7FNhn8BJOZyJEZAZO8rr9Gvyt+TJfpG7TWALRDb0ZqiK0KhnryUr+
 UXAHZnBile2S7OlzoEeX8BDSakgxWvG6jnDlA+2ppfDNpxpTfBxp1uP8wDnAk+HbSwoDKPrCob5
 QEc1gTDfixZORBTtQTEOoFfCiAcKn04khTP+GCCMSnNMtywKSD/R4DwvAMWg4ACKwXEBj2lC
X-Received: by 2002:a05:620a:6288:b0:93a:14c:3296 with SMTP id
 af79cd13be357-93bdc64eb85mr39106785a.15.1789679737748; 
 Thu, 17 Sep 2026 14:15:37 -0700 (PDT)
X-Received: by 2002:a05:620a:6288:b0:93a:14c:3296 with SMTP id
 af79cd13be357-93bdc64eb85mr39102785a.15.1789679737318; 
 Thu, 17 Sep 2026 14:15:37 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93b780ca630sm542828685a.4.2026.09.17.14.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 14:15:35 -0700 (PDT)
Message-ID: <67d769ba8addf5a1c4aa052fa5907453a0d5f529.camel@redhat.com>
Subject: Re: [PATCH v2 4/4] drm/nouveau/clk: don't clobber reclock status
 when restoring volt/fan
From: lyude@redhat.com
To: Francesco Magazzu <postadelmaga@gmail.com>, Danilo Krummrich
 <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Karol Herbst <kherbst@redhat.com>
Date: Thu, 17 Sep 2026 17:15:35 -0400
In-Reply-To: <20260712123616.1180830-5-postadelmaga@gmail.com>
References: <20260712123616.1180830-1-postadelmaga@gmail.com>
 <20260712123616.1180830-5-postadelmaga@gmail.com>
Autocrypt: addr=lyude@redhat.com; prefer-encrypt=mutual;
 keydata=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
 8doKQgPpApRcFGaE=
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qsaHoesIt0LVc10T1wsJ3oW_wbmKAgPvFBJy1L0qNuY_1789679738
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Sun, 2026-07-12 at 14:36 +0200, Francesco Magazzu wrote:
> nvkm_cstate_prog() reuses 'ret' for the voltage and fan-speed restore
> calls it makes after reprogramming the clocks.=C2=A0 Those calls almost
> always
> succeed, so the status of the reclock itself is overwritten and the
> function reports success even when clk->func->calc() or clk->func-
> >prog()
> failed.=C2=A0 The converse is also true: a successful reclock is reported
> as an
> error if the final restore call fails, even though that failure is
> only
> logged and otherwise ignored.
>=20
> The only consumer of the return value is the error message in
> nvkm_pstate_work(), so in practice a failing reclock is simply never
> reported.=C2=A0 Nothing else changes, but a function that returns success
> on
> failure is a trap for the next caller.
>=20
> Keep the calc/prog status in 'ret' and use a separate local for the
> restore calls.
>=20
> Fixes: 3eca809b3c05 ("drm/nouveau/clk: cosmetic changes")
> Signed-off-by: Francesco Magazzu <postadelmaga@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 16 +++++++++------=
-
> =C2=A01 file changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> index 4d546b07f..05336fc7d 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> @@ -199,16 +199,18 @@ nvkm_cstate_prog(struct nvkm_clk *clk, struct
> nvkm_pstate *pstate, int cstatei)
> =C2=A0=09}
> =C2=A0
> =C2=A0=09if (volt) {
> -=09=09ret =3D nvkm_volt_set_id(volt, cstate->voltage,
> -=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pstate->base.voltage, c=
lk-
> >temp, -1);
> -=09=09if (ret && ret !=3D -ENODEV)
> -=09=09=09nvkm_error(subdev, "failed to lower voltage:
> %d\n", ret);
> +=09=09int err =3D nvkm_volt_set_id(volt, cstate->voltage,
> +=09=09=09=09=09=C2=A0=C2=A0 pstate->base.voltage,
> clk->temp, -1);
> +
> +=09=09if (err && err !=3D -ENODEV)
> +=09=09=09nvkm_error(subdev, "failed to lower voltage:
> %d\n", err);
> =C2=A0=09}
> =C2=A0
> =C2=A0=09if (therm) {
> -=09=09ret =3D nvkm_therm_cstate(therm, pstate->fanspeed, -
> 1);
> -=09=09if (ret && ret !=3D -ENODEV)
> -=09=09=09nvkm_error(subdev, "failed to lower fan
> speed: %d\n", ret);
> +=09=09int err =3D nvkm_therm_cstate(therm, pstate->fanspeed,
> -1);
> +
> +=09=09if (err && err !=3D -ENODEV)
> +=09=09=09nvkm_error(subdev, "failed to lower fan
> speed: %d\n", err);
> =C2=A0=09}
> =C2=A0
> =C2=A0=09return ret;

