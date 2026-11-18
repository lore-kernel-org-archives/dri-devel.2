Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D30606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=jfqkTBkA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DF8910FCF1;
	Thu, 19 Nov 2026 07:48:56 +0000 (UTC)
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu
 [128.30.2.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E75E10FDC4
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=outgoing.csail.mit.edu; s=test20231205; h=Content-Transfer-Encoding:
 Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PR3hub99Xsm//k1e56CFmuZA9rCDR5FKEPlC2s2rAkk=; t=1795015256; x=1795879256; 
 b=jfqkTBkAXFgGkLbq78phVv1yTWwGEMtywuRMkOWkGD9gtG+vuxxQmd2veuW/HOTXR+azZnW7Zmy
 Am0WEC1yieuD4JNXZ6Y38CJd8JzURuuq/Irt+oXNbWoIqnuzQIHvDL6fiOx+pXjVQGe/hfRlX4AOZ
 dyJBI7W5r165egUEmWG7PFCnKZi7HRdcpRlTaGXaq6vyHsspO/76HuTX5IbXPGWKVF+MQ0Adr2fXZ
 e8a9pZUNF/zO17cDCP74HGmHamWAb4MdnM3JWpc/hILBHSIAX/HmNaw1y/sn6VSBBwa556KVRELKH
 QR5+Ftbd2wZAnB+za3ac4RT6QESBzW8v+G0w==;
Received: from mail-dl1-f54.google.com ([74.125.82.54])
 by outgoing2021.csail.mit.edu with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.95)
 (envelope-from <nickolai@csail.mit.edu>) id 1xThSx-00GiKV-DY
 for dri-devel@lists.freedesktop.org; Wed, 18 Nov 2026 10:20:55 -0500
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-14394530ec6so1743493c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 07:20:55 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErHsvfihoTPeH1moNfR1L5c8ne2ee/bVRDF4eaD/VKLwj42xOKHvSATUsZcbglCqnlwtw0ds0olfpIg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/KsOmsODDA36HkN8XAf+AmA5tAVc19bS2TuwLDMM5pzzjINW/D
 aJmadAdPtIW1mCUi1Of2IlgjD6yLyobseUHfnZagTARfSK3ArPFx+/WIOmp1bZK4kgW82qYJNxI
 r/6+cQsiCX+k/QXKWqC/tmTijw+SElGA=
X-Received: by 2002:a05:7022:e0d:b0:1b3:8814:8383 with SMTP id
 a92af1059eb24-1b543bb6158mr3662263c88.9.1795015254429; Wed, 18 Nov 2026
 07:20:54 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117170328.56738-1-nickolai@csail.mit.edu>
 <d7179bdf-daa3-4ed2-a45e-ef2b99d116f1@amd.com>
In-Reply-To: <d7179bdf-daa3-4ed2-a45e-ef2b99d116f1@amd.com>
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
Date: Wed, 18 Nov 2026 10:20:41 -0500
X-Gmail-Original-Message-ID: <CADGQE7EDJHu9F41ZGKfP92M7kbbw7A-FGYzX1kaemjXmkuW5Wg@mail.gmail.com>
X-Gm-Features: AclHuK-XtrrvqYPPygdcx8gUT8Gu0j85-P6irS7Octs2KttgRf_mGWk5jg1-ewk
Message-ID: <CADGQE7EDJHu9F41ZGKfP92M7kbbw7A-FGYzX1kaemjXmkuW5Wg@mail.gmail.com>
Subject: Re: [PATCH v1] drm/radeon: stop the GPU before kexec
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 7:11=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
> On 11/17/26 18:03, Nickolai Zeldovich wrote:
> > Suspend the GPU in radeon_pci_shutdown() on kexec, as PPC64 and Loongso=
n
> > already do on every shutdown. Normal shutdown and reboot are unchanged:
> > commit 8d13c187c42e ("Revert "drm/radeon: Fix EEH during kexec"")
> > removed the same call there because it hung some HD 5770 systems.
>
> Yeah that is clearly not the right approach.
>
> The kexec is often done to switch to a new kernel because the old one has=
 encountered some severe problem, doing a HW suspend in such a situation is=
 not guaranteed to work.
>
> What should be done instead is to fix the initialization order and/or dis=
able GART before the bus mastering is enabled again.

Thanks, that makes sense. I tried disabling the IH at the start of
evergreen_startup(), before the MC programming raises the page-flip
interrupts. I also had to clear IH_WPTR_WRITEBACK_ENABLE when disabling
the IH; otherwise resetting the write pointer writes it back through
the stale GART, which is one more stray write. With both changes, I
see no stray writes (no canary-page corruption, and successful kexec reboot=
s).

On disabling the GART: the new GART is already enabled before bus
mastering, so, as far as I can tell, the stray writes were translated
through the old one earlier, during the MC programming.  Disabling the
old GART before that would also keep the stray writes out of system
memory, but evergreen_pcie_gart_disable() and its counterparts also
unpin the GART BO, which is not pinned at that point, so disabling the
IH seemed the more direct fix.

Before I send a v2, a quick question about scope.  R600, RV770,
Cayman, SI and CIK have the same IH, and their *_startup() functions
program the MC before their irq_init() in the same way, so the same
two-line change (see below; disable the IH at the start of
*_startup(), and clear the writeback enable in the corresponding
*_disable_interrupts()) should apply to all of them.  But I can only
test Evergreen: my card is a Caicos (HD 6450), which runs
evergreen_startup().  Would you prefer I just fix Evergreen, or all 6
families (the other 5 only compile-tested)?

Nickolai.

For reference, the Evergreen version without comments (with apologies
for the loss of tabs):

--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -5010,6 +5010,8 @@ static int evergreen_startup(struct radeon_device *rd=
ev)
        int r;
        struct drm_device *ddev =3D rdev_to_drm(rdev);

+       r600_disable_interrupts(rdev);
+
        /* enable pcie gen2 link */
        evergreen_pcie_gen2_enable(rdev);
        /* enable aspm */

--- a/drivers/gpu/drm/radeon/r600.c
+++ b/drivers/gpu/drm/radeon/r600.c
@@ -3604,7 +3604,7 @@ void r600_disable_interrupts(struct radeon_device *rd=
ev)
        u32 ih_rb_cntl =3D RREG32(IH_RB_CNTL);
        u32 ih_cntl =3D RREG32(IH_CNTL);

-       ih_rb_cntl &=3D ~IH_RB_ENABLE;
+       ih_rb_cntl &=3D ~(IH_RB_ENABLE | IH_WPTR_WRITEBACK_ENABLE);
        ih_cntl &=3D ~ENABLE_INTR;
        WREG32(IH_RB_CNTL, ih_rb_cntl);
        WREG32(IH_CNTL, ih_cntl);
