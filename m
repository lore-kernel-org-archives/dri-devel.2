Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF03FB5173
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 23:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 981B110E300;
	Mon,  6 Apr 2026 23:42:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="A8VNuzfO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="irEgHr9C";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34E4710E300
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 23:42:20 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636LQKcn3537314
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Apr 2026 23:42:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C3Lc6HMiLoq3fOrxhAfmM90ggy4edfwF+3FXKllorno=; b=A8VNuzfOhiCv4TfW
 Ca2EftV+QPs/mncQp0Tq+DREHq61Cai2Yczv935fQdZTOPpVlpo2WFA46qFfFKa2
 PzMoiFr39fiBFhh5vIMaMG44zQFjygnzIToaJo3UEkxDieFsTc439aPWzUXYEvpv
 chodlaD2wGgE/RY4dlG1bf0AVSZFiUI8PE8oDPt9tajep61FOxpa8zT7C809zy52
 fSsd38VItE4S3dC6Rgo9HHuWZla1VvATzJwPcZ58mvbSt+qwj70oywoiyrI89un0
 gOcaADxITAlLSVDyHe/tia9LvQyUMllw8Kkyz0coWgCnxKiUeWumu/21eeJoCKwh
 PGcEeg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmra091a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 23:42:19 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b52a2d70cso103183171cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 16:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775518939; x=1776123739;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C3Lc6HMiLoq3fOrxhAfmM90ggy4edfwF+3FXKllorno=;
 b=irEgHr9CO01QcaTHr0/32w2PELAcYq2RPqWl3YjgwMFlN31rc7Yn85HKpbAei/lwxD
 2NqNdVfLeJ0BRa41AWLKz34qnzWMc2+8PxgY7WgqcI/OAE1QHig1BXXaVCmC2jscVeBo
 YymF81Eu3NFLpj2g0rf1C8Co+6u3m3QEnFztSVoRIRjffhbrRaLYcbT8Gk9NrvBNX8F3
 KefCGpO5R1VkoQZq1X4rnLQHbHdOheez4KJLSGj9jnJgq1P0/xzgrcqfwM22oPoQBvVJ
 5Po4ufmbYGlfL2HxxDPU858/SzeaXTF92eJhyJf46xsThMY486rQNPpf63Yhb7hpE2Kv
 GCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775518939; x=1776123739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C3Lc6HMiLoq3fOrxhAfmM90ggy4edfwF+3FXKllorno=;
 b=CPgLpUp1eA+S96JsJFj7HNHyX9vLQ+R5dteWUr+q02R7mw2yXu5edE2NwLEt68DU/r
 dX1UT0isExQHjvs4lytkPociQlGJU7qoFDEYC6rpD+fLMEYyqAhOE5/ZhF6eeBJqPArH
 +d/9QT+LU93ZILw1h1r89icH2eCYwRGGvXF5v39rmkURKzayCyC8t9FZkcsMYglGjAuG
 /F5+pCf6vSpGVtqS0KWIUlu7k68b9AQm/pZKic2Y0wkNd89mf8s1WY7sd7q+BIh95F8B
 x8ilRLmdczmil26jN5PCG1+NC5zPSAYPBYD/dTWnd+hFEHn3gcEyx/nYXYzsCbVOg7fq
 jXjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMMIwdL2+7FJY3JCQkq66x+1Bon4f6PJBRMf6CHqSKRvIcQCOCYD/dNttTS59SMpxqGgCJlXlOAxU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOvx945Ie9AUO4QbRfrSk/f2bWc48w0OWn3EWLhB771JjxrHj0
 fHfRmOzkR+/fnkegOgM+Ba4tXBvnQI0KgxfSiryRKhSzK1+nEVBa1OTTn/PXyTd4T+V/AwM17Cb
 L3j5sqcpfifTL7pAeoZwNc+yAUbZb3fIdG8tJmbCfzQBTt402879T7R//CE1UDuPj/5LiGDo=
