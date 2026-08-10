Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC5EC5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 09:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD1A710E033;
	Mon, 10 Aug 2026 09:48:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="y2NvKwqZ";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AE5610E033
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 09:48:21 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67A9Twcd2088712; Mon, 10 Aug 2026 10:48:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=5
 aGh8gWiARGiF5syLeKPSG5W3xs0DUP6CltO+CSpunc=; b=y2NvKwqZPMrGG9UP2
 05eefQHT2DgCGujEiU7ovtjLcdJggS7VbtfZaKyP6uQ4Yx6LTYxOYSAph4PQX9sq
 XaYo9HgW8anprXzVPl7kjY9UmBv3+z5JprTHHv87HgjZ4QtyucN3/j2UICiTGHNS
 7ZzACLTnEou7Qr+Ep3zPy8tBOxLJS0UVXwv/AyCMlRV4wDQrrQgdodz3l3aCP+ww
 nTOlUmJKzZEsxUh25NFFxbucV7bgresH+EJ/z+NZDPzjElReb7Bdxr31ZX+38RDa
 EO9CZRPrjlO5Mn9GyNzHNTEiYOJVBnNeEwdXmOejquKXLZDGazmV78YTVDqGJc4i
 iXU2A==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4fwtqqhck2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 10:48:09 +0100 (BST)
Received: from np-m-daniel1.kl.imgtec.org (172.25.4.227) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 10:48:08 +0100
Message-ID: <2d3f5871aa7cda3f705b542f0a47e314a669f264.camel@imgtec.com>
Subject: Re: [PATCH v2] drm/imagination: Align rogue_fwif_hwrtdata to 64 bytes
From: Luigi Santivetti <luigi.santivetti@imgtec.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>, Alessio Belle
 <Alessio.Belle@imgtec.com>
CC: "lkp@intel.com" <lkp@intel.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Frank Binns
 <Frank.Binns@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>
Date: Mon, 10 Aug 2026 10:47:40 +0100
In-Reply-To: <223e0d51-9c2a-4938-b304-5d49d5984d37@samsung.com>
References: <CGME20260805193726eucas1p122ba1e7c33d06a993a985637e909bd41@eucas1p1.samsung.com>
 <20260805-fix_imagination-v2-1-7391a13c891f@samsung.com>
 <1be61852213cc616eadc60941512862deddd12c7.camel@imgtec.com>
 <223e0d51-9c2a-4938-b304-5d49d5984d37@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
X-Originating-IP: [172.25.4.227]
X-Proofpoint-GUID: UoHDrSCJYDWL-keqYBrOZ0Llcn0IjhTc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA4MyBTYWx0ZWRfXwepf8AFPEApF
 XgmHl2H7GVh7+qfJnlH23K8tPTSGKxhfiu8l472UnGEUEZ+TrrVPY/uLMZeeH0ZeC0fNyezKQzh
 cs8+p8njHc0V54ecqdhCqILxe5oBH7t/G/CcfNju7QuHTqDNT8y/m8qGjnN0ATRAgQkuRBhAEIK
 Jy9vwZzaHGJacx06M9wmmxku0vm2lNQfMKOzUGIgqG8gHxZaAZVD6wOJKu718AvI8qjmrkLO6Yd
 /idQTe7xnGAMdiqPtFchRF2HxXlqpo78VQabSZHEm0db0dmH95tjOgy0kMEeqvtrgHD7kOrZNdK
 hR/XejSZt5p970j99lsiuhO2YwRef+geYdMAKSPWjImrfLZnQeCD32Vlp/sBel4nwRm96BKlTg1
 yn5HJCpvHnoSIwkPShO8v7frR8bKY+9MmX2RDxgefF3KaQ99Vd1DUMVkc2BX4PLKXiTXi0xgyHV
 zIKUnwyQDypRkayLmQA==
X-Authority-Analysis: v=2.4 cv=fsTsol4f c=1 sm=1 tr=0 ts=6a799e59 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=eoBRZU4O7WcA:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=lSmzcdz2ok3yLAQ5NkIA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: UoHDrSCJYDWL-keqYBrOZ0Llcn0IjhTc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA4MyBTYWx0ZWRfX3itMz+hc04KH
 dK1VZzR+mp9y/N+b1v2yt2YKtMD3iuCUs/l9+o7yETTOGo3HDF995GOqrc8b50rRZ0NzmMLRIl1
 9LXyyQeVtw4Nev3VJJ8s4ICKS04aLIY=
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

On Mon, 2026-08-10 at 10:53 +0200, Michal Wilczynski wrote:
>=20
>=20
> On 8/8/26 11:27, Alessio Belle wrote:
> > Hi Michal,
> >=20
> > Did you mean to make any changes to this patch? Because apart from the =
stub
> > changelog, everything else seems the same as in v1.
>=20
> Hi Alessio,
>=20
> Yes, the only intended change for v2 was expanding the commit message
> based on the feedback from v1 [1].
>=20
> I completely missed replacing the "EDITME" template in the changelog
> section, sorry.
>=20
> Let me know if you'd like me to send a v3 just to clean up the changelog
> block, or if you're fine taking it as-is.
>=20

Hi Michal,

As Alessio is OOO I'd reply by saying you could send a v3 cleaning up the
changelog and adding my reviewed-by (I'll attach this by replying to the pa=
tch).

Thank you,
Luigi

> [1] -
> https://lore.kernel.org/all/09a1028b03d614ffedc49dee24eee51578fa0d96.came=
l@imgtec.com/
>=20
> Best regards,

