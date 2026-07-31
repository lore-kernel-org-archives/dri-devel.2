Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EABDC5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 08:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA7A210E21F;
	Fri, 31 Jul 2026 08:39:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y0426o5D";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E5o/5ISD";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FFDA10E21F
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 08:39:29 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V8Zl4p3675556
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 08:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0aS3a1IldF5Hbms4X/oaN6dyR7C27AUylN470557Iek=; b=Y0426o5DtAmpV+CI
 pa9mC3woijvQAOSlCbxssCTGjzH/9SyPVjH1jOdc4ONy7HX2LtjtlCQZV+pBSORq
 BMyq/waKEb9hCO9u1nC+yzqk5caF6dVBfg39rEORc4E3d2GR1iJnWThRE1Ynue09
 5ebW5LPfCkp+baXesyO7CTvBAVuI4r+HRlj7S+l8tX42yRy3/qGBaS4hm4xnJapX
 zj+ZUOXWxFNFl6VWRYa89+uKWtPxfiYch5T65AY3hoQSRou9jxqZBw2oLajdiXPX
 nSwn4106VfDFAUzryNFM3GOgDiJR12oimHPrSoryWJ3NgQCOkmKERuam0pOUatkh
 GEvotA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frrb780dw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 08:39:28 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-81e6fce9ed7so16881737b3.3
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 01:39:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785487167; cv=none;
 d=google.com; s=arc-20260327;
 b=U8ZeexJVDC5lmxbhp5gpKUXiLSelcj45QT+/5UthFGZFXTRZH/LwH1GdlmHDR/W43b
 YzAUjYZzx2mgQe8wgS0/8KEb2c+uZnKtmuO4eaOu/RAFiHNcyTa6ThRZtlYPdsyP0RmO
 ryucERuUui1V1oNLWkyb5MsEpMC8jyK/0ebJfb1fk6IFMLWV3Ep1r5V0xLf4jBi2y8EA
 gn72d/g5v69H8AcbvBrCVNzfKDWWfnHK0RHgl48H+Pik6q1A/88VaenovfXSdjI9nise
 1GuT2kEYxGCAnpekyyufVqSy2/8N+KRA2M/jwX08T2zPoaOrB/z82VwSl7yI+292n47r
 qGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0aS3a1IldF5Hbms4X/oaN6dyR7C27AUylN470557Iek=;
 fh=/SFT9MLoStGYXZhJ8EUVegh65mYBMj4WOwL8LZELv9k=;
 b=IPGhJ3AHl+e7rP7JZOkAwhxJBDGEQidU9mtzhuWZdhpREllMTGM9DRGh5tqEvAhvPd
 vFL8U+mAKkzrDirwIA5Io5YSQIF80XO57stckCRszElplwIMcdD5PpIbptZwMNeJQY7y
 Z0RwZo5L0ufiUougwxzaI3O3Hi2Ymbu5N/s5RgjL3l8NAd0JuMQXHqBUAsIPPZe+WTCH
 peq6JvSoRv81yVlTYahEO6KM4KV06oZ4kTMcm6kd0IQzrFLr/p80lEYpNyRdSGL6S7kp
 JfZsS15oNplKNv9OVvQCRYv8pR1m8MBYcFVMOs78QN7uLaamTLzOKK+GN1Edcg8psoDU
 IkUQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785487167; x=1786091967;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0aS3a1IldF5Hbms4X/oaN6dyR7C27AUylN470557Iek=;
 b=E5o/5ISDysh2v/u+ykLD3caX/zt78E8Lgdmwa4zV1YG9lupSxY4SwaSVwi0wsYUKT1
 EUIEx3lv0MOXRUfxBeIXj68Tpavex6qOS8za444Z1aXOaULNldGF51/kHj7pyxJNxMyx
 In/gUNZHZW/WugMDEBbg+E9mUw4BASAtVq3tjndQxrms01TP69xR3MX2+D/3SfEAAUGV
 h/fF1xv78RZpaLRvW/kLsyZbe/MLzT+ztJESj5i5IKKRM0QDtctlNYC3m3DykJXnYmK0
 DT0AgBv1c2z3pDEAfqH/Vy08CBN4C3zffQgs/1cAdhI3yPmRYNgSGbimOGGroubqKT0m
 GfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785487167; x=1786091967;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0aS3a1IldF5Hbms4X/oaN6dyR7C27AUylN470557Iek=;
 b=XGBJr+DtyeBLajuxF8etWvuxDm6s8cSYebz5MEY8vp6my9eEeHQetLlKDfSQ7wmxCX
 o1UlfVrROeOpuT+RMDmhf4UoukANPs6TqPaXnHqxZqkyY6T2g+IixHB6HpdRWwWE3j9F
 jizxiBg58fHKiU04wgBNuXhPxahRT2EVbd92/8skeY2xPc2yly4h4extOEGc5/HSOd3H
 dCqnC+OhLnWdKhzO6BP202n9uoxKwFCQYqRElb+Aqq+BcbcTdA3vDCdShnWZuqAXaOay
 utGnepxD7wysVk8k6k4jD0YL7YEgUkutg2RtK5v2uLgqIgDbSatYICuYBxhZFPlSUc9F
 85dg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpvOroF25iB82XEJduf1QFyGNoNzQ+1xCQD+qonfLRU7nOq+pB9/LbNGx1Z9bIwh7s3txTEX6wFeHU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxETr/P0/ersJ3PBQxxFrvsDp6UbVOWpTxs6luNIBuuI5UawCt+
 SfFgyQOgOYgqVM/Df53M3R+3pdbR88BrEbWn8nK+xUqWFLphzZmhFRKzRV6DjgLk+mWxfijNTZ+
 kNd7miqzqgW1ki/9tsI5DzZzvtpqzExXr05nu0O+tsyKSK51UG8wwwsUR0Hh0g8Pf/pYje1rfVE
 bcnhX3/4FR4kufvzYefWaJtPEdsAHsQNDmWt2udVN8ANhHYA==
