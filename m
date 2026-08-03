Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFF8C55175
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF3CF10E4BD;
	Mon,  3 Aug 2026 09:10:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="FwXtdH3K";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8672410E4BD
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 09:10:06 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47fe2d179e2so367163f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 02:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785748205; x=1786353005; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Z1GNJHA/wk3B/tLgEj5BiBlQSmADQEGBijFgHvx9KdQ=;
 b=FwXtdH3KQUtBj32mW1j/RbMIN7p2ywsanwKWU7TADvtPd3FL4835Bwl+InRS4jpe8h
 yDyG0cmpL/C2g/YKsVniaO5TU/+ifo4vdJrGHQeEbaI1ySkbOl/5ZGwTP2DnCMOcec0c
 5pnFY86oiGXU7rKs/dkonBTy/tTr8sm1k0EKPK+ofWHH5KTw1s74e+GFGbfnK0wu9Q9L
 uE38TcVNiuyDxifQ86FYgmZuFWzMT0GlQZG1pacCyMmJoch1xmtJesW0QmNT5/jdW93U
 pBkgYt77sUEgC+TJXyAmZ/t24ShmwiJ3moVkDALzyfgZ1SD6OYOLTyu5VaelkfA4xgPK
 dUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785748205; x=1786353005;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z1GNJHA/wk3B/tLgEj5BiBlQSmADQEGBijFgHvx9KdQ=;
 b=Gb6vqoMQsbj1hFrPbSZg7O/JQcCyA8qQLBUR5LXIpiGBW1GD4caKGuhyIbJB6M4Uk9
 Rjtz1JWfcnLTFQqZaxBG8Wt03YBgBW7LYab/KZYPUL9fCK1uMHTnn2SFSbJ5Ys2RKKQ6
 vj5fAJCAFadfb3fdc2Qd8GQkBkokZJttpjHyDxn6CYt6EU+Ac7o5TiicHeGqilcDANz+
 0TG+QN/apMntoZmZh3Ix27ukWC8us7emqVtguq0YPTKsnGl2/1EAU5swN2RcOS4J+CHN
 A4VY8JhiPZSZG5vQ84FVNYiC/aKVH3V5pE9DA4OoQzIWCfyAAEjjYlVEGdM2XGlhRyaR
 TmAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpyVEMKup6cpL2UkZC6WMc0Zo2qjQiu7QHvuXSKlYuyPt0t1TRT5JaoLih9u/kIRYIsuuLoR2K0UPA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhIWaDBbSzLSX8KtWd8xcDs/19hyka+UektiXM42/0HOeald6i
 vnKOjSJFO5wKxnHCFpzu2fS6d1orCXOBw5/bHiTNeq7BExMEbSo7qpbs42Z83cTy//w=
X-Gm-Gg: AR+sD11mtMdaZe7nMGNyd8tx5lMiY8Gy7PuWXXxtuuTN8Jg6J+BsMU32HFf0ArulL4l
 SlCqQv3a2tixE/EKpW6CUqJltAbbC3AzNRnYVE5JF4xYqQLTI0hsJn+rWJeiRRWm8+fRxgbjOXo
 qlvFlQk8JwmmkKOGFDQsLL8NzPlfOqrvaRkFh3qaDPx8GbTOXwJGwT05h4yB15KVvDbqyFIO1oW
 0wpTzvz/Y73Bi+Vsb04SJSxbndfTR0U150e1f/nJQKH1go9uULVD8ZUceMEDToWVkYKvovCPlR+
 90vgMvOPYBSbYUWKYzCiMkYFvZ4rZr9rnverJtePRW6TxpOAsITsTdiWsSHhDe4U1vuDfPMcJxp
 uGb+bul34pNQuDeG0Wz49ce3X7zc4ZFqT5my88m1WAtS6vL6hSnzQ8/s4SCt62qFduQhTN8/mzK
 RMGs6FV7iHQSUD7I0KoR+maQ2OXICOI5j8bp2sVhcQuHy3hmAL3f1uyXmHVKvXecdngzfM+K3cd
 jsKsXPKHIh4RHxBfkBv4sdbD/mNtRqhPpQfLnyDr3LTcfGrbS/QeQcjLx9kwUJM3M+Jq6EYMSvq
 hfm2A5wj9K2/7EAN/BFEcGispsV7NYo=
X-Received: by 2002:a5d:46c1:0:b0:47f:8b9e:f457 with SMTP id
 ffacd0b85a97d-47fd72b0552mr16078486f8f.17.1785748204889; 
 Mon, 03 Aug 2026 02:10:04 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100?
 (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz.
 [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd456a6cbsm28027816f8f.23.2026.08.03.02.10.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 02:10:04 -0700 (PDT)
Message-ID: <e8733203-29e9-4a3f-b41c-198dcf1d5273@suse.com>
Date: Mon, 3 Aug 2026 11:10:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/10] Fix missing fops.owner in Rust DRM/misc
 abstractions
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
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
 Carlos Llamas <cmllamas@google.com>
References: <20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev>
 <a9dde63a-5f2d-494b-95dd-7567879de38d@linux.dev>
 <CANiq72kkuKsRAF-r+2OyZbjjgvC+jvqMSXR=LgmqTNRaWQZ-nw@mail.gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <CANiq72kkuKsRAF-r+2OyZbjjgvC+jvqMSXR=LgmqTNRaWQZ-nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 7/31/26 8:29 AM, Miguel Ojeda wrote:
> On Tue, Jul 28, 2026 at 10:39 AM Alvin Sun <alvin.sun@linux.dev> wrote:
>>
>> Back in v3, Gary suggested this series go via the rust tree.
>> Would you be happy with that, or would you prefer a different
>> path? If so, is there anything else needed from my side?
> 
> That is fine with me, but let's see what the modules maintainers think...
> 
> Luis, Petr, Daniel, Sami: what would you like to do? This touches your
> entry, so it would be nice to know what your thoughts are /
> Acked-by's.
Looks good to me. I've replied with Acked-bys for the relevant patches.

-- 
Thanks,
Petr
