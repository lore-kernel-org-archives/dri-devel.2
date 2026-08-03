Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BBAC5518F
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B02E610E4B8;
	Mon,  3 Aug 2026 09:01:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="QQQ6x44B";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F04A810E4B8
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 09:01:18 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47fdcdfceb6so738691f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 02:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785747677; x=1786352477; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7c8ajU7Bc5fO7IMCQU0cwsLx5uJDTGm1qTHU9/J8vs4=;
 b=QQQ6x44Bhprv2zcZ/ksibi0Bdu314tl5FJUNTEu8VKtwuIkOAD1nom6jJ+ak6mfQzW
 yXlKLoiNeGvAvi75GavjSz/DiMUerJAC/fvbRw5d7EfegkocomT8j6moQp/z7BmtKoc1
 XsaBVjckn8dGPqpuRo3cbiWG4cMdx/WQvwVpiCgLTJfsxcNoVpvcEydfNGNjswMiMr0s
 gcsST6CIM4z5ZBAqt+aPRfL6azoEoa3hnWjzhlOG8sUGduaG0ae4K6+J9N+moHjOIhm9
 2IWlu7bCihqZ7ypMtG1XzA+c8XynFqk7AYc6zNUZGOi6wXXagLUvz5izO28+bADcoeNk
 4Z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785747677; x=1786352477;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7c8ajU7Bc5fO7IMCQU0cwsLx5uJDTGm1qTHU9/J8vs4=;
 b=aJVJ+JAWbxFTbkNGjyJkCRMzcmxT+OyPG1SSWOoCSqTStOCWgsE0mMopcLN6R/5Wol
 jFMMLsQbjSG3LNBiB8t0/x4wMBmb9bCEvgvSh67qr9gOAJZP7KswTkStbQpfauZhQg78
 ExXynAj/XJ8X94QmwkalpMnH7uWVF2Or1av66dh3mSQJAsmPEQ/T6fwMGWb96oCmgQP8
 DhjE27y+Wx47ORD81LmDqrrFgWszmmeAXl+fDoy3USHCJ0fyTuCkCh0vypmGeV9N1mb1
 qamjXfDwnEsXo9G2zmMAioFnxbHeXWdIKP8jzNc0XK7QpAIvusovLhk8oHhSFBujK3B+
 ABCQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoDqE7+n3amG8MqoUy47d1vAkHN9JmBDmNdj8YVK9hIjyMHZy6Ud3BEY5gWb1OJIdiq4e50tP94RvQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxqlFhzk0+MpLY/M7kg6XVw2MJToWiz1tJa61kFtDZPJ+H4EQ4r
 HBThO+nvTUiw3G73pMzq6O0EtQqcmmBiFeDmdjjL0vWP3/Vpon1EHj/ZiQaVbP42eSw=
X-Gm-Gg: AR+sD13jhhrHJiqnbdImQ3slu6lLKaVe0t2Cvam9xIgEziqR1bI8mWxhMO40DXtXfxj
 zzsfK81WuQMPLoXcriNjXabN/bo97HXywJTG1z1XhLHEs79vcprNl2Ic/1hSQPWpDdc0cU2KKzA
 Hi3GguDsPjQq6fKyLgWHrb1p24FnsZcVPL3PvMaxi5uhhjc4Errnjw2vcuBES9audyjE8rZ2R3x
 PVuc0eSLJYk2Cv1zIjEk1xrFsme7sDXLg98gp6L+2EQ4F30UdIKzsgPopgYUW9UY31/GJuBgfEd
 ESHtSxVyd9Delxny1ctMNx27axYeKDMu1JiOpU5hsdBSJ5JDwzQ6+DL9GshVqh/d6vNkpnYRdQ4
 cbqnUKh1v1yRNBgVUzJ7C82d/GJWLR10mEWA+E+aWzKRvm5QALH90hqK6hpQi9HzyRSUb2idCDy
 3aqQzVua/3QGNuv9nfnjxq4aXXPrq/u9sXjXfhQ645i1CL1ObSxiCczNBEIrPJ2JPSjYP3epNb5
 2igakcB4H0V84WmPff/ERx+Bwo9xja4E/RgaJvLs6nbWAYNt3aVAeAUyweWQ8TIcZbrv7jOovcX
 dJrnrUvPgjReDp8pHMdQad/EEV7/+xY=
X-Received: by 2002:a05:6000:481c:b0:47f:8ac0:ccd3 with SMTP id
 ffacd0b85a97d-47fd9fa5e61mr20758749f8f.2.1785747677195; 
 Mon, 03 Aug 2026 02:01:17 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100?
 (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz.
 [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd458b73asm29125053f8f.29.2026.08.03.02.01.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 02:01:16 -0700 (PDT)
Message-ID: <7b24e554-0f13-40fb-bc04-dd64cdb93528@suse.com>
Date: Mon, 3 Aug 2026 11:01:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/10] rust: macros: remove `THIS_MODULE` static from
 `module!`
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann
 <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Igor Korotin <igor.korotin@linux.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>,
 Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org,
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev>
 <20260723-fix-fops-owner-v9-9-c1c3af7f7bcb@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260723-fix-fops-owner-v9-9-c1c3af7f7bcb@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 7/23/26 4:10 AM, Alvin Sun wrote:
> All users have been migrated to `ModuleMetadata::THIS_MODULE` const or
> `this_module::<LocalModule>()` helper. The `static THIS_MODULE`
> generated by the `module!` macro is no longer referenced anywhere,
> so remove it to avoid having two sources of the same `ThisModule`
> pointer.
> 
> Assisted-by: opencode:glm-5.2
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Acked-by: Petr Pavlu <petr.pavlu@suse.com>

> ---
>  rust/macros/module.rs | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index aa9a618d5d19e..23b6a1b456b80 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -497,22 +497,6 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
>          /// Used by the printing macros, e.g. [`info!`].
>          const __LOG_PREFIX: &[u8] = #name_cstr.to_bytes_with_nul();
>  
> -        // SAFETY: `__this_module` is constructed by the kernel at load time and will not be
> -        // freed until the module is unloaded.
> -        #[cfg(MODULE)]
> -        static THIS_MODULE: ::kernel::ThisModule = unsafe {
> -            extern "C" {
> -                static __this_module: ::kernel::types::Opaque<::kernel::bindings::module>;
> -            };
> -
> -            ::kernel::ThisModule::from_ptr(__this_module.get())
> -        };
> -
> -        #[cfg(not(MODULE))]
> -        static THIS_MODULE: ::kernel::ThisModule = unsafe {
> -            ::kernel::ThisModule::from_ptr(::core::ptr::null_mut())
> -        };
> -
>          /// The `LocalModule` type is the type of the module created by `module!`,
>          /// `module_pci_driver!`, `module_platform_driver!`, etc.
>          type LocalModule = #type_;
> 

