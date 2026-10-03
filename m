Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D286BCA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 21:20:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3642D10EA2E;
	Sat,  3 Oct 2026 21:20:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="NRFZcNdS";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com
 [34.2.64.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAC2410E9AF
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 21:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1791062419; bh=yrmEhSQLlEG0ucgunfCQSW1C23MI635cvk0Jl+8/sTQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=NRFZcNdSzBtp/nfZmy2kaHYsx77j5tBfv+oRavzaogk/EMXxGsHVKmljYpykNAU1+VC8E7FC1+9x0TiPXbpf+Fam8BAdUKNuo5b0/u8BCqUQR1HLADEjL1oG9EjUWBlTKwHemX32FR8F+ta8VR7up8K1dvTIPVI9fFObr8UM/mFeSqiaETStn5rrwrK++Ssq8On6rwFhJUlmuuSkvEBn+H2Q2W/rhJnzzQbQhITg9t/5HbRSfqL6Aubnv6eXwkPHDGeJ2ywFn+onL0yfAoDgF/ODwEHM0uCIj6uEFTUAtKWf7Khp3w1YU4xVneO3TsK1u2naFHWdZnUrp1UcegIRSQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1791062419; bh=yd89yWeabfBXt/YkKcGNZA7VNjdBP8ctf0Uvjrg1K27=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=OME95Cnn9zdfWNnHyn7ZKvOdoSQrwdgLpJsaiHpte5rnRLjHjiWpc+Vr5ssym2V2cWm0nYsnn/LoMrNvxeF0YFYT20QHcIfo/Adnabhf7XxxqtIYySG3i8xh6yi/zH702tqYVMb68qmsIfJRVFCN60D92tTErtJomPNMUhgH4tYlE53Ikmfnm29utRWKwuoM/UbuV/WlCd0LAnDhkUIX6WKdDWbsVqIDml2g/Fy/s9WKnfF4VtfDscwWvBF5unLBlvdLvSbuw7bG+c+bwiOrNwA79px76FOo2jWYKXx84HnyRKPnA7a+e53ukcq+w66RCqtMSRWkVBT9Mqy/RwQ7dw==
X-YMail-OSG: GpNHSLIVM1kY6Zlo1PAip.jcrILvQttWOdrA4zB7vMcL4XTVY9x3i1wPTFeNIE6
 9VDsoAOT9OmVzLbWpQxk93ggWbzekW9PlGI81c7KuBe38Pe82ZHqgDz0sMHlksN9VqV3OzNYXlYZ
 rnElfJeFhvnYUApCHOTNz7ZTMsvpeFR8063XhJVBPCTLOZ8vS3hlUlI4RGK0I0_yl4Qt3k6w7GK9
 t4pw2.axYgV4i6rZQ3LLAHNDD2OlmCVncT9RBYcxLxyYmCy6NTM3YRVWrj0gOTW5athEMLVDNHb6
 W6TYfGIfkM3w7cBQ77ZLlXfbZCmUaDFXj62NIKhFjHsfN55j8JxASu9_Lv0G1HnGqiBb8E3orqxf
 IE9X52HVlNYjBLiBdq3GkWnMk7JKpBqc.9tr8kTXntLuBL_pDx46WfEbIqdobZRiaApn37upkNzV
 b7Z6kDH0Gqul6CM2ERNZbvg_OtYi2ZS2XfPwWwEtfxO05n_VMVUCRtpYF_zSfpFkgF06QZ98LpQ.
 KOOoc1rN8YlFx9X_H5Z2BzklFqhC4FfSupG4g.GP0TaW0xVnuCGc6uhTaeCiKsER1KyLPhBMDuRF
 m9QGrlV2GeWVre9jaO.FYDHX3mnCk3SwvSudsqgxbRx8J9rzG.zTWH7rjBMONVPPTDX2x0MGE7lw
 HEn.khqvlf3OGxlZNESpcmhLS1FDpTnqpYFPXbFE0EBkANNQpbbS6O440WxNt.w8tgFNUwV8gsWR
 7x0b0zNABqIYHsaa9ZXrvzMo.I.T2sPePtwohpukmlzKu3BJ0NVNMW_Dvfl7siO857H9km_wrzzE
 lgALzdl41xqSIMGB8Y3aGn5l_yJM7ldHxHXfvd.038qbie9e1d7QuriizZTDrulKQH8k4BmI4iaG
 vLcuJuyFWi4TLiw.QAtoLnp4xkonr.h0yW2DB5Prqrd6kLyNcperT64k4UO1iwJE0UjagFI2_7_U
 eWNyMUYeQioC3CdNYu5S25K.CD88uaE_4zjJJVOEscXcoNYmKRVQoTHmH2v55r1EUazWbi_lpeNN
 Nvc.jCilRucci6HNBHMURCBOi4F27rOmfm3685MrApR9NESG7r7r8IV9DVPvdJZ6wC7c1ILomriH
 2.kUId6UryarkqTAqyS9JxVIeTqNwcFSX3sVSS0k5rFo9S6mVhCCpiP4GDSFSU1S_DVjndyLV1FD
 k460buE21poX1Plz7xiFJwGdMELk8iO3vKARjl0OgGWHrMo.uQZDqn1t.HXPh5tsh5ULuTAgd5h8
 5fBimPkViJQCsuotyZpC2Mf7nVLFJcSPyP8lox_vKcMpETSfjWnBuAbLLwJBPul2oWPGJL_h4yMO
 _qFEFhPTbJV.ZMxOlnOsPMD2qA5uTWmqyKoGGxbrFiDaEDrK7AhL1LlMF36ynomCuh7NhNSVwPFx
 Ttzcp4VBGzg1beyMykcatVaKQZWWoc1Q7kR0fN0nZITDoVfBP22ncGv93VTPKIFFglS3OWtd.bIQ
 P6.CFJnRXsm4sZZqxs96h6XIiXGCeq0KqqPaPcnAY9oq7uRAsrKQEBjg7Dd1BMM1RzW10VMxA25z
 GVjK0DbMYiNeZOuWALC_hpuop.b0znYoUUfJ5dNKob2f7FjZ8NL7X2roxGaMRV0cIEk7SsvwHj4M
 7wkNIylaSWt21_f.OtL_6XphFWCEyjwBXpXkaTK3N1z2p3CHVcfv6oqqZVuTxgd5GKWXXHO5vfw_
 rz1RpeThLUqGLpqMXtTpMt6Xo5OUs88LuwAuUuC7JKsCM1Ef6QxUqv0MC1zliIFdLYHK2Hfrj6zm
 xh5YfbxgWmUkCMpfoFRnxs1NoDS.kwIlASktcCp3a5uiumjf7n3ADRYA2R5TUcn2TIZLk.hJKjmD
 IHdNJrvIJPkay_CtAq2nlN._l6jiLGX5pS7i5R1TQPILilK5bkpbVGEBZ9wGXg9Lh1cviIfDZz6o
 bt.I6t6OU_U3UyD5kQ8Iinr6xXawGCdMN1KoQxF_0VknE5imTse9NsDA5DuNbKLetEDJPvtS.._.
 zoUvh26vq
X-Sonic-MF: <Capitain_Jack@yahoo.com>
X-Sonic-ID: 9f9fd89c-768c-4308-9788-2b2a9f654e0f
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-102 with HTTP;
 Sat, 3 Oct 2026 21:20:19 +0000
Received: from dip28.lsn.bf1.yahoo.com ([67.195.177.37])
 by hello (SMTP) with SMTP ID acd1a88dad1bf88c6a89949334e77d37;
 Sat, 03 Oct 2026 21:20:15 +0000 (UTC)
From: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
To: jim.cromie@gmail.com
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@redhat.com>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] nouveau: fix 3 null-ptr derefs
Date: Sat,  3 Oct 2026 18:20:10 -0300
Message-ID: <20261003212010.113714-1-Capitain_Jack@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002-my-fixups-v1-0-a83d20f9d3fe@gmail.com>
References: <20261002-my-fixups-v1-0-a83d20f9d3fe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Jim,

