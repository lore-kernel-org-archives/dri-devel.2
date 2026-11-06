Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7412606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 19:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kcVTlkY1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WBWREgB3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E10FA112FAE;
	Fri,  6 Nov 2026 19:28:54 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D02A910EA4E
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 19:28:42 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6JL63l1699926
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 19:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=eBPjMwVd0jaBoQmrGoNaoqquijK1PZ3EZwzevr9JqQ0=; b=kc
 VTlkY1xd3z3BoetGvpZ4gUcASg6DoYN/uisq9AloTvAgCBoeKlBAsfSIqDEoypCp
 hg0w51FC0Yq0JxsNVez262dvaxDQoFeapCbrSfGg8oXV0+MhUGrTIUJDMNP0OuNn
 mEC9MqOuwBn7J/nXTRPcsocpxbCkqyoJ/XV6mkR/pL9l2jSSHqDeXCSdfa5SA2t5
 QiWJr6liD/mowHNlvTb2I70Y1Dd1OatzpZE16N4+Crq7V6IirC6QWe5268cYb9oO
 mSZcDbtp6xJK4VsNN/Go6yIJVA2ZLRuEzkcs+Wp1z7pya9a9SybTpzB1xVThOtdI
 beJQ8IFFa3vIucu/YC6g==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsmypg0xs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 19:28:42 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-821de0b7baaso1348254a34.1
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 11:28:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793993321; cv=none;
 d=google.com; s=arc-20260327;
 b=QT64QGz9A0R2DNEXLkKJvFFVDCj+EN9C+GNue2A9+2y8hUZadnZOpobmxy7xq0AfK+
 AsByWhQdk+spzcGM+fsOXJBEQAGt1NyUyrr/eiMeopV5MM4osRwNtDRHCypfyjjBs2+8
 v0f88z4baKZb1iYjm5lvXqgdftYw5sFq3rcNgh3fBtz5SdNq/LsCdPCfl2+Dsfnbzp07
 F73zcBBal8a1pVOeVYJgsvjXfwp3CdlN979GBDonoO0wVGRmFzs+zNEtdNyWksVgP0QI
 gpK8ER6E5xekq1pj/6NQUW65EbsKH9KPUPL3R65OQb1Y0tWnWbauJUm08Ts6keT7n2Sa
 oZkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=eBPjMwVd0jaBoQmrGoNaoqquijK1PZ3EZwzevr9JqQ0=;
 fh=cJQ4RLwy8VQWgX33AFnhjJCF4AKfDhT/cdXxmnT7vss=;
 b=VGZRizdI9JiLFK2z4EX9f6OiWw8qwEWgF6xil8d+k4N5CAPkjc2Xy1/hdiF8tC0j5E
 KFIaX+khi+h2SNTPS15DVyzSjAEQioPJY7Y3D3PrYrnnDtjJyPbWxEUUsrEH5QnA5/b/
 jMVe5F2N9IXqSPO5q62oFWwGaKNkJnzrCGNyppp2sz/5sjjs4LIVlt7Bluo4eqKwG2yp
 ehvM0y4PYB92Szi8fYpuLaiWu0v4s8iPIw5f5We2rLa6BS1DZ2YRiFniN8SrNnTo5L0G
 dSEDmeFVwBut5P2cvN43L7ZL+lpnChpiUbo6oOLk9eqgLFCrnY3phPdHdGVE36A2jYvq
 JHzg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793993321; x=1794598121;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eBPjMwVd0jaBoQmrGoNaoqquijK1PZ3EZwzevr9JqQ0=;
 b=WBWREgB3roZTbfd4IjvFUplCNsX2OlnUXzm9taOE7eF7WFQS+CrSBS2wJY3kOkzAN4
 sAIUmDIPNFZ/3xtfHOHB4mUxxWvux5GHsGsvlkzueyzMIdKQkX4YBMClC9zGl0aoezlZ
 hFX8zaeKnkBqBlI7ZFHjgACrMs2octloDVX8FAL7u0bgCmUUDWKcwAtJ5dIg4Gfznn6+
 MpO3FyvqHZ05nMmsQeE44SEkxKDx9bROy+O26yMs8OhSW4bftFSDJpMPeDdSKH+uuu9n
 50Ff1zHUgrz21AvVjdvhdTD4cYKh3atQ5ELhERqICxb7TblByJA9f0otCqI0TSg/N08u
 lKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793993321; x=1794598121;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eBPjMwVd0jaBoQmrGoNaoqquijK1PZ3EZwzevr9JqQ0=;
 b=kTg3KZk0Sr0fTJiQB5ZmEj8OAUOU6VeXwYkuDh5tyQndb3RWUr24maafvGe+RulS7t
 lmZvVW3/UQNzg2belqwgO8sXRzy6cwFOiJWKX2DRqnaC7Cup8CehuFJE5ethp6h7Eh+c
 c3n8nr2liPjHe8AFWzluxoh/D6edJvl2pntCgNrOd2hJXBJPA6n8jLh84KtrYwkZwrMK
 jId9che/CzE0m225Qbp9zlVd1/iEYrjREfHzBztnBjzIoGhFx06590zMOLd8ISLEboOa
 i/eV+KqaCQLr/Q3bThBSEgjRR9QS8/h7Rd0BdmcuGVYjeq9TKYIJA+5a8oH3UJ/M4vUM
 wzNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2CJ/4XOBNmOM2jKaA+GlkbAujcNmaqlUVul71uxvu9iA80SC0SSq7JfqlkYffLC3uH8DCqOjpQm0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9vY/NGxtiMfLe0uL1Z2HtKlZ0Pudo9xilDnQ+GpVDQUhcwHNCM
 vwADuLuERyoaGlqr1sILzscLMS4G0opRDZOJBavjxkawRjH62j5s57+WhjTvFaGje3w+K9HpMeW
 TLM3OO2ZDvqXZB1eCtqWuQYN251HSWotd23yLwVKcHOm6ayFkkQ8IHBObaRVlupIJOOs9EZ5uXB
 ys/vCyemjVqzVFGRt0+uYAtC9onK4ZPzl7u2Ct+J50BNxPcg==
