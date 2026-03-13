Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7796D105F7AF
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:30:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0C8110E048;
	Fri, 13 Mar 2026 14:30:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DcI+0Bbx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kq6y122V";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9761210E048
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 14:30:01 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DAmp2l2390203
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 14:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=5bxFQeCPd7k8jJvVFFFJLioU
 dLVXiU/NXmy4eQvQlxY=; b=DcI+0Bbx7x+WZjWfzXUPb53/dAIa28T2uWZcMvOG
 +6jcPI/GyrJUOBTgZtbguhbpy3xxiICBp/x1MdPFl7NViU38r/KhH6c1z7Gpmzqg
 jNNnLvHseDglh55A+EHsmJz1lBAZRkZvEDG115dIm115Q/TAGobWzP+t6/INxleT
 xFIPeSxbY1+Y4Cf7kql/jLvPiaGupVuHE+2uY9LCDUgVtP/4Ja3Ef3W2iRZRvPLd
 czf9NZJavbW6fJoVuYM1RxWz5QAf15oay0M6RD7C7Q6zrhhPZ0GLJmr7DtzKlpLe
 CYFJ0V+ZsvWwan7cZbAKpsoB9pw1Zh+ZXF07FetNG9rlxA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvh5m8pk3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 14:30:00 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-94e4b6c8cd5so3909567241.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 07:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773412200; x=1774017000;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5bxFQeCPd7k8jJvVFFFJLioUdLVXiU/NXmy4eQvQlxY=;
 b=kq6y122VRwrWw+T/EtdOaYLInbhPhRjwKIXADtb20iqEZ3mfdTIP+qNVKbi4qMk3yV
 PJWe/ylwz3q4zHk2BuJTkdUXK5+g4jtdVJkeVgFhtpp16wtneq7cUUzaTwybhe4n+Avu
 LZ7MV7pLK1Lxy8nGcylZeOKsG1snoADGbnO3QKeg/nbiCb/nz52Ql4W6Cs3R8jqhkR7F
 JobtPn3T2JNFyu1t8RB7NGQbgBtGju8HfLcdLG8TaFiTn9/mOHfnbjtlh1/2MhXEyt7Y
 agIm/SY8O1wQtyiCNBxOdkcwhDlQgU3d/Jnpgj7laNacbu0/NoHMmyq2RYr5/b8yUXlN
 kNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773412200; x=1774017000;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5bxFQeCPd7k8jJvVFFFJLioUdLVXiU/NXmy4eQvQlxY=;
 b=j3VyliIp/4p9YuR9GfDOMHbRTjSur7tfeKIMdAIBaxTQzmmHXcmjacgTM7wvmVNI00
 tGq50QsrHtgS208z0CAEmkGHYyAaZ+ErBg/Jw3LnllycqBRX/ggeWG8rFD0PKLeKE7kd
 TSuP/EexZvNYHKEBRQMJCfM4pCr4EScYWAs+qsa2CzT6pIVoE+qFoQlgIKAghMu9zqol
 +zpa+cOZqvSu/QwpRx4AWD4Zhx+yRcZ4/H2pNqkewWjqMMak1MRNmQX7LBn7G+2rUx80
 uc9ac45MXyeQb5C0VlVhNhEcTP9ta4suMrrMGicX1+RqoV/HtKpU149hNOShLXvRN6/w
 0Hqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfqXxLHO56tcDeJG3dZHtpxHZXRy/+6nG/ZCtUkCpEtECeqehK/u5EYB3g/Zk5VYZuzPK6qM5WHos=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzAaqOicyTIVXZtHBQAosqkAhY7zHLe/GJMqkW0CeOMJd95m6ln
 +I6vkZYVzsJzOkYmPRU7bC+66Qs/BUhKCcrGl0obgeTdE4cD9rX2xFqrX0JeZka2KdfZTzfn5gT
 RkPrprI2LI/SDM5d2V8GGY1pM9vxGxKkcSx9Uw0RY0x9OKFrm+zGCZxlEt8+/RfevfQ39IqU=
X-Gm-Gg: ATEYQzyQPP7zJarRw970LviDQzaGEkPFbPsBbCaQCayZV7Vu7W2JJwrCnj2zGKxBfgj
 o0fPi9P2SfFpSxMSY4mUXY6NcXq9h8K9mdaA+/EOtpzTnDO1YlBRlihjdtg/ZKfa4PISSHZV955
 3zdsv8ja13h7hf0Hg6uAVwRq8mP37K1OFA/F4HYF6MrXr86MkdKaVTe5J6HIB7JfmgC2Q2+fDC+
 EtUC3LhpXHCxd2hPzl+xSa8ES2dTmnpzOOMY4xi20C845Bmhl7fzCRozNewpRwezfe2glmohKGU
 PlWoCAaVNkDYcK95vUN8LcpS09JCBv4BgTw79KWuUcaELAPDRSpoPsWYZ5QKxkA8uBvKr2fv0Kh
 tSQLPfPjGFCBxALbcvIMMjjxNUnpMOlhZ5k8BybgcPPRWFqm1kpVQ5FNsR/YKDf7Pgs4j1kf7ES
 Y0s0z+xiC0STiaiq0t/W+gCZ7S05vCQdsyZIg=
