Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7EB606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gGv8K8A4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A842D10E064;
	Mon, 23 Nov 2026 16:54:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C151B10E064;
 Mon, 23 Nov 2026 16:54:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6DB80409F4;
 Mon, 23 Nov 2026 16:54:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7032B1F000CA;
 Mon, 23 Nov 2026 16:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795452842;
 bh=+s+2JqGfV/wt1208sMgNo78UahYBAE4HE3ngb4zFNXI=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=gGv8K8A4oKtmEseyLt+MAwYOjkPv5tc5XyC8c6rXsbZrHp3mIv2MsNMU3GFkROkfq
 35zpB3HhWPMLyG7Hzf83LdFZ4mYhg18is9I4JZxpTA8436qLoe5Sm7SvYEohRwP0d6
 qEkBR4ubg1F3VP80xAYG0PdCus+iFtOEV/Es3SeAX1Jmed4gH2NNMcDkGYHQf4Jqao
 YqAeeqrOe9eplb1Fm4bdIuGH5LtclnEFM4g4VyRs+qwlige1FOWTlGDPiQrqf/rbFV
 vFIxy3tmVxmAR/bcxt8yo4Cn9aqqDWDpZ7i39EZsRcL6nQ5RtSpfIYacSNrJaMljaq
 vnkg96Ax+/hRQ==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 17:53:59 +0100
Message-Id: <DN2QWVWVB2FP.2DL4ZSBMYRXEC@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 3/3] nova-core: only bind to GPUs when explicitly
 requested
Cc: <airlied@redhat.com>, "Lyude Paul" <lyude@redhat.com>, "Alexandre
 Courbot" <acourbot@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <nova-gpu@lists.linux.dev>
To: "Dave Airlie via B4 Relay" <devnull+airlied.redhat.com@kernel.org>
References: <20261123-nova-nouveau-gsp-v2-0-5e8c27aa8555@redhat.com>
 <20261123-nova-nouveau-gsp-v2-3-5e8c27aa8555@redhat.com>
 <DN2OVF03FAL6.2EKLEYINW79YO@kernel.org>
In-Reply-To: <DN2OVF03FAL6.2EKLEYINW79YO@kernel.org>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 23, 2026 at 4:18 PM CET, Danilo Krummrich wrote:
> On Mon Nov 23, 2026 at 3:50 AM CET, Dave Airlie via B4 Relay wrote:
>> @@ -30,3 +30,24 @@ config NOVA_CORE_SELFTESTS
>>  	  logs its failure and lets the probe continue.
>> =20
>>  	  If unsure, say N.
>> +
>> +config NOVA_CORE_BIND_GSP
>> +	bool "Make nova-core the default driver for GSP-capable GPUs"
>> +	depends on NOVA_CORE
>> +	default n
>> +	help
>> +	  Make nova-core bind to all NVIDIA GPUs it supports by default.
>> +
>> +	  By default nova-core does not bind to any GPU and leaves NVIDIA
>> +	  GPUs to other drivers, such as nouveau. Say Y here, or boot with
>> +	  nova-core.bind_gsp=3D1, to make nova-core claim NVIDIA GPUs
>> +	  instead.
>> +
>> +	  nova-core is work in progress and may not be functional, so this
>> +	  is intended for nova developers and testers only. When enabled,
>> +	  nouveau must not bind to the same (GSP-capable) GPUs, i.e.
>> +	  CONFIG_DRM_NOUVEAU_BIND_GSP=3DN or nouveau.bind_gsp=3D0 is required.
>> +	  Otherwise both drivers compete for the same devices and
>> +	  whichever is loaded first wins.
>
> I think this is a bit unsatisfying, for the Kconfig at least it would be =
nice to
> avoid the possibility of being able to configure
>
> 	- NOVA_CORE_BIND_GSP=3Dy && DRM_NOUVEAU_BIND_GSP=3Dy
>
> 	- NOVA_CORE_BIND_GSP=3Dn && DRM_NOUVEAU_BIND_GSP=3Dn
>
> since I wouldn't consider them valid combinations of Kconfig options.
>
> Maybe something like this:
>
> 	config NVIDIA_GSP_DEFAULT_NOVA
> 	bool "Use Nova by default for GSP-capable NVIDIA GPUs"
> 	depends on DRM_NOUVEAU !=3D n && NOVA_CORE !=3D n
> 	default n
> 	help
> 	  When both Nouveau and Nova are built, use Nova by default
> 	  for GSP-capable (Turing and later) NVIDIA GPUs.
> 	  When only one driver is built, that driver is used by
> 	  default. Older GPUs use Nouveau.
> =09
> 	  Override this default using the nouveau.bind_gsp and
> 	  nova-core.bind_gsp module parameters.
> =09
> 	  Nova is work in progress and may not be functional.
> 	  This option is intended for developers and testers only.
> =09
> 	  If unsure, say N.
>
> I think for the module parameters it is probably fine to not restrict thi=
s
> ambiguity.
>
> We've also discussed whether we can detect vGPU mode in order to pass GPU=
s with
> vGPU mode enabled to nova-core regardless. I think this requires an FSP r=
equest
> via EMEM (at least on Blackwell), so it should be possible to implement t=
hat
> with the existing infrastructure in nouveau as well, but I'm not convince=
d it's
> worth it.
>
>> +	  If unsure, say N.
>> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/dri=
ver.rs
>> index d6bc972d47c7..66208a244cab 100644
>> --- a/drivers/gpu/nova-core/driver.rs
>> +++ b/drivers/gpu/nova-core/driver.rs
>> @@ -105,6 +105,19 @@ fn probe<'bound>(
>>          dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
>> =20
>>          try_pin_init!(NovaCore {
>> +            // Only bind when explicitly requested through the correspo=
nding
>> +            // Kconfig option or module parameter. By default, leave NV=
IDIA
>> +            // GPUs to other drivers, such as nouveau.
>> +            _: {
>> +                if !crate::module_parameters::bind_gsp.value() {
>> +                    dev_info!(
>> +                        pdev,
>> +                        "Not binding to GPU; make nova-core the default=
 NVIDIA driver with CONFIG_NOVA_CORE_BIND_GSP=3Dy or nova-core.bind_gsp=3D1=
\n"
>> +                    );
>> +                    Err(ENODEV)?;
>
> I'd prefer this to be wrapped in an associated function of NovaCoreModule=
, e.g.
> NovaCoreModule::check_bind_allowed(). I'd also move it before try_pin_ini=
t!().

Actually, please disregard the latter, I want to avoid the need for
pin_init_scope().
