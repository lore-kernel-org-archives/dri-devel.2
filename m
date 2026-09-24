Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB50C98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 570C510F8EA;
	Fri, 25 Sep 2026 07:30:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="oyLtJ6pW";
	dkim-atps=neutral
Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com
 [74.125.230.233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C6B210E18B
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 16:38:12 +0000 (UTC)
Received: by mail-qk2-f41.google.com with SMTP id
 d75a77b69052e-532e91a3687so105061cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1790267891; x=1790872691; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LuPrvXBzY5FQ+f/5fzbveR9yF272P1V2+jsIcGJNdC0=;
 b=oyLtJ6pWfZOGFGj2JeXI5d0I2eUB5psGCC2b3F7mLZWA1K69oPZZMT2gCUPIO4q8lc
 ch8f4ikZGtfZbtnH0vUkUL4wr/MavYiXtjtEm7ojSALRNyHeDxzF6/d1pxzw/SQKdg6d
 hLlpfFVXmSj2TEOytixdcTuhAozefjnSwkWfvTZPza4wdQw7ME8JUJu3e7J4YKMsGuW2
 D8HLDz1zqKugT9g8MZyYFRkLVpO/zOGGYBw/rkeMgtmQoAte74/1J4/CHVs5o2rU+eUI
 HrMNMSXl31Hb95Qt/XhgcVj1KqQUs34TzlfiRgC7OSGjuevfMO/p+494xWw1wjigk5FD
 BCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790267891; x=1790872691;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LuPrvXBzY5FQ+f/5fzbveR9yF272P1V2+jsIcGJNdC0=;
 b=ZMzqMlqZjOXOoDzvoTJUlvf8fPsmvdjmyqU9gKX+IM+4nJgcMDa7512rC9geycNpxY
 UgDV7noFBGSf6n1EFGLLXaqJjcVYKHd96RV7NQYy0dpXcDDdDPKS1Ar5oxgGBHuSI4Yh
 jo3mBLNyzMFyFFODR1n2jWQIMtHN/Qlhko3qT6lWyBJEeVvEMa+1XSlS6GO9a4yGzsgW
 Ewr3pZWvw1qQqkeXGZdCuCU0SmqQo0gvxuBBMrM95K9syNP2crBUKni4jdfscIKSjOoN
 ttictnhV/sU6N3m2gdD/qUJHuwADYnYEp9LtuKyyyt7eCH7M2y7vWDCmOHo6HtRjFOG0
 op7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIPYyQgYSNnIhlzD6OZFRaLqZgr6Pdrqa/kEb/0In0L/v35RTQ/08qPFzXzRICgFU2D3z0GgqTMrg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lMsYhT93krVs/Q+vvDVYGCuVfGKrSsWVvZn1KJeRnb+O6w8TsO
 lnPrCHjp9pMGhyNPNkQ7dGiq20yg11NYVjUjFxFDgHV+2fVjamVMt9GtgJvodqBYnCw=
X-Gm-Gg: AYBFou3yGJyXs26VZZH75bYHc833/LoS4DHOzhZ0ZLdbxqa0sOqJxuwbbmkKNbORcD4
 rVz9Q2fWacfOyf1d6ptCQmbkcKnYnNGPqVc4Q6WHsS8zWw466/cpt0xYxDC010I7vuBU3Dk6yk0
 5duyXGZHEJOI1Bf8n44VuuyER8gw1kUVAri3ltDqI+GjDzJFVI9Rk3Hs0VazKn+WIc+VWf/9L17
 Sh9oQNn4DOem57v1lHvy1KqL7+XN0RO9+VbDi4Y8mOvvNtErIVD7gnmWG5sX/2KGwlwCr45plJ/
 4Nhfb8cPWnfPawI3TfU5jTRODNKTEnTQEm3byKoj8Rov2Xehgz+YPWwdVCEkbnVSsVX5YByBTWo
 puYo+y31v/GfuAmp+T3N9YVtHCTHMi++QHHKG/0s+t3ox/J60UyDfbn5SCEzuU5swGEz9o6A7Eu
 Kcdip/YcOkAf76L0aV8xUn2glcKce+TZjz4BxvH3D9Ax/OzcVNyf500CMor1BuKsJY1bdfDR9Km
 zp2sNNojRmUMeqASFF5EPEEtNdQLAKqXZ/WU8Xj0umfikwvfNmVsvA=
X-Received: by 2002:ac8:5743:0:b0:530:d860:ffba with SMTP id
 d75a77b69052e-532fe9f05bamr29797891cf.6.1790267890993; 
 Thu, 24 Sep 2026 09:38:10 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-532eb32f6aasm45064551cf.16.2026.09.24.09.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 09:38:10 -0700 (PDT)
Date: Thu, 24 Sep 2026 12:38:08 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-usb@vger.kernel.org, 
 linux-rdma@vger.kernel.org, selinux@vger.kernel.org,
 linux-sound@vger.kernel.org, 
 bpf@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 fuse-devel@lists.linux.dev
Subject: Re: [PATCH v3 03/40] mm/vma: introduce and use vma_[flags_]can_merge()
Message-ID: <arVRqJZkql6sGunt@gourry-fedora-PF4VCD3F>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-3-4583d8a23bca@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-3-4583d8a23bca@kernel.org>
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, Sep 17, 2026 at 05:22:12PM +0100, Lorenzo Stoakes (ARM) wrote:
> Replace the open-coded VMA_SPECIAL_FLAGS check in the VMA merge logic with
> two new functions vma_flags_can_merge() and vma_can_merge() and update the
> merge logic to use the former.
> 
> This abstracts the check and expresses it in terms of the desired behaviour
> rather than an arbitrary and confusing VMA flag.
> 
> This also lays the groundwork for making further improvements in VMA flag
> usage.
> 
> Also update the userland VMA tests to reflect the change.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

