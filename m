Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFB8C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3134210E072;
	Thu, 24 Sep 2026 13:48:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eHjiz8y8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RoZV5u9e";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A4F710E072
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:48:42 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC4kTB1429858
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gIzGgpbn/bLfRecbbJR8idZ+V5oVFq52ZNmGReij2M8=; b=eHjiz8y8YIHa5or0
 11zmYv8N8YFWNIrLMP+nSz2/CY2JsZMAGAiyHU7KTwUOLrN/RgQ55IKjEboEug1E
 nydY3hdgllD8W4Mbr88/Vb2+WaKgXhFBIxOTgRIgZ0m1mdrkgnEUJ4ZQ3yEAZh/n
 u534i+M34SCuyNfiBEd+Sei3pRJLNbufiIlZqP1o3sJIz6cTwDK/fAjOqRTU8T4F
 lU+6mFAQdEnJEAuk+6PGMgD1LnD72JlZtJIFbFDz7ulf1r9gFBFFty2DO1wwRiOt
 y4aPrllNI8TZVUbHydTUVIQUDEoW6IWah+KSKq2AJDUEVqfPwzQhEAMUr/0r5QHX
 WbYPfg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvvghaa4c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:48:42 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2db3734d06dso19081095ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:48:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790257721; cv=none;
 d=google.com; s=arc-20260327;
 b=pICF+boQ5iSm7rr4BFOusGL/38VSoYdNeTk6LeOfY8h4nGeWngueCPn55IyhSdHyx1
 7u9NX5NNApVBHsQthQKXEjSRXWt4r/VmRt91EuZ72iDxBugLEhjXkRwgMIFuA0cdEHxP
 t1URe6+9vnDO9ZeT/JFGV9koYloVt4ycjUiI7nBVqFDcUtQct/QPy8OW7tttt+IZ5JCb
 RdN86u6DHMIY9SyQFoRfw8WcfAZna/KVInk7spn/6X3Z7cwRqF4qSKOs2PCZEOal84ER
 UTFa3dfOe+OByatPfsZzjRqkzt5LymRC9HPWyPHkXAfVXryYRKFgywwt52qRgR95Noww
 GNnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gIzGgpbn/bLfRecbbJR8idZ+V5oVFq52ZNmGReij2M8=;
 fh=TP0RXlvuUL1mf6eZTCKftoPOxeY9QeeUnSNHZbyn/Lk=;
 b=lw6Ei45Kd2dsWOD1KWRfNfqvl1U4iWnwPQaRkOYS2X0ucQmmh4DaSEQ0pPOYk+RFTY
 co1jXBFaBNGBtxfbPhApHBgURG4OlbHtqDOhdGq1ZhgwwCBrsc5vp84P16i5E8DNXom4
 H7NUQWmHAC6DS6OR1Jh+9YYkC7I3f6PP01IeS1TtIw++MCGaKOoJBFBuyoK0jDL8yfsu
 X8K/J0cBP76a+kvaOfUOg/3AfYFsxhCnmp9cR5JwNPZuPnuU4uX0wprKGLTv+wvya6cI
 +1EAWB+Nhh2cWLSQLFXm4M6O7BwglaF7QO/Ps8fBIXN8zDWN9QrnCVnYBJcIeITh+s7B
 kRdA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790257721; x=1790862521;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gIzGgpbn/bLfRecbbJR8idZ+V5oVFq52ZNmGReij2M8=;
 b=RoZV5u9e+D0aFCCY4ozhax2G1rGBevM7Z2R9FvOCRw3ZPYEmJMg+h+NTwWWSSy69Jn
 qadmLVAo84H/gxI1xiQUmrQ+sLQSZCuIgmPtY1yKF6T2/XVAVLOd2rJZxa6iLO6rqVtL
 VMR1D80CTudj+oAG4kPH0BruUjDerfGOC8+5SNNcCtmU5MAQBf4XZyW7d6Gj0d2FTtzM
 7WzV4RVjg2ns70Tlw12ENF2zPPfFofAcOuo91HV4Silb142ea0q6Z222a5hISgGvLxkO
 +Y+s8K3zax02BuiHJZV+craKPilRQaXhE/fWbFPOriq0dKabjwaBWkJaHT5tS2ZY1XLX
 BMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790257721; x=1790862521;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gIzGgpbn/bLfRecbbJR8idZ+V5oVFq52ZNmGReij2M8=;
 b=oth0ilk3e9oUiVCiCXS33PEkjAlKd18opwvla5e5aFgHZSBB3sc9hSt1szp3d7CvBe
 HcCaCNivD9+h2jU49HugqfQJQ9jn8f/sFMi6Xnktyr1i763t4NppGXrFHhdX3AmlIHSe
 vM/8K1Q30wTVob4I9QZsHEY3lN9DsAnADcvtifPv9YRh+wccIKi1nq54of2+WkdCGH5n
 ka3Pl66DflFwk2i3mGSYwWuTpl4kCqNQzMDYtIgoYiXemHHryh5uxMnygQ04jqM1usMd
 vwpQKaykpCY2LlFn19DiERdkGSqMDIN01A6HrxP/D2JqokXSq/rzs3XJxKZjn1CV6ORI
 p0GQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxuiNFZ/KUpY4sCNJeHlHVeNWa0i3VyqCwY3VX6kQhdiMjEb6hkZK7j/9Gu3hOEz/KCkS1SvNXnwj8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lbjjLOjdlfQvX9zIpyL3+qBGemncFR1i9RyleYJVEJlLx98Q9h
 xTzS+9KkeIGM/UeDQCP6V3SRF38qTYs2DxIdpXfuXfcm3hwSXwrTSjRuUg5SLzR7sC1fOeM+EpH
 9mc1Sn0zw4BW/Hc9uOlcds3NhmQ8Q9hoGGtb3PjqEgJAOq90uX6CwX7d/58bVFBUSz6rZK0vtgT
 ff3Wqww80OgnFKsQY8Ml57GC7E3RVOPdmz9Oh6qVDcFNfakg==
