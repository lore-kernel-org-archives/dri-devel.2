Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0059760A2607
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XKWeMppo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A26310E7F9;
	Tue, 24 Nov 2026 21:17:05 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EED510E7F9
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 21:16:59 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4bb6860f867so198115e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 13:16:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795555017; cv=none;
 d=google.com; s=arc-20260327;
 b=X49gg1ZZbN7J0vrvEwIUKIUXeLlxX1L3o6H1ZUYMQ8c+XflPdKV2/LbRZMS77dK0C5
 DppqmaqBWy9AJ3pHhgsP2EoGp65pfhVqKXj/EFi+YlpZdWbTyo7H10+H6mCoVuvq0dQB
 t8WY7B0UWsYaUF1qsfmFUbg/baWUfjZUMmC6t0bXm75M2kJjoJjTnEJ87xSlswpfp9G4
 sAhwgJgp4aMHeISQnF7ixqGnIT7Z1Eu2oBsGE0yZBGF0YXfhXgJyhNwxJhjZ3h0NFSdQ
 Or5ZT+ihFbklad78unl87uELQenQBAes7A836+/guprFI1P5uKWziPzq4m+vFdB8BM0A
 k1Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=woptNqYegtlAA/3EhXiqmTlLN2r1UfDWEk1Rf7o05To=;
 fh=z84zWIL9Yv3jgXDDULXsD2cRBCa/4O3xNtSmhUid50s=;
 b=jr4GD2kGu/D8Oroo/wwhPk0s5UTf2UTlwKicIpjzDIH/0E3XfJtxy7Z5zU8dOjpKL1
 Bqgr0dv+KiXOpVfqZBaM23jUF0Ymic5L3JtOgAAkb3mPYeGPUp7uAh7kZ1nbp9RNnUoU
 5X+MrOGMA4i3zBCJnTApTGUiyZJJcLOGUdy5o49YGuRwZeb/G2iKQbx8J7bzrfx3QDdv
 J2oUbmsS76wJxy1Ydx3vPHe07SU1/E3JNGz3DYKXmkhiweOzn/WCQRiwWtmtcnhHUuYw
 k9fYd8SuITKx2dqovgLTlEf15+nLqTMxnVdRaEpG17ztLyVyuyp+S/aExlx4iGSy6PA5
 dmGw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795555017; x=1796159817;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=woptNqYegtlAA/3EhXiqmTlLN2r1UfDWEk1Rf7o05To=;
 b=XKWeMppo4jz0Gu2jWNsYTrkf08s75ch40HUyxFg4APZlt8LgbCtUwCRXMQxXa3fXnz
 0NAm5wdLQ6O2sLutJFu7nPQ8zXBxrSMTttXyNXGyk8dHN2JJ/i86ct0SPe/4I9b4DPCk
 aThPdlWKle/djrOD21inNt5oe81nLaz6mwsJiUurWEJMpSLq5HtS5m7JwXztP9tT5rxe
 vR+3sCk0P5z5z/AuxacUQH8olNXbrzlTongqobNpmTDdGz7wm9vgKNYA3VE+HqeOWAYL
 8Bwyg13s1q6iibNP4Pcthu+lzOrxXqZiR8U2zGE+D96rRTHmcksj63PXtiTYPXzTDnzj
 ZCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795555017; x=1796159817;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=woptNqYegtlAA/3EhXiqmTlLN2r1UfDWEk1Rf7o05To=;
 b=uCaO1ABtWnEHNr6WYkirNm36Le9HC9GSeuxz1cbPfzyVTmbPBOoCM66DxZoWQ48FNy
 JQYadybWmflU0zxTDrypkFAR17vX4PluxZEkrsBduvL1CROK+mhCHHZFpYyAPgyEmMOj
 dBOfK3hamdVD4AyT+XSEeSgeF4RxMYkk76scM3gu0GASsKh63Dn5D+BE10I8EbNkG+wA
 cQzD+Ts10B8URL99hXhuHiR7xQbCzFZmANqcIr/emYTm3L1gXHw5AC1GlyhfF5BxzJRi
 q95EUj7ry9hUz3n8l+1i0yVNL40pfDuDbMNqldK00wdw7hYvWbrSvtbbg6nSk93cdLjQ
 VpRQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHMcPz8bgBJIlqOUfotA5tEDcuoKrGyKUZvHSA/tMb8CZaPANPLEGHM5XxwwRppkwCL/gKthOYRdmU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/xkjAtmeLwwmDmME9jA3Qo8xIeVhrBWc9pWMzglec6p00ruacP
 2QBqFx11Te2Pa6YZRJCf+EgJ2nF/9RjxrcLlLDkhl57tvK44KGcM4QTIqYrC0lI7nBGDTEsJsLH
 Jc9mSAwsl7HxTFCq9zndL7ETFu9H0lE6hSkiaBX8f
