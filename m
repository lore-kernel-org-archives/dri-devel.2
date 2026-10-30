Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D29606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ngBIoon7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XewDSGHl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2DAE1128C0;
	Fri, 30 Oct 2026 15:25:01 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E46D10E257
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:24:50 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERCss4141517
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=K3VqXyfdn7aZvC6p6W5C0H6nzI/A5JqmWJ506i3piMI=; b=ng
 BIoon7753itXocLi6kpSZ76gyoIht8FUgc6dDKyKExdonJVl8vQ1NXmSk/QSAB5S
 DN22e5chBcSmc1FKASMIT/DJyPNq1RNPL/K5E/FQ0NKIXx1yg4m+7wVjegl4bYAn
 Aoy1TmQOR1DQqcJxQnghj+lWVFgChBbdv0xpdaMWB0TFkWxJo/P+tbHfNxTtScBR
 RjbwlvH3Pj1bu5XOxYEt0WhrACo25jzVjW/+lOaV6BFraUZZnBVM851C/CmTv9fW
 eqLS7l1Z+wQxKiAAbuiiu5VLl/sMGcG1C7Hgh2dn/p8yMkW9XT3Lcunhk2U+rJji
 h7OjaF0A2hDjorWO8CSQ==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qupkv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:24:49 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-4a7da05b026so1047597fac.3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793373889; cv=none;
 d=google.com; s=arc-20260327;
 b=GqD0BPDfMp31SIzWvDprAClMK63isHTrprGN9leezCGqoDBZs8INI/83QXWe814Aff
 eY2Fay99f+Z71SDQHGUwZ05Gu4kejthgUQ/I/eYFpmK8Eyyr6kTs5JyT2Ok2ND7ENZzc
 kA46xEMi3tEX2m9izjsGEujRmF8tTYdbzeD71ih3BPJJ+suPtd4Z4cfbLTIc2m5vGEGS
 ytfUea58nOuK6qJtUBKn6apBz4rBTu22dr1bI//EDPLMB4RRmSKjSSYxVdP8vn+vJope
 Fxoqst2KDf680OjBwTzkykq/GwOfLLg+04v6HMlRgFXwR1DMgtHSr72vlTroHSoQKdBx
 3aDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=K3VqXyfdn7aZvC6p6W5C0H6nzI/A5JqmWJ506i3piMI=;
 fh=u5FCvl/hlkduhXSzJ68i7bGHRzuCigxChcRzBcTcgdY=;
 b=PqVbzgGGvXqN00WinjTKAOGheTmhbTNL3NG8mVHmt31baj8zbdIj4dBFC2X2FGAK8e
 BildA5W9MOm76AH9okWldrVO6fm3wACSIESPqCPqqW0KnaEVOwx1HXPoE87KFz0bDBxX
 a9fhfCECbfuG/4mDKTPRKVzm0Z3hE2mtujaN4pdOZnV9pcMrKkEpDjyGx4rptBY3cFsT
 9FaN71SEsOhNAduBJMCnhhANTIqG/Kv917/UY6OhR2P84qeO66oOqP5NJ2CplsxH3nfk
 Xn+AVWJpah1gaZ0qwBgUIjeEJJP8wFOqcG655h1qVV2AkUu4fFOpNfgR8EZcZSFrnEbF
 i0lw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793373889; x=1793978689;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=K3VqXyfdn7aZvC6p6W5C0H6nzI/A5JqmWJ506i3piMI=;
 b=XewDSGHlIfFyJHXfmhrutvf8syBvm2tGKfHyCKr5SKvZKfDyW1FicEx784SNiAAoSh
 D0VgmZ6jWZExc5lNV4YS9ThTt2ox5Lt6NkXDt7xb6BuhiRw7z9+zpBfknPDa0vuVBR/F
 XG/t6xfyuig45/+rVMb5v29KZXSMxODFnWM2luSkfhz+q0A/zo+CMYEb4FGajRNuW9tH
 W/HsbbwRd82MeED0dq08tSBZ7Y9I9pGDY8jYEQ3kSQmL9bOeDEgiG5gcuC0MStvxmDUn
 fUL7p0carCGlYh50Esyd2zeGeSdMLVrkJuSb9Kz8tteh+Jbd+rXOlaMGBvV1jBFsIuWV
 LHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793373889; x=1793978689;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K3VqXyfdn7aZvC6p6W5C0H6nzI/A5JqmWJ506i3piMI=;
 b=s/1tRXwLskLRmiAn+IvLGakfOqslSF31mQrs0eXXV8Wu5Ax8jFHiOIQRcUOt9nQQyt
 BZ/MFP/n383AXu9UXSB7byR28dqr0OgI8Q4XFaq7FnmLSqURCruj0l90mx0hxzT7Fl0O
 azMojYS8Zp0s0CYA5dY5ETaRI9gHRbMUj3OpFEcsIjY0q5kxSsEYiZPiBm8wpxRjo2gl
 BHjY++GLs0QQ0zBpvUtHQt07p1Xb2brZWHB/Q8Bd75+JGWueZY3KKgi3JXfiGutfdmZO
 E1l3GRnvWY2xy3/k6IWvf31cBht7sSbZIED582UaX8Wa9mt927gonv0RiXwA5eSsgZm1
 8EAA==
X-Gm-Message-State: AFq9FYK94wdWn3qoa4c2Q6dePtSBXsP0V7ijCJhOx6HNUYiUtE8y9mFk
 +8RK+sX9A8G/m6HleEWPZYmLfh/0/E4J6p/F50B+bOq7nw/Lvb5/fxXGCLPXtzx42R51TCrRQaP
 6sVT80yaDjdvq2bxtBLy0sT4AyBgsVSl6sIt409Yowxz8Um0/VIS72W3dOULWPSOTrRPicOu72S
 TBFvwfy1g0mxmWsNBTCEqycjs+8sFgAvjfHbA37GOp/tUf4g==
