Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39385606C54B
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QuHoTSHU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NMhiyRmh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8318F10EFCE;
	Mon,  2 Nov 2026 15:19:19 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2B9C10EFCF
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 15:19:08 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2DpVRx477173
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 15:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=PdDU8m93RcW1fZwZqI8+6F0AE7NDrUTsi9z6BVOaBVA=; b=Qu
 HoTSHU79wtw3WxydbbwxFGBHTAmhokn4hj/ikHi7Hv3HQFNcTvWoFCfojIh38ymS
 zQ8U5z8sf64CySh/M3RJSfvI4clEO4bfDX7O7wL+RElTGYfrMtvZvR82HHx6f478
 gldXZu4hwzuEubkTr/mIWCQahbJNvu6cUbP8h86mQEHUS+nOL0OojO7QLfD6ZslL
 sdSfD8KLWrEwGxjRs/vg+J1dDCrgG6SRHxheP8Zk14JKTPRKpXKpr+Cf5fLPnh9L
 GZPZuOgytRJQg1D8+hWf7fHKkocPkZ6efMIKNAhW+VXdQdsPwThWspX0VSpNJpFl
 qEhr4xrbzxWfAOYmblow==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpph19s6r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 15:19:07 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-466d41a1d9aso3372368fac.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 07:19:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793632747; cv=none;
 d=google.com; s=arc-20260327;
 b=TluOgXa0+kxWTSQNarTLQl8liOuNQ6Ir1wkU4UBQlxaFTEAG6gthPlUkZEP2pWPZJX
 nVdyu3HgS6G81oUPr7YfPmkgdIYVGwI2JBdKrTlz7E92fP6kSeuMVklQ45++DuqHsQF3
 yJY25gRkJWUSoI9SDDgv8vS+Wc2fbaVGMFnwDho3TW26sXvVS5zhUV2jkoAiXpKqcCW0
 6qnAdgq568NFbH2eMtrvpMbkVKpAn5XfGeh6SjeXPK+ueG290Vcz1Fl5dFKV2ctp5qdv
 sVeTKOu98ipw9fPfrurQl3eTVUT42iGyalEeIkpzJQAT3vzCwpoia/xlzo1PU0IXJSft
 7a2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=PdDU8m93RcW1fZwZqI8+6F0AE7NDrUTsi9z6BVOaBVA=;
 fh=6d8X2VPF0vB7aaSJYwoMHNMlWqc3OwCXRB9cqR1OqIk=;
 b=exANI2FRurxyLEdw/DxXeKHLAVqYyghRK7S8XB2mzQrUenXO1DhvJeRhzseyiFSVYr
 c+UwIEics6OP4+IiXlceojb4mD8w1yd8eHmgREM1NuRBUlvfczCa+dpiGZLAtpwrlMHY
 /n7rDmrkaQqNhyZyc6UWSWEtirGZHVT2cGt5/o2tDVm+QaKFlyYaFyhpD2T/4zw/Dc9N
 mlXIiNuiiyvJb0RhZ9zeVNcoi6MZM6LfaXr1ZOTnoZrt+kxE8+PP5m62uOWAPjyMzNPg
 5yuECKM1xIy3NfVigRgVSfhKhCnDMFV86thlkm303WPoP064fp5giuKpidnU5UQ7hLYS
 h1lw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793632747; x=1794237547;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PdDU8m93RcW1fZwZqI8+6F0AE7NDrUTsi9z6BVOaBVA=;
 b=NMhiyRmhma5SJxdss8oQCRtWY6hMoCAwXJhcBujaP9YUkDfUpsJuJEMmSAlSvdQqMY
 skBhMyUS9WPf6L8m39PD74VlpsbWjV36Hxb7pUIrdr1NSTPX9K4iDSk3ean2PSr6pK9P
 UwiCt/kM0L3DtZmvwuWHVFgEvU2x7WRRvhwxltMqHlqdZl9n/4szVC7Amc173B1680pK
 is1SSAe260UTQ5evAozx73tn3WrGy/HYsFtnomGV9eKZ3ju3eoh7WjvSEppCX9XXHZ0c
 X4V5YNYQJkpXVkHRzR+Oov1qxnWJKWhMlFWjyPRafvpSOmrAEz85otiEw2xRWlfj80Rf
 2SoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793632747; x=1794237547;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PdDU8m93RcW1fZwZqI8+6F0AE7NDrUTsi9z6BVOaBVA=;
 b=ifel2RQk551TtA76HpFaYLjnEvSFfktm7GixqHlzhX7guML2AicjHVc0qNoQlO98CW
 Swv7UrphzqeOIe8S/QuQapFe4DxpwTqJb02/G98glPGWCvfDFT72jnhJAzlHeF9s3vnR
 LA9wtvU97wCICTJoHSt08FRu1eyWW9iG5UcqNY73rnaJF0K1/8TfNKtoz1oSOwpaRiso
 Gsce1uldNYpIsVue6uDJ5eUd5YBS+X80ijbj+YfjMU7YNSWiN6CzCw5swtxQL0DbZwkb
 fCRX5unjnJelRbHoC1Eq8dhuMYA1mlI4578yseJtoI0Kf9cJkHK4T5BDn2JrJH6GJCz7
 fySQ==
X-Gm-Message-State: AFq9FYI0KJXfhv0WPW0faS57NrmJFB5SJIx6ICLmApLiSJSogtDfhQ1q
 h/Jd/OEi/paX95T+j3J7kvDHvcyjaxvYLSj3gKWqrUey9IgiQtI8/d5aE6o+q9NTIbl056F3A9B
 0wbFRpiugGqWEN/ZiOXxR6eW4euJISPbFwzhlso0ooHMZPWxyjnM+l36aBUcWZiQtbhe8Z4LRFw
 zVtJ5Fbq722cZFrSK1RhOZx1wmKcqexmdG5crwTBKRdhkX3A==
