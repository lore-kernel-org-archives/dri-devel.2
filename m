Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366E6606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=J5DBBidH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EDB410E7E8;
	Wed, 18 Nov 2026 12:23:19 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7E8510E7E8
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:23:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795004586; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=oGbns6684pX2WvPKftPvV4vlLiBQyCVkT4FCAuLiDDuGMCE949C3jUBopub8DxV4p2hTIs3zDPbHktFeFCpn39+WpfIuvKpArgFxTBSc1DuP2WZSfQb5G1VDDto8keTAhrVhrry/hkLmQnQBzwSHurx5haNTAH00j+0HtwoIqGQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795004586;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=cjhT9lPBrmYqZSZOzIBzYhYI/I9rXhhiam5UCNwKdF8=; 
 b=eCYRGWHeG41YcUgNTA7IjsQUmOK1GIOCWlYiQ6BUqKXsRRMS5EDF72rAdGY9BhTqyQsO3XcxOOd2exTPldUKyTwOzTXaD55oHyVEFsvw9umodnae57sV7+vhxnoiqTDLPnEMu9WDbkZfdvzpz3+YXGzRfNiq5DG9pA6B9pvdZI4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=J5DBBidHI4rrMJEWmOlpnBmuoVkNfyaktxykd+RnxCgVuXlsy4E6WKvch5WM+GEqWnJp6WqP5iv2lyQuTXpOadRSWIBBFGjK7zWkitoVzyy4rZbF+WH4HTygm7Nf1kArRPNipbRAH5NDw71kv+0NvGvimg5QjqW9YRwPtk7jWOM=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=cjhT9lPBrmYqZSZOzIBzYhYI/I9rXhhiam5UCNwKdF8=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795004583498854.6891259147035;
 Wed, 18 Nov 2026 04:23:03 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v2] rust: DamFence: Remove warning about unsignaled drop
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20261118120813.1539288-2-phasta@kernel.org>
Date: Wed, 18 Nov 2026 09:22:46 -0300
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E66E5A69-4B91-4089-831E-8DB07308185D@collabora.com>
References: <20261118120813.1539288-2-phasta@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
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
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Philipp,

Just pointing out that the same typo from v1 remains, i.e.: DamFence

=E2=80=94 Daniel=
