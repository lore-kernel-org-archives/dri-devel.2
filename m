Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98397EC01A3
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 08:11:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D230F10E40A;
	Mon, 23 Mar 2026 08:11:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TK2uPSDs";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B6E210E184
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 06:24:10 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2c107ef474fso3115746eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 23:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774160650; x=1774765450; darn=lists.freedesktop.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d/1klNg2aFhsp6OGvAAoWYikrcXambFiOwbGCQtt8hg=;
 b=TK2uPSDsfnDe2uou7y/uNdTd4x/XRX44oM7AhDjlZn/Y5o1wf6MroqGDohCRX0VVJ9
 WOwltaE9t+zI0bIXiyjdcGY6XwZXXVovR1sx41/cQ2zmakWOiUaUq1wwKtRdix4EdWet
 puNcjYB8bEPfEr5SPlgUuIUqOU0DqWOMagqtjB1NvmC764yIU1vND+/CQQDymkySRDrd
 NFXFEHcHiHcJMWAxkwAbGLx7mGxIL9SxD4BoIxH/2+JBFbzMZa18fOW+K1c/2n2DAlLo
 QmLUpm7jU+C+VmZa7NAtOzwS10sxHUDPfNErVPiiZu2A6IeRqQJ+v7hpxaeokVJN4in6
 8X8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774160650; x=1774765450;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d/1klNg2aFhsp6OGvAAoWYikrcXambFiOwbGCQtt8hg=;
 b=KDbpaWmzP1+eTG0groHsABUGgVHitV1FueOR6P0ZZ7H2ObCvnW2jUk/MGpGpKFhKOz
 ofjSphQjA/yevLL3TzY1yGxoUUgVF3pjoXjCxa+Be+GrYrpMYnmzcFYpGEzif4E9YIs5
 RlOXVDGC9lKlOuLvZ/KGi+FvQS/SEtK2DFjlZZuaTPxHXRKWJlxRRZAgWN7bBHFo4zgG
 StR8hAkf32I+0A8h3XaVCbkEfdmZGJ80/eKtWMHWr05NJoVO5Ykb7djEmeXptbHthIOS
 ZRjv9HJVZTONLeAI/hSpfC6xX00mFu/OJCnX1M6P2iViXjObOpXU5TbHQ+WO2NbcW3Rb
 xk8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLX0hMzgRwGaqLHOlY/DEfzHvfqTqpEUZTStxHTodLmcI40Rs2Gvy0EmjVhzR2Gn/cay4OAK8zi5M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw69VbnzLiVdlnVL0V7+hoC3DYyHbQudJoEVbhzP/V+/jpg3ck8
 W6A6piMnVGLs8pdoz/mtrhAZF3g/DAYm0syA0xs+N9AkMFa9kinQlZYn
X-Gm-Gg: ATEYQzyvZUY5pTzo3guC9RcpBA7qN8cn9nuKNiHf2qyCduwWkfqCRMYHjGLs78R0VEl
 ABCdbEBAvLgqx9Ppc/ppQNF2SmlMr6xpFR+nnw8c1jKHk521Irg6gSWrNK/XR7cfVgVyOcjKtX0
 iscw3luCo6j61+re0JJgAgGGcmT1anYLJ6TD0xgU0Li9cJeFdUsjA/EbyiTB6yl6myQ2YCQpFOQ
 T4AMJi3DBMT4FmbmvOvulOlljPgByK45d73+K+5qMi2ScVDTSpfNnZZbPcFfMaDcJ6uTGPH7twi
 aoXFZCv1kqAQWcNVNO0Wwn2+xlOSpoiGvuJd5QTShnezMDFY1fMiRJCx4bGdELDCjv7DZU4DSmo
 bAYfrnR1lXPMXwJVN40AQQzs+bgfvNDMYQACcCjB4+TFpKuWeSzqh9lEyCyMuKPNmvT+cC0+xwM
 fKRXEMwusj45MijJjRiy4PyHJG3ZMvfH68ycM2LQwU7ske
X-Received: by 2002:a05:7300:e785:b0:2be:2f58:2ef5 with SMTP id
 5a478bee46e88-2c1095d7861mr4599770eec.1.1774160649552; 
 Sat, 21 Mar 2026 23:24:09 -0700 (PDT)
Received: from localhost ([2603:8000:bb00:9b3f::18f6])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b3253d0sm9235890eec.29.2026.03.21.23.24.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Mar 2026 23:24:09 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Mar 2026 23:24:05 -0700
Message-Id: <DH93GL0U3NZO.3STS474THERXH@gmail.com>
From: "Aditya Rajan" <adi.dev.github@gmail.com>
To: "Gary Guo" <gary@garyguo.net>, "Aditya Rajan"
 <adi.dev.github@gmail.com>, "Danilo Krummrich" <dakr@kernel.org>,
 <aliceryhl@google.com>, <acourbot@nvidia.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>
Cc: <driver-core@lists.linux.dev>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/8] rust: dma: add generalized container for types
 other than slices
X-Mailer: aerc 0.21.0
References: <20260320194626.36263-1-dakr@kernel.org>
 <20260320194626.36263-3-dakr@kernel.org>
 <DH8UHISTLOA4.934370PUTLB4@gmail.com>
 <DH8WATAVCH33.19JPYBAOILCZE@garyguo.net>
In-Reply-To: <DH8WATAVCH33.19JPYBAOILCZE@garyguo.net>
X-Mailman-Approved-At: Mon, 23 Mar 2026 08:11:26 +0000
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

On Sat Mar 21, 2026 at 5:47 PM PDT, Gary Guo wrote:
> They're going to be removed later, see https://lore.kernel.org/rust-for-l=
inux/DH87CCNRR5EC.2SK3IT6N6Q8V5@nvidia.com/T/#m30142b65bb87af64860838565c78=
4c304e02b563
Got it ! Patch LGTM !
