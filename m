Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21349606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lUEEKPSi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kv+EhYiR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B95C10E07A;
	Thu,  5 Nov 2026 13:01:40 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C85D110E07A
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 13:01:29 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5Ahxtu1582975
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 13:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=XeRy0oEaa43dns1qWHShRBlWSY0H2JNTqzR6NqinL24=; b=lU
 EEKPSiWqKZWaHU/bW6jGHmPPlsvYPXsSAcneaDK76rvOeY+PHGa8Z5KfZUmwpBtL
 YYUYCZkFrsNTLoOGVPUmKPaWVxtpx9Wcu0RjKppbD2+d6h0hYObfulFBV7ZCoy2k
 OOgmDjWawtHGm9q6nwvWP61zt2x4eymRTYHT32+LtcpsoYSnaqES8nxZ8ql3wpZf
 lxGOHfCte1z60PzfhnWkDnsiP+xjWRnyO9fNibEcJRFRIjs4zokoPcREZ8QLPgnP
 LHhbgBUFYWU21f9CTO94zD736VPYycRCRxqyZIcNWp8CfCugngx1gj/AhZXZL/Sh
 16nThmAjhxP9NTB1XtYg==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrraarhqr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 13:01:29 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-45e6091d8a1so1022079fac.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 05:01:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793883688; cv=none;
 d=google.com; s=arc-20260327;
 b=s7gjmSRN3mDlhZAipVbPwUIADfbvjk4iGB7ZiOsqtsvcB6KtBrdE7Zv5CcV3u00N/7
 ldkaT+hKe+x6EqGa/OS3tC5NSqL9Rmu1Ispzsh52Gfxm968feUB8oRx0GvUXJgb3FKr3
 xEd1inkGJMtUFyGScNMPDpuQv59MVBu/ihdhxnQ0fKc5C/t7vQwdVrNsl4jh+5RyxZ73
 ZmjWYXnkUO1hZLKZET9/6ow2V0rOcYS8XtZQNTF+o5790rgvrjCZ2uLu3kERwLKU0vuU
 bUngbodT7ySjSPRF1xy3Dv3bLMyguEqEX8DOSeZXuIuE1oxHUk/+qOWHVjTeM66vcH8Q
 Gsvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=XeRy0oEaa43dns1qWHShRBlWSY0H2JNTqzR6NqinL24=;
 fh=+F3HPDkT1jiG+bEE1KDFP0LwtqDpVSyReumefbYDau4=;
 b=gkWpOSGcQ/jhCCPYDnXWf872999cRA906DOikAFKWog/SNh4rZh+33VXDgl6Vrkyvr
 EWFEO1/1N1OazDvuDEJapDOB2mrLECE8Pkw2jOqHo7uf3J67DcIi/9F86HD6nO7P4KEj
 EVYxTlrq7BPc4Plgi78k4uBoWivnj8OhtOn4W+oiv9+YE1o8j/5KsmLYQwVOthbc4xvD
 EPWXkJ4LRtaKm8w1ot1UxP3yrTikbugLhywXrBSptYbKVG3PhDfkHyzm+AlvZHXH4LWV
 iT9s3/MmpY23woPnxEy151YA/pLDtUuR1UD8Evq1VqrNEhcHAvP7yn6Re6HArXAxxahK
 mtOw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793883688; x=1794488488;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XeRy0oEaa43dns1qWHShRBlWSY0H2JNTqzR6NqinL24=;
 b=kv+EhYiRmmpvAZr1iImYCSqHRTFc0f3MO2rQoRXzGiLfqUSMXEDiAPUmh0ruRNt2Wv
 2zTC879iWs20Q02/705IdfNRRmFu2QEJ1uODegiLZK3ChqgCQsFpjiSeyHfuhwxY+4g1
 HLRSxP2zt04x+ayHQmWtAqnkRSEFFXG2vTVGyER5geWsTMMPWvZ4zO/iCg7yN/26YpsI
 2eVZuLXJDyvVN7RpH6DHpJvm36OY+jucquoC/u9ASBvBCTwRjW9FpQAColO7NBSPmEva
 3Wh+do92vuTOB5+l2zftJktbWkqcP1ROcKJxAJaopokTW+MCXaP0DMqsAeQZFNdb0nlH
 QXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793883688; x=1794488488;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XeRy0oEaa43dns1qWHShRBlWSY0H2JNTqzR6NqinL24=;
 b=YdPQ2zxJCpLVusljuTdCHzlYSWVUTps5oO2meSbo+IjjkF+g8nENpzAdkJU3tqM1Mh
 0xh09SlcU9OFlZ3qZBt6DOoCHgEZAgGyYDDoHSXX2cKJGvZ23/mahowlzGwZfRdaNLfw
 5pSDXLXSWqDdAiY7DuDUi60f5LPXc9VVf6eqeVmoHCeqFizM98T49sx/0NQelDaxIvy/
 ROc59TVT0RMjIYZ5HMTbuPHIOtaYx/WMFObis7/tRu6EcGXMFkt7uF3ymU+YCIiiPIkX
 867HkBiHEjpbev2hQuM7jeMaJ8Duw6mS63uJuNkonxyFkSNH6jZCsADiiTu1C5GQ+jtG
 8D2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUkaYon842177Ka99a14kqfSbMSQYRpA0Bl00bqBdYwcQYQ8F8lJj1mUIy0/F13OW/ldp9dUqYpzc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/ZKX0gO1NOU/4kJmvaQBO2qtzZrY1fDyNczMXU5M4FALkHIp0f
 +YioHw7EBSC/fQyTyuigANDao0Jjqrc1xRuCxaBkvoRYDyOJjqrIqYw8wEGidKAsIhCfFvFA7W5
 snEbUuROT4ONrBUjsEuNjMq4Ua7YHbBtHq7fjAbBVLsS/JTmNwTz8U4kVrQFTwoWG89Y1f9ZMos
 48UADY8A6RNgLT8xvKq3xZYN4crUF2kbRFSVbpe4tt+l+eSg==
