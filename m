Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADF0C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:23:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F93710E3B9;
	Tue, 21 Jul 2026 18:23:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="VZI2P2mk";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 617BC10E3B9
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784658217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EDSz62jCk0OzsKXSSKAgLcWpgh9OgrJcskErIfIIIWw=;
 b=VZI2P2mkCtId4OR4h2uMF/wHuE+VXiLND8dHBNUQKHhZzmfXvpHdAW1dB9celd+IBZ8uNt
 j2OMBhog3L4fpF+uyplB3MhsQqCrdjvpnJhUuosYpHA9Is/sEsdwbvg/hVjgo85yCPnJtk
 wG5rlT3ip4lLt5TF460QVcr6yedj/38=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-CAXG4_0BN9-d1AcprSNFVQ-1; Tue, 21 Jul 2026 14:23:36 -0400
X-MC-Unique: CAXG4_0BN9-d1AcprSNFVQ-1
X-Mimecast-MFC-AGG-ID: CAXG4_0BN9-d1AcprSNFVQ_1784658216
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92ec91dc265so811470385a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784658216; x=1785263016;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Nf89HWE5FEb29AybdiEPsxsfpgf+Ik6TKAe6jF03lFU=;
 b=cLDrUKTk8zrVL/SDf/M5VqcqPou2dZO2a/zvrAYsQwtJT6/BmTAQ975aDEjU7iJ6oY
 kDa6pLpLI4e1k3YeT2hjSdm3o2AezeD7R7OKLCpJcSkfI/EJPquxRE1+P/22mrlpDeK3
 cewbet+ndpAArB3TnreWr5z3ox7sPddg7jVnJ41lNhTqceYC+oL/Io15gZ7FFlhs4ofG
 cb49F0yYZTTUIoMqpGpEFIrg+0MEuMhPsGXtG5HoOpBF6mIXz2gASTg8p/EZKSI/EhKD
 dp6pUi+ZOV3ZWKlqAUvUoHplvaIv3PzlxHLZs7O8cqKlV5TZ/MsNxnOmjuVLG+fUFoU0
 foVg==
X-Gm-Message-State: AOJu0YwlpufNuR4qQUr1cTYkYlJ5hpF3tFHAN+s2FkXuO74STYUt5ziA
 XxhGC2DwX1pXFoIVBHQDo0yw6dfdfhMsqMSKD2qPHlIIzkZYHKSDahadzAsKElsKZy8aJG+edv1
 wdm7EcluN5Psh67vG+nF4mLJTjMTRXR0EG7lK6ibA9verMbfeWU1tghs1U9y0LUxEKLhtMw==
X-Gm-Gg: AR+sD13eWL+khYRj0usaHz30OaVzPJylcuY3B6325ShxBz68FzK9kY6SXarSftdhAXq
 +Ltz4mevX/1aSjGN7fzFC6SCwqRlCNM/MWcudBnr47a5sW+LBpNEdQitIEU7qc0JgzBe0JLnEOM
 u2XkG+LNoUbhmXzjeBChnz8FInXBcGyWhwyOnuIiiL55aj4/Sfk2Ul1Qu2zEtlAtN7buYzC9GMM
 UgFYdycPFO/GuUv6Zo1M1I+NHZ6eom1VuspUmWjcXAjvY1I4Cumhj7ze5ft9AWvd/Jpdudx/XgP
 dGmRrotOGZ7FWkyvjEV9jSE1WHBUNfe2l5YImnUu0wROXfFbtNrY6rVUTHRJoQLqCMqsLPeA
X-Received: by 2002:a05:6214:61cc:20b0:907:b32f:9b79 with SMTP id
 6a1803df08f44-907b32f9c56mr27881696d6.6.1784658215299; 
 Tue, 21 Jul 2026 11:23:35 -0700 (PDT)
X-Received: by 2002:a05:6214:61cc:20b0:907:b32f:9b79 with SMTP id
 6a1803df08f44-907b32f9c56mr27881156d6.6.1784658214438; 
 Tue, 21 Jul 2026 11:23:34 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907ba8df5d0sm2230206d6.18.2026.07.21.11.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:23:33 -0700 (PDT)
Message-ID: <174e6951bd8216b76c2bc5fb42f1be8138b345ac.camel@redhat.com>
Subject: Re: [PATCH 2/6] drm/nouveau/gsp: add RUSD telemetry support
From: lyude@redhat.com
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Mary
 Guillemard <mary@mary.zone>, Milos Tijanic	 <mtijanic@nvidia.com>,
 nouveau@lists.freedesktop.org
Date: Tue, 21 Jul 2026 14:23:33 -0400
In-Reply-To: <20260714211429.238355-3-mohamedahmedegypt2001@gmail.com>
References: <20260714211429.238355-1-mohamedahmedegypt2001@gmail.com>
 <20260714211429.238355-3-mohamedahmedegypt2001@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DnrdyOWKmlB2Xr2VcXji-xOpc5DlNHHXsp8L_xZUhgI_1784658216
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

Some lil nitpicks

