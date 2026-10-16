Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B000CCA464
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:10:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B889E1126DF;
	Fri, 16 Oct 2026 09:10:40 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B40F91126DF
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:10:28 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69G8lW7w2815472
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Qdw1IMSJPlaVw9V5/5RUUe24WWrftggVUgg+EtKpg0A=; b=mRoFUeIghvPRrNcW
 M1dseKIVbsc6Zw7kDzvhwk/T6GanfkjAQPcFxTlvBmyc3lXlUWl9DFyn/OwIVrdI
 t0xvlXFxbO0f0Wr8+YQsf2C3miZXKmQvUYPEpEuDX6nEGuLnJcEwmQ4l6bMzvHVO
 VoSY6UUOKqQK99xlofpB9GUFgnIGSMg3RyXWw1QSR6qnI8A8zcADcHmiLLc3wqyo
 QKy5o4RGcKWBwN4h72+sm1xxIiK7b+g77n0O5ZFkKzGHiFTjGg10LuCwDH/6VNlG
 K0nAoUIxzhalXSvBCbZUG/SFZddQGeYs11p/g0NE1ccSIfuDitTw30F3hoYJ+xPw
 mOzvEg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb8r11tuy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:10:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-530cd3dff25so12951841cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 02:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792141827; x=1792746627;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Qdw1IMSJPlaVw9V5/5RUUe24WWrftggVUgg+EtKpg0A=;
 b=jKLbKuHjON44sQ94v9tpVUveZ2lhD/zWYOeqT2de4iDYLbZ0xiEPO1EUK2aKGWAarP
 MPmd8BoPGFzZlUpW8DzjaFhkogorB4khEkG1hxj8WLFCSsP+sYSodWC72+msruajC/pc
 LhztjQCiSXeKxRMeQzBBccZoOGdMC4dpffoMueeYoroWofiWwvHmpcSgLClHWCZrzxOt
 tmMfcLlXsupOqgvB24corAu4KPfTKD4X6BXsrDdJs1/mxiSVmyOAbN0Y2dI6XuLiZ/om
 S0BRu6ehnIzG2NDWidOPko+CRA4AMYBCeMKR2imNr93CMp+SFmRY/3+vODFAOrIIN4ha
 oaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792141827; x=1792746627;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qdw1IMSJPlaVw9V5/5RUUe24WWrftggVUgg+EtKpg0A=;
 b=WKpq2HnmSWJlpatMpO4mrsoSg7qtHcy8X5MF/b9XBKs3u41wT0t0gTj0rmxMkX3XV3
 iy6CnqKJjiZFNohOPjF2rEK8eAKyQt70pB37oFqb3ouvSXSqXNNGNLu7WWcVO/NhzLbc
 kBJC+DFJsAbsE5uMT1DdfiONkrVR0sSEHoEYeLKZL/5knEsAk/LHgjhW2drb1hIF8WFa
 9PcyVk3JL0iqQlUjcS/3ErsZPOE4lBo2A+Of2Y8mlVZxiPK5zWA1gpuOr/5yE27lq8Hz
 jUHJPoTF+AvVzFQJjFLppcI7TawUngB5tb7ktub+Exh0T1W/TYqbBvBvlfXGIUvi/Ftp
 W7ug==
X-Forwarded-Encrypted: i=1;
 AKwUvBx91slL14d3RkEkBw/7sIjMTILaLGNlobTIzDNcXMMkrLxc2Pu/ia6OfH/DXCsw7EW95+fn81Jk6ZY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJV0NNIslsXQFrtmWS5y3lxBg7yiq1kS0PWjy9ZxWdi7XCM4dbt
 gxnk6TluwVmRxCvZaesRBzEe0Hom90zdk0Ed2lj8RbF91Wn+g9ESq9h7r8yiJRWIT6cPdTh8sK2
 T+dbLLpxNf8689UvoLT/7vKFAAvKeI8jE1SOToSkCnoNEnTIlEPw9W3xGZHHZN/LXWbxjRvc=
