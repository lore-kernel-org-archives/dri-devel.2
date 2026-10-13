Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3219CC6B08
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1249C10F5E7;
	Tue, 13 Oct 2026 08:44:52 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDBFD10E04C
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:44:40 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D7OWBs015212
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=faK0bJ0sX0dcSnwboayq3MHZ
 Icr4uJu+BKG/etclmFg=; b=caCpwNn8oseMurXZLBRWMTz+TrmZik63MloQIBVZ
 V0h4K9VIGhkoKvsbacEkmw7TJ1RkBwE9tQ6rrlzbJte9vYAS3WFF8ufNY8rFH7zj
 MoaOQUTo6j5yAcaDh4HGM3IKZTbaBbCKmvAJjwbIk5R6JxnXy8VH9C2DB+mSTU10
 NBZ31VUZGd9PGL2Bhl59k3CPWx1hL4xep3M7aEhbJ8OObdNYAbHJVZtJH43tT+Fr
 TQ/TKZWW/lOsLgK4PVOOM0UtI+a/mGrAnfSuKWJ6KU5mFm0D41FScpZLgpA6Jsi2
 GR9ISiy+w5ZPeXUPuNj7ZYpV2pxDfYPBUQ3oo2TsZwMJVQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9g7ugaf7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:44:40 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9308eafb465so759156485a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 01:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791881079; x=1792485879;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=faK0bJ0sX0dcSnwboayq3MHZIcr4uJu+BKG/etclmFg=;
 b=S+RqZ4z6XMcWRilnE/K6vPEoP/udwixEiWAYg9aOosK9Vm8DpKyba5Azg3k4KGFPV4
 NmhzOpEVXdeA8xoLP0++nx8LgHMwn+UOgI5XoTL2eHQlxPiyS2rzGhbORiCr4PhGvPk6
 S6GZbweXOEcohFL3HtlYcCYBemF+BxNeW9jW3KzLv5DDSJHRYc8aAf7nyWJT9Qu2maFb
 +wrnSzxE34xYUDcU5xGnzbqFQpMl75STWiweZlil3ctjxndpeyEG3ljujMx96ac5TYIc
 KKQshhA1yOXH10XADX1r1UQLsm5ng8hb2PofOIpZiEDUw2mhZNZRg8/Gmv/ZFpwNv2zU
 8URg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791881079; x=1792485879;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=faK0bJ0sX0dcSnwboayq3MHZIcr4uJu+BKG/etclmFg=;
 b=2gV0fq/tfyCEOOnsGctfZBra8OFxR8OcvgeptcYsToqj9rCQAcZZ7bIK7QEF2ATtUy
 AgjluKArs2OhyYDbjrZG5Zv3g7gw65AHw6zd4sUttgdNNPa4d9tSuQlxwRm5gyBBlRYE
 gYGjUiKQtao2e9sbJWrbVoqX6X4Gl1E/1bSexuBz/beFH4nSAlg13i1C36nsj5GUxbEN
 +Sa09+fvOIlG51+ewLwRPeDpBQ8RgbdAolLgnr/YZ+tF7zzA3GtbjRTa+X9Ky2mpUvt+
 C1qWbrYTBUgyZnpx9hgRVr2jbgVQRtVX46Hf+3FTgHOAM6X76QtTwnNaUpfqexFSGGnV
 afhQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByVpxvprktZ7W0oRfYWnToLYWQ6iPI5yWoyQwzWWQnxgGNs862TXkfmhpDKdcLfLmdvwvWVdBEfbMs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIPcrM/VuHdT7chMR/vV+j4ppAPlsOunLZKc1V/qdAPcjEmFyr9
 gDtd8phCBbrdXu1dHN1Akne0uqwe0ZdQYbk33ic8+Lpc7jZirm9MhIcrFGAE8moRS1qC0I4FEEX
 sJ6gmIe5Rc2YLZp5hRD8GdFgd+MuroClPF0Uu86gv6qNfXkhZO84PavKKIulyjlbp639rPuU=
