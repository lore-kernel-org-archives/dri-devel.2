Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0655C44511
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:46:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF11B10E02F;
	Thu, 16 Jul 2026 15:46:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FSvu2mcB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E6FD10E02F
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 15:46:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4AB7142BA1;
 Thu, 16 Jul 2026 15:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1151F000E9;
 Thu, 16 Jul 2026 15:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784216788;
 bh=aDaQrJ9mCaIviF1qG7a4/qV1rgG8vMyEjhK4HreSyIc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FSvu2mcB93gTRS7H+LHcsGR/3IoEIKKcOWPA9dzq3MBdhpbOqLR59+XB42S7vaCM0
 TPYj2SfAiYS1+SkuCvDLy2G5VQ2ZWUX0WH8jRjTmhPqLYyIGeLhzIiB+BmWz6TZmsK
 Z9UT5Q3T8De2vJs2Sx+3uzPMVn3Rf65+XWzw/1UVmUeCIrQnM19jbFnvyXQluTCTq3
 DfOKVsNlRt5Ti7A+1KqOth6jGfcyvJDmG7JU/U9LHO+Nr5dXkfsD5zu1z2Ruj03RwE
 6rhG870wv/kltogEsVbNdLZFHH+gA7Wtz7bEr0oMzoWMXouua2mFbyECIyq22CopAb
 3lI1gkiqx+nLw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 09/11] selftests/kvm: gmem_provider KVM-only tests
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org, kvm@vger.kernel.org
In-Reply-To: <7022c98bc66214bf02334d648ec0fd4d296c6c14.1784194290.git.dwmw@amazon.co.uk>
References: <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>
 <7022c98bc66214bf02334d648ec0fd4d296c6c14.1784194290.git.dwmw@amazon.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 15:46:27 +0000
Message-Id: <20260716154627.CC1151F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The test does not check for partial completion of KVM_SEV_SNP_LA=
UNCH_UPDATE, leading to potentially silent incomplete memory initialization.
- [Medium] The test fails to assert KVM_EXIT_MEMORY_FAULT on the revoke pat=
h because the validation is placed in an unreachable 'else' branch.
--

--- Patch [9]: [RFC PATCH 09/11] selftests/kvm: gmem_provider KVM-only test=
s ---
commit 93ae3986a0340a4d14084b20d7839ed583b0c01b
Author: David Woodhouse <dwmw@amazon.co.uk>

selftests/kvm: gmem_provider KVM-only tests

Three selftests that exercise the guest_memfd provider ABI purely from
the KVM side (no iommufd, no assigned devices). These tests verify the
live-update survivability, hugepage mappings, and memory revocation.

> diff --git a/tools/testing/selftests/kvm/x86/gmem_provider_revoke_test.c =
b/tools/testing/selftests/kvm/x86/gmem_provider_revoke_test.c
> index 0000000000000..7e711ea526748 100644
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/gmem_provider_revoke_test.c
[ ... ]
> +	/* 2) Revoke: mark absent and zap the guest NPT (provider->KVM). */
> +	req =3D (struct gmem_provider_present){ .offset =3D 0, .len =3D 4096, .=
present =3D 0 };
> +	r =3D ioctl(gmem_fd, GMEM_PROVIDER_SET_PRESENT, &req);
> +	TEST_ASSERT(!r, "revoke ioctl failed, errno %d", errno);
> +
> +	/* 3) Guest re-reads -> re-fault into absent get_pfn -> must NOT see MA=
GIC. */
> +	r =3D _vcpu_run(vcpu);
> +	if (r) {
> +		pr_info("revoked: vcpu_run failed (errno %d) -- guest faulted, as expe=
cted\n",
> +			errno);
> +	} else {
> +		TEST_ASSERT(vcpu->run->exit_reason =3D=3D KVM_EXIT_MEMORY_FAULT,
> +			    "revoked: expected fault or KVM_EXIT_MEMORY_FAULT, got %u (%s)",
> +			    vcpu->run->exit_reason,
> +			    exit_reason_str(vcpu->run->exit_reason));
> +		pr_info("revoked: KVM_EXIT_MEMORY_FAULT as expected\n");
> +	}

