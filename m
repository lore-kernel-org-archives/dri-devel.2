Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CD2606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=myC3tXsR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FDE210E33D;
	Sat,  7 Nov 2026 15:43:11 +0000 (UTC)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0C2110E33D
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 15:43:01 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4902ce85f72so1632156f8f.2
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 07:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794066180; x=1794670980;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=D3NoZ9xEC4313Trcgt2ltEJwS8UgPUcORECDaAKh+WA=;
 b=myC3tXsRCxYzzy2SHq18/GFswUxBxu5uvPEM0QyeQHst+f/eb2OIOB8kdzqrxFefI4
 rlvFXJQxO3lLw/uVgBvpredynV2psIKRdZV2hF2BFRZBj9P3ZKjamMX4uf4Zxn7tHfvd
 aFG9F7vims239ELAYHTH9cStzG8zSrunIqOxCkdG6ocZZ215LIGGW4SH964smPV/V23x
 CU9aJwnpOd7+kNOKPJIbS2pS/g817L1pWDocihgunK2OLupKtgfDu/+iHYcafHn4KSjx
 l0nHurn1Av7GBvnrZEZlok2OU6V/XShuPf3Or9N9sZekj6d6fWfYTwTEImQJdXyT/hoE
 EBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794066180; x=1794670980;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D3NoZ9xEC4313Trcgt2ltEJwS8UgPUcORECDaAKh+WA=;
 b=J4fnxYPrElr1atsXVeZV1TX/KtWwCPd8omjqRhqpc93gqWUc2vZ4BQi7D4pot38Kok
 GtFmFRCMLq8AwXq37lMQHlnVQZ4D/OlSz15PlolI4jnosUzl/rWzNQH15v7V/qFzCuiK
 ETGgm03pWn1RPISPlX4CFyGaOvyBSF/UUyhkTPReabpFqQP95qByKLvY5r2ahOsK0v9H
 rA5jFPmkrxXXzyuVMRXMryZT2zuVMml47OptjP8y+taUflZ8bxbPZ7cIRfBOeqAvfUlv
 brUq7SQZJNgOBIBzYQcNi67Tc8dXQYPLU30GJN28hvvei4HT4P8jXiP6AMTh/F33+cx7
 9ccQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHaytczC9oOf6DwblMh/ocKUs58qPcdlM7rP+y601vBWYEK6WRS7+vxGdrU7U4qGXKWkLSAnoRZbFQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+iA5JXKS5OV9Ub56hi8MBnebmiloZcP3o+klEdA3Cg+A5vs4vP
 DWDcw74GmhwpbDCb3FL8cDZLE+PGn64zR+JdNktbDzXkmJhebWO6yIfSdcFZIe71WLV3AMI5fUY
 o3V0EnRCsB0VCCIc6DQ==
X-Received: from wrsn15.prod.google.com ([2002:a5d:484f:0:b0:490:3c0:b998])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:64ce:0:b0:48f:e879:5890 with SMTP id
 ffacd0b85a97d-492760da597mr10504618f8f.32.1794066180064; 
 Sat, 07 Nov 2026 07:43:00 -0800 (PST)
Date: Sat,  7 Nov 2026 15:42:58 +0000
In-Reply-To: <20261019-chid-v10-3-67de9180b4ed@nvidia.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261019-chid-v10-0-67de9180b4ed@nvidia.com>
 <20261019-chid-v10-3-67de9180b4ed@nvidia.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261107154258.3547690-1-aliceryhl@google.com>
Subject: Re: [PATCH v10 3/3] gpu: nova-core: add ChannelIdPool
From: Alice Ryhl <aliceryhl@google.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
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

On Mon, Oct 19, 2026 at 01:29:28PM +0900, Eliot Courtney wrote:
> Add `ChannelIdPool` which adds automatic tracking and releasing of
> channel IDs on top of `IdPool`. This is necessary for apportioning
> ranges of channel IDs to be used in e.g. vGPU.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
