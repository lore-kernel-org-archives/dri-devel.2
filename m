Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342BC606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=kgAoWqWf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93C5210EAA3;
	Wed, 11 Nov 2026 17:29:42 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F91210EAA3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1794418174; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=J1wl3Zvpxev0DGwhYd1mPbQy7eKIy7/VxKt8XZnLehTZD5ZD+8s9X5oTWJJJ2X73LgUREJmHy9kSYJgNNmTTWebUihdpniJt0mVK7ZXY4K04l91DsPcjyR2Zt0zTi7Rlff07euI9BwH7DJe4Egw1nx0U5avM/9ixjMcUSBzOhTg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1794418174;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=; 
 b=aPoURh4oL3UsQVn7BxBtJ5OadUIbhpnT80S/0BqS0Zf3tB+LCofv8uPUbRocegjFR3rJYu46n2kFiFPJgSvSmW4shgrmRv9qW+GeFx3+Z7kRPQhflMQZEo9ueAYp2+cEGdZcK+ML5/x9T8HlQl5qtuqeHfafbAou4mUu6fIbwok=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=kgAoWqWfpIkvKM+aQ4I08A6U5Far+l7wwYDCPLPfV5E29cIzpeXUM1VUnLIJvBXgkug6utdS6SjLsblp9nmTPtnJgHyORuT6Id8Ykic9Gdj2z5h3JgU0s1c1/rQ9RNXuMq1u40mP74wum/+IChJs2WrqpxstJ16C68hYzMv6mCU=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 17944181737439.499080471783259;
 Wed, 11 Nov 2026 09:29:33 -0800 (PST)
Date: Wed, 11 Nov 2026 14:29:33 -0300
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
Message-ID: <1a1cba8671a.1ba93626263271.8137996775533663026@collabora.com>
In-Reply-To: <20261107021427.2105374-7-dakr@kernel.org>
References: <20261107021427.2105374-1-dakr@kernel.org>
 <20261107021427.2105374-7-dakr@kernel.org>
Subject: Re: [PATCH v2 6/7] rust: drm: return impl PinInit from
 DriverFile::open()
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

