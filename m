Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72900CA6012
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2B3910E582;
	Fri,  9 Oct 2026 10:04:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WEXjmYKV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="efS22pMx";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C0A810E582
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 10:04:01 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998KFZB642352
 for <dri-devel@lists.freedesktop.org>; Fri, 9 Oct 2026 10:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RGFAbqayoGzkNoR9L5GgWnoZmVxL7JzSyp3JwWFjq1k=; b=WEXjmYKVBun7yiWt
 YcX80+2wv35fcTXvK0ES0ZsZU2i6UqtGQUdqQ4VwyEeUF/DSdreHDgunke9Bt6Zb
 uScCI2vzXkW/VEx2NnFgsweM1StFeweU8GOg82xUFPbMEEMB5NkDKsgUgKSkizv4
 zY5MHEbeGsyttEzp9ebcb3RpBQXkvjgKnoSv8ArUfBs/s5/Y6GOMqcgILZDcv/pS
 pEcgCWyXzVgPO46tMgTDwL6Q3MsUFTZ0c2FA0U+PYKGZBGvML8OXH3wDKGQHqrkL
 9HJuqxwi9YNtGh4mdyRvz/KF+F+jklfT+CQgBQ8hU22qEI+ihK0+Ax9tR3OQTFbk
 B8hibg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxru1ug-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 10:04:00 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-88b59692e0dso5403035b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 03:04:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791540240; cv=none;
 d=google.com; s=arc-20260327;
 b=Ns6K5hh+61EDeKWKIgrRGzOL85F+KXsbywx1SsyYQpRoMQgYCVvCMHNfWzSzR11620
 T5lQijUNjDBb/SWhcfaQCkw0D/wcMyVbx10y1S/t1hg0+ezlT6Zl+c4KnLXCHuVKjJb2
 99Z2OMmN8rwC1rNyv8E5u0BBqlBtuqinMDvuMSi1vI/paC32ISIzB96yN45TeVA0eZ8L
 E6ZduAO7V53SCYyHEKaz5uIwZKhSmfW4ETUz8OQEXeYOFo3q2oRA5WeBxO6USxmAXA1S
 RQ+kuYmsgn0y0Df279KZ4gMjHW0G16auT1MyZro8jptyQUGey3bUgfAdp1BT3mnt+lbO
 VOrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RGFAbqayoGzkNoR9L5GgWnoZmVxL7JzSyp3JwWFjq1k=;
 fh=AEn1XrPZ1QH0eOIJD/MlWSJe8yahlhybJGUFB5SB+Rg=;
 b=OvYNJ7nEAbgBtlwUNiYH+DY/MvLKF11U08rl2RJBjZfCLTUJ4Ka7//1znM4KE1IN+q
 Vgu810st9PboVWbjR2txVqdvudmYn65h38NToFYHcQw33BRpWzD72QfKIvCanQYKnsqp
 FdkDA4724S1uEnRnyBVZLKqrkzwydFZ4CoENRn8WbyAxBpDexZ+ueDgQl2HJOKewveMc
 R5A7i/yWwqt6P6ET/07zOrYxas8KHQ1hg4pv1SW4kCU/uzsYmcCgBi47OOEWkdnuJmsY
 WHwjTD23jgLSvJPbJjojAMZ8T28FldYpujzIDhdBmXfQCP0WjpZGqJQfRduKjd5Mdwp1
 /ZBQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791540240; x=1792145040;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RGFAbqayoGzkNoR9L5GgWnoZmVxL7JzSyp3JwWFjq1k=;
 b=efS22pMxXaqaThVw1GOwDMbEshMyl3T+WSoVUIpfwnwFHaQeyTyK471UsYUA2VlCu6
 Aok34ufn6DVNjHp5Irj/J4SEvszxTAck1YpNnXitUzltfuogflFj9VKTd8dkjOMwCu+B
 yC9GEPc4bv28gxaPr0Pzsb7H2Qv0C68qbbMmuS8jsg5sXh9/CufO7/LZEs1Od3VZKvlm
 V+FUUEqaQ/cyvp0iBGzkPuA9CoB+SBm5YOWSCi46R6bB8eC+DjXOf/QYaVWkp5Dz+G6t
 6gtjWg96WyxLPrcXqAkdw861bmFOzA1kFmjKAEcBLPqh8p3vmpvcB+NEmfqTeQ20LRUf
 z91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791540240; x=1792145040;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RGFAbqayoGzkNoR9L5GgWnoZmVxL7JzSyp3JwWFjq1k=;
 b=i+0sEahEQPQmte2tpL9cqteNY6kVFiX/VR0MPDH5ULNPXEC8cdGX5nAQfaxXvXxaeB
 aWhb55qnUvHyJEF4Y+r6SGxqT9N32kjcukKUclem+tu8x/GoL8P7Y3BWERTNHMmfUUHp
 vMUveMQesIcJwKOxiEPRh4bmXASUY68lpHcJrPxCB06awa/kykHBx9hE5CLXQa9pT/ht
 GBt/Ny+hIbf14i4FXB59Ky7ciQcHnd7myUtsYQvSgjKGnHvzUQLVuPLI7NwNxOQwRT90
 fUaCiG6RTPrtx48x7tvIRI4aHlgg/jdLtwNysCsxrhRc/SGDYwJ3m4dDAQK+54/oc0aa
 ch4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcU6/nWcW8Okxy9IoqqKSqcUH+YF27uswaWQFaE2ATBdV5BOjEUMzZoTDXkE8wu+iP0kQUdCx1Fxs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIGfZ+yyGZcvYqB6v+KzCwkhT5b6vkq+sUqKr4u5CMOcMRmGINF
 Wit6wczkxUFdwkewME28gZc9ni2qi72sV/btYZoWCV50ZGapNVvQNqBesn+Wl4PAVHC2YaDUhk8
 YFc1I0XWCkTbPypIkCN/CXVgo1KK6Ki9jdXxbB0MgPllDbYBsoPoB5hunD5nnVtvuwcZZJwafJs
 a1ikXqdaiBKZ77Z36bkm1MPcfP3Ckvz8joarAhKQN+1ek5NQ==
