Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3873AC624D6
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 22:08:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69C0D10F7D2;
	Thu,  3 Sep 2026 22:08:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="QCocL3ny";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F24F710F7D2
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 22:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788473327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mSmQPXj8inEoKBdqECUOM+0RiHNGnxlFvDmP/jJyOY4=;
 b=QCocL3nyAH2b1ro3rWEPTufPjJl67zKNOcdu5O3vbpvGoR3+lX0NFssthQPFmNzTTr9pAO
 s1dKwdzErZjTHjvY0mOdRT1gEf2IqRZGvmzfA4oT2XFcnWnac/fcEFhEU1u9Xb4TWklI0Z
 BOWpakdVAjKdr14Xh3SCVM9oDu2vc+c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-4i8gOtneOTW5WqZMYC4ovA-1; Thu, 03 Sep 2026 18:08:46 -0400
X-MC-Unique: 4i8gOtneOTW5WqZMYC4ovA-1
X-Mimecast-MFC-AGG-ID: 4i8gOtneOTW5WqZMYC4ovA_1788473325
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-482db84a6eeso288979f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 15:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788473325; x=1789078125;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mSmQPXj8inEoKBdqECUOM+0RiHNGnxlFvDmP/jJyOY4=;
 b=KWx9pGXQGp4vwevunoHLbiEu3KVMAQPSqhkUc8uB5D4c10uECPdxHd6VHYtal65Ub2
 FyGNHBADA1xvDrPNAQBqU2iFzkwU2TnfLmL/zrclBgwvrKgLg2Ou6EWO4ml4I8X6e0wE
 wPtnfX1QplT6hkaGyA/AB6zFnlHhgLByap06zGPqTtuomV1e5CyWXmaBlWVzU+TGjx4u
 RTjWFNs4VTzsle3dR75lQapAZ4w1Nk+ushK+EMUDh6zfZHb5GQYZ1VDP7bsoz4p7Axz2
 6CfCP1SU7KCeYGbmldFvXv8R6Xv5PzZD3cSWPMOEyIO9S0v7EJcn4Oz5D5AuDEL0Rp1o
 UTCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZXKbhELzKIM/AoYWPr3gcJOHvmIV2xJO+uNjcBbR6QyMqg7apNkLw9qJLGL5uVHilFMIrplLG5fQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kX2QnMdfnGdq/ooN1OsdeAqrNENhFRS2D2A+Z9BzFZNLRNuZ7n
 jKONTU8zHGwxpPUqG8vuEHRypgQXUzjAC+R/C0HHjYWGT4jFT/kn5tuOugNEy50K3itE9MOgPbJ
 IIvXrClgYjvQKRstONGuYnmqfKDm0aUReR0nOUAlwrei8zz+a+4+s0aYf+rBzQVFMhlUjJw==
X-Gm-Gg: AYBFou14O8StbbUZaFId9fhO2EGDXxqLyygd6LUvoNhB8We1I1KOY4fbByKk+2IIAOw
 DmStLYv72zUHtbx84Pqx3ryQ1gFgk/kONNiVjRoieWetf2sgT4L9mz4536dHvCj5eIh40Jyfxi+
 y54+hHRnKzzWH1DD6CmmtAVXFI++lL9IkIppRc3+qx3SmytkUEM54flAqGZ09f4TLoDz8sw96Qn
 rqpkAcqSHtvYvJwkeZZMm1jqasXPG02sWPBPbQMSxCTR58b2lWFLVt5etw4AfGq5Y3b1YFjzCvx
 2YiRLmzfQ0jdkb5uCjPGjgn3r9zbyWocu+qi3dVDLu/hcrve0GdGsJQWSilFKOeaO1wOIMq3tUO
 ++Bw1bdHVC9tSVF3SNlpPsEN5pJNnsDLzCpAkM7gQSb9Kuw==
X-Received: by 2002:a05:6000:2c10:b0:485:4275:f207 with SMTP id
 ffacd0b85a97d-48587099a2dmr2766265f8f.24.1788473324918; 
 Thu, 03 Sep 2026 15:08:44 -0700 (PDT)
X-Received: by 2002:a05:6000:2c10:b0:485:4275:f207 with SMTP id
 ffacd0b85a97d-48587099a2dmr2766223f8f.24.1788473324542; 
 Thu, 03 Sep 2026 15:08:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:11aa:87f0:935:4f8e:b423:64eb?
 ([2a01:e0a:11aa:87f0:935:4f8e:b423:64eb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858791bddasm1786219f8f.0.2026.09.03.15.08.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 15:08:43 -0700 (PDT)
Message-ID: <101089d2-96ca-4a0a-bea0-6e936beebadb@redhat.com>
Date: Fri, 4 Sep 2026 00:08:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panic: clean new `clippy::needless_range_loop` lint
 for Rust 1.100.0
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 stable@vger.kernel.org
References: <20260826145642.43807-1-ojeda@kernel.org>
 <CANiq72=TjVOxDj631gCFMKAeXYbjycmZe74ChXL=rw4H53pQzA@mail.gmail.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <CANiq72=TjVOxDj631gCFMKAeXYbjycmZe74ChXL=rw4H53pQzA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rhQsqKt-am1XTKpx8UlLZ18YsrVD269jg152tQXyYsE_1788473325
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 31/08/2026 19:54, Miguel Ojeda wrote:
> On Wed, Aug 26, 2026 at 4:56 PM Miguel Ojeda <ojeda@kernel.org> wrote:
>>
>> Starting with Rust 1.100.0 (expected 2026-11-12), Clippy warns:
>>
>>      warning: the loop variable `i` is only used to index `self.decimals`
>>         --> drivers/gpu/drm/drm_panic_qr.rs:410:18
>>          |
>>      410 |         for i in 0..len {
>>          |                  ^^^^^^
>>          |
>>      note: for this index operation
>>         --> drivers/gpu/drm/drm_panic_qr.rs:411:13
>>          |
>>      411 |             self.decimals[i] = (chunk % 10) as u8;
>>          |             ^^^^^^^^^^^^^^^^
>>          = help: for further information visit https://rust-lang.github.io/rust-clippy/main/index.html#needless_range_loop
>>          = note: `-W clippy::needless-range-loop` implied by `-W clippy::all`
>>          = help: to override `-W clippy::all` add `#[allow(clippy::needless_range_loop)]`
>>      help: consider using an iterator
>>          |
>>      410 -         for i in 0..len {
>>      410 +         for <item> in self.decimals.iter_mut().take(len) {
>>          |
>>
>> The lint did not trigger here before because it could not handle arrays
>> behind a field access such as `self.decimals` -- Clippy was improved to
>> catch those cases [1][2].
>>
>> Thus clean the warning by iterating over a slice rather than using
>> `take()` so that an out-of-range `len` still triggers the same bounds
>> check as the indexed loop.
>>
>> Cc: stable@vger.kernel.org # Needed in 6.18.y and later.
>> Link: https://github.com/rust-lang/rust-clippy/issues/16631 [1]
>> Link: https://github.com/rust-lang/rust-clippy/pull/16634 [2]
>> Assisted-by: LLM
>> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
>> ---
>> One may want to keep the loop in a shape similar to e.g. the one above,
>> though.
> 
> Jocelyn: I will likely send another rust-fixes PR during this cycle,
> so I can put this one there if you agree with it.

Sorry for replying late.
That looks good to me, and you can take this patch in the rust-fixes tree.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Thanks!
> 
> Cheers,
> Miguel
> 

