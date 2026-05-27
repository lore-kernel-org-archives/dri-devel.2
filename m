Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11984CD5BD0
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 23:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CC8810EAAE;
	Wed, 27 May 2026 23:31:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W3wumaGx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3A9110EAAE;
 Wed, 27 May 2026 23:31:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0987860572;
 Wed, 27 May 2026 23:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FD31F000E9;
 Wed, 27 May 2026 23:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779924675;
 bh=dSZZq7uPVfBoy5o3jAkbQrEgiZOO9X8eE+ojA0svfFk=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=W3wumaGxANEj8FilKar/dxxHvEahPStKlSD4HI/03xH7HONvEw6vMYVwJ1EnTXY6U
 V9oBCZXiHKlZskm6pr7acWAuzz+F+RUM3idvM8YSImjswjuo4cuzh+138FplWZLVwi
 8DKXiwmK1rOkjPRwAA5JPbA7ZFfIdYSIg3x00k2FQZid3V+A+zkdtXOtCb28E/z3tv
 acOf0X+fxJX/fL/5e62arSRiDIFydfbkcfoLubf+0nAOmAr8fqrN87vWc1qhNncJvS
 rsz5tqvV3YbdqfCVX/Rhv+cQ6C67JvnqGQf/XdX5aa/G3oQfXnWLrZjgGvS+MVaeW9
 bri2B5pjMkPzQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 01:31:12 +0200
Message-Id: <DITUMY6K2IQX.17R1VUFJGBDAW@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 2/2] gpu: drm: tyr: use IoMem directly instead of Devres
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, <aliceryhl@google.com>,
 <daniel.almeida@collabora.com>, <boris.brezillon@collabora.com>,
 <gary@garyguo.net>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
References: <20260525230152.277820-1-dakr@kernel.org>
 <20260525230152.277820-3-dakr@kernel.org>
 <DIS9H75POYGW.EBC1MLW466RG@nvidia.com> <ahd4UoKVT4cM-pgA@um790>
In-Reply-To: <ahd4UoKVT4cM-pgA@um790>
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

On Thu May 28, 2026 at 1:03 AM CEST, Deborah Brouwer wrote:
> On Tue, May 26, 2026 at 11:43:38AM +0900, Eliot Courtney wrote:
>> On Tue May 26, 2026 at 8:01 AM JST, Danilo Krummrich wrote:
>> > @@ -40,9 +39,7 @@
>> >  pub(crate) struct GpuInfo(pub(crate) uapi::drm_panthor_gpu_info);
>> > =20
>> >  impl GpuInfo {
>> > -    pub(crate) fn new(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> =
Result<Self> {
>> > -        let io =3D (*iomem).access(dev)?;
>> > -
>> > +    pub(crate) fn new(io: &IoMem<'_>) -> Result<Self> {
>>=20
>> Perhaps a future patch can remove this now unnecessary looking Result in
>> the return type.
>
> Oh that's right now that we don't have: let io =3D (*iomem).access(dev)?
> we don't need the Result anymore.
>
> Danilo, I can add this fix to our fw-boot series which I'm preparing to s=
it
> on top of these changes.

I can send a v2, fix it up on apply when I get an ACK, have Alice fix it up=
 on
apply, or have it done in a follow-up as you offer -- just let me know. :)

>>=20
>> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
>>=20

