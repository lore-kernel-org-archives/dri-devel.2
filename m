Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAD1CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 17:43:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C54C10EA99;
	Fri,  9 Oct 2026 17:43:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="IcWKAHyk";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3475610EA99
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 17:43:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791567799; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=g3lMuIJlU5myjBeFh5StRCLz5OuShmhh2kujR0XJxKpacLwXUfjuTNkd/cw3J9t97El+u97tMfwSPmOHV3JzDowzCbWseNOlaZeI1QyTKNLu3zPkHkL9lVa9iI3cPpP0lQvVQeOs1f/qds/FoukeV9kaXwOmkltaGO8O6ZJ07s4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791567799;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=2USrELN0j9xjAwY+/mGGtPdliAWR0A+x4t3JgPpnkkc=; 
 b=T2SqrsCVVbzz0caauPWDtySNc788Z7nLCbAaPagojusYfSU1vZtTgppqhRmqlNOb8WqAtA6NJit30HDyhZ3enS9RHPl4pRFWiTHs07GfCBS3EycV5BTc2i63PkvxzVzrOBj2Sp18XEJtY9/pECb/YsI5V8PVi+QBxZWpFtLTFMM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791567799; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=2USrELN0j9xjAwY+/mGGtPdliAWR0A+x4t3JgPpnkkc=;
 b=IcWKAHykQ90adxjIX4R8u1h3dhdvXqpxsc7KWIaOIA9o6v8qjlvqTnAJEyosBRfT
 NMFlgtITRsQwZVQyLRPRJfFhzPm/HM2kVT3Rn0lBaZr4gIGvrNG6FLYLd81sqjyC6uG
 Oa865Z1qL+ug4uohLwJm/jVxA4jDbGWcB6NqDtXY=
Received: by smtp.zohomail.com with SMTPS id 1791567797840227.23013293258816; 
 Fri, 9 Oct 2026 10:43:17 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH 4/7] rust: fs: add iminor() helper
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260814230923.1292966-5-dakr@kernel.org>
Date: Fri, 9 Oct 2026 14:43:01 -0300
Cc: aliceryhl@google.com, acourbot@nvidia.com, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 tamird@kernel.org, work@onurozkan.dev, brauner@kernel.org,
 lyude@redhat.com, j@jananu.net, alvin.sun@linux.dev,
 deborah.brouwer@collabora.com, laura.nao@collabora.com,
 beata.michalska@arm.com, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6395D58C-F3CC-4B2E-8B20-6EEEB92070DC@collabora.com>
References: <20260814230923.1292966-1-dakr@kernel.org>
 <20260814230923.1292966-5-dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
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



> On 14 Aug 2026, at 20:09, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> Add a Rust helper for iminor(), which extracts the minor number from a
> struct inode. This is a static inline function in the C headers, so
> bindgen does not generate a binding for it.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
> rust/helpers/fs.c | 5 +++++
> 1 file changed, 5 insertions(+)
>=20
> diff --git a/rust/helpers/fs.c b/rust/helpers/fs.c
> index 789d60fb8908..d6f9782db178 100644
> --- a/rust/helpers/fs.c
> +++ b/rust/helpers/fs.c
> @@ -10,3 +10,8 @@ __rust_helper struct file =
*rust_helper_get_file(struct file *f)
> {
> return get_file(f);
> }
> +
> +__rust_helper unsigned int rust_helper_iminor(const struct inode =
*inode)
> +{
> + return iminor(inode);
> +}
> --=20
> 2.55.0
>=20
>=20


Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=
