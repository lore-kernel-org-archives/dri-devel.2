Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AEF606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 23:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WTLU51De
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B71F10E442;
	Tue,  3 Nov 2026 23:50:08 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 782BE10E442
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 23:50:01 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a018493d57so25175e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 15:50:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793749800; cv=none;
 d=google.com; s=arc-20260327;
 b=TmxTOKyJ235xpMsEzeGsnizbVDv9svd/LajtMPc+szjVn3KiNO1eL2jMT1hzVS2Vuz
 O419SHO1aQnby4+y+SPS8xYbMBhvX7eUr81l+nLes94aOHsD+M79RixtHrDkKmCS75dB
 UkrJMKOgD4GtiRhRrcyct1tGTT9QaEV03UVCbmKlG9IRDzfWp1z61kyLXRPRkbnqmOGv
 TKWyJ7Z3K65cBtour8CjGo0Z3KIz4tEL5gWZN22nXTDM4t/0Yq425+nx2O7dTRSWEsM7
 tz6FUbjLFXsQj3djx+0BFaevgiVt9h8j46Z0pwt/DwAcl9CL3eHN4ZQdN2ymOZdulsgj
 onhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2LyDKxPm7BmS9aARoXNEEpr8AzutCEsbFkZ2B7a7nyg=;
 fh=NqdZ3GMgMrh7tze9aqMIgLeMZLak7pW1CGqeAv1fcUQ=;
 b=BHHcOFb+e97k4F6TrxR7CkwqhpJ3W/FiNImmd0Hpa2e25R05g+Sbj43eory1vNFMKH
 3Y+EX/4d6qtAvFtn9iT3lXqX0UcqC8bsMnZw8hHOR/Y3tjdcqWgfLe5MYNLFdcZeDduc
 An69x/2mzo20UbjrklJb/zdA3fXWm9PBK5ueVvVJ+xsxQ1H1Kvim4/c8NM9QzvDX36p2
 zDSiEpuZqSJ5QHXM0DHoBDeXe3Rb10somN6djEkIBN4vUXGk9fRD9VmOaxTx9JnE74QA
 nOd9joEjRGIBn8jWYCjxerbkW/YcwDwvc5ldSWIx/sxJxf8tgAcA+TZKCiOgWw8yO21U
 1/kQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793749800; x=1794354600;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2LyDKxPm7BmS9aARoXNEEpr8AzutCEsbFkZ2B7a7nyg=;
 b=WTLU51Dea1QQhMN5cT0I/57iZF45Pa6ZnX1es9h/q5UUChWfwBgCqRDFop0hAH+urE
 fUVfTBzoq5ynrquXrsygEL1qQtgrcCAKf5RU3tWt1xnIcythyVAJBvZXZHAC0Ze18A2E
 d89ZBzRPN+aZGRz2o9+UR1+S92XF73gxAoXj+IuHBuJvJqbbXq59FMAFAa8OrTMoqdz9
 x4a9xOgqtH9vKMO5ePurJoVtmoc2tCQTW5enas+gJPMRdZnsa8TETzADPLGUxEr9WTQv
 3AkpASc530wgsmCi2AV61Ds6nXkS/LBJ/eqWZJTGKQn4iTwNeFD4DCDFtcxAL7glt9FV
 VTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793749800; x=1794354600;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2LyDKxPm7BmS9aARoXNEEpr8AzutCEsbFkZ2B7a7nyg=;
 b=XC/6B4OMvak/M7aIptpJcdXTdon55Toxjt7kAvn7y0jDaEGrPI+mFdjHXSwbeDhm90
 8g9wRUqJLDgtAq8lz2lhzSB59PY420KwU7gX3NP8iOEQpJ1E0nIWcSkhgCToXVe6l3jy
 zRUzhPMnTjN7tat0ALPCLRdwzT2XFuhXsACJtJkPl1itQ1aqriZu6XaZO/H7zK0M5rQo
 S/NLRw/qDmg8Qh5ZLkEkqfjITTOBilugFFRijvAH/BBovUorE1xnqkutbO33wDWhWvqY
 NnAWGAAMxUMV4cwI28i/WLim9bCjyPIGDyv7et0H9tN/zOseI/8qJerjzpBSSid/ylKO
 koTA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxISf9gSmTAKBODFx8Zzsb1W+zK9b7QTGj2zCFNrU2l8rOLz1TcPtQp1Xk+Le4PC1WwdMfFFRCb8j8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8V3wVs+jOqFBHuEy9O99hX+LX+fEYXxTUs5L1YdqjH53+X32MF
 oy3fNUAQc1xomw8x6Za6uCWWI4P8uDhXvJQWZW2vqAOnm+i6t3cc5PsE2xl0Q3txPScpjBBDSWJ
 Z+T6T1qskjb2tNImq0Cnqqe/zGlwRjZmU3PZEWX/M
