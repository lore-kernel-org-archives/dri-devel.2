Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFE9CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 12:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59BAF10E32D;
	Fri,  8 May 2026 12:06:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="l9hLCzpG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bB9XIjAV";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EE2010E32D
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 12:06:06 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64872SoH1061973
 for <dri-devel@lists.freedesktop.org>; Fri, 8 May 2026 12:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JsPeSJpm1Gzish10iQDoB6ixGKak2ISCVny4R91SuMQ=; b=l9hLCzpGgu1zwdIX
 qsB74BixolXE7boA2iDrwC8eYiisxS/Y/SVd2F+Sd6akxBp0m76VV/kZJ+mxYh1z
 TIrRe18p5woVU9Y3Sy8PZ1IXs1Nhi0R+X/JT+cN1ocfiSkghDocXQvJ1xZtus2ia
 bUo4ZI+GTeVpY/ssOa4qCbP8H5bi8lrMxWLilOSsY2iYAm5O6ewO9SoFI0kKXXi9
 5PgldEpFZ4Al8PKPeGUFD1SHthsdZxSD7cnLCwu4mzr+4l9s6cWeWMHWReyXxh7M
 chBsnFrt9abEA7+4VIlLeTP5KqM8L1fHs5QtA7vQRTmu7PPmyZs5I8QCu5Qpou05
 aXG9uw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1b3fh434-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 12:06:05 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-95d2da54a55so1106906241.2
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 05:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778241965; x=1778846765;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JsPeSJpm1Gzish10iQDoB6ixGKak2ISCVny4R91SuMQ=;
 b=bB9XIjAVA3SQuIoPc3k/LzIZ2iBdIMOfQX4/NuEHHGo/3CtqHGd3+Y//CiHib2a7IW
 rmKFnusSeqSNgKywYkpuSUQyM5XFdiKJBirSo4Il7Zw+z0P/C5loTZ2+TkAdbihqcKUq
 IurvCwfrRQsyW10NdJ7Sgsf2AKgH3bHMRZk03wO+GwAI6AiTBy4KLGrXr3Hkv5j8MahS
 /tJNeEvOEbJ4NdWTRUEShI4Nq3IkMb2NiNFtfRGiN41d1FyNa7ICwuafGvI6z+bgrxVO
 YmXuP9E0uR3mWZlTg/veIyIdX/h/whapCvlrXyX2gGry5vH1tO1j/XgMDIBqEwvphwId
 DWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778241965; x=1778846765;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JsPeSJpm1Gzish10iQDoB6ixGKak2ISCVny4R91SuMQ=;
 b=bo2bcVARTAK9z2G++9/puvRn37MyIKGdDUuff+4XB2RLII2lHIPj1V6f/Hm/MIXT/x
 4uSNPFTCsli4Oe6SinlccEOFnaW9fButNPPRpAiYXedfLqfdWu1XsaeeG4WEnd0m/A9H
 z0wqPWeztKUGfDTNNrfT3gMU9g+KLDClBMOC7amEhXZ4iZdoXU8Gys7d6cgC3adTwCMs
 XIRhdXFYIgdtP/SQ2cdqD2v6XZo2g4qnp+/FMASc3QPxNVYQ+bWKcp/d93bJAbPyS3Hk
 V5HKWXsBZk2UYXEh+s4qaPIgbdY8c+1fu143rrWZxkgeaHMpKWNmxbin6CCvzTbrVY2y
 oiDQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+caMbDYL8SWZHsDLX2oVcNk0E3vn0UBsjsVOYQ6SHIh0QZAnZTpCeXhUElvFYF++jTo4gGTP2CVDM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCrLi3+WUMIAikxiBnj/9Jo+Vctd18F55lMJcI9ueElculvyHp
 j7/cuAZyKZnQBFI8hhFusIvIjVh6sC6oOfb4qhgOtzJ4lCJlEt51Pv6gj3HwFWXivfszssSs4qJ
 0+Bt3MCbtCohf1nRM+z3aBFATqWb/l3/+KrlbjXIBeY+oOV6pdQQVzMeJYA3h0/SffB+6Ebg=
