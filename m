Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC868606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MsLuYyeJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E5EB11217D;
	Thu, 19 Nov 2026 08:32:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA23F11217B
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795077148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GOeeMlJadvR8eJKaf/pvSRcLKH/zNPjXMWFdAT6wDGo=;
 b=MsLuYyeJYN+7kNu4reupJyTWt7W+QlXn6Bra5RAm4C4zuOMp8Bc2EBHCF1sEEmblD65SxB
 /pSKQom5KewM3jwKNms0FLfFOev8st2XHvVcu6gdjRhmWQuDMFnbv/3wshYR8WN1a8/WvY
 DJPagUQ9f5uqPmO+p2uDV8LXmfl5YwM=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-x05GCyTtNjKlCIAPUr9UIQ-1; Thu, 19 Nov 2026 03:32:26 -0500
X-MC-Unique: x05GCyTtNjKlCIAPUr9UIQ-1
X-Mimecast-MFC-AGG-ID: x05GCyTtNjKlCIAPUr9UIQ_1795077146
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8b155f4eb8eso29123497b3.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:32:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795077146; x=1795681946;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GOeeMlJadvR8eJKaf/pvSRcLKH/zNPjXMWFdAT6wDGo=;
 b=t2ZHv1DtpE8exu58Vkz3q/PB8PRx73P/YghSGPNJZf7Ts7J1tVAQq7ePV8d8KwyAnc
 qNyEmmyb+KGo9YY0kf07KcTHkv8RS3cjk2SG3o3EQVLfGrD+xezfRCZMxQqO55/eUMGL
 LictNza9SQdAZHWagbQiptLbLMmV5o1Y1Mpv0jyYmxqc85u3A6o1I8YIR4iYyO48koFx
 r0ny5hSEQCv5BFo/4II9nio1R1XJeuI6tfvh34hMJvqmBtHEW1eiWOjSxyt75kDzfpW5
 M7AMeNQL08ur3VQZdrY9Za+j63hC0dqkAYcgFtml49qWtmOF5MRnnYGL5KFCbg+h6CL9
 5eaA==
X-Forwarded-Encrypted: i=1;
 AL+hErGe70kqJ5++SeZw9L8VupHvlZDrdLzJhG/XUU0+iRmlIpTMLJIC8Cg5qg0w6/qa5bovdgjb7DklmCk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9RaIG45xmfkmqzyBcbQ3rNf5Ux8pYPyIhyJNtXtYsLlfQOjrBj
 XvW+N/8JknklIHJU5BLj80QKqNfNyIh8uCr2O+q1pnQa5e3c8ukhuqbak89GbcgphEGJh/tWCW4
 Ql6E4iv+8PpiCiYtyvg7XrWdJG26f72xBLdji2jc/6vNzyIAd5CAA5+t9YLxUSfXeoHUDFcGsdN
 hC5uGPQP3AKwMLgOTPGGq4FK/pDsl+/hlksT6lhuJzZPEk
X-Gm-Gg: AZFdTZck2X2/0NQwuxzB9JeX0G6JbEGmoCSPjbcbUVA3SCNYeusSPwFw6xg4R8m5FmI
 pYRUG82vodViWXMaba1rMHGYu6u1b1Ccm+0eILyel1LvISxMvzuS9FxIVVy2lodIyeFbgH11ynW
 nPKUExhBF7+3OLEYmLxhjfvuXq3Na6yWndo1OMyJNq8QeKW+r/yLyxCLma
X-Received: by 2002:a05:690c:22c7:b0:8b1:e7c:cde6 with SMTP id
 00721157ae682-8b4fecfa916mr15730657b3.14.1795077145719; 
 Thu, 19 Nov 2026 00:32:25 -0800 (PST)
X-Received: by 2002:a05:690c:22c7:b0:8b1:e7c:cde6 with SMTP id
 00721157ae682-8b4fecfa916mr15730547b3.14.1795077145072; Thu, 19 Nov 2026
 00:32:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117184019.430513-1-andreas@kemnade.info>
In-Reply-To: <20261117184019.430513-1-andreas@kemnade.info>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 19 Nov 2026 09:32:11 +0100
X-Gm-Features: Aa3M54pcd8uZex_i9Rd4360VDD8T-xWI8UqsAN9jqbFQoUlHyB8r0gZiXyXzCl8
Message-ID: <CADSE00+-9Br_eVWRc=+i+OnthqZYfaMZ57Gxp5fXmqFXrMqf3A@mail.gmail.com>
Subject: Re: [PATCH] drm/omap: dss: simplify omapdss_device_init_output
To: Andreas Kemnade <andreas@kemnade.info>
Cc: tomi.valkeinen@ideasonboard.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 luca.ceresoli@bootlin.com, louis.chauvet@bootlin.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 279AUtlh3TGCeLUKB8XGGRyQlEX1pf6Mai0QoSYIDMs_1795077146
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 7:40=E2=80=AFPM Andreas Kemnade <andreas@kemnade.in=
fo> wrote:
>
> During reviewing of a regression fix is that function, questionable
> possibly unbalanced drm_bridge_put/get came to light. Sashiko
> review pointed out that of_drm_get_bridge_by_endpoint() does not return
> NULL, so the questionable code is simply unreachable and therefore does
> at least not harm. Remove the dead code.
>
> Suggested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/gpu/drm/omapdrm/dss/output.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/omapdrm/dss/output.c b/drivers/gpu/drm/omapd=
rm/dss/output.c
> index b5cef5093a883..cbb9b2f1a2133 100644
> --- a/drivers/gpu/drm/omapdrm/dss/output.c
> +++ b/drivers/gpu/drm/omapdrm/dss/output.c
> @@ -20,7 +20,6 @@ int omapdss_device_init_output(struct omap_dss_device *=
out,
>                                struct drm_bridge *local_bridge)
>  {
>         struct drm_bridge *bridge;
> -       int ret;
>
>         bridge =3D of_drm_get_bridge_by_endpoint(out->dev->of_node, out->=
of_port, 0);
>         if (IS_ERR(bridge)) {
> @@ -34,20 +33,11 @@ int omapdss_device_init_output(struct omap_dss_device=
 *out,
>         out->bridge =3D bridge;
>
>         if (local_bridge) {
> -               if (!out->bridge) {
> -                       ret =3D -EPROBE_DEFER;
> -                       goto error;
> -               }
> -
>                 out->next_bridge =3D out->bridge;
>                 out->bridge =3D drm_bridge_get(local_bridge);
>         }
>
>         return 0;
> -
> -error:
> -       omapdss_device_cleanup_output(out);
> -       return ret;
>  }

This looks correct, it is dead code. But removing it makes the return
value meaningless (every path returns 0), so it may make sense to make
omapdss_device_init_output() void?

I looked for the callers and there are only a handful. They can be
simplified to avoid checking the return value (the "r=3D...; if (r < 0)
{ cleanup; }" patterns is repeated in all of them).

BR,
Albert.

>
>  void omapdss_device_cleanup_output(struct omap_dss_device *out)
> --
> 2.47.3
>

