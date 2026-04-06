Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AB5FB5173
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 23:42:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0A2610E2FC;
	Mon,  6 Apr 2026 23:42:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GM4AGJwL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YX2BjnM/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D16DF10E2FC
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 23:42:29 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636LQK642549972
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Apr 2026 23:42:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HbZ3jksSPmGnNj+jFNKCK9ZaURVLc5iIZ5PBC5ncrtw=; b=GM4AGJwLldePcCTR
 Yxomw84YMCKzfC+D5pBQzRAGsDggWAUCXvyiRCvdSHDMSRSfdulCYTF+rcTSAa6K
 SytT5TzA4nTfJaHrw8kHTSIBRA2MHKq95IbvliBlnduhgx82M2e7s7z2f7khGWI5
 drll9XvNnc30u8iJeymdYw79/K47Ei6EoCIh+maLjnm6EgMvtyX3hh55kPiK7a3y
 lh1EvXL5SwodVnDQ7YQUONX39+pdZzo8BCgAnaIyfLPeYwj7IjEz4RiMmfbS8nLN
 GvQ+rJF4oHPTZ3VtSpqPw1NXih1FB5LDsHH+M7VDxaA2qdz1ZT0qsfWmt+U4P3Cv
 uUYdpg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmre88wm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 23:42:29 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d84b5f73bso28469031cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 16:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775518948; x=1776123748;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HbZ3jksSPmGnNj+jFNKCK9ZaURVLc5iIZ5PBC5ncrtw=;
 b=YX2BjnM/eDzJvLyl4VeMGeVlVBMFa9neXrRial0YSpuFLkAx2OTgzzLS+BL2Fc7mHL
 ovK3ha5ZBxTM/AwsBOvxgftXTIbkKLJ3EV3E+D+9G1a85SwP1RxmSuzV0Ma5IRcxkQvt
 6rOjiegjq7FqlXQfnFD/6lUqARj/GRWLg0Tic6V9ZNz26KfNZpKKQBmiMVOIJDnyvubY
 407kXZDLWPY3+vfeXRAX4E6ndqgfQWbmnMjtNmThzIHSGc/TdDeiW+ZjlsJcA8wSs7c8
 93eKaDglMNeVZZ9gen3YGSUQnLw6Ur1c/qLCegahJ6gRHw+nX1BdXvHFWNFVMepK/Oj/
 a2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775518948; x=1776123748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HbZ3jksSPmGnNj+jFNKCK9ZaURVLc5iIZ5PBC5ncrtw=;
 b=TJHesQVH3UwEGUUp4HxAm2k6eCivtPB80fSCU5/I2bke1FJpaeNxf4V1h/cpUFAAbH
 GJhbrdgGam4BSb5vp1JwvVARo1aowbmh70lD9K+xrlwpQwo44NHezPRXV4muGc6bbVFi
 23F7956vGkQ4CqbHCj3cT3VTlfCTH8Wuu98CFb7A5WCoXlQ3PPK0R/f1uon6A6r7nJdg
 5ne/7g77nG3qqKSVcUPkwjtXAKXfHrGxjNVDpJTb5eIax1AgR0VvYgNVEWp0AHoE4AO2
 oEh5BY+ZnKly7Nk07unm94deODPg0e6JnuSvmDQ488E2M1lb5DCEhktDUMp0KHkG3WUv
 VN2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU04oYKJN8gPDzGSi80ICm448pF+uXGTNBQYa2dNH2IfgkehwEXyCooAox5ejg5OVfkH4F1D42eBWQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyfSu/cJnZrTdgCvKZvO1b5epBrAWtlHsTVuvRPkWvqUgJjeHZD
 rN9ZgrK9MjVIhC0jaZFkv8ViEiDTCAzmsYQuqmX9F1BaMoiOaeKHKBG+6W6sZB9GYv+YfDwfCPi
 X61ou+G+CLZSGbcJf+pnmWz09h967pnzqAZpREcV96SUvUf5no0xMrOiA0Bjs5HVJdAZGU/k=
