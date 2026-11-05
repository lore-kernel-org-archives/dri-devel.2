Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0BC606A337
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 03:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BjwJPGhl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E2AB10E28C;
	Thu,  5 Nov 2026 03:22:44 +0000 (UTC)
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D50D610E411
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 03:22:38 +0000 (UTC)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-677bc4704cbso1770318d50.0
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 19:22:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793848958; cv=none;
 d=google.com; s=arc-20260327;
 b=dD+a+sn+XJwec7RucVmpzySt0y20tV3s3KKVYddy9k4HUl8bBudtfDj38p9/EBgW3A
 azwSInLVKDkxl8sDF+mOiYLOkxc9uDIp7pgp+oMuh/DkfNAuSvlYzbBfe1K2zf6A+RUw
 2hrXLFdk3OKs96AoePaJCi4vvBnFSlMQI1vS+3XYcO9mWlrPepDEtwLBo1uV+jNIeqtt
 pAMeY+jIhDaLudXRZ7jd57OKtWW0jMev7Bp77yuCKVaiOwuBpMYSxxID9RA3xqzedc5G
 nX7vFGxsMY2DmjJpq7KPLSJTkRphYhOYeldpfVhcmonolKPuKbqorG8J3LV3PBa/ZxbY
 wWZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=avEJPS9ML1med4KWJvijH4mGMhfCeFDeDWnEyAF9h88=;
 fh=KgXl8j6cvnXriX7KIBKm0EaVUlxJ0c88KAbYSAgmQEk=;
 b=nIOAuZseSQ9yKaAI+vdxprdGX0+mYYu9Y6bg3vFQGVwX5AqRcKOYNK+8Uv+kMYepdH
 XsOr5wPD2tYUG7CXsnnaoQhtXTMipxfoC24mkMck6Ma53Iisw3uh/G+MVp8XPYDizFrZ
 p6lYShz8V6u2OERC9MqmlssTqEYUCUl1MBTLC+D03+jbsRWvjI4ruFrhJArWHUti7yT1
 W7TvCVuTTcOvxI7Vw+BcFtUIiiymUi+L9wT9iKB4gH8GXhXgcpPDOeX99uqkYOyU/XLj
 XV9PAg76lklptdX69XOZRf8CZxTwE5fQ6CEM0btNlt5P9uiBZC5JKcJbb6EAk2LEyyD/
 8XMg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793848958; x=1794453758; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=avEJPS9ML1med4KWJvijH4mGMhfCeFDeDWnEyAF9h88=;
 b=BjwJPGhlC2lCLcCm2yMuG7pHBsz/w87LU/EX1quzUr1UxxdEW051XwM5nOPfmS/ngw
 HhISgw+eoeF4w9/opqVSXntFqSc3SYdofGI9acjdc76/Xfq9kDJQLBFIbVz9guM8oFPY
 zHlO2yY+M9OQEsc9j8zctTI2orj/TXRLhj72jWsWQ23XITZ282kMDYz3S4NFZAwjAdpM
 IWxoqpzNIaW7Z2f4n8UUicZ5+0kH+GRm/nrlRWNbduNIkOFMHMdB+zGLEnBWgHRn+ei2
 3gJGJjpa64SSMCkH3CfhGMFU+ZXV3iC0Jnc/88RPgo+STpLtW71AJPdjoSKvfTO9oSsW
 MrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793848958; x=1794453758;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=avEJPS9ML1med4KWJvijH4mGMhfCeFDeDWnEyAF9h88=;
 b=EdQhPWX2TPqDbYvAxKS/CsqSlWWJs7/ZJ7aMWsMuJUc1m8ZEqAp0w6CqVqmFhmKCzD
 qeT0n+nciAmwv9HlPaWwxte3IuDvp90iNj/Q/158rQ28h/BY+5hwe+1BwrMXKbEh15xR
 AMlRJRugSy2nmUj4ugKZbqTl8o02p8jd1LFWL7OnTyTYjatnIXSGNMFhcqAKubssTtfq
 N7Fy9PcSWFtuFlS74iwJvrzgYpk4wSA7DUdrfI0LmbDvwQHEQ4ZpaIINCNeSPtqdCRRo
 QX2dOcQAYKjTDWaaBZmYYjYDewNSC6WXhDsqJXXn/ahfZt0lyYj/K8n+GmE7L/eys+z7
 ZNLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2RN6y/o7rQ7KLoTvbp+9ZGS9t2vk4VXTibvt5BZ7hicPDlTCv5idzjrewbVbAsJsTaCRDjiNhiiY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/pGO3MUtrf6Zu46ScXlJrcHcSjf62YH/AVhHzjDUGlp/JiEZUY
 UiG7AJf/JB6HbUur3o635CAhjGrf0ngQVf4W5YTS9OEdfTX0sNTBliLA6s9Fl6Y9DoI8M6/Vq8j
 dOirjDRa+lceKIPPowJyTinMc56zvS4o=
