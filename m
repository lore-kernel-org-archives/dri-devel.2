Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE646C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A39F410E6E9;
	Thu, 17 Sep 2026 16:28:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="IkeM/sJR";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA7D410E0AE
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 16:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789662509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nI01nierIQhKdbu+9MV6yfFxFnly7TF1DFNzMzDFFYs=;
 b=IkeM/sJRlc293kVHtaftvgUGqlCxLqrsvx3W83xstSbGVzkb5wZhUb2MGK0L1ueoPKn20P
 bbYbQ85famjwYqHV6ItdJfkllOeYgF8s8ebgM//rPNxL+blskapGGpW1ljVVKMSt1VoTW4
 MFEVodsE0zBJVCFVfc7JVPoF1oC/mQA=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-tuPENa3CO7yWVe3F2NsrxA-1; Thu, 17 Sep 2026 12:28:26 -0400
X-MC-Unique: tuPENa3CO7yWVe3F2NsrxA-1
X-Mimecast-MFC-AGG-ID: tuPENa3CO7yWVe3F2NsrxA_1789662505
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-671217c949cso1205974d50.3
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 09:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789662505; x=1790267305;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T9Zesbadxeg7oTrWei3JYdZLdaxPsolNq8bf7iCfLoA=;
 b=Pedj5F3qairTNrUPQ45CUgt+N75qAlAUJ8VYYHzYcFXlWZaQuwYzgy9seuIt9g7mLj
 i6uGR0njsTlcBe90Vo/2dKX1T8XRvZ4xvoRScyHmQc8N8+tq6M1vatChlZ4iTtBsy1s/
 TyT9Ue85I7d+I151b2QlTGKaSKoTN0rs3Jzv14KgiFjYrvz/SMNerhEO6mz8tYn4QlKK
 bijIfK6SSs7B3TapYTxXQZ5g7aRw7CkXONPgRNYNN2MCQPk4budrVqyk0at6kvbx49SX
 11++KaknKr8PIvIoKexFCMDj/J8Y8OW4Y/9Vxx83vAUAhd55UKtdMBnW512bgT2fnZMl
 99pg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw7ZEA7BPbRy3JGLNOKMP/CGFFpyviELNDLgHXT0dP+XfEkotuvaNuB9q91opZHE4WzqpdVCooMmDY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n2AWXLjMPArbFpFVP/X9J9zYt8TGgM9/2yR5Qs1Jqcc1y9HmRc
 I9krvPkGMbr/h/W32fLY6P+DfJ2Qb5tZZrNsm6kmHo9VwZUvMF+lj6dA+hyrtSZZsTIoWOpaNaM
 2NnPvOh447dDRFlhtWa7QgBosAOK5RTiSegDtYpkIkFUTC3KGtzkPV02gZUNhmqb4yd2Vaw==
X-Gm-Gg: AYBFou3uZRNSm4/hviLtIfjXtqcsW/dzq3XGZDEbiipMMAlEarWHBDhMpkod91hGjg6
 flNfPTsYNg5TTyxcRVfh2BbzJl1NV1M6z9zBXXd6Hrhhe0ZmkKNnETuDO17cqkkhr9K9mCKCmTM
 BK95pm+1HgNRngtyNcbrdD4akHLSZRB0MrWd1DGg8wNapBZY/taM68VVuz56jLD1kK2kbTGCGYr
 taSGJt0VsoVY2rGjB5aGf6hBKSjz0+UIbN9qyyFg9eCpTaDZbLdHkfEa2bPdmNpvX6GM0gOWwHj
 8y1IMrakXPCmlCm9elJsoMjh+A2I2rY5SOSCjq2/hOSIIM+bMjgfllRFdjVrGq3h9vNpfv52
X-Received: by 2002:a05:690e:480c:b0:66f:c1bc:4099 with SMTP id
 956f58d0204a3-671632fcb0dmr1856050d50.92.1789662504463; 
 Thu, 17 Sep 2026 09:28:24 -0700 (PDT)
X-Received: by 2002:a05:690e:480c:b0:66f:c1bc:4099 with SMTP id
 956f58d0204a3-671632fcb0dmr1856033d50.92.1789662503824; 
 Thu, 17 Sep 2026 09:28:23 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-896ca03f345sm1229717b3.20.2026.09.17.09.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 09:28:22 -0700 (PDT)
Message-ID: <4170733fbe8a738f925986f0a17d03c39b066c17.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/disp: don't reject HDMI config on cards
 without SCDC
From: lyude@redhat.com
To: Tano Dzhinski <tano.dzhinski@gmail.com>, Danilo Krummrich <dakr@kernel.org>
Cc: Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, 	linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 12:28:21 -0400
In-Reply-To: <20260917135051.47683-1-tano.dzhinski@gmail.com>
References: <20260917135051.47683-1-tano.dzhinski@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MTzmUHvuJMHvvVggVBh31TNFNQYEKlS8waYUpExVM38_1789662505
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

Hi - apologies for missing the patch previously, and thank you for
bringing this to my attention!

Would you mind re-sending with the original authorship + a Co-authored-
by tag for yourself to make sure we give the original author credit?

On Thu, 2026-09-17 at 13:50 +0000, Tano Dzhinski wrote:
> nv50_hdmi_enable() passes the sink's SCDC capability from its EDID
> straight through to nvif_outp_hdmi(). On pre-Maxwell-2 cards there is
> no
> hdmi->scdc callback, so nvkm_uoutp_mthd_hdmi() rejects the whole
> configuration with -EINVAL, and nv50_hdmi_enable() returns before
> hdmi->ctrl() runs and before the AVI and VSI infoframes are sent.
>=20
> The result on such a card driving an SCDC-capable HDMI 2.0 sink is
> that
> HDMI audio silently stops working. Video is unaffected, and nothing
> is
> logged, which makes the failure hard to attribute.
>=20
> SCDC is optional, and the hdmi->scdc() call further down is already
> guarded against a missing callback. Requesting it on a card that
> cannot
> do it need not invalidate the rest of the HDMI configuration, so drop
> that term from the condition and let the existing guard skip SCDC
> alone.
>=20
> Giuseppe Ranieri posted a fix for this to the nouveau list on
> 2026-01-17, which received no review:
> https://ratatoskr.run/nouveau/2026/01/16963412
>=20
> Fixes: 6c6abab20b99 ("drm/nouveau/disp: add output hdmi config
> method")
> Signed-off-by: Tano Dzhinski <tano.dzhinski@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c | 3 +--
> =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> index 377d0e0cef84..9887b3898505 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> @@ -253,8 +253,7 @@ nvkm_uoutp_mthd_hdmi(struct nvkm_outp *outp, void
> *argv, u32 argc)
> =C2=A0
> =C2=A0=09if (!ior->func->hdmi ||
> =C2=A0=09=C2=A0=C2=A0=C2=A0 args->v0.max_ac_packet > 0x1f ||
> -=09=C2=A0=C2=A0=C2=A0 args->v0.rekey > 0x7f ||
> -=09=C2=A0=C2=A0=C2=A0 (args->v0.scdc && !ior->func->hdmi->scdc))
> +=09=C2=A0=C2=A0=C2=A0 args->v0.rekey > 0x7f)
> =C2=A0=09=09return -EINVAL;
> =C2=A0
> =C2=A0=09if (!args->v0.enable) {

