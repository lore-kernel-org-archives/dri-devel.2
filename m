Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7830606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OqO43WIr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S4elmdb9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04B5E10E0E3;
	Thu,  5 Nov 2026 20:53:21 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8982310E379
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:53:10 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5JMWWg599701
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 20:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=sX8j+rhapnFRAdikVp9Pz/gF+oALejP+4Db90hXaOAI=; b=Oq
 O43WIr6igflvAIkd9ASejt2pm7/Vf9caX5Pk315Bc5ggbNfK9F2LpMRsevBqIwb4
 hPhmzZAYplsNr3OTmx0bYsmVnISLeK+458SAt6/W1bu4Jz3ROc2RmVBt8UUjiXCQ
 nZZBOgkiByaNQmV690shz+jF+TDJzxDb27WHOrSkeVYU20FfOPbqFYGYbera5F/5
 NHF/t/LinRDZ/dBI1uXdtTJ8n0TqT9UcD4ZQLFKVqPGiJ7wC6qhcV8yyDPgKpGqK
 i1l8ujZZSz8UlmrG/yE3H4ZQwpendLKunNHPd3xPOjL0W9EbmYiIoRz/+OJD0mNt
 BqMwb9IrwRKk8bdcmrHw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hryvv0d00-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 20:53:09 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36a3451ea93so3219651eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 12:53:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793911989; cv=none;
 d=google.com; s=arc-20260327;
 b=KlapxHf7sQMQeKcG+sAhnotB7Eo9KAUF/L7/y8z+JC905pBOmqm4Mwijfzd4iaigSs
 9UB9+mRU9GiWLJ3JzvOmCOdf8jNT7DkumRylG7QMejalWWLw74l2B0P5h7Q94kGhA4mG
 bS7rytdRxsQSkeJARFL3dhERaymK42/svGTBWHBHmOPyZEdjN6EO+1bKZD8lByJ2fdHr
 81mNCxtktbVnnCJ3gCHivNysEE51piLPcb83e8mOa0uFCDuQjJ2Tiewv+e7LAPxpD6cj
 ISeBXgsTY0QtudUDN6uuVLrVSyyOfUw2jhEa5cKA6ate8vr8P75AQqdf8CZYt1yr/VAr
 1MfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=sX8j+rhapnFRAdikVp9Pz/gF+oALejP+4Db90hXaOAI=;
 fh=PYZMJWLu+2KhAuhgHRoKHXvG6Zk1A/iRDvu1mxmVWqM=;
 b=E722D+7H8DZwXlcPEt8343l5QfnMZkLRqlIzXGzDNWa9EvBN8iiClQLoghKhK5NNM2
 r6xHWZ47i2x1EddSBkRvyA0OSD+REbpM3BmpLPt0jkX4iBtBmsppuKa4ThcJ5SniY/8H
 4LqVW/i+AtuQDsS+iR6YxQShMzDDnOeJCjQBVnMxUcmTbbsz/wSI/h1W9j++y7uOAdX2
 fFWMPhrL5dwMknUlYlQtbgOuiG2YOlkxE1UoDshKyUZDTQgnmjK2wF2qfW/7S5ZFJIQs
 SVPGX8AwoU/7OX/BmGFfrWcx+dr+gkrzteSH44PxvRfBhZtAVvyQfT1CCZS87Tn3PG2A
 jGLw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793911989; x=1794516789;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sX8j+rhapnFRAdikVp9Pz/gF+oALejP+4Db90hXaOAI=;
 b=S4elmdb92H1yWehYfn8KJUo0E7hgFAmUPS8AFcU+ytsfiKXYa9Tg19QXk0+nf1TVWj
 MTS7DCu30KETElyWFosB5CRB+U5ckDbVgBzv18ZUD729/RUwUX2ChgzumszRvebsqhrt
 x0wCNdcRHuv3SDhecqJVJG2DXPbKhTiXLwcOTADmP0De/5EyYVqwtZpPG1OSQ5mCylsE
 aEEb34YgVf1zsFMs+I6bCMUrrhZ1O7H7aVkaYHpUInfHrQS+90qvBmxeV7+9HOkiWLkI
 a8/j4vdtw7OXkXTg9RhpXLj0egVmBypS+nZzpUNS773b7hZ6VWGFmCaYmtYRiMatNnXR
 ccKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793911989; x=1794516789;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sX8j+rhapnFRAdikVp9Pz/gF+oALejP+4Db90hXaOAI=;
 b=yHxBnqHJpA20jQbtV6YFa5fH3iwuoYzm4yvLtVIdeJ/CzwFPKpnj2qgR8q/n2UYdzs
 qGlGfAAqwsZMqqH8LwE6Saf4pkoAZMK44TP3FB8SWqXIQ/HOBPelNKi5DxjjQyS4SLEK
 jtH6pPIym7eh2HeGOBXpZLlo6tRQc6zYa2xkeQuO5tDBHCRCrONb+CCupDOCQ1IY0CO8
 OC6gN27hETiHrGCHgwbp9ocqBZFeBqI66dqIi1kUI7w/S+3dH1g0SntKVI9FXs03iam7
 2tDKnQNB3AbqmDktGtuByLT+SNEz7LZTnYMZHdIe3ri/tUrRGSN5x7YIFcrfvLDXjpmE
 xX9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxr7j25xOFaj2Se/ZgTu3YR8mIMjbaiQSb4qlo0/cwO/WxfiZ12vLhMOtVJAqo1owzvnpJf8c1XjC4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8oV2g1P/B9g/vsQxcIA8z9GT9jKboKHx3xcZ7i94b2si3tV+TH
 RFj8Oj+/GhrR+xEia/spaiftwp3UiBTKif1stjSt1ZNd8pVZ9BZTgNlZcDK9klorpavlCw+hFBS
 yiCVzJ/S57T5tuAFWJDvPllbv4lK6jI73bB2o56YHcTdH4OFdZ/c55lYhjudKORgL79MX2w4b6m
 Y95gIQ7J05FEL9WhmVG0566PqgDDeb0NVuEUnt5oTjALrNZA==
