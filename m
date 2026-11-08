Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCBA606A31A
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 05:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZi0pP1t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E295910E793;
	Sun,  8 Nov 2026 05:35:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2756D10E793
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 05:35:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AF7B64325D;
 Sun,  8 Nov 2026 05:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB2B1F0089F;
 Sun,  8 Nov 2026 05:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794116146;
 bh=CGbkoW7Q1ynTDxMxq7P+eTlmZyORU3fGD+SfZW70720=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jZi0pP1tJ+OF0hMRMpTlgL6no95odTt8tSJnxuk4EHw6lM+DP6Vjv7V7bSO/ARAuN
 z9dNB4pBqfCFJeE/Ca7RjXbBxKAja89rpTl+FN1Nk6djsoU67sgSCumKXHpDHlzTLd
 luELRLfAuvfRNmtj2eUpZEimM9aCKDAUwtACMMNv5M4hpPu69URNhI+pfyBDqfjo+1
 +mS917qHGsFj9MOoXXPtin/9R1REbtRM80GCTi23Tj53s48VKMp4ov28h9jZE2rAyK
 +jVAspJyEVTm3hpJbkmGet/E1EEDW9VkiQ5/4AlvCRSDZ/bHPkVk9EyZd8lI/XrScg
 +BjSy74+ZB7EQ==
Message-ID: <sashiko-outbox-203586@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/amdkfd: handle SVM interval notifier
 registration failures
To: "Aveline Noir" <jm5905938@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261108-kfd-svm-baseline-errors-20261107-v1-1-9ef4008019ab@gmail.com>
References: <20261108-kfd-svm-baseline-errors-20261107-v1-0-9ef4008019ab@gmail.com>
 <20261108-kfd-svm-baseline-errors-20261107-v1-1-9ef4008019ab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 05:35:46 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	SUBJECT_DRUG_GAP_L autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] drm/amdkfd: incorrect address unit in svm_range_restore_pages()
  [1]
--

commit 1895ed01e5a9a263f9ad3ebb51b71149e38c2024
Author: Aveline Noir <jm5905938@gmail.com>

drm/amdkfd: handle SVM interval notifier registration failures

This commit propagates MMU interval notifier registration errors and
registers staged SVM ranges before publishing them to the process SVMS
or handling retry faults.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_svm.c
> index ed5e3318877be..8184cbbb829ef 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c

[ ... ]

> @@ -3203,11 +3235,11 @@ svm_range_restore_pages(struct amdgpu_device *ade=
v, unsigned int pasid,
>  			goto retry_write_locked;
>  		}
>  		prange =3D svm_range_create_unregistered_range(node, p, mm, addr);
> -		if (!prange) {
> +		if (IS_ERR_OR_NULL(prange)) {
>  			pr_debug("failed to create unregistered range svms 0x%p address [0x%l=
lx]\n",
>  				 svms, addr);
>  			mmap_write_downgrade(mm);
> -			r =3D -EFAULT;
> +			r =3D prange ? PTR_ERR(prange) : -EFAULT;
>  			goto out_unlock_svms;
>  		}
>  	}

[Severity: High]
This problem wasn't introduced by this patch, but does
svm_range_restore_pages() pass a page number instead of a byte address to
amdgpu_gmc_filter_faults_remove() [1]?

amdgpu_vm_handle_fault() passes addr >> PAGE_SHIFT into
svm_range_restore_pages(), which then passes addr unchanged to
amdgpu_gmc_filter_faults_remove() on the -EAGAIN exit path (and when
svm_range_skip_recover() returns true):

drivers/gpu/drm/amd/amdkfd/kfd_svm.c:svm_range_restore_pages() {
	...
	if (r =3D=3D -EAGAIN) {
		pr_debug("recover vm fault later\n");
		amdgpu_gmc_filter_faults_remove(node->adev, addr, pasid);
		r =3D 0;
	}
}

amdgpu_gmc_filter_faults_remove() hashes its address argument via
amdgpu_gmc_fault_key(addr, pasid), which expects the page-aligned byte
address that amdgpu_gmc_filter_faults() originally inserted.  Passing the
shifted page number produces a mismatched key, so the fault entry is never
removed from the hardware fault filter and subsequent retries of the fault
are suppressed, leading to unrecoverable page faults and GPU hangs.

[1] https://sashiko.dev/#/bug/linux-c3a1de9c-2a28-405f-a897-3418639e7854

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-kfd-svm-ba=
seline-errors-20261107-v1-0-9ef4008019ab@gmail.com?part=3D1
