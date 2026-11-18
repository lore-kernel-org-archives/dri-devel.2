Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AF7606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=Bh3Dna/U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D90A10FC5D;
	Wed, 18 Nov 2026 13:15:38 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F97510FC5D
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:15:31 +0000 (UTC)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-3ab3b29a298so10036991fa.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 05:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli.us; s=google; t=1795007730; x=1795612530; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/TyJXkm2vpWoT51loq346JyUhuDruv4LPJ1ahbEZXZ4=;
 b=Bh3Dna/UpnEczy/bAgabMAySpsUQuvUrWmDp/Yn3JprcNtW8iKYX9HtFKtd8nEzRGY
 zTFpaHCCaQpaiAp/mtRzezYvsXqY0XQGNHPDFs/lUzZJObCU3UFNyWFPnppaf1zV0IUC
 4acsMfnyoNoUVIIszQG8lTDCQR/turG3ixMdIYfdzzCiY5+GVm8sgAuiVWIk2ygtjSEv
 QQ0GUD0pdXUgOM4WiZkJAEXHO79Tx/VLYQE7OLIKAtEiLwfPPap10F5J3dJwve9Duedw
 G9kWEDDXLGt8jE/YU4KivQElRMAaIYcVqhmMT4bn0E2NwC5WNEqRCLgVgVuamUYtHDax
 9nxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795007730; x=1795612530;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/TyJXkm2vpWoT51loq346JyUhuDruv4LPJ1ahbEZXZ4=;
 b=TvoOPdlREjVnCWNPMsecCY0q1LRWD3fw8odvK3HlZSGum4k9KgKfdBx1Mg5wBhC1/L
 KZL48E0eklvfwdB41JxdPmHyFDF++V+p2BzmEY8eISH0AsFa9k80KczhphFz0lL/Ee3Q
 frTP8oKLU4U7nfReZEqn/5ia02p/5zPQX2Fo346LcgoUTVxiO47oTvCh92lx/YBTuW1C
 NQ2Uqu/xWyAWz4N+/Riy5deHqEFbMrHhe78buwDD6lBxu18ktkx2GNci3dfw9wgZpo4d
 DAOjoQ3NIMEqoFRQHIlarKeQ2TgJes/cqbbUHOrcNsK9Sk2x10hzdbKgB+mbqJMrFREB
 GwVg==
X-Forwarded-Encrypted: i=1;
 AL+hErGj/BWRXPh57wxR1ktaKWxUO9xRETiufCTa21qtdr/jthnjF/JCEwa6xBF/nBtMGMecFXrMIjKeAyA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+H7LlPrvEOOF84BAlHR24pOCgGll6h+RliA/pQ0Fo6rXdVGHf2
 XHwKsibxL1uQEgnakKP0ycSBrbNpLpwMcmTqkx1CH+iBcqt96VAl41I+2zV4zlcR5Yw=
X-Gm-Gg: AYBFou0NGkOTNN/KnL7M7D+oiQu4JQToLEysbReUOqZvAvVdJnm/tqW6jWCjU4uS/vn
 W157W+mwB2vubOwKxqv73s/ql/8Xj3MFJFYdfcob/mYUaXbeV2OvYtGHKbVL7oBDG9XJMV6aOWV
 kvLT6QMFBNGA809n9piz/bp+VRFIkCPF3uEZC6r/sJ8szR5QyXBQ1/eNaKJng5pbKZ0SpbDo9Kn
 fySCN0aYHquLNJvBaNMFzV5yuRSUA+iI8efL56YQqZ1RnClsG6irax1j8JU73Tr5vYO5C2j1esF
 Ej1AUkU8YkJub8m4yo7oUCsNKhn1nejiPOWZYurvUJtSoPzXFDVp3UEAuGt7cIxC7o4uSyRl01b
 7/OWQeMqvXUbkoVIF10M7xMXSJvr0mUqrietem8stTR0eSFg4VC6ofiQG3193m5dBIpzCmpuPvG
 VIYA8lbdaKcIhvi3n9WCqDizU9C74xLydEe22JP2CWpEfscNSt4nePYPPKLfg/fncnaYv2pITTs
 YE+94No8qaryxwr6R+AN5mSQkYUQ3beX0jSRwNB7750H7mR2GROT1faETY7thbg7BIIZQl8O2Us
 t5q06ylsH4XNRAGqB3BoTBsjWe5Kp6iTQqXWUl76g40Ow+/3YspSBtGbKhrvvg==
X-Received: by 2002:a05:651c:a148:b0:3ab:3607:df9e with SMTP id
 38308e7fff4ca-3ae670d1664mr9301141fa.13.1795007729556; 
 Wed, 18 Nov 2026 05:15:29 -0800 (PST)
Received: from localhost ([140.209.217.211]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae67a38db8sm5617761fa.4.2026.11.18.05.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 05:15:26 -0800 (PST)
Date: Wed, 18 Nov 2026 14:15:21 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Ying Xiao <eagleshaw@google.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
 "T . J . Mercier" <tjmercier@google.com>, Jiri Pirko <jiri@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, 
 Jacob Moroni <jmoroni@google.com>, Xuehao Hu <xuehaohu@google.com>,
 dri-devel@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-buf: heaps: system: zero pages after
 set_memory_decrypted()
Message-ID: <av2jgIDyawKNS1BA@FV6GYCPJ69>
References: <20261117155431.1654298-1-eagleshaw@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117155431.1654298-1-eagleshaw@google.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Tue, Nov 17, 2026 at 04:54:31PM +0100, eagleshaw@google.com wrote:
>system_heap_allocate() allocates pages via order_flags[] with __GFP_ZERO
>while the direct map still has the memory encryption bit set. For the
>system_cc_shared heap, set_memory_decrypted() subsequently clears the
>encryption bit without re-zeroing, leaving ciphertext in DRAM on
>confidential computing (CoCo) guests instead of plaintext zeros.
>
>Skip __GFP_ZERO during alloc_pages() for cc_shared allocations, and zero
>the pages once in system_heap_set_page_decrypted() after
>set_memory_decrypted() succeeds.
>
>Fixes: 78b30c50a7ac ("dma-buf: heaps: system: add system_cc_shared heap for explicitly shared memory")
>Reviewed-by: Jacob Moroni <jmoroni@google.com>
>Signed-off-by: Ying Xiao <eagleshaw@google.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