X-Received: by 2002:a05:6102:510f:b0:5ff:be25:8937 with SMTP id
 ada2fe7eead31-6020e6233d1mr1360028137.31.1773412199955; 
 Fri, 13 Mar 2026 07:29:59 -0700 (PDT)
X-Received: by 2002:a05:6102:510f:b0:5ff:be25:8937 with SMTP id
 ada2fe7eead31-6020e6233d1mr1360012137.31.1773412199436; 
 Fri, 13 Mar 2026 07:29:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38a67e5ecedsm14686921fa.21.2026.03.13.07.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 07:29:57 -0700 (PDT)
Date: Fri, 13 Mar 2026 16:29:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 24/27] soc: qcom: ubwc: drop macrotile_mode from the
 database
Message-ID: <knrwkgsq7fp46y2yy7ub5l4zqwrhpmsky3khvtltsvdxsemjn5@t3re4gxcnbkc>
References: <20260312-ubwc-rework-v3-0-b7e8f800176a@oss.qualcomm.com>
 <20260312-ubwc-rework-v3-24-b7e8f800176a@oss.qualcomm.com>
 <52bd0410-5009-45c8-bfdc-b493e2f60610@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52bd0410-5009-45c8-bfdc-b493e2f60610@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: HipxYsi9Qa9vp9proKShNXRpSt-GXDez
X-Proofpoint-GUID: HipxYsi9Qa9vp9proKShNXRpSt-GXDez
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDExNSBTYWx0ZWRfX3FWe0zZWtkMd
 h2KVRVWC19pzevcMgdC0r3GSrxOHGUw338ttHLcfjEN25OrOEiTtuRDm5QpnsvZ5lwYoqHb04Xt
 2HvY16SJkXFYFewNzEjQQ+1g+zPFjpR0K/SpANlQoiwvyOZfoYTiQeeVw2rxKs7OP2wiQIjbn72
 kd+NMPaoF+IDEXLHhFjAINQ5nwzQN1c5yvIvJAm4yC8EJ87ssarYNaq5DYqPMMpoIYrWOo6AUeU
 +EYwO/R/KIE6p4KkJHpOJANVA8dVLo5CPzpVGMZlouTSEhS2+sjiRITjcnoeQvKd2dxTExkEj3b
 jsogu4VIUUqaQaZRCZThug5Pldah/r7D9awPX91ZivhY3399JWE1pLt6kOBnuhRQdXfzhVG2F4Y
 eSsTHSBsEzz+sQ4MDW9LJoQ/zfaYPDgir85gh1j9lQuHOtJ8cDhNnnbghttFZWwVu7XlEuoRjjb
 hdtOfxPxdEYggLhU7vg==
X-Authority-Analysis: v=2.4 cv=S6TUAYsP c=1 sm=1 tr=0 ts=69b41f68 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=TemcLLIvp6Dw_u3LJh8A:9 a=CjuIK1q_8ugA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130115
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

On Fri, Mar 13, 2026 at 11:28:26AM +0100, Konrad Dybcio wrote:
> On 3/12/26 2:29 PM, Dmitry Baryshkov wrote:
> > All the users have been migrated to using qcom_ubwc_macrotile_mode()
> > instead of reading the raw value from the config structure. Drop the
> > field from struct qcom_ubwc_cfg_data and replace it with the calculated
> > value. Split single UBWC_3_0 into UBWC_3_0 (no macrotile mode) and
> > UBWC_3_1 (with macrotile mode).
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> 
> [...]
> 
> >  static const struct qcom_ubwc_cfg_data sar2130p_data = {
> > -	.ubwc_enc_version = UBWC_3_0, /* 4.0.2 in hw */
> 
> Is it referring to the values reported by MDSS (4.0.2 enc, 4.3.1
> dec)? FWIW the other doc only mentions UBWC3 for the platform..

Yes. The code (and the database) has its roots in the msm_mdss.c, which
had that comment. Other blocks on SAR2130P might have different UBWC
support levels, leading to UWBC 3.0 (3.1) as a common denominator.

-- 
With best wishes
Dmitry