X-Gm-Gg: AeBDietmflB/6cm8C8MUtIGiz2pI0mEF+pn5g8stZSa6QY8l6aLMJTDc+rzD//SGlhz
 vJiLbMFht8UDDoPgafpZ6G1OGgkCQS9sm6xlLbvKHKztHxNNaB5A84NJhY95XgXb/izlJPElvOK
 zi3s2NR9Mr3iE3mEy6tPhoWDGpnWlSSwAqr5MXgIyljEUrO4PWaETZWV7qgt9AsVqKMkFd5+pJD
 qRTQ6KQMzh+nBdscNafQZ7pwj5R7wbxnG+xmhUz4b5MNxTSycyim3sbSyQaF4QvadfnaKZ6ii1c
 pmhmxKJsbGWTIrEHMuNkK+zmgedbITeLaUFVvSzPnsvMhbCtXlqQ1RvydNaHvl2GzGJZeIlOTJN
 k/e5OvHDWGoxLvhWoGy1xnDHeYLVFH0zxkL3Ire1Nsp5llLKacJiQ1oCn3yhx/DTBGmLBjZxeA1
 iVEYP/fwdO8BsgV/qRSA9reKsc2RjS4MLLv6M=
X-Received: by 2002:a05:622a:1993:b0:509:211e:3624 with SMTP id
 d75a77b69052e-50d6250047fmr224132091cf.4.1775518948397; 
 Mon, 06 Apr 2026 16:42:28 -0700 (PDT)
X-Received: by 2002:a05:622a:1993:b0:509:211e:3624 with SMTP id
 d75a77b69052e-50d6250047fmr224131811cf.4.1775518947973; 
 Mon, 06 Apr 2026 16:42:27 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cd217c708sm33512011fa.39.2026.04.06.16.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 16:42:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] drm/msm/dpu: eliza: Use Eliza-specific CWB array
Date: Tue,  7 Apr 2026 02:42:13 +0300
Message-ID: <177551403345.616257.3686766092798863142.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331161156.211623-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260331161156.211623-2-krzysztof.kozlowski@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OKEXGyaB c=1 sm=1 tr=0 ts=69d444e5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=e5mUnYsNAAAA:8
 a=vzji59FW9qLxD_cu0m8A:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: vc4R_tgImgoSwqJLqXYvAtMs5cBXWnd0
X-Proofpoint-ORIG-GUID: vc4R_tgImgoSwqJLqXYvAtMs5cBXWnd0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDIzMSBTYWx0ZWRfX3nmu9QRmObal
 wECnQUNX9frFgC09XCS79X5ZJVIudA4MrlbZnGbLHlF4ZOYtD3ZT5myZPg0bijaUcR8bF7knWNv
 NY58jNPdlx5PvX3C0wur4ZBpzxYnGJQ2a8a6yisUDyT2ZOorX6fy7wJOYTi0NJQg7QRCxmSXp9J
 dZqvuIN5b07Py1Wbc9bzjcmNv0DFtl7vAC0OB6TtZXgAA6WkI4McV1q+UC1t8Ar97Pemyj+rWkv
 /vRw4ywF4TVvJiPM1ZMvxG2EToDra+A/xVw7EHVYT2Rc0Ca3dWZ+rGXzTzzG2xs6xn95LWr2p16
 Nf/qekRsoNo4LuxjYwZDV/izBfIPypXehZnbjMmlw9YMAAnygD4bRmuYfbpuPPhIGQrLgTfgcHF
 AgeVdyTIaW2y0KxZh+fhZa1VJaeXiNqB4x0pkccfS6vup5vQMobkqaA5RvygaFSAOL/w+/9XzmF
 IpsT7l2iCU008tDrQSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
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

On Tue, 31 Mar 2026 18:11:57 +0200, Krzysztof Kozlowski wrote:
> The driver references CWB array from SM8650, but should use the Eliza
> specific, which has different register space sizes.  This should not
> have noticeable impact on function but is indeed confusing, since the
> Eliza table is used for .cwb_count.

Applied to msm-next, thanks!

[1/1] drm/msm/dpu: eliza: Use Eliza-specific CWB array
      https://gitlab.freedesktop.org/lumag/msm/-/commit/502455d8bef2

Best regards,
-- 
With best wishes
Dmitry


