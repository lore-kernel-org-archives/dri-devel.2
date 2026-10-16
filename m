Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03ADCCA464
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10F9E1126DE;
	Fri, 16 Oct 2026 09:11:20 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 799AD1126E8
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:11:08 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69G8lhRr921348
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QIOZtlc4H5WdZ+JHF5mX59cxfjXnkubowR3t/yD78FI=; b=mO1EusKON6JQKbrg
 dwNjWV0Z0zHVec1VDd0Qwkn03nRBvGXbbG++qvBxjK1rGs/ZDAxT4bpQE8/EOOqB
 hefaSQyfs/qOWf+hNJ+mbdWf95Lo/lDzP8dVA+eXcmiBcqrhu7e3qRB8JC/9Vf9H
 m7XQM9iaqZc89S6tCLzyZRN2xL/p/BObKeTBi9m9D/lQXflPkx3W6xOZG/R6IjPI
 dz0m37f+Cey+mUWrh318vbQ1eTtLGjYK+CP4gNSSfzI584O6VD/LJlhQZUt3atnU
 7KwxR2FO5ui+Edo0JmrmppKNbhX+y0VmMLlipeZnG0hxWP964/DCJx6Za59R0wME
 1tVEhA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3r3b22v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:11:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cc50fb0d2so122478085a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 02:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792141867; x=1792746667;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QIOZtlc4H5WdZ+JHF5mX59cxfjXnkubowR3t/yD78FI=;
 b=GEReKs0bO6A6gInJa9Je4cb9ajkPKSuNBbnJ6d+SRnHVon3yOxssf++4yHaOTV1Hr/
 RY3rsPRNu9vkd4UW7R09R3SBYQyfmvk67RKNJOQTExl3YBG1yHIHLecKG7maxUhL03iC
 zTkpTOKkp0hcYWwTqx+citw689rYX/hBo5TFecjItFYNXJAjTKLNUS5/pxatTlGKE3EU
 8VkjKEq77oiH1lwjLRtZhNGBLrfm3zIdO/M+tpqVAkquJkAR4H2+SYJd5AYGVd7ONhwS
 LihZSOqBvlaSQPvK3PLhbnFh7XuE2o6gW+RdtcCbLlefYXXG1sBlK9OINChmA0L/o238
 ObBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792141867; x=1792746667;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QIOZtlc4H5WdZ+JHF5mX59cxfjXnkubowR3t/yD78FI=;
 b=0kbYIao73Ae9NonApmuaoUfaWunRpt07QbzUYOjaUPn6zVQxAVX6YGb54d/BEz/v8j
 Bj1ImFBIKi8D/nmCdJwNALAaE9ukO8wGIwFxCVY4P+p8OEDklSwmQEfS8Nr2sfbNAZUe
 uvKki+2C5vpHi6S5iHFCBB1naZ9rx2y/6bTpoUaB9TWU+8MPoDAVHAn+RvLCjQ6bJ1lO
 Wbw61ZJVUZOe6nm/Afm5vzty314uRHkqcFy09DcrNTpf1Ie9FkfK/E2rrYdhFH+5Ma/Y
 DoqoGtvsTt66lxEYo7DzFo/20VyqQLYK9G5NAhoqiJw8ub6nZbPZC7hvCuUqeq57xx7B
 S6Iw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUBBw831Bon1B/3hVtH2ynq2YkUsAskLuYHpVZHjim4cxqsjOwiP9L9sE18j6q6GkP+Cw+6MJC49U=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKA07/lcRJwL6bfoJq0eMHCBRmklQco0n61KbyUnLgd9WgNkd+s
 /y75VGsgEu8vCCsy4X+8XK+Rq4lYZGfpA3cYwY9VM4YmDT/mXA5NJke3QZqWrGn6kMVTAceUo5H
 kfWLclBgR8CQL0R3gCNu+TtuYeNFgZ22jy3qGJqrFZlsea9PDxqDY5IpWVwAqmVaNmH2ptqk=