X-Gm-Gg: AeBDietLMZhxL9bymQ/NgkUHUQkm5vHSciCRMEZMZaPWGZ6ULBF4X3io4Muxe3nGd5p
 nVW7HY4xvWwr9oRxC1okpk7fJhrpTBe0mIkfWzOEID3xKf7f2nuiNbYFR1kEsetzgNn4pC68/ie
 Auj6bRWZ4iFV3hCsjD8SM30KHfbGOFunKHoN6BzdgUUg3ethkiSqX8iKIe6y/hY4U22Ik9mz26D
 lnBolsDWi8SBEmHuypKeTbvGYJJ7EDLFKumUuooGN8nyUKD5fNXzQTrctRd2Y7zdgKBaQ9h9qjz
 jkdyi3U3pDL/DrzycLDq/gH5i5d5vLeSTS0bwF9LLnlp+5BdvmS+TwwM3C//LObuF21zlw8SqhP
 bTMPXpv09tZRzhYhruu9qVZmZqol4DFU1ftcrTlnYV9EcZz09TOQoM6Om9obltG28qsTAGy4xfx
 AnOSDAmKLKvJlCIMe2WsFCVqyjmTxXocuGw7o=
X-Received: by 2002:a05:622a:1b86:b0:50b:4e60:93b7 with SMTP id
 d75a77b69052e-50d6d054b91mr200801251cf.43.1775518938794; 
 Mon, 06 Apr 2026 16:42:18 -0700 (PDT)
X-Received: by 2002:a05:622a:1b86:b0:50b:4e60:93b7 with SMTP id
 d75a77b69052e-50d6d054b91mr200801061cf.43.1775518938405; 
 Mon, 06 Apr 2026 16:42:18 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cd217c708sm33512011fa.39.2026.04.06.16.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 16:42:17 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/mdp5: drop single flush support
Date: Tue,  7 Apr 2026 02:42:10 +0300
Message-ID: <177551403364.616257.14558532661689430165.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325-mdp5-drop-single-flush-v1-1-862a38b4d2ec@oss.qualcomm.com>
References: <20260325-mdp5-drop-single-flush-v1-1-862a38b4d2ec@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: V0M-ZN_OzFQ8zvnT8MOAEb4Z7xTMEnNV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDIzMSBTYWx0ZWRfX1/AAGFqGEA8F
 uRdjxUb4McCtmgWX1eThw6RrlnHiHo6/cRjTwPEh+kOqm6bt2SKGDsEvniGycRIn0ko8CEk14bh
 Z062pxkMqd/gBWXXD5fIyB+pyyBeNWgwbSXyopt54/dWD4oRFX/wxYHmNrVp6LJudOflgkMzpYn
 f27HiAqSgkJCo9HqK70N8zaqkrb7D6j1RI8oTsD1GNTpxQACE1psG4QEawlc/qI0mWzNtOszSrE
 hAY8zS1akMv+HFJrT9KIJ/6XEFPF/nGwkv/RTXMekcy2u3m+vN3S5uuv0U0i3YZnqVeysob2W7z
 WIfyfj6BInlJC3ESLqbO8m70+3GyfBUpijd6dNv1GdNkaolA5/Q8QjBunlyZMCfWeRhzDgcburl
 i0mfNTjUlrNdMy2K7wbTHMnum2TaieYTmKBG842jlePMc04a5wzEBLWRZ8oO1bsl7fkraKWDFZ/
 NIV8s21V3LfRjFC57ng==
X-Authority-Analysis: v=2.4 cv=BKGDalQG c=1 sm=1 tr=0 ts=69d444db cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=e5mUnYsNAAAA:8
 a=oqX7KGtr0477KDneg_0A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: V0M-ZN_OzFQ8zvnT8MOAEb4Z7xTMEnNV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604060231
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

On Wed, 25 Mar 2026 04:59:02 +0200, Dmitry Baryshkov wrote:
> Support for using a single CTL for flushing both interfaces was not in
> use since the MDP5 driver dropped support for dual DSI configurations in
> the commit df3c7899946c ("drm/msm/mdp5: drop split display support").
> Having the MDP 3.x support migrated to the DPU driver the single CTL
> flush is applicable to the platforms suspproted by the MDP5 driver. Drop
> it alltogether.
> 
> [...]

Applied to msm-next, thanks!

[1/1] drm/msm/mdp5: drop single flush support
      https://gitlab.freedesktop.org/lumag/msm/-/commit/429ebd815bbc

Best regards,
-- 
With best wishes
Dmitry