X-Gm-Gg: AYBFou0W77pc3FKAuJepHc7n7eqR7iBDFMJCqwSdrcrWkMIikJJ3uoJZ9PS5ZUN8vxi
 oiUxyIgT5g7+6E2dnaVy5hUeu/Md+j8lBe2fhIVLngrl/OKTCXCWTMTVkHhyUA6gGCjR75DPnE9
 srGFFFIKx3ozT6TaQXe3jrvNnUDxM3hFSM3kYVPOGKdktZnFDOhS59N86eBQ==
X-Received: by 2002:a05:6870:31a2:b0:4a7:4730:affa with SMTP id
 586e51a60fabf-4a907691617mr6816485fac.24.1793632746903; 
 Mon, 02 Nov 2026 07:19:06 -0800 (PST)
X-Received: by 2002:a05:6870:31a2:b0:4a7:4730:affa with SMTP id
 586e51a60fabf-4a907691617mr6816446fac.24.1793632746294; Mon, 02 Nov 2026
 07:19:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261101174911.25184-1-robin.clark@oss.qualcomm.com>
 <20261101174911.25184-2-robin.clark@oss.qualcomm.com>
 <90ae1b4e-d83e-4209-9df1-7ebf778a881a@oss.qualcomm.com>
 <CACSVV012ncykN3PnXnuP+-tK51r4kJ4BUfiThcjV2JYvn_jXwQ@mail.gmail.com>
In-Reply-To: <CACSVV012ncykN3PnXnuP+-tK51r4kJ4BUfiThcjV2JYvn_jXwQ@mail.gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 07:18:55 -0800
X-Gm-Features: AclHuK8f43_19qDcy0p2s8OAyXrGV6vF3SunCYGHH5JIns_9PiJHYiC99rZWaqw
Message-ID: <CACSVV01=19OWZ4i1Bc-j8m8u0+5jtfOgqPU-VfkLUQUQ_oVdmg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/msm/gem: Fix VM_BIND range check
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 8gH_xozur_rnK24wbW-U9FLK-gtmx48D
X-Authority-Analysis: v=2.4 cv=IruL47/g c=1 sm=1 tr=0 ts=6ae8a9eb cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=q-aMyWzK8yv6Tw-4Un0A:9
 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-ORIG-GUID: 8gH_xozur_rnK24wbW-U9FLK-gtmx48D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfX9QLZ4kY7EHmx
 q1Ybh2p/rtZJOv1SXrmeopt6kgjqpA0efUZzrivsogTK73P4TPUGeWL8h0Zq+NqN+fNJnMEVTZo
 0bIUX0zudl9pvA3gSjJBdyI8V2MnWx6ysvN2oqiS5/MwjRyotLyoU11Zx8oAbcCxCkU8nAM0MbC
 gxi6zO8HKCvJDvpF1FFCfFx9m1sRrdKjDuRLI7Tp8zxa1/OezldKHGvyenWuBkhHjJr9pEXqjjv
 JGOtk0EuvcxMRu839pH8hOOg2BeNodGq1h+5MwF+oWGBx4kn1Bi5BnUmO4Oi/f4BlaxPT8tEbLU
 UWA66rlG8RX8iOwzi3Xf0k81D22Kr5ETS6r7Hdsv4yGr/1l1QWjXBMBNci9X5cGw1k0+2opgtSB
 CiCGQ9fPrE1keBf+A4rpak9SjZlD39Z5M1IHgQ3XJzDkkpAAD/Y+909uCANz47V21XxIlnGx+Vj
 Z7KoenAjsbh7tZRQo/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfX5Yt0BL2wCJmB
 yYo3D8Hn4i6SdctvZpdvn0gocc+25QNYkaR5gjTWTc3GubB/vxMQNQ0Rc5jlqmPOD0D0N4m9Rh5
 mD0FZSsoqIZP1N96Ib6Qj3cj/pe/8WA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020060
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
Reply-To: rob.clark@oss.qualcomm.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 2, 2026 at 5:59=E2=80=AFAM Rob Clark <rob.clark@oss.qualcomm.co=
m> wrote:
>
> On Mon, Nov 2, 2026 at 1:40=E2=80=AFAM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
> >
> > On 11/1/26 6:49 PM, Rob Clark wrote:
> > > Use size_add() to guard against overflow.
> > >
> > > Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > > Fixes: 3a3bef68a6c1 ("drm/msm: Fix missing VM_BIND offset/range valid=
ation")
> > > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > > ---
> > >  drivers/gpu/drm/msm/msm_gem_vma.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/=
msm_gem_vma.c
> > > index f687a629629d..16b3870d5e90 100644
> > > --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> > > +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> > > @@ -1118,7 +1118,7 @@ vm_bind_job_lookup_ops(struct msm_vm_bind_job *=
job, struct drm_msm_vm_bind *args
> > >               op->obj =3D obj;
> > >               cnt++;
> > >
> > > -             if ((op->range + op->obj_offset) > obj->size) {
> > > +             if (size_add(op->range, op->obj_offset) > obj->size) {
> >
> > GPT and Sashiko are unhappy about what this does on 32b
>
> Considering that we can't have >4gb BOs on 32b, I think the concerns
> are probably unwarranted.  But yes, I do look at Sashiko's reports

Probably we should add checks that obj_offset/range are not more than SIZE_=
MAX?

BR,
-R
