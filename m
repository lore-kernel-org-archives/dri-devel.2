Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16A7C55175
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 08:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4133410E4A5;
	Mon,  3 Aug 2026 08:54:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="XzQNl4JR";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C88610E4A5
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 08:54:17 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-495635a85d2so17040385e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 01:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785747256; x=1786352056; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EPO+ED0ot3Taa08GbV6IzKrIjqgkBaW3P1eEmTzgiUE=;
 b=XzQNl4JRe5IaHLHUWNRz7bMqIh0vYFSJLWtJUft6kfNy7KdzOpZDbKrMttzXaBXlNN
 SzqocATfpxwYQAgTGRROAUJreSndcuehc1S1HF7gt5YwBXpTxGSXkWs1W2vYRvZ5g6mA
 Ny8pmV6dZOYleTLEIHeFHZuSsw7zDLRRoabmjoWNvOr4UDYY482MknlpOMgx1hC/Xk8Q
 aN1JaLz4uyvARnvn3rxiNfQ53dKnQUCGNpxgIwbUxxpUQ4CWb9sl6aDK0tL7wiKTaVFJ
 jFRTRfeu7TEY8p0ihdYLTL0XcO3QsKajM1fO8lMlI2CfsCvpIip7U7JjjvLjxMI5m3r8
 dsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785747256; x=1786352056;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EPO+ED0ot3Taa08GbV6IzKrIjqgkBaW3P1eEmTzgiUE=;
 b=DTRMpQd6kihlKFW9roex5WpNumGfmtCwLwByEXs7gZAMVaPCwzjzWggzbzKsOYz3z/
 pgZs4ZI+9jdVZxOeLjqS+Vn31V0oF17vtw0B2qtxKeDfSstqn5C+qP9Owqv6NGdx3pvu
 lf7O7RjYbJdkks0kZI6q4hA+H9yM5fihksRK06MoX7+tkiD43uksxunqtouM1yQVvY39
 1xXFRxfP5jWdN8fTkDSMG8W2Pjfg8/BibJeie9qlt6MkHBPxHXaW7brt+0LLlul+c3yR
 kj3U6z34EE8G8SSw0vFP4aw3L92+WhjiOugJBaZSud51gN1V6aWabv5G3uPx04BuF6Ch
 rAYw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqDAlpcZOeBaOmXRODUkhHz7p3SLEDdA5s+m9oxSSf4M9AXH3hPvSKQdyFgByRZs2GDB0kH7V4iq1w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxj4sdYN5bq6bAjm5KSB/wLkm3jgmGiMRnWNmEWxsHDWJTUhR1c
 PVxMZ7UZsJvvW4+6ez1DjOz+uUn5FCHt6UWG8mQcodie9bk4Y5MtAh8/1OLkqoyjxfU=
X-Gm-Gg: AR+sD10IKyS09u+66OLLOeW36sU+sgeszlX8cPqZ1T3LsbAPiK/MIEOp0BDh5A1+yv8
 q5+w28wfVKeWF6wmBGk1qFB1OatSRB3Rl0dQ8pB37tNBHyBXwg+iC3xuyIqw1Ra5GvQ2NqpBcm6
 IDJb3PHyU5BEGb2xssPULJAgwbQeXPlaRsEq2ofa1RNxqSWiEie4H2Bw4y73ATySMkP5gfh9jsI
 uzjZvIDeu8AkXrVPNONBRawYZHhI4llkzYtA6PxaTvoJYO7DzgkQrj0zrWNf/5GH+LsSqGT41LA
 VNUurf5EXRL8Er73VS/HVmVRqPJaH3FuX3Zsa+ZzfeK+7R5bqegwPt761yDfWgLIrSS65uEG7mm
 4jNlgPJ7WtkcVAF0him6I2qzk3lhyR5DqFjWZVv93Os4iflUrAD66K+rrwUqrLXrZTw+Aolsn77
 50NmnYegZaRzOLGJVfnIKXF6WootL5sIjQAd+ZXM2sTOBUcWtZ1SEbu0oIdA9T2P79Inc57jqps
 4nRAhBKzgszEn5WsL5AxBY8NJuPfvGxcY1gKVeRKQIWuHYdMVXzYdgShy4808Pb6eA8cUeDNr+I
 v0Xy52Ma7fTIENuDuZ3LOTHVr68Nqla4PiEnNZFwYw==
X-Received: by 2002:a05:600c:5914:b0:495:5cda:52ec with SMTP id
 5b1f17b1804b1-4980c662d03mr170527905e9.16.1785747255995; 
 Mon, 03 Aug 2026 01:54:15 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100?
 (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz.
 [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b7afe6sm200011075e9.0.2026.08.03.01.54.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 01:54:15 -0700 (PDT)
Message-ID: <a6a83aae-2f51-428e-8e38-e6a36f095f13@suse.com>
Date: Mon, 3 Aug 2026 10:54:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/10] rust: module: update MAINTAINERS to cover
 module.rs
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
 <20260723-fix-fops-owner-v9-10-c1c3af7f7bcb@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260723-fix-fops-owner-v9-10-c1c3af7f7bcb@linux.dev>
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
> Module types now live in `rust/kernel/module.rs` alongside
> `rust/kernel/module_param.rs`. Update the MODULE SUPPORT file pattern
> from `rust/kernel/module_param.rs` to `rust/kernel/module*.rs` so both
> files are covered.
> 
> Cc: Petr Pavlu <petr.pavlu@suse.com>
> Assisted-by: opencode:glm-5.2
> Link: https://lore.kernel.org/rust-for-linux/8ea21b29-9baf-4926-a16f-7d21c5a1a1b8@suse.com
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Acked-by: Petr Pavlu <petr.pavlu@suse.com>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e035a3be797c4..74733de3e41ee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17984,7 +17984,7 @@ F:	include/linux/module*.h
>  F:	kernel/module/
>  F:	lib/test_kmod.c
>  F:	lib/tests/module/
> -F:	rust/kernel/module_param.rs
> +F:	rust/kernel/module*.rs
>  F:	rust/macros/module.rs
>  F:	scripts/module*
>  F:	tools/testing/selftests/kmod/
> 
