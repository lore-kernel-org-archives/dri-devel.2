Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBF0C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EE4310E322;
	Tue, 21 Jul 2026 10:23:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YkZU9qx6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ENtDqa5u";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F25110E31E
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 10:23:38 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66L88CgC043492
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 10:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FNVZLfwCsaGZu+dN7KdgMrqhUKre/8+4rzOhShj+rOc=; b=YkZU9qx6lnMX4N5K
 Do0b62EpRlotw+/e8mEbhWDllZ3QfTEvVcxyBwNAymMa+RQMcZQyFEuQy7fXxd9Z
 rWH4cWFfbPEGE74FlVO+pJA4iZDM+btPk9jltI5eWsv1UAL6mEo05qZHc0IR+y0z
 RJsUEtKoGNdiMaoLigiqBrxnJsAIW/jkcyEcEb2/Ff2hxrfXhIsfC3c5NR0SSa5G
 7y0HXEdC1VzjBR0o4gRORznyxuibrXiiQ2YD0U1oyc1mN4nSgSvfjlan7Iy2q5or
 tQ7kd/Y3Ni1XNudl9Rhgf4CDLVN9VCLP+AO3YviOI66wsozf3nEO/8J4yKJpE4ju
 0TPZmQ==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj0as22dr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 10:23:37 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-667c40cd608so3884068d50.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 03:23:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784629416; cv=none;
 d=google.com; s=arc-20260327;
 b=ijzMdwN99oPW19Gq2SktKTRAD15j8PgrDIQV4vXBSuhOlYA3iyWLdO9CuqzTiYNLyB
 z9B104OMfj8xfSQ/YQbaCjBK09brfw+jCkqcZ5U4OLpf6ChC6ORtTAltLqpt07gnCz9F
 NF6lDNq5Uv+Q7AH5HtM3Tmrxa2AmqHmN8jReBnHBSo3XFQkdFuYWRp1dLvwl/UTzjAnh
 HUSRP3AWfEoYGxp7I4IawG93lWmU8KI/KruV/xxlAYLApdoQ89My42ivOdwInqbk2RNB
 snpQW7XJYXuvzWbe2PHwGCkL+RPVpZVofiE4ri/4QIhc+wT3rrhAczbkU2h+ZV+qdg22
 Acrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FNVZLfwCsaGZu+dN7KdgMrqhUKre/8+4rzOhShj+rOc=;
 fh=FJamcjQNQDt9vrY2D7w2rmvSyUn0MJzE/GSy31LMkdE=;
 b=Avwc7ohw1plGZL66sJ1jX4thtxx0btvQFfda4mMWIf05bxKOsIbkAGLZj1lWKyiW+j
 HXNySZqcueP7BUJrjkp2U0j0vg+X5jtoaGKR0U1Y9of5BRGMjhdxsp5ZLR3SFL4D034T
 CnTez+fgdhmj3HM+6Zq2E1JqrrStr5ZTCM/9GRYw4RSYtReWD51AF0Ulx7yQ3Ksd1Zck
 OzCsyc4ai7P0itsNQ0E9skTqPEhcsttJIaKE/bsumlqiHAYXXZgufmqiaOEsvqlRZT+t
 y2bGgX4Sn6ctj9vwXfPtVS0dyfaGoCbTDbintNA2mT3WlzCeKfdSIbfXCrJue2NZXXU2
 4ePw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784629416; x=1785234216;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FNVZLfwCsaGZu+dN7KdgMrqhUKre/8+4rzOhShj+rOc=;
 b=ENtDqa5uWzn0L6jYF3W6s64zYW6nhlX1RnmyIdG5GDOZpegyvlHTBfp4EX/6SE3Stg
 oOOUbThtneO6ZI0ziQOIgdcYPEHVMiYDDXWfThAtGXzxyddciYVgfltkKA+vqfSqCkit
 rjTyQbizY7nLl4XR+7Xv6frZ77pR85JSUR1F9Gw6MLRIv2L5+Ng8HXgjkYdMbkbXRog6
 j3Ay3SuCtBhU5agjByKQ6sSQtwcy5sBFa7BPV9I854JK/yK+1ch9MvVPejtbGUFZX+QS
 AnBFVQi1vkHbLFvc7+dOxe2lRSs3q26zWlRxU6AhfX2R4z3+18YbF+i2+8gidPiktDbz
 2Uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784629416; x=1785234216;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FNVZLfwCsaGZu+dN7KdgMrqhUKre/8+4rzOhShj+rOc=;
 b=lkiy8h4R36tK3lVNpQTfIdvpAemz8zS+AX+XLa7e0RgHbiEj4n1g9mO3XFG0oZEynd
 dRUX4S+jcBRoNzVi3lgohxjvnqbCxiIfDrJQBuyb4mapm/Yqh7M/uRRmjdPrlpWNfFUt
 blkVMZGN6g1B8lSnBiMFF7+QNRq6cEm0ZvY0edCeTIOgleZzZYxboIKUByu//x+ps/VL
 KS4pbMjLcAv2gmcyO0lfDMRQ0CzVkF02wMybzBjLPX+HcB9LVwixXs5q10uqre2i3cOg
 IFHDxATGyrSocGWHjrBLQrRSdF2wVo6p3klxBnwTBhc8eNOPxiFTPiL/MaGp4I8NSXc2
 KeRQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrUnyMzGxtA7aV00Eqdcs8pnJkYZWOqH1vgqFIRlhRlTjAdAwAaWw33bXONSAQmlwpB/zlLVE3P/QM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFkNoheBak5cDpLYEFofBEth62f8AZvNQCcx0CXqeBGzaqm8/9
 V2Q1GGKiEnHFFQfvK9ECAKcESgdNnLAJZ6Xf1564k1oL0JB8oV6EcQ4sljilf/Vtry4fB+rfdKd
 ECJgUNC1SQ5thubY/RJtYd00/kVmBCVjF9rcO5VUoOQtJrUAc2dJrZ05NMO2BqEwPJokxtq4i9j
 Lfnypp7N2ZXwR+wmNW9Nb8Q+I4sWbs/dO8mFHYOM1YNMjxlg==