X-Gm-Gg: AYBFou2ocjwNo2eUu3t3n6WVnM9leSLrkV8VvL2EOyJTd5ShBHSgM2EvA88dpGj1Co3
 2cBBLASJvsmnXI13Sn0ilrd5L4EEW1phZuYYv3nK1/InY94cGNPTPUCREkTOFuTe819qF5gz3LK
 fWB4nByPTw9DZrJjgNhB89HSuP6iDIsz1JtJBAmNZAT+RIv/k9/OQKe+RJMvnVyrhqh29mQ8w+e
 t4GDzfGYohH/JrjgZfIdMhdcG3mPlNbFynmtPEwu+lDnCO7nNCkyDRAl+0vcFNQSehVWqeChoex
 cXg58GD9FLQT9iNWGaRUQQD1gZP5vIP8oF6MhzEw9Vhw8CYjjuIBK1l+aTtMGEOOgXSTk/3WySk
 WWV7GGCnoU5fADYMn0a1FbQ==
X-Received: by 2002:a05:620a:3186:b0:939:8bc:8826 with SMTP id
 af79cd13be357-93ebd10c0e2mr4105012485a.2.1792141867064; 
 Fri, 16 Oct 2026 02:11:07 -0700 (PDT)
X-Received: by 2002:a05:620a:3186:b0:939:8bc:8826 with SMTP id
 af79cd13be357-93ebd10c0e2mr4105008985a.2.1792141866485; 
 Fri, 16 Oct 2026 02:11:06 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4091eb1c55sm54193766b.74.2026.10.16.02.11.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 02:11:05 -0700 (PDT)
Message-ID: <e7768d31-a6bf-4ac3-af30-9de313b16ccd@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 11:11:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] arm64: dts: qcom: kaanapali: Add DisplayPort
 controller
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
 <20261015-kaanapali_dp-v2-3-c15cb83d9140@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261015-kaanapali_dp-v2-3-c15cb83d9140@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNiBTYWx0ZWRfX/Eb+1j1oYcxq
 m2HqeICC3Qkuv3Zfh08MY43swJrPHSYlcffMI4OV3TCFoCdmx65ivsN0N/E7m0bMEbSlabmhL0V
 FjYN8Eg7NoY153hFSCGMzBenTjlH9B3WO8n7rznPOEjrTdFh05Bd5x7P/gMVDCdj2jWKhskGtfF
 Kgz9g6yLxkI3K//GJ1rPZf1s58+lOmNTy9prem6Ez2GACq/X3ZIdKGlczYjzg1LXvayaqWsFn3T
 MK9Qtd+sUZKcBEpAccFeuv7W0nZMBEzG41tHGvJRT/G/d7X9AN+FDGv2D1lbxXzXg/BIzPd1rNS
 zRstXvsmJSv/ZzRI6xI4KKkZOtnqrjBYY56gSQ+j/us/8N+3OaLPfbp3WVA2uf+ql3Ex8tvDH+O
 XEjKBO+jCF9FigoYKcNnz8i04aj9g8DPTBbIBbmjAe3ckyHFFKxmsCCcdnx4K/D/XfQx3NCLaQe
 Qzu3zsyUc08+Tvjs8uA==
X-Proofpoint-GUID: VZudRJyIUL_QtLqjZLLQipthLSBVpHyK
X-Proofpoint-ORIG-GUID: VZudRJyIUL_QtLqjZLLQipthLSBVpHyK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNiBTYWx0ZWRfXzZKkQe2XG0Qj
 bRiYqucxh/uYM//Sed0PDMujF7acbZQeVxlyqdUOZz/Tp+OEsmpAaRI/HcXRXiWtMK8a3JtCe2C
 35BKYHmeNNbjG59F4FiPdgJdLhbgIiM=
X-Authority-Analysis: v=2.4 cv=INGXmQvG c=1 sm=1 tr=0 ts=6ad1ea2c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=dzNGixxSrynEd2cHrbYA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
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
> Add the DisplayPort controller node, including its OPP table,
> controller clocks and power domain.

[...]

> +			mdss_dp0: displayport-controller@9ad2000 {
> +				compatible = "qcom,kaanapali-dp";
> +				reg = <0x0 0x09ad2000 0x0 0x10c>,

sz=0x200

> +				      <0x0 0x09ad2200 0x0 0xc8>,

sz=0x200

> +				      <0x0 0x09ad3000 0x0 0x78>,

sz=0xc00

> +				      <0x0 0x09ad4000 0x0 0xa0>,

sz=0x400

> +				      <0x0 0x09ad5000 0x0 0xa0>;

sz=0x400> +
> +				interrupts-extended = <&mdss 12>;
> +
> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL1_CLK>;
> +
> +				clock-names = "core_iface",

Stray \n above

Konrad
