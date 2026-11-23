Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AD6606A322
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 22:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=fPj8nhdu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD86610EC43;
	Mon, 23 Nov 2026 22:21:27 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E09BE10EC43
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 22:21:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795472477; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Qvr9OkM55YewH7a1kmhujGsW6GcLuosTdF022DYd/zazc7OK8UZvW/64GLOgUxsBqqyRYYf4iV8ZNKM9IWXWQusjaOU3OPx52zhC8KESjJ80Mh4xxS3SVoKb21MeVuzvflBWZwBXFMTuQ30dRI0E8JSRtfmbatrmGk1wHUS/zVU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795472477;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=loCklCyG3lJZLM7HB7hwAb7zV0bfVHMUtT4+DsQV5ow=; 
 b=U7gNiCjPtnl8JfCe8AC3wf8DlRJgvtphfH0AoNT4TaQI5XTxB+t8H1nr6TMhhZGfz13Hp+drDEStzHWE9rLkMZHTTRcokuSuziirq8nC53cNNd4a/b7R3vpcmc1p+p8xHzPPB/YSsuYO7B2KRi1QZgm61jwF9Dcbuf4AGyK0R2w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=fPj8nhdu4HYbwinx47ZHtg8XWT3qbjnckDLHHuvxfWpgwJqfNBGyQ08uw3Rkn/dHy5gSts20yOTmbBh3n/wsmzVBE2hR6Zgxgn8swbLhk02pRitGwk1cuNQVjo79Io0S4SdErs51hF9lnGW5CLVX0J/8MjMEmQby/VNskgo8CKI=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=loCklCyG3lJZLM7HB7hwAb7zV0bfVHMUtT4+DsQV5ow=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795472475631655.0565800257085;
 Mon, 23 Nov 2026 14:21:15 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH 0/4] drm/tyr: use pin-init self-referential support
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20261118233727.3147222-1-dakr@kernel.org>
Date: Mon, 23 Nov 2026 19:20:59 -0300
Cc: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 lossin@kernel.org, gary@garyguo.net, ojeda@kernel.org, boqun@kernel.org,
 bjorn3_gh@protonmail.com, a.hindborg@kernel.org, tmgross@umich.edu,
 tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <084F476A-BD3F-4FAA-B47C-E875B542AA1B@collabora.com>
References: <20261118233727.3147222-1-dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
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

Hi Danilo,

Thanks for doing this.

I spoke with Gary about this topic at Kangrejos and again a couple of =
weeks
ago. What worries me is that we might introduce some restrictions that =
might
paint us into a corner. IOW: we have significant downstream work, and I =
wonder
whether it will work with this series after whatever refactors are =
needed.

To start with, Alvin's VM_BIND ioctl series [0] will need some changes, =
since it keeps
the VM pool in the file data. I think this is doable if we move the pool =
into
the registration data and have each file hold only an index to its own =
entry?
i.e.: something like an XArray<Pool<Vm>> indexed by a number associated =
with
the drm::File. Same for the group pool later. Is this what you had in =
mind?

Anything storing a KernelBo will also have to be outside of the file =
data,
IIUC, since it now stores a &Vm. Also, downstream we defer KernelBo =
drops to
a workqueue, because they can happen in the fence signalling path. I =
suppose
we can keep doing that using ScopedWork/ScopedQueue?


=E2=80=94 Daniel


[0]: =
https://lore.kernel.org/rust-for-linux/20261122-tyr-ioctls-v7-0-3a2af624b9=
92@linux.dev/T/#t=
