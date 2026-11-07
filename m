Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38378606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=N5yRXb5I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84F7D10E527;
	Sat,  7 Nov 2026 08:16:33 +0000 (UTC)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94C7810E527
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 08:16:26 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4902ce85f72so1458698f8f.2
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 00:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794039385; x=1794644185;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GRZSNFEWbftVAvpLk7hELzG7uAWoQX3JdWqOw5mrmdc=;
 b=N5yRXb5IW4YJ2CR7TgbfOieIa4/ApiGSkyn0ZhKweRGgE+wCqfCWSFhn2SWoHQBy3e
 3ye8CdYlqKB5pvx1crhMuBjMVojPljsLoaveVBf8Cf8q646P81jncOnOJl8hYUUKrLZc
 tMh/fe2PbP73pdePTGt/Oc3mX88rJiCzrpzuWGN1foYQot8Evsxo4QfPfpSxrbU+I8pv
 VdrKTAfH7Gaf8MLgm76jssmDDJXrz33ZmeY9G4KrfGHMp+56YS+poptltsc4jwl24heq
 u/g0y54UYsXzEsKMbrZNKemCPL1cemXNR48iyckFqz6JoiswnHMonMxVjJH7dQ7RPxlH
 eE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794039385; x=1794644185;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GRZSNFEWbftVAvpLk7hELzG7uAWoQX3JdWqOw5mrmdc=;
 b=0JHJIAaA1ah2jHlnb7GlumuWz2QXdnOEbTTuNiYpEQTb18lmFUCymihYh+11eKj+BV
 m5GZYIY+yB3itfyK3OYQPGXubKAMAqi8xmSEnSK7WiXuIhlhAg5Y2NWT09J5IXwlFYXT
 hP787LG5DoJUJisUQJ4GafOI230FBT2iPj4Hbcw4rauEK6ubklTkji4pVEytKyIyjCVN
 dWScNvB/nkATrlKc6FgP+RplAYh5b4X4FdrgzaYhevkuLdphIPFVSsJnNMs7sds4wb/6
 8MeDi8lFltp29iehBgKDQD0LzRjP1az9vD8TyvnO6/4Z2py5SAKtfZvLHNdHsK/V7hdR
 0Y7A==
X-Forwarded-Encrypted: i=1;
 AL+hErHLQpukBP517bpIGQm+PoDRx0O7JxW60VR3MrFCV9sOrE9LKhKQGjFmHa1F7r6EjEv1NlFKzRaf/8k=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/4h5g/zFh6Q5AWnyv4fH8SIOu+q4YorI0Xi24cLawbuKopDzCU
 8bVzE65aSqXxEMxGysiwy4Uh3VG8r3DN+Ayabf2bmwbPCq18kyLBkpx397dZy9Mo6Qd/vF8GI5i
 pKP3SRu+xtd1A809feg==
X-Received: from wrtp5.prod.google.com ([2002:a5d:4e05:0:b0:48c:44a2:fe52])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:25eb:b0:490:421f:1555 with SMTP id
 ffacd0b85a97d-49275b1bc23mr8281265f8f.22.1794039384637; 
 Sat, 07 Nov 2026 00:16:24 -0800 (PST)
Date: Sat, 7 Nov 2026 08:16:23 +0000
In-Reply-To: <20261107021427.2105374-8-dakr@kernel.org>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261107021427.2105374-1-dakr@kernel.org>
 <20261107021427.2105374-8-dakr@kernel.org>
Message-ID: <au7eV0D_44ipe3mw@google.com>
Subject: Re: [PATCH v2 7/7] rust: drm: make Driver::File lifetime-parameterized
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: acourbot@nvidia.com, daniel.almeida@collabora.com, ojeda@kernel.org, 
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
 tamird@kernel.org, work@onurozkan.dev, brauner@kernel.org, lyude@redhat.com, 
 j@jananu.net, alvin.sun@linux.dev, deborah.brouwer@collabora.com, 
 laura.nao@collabora.com, beata.michalska@arm.com, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 07, 2026 at 03:03:25AM +0100, Danilo Krummrich wrote:
> +        // Run driver destructors without `filelist_mutex`. Take each link before dropping its
> +        // allocation to avoid recursively dropping the entire chain.
> +        while let Some(mut data) = files {
> +            files = data.as_mut().project().next.take();
> +            drop(data);
> +            drm.open_count.fetch_sub(1, Release);
> +        }

Instead of transferring all the files to another linked list, how about
taking them off the file list one-by-one? If you release the mutex in
between dropping each file, then we still avoid deadlocks if the file
private data destructor takes the lock.

Alice