X-Gm-Gg: AYBFou2NBq/7XFZR+OxaQmv+XFHVRRVZupZF1+R2pg+jmP2ld+m4nvJlCfvJzX1RXZd
 nDvHqZ9rM9fp6LAuXDe3UWinWhlTI3qLP7vCh5NXYIAzwqG54WKzp0UQpMdUcmCclTIuE8sWnSt
 4ZOeVmRtwgFLYIjSWQupr28UWDXFN4siiiu3M+qpuIUJS+IMFtK2QXUZrXfA==
X-Received: by 2002:a05:6a00:4f87:b0:881:1fb6:a81 with SMTP id
 d2e1a72fcca58-897c3ff538amr1154986b3a.3.1791540239800; 
 Fri, 09 Oct 2026 03:03:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:4f87:b0:881:1fb6:a81 with SMTP id
 d2e1a72fcca58-897c3ff538amr1154954b3a.3.1791540239339; Fri, 09 Oct 2026
 03:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <CAD++jL=gFt9kKZH9T-m8B_pbwRvzc35tTrMn5V238d3528DpUg@mail.gmail.com>
In-Reply-To: <CAD++jL=gFt9kKZH9T-m8B_pbwRvzc35tTrMn5V238d3528DpUg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 12:03:46 +0200
X-Gm-Features: AclHuK9hQAW8ziR1wvAdOw0nLveraf3a0x0LG_1OOR8LPyJDyZu5bXvxmgGRPSA
Message-ID: <CAPx+jO-wb6NLYjnn_k7xu=Wqq61+vop9o7UM=5Y47U-WiGFXBg@mail.gmail.com>
Subject: Re: [PATCH v3 00/18] pmdomain: st: ux500: Implement ux500 power
 domains
To: Linus Walleij <linusw@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Frank Li <Frank.Li@nxp.com>, Frank Li <Frank.li@oss.nxp.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Frank Li <Frank.Li@kernel.org>, Lee Jones <lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=E+1YNqdl c=1 sm=1 tr=0 ts=6ac8bc10 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=MPZ65LRjT8IzFkvHGtsA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: 7ibe_ztcr3O17MW9XTh_i6EZ7sG7eEn2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzOSBTYWx0ZWRfX+RHlCxDA/a1Y
 ciit+XpE9E4P8l7kuQiV6+fwocXh+JTyU/clCQA16s+Q1oOC7XCT29JZ6SkMtEmdozWWC477+bZ
 mYWZlvJQ5bf6LywEbau3oKUccb5KyLCY/stjFWrb9ogac2rSw9pqe+xLTha8ycSwraiqelBp7aS
 xUDZMutwFTyKnwOAOJmN8Z2BhJ0OEs4cXc38mZvpg/TOVXZHnljb8ncdnVHMtr8QxDkeBbdioVn
 NgEcL8MFTW4dguZRfskvDzRSnL8MegsoURYxUJWKixnEFwpXAtOifcz+Vx+H6Be0EYN0KULK2kA
 sv1y/k9IBw6MeHWZoyQx/LJf1fqp2VD/p1reCv9f9UTDc4S1lWBumiJy96FcIM795CF9RfeW4eE
 LMsKxDkrumYNnLX1jn0fCio2cpNJutV0loKieT4uYJR4iP8Yd/aNJYmVjQTGu4s3pOyvNe2+XTs
 pJYjmh7GihqxJfPjreg==
X-Proofpoint-ORIG-GUID: 7ibe_ztcr3O17MW9XTh_i6EZ7sG7eEn2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzOSBTYWx0ZWRfXxCw2AaDeJtrZ
 ynGeBZlgyA+UK+1/PUlr+kswmP1gur9xKEwsp5FC8Z7fF+rlXtCjeJ3qQgstjW87B4Ri/n4ke7+
 UHz6WZYUVnTolleHKd9EoELHpyDmeto=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090039
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

On Tue, Oct 6, 2026 at 12:30=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:
>
> Hi Ulf,
>
> On Mon, Sep 21, 2026 at 12:48=E2=80=AFAM Linus Walleij <linusw@kernel.org=
> wrote:
>
> > This series pays off technical debt from the beginning of the device
> > tree for ARM initiative in the early 2010s.
>
> I have so many fixes series that need to land for v7.4 that this is
> mostly targeted at v7.4 at this point.
>
> However:
>
> > Linus Walleij (18):
> >       dt-bindings: power: Convert Ux500 PM domains to schema
> >       dt-bindings: arm: ux500: Drop NR_DOMAINS
> >       dt-bindings: arm: Add the actual power domains on U8500
>
> What do you think about applying these three patches to the
> PM domain tree as a starter for v7.4 if it's not too late?

Assuming we get an rc7 on Monday, it's still okay for me.

Although, please re-submit these three separately in a v4 to address
the comment on patch1 from Krzysztof, then I can apply them.

>
> They are reviewed by binding maintainers and should be
> uncontroversial and will make it possible to avoid trouble when
> merging more stuff later.

See above, I think you missed the comment from Krzysztof.

>
> Yours,
> Linus Walleij

Kind regards
Uffe
