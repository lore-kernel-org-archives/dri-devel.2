Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98BAC43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 23:46:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1190010E2A3;
	Sun, 12 Jul 2026 23:46:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="B5kYly1o";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OYrR77Un";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BCD710E2A3
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 23:46:54 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CNWEAn3963999
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 23:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JYV1vviYmvv18rlHbpJk8khcLhfX/RfZkk0vj4YXymk=; b=B5kYly1otcGPDCYb
 8q7zTMc8iglLa6qIZzyq0FTbqvDGRoThhUCgzX2IbYCnWMaZTu0/fOXLUVZhw8Wx
 Upy7BoOdu6dTgbEEWcujNgoPFl1UiRmXlB1uO4XyVVyU/Gf2HDzmHYtMqjVqa0I9
 JbC+98CTnFA+lcphysAsmKlBDkJaHaqRxBhb7zZo4fWYqOlGPouag2bAD8F8nU9v
 noXF296oGLIqzffKCiuNl7ExY4aLakK3QHSyZ92NdGiYMYMGmsy7r4re+9lA5wGG
 1CbhWyN3JTC11GyOs7MxVYL2OdnGjkMsIspp1aKBhIw26ZqZjSBYIXYXC0fbU6gG
 h2iieQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjnm060j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 23:46:53 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-90284139cceso26092566d6.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 16:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783900013; x=1784504813;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JYV1vviYmvv18rlHbpJk8khcLhfX/RfZkk0vj4YXymk=;
 b=OYrR77UnG+lS+xRuOQB/mjSgkBo+BWUohBhd7vNiTvyy2h0M1/Dieb2QeAbB/CnxJv
 yz9+/yewBm3nkbRK1bHgBmMpvmaaSwIi6qs+5FDx0xHOg86+s1ev6LdIcLit3ofJwG3g
 eRl+MvzbTezTfM+IpevkaN5w7Chba0/820dGjKN7Hw1N2ygzXfhXATlwfEGdqSNJFvOO
 q0+OiwIMIT/uVNWBreDh3GStCqImqhr49hAjH+i2YpecGJg2gc+GCSiqbfWMOfdaxKLE
 w4ToyNyS2E1K6XNGHLLXuO8qEGGjIJFNJe1hgawVb3VZVEGXhZ0SW8UKB9840tzjNlNK
 Fo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783900013; x=1784504813;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JYV1vviYmvv18rlHbpJk8khcLhfX/RfZkk0vj4YXymk=;
 b=lQwWm6IbK6ikWuWfMTVdo0s+jcbS98sSgCF593JWkUdNHm8qlG+XpeXt4iaEVGdeY1
 Sbl8Agc6RwPLG08TkUC4ApLTchwb9V8AF4kc9E3qYYgtnnmi8bwabuU9/VP4aZgZFvgK
 /hciuMY1QF6lp/7Xd0so78FZZffe/olezDL7p4YUKg34UAo8owHUb7mpcLCGe8F1BQQF
 PkM909LLOXXfIyIPATkt6jtaNLZuKpI8Fn2MBK4me4euels2p6VyOTsuZNUBQN6cvhxI
 P+85xEeHNPs8rrmOha85Cr8JHD+T0dnDAH5Tklal4D6mLkoWdZ2ayLETvogQApJYP6QE
 5fdA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrXBefsRHeKySuOvAhw0iEVvAoY/ej35EfWAaE8+qdKxcgmfmaW35TdrJZTcN5R5xic2LCw+3rlg0s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyNPB6Zjk+m1Iieg2yUtlBaI/Fxz5GcfrXWm9vkzQqZNmLU0syN
 k59oScE5iHvofyl4qa0tcjq4McAsxBgVwcBFpKaCrIoSt0TphFgapRH+GTilv2VtGNYNepf1Ee9
 OUtcUojp+lWzjzrxGULmq52TA5By+qNf6/gNLJA+EJY6tEb/l3yMb3rAlDMyxN3ULAwS7l1s=
