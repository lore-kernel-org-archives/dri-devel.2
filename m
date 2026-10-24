Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B1B606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dsTk01wf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C198910E1D2;
	Sat, 24 Oct 2026 20:50:30 +0000 (UTC)
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com
 [74.125.224.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53B4A10E1D6
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 20:50:24 +0000 (UTC)
Received: by mail-yx1-f54.google.com with SMTP id
 956f58d0204a3-6774639a8a4so1626503d50.0
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 13:50:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792875023; cv=none;
 d=google.com; s=arc-20260327;
 b=XVZVMB/9OebhlrVJlrCv609fCP6vEVonXYzYw0Si4Q/3TCKJo+qb/lQxb0EFhFAww4
 jKt/PLfLIL2Spd/U6EJw5i8ytew/e9S4iOclaTA+XXV7pL5xDQowpSdIuVQjUjnT7DPV
 heqvcWNq75MA1IfDLG+pT4tC71aVD2DtKvIGXM3toJeBbF26uvBWUy+bcC46E8yadnXX
 +juVTBM4guDypvad9mAOE+LLBPjG1ZFpsVWmfLpfyvrarCqtzBRwVg9hMX1i6HD/u91a
 akQ8w/hNz5+wItB3FSezyp1fqD+DrPiAo3SvGrX9cPQ+28xRXwsjIx/3NPjqTUfNqzL0
 ItSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2pheqrYFv+zl32Mdi/C5xZhVx+kYgPr7R76e3E4UtAg=;
 fh=h8kmlWUrFHpNNLvjcNuFfRmuT2aDvJvwYsPe+lpcxp4=;
 b=aOsW0sF6JLl5jYhA6c9g5YaSg7FtBzSPNsx9dS/QFrhwbPHT4stkDJFT5LxYtVS2Sb
 Jc7nwv75/TE6xEWn0jGoKWwKmlg9lkECwpuJgYL8Xqiz/xceNByLo378VSDomigUHOY1
 TqmErDhrqG7TsH1+aJqMS5p6VfPyksRxPji1N573HRItnQA6pf+OasKI5wjBs/ma+IZs
 CmAxmjT8LymLMVDsLO4HKZVL5mahdVO2cnheTEVAIPDnbosOnzAlLAmbsZnWfdEGSAes
 wc/dhoIQhTOnwhZfm7gRZZg2BMp7FWP2TIB6Uh3x7e3uE4PIQ29iFeKvjh+VxtgxPu78
 KVvg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792875023; x=1793479823; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2pheqrYFv+zl32Mdi/C5xZhVx+kYgPr7R76e3E4UtAg=;
 b=dsTk01wf+bxh+xr9LHjn3unDH5qxxJwaCaLi9kJQxaGcxWF/jgxrsstAeK8OGuVqpG
 Hko33491AiP+xfoHKkmUsvBxtHOGAdjXCKSOdubYR2y4zPaahwkoxk/lHg4pm4aNK8S2
 XqEPn5GvRnLd4j8K2WqhTdpbLby5tj16OFa30vGFUPNYPo/lSusBRF7fSleywuCuhR4Y
 RtOfGYFagImACV5vFoFj80QQHh5jS5jOdRYuaIcOdHxoBh/0u8uf8ne09qIyHS5Fv0eW
 sAmphKZ0sizBT/8Nx5N9xdUHpZEyDC6wZUTcixBhfel2+9xKRC6HXjF/5zgrGy2/ml+6
 Jsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792875023; x=1793479823;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2pheqrYFv+zl32Mdi/C5xZhVx+kYgPr7R76e3E4UtAg=;
 b=VHKI1tH3WqYIyr5HBw2XnhJf7i6+Ir0VS+S2tdIa2HkMyGdvM8im+YwjHMXq83aKaG
 6tD6u/eoThO7qaRgZs8MvOz9yC7EoF3EAskb49Dqf4pQyiSlV2F+57Seir0sOK2Je42Y
 8yj6zN/AMt4dDChRdnSNLL1RsK8rr45H0fWmGJpjGySHKXN6L7UU1aQckxNn//2k2KQO
 xFlIsyNtsJIe70Ixs5UOhib/ik5VaoUdo3MbbusmK4k38yIw4LTIDZ8M7xO9231GXZ3o
 H+b99Yb7aoNnnE+8mmZYEtzA/3jnQkgnGofudSDTYWx6uTQ1qBRDK9aRI51orQ0tCsMh
 VqiQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYNF8QHnn2LYuEKuLGUDaBNtkbCXIhneaViu1vm5YxD7u2Zvx4Vny0Q10avRYQJkH+6caM3kpCGWY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKP9Qv9xfUUkrL1BZt6FNN5jkAzsFEMnwal3faRu/MRrbvCDIIi
 UuBgmqmZFm1QS3SnMbG+zjcG5ljhG5arvNrGJ+WfGjURulExnJkcP7Rlb0V56Cq1/EO0LYiUeqs
 Cz7cavaglSDNGwXs/Mwafo4aA2NhsgtI=
X-Gm-Gg: AYBFou1vi1s/Ct3lrlymao0gDXrZGzcXFMYdpq29fwh+O7Qu3bY9r9aOzoI1vrCxflX
 nqqrYfXHMzMfD1RQj6vYb4jA/sIg/gBWrZY0w1q2dKGb6U9u2l0yPdl7TqFIkbzecJbts182cCM
 FkQkLsDnqVh8/DiFtqOGwSYBLsiCFGdfhPPsAxNyHTukyBdP6R93yLm55SISevOlukKlgokoOba
 jDL61Woh4cA/HPvB6My8KWAgnH/hlPmT5Prb5TqmFREFW39z+GfntRcUhJ0exhpgMom2TEqkaQg
 NMsrqf6KbVIGEWme6CldLlUg0K5Ovsw0w5rxdh/ZHhLTYW0nOfmSLWu9ZQqfmFmwMjPmEkNg+Ut
 77mZMFlZ4sNkCmct7EI/KBd4BPg+YHij+2JM=
X-Received: by 2002:a05:690c:82:b0:8b0:7900:1405 with SMTP id
 00721157ae682-8b166c44200mr20324627b3.81.1792875023277; Sat, 24 Oct 2026
 13:50:23 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260925175819.3699225-1-qwe.aldo@gmail.com>
In-Reply-To: <20260925175819.3699225-1-qwe.aldo@gmail.com>
From: Aldo Ariel <qwe.aldo@gmail.com>
Date: Sat, 24 Oct 2026 17:50:11 -0300
X-Gm-Features: AclHuK8RPndl3rBceGJ5GKds9BPkshpzDsHBMfwP3_8uyDds3AYrJ126aWi66_M
Message-ID: <CAP48Hfu=LTGfajcgceqbjNtE4oM+2WsA_4GgFQfSqEfub6jOzQ@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau: cancel irq_work before freeing connector
To: dakr@kernel.org, Dave Airlie <airlied@redhat.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000e3a357065e9c3ebf"
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
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000e3a357065e9c3ebf
Content-Type: text/plain; charset="UTF-8"

Hi Danilo, Dave,

Following up on this connector teardown fix sent September 25.

Would any additional validation or changes help with the review?
I'm happy to investigate further or revise the patch if needed.

Thanks,
Aldo



On Fri, 25 Sep 2026 14:58:19 -0300, Aldo Ariel Panzardo <qwe.aldo@gmail.com>
wrote:
> nouveau_connector_irq() schedules irq_work on the system workqueue.
> nouveau_connector_destroy() calls nvif_event_dtor() which unregisters
> the interrupt event source so no new callbacks will fire, but it does
> not drain the system workqueue.  If a work item was already queued,
> nouveau_dp_irq() can run after kfree(connector) and dereference freed
> memory.
>
> Add cancel_work_sync() after nvif_event_dtor() so any in-flight or
> pending irq_work completes before the connector is freed.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_connector.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c
b/drivers/gpu/drm/nouveau/nouveau_connector.c
> index XXXXXXX..YYYYYYY 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -395,6 +395,7 @@ nouveau_connector_destroy(struct drm_connector
*connector)
>       struct nouveau_connector *nv_connector =
nouveau_connector(connector);
>       nvif_event_dtor(&nv_connector->irq);
>       nvif_event_dtor(&nv_connector->hpd);
> +     cancel_work_sync(&nv_connector->irq_work);
>       kfree(nv_connector->edid);
>       drm_connector_unregister(connector);
>       drm_connector_cleanup(connector);

--000000000000e3a357065e9c3ebf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Danilo, Dave,<br>
<br>
Following up on this connector teardown fix sent September 25.<br>
<br>
Would any additional validation or changes help with the review?<br>
I&#39;m happy to investigate further or revise the patch if needed.<br>
<br>
Thanks,<br>
Aldo</div><br>
<br>
<br>
On Fri, 25 Sep 2026 14:58:19 -0300, Aldo Ariel Panzardo &lt;<a href=3D"mail=
to:qwe.aldo@gmail.com" target=3D"_blank" rel=3D"noreferrer">qwe.aldo@gmail.=
com</a>&gt; wrote:<br>
&gt; nouveau_connector_irq() schedules irq_work on the system workqueue.<br=
>
&gt; nouveau_connector_destroy() calls nvif_event_dtor() which unregisters<=
br>
&gt; the interrupt event source so no new callbacks will fire, but it does<=
br>
&gt; not drain the system workqueue.=C2=A0 If a work item was already queue=
d,<br>
&gt; nouveau_dp_irq() can run after kfree(connector) and dereference freed<=
br>
&gt; memory.<br>
&gt; <br>
&gt; Add cancel_work_sync() after nvif_event_dtor() so any in-flight or<br>
&gt; pending irq_work completes before the connector is freed.<br>
&gt; <br>
&gt; Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank" rel=3D=
"noreferrer">stable@vger.kernel.org</a><br>
&gt; Signed-off-by: Aldo Ariel Panzardo &lt;<a href=3D"mailto:qwe.aldo@gmai=
l.com" target=3D"_blank" rel=3D"noreferrer">qwe.aldo@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/nouveau/nouveau_connector.c | 1 +<br>
&gt;=C2=A0 1 file changed, 1 insertion(+)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu=
/drm/nouveau/nouveau_connector.c<br>
&gt; index XXXXXXX..YYYYYYY 100644<br>
&gt; --- a/drivers/gpu/drm/nouveau/nouveau_connector.c<br>
&gt; +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c<br>
&gt; @@ -395,6 +395,7 @@ nouveau_connector_destroy(struct drm_connector *co=
nnector)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct nouveau_connector *nv_connector =3D n=
ouveau_connector(connector);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0nvif_event_dtor(&amp;nv_connector-&gt;irq);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0nvif_event_dtor(&amp;nv_connector-&gt;hpd);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0cancel_work_sync(&amp;nv_connector-&gt;irq_work);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(nv_connector-&gt;edid);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_connector_unregister(connector);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_connector_cleanup(connector);

--000000000000e3a357065e9c3ebf--
