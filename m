Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16861C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 20:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6001010F105;
	Thu, 17 Sep 2026 20:34:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="UT1tx/UM";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E104F10F105
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 20:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789677288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mYjbBVwargHWsKu07Jhp0TKQU4hcLQthxlQyB3uB2hE=;
 b=UT1tx/UMh8lTgo+z3E+X7BdByxO6HGONT7dlqGLDdkdJq75X8nS7QTAFZ+WFzKZGM7WFsv
 V/G1LKaY64xGTksSdVZFdOJv11kozygNOCywbaghit3GpqPiruKK2vIphofZGZ1xOuzHPN
 6HGWjAK5wnWHyhoQqKI8qpPgRX3+8p4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-1hrVmQQDNOSDjheYhywRvw-1; Thu, 17 Sep 2026 16:34:46 -0400
X-MC-Unique: 1hrVmQQDNOSDjheYhywRvw-1
X-Mimecast-MFC-AGG-ID: 1hrVmQQDNOSDjheYhywRvw_1789677286
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9390a2c895bso13534585a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 13:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789677286; x=1790282086;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mYjbBVwargHWsKu07Jhp0TKQU4hcLQthxlQyB3uB2hE=;
 b=YYp5GJ/Dv6I/L4vAvwWMEDaKy6ATHpMcRT4sPiSQhvYBeC+MasRP1L42/Mh0+8cVDD
 T/3u11SRMn9DsSGW64XtzCJaoKAdWyaNEHz5IiRZ6cJfvWeOiCUDBGaZzhIIkNeviUmJ
 QD1KCbwUlP15TfGq4xNPTq+QLg61oSsCu5nWDoKj5YH8U74YxAiFRbMbqwaokWmIddxY
 Uuwbn85irgiZ7fG+RyXXAdhW+NxSkvCqWKZfdAQctnZMPAV1LsFBfBSoG29XvnUaLbPT
 W0EgOcMYLYiNIMQru+ricHmaueMP7lC++r3q2vpOOolwrrrYNJ3vx8N//Gv4TzHrccoC
 iXNg==
X-Forwarded-Encrypted: i=1;
 AKwUvByX8FBfF7tAoYbNahLQ9SbrOHDrAj2D3+nc1lF6GyaCQS/6CNJjLDEriOAr0a2cBmFeOJQeE2GfZuw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ksgEBo180w8+S8/30yA7hDpPm7Z09OeFCdzo4b+HgT0z3hFKNv
 pJyW2gDbv70n9wT/ya+gIKhIW3BiO80uWO3IIXVbc6BzLnc3wqkPSRjk1KGUfsrWQm6biztFkJg
 v+Hj6/aVW7e4a66LMAmjSvTDdCzhENA28wPqTFTfMXcvMULgjGdYgN3+1Jfk+A//p2u/7iA==
X-Gm-Gg: AYBFou2I9HzD5csiDJ0dkpg1sk/BgA9j5gCxNuX0/CwkDuPw4V2Yo6LNRRWsrl1x0g7
 tDFhHybXCo4Ob7NJ9x8vXRTnQ6DS14mRTciXJg/uF2KXXFE/DclhD452+qoA04Vq4FhRK7PryVa
 oJL+pOVFBWPX3iAXAncI7ec6UvQ7v9AT0Zch5Yv4rL0Oahhd1Vk9yMk8VNG4AFPVRxvmx/vnjSc
 CjKEn+jWPJIDGviJTwYscJYihw/g+gbHa2NAE2S8rFY66nGW6poO6kTIbkhLR4zlBz9GHW1Z5PM
 2N+pW2TKR4JRj4JWogZxnvN4l6W96df8e01NFrmc1DftvuuK623l3DTnGe3k6Lv1T6sr0Du1
X-Received: by 2002:a05:620a:254a:b0:93b:d79f:d951 with SMTP id
 af79cd13be357-93bdca433b5mr16959485a.70.1789677286162; 
 Thu, 17 Sep 2026 13:34:46 -0700 (PDT)
X-Received: by 2002:a05:620a:254a:b0:93b:d79f:d951 with SMTP id
 af79cd13be357-93bdca433b5mr16957185a.70.1789677285807; 
 Thu, 17 Sep 2026 13:34:45 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93b781deec2sm559137785a.7.2026.09.17.13.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:34:45 -0700 (PDT)
Message-ID: <fcd366286750d61f0d4e2b99ddef2a9d36e72b0f.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/bios/init: drop unneeded semicolon
From: lyude@redhat.com
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: kernel-janitors@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, 	nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 16:34:44 -0400
In-Reply-To: <20260801191002.1383835-8-Julia.Lawall@inria.fr>
References: <20260801191002.1383835-8-Julia.Lawall@inria.fr>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hcqjg5Ad-ImIS8B_QYizjNi0wwcqt80vss_g9RrLCyM_1789677286
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

Will push to drm-misc-next in a moment

On Sat, 2026-08-01 at 21:09 +0200, Julia Lawall wrote:
> When a function-like macro expands to an expression, that expression
> doesn't need a semicolon after it.=C2=A0 All uses have been verified to
> have their own semicolons.
>=20
> This was found using the following Coccinelle semantic patch:
>=20
> @r@
> identifier i : script:ocaml() { String.lowercase_ascii i =3D i };
> expression e;
> @@
>=20
> *#define i(...) e;
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>=20
> ---
> =C2=A0drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c |=C2=A0=C2=A0=C2=A0=
 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
> index b54f044c4..3f888fb97 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
> @@ -403,7 +403,7 @@ init_table_(struct nvbios_init *init, u16 offset,
> const char *name)
> =C2=A0#define init_io_condition_table(b) init_table_((b), 0x08, "io
> condition table")
> =C2=A0#define init_io_flag_condition_table(b) init_table_((b), 0x0a, "io
> flag condition table")
> =C2=A0#define init_function_table(b) init_table_((b), 0x0c, "function
> table")
> -#define init_xlat_table(b) init_table_((b), 0x10, "xlat table");
> +#define init_xlat_table(b) init_table_((b), 0x10, "xlat table")
> =C2=A0
> =C2=A0static u16
> =C2=A0init_script(struct nvkm_bios *bios, int index)