X-Gm-Gg: AR+sD11qgSoMkjOFcNIWVV44cy28nLZTpXeTN2kFCan7++2Jjn8hFAqyCrmhVJ615Sy
 i6ar0jpeIYeN/NnNEAPBR/6TnEUONh73ucE4o/u449p42xVphUz9btcAU+PybwTdxBRyP8xLoA0
 1UjGLOgj9pmPsQ4dtxwg6aXVr+FgfeVzmt7BMoMb1BVWgZSkGckKcH6yX26g==
X-Received: by 2002:a05:690e:148e:b0:668:85e8:7cb with SMTP id
 956f58d0204a3-66885e80a8fmr310984d50.38.1784629416562; 
 Tue, 21 Jul 2026 03:23:36 -0700 (PDT)
X-Received: by 2002:a05:690e:148e:b0:668:85e8:7cb with SMTP id
 956f58d0204a3-66885e80a8fmr310932d50.38.1784629416151; Tue, 21 Jul 2026
 03:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-10-sumit.garg@kernel.org> <alJpc3nFX9D7_8i1@baldur>
In-Reply-To: <alJpc3nFX9D7_8i1@baldur>
From: Sumit Garg <sumit.garg@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 15:53:25 +0530
X-Gm-Features: AUfX_my8FmFS_RPsD9P_wAO_xi3w3rSS9J18xqmBVD6VnuXnMyKuUdz39cXSwBQ
Message-ID: <CAGptzHP8EQyvx3tn-ZVWZPN6TwFec-ADvAuxEQhwQBE00Sg=Kw@mail.gmail.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDExMCBTYWx0ZWRfX2t9GKYcH4/MD
 DA7UhOUmaigD03eKJQQ9DP7Qg9+n3DA4BLJYpPXaGLSl0LyKtTwq4DZftkuWlAWKGHupHYo4UEa
 yK57b+lpUE47utBU1t6XsG8FdbgovOgT6XHx4uUhYrVZmeNnh/e8Eucg3LRv6rTBrIJc2TrmrQI
 aRJSprAqZbq95zgZwnfQd59Cc8umBwA6WL2v13GmUFKQEYdm5jXyU0FYrxzMLhVGf8+MDu/hpLF
 JfNMD0q9NhQbYtAN0g+VwZr0kJgi1wf/onxX2Yfim2szFiISmaGc1dJMzZtGVOs2hTlcFfL9muJ
 TR0qep6xU0FSPR0foEAn7HVcedATftKxGUJ1i2Xd913mFfKmrThiHwB5P9JcjvnkCy0gsAjJLc/
 m5zZTh7AMKETeSkzMlJSa3K++phVYFVoo3aZAxanVXlaMX8cCmwmUJM+lCCGkth5RsKCA+40Cga
 DtWaZeaD3XaZS3H2uSw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDExMCBTYWx0ZWRfXxPOJstMK1vGH
 c5WCVoCUSIiqcy0FAH3Jn+6yTKlMwVdY7JzmxrfnuWxQvi0fH4dk60LIxjXZAgMUr54sh5Eqmq9
 zxsRmCEvHBIaHugZD+6toQJP6JmiCCA=
X-Authority-Analysis: v=2.4 cv=DoFmPm/+ c=1 sm=1 tr=0 ts=6a5f48a9 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=lt5aTsHmsBbDyw7JONsA:9 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-GUID: B8DrGJ5CIfPGP9i349Ijwlq35M8lG8rx
X-Proofpoint-ORIG-GUID: B8DrGJ5CIfPGP9i349Ijwlq35M8lG8rx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210110
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

Hi Bryan, Mauro,

On Sat, Jul 11, 2026 at 9:36=E2=80=AFPM Bjorn Andersson <andersson@kernel.o=
rg> wrote:
>
> On Thu, Jul 02, 2026 at 05:28:25PM +0530, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> >
> > Switch qcom media client drivers over to generic PAS TZ APIs. Generic P=
AS
> > TZ service allows to support multiple TZ implementation backends like Q=
TEE
> > based SCM PAS service, OP-TEE based PAS service and any further future =
TZ
> > backend service.
> >
>
> Please find an immutable branch with the dependencies for this patch at:
>   https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git 20260702=
115835.167602-2-sumit.garg@kernel.org
>
> Alternatively, if you think there will be no conflicting patches in the
> time leading up to next merge window provide an Ack and I can pick this
> through the qcom tree.

Just a gentle reminder for this patch to be picked up as only the Qcom
media client is left in the next branch for migration to the generic
PAS layer.

If there aren't any conflicts then please allow Bjorn to pick this
patch since the cleanup patch dropping the old SCM APIs is blocked on
this.

-Sumit

>
> Thanks,
> Bjorn
>
> > Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
