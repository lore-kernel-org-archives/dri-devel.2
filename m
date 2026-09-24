Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F78EC98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07A4210F906;
	Fri, 25 Sep 2026 07:30:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="QzmQybcC";
	dkim-atps=neutral
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com
 [74.125.230.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C943210F6A5
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 17:17:31 +0000 (UTC)
Received: by mail-qk2-f12.google.com with SMTP id
 d75a77b69052e-53122c5bbb4so549721cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 10:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1790270251; x=1790875051; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=feTLx7y3sxZ57LB+c+M8YbdddVhljMzyHzPRAu6TpA4=;
 b=QzmQybcCEaWPPQg6fwtCpnGIr9L98uYqm+8NlAJ+3DTFOFPafcxMQhNmeUYuFT48xs
 zoF72mpgEckCkYT4s+CkE4HZQN68rtmVOqHPQz+u+PDzHTKXOmiQYEcJfKh50h/L8n2l
 uXZmvHQY9UeOkDDcC344meazC6ygldKaWCbV5AU4wO5aDhe1AKe2eUsKTjRaSvfyeTeo
 e5sIQWApeyKUsBXlDkIRZul4s0/m+Kpeztj8GA2ft4S1Xa6M0zNLb8ghMc5t8i5auz+f
 2n04a0GzKP2glVWhkETfhuoxgiF04O96b6gsp0S1mXWVqmxAu4i2jkaMpSO2kEPc/QZi
 khlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790270251; x=1790875051;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=feTLx7y3sxZ57LB+c+M8YbdddVhljMzyHzPRAu6TpA4=;
 b=VORe+t0Uo1jdT8YiGjuxqPNQkWu90Spvu2qWTnkYHwFpDxF2BPtYE+VHRv0SeP92V3
 154YnGnNxC8BOQaGfXUWQI82TNDnBr2CzWuAFAa4qLeF5IJ48fMROHhxnGxg2rIGkqoY
 nDJCGCiz3Tis7DanVE7M1ev16APCEExhvlKN+curL4tEeHXSQz8Sfk4fOnoLyqGv5icj
 sK3WH7Dayga4Or2Xt0r7HT+2BrN8JWJ0oUg+ZHL4qeCDPz8wR/gsOK1mEv/qeDSTQzQ1
 64sy6SgVi08cZT5nUufzszBGu/hgrezvpR5D/NNb/XPKoykLe2oufsAwTirmvlbwnmFn
 xasg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxA+ckCJQMrN4iYcVC5n3qjKz9TAPL5fBXhfCHiaYLo6K+7Ij9ePyyrCl7kXvikjFi51F19+8TcqNI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nf07MEJTNyPsGSNUxGJbKJ+7Zbb9fIqWDbgdNiePPD9OcRGWF/
 2fHG2qeBvegBi030V7teKybESCeYG0J4XFTvBdXk1YJ/WO9E7fPvNejpChCw7+Di56E=
X-Gm-Gg: AYBFou09V+BVXuB9Rzjs8NEqTybxP41X/3x38uj7ERzDarx6ZVVgh1cLJShyXMSqGd9
 n29MwNIBK8tcjIPXQEpdi5qT70ZhP8rmeZRYROwXZnDM5PHN69rLDLxc0HMbJIfqoxoinBdOVwY
 j4CFGDFB10u7FxV5y3wzwx38vRkT1GDqvq/TbrI0gewSRQ/ZM5eq/l/YYtbskS16vFQUF8UnKTT
 ENFD4BzTpmwu1mBPRU+dO67tPh8x6U5VenDdoKtT7xLPPXCRql1rGQTrwjKmAuEq0R55PH08eLQ
 6ZVp/HEzwm1QV6URPeGWSR370Xd3LrDZNLZaeQm+Nh4g/SrXaS+G4J/yLFUQW3/gdk46gLW6T/D
 LcVDKnlxdRJhnsIve9GJPlW4UPEeIzIHSo9wv7wZoffvJ/appvbolzmrSFWLbu0twgFGuRHdlf/
 BOeCsZmvq67ryAguAHq0rwtptT6ql8jGhbfS8msSgJph8y4A5rkojPb/yVQnE1Y+4WrfblmYo85
 bRNTIgcbQ3u13X5IDx+rKaK7YiU20BvA8VRNJxzCLDDU8xuEoXepoY=
X-Received: by 2002:a05:622a:2b05:b0:530:42e4:f001 with SMTP id
 d75a77b69052e-532feb3025amr31555731cf.46.1790270250746; 
 Thu, 24 Sep 2026 10:17:30 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-532f8b7174asm25743881cf.14.2026.09.24.10.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 10:17:30 -0700 (PDT)
Date: Thu, 24 Sep 2026 13:17:28 -0400
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
Subject: Re: [PATCH v3 04/40] mm: consistently validate VMA state after
 mmap[_prepare] hooks
Message-ID: <arVW5i8pvySq6Co2@gourry-fedora-PF4VCD3F>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-4-4583d8a23bca@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-4-4583d8a23bca@kernel.org>
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

On Thu, Sep 17, 2026 at 05:22:13PM +0100, Lorenzo Stoakes (ARM) wrote:
>  static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
>  {
...
> +	err = mmap_hook_validate(prev_start, prev_end, &prev_flags, vma);
> +	if (unlikely(err)) {
> +		vma->vm_start = prev_start;
> +		vma->vm_end = prev_end;
> +		vma_close(vma);
>  	}
> +
> +	return err;
>  }
>  

I indepdeantly validated the sashiko report on this chunk.  Seems like
close() should be deferred until after __map_new_file_vma() calls
unmap_region().

suggested fix is to drop vma_close() from mmap_file()  and update the
cleanup in __mmap_new_file_vma() 

if (error) {
	UNMAP_STATE(unmap, vmi, vma, vma->vm_start, vma->vm_end,
		    map->prev, map->next);
	vma_iter_set(vmi, vma->vm_end);
	unmap_region(&unmap);

	/* Release driver state only after its mappings are gone. */
	vma_close(vma);

	if (map_same_file(map))
		fput(map->vm_file);
	vma->vm_file = NULL;

	return error;
}

Example race:

  Thread A                              Thread B

  mmap(MAP_FIXED, address A)
    driver remap_pfn_range(A, page P)
                                         load/store at known address A
                                         hardware finds the new present PTE
    validation fails
    ->close() frees page P
                                         UAF
    unmap_region()
    TLB shootdown

With that fix

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

~Gregory

