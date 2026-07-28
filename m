Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79905C54F52
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:30:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78E1110E9E6;
	Tue, 28 Jul 2026 19:30:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YmRIWNo4";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AC1F10E9E6
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 19:30:27 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2ceeee8c46bso373985ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 12:30:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785267027; cv=none;
 d=google.com; s=arc-20260327;
 b=kpsWJRxygCJPVxXLAtqnX+nz3wCYTroS6UjOmTEb0Py4GCcKCtmNiqErLFESSYE5TO
 UcCwO8CjG9NziPNf65lOz5brD9MCB5rn4lOGAQcY0VnL+mkRVV3krpgcRy8CwYsy6b+X
 oxif637VHNaJbFqCXCXLWcBGvYuqfmSJDz4gpYeSBhSD0DRa2RmduGf+A3r/aq0D3iYG
 AaoQrtEfQyj34G+P3u3kOoEA7a7LpX7eLvM0Gg1yhWQyMckB3ONHt2Ww1oj5uIaph9fI
 m7v5S2fERCpuIwmfdi6NBbc0XSzXta8FhV/7+jUzS9Daw69FCtEXhfqsEMo0edMaofak
 42Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YOlnY10tnr4QkKaIlxFYxTs9Lp19ftPVrjCjqbroCWQ=;
 fh=gR2ki9Roug6sMr8hGBtyCssRA5rRN4zMYgDxmqc2UfU=;
 b=MOu2wXCC3QyjW3SS68F+n1985eiymuBVo5J+DFrYZPAN3TczFi31i/lWxi3Tzqnr7J
 AwPYdB/AzcYLE9l1ECAzB61cdi98wRckBxne96+0Za2ogTQbvyJRa2ztS9N/6IPOFgF2
 mkm0mmeB6CyI4anj18AaEe/cSglv8vQBg3cbyRGmq8+Tm/zEIwEGaomK8iGV7amm3A4y
 /m/BYnRaQuO/gu5w7lLOa/Xvm+4FHQGExjQTVpWO28KCc6ATxlQ8ZlgWP57phyLgU3pF
 ab4SHzT3ockr5LP+WjHSNAeZNL1sSuapcdQSvdnagvv/bX6zz5kurz1z4VOgWPDoSrSq
 TyAw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785267027; x=1785871827; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YOlnY10tnr4QkKaIlxFYxTs9Lp19ftPVrjCjqbroCWQ=;
 b=YmRIWNo4QtgU3IxMq/DjNGXkjm29CRX2Hq4LtLDeJjN+cxZxnd7+j59SYy5wtBXUmr
 vEZ4gtBE4lBULTqMS5zUWdHkk+q8VFHgfnvMyf7IbNUOE3faUCxmvbQcBhhZL0iZQ3Wz
 FoF2lQFyBL0NjUzYuV2ZXtb2G2LGis/Ii0sY82wlaXdC2fwz0kxtvyJyL2enk9+tu6Q3
 cjQjTm1se25WqJqfH1RO28oOYMGVJQvFC0e/ZcgcDAmleDTh+nKN6QkPQ4PjOx6L7DsR
 88+Pwv7OKWFMUMV0QGDj/OlnQ7c2Cwjhcy2cJ4AzktYJM3+R2tNB6Q0K8yDhaBhkTiZO
 1fPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785267027; x=1785871827;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YOlnY10tnr4QkKaIlxFYxTs9Lp19ftPVrjCjqbroCWQ=;
 b=Bgwza2zby3ZCJeQ7L9hzEmOmfErx0BWAj5LfXwC7GlhF+xDRqFbN/OJllxBN1QAcWK
 N/cVhZkT5DDmzOhjTpDyMHZ7fXHF6BuZiYqYKLhG3oQP1v5dOwJMJ4/auPIijobR+u6M
 xsilBXZt+5EZHfsIaa/Tp2Gd/JrRb4SatliotmTai2B+7T1I8sYfrOTu1+6d8YhwSajK
 /KLx/uRXe6lU2yP57dZ3hav8VD5w9dmVXk65pkh6izMcDkYIUXqpHnEdTAEkMRduw73l
 nfx8zNmA2qy5mp+wEc4PlbhN9AYCQqJaRjR8dnyNUBQ1FGLIkr3+nyLNNA32uhmprpjW
 5Pbw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoL6neQp/hzAxLoQdHIiEOy+P9H8DCNgIVG2Wv1EwPFe6Z/T5BopRmxd2xi+yTOaYvQgnM6x9q7wno=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDdKf/eHtg2vNCdazy5Mjj7TkewsphtkxnjX6Ch3RELEmOcJje
 i+9BrE75Yel96d3YkS1Jp6V8nlu+S3twxBXZ+xTmRHBCFi6Na6/kVC0MBnG8DGcxYgRBeDBV7DT
 Q4+SfBnqgqaTtZyOTCxVxekobMCbGEvI=