X-Gm-Gg: AYBFou3+ANjbL9gzlkTSA0K3ooH1HRrcVTROy2olVWSx3UdYFoBv21TJl8fTs4N3qf0
 QfgGEfX7z87QJAwYIYO9rx41ExCXqsPHBgZ6xw23iy/ETPYbHvyzs8S5xF/wotuquQr4V19e9fO
 LqAa+3hdUnK+njqKmz26Kfv2QfF7DHQAw+yrBFW6idH0SunvKdandGIuscMQeNJCFzB4OBMtjZw
 BSVDpGKD5GjIwHj3N5UPg==
X-Received: by 2002:a05:687c:8c7:10b0:4ad:76eb:60dc with SMTP id
 586e51a60fabf-4ad76ebcb9fmr862207fac.27.1793883688093; 
 Thu, 05 Nov 2026 05:01:28 -0800 (PST)
X-Received: by 2002:a05:687c:8c7:10b0:4ad:76eb:60dc with SMTP id
 586e51a60fabf-4ad76ebcb9fmr862182fac.27.1793883687555; Thu, 05 Nov 2026
 05:01:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104-ubwc-format-docs-v1-0-389044012b4e@oss.qualcomm.com>
 <20261104-ubwc-format-docs-v1-7-389044012b4e@oss.qualcomm.com>
 <86b801ce-a56c-4ff8-8915-9be369fc0ce8@collabora.com>
 <CACSVV02t9=tm2qyG531f8Ne90ADAb1_ZDDGEg7PwDmoEvGxPrQ@mail.gmail.com>
 <7b4d3a85-6aea-4b96-a4d0-c2f16e488ad9@collabora.com>
In-Reply-To: <7b4d3a85-6aea-4b96-a4d0-c2f16e488ad9@collabora.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 05:01:16 -0800
X-Gm-Features: AclHuK_FTfX1bhtgOB5smy8jkMhXcHjbMGJa7VVWz-rbBqyySfj6RR5zIBt9uVM
Message-ID: <CACSVV01ZhTxeJV6qUGXvM0cu9tkriu_cnDJ1zn83WjXQb6ABbA@mail.gmail.com>
Subject: Re: [PATCH 7/7] media: qcom: iris: describe QC10C as TP10
To: Robert Mader <robert.mader@collabora.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 "Bryan O'Donoghue" <bod@kernel.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jordan Crouse <jordan@cosmicpenguin.net>, linux-media@vger.kernel.org,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX7xx4cz7usdRm
 1ad8oQrs6Nq2CKPrW0sieS1Cj0vhUUBMVKNwFGguv9DpML/avBS9+kb8fwVi3ZctFMlin0Iw2oD
 KYNCYSpPOeZtMLDCb2rEP5iuhrj6kGA=
X-Proofpoint-ORIG-GUID: y9j2Uda-YH4jNSpbgjayaSOQ_ohxb4gm
X-Authority-Analysis: v=2.4 cv=U54Hnuru c=1 sm=1 tr=0 ts=6aec7e29 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=e5mUnYsNAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=xAgDbal6OUhFU9-prukA:9 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX/VXnkLgdovPm
 Jfjo+1GVjTJRVmjgneRdtXYElOTB8I0gRzKTivjH4+XEvMG2Tn7kz8FJxL0mB0gCE/eZDjuD/Hf
 S+Qx90AXGShAEYaqfV7cy8vuYnc7pqRA0LwGPkUwyXsWlqhWQ7Pqvgi/Y0MXGZL2gErt5s2uvV0
 9ubtBcq5YYdSYQrXX4zdH8S/yXL0rX7qJgrDY6wuk/0K7uof0SxgXu36Id2h1U8GGPTGuTXuaGw
 XRtLXkfxMlqtr+tQuOS6SDP58KFbgdvClYM2bq1hFvTR2aFljHMZTM5hJ9l1GR6XewM+Hf4Noc6
 CRc01kUf7S5NDJcsv+/gPA5KrNTeMLrZObak3dPvanC55mtNkT4WiSgi5k/b7BJ4MeuxvlcaJKe
 t5Wnmc5cF6LtMvbkUCoptY7Uxm5DhkBJzCcxdEDUr1BUW2AQm2qcmimLpXFsjo1x4vGOyC5DMUu
 cYLi7/HLcCw/TLn0P1g==
