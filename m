Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DDFCA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FFFA10E5FE;
	Mon, 12 Oct 2026 14:01:57 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF8F710E5CF
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 14:01:45 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0JNI802223
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 14:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xRffrSm/hTCfqJYTTAkUvuKQGsX5x5h5c8d6nqDnnZA=; b=WBHn8v96BmySlV5J
 ZcckDIJSs30babgz5DeWI8UxO4Fbpnv9ogSFdB7qLcAIV3YB3+Ap7BlibnqkLD0g
 SjCknaWTgwahDtDy0tcBE6QI96oSdNq8/npREjQus2oK9wJfsFW7Yk5FQr/R1hyF
 YP2Axpl2uoRMABKagAvmxB7AE4sYl1/1u+L4hVOzwOp8Mh5YPXdrPhhOdvpqCP+f
 v7ck1UfANyawbtUZA77n3LjwRyP95n/qGTkJLsoyQtkLRy4IXCMDlMs10Kr4oR6E
 NnH25tD2zQ3Nkc3Tn/HYc+e/HWOYivMIHz8lU1JchAKhuhvVldh4fpVcNvqmNGqN
 E0wP4w==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wfcs0rk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 14:01:45 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5de7ad7cdbfso38787e0c.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791813704; x=1792418504;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xRffrSm/hTCfqJYTTAkUvuKQGsX5x5h5c8d6nqDnnZA=;
 b=UEq8mU2dj+Q6eVP4D9tlvPJMOugtkyx+Q6pm2+lc00PQWPR5ye/DxOhasjsyiQxHr0
 447tHPXKQ5ZX/daOgXfdTIxD/xmrAoaY2B1UNUeRQ+cJAiW+GDoaSLC8KrTa5EbmYGr9
 1N6FmhLsTtwXYwvDxZZ4tXNjiDjyaHCJCp5bLZvZGDf17wC0ltoPTk44a40EvtUsD17m
 OX3S4kS9eqpRNADSS6FfW/4QA4L223QAwVuXbuyslA31fsY7R8ZyrIIbzVdD1bUHN+GV
 JudzAvePjqsefbte5BYDCqxYXh2ztnbxqNwyi2JWvZjy1zPziXlDvW+P4XbpE+7t9iTc
 1qcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813704; x=1792418504;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xRffrSm/hTCfqJYTTAkUvuKQGsX5x5h5c8d6nqDnnZA=;
 b=LKm3aja9nbkD2Bq6yzC9B0qTpad+6meX07utRz0lLgX+BtJFOh5OHCrPcQkfNmZkZm
 D/sXWj221YgGRerFuYP0bzWbEh6hB1ARWX/fakhcNCpsM3EoAtvN3nvaMr3Qf6nknt7s
 QdzYWkytGvkZbwjlhwKx0RVdQYOqQfy2e93mDEwSrEBzY0voDrTOX5wtEjpVOV+H8/Cv
 TWbmthc4PRSbvEvnm3VhW1vsQOapUPyguABNvpsnhEoJBgtprLxZu0DtOmqv3bx7C8Vt
 5mASBM7m39rDaWEURKLmmJziJ0cEdRJycwDczuluse9zC5Udy2gAlxt/KqJceHdpZ/1A
 RMZw==
X-Forwarded-Encrypted: i=1;
 AKwUvByiKK7mY711HrczjjhkvC3P3ejFnKBVvMvEmqMDrX47zNmDBLJg0NLHzllw1jAzWnxsvQnl1WmKDDg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJGROaxGL/24vI/IVRwAwU78eB5wPmVmFGnWMpDa5WgMPPQaVix
 frRLcsVGTblfWtZ0PjB0O3A/8SfERPwrW8/1k5TmsGIWUGR+iARZyifv2azwoRuTwgzQ+N2GYu/
 4kB+7dB61oyCtJDwxUWSsvkk5l+yd68Urj9UQz+qLoeQB1a3FPKyOnfRheUGJrvDU3pv+aQE=