X-Gm-Gg: AR+sD12Nn2R9bLeCSkYh0PapHKW8ek6P0f1B2SJ/UX8+7hRQbPGxOIdqfvU1W2DKeA2
 VaO/sPVBk+qDbbK1ViBVJlwmSlCZppj1eFmS/4GwdNaaS+cDEU+trVSBV8Yuv1hoB+SYSuiVcpd
 /Q9vBI6Jlnf9PmVC0GAjEM9yl0kSlxk+TNY7QqmfTu4u4b5IFG66vXG0cNregij9xClNf424d94
 sTnexyD/uFjchS/K5vimnRV8K7LgyjpDUheWZNHB+agqX8H8WQhVU80neGT44p9rRxwfkKUqZW2
 0/KFsS3YinPzt6Bjac89NATC2GRWl/Q96NqqjbgGZlVT1939Doi3PDXBt9s+0yfSzytWSDzcbZW
 8ZH4gV0eMMOMFWrVKYfbdhlojZa7ao3xw/o7rUMS4RqpfCAtp9UMinNmcOJ/y
X-Received: by 2002:a17:902:e88c:b0:2ca:de3:15eb with SMTP id
 d9443c01a7336-2d0157877cfmr34510465ad.0.1785267026639; Tue, 28 Jul 2026
 12:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-8-452d72b60262@garyguo.net>
 <DKA02Y5RE1YJ.2FGI97Z60X96R@nvidia.com>
 <DKA4Q5QUBUXM.1K6QS2QPXT12H@garyguo.net>
 <DKAASRCK3M06.G9XODK0T5AAK@nvidia.com>
 <DKAD64Q7CEQD.Z15OS6MRHEKE@kernel.org>
 <DKAEZ4LDA10F.1RFA9JKBGY2CF@garyguo.net>
 <DKAFMD8X5LFP.UPKPHK5FYZPH@kernel.org> <DKAFRETW93IW.SXUWFVB47V3B@garyguo.net>
In-Reply-To: <DKAFRETW93IW.SXUWFVB47V3B@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 28 Jul 2026 21:30:14 +0200
X-Gm-Features: AUfX_my7ge7MYUh2zUi3Gt3zgCDTbiWd0Gi_L5P50g4KhlbsBg8SdJA5xeWd3II
Message-ID: <CANiq72kqRh=ucvE8ibPmesyrWdLnwbOwcsmTx2A0iD34DdUsVA@mail.gmail.com>
Subject: Re: [PATCH 08/10] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jul 28, 2026 at 9:03=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> It'd be a compiler bug if const folding is expected to happen, the whole
> BUILD_BUG_ON depends on it working.
>
> `build_assert!` is a useful tool that I'm not giving up. If there is a ne=
ed to
> use it, then I'd use it compared to having two variants to do the same th=
ing
> with different syntax.

Yeah, and on this topic, the overall concept is being discussed in the
C standard committee due to paper:

  N3846 2026/03/10 Grant, compile_assert =E2=80=93 optimization-enforced
conditions at compile time
  https://www.open-std.org/jtc1/sc22/WG14/www/docs/n3846.pdf

I gave the author some feedback on the prior art in Linux (at least
since 2002, originally using the linker approach) and GCC (adding the
compiler attribute in 2007 from what I could see), including our Rust
macro too, starting in 2022.

Hopefully the discussion will continue -- the thread was active up to
a few days ago.

Cheers,
Miguel