X-Proofpoint-GUID: y9j2Uda-YH4jNSpbgjayaSOQ_ohxb4gm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050051
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

On Thu, Nov 5, 2026 at 4:35=E2=80=AFAM Robert Mader <robert.mader@collabora=
.com> wrote:
>
> On 04.11.26 23:11, Rob Clark wrote:
> > On Wed, Nov 4, 2026 at 11:00=E2=80=AFAM Robert Mader <robert.mader@coll=
abora.com> wrote:
> >> Nice, very happy to see the series!
> >>
> >> On 04.11.26 17:36, Dmitry Baryshkov wrote:
> >>> The comment describing the QC10C buffer layout calls it a compressed
> >>> P010. It is not:
> >> If I'm not mistaken the display engine / the DRM side (including Mesa)
> >> describes it as P010+QCOM_COMPRESSED as well, and so does my pending
> >> Gstreamer MR [1] . So if we can't pretend that QC10C =3D=3D
> >> P010+QCOM_COMPRESSED, then we probably need a DRM_FORMAT_TP10, wire th=
at
> >> up everywhere etc. OTOH if we want to keep the DRM side as is, then th=
e
> >> comment should reflect that, IMO.
> > IMHO we need DRM_FORMAT_TP10.. on the GPU side, we have TP10 and P010
> > as distinct formats, both with and without UBWC.  I'm not sure if the
> > same is true on video side but P010+UBWC was never exposed, or if it
> > truely only supports linear P010 and UBWC TP10.
>
> Oh, do I understand you correctly that the P010+UBWC implementation is
> not compatible with QC10C, meaning on the GPU side (Mesa and display) we
> don't yet have any support for QC10C exposed to userspace? If that's so
> then we don't have a choice but to introduce DRM_FORMAT_TP10 I guess?

Yes, TP10+UBWC is different from P010+UBWC, just like linear TP10 is
different from P010.

In all the cases including planar YUV, there is a single plane per
"logical" plane, ie NV12 with or without UBWC is 2 planes, etc.  When
UBWC is involved, the UBWC meta/flag data and pixel/color data is part
of a single plane.

In slightly more detail, in some cases we program the hw w/ a separate
UBWC address.  But in particular for planar YUV descriptors we just
have one address per plane (up to 3) which gets programmed with the
UBWC flag/meta address and the pixel/color data must be at the correct
offset from that.. at an API level it is easiest to ignore that and
just treat meta/flag + pixel/color as a single plane everywhere.

BR,
-R

> On the plus side - this would allow us to make the format single plane,
> matching what we get on the V4L2 side.
>
> >
> > BR,
> > -R
> >
> >> Best regards,
> >>
> >> Robert
> >>
> >> 1: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests=
/8195
> >>
> >>> P010 stores each sample in 16 bits, QC10C packs three
> >>> 10-bit samples in each 32-bit word, which is what the stride computed
> >>> below (width * 4 / 3) assumes. Name the format correctly.
> >>>
> >>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >>> ---
> >>>    drivers/media/platform/qcom/iris/iris_buffer.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drivers=
/media/platform/qcom/iris/iris_buffer.c
> >>> index eb8de60c1177..ec2bf2a2d953 100644
> >>> --- a/drivers/media/platform/qcom/iris/iris_buffer.c
> >>> +++ b/drivers/media/platform/qcom/iris/iris_buffer.c
> >>> @@ -266,7 +266,7 @@ static u32 iris_yuv_buffer_size_qc08c(struct iris=
_inst *inst)
> >>>
> >>>    /*
> >>>     * QC10C:
> >>> - * UBWC-compressed format for P010.
> >>> + * UBWC-compressed TP10, YUV 4:2:0 with three 10 bit samples packed =
in 32 bits.
> >>>     * Contains 4 planes in the following order -
> >>>     * (A) Y_Meta_Plane
> >>>     * (B) Y_UBWC_Plane
> >>>
> --
> Robert Mader
> Consultant Software Developer
>
> Collabora Ltd.
> Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
> Registered in England & Wales, no. 5513718
>
