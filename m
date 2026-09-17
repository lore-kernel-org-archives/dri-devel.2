Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FFFC982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 18:23:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF04010F04D;
	Thu, 17 Sep 2026 18:23:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="P1oVLhe6";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C89D10F04D
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 18:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789669410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nN+X7/soQGz+UP9W+KThO9HODN8BfebifEMis1Y5K7U=;
 b=P1oVLhe6UE/Db5QSeLw5Zj7N4+jOAvg6OlFQb/M4DyOkmAtdZZXzk53R3CgEdIqHSW3sI1
 RMGkDk96CkZ7Sl51NvcHauNL59PFRu/vjJiYXzkfl2LRYskd25hA3b2JwYBZ5u90qMYt4l
 GqQWyLEAw8NEmIskHygkdMRH+VwuXD4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-H5h4kfmHOCKZ28KDrfUTww-1; Thu, 17 Sep 2026 14:23:29 -0400
X-MC-Unique: H5h4kfmHOCKZ28KDrfUTww-1
X-Mimecast-MFC-AGG-ID: H5h4kfmHOCKZ28KDrfUTww_1789669409
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91245cf2b35so18375356d6.2
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 11:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789669409; x=1790274209;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WDPWA2x/XShhRvPN2CAJ/FdnJPiyLxgST24Qp2ARue0=;
 b=d506KwkPbyutoHqaviqK5LteZj7Qg9BAJpxVyqZ+ga0aWrPrTkrlG7EHwE3NT2OQaz
 QELEXKeoHFjANF8Bx+7tfs4Si+he6nW/fuYUYhc6tA0SN9+zebU8YmEztKANTjnRaNF6
 UbEbyF9h1YzhDnkhPxUFN5ng9gxCUJRwfW88U6OdYf22AJRH3RvskDzmOK0Ch3xkkhEU
 5Ov12/SpEknfmi37gxK766C5FaF+xR5U0INZhYasbuzlP2F2kQvH4/mofliM7SEF4c2e
 y8FAkGpjedP80YNvJP4TZsOWPNP+PvPWwuiyCyFN1akL3xFeLKTPU1bsELXd4215ZKXh
 ae9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByuM/w6/9vU4I8fh1U+OieG40EbaDRWhbfIWvFw7Zxr/N+S8+q6PZUwnyB3uWOqJChFjPRwpoE70fw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n6Ai48ciFrA5o7/QW0q8LkHaOPOSj39KJ98hlTdJnPNzAuTKAh
 1/5hbuevl95kg4amDcgMbcE/IY+rCvIfwfvLg5HNUs8RQH+8qLT8/A6GLF0ngLah/AWKKM9t61c
 YGnam1lvjiCKYHYIrSRB6GhqP7vJwepuQ8C62e4qqvP2zrqzQ4m7o7X2PM4LxTDjVy5bHLQ==
X-Gm-Gg: AYBFou0YJmwtccd8tJyspEE4NqL5bzQZkELQvJsT/wVyUuhxEcMnEaEBIAl1yDhmNrr
 G41xBb3hvBvvngePHRnNPG954Fz7J4I7Tfm0SrzVdM71BH1lIyxgApIhOYRxkCJ//o1LpsCZl43
 Uey6lID7O93yCyPFyMSlLkZ6/FCMv9W0x5ohNsKsL6FoLH8jvsFIKLDAhxnZnA6cUTAO9AsTQCJ
 p82mUnEWLTFOoDkgSvf6iNYTvGxajQP+eBOFc2ijaNYmAjANLktO1TKIvyVfrG9s20RvG+lGo4P
 C1LxZXU9nJn8fUZVI3G6nMhAepY1g1Ki7L0cNAcAxV4F7e9HZC4PYbJfS8g+YFcFhDeX3q+j
X-Received: by 2002:a05:6214:80d6:10b0:90e:98c9:548 with SMTP id
 6a1803df08f44-91254ba3a7dmr883586d6.1.1789669408627; 
 Thu, 17 Sep 2026 11:23:28 -0700 (PDT)
X-Received: by 2002:a05:6214:80d6:10b0:90e:98c9:548 with SMTP id
 6a1803df08f44-91254ba3a7dmr883226d6.1.1789669408180; 
 Thu, 17 Sep 2026 11:23:28 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91252d17cecsm3762106d6.44.2026.09.17.11.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 11:23:26 -0700 (PDT)
Message-ID: <fc7bae477fdeab0bcbb908863b4f434dc03844f2.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: Fix runtime PM leak in
 nouveau_connector_detect()
From: lyude@redhat.com
To: Wentao Liang <vulab@iscas.ac.cn>, airlied@gmail.com
Cc: bskeggs@redhat.com, dakr@kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, nouveau@lists.freedesktop.org, simona@ffwll.ch, 
 tzimmermann@suse.de, stable@vger.kernel.org
Date: Thu, 17 Sep 2026 14:23:24 -0400
In-Reply-To: <20260916180342.2090360-1-vulab@iscas.ac.cn>
References: <20260916180342.2090360-1-vulab@iscas.ac.cn>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7Nu8TR84P43_u8N66btyZRxuM-F_qqyONGr-qFV-HQg_1789669409
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

Nice catch!

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to drm-misc-fixes in just a moment

On Wed, 2026-09-16 at 18:03 +0000, Wentao Liang wrote:
> If nvif_outp_edid_get() fails, nouveau_connector_detect() returns
> early without dropping the runtime PM reference taken at the start
> of the function, keeping the device powered on until the next
> successful detect.
>=20
> Balance the reference on the error path like the other exit paths
> do.
>=20
> Fixes: 0cd7e0718139 ("drm/nouveau/disp: add output method to fetch
> edid")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_connector.c | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c
> b/drivers/gpu/drm/nouveau/nouveau_connector.c
> index cc239492c7f0..4a750d4bf1f4 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -600,8 +600,11 @@ nouveau_connector_detect(struct drm_connector
> *connector, bool force)
> =C2=A0=09=09=09=09new_edid =3D drm_get_edid(connector,
> nv_encoder->i2c);
> =C2=A0=09=09} else {
> =C2=A0=09=09=09ret =3D nvif_outp_edid_get(&nv_encoder->outp,
> (u8 **)&new_edid);
> -=09=09=09if (ret < 0)
> +=09=09=09if (ret < 0) {
> +=09=09=09=09pm_runtime_mark_last_busy(dev->dev);
> +=09=09=09=09pm_runtime_put_autosuspend(dev-
> >dev);
> =C2=A0=09=09=09=09return
> connector_status_disconnected;
> +=09=09=09}
> =C2=A0=09=09}
> =C2=A0
> =C2=A0=09=09nouveau_connector_set_edid(nv_connector, new_edid);

