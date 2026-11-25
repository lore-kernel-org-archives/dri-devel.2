Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02348606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hM/Hhp/g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B96710E07E;
	Wed, 25 Nov 2026 18:38:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3214B10E07E
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:37:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0AB3D464CC
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC0C1F01808
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795631875;
 bh=ThhoIel7DpJo+Z9HTOd5yaKh4yxVMCupiDlEOYEsUTA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=hM/Hhp/glJKiy2UHvvPIvDz3bQ4arx/Em/jxGlIs5JIsIRP6rNUba0vLTpWsUqcBO
 NdkENmgt12xGYAJnV9QcJA9zK9aN9SuIj7azxDqkyCr5VbEJiENv3aLIOL345VWIk7
 iuYKY7HtDzY4HLK6DGClLXDVJkWHjRZsqckxARxf1ajyj6BerGz0ibB9CLJAauzBzj
 uPEtNXFnyZ6E4+OPuZBLooz6aBMV05j4asXKIxbZD6onyZ1OVuxlQ9RaNmYyjc7Rs+
 FLFVCbtOR3vioC/MsER9Iv0DkVbr8UgJcPw0O6/cU6KowHbij67fFbk8aOKP3vUMsf
 DCbUGF87fuXcQ==
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-3ae6f2b193fso31307151fa.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:37:55 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErENJj5PqzLo3TFq95u0DnoZBTxeFcuxqKxaNsrPCJa/S/lHL2EyQwYGD7tZ+YmYI5pXJqpTtfyJy7Y=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+9Vz5GBYhczzDa4q9qZud/O+23J4j97JJrgJUcbTz6gpQjjcx0
 5MlQRQknwCFI3jvZ2nKFGY+RcXSNSXpTuqtq/Z4CjQdxvGyylIFjlpwc03f47Rquva23HSTjjeh
 Wy8mQztQexwSQkhFfuxxDBbDtviMPXLo=
X-Received: by 2002:a05:6512:3d10:b0:5c0:d7c:7a1 with SMTP id
 2adb3069b0e04-5c1bc7d0f5amr6199145e87.25.1795631874701; Wed, 25 Nov 2026
 10:37:54 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119230733.790573-4-blum@kernel.org>
In-Reply-To: <20261119230733.790573-4-blum@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 25 Nov 2026 19:37:42 +0100
X-Gmail-Original-Message-ID: <CAD++jLm_sE7r22_THeMU=jHfA5u-NH1PyDcZ+3OP5KfBPsM0ZQ@mail.gmail.com>
X-Gm-Features: Aa3M54rz2zBBXyjBliUtbexR77yF7c6oBfq13Y-rusRNaJWJqhX0Mayx5QUkSkI
Message-ID: <CAD++jLm_sE7r22_THeMU=jHfA5u-NH1PyDcZ+3OP5KfBPsM0ZQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] backlight: ktd253: Initialize properties before
 device registration
To: Thorsten Blum <blum@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Jin Park <jinyoungp@nvidia.com>, Samuel Ortiz <sameo@linux.intel.com>, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 12:08=E2=80=AFAM Thorsten Blum <blum@kernel.org> wr=
ote:

> The backlight API requires max_brightness to be supplied at device
> registration and not to be modified afterwards. KTD253 currently sets it
> after registering the device, allowing userspace to read a maximum
> brightness of 0 before the configured value is applied.
>
> Pass the initial brightness, maximum brightness, and power state to
> devm_backlight_device_register() to set them before the sysfs attributes
> become visible to userspace.
>
> Fixes: 5317f37e48b9 ("backlight: Add Kinetic KTD253 backlight driver")
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Looks right.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
