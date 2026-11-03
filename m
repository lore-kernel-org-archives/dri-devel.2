Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A95606A32D
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3dfCqjQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36A9E10F3DB;
	Tue,  3 Nov 2026 07:34:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C72210F3DB
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 07:34:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 13CF2601F6;
 Tue,  3 Nov 2026 07:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701041F00919;
 Tue,  3 Nov 2026 07:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793691259;
 bh=XfKNC2NE9YSYVP2MPnS+smvI8z2Ige3tMx497tBdQho=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l3dfCqjQj+DS0DEcJftio2F2cN6tjiUPYQ+Qap3FvZ5+5uPKlDOS0Ug87r+5GuC7y
 e9+K0KJZoyu4NP7LK5uVodgS2dzgEQz3hV6fmmNiAEcdJ3535CZY1GTcqmiD/kKSHE
 4Rb/ADET5SOCZmEvmMdMJ09KKRDCB9B4++tmKzNeShhRrru7uU6Oewtih2VGEd4qGM
 i4KiEifWR2oXo5ZNdE+NYRGBG9Jntbr42sREOT3NtidrDBhLN5oCyjQ/k2mMGH0RJB
 IRzuIffVomlseS+D+pWJYUIQiZ0gqBNiFABt/QWUg4pWDGvbeGScrmQ7wfmCGBwjUW
 6Ex7BILm4/gVQ==
Message-ID: <sashiko-outbox-194717@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] x86/vmware: Route low-bandwidth hypercalls
 through a static call
To: "Zack Rusin" <zack.rusin@broadcom.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <70ce0c2c18008fb25399125fc81eb368d8e824ad.1793685318.git.zack.rusin@broadcom.com>
References: <cover.1793685318.git.zack.rusin@broadcom.com>
 <70ce0c2c18008fb25399125fc81eb368d8e824ad.1793685318.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 07:34:19 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] x86/vmware: broken TDX hypercall guard when vmware_init_hypercal=
l() is skipped
--

commit fc9641d4edae98b08577710c597ef17cc2f5765e
Author: Alexey Makhalov <alexey.makhalov@broadcom.com>

x86/vmware: Route low-bandwidth hypercalls through a static call

This commit consolidates the low-bandwidth VMware hypercall inline assembly
into four backend functions dispatched via a static call, passing arguments
and results through structures rather than nullable pointers.

Link: https://lore.kernel.org/r/20260309235250.2611115-2-alexey.makhalov@br=
oadcom.com
Link: https://lore.kernel.org/all/CAHk-=3Dwivx7pi+h+hGmvNFAJm6StQLiQ-b8DdsE=
5J=3DLMOWae8Ng@mail.gmail.com/

[Severity: Medium]
In arch/x86/kernel/cpu/vmware.c, vmware_init_hypercall() (around line 510)
updates the vmware_hypercall static call to vmware_tdx_hypercall() when
X86_FEATURE_TDX_GUEST is enabled, while the link-time default for
vmware_hypercall is vmware_backdoor_hypercall().

Previously, vmware_hypercall1() through vmware_hypercall7() in
arch/x86/include/asm/vmware.h checked cpu_feature_enabled(X86_FEATURE_TDX_G=
UEST)
directly and called vmware_tdx_hypercall(), which rejected non-VMware TDX
guests via !hypervisor_is_type(X86_HYPER_VMWARE) (around line 633 of
arch/x86/kernel/cpu/vmware.c) and returned ULONG_MAX.

With this change, vmware_init_hypercall() is only invoked from
vmware_platform_setup(), which only runs when VMware is the detected
hypervisor. On a TDX guest running under KVM (where x86_hyper_type is
X86_HYPER_KVM), vmware_platform_setup() does not run, leaving the
vmware_hypercall static call pointing at vmware_backdoor_hypercall().

When vmmouse_detect() in drivers/input/mouse/vmmouse.c (line 323) runs on a
KVM TDX guest (since vmmouse_supported_hypervisors[] includes X86_HYPER_KVM)
and calls vmware_hypercall3(VMWARE_CMD_GETVERSION, ...), won't it execute
the port I/O instruction inl (0x5658) in vmware_backdoor_hypercall() instead
of being blocked by vmware_tdx_hypercall()? In a TDX guest, executing inl
triggers a #VE exception and issues a TDG.VP.VMCALL<Instruction.IO> to the
VMM, which will raise a kernel #GP(0) fault via ve_raise_fault() if the VMM
rejects port 0x5658 I/O.

Additionally, since vmware_tdx_hypercall() is now only installed after
x86_hyper_type has already been set to X86_HYPER_VMWARE, doesn't the
!hypervisor_is_type(X86_HYPER_VMWARE) check inside vmware_tdx_hypercall()
become unreachable?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793685318.gi=
t.zack.rusin@broadcom.com?part=3D2
