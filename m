Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73DCCA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A08210E241;
	Tue,  6 Oct 2026 08:19:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="raJ5n2XL";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 292AB10E241;
 Tue,  6 Oct 2026 08:19:52 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6966erBU2628810; Tue, 6 Oct 2026 09:19:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=s
 YO8DUfX9+QiR/3vbenuCHKMo9DRrZNNECyROOYo9SQ=; b=raJ5n2XLcLmT6mmJj
 SYhNF5GXTdui74VT8tQmZcV9ylQNFuybCI9znWaXWauoslea1DTNvzJeXvvYpNen
 9ucVNbf5lqt40DhFoxnhO7+iRK9KXKjflNjfrBbLwMaVO0J1Wm/95wYsT5rCIhaX
 HTaJwjOKj++yLZEn/bJsf7uGSQfUSKajgGI7iMeB1pBuT43GOio9ne7hRsowT1WX
 uoDiJtq6VGu9eHDZygRVBG4IYNfBJELXwCEGSWekhipZopHF5QXDJDziA06hLWER
 +ue8tFycVkOyqSkU27/SxTt1BZ9/mYd0+hTYg/BDtecPrOqLJ6jpYvJgA3J1dclD
 VH+Uw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4h3fnt1e3p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 09:19:41 +0100 (BST)
Received: from np-m-daniel1.kl.imgtec.org (172.25.4.227) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 09:19:36 +0100
Message-ID: <60ee11a2e95bfd475a54e042cbbf9110159c6853.camel@imgtec.com>
Subject: Re: [PATCH] drm/imagination: Fix PowerVR UAPI constant references
 in kernel-doc
From: Luigi Santivetti <luigi.santivetti@imgtec.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
CC: Alessio Belle <alessio.belle@imgtec.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Faith Ekstrand
 <faith.ekstrand@collabora.com>, Frank Binns <frank.binns@imgtec.com>,
 <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Date: Tue, 6 Oct 2026 09:19:40 +0100
In-Reply-To: <5bcbcbc46c1076f0e4c3b6e249ef2ce61db848a2.camel@imgtec.com>
References: <20260912063021.43076-1-kmehltretter@gmail.com>
 <16d56cee0036a41f411df0efab03bbcc8e964da2.camel@imgtec.com>
 <5bcbcbc46c1076f0e4c3b6e249ef2ce61db848a2.camel@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
X-Originating-IP: [172.25.4.227]
X-Proofpoint-GUID: HscVdQrRjjcMPajfMfTDRKpF-d_exgIC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzMiBTYWx0ZWRfX2qxtiRyIqT2S
 fCljwm562S0JERy3y+VLY8lKuivrhUwQQeo0t+Rbg2ewkWiGbVtZNnSAgXByb71vhn/nFR06B4H
 dQwd+ZUx342/cZapaC6+x4t/snTxqNx890x6/4zc6osMTeUBVnVehOOfO+bf4Qoe01gBlDmjt4Q
 ZbWpD1Rp17B0X/IcMR1TkyyNb1ao5uRsanma9vvhmtDDQKi0EDyN6wMVOx4tzYF8H4DKOgPOeFB
 3YflE9FB6Co5MiFu8wIciA8tuWOY2AZpA1a/PbhIdyKlCIV9M2rgg4AsrDlTM3enSj3Hi6X6cdJ
 4iRcA5Ebv0wmQvL8kdQdGqdI+69+Ttr9Ju7i0wjZnEh8YDfkoGRmlFITpFdB65UOGpB2hKisjQv
 RG39e9BWX32CNn98TQJrWrgmVAXwRdfrjAAHin4ceD3FzDK+gkLQ35CyRkH3UMLBbm5RlnK5deM
 jTdJjJXsFq0zu/urfbQ==
X-Authority-Analysis: v=2.4 cv=TplzFzXh c=1 sm=1 tr=0 ts=6ac4af1d cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=eoBRZU4O7WcA:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=pGLkceISAAAA:8 a=r_1tXGB3AAAA:8 a=Kyt1cHT3QFHoITg6mwYA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: HscVdQrRjjcMPajfMfTDRKpF-d_exgIC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzMiBTYWx0ZWRfX2Az3+8hbAGMn
 1i34bVb8hSG3Qi+CW7QeB6eCuLgddVSpcB07sy1d8fafQ9r89SLhMEMHLdrGjQM2r2V4FCN98qb
 ElJPMGuqWV3fXw7WenorOMQ5Nzzt9dY=
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

Hi Karl,

On Tue, 2026-09-15 at 10:05 +0100, Luigi Santivetti wrote:
> On Tue, 2026-09-15 at 09:51 +0100, Luigi Santivetti wrote:
> > On Sat, 2026-09-12 at 08:30 +0200, Karl Mehltretter wrote:
> > > The PowerVR UAPI comments contain misspellings of the enhancement que=
ry
> > > selector, two buffer object flags, and the job submission ioctl. The
> > > correct names were already present in the UAPI definitions when these
> > > comments were introduced.
> > >=20
> > > Use DRM_PVR_DEV_QUERY_ENHANCEMENTS_GET, DRM_PVR_BO_PM_FW_PROTECT,
> > > DRM_PVR_BO_ALLOW_CPU_USERSPACE_ACCESS, and DRM_IOCTL_PVR_SUBMIT_JOBS =
in
> > > the corresponding comments.
> > >=20
> > > Fixes: 1088d89e5515 ("drm/imagination/uapi: Add PowerVR driver UAPI")
> > > Assisted-by: LLM
> > > Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> >=20
> > Reviewed-by: Luigi Santivetti <luigi.santivetti@imgtec.com>
> >=20
> > Thank you!
> > Luigi
>=20
> Would you mind propagating your fix driver-wise?

