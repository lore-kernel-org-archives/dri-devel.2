Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA30606A329
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=koQgpWjC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GfgmuVkB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27923112007;
	Thu,  5 Nov 2026 21:08:11 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2EB9112007
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 21:07:59 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5L6Olo2529113
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 21:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=yrKHsAyKjgQsLWA30cSaDJqtamOdne71y3/nc/PZAXY=; b=ko
 QgpWjC/rgaCt0NHLrQfHNc2+Iz/JbxNh1STZty8f+unqZjTUU/JirMf+++xHmTwn
 YIAZrKLT7itaSsSGx+ulrNeD9GR0qMz2h37Ck+zV4OUg3wh00Mn2WSEsYHMCNcDd
 QqpsSySqlPm5HBaRQpCkyWbihCF2TeRDDGPY3C1W6Lkb3bDv/SiNI7SUwfvyultb
 GbG7PlaJWNLX3FFhR+pBy8UhvcDvG58NsxsaX0KIJrgPskdDOKMUeewLy9T4UlwI
 CMPkAPzsWNfscaE0LpzBsSo3MXr9IP04Bb4wLqiDJ0wLQLUQ/PkQF4uSF49g5qsH
 4MKFiotR99rvbtV2GVww==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hryw18eyb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 21:07:58 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-4a68926c8c4so2237899fac.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 13:07:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793912878; cv=none;
 d=google.com; s=arc-20260327;
 b=dNrIZPNvgIABL13+7MAc25pX6EXVsfIdC0SouxhYNgOrPL0I3DcB7v2x3VO6wdXFn+
 3Mb9ji0PW7rEEtlOd4BYudcq3yQLv0p/ZdKzTdh5HofMnexsCYDJ9U8qYZiI1glQfbwV
 jmJYsjAAU00uzdWUL7a9p6nuv7lpfeCo593ZbVEQHF8otWPSVQrn5oQgDXe1jW0gIDSi
 Yntr0o0YMOdhMdKOz6UzhEoY+c2h8nzeCvI88rspvu1rZG1HK4mOdWB6RwuqFJbRIuEA
 20nVzqxvo/xMSe9I7ItoLQqiFR2NkvWOTtmaSMGh096WgTZzKawxHnT0RY2cPxA6L/nz
 424g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=yrKHsAyKjgQsLWA30cSaDJqtamOdne71y3/nc/PZAXY=;
 fh=nVlXmaW8/gWT56I8muUv/KEi06k1Gb4sY9zXiHuk0yY=;
 b=OnnM5dQ+EddKCVK+bBspNMoeHgywLJFJyHazFJDipGv0cXkqb10yblO5hav8OuPYAf
 yNvWYFUbCmboJ+VqbyZ3s4R+CIp80nKIWruaZfuUV5PDYRJvKaDrVvQntsPjX9SyR87x
 aaygRMF2fLKrHFEONpyQnqvLd3fP/bJWDmOYYix7AIs4JJbDuYi5rl36B7WwqwdylVut
 NrtW7MMqUlVypx/ThsExWilxuluWQ3wZ5oogvysxXljWbbvCEVR4gd//i/cNR88JOHLb
 1Ac+CqXCICm0Ttj0JUtg8ssPxcAQrwQihKEzOXfZmynu3sZ4RRi0qOETwj0mpg0ENALo
 6jLw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793912878; x=1794517678;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yrKHsAyKjgQsLWA30cSaDJqtamOdne71y3/nc/PZAXY=;
 b=GfgmuVkB4PWUY9bX5wonDl8rbV6ZlglvmWtyj0iawgYqKJaPLbE7ZaZGD/0pVo7Pc3
 5/gnlOhqFhShHXRQJMOg85lVJ+2SUzCdab+LmBDYLN2j4GMBbXdsYOdAorMQXb0Y5R8z
 zFngZ/Yx090ouRqI+pGEM3wFzOETr+iZtmbzl0ItMFnFhPmjUBTGi/O6/QczD+dfR9LQ
 bcU7dKYJQYnLkY7rDGB8yQpg5Tg7a2cMSEMEJqPgOWkHMOHVjn4Cpg5cM32hmYHUFJ9H
 15M2JdHmR5WKu1mmImPK3iDJfpbruqqUL0J46iEE+W09KwPQQepBQge43RESMscsYhMT
 ZTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793912878; x=1794517678;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yrKHsAyKjgQsLWA30cSaDJqtamOdne71y3/nc/PZAXY=;
 b=C5RtSYtTLkc/bkSDCqAM/Zl8dTKE6TEaCuGkPV5/HAA86pIPM+cu2kl3hpowo5AgqQ
 /wgD+YRFAAblbnJhJnHaGAnzWDiKnM+ssqkNKMMVVmuaL0k2BjHRn8hlKQUfyv+i35O+
 tyHUddQMA5JA4ihXAwpnar989YXQoUBD9eres1QedfTePNLcHZhV8vqqFQ1Nz2XHI/Pn
 DBbtVyBcDfSljt01u9KkKyYUqwhoH3F9v8HORz027ktCxbqcS8CF/2o7zOxWu/Fd3VOA
 3NDrHbf5BGVCoZSNAkCxgsPSacjEnmNRBngOtugmc/Xsy0j4f2jsNmq+Eu8yqV83blsl
 VDdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/qsYND1P3xSwe9QIUa2UIs/ojR/n/o4EvyqIy0zdMrlrE7iLwLKWk+af5VWMqYYMvc+RqKtNq35k=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/iWCDKthNONkfgiRH/FD8NNeI2V36TI3xj7hoMBaA1hjywsvCv
 U9oAStbL/W3rKbntpPzeQZ/3huSpTgzGXHNZtVp62XpgmkElhsBSz38taBC1svadRNpdvcFX/V/
 u2h+CJ+3/RfFLoekE3YKPi1nuYnrJq5rMJEcfWpmHQT/yDEPzZlvIRiJ7ePrtA+YukV6RNlDgzH
 9UfDyasOUNhoJfvzkUnTJVyCghIL4rLa3NDrCdrg3yxItpHQ==
