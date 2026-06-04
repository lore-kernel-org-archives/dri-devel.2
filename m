Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F82CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:54:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7A6D1127F5;
	Thu,  4 Jun 2026 12:54:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nydNX8LJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ex7yfU6G";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF95611A011
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 12:54:34 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6548UFRF598074
 for <dri-devel@lists.freedesktop.org>; Thu, 4 Jun 2026 12:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=y1M+AD0HzgLHXiH1WXXCQCSg
 tLsSzH+qDPseKkIaoiE=; b=nydNX8LJLy0aABXqeGgQ/D/uwwN5k/oQ5EQpOyWA
 rHV0yg6xamAmp8Xiu7C/tWRX0AUPrPeVD5w2tzaJQ85lKH/jGZ3BOH4oD25DpxJU
 7xCkntxHLwbMQx0KDXdSeDVi6uPRq3ChwAzq3OAj8HcV7aNzQKipF/uFcHZt2um/
 1k5mguRhB2LaVYXGfhvv9jPK0C2Wi5L64R5wd/Bck+8FjsxCWT1wzjdi0MVF32SP
 dIvxb/7pLRmUjCZqOZKD56zUG9Y1IfTdVWUhSCcLh/lMf7d5Qo60Tu60lP6oH+st
 rmcwapviYznuh+b+4RgRwUU3uWEeszhkZHDtcFmMOza8DQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejy8m2dat-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 12:54:34 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-6751db2792dso345175137.3
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 05:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780577673; x=1781182473;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y1M+AD0HzgLHXiH1WXXCQCSgtLsSzH+qDPseKkIaoiE=;
 b=ex7yfU6G6xG/I0QwFtOG49ZWVGUy44SuX9tl4GN6FXyrwfHK4BLC63P19okQdKiBCS
 z/6ZqtlyXI6FJQxOmUDRz4Ewx0htYpGnwY7bc2lSbwU0MJ/9Vg68Lyr/PoNKwwn7h+Ad
 VK2mi6saMngjpM4IKHF/RSUZ4kzNiiWMwTHD4G9X7u1Z1sXcZM/fQiMEGZ54zmf17T8w
 xnt3kkq0BzREVt7KSKXohPuTeevPV/Imy59a+T5JAz2qIQIbD4JLAJLHTY+0Ask/VYJO
 UWqqrXRLnopaCdk3mBubHQUkbEOyxVJ8HSBtN06XlpSQMfbvA2c0C9g5bxr1ZM77qnX8
 UBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780577673; x=1781182473;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y1M+AD0HzgLHXiH1WXXCQCSgtLsSzH+qDPseKkIaoiE=;
 b=KnLesCI33//VBFxYzeeFuf/XNHiX9IH12hxybb5X96TJ5XMECHdqQ2VNwpE3xfGZgV
 S6jTESH3TQ2mLQ91wLArnSnRhxVjF4jWv7J6haE05bqfhaYVKQ4wKcWECcoa+02EMfl/
 lhxzfNmHSd7kHJzV8BcRfcXCcxlrCl+1WwGulLcO7wud+LP37umbPIL9qo0cLggsSvkG
 M5MCb3I7InqOYPgOTcMPs3xNWOzMGGLYs5Dg9ygwFF8CeMBnn4C6KhvBo6rBnL8Rnlm0
 3aQxRAOp2RHk1GT+E28UqUrjjQZy1tdag9MZBam16B3l4S+gyZPIzwvEL944ouyKwLe3
 hGFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/im0I1r1V78PtBw+OUO3kZ8jr2uDd9SdUNY70JmiHnbYmTu6mpEIh3DPZYuO5kMIJxFdFo8EBCGiw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUaYHfr2EzJthpB2AbL13aZn6oGwwiwDLVcIbsjnR6gEJ0ZIy+
 lw2X/2kBIsSjn+oc/5h2FPUu6SQfoTFmnPTSlbUV6BQbTRClUbX6wuZsY95Kpf3KR8k8Ooyl2fW
 8TS6PnA++tkDychr2Vl7hDP6V4vsYYx44hiXOsRtZFRPxw8Nz/A1QPMbKrWN+W2QydbLMnGU=