A kind ping - can you address those remaining typos?

>=20
> $ grep -wnrE
> "DRM_IOCTL_PVR_SUBMIT_JOB|DRM_PVR_DEV_ENHANCEMENTS_GET|DRM_PVR_BO_DEVICE_=
PM_FW
> _P
> ROTECT|DRM_PVR_BO_CPU_ALLOW_USERSPACE_ACCESS" drivers/gpu/drm/imagination=
/
> drivers/gpu/drm/imagination/pvr_fw.c:1841: * %DRM_PVR_BO_DEVICE_PM_FW_PRO=
TECT
> is
> implied for all FW objects. Consequently,
> drivers/gpu/drm/imagination/pvr_fw.c:1842: * this function will fail if @=
flags
> has %DRM_PVR_BO_CPU_ALLOW_USERSPACE_ACCESS
> drivers/gpu/drm/imagination/pvr_fw.c:1923: * %DRM_PVR_BO_DEVICE_PM_FW_PRO=
TECT
> is
> implied for all FW objects. Consequently,
> drivers/gpu/drm/imagination/pvr_fw.c:1924: * this function will fail if @=
flags
> has %DRM_PVR_BO_CPU_ALLOW_USERSPACE_ACCESS
> drivers/gpu/drm/imagination/pvr_fw.c:1961: * %DRM_PVR_BO_DEVICE_PM_FW_PRO=
TECT
> is
> implied for all FW objects. Consequently,
> drivers/gpu/drm/imagination/pvr_fw.c:1962: * this function will fail if @=
flags
> has %DRM_PVR_BO_CPU_ALLOW_USERSPACE_ACCESS
> drivers/gpu/drm/imagination/pvr_fw.c:1998: * %DRM_PVR_BO_DEVICE_PM_FW_PRO=
TECT
> is
> implied for all FW objects. Consequently,
> drivers/gpu/drm/imagination/pvr_fw.c:1999: * this function will fail if @=
flags
> has %DRM_PVR_BO_CPU_ALLOW_USERSPACE_ACCESS
> drivers/gpu/drm/imagination/pvr_drv.c:1183: * Called from userspace with
> %DRM_IOCTL_PVR_SUBMIT_JOB.
>=20
> >=20
> > ---
> > > =C2=A0include/uapi/drm/pvr_drm.h | 8 ++++----
> > > =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/include/uapi/drm/pvr_drm.h b/include/uapi/drm/pvr_drm.h
> > > index
> > > ccf6c2112468f3f53b093bc298dac2bbbfd35e6e..d97a69b83cc59338b7aae306e4d=
fa132
> > > 0f
> > > 07
> > > 1a2d 100644
> > > --- a/include/uapi/drm/pvr_drm.h
> > > +++ b/include/uapi/drm/pvr_drm.h
> > > @@ -231,7 +231,7 @@ struct drm_pvr_dev_query_quirks {
> > > =C2=A0 * the user mode driver.
> > > =C2=A0 *
> > > =C2=A0 * When fetching this type &struct drm_pvr_ioctl_dev_query_args=
.type must
> > > be
> > > set
> > > - * to %DRM_PVR_DEV_ENHANCEMENTS_GET.
> > > + * to %DRM_PVR_DEV_QUERY_ENHANCEMENTS_GET.
> > > =C2=A0 */
> > > =C2=A0struct drm_pvr_dev_query_enhancements {
> > > =C2=A0	/**
> > > @@ -848,8 +848,8 @@ struct drm_pvr_ioctl_create_free_list_args {
> > > =C2=A0	 * @max_num_pages * ``sizeof(__u32)``.
> > > =C2=A0	 *
> > > =C2=A0	 * The buffer object must have been created with
> > > -	 * %DRM_PVR_BO_DEVICE_PM_FW_PROTECT set and
> > > -	 * %DRM_PVR_BO_CPU_ALLOW_USERSPACE_ACCESS not set.
> > > +	 * %DRM_PVR_BO_PM_FW_PROTECT set and
> > > +	 * %DRM_PVR_BO_ALLOW_CPU_USERSPACE_ACCESS not set.
> > > =C2=A0	 */
> > > =C2=A0	__u64 free_list_gpu_addr;
> > > =C2=A0
> > > @@ -1277,7 +1277,7 @@ struct drm_pvr_job {
> > > =C2=A0};
> > > =C2=A0
> > > =C2=A0/**
> > > - * struct drm_pvr_ioctl_submit_jobs_args - Arguments for
> > > %DRM_IOCTL_PVR_SUBMIT_JOB
> > > + * struct drm_pvr_ioctl_submit_jobs_args - Arguments for
> > > %DRM_IOCTL_PVR_SUBMIT_JOBS
> > > =C2=A0 *
> > > =C2=A0 * If the syscall returns an error it is important to check the=
 value of
> > > =C2=A0 * @jobs.count. This indicates the index into @jobs.array where=
 the
> >=20
>=20

