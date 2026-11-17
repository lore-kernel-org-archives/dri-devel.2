Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B0D606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=sM/NDTzO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8C3210EB3E;
	Tue, 17 Nov 2026 09:28:07 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03B6A10E4C4;
 Tue, 17 Nov 2026 09:28:01 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6AH8efab2136092; Tue, 17 Nov 2026 09:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=d
 8sOk0x43WSILP9MfWYP7qgMe7uUQwafssmLoeKj6k8=; b=sM/NDTzOSP81bonow
 0MUZsKzgAdJUu/Ls/RjW8AEqHaA9CdjlilK18XRZauC2I4JiSxl5UD2IwEwSKIhf
 M24L9fwoSHzOK7sjcdFgTzdgia3QsEuY0+lekBUm2RM+1NV4KyjsnaZlyb3VYnTQ
 ZTd+H1rtGVK0LpdxBddINYxUj6OJ6W566lXD1RFzjlz8IVJUtvma1wsMuieHV4th
 oMCvcnG61XveSf8WcwLk5d0FMEBeHH+JmHv3bj/st8+f+xE2Z/EaGf+A5NeCM/W9
 3oER96VmZIHfifZ98KaKxtdjMeiR7xVsWUacfsns6OB7FgdKwQ1G8OY+8eErZYyc
 saoVw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hxestt2j2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT
 key_exchange=secp384r1); Tue, 17 Nov 2026 09:27:51 +0000 (GMT)
Received: from np-a-belle.kl.imgtec.org (172.25.6.177) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 09:27:50 +0000
Message-ID: <023177c465539fa87c8ff08ab0ea5051e75547d8.camel@imgtec.com>
Subject: Re: [PATCH v2 0/2] drm/imagination: Switch the GPUVM to immediate mode
From: Luigi Santivetti <luigi.santivetti@imgtec.com>
To: Gyeyoung Baek <gye976@gmail.com>, Alessio Belle <alessio.belle@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Alexandru Dadu <alexandru.dadu@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Frank Binns <frank.binns@imgtec.com>,
 <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Date: Tue, 17 Nov 2026 09:27:50 +0000
In-Reply-To: <20261011-pvr-gpuvm-immediate-v2-0-744ddc6644c3@gmail.com>
References: <20261011-pvr-gpuvm-immediate-v2-0-744ddc6644c3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Proofpoint-GUID: 4ywLvArhZlLtsY9sGfHZtQ-bxjvldLib
X-Proofpoint-ORIG-GUID: 4ywLvArhZlLtsY9sGfHZtQ-bxjvldLib
X-Authority-Analysis: v=2.4 cv=O8OsLx9W c=1 sm=1 tr=0 ts=6afc1e17 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=2JH569OHYJkA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=c92rfblmAAAA:8 a=bC-a23v3AAAA:8
 a=CcRmZogvfuLsyrlAmdEA:9 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAzNyBTYWx0ZWRfXxjfOJTU0ZBkU
 uJ3P19BR6tnbALmqp48mAm2WLUQXPhsgTcAcMRqSCHgS1js8SJTpf+Xjb/nUUZWt3Nw7HdROHSn
 4+k/tQg+Q9zyTS/yiaiSnNAfmGhHxbvyzqWLOv24MgI4GwU9HfiVrtgmHEVM6K3971t4aqRfxi2
 GgTSWymNXiPVNjBfDaJq4aIpS4ZTH2u+E6PklgZhN9TZgxa8a54+X/pY6welRYRXIJM9PThiDIB
 30KhuKDyM8Ys7x66cvvjXCplwXHAuDKYGjhFDEaiEbnGN2a/y1BnLvRIvygVtmbFVzq6ILtR28A
 L5wJnOiG1P/lvxcNZWmkZiIAjUN/8+Hs4SLADlLQ8VD+UM/rkWHbgG3W0gMk6xfvvcdYYIGBY/2
 rnroPHnIFWYBewix6qvx24cLWZ25eescEF8rtC4LI63NH2J5qo8m6tbg3eW+Wi+7nFUUgHMXFUn
 YAob8DlhiZGwwiVMVNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAzNyBTYWx0ZWRfXwJ6EO75QBBQ1
 GenBilQib08oA9kDEoRCVN4/289UtocwDBPmPrm4bIyauFJQ9gqvwpXoHq40Kt/7Ro5gG7Anhej
 2ktAk0tZsCGc0Ak9GyPmwd14X7A8jMs=
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Gyeyoung,

Thank you for these patches, and sorry for the slowness in responding. Thes=
e two
seem okay to me - I also run IGT.

What I can do is to kick a run of CTS with them applied while I'll look at =
the
series for adding the VM bind ioctl.

Thanks,
Luigi

On Sun, 2026-10-11 at 18:45 +0900, Gyeyoung Baek wrote:
> Switch the GPUVM to immediate mode, as a prerequisite for asynchronous
> VM_BIND. A revised VM_BIND series will follow separately; v1 [1] is
> linked only for context.
>=20
> The switch also fixes an issue Sashiko reported on [1]: the GPUVA lists
> of other objects are updated without holding their reservations [2].
>=20
> Based on drm-misc-fixes (depends on 196d4d10c1b3).
>=20
> Tested on BeagleY-AI with lockdep, KASAN and failslab enabled:
> - All IGT imagination tests pass, including pvr_vm_map [3].
> - The fail-nth reproducer in patch 1 no longer warns.
>=20
> [1] https://lore.kernel.org/r/20260817-pvr-vm-bind-v1-0-0a0f21be7d38@gmai=
l.com
> [2] https://sashiko.dev/#/patchset/20260817-pvr-vm-bind-v1-0-0a0f21be7d38=
@gmail.com?part=3D1
> [3] https://lore.kernel.org/igt-dev/20260930125057.1837788-1-gye976@gmail=
.com/
>=20
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
> ---
> Changes in v2:
> - Patch 1: drain the vm_bo that fini() deferred when map_init() fails.
>   (Sashiko)
> - Link to v1: https://patch.msgid.link/20261011-pvr-gpuvm-immediate-v1-0-=
5b298dfce4f8@gmail.com
>=20
> ---
> Gyeyoung Baek (2):
>       drm/imagination: Switch the GPUVM to immediate mode
>       drm/imagination: Stop locking reservations around map and unmap
>=20
>  drivers/gpu/drm/imagination/pvr_vm.c | 82 +++++++++++++-----------------=
------
>  1 file changed, 30 insertions(+), 52 deletions(-)
> ---
> base-commit: 6ccf996a0dec1852dab94ad865f27b4904750e12
> change-id: 20261011-pvr-gpuvm-immediate-f7ea8edc2e7f
>=20
> Best regards,
> -- =20
> Gyeyoung Baek <gye976@gmail.com>
>=20

