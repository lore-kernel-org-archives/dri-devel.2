Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA72BCD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 16:31:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E57A610EB8D;
	Tue, 12 May 2026 16:31:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uG8OfP8I";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB6B810EB81;
 Tue, 12 May 2026 16:31:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7FC6E40AA5;
 Tue, 12 May 2026 16:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E460FC2BCB0;
 Tue, 12 May 2026 16:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778603510;
 bh=sblpOtK2lQq5+S4Sem63m6E70MmkLH+vjHxwFv70MY0=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=uG8OfP8IAYLS92UPnfRbS+xC22SKgEeek73+SJbCW/Q1wxhtGAR5HsBttZZgsDjow
 W/gjOCl57L3P/aY4qksrIRtvOCHnVX+n75Oop6ji+09hKNZEitGmxPiOwazyIhkFtz
 ZcYnw7GxxMqBYqwv07DYMgLDxTjxK64e7sWNbuXNBOc0KpwZ3m5m36PcNNfWPdOruN
 6bV2yOdfJ0VB9wNp/3PpLzXkPdEprKrg6r0aJCLePQyKwQwvtlTZ/VljF8nhGdp5Ii
 GwvySQJMyKq0nvGiEkcL5JjUA2U1ms35IThuo3f5+8Y0vCMcblIQJ1KRqA2aCVvgsT
 HU+KchwapPiLQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 May 2026 18:31:44 +0200
Message-Id: <DIGUBLZXZXPJ.8CX0K5EL6255@kernel.org>
Subject: Re: [PATCH v5 3/7] driver core: platform: provide
 platform_device_add_software_node()
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Brendan Higgins" <brendan.higgins@linux.dev>, "David Gow"
 <david@davidgow.net>, "Rae Moar" <raemoar63@gmail.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Maximilian Luz" <luzmaximilian@gmail.com>, "Hans de
 Goede" <hansg@kernel.org>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Matthew Brost" <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Rodrigo Vivi" <rodrigo.vivi@intel.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, <brgl@kernel.org>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <platform-driver-x86@vger.kernel.org>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260512-swnode-remove-on-dev-unreg-v5-0-0035eff63812@oss.qualcomm.com>
 <20260512-swnode-remove-on-dev-unreg-v5-3-0035eff63812@oss.qualcomm.com>
In-Reply-To: <20260512-swnode-remove-on-dev-unreg-v5-3-0035eff63812@oss.qualcomm.com>
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

On Tue May 12, 2026 at 1:59 PM CEST, Bartosz Golaszewski wrote:
> +int platform_device_add_software_node(struct platform_device *pdev,
> +				      const struct software_node *swnode)
> +{
> +	return device_add_software_node(&pdev->dev, swnode);

I think this should be device_create_managed_software_node(), see also [1].

That said, now that I see the resulting code and the corresponding subletie=
s, I
think we should reconsider your (well predicted) "temporary
platform_device_release_full()" idea for -fixes, while iterating this for -=
next.

[1] https://lore.kernel.org/driver-core/DIGU67TAWF7W.1DWZMO4XAVK7G@kernel.o=
rg/