X-Gm-Gg: Acq92OGqrdaWjKdU4IQdaypiR2nMCbTzyF5crKegC4IwWEtxS+7PpFwImb17+kc7zbx
 oYKYkNKa+SlyyUqYPiB/oGrak66gploa1jJRuR57NlvnzIsYrZBA7CJHcMq3ooqel5EnTFPPnch
 wEPdYl72I2jfW4RBNIXVEewSApdG8NAIFbYaEFRvZVhmuDuy8tMld54+B873ot+0h9mNIa/sRAZ
 7PZrM2ch89QZBg7QUc5drwjr8bnBQyumeskcnWiZ6VCyV4+f38q08sr3lTiaQ2GutjgUQ/J1aS5
 Nns7wTBvMtPcWnu1tJBzHFvQ2n0RjGFFz1F8wTzksTVTZ4EWro5S7Kjwso0ydtljTYljD/T57rf
 diCJBejchgAq8yCS36hGVeXYS9Nq/ftn5vKjL8zOpmsf1srynKGtBocnBznc3J9WbN3sHdOMYOW
 eUXKNWeFHJBXWkPvITcr5SnDXHahA5aVZdEVo7/zarIjVIcQ==
X-Received: by 2002:a05:6102:554c:b0:6c3:1bcd:31dd with SMTP id
 ada2fe7eead31-6ec2a218ccemr4587384137.6.1780577673397; 
 Thu, 04 Jun 2026 05:54:33 -0700 (PDT)
X-Received: by 2002:a05:6102:554c:b0:6c3:1bcd:31dd with SMTP id
 ada2fe7eead31-6ec2a218ccemr4587359137.6.1780577672874; 
 Thu, 04 Jun 2026 05:54:32 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-396ac2ed9eesm16343671fa.40.2026.06.04.05.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 05:54:31 -0700 (PDT)
Date: Thu, 4 Jun 2026 15:54:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] arm64: defconfig: Enable ILI7807S DSI panel driver
Message-ID: <wn2tfhmskrlf6ewusqt3uv7xg62fl6h2qz4qz5dyf2az3vumxd@dhphx5seowr5>
References: <20260604-shikra-display-v2-0-b3c1b2b67edc@oss.qualcomm.com>
 <20260604-shikra-display-v2-2-b3c1b2b67edc@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604-shikra-display-v2-2-b3c1b2b67edc@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a21758a cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=oNl6jLlcSFQHEdJXP8oA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEyNCBTYWx0ZWRfX33HoUuVRpRWt
 Ejl+Gxk++XIRsCDcDm4gahLazDudSrndSJaFFL2DnQKg35YLHurck8UNgd1hpWLPNFNCv+Xg7bO
 gCiolgZFnjGtAWaJ4UEn9Bpk0zrR6XoS+sinmL0LN17twTgjzWar8yLcRFf5GNgcnOuovdE9luw
 SNhdRoRiAKEr4hyP47iEH72w+AgmXnQVnG5uVK/juQopAXCW/I3zKN9tzypNoWcyNa7N1MP/QSF
 qHBQhsRO09c+01G5InEczRI4+N2hYlD7f0NEgv9d9h2WCRIqNpbPWHw33RcaeUcgxNlaIzWhbng
 eDtGuPHL41OtZtkk0O4yuzIuYBfoQqugs3o0G+z3F+iwxmiMPFvCGZjCgJSkylxLu9P0TxcBBZy
 fjjnXsTAy8KRV3jphsCjwTxCiFpW25oIk7FO8lSMx1kn28bm8Et6f1nfpAn3ChCwhDVp6ivaSh9
 +f6XG6SGh7+rV/b2G1Q==
X-Proofpoint-GUID: KkjCRETLBQ5x9vm5VgBxtr9BFA14PO9W
X-Proofpoint-ORIG-GUID: KkjCRETLBQ5x9vm5VgBxtr9BFA14PO9W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040124
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

On Thu, Jun 04, 2026 at 06:00:48PM +0530, Nabige Aala wrote:
> Enable the ILI7807S 1080x1920 video-mode DSI panel driver as a module,
> used on the Shikra CQM EVK board.
> 
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 

Move it to the series adding corresponding panel driver.

-- 
With best wishes
Dmitry