X-Gm-Gg: AYBFou03FEmhgDxGgO8/O9z7INSYbguud+49BNe+HFL7ZgEtU1tEaWLUCkHn0QVcmQf
 iaiQKNNPKfyukWF7Fqg5FvfYR7quHlYtXEDYVz2GP4Sk0BbO7lJEeeJF8UoiFO+uXuDBfPtcXvu
 ckBkoO9e4IrD7JlIW7LwvUIfQqZG+w7uNRGEmjpJHAKsrb2gDHTwpJq7m53X7O3+HcYq6m2PTXe
 y0jQLB6paTVwkclGpra+w==
X-Received: by 2002:a05:6830:903:b0:82f:5733:ffbd with SMTP id
 46e09a7af769-85f1cd6c102mr4535832a34.1.1793993321192; 
 Fri, 06 Nov 2026 11:28:41 -0800 (PST)
X-Received: by 2002:a05:6830:903:b0:82f:5733:ffbd with SMTP id
 46e09a7af769-85f1cd6c102mr4535793a34.1.1793993320712; Fri, 06 Nov 2026
 11:28:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104-ubwc-format-docs-v1-0-389044012b4e@oss.qualcomm.com>
 <20261104-ubwc-format-docs-v1-7-389044012b4e@oss.qualcomm.com>
 <86b801ce-a56c-4ff8-8915-9be369fc0ce8@collabora.com>
 <CACSVV02t9=tm2qyG531f8Ne90ADAb1_ZDDGEg7PwDmoEvGxPrQ@mail.gmail.com>
 <7b4d3a85-6aea-4b96-a4d0-c2f16e488ad9@collabora.com>
 <7e8a6645f181c9e8d663eb97bb1f32e3e4fd8c67.camel@collabora.com>
 <CACSVV03Nz=das+fneMqx9UE1Vzps55=_An-DtmufRTxdhv2idw@mail.gmail.com>
 <8f3c80b4b518835e2d8b3da62e84572338657f68.camel@collabora.com>