X-Gm-Gg: AYBFou1MuJjvQe5VWswyLdgTQyzIh6g5+1J6u+OyP05da+6jiz+EsTlYJjhYyvoVQBX
 PMa1i77ctv1YlS8JBSKCKQh2zfx4Z1GSrd+E9MN9kKv9iyqk6sUt9UN1ZtBSUBRseHcCGXzHyOP
 tuYQYVCm5aUHLD3kupFbuunZeGRNIUaJtk2NfXD+ffbGq7KfVWHz9b/afOt2eFlVuwJVatOuNh0
 prGdHK739B/YQefynisZj06FoviDi5+oIdtOSERmV3Be+N2vnoE3G2doZBgwNfUArBPoXFgOH/J
 PB4mKMTxSxd+Ar2H3Ef83tUwyDiA6cJyjCxt1jtEEZUg+Gs0/FVCe3yqKfvJ/bPfMveGlSJauKC
 bMJrPsQiOG+AVDD/SXwQE22tf9kv96rVtNmI2YxGhNQvNCATEH2yFljr6NRo=
X-Received: by 2002:a05:690e:408b:b0:67b:fe7e:3796 with SMTP id
 956f58d0204a3-67bfe7e3a47mr1118045d50.5.1793848957564; Wed, 04 Nov 2026
 19:22:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103155338.1949294-1-sidong.yang@furiosa.ai>
In-Reply-To: <20261103155338.1949294-1-sidong.yang@furiosa.ai>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Thu, 5 Nov 2026 12:22:26 +0900
X-Gm-Features: AclHuK-SpSCz6RumENvx2yQ6iVXRKTEGvo6_tUmRKMrurLM7QwlEqialnFZRCuI
Message-ID: <CAKbEzns7nqMP0FSf+G9e31nXR-c+vy+Vv-gTyFV5jv46rAgwRw@mail.gmail.com>
Subject: Re: [PATCH v4] accel/rocket: Report NPU usage through fdinfo
To: Sidong Yang <sidong.yang@furiosa.ai>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Sidong,

On Wed, Nov 4, 2026 at 12:53=E2=80=AFAM Sidong Yang <sidong.yang@furiosa.ai=
> wrote:
>
> There is no way to tell how much of the NPU a client uses. Implement the
> DRM usage stats: account the time each job occupies a core and report
> it per client as drm-engine-npu, along with drm_show_memory_stats() for
> the BOs.
>
> The cores are identical, so they are reported as a single engine with
> drm-engine-capacity-npu set to rdev->max_cores, the number of core
> slots. The time is summed over all cores, with an atomic counter as the
> cores complete jobs concurrently.
>
> Jobs can outlive the file that submitted them, so the counter is
> refcounted and each job holds a reference. The time covers the whole
> period a job owns a core, so it also includes handling the completion
> interrupt and the gaps between the tasks of a multi-task job.

nit: "the time completed jobs occupy a core" would be more accurate than
"the whole period", as timed-out jobs are not accounted.


>  * RK3588
> +
> +.. _rocket-usage-stats:
> +
> +Rocket DRM client usage stats implementation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The accel/rocket driver implements the DRM client usage stats specificat=
ion as
> +documented in :ref:`drm-client-usage-stats`.
> +
> +The NPU cores are reported as a single engine, npu, with a capacity equa=
l to the
> +number of cores. The time is summed over all cores, and covers the whole=
 period
> +a job occupies a core.

Same here

> @@ -139,7 +183,28 @@ static const struct drm_ioctl_desc rocket_drm_driver=
_ioctls[] =3D {
>         ROCKET_IOCTL(FINI_BO, fini_bo),
>  };
>
> -DEFINE_DRM_ACCEL_FOPS(rocket_accel_driver_fops);
> +static void rocket_show_fdinfo(struct drm_printer *p, struct drm_file *f=
ile)
> +{
> +       struct rocket_device *rdev =3D to_rocket_device(file->minor->dev)=
;
> +       struct rocket_file_priv *rocket_priv =3D file->driver_priv;
> +
> +       /*
> +        * This is an estimate: the time is taken around the whole period=
 a job
> +        * occupies a core, so it also covers handling the completion int=
errupt
> +        * and, for a job made of several tasks, the gaps between them.
> +        */

And here.

with these addressed:

Tested on RK3588: no OOB access, and fdinfo reads correctly with several
apps running concurrently.

Reviewed-by: Gyeyoung Baek <gyeyoung7182@gmail.com>
Tested-by: Gyeyoung Baek <gyeyoung7182@gmail.com>

--=20
Thanks,
Gyeyoung