X-Gm-Gg: AYBFou1Rv3lmdTrnjyynfl/iCQzx3s6WSXn9EpO9izkQkM/BDbRbfr4RmCtMfF0Wqi4
 dGQdXfb85UEJplwX7o7Yj7Hpc5usEW8ecXKTfpBu5xkHCwcmHRHxTdovaUiwGRb4JVAfci6pM3x
 ZLnE0thuNLNh8FqbDZZBs3lbvn278gMinhV8yxa6piL99hbpaZ5QFsvnze+g==
X-Received: by 2002:a05:6870:142b:b0:493:186e:b51 with SMTP id
 586e51a60fabf-4a90765f95bmr1797637fac.20.1793373888563; 
 Fri, 30 Oct 2026 08:24:48 -0700 (PDT)
X-Received: by 2002:a05:6870:142b:b0:493:186e:b51 with SMTP id
 586e51a60fabf-4a90765f95bmr1797609fac.20.1793373888097; Fri, 30 Oct 2026
 08:24:48 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
 <20261029201730.151754-13-robin.clark@oss.qualcomm.com>
 <72mcRc_XaEFYOXsQm5r3_QWSIcGfu2OOwWlCRp086BzS5v9e19_2L3wttKhZOHho-XlIv1lZODbEYPFwnSVWDEQXgilHOfqgP5U0t2xsNcA=@pm.me>
In-Reply-To: <72mcRc_XaEFYOXsQm5r3_QWSIcGfu2OOwWlCRp086BzS5v9e19_2L3wttKhZOHho-XlIv1lZODbEYPFwnSVWDEQXgilHOfqgP5U0t2xsNcA=@pm.me>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 08:24:36 -0700
X-Gm-Features: AclHuK8BnLlPd54aThROE7CjiGNynTqPFp3Ou8wSOh8Og2sGLyha8Oc-svz3-gQ
Message-ID: <CACSVV00SZWNNrY12Zw8NKUksvEagDFEw1S0jJxLNVvc7kGVfZg@mail.gmail.com>
Subject: Re: [PATCH v3 12/16] drm/msm/a8xx: devcoredump state capture support
To: Alexander Koskovich <akoskovich@pm.me>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: wlaR_6HEQzjnDr_w6a_i6VuLhLLCFiap
X-Proofpoint-ORIG-GUID: wlaR_6HEQzjnDr_w6a_i6VuLhLLCFiap
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2MSBTYWx0ZWRfX0GaWcOIamnsT
 N/eBgGI+MnCRxcQqfu4IRAuMNoWQpcTv+H+ztfWbA3ibfLQS+eu/8Xs+LlmrXTZW2bmdR/pMiwp
 NVg49mqyHgBfXQRmgiu4BMyEu42DM7grz8oLhLX+KKuZFu8VDg7Mv2GrCkbQ0IW3EUcavkfBDw/
 no5EHMHxJncJavTaPKrcxvNGXVOUSjTrZK6kJI6x3529YaZlDYdJlixmT2BBEFTM1t6nr6ls/Ys
 pP9LgWrosqI9JGEUFBQCZzmaAvEIF2Br4E8ZZ+4rR3A9u1pTl59YLW3sJUYy8/sYJIxkVHrHM7e
 oFAi58mLzR72shKgg7bopAKlotdDwj7cnXucOC8HL8siMu0tq9uVhIn1d+h0bDrMK4mIm5nSRqE
 TXjx5UWglsLJ21WvGMeGfS08o+YzwNvprHx34wwQyrmKKtt9qoZ6W0bYdJFyYtCAv9988ozn/Zw
 lsH0ph38vNS9Jswsfww==
X-Authority-Analysis: v=2.4 cv=dPgzC+Zb c=1 sm=1 tr=0 ts=6ae4b6c1 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=hxNMMXO8-ik_v7z4v3UA:9
 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2MSBTYWx0ZWRfX4tXmCgElZgyc
 tkNYlePW8JXnli6HCDoqtMGRQtmrMbWvj4XFVyl3XiFoVsgYGU+Y8LZXXJyb/sMxZRpytvwP92k
 +n/3+B5A+3mpC77JpWXxLbfranpokhY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300061
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 2:20=E2=80=AFPM Alexander Koskovich <akoskovich@pm.=
me> wrote:
>
> On Thursday, October 29th, 2026 at 4:20 PM, Rob Clark <robin.clark@oss.qu=
alcomm.com> wrote:
>
> > +static struct adreno_snapshot_sect
> > +__snapshot_sect_init(struct adreno_gpu_state *state, uint16_t id, size=
_t extra_sz,
> > +                  void *sect_hdr, size_t sect_hdr_sz, const char *func=
, int line)
> > +{
> > +     /* A few section types have no section header: */
> > +     switch (id) {
> > +     case ADRENO_SNAPSHOT_SECTION_REGS_V2:
> > +             sect_hdr_sz =3D 0;
> > +     default:
> > +             break;
> > +     }
>
> Heads up that I'm seeing this warning when building with clang:
>
> In file included from ../drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c:9:
> ../drivers/gpu/drm/msm/adreno/adreno_snapshot.h:398:2: warning: unannotat=
ed fall-through between switch labels [-Wimplicit-fallthrough]
>   398 |         default:
>       |         ^
> ../drivers/gpu/drm/msm/adreno/adreno_snapshot.h:398:2: note: insert 'brea=
k;' to avoid fall-through
>   398 |         default:
>       |         ^
>       |         break;

thx, fixed.. not sure why gcc didn't complain

BR,
-R