In-Reply-To: <8f3c80b4b518835e2d8b3da62e84572338657f68.camel@collabora.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 11:28:29 -0800
X-Gm-Features: AclHuK9Qgc9clmR_7H8t98hdINV7q2dwzavw_NQzbOJlTXbTdCINtEAArvoby-Q
Message-ID: <CACSVV02KqnDzMQd776fvXBErHLzJPptzWBSnXtEoxXNsUW6TnA@mail.gmail.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3NyBTYWx0ZWRfX2qtxYLZUvTOs
 e7v6mCUbr8n24qKl9cwRDcuJvqVWGByqjwVomtfIM+pZfbmRy9GsNArlRHer3ZlluP0mvYK9TxW
 MiEUkLL3iwatAFb2+RNAA/UZGM/eUBperHUXRvwU8bNAn+J5uTgZgRAsAdx3tlA9Quxa3DXch4B
 WfBPDHE5+0bwL2D+OoMPbrnXWOP8su7fXteugKbkXw3EbxXb4n4oZiYyl1dT8RpodlOYvfYoa1f
 0aTUsK/p2xxgycBCcHtTIM9vxLtpyRrOPtaJeVwI/R1NzGuPQ1170zB9krHea3lFLlGGvE/loNZ
 O06j1mqM8ns5CaMeJ8O24xUUcdPcN8JMuT6DfISxfW/PMZnUNN1mDkuhsZkEVvrJOkp2Kx4butQ
 i4jB/Z5JgrEHpO6uZIlxNKP2ETdLLQyZHEapO2961BSNXpEUaBsoU64aKjPMi6D/K/KckQSjc0U
 HZ89BixztIsOyzSae0Q==
X-Proofpoint-GUID: Og93Aim_ARJpr3z2VWbaCWhGAucw8YwW
X-Proofpoint-ORIG-GUID: Og93Aim_ARJpr3z2VWbaCWhGAucw8YwW
X-Authority-Analysis: v=2.4 cv=TZ4DJhQh c=1 sm=1 tr=0 ts=6aee2a6a cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=e5mUnYsNAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=TpzBZJKYoUEfyNYX0y4A:9 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3NyBTYWx0ZWRfX5fZJan9cJNeR
 4nXOeEMT14QP7a79XzDYPvikb7A9GDMW/mNbo+0KefqQa3wsiHfsQANSImUSZWEW3bCAv8Ou8Zv
 76/e63uFAz+axTUN6jC2+ae7yiKu5eg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060077
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

On Fri, Nov 6, 2026 at 11:09=E2=80=AFAM Nicolas Dufresne
<nicolas.dufresne@collabora.com> wrote:
>
> Le jeudi 05 novembre 2026 =C3=A0 12:52 -0800, Rob Clark a =C3=A9crit :
> > On Thu, Nov 5, 2026 at 12:35=E2=80=AFPM Nicolas Dufresne
> > <nicolas.dufresne@collabora.com> wrote:
> > >
> > > Le jeudi 05 novembre 2026 =C3=A0 13:35 +0100, Robert Mader a =C3=A9cr=
it :
> > > > On 04.11.26 23:11, Rob Clark wrote:
> > > > > On Wed, Nov 4, 2026 at 11:00=E2=80=AFAM Robert Mader <robert.made=
r@collabora.com> wrote:
> > > > > > Nice, very happy to see the series!
> > > > > >
> > > > > > On 04.11.26 17:36, Dmitry Baryshkov wrote:
> > > > > > > The comment describing the QC10C buffer layout calls it a com=
pressed
> > > > > > > P010. It is not:
> > > > > > If I'm not mistaken the display engine / the DRM side (includin=
g Mesa)
> > > > > > describes it as P010+QCOM_COMPRESSED as well, and so does my pe=
nding
> > > > > > Gstreamer MR [1] . So if we can't pretend that QC10C =3D=3D
> > > > > > P010+QCOM_COMPRESSED, then we probably need a DRM_FORMAT_TP10, =
wire that
> > > > > > up everywhere etc. OTOH if we want to keep the DRM side as is, =
then the
> > > > > > comment should reflect that, IMO.
> > > > > IMHO we need DRM_FORMAT_TP10.. on the GPU side, we have TP10 and =
P010
> > > > > as distinct formats, both with and without UBWC.  I'm not sure if=
 the