On Wed, 2026-07-15 at 01:14 +0400, Mohamed Ahmed wrote:
> +=09case NVKM_GSP_RUSD_ROWREMAP_HIST_MAX ... NVKM_GSP_RUSD_ROWREMAP_FAILU=
RE: {
> +=09=09RUSD_MEM_ROW_REMAP remap;
> +
> +=09=09ret =3D r570_rusd_read_section(gsp,
> +=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 offsetof(NV00DE_SHARED_DATA, mem=
RowRemap),
> +=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(remap), &remap);
> +=09=09if (ret)
> +=09=09=09return ret;
> +
> +=09=09switch (item) {
> +=09=09case NVKM_GSP_RUSD_ROWREMAP_HIST_MAX:
> +=09=09=09*val =3D remap.info.histogramMax;
> +=09=09=09break;
> +=09=09case NVKM_GSP_RUSD_ROWREMAP_HIST_HIGH:
> +=09=09=09*val =3D remap.info.histogramHigh;
> +=09=09=09break;
> +=09=09case NVKM_GSP_RUSD_ROWREMAP_HIST_PARTIAL:
> +=09=09=09*val =3D remap.info.histogramPartial;
> +=09=09=09break;
> +=09=09case NVKM_GSP_RUSD_ROWREMAP_HIST_LOW:
> +=09=09=09*val =3D remap.info.histogramLow;
> +=09=09=09break;
> +=09=09case NVKM_GSP_RUSD_ROWREMAP_HIST_NONE:
> +=09=09=09*val =3D remap.info.histogramNone;
> +=09=09=09break;
> +=09=09case NVKM_GSP_RUSD_ROWREMAP_CORRECTABLE:
> +=09=09=09*val =3D remap.info.correctableRows;
> +=09=09=09break;
> +=09=09case NVKM_GSP_RUSD_ROWREMAP_UNCORRECTABLE:
> +=09=09=09*val =3D remap.info.uncorrectableRows;
> +=09=09=09break;
> +=09=09case NVKM_GSP_RUSD_ROWREMAP_PENDING:
> +=09=09=09*val =3D remap.info.isPending;
> +=09=09=09break;
> +=09=09default: /* NVKM_GSP_RUSD_ROWREMAP_FAILURE */
> +=09=09=09*val =3D remap.info.hasFailureOccurred;
> +=09=09=09break;

Maybe this should be an explicit case instead of default, so we can
drm_WARN_ON_ONCE unknown values?

> +=09=09}
> +=09=09return 0;
> +=09}
> +=09case NVKM_GSP_RUSD_PCIE_GEN ... NVKM_GSP_RUSD_PCIE_UNSUPPORTED_REQUES=
TS: {
> +=09=09RUSD_PCIE_DATA pcie;
> +
> +=09=09int idx =3D item - NVKM_GSP_RUSD_PCIE_GEN;
> +
> +=09=09ret =3D r570_rusd_read_section(gsp,
> +=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 offsetof(NV00DE_SHARED_DATA, pci=
BusData),
> +=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(pcie), &pcie);
> +=09=09if (ret)
> +=09=09=09return ret;
> +
> +=09=09*val =3D pcie.info.data[idx];
> +=09=09return 0;
> +=09}
> +=09default:
> +=09=09return -EINVAL;
> +=09}
> +
> +=09/* A reading of 0 mW is indistinguishable from "not supported on this
> +=09 * board" (e.g. module power on Ampere/Hopper).
> +=09 */
> +=09if (!mw)
> +=09=09return -ENODATA;
> +
> +=09*val =3D (s64)mw * 1000;
> +=09return 0;
> +}
> +
> +const struct nvkm_rm_api_rusd
> +r570_rusd =3D {
> +=09.init =3D r570_rusd_init,
> +=09.resume =3D r570_rusd_resume,
> +=09.read =3D r570_rusd_read,
> +};
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h b/drivers/gp=
u/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
> index a9af94adf9ef..1338b4a88f95 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
> @@ -130,6 +130,12 @@ struct nvkm_rm_api {
> =C2=A0=09=09=09void (*fini)(struct r535_gr *);
> =C2=A0=09=09} scrubber;
> =C2=A0=09} *gr;
> +
> +=09const struct nvkm_rm_api_rusd {
> +=09=09int (*init)(struct nvkm_gsp *);
> +=09=09void (*resume)(struct nvkm_gsp *);
> +=09=09int (*read)(struct nvkm_gsp *, enum nvkm_gsp_rusd_item, s64 *);
> +=09} *rusd;
> =C2=A0};
> =C2=A0
> =C2=A0extern const struct nvkm_rm_impl r535_rm_tu102;
> @@ -188,4 +194,5 @@ extern const struct nvkm_rm_api_gr r570_gr;
> =C2=A0int r570_gr_gpc_mask(struct nvkm_gsp *, u32 *mask);
> =C2=A0int r570_gr_tpc_mask(struct nvkm_gsp *, int gpc, u32 *mask);
> =C2=A0extern const struct nvkm_rm_api_engine r570_ofa;
> +extern const struct nvkm_rm_api_rusd r570_rusd;
> =C2=A0#endif

