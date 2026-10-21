Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86C7606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OdAfWAAx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ww+5QQ+3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 252DD10E10B;
	Wed, 21 Oct 2026 14:51:22 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92A4510E10B
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 14:51:11 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LEFF6N1903411
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 14:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=5p9qlTx8BOaAdi//0zTq3lrbyfHYbM3+Yp/X8xSSIKw=; b=Od
 AfWAAxGtG6LOeHQ2KO538LPP0mZuIUNVNfnGBrB6gzHMJLRmNNyvSk/+WWJytfb7
 KnolhRZf88/aNE6u03wyIDQ+U3X1kV1dRc80M4DiLttfCB2KyN/agwO4Bci+kPJ4
 P8VA4c8aaJmbDA4NlFlF8j6kPwNwDBZocH0MNRWnHHzHOUbFvagn1A2sjgEF9Bxq
 MH8doGnDWhOHT/ltI6eKRb0O2LCteAUDHLrD13vt2kiMAO3Cl4OJDJjV6+UdSARs
 aD0eXd+ndv9DvV9z8Ivigc5DKauI5wtuOTJG0Nke8LN6+HAoSk41Rkr+HD0t3mhB
 S2u2HYqB2UTd+bO3w9vw==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda4vg8c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 14:51:11 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-46a5954cdfcso872159fac.3
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 07:51:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792594270; cv=none;
 d=google.com; s=arc-20260327;
 b=bgc9bD6h/LUebl7XeKzDAor4ykBCQUgdQUpM56PtubyVsW/vlCsAQKgfCE3+P6WHEl
 sSsUkQzvvpzg27tFa3xKRM3HvHv/nE4ommTJ0tk5/DFvL5kvmyWce7GL+EMfdNBgtnt1
 JDw4iHQTvQjOUb6CBn/G+GJChMXnpfe7X82x3NhkSuysztjST4J+Hsn+6NssDvI8DA24
 mPP1PL4GYfitEeVietKWRlJWsgvk05vC3XPn1OgF6cRKgwku/RWTq3dw0ET88Ai1sBHR
 LFGzPBjOnKbwIEe41lb2A2JTdK2O2bUSS/h1yYf6FBeNaX4hDANwOcCivVO19YlKzWH9
 CKjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=5p9qlTx8BOaAdi//0zTq3lrbyfHYbM3+Yp/X8xSSIKw=;
 fh=Nx/8WhhgsodE0SBSV2NMBLjqRsQB08lor9AnDUfMUuI=;
 b=WXkr1xZSIKDlLhdks1yyrUWEjAq2bDohUJX068IURl5YY0UFdmmg958lirHrZehl8x
 RERC3YpHm3NgRxX+sTVy0IQQ04pPA5qNGejCuUZ71PcxWmzhJe2nsZ9/lAm4REQZj5kP
 ygqWltuihHdpdUFFxmgw31XACdNmKZdbg9uR6KTS3dsNuQDNFqEV+rkzwjhTs/l/YoCJ
 QszGjqM2w42pfd43ZXzQ7LVFiWM5uXA0rgLFBmnnSBaGmBir1J0CnygBJQKWRjCtCJfu
 peVRUbL4DMZVeth80eNmQa/+3ClDwVP4sFWDpSaTgFGwqIw0xcKJ1kdxwOGjvyAVadKA
 wXyA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792594270; x=1793199070;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5p9qlTx8BOaAdi//0zTq3lrbyfHYbM3+Yp/X8xSSIKw=;
 b=Ww+5QQ+3DoUGG1Os+RW36i5a+tAJMsEav+pZR9b9LVQSuBBKay0qGe8ojH6WHQiCCg
 D3kR00h0AoCSHbNjJibAqn4GQurmb2Fbpmt0qUNOUBjjsId3phHyeQdBJeu3nLYpHH4C
 8t2j45TH3OPX1jqk4A94wfn0Pw6Cn2XQt8wb7xsWWBCSQ0rqY9Y39PrXvLR8VCWkxhjZ
 xDTexl67iAd+x/QiNb3TnlAw8/kxhWYh3wRkxYLJ1hg+CiqsW635/gO7wgjPJr09uLFu
 IXYnL571Tq4ywYaXV+bApli08erbCvKxviq/IC8pYTm5x75Z4mMIO5VXthJ48C90FMHv
 Vy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792594270; x=1793199070;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5p9qlTx8BOaAdi//0zTq3lrbyfHYbM3+Yp/X8xSSIKw=;
 b=ibS4JE7Yf/1Ul/hN4LWZAuVhu9I+eSIIjwHSUT4GPYjGcmftXtyAJV7rlirMGPr4Le
 YDU9TivJWLk2g0ISGj0W63F/vlfi0pZU5pvuKnkCAY+P8jjyURnv5QRkn3cTAvF7odS2
 +X6nVuuOnEAsXcLey3neXt1nWcD7Wh1CeNMiHcvhJAIT4lenhlTkx94799p4yoW18HHT
 AHkOE9NjwWF2jT7W8SONwD+kjKcvN8DFkNbLd8CUxSd+5Lk2qpynL0mpSWDpB180WK38
 t14xHzfDP3N90uZVLjAr/oQkeTOXuJrUlBQgQwPPsrloLt7epPtlfyB57h/TdrINxAkV
 607A==
X-Gm-Message-State: AFq9FYJtG89XW+DvkHOuubL6J/av6RXkxccfe9JrJ3GglfF9KhwmdEYp
 VQPNYfZP/ACI0FXZG3SEdZP2C2dXjAfm35FLJbLLD/gfboV3cNb2PT0JfEnDrq5ZtC0bHJt9sEj
 +Zy59F22PqZUKVHsRqlMMFJ164/37T9D9injdMYuKNE0S/oQZLX5vNZzkcglpeduXN3CFS3EPog
 gMFyvJFqj0tOWSk5Mmy+k8HTb8xS0ps9I5KXFrqLcqR21JQA==
