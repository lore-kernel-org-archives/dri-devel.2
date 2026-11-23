Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4248E606A322
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 22:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=E8ilBHpW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3927D10EC65;
	Mon, 23 Nov 2026 22:26:13 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DCAD10EC65
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 22:26:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795472763; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lk7EJhzpaJ+wBBDlEn8gJKP6rvwE0AtPPiz+pvSeF/ou0sYTpM/2tE6Q3jybpYsHS0U+31NxkENAEc5pooCC9EP0r8mbtXd6zC9yXMaNlu/HdyQcjkAFUSNTt00zLypAg7dQHdoHwsgghNa6Ko7+UIZlpE3jNzNXf8ApUtr0NF0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795472763;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=k9AdsQ75C4VFTI3Ny+V7EnE4MQOaiUpfZxRopOuTcOg=; 
 b=kahc7bT71Pn0fa82ABYYPL3CTo9qsUQ5ZFG93poNOET3MDSkzQq38u4zkH8sHwY3W/nqufIdbwL8DJyw5vObWDXdaY7LWLKYx3aYqgVQLYiNKj75IsPAaA08SRX2C5RX0sjpNhpr4BWtDRHA9PkMAybOILeQVjWVPosK4lrN0lM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=E8ilBHpWN4kfzwkBtr/JbRk2uHTFGzIxZhxtrvR5QU9bRZxskkCKuPd/+x8HxzPKNTbk/DTFidImiP3pjbz0VL+lp7JbmWYbshCVjPWrNwj5zmb667M6ECACgsrOh9Z5v7rfzBJBDIIqOvfJZZT2AXjNDGWjlYabS8p9gBQyztk=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=k9AdsQ75C4VFTI3Ny+V7EnE4MQOaiUpfZxRopOuTcOg=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795472760727373.83086376046344; 
 Mon, 23 Nov 2026 14:26:00 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v7 00/10] drm/tyr: add VM and BO ioctl support
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20261122-tyr-ioctls-v7-0-3a2af624b992@linux.dev>
Date: Mon, 23 Nov 2026 19:25:42 -0300
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
Message-Id: <1103933C-C9A7-48C8-8890-449313716EB5@collabora.com>
References: <20261122-tyr-ioctls-v7-0-3a2af624b992@linux.dev>
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

Alvin, can we have your thoughts on this [0]?

See my reply, which is directly applicable to your patchset [1].

=E2=80=94 Daniel

[0] =
https://lore.kernel.org/rust-for-linux/084F476A-BD3F-4FAA-B47C-E875B542AA1=
B@collabora.com/T/#m14abaa8f4cffe0475a8ee9c1387d61c077ff7533
[1] =
https://lore.kernel.org/rust-for-linux/084F476A-BD3F-4FAA-B47C-E875B542AA1=
B@collabora.com/


