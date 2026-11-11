Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C299606A335
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=iUCXqri5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A54A10E6F0;
	Wed, 11 Nov 2026 13:03:53 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A556610E2FC
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:03:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1794402226; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Zh2WZxtb83wiwRb55pRxREL5E1WrfyKssqgEz5SCi92CW7JIemCmbhV1yFx0zfNB4HLzo8ucwBbftVkLr8vLtgD56heloJGjJgeTIpoKIPN1wz78hTT3/+TZi/eb1dMj5ClJklA/Z3JK5IrLbAAdGPnlaYaxMvu3CE0W/NlAuPM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1794402226;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=YNKbqnPxAy2kyKtQIxYMphXXlBnE1sy3rQHY1OtNP0o=; 
 b=X1e+dM4k5IyuX5JjIXL+KLKDEqYIKs41O9z/fGRRTjynLSKGIxsjl0FssYE1L2yN4mZ6C0KDur/CqyYGa4rAeDAGaEr2b8LIJjlp2ZbsbM2m+8y0EBxqmeyK9HgEK0giPBHk+l4MiP/OJBe/tyuxs1850SNCYWoK9GOqkB97Dcg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=iUCXqri5yD3OP75C+gC4ZVBcwt7hvAazBVIpSV6pFx/07tOgbLBtVVSxIUNAv/0n4+eU7RBrPLRQWqStItspt3s+uOKz6SL0SV8ozwbF2aTNZSYNI0Y2jfpU6onvXsM1UoXvLro64Lc8Ml6TkQkxTKCa8wdofnk8RVLnsSU5kzQ=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=YNKbqnPxAy2kyKtQIxYMphXXlBnE1sy3rQHY1OtNP0o=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794402223658550.9611442995573;
 Wed, 11 Nov 2026 05:03:43 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH 0/7] rust: io: add read-only and write-only views and
 registers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20261020080147.1743459-1-aliceryhl@google.com>
Date: Wed, 11 Nov 2026 10:03:25 -0300
Cc: Danilo Krummrich <dakr@kernel.org>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Message-Id: <D2C021BF-4C1D-46B7-A6CF-9C76C56805B0@collabora.com>
References: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
 <20261020080147.1743459-1-aliceryhl@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-ZohoMailClient: External
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


Gary,

> On 20 Oct 2026, at 05:01, Alice Ryhl <aliceryhl@google.com> wrote:
> 
> On Thu, Oct 15, 2026 at 04:19:40PM -0300, Daniel Almeida wrote:
>> This series adds read-only and write-only I/O views, and the #[ro]
>> and #[wo] attributes to register!. An access in the wrong direction
>> then does not compile.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
> I heard a suggestion that it'd be better to drop the Io from these trait
> names so they are just Readable and Writable, because not all
> implementations do IO (i.e. if it's SysMem it's arguably not IO). Not
> super important to me, though.
> 

Any further thoughts on this series other than the feedback you have
already shared?