X-Gm-Gg: AYBFou2FmwrL6FjCnbFhg3L7Q7R7wv8/0r8UXgzh/wGh5STtNzFbHcjHOcUlY+CG+gp
 GZ6GR3pjyu8DTi82PsM/LwL/IIR6huEvirniDeCq++9MW4PhrY4DR2nB3mlmoqt2f9lXFusuyLn
 YK5GK76FUuzdzjSJeieJpUAUOeahNv4CpAJH2V4NK1/uKvSBdXBX54G0r81Ze5QsurBPlQfyxkf
 4s/YmvcYJLHbH+9xOxjzQ==
X-Received: by 2002:a05:6871:a1e1:b0:48f:e0e5:a1ec with SMTP id
 586e51a60fabf-4ad98bedbd9mr282032fac.49.1793912877704; 
 Thu, 05 Nov 2026 13:07:57 -0800 (PST)
X-Received: by 2002:a05:6871:a1e1:b0:48f:e0e5:a1ec with SMTP id
 586e51a60fabf-4ad98bedbd9mr281983fac.49.1793912877179; Thu, 05 Nov 2026
 13:07:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104-ubwc-format-docs-v1-0-389044012b4e@oss.qualcomm.com>
 <20261104-ubwc-format-docs-v1-7-389044012b4e@oss.qualcomm.com>
 <86b801ce-a56c-4ff8-8915-9be369fc0ce8@collabora.com>
 <CACSVV02t9=tm2qyG531f8Ne90ADAb1_ZDDGEg7PwDmoEvGxPrQ@mail.gmail.com>
 <062fe7dca00f77dac05197552d22897b28dc2143.camel@collabora.com>
In-Reply-To: <062fe7dca00f77dac05197552d22897b28dc2143.camel@collabora.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 13:07:45 -0800
X-Gm-Features: AclHuK_l2F4brRz8zEFJVBH6hAHGfTJx_ef7xI7quruekmosYIZayahgz2bCT68
Message-ID: <CACSVV013piWuVo87SuAGK+j9i+rj4cHGiOTX9kznE4ROJup0Hw@mail.gmail.com>
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
X-Proofpoint-ORIG-GUID: oTgGlIzwBWlraQCDLTcinDPDjbeSW_xi
X-Proofpoint-GUID: oTgGlIzwBWlraQCDLTcinDPDjbeSW_xi
X-Authority-Analysis: v=2.4 cv=RdYFmFtv c=1 sm=1 tr=0 ts=6aecf02e cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=e5mUnYsNAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=w63Y8P8m0PzJOg8PKjMA:9 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4NCBTYWx0ZWRfX89lO74VGuH1a
 +4vo50xamovzjL+/1OOyQXuuJSVy6uanUhHSnbP9JssyKn+OVy58987kkQ9WN/81IO53lht039d
 HfHhLlLIPA0FntY498ENr2x3APnfHWdy0gKoCOvV1V39kSZf90VaMzB8aCb5VMzKi6XHqFR0anH
 t6qNB/wC6xr4Qu19dn+MJeOfwYG0z6M0aJnH4lguEIal0g7knvWBwZ6Eg6aWXpEXQZjngSyqJ6b
 v/INxlOhvcV/ijLK8IXvyYMmmvZGmqq8MGWEQ0hQIyiXKU2M/h+DzbEViNf7bJpeh+eLCOWni1i
 LWt3mTMYfIeoMFwtWUVPLmhgMxB78Bwe08bbAtr2AQWDaXnMRtsMB5y8wXbBla2GkIF/QHL1YJd
 3dGx5U23a6QKEJVVH3o9TcSi71WJ37UiwKNM1IE7akrIV0g/bjHUQEW10lIlTUY1VO4tpJtW8DZ
 UwODI+kJcuuDtqtNR7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4NCBTYWx0ZWRfX3uK8b3ekbWEx
 xvOiYrV1TS59L1NisAGsYYwsivKUIwosZRlMN+jwWs3Oomm0CGlrt7Geg1+/+V+R4fYK4yk4i29
 zKVNQ6BQikTrJE+oUGLJHS7KTvWbkjI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_06,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050084
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