X-Gm-Gg: AYBFou2BPSlFx9Em+mvTx1yYt4xXxNexIgAH2edxxLjK7Mg1xNrk+mdj5jnbGkAA9Hx
 Yoew6kBCckyuY1edl2reQL93yLAYjsUdpV3adHsMVJaqkUJD8WtxK0sCbiVFNt76t5/S4wOxJpA
 xmuyD65wCuJ5Sz6hAxYmRUc0JQXvTgUvUtBur8+qRaeGAbIhKHgtLoc7oM5A==
X-Received: by 2002:a05:6870:4e88:b0:494:b8f4:9a22 with SMTP id
 586e51a60fabf-4a7dc1f1813mr1321148fac.28.1792594270139; 
 Wed, 21 Oct 2026 07:51:10 -0700 (PDT)
X-Received: by 2002:a05:6870:4e88:b0:494:b8f4:9a22 with SMTP id
 586e51a60fabf-4a7dc1f1813mr1321121fac.28.1792594269645; Wed, 21 Oct 2026
 07:51:09 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
 <20261020204728.28844-7-robin.clark@oss.qualcomm.com>
 <daed5a07-7d4c-4597-bec9-7a537d0af4a9@oss.qualcomm.com>
In-Reply-To: <daed5a07-7d4c-4597-bec9-7a537d0af4a9@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 07:50:58 -0700
X-Gm-Features: AclHuK_273K7JWxAwm9ju6BwL2RphOQ69uYzozmpnUfx_cbgda8C-aejWgJFIyU
Message-ID: <CACSVV01Kd10wFrPKaG2GgcFoTuCXT6imthSUbbtBZ--zQszxtQ@mail.gmail.com>
Subject: Re: [PATCH 06/12] drm/msm/adreno: Fix PROTECT span length
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: oVbEEUTIoZDrUcqxfZ3yM7Ts5q-g65Ys
X-Proofpoint-GUID: oVbEEUTIoZDrUcqxfZ3yM7Ts5q-g65Ys
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1OSBTYWx0ZWRfXyvajw7K3Ha/s
 lUAoyc1INGzsHTXXBythkNd6VBH8CYPD38yosfKm5JIINuNGlBMvhOwZ27N1ALsPWgnn5mxFROM
 6lvGY4FMUzHB/aFs5UnaVQFjWDWF13k=
X-Authority-Analysis: v=2.4 cv=R7aWitRX c=1 sm=1 tr=0 ts=6ad8d15f cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=A5R5xhKYohY9jtTwzVoA:9
 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1OSBTYWx0ZWRfX3pVwQ3aVa8lv
 ae1VXOcX0/t33J4MTfNbzVHaEHZL++PWRIZiddFTlg52sxKBLZfURF5mAsOaWF6JiwpBcSArEhr
 r4Xm2hX9Gq4Mz/CAgE7CMwPBg6kK3wpEuFiazIdJ2aQW9FdFyi7HeN/xCuMTLCAQ45U/lzScGSN
 NvD2t4kD+S+k9EB9wYUTJPV9Vbnu4Gmp0MjLpzZyga+CJI0XKWBKxhWaXPYM8Ecu7HhdczqAOT4
 Nq/fER2xSxxrWAh4TsmBI0RXuyMf61IrfRlHzBM5VDUWstiO0oJqAQ+haCVVoVeIJufxt9o6zKY
 AF/2CKsLI8io4rS+aYmKJBVdoYIUOaFoodgHmV1Aah7HQXd4WC2nYzFn6/FiXzFAIHB/adPLx5H
 tG2t67FYARnLJr5dEFzmYWg5zClOtEzaRCUqlD91m63yYO7ZjJGHSIhX1SSZg6+YJdAJc3TOifD
 7XcdZPkAh254WOOvzEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210059
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

On Wed, Oct 21, 2026 at 1:40=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 10/20/26 10:46 PM, Rob Clark wrote:
> > Don't let the length bleed into b31.
> >
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/ms=
m/adreno/a6xx_gpu.h
> > index d60cbfaa0d8e..5e1f35c83d63 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> > @@ -244,7 +244,7 @@ struct a7xx_cp_smmu_info {
> >   */
> >  #define A6XX_PROTECT_NORDWR(_reg, _len) \
> >       ((1 << 31) | \
> > -     (((_len) & 0x3FFF) << 18) | ((_reg) & 0x3FFFF))
> > +     (((_len) & 0x1FFF) << 18) | ((_reg) & 0x3FFFF))
>
> Time for FIELD_PREP()?

We have generated builders, ie. A6XX_CP_PROTECT_REG_BASE_ADDR()/etc..
which would be better but they don't play nicely with tables..

BR,
-R

> Konrad
>
> >
> >  /*
> >   * Same as above, but allow reads over the range. For areas of mixed u=
se (such
> > @@ -252,7 +252,7 @@ struct a7xx_cp_smmu_info {
> >   * single register
> >   */
> >  #define A6XX_PROTECT_RDONLY(_reg, _len) \
> > -     ((((_len) & 0x3FFF) << 18) | ((_reg) & 0x3FFFF))
> > +     ((((_len) & 0x1FFF) << 18) | ((_reg) & 0x3FFFF))
> >
> >  extern const struct adreno_gpu_funcs a6xx_gpu_funcs;
> >  extern const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs;
