Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65700C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:16:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCA5910E77E;
	Thu, 17 Sep 2026 17:16:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="S+B9PP5m";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D31EC10E77D
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 17:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789665414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3MvyyPGMzfOwx0JelbURKpCi5LDNjiPyXlUunrRmX44=;
 b=S+B9PP5meriAe24+YeiQIcR0uAipbkzPLNyeWHa+Pi2gqe3gHUlYSv0f/LaX3gtfqCuOJA
 LBM255Yg6BiCvkHFYWtQEljBJdzpuLk7BOPA+5ppukpwQt+k9MC1svZ9MOCvBplx8ah1pS
 yYNbj56WnS6ppezLfBdc4ALbzrAT5y0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551--E-zUAIrMuWU7K_buohQBw-1; Thu, 17 Sep 2026 13:16:51 -0400
X-MC-Unique: -E-zUAIrMuWU7K_buohQBw-1
X-Mimecast-MFC-AGG-ID: -E-zUAIrMuWU7K_buohQBw_1789665411
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-90e7de22fddso21138406d6.3
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 10:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789665410; x=1790270210;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uC98k1DYNd0VN7AyfHY1vWTx0QXpdNax6z4iHwpWNLQ=;
 b=Cb+v7GRMe1QbSaOdxdOPO9RhPnovHLyOoMnq2UOcFCgmKoaucuQsgDYtzBHdiolXnE
 VPUfY3pxDGqXgZTFotTWUhnxzVAFrLB5++mmbPsjrJU7CvYIEt3LL/RaC4zTxHC/2hev
 wXlEIu64AqWxeG58afWWWfkvtj/lQ0dfveY7NfPMonUyyrhtGNmycqT4Q/wqaNcngEBS
 RUFgXWqzhHiNjfxX/Nbwcn5t/UFaa09BoEX0ixCcVVQjrsJoeVvTCydxVrYEwsMKjVUQ
 udUzzh01RB/iDpNtB8VsCryFN4WaVNcZlu5Yw8EuFjU7lekuJBU+rdHuEN3/mElXXVXn
 9KBA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw7uFvdI3N60MtwxO8HRf/bqbTXRcMgN8/x5snr0Sr75RpnpQUe66bdWdUBL8sarBUwgseNAFCeIFM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++llnnw0q9Fa6zc7CrER6v2LR4GuXwwsVERpn6TIXYKLN0wnTUgv
 XIrQ2tMOc1aTsWRd2VFtmLTlxa7Ip3STiROtGoIag1RF/WqGTgy9lmWvz4YlrTbRvL7HvWvTi/P
 NZq3RdP2uOx5m4fatD66LcguF6SBk2sLu/ya69lczqynxPkZx1OBBgZerNw9dSkXSuU5RWsOZxB
 doNg==
X-Gm-Gg: AYBFou2uPjrMpbGFTxk4E36C6kJ5MsheNx+aiTyZgiApciV671oSbtUJkCRZvtrarAT
 QeocnPWeVvnukeoZRlmR8lkHPSUY3WWBzREWBUnwFWwXW7Ispzv2M3JatWGIWNnuQGz22L9Xcah
 iRfW+k2W6QpixNBiBmhaTdSxYZzTXVxdWTYETXvfMu7oBBR9q+JgaGc1i4rXn31QnYmLJi6er3F
 4Ngt2IYUAta0hGwqQ8mJct+tmTwW2bOrxUI4/DElG3HBSupjBF61du2MyK8VYYJty9WmYzc9yoy
 WBAMjJoXMtHDPxHp+qz2U147uEgzGnOgncekKuQJiSWN53Dd6U5kP/CNPuTuxEgZcS1ZO8pM
X-Received: by 2002:a05:6214:2a45:b0:8ef:4ed2:316 with SMTP id
 6a1803df08f44-9123d70ceabmr135427056d6.1.1789665410466; 
 Thu, 17 Sep 2026 10:16:50 -0700 (PDT)
X-Received: by 2002:a05:6214:2a45:b0:8ef:4ed2:316 with SMTP id
 6a1803df08f44-9123d70ceabmr135426346d6.1.1789665409997; 
 Thu, 17 Sep 2026 10:16:49 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91252d2b826sm2374926d6.47.2026.09.17.10.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 10:16:48 -0700 (PDT)
Message-ID: <6a934ca2b3caeb20f1b3d2e9d71e987d5d78af15.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: Fix bridge reference leak in nv1a_ram_new()
From: lyude@redhat.com
To: Wentao Liang <vulab@iscas.ac.cn>, airlied@gmail.com
Cc: dakr@kernel.org, dri-devel@lists.freedesktop.org, helgaas@kernel.org, 
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, nouveau@lists.freedesktop.org, okaya@codeaurora.org, 
 simona@ffwll.ch, tzimmermann@suse.de, stable@vger.kernel.org
Date: Thu, 17 Sep 2026 13:16:47 -0400
In-Reply-To: <20260916180036.2090118-1-vulab@iscas.ac.cn>
References: <20260916180036.2090118-1-vulab@iscas.ac.cn>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FlRaca23P7q_UeQwltMqJBOfbmYTsYMvXoLxN2nfqCM_1789665411
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

Will push to drm-misc-fixes in just a moment

On Wed, 2026-09-16 at 18:00 +0000, Wentao Liang wrote:
> pci_get_domain_bus_and_slot() takes a reference to the PCI device,
> which is never released once the memory size has been read from its
> config space.=C2=A0 Drop the reference before returning.
>=20
> Fixes: 2fa6d6cdaf283c05 ("drm/nouveau: deprecate
> pci_get_bus_and_slot()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c
> index 18241c6ba5fa..4d52a158f320 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c
> @@ -51,6 +51,8 @@ nv1a_ram_new(struct nvkm_fb *fb, struct nvkm_ram
> **pram)
> =C2=A0=09=09mib =3D ((mem >> 4) & 127) + 1;
> =C2=A0=09}
> =C2=A0
> +=09pci_dev_put(bridge);
> +
> =C2=A0=09return nvkm_ram_new_(&nv04_ram_func, fb,
> NVKM_RAM_TYPE_STOLEN,
> =C2=A0=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 mib * 1024 * 1024, pram);
> =C2=A0}

