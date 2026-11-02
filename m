Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2678606A338
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lIxp1Er0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S5EnV+BO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0400210E608;
	Mon,  2 Nov 2026 13:59:48 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBDB310EEA0
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:59:36 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2DpVnV4062603
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 13:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=jDl1jeBrkJUqNUFNL16OIVdN8brVJ67X9WbVwmdzaFA=; b=lI
 xp1Er064GspN1zRmtcdK4p2Qi4sukyRxlwgpRBqOgFRzKduF6DGyMMK8+iXG11Rx
 fVXUmc/TgtHcTEpfCaSulV6sGd5kG2Yzq7roDqP5GTWGTGGfDae69TQ0JJ39qEou
 FP3P8+CyxSKQcrxKD9idZjUMViF1MeAvu/P1H0Q7vrvpk4xBSuTuw8gKIPBEaT8j
 NOvockeNnuEGkA/PivqHw063vsouEWMqtch0Uz+JywTj3DuCS/KIAE8UVbEf5fcw
 Uti627fooofEiyh0Q5P0GqPTII41Q40bPrPW1t0GTjBdaPDMBPdgxzqxrVbHCM83
 pWGOExnQ2xfuDdGmibsQ==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpnmesjxg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 13:59:35 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-464fb819ac5so3263852fac.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:59:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793627975; cv=none;
 d=google.com; s=arc-20260327;
 b=T5sW2t5/0zIw/BKBXESWE/ewBhS09FnP09GFIawfUcMKOjeR9ZEe8Dz9pCvX30qD2O
 TkX3SR9SOXY+8TUZqYZN3o147Q4Jdy+2duh2aYd8wZKSh8GqCD4Aytt4vYO4h7qFixOX
 kb4b3fwpVgunKI5qxMab9BXlcvbCZGbBRDSeMhhcKDJri106I0E7d0nCxyhbEDtgRJ/9
 evKch4LTV03/HiDfY3754fCGp5S0dIFwsYhYgh9t1oI6CVHFS8U2q2R+2yFESoxqOkS4
 G/eTv09yHpS+R0nqS4JCEFY4zvQJS+wzWeacUq42OEqMC9wYQvLOTasePpnDbtLK/0RB
 dhLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=jDl1jeBrkJUqNUFNL16OIVdN8brVJ67X9WbVwmdzaFA=;
 fh=6d8X2VPF0vB7aaSJYwoMHNMlWqc3OwCXRB9cqR1OqIk=;
 b=aqMBsp9VLx8T4qN8XmDl1z4/eNHqIURic2ZLwHpZMrZMuDk9VHLasefvbwuRVcC8KN
 akH//uf08s0IwQxpm0l6lYpCYUb6lAdXaHMCu5MbzUtAlrULriN+I0Z9mQ0J2gNmJSA9
 JnfNr7R3syv9vg76Eefr/+8l8Guuc7rHBfyYxwy8n0eJau/czTMU4vHsIquhwD8LL5ju
 enYK83fYB8KSOOqH0s9KcVNlOukpjlzFVn1R+5ujwLsUdxWB5bHhwgP77xm49AHlth/O
 bJSZ6YzxRBygrfkQuvL2diyljTHY0+2XZBxCTMid7tsAfahautYWIdjqV72lY2YKwNxc
 ZQDA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793627975; x=1794232775;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jDl1jeBrkJUqNUFNL16OIVdN8brVJ67X9WbVwmdzaFA=;
 b=S5EnV+BOqdzP4sELeLvhumBxp7VIkLxE4+zDMuwX9WaKyL30mtsalO6rsiitrwL4Cj
 2mZ2N+79MwKr/7TUTTOeeuBEq5FV//vu4lheRPFWIP6qmE8+4F5q8DhC8Nnb68SkwZac
 9P1fdzg1Hl8qIZiNkezcwY5cBX+i6O9Bq198ZGXIaWw5n9wc7npjg+3iGCMfrfavvP+T
 TYa9LiyAn1Y7yaQdNAG6IRp7ZCEtBCse1z1GQY7uXXnbfkiqDiMif9qm53Y/qfgDJKnd
 GHe7LQfzcM2/f1YemeBJ0bci+a8paYoa0n5Y+lSMMT3b0VNo0te8G7XLOMuF0yVg0HOW
 lXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793627975; x=1794232775;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jDl1jeBrkJUqNUFNL16OIVdN8brVJ67X9WbVwmdzaFA=;
 b=TJNjSDlSQVtCjWDJifNzUrze6S9JVvI0ifn+q5zzvrMwdkgHSSH/VYfCE9SZ4VHXUk
 mMgKATxekYBj5wdSz4v450RC5fnbnxPTBhODzQ+JSXKqFnTzxSBgNLOPffnxB6xSyqsT
 v7sMPTZBTj3GtxeJzYh0AAynuCR1L+VoO2DcI9UDxFV4ys19NsHjeR4JwrswRJsz/yw9
 VN6mVITGqM7HGzi8C0VPqW1qpjSyo7QevNhN+39C/OilkPL1AKtYoeaHTt4Q9/lZW3+K
 QvEb/2OuZysuMqIk5Srl0R6uKq06GjCVA+0icnEA/E/XAQ+24Sl0zITuHBFU1qqmDso+
 pcwA==
