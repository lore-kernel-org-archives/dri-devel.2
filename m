Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8405C98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:59:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F80D10F088;
	Wed, 23 Sep 2026 13:59:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="fjIYZKEz";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 575DF10F07A
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 13:59:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790171965; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jicYzAoprwpsIWN1U00F8UuLOdczK6zyosgQsUMxTcGqqofaM/VefKS9qvdQrsxWMCf5AZkZr8q32XtrxvhfhNLmZHp1ao9SI5AHGaK4ExjXcKJK+tDjeO/Fb9OxcfaRJ7WG4YExTzLqcZDR/Ca4A1KcOcqiO9tFkaKxAM9oUZ8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790171965;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=L7epMfBwO2rJwwLcucODN167YbFCjHgq+KPch1hiG+E=; 
 b=U3raRjcO6FiJ8s4sct/2rOaXtEQ1OwGsVPV2UGR0TsHGrfboVeAFLUD4w9dcVfeLpOrT7G7ChlDTpjpM53jLZq27vMKLoywIn4N/YME9tmzdnd+ihTLg5QkGu1qS/1N+gXO7c1kVJwsgc1xLASfLmu5M0fZgWn8hU0bIAAe84rA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790171965; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=L7epMfBwO2rJwwLcucODN167YbFCjHgq+KPch1hiG+E=;
 b=fjIYZKEzmcfcdkZEfeXVr6h+2+NJw9FaHxC7kbQcYExCGJHZK0rPbOBJl5vriP1m
 4rzcIccVn9O/ZqzG2XS29d9x0NE0QIS5rhdcZ81UjTTDCuXDTTRh/MFIqgpnLODgrPh
 q+jBR+IOtijQ1DjlES/Nm9Da1CotXBbDEdC8T1T4=
Received: by smtp.zohomail.com with SMTPS id 1790171962617504.15189302321266; 
 Wed, 23 Sep 2026 06:59:22 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH 1/9] drm/tyr: validate presence of CSF shared section
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260915-tyr-interfaces-v1-1-5d28f1f75aca@collabora.com>
Date: Wed, 23 Sep 2026 10:59:02 -0300
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
 kernel@collabora.com, Deborah Brouwer <deborah.brouwer@collabora.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C8FBCD55-3246-41B6-9F45-C1190F0FFD14@collabora.com>
References: <20260915-tyr-interfaces-v1-0-5d28f1f75aca@collabora.com>
 <20260915-tyr-interfaces-v1-1-5d28f1f75aca@collabora.com>
To: Laura Nao <laura.nao@collabora.com>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-ZohoMailClient: External
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



> On 15 Sep 2026, at 07:57, Laura Nao <laura.nao@collabora.com> wrote:
>=20
> From: Deborah Brouwer <deborah.brouwer@collabora.com>
>=20
> The firmware binary must have a shared section for communicating with
> the MCU. Check for this section after parsing and fail with -EINVAL if =
it
> is missing.
>=20
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
> drivers/gpu/drm/tyr/fw/parser.rs | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/tyr/fw/parser.rs =
b/drivers/gpu/drm/tyr/fw/parser.rs
> index c4d0ad1d7899..8bddaa1f0aa2 100644
> --- a/drivers/gpu/drm/tyr/fw/parser.rs
> +++ b/drivers/gpu/drm/tyr/fw/parser.rs
> @@ -197,6 +197,20 @@ pub(super) fn parse(&mut self) -> =
Result<KVec<ParsedSection>> {
>             return Err(EINVAL);
>         }
>=20
> +        // Validate that the firmware contains the required shared =
memory section.
> +        let has_shared_section =3D parsed_sections
> +            .iter()
> +            .any(|section| section.va.start =3D=3D =
super::CSF_MCU_SHARED_REGION_START);
> +
> +        if !has_shared_section {
> +            dev_err!(
> +                self.cursor.dev,
> +                "No shared section found at 0x{:08x} in firmware\n",
> +                super::CSF_MCU_SHARED_REGION_START
> +            );
> +            return Err(EINVAL);
> +        }
> +
>         Ok(parsed_sections)
>     }
>=20
>=20
> --=20
> 2.39.5
>=20


Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=