X-Gm-Gg: AZFdTZeR04dU/uP88NSB9Po65yBP5Xh4P1cmbtFV3ykbeAX+GDa53JoNCCkR77YiMnJ
 O7a+ImBOJSMci9o7F6i6qDHj7aeyCu/iZr4jH3kS06nr1243qMMHmVDtnupqkYbMBm9KVMDk3nX
 VuAfxvf6iQ0bj2euHNNQTVk17ArAoFBNNpsoFVcbodjffqEuvfjh75XAlw2/Tf+vrrfZ4EiElby
 UuPhSLPv06VLDtSpDxzVpQ64AhPCMc6/b1lxLpsejwcQ1jSoA9qKOhM4A0Gawh0/IwI8pH6mLVg
 5OhDnVipREYTX9A3TR1E5vF2bzh03PXzAdeZzVLHQVJzqGFQ/+JQ3TI9if+g3MZxQ8i0OA1vvqF
 9ogoQtGlq/Od6MxB3fP2iK0ZLz9th1nOoVtnsVRFUYqY9smE9NggJkTtvhgGxEfE2v6X+FOlpkh
 2+k7RfmPO92Gysa4HZxDj2dg==
X-Received: by 2002:a05:600c:4f0d:b0:4a1:a48c:17eb with SMTP id
 5b1f17b1804b1-4bb916369c4mr5002655e9.11.1795555017146; Tue, 24 Nov 2026
 13:16:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123-feat-udmabuf-huge-pfnmap-v2-0-3254f801fc36@linux.dev>
 <20261123-feat-udmabuf-huge-pfnmap-v2-1-3254f801fc36@linux.dev>
In-Reply-To: <20261123-feat-udmabuf-huge-pfnmap-v2-1-3254f801fc36@linux.dev>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 24 Nov 2026 13:16:45 -0800
X-Gm-Features: Aa3M54o_hbLVSlOG7JsmOAd1qF2KuaOISZwlNoGrfoGShDk7KQSGd0nh9FrptyA
Message-ID: <CABdmKX3_4=HiNZnurUAHcrY5hkFLPrLer-q6cV76FvmJkikmYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dma-buf: align large mappings to PMD boundaries
To: Qiliang Yuan <qiliang.yuan@linux.dev>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Philipp Stanner <phasta@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Shuah Khan <shuah@kernel.org>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Philip Yang <Philip.Yang@amd.com>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Natalie Vock <nat@pixelcluster.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 6:45=E2=80=AFPM Qiliang Yuan <qiliang.yuan@linux.de=
v> wrote:
>
> A dma-buf exporter whose buffer is backed by physically contiguous memory
> can map it with PMDs from a ->huge_fault() handler, which only works wher=
e
> the user address and the buffer offset are aligned alike to PMD_SIZE.
>
> dma_buf_fops has no ->get_unmapped_area(), so mmap() places a dma-buf at
> whatever page aligned address the default allocator returns. A 4 GiB
> udmabuf, for one, lands 616 KiB past a 2 MiB boundary, and then none of
> its PMD-sized ranges can be mapped with a PMD.
>
> Use thp_get_unmapped_area(), as filesystems that support huge mappings
> do. It aligns a mapping that covers at least one whole PMD to the buffer
> offset and leaves smaller mappings where they would be placed anyway.
>
> Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: T.J. Mercier <tjmercier@google.com>