X-Gm-Gg: AfdE7cm1Gafc9CBgE9r27hkRWWhae4/SHGJwh9y++9tw6QLGRpPq9s8w719X4MWNK4A
 5mVDeM22uz0cSrH7s3oRFiS3FJAnS2YfNGxMnysBPtEU3uS4Hj+CXes9jqpKUSd93Qp5Fg1W2DT
 CXCQ1As+TgrUMuaoyz79YB4/gK0UgreGZViZEwxzMPSd5HxJ8kM8uOKBMyOqaOkrP14FO92W+6h
 K4eUEJFGat/L+u5HUcevXMHUmdTblAKBqKnm8lcfy66+yn4tTAk1FHCAQaXMPaao3S7Tz/GL52G
 CgQsqx459FMIlqNEX/UKuwAFkJlAX4LRMuYx6Rz3zJi4bL1ECkwZIPybHiwc+5YenleX5/2JSrM
 amg/7SYH8L+IiDCamVReyzID8bs0lgNpGQjN8ytmJdZ1UtKlaNGsPsYqH8x1NxCJpX21lPNiG99
 7QHVfjNNfDYNb0kpe7zpxeRLyE
X-Received: by 2002:a05:622a:4089:b0:51c:8556:55f0 with SMTP id
 d75a77b69052e-51caa173e38mr122326761cf.34.1783900012667; 
 Sun, 12 Jul 2026 16:46:52 -0700 (PDT)
X-Received: by 2002:a05:622a:4089:b0:51c:8556:55f0 with SMTP id
 d75a77b69052e-51caa173e38mr122326611cf.34.1783900012272; 
 Sun, 12 Jul 2026 16:46:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b01caaf40esm2371357e87.71.2026.07.12.16.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 16:46:49 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: quic_abhinavk@quicinc.com, Rob Clark <robin.clark@oss.qualcomm.com>,
 Kavan Smith <kavansmith82@gmail.com>
Cc: sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
 simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v2] drm/msm/dsi: round 6G byte clock rate to the
 PLL-achievable value
Date: Mon, 13 Jul 2026 02:46:40 +0300
Message-ID: <178389962794.1434604.86942707756896992.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707013240.681012-1-kavansmith82@gmail.com>
References: <20260707013240.681012-1-kavansmith82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CamuYU4GLD1brp2qjmcbYsRr1jYYRx4u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDI1NyBTYWx0ZWRfX/DH5xN5kPb1x
 zeaM71NU1VqpufKikP/PUodc0buV2VjWUGlfr5snKcei4eq5FriocHtadIJrljaxyF0oF4FrHSH
 LOPv9vT6Ysy7zu1XW1GE5kfAJ5Zk5R4MTGlgDfBOH/a1AQDhfIVzUScU1/wBPEK5OtgnOJujmI8
 uLj9bCIEMg6egNfZZdJTnQLpoyqxypuyO+MLxOvDfnEQzx2EEFt60H4Z2AqVdJa9i+0nNO6kEj7
 o8XW7/CeSWNg1dvKlDoLG6K/5xuPBHq7LCqqjG28K69B8ZZpzJWU+BU8kmUXx/DsslyfWUJQsS2
 5Y7T1Rf17ejHG2MpU36NKEuk/d/VjuwWJPJU8UUoVKJy7SNBoea2XGa0JkCeGIgsf0TOvmTpirq
 wXD0H8JHNvsVmlrtk/0H90fQNRI4xxuQ+hUFAQ3G9Frnn+GbSskEqQVbc3m/J//eebQYjV2/Uhk
 6UZsz5cVeBEbAC04FEQ==
X-Proofpoint-GUID: CamuYU4GLD1brp2qjmcbYsRr1jYYRx4u
X-Authority-Analysis: v=2.4 cv=AfmB2XXG c=1 sm=1 tr=0 ts=6a54276d cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=e5mUnYsNAAAA:8
 a=TRR5xVq1x4uEjgd2TI8A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDI1NyBTYWx0ZWRfX1OjpNDDg31vk
 h15ssmU/azecA5GgzT7sCCvb5qxjur1BwcwX31vIxWTPsZzXpTH1BguuX1xL4hTTScVQjaHny6y
 srp1/IkN6d0cJ5ABf+pXR9aR3RW2gwU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_08,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607120257
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

On Mon, 06 Jul 2026 18:32:40 -0700, Kavan Smith wrote:
> MSM8916 runtime DSI commands still go through
> msm_dsi_host_xfer_prepare(), which re-applies the link clock rate before
> enabling the link clocks. That is fine in principle, but on DSI 6G the
> requested byte clock rate often does not exactly match the DSI PHY PLL's
> realizable rate. For example, the driver can request 56250000 Hz while the
> PLL actually runs at 56246337 Hz.
> 
> [...]

Applied to msm-fixes, thanks!

[1/1] drm/msm/dsi: round 6G byte clock rate to the PLL-achievable value
      https://gitlab.freedesktop.org/lumag/msm/-/commit/6cd33b6f4155

Best regards,
-- 
With best wishes
Dmitry