X-Gm-Gg: AYBFou3yRKSguuEFd+FswU0x8J/+gay4dO02LD6PEE/yM4dHQ613YSeAFT+mkibp2oZ
 55KL5BqE1MG6GuiUd6hG55oQtW29wAQsWOZsoCgdwBnU4adsT+0B7oUzGH5Bp+tnA/SM4rX/0Wl
 AANAsb/VDjK9PlcghBoV2vZsm0/L7UfquWXYutzieHzxcxffg7fic6Wd5kFSlWPcn1tzwkBxVYu
 vW84WHB2Gm2JQZaRYxtoQ==
X-Received: by 2002:a05:7023:a86:b0:156:6676:d0e2 with SMTP id
 a92af1059eb24-1b25d2fe849mr303325c88.10.1793911988313; 
 Thu, 05 Nov 2026 12:53:08 -0800 (PST)
X-Received: by 2002:a05:7023:a86:b0:156:6676:d0e2 with SMTP id
 a92af1059eb24-1b25d2fe849mr303269c88.10.1793911987586; Thu, 05 Nov 2026
 12:53:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104-ubwc-format-docs-v1-0-389044012b4e@oss.qualcomm.com>
 <20261104-ubwc-format-docs-v1-7-389044012b4e@oss.qualcomm.com>
 <86b801ce-a56c-4ff8-8915-9be369fc0ce8@collabora.com>
 <CACSVV02t9=tm2qyG531f8Ne90ADAb1_ZDDGEg7PwDmoEvGxPrQ@mail.gmail.com>
 <7b4d3a85-6aea-4b96-a4d0-c2f16e488ad9@collabora.com>
 <7e8a6645f181c9e8d663eb97bb1f32e3e4fd8c67.camel@collabora.com>
In-Reply-To: <7e8a6645f181c9e8d663eb97bb1f32e3e4fd8c67.camel@collabora.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 12:52:56 -0800
X-Gm-Features: AclHuK_2VHyuNEs4DZc22sx9QJcK0ltaGhWBXQlToG9hpn9RflPMYR8eoL4qhGs
Message-ID: <CACSVV03Nz=das+fneMqx9UE1Vzps55=_An-DtmufRTxdhv2idw@mail.gmail.com>
Subject: Re: [PATCH 7/7] media: qcom: iris: describe QC10C as TP10
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: Robert Mader <robert.mader@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
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
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4MyBTYWx0ZWRfXzqD4XP4fC1Wq
 nXPsxfLm4zy8BwES9HknINtK5f2QXMt65BweHufdkgkTm2XxDNM6oOxT8a7ujxHlb6Z/yJH9xQv
 TDEhje6NpkPsK8CqRHoxBQoeAwbGvQE=
X-Proofpoint-GUID: EcTYAJSlB1-6tS1AsfSOI8gGx5cO2HlC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4MyBTYWx0ZWRfX2UrGqQTfuxNF
 DzdUzhhkDqWSux0mQ1HsukzDb8FWrRQFfbVlxQdPUZOOPnVU8vPEPUvK5/wLtH4WAZU3Zfb4Ygr
 68fUR3Y4Mu3BWGz/tvw5piopaAHe9854bZHFNvlnpcZJH8yWbSj7EX5SuwGr+srhdce/KJ3xno9
 yKBmwDTQBSt369vIXSBKWTwWb0RgxywrSDO/1GMCw3m7oJuMdvyZtxP+ES90G6+PubbOO/9JgvQ
 jKATYa0s4tRka8PsDjRc+rvsSL4xTG3Bkc3zgxN+PRF4IuHm0QfcyHfmYHy36Mxfmh3tLNVVX8S
 g55W3ezqAtvotwyM5CAbWcIxrXci1BITvTTRJHc4Ir/oeWX3DuRpPQhPoMAxeyZcpnIaNzwXxnF
 ovdEIQrNpl+mLwoeEbyYdvzYZncahMecmfXAd+bgcNWf7m6D2LoPE1fo3DhOMvfigSR4wjoHSaE
 Pl0fuWBVqHQe9zExd0g==
