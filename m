Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4835AC982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 18:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8147410E048;
	Thu, 17 Sep 2026 18:19:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="IvT+JaMK";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 356C010E048
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 18:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789669173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zghduFgZwDIIypwl6PQd6HNgjS/ywXtiQKQuJdsOiRw=;
 b=IvT+JaMKvsid338KVVEvqILbb4SDms+ljAVclaTtkJKpF23PwDWQtt46/ed/+/QViosdrW
 q/4tgtshT7UqiznI+8aJHom175MTNChaayBvbTLKEzTMdADwKZLGTCfc2EoP+HQhlEcxxC
 qTPjDbRBcleQ5SoXYnlbcKFYLrNNrTU=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-ZfyAneHjOia_VMYS_fPrWA-1; Thu, 17 Sep 2026 14:19:32 -0400
X-MC-Unique: ZfyAneHjOia_VMYS_fPrWA-1
X-Mimecast-MFC-AGG-ID: ZfyAneHjOia_VMYS_fPrWA_1789669171
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-982a39e0c4dso169378241.3
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 11:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789669171; x=1790273971;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6EVrUJFQJF3dnaOQZb2Gx1UGobWA2s6Fo3aIIPVgJwM=;
 b=pnQ1DUkmSNeWbtRpd9wwEiSTWK+xKnir+GKGiAzZ9pgCPNsMEYVoCAVSBWmeH5fiMN
 bSj3b019lC7QaWZhUvrADp27dQdurK4s2WTdAvunka2vIixU5fxLVX13DXslTh9v0IaU
 dUJNnamOcPpdc7dFrNtcIN+1eUigUkngQuQKKEEDpd9BYit7AHa5rvbMkk35N+xthGBU
 uO01dROcxECJSuD3+3iZzpVl0SsiY7n7dGLabZDYawcgPnTOTqSBHApMuj+d83d9c+mR
 wKWWsOEl/+WHH4IyQkmsTPsvwZnZHr5npEJ1HDLsducBdLRzZQBj/pbdpua6i4ha3vcj
 By8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkP0Su5/CUUkjLtGOKN2pxRW+aA7/SgFN00S75bprQddSn/03X1ZxCbmhA5cnzFL/EwauV5Bpf8uY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lDj16id+QD9i5/g3spG/Zy1FbAIRkZ9X9fwMzyW++Kaz43rYaV
 KjM1cUKxlXjiTJPCwptH8XTu88tF+V3sd/2a4tTuJnPI6f96xU2k8ZMHpMELQM78hJ3fNXI3lvo
 KznGgu9IXE5P4AIjxy8Pr0+Kd+KlFuPGOY0qjBCeFVYvSFblbsF71KFLwzNUOrWdIV//LVhTKNR
 MMDg==
X-Gm-Gg: AYBFou3AtmihkRovzzr0SVym15xO3mebT1hO3yOMRd4MyBtNYGJ676NfxcY+s9f9gfe
 AerwpL7CLI+EyFcRlAraSk3Skd7KQINfFopVpkgRD/kQ6H1PuJA34PucirdClBUEriwFhxUIKpX
 4VVQXhMdsDnUBT+T+r7bFI6ucXureqjBzplALlefvHQXy4rsyOEegyoy3sKVLcq0lsDGGJ2OCfr
 FwHHS3ICJg68auK55B7lCCsTYzhq7j2Ys0HcYYWpVxhy8VAelxGpL8Gpkcicq1w5EfuTdPx+05X
 Fsto+JFTitsvb0h3FKHcYx1ZpFQz82hdurCW55OqxbLgiwbOhHXNnFBD9HKtBBpXsaZcJQ6Z
X-Received: by 2002:a67:e708:0:b0:797:e5aa:61c2 with SMTP id
 ada2fe7eead31-7a024dcd2e6mr7627691137.3.1789669171502; 
 Thu, 17 Sep 2026 11:19:31 -0700 (PDT)
X-Received: by 2002:a67:e708:0:b0:797:e5aa:61c2 with SMTP id
 ada2fe7eead31-7a024dcd2e6mr7627685137.3.1789669170960; 
 Thu, 17 Sep 2026 11:19:30 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7a1e292ee59sm4120534137.6.2026.09.17.11.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 11:19:30 -0700 (PDT)
Message-ID: <d43ff56c010c83fc4cbef634e7a632940f5d20f7.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: Fix gem reference leak in validate_init()
From: lyude@redhat.com
To: Wentao Liang <vulab@iscas.ac.cn>, airlied@gmail.com
Cc: bskeggs@redhat.com, dakr@kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, nouveau@lists.freedesktop.org, simona@ffwll.ch, 
 tzimmermann@suse.de, stable@vger.kernel.org
Date: Thu, 17 Sep 2026 14:19:29 -0400
In-Reply-To: <20260916180202.2090231-1-vulab@iscas.ac.cn>
References: <20260916180202.2090231-1-vulab@iscas.ac.cn>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QBsXo3B6rlBCzOmKVk6IfDf1SCkQ3ltck84eKgF6qm4_1789669171
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

Will push to drm-misc-fixes in a bit

On Wed, 2026-09-16 at 18:02 +0000, Wentao Liang wrote:
> On the ttm_bo_reserve() failure and "vma not found" error paths, the
> loop breaks without adding the looked-up object to any validate list,
> so the reference taken by drm_gem_object_lookup() is never released;
> validate_fini() only walks the spliced lists.=C2=A0 Drop the reference
> before breaking out on both paths.
>=20
> Fixes: 19ca10d82e33bcfe ("drm/nouveau/gem: lookup VMAs for buffers
> referenced by pushbuf ioctl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_gem.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c
> b/drivers/gpu/drm/nouveau/nouveau_gem.c
> index 20dba02d6175..c2601b559947 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_gem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
> @@ -513,6 +513,7 @@ validate_init(struct nouveau_channel *chan,
> struct drm_file *file_priv,
> =C2=A0=09=09=09if (unlikely(ret)) {
> =C2=A0=09=09=09=09if (ret !=3D -ERESTARTSYS)
> =C2=A0=09=09=09=09=09NV_PRINTK(err, cli, "fail
> reserve\n");
> +=09=09=09=09drm_gem_object_put(gem);
> =C2=A0=09=09=09=09break;
> =C2=A0=09=09=09}
> =C2=A0=09=09}
> @@ -522,6 +523,7 @@ validate_init(struct nouveau_channel *chan,
> struct drm_file *file_priv,
> =C2=A0=09=09=09struct nouveau_vma *vma =3D
> nouveau_vma_find(nvbo, vmm);
> =C2=A0=09=09=09if (!vma) {
> =C2=A0=09=09=09=09NV_PRINTK(err, cli, "vma not
> found!\n");
> +=09=09=09=09drm_gem_object_put(gem);
> =C2=A0=09=09=09=09ret =3D -EINVAL;
> =C2=A0=09=09=09=09break;
> =C2=A0=09=09=09}