On Thu, Nov 5, 2026 at 12:30=E2=80=AFPM Nicolas Dufresne
<nicolas.dufresne@collabora.com> wrote:
>
> Le mercredi 04 novembre 2026 =C3=A0 14:11 -0800, Rob Clark a =C3=A9crit :
> > On Wed, Nov 4, 2026 at 11:00=E2=80=AFAM Robert Mader <robert.mader@coll=
abora.com> wrote:
> > >
> > > Nice, very happy to see the series!
> > >
> > > On 04.11.26 17:36, Dmitry Baryshkov wrote:
> > > > The comment describing the QC10C buffer layout calls it a compresse=
d
> > > > P010. It is not:
> > >
> > > If I'm not mistaken the display engine / the DRM side (including Mesa=
)
> > > describes it as P010+QCOM_COMPRESSED as well, and so does my pending
> > > Gstreamer MR [1] . So if we can't pretend that QC10C =3D=3D
> > > P010+QCOM_COMPRESSED, then we probably need a DRM_FORMAT_TP10, wire t=
hat
> > > up everywhere etc. OTOH if we want to keep the DRM side as is, then t=
he
> > > comment should reflect that, IMO.
> >
> > IMHO we need DRM_FORMAT_TP10.. on the GPU side, we have TP10 and P010
> > as distinct formats, both with and without UBWC.  I'm not sure if the
> > same is true on video side but P010+UBWC was never exposed, or if it
> > truely only supports linear P010 and UBWC TP10.
>
> Xilinx ZynMP is all matching TP10 (they had GEY and YUV semi-planar varia=
nts),
> but they never upstreamed it, hence why we don't have it in V4L2. Just fy=
i, we
> named it creatively NV12_10LE32 in GStreamer, but careful, I cannot guara=
nty the
> padding in on the same side.
>
> Though, how do we deal with backward compat here?

On the qc side, it seems like apparently what the display advertises
as P010+UBWC is actually TP10+UBWC.  I'm willing to call that a bug
and just fix it.  On the GPU side there is an MR[1] to add P010 for
vk.  For gl, I think linear P010 should already be handled via shader
lowering.  I'd like to add TP10, although there doesn't seem to be
(yet) a vk format for this.  (And I'd like to stay away from hacks
pretending TP10+UBWC is P010+UBWC at the API.)  For now I think we
could workaround the lack of a vk format by using DRM_FORMAT_TP10.
The main use-case to start would be dma-buf import, so that seems like
it would be enough for now.

On the v4l2 side, I'm not sure.  But it is also not clear to me if the
viddec hw (iris) supports all four combinations of P010/TP10 vs
linear/UBWC.  I guess there is already some fourcc translation needed
between v4l2 and drm, so maybe it is ok to stick with QC10C on the
v4l2 side?

BR,
-R

[1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/45721

> >
> > BR,
> > -R
> >
> > > Best regards,
> > >
> > > Robert
> > >
> > > 1: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_request=
s/8195
> > >
> > > > P010 stores each sample in 16 bits, QC10C packs three
> > > > 10-bit samples in each 32-bit word, which is what the stride comput=
ed
> > > > below (width * 4 / 3) assumes. Name the format correctly.
> > > >
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > > ---
> > > >   drivers/media/platform/qcom/iris/iris_buffer.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drive=
rs/media/platform/qcom/iris/iris_buffer.c
> > > > index eb8de60c1177..ec2bf2a2d953 100644
> > > > --- a/drivers/media/platform/qcom/iris/iris_buffer.c
> > > > +++ b/drivers/media/platform/qcom/iris/iris_buffer.c
> > > > @@ -266,7 +266,7 @@ static u32 iris_yuv_buffer_size_qc08c(struct ir=
is_inst *inst)
> > > >
> > > >   /*
> > > >    * QC10C:
> > > > - * UBWC-compressed format for P010.
> > > > + * UBWC-compressed TP10, YUV 4:2:0 with three 10 bit samples packe=
d in 32 bits.
> > > >    * Contains 4 planes in the following order -
> > > >    * (A) Y_Meta_Plane
> > > >    * (B) Y_UBWC_Plane
> > > >
