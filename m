Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB50606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gfRiJfyu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25519112A8C;
	Fri, 27 Nov 2026 12:44:17 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0066D112A94
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:44:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0705961D42;
 Fri, 27 Nov 2026 12:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BAE1F000C1;
 Fri, 27 Nov 2026 12:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795783449;
 bh=s97IOTm5/rXBV3ZdRIfid6XH5xn9938zK2WxzL34EEo=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=gfRiJfyugR/55cIxCb0DD9FbKrYxSkewGFaV66svCV6I6kjkQlkLhePEFUK1iH9kD
 cEUhgtsegnDqOlHpwD8xAeLmRH3DsaD1gLoSJQBNAjj7Njp1xkTgKyr2Sf6/xqgPci
 aerwv8M9oHbyFOUesiv5O2A0RkS3eMfk8R6KuLeWFbpbE+ZyMi2bxKECjs4TRgSLsK
 70N/AvvKAbg+dZIA8J+dEP3XXOJqQJdMtwQUdzVF9VXSnpKgXS3B7TM/sSgC21hq/8
 PzhuTsjjIiKo/+3mQvcUq0jAfmNVlfi0TJv3G8R3amVao8FwxI8vLVPR2sT/QijUdp
 K7YbrgtEl9paA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 13:44:02 +0100
Message-Id: <DN603ORZA8KY.30W58KXH3Q8Y4@kernel.org>
Subject: Re: [PATCH 2/3] rust: pci: return a bitfield type for dev_id
Cc: "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Alistair
 Popple" <apopple@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi
 Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pci@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261127-nova-gsp-dbd-v1-0-0fb5f7c2ce63@nvidia.com>
 <20261127-nova-gsp-dbd-v1-2-0fb5f7c2ce63@nvidia.com>
In-Reply-To: <20261127-nova-gsp-dbd-v1-2-0fb5f7c2ce63@nvidia.com>
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Nov 27, 2026 at 12:46 PM CET, Alexandre Courbot wrote:
> +bitfield! {
> +    /// Bus-Device-Function ID of a PCI device. Equivalent of C's `PCI_D=
EVID`.

Please make the reference to the C API a separate line.

Additional nit, I'm not sure I'd use "equivalent" as Bdf is a type that can=
 do a
few more things.

> +    pub struct Bdf(u16) {
> +        /// Bus number.
> +        15:8 bus;
> +        /// Device number.
> +        7:3 device;
> +        /// Function number.
> +        2:0 function;
> +        /// Aggregation of `device` and `function`, which are commonly u=
sed together in code.
> +        7:0 devfn;
> +    }
> +}
> +
> +/// Formats the ID as `bus:device.function`, like the corresponding part=
 of C's `pci_name()`.
> +impl fmt::Display for Bdf {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        write!(
> +            f,
> +            "{:02x}:{:02x}.{}",
> +            self.bus(),
> +            self.device(),
> +            self.function()
> +        )
> +    }
> +}
> +
>  /// Abstraction for the PCI device ID structure ([`struct pci_device_id`=
]).
>  ///
>  /// [`struct pci_device_id`]: https://docs.kernel.org/PCI/pci.html#c.pci=
_device_id
> @@ -700,10 +729,10 @@ pub fn revision_id(&self) -> u8 {
> =20
>      /// Returns the PCI bus device/function.
>      #[inline]
> -    pub fn dev_id(&self) -> u16 {
> +    pub fn dev_id(&self) -> Bdf {

At a first glance I wasn't sure if the naming should align, i.e. whether Bd=
f
should be DevId instead, but I think this strikes a good balance: dev_id()
remains aligned with the C API and Bdf as a type is more on point than DevI=
d.

With the above nit fixed,

Acked-by: Danilo Krummrich <dakr@kernel.org>