X-Gm-Gg: AR+sD12AR39KO4uHsXX6Cj59NGPKbrL7w8rJeqC9rX5B/jl8M5tI24EVePKvM9IcAFv
 okzpQxIUuKYOW0+YgeJHMGS3FwlRJyfjNH/63NrhgB0Xv7cf0WzVQRwBBRK2PZSkrYogMV6kx1U
 XzLII8Wc/7sJvtCn/Kr6ajrL8h6JvkxeZ0kuiaTvmTgNC4F0r2kzGx6s0j
X-Received: by 2002:a05:690c:7305:b0:81f:650c:98ce with SMTP id
 00721157ae682-81fcba86c09mr6967727b3.31.1785487167422; 
 Fri, 31 Jul 2026 01:39:27 -0700 (PDT)
X-Received: by 2002:a05:690c:7305:b0:81f:650c:98ce with SMTP id
 00721157ae682-81fcba86c09mr6967197b3.31.1785487167009; Fri, 31 Jul 2026
 01:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-10-sumit.garg@kernel.org> <alJpc3nFX9D7_8i1@baldur>
 <CAGptzHP8EQyvx3tn-ZVWZPN6TwFec-ADvAuxEQhwQBE00Sg=Kw@mail.gmail.com>
In-Reply-To: <CAGptzHP8EQyvx3tn-ZVWZPN6TwFec-ADvAuxEQhwQBE00Sg=Kw@mail.gmail.com>
From: Sumit Garg <sumit.garg@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 14:09:16 +0530
X-Gm-Features: AUfX_myayjkpJROHbmEgd6_YM-8VOlEVu55qy_zXpmBuYnmJ9VMnESXGGquBttM
Message-ID: <CAGptzHORxaftDtf9K5pCLORK0kpdfP4RGRSE9iNkm0Bf+ZqmGA@mail.gmail.com>
Subject: Re: [PATCH v9 09/14] media: qcom: Switch to generic PAS TZ APIs
To: bod@kernel.org, mchehab@kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
 konradybcio@kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
 pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
 srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=I7hVgtgg c=1 sm=1 tr=0 ts=6a6c5f40 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=SwCItUvQPH3YegUC7JoA:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA2MSBTYWx0ZWRfX9Qaln+1zZth2
 EeVV4qMKu5ca/mG3pq60AIrOHW4dO56NQaZrOUX/xRj/0XPc+9BTNsi4KUfmbwimWWumMciSbY0
 OQjSijqswb0PSJCIitx4cgKssDWxEpRV6NOKwImBWmcL2smAgd35TryH5p969Txmredk9tejVuD
 /tq3jqPMjPBNQh3uF61J058ZcJbNk0jX7Mogf5+wJKp3zofv1Y3o1N8eR5O6aZMQH5lJkMyCoAV
 tD4N9W7BIW1vX9jR33QOQ+eVI9QzWDLRy6F7SQ9JC0AKf1VOYQ8mcMEDs3Jpw3LdfHHDJD6exTA
 BqNI+qI0t6/1rTD1n/cOm7M7bk8wE4063y8n0pDD1nTlfG1wZ3Le0RVnnc7TK7BCNy6gw/Tknms
 jnOjdxHx8u0bIBbANJAK7MTVOMIDnmEVMNjABF5qwpVFDdbRjgMR9CuOoiHwJOmft5BLu6RU48n
 jrFCtu0vXPcWjVhJ9xw==
