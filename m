Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEB8606A330
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=m/POi6fm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 046FA10E077;
	Sun, 22 Nov 2026 13:01:40 +0000 (UTC)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82D8010E077
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 13:01:34 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4aae099f5baso1060704f8f.1
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 05:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795352493; x=1795957293;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dgD6v1f8hqSyKP1pmrAiIRCKNp5vHibGV2DXdSb8jaU=;
 b=m/POi6fm9mTC5b2u2ieAUS/Knhlx7LA39YszWI3Tb9TvOC+5S59NJsjCSOVpFTs1aD
 KwRGPofWMrTiZiI1HUiOd3kaKR3I5bFb0qUp0sV6PN3vQIf6VDDmP4eBRohwbTKLl6uJ
 52WnDOTd1HN1q7txih9EBaOA0EFziYPitXBnhZOGFr79UmXCGDsv0EtFRGHfLyHI4+hh
 iFThiSllrBbZCmc9jNo71G9yr8HsKK5m0OqkvrYfSYGZLiAiEkxthUE1kBhZISC2FXYT
 qQ9Ms42rORVtgk0Eb4PwOEu9zQPzABdWhacc/xdjIxu302RMP4/3woCzpnDI6DDbhg8V
 mV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795352493; x=1795957293;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dgD6v1f8hqSyKP1pmrAiIRCKNp5vHibGV2DXdSb8jaU=;
 b=A0+Vc2ZyVO7Fir0unEudEZOGCsoEXXQ3Z4gyL0UnHWQ3qrsgJqG5fd+fXfepHdGAFa
 fMlqczqUZMKx1g/hlDnXrivBfTLS6U4obaOX8is0x4URThlMYG6mPIHd20SJdZAEa98y
 kYoY2kJHaD0dfowWAM1/IFAaOwDGyhsxtRbt8SM7VSOunk70IRHMpTnwS3ERe4eSFudF
 vwOWrlZQjHTLxYQftG34Soy+kS4CU/U0SAA8VyNwSUI3KNdhY7pc2ysev7qv7eQ9PqOL
 3NIqr9Bq4XE9tn6SUcmB4ZgFPh11PvOvZ1Qd4On/+DvSzL/U5I2jMRIOGUUd3tgWY8bS
 F/sQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEaklIpbZ9XkkrB6s9ApdJFZ//1+GECuyFYDUpw01yBdYl5uaZSioSCoF68U+IlZPei2YvTsfR+Fzc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/GeBEZhWl8dp5bnX1L1epIrqqqMt2/wljp8wRKIwFxgWcJJOsn
 Vlkzkl89Al12iUHK+KaJDXJfz1t2MuJ+IXCFXo4B9ybfB3NmyifGK9SA6uvBRhwUu4f2c+VDHSy
 UbKliISkfh7hB1Zf77g==
X-Received: from wrnv1.prod.google.com ([2002:adf:ebc1:0:b0:4a3:da3d:b9a6])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:188a:b0:4a9:4dfa:c150 with SMTP id
 ffacd0b85a97d-4abb2910440mr16888311f8f.33.1795352492323; 
 Sun, 22 Nov 2026 05:01:32 -0800 (PST)
Date: Sun, 22 Nov 2026 13:01:31 +0000
In-Reply-To: <20261020-b4-dev_query_fixes-v4-0-df66b4c98bc6@collabora.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261020-b4-dev_query_fixes-v4-0-df66b4c98bc6@collabora.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261122130131.1394960-1-aliceryhl@google.com>
Subject: Re: [PATCH v4 0/3] drm/tyr: allow mismatched buffers for dev_query
From: Alice Ryhl <aliceryhl@google.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 05:06:44PM -0700, Deborah Brouwer wrote:
> Panthor UAPI for DRM_IOCTL_PANTHOR_DEV_QUERY allows userspace to provide
> a smaller or larger buffer than the kernel needs. Revise Tyr's
> implementation to match the expected UAPI behaviour.
> 
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

Applied to drm-rust-next. Thanks!

I folded in Miguel's style and doc suggestions when applying.

Alice