I tested patches 1/3 and 2/3 on 7.3.0-rc1, with an RTX 3060 (GA106)
passed through to a VM (vfio-pci). Patch 3/3 does not apply on 7.3-rc1
(nvkm_gsp_gcx_ready() is not there yet), so it is untested here.

Without firmware (the whole nvidia/ga106 folder removed and the
initramfs rebuilt), nouveau reports acr, gr and sec2 "firmware
unavailable", so there is no GR engine:

- GETPARAM with NOUVEAU_GETPARAM_GRAPH_UNITS returns -ENODEV and logs
  "GETPARAM_GRAPH_UNITS: no gr engine or func"; the desktop session
  already reached that path at boot.
- DRM_IOCTL_NOUVEAU_GET_ZCULL_INFO returns -ENOTTY.

I also called both ioctls directly from a small test program on the
render node. No oops anywhere: KWin composites, NVK declines the device
and zink falls back to llvmpipe.

With the firmware restored, GSP-RM 570.144 loads, there is no oops, and
the card drives a Sony 3D TV in every HDMI 1.4 3D structure it declares,
at 12 bpc.

On your worry about firmware: the most "damaging" thing in all of this
testing was the TV getting stuck on a corrupted signal during an earlier
no-firmware run, solved by power-cycling it and feeding it a proper
signal. No GPU firmware is ever written, and the firmware files in the
VM are disposable.

The kernel logs, the test program and its output are here:
https://github.com/danielcamposramos/sony-bravia-linux/tree/main/docs/upstream/nouveau-null-v3-test-2026-10-03

Tested-by: Daniel Campos Ramos <Capitain_Jack@yahoo.com> # 1/3 and 2/3, GA106

The test was run with an AI assistant doing the legwork under my
direction; the results above are what I saw on the hardware.

Daniel
