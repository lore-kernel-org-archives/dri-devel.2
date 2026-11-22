Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEDF606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=iUlw9AP0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 023E710E4E7;
	Sun, 22 Nov 2026 14:41:26 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1FFA10E4E7
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 14:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795358467; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KLZoxImi/gLRc5IEyb5cQvAK0V4Dz41Xb6f+OH0JaW7n/3y+F/jaQRJBJKi9ln56cZ87I7YX3upq/wZkRP3KqZPiIFmiSCxc6f+8o+tda74u6BJ/KCQmMRRvC0A00FpxfN8QkFqipX6l5PWC7cAoDgVV42p+2cFF9T1XKm6Cm8g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795358467;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=OAs13tz1zp/V0FXsNuU43sQnuDXZ2JK6gLC8wvitSVA=; 
 b=NdSm97msQRfBEanTZa4vhVxHcbmj0M76Sb498KU5Awm30rC0SOSPYTTqODJFdxDcRzg4xNGTp5jfeHlk1Eoj6gQdcj07Kxm7SoY+/ysE92a+k7a3E9cCHgBXQxz7763wXvllIGBMsZo/fbkdQqHvykztbFkZLrahlZgB9blTqBQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=iUlw9AP0eZxLbWFQSQ6ZbMipLVn1sRzoht2NE9FRSavf7MpzLAdk6nkgQEp1wA3lxEI3IrrLbKumoE1RPOyWtO6rGWVk5gCFZeL07MlGO9UdMyN0RnWzIC5HxyTP2/elO7y/wuN4VXMVPr56G9r+etB35lzpIX0LPOcneWT+LDo=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=OAs13tz1zp/V0FXsNuU43sQnuDXZ2JK6gLC8wvitSVA=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795358466185585.8202777739539;
 Sun, 22 Nov 2026 06:41:06 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v9 0/2] drm/tyr: GPU reset infrastructure
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20261122-tyr-reset-impl-v9-0-ed42d8f513ec@onurozkan.dev>
Date: Sun, 22 Nov 2026 11:40:51 -0300
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dakr@kernel.org, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu, boris.brezillon@collabora.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B7A7F936-E696-41F1-8B9D-5A29DFBED07C@collabora.com>
References: <20261122-tyr-reset-impl-v9-0-ed42d8f513ec@onurozkan.dev>
To: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
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

Hi Onur,

We can probably fix the sashiko findings once the Clk typestate patchset
lands. In any case, what we have so far is good for the time being.

=E2=80=94 Daniel=
