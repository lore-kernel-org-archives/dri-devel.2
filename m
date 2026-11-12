Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17165606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 21:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7580310EBD1;
	Thu, 12 Nov 2026 21:20:41 +0000 (UTC)
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com
 [74.125.224.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BDEA10EBD1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 21:20:40 +0000 (UTC)
Received: by mail-yx1-f48.google.com with SMTP id
 956f58d0204a3-67be4f2f4d4so296963d50.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 13:20:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794518439; x=1795123239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4lVRI4+WeL0K1LHsrLPYLei1kIG9yDeeWj6koWi/zHw=;
 b=qv9Xnv7nOeZlwuzWNADRBYt656unQsYYcG7espSxcrC9WteJWQ1+0SY1CTlnIAl121
 FD/No3fWX4KWxUUBb8w5r+3lwPy7qlS1N5FVXiPtsw2VGX7zN05IYBVVNspsXjNEHDEO
 I+G63hbxpmImRngV7hGhFVSC7xvHQXt3fzaYzszB0O+F27hfp60ONLJYr3zHDucFPpB5
 +zl52iqQmQ5v+Wy9X4QVqZxeY+N6YuLqSARCAUOTZ4WubtvDTZXi93GxymE4dnJNHH3q
 uivl7YAQe7dUlskaRdHSQUcbXHs4zxOWaSgjq5mDsNXKEHsnuNHW7l6aAwr0aDf6dRus
 0p+Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFv/t1FlEqN57BGcNVnDjDmp8HB4b2V2EwzPrC311bZz8ZI0Iqfx/U4Zt/gPDnp2kXi1aVCHQQQh90=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9oSxNAEgB4s9JSdj4FJDgMSBqD5DWgDGNI9nj3WgRBcgH3PZIj
 wnXxTPjRdd2ZDDeIxT9cvfqsjhfCYbC/wP6YPBswncQHo9v8dxksbT2j
X-Gm-Gg: AYBFou0phaDjsf/WeEat1QG4R/jaRPyoR4PoAE/4X4vb9gsQ0idA/1TVYIcuAyqU8Ju
 rCJNz9O7OGtPnJvZ4rjehVDCH54d/x97Et7HfPSF5paqxPpdtUj0zVhxcNFSoq3RG5InVFXTulW
 xzWKKINWGiiZ09wCQut3iagoIxB6QmkMgJhDAZ3fxYuV9b5jLNMIB4VPohCFBIhRIHZgR5lAh09
 xm9uCH0cqY6qkFsA4MFEwGU3m3yDunvdVvYsgLicrC2RPIVjOkrFBC4mwUYa8CtBSR/siGbcgni
 4GMDy6+2PAVMgJDXXt2Nov37Ox1aTTQER0kFotcLalS13W/j3M9RaWTzgkIgRrLlZHv8CxeoZD8
 rnKOlds4lEApH856rtPMAiVh7/aXFuM0MTsn1pOl7nKje8sQx1tBkmw3KB+hltDOnCNgyUGzdsU
 DcXsItwqS9JGdyIhH5Zec9gQ3h0kQpZvKTGF64AZCeeAXnt9OA+C1kgWElAQwxpEMcjCH17bNsa
 /yKnhy0UPcF0m7dQmmtVtOG7GIC4HF2t62GbIhf3/N0WH6GUmRCoU+SXwDn+4bkyAiHAknulXQB
 z9EWrOHj1O/crdIIn+oOb1D4MEDVyY/894nA5ABrcPlyn9H5+F3JpoetrFBrKFDYOJJPI/cvx6I
 cgsYmOTxP5BFk0l0pictlS/PKyGfF2Zc=
X-Received: by 2002:a05:690c:94:b0:8b1:a24b:fa51 with SMTP id
 00721157ae682-8b4aa2a7bf0mr4250717b3.17.1794518439196; 
 Thu, 12 Nov 2026 13:20:39 -0800 (PST)
Received: from localhost.localdomain ([71.68.170.161])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa67085bsm6051947b3.0.2026.11.12.13.20.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 13:20:38 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
To: Gabriel Gama <operatingsystemsdepression@gmail.com>
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH v2 3/6] drm/gma500: Fix SGX page-table cache-flush
 mapping lifetime
Date: Thu, 12 Nov 2026 16:20:29 -0500
Message-ID: <20261112212032.10576-1-joseph@telaak.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261109063303.32658-4-operatingsystemsdepression@gmail.com>
References: <20261109063303.32658-1-operatingsystemsdepression@gmail.com>
 <20261109063303.32658-4-operatingsystemsdepression@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 03:33:00AM -0300, Gabriel Gama wrote:
> -		kunmap_atomic((void *) v);
> -
>  		if (pd->hw_context != -1) {
>  			psb_mmu_clflush(pd->driver, (void *)&v[index]);
>  			atomic_set(&pd->driver->needs_tlbflush, 1);
>  		}
> +		kunmap_local(v);

Looks right. One concrete trigger is a 32-bit HIGHMEM kernel with
CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP: kmap_atomic() then maps even the
lowmem PD page through a fixmap slot, so the clflush after the unmap
hits a cleared PTE. It might be worth naming in the message.

The clflush_count change is a separate fix. I'd split it out, or at
least mention it in the subject.

The Fixes tag is right: 8c8f1c958ab5 added both.
