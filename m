Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EBAC5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 09:49:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADD9D10E774;
	Mon, 10 Aug 2026 09:49:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="yXNEbkc7";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4513F10E774
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 09:49:17 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67A9U37K2088876; Mon, 10 Aug 2026 10:49:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=y
 LkRR1FWr254pW8cLoADgzmmBb2CwdfpaH0idLf9pDY=; b=yXNEbkc7mI+FPJxSS
 2ae382osyfUmE9o9EZDpjaR/1wtycERt0nLy30JdqMr/Qpe0MNBQUDmmfi/1g/QN
 iNfnJjkJiU3emjI97UjOxZGzOUFKkBiv32CGljXXGEs3hd3iUvQt32Z+ain+x+z7
 Dsq0Ml7oaoV/Y3rx47DHnlDLMWxOXzDFQj0EnZtTmz6HBdTz+BXDw5+Vk1lMWMFa
 jxtM5CYIz35btoyBa+Ne7VsOqhSsJFGdC/hBJWAqr6hGjLY2U/re5hbWU8jdMRDn
 JUfaKwMa51YiDV+OxE9jz+NgppNMsNLvY2i4cxbaa9VTyumkyIDR2vY1JFNwB2Vy
 Lrbmg==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4fwtqqhckj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 10:49:07 +0100 (BST)
Received: from np-m-daniel1.kl.imgtec.org (172.25.4.227) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 10:49:06 +0100
Message-ID: <07351b55d157cec6fd342599a4af5ea6ab74ce1c.camel@imgtec.com>
Subject: Re: [PATCH v2] drm/imagination: Align rogue_fwif_hwrtdata to 64 bytes
From: Luigi Santivetti <luigi.santivetti@imgtec.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>, Frank Binns
 <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alessio Belle
 <Alessio.Belle@imgtec.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "kernel
 test robot" <lkp@intel.com>
Date: Mon, 10 Aug 2026 10:49:05 +0100
In-Reply-To: <20260805-fix_imagination-v2-1-7391a13c891f@samsung.com>
References: <CGME20260805193726eucas1p122ba1e7c33d06a993a985637e909bd41@eucas1p1.samsung.com>
 <20260805-fix_imagination-v2-1-7391a13c891f@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
X-Originating-IP: [172.25.4.227]
X-Proofpoint-GUID: cRqVMtB3ziH0zHmEOUBdx-BT3tt_kSf5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA4MyBTYWx0ZWRfXz9vMr32DCAbT
 fmu4BSSkeOOvj5FM24FiVTRZSl8mNivBZEWgIxzGTt+mAFBNk3J90+qNNNiju8+d9aURKLvVA4k
 FyyoGwmp1Oama7ZuY5UXNkVdOefqBl6NJySwuoDhSzQCgZNtTYs9lS9jcHzq96D41fgRk4QQSOv
 VBrW0KKF1M8i8Kdw+KZywGatspgC0oXJYlVYIfCHY1AglBNZ3hlNs0v6BxsXGz5AYDJYkzvGhVe
 AUIkOhn8YGAHCb6L3WciSr94QZo356ovPPcTdMfG5BCIsYaFpBfns+fhBm0LRcqVVBH1ywUzV6M
 ZQbLvMQoUVxdzI+d+pZj1Tu5aTqD+89wsLjDmeefgFXH6OcaWYTLVA0huXljH1TLb/PhA1BbtMm
 hjqPO7ngZ9bbveCT1/fXFsQyxz+63ntK+AEW0erZ0c8rACno6YWrdL374dLyob35336on8PqivA
 NwpGw2/wwN7GwlEVjXw==
X-Authority-Analysis: v=2.4 cv=fsTsol4f c=1 sm=1 tr=0 ts=6a799e93 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=eoBRZU4O7WcA:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=hD80L64hAAAA:8 a=r_1tXGB3AAAA:8
 a=Us2G9mFh6sP1UL_tPTwA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: cRqVMtB3ziH0zHmEOUBdx-BT3tt_kSf5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA4MyBTYWx0ZWRfX1hW/Kj4+miXH
 qa0c95cWtQd4rBMROF0cxc+JLZXTmVm4OEewQLnK+Vx3jTD2LltrcYjO+F7L0D/QexIdQew/oXV
 R9kRtoyddOHyMXDdb0TFq4YTCOD1nPE=
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

On Wed, 2026-08-05 at 21:37 +0200, Michal Wilczynski wrote:
> The build fails on RISC-V using GCC because `SIZE_CHECK(struct
> rogue_fwif_hwrtdata, 384)` expects 384 bytes, but the compiler generates
> a 336-byte structure.
>=20
> This is due to an alignment conflict: the inner member `cleanup_state`
> requires 64-byte alignment, but the outer struct is explicitly marked
> `__aligned(8)`.
>=20
> While GCC on ARM64 implicitly pads the size to a multiple of 64, GCC on
> RISC-V strictly respects the 8-byte outer alignment, resulting in a size
> mismatch.
>=20
> Fix this by aligning the entire structure to 64 bytes, which resolves
> the contradiction and forces the correct 384 byte size on all
> architectures.
>=20
> Fixes: a26f067feac1 ("drm/imagination: Add FWIF headers")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:
> https://lore.kernel.org/oe-kbuild-all/202512131851.1WNXk3BC-lkp@intel.com=
/
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Reviewed-by: Luigi Santivetti <luigi.santivetti@imgtec.com>

> ---
> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v1:
> https://lore.kernel.org/r/20251222-fix_imagination-v1-1-0ac80a2ff317@sams=
ung.com
> ---
> =C2=A0drivers/gpu/drm/imagination/pvr_rogue_fwif.h | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/imagination/pvr_rogue_fwif.h
> b/drivers/gpu/drm/imagination/pvr_rogue_fwif.h
> index
> 172886be4c820a32ae1b08d62bf0814250f2a9bd..1ba2a167a38b31911e0846923e4dc70=
626f5
> ca65 100644
> --- a/drivers/gpu/drm/imagination/pvr_rogue_fwif.h
> +++ b/drivers/gpu/drm/imagination/pvr_rogue_fwif.h
> @@ -2170,7 +2170,7 @@ struct rogue_fwif_hwrtdata {
> =C2=A0	bool geom_caches_need_zeroing __aligned(4);
> =C2=A0
> =C2=A0	struct rogue_fwif_cleanup_ctl cleanup_state __aligned(64);
> -} __aligned(8);
> +} __aligned(64);
> =C2=A0
> =C2=A0/*
> =C2=A0
> *************************************************************************=
*****
>=20
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251222-fix_imagination-8ef0c94122c4
>=20
> Best regards,