X-Gm-Message-State: AFq9FYIzeosyeFgLlKXeDCw/mTThq97keRt8/0/rVlOfMpEC3FS+KW8/
 26yJp3qw6/FB7yVE8vV5cHldWobHpt8EtZYH1q65EDvQneciwEz3tIMGugW5a+5lQfS1PbpvdS1
 TZ/0DX8f3LGEz+wUCmkUSgRdniIeEbYP0Y4OmJbba5/zv67wrDf5aukUVHZ4oFPkStH+8v4c3Ng
 FjMukEvnpqYwdsG/rFPnX8noK3lDh+oezuteIw1olkyp141g==
X-Gm-Gg: AYBFou3gJqvcnd8PniOz9YPKZuAkPJvwAYmdSvfkHiodr3rfi7gqA/wOe77aLTAbCYB
 MxSDz/KkA83Yol58xhR8/VDAsUTF0iLxRNC/Apxy0tvmOHd0MjeBU/ffARSyLKyF+gnOpLCYQEl
 hEDAJY0vXjA8ir83I0ROMq2RpLT+hL+FjKXGLNHqqxZHa12t2N0IAqigMqYw==
X-Received: by 2002:a05:6870:5ba2:b0:4a2:4c6c:c9d5 with SMTP id
 586e51a60fabf-4a90729ac7amr5634871fac.7.1793627974603; 
 Mon, 02 Nov 2026 05:59:34 -0800 (PST)
X-Received: by 2002:a05:6870:5ba2:b0:4a2:4c6c:c9d5 with SMTP id
 586e51a60fabf-4a90729ac7amr5634852fac.7.1793627974121; Mon, 02 Nov 2026
 05:59:34 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261101174911.25184-1-robin.clark@oss.qualcomm.com>
 <20261101174911.25184-2-robin.clark@oss.qualcomm.com>
 <90ae1b4e-d83e-4209-9df1-7ebf778a881a@oss.qualcomm.com>
In-Reply-To: <90ae1b4e-d83e-4209-9df1-7ebf778a881a@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 05:59:21 -0800
X-Gm-Features: AclHuK9ZhLwCfrUX-9m8aRznRVSHUF8x1JBC9wm-I47eYmvAKPX_Cth1Jx0xGxw
Message-ID: <CACSVV012ncykN3PnXnuP+-tK51r4kJ4BUfiThcjV2JYvn_jXwQ@mail.gmail.com>
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
X-Authority-Analysis: v=2.4 cv=KZ1HIgYD c=1 sm=1 tr=0 ts=6ae89747 cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=NaZcOW_h6FOph8AvsZMA:9
 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1NSBTYWx0ZWRfXwGFxxnduC/qN
 w+BPktz3JstXzq8OXkfwa1Bix8taiFKGwoiHjLYkLufPzaRRDZHJ+15CWqKx28QA1/5dc6NoEp3
 JkGgf2ldtydxzcxRp8ICVW6atC6PG/CEfc5X6Ekp1uzn1fnL2Fri4fh+b07E2lH+BNEvod45xHJ
 zX6HPu8GNfSz+/lG6hz6ibVmjKkOzjviHAONKOG5KbU8RHYSKFAROtSjufPw9jCLEO8awGkv7Ib
 n3TvxA8sSM8Iq8BAO0g3UdXkFdHlEtrBmpV8c2VivJnY8qgkLtR3zyU4fklmur2V/xRYrBusjHV
 AzXwwEeRC7R3poZgzghAB+XV9lJT4zHtPXy9uN6n1DShke7AxlDBIzi7tvlUrqnE2/5cuFWXszO
 u7Vkd06dLSQ2ljljKldewsWaaHuTqdgmor3CHu08YcpUkOHRWRa/dtnNf31nZRpUnQikqi8FOdw
 Z25weZnHviyaKD+Sh1A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1NSBTYWx0ZWRfX49jD0ogUgzJb
 /mTuUd2sRyiX23ELvivzBssu7OML0IfLgrROrgc3oCUC7CyVGsBmh9oA4AFEkWRN7lWokxpK8+h
 ikBpyaiKVWFhDd6OBoVCpIggx4Wd0to=
X-Proofpoint-ORIG-GUID: gjzFZBaj9dtjpPm_jshMjXvPeImceDoI
X-Proofpoint-GUID: gjzFZBaj9dtjpPm_jshMjXvPeImceDoI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020055
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

On Mon, Nov 2, 2026 at 1:40=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 11/1/26 6:49 PM, Rob Clark wrote:
> > Use size_add() to guard against overflow.
> >
> > Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > Fixes: 3a3bef68a6c1 ("drm/msm: Fix missing VM_BIND offset/range validat=
ion")
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/msm_gem_vma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/ms=
m_gem_vma.c
> > index f687a629629d..16b3870d5e90 100644
> > --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> > +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> > @@ -1118,7 +1118,7 @@ vm_bind_job_lookup_ops(struct msm_vm_bind_job *jo=
b, struct drm_msm_vm_bind *args
> >               op->obj =3D obj;
> >               cnt++;
> >
> > -             if ((op->range + op->obj_offset) > obj->size) {
> > +             if (size_add(op->range, op->obj_offset) > obj->size) {
>
> GPT and Sashiko are unhappy about what this does on 32b

Considering that we can't have >4gb BOs on 32b, I think the concerns
are probably unwarranted.  But yes, I do look at Sashiko's reports

BR,
-R