X-Gm-Gg: Acq92OHZwMgAYrn9yBvGZU32eUlJnt1P/4RIe0UTtfacDTfk5zvMXg5TcqNlPSRNZGr
 Vsdq0G+Ou0K1KRS+LXFumeVctpsYgQpCdbR8S+Svqem8f2E9nmrcYoMG8M2MyWjhM5fleUbNVL2
 8NSMoCVRF2Di0VekzwHqvhTX6EhC65SFbf3nCaWOuqD6cXYMLgGqSwQbAEEnI+0iIlj18oLMHGr
 tlBwhgfAXvEQrqIl8OqYqNgbL+8pCBK1gS5q8AtohYxRIm9zEETPeejNM9sqxeU8350BuTCBHu6
 hG7sXaknuOMA2S9I0i5OI2HJSHx/8xMGAa4ePVPyJ8mNydnDZRTWlkFS7DohizCM1izw3IKZP9L
 5rdB4cHq035VpgVutjaypHyMiyDGhzOvIh6Z83J8qF4ytyxJ4K1h+Po2vzBqPvQmikTbsoQuFlu
 NGLV6EwZN1rmOd2aPfnXshxqSeVh21wPB3rR0=
X-Received: by 2002:a05:6102:4b19:b0:62f:4349:ce2b with SMTP id
 ada2fe7eead31-6313eb7fb77mr800486137.30.1778241964941; 
 Fri, 08 May 2026 05:06:04 -0700 (PDT)
X-Received: by 2002:a05:6102:4b19:b0:62f:4349:ce2b with SMTP id
 ada2fe7eead31-6313eb7fb77mr800403137.30.1778241964433; 
 Fri, 08 May 2026 05:06:04 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393f6131c08sm4477931fa.30.2026.05.08.05.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 05:06:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: devicetree@vger.kernel.org, Marek Vasut <marex@nabladev.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Herring <robh@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260407203109.34302-1-marex@nabladev.com>
References: <20260407203109.34302-1-marex@nabladev.com>
Subject: Re: [PATCH v2] dt-bindings: display: bridge: lt9211: Require
 data-lanes on DSI input ports
Message-Id: <177824196296.236860.8799112140087444595.b4-ty@b4>
Date: Fri, 08 May 2026 15:06:02 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
X-Proofpoint-GUID: uNwarbzyM8cw_Ymka5t4HiIuU1LeKUAz
X-Authority-Analysis: v=2.4 cv=YMOvDxGx c=1 sm=1 tr=0 ts=69fdd1ae cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=YpGkoaE24zJHBMRrs6oA:9
 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: uNwarbzyM8cw_Ymka5t4HiIuU1LeKUAz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEyNiBTYWx0ZWRfX9VNR3MlyUDp7
 64itbDE0zYd8k62SOS/BaxJ685bdaAj1hsMyopJJ1Itp2uArEKy25B+D+z2KFslPDdy4cOvgZKW
 j6pICZopNTCoC/2YHsNUpApV9Hy0IQH4oJE0AEHxcn3rXvPcV8H6HpHKxG4iU8ljvUm/pvMnnfY
 CKiXK9B34ZWe/umWoKDuOT4loGbTW3MNfmmo8v00FjMtHaZ5uDSCqV1M+NG+aBiLkk7bvPmX8KE
 OVEMux8SIOX9GRLaeMRIPPBmaV/xfTr9RJyqXAv/mQcaAG1IsT4tfBrilRmSh9AZ2BM9a9h6Xho
 AQH/Qwnmvi87QoPw1atCumxUfQYQS/QUJjy5F4xd2NJ8Sn6o6u8s9Mc8paYCBwCzgY+JTYOGbM4
 UPHQyO2bGf1diQdx98AsHEuczjTzfBuOh/xqpN88mCME13ZZ9Rch5rRHi/IAQKAHcoV/ojlUBw5
 43Alf0jXKACVH2OgkOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080126
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

On Tue, 07 Apr 2026 22:31:03 +0200, Marek Vasut wrote:
> The Lontium LT9211 is capable of 1..4 DSI lanes per input DSI port,
> describe the lane count for each input port in the schema.
> 
> For example Linux kernel driver does already use that information and
> fails to probe if it is missing.
> 
> 
> [...]

Applied to drm-misc-next, thanks!

[1/1] dt-bindings: display: bridge: lt9211: Require data-lanes on DSI input ports
      commit: c2738d88b624a977e42a1734fad4b15993ac354a

Best regards,
-- 
With best wishes
Dmitry