> > > > > same is true on video side but P010+UBWC was never exposed, or if=
 it
> > > > > truely only supports linear P010 and UBWC TP10.
> > > >
> > > > Oh, do I understand you correctly that the P010+UBWC implementation=
 is
> > > > not compatible with QC10C, meaning on the GPU side (Mesa and displa=
y) we
> > > > don't yet have any support for QC10C exposed to userspace? If that'=
s so
> > > > then we don't have a choice but to introduce DRM_FORMAT_TP10 I gues=
s?
> > > >
> > > > On the plus side - this would allow us to make the format single pl=
ane,
> > > > matching what we get on the V4L2 side.
> > >
> > > Since its single plane, we should aim for a variation of
> > > DRM_FORMAT_YUV420_10BIT. Similar to YUV420_10BIT, there is no obvious=
 linear
> > > single plane packing for that, it would only be there to support the
> > > compression. Or maybe this one is abstract enough to be used anyway?
> >
> > Oh, sorry, maybe I was a bit misleading/unclear.   TP10 is still a
> > semi-planar format with a Y and UV plane.  But each of those planes
> > combines UBWC metadata and pixel data.
> >
> > Within each plane, the pixel part of the data combines 3 samples in
> > 32b (compared to P010 which is a single sample per 16b.  So not quite
> > the same thing as DRM_FORMAT_YUV420_10BIT.
>
> I believe DRM_FORMAT_YUV420_10BIT is defined as fully packed, no padding =
indeed,
> but I'm not sure if it actually matters considering there is no linear
> representation of these. What really matter is that its a single stride/o=
ffset
> format, which TP10 is not. I would not mind to see another pair for forma=
t, but
> I just wanted to emphasis about the number of expected strides.

For at least some gens of AMD you don't even get to specify the
stride.  It is a function of the image dimensions.  Not sure if that
is true in other places too.

So far, for compressed formats, the stride used at the API level has
been the stride of color data, and the compression flag/meta is a
function of that.

BR,
-R

> Nicolas
>
> >
> > BR,
> > -R
> >
> > > Nicolas
> > >
> > > >
> > > > >
> > > > > BR,
> > > > > -R
> > > > >
> > > > > > Best regards,
> > > > > >
> > > > > > Robert
> > > > > >
> > > > > > 1: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_r=
equests/8195
> > > > > >
> > > > > > > P010 stores each sample in 16 bits, QC10C packs three
> > > > > > > 10-bit samples in each 32-bit word, which is what the stride =
computed
> > > > > > > below (width * 4 / 3) assumes. Name the format correctly.
> > > > > > >
> > > > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcom=
m.com>
> > > > > > > ---
> > > > > > >    drivers/media/platform/qcom/iris/iris_buffer.c | 2 +-
> > > > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b=
/drivers/media/platform/qcom/iris/iris_buffer.c
> > > > > > > index eb8de60c1177..ec2bf2a2d953 100644
> > > > > > > --- a/drivers/media/platform/qcom/iris/iris_buffer.c
> > > > > > > +++ b/drivers/media/platform/qcom/iris/iris_buffer.c
> > > > > > > @@ -266,7 +266,7 @@ static u32 iris_yuv_buffer_size_qc08c(str=
uct iris_inst *inst)
> > > > > > >
> > > > > > >    /*
> > > > > > >     * QC10C:
> > > > > > > - * UBWC-compressed format for P010.
> > > > > > > + * UBWC-compressed TP10, YUV 4:2:0 with three 10 bit samples=
 packed in 32 bits.
> > > > > > >     * Contains 4 planes in the following order -
> > > > > > >     * (A) Y_Meta_Plane
> > > > > > >     * (B) Y_UBWC_Plane
> > > > > > >
