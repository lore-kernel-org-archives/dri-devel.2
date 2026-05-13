Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C80ACD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 11:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC15B10E5D1;
	Wed, 13 May 2026 11:55:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bh0TgWy+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA91D10E5D1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:55:26 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 960AB444EE
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4C8C2BCFF
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778673326;
 bh=C3ROoSAwEcHmpVj4q2nXE9Zx2ZOZUZAfV3pe+l9yKtQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=bh0TgWy+eepwj2qnbn9Rc3qYpCqJLPwMWlEQbiwSrKH5tnYeUUxAyM+acmatna/d0
 bT+bKrITNGzPCW7k/nmRZFlOqsOwK8hE73H/w62ib0yp1843+uP6BxNttJwaMKvExP
 N1yvsRysJsvMOJvCF07i4kCwa8710Bf7vSOmvABfpxMurufWzXS1Wow/dqJJ5ybMdP
 dT7G/QMOcYEGUGyCcrrP5C9TGD/MGKFrOnoXNydAdFCCYKgsH5hiBcU7p48blC/lpy
 pVHuh+PGbdSN0o3cwqyC82SUJY/j0Bqp61k8JN/YjLFwO298TbChViZHTjcsEbVrGD
 Rc4Y5M8iAMRmA==
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-5a74ac8b40aso6110305e87.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 04:55:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9pRCMzczBu4fjhDK1HXo4mxBTlDt46gyVIn8eXHBr6NNUeRn78fbkfy2/llxK0/7KuhMfg6QtIItU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxbwGr806cJBhYakxuvwInELMGddweJRDGHXjR70gVyuyXhZW76
 ypWftwHXjYcw9m85jCJE2MFtocg6QiF0srogFtlD7l5yHEqOdu6yZyWxyJUzUUHDL2iMmMjEdKN
 gLrVxJqbn8HjTTrPXQq4+msQSuBRUxl1ONuvk8nhecQ==
X-Received: by 2002:a05:6512:68a:b0:5a8:9b6a:5749 with SMTP id
 2adb3069b0e04-5a8ef9af8a5mr1068752e87.28.1778673324966; Wed, 13 May 2026
 04:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-swnode-remove-on-dev-unreg-v5-0-0035eff63812@oss.qualcomm.com>
 <20260512-swnode-remove-on-dev-unreg-v5-3-0035eff63812@oss.qualcomm.com>
 <DIGUBLZXZXPJ.8CX0K5EL6255@kernel.org>
In-Reply-To: <DIGUBLZXZXPJ.8CX0K5EL6255@kernel.org>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Wed, 13 May 2026 13:55:11 +0200
X-Gmail-Original-Message-ID: <CAMRc=MdnKgkxsiw7UtpXaSYf+5WHMWZidy4YukPhndZY2Uft9w@mail.gmail.com>
X-Gm-Features: AVHnY4IuEQ8uACIYu2CQFY2xUnaqBV75CJzYWeWWso-yewElWdvH5VZ2Hb43cmI
Message-ID: <CAMRc=MdnKgkxsiw7UtpXaSYf+5WHMWZidy4YukPhndZY2Uft9w@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] driver core: platform: provide
 platform_device_add_software_node()
To: Danilo Krummrich <dakr@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
 Andy Shevchenko <andy@kernel.org>, Maximilian Luz <luzmaximilian@gmail.com>, 
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 platform-driver-x86@vger.kernel.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

On Tue, May 12, 2026 at 6:31=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Tue May 12, 2026 at 1:59 PM CEST, Bartosz Golaszewski wrote:
> > +int platform_device_add_software_node(struct platform_device *pdev,
> > +                                   const struct software_node *swnode)
> > +{
> > +     return device_add_software_node(&pdev->dev, swnode);
>
> I think this should be device_create_managed_software_node(), see also [1=
].
>
> That said, now that I see the resulting code and the corresponding sublet=
ies, I
> think we should reconsider your (well predicted) "temporary
> platform_device_release_full()" idea for -fixes, while iterating this for=
 -next.
>

Agreed, I think it's much safer this way.

Bart
