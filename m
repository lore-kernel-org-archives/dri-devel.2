Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386CB606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 01:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=g8nP1E80
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3935B10E8D9;
	Fri, 20 Nov 2026 01:25:54 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C46F110E8C3
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 01:25:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795137942; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jQi/lqqZHqycRDxqDLXZ0wdrayC1AWhR4/BgtKrgRVnAd0oN6TxBl3rbFWXKTUhx4aB0+ed8xsi81AvPGfHxcnevNFmqlTZhKX9ySN1A1d+UVaeoC10xYvqa4AHeEZ7rz2L+s85m6kZ3rJ1Md+t5OtW9ZmYd5lxVVEFi8kS65AI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795137942;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=; 
 b=H352xFaYTGu4dsAC2JbfSR5U3A7ekFVQj7zoZN8zlij+a7LABnLayE7RLe40ONNqLi9MZ+kYa3bBHkKpHzOa3OVS+9Puq2gO/VKjYHM3utClWwI9ll8lzqZv7+PgOQ67h7Xzvp+NG0yXWOctHflvCsm6wnRtU8kTK+qb53aIKTg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=g8nP1E80Z/pgpgrjx3ahXA/XEHGvUcY+ld3Wl8RpTAntRXzecPOKcEMszMPEQCNdPgTSOdL/yOE4bX6Yiy/4BipOlpduz5O9ta16c/dbrSq66H1LPNrmM17nZSjc7BM5PTrOPQFCKtO0qTunF0GunPXo+lh2EmPMCi6gBKmq+pw=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795137939387662.7486311832405;
 Thu, 19 Nov 2026 17:25:39 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH] rust: drm: gpuvm: rename UniqueRefGpuVm data accessors
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20261119-gpuvm-data-rename-v1-1-8eb773435fde@google.com>
Date: Thu, 19 Nov 2026 22:25:19 -0300
Cc: Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?utf-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Sami Tolvanen <samitolvanen@google.com>, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <37602247-89D5-47FD-B687-A5762AD5FE86@collabora.com>
References: <20261119-gpuvm-data-rename-v1-1-8eb773435fde@google.com>
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

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
