Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C268CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 20:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7898110E5E5;
	Thu, 28 May 2026 20:48:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jOyHkSwV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C2A510E5E5;
 Thu, 28 May 2026 20:48:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5EAF643F33;
 Thu, 28 May 2026 20:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4330F1F000E9;
 Thu, 28 May 2026 20:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780001303;
 bh=FpQud1RDgcM36CY4JFAfny+s7huVK65jhoq2kaa9jkQ=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=jOyHkSwVCO70aJ4Ov/94NwYVAy9n5PAM8hPSejYwgQIExxEYZNmEbWq7U0TWFEOdd
 K32gMY1WhKQA+DvPEHgopFQc3JP2M0ykroQ8dB0Wj86HuT08+iBhBvGvOy6koG2EiL
 DAlnC/FvXx6253dt5qhslZ/cqwceHP6v9WSIOucB4rLfmQRgw2v3HNmZ3+Sel8rOKu
 4umK7DtSkJPOLDgbPSa2qf1l2CLC/senmm3oCzL/LnF3rc+Ia/ky6LhbxeiBBKDOiq
 XDkoqqzaDzTE9xot3M3lN5ra9OrYN06Od/8WTxSA2lvsltKIzq50/WZUHYTy14vgHf
 FBmncuzlJWGBA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 22:48:18 +0200
Message-Id: <DIULSRTZPQ0H.39RB5RF1NTFYA@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 0/5] Revert cleanups for IS_ERR_OR_NULL() usage
Cc: "lyude@redhat.com" <lyude@redhat.com>, "rongqianfeng@vivo.com"
 <rongqianfeng@vivo.com>, "airlied@gmail.com" <airlied@gmail.com>,
 "kees@kernel.org" <kees@kernel.org>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Zhi
 Wang" <zhiw@nvidia.com>, "nouveau@lists.freedesktop.org"
 <nouveau@lists.freedesktop.org>, "airlied@redhat.com" <airlied@redhat.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "zenghongling@kylinos.cn" <zenghongling@kylinos.cn>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "mripard@kernel.org" <mripard@kernel.org>
To: "Timur Tabi" <ttabi@nvidia.com>, "Hongling Zeng" <zenghongling@kylinos.cn>
References: <20260528192847.4077458-1-lyude@redhat.com>
 <DIUKG7F2VAC7.17L4VHNNI7YL2@kernel.org>
 <4f4b7a4a89a253e515b009ccfa7ddfd21853b64d.camel@nvidia.com>
In-Reply-To: <4f4b7a4a89a253e515b009ccfa7ddfd21853b64d.camel@nvidia.com>
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

On Thu May 28, 2026 at 10:23 PM CEST, Timur Tabi wrote:
> On Thu, 2026-05-28 at 21:44 +0200, Danilo Krummrich wrote:
>>=20
>> @Timur: I do think cleaning this up is the right call in general though,=
 and I
>> also don't think that the whole driver necessarily needs to be consisten=
t on
>> whether IS_ERR_OR_NULL() or IS_ERR() is used -- it depends on the contex=
t
>> (although I usually prefer not to mix up NULL and ERR semantics in the f=
irst
>> place).
>>=20
>> It should however be consistent in terms of what functions can actually =
return.
>>=20
>> 	ret =3D foo();
>> 	if (IS_ERR_OR_NULL(ret))
>> 		return ret;
>>=20
>> If foo() can never return NULL, the above is misleading, as it puts an
>> obligation on the caller to somehow handle the NULL case and come up wit=
h an
>> actual error code for it.
>
> Sure, I get that.  My point is that it's often not clear whether foo() ac=
tually can never return
> NULL. =20
>
> It's been a while since I've dug through the RPC call chains in Nouveau, =
so my memory is a little
> hazy here.  I do remember noticing that Nouveau frequently has situations=
 where foo() call bar1()
> and bar2(), where bar1() can return NULL but bar2() can't.  So the questi=
on is not whether foo() can
> return NULL, it's whether bar1() should not return NULL, or whether bar2(=
) should.

If there are multiple, it has to be the superset of course.

>> So, I think it is the right call to align that to what functions can act=
ually
>> return, but while doing this, the contract should be properly documented=
, such
>> that subsequent changes can be properly validated.
>
> "Properly documented" and "Nouveau" are not two things that go together.

Unfortunately -- but the changes submitted by Hongling can add the document=
ation
for the places that are touched.

@Hongling, can you consider this in a v2 please?

Thanks,
Danilo