X-Gm-Gg: AYBFou1tsje0hkj08uAOHXkN21pwPK9gFBQ5bqi3HA3yC+JmmJCuFq8JfoAaHBNEUW6
 52CyIidBJ1Lr0c+rjKAlTpxa43ol6w7dizQq5VPN2UaBNzo03xzD6oJYMBWq2uxcIK8rDQe2x6V
 xZx8+xrJJWTs7TycIgxdw634r09Df0HlkbUnbURvNL8g1tKuygLKodf9EeTCvgxQHSReADXly7d
 fVlAFNPvKy86j7uZ8asYzokrE/waJ0q9CBJy8SD0dJFuxMibHEtDRS0GtwKdQm2c0hsIKMaEi6o
 NzaEtBYyDZ7vFqcLqT/t4PfHZuznsMN96FFw2jhL0tyVoaozOQWqb2LAy7OuyFGpeXq4b/Lku73
 50hSGAncqOSqsnMyTP0PtdA==
X-Received: by 2002:a05:6122:a5c2:10b0:5c9:fe51:53d5 with SMTP id
 71dfb90a1353d-5e91f242088mr1786260e0c.1.1791813703998; 
 Mon, 12 Oct 2026 07:01:43 -0700 (PDT)
X-Received: by 2002:a05:6122:a5c2:10b0:5c9:fe51:53d5 with SMTP id
 71dfb90a1353d-5e91f242088mr1786149e0c.1.1791813703157; 
 Mon, 12 Oct 2026 07:01:43 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c338d5b170fsm237486266b.75.2026.10.12.07.01.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 07:01:42 -0700 (PDT)
Message-ID: <04672b02-cdf6-4719-a17c-4f7ce95a98b2@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 16:01:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] drm/msm/dp: Add support for DP controllers on
 Nord
To: Nabige Aala <nabige.aala@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
 <20261012-nord-drv-dt-v2-6-a2ab9af954d2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261012-nord-drv-dt-v2-6-a2ab9af954d2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0NYJp9CihbtLoMojAvUW4GiTIPpTQjKu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NSBTYWx0ZWRfX7FDCg7rvt50R
 TE9irodz1seigvSRu72nZo1uAG353VMHkjwpIqXHeAWCJI4c3biha/DyOWdjyjORXmnBovHzwwM
 nBhnNzFQawg2BwpKIIjjHg1aEcxyrTs=
X-Proofpoint-ORIG-GUID: 0NYJp9CihbtLoMojAvUW4GiTIPpTQjKu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NSBTYWx0ZWRfX0wk8acBHLK3O
 fWAvvO8vNeLvFwdiHwEE75b2njDVNz64F92MBrqSnrn5J3ukm8w5ItHpx7OVGDBPZd4So1JtVJL
 kMZFDAgRnhjE5Zosz9TlD9hAgFFHXstJ9LOTSczU4vCvQ7rklmpFbvl/JivfVuyoSlFULweYC1r
 dyKBpYFgfzWPvdai/W51IIPKIv7/9Wpd3PyOzSPBK5Pc4opsZOy0Em+FCQ2AemdQbxbGnrkmS+3
 8+0XXrMKrXzTDs7L4ZD8rC/W9PFT0Jpu8zK+1hL3BfimS4Lfz62KXqa2LbBDZGBX4BfsytKp5wr
 MWXRP66q+ZNWzWJGlIHY5j3CI4AvRVwB41Q4yj3mxEECnf7ySpsRxUkmrmqHokjJdaPRfLmkS1h
 OLYhtZhymrTLk9dZkloXuMy3gmd/WUn4cd9aC156Ve4lgV/MQksOFYngfPUrEC9v7x30hGigAFg
 VSKtL06wbBamCbjcNPA==
X-Authority-Analysis: v=2.4 cv=PbhqFShd c=1 sm=1 tr=0 ts=6acce849 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=rMXm0_BZOgqvqhzNPSsA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120055
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

On 10/12/26 3:32 PM, Nabige Aala wrote:
> From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> 
> Add the Nord DP desc and compatible. Nord is supporting the
> four DP cotnrollers, two per MDSS instance.
> 
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
