Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD68D606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 21:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Z5tQ8dfU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D939B10E043;
	Wed, 25 Nov 2026 21:28:04 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B427F10E043
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 21:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795642076; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MjLcmEYP4dfYgDJ1mAWe0gCDumOjchif5rjLyGxg00V3WjYCwzbi11yuEa3fFi8gOTHJS+NjxXczyqP1TSqR64XgusnxoAuBQ4bBxcaEb7XsFZVGg2luGgNbmxjeSzEkoQc8YuiDr+oJlJO1oObu1HahoxXskwM5TAGJYuXxNDo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795642076;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=; 
 b=asJ1AS5EdNp2gkQfi3EfZ+TytbJ8iSpJmJjcdvk4afJDaYVYsVSR1f1Vn//nV+jluurid23nf9fGye0uATwiVW3zZNiC3VY0vVsjR6DyEbx4mHKF+sYdMI3PWC3T9O2BgyCIt5OKjerRcIX7nE+B7lZv+JGP+YXctchkNehuhy4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=Z5tQ8dfUbRupGUOW5D+gWjdTRrDJVJW+m51QlD9Q+uKSrmGCXo7afcug9oPOG5rr0xBk8QmlYwdbu0XJIrO1uBfUa6FBF7pWql0E3S/KJO6yjg84rdjghifRwoR0piB6Zkk7PBqjPJ3flQoYI7ieTsZYTMErDIkoslv7sp9H0LM=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179564207465225.02107895592883;
 Wed, 25 Nov 2026 13:27:54 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH] drm/tyr: clamp va_bits to available bits
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20261125-b4-va_bits_clamp-v1-1-07e2bb33eb50@collabora.com>
Date: Wed, 25 Nov 2026 18:27:39 -0300
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, sunke@kylinos.cn
Content-Transfer-Encoding: 7bit
Message-Id: <9AF45BE4-9E86-4663-A759-62E4469D4228@collabora.com>
References: <20261125-b4-va_bits_clamp-v1-1-07e2bb33eb50@collabora.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
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