X-Gm-Gg: AYBFou2QAjXLz1REzdsjyN5ut+ip9/6dqyAuhvg35g+r6N0liWq0gNt+25G2c9gmYtb
 x8Wqc00iTkWpwFdCPO//zhISiKxT+lyFAOlw6kf+QFj4WA8b29JrwbJOk+82tp2ZcDdkW7Nw45N
 RsvbvUcuqF4u8dw9Hwsb4FHnpwie4SBDefKpdzkEk8Bf+6AKOheE3Gq4mme++iW6pERnTBXZgYL
 PUHl/pWW87KgBNa3SxNgoN00V9lemrhWY+tCAorMwVPF0CiQrJqEk0CgtnL94JyPKq8xsiu/Q/f
 fhvru/7DSrdB3lSOTBtbbKegrw6sk+7hU/j1xRK2XQSIGZz8AFf4Gj5heDNZvrK5w4VZ5xlcA23
 bTrKVmdTTkbM2QgU19WKSOA==
X-Received: by 2002:a05:620a:a43:b0:93f:211f:7ba4 with SMTP id
 af79cd13be357-93f211f7e97mr73040585a.5.1792141827227; 
 Fri, 16 Oct 2026 02:10:27 -0700 (PDT)
X-Received: by 2002:a05:620a:a43:b0:93f:211f:7ba4 with SMTP id
 af79cd13be357-93f211f7e97mr73032885a.5.1792141826093; 
 Fri, 16 Oct 2026 02:10:26 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c409239b3a1sm52586266b.85.2026.10.16.02.10.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 02:10:25 -0700 (PDT)
Message-ID: <3866c346-ddeb-4c9d-9f4d-3e09e3854bbb@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 11:10:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] arm64: dts: qcom: kaanapali-mtp: Enable USB
 headset and Type-C accessory mode
To: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261015-kaanapali_dp-v2-0-c15cb83d9140@oss.qualcomm.com>
 <20261015-kaanapali_dp-v2-4-c15cb83d9140@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261015-kaanapali_dp-v2-4-c15cb83d9140@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: QTeuvxVLS-oorMpgw6j373ZM4_BSviSv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNiBTYWx0ZWRfXzPYMeTeyt5ma
 oYUIDT3aejVc6RwVtO/EqxWnCAJkzcC7+uOWajLcZCMco5C4UfnxUxm1q6Ii4b5gOip8yxuMvsU
 hDyrD/5ujkALOwkd8rS7A2EFCTVczqo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNiBTYWx0ZWRfX9Pmxb2AaWOde
 FYXEKwk13xBHGy/quA5xk6HVRxzGJh7KyuWfX6KNnDMz+ZnrwOoFUeFgX80m7N0lvtOYdQtFWoV
 SNOJ0VLR3DC0LO9WrU/pN4NKLkzaqp3SyFYrZLjYmaohovEdxlEJwFqlFhreprao0x9hh/SoEV3
 O8d2KXcV+nYeF0CD0mf76fVyrZzpdRbJeidO7k/EXR6ftiEwQuf/kTKXAOJrWECmHoDtvz0P1Ld
 Bz2/QPy6JV5LxYzaKoj2SpV6M41C/wO4tPZEoefJ1nXJap31IZCo5jcTLFaajSJuiSVR8Ad2jop
 UhByTlkTegRE168HDtPpMKICzcFb9oaC2aDAwsxUlGVrvnfkcTTnxn90DL0NH1bsJ1XJl7IGq39
 hsKTPc0occppiWsyUXPXFfdkOF1L+sqqISDDyHfPq4MuKiWCzGAF93g/Ol5y37yqnbiqCU76ZrG
 b/tW7LtjZMx1AfB7FQg==
X-Proofpoint-GUID: QTeuvxVLS-oorMpgw6j373ZM4_BSviSv
X-Authority-Analysis: v=2.4 cv=L/CI0OT8 c=1 sm=1 tr=0 ts=6ad1ea04 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=ENyogFyUuOtWwiBkGF8A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160036
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

On 10/15/26 11:54 AM, Balaji Kalkonda wrote:
> MTP does not have audio jack connected and relies on USB mux (WCD9395).
> Add necessary nodes for proper audio headset support along with USB
> Type-C accessory mode and orientation.
> 
> Set the I2C bus clock frequency to 100 kHz for the WCD9395 USBSS mux.
> 
> Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
