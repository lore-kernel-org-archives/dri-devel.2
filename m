Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BBA606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=F0JXi3Jk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14A3D10FC40;
	Wed, 11 Nov 2026 17:30:38 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98CBA10FC40
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:30:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1794418230; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XQ+4kTy1Sbg+S2qNqks5/t4BdOZlkR2RGbfx3y/El1qrOUQAACXO4gR1elMHCCnS3PfaFn1wyBg9AJ526lxZxpkoyUzWj2PWQBkFIRJEQ+3Te0fLtNfLc0j1S0paBxNAF5Bww5IlcEcXP1LqCG+U279JEiZ1r5cSe6yFngmRcP8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1794418230;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=; 
 b=DgKZQP5SIj85Z+b2Ao90Am8f3aCxiUdNAXLepTZn80nMH5elWAeJdpif3MJw/baWpFno75pkfxoJ+tVXfnemyJqpoy80pA7jGfxN3bUTRsNE0gpmHbhFrU+Cn/paHcjy84knPtCp+Ag8JgVyBJgrCgKUfM+NgsWIiZeF/KWjBLQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=F0JXi3Jk1+ckm+EuI/KcTpwx6KLcN8S2S6w05QcozMJ25TNkCNkLdBa8MvUdDiTbqO54Qc9Pxdxo/BkRd9NrBN2MZ2/YT/opWYXHRUTqFeB167MonfJNVH4nFVdRnAbmLKIuqKIWQtpn0z29rV7B/CY1Op1bhd8FU5YgkfLMg6M=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1794418227715371.06425639823635;
 Wed, 11 Nov 2026 09:30:27 -0800 (PST)
Date: Wed, 11 Nov 2026 14:30:27 -0300
From: Daniel Almeida <daniel.almeida@collabora.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "aliceryhl" <aliceryhl@google.com>, "acourbot" <acourbot@nvidia.com>,
 "ojeda" <ojeda@kernel.org>, "boqun" <boqun@kernel.org>,
 "gary" <gary@garyguo.net>, "bjorn3_gh" <bjorn3_gh@protonmail.com>,
 "lossin" <lossin@kernel.org>, "a.hindborg" <a.hindborg@kernel.org>,
 "tmgross" <tmgross@umich.edu>, "tamird" <tamird@kernel.org>,
 "work" <work@onurozkan.dev>, "brauner" <brauner@kernel.org>,
 "lyude" <lyude@redhat.com>, "j" <j@jananu.net>,
 "alvin.sun" <alvin.sun@linux.dev>,
 "deborah.brouwer" <deborah.brouwer@collabora.com>,
 "laura.nao" <laura.nao@collabora.com>,
 "beata.michalska" <beata.michalska@arm.com>,
 "nova-gpu" <nova-gpu@lists.linux.dev>,
 "dri-devel" <dri-devel@lists.freedesktop.org>,
 "rust-for-linux" <rust-for-linux@vger.kernel.org>,
 "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1a1cba939ec.316e688b263885.5117314523612320809@collabora.com>
In-Reply-To: <20261107021427.2105374-8-dakr@kernel.org>
References: <20261107021427.2105374-1-dakr@kernel.org>
 <20261107021427.2105374-8-dakr@kernel.org>
Subject: Re: [PATCH v2 7/7] rust: drm: make Driver::File lifetime-parameterized
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
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

