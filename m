Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B5FCD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 705D910E4FA;
	Tue,  9 Jun 2026 14:11:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kEKm/Qzi";
	dkim-atps=neutral
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1741610E4FA
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 14:11:15 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-304f9bc869aso679093eec.2
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 07:11:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781014274; cv=none;
 d=google.com; s=arc-20240605;
 b=LsJUhliLlCJnnb1LDHmU38Qo/fehF0mqni+KbcxPz45G6UmgUsgfZ9CX/xusk7WjMf
 Z/+O0hNFNrauWXgk7DBX9ujaFWIfgXwu/yqTut6Ni6yRPANTyxHLIVKireunrA6shNcW
 n1HddkYWrK1lNjmzCczUCHeAuYduDCha3W7YU7l3ARhFcb3i5FDckzvGJ/YWx+ERqKVp
 JxzsxiZO+OFS8DOHN3OjdSk90dFn9W8CRE4AGnz6nC0BMQvqOjoyX/AnBfPPuBmQN1sh
 WoL3c6AKOwTY/aP1BeeIs5Zqp/lX4UxiB0RpMpLbHYqK2lLOIiMRGHk26DNlXAdrLK08
 l9ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nhjDW0OszKJAGtPcPLD3bV8YMBm1E7bkkVTPi52pFmI=;
 fh=NfjyyyFdufTYqBnDUMjTnXL5RLXNB03rubwLJ4Kcvis=;
 b=gnzUILqPCkRrv85Lh1G2cXKf3aOIQFjKHEbYI5qodQs8Mvs/rpB5gf0PFWF+qLY8h6
 +rNlSmk0P/ug/sL9kDOrVBhO1AmQe05bqzgRvDq1ZYcpYxijwDw5Vhg0yb3jPr+eg18T
 WtsGRHdJJtgoXV2IEmJyx3t4WATrKVGY9/zc2PyQNMwqpetK5usyuNBJ1kSCL8jc/0W9
 Pu4Wzqau+SOWEJmfp8Z2OfuUIt+zQn19wMxBXhs+/AGDlyo+ATMSUpG7BhogAH5HlIru
 lhNFtKSV1QSLqfl1vzS/ScdjRyd1xRDIfF2hiM5k/VqRAyGnT6AwM0vPgz/sGthy6C4B
 hn2g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781014274; x=1781619074; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nhjDW0OszKJAGtPcPLD3bV8YMBm1E7bkkVTPi52pFmI=;
 b=kEKm/QzicWGHVPEN/LhnIz4te3fQ2/9FCJpesDHfXJ4f7MtyjKLwLx1LSvFVJH+y+o
 f8MLIiABl8JfOFD2OtzRufEnclnZ6m7cHrKOgkxhxUJ3SB2xv//liFsq5DWIoFTJQWX1
 8sZjJ4b/qDbRr/bbTrRFbkHG7OHEPinF7WJ2OGNPOL+ODLmEPK0AkDlmIqAM2nO7Vnkj
 /esvT4KOWUOR7HeV89WLndr6Uyc3kYMqZ0d0LfxZ66gP/RNNrkQdksOatB6d9RxrP4cg
 D5IlWz7HvBIqUDJajCO1UE7mDqwOmG13bkpArtQviAp9LHsOoRcUDzx60/bX06aqdiv6
 YztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781014274; x=1781619074;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nhjDW0OszKJAGtPcPLD3bV8YMBm1E7bkkVTPi52pFmI=;
 b=GUeDOsPKkTxcmacxZSS1Q/gludlMj2Xuc4wY+6spFNN3QamwspcvXKFg6TOVItqzSK
 W496zwdZF8cbvnkXAPXf/oEyz60FqpbMHPoA8xT9vpvWU6e27WKo6enl4gBCHaWNCcqA
 fbHLHXaFGQoP1CirucxHqQcIvf5z2RaWEHYqXksT8xV+OPAmRv56eRltX5Nhxrictuww
 NfqMs91X7ms0+WfUvLudKQjNCwU5/VquYg06GBXBHOJh/l585SYnM1fCI5LMOAvs1bXL
 g9ATedrZOZ0bHSW3PmJh5CvdWhhl5RpzGj4AHuJNU86jfAceNey8n3G/BMn+QHaiVg3n
 4Uuw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+zz/TWAbunPhBOrmgPkKINM0Qx30tnyxLMMvA0b8PgnTd0+vqee+1UDpu/Q1CD+aSNjRGuwIqeGCo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxuJjDswFzjUlW2Gur4kZ5TAdc193wiwlIwDcFXH59H69/A+f9M
 LOK+8NbT6PELpQDaDe0jbOzodDHwbjhrFpdiNxgnKCRfryK/nuODCcHPDPIvzGnHWA977gUGxJ6
 7fRiu5K0Rbfkdpp7epBJMhCmKwzQUBGs=
X-Gm-Gg: Acq92OHCXYHYzdqemHzT8Nlgiz8yBaJqq2fU8EwRZSK43DTq96cBADBXC/ER/tAdJHb
 HpQRkrSWV3BzJ7sBt/+uPZy8IhEYkFAtPQDf3CVxPgysfiK5ulaBn7FqBQ1oyIu1Qo2wlPRaWdq
 22UPfOxi5WBM0cqLPkztmZZWEqHe6fhRMtEJ+F/+wNPLg3EbqJTBwYjOgFmVUDFZzmg3uitsBlX
 O1zjGEy722Of1L1lV79JYFNJILRCoHmXWiGmK3oyfy7GU04nLu1xTDDKz8GSoGiwgYMCjPO8pi+
 peJx9AeT2vOAEEChzwQpEYPhVkivN741KF5ESg4cPRqFMXRm55G3NwxFtCJWOQ506pwea7EiJrT
 X/CB8hkxpKiUT0QaTjMaGA0vEQ94diESyrw==
X-Received: by 2002:a05:693c:3749:b0:304:8860:74d6 with SMTP id
 5a478bee46e88-3077b21ea10mr6213247eec.1.1781014274135; Tue, 09 Jun 2026
 07:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
In-Reply-To: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Jun 2026 16:11:01 +0200
X-Gm-Features: AVVi8CfNPwpEZxw0N5nqXBfBlOCze0ATuinL6YIsUVP51KJlhLB9xVsEvEDqHhw
Message-ID: <CANiq72nkYJnztntLzB5jNwi_oRY+V7UMpf6AuKM07aGH9FwPdg@mail.gmail.com>
Subject: Re: [PATCH v17 00/10] rust: add `Ownable` trait and `Owned` type
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Ertman <david.m.ertman@intel.com>, 
 Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Paul Moore <paul@paul-moore.com>, 
 Serge Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
 Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Igor Korotin <igor.korotin@linux.dev>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 driver-core@lists.linux.dev, Asahi Lina <lina+kernel@asahilina.net>, 
 Oliver Mangold <oliver.mangold@pm.me>, Viresh Kumar <viresh.kumar@linaro.org>
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

On Thu, Jun 4, 2026 at 10:13=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
>       rust: page: update formatting of `use` statements
>       rust: aref: update formatting of use statements

Applied these to `rust-next` to get them out of the way already since
I have another similar one for `str` I am applying too -- thanks!

    [ Picked from larger series and reworded. - Miguel ]

Cheers,
Miguel