X-Authority-Analysis: v=2.4 cv=dKUzC+Zb c=1 sm=1 tr=0 ts=6aececb5 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=e5mUnYsNAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=vmm0ZkxeQxYXhTVWvzMA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: EcTYAJSlB1-6tS1AsfSOI8gGx5cO2HlC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050083
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

On Thu, Nov 5, 2026 at 12:35=E2=80=AFPM Nicolas Dufresne
<nicolas.dufresne@collabora.com> wrote:
>
> Le jeudi 05 novembre 2026 =C3=A0 13:35 +0100, Robert Mader a =C3=A9crit :
> > On 04.11.26 23:11, Rob Clark wrote:
> > > On Wed, Nov 4, 2026 at 11:00=E2=80=AFAM Robert Mader <robert.mader@co=
llabora.com> wrote:
> > > > Nice, very happy to see the series!
> > > >
> > > > On 04.11.26 17:36, Dmitry Baryshkov wrote:
> > > > > The comment describing the QC10C buffer layout calls it a compres=
sed
> > > > > P010. It is not:
> > > > If I'm not mistaken the display engine / the DRM side (including Me=
sa)
> > > > describes it as P010+QCOM_COMPRESSED as well, and so does my pendin=
g
> > > > Gstreamer MR [1] . So if we can't pretend that QC10C =3D=3D
> > > > P010+QCOM_COMPRESSED, then we probably need a DRM_FORMAT_TP10, wire=
 that
> > > > up everywhere etc. OTOH if we want to keep the DRM side as is, then=
 the
> > > > comment should reflect that, IMO.
> > > IMHO we need DRM_FORMAT_TP10.. on the GPU side, we have TP10 and P010
> > > as distinct formats, both with and without UBWC.  I'm not sure if the
> > > same is true on video side but P010+UBWC was never exposed, or if it
> > > truely only supports linear P010 and UBWC TP10.
> >
> > Oh, do I understand you correctly that the P010+UBWC implementation is
> > not compatible with QC10C, meaning on the GPU side (Mesa and display) w=
e
> > don't yet have any support for QC10C exposed to userspace? If that's so
> > then we don't have a choice but to introduce DRM_FORMAT_TP10 I guess?
> >
> > On the plus side - this would allow us to make the format single plane,
> > matching what we get on the V4L2 side.
>
> Since its single plane, we should aim for a variation of
> DRM_FORMAT_YUV420_10BIT. Similar to YUV420_10BIT, there is no obvious lin=
ear
> single plane packing for that, it would only be there to support the
> compression. Or maybe this one is abstract enough to be used anyway?

Oh, sorry, maybe I was a bit misleading/unclear.   TP10 is still a
semi-planar format with a Y and UV plane.  But each of those planes
combines UBWC metadata and pixel data.

Within each plane, the pixel part of the data combines 3 samples in
32b (compared to P010 which is a single sample per 16b.  So not quite
the same thing as DRM_FORMAT_YUV420_10BIT.

BR,
-R

> Nicolas
>
> >
> > >
> > > BR,
> > > -R
> > >
> > > > Best regards,
> > > >
> > > > Robert
> > > >
> > > > 1: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_reque=
sts/8195
> > > >
> > > > > P010 stores each sample in 16 bits, QC10C packs three
> > > > > 10-bit samples in each 32-bit word, which is what the stride comp=
uted
> > > > > below (width * 4 / 3) assumes. Name the format correctly.
> > > > >
> > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.co=
m>
> > > > > ---
> > > > >    drivers/media/platform/qcom/iris/iris_buffer.c | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/dri=
vers/media/platform/qcom/iris/iris_buffer.c
> > > > > index eb8de60c1177..ec2bf2a2d953 100644
> > > > > --- a/drivers/media/platform/qcom/iris/iris_buffer.c
> > > > > +++ b/drivers/media/platform/qcom/iris/iris_buffer.c
> > > > > @@ -266,7 +266,7 @@ static u32 iris_yuv_buffer_size_qc08c(struct =
iris_inst *inst)
> > > > >
> > > > >    /*
> > > > >     * QC10C:
> > > > > - * UBWC-compressed format for P010.
> > > > > + * UBWC-compressed TP10, YUV 4:2:0 with three 10 bit samples pac=
ked in 32 bits.
> > > > >     * Contains 4 planes in the following order -
> > > > >     * (A) Y_Meta_Plane
> > > > >     * (B) Y_UBWC_Plane
> > > > >
