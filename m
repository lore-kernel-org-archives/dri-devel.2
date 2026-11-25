Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7590C606A326
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=JA9mkt0g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9352310E21E;
	Wed, 25 Nov 2026 21:02:46 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7306210E21E
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 21:02:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795640557; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gaBZDKBMhJQotJZvAO9dmkqbsWeSRLa4D5euUsXMXiMl71urKvbu2oOaQwCoIDDAkRH4LIXCBm/PjVYQpJWJ9KUQ+PnSqQao9VO1fbOvnoUOSBV3qJ2OCZiQmainIsXs4P4w8u3VknNeP9Ha2Dd6N7/ob3/Oho2PFwAkd1imyL0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795640557;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=YkNlt+uKLADOZuplhNVa0yz6s4jz80shVgstOdfT/Ro=; 
 b=K9W/eHou/RyXErOLS1eKRWTT18c3oyNjhZciNb4six7Wz7ZzHtloR0pKa/2kR9MSAJn6xlYBhk5MLZutXshTCGnjyo1b4VJLqtLgqELhU8N/hVdTkOhgJkHGiiLQB+rFtRApPPwyxrrImb8RUZjw+34mOdKJUtXQihmuA0ra5Bs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=JA9mkt0gxPLJBAxVFbkZ2TkRrnqihs1+c7c/AIlZqkPg2IGAfZDJDotIUTZHRY/5Eew/nohVwbGgVLcouAy2Qgm0+v9a0oVJZMywsNTWoFFhPneshuWsTkxG/dkJEbapqIBSvpOhCRGg9NqZA9Nblyo2fWfC3Q0VsEKKJYO9vs4=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=YkNlt+uKLADOZuplhNVa0yz6s4jz80shVgstOdfT/Ro=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179564055584856.10191565405103;
 Wed, 25 Nov 2026 13:02:35 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v7 10/10] drm/tyr: add BO-related ioctls
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20261122-tyr-ioctls-v7-10-3a2af624b992@linux.dev>
Date: Wed, 25 Nov 2026 18:02:17 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Johan Hovold <johan@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev,
 Ke Sun <sunke@kylinos.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1B531CBF-FEDB-4F99-AFE8-D6DCCAA5697A@collabora.com>
References: <20261122-tyr-ioctls-v7-0-3a2af624b992@linux.dev>
 <20261122-tyr-ioctls-v7-10-3a2af624b992@linux.dev>
To: Alvin Sun <alvin.sun@linux.dev>
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

Hi Alvin,

I will wait for the refactor on the last patch, since this one will
change in a few ways due to it.


=E2=80=94 Daniel=