X-Gm-Gg: AYBFou3cgvFTRDgIuzZr9QeA9l4J0fy2LSdyGORoz23ef2finOv3Kxkxo3W6pTLIK8y
 wpNbD+xBBjQksVAfSawxuBZQq51MUCUGQVFneCQznbY60iRTwSN7XuV4rkdrtb45lLRJWlwHlii
 wMwMOz+RvySYv6TrXAxVcz2sCaT0hOrRq60g+Aag47nNl4DA1bFJJpjKUUL5WRfTijcVVfhyTi2
 1xk4w+pQ8PiR9DKjXJxZyQxIwJUlN4/5QeK6ByjRb1QGWKwIUv1asfnmhRZ9qhtUrphPNjWIkIM
 kwICxA2iHp+AN/6opzafk6BpQwivM1v0azbrJsA5clRmKmatNQPm0kYXeP0mmSdgSjyT9o7XaZj
 R/K4r17y1nw3PRXgx/2157lNLWqEwaRDpicxEwkDj4WSsS2WpP+eysINt4ircVDD54w9Td7GwGG
 JBGlrkrPT+7mVSpGh1vNuVCa0=
X-Received: by 2002:a05:600c:5799:b0:4a1:eb11:489d with SMTP id
 5b1f17b1804b1-4b4606a61f5mr16595e9.16.1793749799475; Tue, 03 Nov 2026
 15:49:59 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <18e445c150434665.3137322e32332e3235332e313736.109a67.0000sendgmr@google.com>
In-Reply-To: <18e445c150434665.3137322e32332e3235332e313736.109a67.0000sendgmr@google.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 3 Nov 2026 15:49:47 -0800
X-Gm-Features: AclHuK8ZKLm3rVsIDA_wL7c0dXQT21arwcYZtB_K4EiOQaTULkyqjY3FAmPFPP4
Message-ID: <CABdmKX0h5Vv2cFHRksJx3hHn5c3aBqbmiTASk5GKn3BqUO4Vbw@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: Reject private mappings in
 dma_buf_mmap_internal() and dma_buf_mmap()
To: Chris Wiseman <chriswiseman@google.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 John Stultz <jstultz@google.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 Philipp Stanner <phasta@kernel.org>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org
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

On Mon, Nov 2, 2026 at 8:00=E2=80=AFAM Chris Wiseman <chriswiseman@google.c=
om> wrote:
>
> DMA-BUF mappings do not support copy-on-write.  Mapping a dma-buf with
> MAP_PRIVATE and PROT_WRITE faults into do_wp_page() -> wp_page_copy()
> and allocates private anonymous pages whose writes never reach the
> underlying buffer.
>
> Individual exporters like cma_heap_mmap(), system_heap_mmap(), and
> mmap_udmabuf() already require (VM_SHARED | VM_MAYSHARE), and DRM
> helpers like ttm_bo_mmap_obj() and drm_gem_shmem_object_mmap() reject
> vma_is_cow_mapping(vma).  However, dma_buf_mmap_internal() and
> dma_buf_mmap() do not check for this and pass MAP_PRIVATE mappings
> straight through to dmabuf->ops->mmap().
>
> Reject mappings with -EINVAL in both dma_buf_mmap_internal() and
> dma_buf_mmap() when neither VM_SHARED nor VM_MAYSHARE is set.  Checking
> both flags still allows read-only MAP_SHARED mappings, where do_mmap()
> clears VM_SHARED and leaves VM_MAYSHARE set.
>
> Suggested-by: T.J. Mercier <tjmercier@google.com>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Chris Wiseman <chriswiseman@google.com>

I really hope nobody is trying to CoW with dma-bufs.

Reviewed-by: T.J. Mercier <tjmercier@google.com>