X-Proofpoint-GUID: G2wcg4MHDwD9mNjqEDk8dc0BKDedxzWg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA2MSBTYWx0ZWRfX7TrxdjEO2r+7
 9Kiocgy2G2ofB89NzUYz6oi/sLiHZjwjTA0MppmTdN2W9HlwYfc30qYHSr6eyHDKDj29Yhbo/Jh
 jCH3Cr6vkH7r4uv+58QcWZ0w1RpOPQY=
X-Proofpoint-ORIG-GUID: G2wcg4MHDwD9mNjqEDk8dc0BKDedxzWg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310061
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

On Tue, Jul 21, 2026 at 3:53=E2=80=AFPM Sumit Garg <sumit.garg@oss.qualcomm=
.com> wrote:
>
> Hi Bryan, Mauro,
>
> On Sat, Jul 11, 2026 at 9:36=E2=80=AFPM Bjorn Andersson <andersson@kernel=
.org> wrote:
> >
> > On Thu, Jul 02, 2026 at 05:28:25PM +0530, Sumit Garg wrote:
> > > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > >
> > > Switch qcom media client drivers over to generic PAS TZ APIs. Generic=
 PAS
> > > TZ service allows to support multiple TZ implementation backends like=
 QTEE
> > > based SCM PAS service, OP-TEE based PAS service and any further futur=
e TZ
> > > backend service.
> > >
> >
> > Please find an immutable branch with the dependencies for this patch at=
:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git 202607=
02115835.167602-2-sumit.garg@kernel.org
> >
> > Alternatively, if you think there will be no conflicting patches in the
> > time leading up to next merge window provide an Ack and I can pick this
> > through the qcom tree.
>
> Just a gentle reminder for this patch to be picked up as only the Qcom
> media client is left in the next branch for migration to the generic
> PAS layer.
>
> If there aren't any conflicts then please allow Bjorn to pick this
> patch since the cleanup patch dropping the old SCM APIs is blocked on
> this.
>

Gentle reminder again for ack on this patch. We don't want to keep the
legacy SCM APIs just for the media subsystem in v7.3 release.

Can we consider it as a silent ack for Bjorn to pick this patch? This
patch doesn't make any functional changes but it's just about renaming
APIs.

-Sumit

>
> >
> > Thanks,
> > Bjorn
> >
> > > Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > > Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> > > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > ---