X-Gm-Gg: AYBFou2pJPXbIYfDZzdPnhLEnwgPNCQ11fRd1Hm6R6YK7hYi0WX54cfgtlyeXaD2rB3
 6B9v+0B67gLlMHvysroK5+doXH7BaIpzSM2XxCirBl6XMvW9mkxcZefUsnmWXMFHL+ucn9Uox2k
 2aAQVMwshGrMzTTL6Yc0hyH9nhHdzQcebRkmoaqdfRDx9SIUPVHETUQoqzcg==
X-Received: by 2002:a17:902:fd8e:b0:2df:84e0:9021 with SMTP id
 d9443c01a7336-2df84e0985dmr10949325ad.7.1790257721292; 
 Thu, 24 Sep 2026 06:48:41 -0700 (PDT)
X-Received: by 2002:a17:902:fd8e:b0:2df:84e0:9021 with SMTP id
 d9443c01a7336-2df84e0985dmr10949065ad.7.1790257720872; Thu, 24 Sep 2026
 06:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260915104328.45901-1-gahing@gahingwoo.com>
 <CAPx+jO8EixqfXmrD8zkMkJe_B+2AATo=YNFJraAdE_O9X4KM-w@mail.gmail.com>
 <20260924090816.38457-1-gahing@gahingwoo.com>
In-Reply-To: <20260924090816.38457-1-gahing@gahingwoo.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 15:48:29 +0200
X-Gm-Features: AclHuK_QXocrU1FUmDoQ1C4eNfLR68g-9FvqDtL-NyGnjY3Q7BSkJqEHWuwlS6Y
Message-ID: <CAPx+jO-zAr+gfEGG5xvWXz-72cU+mw2HOnm7xVBYGhMenZWSVw@mail.gmail.com>
Subject: Re: [PATCH v13 00/14] accel/rocket: RK3576 NPU (RKNN) enablement
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: heiko@sntech.de, p.zabel@pengutronix.de, tomeu@tomeuvizoso.net,
 chaoyi.chen@rock-chips.com, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=KYhHIgYD c=1 sm=1 tr=0 ts=6ab52a3a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=9GNsruGHAAAA:8 a=gHPckg_Ghvi-cCk_7foA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=gf-oSkQAjqHFJRp-GQfY:22
X-Proofpoint-GUID: kuS_PQuaOAQKLaS6sutiXJ5h6NbL4vI6
X-Proofpoint-ORIG-GUID: kuS_PQuaOAQKLaS6sutiXJ5h6NbL4vI6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1NiBTYWx0ZWRfXzdSYzZr56Fpn
 Th5jXxQHu2VLiMYWKaSc0WGbN+DoutE0PgaULtEh8pNMp7bE+P6qbZGJAXVbxntUFfnC7gKOyjw
 Gn99qKvCglLuCWzjoiIXcMGmK1F3eRw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1NiBTYWx0ZWRfX/MCHX9VZPzQU
 HWUoZjbtNt0L16cj4ELCs2BvufWkTyXjLG669RTU1dVOEoKZJmETBGO6RRIdWz4QUBHez6RKSvf
 6RtmRQeVycSiAJSyTeS11nvwbY+WhiDRKY84ih3+boJD4VM4vn7OciyUkGJtAXbYuI9BcXLxd1b
 W/HBc+6W9J0ONiAdxMDez/z+Xia2NL/MXRyAg7qD2RTGOOgEjvycHN1ZmZnlD/BG7pPC8/Zah0M
 cQWcg2VLrQYU72OqQ/P/bTuGNGjGVJOCTcw7NmHn1stchxmHditrE/naryyyFttm3yvHKn2ZuLZ
 8YSKUdym6gfYL7um9xrzoKEk3hF1mlUU4+FwUapuVLTIRwS4t5U1T3NqC4dfBFfRR3q9BQZPe4c
 DbN2sQYt9Iv2JEMejzAIJK/5ug37055H/qeGwSE/YJYqPzxrdRgGggGsEZ5O3uqDte/zbNy9YQo
 UdPv6x0s1JaGpQosmig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240056
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

On Thu, Sep 24, 2026 at 11:08=E2=80=AFAM Jiaxing Hu <gahing@gahingwoo.com> =
wrote:
>
> Hi Ulf,
>
> Yes please. Could you take them from v14 rather than this version?
> Philipp pointed out that the binding allows one reset, so 10/14 should
> use of_reset_control_get_optional_exclusive() rather than the array
> form. v14 has that, your two commit message trims, and Heiko's split of
> 13/14.

Okay, good!

>
> In 9/14, v14 keeps one sentence beyond the two paragraphs you kept:
> RK3576_PD_NPU also gets need_regulator, which makes
> rockchip_pm_add_one_domain() power that domain off at probe on every
> rk3576 board. The subject does not describe that. Say if you want it
> gone too.

I will have a look at v14 and let you know, thanks!

Kind regards
Uffe