X-Gm-Gg: AYBFou1XN/JX3e45Gfj+NJMdXPkrGgx+w5g4kmVL1K4fUF/38aIfAsd5x17GOwsxXkk
 VOcE4YqJqNcjPwsijlA9EWIigMayNuyPxYg3zqFxoqRwOhc5FvAP0iM4Yp5dV+yxykWwhU8hx+v
 o9QdDj5mynjCIV7gGSzXtGYx+s7r2WRRL9qyM4Qg38cwJkrYbi8C69S7yo0ECeQF4dy3TbB2PDU
 Slbmlc7UP6yCw/zmer5t1tFBBD/3fTnpm0VE0UrXznNPSFXalWX3HzNWyCmK4h76Lp3QVwpRSQv
 slV5aBoDn1J77FKYObAs6aiBOLPODnKrmvEJPFl56aIzg+NxzfKW1YOx1I2LP2JNcXRf5Ok+zl5
 LwGElZEFYk0vuTN8=
X-Received: by 2002:a05:620a:4507:b0:93e:c12c:fbbb with SMTP id
 af79cd13be357-93ec12d05d1mr1863344685a.72.1791881079163; 
 Tue, 13 Oct 2026 01:44:39 -0700 (PDT)
X-Received: by 2002:a05:620a:4507:b0:93e:c12c:fbbb with SMTP id
 af79cd13be357-93ec12d05d1mr1863342285a.72.1791881078606; 
 Tue, 13 Oct 2026 01:44:38 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.215])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18beacd2csm380055145e9.14.2026.10.13.01.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:44:37 -0700 (PDT)
Date: Tue, 13 Oct 2026 11:44:35 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Subject: Re: [PATCH v2 09/13] phy: qcom: edp: Add Nord voltage-swing and
 pre-emphasis tables
Message-ID: <qihez76tvkqvq4axyqmqyig73bdds4cuuxhzzv3smlztu32gje@q3r7o2uuqkw2>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
 <20261012-nord-drv-dt-v2-9-a2ab9af954d2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-nord-drv-dt-v2-9-a2ab9af954d2@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNCBTYWx0ZWRfXzHwGa2gBq/01
 0KytvAcj0+0HVnE4fMRpvEL0t0hC+F0gyQI3qXtdCdWSyLl9oB12iXktor4xg61y0xHnAaops8j
 51bKrYRN2jPC7mZwNkF1RglKe6jbijwYpdzUuUyKR4zFvtu30gZbZBYFZSUIlJNUBtME2r0qhYa
 skAotn3FyEzQW8ASxTB1+jWbe7XJ/6zVgpmMGpqGoaeHxLkDcWSgzjetSqor+ubqPC1RPkRZAEf
 b9Pcm1I8ayvyaKBSk91ucetETOBs5t18wmk7qVH94h8ReXaEJMqpcxHnSktWELbSG9o9Qm6Bkb+
 awp1fIFku01GA8EDJzIdJ31izDUqTb1o9C9MQbZnhly9Xid2SOZcFcboexNQhsEYAKj2JX8SA3G
 FVaIGtCjRa0x59CaF+MX95elA5Roh6NhFCvs7H5G3CfNutYpAejT2UgRGwKC9LUbUZAISDqL3BV
 lw9o4yzEbGjW1x8DmgA==
X-Authority-Analysis: v=2.4 cv=Z495j3RA c=1 sm=1 tr=0 ts=6acdef78 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Rt3kCFFBWhWisHNmluDamg==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=4S7jAy6oAwHpvZ4QFX4A:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: fxiDURDs49aHWPyCT6Puet0-txgGX01L
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNCBTYWx0ZWRfX91eXd6U1fcef
 iRM++2h0pmHRVEkAYKw/qBkVZK0DqnjuqXd+uJblu+IkYlOeppNGsapeEBk90x7Jzyjb0rbLB5p
 NlxxRyibUx1rCXHRStYrq73NnkZJG0s=
X-Proofpoint-GUID: fxiDURDs49aHWPyCT6Puet0-txgGX01L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130034
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

On 26-10-12 19:02:19, Nabige Aala wrote:
> From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> 
> Nord requires different TX voltage-swing and pre-emphasis levels for
> both eDP and DP modes.  Add four pairs of 4x4 tables covering
> RBR/HBR and HBR2/HBR3 for each mode, sourced from HPG Tables 2-2,
> 2-4, 2-6-a and 2-6-b, and wrap them in qcom_edp_swing_pre_emph_cfg
> descriptors.  The eDP RBR/HBR swing table reuses the existing
> edp_swing_hbr_rbr directly; all other tables are new.
> 
> Assisted-by: LLM
> Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