[Severity: Medium]
Since KVM_EXIT_MEMORY_FAULT always causes the KVM_RUN ioctl to return -1
with errno EFAULT, won't _vcpu_run(vcpu) return a non-zero value here?

If so, this execution path would take the if (r) branch, completely bypassi=
ng
the exit reason validation in the else block. Should this check be moved or
adjusted to properly assert that the exit reason is indeed
KVM_EXIT_MEMORY_FAULT?

> +
> +	/* 4) Restore: mark present again. */
> +	req.present =3D 1;
> +	r =3D ioctl(gmem_fd, GMEM_PROVIDER_SET_PRESENT, &req);
> +	TEST_ASSERT(!r, "restore ioctl failed, errno %d", errno);
> +

[ ... ]
> diff --git a/tools/testing/selftests/kvm/x86/gmem_provider_test.c b/tools=
/testing/selftests/kvm/x86/gmem_provider_test.c
> index 0000000000000..d7caa11616dfe 100644
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/gmem_provider_test.c
[ ... ]
> +	struct kvm_sev_snp_launch_start start =3D { .policy =3D 0x30000 };
> +	ret =3D sev_ioctl(vm_fd, sev_fd, KVM_SEV_SNP_LAUNCH_START, &start);
> +	if (ret) { perror("SNP_LAUNCH_START"); goto out; }
> +
> +	printf("[VM%d] SNP_LAUNCH_UPDATE (code + zero, %luMB)\n",
> +	       vm_num, GUEST_MEM_SIZE >> 20);
> +	struct kvm_sev_snp_launch_update update =3D {
> +		.gfn_start =3D 0,
> +		.uaddr =3D (uint64_t)(unsigned long)src,
> +		.len =3D PAGE_SIZE_4K,
> +		.type =3D KVM_SEV_SNP_PAGE_TYPE_NORMAL,
> +	};
> +	ret =3D sev_ioctl(vm_fd, sev_fd, KVM_SEV_SNP_LAUNCH_UPDATE, &update);
> +	if (ret) { perror("SNP_LAUNCH_UPDATE code"); goto out; }

[Severity: Medium]
If a signal interrupts the KVM_SEV_SNP_LAUNCH_UPDATE ioctl, KVM might
return 0 but leave update.len > 0 indicating a partial completion.

Does this code need a loop to check update.len and retry the remaining
length to prevent silent partial initialization?

> +
> +	struct kvm_sev_snp_launch_update update_zero =3D {
> +		.gfn_start =3D 1,
> +		.uaddr =3D (uint64_t)(unsigned long)(src + PAGE_SIZE_4K),
> +		.len =3D GUEST_MEM_SIZE - PAGE_SIZE_4K,
> +		.type =3D KVM_SEV_SNP_PAGE_TYPE_ZERO,
> +	};
> +	ret =3D sev_ioctl(vm_fd, sev_fd, KVM_SEV_SNP_LAUNCH_UPDATE, &update_zer=
o);
> +	if (ret) { perror("SNP_LAUNCH_UPDATE zero"); goto out; }

[Severity: Medium]
Similarly, could a signal interrupting this update_zero ioctl cause a parti=
al
completion here as well? If the return value is 0 but update_zero.len is
still greater than 0, the rest of the 16MB guest memory would be left
uninitialized, potentially causing flaky test failures later.

> +
> +	struct kvm_sev_snp_launch_finish finish =3D { 0 };
> +	ret =3D sev_ioctl(vm_fd, sev_fd, KVM_SEV_SNP_LAUNCH_FINISH, &finish);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/f09647f427565c1789a=
6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk?part=3D9
