Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECE3C55167
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 21:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2D3510F08B;
	Thu, 30 Jul 2026 21:00:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XlIrnsvx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0929210F08B
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 21:00:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9948541720;
 Thu, 30 Jul 2026 21:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722611F000E9;
 Thu, 30 Jul 2026 21:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785445246;
 bh=GU4+hYZmZbT8tEUgTys+3//O3qZ0GI86e9VhsvZnCak=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To;
 b=XlIrnsvxN8Tws6u8wpf2xhSPdpQHht3nk99pv2UUZrTJ7CnNuNd1V6nCgKcOici7E
 1u4l/as7uDuGCMZcCATCX+vfNtTub5A/vSX6tZzdslKO+vYQrE/zLGe/ccTvDzzVBc
 P+STc3ugdaY3KKCj0Toc6vC25GYbp1QZUQdFEsUdYjTcx6Yp8dIIBx+Oev7dr9AZPc
 zu6XBHxm+7fy+kKyE1jJ507sJoBnw5H5eaggmkbYl/oMXml+8QgZ1InStH/bweo7Po
 ZicWB64bO2erPMxgizFIxFBmnlOMbc4D36IhSRxFip3Lx9GTpQbbqtvD0u3kb2IKtN
 1WMlasksKTS8g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Jul 2026 23:00:37 +0200
Message-Id: <DKC7IILD54UO.1N47QGSHMKENI@kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 11/11] RFC: rust: driver: support map-like syntax for
 ID table
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <iweiny@kernel.org>, "Leon
 Romanovsky" <leon@kernel.org>, "Len Brown" <lenb@kernel.org>, "Igor
 Korotin" <igor.korotin@linux.dev>, "Rob Herring" <robh@kernel.org>,
 "Saravana Kannan" <saravanak@kernel.org>, "Viresh Kumar"
 <viresh.kumar@linaro.org>, "Michal Wilczynski" <m.wilczynski@samsung.com>,
 "Drew Fustini" <fustini@kernel.org>, "Guo Ren" <guoren@kernel.org>, "Fu
 Wei" <wefu@redhat.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pci@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-usb@vger.kernel.org>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
 <20260629-id_info-v2-11-56fccbe9c5ef@garyguo.net>
In-Reply-To: <20260629-id_info-v2-11-56fccbe9c5ef@garyguo.net>
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

On Mon Jun 29, 2026 at 2:39 PM CEST, Gary Guo wrote:
> diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
> index c81fca5b4986..5f4d191fce51 100644
> --- a/rust/kernel/device_id.rs
> +++ b/rust/kernel/device_id.rs
> @@ -183,6 +183,17 @@ macro_rules! module_device_table {
>          $table_type: literal, $device_id_ty: ty,
>          $table_name: ident, $id_info_type: ty,
>          [$(($id: expr, $info:expr $(,)?)),* $(,)?]
> +    ) =3D> {
> +        $crate::module_device_table!(
> +            $table_type, $device_id_ty, $table_name, $id_info_type,
> +            {$($id=3D>$info,)*}
> +        );
> +    };
> +
> +    (
> +        $table_type: literal, $device_id_ty: ty,
> +        $table_name: ident, $id_info_type: ty,
> +        {$($id: expr =3D> $info:expr),* $(,)?}
>      ) =3D> {
>          #[export_name =3D
>              concat!("__mod_device_table__", ::core::line!(),
> diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_p=
ci.rs
> index 2282191e6292..652819dff082 100644
> --- a/samples/rust/rust_driver_pci.rs
> +++ b/samples/rust/rust_driver_pci.rs
> @@ -75,10 +75,9 @@ struct SampleDriverData<'bound> {
>  kernel::pci_device_table!(
>      PCI_TABLE,
>      <SampleDriver as pci::Driver>::IdInfo,
> -    [(
> -        pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5),
> -        TestIndex::NO_EVENTFD
> -    )]
> +    {
> +        pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5) =3D> TestIndex:=
:NO_EVENTFD,
> +    }
>  );

This LGTM, do you want to send a follow-up series?

Thanks,
Danilo
