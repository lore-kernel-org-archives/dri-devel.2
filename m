Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8FFCDE001
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73AAD10EDCD;
	Wed, 24 Jun 2026 07:47:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XrmofrhZ";
	dkim-atps=neutral
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD09210EB11
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 12:50:46 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-519f9f13b06so38482041cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 05:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782219046; x=1782823846; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dGj3g1KCk+kZNll4UB6dOm+IXncrIJjrxvMy5Ft1TB0=;
 b=XrmofrhZ4gVMIbg/DezkWIXnhux5W02qwmmYbDYBaqbTb9srgmfM6X1h/PXAxgPk8E
 dIMp9Nmtip2JtTjcakpsN8rJe1+4lh5bcNHkVco6PJWp5It4xg1JIPVi8U12G0EGQalP
 7yIRjFoMD3KDE1/xtr76XYHb/fncMYSKEHsEq+BlrzalI0rVf3/JdFIAabQQ3QC3Yacr
 P+emp/c5ioDDqJiEcHYaO/0Ph9B6h5JAnYmsgvXe2FvZ5eN6DZ1Bv7r4hdTPWuerrERu
 Hmy6i12j5KvXnr54A+1OupoW8igdIJimc+H38ZiMRJEdnHo1lLdhm7LATPHB2XCX0y3h
 3ffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782219046; x=1782823846;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dGj3g1KCk+kZNll4UB6dOm+IXncrIJjrxvMy5Ft1TB0=;
 b=lN/4/OyP4l0BQM1HdG4vN3HfuW23NCOWs6mpwsQ9JJhlsz6zamrUKU7YKb/MzPJmcK
 vC/l28nART7LfukkbMtxtYw9QXTPidqbZTOvLsomVp/MpctZ9UZYU0UIBYs0euXXN8NL
 VYZeSG7fOAOSLTkKSxo6jK7uTr84Tc9h9wpff3WMjotWaNszSBlVhEXNCFqVKBSywxKR
 j5VaeHTnuFuTmyQu6ey9oBF7QxyDPOSeIdW093KN7CImW89ZmARHAao2MNWj9I0n1DZm
 C0KLUyo5VDE/JUQGEbBf0BFtI322doU5eZGhkDiaTmmEFeB/Tw0N7TF98AnqtrNAFt+G
 Ej5w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Ux0EU7eIOm6QrQg5nlKmUykhVTlekRXvW+Hoc1y3B4KgEb9cr9f+5z7W7eizTt1EIyfv9kkYh3ds=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz9ozQHjgSBG8ygMFqare6jdAQ/8Wg+JIt4u9loUf7WiaZ0mY1z
 DBdaW9qS4t8chIQKbnUJLFlnwR2S4g4aJGQKQDA7Y8/lxaC8jqKHLlM=
X-Gm-Gg: AfdE7cnVgTzZ9uulu6tB1hpANbHpFfE44twP0XQp7YlPCE4goL11NV72VGPqHBodX+X
 7DgBmmTJBbCeO98/23M8Bqt3iqQfD23wQhNXUWa5VhzEDmPZn36d04ZYe+tZ4++2W65jBNaOfpR
 H+Q7mbA3mGmlyypirL+5P6g3nBEc7sSRZSc9rISjMDa4Y3MsVXIbR+XnrX4YbGyWNGaGDPnD01y
 6Lmk5e+IZ8fG/IZ/iMemxJTkBnqQVTw/TmfiOco8mUUz+hqgQ9l8oiED2LVQrGTHdGY6qbuB7OW
 gzQycdzBNHtWQojq+tTGzYk4j9bAQ+CIOjmaEgVPiS7kti9C2fTNPaRUqTDdM6sDbclmQH3bFkI
 UcXYv8twGYAjuf4FSBAo4vMERJm7BofaZkvxtRE8FquFdowjlapyd/DCevyuxmVkn6dE56RV8dY
 KA0DJAOZ/KMK0wWJAfFgbuDRyX49DClcY1dRjzrCauwSRLfq2Q
X-Received: by 2002:a05:622a:408d:b0:517:917d:e3d7 with SMTP id
 d75a77b69052e-51a54807d1fmr37051071cf.28.1782219045378; 
 Tue, 23 Jun 2026 05:50:45 -0700 (PDT)
Received: from localhost ([186.158.238.108]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a51106a09sm22340861cf.0.2026.06.23.05.50.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 05:50:44 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 09:50:38 -0300
Message-Id: <DJGFX7B3FJJP.3CI7CU0US8FYB@gmail.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "David Airlie"
 <airlied@gmail.com>, "Shuah Khan" <skhan@linuxfoundation.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Tamir Duberstein"
 <tamird@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <linux-kernel-mentees@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>
Subject: Re: [PATCH] gpu: nova-core: parse structs via zerocopy
From: =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>
To: "Alistair Popple" <apopple@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.20.0
References: <20260621143647.264770-1-nico.antinori.7@gmail.com>
 <ajjj1yyMcrCA8H19@nvdebian.thelocal> <DJFUZJYZHOT1.M74T83PJE8GM@gmail.com>
 <DJFVRMR67B0W.2AJBHU1PWDPFT@kernel.org>
 <ajnPpyQcirSDIZTu@nvdebian.thelocal>
In-Reply-To: <ajnPpyQcirSDIZTu@nvdebian.thelocal>
X-Mailman-Approved-At: Wed, 24 Jun 2026 07:47:57 +0000
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

On Mon Jun 22, 2026 at 9:23 PM -03, Alistair Popple wrote:
> On 2026-06-23 at 07:02 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
>> On Mon Jun 22, 2026 at 10:26 PM CEST, Nicol=C3=A1s Antinori wrote:
>> > I did my work on rust-next [1] because drm-rust-next does not have the
>> > zerocopy crate present yet [2]. linux-next contains both zerocopy [3]=
=20
>> > and the new users of transmute::FromBytes if I am not mistaken (BitTok=
en,
>> > PciRomHeader, and PmuLookupTableEntry), so I can make the changes ther=
e.
>>=20
>> The drm-rust tree is a bit special, as it remains open for contributions=
 even
>> after it has been tagged for inclusion into Linus's (including throughou=
t the
>> merge window). However, all changes staged in drm-rust-next are not goin=
g into
>> linux-next until -rc1 is released.
>>=20
>> IOW, until -rc1 is released this may or may not resolve all conflicts wi=
th
>> drm-rust-next. Once -rc1 is released, it is backmerged into drm-rust-nex=
t and
>> drm-rust-next is picked up by linux-next again.
>>=20
>> Usually all of this remains rather transparent to contributors, but you =
hit the
>> case of using a new feature introduced through another tree before drm-r=
ust-next
>> caught up with Linus's tree (which will happen next Sunday).
>>=20
>> Before drm-rust-next caught up, this patch can't be applied anyways, so =
all
>> good.
>>=20
>> > I am fairly new to kernel development, I apologize for the mix-up.
>>=20
>> No worries, you did nothing wrong; thanks for the contribution!
>
> Yes sorry if I gave the impression you did something wrong - this also to=
ok me
> a moment to untangle as an experienced contributor so perfectly understan=
dable.
> Appreciate your contribution and hope to see more of them in future.
>
>  - Alistair
>
>> - Danilo

Thank you both for the clarifications! I'll wait until the backmerge
into drm-rust-next happens, then I'll rebase this patch along with
the new conversions and send a v2.

Regards,
Nicol=C3=A1s
